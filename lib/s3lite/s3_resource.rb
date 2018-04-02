module S3lite::S3Resource
  class << self
    def s3_resource_object(path)
      raise 'No AWS S3 Bucket Set' if S3lite.s3_bucket.nil?
      s3_resource.bucket(S3lite.s3_bucket).object(path)
    end

    def s3_resource
      raise 'No AWS Access Key Set' if S3lite.aws_key.nil?
      raise 'No AWS Secret Access Key Set' if S3lite.aws_secret_key.nil?
      Aws::S3::Resource.new(
        region: S3lite.region || 'us-east-1',
        access_key_id: S3lite.aws_key,
        secret_access_key: S3lite.aws_secret_key
      )
    end
  end
end
