-- Exclusivo do Supabase edulegal-testes. NÃO EXECUTAR EM PRODUÇÃO.
-- Apenas nomes e conteúdos fictícios. Fixture idempotente para o isolamento entre escolas.
begin;
insert into public.organizations (id,name)
values ('9d93b568-f820-4bc9-8e6f-a9bbcfca0002','Escola Parceira B (FICTÍCIA — TESTES)')
on conflict (id) do nothing;

insert into public.students (id,organization_id,auth_user_id,name,username,active)
values
 ('f71a0a01-735f-4c85-8ab1-7c6b504a3001','6c726841-b198-443a-b5f1-d0c7df776b4b',null,'Aluno Fictício A','demo_aluno_a',true),
 ('f71a0a01-735f-4c85-8ab1-7c6b504a3002','9d93b568-f820-4bc9-8e6f-a9bbcfca0002',null,'Aluno Fictício B','demo_aluno_b',true)
on conflict (id) do nothing;

insert into public.trails (id,student_id,organization_id,title,content,teacher_brief)
values
 ('f71a0a02-735f-4c85-8ab1-7c6b504a4001','f71a0a01-735f-4c85-8ab1-7c6b504a3001','6c726841-b198-443a-b5f1-d0c7df776b4b','Mentoria fictícia A','{"fixture":true}'::jsonb,'Aprendizagem com dados fictícios'),
 ('f71a0a02-735f-4c85-8ab1-7c6b504a4002','f71a0a01-735f-4c85-8ab1-7c6b504a3002','9d93b568-f820-4bc9-8e6f-a9bbcfca0002','Mentoria fictícia B','{"fixture":true}'::jsonb,'Aprendizagem com dados fictícios')
on conflict (id) do nothing;

insert into public.messages(id,trail_id,user_id,role,content)
values
 ('f71a0a03-735f-4c85-8ab1-7c6b504a5001','f71a0a02-735f-4c85-8ab1-7c6b504a4001',null,'student','Exemplo fictício A: como criar uma peça no Roblox?'),
 ('f71a0a03-735f-4c85-8ab1-7c6b504a5002','f71a0a02-735f-4c85-8ab1-7c6b504a4002',null,'student','Exemplo fictício B: como criar uma animação?')
on conflict (id) do nothing;

insert into public.moderation_events(id,organization_id,trail_id,message_id,direction,flagged,category_summary,status)
values
 ('f71a0a04-735f-4c85-8ab1-7c6b504a6001','6c726841-b198-443a-b5f1-d0c7df776b4b','f71a0a02-735f-4c85-8ab1-7c6b504a4001','f71a0a03-735f-4c85-8ab1-7c6b504a5001','student_input',false,'{"fixture":true}'::jsonb,'pending'),
 ('f71a0a04-735f-4c85-8ab1-7c6b504a6002','9d93b568-f820-4bc9-8e6f-a9bbcfca0002','f71a0a02-735f-4c85-8ab1-7c6b504a4002','f71a0a03-735f-4c85-8ab1-7c6b504a5002','student_input',true,'{"fixture":true,"category":"teste_de_isolamento"}'::jsonb,'pending')
on conflict (id) do nothing;
commit;