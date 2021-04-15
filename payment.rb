require "m2y_senff"

basic_user = "ws.mobile2you"
basic_password = "z1x2c3v$B%N&"
basic_user = "ws_mby"
basic_password = "M%%HLI#0"
env = "hml"
cpf = "37856994843"

a = M2ySenff::SenffIndividual.new(basic_user, basic_password, url)
account = a.findPerson(cpf)

a = M2ySenff::SenffAccount.new(basic_user, basic_password, url)

account = a.getAccounts(account.nrClient)

barCode = "23798862000000001003391090190000035500082250"

a = M2ySenff::SenffPayment.new(basic_user, basic_password, url)

p a.paymentValidate(barCode)


cdt_params = {
  "nrAgen": account.nrAgen,
  "cdCta": account.cdCta,
  "description": "Transferbank Description",
  "beneficiary": {
    "type": "fisico",
    "docIdCpfCnpjEinSSN": 37856994843,
    "name": "Caio c c Lopes",
    "bankId": "341",
    "agency": "8170",
    "agencyDigit": "",
    "account": "23510",
    "accountDigit": "8",
    "accountType": "cc"
  },
  "value": 0.42
}



# a = M2ySenff::SenffService.new(basic_user, basic_password, url)
# p a.p2pTransfer(cdt_params)

a = M2ySenff::SenffTransfer.new(basic_user, basic_password, url)
# p a.bankTransfers(cdt_params, true, DateTime.now.next_day.next_day.next_day.next_day.next_day)
# p a.bankTransfers(cdt_params, false)



cdt_params = {
  "nrAgen": account.nrAgen,
  "cdCta": account.cdCta,
  "description": "Transferbank Description",
  "beneficiary": {
    "type": "fisico",
    "docIdCpfCnpjEinSSN": 37856994843,
    "name": "Thiago Carmo",
    "agency": 19,
    "bankId": "343",
    # "agencyDigit": "",
    "account": "108",
    "accountDigit": " ",
    "accountType": "cc"
  },
  "value": 0.12
}

    # {"nrInst"=>343, "nrAgen"=>19, "cdCtades"=>108, "nmFav"=>"Thiago Carmo", "nrCpfcnpj"=>"30125469870"}, {"nrInst"=>655, "nrAgen"=>1111, "cdCtades"=>622653217, "nmFav"=>"mobile 2 you tecnologia Ltda", "nrCpfcnpj"=>"17357065000191"}, {"nrInst"=>1422, "nrAgen"=>19, "cdCtades"=>183, "nmFav"=>"Caio Lopes", "nrCpfcnpj"=>"37856994843"}]}


# a = M2ySenff::SenffService.new(basic_user, basic_password, url)
# p a.p2pTransfer(cdt_params)




