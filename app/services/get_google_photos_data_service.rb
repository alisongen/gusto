class GetGooglePhotosDataService
  def initialize(name)
    @name = name
    @api_key = ENV['GOOGLE_PLACES_API_KEY']
  end

  def call
    response = HTTParty.get(url)
    if response.success?
      response.parsed_response.dig("photoUri")
    else
      { error: response.code, message: response.parsed_response }
    end
  end

  def url
    "https://places.googleapis.com/v1/#{@name}/media?key=#{@api_key}&maxWidthPx=1024&skipHttpRedirect=true"
  end
end
