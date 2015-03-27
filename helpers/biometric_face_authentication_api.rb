require 'json'
require 'net/http'
class BiometricFaceAuthentication

	def request_post(method,username)
	    uri= URI("http://localhost:4567//api/profile/#{method}/minkbot/123/#{username}")
	    response = Net::HTTP.post(uri)
	    JSON.parse(response)
	end

	def request_put(useroldname,usernewname)
	    uri= URI("http://localhost:4567//api/profile/edit/minkbot/123/#{useroldname}/#{usernewname}")
	    response = Net::HTTP.put(uri)
	    JSON.parse(response)
	end

	def request_delete(username)
	    uri= URI("http://localhost:4567//api/profile/delete/minkbot/123/#{username}")
	    response = Net::HTTP.delete(uri)
	    JSON.parse(response)
	end

    def register(username)
	  request_post("registration","#{username}")
	end

	def authorise(username)
		request_post("authorise","#{username}")
    end

    def edit(useroldname,usernewname)
		request_put (useroldname,usernewname)
    end

    def delete(username)
    	request_delete( username )
    end

end
