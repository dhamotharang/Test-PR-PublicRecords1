IMPORT  HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;

  // f_AllRecords := '~temp::RID::HealthCareNoMatchHeader_Ingest::ingest::AllRecords';
  // f_ActiveRecords := '~temp::RID::HealthCareNoMatchHeader_Ingest::ingest::ActiveRecords';

  pSrc :=  '00000099';
// pSrc :=  '16935732';
  dInFile :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords;

EXPORT In_Header := dInFile;