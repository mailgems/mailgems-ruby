
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mailgems/version"

Gem::Specification.new do |spec|
  spec.name          = "mailgems"
  spec.version       = Mailgems::VERSION
  spec.authors       = ["Mailgems"]
  spec.email         = ["admin@mailgems.com"]

  spec.summary       = %q{This library allows you to quickly and easily use the Mailgems API v1 via Ruby}
  spec.description   = %q{This library allows you to quickly and easily use the Mailgems API v1 via Ruby. It is also an Action Mailer adapter for using Mailgems in Rails apps. It uses the Mailgems HTTP API internally.}
  spec.homepage      = "https://www.mailgems.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/mailgems/mailgems-ruby"
    spec.metadata["changelog_uri"] = "https://github.com/mailgems/mailgems-ruby"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", ">= 0.17.0", "<= 0.18.1"
  spec.add_dependency "launchy", '~> 2.2'
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mail", "~> 2.6", ">= 2.6.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'webmock', '~> 3.5.1'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rubocop', '~> 0.87.1'
  spec.add_development_dependency 'coveralls', '~> 0.8.23'
end
