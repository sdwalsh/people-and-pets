require 'sinatra'
require 'puma'
require 'haml'
require 'csv'
require 'json'

class PeopleAndPets < Sinatra::Base
  get '/' do
    status 200
    haml :home, :format => :html5
  end

  post '/upload' do
    if params[:csv] && params[:csv][:tempfile]
      file = params[:csv][:tempfile]
      delimiter = sniffer(file)
      if !delimiter
        halt 400
      end
      # array of hashes eventually can be converted to json
      response = normalize(file, delimiter)
      if !response
        halt 400
      end
      [200, response.to_json]
    else
      status 400
    end
  end

  # Normalize the file values into a standard format (defined in docs)
  # important note: ordering of hash literals is guaranteed
  # https://stackoverflow.com/questions/31418673/is-order-of-a-ruby-hash-literal-guaranteed
  # :last :first :m :pet :birthday :color
  # returns an array of hashes
  def normalize(file, delimiter)
    response = []
    case delimiter
      when ','
        CSV.foreach(file, col_sep: delimiter) do |row|
          hash = {:last => row[0], :first => row[1], :m => "None", :pet => row[2], :birthday => row[4], :color => row[3]}
          response.push(hash)
        end
      when ' '
        CSV.foreach(file, col_sep: delimiter) do |row|
          case row[3]
            when 'C' then row[3] = 'Cat'
            when 'D' then row[3] = 'Dog'
            when 'B' then row[3] = 'Both'
            else row[3] = 'None'
          end
          row[4].gsub! '-', '/'
          hash = {:last => row[0], :first => row[1], :m => row[2], :pet => row[3], :birthday => row[4], :color => row[5]}
          response.push(hash)
        end
      when '|'
        CSV.foreach(file, col_sep: delimiter) do |row|
          row[5].gsub! '-', '/'
          hash = {:last => row[0], :first => row[1], :m => row[2], :pet => row[3], :birthday => row[5], :color => row[4]}
          response.push(hash)
        end
      else
        return nil
    end
    response
  end

  # Sniffer returns the delimiter in use
  # for more robust searching consider using a sniffer library or creating a sniffer class
  # this sniffer function meets all requirements of project guidelines
  def sniffer(file)
    line = File.foreach(file).first
    line.each_char do |c|
      if c == '|' || c == ' ' || c == ','
        return c
      end
    end
    nil
  end
end