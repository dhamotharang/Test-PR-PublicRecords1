import AutoHeaderI, AutoStandardI;

export mod_Params := MODULE

	export BusinessSearch:= interface(AutoStandardI.DataRestrictionI.params,
																				AutoStandardI.InterfaceTranslator.dppa_purpose.params )
																				
	END;

	export PersonSearch := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
	                                 AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
																			 AutoStandardI.InterfaceTranslator.industry_class_val.params)
     export UNSIGNED8 MaxResults;
     export string20  PhoneScoreModel := 'PHONESCORE_V2': stored('PhoneScoreModel');
     export integer MaxNumPhoneSubject := 0;
	END;
	
END;