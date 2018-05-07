# Leads - Branch
SELECT b.branch_name, count(l.lead_ID)
        FROM Lead l, branch b
        WHERE l.branch_id = b.branch_id
        GROUP BY b.branch_id;

# Leads - branch - all
-- SELECT b.branch_name as "Branch Name", count(l.lead_ID)
-- FROM Lead l, branch b
-- WHERE l.branch_id = b.branch_id
-- GROUP BY branch_id;

# Leads - Indusry
SELECT i.industry_name, count(l.lead_ID)
FROM Lead l, industry i
WHERE l.industry_id = i.industry_id AND l.leadStatus_ID  IN (2,4)
GROUP BY i.industry_id

# Leads - Successful leads by year
SELECT leadYear, count(lead_ID)
         FROM lead
         WHERE leadStatus_ID  IN (2,4)
         GROUP BY leadYear
         ORDER BY leadYear ASC

SELECT l.lead_ID, b.branch_name, e.employee_name, i.industry_name, lt.leadType_name, ls.leadStatus_name, l.leadValue, l.leadYear
FROM Lead l
JOIN Branch b ON l.branch_ID = b.branch_ID
JOIN Employee e ON l.marketingRep_ID = e.employee_ID
JOIN Industry i ON l.industry_ID = i.industry_ID
JOIN Lead_type lt ON l.leadType_ID = lt.leadType_ID
JOIN Lead_Status ls ON l.leadStatus_ID = ls.leadStatus_ID
