IMPORT tools, Corp2;

EXPORT Build_Bases_TrdNamesOwn(
	STRING																				 				pfiledate,
	STRING																				 				pversion,
	BOOLEAN																						    pUseOtherEnvironment,
	DATASET(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutIn)	 		pInTrdNamesOwn   = Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.TrdNamesOwn.logical,
	DATASET(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase) 	pBaseTrdNamesOwn = IF(Corp2_Raw_VT._Flags.Base.TrdNamesOwn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.TrdNamesOwn.qa, DATASET([], Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase))
) := MODULE

	Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase standardize_input(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutIn L) := TRANSFORM
		
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		
	END;

	// Take the VT Corp update file  & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInTrdNamesOwn, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseTrdNamesOwn;
	combined_dist := DISTRIBUTE(combined, HASH(tradename_id));
	combined_sort := SORT(combined_dist, tradename_id, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase rollupBase(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase L,
																												Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase R) := TRANSFORM
																													
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF                    := L;
		
	END;
	
	BaseRollup						 := ROLLUP(	combined_sort,
																		rollupBase(LEFT, RIGHT),
																		RECORD,
																		EXCEPT action_flag, dt_first_received, dt_last_received,
																		LOCAL);
																		
	tools.mac_WriteFile(Corp2_Raw_VT.Filenames(pversion).Base.TrdNamesOwn.New, BaseRollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VT.Build_Bases_TrdNamesOwn attribute')
									 );

END;