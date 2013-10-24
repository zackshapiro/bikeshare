class BikeShare

  FIRST_STATION_ID = 2
  BAY_AREA_BIKE_JSON_URL = "http://bayareabikeshare.com/stations/json"

  def initialize(url = nil)
    response_url = url || BAY_AREA_BIKE_JSON_URL

    response = JSON.parse(open(response_url).read)
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

  def lat_and_long(station_id)
    check_valid_station_id!(station_id)

    station = @response.select { |station| station["id"] == station_id }

    lat = station.first["latitude"]
    long = station.first["longitude"]

    [lat, long]
  end

private
  
  def check_valid_station_id!(station_id)
    first = FIRST_STATION_ID
    last = get_last_station

    raise "Please enter a station id in between #{first} and #{last}" unless station_id.between?(first, last)
  end

end
