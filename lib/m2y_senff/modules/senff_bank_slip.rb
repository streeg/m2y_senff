module M2ySenff

  class SenffBankSlip < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def getPDF(id)
      response = @request.get(@url + DEPOSIT_PATH + "/#{id}", ["get:/v1/accounts/deposits/",id].join("") )
      invoice = SenffModel.new(response)
      invoice
      req = HTTParty.get(invoice.data["boleto"]["url"])
      req.parsed_response
    end


  end
end
