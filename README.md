# README

## Installation

1. `bundle install`
2. `rails db:create`
3. `rails db:migrate`
4. `bundle exec figaro install` (see Known Issues below)

## Known Issues

 - figaro gem uses deprecated alias `exists?` which needs to be changed to `exist?` in `~/.rbenv/versions/3.2.2/lib/ruby/gems/3.2.0/gems/figaro-1.2.0/lib/figaro/application.rb`

 - for image processing locally: `sudo apt-get install libvips`
