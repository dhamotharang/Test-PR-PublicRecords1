#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthCareNoMatchHeader_Ingest,SALT311,STD,versioncontrol,HealthcareNoMatchHeader_InternalLinking;
EXPORT Proc_Ingest_Master( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
    , DATASET(RECORDOF(HealthCareNoMatchHeader_Ingest.In_Ingest))  pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AsHeaderIngest
    // Ingest
    , BOOLEAN doIngest      = FALSE // perform full ingest process (ingest source into existing base file)
    // Ingest Stats
    , BOOLEAN doIngestStats = FALSE // generate statistics on full ingest process
  ) :=  FUNCTION

  ingestMod         :=  HealthCareNoMatchHeader_Ingest.Ingest(pSrc,,,pBase,pInfile);
  InputSourceCounts :=  OUTPUT(ingestMod.InputSourceCounts,ALL,NAMED('InputSourceCounts'));
  UpdateStatsXtab   :=  OUTPUT(ingestMod.InputSourceCounts,ALL,NAMED('UpdateStatsXtab'));
  fAllRecords       :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Base.AllRecords.new;
  OutputResults     :=  OUTPUT(ingestMod.AllRecords,,fAllRecords,COMPRESSED,OVERWRITE); // Remove _Notag to keep 'what happened' byte
  dAll_filenames    :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Base.dAll_filenames;
  createsupers      :=  versioncontrol.mUtilities.createsupers(dAll_filenames);

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
                  ,IFF(doIngestStats, runIngestStats, OUTPUT('Ingest Stats Skipped')),
                );

  allSteps  :=  SEQUENTIAL(
                  createsupers,
                  IFF(doIngest, runIngest, OUTPUT('Ingest Skipped')),
                );
                
  RETURN  allSteps;
END;
