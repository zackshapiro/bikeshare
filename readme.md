### A Ruby gem for interacting with Bay Area Bike Share station and bike info

## Available methods:

#### stations
Takes a city name like `"San Francisco"` and returns an array of all the stations in that municipality

#### empty_stations
Returns an array of all stations with 0 `availableBikes`

#### `empty?(station_id)`
Takes a `station_id` as an integer and retuns true or false based on the number of `availableBikes`

* Created by Zack Shapiro and Patrick Traughber
* For more information, please go to the [Bay Area Bike Share website](http://bayareabikeshare.com)
* [JSON from](http://bayareabikeshare.com/stations/json)
