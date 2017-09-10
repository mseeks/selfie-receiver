require "aws-sdk"
require "open-uri"
require "sinatra"

set :port, 80

s3 = Aws::S3::Client.new(
  access_key_id: ENV["S3_ACCESS_KEY_ID"],
  secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
  endpoint: ENV["S3_ENDPOINT"],
  region: "none"
)

post "/" do
  media_url = params["MediaUrl0"]
  object_key = Time.now.to_i
  object_body = open(media_url)

  obj = s3.bucket("#{ENV["S3_BUCKET_NAME"]}").object(object_key)
  obj.put(body: object_body)

  return 200
end
