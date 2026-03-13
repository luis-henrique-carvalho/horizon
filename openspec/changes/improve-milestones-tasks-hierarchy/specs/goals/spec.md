## ADDED Requirements

### Requirement: Conclusão Interativa de Subtasks
O sistema DEVE permitir que os utilizadores marquem Subtasks como concluídas ou pendentes diretamente na página de visualização do Goal, sem necessidade de recarregar a página completa.

#### Scenario: Utilizador altera estado de uma subtask
- **WHEN** o utilizador clica na checkbox ou botão de conclusão de uma Subtask na vista do Goal
- **THEN** o sistema atualiza os atributos `completed` e `completed_at` da Subtask via Turbo/Hotwire
- **AND** o sistema atualiza as barras de progresso da Milestone e do Goal na mesma página de forma assíncrona

### Requirement: Hierarquia Visual para Milestones e Subtasks
O sistema DEVE apresentar a lista de Milestones e Subtasks com uma hierarquia visual clara que permita distinguir facilmente os dois níveis de granularidade.

#### Scenario: Visualização da hierarquia na página do Goal
- **WHEN** o utilizador visualiza um Goal
- **THEN** as Milestones são apresentadas como cabeçalhos ou secções destacadas (ex: cards ou dividers)
- **AND** as Subtasks são apresentadas como itens de lista indentados sob a sua Milestone correspondente
- **AND** cada nível utiliza elementos visuais distintos (tamanhos de fonte, ícones ou cores) para reforçar a hierarquia
