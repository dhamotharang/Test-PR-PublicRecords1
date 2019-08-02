IMPORT  STD, HealthcareNoMatchHeader_Ingest,VersionControl;
EXPORT proc_build_all(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , STRING  pIter     = ''
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords // Change IN_Base to change input to ingest process
    , DATASET(RECORDOF(HealthCareNoMatchHeader_Ingest.In_Ingest))  pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AsHeaderIngest 

    // Ingest
    , BOOLEAN doIngest      = FALSE // perform full ingest process (ingest incremental and non-incremental sources into existing base file)
    , BOOLEAN doIngestStats = FALSE // generate statistics on full ingest process
   
    // Specificities
    , BOOLEAN doSpecificities = FALSE // build specificities keys used for internal linking build
   
    // Internal Linking
    , BOOLEAN doInternalGetBase = FALSE // use results from above to create new base for internal linking (SALT input)
    , BOOLEAN doInternal        = FALSE // perform internal linking
	
    // Append CRK
    , BOOLEAN doAppendCRK       = FALSE // Append CRK to Internal Linking Base File
)	:=	MODULE

  // get current full base from ingest to feed internal linking (sets SALT input superfile)
  runInternalGetBase  :=  SEQUENTIAL(
    OUTPUT(HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords,,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking('0').Iteration.new,COMPRESSED) //  Move AllRecords to it0
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,'0').linkingfiles.New2Built
    ,HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,'0').linkingfiles.Built2QA
  );

	EXPORT	full_build	:=	SEQUENTIAL(
    HealthcareNoMatchHeader_InternalLinking.Proc_PreProcess(pSrc,pVersion)
    ,HealthcareNoMatchHeader_Ingest.Proc_Ingest_Master(pSrc,pVersion,pBase,pInfile,doIngest,doIngestStats)
    ,IFF(doInternalGetBase, runInternalGetBase, OUTPUT('Get New Internal Linking Base Skipped'))
    ,HealthcareNoMatchHeader_InternalLinking.Proc_Iterate_Master(pSrc,pVersion,pIter,,doSpecificities,doInternal)
    ,IFF(doAppendCRK, HealthcareNoMatchHeader_InternalLinking.Proc_PostProcess(pSrc,pVersion,pBase), OUTPUT('Append Customer Record Key Skipped'))  
	);

	EXPORT	All	:=
	IF(
    pSrc  <>  ''
    ,IF(
      VersionControl.IsValidVersion(pVersion)
      ,full_build
      ,OUTPUT('No Valid version parameter passed, skipping HealthcareNoMatchHeader_InternalLinking.proc_build_all().All')
    )
		,OUTPUT('No Valid Source parameter passed, skipping HealthcareNoMatchHeader_InternalLinking.proc_build_all().All')
	);
end;
