//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareNoMatchHeader_Ingest.BWR_Ingest - Ingest - SALT V3.11.7');
IMPORT HealthCareNoMatchHeader_Ingest,SALT311;
//If you are not ingesting as part of a header build you can use the below;
//Set incremental to TRUE to run an incremental ingest mode
// pSrc :=  '00000099';
pSrc :=  '33333333';
// pSrc :=  '16935732';
MyDelta := DATASET([],HealthCareNoMatchHeader_Ingest.Layout_Base);
ingestMod := HealthCareNoMatchHeader_Ingest.Ingest(pSrc, FALSE, MyDelta);
f_AllRecords := HealthcareNoMatchHeader_Ingest.Filenames(pSrc).AllRecords;
f_ActiveRecords := HealthcareNoMatchHeader_Ingest.Filenames(pSrc).ActiveRecords;
O := OUTPUT(ingestMod.AllRecords_Notag,,f_AllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
N_U := OUTPUT(ingestMod.NewRecords_Notag+ingestMod.UpdatedRecords_Notag,,f_ActiveRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
PARALLEL(
         ingestMod.DoStats,
         O,
         N_U,
         ingestMod.ValidityStats,
         OUTPUT(ingestMod.StandardStats(), ALL, NAMED('StandardStats'))
         );
