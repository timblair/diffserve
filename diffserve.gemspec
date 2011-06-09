# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "diffserve/version"

Gem::Specification.new do |s|
  s.name        = "diffserve"
  s.version     = DiffServe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tim Blair"]
  s.email       = ["tim@bla.ir"]
  s.homepage    = "http://github.com/timblair/diffserve"
  s.summary     = %q{Serves up your changes}
  s.description = %q{Runs a simple webserver that serves up your uncommitted changes.}

  s.rubyforge_project = "diffserve"

  s.add_dependency "sinatra", ">= 1.2.6"
  s.add_dependency "vegas", ">= 0.1.8"
  s.add_dependency "diff-display"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
