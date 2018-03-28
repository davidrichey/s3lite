module S3lite::Base
  attr_accessor :last_backup_at
  include S3lite::S3

  def backup(raise_error: false)
    s3_put(path: s3_path, body: to_json)
  rescue => e
    raise e if raise_error
    false
  end

  def backup!
    backup(raise_error: true)
  end

  def latest
    obj = s3_get(s3_path)
    body = obj.body.read
    json = S3lite::Parse.json(body)
    json[:last_backup_at] = obj.last_modified
    self.class.new(json)
  rescue Aws::S3::Errors::AccessDenied, Aws::S3::Errors::NotFound
    nil
  end

  def backedup?
    to_json == latest.to_json
  end

  def s3_path
    if defined?(Rails)
      "#{Rails.env}/#{self.class.to_s.parameterize}/#{id}"
    else
      "#{self.class}/#{id}"
    end
  end
end
