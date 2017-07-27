//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_POWID.BWR_Ingest - Ingest - SALT V3.3.0');
IMPORT BIPV2_POWID,SALT33;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
Delta := DATASET([],BIPV2_POWID.Layout_POWID);
ingestMod := BIPV2_POWID.Ingest(FALSE,Delta);
O := OUTPUT(ingestMod.AllRecords_Notag,,'<your_filename_goes_here>',COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,'<your_filename_goes_here>',COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
