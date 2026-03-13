## Context

Atualmente, a visualização de um Goal em `goals#show` lista Milestones e Subtasks, mas de forma estática. Não é possível concluir tarefas sem editar o Goal completo. Além disso, a separação visual entre uma Milestone e as suas Subtasks é ténue, o que prejudica a experiência de gestão de progresso rápida.

## Goals / Non-Goals

**Goals:**
- Permitir a conclusão/reabertura de Subtasks diretamente na página `goals#show`.
- Reforçar a hierarquia visual entre Milestones e Subtasks.
- Atualizar indicadores de progresso (Milestone e Goal) em tempo real via Hotwire.

**Non-Goals:**
- Adição de novas Subtasks ou Milestones na página `show` (manter no `edit` por agora).
- Alteração da lógica de cálculo de progresso (manter a média simples definida no modelo).

## Decisions

- **Controlador para Subtasks**: Criação de `SubtasksController#update` para lidar com a atualização do estado `completed`.
- **Interatividade via Turbo Streams**: Ao clicar no checkbox da Subtask, um formulário será submetido e o servidor responderá com `turbo_stream` para atualizar apenas os elementos necessários no DOM (linha da subtask, barra de progresso da milestone, barra de progresso do goal).
- **Redesign com DaisyUI**:
    - **Milestones**: Utilização de cabeçalhos mais robustos com ícones específicos e talvez um fundo ligeiramente diferente.
    - **Subtasks**: Indentação visual (`pl-8`) e uso de um `checkbox` estilizado da DaisyUI.
    - **Estados Visuais**: Uso de transições suaves e estados de `disabled` enquanto o request está em voo.

## Risks / Trade-offs

- **[Risco]** N+1 queries ao atualizar múltiplos fragmentos via Turbo. → **[Mitigação]** Garantir uso de `includes` no controller ao carregar o Goal pai e as milestones.
- **[Trade-off]** Usar Turbo Streams em vez de Turbo Frames completos. Optamos por Streams para podermos atualizar múltiplos elementos espalhados na página (barra lateral de progresso global e lista central de milestones) num único request.
