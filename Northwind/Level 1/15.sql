-- Find category names that contain a comma in their description.

SELECT CategoryName, Description
FROM Categories
WHERE Description LIKE '%,%'