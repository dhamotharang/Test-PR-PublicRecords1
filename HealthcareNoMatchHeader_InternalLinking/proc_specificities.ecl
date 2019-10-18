IMPORT  STD, HealthcareNoMatchHeader_Ingest, HealthcareNoMatchHeader_InternalLinking;
EXPORT proc_specificities(
  STRING	pSrc        = ''
  , STRING  pVersion  = (STRING)STD.Date.Today()
	)	:=	FUNCTION
  
  dInHeader :=  HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).AllRecords;
  SpecMod   :=  HealthcareNoMatchHeader_InternalLinking.Specificities(pSrc,pVersion,dInHeader);

  runSpecificities  :=  SEQUENTIAL(
                          SpecMod.Build
                          ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'key').buildfiles.New2Built
                          ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'key').buildfiles.Built2QA
                        );
                        
  RETURN runSpecificities;
END;
