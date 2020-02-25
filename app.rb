require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "c3e18d2e5103cb533deb1674c7ac4dc9"

get "/" do
  # show a view that asks for the location

  view"ask"
end

get "/news" do
    results = Geocoder.search(params["location"])
    lat_long = results.first.coordinates # => [lat, long]
    "#{lat_long[0]} #{lat_long[1]}"
end