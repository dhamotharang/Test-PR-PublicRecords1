IMPORT  HealthcareNoMatchHeader_Ingest;
EXPORT  File_Precision(STRING pSrc) := FUNCTION
  RETURN  HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK;
END;