/* For tickets overall view */
SELECT ts.ticketStatus_name AS status, COUNT(*)
FROM Ticket t
JOIN Ticket_status ts ON t.ticketStatus_ID = ts.ticketStatus_ID
GROUP BY (ts.ticketStatus_name)

/* For tickets by status table */
SELECT t.id, st.description, e.employee_name, cl.client_name, b.branch_name, co.contractYear
FROM Ticket t
JOIN Contract_service cs ON t.contractService_ID = cs.contractService_ID
JOIN Service_type st ON cs.service_ID = st.serviceType_ID
JOIN Employee e ON t.foreman_ID = e.employee_ID
JOIN Contract co ON cs.contract_ID = co.contract_ID
JOIN Property p ON co.property_ID = p.property_ID
JOIN Client cl ON p.client_ID = cl.client_ID
JOIN Branch b ON p.branch_ID = b.branch_ID
JOIN Ticket_status ts ON t.ticketStatus_ID = ts.ticketStatus_ID
WHERE ts.ticketStatus_name = ""
