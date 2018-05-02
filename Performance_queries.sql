# Company Performance -> Net_income = revenue - cost | Net_sales = revenue | Profit Margin = (net_income/net_sales)
 SELECT (SUM(sales_price) - SUM(actualCost)) AS "Net Income", 
          SUM(sales_price) AS "Net Sales", 
           (SUM(sales_price) - SUM(actualCost)) / SUM(sales_price) AS "Profit Margin"                     
 FROM Contract;

 # Company Performance - Retrieve the total revenue & expense of the company each year
 SELECT contractYear, SUM(sales_price), SUM(actualCost)
 FROM Contract 
 GROUP BY contractYear
 Order BY ContractYear ASC;
                                   
# Company Performance - get the min and max year                           
SELECT extract(year from MAX(day))::integer
from sailors S, reserves R, boats B
where S.sid = R.sid AND R.bid=B.bid;
 
 SELECT Branch_ID, SUM(Contract_price)
FROM Property P
INNER JOIN Contract C
ON P.property_ID = C.property_ID
INNER JOIN Branch B
ON B.branch_ID = P.branch_ID
GROUP BY Branch_ID;
 
# Gross Profit Margin - showing totals for estimated costs and actual costs
SELECT TotalCostEstimate, ActualCostEstimate
FROM Contracts
GROUP BY ContractYear;

# Contribution Margin - Showing profit margins from contracts for each year.
SELECT ContractYear, 1 - ((Select sum(ActualCostEstimate) From Contracts Group by ContractYear)/(Select sum(sale_price) From Contracts Group by ContractYear)) as Contribution_Margin
FROM Contracts
ORDER BY ContractYear Desc;
