#CREATING NEW DATABASE 
create database sql_assignmnt_1; 
 
 use sql_assignmnt_1

Rename table 
select * from Bajaj2 -- checking the table Bajaj2 

Create Table bajaj1 as 
SELECT STR_TO_DATE(date,"%d-%M-%Y") as `Date`,
`Close Price` as `Close Price`, 
AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS `20 Day MA`,
AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS `50 Day MA`
from bajaj2;  

select *from Bajaj1 -- This table has Date, close Price 20 Day MA and 50 Days moving average 

#FOR TCS 
Select * from TCS2 -- checking the TCS table 

Create Table TCS1 as 
SELECT STR_TO_DATE(date,"%d-%M-%Y") as `Date`,
`Close Price` as `Close Price`, 
AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS `20 Day MA`,
AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS `50 Day MA`
from TCS2;

Select * from TCS1 -- This table has Date, close Price 20 Day MA and 50 Days moving average for TCS 

# Importing the TVS AUTO CSV and checking the values in the table 
Select * from TVS2

Create Table TVS1 as 
SELECT STR_TO_DATE(date,"%d-%M-%Y") as `Date`,
`Close Price` as `Close Price`, 
AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS `20 Day MA`,
AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS `50 Day MA`
from TVS2;

Select * from TVS1 --  This table has Date, close Price 20 Day MA and 50 Days moving average for TVS 

#Importing the Infosys CSV and checking the values in the table 

select * from Infosys2 

Create Table Infosys1 as 
SELECT STR_TO_DATE(date,"%d-%M-%Y") as `Date`,
`Close Price` as `Close Price`, 
AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS `20 Day MA`,
AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS `50 Day MA`
from Infosys2;

select * from Infosys1 --  This table has Date, close Price 20 Day MA and 50 Days moving average for Infosys 

# Importing the Eicher CSV and checking the values in the table 
select * from Eicher2

Create Table Eicher1 as 
SELECT STR_TO_DATE(date,"%d-%M-%Y") As `Date`,
`Close Price` As `Close Price`, 
AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS `20 Day MA`,
AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS `50 Day MA`
from Eicher2;

select * from Eicher1 -- This table has Date, close Price 20 Day MA and 50 Days moving average for Infosys 


# Importing the Eicher CSV and checking the values in the table 
select * from hero2

Create Table Hero1 as 
SELECT STR_TO_DATE(date,"%d-%M-%Y") As `Date`,
`Close Price` As `Close Price`, 
AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS `20 Day MA`,
AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS `50 Day MA`
from Hero2;

select * from Hero1 -- This table has Date, close Price 20 Day MA and 50 Days moving average for Infosys 

#1.Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. 
#(This has to be done for all 6 stocks) -- DONE 	

#######-----------------------------------------------------########
#2. Creating the master table 

Create table `master table` as 
select `Date`, bajaj2.`close price` as Bajaj,
TCS2.`close price` as TCS, 
TVS2.`close price` as TVS, 
Infosys2. `close price` as Infosys, 
Eicher2.`close price` as Eicher, 
Hero2.`close price` as Hero
from bajaj2	
inner join TCS2
using (`Date`)
inner join TVS2
using (`Date`)
inner join Infosys2
using (`Date`)
inner join Eicher2
using (`Date`)
inner join Hero2
using (`Date`); 

select * from `master table`-- The master Table has containing the date and close price of all the six stocks. 
                            -- (Column header for the price is the name of the stock)

 
#######-----------------------------------------------------########
#3. Use the table created in Part(1) to generate buy and sell signal. 
#Store this in another table named 'bajaj2'. Perform this operation for all stocks.

Alter Table Bajaj2 
Rename to Bajaj10; 

select *from bajaj10 -- This table has Date and close price for Bajaj Auto 
select *from baja2 -- This table does not exist not 

Alter Table TCS2 
Rename to TCS10; 

select *from TCS10 -- This table has Date and close price for TCS  
select *from TCS2 -- This Table does not exist 

Alter Table TVS2 
Rename to TVS10;

select *from TVS10 -- This table has Date and close price for TVS  
select *from TVS2 -- This Table does not exist 

Alter Table Infosys2  
Rename to Infosys10;

select *from Infosys10 -- This table has Date and close price for Infosys   
select *from Infosys2-- This Table does not exist 

Alter Table Eicher2  
Rename to Eicher10;

select *from Eicher10 -- This table has Date and close price for Infosys   
select *from Eicher2 -- This Table does not exist

Alter Table Hero2  
Rename to Hero10; 

select *from Hero10 -- This table has Date and close price for Hero  
select *from Hero2 -- This Table does not exist

create table bajaj2 as
select
`date` as `Date`,
`Close Price`,
case
when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then 'HOLD'
when nth_value(short_term_greater,2) over w = 'Y' then 'BUY'
when nth_value(short_term_greater,2) over w = 'N' then 'SELL'
else 'HOLD'
END
as `Signal`
from (
	select date,`Close Price`,if(`20 Day MA` > `50 Day MA`, 'Y', 'N') as short_term_greater
    from bajaj1
) temp_table
window w as (ORDER BY `Date` desc ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING); 

select *from bajaj2 -- Bajaj2 Table has signal attribute which tells when to HOLD, SELL or BUY the shares 

create table Hero2 as
select
`date` as `Date`,
`Close Price`,
case
when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then 'HOLD'
when nth_value(short_term_greater,2) over w = 'Y' then 'BUY'
when nth_value(short_term_greater,2) over w = 'N' then 'SELL'
else 'HOLD'
END
as `Signal`
from (
	select date,`Close Price`,if(`20 Day MA` > `50 Day MA`, 'Y', 'N') as short_term_greater
    from hero1
) temp_table
window w as (ORDER BY `Date` desc ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING); 

