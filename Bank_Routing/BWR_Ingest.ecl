//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Bank_Routing.BWR_Ingest - Ingest - SALT V3.8.1');
IMPORT Bank_Routing,SALT38;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],Bank_Routing.Layout_Bank_Routing);
ingestMod := Bank_Routing.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::rcid::Bank_Routing::ingest::AllRecords';
f_ActiveRecords := '~temp::rcid::Bank_Routing::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove  to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords+ingestMod.UpdatedRecords,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove  to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
