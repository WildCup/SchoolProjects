------------my project-------------------
--at least one using:
--like -- find workers from Warsaw
select * from Worker
where adress like '%Warsaw%';

-- 'nvl' -- find how much bonuses all workers earnen
select IdWorker, sum(nvl(Bonus,0)) from WorkDuty
group by IdWorker;

--in -- find products which were sold in the amout from the list "biggest amounts for each Type"
select IdProduct from ProductPurchase
where Amount in (select max(Amount) from productpurchase 
                join product on product.idproduct = productpurchase.idproduct
                group by typep);

--between -- show who worked last month
select IdWorked from WorkDuty
where DateW between '01-04-2022' and '30-04-2022' ;

--group function, having -- sum of earning every day last month
select DateP, sum(Price * Amount) from Purchase
join ProductPurchase on ProductPurchase.IdPurchase = Purchase.IdPurchase
join Product on Product.IdProduct = ProductPurchase.IdProduct
group by DateP
having DateP > '01.01.2022';

--exists, any, all, corelated sub-quary
-- find workers who didn't work ever
select IdWorker from Worker w
where not exists (select * from WorkDuty where IdWorker = w.IdWorker);

--any, all -- find workers (who worked in 2022) more then any/all workers (who worked in 2021)
select IdWorker, sum(TimeTo-TimeFrom) from WorkDuty w
where DateW between '01-01-2022' and '31-12-2022'
group by IdWorker
having sum(TimeTo-TimeFrom) > any (select sum(TimeTo-TimeFrom) from WorkDuty
where DateW between '01-01-2021' and '31-12-2021'
group by IdWorker);

--any, all -- find workers who earns more or the same then anyone else/all
select IdWorker, sal from Worker w
where sal >= all (select sal from Worker);

--self join -- wchich products are variant of other product?
select p1.NameP, p2.NameP from Product p1
join Product p2 on p1.IdVariant = p2.IdVariant;

--vertical join with order by -- select all types of products
SELECT typep From Product
UNION
SELECT typep From Product
order by 1;

--find maximum profit possible with every order
select orderP.idorderp, sum(Amount*(Price-PriceBought)) "Profit" from OrderP
join ProductOrder on ProductOrder.IdOrderp = OrderP.IdOrderp
join Product on ProductOrder.IdProduct = Product.IdProduct
group by OrderP.IdOrderP
order by sum(Amount*(Price-PriceBought));

--non-equi join
--not-corelated sub-quary
--10 functionality in total witch will require these quaries


--Triggers
--1. after inserting new person display msg 'New Friend'
set ServerOutput on
create or replace trigger T1
after insert
on person
for each row 
begin 
DBMS_output.put_line('New Friend');  
end;

--2. when new person is inserted set it's id automatically
set serverOutput on 
create or replace trigger T2
before insert on person
for each row
begin
    select nvl(max(idperson)+1,0) into :new.idperson from person;
end;

--3. Don't allow to set price over 300. Display 'That's too expensive!'
set serverOutput on 
create or replace trigger T3
before insert on product
for each row begin
IF :NEW.price > 300
then
    raise_application_error(-20000 , 'That is too expensive!');
  END IF;
end;

--4. Allow setting perscription only to 'Y' or 'N' (yes or no)
set serverOutput on 
create or replace trigger T4
before insert on product
for each row begin
IF :NEW.PRESCRIPTION != 'Y' and :NEW.PRESCRIPTION != 'N'
then
    raise_application_error(-20001 , 'PRESCRIPTION can be only Y or N');
  END IF;
end;

--5. Don't allow to sell for cheaper price then bought
set serverOutput on 
create or replace trigger T5
before insert on product
for each row begin
DECLARE
 oldP productorder.pricebought%type;
 begin
 select pricebought into oldP 
 from productorder where idproduct = :NEW.idproduct;
 end;
IF :NEW.price < oldP
then
    raise_application_error(-20002 , 'A Price is too low');
  END IF;
end;

--6. Don't allow negative value in product purchase
set serverOutput on 
create or replace trigger T6
before insert on PRODUCTPURCHASE
for each row begin
IF :NEW.AMOUNT <= 0
then
    raise_application_error(-20005 , 'Amount has to be positive');
  END IF;
end;

--select
select* from person;
delete from person;
select* from product;
delete from product;
select* from productorder;
select* from worker;

