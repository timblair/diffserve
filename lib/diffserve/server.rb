require 'sinatra/base'
require 'diffserve/repository'
require 'diffserve/command'

module DiffServe
  class Server < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true

    get "/" do
      content_type 'text/plain'
      DiffServe::Repository.locate.diff.result
    end

  end
end
