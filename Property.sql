# List property,  branch, and address:

SELECT P.property_id, P.property_name, B.branch_name, C.client_name, I.industry_name, A.addresstype, A.addressline, A.city, A.state, A.zipcode
FROM Property P, Branch B,  Client C,  Industry I, Address A
WHERE P.branch_id = B.branch_id AND P.client_id = C.client_id AND P.industry_id = I.industry_id AND P.address_id = A.address_id
ORDER BY P.property_id;
