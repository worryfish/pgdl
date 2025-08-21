create or replace function public.ql_param(in param record)
returns text[]
language plpgsql
as $$
declare
    items text[];
    tmp json;
begin

    tmp := to_json(param);

    --RAISE EXCEPTION 'Things: %', tmp;
    
    if tmp::text='{}' or tmp->>'f1'='' or tmp->>'f1' IS NULL then
            items := NULL;
    elsif tmp->'f1'->>'f1' IS NULL then
        items := array[tmp->>'f1'];
        --RAISE EXCEPTION 'Type of 0: % -> %', pg_typeof(tmp), tmp->>'f1';
    else
        items := (select array(select (json_each_text(tmp->'f1')).value));
        --RAISE EXCEPTION 'Type of 1: % -> %', pg_typeof(tmp), (tmp->>'f1')::jsonb;
    end if;

    --RAISE EXCEPTION 'Type of 2: % -> %', pg_typeof(items), items;
    
    return items;
end;
$$;
