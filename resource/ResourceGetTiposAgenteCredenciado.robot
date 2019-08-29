*** Settings ***
Library  RequestsLibrary
Library  BuiltIn
Library  Collections
Library  OperatingSystem
Library  JSONSchemaLibrary  C:\\Users\\anderson_benet\\Documents\\git_robotframework\\agente_credenciado\\schemas



*** Variables ***
${base_uri}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net:443/v1
${base_path}  /tiposAgenteCredenciado/

&{headers}
    ...   Content-Type=application/json

*** Keywords ***
#TC: Contrato
Validar contrato response tipos agentes credenciados
  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  GET Request  api  ${base_path}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  200
  Validate Json  get_tipos_agente_credenciado.json  ${response.json()}


#TC: Busca tipos agentes credenciados
Validar busca tipos agentes credenciados
  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  GET Request  api  ${base_path}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  200

#TC: Busca tipos agentes credenciados com filtro
Validar busca tipos agentes credenciados com filtro
  ${id}  Set Variable   1

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  GET Request  api  ${base_path}/${id}/  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  200
