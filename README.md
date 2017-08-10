# Open Data Cultura 2017
Leggere e rappresentare i progetti culturali innovativi.
Tutto il materiale è rilasciato secondo la licenza:

Creative Commons Attribuzione - Non commerciale 3.0 Italia (CC BY-NC 3.0 IT)

## Base Dati
I dati utilizzati nel progetto sono scaricabili dalle fonti citate nel [Bando](https://www.che-fare.com/che-fare-media/2017/05/Bando-Open-Data-per-la-Cultura.pdf).

## Modellizzazione delle Informazioni
I dati dei singoli bandi sono stati organizzati in una struttura a grafo, evidenziando le naturali connessioni tra i soggetti proponenti i progetti, la loro provenienza, e l'ambito (argomenti) delle proposte progettuali.

# Database Neo4j
Il database a grafo [Neo4j](www.neo4j.com) è stata una scelta naturale per rappresentare, interrogare e visualizzare dati connessi. In questo progetto è stata utilizzata la versione Community 3.2.3, gratuitamente scaricabile dal [sito](https://neo4j.com/download/community-edition/) del produttore.

## Pulizia e Formattazione dei Dati
Al fine di procedere con l'elaborazione dei dati, questi ultimi sono stati opportunamenti "puliti" e formattati in un formato leggibile in fase di importazione nel database **Neo4j**, in formato *.csv*. Tutta la fase di lettura, pulizia e formattazione è riproducibile attraverso lo script Python *CleanExportData.py*.
