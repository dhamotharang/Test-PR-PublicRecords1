//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Ingest.BWR_Ingest - Ingest - SALT V3.7.0');
IMPORT InsuranceHeader_Ingest,SALT37;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],InsuranceHeader_Ingest.Layout_Base);
ingestMod := InsuranceHeader_Ingest.Ingest(FALSE,MyDelta);
f_AllRecords := '~temp::RID::InsuranceHeader_Ingest::ingest::AllRecords';
f_ActiveRecords := '~temp::RID::InsuranceHeader_Ingest::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
ingestMod.DoStats;
O;
N_U;
