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
          .code   { font-family: monospace; }
          .header { font-weight: bold; }
          .insert { background-color: #CFC; }
          .delete { background-color: #FCC; }
        </style>
      EOS
      out << "<h2>Untracked</h2><pre>#{h repo.untracked.result}</pre>"
      out << "<h2>Diff</h2><table>" + unified.render(DiffServe::Renderer.new) + "</table>"
      out
    end

  end
end
