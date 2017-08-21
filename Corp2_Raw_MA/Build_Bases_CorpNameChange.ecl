IMPORT corp2, tools;

EXPORT Build_Bases_CorpNameChange(
	STRING																						 		 pfiledate,
	STRING																						 		 pversion,
	BOOLEAN																								 puseprod,	
	DATASET(Corp2_Raw_MA.Layouts.CorpNameChangeLayoutIn)	 pInCorpNameChange   = Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpNameChange.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase) pBaseCorpNameChange = IF(Corp2_Raw_MA._Flags.Base.CorpNameChange, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpNameChange.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase))
) := MODULE

	Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase standardize_input(Corp2_Raw_MA.Layouts.CorpNameChangeLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MA Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpNameChange, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpNameChange;
	combined_dist := DISTRIBUTE(combined, HASH(dataid));
	combined_sort := SORT(combined_dist, dataid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase rollupBase(	Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase L,
																														Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	BaseRollup						 := ROLLUP(	combined_sort,
																		rollupBase(LEFT, RIGHT),
																		RECORD,
																		EXCEPT dt_first_received, dt_last_received,
																		LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MA.Filenames(pversion).Base.CorpNameChange.New, BaseRollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MA.Build_Bases_CorpNameChange attribute')
									 );

END;