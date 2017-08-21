//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_GA_Main.BWR_Ingest - Ingest - SALT V3.4.0');
IMPORT Scrubs_Corp2_Mapping_GA_Main,SALT34;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(Scrubs_Corp2_Mapping_GA_Main.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
Scrubs_Corp2_Mapping_GA_Main.Ingest.DoStats;
O;
