//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','infutor_narb.BWR_Ingest - Ingest - SALT V3.4.3');
IMPORT infutor_narb,SALT34;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],infutor_narb.Layout_infutor_narb);
ingestMod := infutor_narb.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::rcid::infutor_narb::ingest::AllRecords';
f_ActiveRecords := '~temp::rcid::infutor_narb::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
