SELECT ps.status_name AS 'status', COUNT(*) AS 'count'
FROM PurchaseOrder po
JOIN Purchase_status ps ON po.purchaseStatus_ID = ps.purchaseStatus_ID
GROUP BY (ps.status_name)

SELECT po.po_id, v.vendor_name, ps.status,
b.branch_name, po.created_by_user_code, po.submitted_on,
po.estimated_delivery_date, po.is_fully_allocated
FROM PurchaseOrder po
JOIN Vendor v ON po.vendor_ID = v.vendor_ID
JOIN Purchase_status ps ON po.purchaseStatus_ID = ps.purchaseStatus_ID
JOIN Branch b ON po.branch_ID = b.branch_ID
WHERE ps.status = 'Complete'
LIMIT 500
