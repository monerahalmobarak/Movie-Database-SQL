Relational Schema:
Branch ( br_num, email, street, city )
BranchPhone ( br_num, phone )
FK: br_num references Branch (br_num )
Room(r_num ,capi,type , br_num)
FK: br_num references Branch (br_num )
Movie(m_num , name , rating, langu ,rel_dat, generes)
Movie_Room(mo_num , r_num , date,time )
Fk1: mo_num references Movie(mo_num)
FK2: r_num references Room(r_num)
Customer ( cus_id , name , DOB , email )
CustomerPhone ( cus_id , phone )
FK: cus_id reference Customer( cus_id )
Ticket(tick_id ,date ,time ,price ,mo_num, cus_id)
FK1: mo_num references Movie(mo_num)
FK2: cus_id reference Customer ( cus_id )
5
DDL Commands:
--for design only --
set linesize 150;
--only for the erorr--
drop table Branch CASCADE CONSTRAINTS;
drop table BranchPhone CASCADE CONSTRAINTS;
drop table Room CASCADE CONSTRAINTS;
drop table Movie CASCADE CONSTRAINTS;
drop table Movie_Room CASCADE CONSTRAINTS;
drop table Customer CASCADE CONSTRAINTS;
drop table CustomerPhone CASCADE CONSTRAINTS;
drop table Ticket CASCADE CONSTRAINTS;
-----------the creation of the tables (( First Point))-----------
Create table Branch
( 
br_num char(3) PRIMARY KEY, 
email varchar2 (100) UNIQUE,
street varchar2 (100),
city varchar2(50)
);
create table BranchPhone 
(
br_num char(3),
phone number (9) ,
constraint br_PK PRIMARY KEY(br_num , phone ) ,
CONSTRAINT br_FK FOREIGN KEY (br_num) REFERENCES Branch (br_num)
);
create table Room 
(
r_num char(3) PRIMARY KEY,
capi number(3) ,
6
r_type varchar2(20),
br_num char(3),
CONSTRAINT br_FK2 FOREIGN KEY (br_num) REFERENCES Branch (br_num)
);
create table Movie 
(
m_num char(3) primary key,
rating number(10,5) , 
langu varchar2(20),
rel_dat DATE,
generes varchar2(35)
);
create table Movie_Room 
( 
m_num char(3) , 
r_num char(3), 
date_m DATE , --the INSERT part we are not sure about it (we did from outside the book 
method)--
duration VARCHAR2(20) ,-- the Movie duration like 1h 43m or 2h 0m (2h)--
constraint mr_PK PRIMARY KEY(m_num , r_num ) ,
constraint m_fk foreign key (m_num) references Movie(m_num),
constraint r_fk foreign key (r_num) references Room(r_num)
);
create table Customer 
( 
cus_id CHAR(10) primary key , 
name varchar2(10) not null ,
DOB date not null,
email varchar2(30) not null
);
7
create table CustomerPhone 
( 
cus_id CHAR(10) ,
phone varchar2(10) ,
constraint cp_PK PRIMARY KEY(cus_id , phone ) ,
constraint cp_fk foreign key (cus_id) references Customer(cus_id)
);
create table Ticket
(
tick_id CHAR(5) primary key,
date_t date , --the INSERT part we are not sure about it (we did from outside the book method)--
time_t TIMESTAMP , --the INSERT part we are not sure about it (we did from outside the book 
method)--
price number(2) check(price<=90) ,
m_num char(3),
cus_id CHAR(10),
constraint m_fk2 foreign key (m_num)references Movie (m_num),
constraint cus_fk2 foreign key (cus_id)references Customer(cus_id)
);
------------------------The Insert (( Second Point ))------------------------
INSERT INTO Branch VALUES ('333','soltan@gamil.com','King Fahad Road','Riyadh');
INSERT INTO Branch VALUES ('154','salma@gamil.com','Olaya Street','Riyadh');
INSERT INTO Branch VALUES ('486','ibrahem@gamil.com','King Fahad Road','Jeddah');
INSERT INTO BranchPhone VALUES ( '333' , 554477554 );
INSERT INTO BranchPhone VALUES ( '154' , 556677441 );
INSERT INTO BranchPhone VALUES ( '486' , 557724682 );
INSERT INTO Customer VALUES ( '11154785' , 'Salman' ,(TO_DATE ('05-07-1995','DDMM-YYYY')), 'salman@gamil.com');
8
INSERT INTO Customer VALUES ( '11454834' , 'Sara' ,(TO_DATE ('07-10-1995','DD-MMYYYY')), 'Sara@gamil.com');
INSERT INTO Customer VALUES ( '55149327' , 'Faten' ,(TO_DATE ('06-07-1995','DD-MMYYYY')), 'Faten@gamil.com');
INSERT into CustomerPhone VALUES ( '11154785' , '0568451248');
INSERT into CustomerPhone VALUES ( '11454834' , '0568412578');
INSERT into CustomerPhone VALUES ( '55149327' , '0546851238');
INSERT INTO Room VALUES ('001' , 48, 'gold' , '154');
INSERT INTO Room VALUES ('002' , 48, 'standard' , '333');
INSERT INTO Room VALUES ('003' , 38, 'kids' , '154');
INSERT INTO Movie VALUES ('110' , 7.3, 'English' , TO_DATE ('18-Nov-2021','DD-MonYYYY' ), 'adventure' );
INSERT INTO Movie VALUES ('231' , 5.5 , 'Arabic' , TO_DATE ('28-Oct-2021','DD-MonYYYY') , 'comedy' );
INSERT INTO Movie VALUES ('310' , 9.4, 'English' , TO_DATE ('25-Nov-2021','DD-MonYYYY' ), 'animation' );
INSERT INTO Movie_Room VALUES ('110' , '001' , TO_DATE ('22-11-2021','dd-mm-yyyy') 
,'2h 32m ' );
INSERT INTO Movie_Room VALUES ('231' , '002' , TO_DATE ('28-11-2021','dd-mm-yyyy') , 
'2h 28m');
INSERT INTO Movie_Room VALUES ('310' , '003' , TO_DATE ('23-11-2021','dd-mm-yyyy') , 
'2h' );
INSERT INTO Ticket VALUES ('52123' , TO_DATE ('22-11-2021' ,'dd-mm-yyyy') , 
TO_TIMESTAMP('07:00','HH:MI') , 75, '110' , '11154785' );
INSERT INTO Ticket VALUES ('42145' , TO_DATE ('28-11-2021' ,'dd-mm-yyyy') , 
TO_TIMESTAMP('12:00','HH:MI') , 50, '231' , '11454834' );
INSERT INTO Ticket VALUES ('72230' , TO_DATE ('28-11-2021' ,'dd-mm-yyyy') , 
TO_TIMESTAMP('01:20','HH:MI') , 55, '310' , '55149327' );
9
-------------the third point part one------------------
--This query will display all rows where the language of the movie in table movie is in English--
SELECT * FROM Movie
WHERE langu LIKE 'English';
--This query will display all the rows where the price of the ticket in table ticket is greater than 
50--
SELECT * FROM Ticket
WHERE price > 50;
--This query will display all the rows where the cpacity of the room in table room is equal to 48 
and ordered by the room number--
SELECT * FROM Room
WHERE capi = 48
ORDER BY r_num;
-------------the third point part two------------------
-- This query will display all the rows from tabel branch --
select count(*)
from Branch ;
--This query will divide the cities into groups, showing the number of branches in each city --
select city ,count(br_num)
from Branch
group by city ;
--This query will split the movie table into qroups according to languages and calculate the 
maximum rating greater than 7 --
select langu , max(rating)
from Movie  
group by langu 
having max(rating) > 7;
10
-----------------To show all the work------------------
SELECT * FROM Customer ;
SELECT * FROM Ticket ;
SELECT * FROM Movie_Room ;
SELECT * FROM Movie ;
SELECT * FROM Room ;
SELECT * FROM Branch ;
SELECT * FROM BranchPhone ;
SELECT * FROM CustomerPhone ;
DESC Customer;
DESC Ticket;
DESC Movie_Room;
DESC Movie;
DESC Room;
DESC Branch;
DESC BranchPhone;
DESC CustomerPhone;
