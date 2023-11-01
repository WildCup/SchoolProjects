INSERT INTO patient VALUES
(1, 'AAMITH',  'Moso',     current_date);
INSERT INTO patient VALUES
(2, 'Lena',  'Czerwi?ska',     current_date);
INSERT INTO patient VALUES
(3, 'Adaw',  'Twawza',     TO_DATE('2008/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO patient VALUES
(4, 'AAMITH',  'Zioa',     current_date);
INSERT INTO patient VALUES
(5, 'Lena',  'Czerwi?ska',     current_date);
INSERT INTO patient VALUES
(6, 'Adaw',  'Bawawy',     TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));

INSERT INTO doctor VALUES
(1, 'Age',  'Mwea',     'laryngologist',8000);
INSERT INTO doctor VALUES
(2, 'Hubert',  'Hagel',     'mentalogist',9999);
INSERT INTO doctor VALUES
(3, 'Yesw',  'Tass',     'mentalogist',5000);
INSERT INTO doctor VALUES
(4, 'Ywa',  'Dupa',     null,32000);
INSERT INTO doctor VALUES
(6, 'Eedsza',  'Wswee',     'laryngologist',32000);

INSERT INTO visit VALUES
(1, 2, current_date, 'bad', 400  );
INSERT INTO visit VALUES
(1, 1, current_date,'cool',600);
INSERT INTO visit VALUES
(5, 3, TO_DATE('2016/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'marvelous', 1200  );
INSERT INTO visit VALUES
(4, 1, TO_DATE('2012/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),'shit',6000);

select * from patient;
select * from visit;
select * from doctor;

--1. List the names and last names of patients born in 1980. The result should be: Last name and first name
--in one field, labeled with the heading "Patient". The result should be sorted in ascending order by last
--name.
select lastname || ' ' || firstname Patient from patient
where extract(year from birthdate) = 2021
order by lastname;

--2. List the details of all visits to ophthalmologists in the form of: patient's first name, patient's last name,
--doctor's first name, doctor's last name, price.
select p.firstname, p.lastname, d.firstname, d.lastname, price from visit v
join patient p on v.idpatient = p.idpatient 
join doctor d on v.iddoctor = d.iddoctor;

--3. List all data of patients who had an appointment with the laryngologist in 2008.
select * from visit v
join patient p on v.idpatient = p.idpatient 
join doctor d on v.iddoctor = d.iddoctor 
and specialization = 'laryngologist'
and extract(year from DATE) = 2021; --error

--4. Select patients data whose surname starts with the letter "A" and does not contain the letter "z".
select * from patient
where lastname LIKE 'A%' or lastname not LIKE '%z%';

--5. List the patient's name, doctor's name, date, price of the visit. Include doctors who have not had an
--appointment yet. Order the data according date of the visit, starting from the newest.
select p.firstname, d.firstname, date, price from visit v
join patient p on v.idpatient = p.idpatient 
right join doctor d on v.iddoctor = d.iddoctor
order by date desc;

select * from visit;
select date from visit; --wtf why error 
select firstname, 'date', price from visit v
join patient p on v.idpatient = p.idpatient 

--6. Find all doctors who do not have specialization. Sort the data by the last name and first name of the
--doctor
select * from doctor
where specialization is null
order by lastname, firstname;