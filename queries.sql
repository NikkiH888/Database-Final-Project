// Expenses by type

SELECT SUM(actLabor_expense) as "Actual Labor Total EXP”,
       SUM(estLabor_expense) as "Estimated Labor Total EXP",
       SUM(actSubcontractor_expense) as "Acutal Subcontractor Total EXP",
       SUM(estSubcontractor_expense) as "Estimated Subcontractor Total EXP",
       SUM(actMaterial_expense)  as "Actural Material Total EXP",
       SUM(estMaterial_expense)  as "Estimated Material Total EXP",
       SUM(actEquipment_expense) as "Actual Equipment Total EXP",
       SUM(estEquipment_expense) as "Estimated Equipment Total EXP"
  FROM Ticket

// Tickets pending approval

SELECT count(ticketStatus_ID) as Pending
FROM name.ticket
WHERE ticketstatus = (SELECT ticketstatus_id FROM name.ticket_status WHERE ticket_name = 'Approved');

// Sales by Person (top 10)

SELECT employee_name as name, completed_leads
FROM name.employee
WHERE position_type = 'Sales'
ORDER BY completed_leads DESC
LIMIT 10;

// Show by Branch

SELECT branch_id as Branch, employee_name as Name, completed_leads
FROM name.employee
WHERE position_type = 'Sales'
ORDER BY complete_leads DESC
GROUP BY branch_id;

// Top 10 Profitable Contracts (right now) - change to properties

SELECT p.property_ name as 'Property', (c.contractprice - c.estimatedcost)/c.contractprice as 'Gross_Margin'
FROM contract c 
JOIN property p ON c.property_id = p.property_id
ORDER BY Gross_Margin DESC
LIMIT 10;

// Billed Tickets (completed tickets) (all tickets, filter later for forecasted/actual)

SELECT f.foreman_name as 'Foreman', c.company_name as 'Company', b.branch_name as 'Branch', [year function from t.completedtime], t.act_Ticket_price as 'Billed'
FROM ticket t
JOIN property p ON t.property_id = p.property_id
JOIN company c ON c.company_id = t.company_id
JOIN branch b ON t.branch_id = b.branch_id
JOIN foreman f ON t.foreman_id = f.foreman_id
JOIN ticket_status ts ON t.ticketstatus_id = ts.ticketstatus_id;

/* Purchase Orders */
SELECT po.id AS 'Purchase Order ID', ps.name AS 'Status'
FROM purchase_orders po
JOIN purchase_statuses ps ON po.purchase_status_id = ps.id

/* Issues */
SELECT i.id AS 'Issue ID', is.name AS 'Status', f.name AS 'Foreman', c.name AS 'Company'
FROM issues i
JOIN issue_statuses is ON i.issue_status_id = is.id
LEFT JOIN foremen f ON i.assigned_foreman_id = f.id
JOIN properties p ON i.property_id = p.id
JOIN companies c ON p.company_id = c.id
