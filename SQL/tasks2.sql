select * from emp;
select * from dept;
select * from salgrade;
--1. Combine the data from the EMP and DEPT tables with a join condition in WHERE.
select * from emp, dept
where emp.deptno = dept.deptno;
--2. Combine data from the EMP and DEPT tables with INNER JOIN.
select * from emp
inner join dept on emp.deptno = dept.deptno;
--3. Select the names and department names of all employees in alphabetical order.
select ename, dname from emp
join dept on  emp.deptno = dept.deptno
order by ename;
--4. Select the names of all employees along with the numbers and names of the departments in which they are employed.
select ename, dname, emp.deptno from emp
left join dept on  emp.deptno = dept.deptno;
--5. For employees with a monthly salary over 1500, give their names, the location of their departments and the names of these departments.
select ename, dname, loc from emp
join dept on emp.deptno = dept.deptno
where sal > 1500;
--6. Create a list of employees by name, occupation, salary, and grade.
select * from emp
order by ENAME, JOB, SAL, EMPNO;
--7. Select information on employees whose wages correspond to earnings grade 3.
select * from emp
join salgrade on sal>losal and sal<hisal
where grade = 3;
--7. 2nd method
select * from emp
join salgrade on sal between losal and hisal
where grade = 3;
--8. Select employees working in Dallas.
select * from emp
join dept on emp.deptno = dept.deptno
where loc = 'DALLAS';
--9. Select the names of the employees, names of departments and grades.
select ename, dname, grade from emp
join dept on emp.deptno = dept.deptno
join salgrade on sal>losal and sal>hisal;
--10. List the details of all departments and their employees so that the department details appear, even if there is no employee in the department.
select * from emp
right join dept on emp.deptno = dept.deptno;
--11. List the data of all departments and their employees so that the employee's data appears, even if the employee is not assigned to the department.
select * from emp
left join dept on emp.deptno = dept.deptno;
--17. List each employee's name and the name of their boss. Sort by boss name.
select e1.ename, e2.ename BossName from emp e1
join emp e2 on e1.mgr = e2.empno
order by e2.ename;
