IMPORT tools, corp2;

EXPORT Build_Bases_FictName(
	STRING																					  pfiledate,
	STRING																					  pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_ND.Layouts.FictNameLayoutIn)		pInFictName1  = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.FictName1.logical,
	DATASET(Corp2_Raw_ND.Layouts.FictNameLayoutIn)	  pInFictName2  = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.FictName2.logical,
	DATASET(Corp2_Raw_ND.Layouts.FictNameLayoutBase)	pBaseFictName = IF(Corp2_Raw_ND._Flags.Base.FictName, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.FictName.qa, 	DATASET([], Corp2_Raw_ND.Layouts.FictNameLayoutBase))
) := MODULE

	Corp2_Raw_ND.Layouts.FictNameLayoutBase standardize_input(Corp2_Raw_ND.Layouts.FictNameLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the FictName1 & FictName2 update files, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFictName1 + pInFictName2, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseFictName;
	combined_dist := DISTRIBUTE(combined, HASH(ESID));
	combined_sort := SORT(combined_dist, ESID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_ND.Layouts.FictNameLayoutBase rollupBase(Corp2_Raw_ND.Layouts.FictNameLayoutBase L,
																									   Corp2_Raw_ND.Layouts.FictNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseFictName	:= ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_last_received, dt_first_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_ND.Filenames(pversion).Base.FictName.New, baseFictName, Build_FictName_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
							     Build_FictName_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ND.Build_Bases_FictName attribute')
									 );

END;
