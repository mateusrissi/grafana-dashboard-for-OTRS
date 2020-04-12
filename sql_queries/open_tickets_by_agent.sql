select
        concat(u.first_name, ' ',u.last_name) AS Nome,
        count(t.id) Chamados
from
        ticket t,
        queue q,
        users u
where
        u.id = t.user_id and
        q.id = t.queue_id and
        t.ticket_state_id in (4,6,7,8) and
        q.id = 2
group by Nome;
