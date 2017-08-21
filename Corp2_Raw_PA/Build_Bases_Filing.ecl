IMPORT tools, Corp2;

EXPORT Build_Bases_Filing(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_PA.Layouts.FilingLayoutIn)					pInFiling   	= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Filing.logical,
	DATASET(Corp2_Raw_PA.Layouts.FilingLayoutBase)				pBaseFiling 	= IF(Corp2_Raw_PA._Flags.Base.Filing, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, 	DATASET([], Corp2_Raw_PA.Layouts.FilingLayoutBase))
) := MODULE

	Corp2_Raw_PA.Layouts.FilingLayoutBase standardize_input(Corp2_Raw_PA.Layouts.FilingLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the PA Filing update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFiling, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseFiling;
	combined_dist := DISTRIBUTE(combined, HASH(corporationid));
	combined_sort := SORT(combined_dist, corporationid, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_PA.Layouts.FilingLayoutBase rollupBase(	Corp2_Raw_PA.Layouts.FilingLayoutBase L,
																										Corp2_Raw_PA.Layouts.FilingLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseFiling			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_PA.Filenames(pversion).Base.Filing.New, baseFiling, Build_Filing_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Filing_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases_Filing attribute')
									 );

END;
