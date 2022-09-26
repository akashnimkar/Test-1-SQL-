select * from airport_detail limit 10;
select * from cancellation limit 10;
select * from carrier_detail ;
select* from flight_detail limit 10;
select * from route_detail limit 10;
select* from state_detail limit 10;

-- use starter qul to connect table 

-- 1.	Find out the airline company which has a greater number of flight movement.
select Carrier_code,
count( distinct Carrier_code) from carrier_detail;

-- WN is the  airline company which has a greater number of flight movement.

-- 2.	Get the details of the first five flights that has high airtime. 
select Carrier_code,
sum(airtime) AS TOTAL_AIR_TIME
from flight_detail as f
join carrier_detail as c
on f.carrierId=c.Carrier_ID
group by Carrier_code
LIMIT 5;

-- 3.	Compute the maximum difference between the scheduled and actual arrival and 
-- departure time for the flights and categorize it by the airline companies.

select Carrier_code,
FlightId,
arrivaldelay,
departuredelay
from flight_detail as f
join carrier_detail as c
on f.carrierId=c.Carrier_ID
group by Carrier_code
order by arrivaldelay desc ;


-- 4.	Find the month in which the flight delays happened to be more
select 
flight_month,
arrivaldelay, 
departuredelay
 from flight_detail
 where arrivaldelay> 0
 or departuredelay>0 
 group by flight_month
 order by arrivaldelay desc;
 
 -- 5.	Get the flight count for each state and identify the top 1.
 select state_code,
count(FlightId) as count_of_flight
 from flight_detail
 left join route_detail
  on flight_detail.routeId=route_detail.route_ID
left join airport_detail
 on route_detail.origincode=airport_detail.locationId
left join state_detail
 on airport_detail.stateId=state_detail.stateId
 group by state_code
 order by count_of_flight desc;
 
 -- 6.	 A customer wants to book a flight under an emergency situation. Which airline would you suggest him to book. Justify your answer.
 select Carrier_ID,Carrier_code,FlightId, arrivaldelay, departuredelay 
 from flight_detail as f
 left join carrier_detail as c
 on f.carrierId=c.Carrier_ID
order by departuredelay asc;
-- in emergency suituation im suggesting to book AA flight having flight id 1047741, becouse its only the fligh have record to delay only 6 min max time. 

-- 7.	Find the dates in each month on which the flight delays are more.
select 
flight_month,
daymonth, 
max(departuredelay)
 from flight_detail
 group by flight_month
 order by departuredelay desc;
 
select 
flight_month,
daymonth, 
avg(departuredelay)
 from flight_detail
 group by flight_month
 order by departuredelay desc;
 
 -- 8.	Calculate the percentage of flights that are delayed compared to flights that arrived on time.
 select ((select count(arrivaldelay) from flight_detail where arrivaldelay>0 )/
 (select count(arrivaldelay) from flight_detail where arrivaldelay<=0 )) as percentage from flight_detail
 group by percentage;
 
 
-- 9.	Identify the routes that has more delay time.
select route_ID,
origincode, destinationcode,
arrivaldelay, departuredelay from flight_detail as f
left join route_detail as r
on f.routeId=r.route_ID
group by route_ID
order by  departuredelay desc
;
 
 select max(departuredelay) from flight_detail;
 
 select route_ID,
origincode, destinationcode,
arrivaldelay, departuredelay from flight_detail as f
left join route_detail as r
on f.routeId=r.route_ID
order by  departuredelay desc;

-- the most delay route is route id 2636

 select route_ID,
origincode, destinationcode,
arrivaldelay, departuredelay from flight_detail as f
left join route_detail as r
on f.routeId=r.route_ID

order by  departuredelay desc;

-- 10.	Find out on which day of week the flight delays happen more.
select dayweek, 
departuredelay 
from flight_detail
order by departuredelay desc;

-- 11.	Identify at which part of day flights arrive late.
select Arrivaltime, arrivaldelay
 from flight_detail
 group by Arrivaltime
 order by arrivaldelay desc;
 -- from result , flight arrive at morning in between 2 am to 5 am are more delay. 
 
 -- 12.	Compute the maximum, minimum and average TaxiIn and TaxiOut time.
 select 
 max(taxiIn) as max_taxiin_time,
min(taxiIn) as min_taxiin_time,
avg(taxiIn) as avg_taxiin_time,
max(taxiOut) as max_taxiout_time,
min(taxiOut) as min_taxiout_time,
avg(taxiOut) as avg_taxiout_time
 from flight_detail;

-- 13.	Get the details of origin and destination with maximum flight movement.
select count(Carrier_code),
origincode,destinationcode
from flight_detail as f
left join carrier_detail as c
on f.carrierId=c.Carrier_ID
left join  route_detail as r
on r.route_ID=f.routeId
group by Carrier_code
order by count(Carrier_code) desc;
-- the max flight movement in between origincode 132 and destination code 30. 

-- 14.	Find out which delay cause occurrence is maximum. 
select count(distinct carrierdelay),
count(distinct weatherdelay),
count(distinct NASdelay),
count(distinct securitydelay),
count(distinct Late_aircraft_delay)
 from flight_detail;
 

 
 -- 15.	Get details of flight whose speed is between 400 to 600 miles/hr for each airline company. 
 select Carrier_code as airline_company,
 (distance*60/airtime) as speed
from flight_detail as f
left join carrier_detail as c
on f.carrierId=c.Carrier_ID
where speed  between 400 and 600
group by Carrier_code;

-- 16.	Identify the best time in a day to book a flight for a customer to reduce the delay. 
select
 Arrivaltime as best_time_to_book_ticket,
arrivaldelay 
from flight_detail
order by arrivaldelay ;

-- 17.	Get the route details with airline company code ‘AQ’
select Carrier_code,
origincode,
destinationcode 
from flight_detail as f
left join carrier_detail as c
on f.carrierId=c.Carrier_ID
left join route_detail as r
on f.routeId=r.route_ID
where Carrier_code='Aq';

-- check 
select * from carrier_detail
where Carrier_code= 'aq';

-- 18.	Identify on which dates in a year flight movement is large.

select flight_date,
count( flight_date) 
from flight_detail
group by flight_date 
order by count(flight_date);
-- on '2008-05-25' flight movement is large which is 2037. 

-- 19.	Find out which delay cause is occurring more for each airline company.
select Carrier_code as flight_company,
count(distinct carrierdelay) ,
count(distinct weatherdelay),
count(distinct NASdelay),
count(distinct securitydelay) 
from flight_detail as f
left join carrier_detail as c
on f.carrierId=c.Carrier_ID
group by Carrier_code;
-- use order by later

-- 20.	 Write a query that represent your unique observation in the database. 
