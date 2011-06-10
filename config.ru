# rackup config for development purposes only
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'diffserve'
run DiffServe::Server
