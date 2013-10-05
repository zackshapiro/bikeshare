require 'json'
require 'open-uri'
require 'debugger'
require 'hashie'

class BikeShare

  def initialize
    response = JSON.parse(open("http://bayareabikeshare.com/stations/json").read)
    @response = response["stationBeanList"]
  end

  def get_last_station
    @response.last["id"]
  end

  def stations(*city_name)
    city_name = city_name.first

    if city_name.nil?
      stations = @response
    else
      stations = @response.select { |station| station["landMark"] == "#{city_name}" }
    end
  end

  def empty_stations
    @response.select { |station| station["availableBikes"] == 0 }
  end

  def empty?(station_id)
    if station_id >= 2 && station_id <= get_last_station
      station = @response.select { |station| station["id"] == station_id }

      station.first["availableBikes"] == 0 ? true : false
    else
      raise "Please enter a station id in between 2 and #{get_last_station}"
    end
  end

  def available_bikes(station_id)
    if station_id >= 2 && station_id <= get_last_station
      
      station = @response.select { |station| station["id"] == station_id }
      station.first["availableBikes"] 
    else
      raise "Please enter a station id in between 2 and #{get_last_station}"
    end
  end

  # def self.get_total(station_id)
  # end

  # def self.get_percent_available(station_id)
  # end

  def offline_stations
    list = @response.select { |station| station["statusKey"] == 0 }

    list.empty? ? "There are no stations offline" : list
  end

end