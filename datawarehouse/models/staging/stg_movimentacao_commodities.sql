with source as (
    select
        date,
        symbol,
        action,
        quaitity
    from
        {{source("postgres", "movimentacao_commodities")}}
),

renamed as (
    select
        cast(date as date) as data,
        symbol as simbolo,
        action as acao,
        quaitity as quantidade
    from source
)

select *
from renamed