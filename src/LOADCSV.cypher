// Open Data per la Cultura 2017
//
// Script Cypher per importare i dati utilizzati per il progetto Open Data per la Cultura 2017 
// in un database Neo4j.
//
// Copyright (c) 2016 Fabio Lamanna (fabio@fabiolamanna.it). Code under License GPLv3.

// Crea Indici
CREATE INDEX ON :Progetto(id)
CREATE INDEX ON :Soggetto(id)
CREATE INDEX ON :Luogo(nome)
CREATE INDEX ON :Bando(nome)
CREATE INDEX ON :Ambito(nome)

// Progetto Open, Ora!
LOAD CSV WITH HEADERS FROM 'file:///oo_neo4j.csv' AS row FIELDTERMINATOR ';'

// Nodes
MERGE (p:Progetto {id: row.ID_UNI})
MERGE (c:Soggetto {id: row.ID_UNI})
MERGE (l:Luogo {nome: coalesce(row.PROV, 'NA')})
MERGE (b:Bando {nome: coalesce(row.BANDO, 'NA')})

// Array di Target
WITH p, c, l, b, f, split(row.Ambito, ',') as amb, split(row.T, ',') as tar
WHERE size(tar)>0
UNWIND range(0, size(tar)-1) as i
MERGE (a:Ambito {nome: trim(coalesce(tar[i],''))})

// Links
MERGE (c)-[:PROPONE]->(p)
MERGE (c)-[:RISIEDE_IN]->(l)
MERGE (p)-[:APPARTIENE_A]->(b)
MERGE (p)-[:TRATTA_DI]->(a)

// Importa gli Ambiti
LOAD CSV WITH HEADERS FROM 'file:///oo_neo4j.csv' AS row FIELDTERMINATOR ';'

// Nodes
MATCH (p:Progetto {id: row.ID_UNI})

// Array of Ambiti / Target
WITH p, split(row.Ambito, ',') as amb
WHERE size(amb)>0
UNWIND range(0, size(amb)-1) as i
MERGE (a:Ambito {nome: trim(coalesce(amb[i],''))})

// Links
MERGE (p)-[:TRATTA_DI]->(a)

// Progetto iC
LOAD CSV WITH HEADERS FROM 'file:///ic_neo4j.csv' AS row FIELDTERMINATOR ';'

// Nodes
MERGE (p:Progetto {id: row.ID_PROG})
MERGE (c:Soggetto {id: row.ID})
MERGE (l:Luogo {nome: coalesce(row.PROV,'NA')})
MERGE (b:Bando {nome: coalesce(row.EDIZIONE,'NA')})

// Array of Ambiti
WITH p, c, l, b, f, split(row.Ambito, ',') as amb
WHERE size(amb)>0
UNWIND range(0, size(amb)-1) as i
MERGE (a:Ambito {nome: trim(coalesce(amb[i],''))})

// Links
MERGE (c)-[:PROPONE]->(p)
MERGE (c)-[:RISIEDE_IN]->(l)
MERGE (p)-[:APPARTIENE_A]->(b)
MERGE (p)-[:TRATTA_DI]->(a)

// Progetto cheFare
LOAD CSV WITH HEADERS FROM 'file:///cf_neo4j.csv' AS row FIELDTERMINATOR ';'

// Nodes
MERGE (p:Progetto {id: row.ID_UNI})
MERGE (c:Soggetto {id: row.ID_UNI})
MERGE (l:Luogo {nome: coalesce(row.REGIONE,'NA')})
MERGE (b:Bando {nome: coalesce(row.EDIZIONE,'NA')})

// Array of Ambiti
WITH p, c, l, b, f, split(row.Ambito, ',') as amb
WHERE size(amb)>0
UNWIND range(0, size(amb)-1) as i
MERGE (a:Ambito {nome: trim(coalesce(amb[i],''))})

// Links
MERGE (c)-[:PROPONE]->(p)
MERGE (c)-[:RISIEDE_IN]->(l)
MERGE (p)-[:APPARTIENE_A]->(b)
MERGE (p)-[:TRATTA_DI]->(a)

// Crea le connessioni [:FA_PARTE_DI] tra Comuni e Regioni di Provenienza

// Piemonte
MATCH (a1:Luogo {nome:'Altra provincia piemontese'}),
(a2:Luogo {nome:'Torino'}),
(a3:Luogo {nome:'Cuneo'}),
(a4:Luogo {nome:'Asti'}),
(a5:Luogo {nome:'Novara'}),
(a6:Luogo {nome:'Alessandria'}),
(P:Luogo {nome:'Piemonte'})

CREATE (a1)–[:FA_PARTE_DI]->(P)
CREATE (a2)–[:FA_PARTE_DI]->(P)
CREATE (a3)–[:FA_PARTE_DI]->(P)
CREATE (a4)–[:FA_PARTE_DI]->(P)
CREATE (a5)–[:FA_PARTE_DI]->(P)
CREATE (a6)–[:FA_PARTE_DI]->(P)

// Liguria
MATCH (a1:Luogo {nome:'Altra provincia ligure'}),
(a2:Luogo {nome:'Genova'}),
(P:Luogo {nome:'Liguria'})

CREATE (a1)–[:FA_PARTE_DI]->(P)
CREATE (a2)–[:FA_PARTE_DI]->(P)

// Lombardia
MATCH (a1:Luogo {nome:'Mantova'}),
(a2:Luogo {nome:'Bergamo'}),
(a3:Luogo {nome:'Varese'}),
(a4:Luogo {nome:'Altra provincia Lombarda'}),
(a5:Luogo {nome:'Pavia'}),
(a6:Luogo {nome:'Lecco'}),
(a7:Luogo {nome:'Monza e della Brianza'}),
(a8:Luogo {nome:'Como'}),
(a9:Luogo {nome:'Milano'}),
(a10:Luogo {nome:'Brescia'}),
(a11:Luogo {nome:'Cremona'}),
(P:Luogo {nome:'Lombardia'})

CREATE (a1)–[:FA_PARTE_DI]->(P)
CREATE (a2)–[:FA_PARTE_DI]->(P)
CREATE (a3)–[:FA_PARTE_DI]->(P)
CREATE (a4)–[:FA_PARTE_DI]->(P)
CREATE (a5)–[:FA_PARTE_DI]->(P)
CREATE (a6)–[:FA_PARTE_DI]->(P)
CREATE (a7)–[:FA_PARTE_DI]->(P)
CREATE (a8)–[:FA_PARTE_DI]->(P)
CREATE (a9)–[:FA_PARTE_DI]->(P)
CREATE (a10)–[:FA_PARTE_DI]->(P)
CREATE (a11)–[:FA_PARTE_DI]->(P)
