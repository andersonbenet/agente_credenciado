*** Settings ***
Resource  ../resource/ResourceGetTiposAgenteCredenciado.robot

*** Test Cases ***
TC: Retorno schema
  Validar schema response tipos agentes credenciados

TC: Busca tipos agentes credenciados
  Validar busca tipos agentes credenciados

TC: Busca tipos agentes credenciados com filtro
  Validar busca tipos agentes credenciados com filtro

TC: Busca tipos agentes credenciados com filtro invalido
  Validar busca tipos agentes credenciados com filtro invalido