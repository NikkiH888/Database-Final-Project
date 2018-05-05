# Find a manager who works for a branch
SELECT B.branch_id, B.branch_name, E.employee_name  
FROM Employee E, Branch B 
WHERE E.employee_ID = B.branchmanager_id;
