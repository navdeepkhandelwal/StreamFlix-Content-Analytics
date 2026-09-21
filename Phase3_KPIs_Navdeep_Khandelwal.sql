USE streamflix;

SELECT COUNT(*) FROM subscribers;
SELECT COUNT(*) FROM titles;
SELECT COUNT(*) FROM watch_history;
SELECT COUNT(*) FROM ratings;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM watchlist;

#Total Watch Hours
select concat(round(sum(watch_duration_min)/60/1000000,2)," Million Hrs")Total_Watch_Hrs from watch_history;

#Active Rate
select concat(round(count(CASE WHEN is_active = 'TRUE' THEN 1 END) / count(*) * 100,2),"%")Active_Rate FROM subscribers;

#Churn Rate
select concat(round(count(CASE WHEN is_active = 'FALSE' THEN 1 END) / count(*) * 100,2),"%")Churn_Rate FROM subscribers;

#Avg Completion Rate
select concat(round(avg(completion_pct),2),"%")Avg_Completion_Rate from watch_history;

#Monthly Recurring Revenue
select concat(round(sum(monthly_price_usd)/100000,2)," Lakhs")Monthly_Recurring_Revenue from subscribers where is_active = "TRUE";

#ARPU
select round(sum(monthly_price_usd) / count(*),2)ARPU from subscribers where is_active = 'TRUE';

#Avg Watch Time / Subscriber
select concat(round((Total_Watch_Hrs / Active_Subscribers),2)," Hrs")avg_watch_hours_per_subscriber
from
(select (sum(watch_duration_min)/60)Total_Watch_Hrs from watch_history) as T1
join
(select count(CASE WHEN is_active = 'TRUE' THEN 1 END)Active_Subscribers FROM subscribers) as T2;

#Watchlist Conversion
select concat(round(count(CASE WHEN watched = "TRUE" THEN 1 END) / count(*)*100,2),"%")Watchlist_Conversion from watchlist;

#Hit Concentration
select concat(round(sum(total_plays) / (select sum(total_plays) from titles) * 100,2),"%")Hit_Concentration
from
(select total_plays from titles order by total_plays desc limit 900) as T1;

#Originals Share of Hours
SELECT concat(round(sum(CASE WHEN is_original = 'TRUE' THEN total_watch_hours ELSE 0 END) / SUM(total_watch_hours)*100,2),"%")Originals_Share_of_Hours from titles;



