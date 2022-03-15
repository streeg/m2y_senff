module M2ySenff

	class SenffInvoice < SenffModule

        def initialize(access_key, secret_key, url)
            startModule(access_key, secret_key, url)
	     end
	
        def findInvoice(id)
            response = @request.get(@url + DEPOSIT_PATH + "/#{id}", ["get:/v1/accounts/deposits/",id].join("") )
            invoice = SenffModel.new(response)
             if invoice && invoice.data
                invoice.status = invoice.data["status"] == "PAID" ? 4 : 3
                invoice.dataVencimento = invoice.data["boleto"]["dueDate"]
                invoice[:content] = invoice
            end
            invoice
        end

 	end

end