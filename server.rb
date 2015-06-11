require 'sinatra/base'
require 'rubygems'
require 'haml'
require_relative 'cache'

class Server < Sinatra::Base

  get '/upload' do
    erb :form
  end

  post '/upload' do
    p params['file'][:filename]
    store = Cache.store("Tester", "Hello")

    #File.open('uploads/' + params['file'][:filename], "w") do |f|
    #  f.write(params['file'][:tempfile].read)
    #end
    return Cache.read("Tester")

  end

end

Server.run!
