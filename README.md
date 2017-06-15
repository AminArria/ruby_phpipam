# Ruby::Phpipam

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/phpipam`. To experiment with that code, run `bin/console` for an interactive prompt.

**Important Note**: Currently only GET actions are going to be implemented, but feel free to make a PR for the others.

## Pending API endpoints
This are endpoints that aren't standarized into a method and a parsed response. You can still call them through ```Phpipam::Query.get(...)``` and get the raw response.

### Sections Endpoints
```
GET /api/my_app/sections/custom_fields/   Returns custom section fields
```

### Subnets Endpoints
```
GET /api/my_app/subnets/{id}/slaves/                  Returns all immediate slave subnets
GET /api/my_app/subnets/{id}/slaves_recursive/        Returns all slave subnets recursive
GET /api/my_app/subnets/{id}/addresses/{ip}/          Returns IP address from subnet
GET /api/my_app/subnets/{id}/first_subnet/{mask}/     Returns first available subnet within selected for mask 1.3
GET /api/my_app/subnets/{id}/all_subnets/{mask}/      Returns all available subnets within selected for mask 1.3
GET /api/my_app/subnets/custom_fields/                Returns all subnet custom fields
```

### Addresses Endpoints
```
GET /api/my_app/addresses/{id}/ping/                    Checks address status
GET /api/my_app/addresses/{ip}/{subnetId}/              Returns address from subnet by ip address 1.3
GET /api/my_app/addresses/search/{ip}/                  Searches for addresses in database, returns multiple if found
GET /api/my_app/addresses/search_hostname/{hostname}/   Searches for addresses in database by hostname, returns multiple if found 1.3
GET /api/my_app/addresses/first_free/{subnetId}/        Returns first available address (subnetId can be provided with parameters) 1.3
GET /api/my_app/addresses/custom_fields/                Returns custom fields
GET /api/my_app/addresses/tags/                         Returns all tags
GET /api/my_app/addresses/tags/{id}/                    Returns specific tag
GET /api/my_app/addresses/tags/{id}/addresses/          Returns addresses for specific tag
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-phpipam', git: 'git://github.com/AminArria/ruby-phpipam'

```

And then execute:

    $ bundle install


## Usage

### Configuration
```ruby
Phpipam.configure do |config|
  config.base_url = "http://my.phpipam.server/api/my_app"
  config.username = "username"
  config.password = "password"
end
```

### Authenticating
```ruby
Phpipam.authenticate
```

### API Calls
In here you'll see the following:
```
method_name()     What it does      What it returns
```

#### Section
```
self.get(id_or_name)   Get section by ID or name           Section object
self.get_all()         Get all sections                    Array of section objects
subnets()              Get all subnets from the section    Array of subnet objects
```

#### Subnet
```
self.get(id)        Get subnet by ID                    Subnet object
self.search(cidr)   Search for subnet by CIDR           Subnet object
usage()             Get usage statistics for subnets    Subnet object with usage statistics
addresses()         Get all addresses from the subnet   Array of address objects
first_free_ip()     Get first usable IP                 String
```

#### Address
```
self.get(id)      Get address by ID     Address object
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AminArria/ruby-phpipam.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

