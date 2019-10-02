IMPORT  HealthcareNoMatchHeader_ExternalLinking,HealthcareNoMatchHeader_Ingest;

  // pSrc :=  '00000099';
pSrc :=  '16935732';
  dInFile :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK;

EXPORT File_Header := dInFile;