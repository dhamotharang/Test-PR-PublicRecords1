IMPORT tools, corp2;

EXPORT Build_Bases_Mast(
	STRING  pfiledate,
	STRING  pversion,
	BOOLEAN	puseprod,
	DATASET(Corp2_Raw_CA.Layouts.MastLayoutIn)	 pInMast   	= Corp2_Raw_CA.Files(pfiledate,pUseProd).Input.Mast.logical,
	DATASET(Corp2_Raw_CA.Layouts.MastLayoutBase) pBaseMast 	= IF(Corp2_Raw_CA._Flags.Base.Mast, Corp2_Raw_CA.Files(,pUseOtherEnvironment := FALSE).Base.Mast.qa, 	DATASET([], Corp2_Raw_CA.Layouts.MastLayoutBase))
) := MODULE

	Corp2_Raw_CA.Layouts.MastLayoutBase standardize_input(Corp2_Raw_CA.Layouts.MastLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the Mast update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInMast, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseMast;
	combined_dist := DISTRIBUTE(combined, HASH(Corp_Number));
	combined_sort := SORT(combined_dist, Corp_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CA.Layouts.MastLayoutBase rollupBase( Corp2_Raw_CA.Layouts.MastLayoutBase L,
																									Corp2_Raw_CA.Layouts.MastLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseMast			 := ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_last_received, dt_first_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CA.Filenames(pversion).Base.Mast.New, baseMast, Build_Mast_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Mast_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CA.Build_Bases_Mast attribute')
									 );

END;
