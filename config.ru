require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'logger'
require './people_and_pets'

use Rack::Deflater

logger = Logger.new('sinatra.log')
logger.level = Logger::DEBUG

use Rack::CommonLogger, logger

run PeopleAndPets