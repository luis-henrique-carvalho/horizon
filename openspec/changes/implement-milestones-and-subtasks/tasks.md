## 1. Modelos e Migrações

- [ ] 1.1 Gerar migração e modelo para `Milestone` (title:string, order:integer, goal:references)
- [ ] 1.2 Gerar migração e modelo para `Subtask` (title:string, completed:boolean, completed_at:datetime, milestone:references)
- [ ] 1.3 Configurar associações `has_many` e `accepts_nested_attributes_for` em `Goal` e `Milestone`
- [ ] 1.4 Adicionar validações de presença para `title` em ambos os modelos e `order` em `Milestone`

## 2. Testes (RSpec)

- [ ] 2.1 Criar testes unitários para `Milestone` (associações e validações)
- [ ] 2.2 Criar testes unitários para `Subtask` (associações, validações e lógica de `completed_at`)
- [ ] 2.3 Adicionar testes de sistema para a criação de Meta com Milestones e Subtasks

## 3. Controladores e Lógica

- [ ] 3.1 Atualizar `GoalsController#goal_params` para permitir atributos aninhados de milestones e subtasks
- [ ] 3.2 Implementar métodos de cálculo de progresso em `Milestone` (% com base em subtasks)
- [ ] 3.3 Implementar métodos de cálculo de progresso em `Goal` (% com base em milestones)

## 4. Frontend (DaisyUI + Stimulus)

- [ ] 4.1 Criar Stimulus Controller para gerir a adição/remoção dinâmica de milestones e subtasks no formulário
- [ ] 4.2 Atualizar `app/views/goals/_form.html.erb` com o design de `create.html` usando DaisyUI
- [ ] 4.3 Garantir que o formulário seja responsivo e suporte múltiplos níveis de aninhamento visualmente
- [ ] 4.4 Atualizar a view de `show` do Goal para exibir a estrutura de milestones e subtasks
