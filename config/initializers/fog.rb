CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_KEY'],
    region:                'us-west-1'
  }
  config.fog_directory  = ENV['AWS_DIR']
end
