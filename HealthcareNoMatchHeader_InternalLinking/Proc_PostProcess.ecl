#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, STD;
EXPORT Proc_PostProcess( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).Linking().Iteration
  ) :=  FUNCTION

  //  Create CRK File
  dAppendCRK        :=  HealthcareNoMatchHeader_InternalLinking.Proc_AppendCRK(pSrc,pBase);
  pCRKFilename      :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Append.CRK.new;
  OutputCRKResults  :=  OUTPUT(dAppendCRK,,pCRKFilename,COMPRESSED,OVERWRITE);
  //  Create History File
  dHistory              :=  HealthcareNoMatchHeader_InternalLinking.Proc_History(pSrc,pVersion);
  pHistoryFilename      :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Base.History.new;
  OutputHistoryResults  :=  OUTPUT(dHistory,,pHistoryFilename,COMPRESSED,OVERWRITE);

  runPostProcess := SEQUENTIAL(
                      //  CRK
                      OutputCRKResults
                      ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'CustomerRecordKey').buildfiles.New2Built
                      ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'CustomerRecordKey').buildfiles.Built2QA
                      //  History
                      ,OutputHistoryResults
                      ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'History').buildfiles.New2Built
                      ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'History').buildfiles.Built2QA
                      //  Stats
                      ,HealthcareNoMatchHeader_InternalLinking.Proc_Stats(pSrc,,HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).CRK).NoMatchID_Stats
                    );

  RETURN  runPostProcess;
END;
