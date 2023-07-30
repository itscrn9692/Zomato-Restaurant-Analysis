Create Database SQLProject;
Use SQLProject;
Create Table salespeople(snum int unique, sname varchar(30), city varchar(30),comm decimal(4,2));
insert into salespeople values (1001,"Peel","London",0.12),(1002,"Serres","San Jose",0.13),(1003,"Axelrod","New York",0.10),
(1004,"Motika","London",0.11),(1007,"Rafkin","Barcelona",0.15);
Select * from salespeople;

Create Table cust(cnum int unique, cname varchar(30), city varchar(30),ratting int,snum int);
insert into cust values (2001,"Hoffman","London",100,1001),(2002,"Giovanne","Rome",200,1003),(2003,"Liu","San Jose",300,1002),
(2004,"Grass","Berlin",100,1002),(2006,"Clemens","London",300,1007),(2007,"Pereira","Rome",100,1004),(2008,"James","London",200,1007);
Select * from cust;

Create Table orders(onum int unique, amt decimal(10,2),odate date, cnum int,snum int);
insert into orders values (3001,18.69,'1994-10-03',2008,1007),(3002,1900.10,'1994-10-03',2007,1004),(3003,767.19,'1994-10-03',2001,1001),(3005,5160.45,'1994-10-03',2003,1002),(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),(3008,4723.00,'1994-10-05',2006,1001),(3009,1713.23,'1994-10-04',2002,1003),(3010,1309.95,'1994-10-06',2004,1002),(3011,9891.88,'1994-10-06',2006,1001);
Select * from orders;

select sp.snum,sp.sname as salesperson_name, c.cnum,c.cname as customer_name from salespeople sp join cust c on sp.city=c.city where sp.snum=c.snum;

select c.cname as customer_name,s.sname as salesperson_name from cust c join salespeople s on c.snum=s.snum;

Select onum from orders as o join cust as c on o.cnum=c.cnum 
Join salespeople as s on s.city != c.city and o.snum=s.snum;

Select onum, cname from cust as c join orders as o on o.cnum=c.cnum;

Select C1.cname as customer1_name,C1.cnum as customer1_cnum,
C1.ratting as ratting,
C2.cname as customer2_name,C2.cnum as customer2_cnum 
from cust as c1 join cust as c2 on C1.ratting=c2.ratting and c1.cnum < c2.cnum; 

SELECT
    s.sname AS salesperson_name,
    c1.cnum AS customer1_num,
    c1.cname AS customer1_name,
    c2.cnum AS customer2_num,
    c2.cname AS customer2_name
FROM salespeople s JOIN cust c1 ON s.snum = c1.snum
JOIN cust c2 ON s.snum = c2.snum AND c1.cnum < c2.cnum
GROUP BY s.sname,c1.cnum,c1.cname,c2.cnum,c2.cname;

SELECT
    sp1.snum AS salesperson1_num,
    sp1.sname AS salesperson1_name,
    sp1.city AS city,
    sp2.snum AS salesperson2_num,
    sp2.sname AS salesperson2_name
FROM salespeople sp1 JOIN salespeople sp2 ON sp1.city = sp2.city AND sp1.snum < sp2.snum;

SELECT
    o.onum,
    c.cnum AS customer_num,
    c.cname AS customer_name,
    s.snum AS salesperson_num,
    s.sname AS salesperson_name
FROM orders o JOIN cust c ON o.cnum = c.cnum
JOIN salespeople s ON c.snum = s.snum
WHERE c.cnum = 2008;

SELECT onum, odate
FROM orders
WHERE amt > (SELECT AVG(amt) FROM orders WHERE odate = '1994-10-04');

Select onum,sname from orders as o join salespeople as s on s.snum=o.snum where s.city="london";

SELECT
    c.cnum AS customer_num,
    c.cname AS customer_name
FROM cust c
JOIN salespeople s ON c.snum = s.snum
JOIN salespeople serres ON serres.sname = 'Serres'
WHERE c.cnum = serres.snum + 1000;

SELECT COUNT(*) AS customer_count
FROM cust
WHERE   ratting > (
        SELECT AVG(ratting)
        FROM cust
        WHERE city = 'San Jose');
        
SELECT
    s.snum AS salesperson_num,
    s.sname AS salesperson_name,
    COUNT(*) AS customer_count
FROM salespeople s
JOIN cust c ON s.snum = c.snum
GROUP BY
    s.snum,
    s.sname
HAVING COUNT(*) > 1;