# encoding: UTF-8
require 'pry'

get '/' do
  erb :consumerSignUp
end

post '/' do
  consumer = Consumer.create(:name => params[:consumername], :key => params[:consumerkey])
  redirect to('/consumers')
end

get '/consumers' do
  erb :profileShow
end

get '/api/profiles/:consumername/:key' do
  consumer = Consumer.where(:name => params[:consumername]).take
  if consumer && consumer.key == params[:key]
     format_response(consumer.profiles.all, request.accept)
  end
end

post '/api/profile/authorise/:consumername/:key/:username' do
  consumer = Consumer.where(:name => params[:consumername]).take
  if consumer && consumer.key == params[:key]
    profile = consumer.profiles.where(:username => params[:username]).take
    get_headshot("photo")
    temp_img_url= store_img("photo")
    profile.confirmed = profile_face_authorise("#{consumer.name}_#{profile.username}",temp_img_url)
    profile.save
    format_response(profile, request.accept)
  end
end


post '/api/profile/registration/:consumername/:key/:username' do
  consumer = Consumer.where(:name => params[:consumername]).take
  if consumer && consumer.key == params[:key]
      profile = consumer.profiles.new(:username => params[:username])
      get_headshot("#{consumer.name}_#{profile.username}")
      profile.image_url=store_img("#{consumer.name}_#{profile.username}")
      profile.trained = profile_face_train("#{consumer.name}_#{profile.username}",profile.image_url)
      profile.save
      format_response(profile, request.accept)
  end
end

put '/api/profile/edit/:consumername/:key/:oldusername/:newusername' do
  consumer = Consumer.where(:name => params[:consumername]).take
  if consumer && consumer.key == params[:key]
      profile = consumer.profiles.where(:username => params[:oldusername]).take
      profile.update(:username => params[:newusername])
      oldusername = params[:oldusername]
      profile.image_url= update_img("#{consumer.name}_#{oldusername}","#{consumer.name}_#{profile.username}")
      profile.trained = profile_face_train("#{consumer.name}_#{profile.username}",profile.image_url)
      profile.save
      format_response(profile, request.accept)
  end
end

delete '/api/profile/delete/:consumername/:key/:username' do
 consumer = Consumer.where(:name => params[:consumername]).take
  if consumer && consumer.key == params[:key]
    profile = consumer.profiles.where(:username => params[:username]).take
    profile_face_remove_train("#{consumer.name}_#{profile.username}", profile.image_url)
    delete_img("#{consumer.name}_#{profile.username}.jpg")
    profile.destroy
  end
end 