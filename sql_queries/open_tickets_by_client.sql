select
      	cc.name as "Cliente", 
      	count(t.id) as "Tickets"
from
      	ticket t,
      	queue q,
      	ticket_state ts,
      	customer_company cc
where
      	t.customer_id = cc.customer_id and
      	t.queue_id = q.id and
      	t.ticket_state_id = ts.id and
      	t.ticket_state_id in (1,4,6,7,8) and
      	q.id = 2;
