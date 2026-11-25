-- Uso exclusivo em edulegal-testes. NUNCA executar em edulegal-mvp.
-- Pré-requisito: criar manualmente SEIS usuários fictícios no Supabase Auth > Users
-- com e-mails reservados example.com e marcados como confirmados.
-- Não colocar senhas neste arquivo. São criadas exclusivamente no Dashboard.

begin;
do $$
declare
  user_count integer;
begin
  select count(*) into user_count
  from auth.users
  where lower(email) = any(array[
    'teste-diretor-a@example.com','teste-professor-a@example.com','teste-aluno-a@example.com',
    'teste-diretor-b@example.com','teste-professor-b@example.com','teste-aluno-b@example.com'
  ]);
  if user_count <> 6 then
    raise exception 'Ainda faltam contas fictícias no Auth de testes: foram encontradas % de 6.',user_count;
  end if;
  if exists (
    select 1 from auth.users
    where lower(email) = any(array[
      'teste-diretor-a@example.com','teste-professor-a@example.com','teste-aluno-a@example.com',
      'teste-diretor-b@example.com','teste-professor-b@example.com','teste-aluno-b@example.com'
    ]) and email_confirmed_at is null
  ) then
    raise exception 'Há conta fictícia sem confirmação de email; confirme-a no Dashboard de testes.';
  end if;
end $$;

insert into public.profiles(id,display_name)
select u.id,v.label
from (
 values
 ('teste-diretor-a@example.com','Diretor fictício A'),
 ('teste-professor-a@example.com','Professor fictício A'),
 ('teste-aluno-a@example.com','Aluno fictício A'),
 ('teste-diretor-b@example.com','Diretor fictício B'),
 ('teste-professor-b@example.com','Professor fictício B'),
 ('teste-aluno-b@example.com','Aluno fictício B')
) as v(email,label)
join auth.users u on lower(u.email)=v.email
on conflict(id) do update set display_name=excluded.display_name;

insert into public.organization_members(organization_id,user_id,role,approved)
select v.organization_id,u.id,v.role,true
from (
 values
 ('6c726841-b198-443a-b5f1-d0c7df776b4b'::uuid,'teste-diretor-a@example.com','director'),
 ('6c726841-b198-443a-b5f1-d0c7df776b4b'::uuid,'teste-professor-a@example.com','teacher'),
 ('6c726841-b198-443a-b5f1-d0c7df776b4b'::uuid,'teste-aluno-a@example.com','student'),
 ('9d93b568-f820-4bc9-8e6f-a9bbcfca0002'::uuid,'teste-diretor-b@example.com','director'),
 ('9d93b568-f820-4bc9-8e6f-a9bbcfca0002'::uuid,'teste-professor-b@example.com','teacher'),
 ('9d93b568-f820-4bc9-8e6f-a9bbcfca0002'::uuid,'teste-aluno-b@example.com','student')
) as v(organization_id,email,role)
join auth.users u on lower(u.email)=v.email
on conflict(organization_id,user_id)
do update set role=excluded.role,approved=excluded.approved;

insert into public.teachers(organization_id,id,name)
select v.organization_id,u.id,v.name
from (
 values
 ('6c726841-b198-443a-b5f1-d0c7df776b4b'::uuid,'teste-professor-a@example.com','Professor fictício A'),
 ('9d93b568-f820-4bc9-8e6f-a9bbcfca0002'::uuid,'teste-professor-b@example.com','Professor fictício B')
) as v(organization_id,email,name)
join auth.users u on lower(u.email)=v.email
on conflict(organization_id,id) do update set name=excluded.name;

update public.students set auth_user_id=(
  select u.id from auth.users u where lower(u.email)='teste-aluno-a@example.com'
)
where id='f71a0a01-735f-4c85-8ab1-7c6b504a3001'
  and organization_id='6c726841-b198-443a-b5f1-d0c7df776b4b';

update public.students set auth_user_id=(
  select u.id from auth.users u where lower(u.email)='teste-aluno-b@example.com'
)
where id='f71a0a01-735f-4c85-8ab1-7c6b504a3002'
  and organization_id='9d93b568-f820-4bc9-8e6f-a9bbcfca0002';

insert into public.teacher_students(organization_id,teacher_id,student_id)
select v.organization_id,u.id,v.student_id
from (
 values
 ('6c726841-b198-443a-b5f1-d0c7df776b4b'::uuid,'teste-professor-a@example.com','f71a0a01-735f-4c85-8ab1-7c6b504a3001'::uuid),
 ('9d93b568-f820-4bc9-8e6f-a9bbcfca0002'::uuid,'teste-professor-b@example.com','f71a0a01-735f-4c85-8ab1-7c6b504a3002'::uuid)
) as v(organization_id,email,student_id)
join auth.users u on lower(u.email)=v.email
on conflict(organization_id,teacher_id,student_id) do nothing;

commit;
