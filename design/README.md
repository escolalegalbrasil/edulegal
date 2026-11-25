# Referência visual EduLegal — recebida em 25/11/2026

## Fonte aprovada para testes futuros
- Arquivo original: `design/EduLegal_Laboratorio_Visual_referencia_2026-11-25.html`.
- O HTML de referência foi preservado **sem alterar seu conteúdo**, na branch `testes-seguranca-2026`.
- **Não publicar na branch `main`** sem validação expressa do diretor.
- A referência é um **laboratório visual** (edição de cores). Não é ainda um editor de programação nem uma tela de login funcional.

## Características que deverão ser mantidas
1. Identidade: logotipo textual **eduLegal.**, interface enxuta, foco em aprendizagem.
2. Navegação lateral: **Início**, **Meus livros**, **Projetos**, **Mentoria**, **Portfólio**.
3. Tela inicial: título **O que vamos criar hoje?**, atividade **Continue de onde parou**, barra de progresso, explorações Roblox Studio / Robótica / Desenvolvimento Web / Escrita criativa e sugestão de novo projeto.
4. Temas independentes **Escuro** e **Claro**, com paletas editáveis e cores nomeadas via CSS custom properties.
5. Layout responsivo e versões compactas.
6. Possibilidade de exportação de CSS/JSON das paletas e importação das paletas.
7. O laboratório visual guarda alterações em `localStorage` com chave `edulegal-design-lab-v1`, apenas para a própria demonstração.

## Integração planejada — quando backend e testes de acesso estiverem prontos
- Implementar componentes reais com esta identidade visual; não copiar a interface como aplicativo funcional sem adaptação.
- Substituir os elementos estáticos por dados autorizados do **Supabase de testes**.
- Manter a navegação funcional conforme o perfil e aplicar as mesmas regras de acesso no backend (nunca confiar apenas no menu da tela).
- Implementar telas específicas de **Diretor** e **Professor** com a mesma identidade visual, mas permissões próprias.
- Proteger dados de alunos (incluindo as conversas e alertas); nunca exibir ou embutir chaves privadas no frontend.
- Integrar os livros interativos e **editor de código** posteriormente. O editor de cores deste arquivo não é o editor de código.
- Disponibilizar versão isolada para testes e refinamento visual do diretor antes de autorizar qualquer publicação oficial.

## Regra de publicação
A interface oficial no GitHub `main` e o Supabase de produção `edulegal-mvp` continuam intactos. O diretor testará e validará explicitamente a versão isolada antes de qualquer atualização oficial.
