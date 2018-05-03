# Company Performance -> Net_income = revenue - cost | Net_sales = revenue | Profit Margin = (net_income/net_sales)
 SELECT (SUM(sale_price) - SUM(actualCost)) AS "Net Income", 
          SUM(sale_price) AS "Net Sales", 
           (SUM(sale_price) - SUM(actualCost)) / SUM(sale_price) AS "Profit Margin"                     
 FROM Contract;

 # Company Performance - Retrieve the total revenue & expense of the company each year
 SELECT contractYear, SUM(sale_price), SUM(actualCost)
 FROM Contract 
 GROUP BY contractYear
 Order BY ContractYear ASC;
                                   
# Company Performance - get the min and max year                           
SELECT MIN(contractYear), MAX(contractYear)
FROM contract;
 
SELECT B.Branch_ID, C.contractYear, SUM(sale_price),  SUM(actualCost)
FROM Contract C, Property P,  Branch B
WHERE C.property_ID = P.property_ID AND P.branch_ID = B.branch_ID
GROUP BY B.Branch_ID, C.contractYear;
 
-- # Gross Profit Margin - showing totals for estimated costs and actual costs
-- SELECT TotalCostEstimate, ActualCostEstimate
-- FROM Contracts
-- GROUP BY ContractYear;

# Contribution Margin - Showing profit margins from contracts for each year.
SELECT ContractYear, 1 - ((Select sum(ActualCostEstimate) From Contracts Group by ContractYear)/(Select sum(sale_price) From Contracts Group by ContractYear)) as Contribution_Margin
FROM Contracts
ORDER BY ContractYear Desc;
