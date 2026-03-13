## Why

O sistema necessita de uma funcionalidade para os utilizadores gerirem e acompanharem os seus objetivos estratégicos, permitindo uma visualização clara do status, progresso, categorias e prazos. Esta funcionalidade implementa a interface "Gerenciamento de Objetivos", proporcionando clareza e organização estratégica.

## What Changes

- Criação do modelo `Goal` com título, descrição, categoria, status, progresso (0-100) e prazo (deadline).
- Associação do modelo `Goal` ao `User` (autenticação via Devise).
- Implementação das rotas, controllers e views para o CRUD de `Goal`.
- Construção da UI utilizando Tailwind CSS e componentes DaisyUI (conforme o design da Stitch), incluindo a listagem de cards, criação, edição e deleção de objetivos.

## Capabilities

### New Capabilities
- `goal-management`: Funcionalidade de CRUD para gestão de objetivos estratégicos, listagem em formato de cards com indicadores de progresso e estado.

### Modified Capabilities


## Impact

- Criação de nova tabela `goals` na base de dados.
- Adição de rotas RESTful para `goals`.
- Novos controllers e views (`app/controllers/goals_controller.rb`, `app/views/goals/*`).
- Testes unitários e de integração utilizando RSpec e FactoryBot.
