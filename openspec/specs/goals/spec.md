# Capability: Goals (Motor de Metas)

Esta capacidade define a estrutura hierárquica e as regras de progresso do Projeto Horizon. O foco é a quebra de grandes objetivos em passos acionáveis, permitindo o rastreamento temporal necessário para projeções futuras (O Oráculo).

## 1. Estrutura Hierárquica (3 Níveis Fixos)

O sistema opera estritamente com três níveis de granularidade:

1.  **Goal (Meta Global):** O objetivo final de longo prazo.
2.  **Milestone (Meta Menor):** Fases lógicas ou marcos intermédios que compõem o Goal.
3.  **Subtask (Passo Acionável):** A unidade mínima de trabalho.

### Restrições de Relacionamento
- Um `Goal` possui muitas `Milestones`.
- Uma `Milestone` possui muitas `Subtasks`.
- Uma `Subtask` pertence obrigatoriamente a uma `Milestone`.
- Uma `Milestone` pertence obrigatoriamente a um `Goal`.

---

## 2. Atributos Críticos

### Goal (Meta Global)
- `title`: String (obrigatório).
- `description`: Text (opcional).
- `start_date`: Date (obrigatório, data em que o esforço começa).
- `target_date`: Date (obrigatório, prazo final desejado).
- `status`: Enum (`active`, `completed`, `on_hold`, `archived`).

### Milestone (Meta Menor)
- `title`: String (obrigatório).
- `order`: Integer (para ordenação visual das fases).

### Subtask (Passo Acionável)
- `title`: String (obrigatório).
- `completed`: Boolean (default: `false`).
- `completed_at`: DateTime (nulo até ser concluída; vital para o cálculo de Pace).

---

## 3. Regras de Progresso (Bottom-Up)

O progresso é calculado automaticamente de baixo para cima, com pesos iguais para simplificação inicial:

1.  **Progresso da Milestone:**
    *   `% Milestone = (Subtasks Concluídas / Total de Subtasks) * 100`.
    *   Se não houver subtasks, o progresso é 0%.
2.  **Progresso do Goal:**
    *   `% Goal = (Média Simples do Progresso de todas as Milestones)`.
    *   *Nota:* Um Goal só é considerado `completed` quando 100% das suas subtasks estiverem concluídas.

---

## 4. Regras de Negócio de Tempo (Input para o Oráculo)

- **Cálculo de Velocidade (Pace):** O sistema deve registar o `completed_at` exacto de cada subtask para determinar quantas tarefas o utilizador completa por unidade de tempo (dia/semana).
- **Projeção:** Se o ritmo de conclusão de subtasks indicar que a data final ultrapassará o `target_date` do `Goal`, o sistema deve sinalizar um alerta.

---

## 5. Estados de Transição

- **Ativação:** Um `Goal` torna-se `active` assim que a primeira `Subtask` é criada.
- **Conclusão:** Quando a última `Subtask` de um `Goal` é marcada como `completed`, o `Goal` e todas as suas `Milestones` transitam automaticamente para o estado `completed`.
