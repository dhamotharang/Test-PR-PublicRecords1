//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless_IngestMain.BWR_Ingest - Ingest - SALT V3.11.4');
IMPORT NeustarWireless_IngestMain,SALT311;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
MyDelta := DATASET([],NeustarWireless_IngestMain.Layout_Main);
ingestMod := NeustarWireless_IngestMain.Ingest(FALSE, MyDelta);
f_AllRecords := '~temp::RCID::NeustarWireless_IngestMain::ingest::AllRecords';
f_ActiveRecords := '~temp::RCID::NeustarWireless_IngestMain::ingest::ActiveRecords';
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
PARALLEL(
         ingestMod.DoStats,
         O,
         N_U,
         ingestMod.ValidityStats,
         OUTPUT(ingestMod.StandardStats(), ALL, NAMED('StandardStats'))
         );
