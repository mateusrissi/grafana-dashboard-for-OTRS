select
        count(distinct t.id)
from
        ticket t
where
        datediff(t.create_time, now()) = 0;
