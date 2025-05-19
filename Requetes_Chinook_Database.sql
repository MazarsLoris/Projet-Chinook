USE `Chinook`;

/*******************************************************************************
   1. Requêtes de base
********************************************************************************/

-- 1.Clients non américains : Afficher les clients (nom complet, ID, pays) qui ne sont pas aux États-Unis.
select concat(FirstName, ' ', LastName) as FullName, CustomerID, Country -- On peut sélectionner plusieurs colonnes en les séparant par ','.
from customer -- Concat() permet de concatener plusieurs colonnes en une seule.
where Country != 'USA'; -- Permet de ne pas sélectionner les USA

-- 2. Clients brésiliens: Afficher uniquement les clients provenant du Brésil.
select concat( FirstName, ' ', LastName) as FullName, CustomerID, Country
from customer
where Country = 'Brazil';
 
 -- 3. Factures des clients brésiliens: Afficher le nom complet du client, l’ID de la facture, la date de la facture et le pays de facturation.
 select concat(customer.FirstName, ' ', customer.LastName) as FullName, invoice.InvoiceId, invoice.InvoiceDate, invoice.BillingCountry
 from customer -- On définit la table de départ avec le FROM puis on rajoute les colonnes des autres tables avec JOIN
 join invoice -- On effectue une INNER JOIN pour obtenir les lignes présentes dans les deux tables.
 on customer.CustomerId = invoice.CustomerId
 where customer.Country = 'Brazil';
 
-- 4. Agents de vente: Afficher uniquement les employés qui sont des agents de vente.
select concat(FirstName, ' ', LastName) as EmployeeFullName
from employee
where Title = 'Sales Support Agent';

/*******************************************************************************
   2. Agrégations et relations
********************************************************************************/

-- 5. Pays uniques dans les factures: Afficher une liste unique des pays de facturation présents dans la table Invoice.
select distinct(BillingCountry) -- DISTINCT() permet de ne conserver que les valeurs distinctes et donc évite les doublons.
from invoice;

-- 6. Factures par agent de vente: Afficher les factures associées à chaque agent de vente avec leur nom complet.
select concat(employee.FirstName, ' ', employee.LastName) as EmployeeFullName, invoice.InvoiceId
from invoice
join customer -- On commence par faire une première jointure pour croiser les données de Invoice avec les identifiants Clients
on invoice.CustomerId = customer.CustomerId
join employee -- On fait une deuxiéme jointure pour récupérer les employés qui ont généré la factures
on customer.SupportRepId = employee.EmployeeId;

-- 7. Détails des factures: Afficher le total de chaque facture, le nom du client, le pays et le nom de l’agent de vente.
select concat(employee.FirstName, ' ', employee.LastName) as EmployeeFullName, concat(customer.FirstName, ' ', customer.LastName) as CustomerFullName, invoice.InvoiceId, invoice.BillingCountry, invoice.Total
from invoice
join customer
on invoice.CustomerId = customer.CustomerId
join employee
on customer.SupportRepId = employee.EmployeeId;

/*******************************************************************************
   3. Analyse par année et lignes de factures
********************************************************************************/

-- 8. Ventes par année: 
	-- 8.1 Combien de factures en 2021 et 2024 ?
select count(InvoiceId) as NombreFactures, year(InvoiceDate) as Annee
from invoice
where year(InvoiceDate) in (2021, 2024)
group by year(InvoiceDate)
order by Annee;
	-- 8.2 Quels sont les montants totaux des ventes pour ces années ?
select count(InvoiceId) as NombreFactures, year(InvoiceDate) as Annee, sum(Total) as MontantTotal
from invoice
where year(InvoiceDate) in (2021, 2024)
group by year(InvoiceDate)
order by Annee;

-- 9. Articles pour une facture donnée: Compter le nombre d’articles pour la facture ayant l’ID 37.
select  InvoiceId, count(Quantity) as Nombre_Article
from invoiceline
where InvoiceId = 37;

-- 10. Articles par facture: Compter le nombre d’articles pour chaque facture (GROUP BY requis)
select  InvoiceId, count(quantity) as Nombre_Article
from invoiceline
group by (InvoiceId);

/*******************************************************************************
   4. Détails des morceaux
********************************************************************************/

-- 11. Nom des morceaux: Afficher le nom du morceau pour chaque ligne de facture.
select invoiceline.InvoiceId, invoiceline.trackId, track.Name
from invoiceline
left join track
on invoiceline.TrackId = track.TrackId;

-- 12. Morceaux et artistes: Afficher le nom du morceau et le nom de l’artiste pour chaque ligne de facture.
select invoiceline.InvoiceId, invoiceline.trackId, track.Name, track.Composer
from invoiceline
left join track
on invoiceline.TrackId = track.TrackId;

/*******************************************************************************
   5. Comptages et regroupements
********************************************************************************/

