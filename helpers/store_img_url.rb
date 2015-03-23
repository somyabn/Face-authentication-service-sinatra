# encoding: UTF-8
require 'sinatra/base'
#!/usr/bin/env ruby
require 'rubygems'
require 'aws/s3'
require 'pry'

module Sinatra
  module ImgUrl
    def store_img(filename)
		AWS::S3::Base.establish_connection!(
		  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
		  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
		)

		file = "images/#{filename}.jpg"
		bucket = "myfacelogin"
	    status=AWS::S3::S3Object.store(File.basename(file), open(file), bucket, :access => :public_read)
	    FileUtils.rm_rf(Dir.glob('images/*'))
	 return image_url = AWS::S3::S3Object.url_for(File.basename(file), bucket)[/[^?]+/]

    end

    def delete_img(filename)

    	AWS::S3::Base.establish_connection!(
		  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
		  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
		)

		bucket = "myfacelogin"
	    status=AWS::S3::S3Object.delete(filename, bucket)
	 end

	 def update_img(oldUserName , newUserName)

	 	AWS::S3::Base.establish_connection!(
		  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
		  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
		)

		bucket = "myfacelogin"
        AWS::S3::S3Object.rename("#{oldUserName}.jpg", "#{newUserName}.jpg", bucket,:access => :public_read)
        file = "#{newUserName}.jpg"
        return image_url = AWS::S3::S3Object.url_for(File.basename(file), bucket)[/[^?]+/]
    end
 end
 helpers ImgUrl
end
