module M2ySenff

  class SenffBillet < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def generateTicket(senff_body)
      senff_body[:nrInst] = getInstitution
      puts senff_body
      url = @url + BILLETS_PATH
      puts url
      response = @request.post(url, senff_body)
      transferResponse = SenffModel.new(response)
      transferResponse
    end

  end
end
