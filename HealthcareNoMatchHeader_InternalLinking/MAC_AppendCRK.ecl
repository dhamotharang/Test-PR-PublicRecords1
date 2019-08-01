IMPORT  STD, HealthcareNoMatchHeader_Ingest,VersionControl;
EXPORT  MAC_AppendCRK(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pBase = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords // Change IN_Base to change input to ingest process
    , DATASET(RECORDOF(HealthCareNoMatchHeader_Ingest.In_Ingest))  pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AsHeaderIngest 
)	:=	FUNCTION

  //  First Build - run Ingest and Specificities
  pIngest :=  
    HealthcareNoMatchHeader_InternalLinking.proc_build_all(
      pSrc
      ,pVersion
      ,
      ,pBase
      ,pInfile

        // Ingest
      ,TRUE //  doIngest
      ,TRUE //  doIngestStats
       
        // Specificities
      ,TRUE //  doSpecificities
       
        // Internal Linking
      ,   //  doInternalGetBase
      ,   //  doInternal

        // Append CRK
      ,   //  doAppendCRK
    ).All;

  #WORKUNIT('NAME','Healthcare NoMatch Customer Record Key for SRC='+pSrc);

  //  First Iteration - Copy Ingest to Base and run
  pIteration1 :=  
    HealthcareNoMatchHeader_InternalLinking.proc_build_all(
      pSrc
      ,pVersion
      ,'1'
      , //  pBase
      , //  pInfile

        // Ingest
      ,  //  doIngest
      ,  //  doIngestStats
       
        // Specificities
      ,  //  doSpecificities
       
        // Internal Linking
      ,TRUE  //  doInternalGetBase
      ,TRUE  //  doInternal

        // Append CRK
      ,   //  doAppendCRK
    ).All;

  //  Second Iteration
  pIteration2 :=  
    HealthcareNoMatchHeader_InternalLinking.proc_build_all(
      pSrc
      ,pVersion
      ,'2'
      , //  pBase
      , //  pInfile

        // Ingest
      ,  //  doIngest
      ,  //  doIngestStats
       
        // Specificities
      ,  //  doSpecificities
       
        // Internal Linking
      ,   //  doInternalGetBase
      ,TRUE  //  doInternal

        // Append CRK
      ,   //  doAppendCRK
    ).All;

  //  Third Iteration
  pIteration3 :=  
    HealthcareNoMatchHeader_InternalLinking.proc_build_all(
      pSrc
      ,pVersion
      ,'3'
      , //  pBase
      , //  pInfile

        // Ingest
      ,  //  doIngest
      ,  //  doIngestStats
       
        // Specificities
      ,  //  doSpecificities
       
        // Internal Linking
      ,   //  doInternalGetBase
      ,TRUE  //  doInternal

        // Append CRK
      ,   //  doAppendCRK
    ).All;

  //  Fourth Iteration
  pIteration4 :=  
    HealthcareNoMatchHeader_InternalLinking.proc_build_all(
      pSrc
      ,pVersion
      ,'4'
      , //  pBase
      , //  pInfile

        // Ingest
      ,  //  doIngest
      ,  //  doIngestStats
       
        // Specificities
      ,  //  doSpecificities
       
        // Internal Linking
      ,   //  doInternalGetBase
      ,TRUE  //  doInternal

        // Append CRK
      ,   //  doAppendCRK
    ).All;

  //  Append Customer Record Key
  pAppendCRK :=  
    HealthcareNoMatchHeader_InternalLinking.proc_build_all(
      pSrc
      ,pVersion
      ,
      , //  pBase
      , //  pInfile

        // Ingest
      ,  //  doIngest
      ,  //  doIngestStats
       
        // Specificities
      ,  //  doSpecificities
       
        // Internal Linking
      ,   //  doInternalGetBase
      ,   //  doInternal

        // Append CRK
      ,TRUE  //  doAppendCRK
    ).All;
  
  allSteps  :=  SEQUENTIAL(
                  pIngest       //  Ingest
                  ,pIteration1  //  Run 4 Iterations
                  ,pIteration2
                  ,pIteration3
                  ,pIteration4
                  ,pAppendCRK   //  Append Customer Record Key
                );
                
  RETURN  allSteps;
END;

