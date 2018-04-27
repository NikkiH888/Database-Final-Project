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

SELECT TotalCostEstimate, ActualCostEstimate
FROM Contracts
GROUP BY ContractYear;

SELECT ContractYear, (Select ActualCostEstimate From Contracts Group by ContractYear)/(Select SalePrice From Contracts Group by ContractYear) as Contribution_Margin
FROM Contracts
ORDER BY ContractYear Desc;
