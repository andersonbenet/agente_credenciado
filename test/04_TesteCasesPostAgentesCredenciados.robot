*** Settings ***
Resource  ResourcePostAgenteCredenciado.robot

*** Test Cases ***
TC: Validar Inserir Agente Credenciado Sucess
    Enviar request POST /agentesCredenciados
