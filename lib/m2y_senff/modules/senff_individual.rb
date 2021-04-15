module M2ySenff

  class SenffIndividual < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def findPerson(cpf)
      response = @request.get(@url + CUSTOMERS_PATH + "?nrCpfcnpjUsu=#{cpf}")
      begin
        SenffModel.new(response["clientes"].select{|x| x["nrCpfCnpjCli"] == cpf}.first)
      rescue
        nil
      end
    end

  end

end
