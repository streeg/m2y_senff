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
        scope: @scope.nil? ? SCOPE : @scope
      }
      data.delete(:scope) if @url.include?('sis-hml.senff')

      puts data.to_json
      puts data.to_json
      @url += PIX_AUTH_PATH if !@url.include?('connect') && !@url.include?('BJ08M06')

      puts @url
      body = URI.encode_www_form(data)
      puts body.to_s
      response = HTTParty.post(@url,
                               body: body,
                               headers: {
                                 'Content-Type' => 'application/x-www-form-urlencoded'
                               }, verify: false)

      puts response.to_json

      SenffHelper.saveToken(@client_secret, response.parsed_response['access_token']) if response.code == 200
    end
  end
end
