require 'sinatra/base'

module DiffServe
  class Server < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true

    helpers do
      alias_method :h, :escape_html
    end

    get "/" do
      @repo = DiffServe::Repository.locate
      @unified = Diff::Display::Unified.new(@repo.diff.result)
      erb :overview
    end

  end
end
