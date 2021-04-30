module M2ySenff

  class SenffRecharge < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
      @auth = SenffAuth.new(client_id, client_secret, url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, url)
    end

    def dealers
      url = @url + DEALERS_PATH
      req = HTTParty.get(url, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def refreshToken
      if SenffHelper.shouldRefreshToken?(@client_id)
        @auth.generateToken
      end
    end


    def receipts(account, from, to)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + RECHARGES_RECEIPTS + "?conta=#{account}&dataInicial=#{from}&dataFinal=#{to}"
      req = HTTParty.get(url, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def packages(body)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + RECHARGES_PACKAGES
      puts url
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def recharge(body)
      refreshToken
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_id)}"

      url = @url + RECHARGE
      puts url
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end


  end

end
