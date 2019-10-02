IMPORT  STD, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT CandidatesForKey(
  STRING	pSrc        = ''
  , STRING  pVersion  = (STRING)STD.Date.Today()
  , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
) := Scaled_Candidates(pSrc,pVersion,pInfile);
