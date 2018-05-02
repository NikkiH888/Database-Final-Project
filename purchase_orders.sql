SELECT ps.status_name AS 'status', COUNT(*) AS 'count'
FROM PurchaseOrder po
JOIN Purchase_status ps ON po.purchaseStatus_ID = ps.purchaseStatus_ID
GROUP BY (ps.status_name)

SELECT po.id, v.vendor_name AS 'vendor', ps.status_name AS 'purchase_status',
b.branch_name AS 'branch', po.createdByUserCode, po.submittedDateTime,
po.estimatedDeliveryDateTime, po.approvedDate, po.isFullyAllocated
FROM PurchaseOrder po
JOIN Vendor v ON po.vendor_ID = v.vendor_ID
JOIN Purchase_status ps ON po.purchaseStatus_ID = ps.purchaseStatus_ID
JOIN Branch b ON po.branch_ID = b.branch_ID
WHERE ps.status_name = ""
