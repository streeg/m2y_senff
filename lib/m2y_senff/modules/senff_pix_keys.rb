module M2ySenff
  class SenffPixKeys < SenffModule
    def initialize(client_id, client_secret, url, scope, auth_url)
      @auth = SenffAuth.new(client_id, client_secret, url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, auth_url + PIX_AUTH_PATH, scope)
    end

    def refreshToken
      @auth.generateToken if SenffHelper.shouldRefreshToken?(@client_secret)
    end

    def list_keys(body)
      refreshToken
      url = @url + PIX_LIST_KEYS_PATH
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def complete_key_claim(id, body)
      refreshToken
      url = @url + PIX_COMPLETE_KEY_CLAIM_PATH + "#{id}/concluir"
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def deny_key_claim(id, body)
      refreshToken
      url = @url + PIX_DENY_KEY_CLAIM_PATH + "#{id}/cancelar"
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def confirm_key_claim(id, body)
      refreshToken
      url = @url + PIX_CONFIRM_KEY_CLAIM_PATH + "#{id}/confirmar"
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def list_claim_keys(body)
      refreshToken
      url = @url + PIX_LIST_CLAIM_KEY_PATH
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def generate_key(body)
      refreshToken
      url = @url + PIX_ADD_KEY_PATH
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def claim_key(body)
      refreshToken
      url = @url + PIX_CLAIM_KEY_PATH
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def remove_key(id, body)
      refreshToken
      url = @url + PIX_REMOVE_KEY_PATH + id.to_s
      puts url
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def validate_key(key, cnpj)
      refreshToken
      url = @url + PIX_VALIDATE_KEY_PATH + key.to_s
      puts url
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      headers['PI-PayerId'] = cnpj
      req = HTTParty.get(url, body: key.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def transfer(body)
      refreshToken
      url = @url + PIX_TRANSFER_PATH
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end

    def generate_static_qrcode(body)
      refreshToken
      url = @url + PIX_STATIC_QRCODE_PATH
      puts url
      headers = json_headers
      headers['Authorization'] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers['Chave-Idempotencia'] = SecureRandom.uuid
      puts body
      req = HTTParty.post(url, body: body.to_json, verify: false, headers: headers)
      puts req
      begin
        SenffModel.new(req.parsed_response)
      rescue StandardError
        nil
      end
    end
  end
end
