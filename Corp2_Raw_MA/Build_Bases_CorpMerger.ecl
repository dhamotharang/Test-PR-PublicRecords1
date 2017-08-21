IMPORT corp2, tools;

EXPORT Build_Bases_CorpMerger(
	STRING																						 pfiledate,
	STRING																						 pversion,
	BOOLEAN																						 puseprod,	
	DATASET(Corp2_Raw_MA.Layouts.CorpMergerLayoutIn)	 pInCorpMerger   = Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpMerger.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpMergerLayoutBase) pBaseCorpMerger = IF(Corp2_Raw_MA._Flags.Base.CorpMerger, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpMerger.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpMergerLayoutBase))
) := MODULE

	Corp2_Raw_MA.Layouts.CorpMergerLayoutBase standardize_input(Corp2_Raw_MA.Layouts.CorpMergerLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(integer)pversion;
		SELF.dt_last_received		:=	(integer)pversion;
		SELF                    :=  L;
	END;

	// Take the MA Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpMerger, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpMerger;
	combined_dist := DISTRIBUTE(combined, HASH(dataid));
	combined_sort := SORT(combined_dist, dataid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MA.Layouts.CorpMergerLayoutBase rollupBase(	Corp2_Raw_MA.Layouts.CorpMergerLayoutBase L,
																												Corp2_Raw_MA.Layouts.CorpMergerLayoutBase R) := TRANSFORM
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
	tools.mac_WriteFile(Corp2_Raw_MA.Filenames(pversion).Base.CorpMerger.New, BaseRollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MA.Build_Bases_CorpMerger attribute')
									 );

END;