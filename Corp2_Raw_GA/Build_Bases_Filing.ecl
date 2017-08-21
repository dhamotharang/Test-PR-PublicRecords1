IMPORT corp2, tools, ut;

EXPORT Build_Bases_Filing(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                               pUseProd,
	DATASET(Corp2_Raw_GA.Layouts.FilingLayoutIn)					pInFiling   	= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Filing.logical,
	DATASET(Corp2_Raw_GA.Layouts.FilingLayoutBase)				pBaseFiling 	= IF(Corp2_Raw_GA._Flags.Base.Filing, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, 	DATASET([], Corp2_Raw_GA.Layouts.FilingLayoutBase))
) := MODULE

	Corp2_Raw_GA.Layouts.FilingLayoutBase standardize_input(Corp2_Raw_GA.Layouts.FilingLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the NV Filing update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFiling, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseFiling;
	combined_dist := DISTRIBUTE(combined, HASH(ControlNumber));
	combined_sort := SORT(combined_dist, ControlNumber, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_GA.Layouts.FilingLayoutBase rollupBase(	Corp2_Raw_GA.Layouts.FilingLayoutBase L,
																										Corp2_Raw_GA.Layouts.FilingLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_GA.Filenames(pversion).Base.Filing.New, baseactions, Build_Filing_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Filing_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_GA.Build_Bases_Filing attribute')
									 );

END;
