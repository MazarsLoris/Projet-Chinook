# 💼 Projet Chinook

Pour ce projet, nous allons travailler sur le dataset Chinook, que vous pouvez retrouver ici :  
👉 [Chinook Dataset](https://github.com/lerocha/chinook-database)  
Une entreprise souhaite produire un rapport détaillant les ventes totales par produit pour le dernier trimestre.

## 🎯 Objectif du projet

L'objectif de ce projet est d'utiliser SQL pour extraire, filtrer et agréger les données nécessaires à une analyse complète des ventes et de l'activité commerciale.

## 📊 Aperçu des données

*(Ajouter ici une description ou un aperçu visuel de la base de données si nécessaire)*

## 🛠️ Compétences mises en avant

Pendant ce projet, j'ai mis à l'épreuve mes connaissances dans les domaines suivants :
- Requêtes SQL de base : `SELECT`, `WHERE`, `GROUP BY`
- Calculs d’agrégats : `SUM`, `AVG`, pour des KPI
- Automatisation des rapports avec des vues SQL (`VIEW`)

---

## 🧭 Plan du projet

### 1. 🔎 Exploration des données
Pour commencer ce projet, j'ai utilisé 26 requêtes permettant d'explorer les données, faire ressortir les différents KPI important et obtenir certaines valeurs importantes pour la suite du projet.

### 2. 🔄Automatisation avec les Vues SQL

Les requêtes critiques ont été transformées en vues SQL pour :
- Simplifier les analyses dans Power BI,
- Réutiliser les requêtes dans d'autres projets
- Garantir une mise à jour automatique des données lors de l’actualisation.

### 3. 📈 Visualisation 

Les vues SQL peuvent être connectées à Power BI pour créer un rapport interactif contenant :
- Les ventes totales par produit (par mois/trimestre),
- Le classement des morceaux et des artistes,
-Les performances des agents commerciaux.

---

## 📁 Structure du dépôt
```
├── README.md               # Ce fichier
├── Vues_Chinook_databas_sql/               # Vues SQL créées pour automatiser les analyses
│   ├── Clients_non_USA.sql
│   ├── Clients_Bresil.sql
│   └── ...
├── Requetes_Chinook_Database_sql/           # Requêtes SQL de base, organisées par thème
│   ├── 01_requetes_de_base.sql
│   ├── 02_agregations.sql
│   └── ...
├── rapport_Chinook_powerbi/        
│   └── Dashboard.pbix
```
---

## 📚 Ressources supplémentaires

- [SQL Course](https://www.sqlcourse.com/)
- [Cheatsheet SQL sur GitHub](https://github.com/enochtangg/quick-SQL-cheatsheet)
- [SQL Cheatsheet](https://www.sqltutorial.org/sql-cheat-sheet/)
- [Sololearn - Cours SQL](https://www.sololearn.com/Course/SQL/)

### 📌 Source des exercices

Ces exercices sont adaptés de la ressource suivante :  
[GitHub - LucasMcL/15-sql_queries_02-chinook](https://github.com/LucasMcL/15-sql_queries_02-chinook)
Le projet vient du programme « 12 projets pour devenir Data Analyst » proposé par Natacha Njongwa Yepnga.

