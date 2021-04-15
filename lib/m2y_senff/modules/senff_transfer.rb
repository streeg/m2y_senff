module M2ySenff

  class SenffTransfer < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end


    def bankTransfers(body, is_ted, date = nil)
      if !checkFav(body)
        addFav(body)
      end

      #fix cdt_params
      senff_body = {}
      senff_body[:idTitul] = 'C'

      senff_body[:cdCta] = body[:cdCta]
      senff_body[:nrAgen] = body[:nrAgen]
      senff_body[:vlLanc] = body[:value]

      # if Time.now.utc.hour > 20
      #   date = DateTime.now.next_day
      # else
      if date.nil?
        date = DateTime.now
      end

      if date.hour > 20
        date = DateTime.now.next_day
      end


      if date.wday == 6
        date = date.next_day.next_day
      elsif date.wday == 0
        date = date.next_day
      end

      senff_body[:dtLanc] = date.strftime("%Y%m%d")
      senff_body[:tpTransf] = is_ted ? 2 : 3
      senff_body[:tpCtaFav] = 'CC'
      senff_body[:nrSeqDes] = 0
      senff_body[:cdOrigem] = 24556
      senff_body[:nrDocCre] = 9
      senff_body[:cdFin] = 30
      senff_body[:nrSeq] = 0
      senff_body[:dsHist] = ''
      senff_body[:dsHistC] = ''
      senff_body[:nrBcoDes] = body[:beneficiary][:bankId]
      senff_body[:nrCpfCnpj] = body[:beneficiary][:docIdCpfCnpjEinSSN]
      senff_body[:nrAgeDes] = body[:beneficiary][:agency]
      senff_body[:nrCtaDes] = body[:beneficiary][:account]

      #adicionando DV
      if !body[:beneficiary][:accountDigit].nil?
        senff_body[:nrCtaDes] = "#{senff_body[:nrCtaDes]}#{body[:beneficiary][:accountDigit]}".to_i
      end


      senff_body[:nmFavore] = body[:beneficiary][:name]
      senff_body[:nrInst] = getInstitution

      puts senff_body

      response = @request.post(@url + TRANSFER_PATH, senff_body)

      puts response
      transferResponse = SenffModel.new(response)

      if transferResponse && transferResponse.efetuaLancamentoTransferencia == 0
        transferResponse.id = Time.now.to_i
        transferResponse.statusCode = 200
        transferResponse.transactionCode = Time.now.to_i
        # transferResponse.content = transferResponse
      end
      transferResponse
    end


    def getBankTransfers(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      params[:nrPrazo] = 120
      params[:tpComprovante] = 1
      response = @request.post(@url + RECEIPTS_PATH, params)
      SenffModel.new(response)
    end

    def getBankTransfersDetails(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      puts @url + RECEIPTS_DETAILS
      puts params
      response = @request.post(@url + RECEIPTS_DETAILS, params)
      SenffModel.new(response)
    end

    def findReceipt(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      response = @request.post(@url + FIND_RECEIPTS_PATH, params)
      SenffModel.new(response)
    end

  end
end
