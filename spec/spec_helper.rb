require 'rubygems'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'rspec/autorun'
require 'json'
require 'open-uri'
require 'fakeweb'

FakeWeb.allow_net_connect = false

require 'requests/bayareabikeshare.com_requests'

RSpec.configure do |config|

end