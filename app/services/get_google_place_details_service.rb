class GetGooglePlaceDetailsService
  BASE_URL = "https://places.googleapis.com/v1/places"

  def initialize(place_id)
    @place_id = place_id
    @api_key = ENV['GOOGLE_PLACES_API_KEY']
  end

  def call
    url = "#{BASE_URL}/#{@place_id}"
    headers = {
      "Content-Type" => "application/json",
      "X-Goog-Api-Key" => @api_key,
      "X-Goog-FieldMask" => "displayName,formattedAddress,rating,nationalPhoneNumber,websiteUri,primaryTypeDisplayName,photos,googleMapsUri"
    }

    response = HTTParty.get(url, headers: headers)
    if response.success?
      response.parsed_response
    else
      { error: response.code, message: response.parsed_response }
    end
  end
end
