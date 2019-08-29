*** Settings ***
Resource  ../resource/ResourceStatusAgenteCredenciado.robot

Documentation    Test case consulta status da API


*** Test Cases ***
TC: Validar Status GET service Agente Credenciado
  Enviar request
