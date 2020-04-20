select
        count(distinct t.id)
from
        ticket t,
        ticket_history th
where
        t.id = th.ticket_id and
        date(th.change_time) = date(now()) and
        t.ticket_state_id in (2, 3, 10);
