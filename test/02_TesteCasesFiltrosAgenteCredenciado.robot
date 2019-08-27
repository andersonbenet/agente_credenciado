*** Settings ***
Resource  ../resource/ResourceFiltrosAgenteCredenciado.robot

*** Test Cases ***
TC: Validar busca agentes credenciados por gencia
  Buscar Info no banco de dados
  Buscar Agentes Credenciados
