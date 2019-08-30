*** Settings ***
Resource  ../resource/ResourceStatusAgenteCredenciado.robot

Documentation    Consulta status da API


*** Test Cases ***
TC: Validar Status GET service Agente Credenciado
  Enviar request
