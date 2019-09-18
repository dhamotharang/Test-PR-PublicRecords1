#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, STD;
EXPORT Proc_PostProcess( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).Linking().Iteration
  ) :=  FUNCTION

  dAppendCRK    :=  HealthcareNoMatchHeader_InternalLinking.Proc_AppendCRK(pBase);
  pCRKFilename  :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Append.CRK.new;
  OutputResults :=  OUTPUT(dAppendCRK,,pCRKFilename,COMPRESSED,OVERWRITE);

  runPostProcess := SEQUENTIAL(
                      OutputResults
                      ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'CustomerRecordKey').buildfiles.New2Built
                      ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'CustomerRecordKey').buildfiles.Built2QA	
                    );

  RETURN  runPostProcess;
END;
