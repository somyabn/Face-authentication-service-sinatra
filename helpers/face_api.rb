require 'json'
require 'net/http'
class FaceApi

	def request(method,parameters=nil)
	    uri= URI("http://api.skybiometry.com/fc/#{method}.json?api_key=2204ce403c414c88a8eab4e7ffd51d93&api_secret=b44484d4c22a43a7b29cc5758da32840#{parameters}")
	    response = Net::HTTP.get(uri)
	    JSON.parse(response)
	end

    def faces_detect(image_path)
	  request("faces/detect","&urls=#{image_path}")
	end

	def faces_tag_save(uid,tid)
		request("tags/save","&uid=#{uid}&tids=#{tid}")
    end

    def faces_train(uids)
		request("faces/train","&uids=#{uids}")
    end

    def face_recognize(uid,image_path)
    	request("faces/recognize","&urls=#{image_path}&uids=#{uid}")
    end

    def face_tag_remove(tid)
    	request("tags/remove","&tids=#{tid}")
    end

end
