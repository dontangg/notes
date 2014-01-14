# Setup Amazon Web Services credentials
# http://docs.aws.amazon.com/AmazonS3/latest/dev/UploadObjSingleOpRuby.html

# require 'rubygems'
# require 'aws-sdk'
# 
# AWS.config(
#   :access_key_id => '*** Provide your access key ***', 
#   :secret_access_key => '*** Provide your secret key ***'
# )
# 
# bucket_name = '*** Provide bucket name ***'
# file_name = '*** Provide file name ****'
# 
# # Get an instance of the S3 interface.
# s3 = AWS::S3.new
# 
# # Upload a file.
# key = File.basename(file_name)
# s3.buckets[bucket_name].objects[key].write(:file => file_name)
# puts "Uploading file #{file_name} to bucket #{bucket_name}."

AWS.config(YAML.load_file("#{Rails.root}/config/aws.yml")[Rails.env])
