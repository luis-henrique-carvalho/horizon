# Diretrizes do Agente de IA (AI Context)

Este documento define as regras estritas de arquitetura, stack e fluxo de trabalho para este projeto. **Lê isto antes de gerares qualquer linha de código.**

## 1. Arquitetura e Stack
- **Framework:** Ruby on Rails (Monólito). Nada de APIs separadas ou SPAs a menos que explicitamente solicitado.
- **Frontend:** Importmaps (ou esbuild) + Tailwind CSS + **DaisyUI**.
- **Autenticação:** Devise.
- **Base de Dados:** PostgreSQL (ou SQLite, dependendo da configuração atual do projeto).
- **Testes:** RSpec, Capybara, FactoryBot.

## 2. Regras de Ouro (A Filosofia "Frank")
1. **Zero Adivinhação (YAGNI):** Implementa APENAS o que foi pedido na iteração atual. Não antecipes funcionalidades, não cries tabelas "por precaução" e não adiciones gems desnecessárias.
2. **Extreme Programming (TDD):** A regra é Red, Green, Refactor. Quando eu pedir uma feature, o teu PRIMEIRO output deve ser o teste de integração/modelo (RSpec) a falhar. Só escreves código de produção depois de eu validar o teste.
3. **Baby Steps:** Nunca vomites 200 linhas de código de uma vez. Foca-te em ciclos curtos. Um model, o seu teste. Um controller, o seu teste. Uma view.
4. **Respostas Concisas:** Sem palha. Retorna apenas os blocos de código modificados com marcações claras de onde entram. Não me expliques o que é o Rails.

## 3. Diretrizes de Frontend (DaisyUI + Tailwind)
- **Usa a Semântica do DaisyUI:** Proibido usar "utility soup" (dezenas de classes do Tailwind num só elemento) quando o DaisyUI já tem um componente para isso.
  - **CERTO:** `<button class="btn btn-primary">Salvar</button>`
  - **ERRADO:** `<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Salvar</button>`
- **Views do Devise:** Sempre que for preciso alterar o login/registo, gera as views do Devise (`rails g devise:views`) e refatora-as imediatamente para usar a estrutura de forms do DaisyUI (ex: `form-control`, `input input-bordered`).

## 4. Segurança e Autenticação (Devise)
- Bloqueia tudo por defeito. Usa `before_action :authenticate_user!` no `ApplicationController` e abre exceções apenas onde necessário (`skip_before_action`).
- Não inventes rotas mágicas para utilizadores. Fica dentro do padrão REST e da arquitetura standard do Devise.
- Usa `Pundit` se o requisito envolver autorização baseada em papéis (roles), não faças ifs espalhados pelas views.

## 5. Boas Práticas de Código (Rails Way)
- **N+1 Queries:** Ao gerar código de controllers que chamam associações, usa SEMPRE `includes` ou `strict_loading` por defeito para evitar N+1 no banco de dados.
- **Lógica de Negócio:** Controllers devem ter no máximo 1-2 linhas por action. Se a lógica envolver mais do que um simples `save` ou `update`, extrai para um Service Object em `app/services/`.
- **Background Jobs:** Tudo o que enviar emails, processar ficheiros ou comunicar com APIs externas DEVE ser atirado para o ActiveJob (com Sidekiq ou Solid Queue). Nunca bloqueies o request-response cycle.

## 6. Comandos Úteis
- Executar todos os testes: `bundle exec rspec`
- Executar linting: `bundle exec rubocop -A` (assume que tens o RuboCop configurado)
