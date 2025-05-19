USE `Chinook`;

/*******************************************************************************
   1. Vues de bases
********************************************************************************/

-- 1.Clients non américains:
create or replace view Clients_non_USA as # Permet de créer ou remplace la vue.
select concat(FirstName, ' ', LastName) as FullName, CustomerID, Country -- On peut sélectionner plusieurs colonnes en les séparant par ','.
from customer -- Concat() permet de concatener plusieurs colonnes en une seule.
where Country != 'USA'; -- Permet de ne pas sélectionner les USA

-- 2. Clients brésiliens:
create or replace view Clients_Bresil as 
select concat( FirstName, ' ', LastName) as FullName, CustomerID, Country
from customer
where Country = 'Brazil';
 
 -- 3. Factures des clients brésiliens: 
 create or replace view Facture_Clients_Bresil as 
 select concat(customer.FirstName, ' ', customer.LastName) as FullName, invoice.InvoiceId, invoice.InvoiceDate, invoice.BillingCountry
 from customer -- On définit la table de départ avec le FROM puis on rajoute les colonnes des autres tables avec JOIN
 join invoice -- On effectue une INNER JOIN pour obtenir les lignes présentes dans les deux tables.
 on customer.CustomerId = invoice.CustomerId
 where customer.Country = 'Brazil';
 
-- 4. Agents de vente:
create or replace view Agents as 
select concat(FirstName, ' ', LastName) as FullName
from employee
where Title = 'Sales Support Agent';

/*******************************************************************************
   2. Agrégations et relations
********************************************************************************/

-- 5. Pays uniques dans les factures:
create or replace view Facturation_pays as 
select distinct(BillingCountry) -- DISTINCT() permet de ne conserver que les valeurs distinctes et donc évite les doublons.
from invoice;

-- 6. Factures par agent de vente:
create or replace view Facturation_agents as
select concat(employee.FirstName, ' ', employee.LastName) as EmployeeFullName, invoice.InvoiceId
from invoice
join customer -- On commence par faire une première jointure pour croiser les données de Invoice avec les identifiants Clients
on invoice.CustomerId = customer.CustomerId
join employee -- On fait une deuxiéme jointure pour récupérer les employés qui ont généré la factures
on customer.SupportRepId = employee.EmployeeId;

-- 7. Détails des factures:
create or replace view Facturation_detaillees as
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
create or replace view Nombre_Facture_2021_2024 as
select count(InvoiceId) as NombreFactures, year(InvoiceDate) as Annee
from invoice
where year(InvoiceDate) in (2021, 2024)
group by year(InvoiceDate)
order by Annee;
	-- 8.2 Quels sont les montants totaux des ventes pour ces années ?
create or replace view Montants_ventes_2021_2024 as
select count(InvoiceId) as NombreFactures, year(InvoiceDate) as Annee, sum(Total) as MontantTotal
from invoice
where year(InvoiceDate) in (2021, 2024)
group by year(InvoiceDate)
order by Annee;

-- 9. Articles pour une facture donnée:
create or replace view Nombre_Articles_ID_37 as
select  InvoiceId, count(Quantity) as Nombre_Article
from invoiceline
where InvoiceId = 37;

-- 10. Articles par facture:
create or replace view Articles_Factures as
select  InvoiceId, count(quantity) as Nombre_Article
from invoiceline
group by (InvoiceId);

/*******************************************************************************
   4. Détails des morceaux
********************************************************************************/

-- 11. Nom des morceaux:
create or replace view Nom_Morceaux as
select invoiceline.InvoiceId, invoiceline.trackId, track.Name
from invoiceline
left join track
on invoiceline.TrackId = track.TrackId;

-- 12. Morceaux et artistes:
create or replace view Morceaux_Artistes as
select invoiceline.InvoiceId, invoiceline.trackId, track.Name, track.Composer
from invoiceline
left join track
on invoiceline.TrackId = track.TrackId;

/*******************************************************************************
   5. Comptages et regroupements
********************************************************************************/

-- 13. Nombre de factures par pays:
create or replace view Factures_par_pays as
select  BillingCountry, count(InvoiceId) as Nombre_Factures
from invoice
group by BillingCountry;

-- 14. Nombre de morceaux par playlist:
create or replace view Morceaux_par_Playlist as
select playlist.Name as Playlist, count(*) as NombreMorceaux
from playlist
join playlisttrack 
on playlist.PlaylistId = playlisttrack.PlaylistId
group by playlist.PlaylistId, playlist.Name;

-- 15. Liste des morceaux:
create or replace view Liste_des_Morceaux as
select track.Name as Nom_Morceau, album.Title, mediatype.Name as Nom_Media , genre.Name as Genre
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

-- 16. Factures et articles:
create or replace view Nombre_Articles_par_Factures as
select  invoice.InvoiceId, count(invoiceline.quantity) as NombreArticle
from invoice
left join invoiceline
on invoice.InvoiceId = invoiceline.InvoiceId
group by (InvoiceId);

-- 17. Ventes par agent de vente:
create or replace view Ventes_par_Agents as
select concat(employee.FirstName, ' ', employee.LastName) as NomAgent, sum(invoice.Total) as VentesTotales
from employee
join customer
on employee.EmployeeId = customer.SupportRepId
join invoice
on customer.CustomerId = invoice.CustomerId
group by NomAgent;

-- 19. Meilleur agent de 2022:
create or replace view Meilleur_Agent_2022 as
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

-- 20. Meilleur agent global:
create or replace view Meilleur_Agent as
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

-- 21. Clients par agent de vente:
create or replace view Nombre_Clients_par_Agent as
select concat(employee.FirstName, ' ', employee.LastName) as NomAgent, count(customer.customerId) as NombreClients
from employee
join customer
on employee.EmployeeId = customer.SupportRepId
group by NomAgent
order by NombreClients desc;

-- 22. Ventes totales par pays: 
	-- 22.1 Afficher les ventes totales par pays.
create or replace view Ventes_totales_par_Pays as
select sum(Total) as VentesTotales, BillingCountry as Pays
from invoice
group by Pays;
	-- 22.2 Quel pays a dépensé le plus ?
create or replace view Pays_plus_depensier as
select sum(Total) as VentesTotales, BillingCountry as Pays
from invoice
group by Pays
order by VentesTotales desc
limit 1;

/*******************************************************************************
   8. Analyses des morceaux et des artistes
********************************************************************************/

-- 23.  Morceau le plus acheté en 2023:
create or replace view Top_morceau_2023 as
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

-- 24. Top 5 des morceaux les plus achetés:
create or replace view Top5_Morceaux as
select sum(invoiceline.Quantity) as Quantité, track.Name as Morceau
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
join invoice
on invoiceline.InvoiceId = invoice.InvoiceId
group by Morceau
order by Quantité desc
limit 5;

-- 25. Top 3 des artistes les plus vendus:
create or replace view Top3_Artistes as
select track.Composer as Artistes, sum(invoiceline.Quantity) as QuantitéTotal
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
group by Artistes
order by QuantitéTotal desc
limit 4; -- Comme le premier est inconnu j'affiche le quatrième.

-- 26. Type de média le plus acheté:
create or replace view Type_Media_achete as
select sum(invoiceline.Quantity) as Quantité, mediatype.Name as MediaType
from invoiceline
join track
on invoiceline.TrackId = track.TrackId
join mediatype
on mediatype.MediaTypeId = track.MediaTypeId
group by MediaType
order by Quantité desc
limit 1;



