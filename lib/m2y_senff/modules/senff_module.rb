module M2ySenff

  class SenffModule

    def startModule(access_key, secret_key, url)
      @request = SenffRequest.new(access_key, secret_key)
      @url = url
    end

    def generateResponse(input)
      SenffHelper.generate_general_response(input)
    end

    def getInstitution
      # response = @request.get(@url + USER_PATH)
      # SenffModel.new(response).nrInst
      INSTITUTION_ID
    end


    def senffBody(body)
      senff_body = {}
      senff_body[:cdCta] = body[:cdCta]
      senff_body[:nrAgen] = body[:nrAgen]
      senff_body[:tpCtaptb] = 'CC'
      senff_body[:nrSeqDes] = 0
      senff_body[:nrSeq] = 0
      senff_body[:nrBanco] = body[:beneficiary][:bankId]
      senff_body[:nrCpfcnpj] = body[:beneficiary][:docIdCpfCnpjEinSSN]
      senff_body[:nrAgedes] = body[:beneficiary][:agency]
      senff_body[:cdCtades] = body[:beneficiary][:account]
      if !body[:beneficiary][:accountDigit].nil?
        senff_body[:cdCtades] = "#{senff_body[:cdCtades]}#{body[:beneficiary][:accountDigit]}".to_i
      end
      senff_body[:nmFav] = body[:beneficiary][:name]
      senff_body[:nmApel] = body[:beneficiary][:name]
      senff_body[:dsPesq] = body[:beneficiary][:name]
      senff_body[:nrInst] = getInstitution
      senff_body
    end

    def addFav(body)
      senff_body = senffBody(body)
      response = @request.post(@url + ADD_FAV_PATH, senff_body)
      puts response
    end

    def checkFav(body)
      senff_body = senffBody(body)
      senff_body[:tpFiltro] = 1
      response = @request.post(@url + CHECK_FAV_PATH, senff_body)
      puts response
      if response["listaFavorecidos"].nil?
        false
      else
        response["listaFavorecidos"].each do |fav|
          if fav["cdCtades"] == senff_body[:cdCtades]
            return true
          end
        end
        false
      end
      #dev only
      false
    end

    def getAddressHeaders
      url = address_url + USER_ADDRESS_PATH
      response = HTTParty.get(url, basic_auth: @request.auth)

      headers = {}

      token = response.headers["set-cookie"]
      if !token.nil?
        token = token.split("XSRF-TOKEN=").last.split(";").first
        puts token
        headers["X-XSRF-TOKEN"] = token
        headers["Cookie"] = "XSRF-TOKEN=#{token}"
      end
      puts headers
      headers
    end

    def address_url
      @url.gsub('8090', '8093')
    end

  end

end
