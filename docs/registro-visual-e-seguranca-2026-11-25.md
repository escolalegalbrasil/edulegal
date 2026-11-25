# EduLegal — registro de testes e referência visual (25/11/2026)

## Referência visual recebida
- Fonte anexada pelo diretor: **EduLegal_Laboratorio_Visual(1).html**.
- Cópia **idêntica** confirmada no GitHub em `design/EduLegal_Laboratorio_Visual_referencia_2026-11-25.html`, branch `testes-seguranca-2026`.
- Guia de implementação futura em `design/README.md`.
- **Nenhuma alteração visual foi aplicada** ao site oficial ou ao painel de testes existente.

## Dados do laboratório
- Supabase **edulegal-testes** (`feijoegkjleirfzbumnk`), não a produção.
- Duas escolas fictícias, dois alunos fictícios, duas mentorias fictícias, duas mensagens fictícias e dois alertas fictícios.
- Script de fixture idempotente: `testes/fixtures/escolas-ficticias.sql`.
- Não foram importados dados reais dos alunos e não foram criadas contas Auth reais.

## Testes já realizados
- Estrutura de RLS: habilitada nas tabelas do laboratório.
- Privilégios de cliente anônimo: sem SELECT direto nas tabelas escolares.
- Teste **simulado** de identidade autenticada sem vínculo: 0 linhas visíveis nas nove tabelas consultadas (sem erro de recursão).
- Script reproduzível: `testes/rls/negacao-sem-vinculo.sql`.

## O que NÃO significa
- Esses testes **não** validam login real, cadastro, permissões positivas de diretor/professor/aluno nem isolamento efetivo com JWT real. Isso exige contas fictícias via Supabase Auth e testes funcionais.
- Ainda não existe site de testes publicado no GitHub Pages.
- Ainda não há backend de convites ou moderação automática implantado.
- Backup recuperável da produção segue pendente.

## Proteção da produção
- GitHub `main` e Supabase `edulegal-mvp` **sem modificações**.
- O diretor testará e validará visual e funcionalmente antes de qualquer publicação oficial.
