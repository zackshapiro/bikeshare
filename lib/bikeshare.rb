require 'json'
require 'open-uri'
require 'debugger'
require 'hashie'

class BikeStatus

  def self.start
    # To do: Make this an init function
    response = JSON.parse(open("http://bayareabikeshare.com/stations/json").read)
    response["stationBeanList"]
  end

  def self.stations(*station_name)
    station_name = station_name.first
    
    list = BikeStatus.start

    if station_name.nil?
      stations = list
    else
      stations = list.select { |station| station["landMark"] == "#{station_name}" }
    end
  end

  def self.empty_stations
    list = BikeStatus.start

    list.select { |station| station["availableBikes"] == 0 }
  end

  def self.empty?(station_id)
    if station_id >= 2 && <= 77
      list = BikeStatus.start
      list = list.select { |station| station["id"] == station_id }

      list[0]["availableBikes"] == 0 ? true : false
    else
      raise "Please enter a station id in between 2 and 77"
    end
  end

end