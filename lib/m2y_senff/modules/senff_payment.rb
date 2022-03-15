module M2ySenff

  class SenffPayment < SenffModule

    def initialize(client_id, client_secret, url, scope, auth_url)
      @auth = SenffAuth.new(client_id, client_secret, url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, auth_url + PAYMENT_AUTH_PATH, scope)
    end


    def refreshToken
      if SenffHelper.shouldRefreshToken?(@client_secret)
        @auth.generateToken
      end
    end

    def validate(ean)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"

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
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"

      url = @url + PAYMENTS_RECEIPTS + "?conta=#{account}&dataInicial=#{from}&dataFinal=#{to}"
      puts url
      req = HTTParty.get(url, :verify => false, headers: headers)
      puts req.to_json
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def find_receipt(account, auth)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"

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
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"

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
