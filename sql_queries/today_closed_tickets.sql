select
        count(distinct t.id)
from
        ticket t,
        ticket_history th
where
        t.id = th.ticket_id and
        datediff(th.change_time, now()) = 0 and
        t.ticket_state_id in (2, 3, 10);
