require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "c3e18d2e5103cb533deb1674c7ac4dc9"
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=07695ccbca25471d9d9972a36de857d2"


get "/" do
  # show a view that asks for the location

  view"ask"
end

get "/news" do
    @news = HTTParty.get(url).parsed_response.to_hash
    results = Geocoder.search(params["location"])
    @location = params["location"]
    lat_long = results.first.coordinates # => [lat, long]
    @latitude = lat_long[0]
    @longitude = lat_long[1]
    @lat_lng = "#{@latitude},#{@longitude}"
    @forecast = ForecastIO.forecast(@latitude,@longitude).to_hash
    @headlines = @news["articles"]
    @current_temperature = @forecast["currently"]["temperature"]
    @current_conditions = @forecast["currently"]["summary"]
    @weekly_summary = @forecast["daily"]["summary"]
     
    view"news"
end




