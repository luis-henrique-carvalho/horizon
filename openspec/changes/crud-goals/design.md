## Context

A aplicação necessita de um sistema para gestão de objetivos estratégicos (Goal Management). A interface aprovada (via design do Stitch) exibe um dashboard rico com cartões de objetivos que incluem título, categoria, status de progresso, percentagem, data limite e responsáveis. 

## Goals / Non-Goals

**Goals:**
- Construir o modelo de dados `Goal` associado de forma segura ao utilizador autenticado (`User`).
- Fornecer operações CRUD padrão seguindo as convenções do Rails (REST).
- Implementar as views do Devise utilizando o DaisyUI para preservar a estética limpa do projeto, garantindo uma resposta visual premium, reativa e alinhada com as cores `primary` (`#1183d4`) e os temas light/dark desenhados.
- Prevenir N+1 queries ao aceder as informações dependentes na listagem.

**Non-Goals:**
- Cálculo automatizado do progresso via "Tarefas/Tasks" ou "Sub-objetivos": Nesta iteração (segundo o princípio YAGNI), o progresso (`progress` 0-100) será um campo numérico simples manipulado pelo utilizador.
- Gestão complexa multi-inquilino de perfis e permissões granulares: O `Goal` estará estritamente associado ao utilizador criador.

## Decisions

- **Modelação de Dados:** 
  O modelo `Goal` terá os campos: 
  - `title` (string, required)
  - `description` (text)
  - `category` (integer enum)
  - `status` (integer enum)
  - `progress` (integer default 0)
  - `deadline` (date)
  - `user_id` (references).
- **Uso de Enums:** Para simplificar e acelerar o desenvolvimento, a `category` (Marketing, Product, Sales, Security, etc.) e o `status` (On Track, Behind, Completed, At Risk) serão armazenados como `enum` do ActiveRecord. Isso elimina a necessidade de tabelas satélites desnecessárias para a primeira iteração.
- **Autorização Simples:** Ao invés de usar gemas complexas nesta fase, o controller filtrará os registos pelo `current_user.goals` para garantir segurança nos métodos `index`, `show`, `edit`, `update` e `destroy`.

## Risks / Trade-offs

- **[Risco] Enums hardcoded para Categories:** Em caso de o negócio desejar categorias 100% dinâmicas criadas pelo utilizador, o uso do `enum` no Rails exigirá um refactor futuramente.
  - *Mitigação:* Tendo em conta o escopo da tarefa inicial baseada no Sticth UI ("Marketing", "Product", etc.), o uso de enums atende as necessidades atuais sem complicar a base de código, respeitando a diretriz "Extreme Programming & YAGNI".
