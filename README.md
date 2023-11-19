# README

## TL;DR

```sh
make
make setup
make ci

# slow down browser tests
SLOMO_MS=100 make test
```

## Work Log

### Consistent Machine ID

to identify different servers producing blocks on the chain

[StackOverflow: generate consistent machine unique ID](
    https://unix.stackexchange.com/questions/144812/generate-consistent-machine-unique-id)

following only works on linux

```sh
sudo dmidecode -t 4 | grep ID | sed 's/.*ID://;s/ //g'
    52060201FBFBEBBF

ifconfig | grep eth1 | awk '{print $NF}' | sed 's/://g'
    0126c9da2c38
```

but this node module https://github.com/automation-stack/node-machine-id

suggests various approaches including the following on Mac OS

```sh
ioreg -rd1 -c IOPlatformExpertDevice | ag IOPlatformUUID | strings
      "IOPlatformUUID" = "41FFFAAA-1111-2222-3333-444455556697"
```

The general idea is to enumerate a Mac address or similar hardware ID. There is
also talk of using [PCI hardware addresses](
    https://apple.stackexchange.com/questions/234410/does-macos-have-equivalent-command-line-tools-like-lshw-or-lspci-for-enumera)
using `lshw` and `lspci`. The recommendations for Mac OS being: `sysctl
machdep`, `system_profiler`, `ioreg -l | grep PCI`

### Faker terms

add the gem
```sh
bundle add faker
```

get a random animal name
```ruby
Faker::Creature::Animal.name
```

access to the YAML data files and all the terms
```ruby
spec = Bundler.load.specs.find{|s| s.name == 'faker' }
I18n.load_path += Dir[File.join(spec.full_gem_path, "lib/locales/**/*.yml")]
I18n.translate('faker.creature.animal.name', locale: :en).first(10)
=> ["alligator", "crocodile", "alpaca", "ant", "antelope", "ape", "armadillo",
    "donkey", "baboon", "badger"]
```

## Old README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
