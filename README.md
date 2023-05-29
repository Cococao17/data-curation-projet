
# Projet de curation de données

Les données récoltées sont sur le sujet "Data mining and sentiment analysis on Twitter and Facebook"



## Authors

- Admira Halili, admira.halili@hesge.ch
- Coralie Chevalley, coralie.chevalley@etu.hesge.ch
- Erisvelton Tavares Da Costa, erisvelton.tavares-dacosta@etu.hesge.ch
- Felipe Covaleda, carlos.covaleda@etu.hesge.ch


## Documentation

### Scrapping
La récupération du jeu de données a été récolté sur Google Scholar. Le jeu de données détient 2030 lignes. Plusieurs recherches sur Google Scholar ont été faites pour ce dernier :
- [twitter data mining filetype:pdf](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=twitter+data+mining+filetype%3Apdf&btnG= )
- [facebook data mining -Twitter filetype:pdf](https://scholar.google.com/scholar?start=490&q=facebook+data+mining+-Twitter+filetype:pdf&hl=en&as_sdt=0,5 )
- [seniment analyse twitter filetype:pdf](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=seniment+analyse+twitter+filetype%3Apdf&btnG= )

La récolte de données a été effectué avec un script créé avec le langage R. Un fichier CSV est fourni à la fin de l'exécution du script.

#### Information sur le jeu de données
##### Nom du fichier
data_mining_sentiment_analysis_Twitter_Facebook.csv

##### Liste des attributs :
- titles, titre du fichier PDF
- authors, auteurs du fichier PDF
- years, année de création du fichier PDF
- ncitedby, nombre de citation
- linkfiles, liens du fichier PDF


### Extraction de fichiers PDF à partir d'URL

Le but de cette opération a été d’extraire chaque lien URL des fichiers PDF pour les insérer dans un dossier local contenant l’ensemble des fichiers avec l’extension .pdf. Le script a été créé avec le langage de programmation Python.

### Micro-transformations
Pour cette étape du processus de curation de données, une sélection de 1200 lignes du jeu de données ont été faites, afin de faciliter le processus.

Le logiciel OpenRefine a été utilisé pour l'extraction du contenu et des métadonnées des PDF, la création des expressions régulières pour trier et nettoyer les données, l'extraction des colonnes des métadonnées et la récupération des données à partir du DOI en lançant des requêtes depuis l'API CrossRef.

### Macro-transformations
La création du nouveau jeu de données a été faite avec OpenRefine à la fin de chaque étape de la micro-transformations.

L'outil DMPTool a permis de créer la représentation de la structuration des répertoires et des fichiers.

Concernant le readme, la structure de celui-ci a été fait avec l'application web readme.so. 


### Découvrabilité et interopérabilité sur le Web
Une page Web a été effectué avec Schema.org (voir page Web [ici](https://data-curation.000webhostapp.com/)). 

L'indexation a été faite sur Google Search.

Le jeu de donnée a été diffusé sur le dépôt centralisé, Zenodo (voir jeu de données [ici](https://zenodo.org/record/7979378)), et est sous licence Creative Commons Attribution 4.0 International et en Open Access.