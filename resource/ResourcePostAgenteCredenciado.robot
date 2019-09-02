*** Settings ***
Library  RequestsLibrary
Library  DatabaseLibrary
Library  BuiltIn
Library  String
Library  Collections
Library  OperatingSystem

*** Variables ***
${base_uri}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net:443/v1
${base_path}  /agentesCredenciados/

&{headers}
    ...   Content-Type=application/json

#Info banco de dados
${user}=  developer
${password}=  developer
${string_conexao}=  '${user}/${password}@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=db1core2062t.tst.sicredi.net)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=coredb)(SERVER=DEDICATED)))'

${query}
  ...  SELECT P.CIF AS OID_PESSOA, P.CPF_CNPJ, ME.NUM_COOPERATIVA
  ...  FROM SICREDI_OWNER.VW_ENTIDADE_SICREDI VES, SICREDI_OWNER.MVW_ENTIDADE ME, VW_PESSOA P
  ...   WHERE VES.COD_ENTIDADE = ME.COD_ENTIDADE
  ...     AND VES.COD_POSTO = ME.COD_POSTO
  ...     AND P.ORIGEM = VES.COD_ENTIDADE
  ...     AND ROWNUM <= 1

${situacao}  1
${descricao}  VEICULOS
${id}  1



*** Keywords ***
#TC: Validar add agente credenciado tipo veiculos - sucess
Busca dados no db
  Connect To Database Using Custom Params  cx_Oracle  ${string_conexao}
  @{queryResults}=  Query  ${query}
  ${oid_pessoa}=  Set Variable  ${queryResults[0][0]}
  ${cpf_cnpj}=  Set Variable  ${queryResults[0][1]}
  ${num_agencia}=  Set Variable  ${queryResults[0][2]}

  Log Many  @{queryResults}

  Set Global Variable  ${oid_pessoa}
  Set Global Variable  ${cpf_cnpj}
  Set Global Variable  ${num_agencia}

  ${aux}  Convert To String  ${oid_pessoa}

  Set Global Variable  ${aux}

  disconnect from database

Validar add agente credenciado tipo veiculos
  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  201


#TC: Validar add agente credenciado tipo cdc - sucess
Validar add agente credenciado tipo cdc
  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  201


#TC: Validar add agente credenciado tipo veiculos e cdc - sucess
Validar add agente credenciado tipo veiculos e cdc
  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado2.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  201


#TC: Validar add agente credenciado sem reguistro na db
Validar add agente credenciado sem reguistro na db
  ${oid_pessoa}  Set Variable  9999999

  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${oid_pessoa}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  500


#TC: Validar add agente credenciado com campo cpfCnpj não informado
Validar add agente credenciado com campo cpfCnpj não informado
  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado3.json
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  400
  Should Be Equal As Strings  ${response.json()['message']}  Dados obrigatórios: cpfCnpj


#TC: Validar add agente credenciado com campo cpfCnpj inválido
Validar add agente credenciado com campo cpfCnpj inválido
  ${cpf_cnpj}  Set Variable  9999999
  Convert To String  ${cpf_cnpj}

  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  400
  Should Be Equal As Strings  ${response.json()['message']}  Dados Inválidos: cpfCnpj


#TC: Validar add agente credenciado com campo numAgencia não informado
Validar add agente credenciado com campo numAgencia não informado
  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado4.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  400
  Should Be Equal As Strings  ${response.json()['message']}  Dados obrigatórios: numAgencia

#TC: Validar add agente credenciado com campo numAgencia inválido
Validar add agente credenciado com campo numAgencia inválido

  ${num_agencia}  Set Variable  99
  Convert To String  ${num_agencia}

  ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado.json
  ${payload}    Replace String  ${payload}  new_cpf_cnpj       ${cpf_cnpj}
  ${payload}    Replace String  ${payload}  new_num_agencia    ${num_agencia}
  ${payload}    Replace String  ${payload}  new_oid_pessoa     ${aux}
  ${payload}    Replace String  ${payload}  new_situacao       ${situacao}
  ${payload}    Replace String  ${payload}  new_descricao      ${descricao}
  ${payload}    Replace String  ${payload}  new_id             ${id}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  POST Request  api  ${base_path}  data=${payload}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  400
  Should Be Equal As Strings  ${response.json()['message']}  Dados Inválidos: numAgencia
