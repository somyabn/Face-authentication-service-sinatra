# encoding: UTF-8
require 'sinatra/base'
require_relative  'face_api'
require 'pry'

module Sinatra
  module FaceTrain
    def profile_face_train(username, profile_image_url)
      faceapi = FaceApi.new
      face_detected = faceapi.faces_detect(profile_image_url)
      face_tag_saved = faceapi.faces_tag_save("#{username}@my_image",face_detected["photos"][0]["tags"][0]["tid"])
      faces_trained = faceapi.faces_train("#{username}@my_image")
      if faces_trained["status"] == "success"
        return true
      end
  end

  def profile_face_remove_train(username, profile_image_url)
      faceapi = FaceApi.new
      face_detected = faceapi.faces_detect(profile_image_url)
      face_tag_saved = faceapi.face_tag_remove(face_detected["photos"][0]["tags"][0]["tid"])
      faces_trained = faceapi.faces_train("#{username}@my_image")
      if faces_trained["status"] == "success"
        return true
      end
    
  end
 end
  helpers FaceTrain
end