-- #####SPRINT 1#####

-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT
  CustomerId,
  FirstName,
  LastName,
  Country
FROM Customer
WHERE Country != "USA";

-- Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer WHERE Country = 'Brazil';

-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT
	C.CustomerId AS "#",
  FirstName,
  LastName,
  InvoiceId AS "#Invoice",
	InvoiceDate,
  BillingCountry
FROM Customer C
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE C.Country = "Brazil";


-- Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee WHERE Title IN("Sales Manager");

-- Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT distinct BillingCountry FROM Invoice;

-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT
  E.FirstName,
  E.LastName,
  E.Title,
  I.InvoiceId
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId;


-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT Total,
  C.FirstName,
  C.LastName,
  C.Country,
  E.FirstName,
  E.LastName
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId;


-- How many Invoices were there in 2009 and 2011?
SELECT
  SUM(Total),
  strftime('%Y', InvoiceDate) as InvoiceYear,
  COUNT(Total)
FROM Invoice
WHERE strftime('%Y', InvoiceDate)
IN ('2009')
UNION
SELECT
  SUM(Total),
  strftime('%Y', InvoiceDate) as InvoiceYear,
  COUNT(Total)
FROM Invoice
WHERE strftime('%Y', InvoiceDate)
IN ('2011');



What are the respective total sales for each of those years?
SELECT
  InvoiceDate,SUM(Total)
FROM Invoice WHERE strftime('%Y', InvoiceDate)
BETWEEN "2009" AND "2011"
GROUP BY strftime('%Y', InvoiceDate);


-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(InvoiceLineId) FROM InvoiceLine WHERE InvoiceId = 37;


-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
SELECT
COUNT(InvoiceLineId)
FROM InvoiceLine
GROUP BY (InvoiceId);


-- Provide a query that includes the purchased track name with each invoice line item.
SELECT
  il.InvoiceLineId,
  t.Name as TrackName
FROM InvoiceLine as il
INNER JOIN Track t on il.TrackId = t.TrackId


-- Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT
  il.InvoiceLineId,
  t.Name,
  ar.Name
FROM InvoiceLine il
INNER JOIN Track t on t.TrackId = il.TrackId
INNER JOIN Album al on al.AlbumId = t.AlbumId
INNER JOIN Artist ar on ar.ArtistId = al.ArtistId


-- Provide a query that shows the # of invoices per country.
SELECT
  BillingCountry,
  COUNT(InvoiceId)
FROM Invoice
GROUP BY BillingCountry


-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
SELECT
  p.Name as PlaylistName,
  COUNT(pt.TrackId) as NumberOfTracks
FROM Playlist p
INNER JOIN PlaylistTrack pt on pt.PlaylistId = p.PlaylistId
INNER JOIN Track t on t.TrackId  = pt.TrackId
GROUP BY PlaylistName


-- Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT
  t.Name as TrackName,
  al.Title as AlbumName,
  mt.Name as MediaType,
  g.Name as Genre
FROM Track t
INNER JOIN Album al on al.AlbumId = t.AlbumId
INNER JOIN Genre g on g.GenreId  = t.GenreId
INNER JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId


-- Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT
  InvoiceId,
  COUNT (InvoiceId) as NumberInvoiceLineItem
FROM InvoiceLine
GROUP BY InvoiceId


-- Provide a query that shows total sales made by each sales agent.
SELECT
  e.FirstName || " " || e.LastName as EmployeeName,
  SUM(i.Total) as Sales
FROM Customer c
INNER JOIN Employee e on e.EmployeeId = c.SupportRepId
INNER JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY e.employeeId


-- Which sales agent made the most in sales in 2009?
SELECT
  EmployeeName,
  MAX(Sales) as TopSales
FROM
  (SELECT
      e.FirstName || " " || e.LastName as EmployeeName,
      SUM(i.Total) as Sales
      FROM Customer c
      INNER JOIN Employee e on e.EmployeeId = c.SupportRepId
      INNER JOIN Invoice i on i.CustomerId = c.CustomerId
      WHERE strftime('%Y', i.InvoiceDate) IN ('2009')
      GROUP BY e.employeeId
  )


-- Which sales agent made the most in sales over all?
SELECT
  EmployeeName,
  MAX(Sales) as TopSales
FROM
  (SELECT
      e.FirstName || " " || e.LastName as EmployeeName,
      SUM(i.Total) as Sales
      FROM Customer c
      INNER JOIN Employee e on e.EmployeeId = c.SupportRepId
      INNER JOIN Invoice i on i.CustomerId = c.CustomerId
      GROUP BY e.employeeId
  )


-- Provide a query that shows the count of customers assigned to each sales agent.
SELECT
  e.FirstName || " " || e.LastName as EmployeeName,
  COUNT(c.SupportRepId) as CustomerCount
FROM Customer c
INNER JOIN Employee e on e.EmployeeId = c.SupportRepId
INNER JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY e.employeeId


Provide a query that shows the total sales per country.



-- Which country's customers spent the most?



-- Provide a query that shows the most purchased track of 2013.
SELECT
  TrackName,
  MAX(Sold) as TimesSold
FROM
  (SELECT
      t.Name as TrackName,
      COUNT(il.InvoiceLineId) as Sold
      FROM Invoice i
      INNER JOIN InvoiceLine il on il.InvoiceId= i.InvoiceId
      INNER JOIN Track t on t.TrackId = il.TrackId
      WHERE strftime('%Y', i.InvoiceDate) IN ('2013')
      GROUP BY t.TrackId
  )


-- Provide a query that shows the top 5 most purchased tracks over all.
SELECT
  t.Name as TrackName,
  COUNT(il.InvoiceLineId) as Sold
FROM Invoice i
INNER JOIN InvoiceLine il on il.InvoiceId= i.InvoiceId
INNER JOIN Track t on t.TrackId = il.TrackId
GROUP BY t.TrackId
ORDER BY Sold DESC
LIMIT 5


-- Provide a query that shows the top 3 best selling artists.
SELECT
  ar.Name as ArtistName,
  COUNT(il.TrackId) as TracksSold,
  SUM(il.UnitPrice) as Total
FROM Album al
INNER JOIN Artist ar on ar.ArtistId = al.ArtistId
INNER JOIN Track t on t.AlbumId = al.AlbumId
INNER JOIN InvoiceLine il on il.TrackId = t.TrackId
GROUP BY ArtistName
ORDER BY Total DESC
LIMIT 3


-- Provide a query that shows the most purchased Media Type.
SELECT
  MediaType,
  MAX(TotalSales)
FROM
  (SELECT
      mt.Name as MediaType,
      SUM(t.UnitPrice) as TotalSales
    FROM MediaType mt
    INNER JOIN Track t on t.MediaTypeId = mt.MediaTypeId
    INNER JOIN InvoiceLine il on il.TrackId = t.TrackId
    GROUP BY MediaType
  )
