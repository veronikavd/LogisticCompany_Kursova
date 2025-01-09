CREATE VIEW OrderDetailsWithClientAndShipment AS
SELECT 
    od.OrderID,
    c.ClientName,
    g.GoodName,
    od.Quantity,
    s.DepartureDate,
    s.ArrivalDate,
    s.Status AS ShipmentStatus
FROM 
    OrderDetails od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Clients c ON o.ClientID = c.ClientID
INNER JOIN Goods g ON od.GoodID = g.GoodID
LEFT JOIN Shipments s ON o.OrderID = s.OrderID;

CREATE VIEW PendingOrders AS
SELECT 
    o.OrderID,
    c.ClientName,
    o.OrderDate
FROM 
    Orders o
INNER JOIN Clients c ON o.ClientID = c.ClientID
WHERE 
    NOT EXISTS (SELECT 1 FROM Shipments s WHERE s.OrderID = o.OrderID);

CREATE VIEW WarehouseLoad AS
SELECT 
    w.WarehouseName,
    SUM(g.Weight) AS TotalWeight,
    w.Capacity
FROM 
    Warehouses w
INNER JOIN Goods g ON w.WarehouseID = g.WarehouseID
GROUP BY 
    w.WarehouseName, w.Capacity;
