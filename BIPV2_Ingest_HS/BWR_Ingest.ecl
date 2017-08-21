//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Ingest_HS.BWR_Ingest - Ingest - SALT V3.5.2');
IMPORT BIPV2_Ingest_HS,SALT35;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],BIPV2_Ingest_HS.Layout_BASE);
ingestMod := BIPV2_Ingest_HS.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::rcid::BIPV2_Ingest_HS::ingest::AllRecords';
f_ActiveRecords := '~temp::rcid::BIPV2_Ingest_HS::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
