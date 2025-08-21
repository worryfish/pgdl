Example sql:

select 
    * 
from 
    public.fn_ql_datalens_logic(
        {{period_from}}, 
        {{period_to}}, 
        row({{title}})
    )

Where {{title}} is DataLens filter contains multiple text values or empty or null.

So you should do next in public.fn_ql_datalens_logic:

1. specify function param as IN title record
2. set internal variable like DECLARE ptitle text[];
3. add param value to internal variable like ptitle := (select public.ql_param(title));
