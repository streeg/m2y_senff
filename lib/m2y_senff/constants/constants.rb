module M2ySenff
  # banks
  BANK_ID = 1414
  INSTITUTION_ID = 1414

  # PIX JDPI
  SCOPE = 'qrcode_api'
  GRANT_TYPE = 'client_credentials'
  PIX_AUTH_PATH = '/auth/oauth2/token'
  PIX_ADD_KEY_PATH = '/dict/chave/incluir/'
  PIX_REMOVE_KEY_PATH = '/dict/chave/excluir/'
  PIX_LIST_KEYS_PATH = '/dict/chave/listar/chave'
  PIX_LIST_CLAIM_KEY_PATH = '/dict/chave/reivindicacao/listar'
  PIX_CLAIM_KEY_PATH = '/dict/chave/reivindicacao/incluir'
  PIX_CONFIRM_KEY_CLAIM_PATH = '/dict/chave/reivindicacao/'
  PIX_DENY_KEY_CLAIM_PATH = '/dict/chave/reivindicacao/'
  PIX_COMPLETE_KEY_CLAIM_PATH = '/dict/chave/reivindicacao/'
  PIX_VALIDATE_KEY_PATH = '/dict/chave/consultar/'
  PIX_TRANSFER_PATH = '/pagamentopix/op'
  PIX_STATIC_QRCODE_PATH = '/qrcode/estatico/gerar'
  PIX_DYNAMIC_QRCODE_PATH = '/qrcode/dinamico/gerar'
  PIX_DYNAMIC_QRCODE_DUEDATE_PATH = '/qrcode/dinamico/cobv/gerar'
  PIX_REVERSAL_REQUIRE_PATH = '/spi/devolucao'
  PIX_REVERSAL_CONSULT_PATH = '/spi/devolucao/'
  PIX_DECODE_QRCODE_PATH = '/qrcode/decodificar'

  ### Paths

  # account
  DEPOSIT_PATH = 'v1/accounts/deposits'
  PAYMENT_PATH = 'v1/payments'

  STATEMENT = '/statement'
  WITHDRAW = '/withdraw'

  # PIX SINQA
  PIX_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0104C/realizarPagamentoPix'
  BANKS_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0102A1/listarBancos'
  ACCOUNT_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0102M/obterContas'
  USER_PATH = '/API/BJ08M01/user'
  USER_PATH_CAPITAL = '/BJ04M06/user'
  INDIVIDUAL_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0101L/buscaDadosCliente'
  CUSTOMERS_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0107A/obterClientes'
  EXTRACT_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0101C/listaLancamentos'
  FUTURE_EXTRACT_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0101F/listaLancFuturos'
  RECEIPTS_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0101M/obterComprovantes'
  FIND_RECEIPTS_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0101N/criarComprovante'
  TRANSFER_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0101K/efetuaLancamentoTransferencia'
  ADD_FAV_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0102O/manutencaoCadastrarFavorecido'
  CHECK_FAV_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0102O/manutencaoListarFavorecidos'
  RECEIPTS_DETAILS = '/API/BJ08M01/BJ08M01/BJ08SS0101O/consultaComprovanteDetalhados'

  # BILLETTS
  BILLETS_PATH = '/API/BJ08M01/BJ08M01/BJ08SS0102G/gerarBoleto'
  
  # LOAN
  WORKING_CAPITAL_CONTRACTS_LIST = '/BJ04M06/contratos/contratosWFCliente'
  WORKING_CAPITAL_GET_CONTRACT = '/BJ04M06/contratos/contrato/pesquisaContrato'

  # PAYMENTS
  VALIDATE_EAN = '/API/BJ08M01/BJ08M01/BJ08SS0102F/validarBoleto'
  PAY_EAN = '/API/BJ08M01/BJ08M01/BJ08SS0102E/pagarBoleto'

  # DEG
  ADD_KIT = '/BJ79M02/BJ79M02/BJ79SS0101B/kitdoc'
  CHECK_KIT = '/BJ79M02/BJ79M02/BJ79SS0101B/consultaKit'
  SEND_PROPOSAL = '/BJ79M02/BJ79M02/BJ79SS0101A/proposta'

  CHECK_ADDRESS = '/BJ01M06/clientesEndereco/pesquisa'
  CHECK_CUSTOMERS = '/BJ01M06/clientes/pesquisa'
  USER_ADDRESS_PATH = '/BJ01M06/user'

  # recharge
  RECHARGE_AUTH_PATH = '/connect/token'
  DEALERS_PATH = '/api/mobile-rechange/operator'
  RECHARGES_RECEIPTS = '/api/cellphone-topups'
  RECHARGES_PACKAGES = '/api/mobile-rechange/refill-request'
  RECHARGE = '/api/mobile-rechange/request-recharge/pj'

  # payments
  PAYMENT_AUTH_PATH = '/connect/token'
  VALIDATE_PATH = '/api/bill-payments/'
  PAYMENTS_RECEIPTS = '/api/payments'
  PAY = '/api/bill-payments/pj'
end