-----------CREATING TABLES ------------------
create table Person
(
    IdPerson NUMBER(38,0),
    NameP VARCHAR2(20 BYTE),
    Surname VARCHAR2(20 BYTE)
);
create table Worker
(
    IdWorker NUMBER(38,0),
    IdPerson NUMBER(38,0), --int references Person,
    Adress VARCHAR2(30 BYTE),
    Salary NUMBER(7,2)
);
create table WorkDuty
(
    IdWorkDuty NUMBER(38,0),--int identity primary key,
    IdWorker NUMBER(38,0), --int references Worker,
    DateW DATE,
    TimeFrom timestamp,
    TimeTo timestamp,
    Bonus NUMBER(7,2)
);
create table Prescription
(
    IdPrescription NUMBER(38,0),
    IdWorkDuty NUMBER(38,0), --int references WorkDuty,
    IdPerson NUMBER(38,0), --int references Person,
    DateP DATE,
    DescriptionP VARCHAR2(10 BYTE) --varchar(50)
);
create table Purchase
(
    IdPurchase NUMBER(38,0),
    IdWorkDuty NUMBER(38,0), --int references WorkDuty,
    IdPrescription NUMBER(38,0), --int references Prescription,
    DateP DATE
);
create table Product
(
    IdProduct NUMBER(38,0),
    IdVariant NUMBER(38,0), --int references Product,
    NameP VARCHAR2(20 BYTE), --varchar(50),
    TypeP VARCHAR2(20 BYTE), --varchar(50),
    Price float(10), --float
    Prescription CHAR(1)
);
create table ProductPurchase
(
    IdProductPurchase NUMBER(38,0),
    IdProduct NUMBER(38,0), --int references Product,
    Amount NUMBER(38,0), --int
    IdPurchase NUMBER(38,0) --int references Purchase
);
create table ProductPrescription
(
    IdProductPrescription NUMBER(38,0),
    IdProduct NUMBER(38,0), --int references Product,
    IdPrescription NUMBER(38,0) --int references Prescription
);
create table Company
(
    IdCompany NUMBER(38,0),
    DescriptionC VARCHAR2(20 BYTE) --varchar(200)
);
create table OrderP
(
    IdOrderP NUMBER(38,0),
    IdWorker NUMBER(38,0), --int references Worker,
    IdCompany NUMBER(38,0), --int references Company,
    DateO DATE
);
create table ProductOrder
(
    IdProductOrder NUMBER(38,0),
    IdProduct NUMBER(38,0), --int references Product,
    Amount NUMBER(38,0),--int,
    IdOrderP NUMBER(38,0),--int references OrderP,
    ProducedDate DATE,
    ExpireDate DATE,
    PriceBought float(10) --float
);

drop table Person;
drop table Worker;
drop table WorkDuty;
drop table Prescription;
drop table Purchase;
drop table Product;
drop table ProductPurchase;
drop table ProductPrescription;
drop table Company;
drop table OrderP;
drop table ProductOrder;

-------------inserting---------------
insert into Person(NameP,Surname)values('Hubert','Hagel');
insert into Person(NameP,Surname)values('Lena','Czerwinska');
insert into Person(NameP,Surname)values('Hu','Tao');
insert into Person(NameP,Surname)values('Qiqi','Seven-Seven');
insert into Person(NameP,Surname)values('Fischl','von Narfidort');
insert into Person(NameP,Surname)values('Amber','Gliding Champion');
insert into Person(NameP,Surname)values('Megumin','Rie Takahashi');
insert into Person(NameP,Surname)values('Kazuma','Sato');

insert into Worker(IdPerson,Adress,Salary)values(0,'Lomianki',9000);
insert into Worker(IdPerson,Adress,Salary)values(1,'Warsaw',4000);
insert into Worker(IdPerson,Adress,Salary)values(2,'Genshin',5500);
insert into Worker(IdPerson,Adress,Salary)values(3,'Genshin',2500);
insert into Worker(IdPerson,Adress,Salary)values(4,'Genshin',3000);
insert into Worker(IdPerson,Adress,Salary)values(7,'Sekai',1200);

insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(0,TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), '8:00','16:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(1,'1-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(1,'2-01-2022','8:00','16:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(1,'7-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(2,'2-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(2,'3-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(3,'3-01-2022','8:00','16:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(3,'4-01-2022','8:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(3,'6-01-2022','8:00','16:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(3,'8-01-2022','8:00','16:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(4,'6-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(5,'5-01-2022','8:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(5,'7-01-2022','8:00','16:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(5,'8-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(5,'8-01-2022','16:00','24:00');
insert into WorkDuty(IdWorker,bonus)values(5,100);
insert into WorkDuty(IdWorker,bonus)values(5,500);
insert into WorkDuty(IdWorker)values(5);

insert into Product(IdProduct,IdVariant,NameP, TypeP, Price, Prescription)values(0, 0,'Jar of Gold','Jar',0,'Y');
insert into Product(IdProduct,IdVariant,NameP, TypeP, Price, Prescription)values(1, 0,'Jar of Gold','Jar',0,'Y');
insert into Product(IdProduct,IdVariant,NameP, TypeP, Price, Prescription)values(2, 1,'Grey Min','Min',2,'N');
insert into Product(IdProduct,IdVariant,NameP, TypeP, Price, Prescription)values(3, 1,'Red Min','Min',2,'N');

-- ProducedDate,ExpireDate
insert into ProductOrder(IdProductOrder,IdProduct,Amount,PriceBought)values(0, 0, 100, 20);
insert into ProductOrder(IdProductOrder,IdProduct,Amount,PriceBought)values(1, 1, 100, 10);
insert into ProductOrder(IdProductOrder,IdProduct,Amount,PriceBought)values(2, 2, 100, 100);

insert into ProductPurchase(IdProductPurchase,IdProduct,Amount,IdPurchase)values(0, 0, 10, 0);
insert into ProductPurchase(IdProductPurchase,IdProduct,Amount,IdPurchase)values(1, 3, 20, 0);

insert into Purchase(IdPurchase,IdWorkDuty,IdPrescription)values(0,0,0);
insert into Purchase(IdPurchase,IdWorkDuty,IdPrescription)values(1,1,1);
insert into Purchase(IdPurchase,IdWorkDuty,IdPrescription)values(1,2,2);