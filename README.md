# 💼  Projet Chinook

Pour ce projet nous allons travailler sur le data set Chinook que vous pouvez retrouver ici : <a href=https://github.com/lerocha/chinook-database>Chinook Dataset</a>.
Une entreprise souhaite produire un rapport détaillant les ventes totales par produit pour le dernier trimestre.

## 📊 Aperçu des données

##  🎯 Objectif du projet
L'objectif de ce projet est d'utiliser SQL pour extraire, filtrer et agréger les données nécessaires.

## 🛠️Compétences mises en avant
Pendant ce projet j'ai du mettre à l'épreuve mes connaissances dans les compétences ci-dessous :
   - Requêtes SQL de base : SELECT, WHERE, GROUP BY, HAVING.
   - Calculs d’agrégats : SOMME, MOYENNE pour des KPI.
   -  Automatisation des rapports avec des vues SQL.

## Plan du projet

### Exercices SQL

## 1. 🔎 Requêtes de base

1. **Clients non américains**  
   Afficher les clients (nom complet, ID, pays) qui ne sont pas aux États-Unis.

2. **Clients brésiliens**  
   Afficher uniquement les clients provenant du Brésil.

3. **Factures des clients brésiliens**  
   Afficher le nom complet du client, l’ID de la facture, la date de la facture et le pays de facturation.

4. **Agents de vente**  
   Afficher uniquement les employés qui sont des agents de vente.

## 2. 📊 Agrégations et relations

5. **Pays uniques dans les factures**  
   Afficher une liste unique des pays de facturation présents dans la table `Invoice`.

6. **Factures par agent de vente**  
   Afficher les factures associées à chaque agent de vente avec leur nom complet.

7. **Détails des factures**  
   Afficher le total de chaque facture, le nom du client, le pays et le nom de l’agent de vente.

## 3. 📆 Analyse par année et lignes de facture

8. **Ventes par année**  
   Combien de factures en 2009 et 2011 ? Quels sont les montants totaux des ventes pour ces années ?

9. **Articles pour une facture donnée**  
   Compter le nombre d’articles pour la facture ayant l’ID 37.

10. **Articles par facture**  
    Compter le nombre d’articles pour chaque facture (`GROUP BY` requis).

## 4. 🎵 Détails des morceaux

11. **Nom des morceaux**  
    Afficher le nom du morceau pour chaque ligne de facture.

12. **Morceaux et artistes**  
    Afficher le nom du morceau et le nom de l’artiste pour chaque ligne de facture.

## 5. 📈 Comptages et regroupements

13. **Nombre de factures par pays**  
    Afficher le nombre de factures par pays (`GROUP BY` requis).

14. **Nombre de morceaux par playlist**  
    Afficher le nombre total de morceaux dans chaque playlist, avec le nom de la playlist.

15. **Liste des morceaux**  
    Afficher tous les morceaux sans leur ID, en incluant le nom de l’album, le type de média et le genre.

## 6. 💰 Analyse des ventes

16. **Factures et articles**  
    Afficher toutes les factures avec le nombre d’articles par facture.

17. **Ventes par agent de vente**  
    Afficher les ventes totales réalisées par chaque agent de vente.

18. **Meilleur agent de 2009**  
    Quel agent a réalisé le plus de ventes en 2009 ?

19. **Meilleur agent de 2010**  
    Quel agent a réalisé le plus de ventes en 2010 ?

20. **Meilleur agent global**  
    Quel agent a réalisé le plus de ventes au total ?

## 7. 👥 Analyse des clients et des pays

21. **Clients par agent de vente**  
    Afficher le nombre de clients attribués à chaque agent de vente.

22. **Ventes totales par pays**  
    Afficher les ventes totales par pays. Quel pays a dépensé le plus ?

## 8. 🎤 Analyse des morceaux et des artistes

23. **Morceau le plus acheté en 2013**  
    Afficher le morceau le plus acheté en 2013.

24. **Top 5 des morceaux les plus achetés**  
    Afficher les 5 morceaux les plus achetés tous temps.

25. **Top 3 des artistes les plus vendus**  
    Afficher les 3 artistes ayant vendu le plus de morceaux.

26. **Type de média le plus acheté**  
    Afficher le type de média le plus acheté.

## 📚 Ressources supplémentaires

- [SQL Course](https://www.sqlcourse.com/)
- [Cheatsheet SQL sur GitHub](https://github.com/enochtangg/quick-SQL-cheatsheet)
- [SQL Cheatsheet](https://www.sqltutorial.org/sql-cheat-sheet/)
- [Sololearn - Cours SQL](https://www.sololearn.com/Course/SQL/)

### 📌 Source des exercices

Ces exercices sont adaptés de la ressource suivante :  
[GitHub - LucasMcL/15-sql_queries_02-chinook](https://github.com/LucasMcL/15-sql_queries_02-chinook)

## ✨ Carte mentale du projet
