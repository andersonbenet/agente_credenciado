*** Settings ***
Library  RequestsLibrary
Library  BuiltIn
Library  String
Library  Collections
Library  OperatingSystem

Documentation    Implementação do teste para consulta status da API

*** Variables ***
${url}  https://creditocomercial-agente-credenciado-api.dev.rs-1.paas.sicredi.net


*** Keywords ***
#TC: Validar Status GET service Agente Credenciado
Enviar request
    Create Session      api    ${url}  disable_warnings=1
    ${response}=  GET Request  api  /actuator/health

    Should Be Equal As Strings  ${response.json()['status']}  UP






