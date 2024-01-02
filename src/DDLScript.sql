create table cust (
    cust_id varchar2(100) primary key,
    cust_first_name varchar2(100) not null,
    cust_last_name varchar2(100) not null,
    cust_phone int,
    cust_address varchar2(1000),
    cust_email varchar2(100),
    cust_citizenship varchar2(50),
    cust_employer varchar2(100),
    cust_job_title varchar2(100),
    dummy1 varchar2(100),
    dummy2 varchar2(100),
    dummy3 varchar2(100),
    dummy4 varchar2(100),
    dummy5 varchar2(100),
    dummy6 varchar2(100),
    dummy7 varchar2(100),
    dummy8 varchar2(100),
    dummy9 varchar2(100),
    dummy10 varchar2(100),
    dummy11 varchar2(100),
    dummy12 varchar2(100),
    dummy13 varchar2(100),
    dummy14 varchar2(100),
    dummy15 varchar2(100),
    dummy16 varchar2(100),
    dummy17 varchar2(100),
    dummy18 varchar2(100),
    dummy19 varchar2(100),
    dummy20 varchar2(100),
    dummy21 varchar2(100),
    dummy22 varchar2(100),
    dummy23 varchar2(100),
    dummy24 varchar2(100),
    dummy25 varchar2(100),
    dummy26 varchar2(100),
    dummy27 number(25, 9),
    dummy28 date,
    dummy29 number,
    dummy30 date

);

create table fname (fname varchar2(100));

create table lname (lname varchar2(100));

create table names (fname varchar2(100), lname varchar2(100));

create table nameslist (name varchar2(200));


create table trans
(
bus_date date not null,
trans_id number not null,
cust_id varchar2(100) not null,
tran_type char(2) not null,
tran_amt number(25, 9) not null,
tran_payment_type varchar2(10)
)
partition by range (bus_date)
(
partition p1 values less than (to_date('2023-01-01', 'YYYY-MM-DD')),
partition p2 values less than (to_date('2023-01-02', 'YYYY-MM-DD')),
partition p3 values less than (to_date('2023-01-03', 'YYYY-MM-DD')),
partition p4 values less than (to_date('2023-01-04', 'YYYY-MM-DD')),
partition p5 values less than (to_date('2023-01-05', 'YYYY-MM-DD')),
partition p6 values less than (to_date('2023-01-06', 'YYYY-MM-DD'))
);

alter table trans add constraint trans_pk primary key (bus_date, trans_id) using index local;

create sequence trans_seq increment by 1 cache 10 nocycle;

create table cust_balance
(
bus_date date not null,
cust_id varchar2(100) not null,
bal_amt number(25, 9) not null
)
partition by range (bus_date)
(
partition p1 values less than (to_date('2023-01-01', 'YYYY-MM-DD')),
partition p2 values less than (to_date('2023-01-02', 'YYYY-MM-DD')),
partition p3 values less than (to_date('2023-01-03', 'YYYY-MM-DD')),
partition p4 values less than (to_date('2023-01-04', 'YYYY-MM-DD')),
partition p5 values less than (to_date('2023-01-05', 'YYYY-MM-DD')),
partition p6 values less than (to_date('2023-01-06', 'YYYY-MM-DD'))
);

alter table cust_balance add constraint bal_pk primary key (bus_date, cust_id) using index local;

