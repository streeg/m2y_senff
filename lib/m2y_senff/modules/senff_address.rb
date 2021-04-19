module M2ySenff

  class SenffAddress < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end



    def getAddresses(body)
      headers = getAddressHeaders
      body[:nrInst] = getInstitution
      response = @request.post(address_url + CHECK_ADDRESS, body, headers)
      puts response
      SenffModel.new(response)
    end

    def address_url
      @url.gsub('8090', '8093')
    end
  end
end
