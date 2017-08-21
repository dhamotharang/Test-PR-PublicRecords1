IMPORT tools, Corp2;

EXPORT Build_Bases_ForProfPrn(
	STRING																				  pfiledate,
	STRING																				 	pversion,
	BOOLEAN																					pUseOtherEnvironment,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)	 			pInForProfPrn   = Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForProfPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase) 		pBaseForProfPrn = IF(Corp2_Raw_VT._Flags.Base.ForProfPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForProfPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase))
) := MODULE

	Corp2_Raw_VT.Layouts.PrnLayoutBase standardize_input(Corp2_Raw_VT.Layouts.PrnLayoutIn L) := TRANSFORM
		
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		
	END;

	// Take the VT Corp update file  & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInForProfPrn, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseForProfPrn;
	combined_dist := DISTRIBUTE(combined, HASH(business_id));
	combined_sort := SORT(combined_dist, business_id, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_VT.Layouts.PrnLayoutBase rollupBase(Corp2_Raw_VT.Layouts.PrnLayoutBase L,
																								Corp2_Raw_VT.Layouts.PrnLayoutBase R) := TRANSFORM
																												
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF                    := L;
		
	END;
	
	BaseRollup						 := ROLLUP(	combined_sort,
																		rollupBase(LEFT, RIGHT),
																		RECORD,
																		EXCEPT dt_last_received, dt_first_received,
																		LOCAL);
																		
	tools.mac_WriteFile(Corp2_Raw_VT.Filenames(pversion).Base.ForProfPrn.New, BaseRollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VT.Build_Bases_ForProfPrn attribute')
									 );

END;