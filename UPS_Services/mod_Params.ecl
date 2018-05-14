import AutoHeaderI, AutoStandardI;

export mod_Params := MODULE
	export BusinessSearch:= interface(AutoStandardI.DataRestrictionI.params,
																				AutoStandardI.InterfaceTranslator.dppa_purpose.params )
																				
	END;

	export PersonSearch := INTERFACE(UPS_Services.IF_PartialMatchSearchParams, 
																			 AutoStandardI.InterfaceTranslator.industry_class_val.params
																	)
	END;
	
END;