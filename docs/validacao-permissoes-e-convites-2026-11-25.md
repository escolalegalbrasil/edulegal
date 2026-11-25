# EduLegal — Validação de permissões e convites (laboratório)
Data: 2026-11-25. **Somente ambiente edulegal-testes**.

## Mudanças aplicadas no Supabase de testes
- `moderation_events`: diretor aprovado pode consultar alertas de sua organização; professor aprovado somente vê alertas ligados a uma mentoria de aluno associado em `teacher_students`.
- `teachers`: chave primária agora `(organization_id,id)`, permitindo associação do mesmo usuário a mais de uma escola sem confundir permissões.
- Revisada matriz de acesso: RLS ligado nas dez tabelas; nenhuma oferece `SELECT` ao papel `anon`; `trail_locks` sem permissão direta de `SELECT` para `authenticated`.
- `trail_locks` intencionalmente sem política: reservada ao backend, não ao navegador.

## Testes efetuados
- Auditoria de privilégios PostgreSQL (`has_table_privilege`): ausência de leitura anônima confirmada em todas as dez tabelas.
- `get_advisors`: sem aviso de RLS desativado; observação informativa para `trail_locks` sem policy, conforme esperado.
- SQL das policies instalado e aceito pelo PostgreSQL.

## Testes pendentes — usar apenas contas inventadas
1. Criar no **Supabase Auth do projeto de testes**, por procedimento administrativo adequado, identidades fictícias com nomes de teste: diretor-escola-A, professor-A, aluno-A, professor-B, aluno-B.
2. Criar duas organizações fictícias A e B; adicionar os vínculos e marcar `approved=true` pelo backend administrativo confiável.
3. Testar sessão de aluno A: pode ver sua trilha A e mensagens A, mas nenhum dado da escola B.
4. Testar professor A: pode ver somente seus alunos associados; não pode ver mensagens nem alertas de outros professores ou escolas.
5. Testar diretor A: pode ver alunos e alertas da escola A; não consegue ler escola B.
6. Testar usuário sem vínculo, usuário não aprovado e acesso anônimo: nenhum acesso aos dados escolares.
7. Testar tentativa de elevar privilégios, criar associação ou convidar professor diretamente via frontend: deve ser negada.
8. Testar alertas sem `trail_id`: apenas diretor da organização, não professor.
9. Não executar chamadas pagas à IA nos testes de autorização.

## Modelo de convites proposto
- **Não** permitir que a pessoa escolha seu próprio papel de professor/diretor.
- Diretor solicita convite, informando e-mail de outro adulto; backend verifica JWT, vínculo aprovado `director` e a organização.
- Backend envia convite Supabase Auth e cria vínculo **pendente**, com prazo e registro de auditoria.
- Após aceitação e validação, diretor aprova; o papel é concedido **somente no servidor**.
- Professor aprovado pode consultar apenas turmas/alunos atribuídos; diretor consulta toda sua escola.
- Convites e aprovações não estão implementados, apenas especificados.

## Restrições e próximos passos
- A página `testes/painel-acessos.html` ainda não foi publicada.
- Não há contas fictícias no projeto de testes; por isso, não afirmar que testes com usuários autenticados passaram.
- Nenhuma mudança foi aplicada ao Supabase `edulegal-mvp` nem à branch `main`.
- Backup completo recuperável do projeto oficial continua pendente.
- Atualização da EduLegal oficial exclusivamente após validação do diretor e autorização expressa.
