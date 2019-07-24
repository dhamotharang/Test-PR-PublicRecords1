IMPORT  STD, HealthcareNoMatchHeader_Ingest,VersionControl;
EXPORT Proc_Iterate_Master(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , STRING  pIter
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).Linking().Iteration
   
    // Specificities
    , BOOLEAN doSpecificities = FALSE // build specificities keys used for internal linking build
   
    // Internal Linking
    , BOOLEAN doInternal        = FALSE // perform internal linking
	)	:=	FUNCTION
  
  pIterate  :=  HealthcareNoMatchHeader_InternalLinking.Proc_Iterate(pSrc,pVersion,pIter,pBase); // Change '1' for later iterations
  pDoAll    :=  pIterate.DoAll; // Use this version to run an iteration
  dAll_filenames  :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Keys.dAll_filenames+
                      HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking(pIter).dAll_filenames;
  createsupers    :=  versioncontrol.mUtilities.createsupers(dAll_filenames);

  // Build internal linking Specificities Keys
  runSpecificities  :=  SEQUENTIAL(
                          HealthcareNoMatchHeader_InternalLinking.proc_specificities(pSrc,pVersion)
                        );
  
  // internal linking iterations
  runIterations	:=	SEQUENTIAL(
    pDoAll
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'key').buildfiles.New2Built
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,'key').buildfiles.Built2QA
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,pIter).linkingfiles.New2Built
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,pIter).linkingfiles.Built2QA
    ,HealthcareNoMatchHeader_InternalLinking.Proc_Stats(pSrc,pIter,HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).Linking(pIter).Iteration)
	);

  allSteps  :=  SEQUENTIAL(
                  createsupers,
                // Specificities
                  IFF(doSpecificities, runSpecificities, OUTPUT('Specificities Build Skipped'))
                // Internal Linking
                  ,IFF(doInternal, runIterations, OUTPUT('Internal Linking Build Skipped'))
                );
                
  RETURN  allSteps;
END;
