-- Testes POSITIVOS e NEGATIVOS da política RLS.
-- Somente projeto Supabase edulegal-testes.
-- Executar DEPOIS de criar as contas e executar vincular-contas-auth-ficticias.sql.
-- Não lê nem exibe dados pessoais: usa contagens e identidades fictícias.

do $test$
declare
  actor record;
  n bigint;
  total bigint;
  test_count integer := 0;
  tab text;
  counts integer[];
  expected_counts integer[];
begin
  for actor in
    select u.id, v.email, v.expected_counts
    from (
      values
      ('teste-diretor-a@example.com',array[1,1,1,1,1,1,1,1,1]),
      ('teste-professor-a@example.com',array[1,1,1,1,1,1,1,1,1]),
      ('teste-aluno-a@example.com',array[1,1,1,1,0,0,0,1,1]),
      ('teste-diretor-b@example.com',array[1,1,1,1,1,1,1,1,1]),
      ('teste-professor-b@example.com',array[1,1,1,1,1,1,1,1,1]),
      ('teste-aluno-b@example.com',array[1,1,1,1,0,0,0,1,1])
    ) as v(email,expected_counts)
    join auth.users u on lower(u.email)=v.email
  loop
    expected_counts := actor.expected_counts;
    execute 'set local role authenticated';
    perform set_config('request.jwt.claim.sub',actor.id::text,true);
    perform set_config('request.jwt.claim.role','authenticated',true);
    counts := array[]::integer[];
    foreach tab in array array[
      'organizations','students','trails','messages',
      'moderation_events','teachers','teacher_students',
      'organization_members','profiles'
    ] loop
      execute format('select count(*) from public.%I',tab) into n;
      counts:=array_append(counts,n::integer);
    end loop;
    execute 'reset role';

    if counts is distinct from expected_counts then
      raise exception 'Permissões divergentes para %: esperado %, obtido %',
        actor.email, expected_counts, counts;
    end if;
    test_count:=test_count+1;
  end loop;

  if test_count<>6 then
    raise exception 'Faltam contas fictícias: apenas % de 6 perfis testados',test_count;
  end if;

  -- Sem vínculo, mesmo com assinatura de JWT simulada.
  execute 'set local role authenticated';
  perform set_config('request.jwt.claim.sub','00000000-0000-4000-8000-000000000099',true);
  foreach tab in array array[
    'organizations','students','trails','messages',
    'moderation_events','teachers','teacher_students',
    'organization_members','profiles'
  ] loop
    execute format('select count(*) from public.%I',tab) into n;
    if n<>0 then
      raise exception 'Acesso sem vínculo detectado em %: % linhas', tab,n;
    end if;
  end loop;
  execute 'reset role';
  raise notice 'PASSOU: 6 identidades fictícias e identidade sem vínculo. Todas as contagens RLS conferem.';
end $test$;

-- Permissões de escrita do cliente: devem estar ausentes, independentemente da RLS.
select table_name
from information_schema.role_table_grants
where table_schema='public'
  and grantee in ('anon','authenticated')
  and privilege_type in ('INSERT','UPDATE','DELETE','TRUNCATE')
  and table_name in (
    'organizations','profiles','organization_members','students',
    'teachers','teacher_students','trails','messages',
    'moderation_events','trail_locks'
  );
-- Resultado esperado: nenhuma linha.
