require "aws-sdk"
require "open-uri"
require "sinatra"

set :bind, "0.0.0.0"
set :port, 80

s3 = Aws::S3::Client.new(
  access_key_id: ENV["S3_ACCESS_KEY_ID"],
  secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
  endpoint: ENV["S3_ENDPOINT"],
  region: "none"
)

post "/" do
  media_url = params["MediaUrl0"]
  object_key = Time.now.to_i.to_s
  object_body = open(media_url)

  s3.put_object({
    body: object_body,
    bucket: ENV["S3_BUCKET_NAME"],
    key: object_key,
  })

  return 200
end
