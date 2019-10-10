IMPORT  STD, HealthcareNoMatchHeader_Ingest,VersionControl;
EXPORT Proc_Iterate_Master(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , STRING  pIter     = ''
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).Linking().Iteration
	)	:=	FUNCTION
  
  pIterate  :=  HealthcareNoMatchHeader_InternalLinking.Proc_Iterate(pSrc,pVersion,pIter,pBase); // Change '1' for later iterations
  pDoAll    :=  pIterate.DoAll; // Use this version to run an iteration
  
  // internal linking iterations
  runIteration	:=	SEQUENTIAL(
    pDoAll
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion, pIter).linkingfiles.New2Built
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion, pIter).linkingfiles.Built2QA
    ,HealthcareNoMatchHeader_InternalLinking.Proc_Stats(pSrc,pIter,HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).Linking(pIter).Iteration).Iteration_Stats
	);
                
  RETURN  runIteration;
END;
