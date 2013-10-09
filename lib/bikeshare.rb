class BikeShare

  FIRST_STATION_ID = 2

  def initialize
    response = JSON.parse(open("http://bayareabikeshare.com/stations/json").read)
    @response = response["stationBeanList"]
  end

  def get_last_station
    @response.last["id"]
  end

  def station_info(station_id)
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id } 
    station.first
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
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id }

    station.first["availableBikes"] == 0 ? true : false
  end

  def full?(station_id)
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id }

    station.first["availableBikes"] == station.first["totalDocks"] ? true : false
  end

  def available_bikes(station_id)
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id }

    station.first["availableBikes"]
  end

  def total_docks(station_id)
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id }
    station.first["totalDocks"]
  end

  def percent_available(station_id)
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id }

    available = (station.first["availableBikes"]).to_f
    total = (station.first["totalDocks"]).to_f

    percentage = (available * 100.0) / total
    percentage.round(2)
  end

  def offline_stations
    list = @response.select { |station| station["statusKey"] == 0 }

    list.empty? ? [] : list
  end

private
  
  def check_valid_station_id!(station_id, opts = {})
  # Checks if a station ID is included in the range of stations retrieved from bayareabikeshare.com
  # Options:
  # => first: The min id to be checked. Defaults to value of the first station id
  # => last: The max id to be checked. Defaults to last id of the response
  # => message: The message of the exception that will be raised if the station id is not included in the range.

    opts = opts.merge(:first => FIRST_STATION_ID, :last => get_last_station)
    opts = opts.merge(:message => "Please enter a station id in between #{opts[:first]} and #{opts[:last]}")

    raise opts[:message] unless station_id.between?(opts[:first], opts[:last])
  end

end
