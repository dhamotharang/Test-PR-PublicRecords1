IMPORT STD, SALT311, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT Keys(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
  ) := MODULE
  SHARED keys_s := HealthcareNoMatchHeader_InternalLinking.Specificities(pSrc,pVersion,pInfile).Specificities;
   
  EXPORT SpecificitiesDebugKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.Debug_specificities_debug.New;
   
  EXPORT Specificities_Key := INDEX(keys_s,{1},{keys_s},SpecificitiesDebugKeyName);
  SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
  EXPORT BuildAll := Build_Specificities_Key;
END;
 
