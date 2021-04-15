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
# p a.getBanks

a = M2ySenff::SenffIndividual.new(basic_user, basic_password, url)
account = a.findPerson(cpf)
puts account

a = M2ySenff::SenffAccount.new(basic_user, basic_password, url)
nrClient = account.nrClient
account = a.getAccounts(account.nrClient)
p account

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen}
# 



a = M2ySenff::SenffAddress.new(basic_user, basic_password, url)
# p a.getBankTransfers(cdt_params)

cdt_params = {:nrClient=> nrClient, :nrInst=> 1422, tpEnd: 2}

p a.getAddresses(cdt_params)
# p a.findReceipt(cdt_params)


