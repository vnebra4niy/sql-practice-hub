-- Show names and addresses of suppliers' websites

SELECT ContactName, Address, HomePage
FROM Suppliers
WHERE HomePage IS NOT NULL