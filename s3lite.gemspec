
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws-sdk-s3'

require 's3lite'

Gem::Specification.new do |spec|
  spec.name          = 's3lite'
  spec.version       = S3lite::VERSION
  spec.authors       = ['David Richey']
  spec.email         = ['daveyrichey@gmail.com']

  spec.summary       = 'S3 Framework to backup SQLite database to S3'
  spec.description   = 'S3 Framework to backup SQLite database to S3'
  spec.homepage      = 'https://github.com/davidrichey/s3lite'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'aws-sdk-s3', '~> 1'
end
