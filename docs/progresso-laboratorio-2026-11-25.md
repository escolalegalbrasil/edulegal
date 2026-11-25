# EduLegal — progresso do laboratório (25/11/2026)

## Ambientes
- Produção: GitHub `main`; Supabase `edulegal-mvp`. Nenhuma atualização executada.
- Testes: branch `testes-seguranca-2026`, Supabase `edulegal-testes` (`feijoegkjleirfzbumnk`).
- Custo cotado do projeto novo: US$ 0/mês dentro da cota Free.

## Concluído em TESTES
1. Modelo multi-escola criado com `organizations`, `organization_members` (`director`, `teacher`, `student`), `students`, `teachers`, `teacher_students`, `trails`, `messages`, `moderation_events`, `profiles`, `trail_locks`.
2. Restrições de chave estrangeira para vincular estudantes, trilhas e moderação à organização correta.
3. RLS habilitado em todas as tabelas; nenhuma permissão direta anônima sobre tabelas escolares.
4. Leitura permitida somente para usuários autenticados e no escopo das respectivas políticas.
5. `trail_locks` bloqueada para acesso direto do cliente (nenhuma policy deliberadamente).
6. Apenas `profiles` permite leitura do próprio registro; nenhuma alteração de papel ou associação por cliente.
7. Adicionada página **somente leitura** `testes/painel-acessos.html` no GitHub de desenvolvimento, conectada apenas ao banco de testes. Ela permite login de conta fictícia e mede quais registros estão acessíveis, sem mostrar conteúdo de mensagens.

## Ainda NÃO concluído
- Contas fictícias Supabase Auth e atribuições de papéis aprovados.
- Testes autenticados positivos e negativos entre escolas.
- Repositório GitHub Pages `edulegal-testes` publicado (a página de laboratório está apenas na branch, não publicada).
- Backend protegido para convidar professores, criar mentorias, gerar IA e registrar moderação.
- Backup completo recuperável do projeto de produção; não confundir exportação de estrutura com backup.
- Migração da versão antiga do aplicativo para a nova estrutura.
- Revisão de privacidade, retenção e alertas de moderação.
- Validação do diretor e autorização para atualização de produção.

## Atenção
Uma política RLS na tabela `trail_locks` não é necessária enquanto o lock for manipulado exclusivamente por uma Edge Function que valide a identidade e use operações privilegiadas. O aviso informativo de ausência de policy nessa tabela é intencional.

## Regra de publicação
**NÃO ALTERAR** a branch `main` nem o Supabase `edulegal-mvp` até o diretor realizar seus testes e autorizar expressamente.
