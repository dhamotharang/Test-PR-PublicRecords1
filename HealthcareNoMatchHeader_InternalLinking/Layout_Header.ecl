IMPORT  HealthcareNoMatchHeader_Ingest;

rLayout :=  RECORD
  HealthcareNoMatchHeader_Ingest.Layout_Base;
  UNSIGNED1 __tpe;
END;

EXPORT Layout_Header := rLayout;