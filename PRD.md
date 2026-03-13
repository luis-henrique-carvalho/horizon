# PRD: Projeto Horizon (Nome Provisório)

## 1. Visão Geral do Produto
O Horizon é um aplicativo de gestão de conquistas e metas de médio a longo prazo. Diferente de um gerenciador de tarefas diárias (como o Todoist) ou um rastreador de hábitos simples, ele atua como um **"GPS de vida"**. Ele documenta objetivos maiores, quebra em passos acionáveis e usa dados de velocidade do usuário para projetar o futuro e gerar retrospectivas celebrativas.

## 2. O Problema
Usuários têm dificuldade em manter a consistência e a motivação em metas de longo prazo (como ler livros ou tirar certificações) porque falta visibilidade sobre o progresso acumulado e sobre como o esforço de hoje afeta os resultados de amanhã.

## 3. A Solução
Uma plataforma focada em três pilares:
1. **Estruturação:** Quebrar metas em subtasks com prazos.
2. **Celebração:** Retrospectivas de conquistas.
3. **Projeção Preditiva:** Mostrar onde o usuário vai chegar se mantiver o ritmo atual.

## 4. Funcionalidades Core (Épicos)

### Épico 1: Motor de Metas e Subtarefas
- **Criação de Objetivos SMART:** Definição de metas maiores com data de início e fim.
- **Desdobramento (Work Breakdown):** Capacidade de quebrar um objetivo em Metas Menores, e estas em Subtasks.
- **Progresso Visual:** Barras de progresso dinâmicas que se enchem à medida que as subtasks são marcadas como concluídas.

### Épico 2: O "Oráculo" (Projeção de Futuro)
*Esta é a funcionalidade diferencial do aplicativo.*
- **Cálculo de Ritmo (Pace):** O sistema analisa a velocidade de conclusão das subtasks.
- **Simulação Visual:** Gráficos mostrando *"Se você continuar nesse ritmo, sua meta de 2 certificações será concluída 2 meses antes do prazo"* ou *"Neste ritmo de leitura, você lerá 36 livros em um ano em vez de 12"*.
- **Alertas de Correção de Rota:** Avisos gentis quando o ritmo atual não for suficiente para alcançar a data de finalização estipulada.

### Épico 3: Cápsula de Conquistas (Retrospectivas)
- **Mural de Troféus:** Uma galeria visual documentando tudo o que já foi finalizado.
- **Retrospectiva Dinâmica (Mensal/Anual):** Geração automática de um resumo no estilo "Spotify Wrapped" (*"Neste mês, você focou em Tecnologia, completou 1 certificação e leu 800 páginas"*).
- **Diário de Bordo:** Espaço para o usuário escrever pequenos aprendizados ao finalizar uma meta grande.

## 5. Casos de Uso Principais
- **O Leitor Ávido:** O usuário define a meta de "Ler 3 livros em março". Ele divide os livros em capítulos (subtasks). O app calcula que, lendo 15 páginas por dia, ele baterá a meta. Ao fim do mês, ele recebe um card celebrando os títulos lidos.
- **O Profissional em Ascensão:** O usuário quer "Tirar 2 certificações AWS este ano". Ele cria a meta, adiciona os módulos de estudo como subtarefas e marca as datas das provas. O app projeta se o ritmo de estudo semanal está adequado para as datas dos exames.

## 6. Métricas de Sucesso (KPIs)
- **Taxa de Ativação:** Porcentagem de usuários que criam a primeira meta grande e adicionam pelo menos 3 subtasks.
- **Retenção de Longo Prazo (Day 30 / Day 90):** Crucial para um app de metas longas.
- **Taxa de Conclusão:** Quantidade de Metas Globais efetivamente marcadas como "Concluídas" dentro do prazo.
