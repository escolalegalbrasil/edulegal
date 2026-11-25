# EduLegal — Situação do ambiente de testes (25/11/2026)

## Separação confirmada
- Produção **não modificada**: GitHub `main` e Supabase `edulegal-mvp` (projeto `xhasvagsodoctsqbfwkw`).
- Desenvolvimento: GitHub `testes-seguranca-2026`; Supabase `edulegal-testes` (projeto `feijoegkjleirfzbumnk`, região `sa-east-1`).
- Custo cotado para o segundo projeto Supabase: US$ 0/mês, dentro dos limites do plano Free.
- **O banco de testes não é uma cópia fiel do oficial**. É um esquema inicial de segurança para testar um modelo novo. As diferenças precisam ser migradas e testadas antes de qualquer integração.
- Nenhum arquivo oficial, função ou configuração do Supabase de produção foi alterado.

## Estrutura criada somente no Supabase de testes
- `organizations`
- `profiles`
- `organization_members`
- `students` (sem coluna PIN; com referência opcional a `auth.users`)
- `teachers`
- `trails`
- `messages`
- `trail_locks`
- `moderation_events`

Todas as nove tabelas tiveram RLS habilitado. `anon` não recebeu acesso às tabelas; `authenticated` possui somente `SELECT` em `profiles`, com política de leitura do próprio registro. As demais tabelas estão propositalmente fechadas (sem policies): **o aplicativo ainda não funciona contra o banco de testes**.

Há um registro institucional fictício da Escola Legal; nenhuma conta de aluno ou dados de produção foram importados.

## Alertas já identificados em produção (somente leitura)
1. `students`, `teachers` e `trail_locks` sem RLS; permissões diretas extensas de `anon` e `authenticated`.
2. Login consulta `students?select=*` e armazena registro completo no navegador, podendo incluir PIN.
3. `generate-trail` (Edge Function) é publicada com `verify_jwt=false` e não valida a identidade nem a autorização de professor antes de criar mentorias usando a chave privilegiada.
4. Os papéis administrativos em `profiles` devem ser revisados para impedir elevação de privilégios.
5. `edulegal-cha` valida `supabase.auth.getUser(token)` e compara `trail.student_id` com `user.id`; modelo de identidade precisa ser auditado antes da migração.
6. Não há integração de moderação automática na função principal de chat atual.

## Próximas tarefas
1. Backup real recuperável: exportar banco de produção usando Supabase CLI, verificar restauro; guardar fora de repositórios públicos, incluir Edge Functions e Storage separadamente. **Ainda não feito**.
2. Validar a relação entre `auth.users.id`, `students.id`, `trails.student_id`, `messages.user_id` e a autenticação do professor.
3. Criar contas fictícias no banco de testes; preparar grants e policies por organização/papel.
4. Preparar API de login e funções protegidas no ambiente de testes.
5. Configurar frontend de testes em site separado, com chaves publicáveis do projeto de testes; não publicar credenciais secretas.
6. Testar fluxos funcionais, isolamento de escola e aluno, moderação, falhas de rede e falso positivo.
7. Entregar à validação do diretor; **não publicar na branch main ou no Supabase oficial sem autorização expressa**.

## Observações
- Avisos do advisor de tabelas com RLS sem policies são esperados neste protótipo fechado; os testes funcionais exigirão policies de acesso específicas.
- Projeto GitHub `edulegal-testes` separado (repositório e GitHub Pages) ainda não existe; a branch de testes foi criada como espaço inicial de desenvolvimento.
- Este documento não é um backup do banco de dados.
