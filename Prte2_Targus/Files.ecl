IMPORT PRTE2_Targus;

EXPORT Files := MODULE

  //Base
  EXPORT Targus_Base := DATASET(Constants.Base_Prefix +'Targus', Layouts.Base, THOR);
  
  //As_Header
  EXPORT Targus_Header := PROJECT(Targus_Base, transform(Layouts.Key,
                                                             SELF := LEFT, SELF := []));
                                                            
  //Keys
  EXPORT Targus_AddressKey := PROJECT(Targus_Base(prim_name!='' and zip!=''),
                                                  transform(Layouts.Key,
                                                            SELF := LEFT, SELF := []));
  
  EXPORT Targus_DIDKey := PROJECT(Targus_Base(did!=0),
                                                  transform(Layouts.Key,
                                                            SELF := LEFT, SELF := []));
  
  EXPORT Targus_Phonekey := PROJECT(Targus_Base, transform(Layouts.PhoneKey,
                                                 SELF.P7 := LEFT.phone_number[4..10];
                                                 SELF.P3 := LEFT.phone_number[1..3];
                                                 SELF := LEFT;
                                                 SELF := []));
  
  //Input Files
  EXPORT Input_Boca := DATASET('~prte::in::Targus::Boca', Layouts.INPUT, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  EXPORT Input_INS := DATASET('~prte::in::Targus::INS', Layouts.INPUT, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  
END;