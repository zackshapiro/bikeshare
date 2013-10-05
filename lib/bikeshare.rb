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
    last_station = get_last_station
    if station_id >= 2 && station_id <= last_station
      station = @response.select { |station| station["id"] == station_id }

      station.first["availableBikes"] == 0 ? true : false
    else
      raise "Please enter a station id in between 2 and #{last_station}"
    end
  end

  def available_bikes(station_id)
    last_station = get_last_station
    if station_id >= 2 && station_id <= last_station
      
      station = @response.select { |station| station["id"] == station_id }
      station.first["availableBikes"]
    else
      raise "Please enter a station id in between 2 and #{last_station}"
    end
  end

  def total_bikes(station_id)
    last_station = get_last_station
    if station_id >= 2 && station_id <= last_station
      
      station = @response.select { |station| station["id"] == station_id }
      station.first["totalDocks"]
    else
      raise "Please enter a station id in between 2 and #{last_station}"
    end
  end

  def percent_available(station_id)
    last_station = get_last_station
    if station_id >= 2 && station_id <= last_station
      station = @response.select { |station| station["id"] == station_id }

      available = (station.first["availableBikes"]).to_f
      total = (station.first["totalDocks"]).to_f

      percentage = (available * 100.0) / total
      percentage.round(2)
    else 
      raise "Please enter a station id in between 2 and #{last_station}"
    end
  end

  def offline_stations
    list = @response.select { |station| station["statusKey"] == 0 }

    list.empty? ? "There are no stations offline" : list
  end

end