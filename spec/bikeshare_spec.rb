require 'spec_helper'
require 'bikeshare'
require 'debugger'

describe BikeShare do

  before(:each) do
    @response = BikeShare.new
  end
  
  describe "initialization" do
    it "should create a new BikeShare class" do
      @response.should_not == nil
    end
  end

  describe "#last_station" do
    it "should return the last station's id" do
      @response.get_last_station.should_not == nil
    end

    it "should return 77 for the last station's id" do
      @response.get_last_station.should == 77
    end
  end

  describe "#station_info" do
    it "should return the information for a single station if valid" do
      station = @response.station_info(2)
      station.should_not be_nil
      station.is_a? Hash
      station["id"] == 2
    end

    it "should return an error if invalid" do
      expect { @response.station_info(0) }.to raise_error
    end
  end

  describe "#stations" do
    it "should return all of the stations if no city name is provided" do
      @response.stations.should_not be_nil
      @response.stations.count.should == 64
    end

    it "should return the San Jose stations" do
      @response.stations("San Jose").count.should == 14
    end

    it "should return the San Francisco stations" do
      @response.stations("San Francisco").count.should == 34
    end

    it "should return an empty array with improperly capitalized info" do
      @response.stations("san francisco").should == []
    end

    it "should return an empty array with bad info" do
      @response.stations("baltimore").should == []
    end
  end

  describe "#empty_stations" do
    it "should return an empty array if no empty stations" do
      stations = []
      empties = @response.stub(:empty_stations).and_return(stations)
      empties.should be_nil
    end

    it "should return all of the empty stations" do
      station1 = @response.station_info(6)
      station2 = @response.station_info(8)
      stations = [ station1, station2 ]
      empties = @response.stub(:empty_stations).and_return(stations)
      empties.is_a? Array
    end
  end

  describe "#empty?"

  describe "#available_bikes"

  describe "#total_docks"

  describe "#percent_available"

  describe "offline_stations"

end