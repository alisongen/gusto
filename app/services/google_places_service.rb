require 'open-uri'
require 'json'

class GooglePlacesService
  BASE_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json"

  def initialize(query)
    @query = query
    @api_key = ENV['GOOGLE_PLACES_API_KEY']
  end

  def results
    url = "#{BASE_URL}?query=#{URI.encode_www_form_component(@query)}&key=#{@api_key}"
    response = URI.open(url).read
    JSON.parse(response)["results"]
  end
end
