# <a name="title"></a> Safety Razor - A Ruby client for the Razor API

[![Gem Version](https://badge.fury.io/rb/safety_razor.png)](http://badge.fury.io/rb/safety_razor)
[![Build Status](https://travis-ci.org/blueboxgroup/safety_razor.png?branch=master)](https://travis-ci.org/blueboxgroup/safety_razor)
[![Code Climate](https://codeclimate.com/github/blueboxgroup/safety_razor.png)](https://codeclimate.com/github/blueboxgroup/safety_razor)
[![Dependency Status](https://gemnasium.com/blueboxgroup/safety_razor.png)](https://gemnasium.com/blueboxgroup/safety_razor)

There are 2 overriding design decisions at play in this library:

1. Implement a solution using the
   [Faraday gem](https://github.com/lostisland/faraday) to support
   middleware injection such as additional authentication, retry logic, etc.
2. Provide a thin wrapper around Razor's REST API that doesn't hide data
   internals. At the time of authoring this library Razor has not yet hit a
   SemVer-stable release and could therefore change internals at any time.

## <a name="installation"></a> Installation

Add this line to your application's Gemfile:

    gem 'safety_razor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install safety_razor

## <a name="usage"></a> Usage

### <a name="usage-active-model"></a> Active Model

* Razor
  [active_model](https://github.com/puppetlabs/Razor/wiki/active_model)
  documentation

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# GET /active_model/{UUID}
client.active_model.get("uuid1-xxxx")

# GET /active_model
client.active_model.all

# DELETE /active_model/{UUID}
client.active_model.destroy("uuid1-xxxx")
```

### <a name="usage-broker"></a> Broker

* Razor
  [broker](https://github.com/puppetlabs/Razor/wiki/broker)
  documentation

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# POST /broker?json_hash=(JSON_STR)
client.broker.create({
  name: "Chefy",
  plugin: "chef",
  description: "Production Chef Server",
  req_metadata_hash: {
    chef_server_url: "https://chef.example.com",
    chef_version: "11.4.0",
    validation_key: "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAK..."
  }
})

# GET /broker/{UUID}
client.broker.get("uuid1-xxxx")

# GET /broker
client.broker.all

# GET /broker/plugins
client.broker.plugins

# PUT /broker/{UUID}?json_hash=(JSON_STR)
client.broker.update({
  uuid: "uuid1-xxxx",
  name: "Production Chef Server"
})

# DELETE /broker/{UUID}
client.broker.destroy("uuid1-xxxx")

broker = client.broker.get("uuid1-xxxx")
client.broker.destroy(broker)
```

### <a name="usage-model"></a> Model

* Razor
  [model](https://github.com/puppetlabs/Razor/wiki/model)
  documentation

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# POST /model?json_hash=(JSON_STR)
client.model.create({
  label: "Test Model",
  image_uuid: "OTP",
  template: "ubuntu_oneirc",
  req_metadata_hash: {
    hostname_prefix: "test",
    domainname: "testdomain.com",
    root_password: "test4321"
  }
})

# GET /model/{UUID}
client.model.get("uuid1-xxxx")

# GET /model
client.model.all

# GET /model/templates
client.model.templates

# PUT /model/{UUID}?json_hash=(JSON_STR)
client.model.update({
  uuid: "uuid1-xxxx",
  label: "New Test Model Label"
})

# DELETE /model/{UUID}
client.model.destroy("uuid1-xxxx")
```

### <a name="usage-node"></a> Node

* Razor
  [node](https://github.com/puppetlabs/Razor/wiki/node)
  documentation

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# POST /node/register?[registration_param_list]
client.node.register({
  hw_id: "000C29291C95",
  last_state: "idle",
  attributes_hash: {
    attr1: "val1"
  }
})

# POST /node/checkin?[checkin_param_list]
client.node.checkin({
  hw_id: "000C29291C95",
  last_state: "idle"
})

# GET /node/{UUID}
client.node.get("uuid1-xxxx")

# GET /node/{UUID}?field=attributes
client.node.get_attributes("uuid1-xxxx")

# GET /node/{UUID}?field=hardware_ids
client.node.get_hardware_ids("uuid1-xxxx")

# GET /node
client.node.all
```

### <a name="usage-policy"></a> Policy

* Razor
  [policy](https://github.com/puppetlabs/Razor/wiki/policy)
  documentation

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# POST /policy?json_hash=(JSON_STR)
client.policy.create({
  label: "Test Policy",
  model_uuid: "uuid2-yyyy",
  template: "linux_deploy",
  tags: "two_disks,memsize_1GiB,nics_2"
})

# GET /policy/{UUID}
client.policy.get("uuid1-xxxx")

# GET /policy
client.policy.all

# GET /policy/templates
client.policy.templates

# PUT /policy/{UUID}?json_hash=(JSON_STR)
client.policy.update({
  uuid: "uuid1-xxxx",
  tags: "one,two,three"
})

# DELETE /policy/{UUID}
client.policy.destroy("uuid1-xxxx")

policy = client.policy.get("uuid1-xxxx")
client.policy.destroy(policy)
```

### <a name="usage-tag"></a> Tag

* Razor
  [tag](https://github.com/puppetlabs/Razor/wiki/tag)
  documentation

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# POST /tag?json_hash=(JSON_STR)
client.tag.create({
  name: "Test Tag",
  tag: "test_tag"
})

# GET /tag/{UUID}
client.tag.get("uuid1-xxxx")

# GET /tag
client.tag.all

# PUT /tag/{UUID}?json_hash=(JSON_STR)
client.tag.update({
  uuid: "uuid1-xxxx",
  tag: "prod_tag"
})

# DELETE /tag/{UUID}
client.tag.destroy("uuid1-xxxx")

tag = client.tag.get("uuid1-xxxx")
client.tag.destroy(tag)
```

### <a name="usage-tag-matcher"></a> Tag Matcher

* Razor
  [tag](https://github.com/puppetlabs/Razor/wiki/tag)
  documentation (contains tag matcher details)

```ruby
require 'safety_razor'

client = SafetyRazor::Client.new(uri: 'http://10.0.10.1')

# POST /tag/{T_UUID}/matcher?json_hash=(JSON_STR)
client.tag_matcher.create("uuid1-xxxx", {
  key: "mk_hw_nic_count",
  compare: "equal",
  value: "2"
})

# GET /tag/{T_UUID}/matcher/{UUID}
# get(tag_uuid, tag_matcher_uuid)
client.tag_matcher.get("uuid1-xxxx", "uuid2-yyyy")

# PUT /tag/{T_UUID}/matcher/{UUID}?json_hash=(JSON_STR)
client.tag_matcher.update("uuid1-xxxx", {
  uuid: "uuid2-yyyy",
  key: "mk_special_sauce"
})

# DELETE /tag/{T_UUID}/matcher/{UUID}
client.tag_matcher.destroy("uuid1-xxxx", "uuid2-yyyy")
```

## <a name="testing"></a> Testing

To run the unit tests and quality suite:

    ./script/bootstrap
    rake

The acceptance suite requires a Razor service, therefore this projects ships
with a Vagrant VM providing a Razor instance. To run the acceptance suite:

    ./script/bootstrap
    vagrant up
    rake acceptance
    vagrant destroy

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## <a name="authors"></a> Authors

Created by [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>), and maintained
by [Blue Box Group][bluebox].

## <a name="license"></a> License

MIT (see [LICENSE][license])

[bluebox]:      http://bluebox.net
[fnichol]:      https://github.com/fnichol
[license]:      https://github.com/blueboxgroup/safety_razor/blob/master/LICENSE
[repo]:         https://github.com/blueboxgroup/safety_razor
[issues]:       https://github.com/blueboxgroup/safety_razor/issues
[contributors]: https://github.com/blueboxgroup/safety_razor/contributors
