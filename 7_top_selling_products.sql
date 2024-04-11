SELECT TOP 10 p.Description AS Product, SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.Description
ORDER BY TotalQuantity DESC;


-- this shows that there are clearly some incorrect errors, we will have to fix this in PowerBI