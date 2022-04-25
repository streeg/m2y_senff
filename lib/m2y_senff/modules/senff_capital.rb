module M2ySenff

  class SenffCapital < SenffModule

    def initialize(client_id, client_secret, url)
      @auth = SenffAuth.new(client_id, client_secret, url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, url + USER_PATH_CAPITAL)
    end

    def refreshToken
      @auth.generateToken if SenffHelper.shouldRefreshToken?(@client_secret)
    end

    def getContracts(body)
      refreshToken
      body[:nrInst] = getInstitution
      puts body
      url = @url + WORKING_CAPITAL_LOAN
      debugger
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      puts url
      response = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      debugger
      begin
        #SenffModel.new(response.parsed_response)
        contractsResponse = SenffModel.new(response)
      rescue StandardError
        nil
      end
      contractsResponse
    end
  end
end
