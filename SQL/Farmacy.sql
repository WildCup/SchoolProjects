------------my project------------------- 
--at least one using: 
--like -- find workers from Warsaw
select * from Worker 
where Adress like "%Warsaw";

-- 'nvl' -- find how much bonuses all workers earnen 
select IdWorker, sum(nvl(Bonus,0)) from WorkDuty 
group by IdWorker;

--in -- find products which were sold in the amout from the list "biggest amounts for each Type"
select IdProduct from ProductPurchase
where Amount in (select max(Amount) from ProductPurchase group by TypeP);

--between -- show who worked last month
select IdWorked from WorkDuty
where DateW between '01-04-2022' and '30-04-2022' ;

--group function, having -- sum of earning every day last month
select DateP, sum(Prise * Amount) from Purchase 
join ProductPurchase on ProductPurchase.IdPurchase = Purchase.IdPurchase
join Product on Product.IdProduct = ProductPurchase.IdProduct
group by DateP 
having DateP > '01.01.2022';

--exists, any, all -- find workers who didn't work ever
select IdWorked from Worker w
where not exists (select * from WrokDuty where IdWorker = w.IdWorker);

--any, all -- find workers (who worked in 2022) more then any/all workers (who worked in 2021)
select IdWorked, sum(TimeTo-TimeFrom) from WorkDuty w
where DateW between '01-01-2022' and '31-12-2022'
group by IdWorked
having sum(TimeTo-TimeFrom) > any (select sum(TimeTo-TimeFrom) from WorkDuty
                                    where DateW between '01-01-2021' and '31-12-2021'
                                    group by IdWorked);

--self join -- wchich products are variant of other product?
select * from Product 
where idVariant is not null;

--order by -- select all workers order by salary
select * from Worker
order by Salary;

--find maximum profit possible with every order
select OrderP.IdOrderP, sum(Amount*(Price-PriceBought)) "Profit" from OrderP
join ProductOrder on ProductOrder.IdOrder = OrderP.IdOrder
join Product on ProductOrder.IdProduct = Product.IdProduct
group by IdOrderP
order by sum(Amount*(Price-PriceBought));


--corelated sub-quary 
--non-equi join, vertical join with order by 
--not-corelated sub-quary 
--10 functionality in total witch will require these quaries







-----------CREATING TABLES ------------------
create table Person
(
    IdPerson int identity primary key,
    NameP varchar(50),
    Surname varchar(50)
)
create table Worker
(
    IdWorker int identity primary key,
    IdPerson int references Person,
    Adress varchar(50),
    Salary int
)
create table WorkDuty
(
    IdWorkDuty int identity primary key,
    IdWorker int references Worker,
    DateW date,
    TimeFrom date
    TimeTo date,
    Bonus int
)
create table Prescription
(
    IdPrescription int identity primary key,
    IdWorkDuty int references WorkDuty,
    IdPerson int references Person,
    DateP date,
    DescriptionP varchar(50)
)
create table Purchase
(
    IdPurchase int identity primary key,
    IdWorkDuty int references WorkDuty,
    IdPrescription int references Prescription,
    DateP date
)
create table Product
(
    IdProduct int identity primary key,
    IdVariant int references Product,
    NameP varchar(50),
    TypeP varchar(50),
    Price float,
    Prescription boolean
)
create table ProductPurchase
(
    IdProductPurchase int identity primary key,
    IdProduct int references Product,
    Amount int,
    IdPurchase int references Purchase
)
create table ProductPrescription
(
    IdProductPrescription int identity primary key,
    IdProduct int references Product,
    IdPrescription int references Prescription
)
create table Company
(
    IdCompany int identity primary key,
    DescriptionC varchar(200)
)
create table OrderP
(
    IdOrderP int identity primary key,
    IdWorker int references Worker,
    IdCompany int references Company,
    DateO date
)
create table ProductOrder
(
    IdProductOrder int identity primary key,
    IdProduct int references Product,
    Amount int,
    IdOrderP int references OrderP
    ProducedDate date,
    ExpireDate date,
    PriceBought float
)
-------------inserting---------------
insert into Person(NameP,Surname)values('Hubert','Hagel');
insert into Person(NameP,Surname)values('Lena','Czerwi?ska');
insert into Person(NameP,Surname)values('Hu','Tao');
insert into Person(NameP,Surname)values('Qiqi','Seven-Seven');
insert into Person(NameP,Surname)values('Fischl','von Luftschloss Narfidort');
insert into Person(NameP,Surname)values('Amber','Gliding Champion');
insert into Person(NameP,Surname)values('Megumin','Rie Takahashi');
insert into Person(NameP,Surname)values('Kazuma','Sato');

insert into Worker(IdPerson,Adress,Salary)values(0,'?omianki',9000);
insert into Worker(IdPerson,Adress,Salary)values(1,'Warsaw',4000);
insert into Worker(IdPerson,Adress,Salary)values(2,'Genshin',5500);
insert into Worker(IdPerson,Adress,Salary)values(3,'Genshin',2500);
insert into Worker(IdPerson,Adress,Salary)values(4,'Genshin',3000);
insert into Worker(IdPerson,Adress,Salary)values(7,'Sekai',1200);

insert into WorkDuty(IdWorker,DateW,TimeFrom,TimeTo)values(0,'1-01-2022','8:00','16:00');
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
