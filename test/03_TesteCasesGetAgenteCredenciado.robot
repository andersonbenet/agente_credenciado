*** Settings ***
Resource  ../resource/ResourceGetAgenteCredenciado.robot

*** Test Cases ***
TC: Validar busca agentes credenciados por agencia
  Buscar info no banco de dados
  Buscar buscar agentes credenciados por agencia

TC: Validar busca agentes credenciados por agencia e tipo
  Buscar buscar agentes credenciados por agencia e tipo

TC: Validar busca agentes credenciados por agencia invalida
  Busca agentes credenciados por agencia invalida

TC: Validar busca agentes credenciados por tipo invalido
  Busca agentes credenciados por tipo invalido