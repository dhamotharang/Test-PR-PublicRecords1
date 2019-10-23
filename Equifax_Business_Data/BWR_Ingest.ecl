//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Equifax_Business_Data.BWR_Ingest - Ingest - SALT V3.7.1');
IMPORT Equifax_Business_Data,SALT37;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],Equifax_Business_Data.Layout_Base);
ingestMod := Equifax_Business_Data.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::rcid::Equifax_Business_Data::ingest::AllRecords';
f_ActiveRecords := '~temp::rcid::Equifax_Business_Data::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
