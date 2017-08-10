require 'sinatra'
require 'haml'

class PeopleAndPets < Sinatra::Base
  get '/' do
    status 200
    haml :home, :format => :html5
  end
end