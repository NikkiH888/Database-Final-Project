SELECT is.issueStatus_name AS 'status', COUNT(*) AS 'count'
FROM Issues i
JOIN Issue_status is ON i.issueStatus_ID = is.issueStatus_ID
GROUP BY (is.issueStatus_name)
