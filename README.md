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
