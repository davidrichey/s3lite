require 'webmock/rspec'
require 'bundler/setup'
require 's3lite'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    S3lite.aws_key = 'K3Y'
    S3lite.aws_secret_key = 'S3CR3T'
    S3lite.s3_bucket = 'BUCK3T'
  end
end
