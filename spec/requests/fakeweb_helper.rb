require 'json'
require 'open-uri'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def request_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/' + filename)
  File.read(file_path)
end

FakeWeb.register_uri(:get, "http://bayareabikeshare.com/stations/json", :body => request_file("bayareabikeshare.com.json"))
FakeWeb.register_uri(:get, "http://bayareabikeshare.com/stations/json_with_offline_stations", :body => request_file("bayareabikeshare.com_with_offline_stations.json"))