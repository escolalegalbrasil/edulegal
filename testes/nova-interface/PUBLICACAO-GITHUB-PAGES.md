# Publicação isolada — EduLegal de testes

## Pré-requisito: repositório novo, sem tocar na produção
O GitHub conectado atualmente permite criar/editar arquivos, mas **não oferece ação para criar um repositório novo**. O proprietário da conta criará manualmente um repositório público chamado `edulegal-testes` na conta `escolalegalbrasil` (https://github.com/new). Nunca usar o repositório oficial `edulegal` nem a branch `main` para esta publicação.

Depois, autorizar explicitamente o plugin GitHub do ChatGPT a acessar esse novo repositório, mantendo acesso mínimo necessário. Confirmar o acesso antes de enviar arquivos.

## Arquivos a publicar na raiz do novo repositório
Origem: `escolalegalbrasil/edulegal`, branch `testes-seguranca-2026`, pasta `testes/nova-interface/`.

| Origem | Destino |
|---|---|
| `testes/nova-interface/index.html` | `index.html` |
| `testes/nova-interface/styles.css` | `styles.css` |
| `testes/nova-interface/app.js` | `app.js` |
| `testes/nova-interface/painel-acessos.html` | `painel-acessos.html` |

Os caminhos relativos estão preparados para funcionar na raiz do novo repositório. O projeto conecta **exclusivamente** ao Supabase `edulegal-testes` (`feijoegkjleirfzbumnk`) usando **somente chave pública publishable**. Nenhuma credencial secreta pode ser publicada.

## Ativar GitHub Pages
No novo repositório: Settings > Pages > Build and deployment > Deploy from a branch > branch `main`, folder `/(root)` > Save.

URL esperada **somente após publicação efetiva**:
`https://escolalegalbrasil.github.io/edulegal-testes/`

Não afirmar que essa URL está pronta antes de confirmar publicação.

## Testes antes de convidar usuários
1. Abrir em navegação anônima e entrar em modo `Explorar a interface sem login`.
2. Conferir os temas escuro/claro, menu e layout responsivo.
3. Verificar que nenhum link leva à versão de produção.
4. Testar `painel-acessos.html` com conta fictícia devidamente provisionada.
5. Nenhum dado ou senha pessoal real no GitHub Pages.

**Regra**: a versão oficial permanece sem alterações até testes e autorização expressa do diretor.
