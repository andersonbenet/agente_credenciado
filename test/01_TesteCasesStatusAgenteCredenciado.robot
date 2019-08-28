*** Settings ***
Resource  ../resource/ResourceStatusAgenteCredenciado.robot

*** Test Cases ***
TC: Validar status GET agentesCredenciados
  Enviar request GET agentesCredenciados
