module M2ySenff
  class SenffLimits < SenffModule
    def initialize(client_id, client_secret, url, auth_url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, auth_url + LIMITS_AUTH_PATH)
    end

    def refreshToken
      @auth.generateToken if SenffHelper.shouldRefreshToken?(@client_secret)
    end

    def pix_limits_nighttime(body)
      refreshToken
      url = @url + PIX_LIMITS_NIGHTTIME + "?Documento=#{body[:cnpj]}"
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      req = HTTParty.get(url, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def list_limits_pix(body)
      refreshToken
      url = @url + LIST_LIMITS_PIX + "?Documento=#{body[:cnpj]}"
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      req = HTTParty.get(url, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end
  end
end
