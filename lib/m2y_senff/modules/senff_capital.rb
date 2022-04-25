module M2ySenff
  class SenffCapital < SenffModule
    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def getContracts(params)
      headers = getAddressHeaders
      params[:nrInst] = getInstitution
      puts params
      url = @url + WORKING_CAPITAL_LOAN
      puts url
      response = @request.post(url, params, headers)
      begin
        contractsResponse = SenffModel.new(response)
      rescue StandardError
        nil
      end
      contractsResponse
    end
  end
end
