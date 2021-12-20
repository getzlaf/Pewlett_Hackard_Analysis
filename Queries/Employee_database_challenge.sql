-- Challenge
SELECT employees.emp_no,
		employees.first_name,
		employees.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirees_titles
FROM employees 
	INNER JOIN titles AS t
		ON (employees.emp_no = t.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
        rt.first_name,
        rt.last_name,
        rt.title
INTO unique_titles
FROM retirees_titles AS rt
ORDER BY emp_no, to_date DESC;
SELECT * FROM unique_titles
-- Creation of retiring_titles table
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;
SELECT * FROM retiring_titles ; 
-- Creation of Mentorship table
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
		employees.first_name,
		employees.last_name,
        employees.birth_date
		dept_emp.from_date,
		dept_emp.to_date,
        titles.title
INTO mentorship_table
FROM employees 
	INNER JOIN dept_emp 
		ON (employees.emp_no = dept_emp.emp_no)
            INNER JOIN titles
                ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (dept_emp.to_date = '9999-01-01')
ORDER BY emp_no ASC;
SELECT * FROM mentorship_table