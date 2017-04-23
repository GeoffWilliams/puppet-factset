[![Build Status](https://travis-ci.org/declarativesystems/puppet_factset.svg?branch=master)](https://travis-ci.org/declarativesystems/puppet_factset)
# PuppetFactset

This gem provides the output of [Facter](https://docs.puppet.com/facter/3.6/) on several representative test systems which makes a complete set of OS specific facts (AKA factsets) available to programs such as [Onceover](https://github.com/dylanratcliffe/onceover) and [PDQTest](https://github.com/declarativesystems/pdqtest).  The aim here is to provide a shared, reusable and small library providing easy access to facter output on as many platforms as possible.

## Adding new platforms
To create support for additional platforms all we need to do is log onto a real machine that has puppet installed and run:

```shell
puppet facts > OSNAME-OSVERSION-ARCH.json
```

Where:

* OSNAME is the Operating System name, eg `Debian`
* OSVERSION is the Operating System version number, eg `7.8`
* ARCH indicates the CPU architecture, eg `32`, `64`, `powerpc`

`puppet facts` will give raw json output of every fact which puppet knows about.

Once we have our factset all we need to do is copy it into `res/factset/` inside this git repository and commit it to version control.  To share your new platform support with the world, please create a [Pull Request](https://help.github.com/articles/about-pull-requests/).

Factsets are named based on their filename, not the name of the server they came from/


## Installation
`puppet_factset` is intended to be used as a library and provides no executable.  To use in your own application, add this line to your application's Gemfile:

```ruby
gem 'puppet_factset'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puppet_factset

## Usage
* `puppet_factset` provides a minimal API to obtain fact information, see below
* Dependencies are deliberately kept small/absent

### Factset Directory
To obtain the real filesystem directory containing the factset files (`res/factset`):

```ruby
require 'puppet_factset'
factset_dir =  PuppetFactset::factset_dir
```

### Hash of facts
To obtain a representitive hash of facts for a given system:

```ruby
require 'puppet_factset'
fact_hash = PuppetFactset::factset_hash(system_name)
```

* `system_name` needs to correspond to a file in the factset dir, eg use 'Debian-7.8-64' to access the `'Debian-7.8-64.json'` file.
* If required system is absent a `RuntimeError` will be raised

### Available Factsets
To obtain the list of available factsets suitable for use with `factset_hash`:

```ruby
require 'puppet_factset'
factsets = PuppetFactset::factsets
```

* The `factsets` array will be sorted A-Z

## Merging additional facts/handling external facts
Sometimes you need to ensure that a fact is present without worrying to much about its real-world value, for example external facts or custom in-module facts that do things such as query for the system for package versions, etc.

`puppet_factset` will automatically merge the hiera data found in all `.json` files found inside the `spec/merge_facts` directory, relative to the current working directory into factset data for each OS when accessed via the above API (the factset files themselves are unchanged).

#### Worked example

```json
spec/merge_facts/extra_fact.json
{
  "extra_fact": "hello"
}
```


```ruby
require 'puppet_factset'
fact_hash = PuppetFactset::factset_hash(system_name)
puts fact_hash["extra_fact"]  # from your json file
puts fact_hash["osfamily"]    # from the facts shipped inside this gem
```

Note that its possible to silently override shipped factsets using this method as well.  I regard this as a feature.

## Development

* RSpec tests are provided, please ensure these pass before and after adding any ruby code to the project
* If adding new functionality, please write an acommpanying testcase
* To run tests: `bundle install && bundle exec rake spec`

## Authors
* [Dylan Ratcliffe](https://github.com/dylanratcliffe)
* [Geoff Williams](https://github.com/geoffwilliams)
* [Jesse Reynolds](https://github.com/jessereynolds)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/declarativesystems/puppet_factset.
