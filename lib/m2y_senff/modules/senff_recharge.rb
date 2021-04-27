module M2ySenff

  class SenffRecharge < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def dealers
      url = @url + DEALERS_PATH
      req = HTTParty.get(url, :verify => false)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def receipts(account, from, to)
      url = @url + RECHARGES_RECEIPTS + "?conta=#{account}&dataInicial=#{from}&dataFinal=#{to}"
      req = HTTParty.get(url, :verify => false)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def packages(body)
      url = @url + RECHARGES_PACKAGES
      puts url
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: json_headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def recharge(body)
      url = @url + RECHARGE
      puts url
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: json_headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end


  end

end
