## 1. Infraestrutura e Roteamento

- [x] 1.1 Adicionar rota `resources :subtasks, only: [:update]` em `config/routes.rb`
- [x] 1.2 Criar `app/controllers/subtasks_controller.rb` com esqueleto da action `update`

## 2. Testes e Lógica de Negócio

- [x] 2.1 Criar teste de sistema (RSpec/Capybara) para validar a conclusão de uma subtask na página do Goal
- [x] 2.2 Implementar lógica de atualização em `SubtasksController#update` permitindo apenas alteração do campo `completed`
- [x] 2.3 Garantir que a resposta do controller suporta o formato Turbo Stream

## 3. Refatoração da View e Hierarquia Visual

- [x] 3.1 Extrair Milestone e Subtask para partials em `app/views/goals/` para facilitar updates parciais
- [x] 3.2 Aplicar novo design de hierarquia visual em `app/views/goals/show.html.erb` usando DaisyUI
- [x] 3.3 Substituir ícones estáticos por `checkbox` da DaisyUI envolvidos num formulário `patch` remoto

## 4. Reatividade com Turbo Streams

- [x] 4.1 Implementar `update.turbo_stream.erb` para atualizar a linha da subtask
- [x] 4.2 Adicionar comandos Turbo Stream para atualizar a barra de progresso da Milestone correspondente
- [x] 4.3 Adicionar comandos Turbo Stream para atualizar a barra de progresso global e status do Goal
