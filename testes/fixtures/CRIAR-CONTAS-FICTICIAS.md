# Contas fictícias no Supabase **edulegal-testes**

## Ação administrativa que depende do responsável
Criar pelo dashboard do projeto de testes em **Authentication > Users > Add user**, preferindo **Create new user** / criação direta com opção de confirmação do e-mail, quando oferecida. Não usar "Send invitation" para endereços do domínio reservado `example.com`, que não recebe mensagens. Nunca utilizar este roteiro no projeto de produção.

Criar **seis identidades de teste**, com senhas fortes distintas escolhidas e guardadas pelo responsável (não compartilhar no chat):

| Conta | E-mail de teste | Organização |
|---|---|---|
| Diretor A | `teste-diretor-a@example.com` | Escola fictícia A |
| Professor A | `teste-professor-a@example.com` | Escola fictícia A |
| Aluno A | `teste-aluno-a@example.com` | Escola fictícia A |
| Diretor B | `teste-diretor-b@example.com` | Escola fictícia B |
| Professor B | `teste-professor-b@example.com` | Escola fictícia B |
| Aluno B | `teste-aluno-b@example.com` | Escola fictícia B |

Se a interface não permitir criar uma conta diretamente confirmada, interromper essa parte e solicitar orientação para configurar um fluxo de teste seguro. Não desabilitar permanentemente a confirmação de e-mail em produção.

## Vincular identidades aos papéis
Depois que as seis contas estiverem confirmadas no **projeto de testes**, executar pelo conector Supabase o script `testes/fixtures/vincular-contas-auth-ficticias.sql`. Ele:
- verifica se os seis endereços fictícios existem e estão confirmados;
- cria perfis;
- aprova vínculos diretor/professor/aluno por organização;
- relaciona professores aos respectivos alunos;
- associa os alunos fictícios já existentes a suas identidades Auth;
- é idempotente e está limitado pelos IDs das organizações de testes.

Não enviar senhas ou tokens nesta conversa.

## Validar
Executar o script `testes/rls/perfis-e-escolas.sql` e depois **testar login manualmente** com pelo menos diretor A, professor A, aluno A e diretor B. Os scripts simulam identidade em transação PostgreSQL, não substituem login pelo navegador. Conferir que nenhuma escola enxerga informações da outra e que alunos não veem alertas de moderação.

## Segurança
- Cadastro/convite real de professores terá autorização server-side e não será autogerido por autoatribuição de papel.
- O registro de teste não representa a identidade real de nenhum aluno ou professor.
- Nenhum dado de alunos reais foi importado.
