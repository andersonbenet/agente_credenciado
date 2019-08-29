*** Settings ***
Resource  ../resource/ResourceFiltrosAgenteCredenciado.robot

*** Test Cases ***
TC: Validar busca agentes credenciados por agencia
  Buscar Info no banco de dados
  Buscar Agentes Credenciados

TC: Validar busca agentes credenciados por tipo
  Enviar request
