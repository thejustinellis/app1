class AlphaVantage::Client
  include HTTParty
  base_uri "ENV['ALPHAVANTAGE_URL']" 
  #debug_output $stdout
  ## as this is a super simple GET request, i didn't build the full client
  ## if needed, this can be extended
  def self.get_data(time_series,ticker,api_key)
    result = HTTParty.get("https://www.alphavantage.co/query?function=#{time_series}&symbol=#{ticker}&apikey=#{api_key}")
    return(result.parsed_response['Time Series (Daily)'])
  end
end
