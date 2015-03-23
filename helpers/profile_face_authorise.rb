# encoding: UTF-8
require 'sinatra/base'
require_relative  'face_api'
require 'pry'

module Sinatra
  module FaceAuthorise
    def profile_face_authorise(username, temp_image_url)
      faceapi = FaceApi.new
	      faces_recognized = faceapi.face_recognize("#{username}@my_image",temp_image_url)
	      	if faces_recognized != nil && faces_recognized["status"] == "success" && faces_recognized["photos"] != [] && faces_recognized["photos"][0]["tags"] != [] && faces_recognized["photos"][0]["tags"][0]["uids"] != [] && faces_recognized["photos"][0]["tags"][0]["uids"][0]["confidence"].to_int > 70
	        	return true
	        else
	        	return false
	        end
    
    end
  end
  helpers FaceAuthorise
end