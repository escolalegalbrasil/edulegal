-- Verificação negativa de RLS em edulegal-testes.
-- Requer execução administrativa em ambiente isolado. NÃO EXECUTAR EM PRODUÇÃO.
-- Simula a função auth.uid() com uma identidade sem vínculo; NÃO substitui testes reais de Auth.
do $tests$
declare
  n bigint;
  tbl text;
begin
  execute 'set local role authenticated';
  perform set_config('request.jwt.claim.sub','00000000-0000-4000-8000-000000000099',true);
  foreach tbl in array array['organizations','students','trails','messages','moderation_events','organization_members','teachers','teacher_students','profiles']
  loop
    execute format('select count(*) from public.%I',tbl) into n;
    if n <> 0 then
      raise exception 'RLS NEGAÇÃO FALHOU: % disponibilizou % registros para identidade sem vínculo',tbl,n;
    end if;
  end loop;
  execute 'reset role';
end $tests$;
