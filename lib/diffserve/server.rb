require 'sinatra/base'

module DiffServe
  class Server < Sinatra::Base

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static, true

    helpers do
      alias_method :h, :escape_html
    end

    get "/" do
      @repo = DiffServe::Git::Repository.locate
      if @repo
        @unified = Diff::Display::Unified.new(@repo.diff)
        erb :overview
      else
        erb :error
      end
    end

  end
end
