*** Settings ***
Library  RequestsLibrary
Library  DatabaseLibrary
Library  BuiltIn
Library  String
Library  Collections
Library  OperatingSystem

*** Variables ***
${url}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net:443/v1

&{headers}
    ...   Content-Type=application/json

*** Keywords ***
#TC: Validar Inserir Agente Credenciado Sucess
Enviar request POST /agentesCredenciados
    ${payload}    Get File    ${CURDIR}\\request_json\\payload_insere_agente_credenciado.json
    ${payload}    Replace String  ${payload}  new_cpf_cnpj       61240010044
    ${payload}    Replace String  ${payload}  new_num_agencia    0710
    ${payload}    Replace String  ${payload}  new_oid_pessoa     5355620
    ${payload}    Replace String  ${payload}  new_situacao       1
    ${payload}    Replace String  ${payload}  new_descricao      VEICULOS
    ${payload}    Replace String  ${payload}  new_id             1

    Create Session      api    ${url}  disable_warnings=1
    ${response}=  POST Request  api  /agentesCredenciados/  data=${payload}  headers=${headers}

    Should Be Equal As Strings  ${response.status_code}  201



