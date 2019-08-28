*** Settings ***
Resource  ../resource/ResourceContratoAgenteCredenciado.robot

*** Test Cases ***
TC: Validar contrato GET agentesCredenciados
  Buscar Info no banco de dados
  Enviar request GET agentesCredenciados
