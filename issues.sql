SELECT is.issueStatus_name AS 'status', COUNT(*) AS 'count'
FROM Issues i
JOIN Issue_status is ON i.issueStatus_ID = is.issueStatus_ID
GROUP BY (is.issueStatus_name)

SELECT i.id, is.issueStatus_name AS 'status', e.employee_name, p.property_name, it.issueType_code, priority.priority_name
FROM Issues i
JOIN Issue_status is ON i.issueStatus_ID = is.issueStatus_ID
JOIN Employee e ON i.assignedForeman_ID = e.employee_ID
JOIN Property p ON i.property_ID = p.property_ID
JOIN Issue_type it ON i.issueType_ID = it.IssueType_ID
JOIN Priority priority ON i.issuePriority_ID = priority.issuePriority_ID
WHERE is.issueStatus_name = ""
