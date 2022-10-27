module M2ySenff
  class SenffCapital < SenffModule
    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def contractsList(params)
      params[:nrInstituicao] = getInstitution
      puts params
      url = @url + WORKING_CAPITAL_CONTRACTS_LIST
      puts url
      response = @request.get(url + "?nrAgencia=#{params[:nrAgencia]}&nrCpfCnpj=#{params[:nrCpfCnpj]}&nrInstituicao=#{params[:nrInstituicao]}")
      begin
        contractsResponse = SenffModel.new(response)
      rescue StandardError
        nil
      end
      contractsResponse
    end
  
    def getContract(params)
      headers = getAddressHeaders
      params[:nrInst] = getInstitution 
      puts params
      url = @url +WORKING_CAPITAL_GET_CONTRACT
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
