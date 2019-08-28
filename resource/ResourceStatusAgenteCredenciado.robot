*** Settings ***
Library  RequestsLibrary
Library  BuiltIn
Library  String
Library  Collections
Library  OperatingSystem

Documentation    Suite valida o status do service

*** Variables ***
${url}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net


*** Keywords ***
Enviar request GET agentesCredenciados
    Create Session      api    ${url}  disable_warnings=1
    ${response}=  GET Request  api  /actuator/health

    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${response.json()['status']}  UP






