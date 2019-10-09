IMPORT  HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;

  // pSrc :=  '00000099';
pSrc :=  '16935732';
  dInFile :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords;

EXPORT File_Header := dInFile;