## Why

A capacidade de Goals (Motor de Metas) exige uma estrutura hierárquica de 3 níveis para permitir o rastreamento preciso do progresso e o cálculo de ritmo (Pace) para o Oráculo. Atualmente, apenas o modelo `Goal` existe, impedindo a decomposição de grandes objetivos em passos acionáveis.

## What Changes

- **Modelos de Dados**: Implementação dos modelos `Milestone` e `Subtask` com as associações e validações necessárias.
- **Migrações**: Criação das tabelas `milestones` e `subtasks`.
- **Interface de Criação/Edição**: Atualização do formulário de metas em `app/views/goals/new.html.erb` (e `_form.html.erb`) para permitir a adição dinâmica de Milestones e Subtasks, utilizando o design responsivo do DaisyUI baseado em `create.html`.
- **Lógica de Progresso**: Implementação da lógica de cálculo de progresso bottom-up (Subtask -> Milestone -> Goal).

## Capabilities

### New Capabilities
- `milestones`: Decomposição de objetivos em marcos intermédios com ordenação lógica.
- `subtasks`: Unidade mínima de trabalho com rastreamento de conclusão e data de finalização para análise de performance.

### Modified Capabilities
- `goals`: Atualização dos requisitos de progresso para dependerem das milestones e subtasks associadas.

## Impact

- **Banco de Dados**: Novas tabelas `milestones` e `subtasks`.
- **Modelos**: `Goal` terá `has_many :milestones`, `Milestone` terá `has_many :subtasks`.
- **Views**: `app/views/goals/_form.html.erb` será significativamente alterado para suportar formulários aninhados (nested forms).
- **Controllers**: `GoalsController` precisará aceitar `nested_attributes` para milestones e subtasks.
