select 
        t.tn as Ticket,
		t.title as Título,
		t.create_time as Abertura,
		sec_to_time(to_seconds(now())-to_seconds(from_unixtime(t.escalation_solution_time))) as Atraso
from 
		ticket t, 
		queue q, 
		ticket_state ts, 
		sla s
where 
    	t.queue_id = q.id and 
    	t.ticket_state_id = ts.id and
    	t.sla_id = s.id and 
    	q.name <> 'Junk' and 
    	ts.id not in (2,3,10) and 
    	from_unixtime(t.escalation_solution_time) < NOW() and 
    	t.escalation_solution_time > 0;
