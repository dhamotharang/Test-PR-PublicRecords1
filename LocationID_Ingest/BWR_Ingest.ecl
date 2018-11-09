//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','LocationID_Ingest.BWR_Ingest - Ingest - SALT V3.7.0');
IMPORT LocationID_Ingest,SALT37;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],LocationID_Ingest.Layout_BASE);
ingestMod := LocationID_Ingest.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::rid::LocationID_Ingest::ingest::AllRecords';
f_ActiveRecords := '~temp::rid::LocationID_Ingest::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
