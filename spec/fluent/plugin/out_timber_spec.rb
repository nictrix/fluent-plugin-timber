require "spec_helper"
require "fluent/plugin/out_timber"

describe Fluent::TimberOutput do
  let(:config) do
    %{
      api_key  abcd1234
      source_id 81293
      hostname my.host.com
    }
  end

  let(:driver) do
    tag = "test"
    Fluent::Test::BufferedOutputTestDriver.new(Fluent::TimberOutput, tag) {
      # v0.12's test driver assume format definition. This simulates ObjectBufferedOutput format
      if !defined?(Fluent::Plugin::Output)
        def format(tag, time, record)
          [time, record].to_msgpack
        end
      end
    }.configure(config)
  end
  let(:record) do
    {'age' => 26, 'request_id' => '42', 'parent_id' => 'parent', 'routing_id' => 'routing'}
  end

  before(:each) do
    Fluent::Test.setup
  end

  describe "#write" do
    it "should send a chunked request to the Timber API" do
      stub = stub_request(:post, "https://logs.timber.io/sources/81293/frames").
        with(
          :body => start_with(
              "\x85\xA3age\x1A\xAArequest_id\xA242\xA9parent_id\xA6parent\xAArouting_id\xA7routing\xA2dt\xB4".force_encoding("ASCII-8BIT")
            ),
          :headers => {'Authorization'=>'Bearer abcd1234', 'Connection'=>'Keep-Alive', 'Content-Type'=>'application/msgpack', 'User-Agent'=>'Timber Logstash/1.0.1'}
        ).
        to_return(:status => 200, :body => "", :headers => {})

      driver.emit(record)
      driver.run

      expect(stub).to have_been_requested.times(1)
    end

    it "handles 500s" do
      stub = stub_request(:post, "https://logs.timber.io/sources/81293/frames").to_return(:status => 500, :body => "", :headers => {})

      driver.emit(record)
      driver.run

      expect(stub).to have_been_requested.times(3)
    end

    it "handle auth failures" do
      stub = stub_request(:post, "https://logs.timber.io/sources/81293/frames").to_return(:status => 403, :body => "", :headers => {})

      driver.emit(record)
      driver.run

      expect(stub).to have_been_requested.times(1)
    end
  end
end
