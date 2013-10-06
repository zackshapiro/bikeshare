# BikeShare
A Ruby gem for interacting with Bay Area Bike Share stations and bike info
* Created by [Zack Shapiro](http://twitter.com/zackshapiro). 
* Ongoing Bike safety, lanes, and infrastructure efforts by [Patrick Traughber](http://twitter.com/ptraughber) and friends.


## To-Do:
* Submit to RubyGems


## Installation

This is available as a RubyGem:
```ruby
gem install bikeshare
```

```ruby
require 'bikeshare'
```

## Available methods:


```ruby
response = BikeShare.new
```
Returns the full JSON of stations available and their information

```ruby
response.stations("San Francisco")
```
Takes a city name string such as `"San Francisco"` and returns an array of all the stations in that municipality

```ruby
response.empty_stations
```
Returns an array of all stations with 0 `availableBikes`

```ruby
response.empty?(2)
```
Takes a `station_id` as an integer and retuns true or false based on the number of `availableBikes`

```ruby
response.available_bikes(2)
```
Takes a `station_id` as an integer and returns the nunber of available bikes

```ruby
response.total_docks(2)
```
Takes a `station_id` as an integer and returns the total number of docks at that station

```ruby
response.percent_available(2)
```
Takes a `station_id` as an integer and returns the percentage of bikes available, rounded two decimal places

```ruby
response.offline_stations
```
Returns an array of stations currently offline


* For more information, please go to the [Bay Area Bike Share website](http://bayareabikeshare.com)

* If you would like to make changes or updates, please fork this, create a new branch with your changes and submit a pull request!

* If you have any questions, I'm [@ZackShapiro](http://twitter.com/zackshapiro) on Twitter. Feel free to say hi!
