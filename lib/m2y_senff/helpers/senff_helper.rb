require 'json'

module M2ySenff
  class SenffHelper
    def self.conductorBodyToString(json)
      string = '?'
      arr = []
      json.keys.each do |key|
        arr << key.to_s + '=' + json[key].to_s unless json[key].nil?
      end
      string + arr.join('&')
    end

    def self.generate_general_response(input)
      cdtErrorHandler = SenffErrorHandler.new
      response = {}
      if cdtErrorHandler.mapErrorType(input)
        {
          success: false,
          error: cdtErrorHandler
        }
      else
        {
          success: true,
          content: input
        }
      end
    end

    def self.saveToken(basic, token)
      unless token.nil?
        ENV["SENFF_TOKEN#{basic.last(6)}"] = token.to_s
        ENV["SENFF_TOKEN_EXPIRY#{basic.last(6)}"] = (Time.now + 1500).to_s
      end
    end

    def self.shouldRefreshToken?(basic)
      finish_date = ENV["SENFF_TOKEN_EXPIRY#{basic.last(6)}"]
      finish_date.nil? || (Time.parse(finish_date.to_s) - 500) < Time.now
    end

    def self.get_token(basic)
      ENV["SENFF_TOKEN#{basic.last(6)}"]
    end
  end
end
