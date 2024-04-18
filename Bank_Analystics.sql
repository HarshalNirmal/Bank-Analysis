use project;
select * from finance_1;
select * from finance_2_final_sql;

-- 1st Kpi 
-- Year Wise Loan Amt Stats

select year(issue_d),
       CONCAT(ROUND((sum(loan_amnt)/1000000),1),' ','M') AS Loan_Amount
       from finance_1
group by year(issue_d)
order by year(issue_d);

-- 2nd KPI
-- Grade and Sub_grade wise Revolving_balance

select f1.grade,f1.sub_grade,
concat(round((sum(f2.revol_bal)/1000000),1),'M') as Revolving_balance
from finance_1 as f1
left join finance_2_final_sql  as f2
on f1.id=f2.id
group by grade,sub_grade
order  by 1,2 desc;
                                                                                            


select f1.grade,concat(round((sum(f2.revol_bal)/1000000),1),'M') as Revolving_balance
from finance_1 as f1
left join finance_2_final_sql as f2
on f1.id=f2.id
group by grade
order  by 1;

-- 3rd KPI
-- Verication_status wise Total_Payment

select f1.verification_status,round(sum(f2.total_pymnt),0) as Total_Payment
from finance_1 as f1
left join finance_2_final_sql as f2
on f1.id=f2.id
where verification_status in("Verified","Not Verified")
group by verification_status;

-- 4th KPI
-- state wise last_credit_pull_d wise loan_status

select addr_state,year(last_credit_pull_d),Loan_status,count(loan_status)
from finance_1 as f1 
 join finance_2_final_sql as f2
on f1.id=f2.id
-- where addr_state='CA'
group by 1,2,3
order by 4 desc;

select addr_state,sum(if(loan_status="Fully Paid",1,0 )) as Fully_paid,
                  sum(if(loan_status="Charged Off",1,0)) as Charged_off,
                  sum(if(loan_status="Current",1,0)) as current 
                  from finance_1
                  group by 1
                  order by 2 desc;





-- 5th KPI
-- Home_Owner_ship vs last_pymnt_d

select home_ownership, year(last_pymnt_d),
count(home_ownership) as Customer_count
from finance_1 as f1
join finance_2_final_sql as f2
on f1.id=f2.id
group by 1,2
order by 1,2;

select home_ownership,count(home_ownership)
from finance_1 as f1
join finance_2_final_sql as f2
on f1.id=f2.id
group by 1
order by 2 desc;





