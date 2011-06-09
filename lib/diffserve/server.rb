require 'sinatra/base'
require 'diff-display'
require 'diffserve/repository'
require 'diffserve/command'
require 'diffserve/renderer'

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
      unified = Diff::Display::Unified.new(repo.diff.result)
      out = <<-EOS
        <style>
          *         { font-family: monospace; }
          td        { white-space: nowrap; }
          td.header { font-weight: bold; font-size: 150%; padding: 1.5em 0 1em; }
          td.insert { background-color: #CFC; }
          td.delete { background-color: #FCC; }
          td.ln     { padding: 0 0.3em; font-family: monospace; color: #999; }
        </style>
      EOS
      out << "<h1>" + repo.path + "</h1>"
      out << "<table>" + unified.render(DiffServe::Renderer.new) + "</table>"
      out
    end

  end
end
