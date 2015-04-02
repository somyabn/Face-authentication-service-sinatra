require 'sinatra/base'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
configure(:development){set :database, "sqlite3:blog.sqlite3"}
require 'bundler/setup'
require 'rack-flash'
require 'json'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions => true	
require_relative './models/init'
require_relative './helpers/init'
require_relative './routes/init'

