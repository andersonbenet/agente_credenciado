*** Settings ***
Resource  ../resource/ResourcePostAgenteCredenciado.robot

*** Test Cases ***
TC: Validar add agente credenciado tipo veiculos - sucess
  Busca dados no db
  Validar add agente credenciado tipo veiculos

TC: Validar add agente credenciado tipo cdc - sucess
  Validar add agente credenciado tipo cdc

TC: Validar add agente credenciado tipo veiculos e cdc - sucess
  Validar add agente credenciado tipo veiculos e cdc

TC: Validar add agente credenciado sem reguistro na db
  Validar add agente credenciado sem reguistro na db

TC: Validar add agente credenciado com campo cpfCnpj não informado
  Validar add agente credenciado com campo cpfCnpj não informado

TC: Validar add agente credenciado com campo cpfCnpj inválido
  Validar add agente credenciado com campo cpfCnpj inválido

TC: Validar add agente credenciado com campo numAgencia não informado
  Validar add agente credenciado com campo numAgencia não informado

TC: Validar add agente credenciado com campo numAgencia inválido
  Validar add agente credenciado com campo numAgencia inválido