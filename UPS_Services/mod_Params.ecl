import AutoHeaderI, AutoStandardI;

export mod_Params := MODULE
	export BusinessSearch:= interface(AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
																		AutoStandardI.InterfaceTranslator.dppa_purpose.params )
		export UNSIGNED MaxResults := 0;
	END;

	export PersonSearch := INTERFACE(UPS_Services.IF_PartialMatchSearchParams, 
																	 AutoStandardI.InterfaceTranslator.industry_class_val.params)
	END;
END;