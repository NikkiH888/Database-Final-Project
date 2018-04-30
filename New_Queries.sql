SELECT AddressType/Count(*) as Address_Type
FROM Address
Group BY AddressType;

Select AddressType, State
FROM Address
Group BY Address Type
ORDER BY State;

SELECT s.contractID, t.title, s.occurences
FROM ContractServices s
JOIN ServiceType t ON s.contractservice_ID = t.contractservice_ID;

# Gross Profit Margin - showing totals for estimated costs and actual costs
SELECT TotalCostEstimate, ActualCostEstimate
FROM Contracts
GROUP BY ContractYear;

# Gross Profit Margin - Showing profit margins from contracts for each year.
SELECT ContractYear, 1 - ((Select sum(ActualCostEstimate) From Contracts Group by ContractYear)/(Select sum(sale_price) From Contracts Group by ContractYear)) as Contribution_Margin
FROM Contracts
ORDER BY ContractYear Desc;

# Leads - Branch
SELECT b.branch_name as "Branch Name", count(l.lead_ID)
FROM Lead l, branch b
WHERE l.branch_id = b.branch_id AND l.leadStatus_ID  IN (2,4)
GROUP BY branch_id;

# Leads - branch - all
SELECT b.branch_name as "Branch Name", count(l.lead_ID)
FROM Lead l, branch b
WHERE l.branch_id = b.branch_id
GROUP BY branch_id;

# Leads - Indusry
SELECT b.branch_name as "Branch Name", count(l.lead_ID)
FROM Lead l, industry i
WHERE l.industry_id = i.industry_id AND l.leadStatus_ID  IN (2,4)
GROUP BY industry_id;

# Leads - Successful leads by year
SELECT leadYear, count(lead_id)
FROM lead
WHERE leadStatus_ID IN (2,4)

SELECT * FROM Lead;


