module M2ySenff

	class SenffAuth 

      def initialize(client_id, client_secret, url, scope = nil)
        @client_id = client_id
        @client_secret = client_secret
        @url = url
        @scope = scope
      end

      def generateToken
        puts @url
        data = {
          client_id: @client_id,
          client_secret: @client_secret,
          grant_type: GRANT_TYPE,
          scope: @scope.nil? ? SCOPE : @scope,
        }

        puts data.to_json

        response = HTTParty.post(@url + PIX_AUTH_PATH,
          body: URI.encode_www_form(data),
          headers: { 
            'Content-Type' => 'application/x-www-form-urlencoded'
          }, :verify => false
        )

        puts response

        if response.code == 200
          SenffHelper.saveToken(@client_secret, response.parsed_response["access_token"])
        end
	   end

	end
end


