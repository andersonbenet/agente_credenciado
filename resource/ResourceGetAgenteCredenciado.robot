*** Settings ***
Library  RequestsLibrary
Library  DatabaseLibrary
Library  BuiltIn
Library  String
Library  Collections
Library  OperatingSystem
Library  JSONSchemaLibrary  C:\\Users\\anderson_benet\\Documents\\git_robotframework\\demo_rest_schema\\schemas

Documentation    Suite description

*** Variables ***
${base_uri}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net:443/v1
${base_path}  /agentesCredenciados/

#Info banco de dados
${user}=  developer
${password}=  developer
${string_conexao}=  '${user}/${password}@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=dtb1admindb010d.des.sicredi.net)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=creditocomercialpdb)(SERVER=DEDICATED)))'

#query
${query}  SELECT *
    ...  FROM AGENTECREDENCIADO_OWNER.AGN_CREDENCIADO_TIPO_AGENTE T,
    ...  AGENTECREDENCIADO_OWNER.AGENTE_CREDENCIADO A,
    ...  AGENTECREDENCIADO_OWNER.TIPO_AGENTE_CREDENCIADO TA
    ...  WHERE T.OID_AGENTE_CREDENCIADO = A.OID_AGENTE_CREDENCIADO
    ...  AND  TA.OID_TIPO_AGENTE_CREDENCIADO = T.OID_TIPO_AGENTE_CREDENCIADO
    ...  AND ROWNUM <= 1


*** Keywords ***
#TC: Validar busca agentes credenciados por agencia
Buscar Info no banco de dados
  Connect To Database Using Custom Params  cx_Oracle  ${string_conexao}
  @{queryResults}=  Query  ${query}
  ${agencia}  Set Variable  ${queryResults[0][3]}
  ${tipo}  Set Variable  ${queryResults[0][10]}

  Log Many  @{queryResults}

  Set Global Variable  ${agencia}
  Set Global Variable  ${tipo}
  disconnect from database

Buscar Agentes Credenciados
  Create Session      api    ${base_uri}  disable_warnings=1
  &{params}=  Create Dictionary  agencia=${agencia}  tipo=${tipo}
  ${response}=  GET Request  api  ${base_path}  params=${params}

  Should Be Equal As Strings  ${response.status_code}  200
  Dictionary Should Contain Value  ${response.json()[0]}  ${response.json()[0]['nomePessoa']}


#TC: Validar busca agentes credenciados por tipo
Enviar request
  Create Session      api    ${base_uri}  disable_warnings=1



