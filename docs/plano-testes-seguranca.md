# EduLegal — Plano de segurança e ambiente de testes
Data de início: 2026-11-25
Status: planejamento; nenhuma alteração em produção autorizada.

## Ambientes
- Produção (não modificar sem validação expressa do diretor): repositório escolalegalbrasil/edulegal, branch main, projeto Supabase edulegal-mvp.
- Desenvolvimento: branch testes-seguranca-2026. Nenhum Pages alternativo ou projeto Supabase de testes foi ainda configurado.
- Dados de teste: apenas registros e contas fictícios; não copiar dados pessoais de alunos.

## Antes de desenvolver
1. Registrar versão de referência do código e configurações relevantes.
2. Preparar backup recuperável do banco com o procedimento oficial Supabase CLI, incluindo dados, esquema, objetos Storage e configurações/funções exportáveis; guardar fora do repositório público.
3. Validar capacidade de restauração em ambiente isolado.
4. Confirmar custos exatos e autorizar separadamente criação do projeto Supabase de testes.
5. Garantir que o frontend de testes use exclusivamente as credenciais publicáveis do banco de testes.

## Correções planejadas e suas dependências
1. Revisar autenticação do aluno: eliminar select=* e persistência do registro completo de students, especialmente do campo pin.
2. Revisar modelo de identidade: relação entre students.id, auth.users.id, trails.student_id e messages.user_id antes de alterar políticas.
3. Revisar leitura de professores, autorização de papel e proteção do cadastro de professores.
4. Preparar políticas de RLS e privilégios para students, teachers e trail_locks; evitar habilitar sem migração e testes.
5. Endurecer generate-trail para exigir identificação e papel de professor validados no servidor.
6. Revisar quem pode modificar profiles.role e criar convite de professores administrado pelo diretor.
7. Preparar futura estrutura de organizações/escolas (tenant), com isolamento por escola.
8. Integrar moderação de entrada e saída com logs de alertas mínimos e privacidade, testando falsos positivos antes da ativação.

## Roteiro de testes (dados fictícios)
- Aluno consegue fazer login e abrir apenas suas próprias mentorias.
- Professor autorizado consegue fazer login, consultar seus alunos e criar mentorias.
- Conta de aluno não consegue consultar dados de outro aluno ou criar mentorias como professor.
- Conta não autenticada não consegue ler, alterar ou excluir students, teachers ou trail_locks.
- IA mantém comunicação, estados de concorrência e upload de evidências.
- Casos simulados de moderação: conteúdo normal, conteúdo de risco, falso positivo e indisponibilidade do serviço.
- Verificação de políticas de acesso e de eventuais regressões.

## Publicação
Não mesclar na branch main, nem aplicar migrações, políticas, configurações ou Edge Functions no Supabase oficial até testes do diretor e autorização explícita de publicação.
