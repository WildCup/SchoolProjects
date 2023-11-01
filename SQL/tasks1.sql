--1.	Select the department numbers, employee names, and employee numbers of their bosses from the EMP table.
select DEPTNO, EMPNO, MGR from emp
--2.	Select all columns in the EMP table.
select * from emp
--3.	Calculate the annual basic salary for each employee.
select EMPNO, SAL *12 from emp
--4.	Calculate the annual base salary for each employee if each was given a 250 raise.
select EMPNO, (SAL+250) *12 from emp
--5.	Label the selected SAL * 12 expression with the heading ANNUAL.
select EMPNO, SAL *12 ANNUAL from emp
--6.	Label the selected SAL * 12 expression with the header R PENSION.
select EMPNO, SAL *12 R_PENSION from emp
--7.	Combine EMPNO and last name with header EMPLOYEE.
select EMPNO || ' ' || ENAME EMPLOYEE from emp;
select cast(EMPNO as varchar)+' '+ENAME EMPLOYEE from emp; --wrong?
--8.	Create a query returning a result in the form, for example, "Kowalski works in department 20".
select ENAME || ' works in department ' || DEPTNO QUERY from emp
--9.	Calculate the annual total salary for each employee (including commission).
select EMPNO, (SAL+NVL(COMM,0)) *12 from emp;
select EMPNO, (SAL+ISNULL(COMM,0)) *12 from emp; --wrong?
--10.	Display all the department numbers listed in the EMP table.
select DEPTNO from emp
--11.	Display all the different department numbers listed in the EMP table.
select DISTINCT DEPTNO from emp
--12.	Select all mutually different combinations of DEPTNO and JOB values.
select DISTINCT DEPTNO, JOB from emp
--13.	Sort all EMP table data by ENAME.
select * from emp
order by ENAME
--14.	Sort all EMP table data in descending order by the date they were hired starting with the last hires.
select * from emp
order by HIREDATE DESC
--15.	Sort the EMP table data by increasing DEPTNO column values and decreasing SAL column values (without listing the SAL column).
select * from emp
order by DEPTNO ASC, SAL DESC
--without SAL
select EMPNO, ENAME,JOB,MGR,HIREDATE,COMM,DEPTNO from emp
order by DEPTNO ASC, SAL DESC
--16.	Select the names, numbers, positions and department numbers of all employees working in the CLERK position.
select EMPNO,ENAME,JOB,DEPTNO from emp
where JOB = 'CLERK'
--17.	Select all department names and numbers greater than 20.
select JOB,DEPTNO from emp
where DEPTNO>20
--18.	Select employees whose commission exceeds the monthly salary.
select * from emp 
where COMM>SAL
--19.	Select the data of those employees whose earnings are between 1000 and 2000.
select * from emp 
where SAL+NVL(COMM,0)> 1000 AND SAL+NVL(COMM,0)< 2000
--20.	Select data of employees whose direct bosses are 7902.7566 or 7788.
select * from emp 
where MGR = 7902 OR MGR = 7566 OR MGR = 7788
--second method
select * from emp 
where MGR in(7902,7566,7788)
--21.	Select the details of those employees whose surnames begin with S.
select * from emp 
where SUBSTR(ENAME,0,1) = 'S'
--22.	Select the data of those employees whose names are four letters.
select * from emp 
where LENGTH(ENAME) = 4
--23.	Select the data of those employees who do not have a boss.
select * from emp 
where MGR is null
--24.	Select the data of those employees whose earnings are outside the range <1000.2000>.
select * from emp 
where SAL+NVL(COMM,0) <1000 or SAL+NVL(COMM,0) >2000
order by SAL+NVL(COMM,0)
--25.	Select the details of those employees whose surnames do not start with M.
select * from emp 
where SUBSTR(ENAME,0,1) != 'M'
--26.	Select the data of those employees who have a boss.
select * from emp 
where MGR is not null
--27.	Select the data of those employees working on the position of CLERK whose SAL earnings are in the range <1000.2000).
select * from emp 
where SAL>=1000 and SAL<2000 and JOB = 'CLERK'
--28.	Select the data of employees working in the position of CLERK or those whose SAL earnings are in the range <1000.2000).
select * from emp 
where (SAL>=1000 and SAL<2000) or JOB = 'CLERK'
--29.	Select all employees of the MANAGER position with a salary above 1500 and all employees of the SALESMAN position, 
--regardless of salary.
select * from emp 
where (JOB = 'MANAGER' and SAL>1500) or JOB = 'SALESMAN'
order by JOB
