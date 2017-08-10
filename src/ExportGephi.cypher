// Open Data per la Cultura 2017
//
// Queries Cypher per esportare il grafo in Gephi per la visualizzazione
//
// Copyright (c) 2016 Fabio Lamanna (fabio@fabiolamanna.it). Code under License GPLv3.
//
// Occorre scaricare il Plugin "streaming" in Gephi.
// Configurare il Gephi streaming plugin con http://localhost:8080
// Quindi run - master - start

// Estrai i componenti e trasmetti i risultati a Gephi via streaming (1/2)
MATCH path1=()<-[:FA_PARTE_DI]-(l:Luogo)<-[:RISIEDE_IN]-(s:Soggetto)-[:PROPONE]->(p:Progetto)-[:TRATTA_DI]->(a:Ambito),
path2=(p)-[:APPARTIENE_A]->(b:Bando)
where a.nome contains 'MIGR' OR a.nome contains 'EDU' OR a.nome contains 'DIDA'
with collect(path1) as paths
call apoc.gephi.add(null,'workspace1', paths) yield nodes, relationships, time
return nodes, relationships, time

// Estrai i componenti e trasmetti i risultati a Gephi via streaming (2/2)
MATCH path1=()<-[:FA_PARTE_DI]-(l:Luogo)<-[:RISIEDE_IN]-(s:Soggetto)-[:PROPONE]->(p:Progetto)-[:TRATTA_DI]->(a:Ambito),
path2=(p)-[:APPARTIENE_A]->(b:Bando)
where a.nome contains 'MIGR' OR a.nome contains 'EDU' OR a.nome contains 'DIDA'
with collect(path2) as paths
call apoc.gephi.add(null,'workspace1', paths) yield nodes, relationships, time
return nodes, relationships, time
