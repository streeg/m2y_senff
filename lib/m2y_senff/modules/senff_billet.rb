module M2ySenff

	class SenffBillet < SenffModule

        def initialize(access_key, secret_key, url)
            startModule(access_key, secret_key, url)
        end

        def generateTicket(body)
            #fix cdt_params
            senff_body = {}
            senff_body[:externalIdentifier] = rand(1..999999)
            senff_body[:paymentInfo] = {
                transactionType: "Boleto",
                boleto: {
                    bank: "341",
                    accountingMethod: "DEF",
                    dueDate: body[:dataVencimento]
                }
            }
            senff_body[:recipients] = [{
                    account: {
                    	accountId: body[:idConta]
                    },
                    amount: body[:valor],
                    currency: "BRL"
             }]

            puts senff_body

			int_amount = (body[:valor].divmod 1)[0].to_s


            response = @request.post(@url + DEPOSIT_PATH, senff_body,[body[:idConta], int_amount].join("") )
            
            billet = SenffModel.new(response)
            # recipient.accountId, and recipient.amount
            if billet && billet.data
                billet.id = billet.data["transactionId"]
                billet.banco = "341"
                billet.numeroDoDocumento = billet.id
                billet.linhaDigitavel = billet.data["typeableLine"]
                billet.url = billet.data["boletoUrl"]
                billet.statusCode = 200
            end
            billet
        end

	end
end



