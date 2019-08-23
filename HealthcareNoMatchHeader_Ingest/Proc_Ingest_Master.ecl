#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthCareNoMatchHeader_Ingest,SALT311,STD,versioncontrol,HealthcareNoMatchHeader_InternalLinking;
EXPORT Proc_Ingest_Master( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).BaseTemp
    , DATASET(HealthcareNoMatchHeader_Ingest.Layout_Base)  pAsHeader = HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).AsHeaderTemp
  ) :=  FUNCTION

  ingestMod         :=  HealthCareNoMatchHeader_Ingest.Ingest(pSrc,pVersion,,,pBase,pAsHeader);
  InputSourceCounts :=  OUTPUT(ingestMod.InputSourceCounts,ALL,NAMED('InputSourceCounts'));
  UpdateStatsXtab   :=  OUTPUT(ingestMod.UpdateStatsXtab,ALL,NAMED('UpdateStatsXtab'));
  fAllRecords       :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Base.AllRecords.new;
  OutputResults     :=  OUTPUT(ingestMod.AllRecords,,fAllRecords,COMPRESSED,OVERWRITE); // Add _Notag to remove 'what happened' byte

  // Ingest Stats
  runIngestStats  :=  PARALLEL(
                        InputSourceCounts
                        ,UpdateStatsXtab
                      );
  // Ingest
  runIngest :=  SEQUENTIAL(
                  OutputResults
                  ,Promote(pSrc, pVersion,,'base').buildfiles.New2Built
                  ,Promote(pSrc, pVersion,,'base').buildfiles.Built2QA	
                  ,runIngestStats
                );
                
  RETURN  runIngest;
END;
