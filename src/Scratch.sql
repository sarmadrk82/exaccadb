
create index text_index on cust(cust_first_name) 
indextype is CTXSYS.CONTEXT;


create index b2index on cust(cust_first_name);

select count(*)
from names;

select *
from cust
where cust_last_name like '%adha%'
;



select /*+ index(cust b2index) */ *
from cust
where cust_first_name like '%adha%'
;

select *
from cust
where contains(cust_first_name, '%rya%') > 0
;

-- Latest

select *
from cust
where cust_first_name like '%adha%'
;



select /*+ no_parallel index(cust b2index) */ count(*)
from cust
where cust_first_name like '%adha%'
and cust_first_name <> cust_last_name
;


select /*+ no_parallel */ *
from cust
where contains(cust_first_name, '%adha%') > 0
and cust_first_name <> cust_last_name
;

create index b2index on cust(cust_first_name);

create index text_index on cust(cust_first_name)
indextype is CTXSYS.CONTEXT;
