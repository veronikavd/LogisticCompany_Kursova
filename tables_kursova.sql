-- 1. ������� "�����������"
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(50) NOT NULL CHECK (Role IN ('admin', 'manager', 'customer'))
);

-- 2. ������� "�볺���"
CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    ClientName VARCHAR(150) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address TEXT,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- 3. ������� "���������� ������"
CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleType VARCHAR(50) NOT NULL,
    RegistrationNumber VARCHAR(50) UNIQUE NOT NULL,
    Capacity DECIMAL(10, 2), -- ������� � ������
    Status VARCHAR(50) DEFAULT 'available' CHECK (Status IN ('available', 'in transit', 'maintenance'))
);

-- 4. ������� "��䳿"
CREATE TABLE Drivers (
    DriverID INT IDENTITY(1,1) PRIMARY KEY,
    DriverName VARCHAR(100) NOT NULL,
    LicenseNumber VARCHAR(50) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    VehicleID INT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

-- 5. ������� "������"
CREATE TABLE Warehouses (
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    Location TEXT,
    Capacity DECIMAL(10, 2)
);

-- 6. ������� "������"
CREATE TABLE Goods (
    GoodID INT IDENTITY(1,1) PRIMARY KEY,
    GoodName VARCHAR(100) NOT NULL,
    Weight DECIMAL(10, 2),
    Dimensions VARCHAR(100),
    WarehouseID INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- 7. ������� "����������"
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT,
    OrderDate DATE NOT NULL,
    Status VARCHAR(50) DEFAULT 'pending' CHECK (Status IN ('pending', 'in progress', 'completed', 'canceled')),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- 8. ������� "����� ���������"
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    GoodID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (GoodID) REFERENCES Goods(GoodID)
);

-- 9. ������� "�����"
CREATE TABLE Shipments (
    ShipmentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    VehicleID INT,
    DriverID INT,
    DepartureDate DATE,
    ArrivalDate DATE,
    Status VARCHAR(50) DEFAULT 'scheduled' CHECK (Status IN ('scheduled', 'in transit', 'delivered', 'delayed')),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

-- 10. ������� "���� ��������������"
CREATE TABLE ServiceZones (
    ZoneID INT IDENTITY(1,1) PRIMARY KEY,
    ZoneName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- 11. ������� "��������"
CREATE TABLE Routes (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    StartLocation VARCHAR(150) NOT NULL,
    EndLocation VARCHAR(150) NOT NULL,
    Distance DECIMAL(10, 2), -- ������� � ���������
    ZoneID INT,
    FOREIGN KEY (ZoneID) REFERENCES ServiceZones(ZoneID)
);

-- 12. ������� "������ �����"
CREATE TABLE TariffPlans (
    TariffID INT IDENTITY(1,1) PRIMARY KEY,
    PlanName VARCHAR(100) NOT NULL,
    PricePerKilometer DECIMAL(10, 2),
    AdditionalFees DECIMAL(10, 2)
);

-- 13. ������� "Գ������ ��������"
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionDate DATE NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- 14. ������� "������ ������������ ������"
CREATE TABLE VehicleMaintenance (
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT,
    MaintenanceDate DATE NOT NULL,
    Description TEXT,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

-- 15. ������� "������ ���������"
CREATE TABLE OrderHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    StatusChangeDate DATE NOT NULL,
    PreviousStatus VARCHAR(50) CHECK (PreviousStatus IN ('pending', 'in progress', 'completed', 'canceled')),
    NewStatus VARCHAR(50) CHECK (NewStatus IN ('pending', 'in progress', 'completed', 'canceled')),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