Select * from Hero2 -- Hero2 Table has signal attribute which tells when to HOLD, SELL or BUY the shares

create table TCS2 as
select
`date` as `Date`,
`Close Price`,
case
when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then 'HOLD'
when nth_value(short_term_greater,2) over w = 'Y' then 'BUY'
when nth_value(short_term_greater,2) over w = 'N' then 'SELL'
else 'HOLD'
END
as `Signal`
from (
	select date,`Close Price`,if(`20 Day MA` > `50 Day MA`, 'Y', 'N') as short_term_greater
    from TCS1
) temp_table
window w as (ORDER BY `Date` desc ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING); 

Select * from TCS2 -- TCS Table has signal attribute which tells when to HOLD, SELL or BUY the shares

create table TVS2 as
select
`date` as `Date`,
`Close Price`,
case
when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then 'HOLD'
when nth_value(short_term_greater,2) over w = 'Y' then 'BUY'
when nth_value(short_term_greater,2) over w = 'N' then 'SELL'
else 'HOLD'
END
as `Signal`
from (
	select date,`Close Price`,if(`20 Day MA` > `50 Day MA`, 'Y', 'N') as short_term_greater
    from TVS1
) temp_table
window w as (ORDER BY `Date` desc ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING); 

Select * from TVS2 -- TVS Table has signal attribute which tells when to HOLD, SELL or BUY the shares

create table Infosys2 as
select
`date` as `Date`,
`Close Price`,
case
when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then 'HOLD'
when nth_value(short_term_greater,2) over w = 'Y' then 'BUY'
when nth_value(short_term_greater,2) over w = 'N' then 'SELL'
else 'HOLD'
END
as `Signal`
from (
	select date,`Close Price`,if(`20 Day MA` > `50 Day MA`, 'Y', 'N') as short_term_greater
    from Infosys1
) temp_table
window w as (ORDER BY `Date` desc ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING); 

Select * from Eicher2 -- Infosys Table has signal attribute which tells when to HOLD, SELL or BUY the shares

create table Eicher2 as
select
`date` as `Date`,
`Close Price`,
case
when first_value(short_term_greater) over w = nth_value(short_term_greater,2) over w then 'HOLD'
when nth_value(short_term_greater,2) over w = 'Y' then 'BUY'
when nth_value(short_term_greater,2) over w = 'N' then 'SELL'
else 'HOLD'
END
as `Signal`
from (
	select date,`Close Price`,if(`20 Day MA` > `50 Day MA`, 'Y', 'N') as short_term_greater
    from Infosys1
) temp_table
window w as (ORDER BY `Date` desc ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING);

Select * from Eicher2 -- Eicher 2 Table has signal attribute which tells when to HOLD, SELL or BUY the shares

# Table Bajaj2, TCS2, TVS2, Infosys2, Eicher2 and Hero2 has Attribute DATE, CLOSE PRICE, SIGNAL 
 
 ############---------------------------------------------------#######

#4. Create a User defined function, that takes the date as input 
#and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.
 DELIMITER //
CREATE FUNCTION get_signal(date1 varchar(255)) RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE signal_ varchar(255);
	Select `Signal` into signal_ from bajaj2 where Date = date1;
	RETURN signal_;
END 
//
DELIMITER ;

-- Now we ca get the signal for a particualr day on Bajaj Stock, Use the function get_signal
select get_signal('2018-07-05') as `Signal`; -- This gives what need to be done on 2018-06-05

 DELIMITER 
CREATE FUNCTION get_signal(date1 varchar(255)) RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE signal_ varchar(255);
	Select `Signal` into signal_ from TCS2 where Date = date1;
	RETURN signal_;
END 

DELIMITER ;
-- Now we ca get the signal for a particualr day on TCS Stock, Use the function get_signal
select get_signal('2018-07-05') as `Signal`;
 
 DELIMITER 
CREATE FUNCTION get_signal(date1 varchar(255)) RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE signal_ varchar(255);
	Select `Signal` into signal_ from TVS2 where Date = date1;
	RETURN signal_;
END 

DELIMITER ;

-- Now we ca get the signal for a particualr day on TVS Stock, Use the function get_signal
select get_signal('2018-07-05') as `Signal`;

 DELIMITER 
CREATE FUNCTION get_signal(date1 varchar(255)) RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE signal_ varchar(255);
	Select `Signal` into signal_ from Infosys2 where Date = date1;
	RETURN signal_;
END 

DELIMITER ;
-- Now we ca get the signal for a particualr day on TVS Stock, Use the function get_signal
select get_signal('2018-07-05') as `Signal`;

 DELIMITER 
CREATE FUNCTION get_signal(date1 varchar(255)) RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE signal_ varchar(255);
	Select `Signal` into signal_ from Eicher2 where Date = date1;
	RETURN signal_;
END 

DELIMITER ;

-- -- Now we ca get the signal for a particualr day on Eicher Stock, Use the function get_signal

select get_signal('2018-07-05') as `Signal`;

 DELIMITER 
CREATE FUNCTION get_signal(date1 varchar(255)) RETURNS varchar(255) DETERMINISTIC
BEGIN
	DECLARE signal_ varchar(255);
	Select `Signal` into signal_ from Hero2 where Date = date1;
	RETURN signal_;
END 

DELIMITER ;

-- Now we ca get the signal for a particualr day on Eicher Stock, Use the function get_signal
 select get_signal('2018-07-05') as `Signal`;

                 
                            ##-------- End of the assignment --------------------------###
# Question 5 in PDF 

