## Why

A página de visualização de metas (Goals) atual apresenta dificuldades na gestão de progresso, pois não permite concluir tarefas (Subtasks) diretamente, obrigando o utilizador a navegar para outras páginas. Além disso, a lista de Milestones e Subtasks carece de uma hierarquia visual clara, tornando difícil distinguir entre fases (Milestones) e passos acionáveis (Subtasks).

## What Changes

- **Conclusão Interativa de Tarefas**: Adição de checkboxes ou botões na vista de Goal para permitir marcar Subtasks como concluídas/pendentes sem recarregar a página (via Hotwire/Turbo).
- **Refatoração da Hierarquia Visual**: Novo design para a lista de Milestones e Subtasks usando DaisyUI, com indentação clara, estilos diferenciados para Milestones (headers) e Subtasks (itens de lista), e indicadores visuais de progresso/estado.
- **Feedback em Tempo Real**: Atualização automática da barra de progresso do Goal e da Milestone ao concluir uma Subtask na mesma página.

## Capabilities

### New Capabilities
- Nenhuma.

### Modified Capabilities
- `goals`: Adição do requisito de interatividade na visualização para conclusão de subtasks e exigência de hierarquia visual explícita entre os níveis Milestone e Subtask.

## Impact

- `app/views/goals/show.html.erb`: Redesign completo da listagem de milestones/tasks.
- `app/controllers/subtasks_controller.rb` (ou similar): Adição/ajuste de endpoint para atualização de estado via Turbo.
- `app/models/subtask.rb`: Garantir que callbacks de progresso funcionam conforme esperado para atualizações em tempo real.
