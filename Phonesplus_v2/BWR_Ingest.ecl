//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','PhonesPlus_V2.BWR_Ingest - Ingest - SALT V3.11.9');
IMPORT PhonesPlus_V2,SALT311;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],PhonesPlus_V2.Layout_Source_Level_Base);
ingestMod := PhonesPlus_V2.Ingest(FALSE, MyDelta);
f_AllRecords := '~temp::record_sid::PhonesPlus_V2::ingest::AllRecords';
f_ActiveRecords := '~temp::record_sid::PhonesPlus_V2::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
PARALLEL(
         ingestMod.DoStats,
         O,
         N_U,
         ingestMod.ValidityStats,
         OUTPUT(ingestMod.StandardStats(), ALL, NAMED('StandardStats'))
         );
