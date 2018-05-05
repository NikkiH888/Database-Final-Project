# Find a manager who works for a branch
SELECT B.branch_id, B.branch_name, E.employee_name  
FROM Branch B, Employee E
WHERE E.employee_ID = B.branchmanager_id
ORDER BY B.branch_id;

# List employee and the branch he/she works for
SELECT E.employee_id, E.employee_name, B.branch_name
FROM Employee E, Branch B
WHERE E.branch_id = B.branch_id
ORDER BY E.employee_id;



