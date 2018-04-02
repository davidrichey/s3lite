module S3lite::S3
  include S3lite::S3Resource

  def s3_get(path)
    S3lite::S3Resource.s3_resource_object(path).get
  end

  def s3_put(path:, body:)
    S3lite::S3Resource.s3_resource_object(path).put(body: body)
  end

  def self.s3_list(prefix)
    S3lite::S3Resource.s3_resource.bucket(S3lite.s3_bucket)
                      .objects(prefix: "#{S3lite.env}/#{prefix}")
  end
end
