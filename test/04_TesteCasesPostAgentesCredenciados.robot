*** Settings ***
Resource  ../resource/ResourcePostAgentesCredenciados.robot

*** Test Cases ***
TC: Validar Inserir Agente Credenciado Sucess
    Enviar request POST /agentesCredenciados
