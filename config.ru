require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'logger'
require './people_and_pets'

use Rack::Deflater

logger = Logger.new('sinatra.log')
logger.level = Logger::DEBUG

use Rack::Session::Pool, :expire_after => 2592000
enable :sessions
set :session_store, Rack::Session::Pool
use Rack::Protection::RemoteToken
use Rack::Protection::SessionHijacking

run PeopleAndPets