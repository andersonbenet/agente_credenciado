*** Settings ***
Resource  ../resource/ResourceGetTiposAgenteCredenciado.robot

*** Test Cases ***
TC: Contrato
  Validar contrato response tipos agentes credenciados

TC: Busca tipos agentes credenciados
  Validar busca tipos agentes credenciados

TC: Busca tipos agentes credenciados com filtro
  Validar busca tipos agentes credenciados com filtro
