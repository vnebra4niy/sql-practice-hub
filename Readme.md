# SQL Portfolio Projects

This repository contains my practical SQL exercises and projects completed during self‑study of relational databases.  
All queries are written for Microsoft’s standard sample databases: **Northwind** and **AdventureWorks**.

The goal is to demonstrate SQL proficiency ranging from basic SELECT statements to complex analytical queries, including aggregations, subqueries, various JOINs, grouping, and correlated subqueries.

## Project Structure

```
AdventureWorks/
  └── queries.sql                # Initial queries for AdventureWorks
NorthWind/
  ├── Level 1/
  │   └── queries.sql            # Simple SELECT, filtering, sorting
  ├── Level 2/
  │   └── queries.sql            # Aggregate functions, GROUP BY, HAVING
  ├── Level 3/
  │   └── queries.sql            # Multiple JOINs, basic subqueries
  └── Level 4/
      └── queries.sql            # Correlated subqueries, advanced analytics
```

## Levels Description

### 🔹 Northwind – Level 1 (Basics)
- Single‑table queries (`SELECT`, `WHERE`, `LIKE`, `BETWEEN`)
- Sorting (`ORDER BY`)
- Simple two‑table joins (`INNER JOIN`)

**Example queries:**
- Retrieve customer names and addresses.
- Select products with price between 20 and 30.
- List products supplied by "Tokyo Traders".

### 🔸 Northwind – Level 2 (Aggregation & Grouping)
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` and `HAVING`

**Example queries:**
- Average product price.
- Total value of a specific order (including discount).
- Orders containing more than 5 line items.

### 🔹 Northwind – Level 3 (Multi‑table JOINs & Subqueries)
- Different JOIN types: `INNER JOIN`, `LEFT JOIN`
- Subqueries in `WHERE`, `SELECT`, `FROM`
- `IN`, `NOT IN`, `EXISTS`

**Example queries:**
- Customers who placed no orders in 1997 (`NOT IN`).
- Products priced below the average for their own category (correlated subquery).
- Pairs of employees holding the same job title.

### 🔸 Northwind – Level 4 (Advanced Analytics)
- Correlated subqueries for comparing with group averages
- Calculating differences between product price and category average
- Multi‑level nesting
- Using `DISTINCT` with aggregated conditions
- Monthly maximum order value analysis

**Example queries:**
- For each product: its price, category average, and price difference from category average.
- Customer with the highest total order value in 1996, broken down by month (multi‑level subquery).
- Products bought by more than 20 distinct customers (`COUNT(DISTINCT CustomerID)`).

### 🧩 AdventureWorks (Work in Progress)
Work has started on the more complex `AdventureWorks` database (schemas: `Production`, `Sales`, `Person`). Planned queries include:

- Products with defined color, weight, size.
- Heaviest and lightest product containing "Road" in its name.
- Products priced above the average.
- Average product price per category (using `ProductSubcategory`).
- Total sales per customer and per salesperson.

## Technologies Used
- **RDBMS:** Microsoft SQL Server (local instance)
- **Tools:** SQL Server Management Studio (SSMS), Azure Data Studio
- **Databases:** Northwind, AdventureWorks

## Skills Demonstrated
- Writing complex `SELECT` statements with various `JOIN` types (`INNER`, `LEFT`).
- Using aggregate functions and `GROUP BY` / `HAVING` clauses.
- Scalar and table subqueries, correlated subqueries.
- Filtering with `WHERE` and `HAVING`.
- Date manipulation (`YEAR`, `MONTH`, `DATEPART`).
- Applying `DISTINCT`, `TOP`, `ORDER BY`.
- Calculating financial values (discounts, freight).
- Logical problem decomposition and step‑by‑step query building.

## How to Run
1. Clone this repository.
2. Install SQL Server and restore the `Northwind` and `AdventureWorks` sample databases (`.bak` files available from official Microsoft sources).
3. Open any `queries.sql` file in SSMS and execute the desired query.

## Future Plans
- Complete the AdventureWorks query set.
- Add query optimisation examples (indexes, execution plans).
- Provide explanations and alternative solutions for complex problems.

---
*Author: Mikita Kutsayeu – aspiring data analyst / SQL developer passionate about relational databases and writing efficient, readable queries.*