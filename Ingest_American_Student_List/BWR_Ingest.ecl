//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Ingest_American_Student_List.BWR_Ingest - Ingest - SALT V3.3.2');
IMPORT Ingest_American_Student_List,SALT33;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
Delta := DATASET([],Ingest_American_Student_List.Layout_American_Student_List_Raw);
ingestMod := Ingest_American_Student_List.Ingest(FALSE,Delta);
O := OUTPUT(ingestMod.AllRecords_Notag,,'<your_filename_goes_here>',COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,'<your_filename_goes_here>',COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
