module M2ySenff

  class SenffPayment < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
      @auth = SenffAuth.new(client_id, client_secret, url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, url)
    end


    def refreshToken
      if SenffHelper.shouldRefreshToken?(@client_id)
        @auth.generateToken
      end
    end

    def validate(ean)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + VALIDATE_PATH + ean
      puts url
      req = HTTParty.get(url, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def receipts(account, from, to)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + PAYMENTS_RECEIPTS + "?conta=#{account}&dataInicial=#{from}&dataFinal=#{to}"
      puts url
      req = HTTParty.get(url, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def find_receipt(account, auth)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + PAYMENTS_RECEIPTS + "?conta=#{account}&autorizacao=#{auth}"
      puts url
      req = HTTParty.get(url, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def pay(body)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + PAY
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end


  end

end
