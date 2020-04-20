select
        count(distinct t.id)
from
        ticket t
where
        date(t.create_time) = date(now());
