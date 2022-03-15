module M2ySenff

  class SenffCep < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def ceps(body)
      response = @request.get("https://viacep.com.br/ws/#{body[:CEP]}/json")
      person = SenffModel.new(response)
      person
    end

  end
end