-- 13. Nombre de factures par pays: Afficher le nombre de factures par pays (GROUP BY requis).
select  BillingCountry, count(InvoiceId) as Nombre_Factures
from invoice
group by BillingCountry;

-- 14. Nombre de morceaux par playlist: Afficher le nombre total de morceaux dans chaque playlist, avec le nom de la playlist.
select playlist.Name as Playlist, count(*) as NombreMorceaux
from playlist
join playlisttrack 
on playlist.PlaylistId = playlisttrack.PlaylistId
group by playlist.PlaylistId, playlist.Name;

-- 15. Liste des morceaux: Afficher tous les morceaux sans leur ID, en incluant le nom de l’album, le type de média et le genre.
select track.Name, album.Title, mediatype.Name, genre.Name
from track
left join album
on track.AlbumId = album.AlbumId
left join genre
on track.GenreId = genre.GenreId
left join mediatype
on track.MediaTypeId = mediatype.MediaTypeId;

/*******************************************************************************
   6. Analyses des ventes
********************************************************************************/

-- 16. Factures et articles: Afficher toutes les factures avec le nombre d’articles par facture.
select  invoice.InvoiceId, count(invoiceline.quantity) as NombreArticle
from invoice
left join invoiceline
on invoice.InvoiceId = invoiceline.InvoiceId
group by (InvoiceId);

-- 17. Ventes par agent de vente: Afficher les ventes totales réalisées par chaque agent de vente.
select concat(employee.FirstName, ' ', employee.LastName) as NomAgent, sum(invoice.Total) as VentesTotales
from employee
join customer
on employee.EmployeeId = customer.SupportRepId
join invoice
on customer.CustomerId = invoice.CustomerId
group by NomAgent;

-- 19. Meilleur agent de 2022: Quel agent a réalisé le plus de ventes en 2022 ?
select concat(employee.FirstName, ' ', employee.LastName) as NomAgent, sum(invoice.Total) as VentesTotales
from employee
join customer
on employee.EmployeeId = customer.SupportRepId
join invoice
on customer.CustomerId = invoice.CustomerId
where year(invoice.InvoiceDate) = 2022
group by NomAgent
order by VentesTotales desc
limit 1;

-- 20. Meilleur agent global: Quel agent a réalisé le plus de ventes au total ?
select concat(employee.FirstName, ' ', employee.LastName) as NomAgent, sum(invoice.Total) as VentesTotales
from employee
join customer
on employee.EmployeeId = customer.SupportRepId
join invoice
on customer.CustomerId = invoice.CustomerId
group by NomAgent
order by VentesTotales desc
limit 1;

/*******************************************************************************
   7. Analyses des clients et des pays
********************************************************************************/

-- 21. Clients par agent de vente: Afficher le nombre de clients attribués à chaque agent de vente.
select concat(employee.FirstName, ' ', employee.LastName) as NomAgent, count(customer.customerId) as NombreClients
from employee
join customer
on employee.EmployeeId = customer.SupportRepId
group by NomAgent
order by NombreClients desc;

-- 22. Ventes totales par pays: 
	-- 22.1 Afficher les ventes totales par pays.
select sum(Total) as VentesTotales, BillingCountry as Pays
from invoice
group by Pays;
	-- 22.2 Quel pays a dépensé le plus ?
select sum(Total) as VentesTotales, BillingCountry as Pays
from invoice
group by Pays
order by VentesTotales desc
limit 1;

/*******************************************************************************
   8. Analyses des morceaux et des artistes
********************************************************************************/

-- 23.  Morceau le plus acheté en 2023: Afficher le morceau le plus acheté en 2023.
select sum(invoiceline.Quantity) as Quantité, track.Name as Morceau
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
join invoice
on invoiceline.InvoiceId = invoice.InvoiceId
where year(invoice.InvoiceDate) = 2023
group by Morceau
order by Quantité desc
limit 1;

-- 24. Top 5 des morceaux les plus achetés: Afficher les 5 morceaux les plus achetés tous temps.
select sum(invoiceline.Quantity) as Quantité, track.Name as Morceau
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
join invoice
on invoiceline.InvoiceId = invoice.InvoiceId
group by Morceau
order by Quantité desc
limit 5;

-- 25. Top 3 des artistes les plus vendus: Afficher les 3 artistes ayant vendu le plus de morceaux.
select track.Composer as Artistes, sum(invoiceline.Quantity) as QuantitéTotal
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
group by Artistes
order by QuantitéTotal desc
limit 4; -- Comme le premier est inconnu j'affiche le quatrième.

-- 26. Type de média le plus acheté: Afficher le type de média le plus acheté.
select sum(invoiceline.Quantity) as Quantité, mediatype.Name as MediaType
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
join mediatype
on mediatype.MediaTypeId = track.MediaTypeId
group by MediaType
order by Quantité desc
limit 1;

