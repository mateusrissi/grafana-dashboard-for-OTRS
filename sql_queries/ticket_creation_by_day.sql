select
        $__timeGroup(t.create_time,'24h', 0) as time,
        count(*) as qtd
from
        ticket t
group by date(t.create_time);
