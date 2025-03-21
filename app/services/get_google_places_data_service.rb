class GetGooglePlacesDataService
  BASE_URL = 'https://places.googleapis.com/v1/places:searchText'

  def initialize(query)
    @query = query
    @api_key = ENV['GOOGLE_PLACES_API_KEY']
  end

  def call
    headers = {
      "Content-Type" => "application/json",
      "X-Goog-Api-Key" => @api_key,
      "X-Goog-FieldMask" => "places.id,places.displayName,places.formattedAddress,places.addressComponents,places.rating,places.nationalPhoneNumber,places.websiteUri,places.primaryTypeDisplayName,places.photos"
    }

    body = {
      "textQuery" => @query,
      "includedType" => "restaurant",
      "locationRestriction" => {
        rectangle: {
          low: {
            latitude: 48.815573,
            longitude: 2.224199
          },
          high: {
            latitude: 48.902144,
            longitude: 2.469921
          }
        }
      }
    }.to_json

    response = HTTParty.post(BASE_URL, headers: headers, body: body)

    if response.success?
      response.parsed_response
    else
      { error: response.code, message: response.parsed_response }
    end
  end
end
