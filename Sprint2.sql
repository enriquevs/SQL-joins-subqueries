-- #####SPRINT 2#####
-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.
SELECT * FROM Invoice i
JOIN InvoiceLine il ON il.invoiceId = i.invoiceId
WHERE il.UnitPrice > 0.99;

-- Get the InvoiceDate, customer FirstName and LastName, and Total from all invoices.
SELECT i.InvoiceDate, c.FirstName, c.LastName, i.Total
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId

-- Get the customer FirstName and LastName and the support rep's FirstName and LastName from all customers.
SELECT c.FirstName, c.LastName, e.FirstName, e.LastName
FROM Customer c
JOIN Employee e ON c.SupportRepId = e.EmployeeId;

-- Support reps are on the Employee table.
-- Get the album Title and the artist Name from all albums.
SELECT al.Title, ar.Name
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId;

-- Get all PlaylistTrack TrackIds where the playlist Name is Music.
SELECT pt.TrackId
FROM PlaylistTrack pt
JOIN Playlist p ON p.PlaylistId = pt.PlaylistId
WHERE p.Name = 'Music';

-- Get all Track Names for PlaylistId 5.
SELECT t.Name
FROM Track t
JOIN PlaylistTrack pt ON pt.TrackId = t.TrackId
WHERE pt.PlaylistId = 5;

-- Get all Track Names and the playlist Name that they're on.


-- Get all Track Names and Album Titles that are the genre "Alternative".
SELECT t.Name, a.title
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Genre g ON g.GenreId = t.GenreId
WHERE g.Name = "Alternative";
