IMPORT  HealthcareNoMatchHeader_Ingest;
pSrc :=  '00000099';
// pSrc :=  '16935732';
dInfile :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).AsHeader;

EXPORT In_NoMatchHeader := dInFile;