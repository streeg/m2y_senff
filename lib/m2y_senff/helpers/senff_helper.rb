require 'json'

module M2ySenff
  class SenffHelper


    def self.conductorBodyToString(json)
      string = "?"
      arr = []
      json.keys.each do |key|
        if !json[key].nil?
          arr << key.to_s + "=" + json[key].to_s
        end
      end
      string + arr.join("&")
    end

    def self.generate_general_response(input)
      cdtErrorHandler = SenffErrorHandler.new
      response = {}
      if cdtErrorHandler.mapErrorType(input)
        response = {
          success: false,
          error: cdtErrorHandler
        }
      else
        response = {
          success: true,
          content: input
        }
      end
      response
    end
  end
end
