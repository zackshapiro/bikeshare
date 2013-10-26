Gem::Specification.new do |s|
  s.name        = 'bikeshare'
  s.version     = '0.0.8'
  s.date        = '2013-10-12'
  s.summary     = "A Ruby wrapper for Bay Area Bike Share bike and station information."
  s.description = "A Ruby wrapper for Bay Area Bike Share bike and station information."
  s.authors     = ["Zack Shapiro"]
  s.email       = 'zack@zackshapiro.com'
  s.files       = ["lib/bikeshare.rb"]
  s.homepage    = "https://github.com/zackshapiro/bay-area-bike-share"
  s.license       = 'MIT'

  s.add_dependency 'json'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'debugger'
end