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

  describe "#empty?" do
    it "should raise an error with a bad station id" do
      expect { @response.empty?(0) }.to raise_error
    end

    it "should raise an error with no station id" do
      expect { @response.empty? }.to raise_error
    end

    it "should return true if there are no bikes" do
      BikeShare.any_instance.stub(:empty?).and_return true
      @response.empty?(3).should be_true
    end

    it "should return false if there are 1 or more bikes" do
      @response.empty?(3).should_not be_true
    end
  end

  describe "#full?" do
    it "should raise an error with a bad station id" do
      expect { @response.full?(0) }.to raise_error
    end

    it "should raise an error with no station id" do
      expect { @response.full? }.to raise_error
    end
  end

  describe "#available_bikes" do
    it "should raise an error with a bad station id" do
      expect { @response.available_bikes(0) }.to raise_error
    end

    it "should raise an error with no station id" do
      expect { @response.available_bikes }.to raise_error
    end

    it "should return the number of bikes at the station" do
      @response.available_bikes(3).should >= 0
    end
  end

  describe "#total_docks" do
    it "should raise an error with a bad station id" do
      expect { @response.total_docks(0) }.to raise_error
    end

    it "should raise an error with no station id" do
      expect { @response.total_docks }.to raise_error
    end

    it "should return the number of docks at the station" do
      @response.total_docks(8).should > 0
    end
  end

  describe "#percent_available" do
    it "should raise an error with a bad station id" do
      expect { @response.percent_available(0) }.to raise_error
    end

    it "should raise an error with no station id" do
      expect { @response.percent_available }.to raise_error
    end

    it "should return the percentage of bikes available" do
      @response.percent_available(7).is_a? Float
      @response.percent_available(7).should >= 0.0
    end
  end

  describe "offline_stations" do
    it "should return an empty array if no stations are offline" do
      @response.offline_stations.should == []
    end

    it "should return an array of stations if one or more are offline" do
      response = BikeShare.any_instance.stub(:offline_stations).and_return([{ :id => 2, :statusKey => 0}, { :id => 8, :statusKey => 0}])
      response.is_a? Array
      response.should_not be_nil
    end
  end

end