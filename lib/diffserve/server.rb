require 'sinatra/base'
require 'diffserve/repository'
require 'diffserve/command'

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
      repo = DiffServe::Repository.locate
      out = "<h2>Untracked</h2><pre>#{h repo.untracked.result}</pre>"
      out << "<h2>Diff</h2><pre>#{h repo.diff.result}</pre>"
      out
    end

  end
end
