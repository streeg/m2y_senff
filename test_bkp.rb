require "m2y_senff"

basic_user = "servcc"
basic_password = "S88c@"

cpf = "03004345960"
cpf = "40709258801"

cpf = "37995934890"
cpf = "37856994843"
cpf = "37995934890"
cpf = "06719175955"
url = "https://apihomol-senff.sinqia.com.br"

a = M2ySenff::SenffBank.new(basic_user, basic_password, url)
p a.getBanks

a = M2ySenff::SenffIndividual.new(basic_user, basic_password, url)
account = a.findPerson(cpf)
puts account

a = M2ySenff::SenffAccount.new(basic_user, basic_password, url)
nrClient = account.nrClient
account = a.getAccounts(account.nrClient)
p account

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen}
# 
# p cdt_params

p a.findAccount(cdt_params)

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen, dtIni: 20210118, dtFin: 20210221}
# p "*****"
# p "*****"
p "*****"
p "*****"
p "*****"

p a.getTransactions(cdt_params, false).to_json

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen, nrCliente: nrClient}

a = M2ySenff::SenffTransfer.new(basic_user, basic_password, url)
p a.getBankTransfers(cdt_params)

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen,  nrAuten: "809A09BA-2ED7-4ABD-97EA-4BB6A9107B9F", dtTransf: 20201126, dtLanc: 20201126, nrTransf: 112}

# p a.createReceipt(cdt_params)
# p a.findReceipt(cdt_params)


