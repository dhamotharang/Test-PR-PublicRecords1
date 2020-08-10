IMPORT AutoHeaderI, AutoStandardI;

EXPORT mod_Params := MODULE

  EXPORT BusinessSearch:= INTERFACE(AutoStandardI.DataRestrictionI.params,
                                        AutoStandardI.InterfaceTranslator.dppa_purpose.params )
                                        
  END;

  EXPORT PersonSearch := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
                                   AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
                                       AutoStandardI.InterfaceTranslator.industry_class_val.params)
     EXPORT UNSIGNED8 MaxResults;
     EXPORT STRING20 PhoneScoreModel := 'PHONESCORE_V2': STORED('PhoneScoreModel');
     EXPORT INTEGER MaxNumPhoneSubject := 0;
  END;
  
END;
