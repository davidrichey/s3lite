require 's3lite/version'
require 's3lite/parse'
require 's3lite/s3_resource'
require 's3lite/s3'
require 's3lite/base'

module S3lite
  class << self
    attr_accessor :s3_bucket, :region, :aws_key, :aws_secret_key, :env
  end
end
