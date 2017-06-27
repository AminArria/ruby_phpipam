# ruby_phpipam
[![Gem Version](https://badge.fury.io/rb/ruby_phpipam.svg)](https://badge.fury.io/rb/ruby_phpipam)
[![Build Status](https://travis-ci.org/AminArria/ruby-phpipam.svg?branch=master)](https://travis-ci.org/AminArria/ruby-phpipam)

**Important Note**: GET actions have highest priority for development, but feel free to make a PR for the others.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_phpipam'

```

Or execute:

    $ gem install ruby_phpipam


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
instance_method()       What it does      What it returns
self.class_method()     What it does      What it returns
```

#### Section
```
self.get(id_or_name)   Get section by ID or name           Section object
self.get_all()         Get all sections                    Array of section objects
subnets()              Get all subnets from the section    Array of subnet objects
```

#### Subnet
```
self.get(id)          Get subnet by ID                    Subnet object
self.search(cidr)     Search for subnet by CIDR           Subnet object
usage()               Get usage statistics for subnets    Subnet object with usage statistics
addresses()           Get all addresses from the subnet   Array of address objects
first_free_ip()       Get first usable IP                 String
slaves()              Get inmediate slave subnets         Array of subnet objects
slaves_recursive()    Get all slave subnets               Array of subnet objects (Includes self)
first_subnet(mask)    Get first available subnet (CIDR)   String
                        for given mask
all_subnets(mask)     Get all posible subnets (CIDR)      Array of strings
                        for given mask
```

#### Address
```
self.get(id)      Get address by ID           Address object
self.ping(id)     Check status of address     Boolean telling if address is reachable
online?           Check status of address     Boolean telling if address is reachable
```

## Pending API endpoints
This are endpoints that aren't standarized into a method and a parsed response. You can still call them through ```Phpipam::Query.get(...)``` and get the raw response.

### Sections Endpoints
```
GET     /api/my_app/sections/custom_fields/   Returns custom section fields
POST    /api/my_app/sections/                 Creates new section
PATCH   /api/my_app/sections/                 Updates section
DELETE  /api/my_app/sections/                 Deletes section with all belonging subnets and addresses
```

### Subnets Endpoints
```
GET     /api/my_app/subnets/{id}/addresses/{ip}/          Returns IP address from subnet
GET     /api/my_app/subnets/custom_fields/                Returns all subnet custom fields
POST    /api/my_app/subnets/                              Creates new subnet
POST    /api/my_app/subnets/{id}/first_subnet/{mask}/     Creates new child subnet inside subnet with specified mask
PATCH   /api/my_app/subnets/                              Updates Subnet
PATCH   /api/my_app/subnets/{id}/resize/                  Resizes subnet to new mask
PATCH   /api/my_app/subnets/{id}/split/                   Splits subnet to smaller subnets
PATCH   /api/my_app/subnets/{id}/permissions/             Sets subnet permissions (?grouname1=ro&groupname2=3&43=1)
DELETE  /api/my_app/subnets/{id}/                         Deletes Subnet
DELETE  /api/my_app/subnets/{id}/truncate/                Removes all addresses from subnet
DELETE  /api/my_app/subnets/{id}/permissions/             Removes all permissions
```

### Addresses Endpoints
```
GET     /api/my_app/addresses/{ip}/{subnetId}/              Returns address from subnet by ip address
GET     /api/my_app/addresses/search/{ip}/                  Searches for addresses in database, returns multiple if found
GET     /api/my_app/addresses/search_hostname/{hostname}/   Searches for addresses in database by hostname, returns multiple if found
GET     /api/my_app/addresses/first_free/{subnetId}/        Returns first available address (subnetId can be provided with parameters)
GET     /api/my_app/addresses/custom_fields/                Returns custom fields
GET     /api/my_app/addresses/tags/                         Returns all tags
GET     /api/my_app/addresses/tags/{id}/                    Returns specific tag
GET     /api/my_app/addresses/tags/{id}/addresses/          Returns addresses for specific tag
POST    /api/my_app/addresses/                              Creates new address
POST    /api/my_app/addresses/first_free/{subnetId}/        Creates new address in subnets – first available (subnetId can be provided with parameters)
PATCH   /api/my_app/addresses/{id}/                         Updates address
DELETE  /api/my_app/addresses/{id}/                         Deletes address (use 'remove_dns=1' parameter to remove all related DNS records)
DELETE  /api/my_app/addresses/{ip}/{subnetId}/              Deletes address by IP in specific subnet
```

### VLAN Endpoints
```
GET     /api/my_app/vlan/                                 Returns all Vlans
GET     /api/my_app/vlan/{id}/                            Returns specific Vlan
GET     /api/my_app/vlan/{id}/subnets/                    Returns all subnets attached tovlan
GET     /api/my_app/vlan/{id}/subnets/{sectionId}/        Returns all subnets attached to vlan in specific section
GET     /api/my_app/vlan/{id}/custom_fields/              Returns custom VLAN fields
GET     /api/my_app/vlan/{id}/search/{number}/            Searches for VLAN
POST    /api/my_app/vlan/                                 Creates new VLAN
PATCH   /api/my_app/vlan/                                 Updates VLAN
DELETE  /api/my_app/vlan/                                 Deletes VLAN
```

### VLAN Domains (L2 domains) Endpoints
```
GET     /api/my_app/l2domains/                    Returns all L2 domains
GET     /api/my_app/l2domains/{id}/               Returns specific L2 domain
GET     /api/my_app/l2domains/{id}/vlans/         Returns all VLANs within L2 domain
GET     /api/my_app/l2domains/custom_fields/      Returns all custom fields
POST    /api/my_app/l2domains/                    Creates new L2 domain
PATCH   /api/my_app/l2domains/                    Updates L2 domain
DELETE  /api/my_app/l2domains/                    Deletes L2 domain
```

### VRF Endpoints
```
GET     /api/my_app/vrf/                    Returns all VRFs
GET     /api/my_app/vrf/{id}/               Returns specific VRF
GET     /api/my_app/vrf/{id}/subnets/       Returns all subnets within VRF
GET     /api/my_app/vrf/custom_fields/      Returns all custom fields
POST    /api/my_app/vrf/                    Creates new VRF
PATCH   /api/my_app/vrf/                    Updates VRF
DELETE  /api/my_app/vrf/                    Deletes VRF
```

### Devices Endpoints
```
GET     /api/my_app/devices/                            Returns all devices
GET     /api/my_app/devices/{id}/                       Returns specific device
GET     /api/my_app/devices/{id}/subnets/               Returns all subnets within device
GET     /api/my_app/devices/{id}/addresses/             Returns all addresses within device
GET     /api/my_app/devices/search/{search_string}/     Searches for devices with {search_string} in any belonging field
POST    /api/my_app/devices/                            Creates new device
PATCH   /api/my_app/devices/                            Updates device
DELETE  /api/my_app/devices/                            Deletes device
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AminArria/ruby-phpipam.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

