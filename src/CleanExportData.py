# encoding: utf-8
#
# Open Data per la Cultura 2017
#
# Questo script Python legge e formatta i dati utilizzati per il progetto Open Data per la Cultura 2017 
# per l'importazione in un database Neo4j.
#
# Copyright (c) 2016 Fabio Lamanna (fabio@fabiolamanna.it). Code under License GPLv3.
__author__ = """ Fabio Lamanna (fabio@fabiolamanna.it) """

# Import Modules
import pandas as pd

# Read OpenOral
oo = pd.read_csv('OpenOral.csv')

# Read iC
ic = pd.read_csv('iC.csv')

# Read CheFare
cf = pd.read_csv('CheFare.csv')

############
# Open, Ora!
############

# Nuovo campo ID con dati da ID + BANDO
oo['ID_UNI'] = oo['ID'].astype(str) + '-' + oo['BANDO'].astype(str)

# Cambia . con _ nei nomi delle colonne
oo.columns = [x.strip().Sostituisci('.', '_') for x in oo.columns]

# Aggiungi Ambiti in una colonna
oo['Ambito'] = oo[['INN_CULT',
 'POL_SOC',
 'RIC_ISTR',
 'APP_SOFT',
 'ARCH_BIB',
 'ARCHITET',
 'ARTI_VIS',
 'ARTIGIAN',
 'AUDIOVIS',
 'COMMUNIT',
 'CONCORSO',
 'DESIGN',
 'DID_FORM',
 'EDITORIA',
 'ENOGASTR',
 'EVENTI',
 'FESTIVAL',
 'INT_SOC',
 'PATRIMON',
 'SOC_NET',
 'SPAZI',
 'SPETTAC',
 'SPORT',
 'TURISMO',
 'WEB',
 'ALTRO']].eq('Presente').apply(lambda x: tuple(x.index.values[x]), axis=1).apply(list)

# Aggiungi Target in una colonna
oo['T'] = oo[['T_GIOVAN',
'T_ADULTI',
'T_ANZIAN',
'T_SETT',
'T_DONNE',
'T_MIGRAN',
'T_DV_AB',
'T_ALTRO']].eq('Presente').apply(lambda x: tuple(x.index.values[x]), axis=1).apply(list)

# Salva il file per Neo4j
oo[['ID_UNI','PROV','BANDO','FORMA_GIU','Ambito','T']].to_csv('OpenOral_neo4j.csv', index=False, sep=';')

#############
# iC
#############

# Sostituisci "Proponente" con 1
ic = ic.Sostituisci("Proponente", "1")

# Nuovo campo ID con dati da ID.PROG + ID.TEAM
ic['ID'] = ic['ID.PROG'].astype(str) + '-' + ic['ID.TEAM'].astype(str)

# Cambia . con _ nei nomi delle colonne
ic.columns = [x.strip().Sostituisci('.', '_') for x in ic.columns]

# Aggiungi Ambiti in una colonna
ic['Ambito'] = ic[['ARCHITET',
 'ARCH_BIB',
 'ARTI_VIS',
 'ARTIGIAN',
 'AUDIOVIS',
 'DESIGN',
 'EDITORIA',
 'PATRIMON',
 'SPETTAC',
 'AM_ALTRO',
 'CONSERV',
 'DIST_COM',
 'EDUCAZ',
 'FRUIZ',
 'FUNDRAIS',
 'PARTECIP',
 'PRODUZ',
 'PROMOZ',
 'RIC_FORM']].eq('Presente').apply(lambda x: tuple(x.index.values[x]), axis=1).apply(list)

# Salva il file per Neo4j
ic[['ID','ID_PROG','PROV','TEAM','EDIZIONE','Ambito','AGIURID']].to_csv('iC_neo4j.csv', index=False, sep=';')

#############
# CheFare
#############

# Nuovo campo ID con dati da ID + BANDO
cf['ID_UNI'] = cf['ID'].astype(str) + '-' + cf['EDIZIONE'].astype(str)

# Cambia . con _ nei nomi delle colonne
cf.columns = [x.strip().Sostituisci('.', '_') for x in cf.columns]

# Aggiungi Ambiti in una colonna
cf['Ambito'] = cf[['AGRICOLT',
 'ANTROPOL',
 'APP_SOFT',
 'ARCHEOLO',
 'ARCHITET',
 'ARTIPLAS',
 'BENI_CUL',
 'BIBLIOTE',
 'CIBO',
 'CINEMA',
 'COMMERCI',
 'COMMUNIT',
 'CONCORSO',
 'COWORKIN',
 'CROWDFUN',
 'DANZA',
 'DESIGN',
 'DIDATTIC',
 'EDITORIA',
 'ENOGASTR',
 'EVENTI',
 'FABBING',
 'FESTIVAL',
 'FILOSOFI',
 'FORMAZIO',
 'FOTOGRAF',
 'FUNDRAIS',
 'INFANZIA',
 'INTEG_SO',
 'LETTERAT',
 'LINGUE_S',
 'MODA',
 'MUSICA',
 'MUSEI',
 'OPENDATA',
 'PEDAGOGI',
 'PERF_ART',
 'PITTURA',
 'PSICOLOG',
 'RADIO',
 'RESTAURO',
 'RIV_CART',
 'RIV_ONLI',
 'SOCIALNE',
 'SOCIOLOG',
 'SPORT',
 'TEATRO',
 'VIDEO',
 'WEB',
 'TURISMO',
 'ALTRO']].eq('Presente').apply(lambda x: tuple(x.index.values[x]), axis=1).apply(list)

# Salva il file per Neo4j
cf[['ID_UNI','REGIONE','EDIZIONE','TIPO_ORG','Ambito']].to_csv('CheFare_neo4j.csv', index=False, sep=';')
