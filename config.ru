require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'logger'
require 'sass/plugin/rack'
require './people_and_pets'

# Use add_template_location rather than directly manipulating the :template_location option
# per sass-lang documentation guidelines more information at url below
# http://sass-lang.com/documentation/Sass/Plugin/Configuration.html#add_template_location-instance_method
Sass::Plugin.add_template_location('assets/scss', 'public/css')

use Sass::Plugin::Rack

logger = Logger.new('sinatra.log')
logger.level = Logger::DEBUG

use Rack::CommonLogger, logger

run PeopleAndPets