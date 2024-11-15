# frozen_string_literal: true

require_relative "lib/dla/version"

Gem::Specification.new do |spec|
  spec.name = 'dla'
  spec.version = DLA::VERSION
  spec.authors = ['Arnaud Meuret']
  spec.email = ['arnaud@meuret.net']

  spec.summary = 'A tool to create diffusion-limited aggregates.'
  spec.description = 'A tool to compute and export trees built using a DLA (Diffusion-limited Aggregation) algorithm.'
  spec.homepage = 'https://github.com/ameuret/dla'
  spec.license = 'Unlicense'
  spec.required_ruby_version = '>= 3.3.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  #spec.metadata['changelog_uri'] = 'TODO: Put your gem\'s CHANGELOG.md URL here.'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "tty-box", "~> 0.7"
  spec.add_dependency "tty-cursor", "~> 0.7"
  spec.add_dependency "tty-reader", "~> 0.9"
  spec.add_dependency "tty-screen", "~> 0.8"
  spec.add_dependency "ruby-duration", "~> 3.2"

  spec.add_development_dependency 'filewatcher-cli', '~> 1.1'
  spec.add_development_dependency 'gem-release', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'solargraph', '~> 0.5'
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
