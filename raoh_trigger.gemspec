# frozen_string_literal: true

require_relative 'lib/raoh_trigger/version'

Gem::Specification.new do |spec|
  spec.name = 'raoh_trigger'
  spec.version = Raoh::Trigger.gem_version
  spec.authors = ['Maxime Désécot']
  spec.email = ['maxime.desecot@gmail.com']

  spec.summary = 'Raoh Trigger'
  spec.description = 'Provide before_action and after_action class method'
  spec.homepage = 'https://github.com/RaoH37/raoh_trigger'
  spec.license = 'GPL-3'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  # spec.bindir = 'exe'
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
