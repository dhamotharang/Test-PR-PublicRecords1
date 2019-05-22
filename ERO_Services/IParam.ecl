import AutoKeyI, AutoHeaderI, AutoStandardI, suppress;

export IParam := module

	EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := true;
		EXPORT BOOLEAN noFail := true;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	EXPORT searchParams := INTERFACE (AutoStandardI.PermissionI_Tools.params,
																		AutoStandardI.LIBIN.PenaltyI.base, 
																		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
																		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
																		AutoKeyIdsParams)			
		EXPORT BOOLEAN 		noFail := true;
		EXPORT UNSIGNED2 	penalty_threshold := 10;
		EXPORT UNSIGNED2 	max_results := 10;
		EXPORT STRING6 		ssnMask := 'NONE'; 
		EXPORT unsigned1 	dob_mask_value := suppress.Constants.dateMask.NONE; 
	END;			
end;
