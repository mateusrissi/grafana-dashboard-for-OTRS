select
  		ts.name Estado,
  		count(*) Qtd
from
  		ticket t left join ticket_state ts on ts.id = t.ticket_state_id
where
  		t.ticket_state_id in (4, 6, 7, 8)
group by 1
order by 2 desc, 1;
