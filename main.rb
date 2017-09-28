require "open-uri"
require "sinatra"

set :bind, "0.0.0.0"
set :port, 80

post "/" do
  media_url = params["MediaUrl0"]
  object_key = Time.now.to_i.to_s

  open("/data/#{object_key}", "wb") do |file|
    open(media_url) do |media|
     file.write(media.read)
    end
  end

  return 200
end
