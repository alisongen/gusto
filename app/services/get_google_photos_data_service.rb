class GetGooglePhotosDataService
  def initialize(name)
    @name = name
    @api_key = ENV['GOOGLE_PLACES_API_KEY']
  end

  def call
    p url
    response = HTTParty.get(url)
    if response.success?
      response.parsed_response
    else
      { error: response.code, message: response.parsed_response }
    end
  end

  def url
    "https://places.googleapis.com/v1/#{@name}/media?key=#{@api_key}&maxWidthPx=1024"
  end
end
