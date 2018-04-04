//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','tris_lnssi_ingest.BWR_Ingest - Ingest - SALT V3.6.3');
IMPORT tris_lnssi_ingest,SALT36;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],tris_lnssi_ingest.Layout_basefile);
ingestMod := tris_lnssi_ingest.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::rcid::tris_lnssi_ingest::ingest::AllRecords';
f_ActiveRecords := '~temp::rcid::tris_lnssi_ingest::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
