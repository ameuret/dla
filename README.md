# DLA

A Ruby library implementing Diffusion-Limited Aggregation.

## Features
 - Produces simple text file fully describing final render
 - Keeps full tree, not just cell positions
 - Keeps building history

## Planned features
 - [X] Demo app
 - [ ] Move "Save .dla" to library
 - [ ] Display saved .dla file
 - [ ] Upscale
 - [ ] Binary .dla format
 - [ ] Load state from .dla file
 - [ ] Height map
 - [ ] Export bitmap
 - [ ] Make history optional
 - [ ] Multithreading
 - [ ] Make Demo app human-friendly
 - [ ] Make direction vectors configurable
 
## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add dla

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install dla

## Usage

Default arguments are fine (1280x720 bounds)

Let it run for a while:
``` ruby
require 'dla'
root = DLA::Node.root
n = DLA::Node.new root:
loop do
  n.move
  if n.parent # Node has found another node
    n = DLA::Node.new root:
  end
  break if bored
end

```
Inspect state:
``` ruby
root.nodes.each{|n| puts n}
```

The history string is made of the letters n, s, e, w to describe the directions followed during the calls to `#move`.
NOTE: The Y axis is oriented to the North.

## Demo app

A quick and dirty demo app is in `./bin/dla.rb`.

Because Rubygems are not supposed to be used to distribute apps, you'll need to run the app from the project directory after running `bundle install` in order to satisfy the requirement of my fork of `TTY:Box`.

## Development

After checking out the repo, run `bundle exec bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bundle exec bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ameuret/dla. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ameuret/dla/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [Unlicense](https://unlicense.org)

## Code of Conduct

Everyone interacting in the DLA project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ameuret/dla/blob/main/CODE_OF_CONDUCT.md).
