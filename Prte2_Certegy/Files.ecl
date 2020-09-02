IMPORT business_header, TopBusiness_BIPV2, Cortera, PRTE2_Cortera, PRTE2;
EXPORT Files := MODULE

  //Base
  EXPORT Certegy_Base := DATASET(PRTE2_certegy.Constants.base_prefix +'Certegy', PRTE2_certegy.Layouts.Base, thor);

  EXPORT Certegy_Header := PROJECT(Certegy_Base, TRANSFORM(PRTE2_certegy.Layouts.certegy_prod, 
                                                           SELF := LEFT, 
                                                           SELF := []));

  //Key
  EXPORT Key_did := dedup(PROJECT(Certegy_Base, TRANSFORM(PRTE2_certegy.Layouts.Key, 
                                                          SELF := LEFT, 
                                                          SELF := [])), record,all);  
  
  //Input Files
  EXPORT Input_INS  := DATASET('~prte::in::certegy::Insurance', PRTE2_certegy.Layouts.INPUT, CSV(HEADING(3), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'))); 

END;