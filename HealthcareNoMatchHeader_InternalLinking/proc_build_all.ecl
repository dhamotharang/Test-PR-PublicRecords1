IMPORT  STD, HealthcareNoMatchHeader_Ingest,VersionControl;
EXPORT proc_build_all(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , STRING  pIter     = ''
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).BaseTemp
    , DATASET(HealthcareNoMatchHeader_Ingest.Layout_Base)  pAsHeader = HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).AsHeaderTemp 

    // Ingest
    , BOOLEAN doIngest          = FALSE // perform full ingest process (ingest incremental and non-incremental sources into existing base file)
   
    // Specificities
    , BOOLEAN doSpecificities   = FALSE // build specificities keys used for internal linking build
   
    // Internal Linking
    , BOOLEAN doInternalGetBase = FALSE // use results from above to create new base for internal linking (SALT input)
    , BOOLEAN doInternal        = FALSE // perform internal linking
	
    // Append CRK
    , BOOLEAN doAppendCRK       = FALSE // Append CRK to Internal Linking Base File
)	:=	MODULE

  ingestFileExist         :=  STD.File.FileExists(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Base.AllRecords.new);
  specificitiesFileExists :=  STD.File.FileExists(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Keys.Specificities.New);
  internalBasefileExists  :=  STD.File.FileExists(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking('0').Iteration.new);
  appendCRKFileExists     :=  STD.File.FileExists(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Append.CRK.new);

  //  Ingest file
  runIngest :=  IFF(~ingestFileExist,
                  HealthcareNoMatchHeader_Ingest.Proc_Ingest_Master(pSrc,pVersion,pBase,pAsHeader),
                  OUTPUT('Ingest file already created.')
                );

  // Build internal linking Specificities Keys
  runSpecificities  :=  IFF(~specificitiesFileExists,
                          HealthcareNoMatchHeader_InternalLinking.proc_specificities(pSrc,pVersion),
                          OUTPUT('Specificities files already created.')
                        );
                        
  // get current full base from ingest to feed internal linking (sets SALT input superfile)
  runInternalGetBase  :=  IFF(~internalBasefileExists,
                            SEQUENTIAL(
                              OUTPUT(HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords,,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking('0').Iteration.new,COMPRESSED,OVERWRITE) //  Move AllRecords to it0
                              ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,'0').linkingfiles.New2Built
                              ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,'0').linkingfiles.Built2QA
                            ),
                            OUTPUT('Internal base file already created.')
                          );

  //  Run Internal Linking Iteration
  runInternalLinkingIteration  := HealthcareNoMatchHeader_InternalLinking.Proc_Iterate_Master(pSrc,pVersion,pIter);

  //  Append Customer Record Keys to Internal Linking File
  runAppendCRK  :=  IFF(~appendCRKFileExists,
                      HealthcareNoMatchHeader_InternalLinking.Proc_PostProcess(pSrc,pVersion,HealthcareNoMatchHeader_Ingest.Files(pSrc).Linking().Iteration),
                      OUTPUT('Append Customer Record Key already created.')
                    );
      
	EXPORT	full_build	:=	SEQUENTIAL(
      //  Create Superfiles
    HealthcareNoMatchHeader_InternalLinking.Proc_PreProcess(pSrc,pVersion)
      //  Ingest and Ingest Stats
    ,IFF(doIngest, runIngest, OUTPUT('Ingest Skipped.'))
      //  Specificities
    ,IFF(doSpecificities, runSpecificities, OUTPUT('Specificities skipped.'))
      //  Create Iterations Basefile
    ,IFF(doInternalGetBase, runInternalGetBase, OUTPUT('Move Ingest file to Internal file skipped.'))
      //  Run Iterations
    ,IFF(doInternal, runInternalLinkingIteration, OUTPUT('Internal Linking Build Skipped.'))
      //  Append Customer Record Keys
    ,IFF(doAppendCRK, runAppendCRK, OUTPUT('Append Customer Record Key Skipped.'))  
	);

	EXPORT	All	:=
	IF(
    pSrc  <>  ''
    ,IF(
      pVersion <> ''
      ,full_build
      ,OUTPUT('No Valid version parameter passed, skipping HealthcareNoMatchHeader_InternalLinking.proc_build_all().All')
    )
		,OUTPUT('No Valid Source parameter passed, skipping HealthcareNoMatchHeader_InternalLinking.proc_build_all().All')
	);
end;
