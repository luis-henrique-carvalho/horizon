## Context

Atualmente, o sistema possui apenas o modelo `Goal`. Para cumprir a especificação de 3 níveis fixos (Goal -> Milestone -> Subtask), é necessário expandir o esquema de dados e a interface de utilizador. O utilizador forneceu um design (`create.html`) que utiliza DaisyUI e Tailwind CSS, o qual servirá de base para a nova interface.

## Goals / Non-Goals

**Goals:**
- Implementar modelos `Milestone` e `Subtask` com associações corretas.
- Criar formulário aninhado em `app/views/goals/new.html.erb` para criação simultânea de Goal, Milestones e Subtasks.
- Garantir que a interface seja responsiva e siga o design de `create.html`.
- Implementar lógica de progresso bottom-up (percentagem calculada de Subtasks para Milestones e de Milestones para Goal).

**Non-Goals:**
- Implementar a lógica complexa do "Oráculo" (apenas fornecer os dados necessários).
- Criar uma API separada (manter no monólito Rails).

## Decisions

- **Nested Attributes**: Usar `accepts_nested_attributes_for` nos modelos `Goal` e `Milestone`. Isto simplifica a criação hierárquica num único POST request.
- **Stimulus.js para Dinamismo**: Utilizar controladores Stimulus para adicionar/remover campos de Milestones e Subtasks dinamicamente no formulário sem recarregar a página.
- **DaisyUI Integration**:
  - Usar `checkbox checkbox-primary` para as subtasks.
  - Usar `input input-bordered` para títulos.
  - Usar `card` ou `collapse` para agrupar Subtasks dentro de Milestones, mantendo a limpeza visual.
- **Progresso Automático**: Definir métodos nos modelos (ou callbacks) para atualizar o progresso. Como o progresso do Goal é a média das Milestones, e a Milestone é a média das Subtasks, usaremos métodos de instância para cálculo on-the-fly inicialmente para evitar redundância de dados.

## Risks / Trade-offs

- **Complexidade do Formulário**: Formulários aninhados em Rails podem tornar-se complexos.
  - *Mitigação*: Usar a gem `cocoon` (se compatível com importmaps) ou um componente Stimulus simples para gerir o DOM.
- **Performance de N+1**: Ao calcular progresso on-the-fly para listas de metas.
  - *Mitigação*: Usar `includes([milestones: :subtasks])` nas queries do controller.
