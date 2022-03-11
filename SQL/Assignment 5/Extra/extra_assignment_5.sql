use adventureworks;

-- Exercise 1
-- Question 1
SELECT 
    ProductID, `Name`
FROM
    product
WHERE
    `Name` LIKE '%Saddle';
    
SELECT 
    `Name`
FROM
    product
WHERE
    ProductSubcategoryID = (SELECT 
            ProductSubcategoryID
        FROM
            productsubcategory
        WHERE
            `name` = 'Saddles');

-- Question 2

SELECT 
    `Name`
FROM
    product
WHERE
    ProductSubcategoryID IN (SELECT 
            ProductSubcategoryID
        FROM
            productsubcategory
        WHERE
            `name` LIKE 'Bo%');
-- Question 3
SELECT 
    `Name`
FROM
    product
WHERE
    ListPrice IN (SELECT 
            MIN(ListPrice)
        FROM
            product
        WHERE
            ProductSubcategoryID = 3);

-- Exercise 2
-- Question 1
SELECT 
    cr.`Name` AS Country, sp.`Name` AS Province
FROM
    countryregion cr
        JOIN
    stateprovince sp ON cr.CountryRegionCode = sp.CountryRegionCode;
-- Question 2

SELECT 
    cr.`Name` AS Country, sp.`Name` AS Province
FROM
    countryregion cr
        JOIN
    stateprovince sp ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE
    cr.`Name` = 'Germany'
        OR cr.`Name` = 'Canada'
ORDER BY cr.`Name`;
-- Question 3
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    sp.SalesPersonID,
    sp.Bonus,
    sp.SalesYTD
FROM
    salesperson sp
        JOIN
    salesorderheader soh ON sp.SalesPersonID = soh.SalesPersonID;
-- Question 4

SELECT 
    soh.SalesOrderID, soh.OrderDate, sp.Bonus, sp.SalesYTD
FROM
    salesperson sp
        JOIN
    salesorderheader soh ON sp.SalesPersonID = soh.SalesPersonID
;