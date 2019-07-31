IMPORT  HealthcareNoMatchHeader_Ingest;

  dInFile :=  DATASET([],HealthcareNoMatchHeader_Ingest.Layout_Base);

EXPORT In_Base := dInFile;
