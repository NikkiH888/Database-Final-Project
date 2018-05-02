/* For issues overall view */
SELECT iss.issueStatus_name AS status, COUNT(*) AS count
FROM Issues i
JOIN Issue_status iss ON i.issueStatus_ID = iss.issueStatus_ID
GROUP BY (iss.issueStatus_name)

/* For issues tables */
SELECT i.id, is.issueStatus_name AS 'status', e.employee_name, p.property_name, it.issueType_code, priority.priority_name, i.dueDate
FROM Issues i
JOIN Issue_status is ON i.issueStatus_ID = is.issueStatus_ID
JOIN Employee e ON i.assignedForeman_ID = e.employee_ID
JOIN Property p ON i.property_ID = p.property_ID
JOIN Issue_type it ON i.issueType_ID = it.IssueType_ID
JOIN Priority priority ON i.issuePriority_ID = priority.issuePriority_ID
WHERE is.issueStatus_name = ""

/* For priority levels pie chart */
SELECT p.priority_name AS 'priority', COUNT(*) AS 'count'
FROM Issues i
JOIN Priority p ON i.issuePriority_ID = p.issuePriority_ID
JOIN Issue_status is ON i.issueStatus_ID = is.issueStatus_ID
WHERE is.issueStatus_name = "
