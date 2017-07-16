# Fluent::Plugin::Timber, a plugin for [Fluentd](http://fluentd.org)

[![Gem Version](https://badge.fury.io/rb/fluent-plugin-timber.png)](http://badge.fury.io/rb/fluent-plugin-timber)
[![Build Status](https://travis-ci.org/timberio/fluent-plugin-timber.png?branch=master)](https://travis-ci.org/timberio/fluent-plugin-timber)
[![Issue Stats](http://issuestats.com/github/uken/fluent-plugin-timber/badge/pr)](http://issuestats.com/github/uken/fluent-plugin-timber)
[![Issue Stats](http://issuestats.com/github/uken/fluent-plugin-timber/badge/issue)](http://issuestats.com/github/uken/fluent-plugin-timber)

A highly efficient Fluentd plugin that delivers events to the [Timber.io logging service](https://timber.io). It uses batching, msgpack, and retry logic for highly efficient and reliable delivery of log data.

[Timber.io](https://timber.io) is a different kind of logging service with a focus on modern logging best-practices: easy setup, structured data, fast clean usable interface, 6 months of searchable retention, threshold based alerts, simple graphing, and more. Learn more at [https://timber.io](https://timber.io).

## Installation

```
gem install fluent-plugin-timber
```

## Usage

In your Fluentd configuration, use @type timber:

```
<match your_match>
  @type timber
  api_key xxxxxxxxxxxxxxxxxxxxxxxxxxx        # Your Timber API (required)
  hostname "#{Socket.gethostname}"           # Your hostname (required)
  # ip 127.0.0.1                             # IP address (optional)
  buffer_chunk_limit 1m                      # Must be < 5m
  flush_at_shutdown true                     # Only needed with file buffer
</match>
```

## Configuration

* `api_key` - This is your Timber API key. You can obtain your key by creating an app in the [Timber console](https://app.timber.io). Registration is one click. If you already have an app, you can locate your API in your app's settings. [See our API key docs](https://timber.io/docs/app/advanced/api-keys/).
* `hostname` - This adds `hostname` as context to your logs, making it easy to filter by hostname in the [Timber console](https://app.timber.io).
* `ip` - This adds `ip` as context to your logs, making it easy to filter by IP address in the [Timber console](https://app.timber.io).

For advanced configuration options, please see to the [buffered output parameters documentation.](http://docs.fluentd.org/articles/output-plugin-overview#buffered-output-parameters).

---

Questions? Need help? [support@timber.io](mailto:support@timber.io).