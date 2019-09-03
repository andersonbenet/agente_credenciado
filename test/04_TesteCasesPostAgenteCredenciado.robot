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

TC: Validar add agente credenciado com campo oidPessoa não informado
  Validar add agente credenciado com campo oidPessoa não informado

TC: Validar add agente credenciado com campo oidPessoa inválido
  Validar add agente credenciado com campo oidPessoa inválido

TC: Validar add agente credenciado com campo situacao não informado
  Validar add agente credenciado com campo situacao não informado

TC: Validar add agente credenciado com campo situacao inválido
  Validar add agente credenciado com campo situacao inválido

TC: Validar add agente credenciado com campo tiposAgente não informado
  Validar add agente credenciado com campo tiposAgente não informado

TC: Validar add agente credenciado com campo tiposAgente inválido
  Validar add agente credenciado com campo tiposAgente inválido