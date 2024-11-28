with commodites as (
    select 
        data,
        simbolo,
        valor_fechamento
    from {{ref("stg.commodities")}}
),

movimentacao as(
    select
        data,
        simbolo,
        acao,
        quantidade
    from {{ref("stg_movimentacao_commodities")}}
),

joined as(
    select
        c.data,
        c.simbolo,
        c.valor_fechamento,
        m.acao,
        m.quantidade,
        (m.quantidade * c.valor_fechamento) as valor
    from commodites c
    inner join movimentacao m on c.data = m.data and c.simbolo = m.simbolo
),

last_day as(
    select
        max(data) as max_date
    from joined
),

filtered as (
    select *
    from joined
    where data = (select max_date from last_day)
)

select
    data,
    simbolo,
    valor_fechamento,
    acao,
    quantidade,
    valor
from filtered