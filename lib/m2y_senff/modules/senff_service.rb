module M2ySenff
  class SenffService < SenffModule
    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def p2pTransfer(body)
      addFav(body) unless checkFav(body)

      # fix cdt_params
      senff_body = {}
      senff_body[:idTitul] = 'C'

      senff_body[:cdCta] = body[:cdCta]
      senff_body[:nrAgen] = body[:nrAgen]
      senff_body[:vlLanc] = body[:value]
      senff_body[:dtLanc] = Time.now.strftime('%Y%m%d')
      senff_body[:tpTransf] = 1
      senff_body[:tpCtaFav] = 'CC'
      senff_body[:nrSeqDes] = 0
      senff_body[:cdOrigem] = 24_556
      senff_body[:nrDocCre] = 9
      senff_body[:cdFin] = 30
      senff_body[:nrSeq] = 0
      senff_body[:dsHist] = ''
      senff_body[:dsHistC] = ''
      senff_body[:nrBcoDes] = get_bank
      senff_body[:nrCpfCnpj] = body[:beneficiary][:docIdCpfCnpjEinSSN]
      senff_body[:nrAgeDes] = 1
      senff_body[:nrCtaDes] = body[:beneficiary][:account]
      senff_body[:nmFavore] = body[:beneficiary][:name]
      senff_body[:nrInst] = getInstitution

      puts senff_body

      response = @request.post(@url + PIX_PATH, senff_body)

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

    def get_bank
      BANK_ID
    end
  end
end
