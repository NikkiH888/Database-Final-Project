/* Actual Costs */
SELECT SUM(actLabor_expense) AS 'labor', SUM(actSubcontractor_expense) AS 'subcontractor', SUM(actMaterial_expense) AS 'material', SUM(actEquipment_expense) AS 'equipment'
FROM ticket

/* Estimated Costs */
SELECT SUM(estLabor_expense) AS 'labor', SUM(estSubcontractor_expense) AS 'subcontractor', SUM(estMaterial_expense) AS 'material', SUM(estEquipment_expense) AS 'equipment'
FROM ticket

/* Total Accuracy */
SELECT SUM(actLabor_expense) AS 'act_labor', SUM(actSubcontractor_expense) AS 'act_subcontractor', SUM(actMaterial_expense) AS 'act_material', SUM(actEquipment_expense) AS 'act_equipment',
SUM(estLabor_expense) AS 'est_labor', SUM(estSubcontractor_expense) AS 'est_subcontractor', SUM(estMaterial_expense) AS 'est_material', SUM(estEquipment_expense) AS 'est_equipment'
FROM ticket

/* Accuracy by Property */
SELECT SUM(actLabor_expense) AS 'act_labor', SUM(actSubcontractor_expense) AS 'act_subcontractor', SUM(actMaterial_expense) AS 'act_material', SUM(actEquipment_expense) AS 'act_equipment',
SUM(estLabor_expense) AS 'est_labor', SUM(estSubcontractor_expense) AS 'est_subcontractor', SUM(estMaterial_expense) AS 'est_material', SUM(estEquipment_expense) AS 'est_equipment'
FROM ticket t
JOIN contract_service cs ON t.contractService_ID = cs.contractService_ID
JOIN contract c ON cs.contract_id = c.contract_ID
WHERE c.property_ID = ""
