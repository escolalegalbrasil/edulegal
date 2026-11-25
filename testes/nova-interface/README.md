# EduLegal — nova interface (prévia técnica)

Este diretório contém a **primeira implementação navegável do novo design**, não uma mudança do site oficial.
Referência exata: `../../design/EduLegal_Laboratorio_Visual_referencia_2026-11-25.html`.

## Páginas e arquivos
- `index.html`: estrutura da nova interface com tela de acesso e navegação.
- `styles.css`: CSS construído a partir do arquivo visual fornecido pelo diretor; tema claro/escuro e responsividade.
- `app.js`: modo de demonstração, navegação e acesso de leitura ao Supabase **edulegal-testes**.

## O que já funciona
1. Prévia visual **sem login**, com dados fictícios claramente identificados.
2. Alternância **Escuro/Claro**, com paletas originais do arquivo recebido.
3. Navegação **Início / Meus livros / Projetos / Mentoria / Portfólio**.
4. Login Supabase Auth **somente no projeto de testes**.
5. Leitura de vínculos aprovados `organization_members`, organização corrente e títulos de mentorias autorizadas.
6. Quando há um diretor/professor autenticado, um item provisório **Painel da escola** aparece e oferece acesso ao verificador de permissões.
7. Sem gravações nas tabelas por esta interface. O conteúdo das conversas não é carregado.

## O que ainda NÃO funciona
- Cadastro de contas fictícias e aprovação do diretor/professores (administrativo ainda por implementar).
- Catálogo completo de livros: **nenhum livro real foi importado**; é necessário conferir arquivos e versões finais.
- Editor de programação, projetos/kanban, portfólios, progresso real e leitura de mensagens.
- Moderação automática, alertas ao diretor e convite de professores.
- Hospedagem de teste em GitHub Pages (o arquivo está somente na branch de desenvolvimento, ainda não publicado).
- Teste de ponta a ponta com contas reais de teste.
- Backup completo recuperável do Supabase de produção.

## Regras de segurança e publicação
- URLs/chaves deste diretório pertencem unicamente ao projeto Supabase **edulegal-testes**, usando apenas **publishable key**.
- Nunca inserir chaves secret/service_role no frontend ou em repositório público.
- Testar com dados fictícios, sem contas ou dados pessoais dos alunos.
- `main` e `edulegal-mvp` permanecem intocados até avaliação e autorização explícita do diretor.
- Os textos de demo, incluindo progresso de 45% e "Minha primeira loja no Roblox", são **ilustrativos** e não representam dados recuperados do banco.

## Origem das decisões de produto
- Navegação de cinco áreas no ambiente do aluno.
- Projetos privados por padrão, associados a tarefas, arquivos, livros e mentorias.
- Temas Claro e Escuro, estética limpa, cores configuráveis, sem roxo.
- Diretor e professores autorizados somente aos alunos vinculados à própria escola.
- Nova interface substituirá a antiga **apenas quando aprovada**.

**Nota sobre a conversa "Reunir livros interativos":** as principais decisões de interface foram recuperadas, mas o inventário completo de arquivos e títulos da conversa ainda precisa ser conferido para importar os livros, sem criar entradas presumidas.
