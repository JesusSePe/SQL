/*1.
Busca la llista de cançons (TRACK) que ha comprat en Camille Bernard
(CUSTOMER). La llista ha de tenir: nom de la cançó i genere (1 punt).*/
SELECT t.Name, g.Name
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE i.CustomerId = (
						SELECT CustomerId
                        FROM Customer 
                        WHERE FirstName = "Camille" 
                        AND LastName = "Bernard"
                        );
                        
/*2.
De les cançons comprades per Camille Bernard, agrupa-les per genere i digues
quantes n'hi ha de cada. Indica el nom del genere(GENRE) i la quantitat (1 punt).*/
SELECT g.Name, count(t.Name)
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE i.CustomerId = (
						SELECT CustomerId
                        FROM Customer 
                        WHERE FirstName = "Camille" 
                        AND LastName = "Bernard"
                        )
GROUP BY g.Name;

/*3.
Busca les cançons que s'han comprat més d'una vegada (INVOICELINE). Llista el
nom de la cançó i la quantitat de vegades que s'ha comprat(1 punt).
*/
SELECT Name, sum(Quantity)
FROM InvoiceLine il 
INNER JOIN Track t ON il.TrackId = t.TrackId
GROUP BY il.TrackId
HAVING sum(Quantity) > 1;

/*4.
Cerca quants minuts de música disposem del compositor Johann Sebastian Bach.
(TRACK composer) (1 punt).
1 minute = 60 000 milliseconds
*/
SELECT Name, (milliseconds/60000) AS 'Minutes' 
FROM Track 
WHERE composer = 'Johann Sebastian Bach';

/*5.
Troba el nom dels artistes que coincideix amb el nom d’alguna cançó d’un altre
artista.(2 punts).
*/
SELECT ar.Name AS 'Artist Name', t.composer AS 'Composer Name'
FROM Track t, Artist ar
WHERE ar.Name like t.name AND ar.Name != t.Composer;
