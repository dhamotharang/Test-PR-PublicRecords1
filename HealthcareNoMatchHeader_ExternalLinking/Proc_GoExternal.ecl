IMPORT  STD, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT  Proc_GoExternal(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
  ) := PARALLEL(
    Keys(pSrc,pVersion,pInfile).BuildAll,
    Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).BuildAll,
    Key_HEADER_(pSrc,pVersion,pInfile).BuildAll,
    Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).BuildAll
);
