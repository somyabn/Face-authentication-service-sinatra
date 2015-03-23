# encoding: UTF-8
require 'sinatra/base'
require 'av_capture'
require 'aws/s3'

module Sinatra
  module PhotoCapture

	def get_headshot(filename)
		# Create a recording session
		session = AVCapture::Session.new

		# Find the first video capable device
		dev = AVCapture.devices.find(&:video?)

		# Connect the camera to the recording session
		session.run_with(dev) do |connection|
		  f = File.new("images/#{filename}.jpg","w")
		   f.write "#{connection.capture}"
		   f.close
		  # # Capture an image and write it to local file "photo.jpg"
		  #  f.write "#{connection.capture}"
	     end
	  end 
  end
helpers PhotoCapture
end