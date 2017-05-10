# Ruby::Phpipam

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/phpipam`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Pending API endpoints

### Controller Addresses
```
GET /api/my_app/addresses/{id}/ Returns specific address
GET /api/my_app/addresses/{id}/ping/  Checks address status
GET /api/my_app/addresses/{ip}/{subnetId}/  Returns address from subnet by ip address 1.3
GET /api/my_app/addresses/search/{ip}/  searches for addresses in database, returns multiple if found
GET /api/my_app/addresses/search_hostname/{hostname}/ searches for addresses in database by hostname, returns multiple if found 1.3
GET /api/my_app/addresses/first_free/{subnetId}/  Returns first available address (subnetId can be provided with parameters) 1.3
GET /api/my_app/addresses/custom_fields/  Returns custom fields
GET /api/my_app/addresses/tags/ Returns all tags
GET /api/my_app/addresses/tags/{id}/  Returns specific tag
GET /api/my_app/addresses/tags/{id}/addresses/  Returns addresses for specific tag

POST /api/my_app/addresses/  Creates new address
POST /api/my_app/addresses/first_free/{subnetId}/  Creates new address in subnets – first available (subnetId can be provided with parameters) 1.3

PATCH /api/my_app/addresses/{id}/ Updates address

DELETE /api/my_app/addresses/{id}/ Deletes address
DELETE /api/my_app/addresses/{ip}/{subnetId}/  Deletes address by IP in specific subnet
```

### Controller Subnets
```
GET /api/my_app/subnets/{id}/first_free/  Returns first available IP address in subnet 1.3
GET /api/my_app/subnets/{id}/slaves/  Returns all immediate slave subnets
GET /api/my_app/subnets/{id}/slaves_recursive/  Returns all slave subnets recursive
GET /api/my_app/subnets/{id}/addresses/{ip}/  Returns IP address from subnet
GET /api/my_app/subnets/{id}/first_subnet/{mask}/ Returns first available subnet within selected for mask 1.3
GET /api/my_app/subnets/{id}/all_subnets/{mask}/  Returns all available subnets within selected for mask 1.3
GET /api/my_app/subnets/custom_fields/  Returns all subnet custom fields
GET /api/my_app/subnets/cidr/{subnet}/  Searches for subnet in CIDR format
GET /api/my_app/subnets/search/{subnet}/  Searches for subnet in CIDR format

POST /api/my_app/subnets/  Creates new subnet
POST /api/my_app/subnets/{id}/first_subnet/{mask}/ Creates new child subnet inside subnet with specified mask 1.3

PATCH /api/my_app/subnets/  Updates Subnet
PATCH /api/my_app/subnets/{id}/resize/  Resizes subnet to new mask
PATCH /api/my_app/subnets/{id}/split/ Splits subnet to smaller subnets
PATCH /api/my_app/subnets/{id}/permissions/ Sets subnet permissions (?grouname1=ro&groupname2=3&43=1) 1.3

DELETE /api/my_app/subnets/{id}/ Deletes Subnet
DELETE /api/my_app/subnets/{id}/truncate/  Removes all addresses from subnet
DELETE /api/my_app/subnets/{id}/permissions/ Removes all permissions 1.3
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-phpipam'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-phpipam

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby-phpipam.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

