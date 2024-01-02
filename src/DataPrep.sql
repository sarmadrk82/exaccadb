


insert into cust_balance
select /* full(a) parallel(a 8) */ to_date('01-JAN-2023', 'DD-MON-YYYY'),
       t.cust_id,
       case when t.rn <1000000 then round(dbms_random.value(0, 10000), 2)
            when t.rn >=1000000 and t.rn < 5000000 then round(dbms_random.value(1000, 100000), 2)
            else round(dbms_random.value(100000, 1000000), 2)
            end
from (select a.*, rownum rn from cust a) t
; -- 322 seconds to insert
commit;


select /*+ parallel(a 8) full(a) */ sum(case when bal_amt < 10 then 1 else 0 end) less_than_10,
       sum(case when bal_amt < 10000 and bal_amt >=10 then 1 else 0 end) less_than_10k,
       sum(case when bal_amt < 100000 and bal_amt >=10000 then 1 else 0 end) less_than_100k,
       sum(case when bal_amt >= 100000 then 1 else 0 end) more_than_100k
from cust_balance a
where bus_date = '01-JAN-2023'
; -- This query without hints is running for 55 seconds as it is using primary key index range scan and then table access by rowid
-- with hints, it ran in 1.8 seconds



insert into trans
with c as (
select cust.*, rownum rn
from cust where rownum <= 100000
),
t as (
select '02-JAN-2023' bus_date,
        trans_seq.nextval trans_id,
        c.cust_id cust_id,
        case when mod(c.rn, 3) >= 1 then 'CR' else 'DR' end tran_type,
        (case when mod(c.rn, 3) >= 1 then 1 else -1 end)*round(dbms_random.value(10, 1000), 2) tran_amt,
        case when mod(c.rn, 3) = 0 then 'GIRO'
             when mod(c.rn, 3) = 1 then 'PAYNOW'
             else 'SWIFT' end tran_payment_type
from (select level lvl, round(dbms_random.value(1, 100000), 0) rn from dual connect by level <= 1000000) l ,
      c
where l.rn = c.rn
)
select t.bus_date,
       t.trans_id,
       t.cust_id,
       t.tran_type,
       t.tran_amt,
       t.tran_payment_type
from t,
     cust_balance cb
and cb.bus_date = '01-JAN-2023'
and cb.cust_id = c.cust_id
and cb.bal_amt + t.tran_amt >= 0;
-- 22 seconds
commit;

