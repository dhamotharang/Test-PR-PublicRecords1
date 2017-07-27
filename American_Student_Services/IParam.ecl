import AutoKeyI, AutoStandardI, AutoHeaderI, suppress;

EXPORT IParam := MODULE

	EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := FALSE;
		EXPORT BOOLEAN noFail := FALSE;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	EXPORT reportParams := INTERFACE (AutoStandardI.PermissionI_Tools.params,
																		AutoStandardI.InterfaceTranslator.application_type_val.params)			
		EXPORT STRING14 	didValue := '';
		EXPORT UNSIGNED2 	penalty_threshold := 10;
		EXPORT STRING6 		ssnMask := 'ALL'; 
		EXPORT unsigned1 	dob_mask_value := suppress.Constants.dateMask.NONE; 

	END;
	
	EXPORT searchParams := interface(reportParams, 
										AutoStandardI.LIBIN.PenaltyI.base, 
										AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
										AutoKeyIdsParams)	
	END;
	

END;