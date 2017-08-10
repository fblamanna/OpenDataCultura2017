# Open Data Cultura 2017
Leggere e rappresentare i progetti culturali innovativi.
Tutto il materiale è rilasciato secondo la licenza:

Creative Commons Attribuzione - Non commerciale 3.0 Italia (CC BY-NC 3.0 IT)

## Base Dati
I dati utilizzati nel progetto sono scaricabili dalle fonti citate nel [Bando](https://www.che-fare.com/che-fare-media/2017/05/Bando-Open-Data-per-la-Cultura.pdf). Sono stati inoltre utilizzati ulteriori dati provenienti dal sito del [Ministero dell'Interno Italiano](http://www.interno.gov.it/it/sala-stampa/dati-e-statistiche), relativi ai centri di accoglienza dei migranti in Italia.

## Modellizzazione delle Informazioni
I dati dei singoli bandi sono stati organizzati in una struttura a grafo, evidenziando le naturali connessioni tra i soggetti proponenti i progetti, la loro provenienza, e l'ambito (argomenti) delle proposte progettuali.

# Database Neo4j
Il database a grafo [Neo4j](www.neo4j.com) è stata una scelta naturale per rappresentare, interrogare e visualizzare dati connessi. In questo progetto è stata utilizzata la versione Community 3.2.3, gratuitamente scaricabile dal [sito](https://neo4j.com/download/community-edition/) del produttore.

## Pulizia e Formattazione dei Dati
Al fine di procedere con l'elaborazione dei dati, questi ultimi sono stati opportunamenti "puliti" e formattati in un formato leggibile in fase di importazione nel database **Neo4j**, in formato *.csv*. Tutta la fase di lettura, pulizia e formattazione è riproducibile attraverso lo script Python disponibile in */src/CleanExportData.py*.

## Importazione dati in Neo4j
I file di output dello script Python possono essere importati in Neo4j attraverso la procedura LOAD CSV, contenuta nello script Cypher */src/LOADCSV.cypher*. Il modello dati proposto è visualizzabile nel file *ModelloDati.png*. Lo script contiene inoltre la parte di creazione delle aggregazioni tra città e Regioni di appartenenza.

# Esportazione e Visualizzazione dei Dati
Il database completo è stato quindi esportato in [Gephi](https://gephi.org) per visualizzare e clusterizzare opportunamenti i dati. Per l'esportazione da Neo4j è necessario scaricare il file *.jar* delle procedure [APOC](https://neo4j-contrib.github.io/neo4j-apoc-procedures/). Lo script di esportazione del grafo in streaming a Gephi è disponibile in */src/ExportGephi.cypher*, completo delle istruzioni per il corretto settaggio delle comunicazioni.
