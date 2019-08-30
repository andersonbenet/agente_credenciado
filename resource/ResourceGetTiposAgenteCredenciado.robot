*** Settings ***
Library  RequestsLibrary
Library  BuiltIn
Library  Collections
Library  String
Library  DatabaseLibrary
Library  OperatingSystem
Library  JSONSchemaLibrary  C:\\Users\\anderson_benet\\Documents\\git_robotframework\\agente_credenciado\\schemas



*** Variables ***
${base_uri}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net:443/v1
${base_path}  /tiposAgenteCredenciado/

&{headers}
    ...   Content-Type=application/json


#Info banco de dados
${user}=  developer
${password}=  developer
${string_conexao}=  '${user}/${password}@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=dtb1admindb010d.des.sicredi.net)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=creditocomercialpdb)(SERVER=DEDICATED)))'

#query
${query}=  SELECT *
     ...   FROM AGENTECREDENCIADO_OWNER.TIPO_AGENTE_CREDENCIADO



*** Keywords ***
#TC: Contrato
Validar schema response tipos agentes credenciados
  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  GET Request  api  ${base_path}  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  200

  Validate Json  get_tipos_agente_credenciado.json  ${response.json()}


#TC: Busca tipos agentes credenciados
Validar busca tipos agentes credenciados
  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  GET Request  api  ${base_path}  headers=${headers}
  ${tam}  Get Length  ${response.json()}

  FOR  ${i}  IN  @{response.json()}
    ${id}  Get Variable Value  ${i['id']}
    ${id}  Get Variable Value  ${i['descricao']}
  END

  Should Be Equal As Strings  ${response.status_code}  200

#TC: Busca tipos agentes credenciados com filtro
Validar busca tipos agentes credenciados com filtro
  Connect To Database Using Custom Params  cx_Oracle  ${string_conexao}
  @{queryResults}=  Query  ${query}
  ${id}=  Set Variable  ${queryResults[0][0]}

  Create Session      api    ${base_uri}  disable_warnings=1
  ${response}=  GET Request  api  ${base_path}/${id}/  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  200

#TC: Busca tipos agentes credenciados com filtro invalido
Validar busca tipos agentes credenciados com filtro invalido
  Create Session      api    ${base_uri}  disable_warnings=1
  ${id}=  Set Variable  0
  ${response}=  GET Request  api  ${base_path}/${id}/  headers=${headers}

  Should Be Equal As Strings  ${response.status_code}  204