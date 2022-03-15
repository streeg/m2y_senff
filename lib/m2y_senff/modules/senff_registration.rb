
module M2ySenff

	class SenffRegistration < SenffModule

        def initialize(access_key, secret_key, url)
            startModule(access_key, secret_key, url)
        end

        def createRegistration(body, version = 1)
            #fix cdt_params
            senff_body = {}
            senff_body[:externalIdentifier] = rand(1..9999)
            senff_body[:sharedAccount] = false
            senff_body[:client] = {
                name: body[:name],
                email: body[:email],
                socialName: body[:legalName].nil? ? body[:name] : body[:legalName],
                taxIdentifier: {
                    country: "BRA",
                    taxId: body[:document]
                },
                mobilePhone: {
                    country: "BRA",
                    phoneNumber: body[:phone][:areaCode].to_i.to_s + body[:phone][:number]
                }
            }
            puts senff_body

            response = @request.post(@url + ACCOUNT_PATH, senff_body,[senff_body[:externalIdentifier], senff_body[:client][:taxIdentifier][:taxId]].join("") )
            account = SenffModel.new(response)
            
            if account && account.data
                account.data["registration_id"] = account.data["account"]["accountId"]
                account.data["id"] = senff_body[:externalIdentifier]
                account.data["account_id"] = senff_body[:externalIdentifier]
                account.data["person_id"] = account.data["accountHolderId"]
            end
            account
        end


	end

end
