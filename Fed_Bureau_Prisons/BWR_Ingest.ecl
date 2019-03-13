//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Fed_Bureau_Prisons.BWR_Ingest - Ingest - SALT V3.11.3');
IMPORT Fed_Bureau_Prisons,SALT311;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],Fed_Bureau_Prisons.Layout_federal_bureau_base);
ingestMod := Fed_Bureau_Prisons.Ingest(FALSE, MyDelta);
f_AllRecords := '~temp::rcid::Fed_Bureau_Prisons::ingest::AllRecords';
f_ActiveRecords := '~temp::rcid::Fed_Bureau_Prisons::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
PARALLEL(
         ingestMod.DoStats,
         O,
         N_U,
         ingestMod.ValidityStats,
         OUTPUT(ingestMod.StandardStats(), ALL, NAMED('StandardStats'))
         );
