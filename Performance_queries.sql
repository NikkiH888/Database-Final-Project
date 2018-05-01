# Gross Profit Margin - showing totals for estimated costs and actual costs
SELECT TotalCostEstimate, ActualCostEstimate
FROM Contracts
GROUP BY ContractYear;

# Gross Profit Margin - Showing profit margins from contracts for each year.
SELECT ContractYear, 1 - ((Select sum(ActualCostEstimate) From Contracts Group by ContractYear)/(Select sum(sale_price) From Contracts Group by ContractYear)) as Contribution_Margin
FROM Contracts
ORDER BY ContractYear Desc;
