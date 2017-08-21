IMPORT corp2, tools;

EXPORT Build_Bases_TranDBExtract(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,	
	DATASET(Corp2_Raw_OR.Layouts.TranDBExtractLayoutIn)		pInTranDBExtract   	= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.TranDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase)	pBaseTranDBExtract 	= IF(Corp2_Raw_OR._Flags.Base.TranDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.TranDBExtract.qa, 	DATASET([], Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase))
) := MODULE

	Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase standardize_input(Corp2_Raw_OR.Layouts.TranDBExtractLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the OR TranDBExtract update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTranDBExtract, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseTranDBExtract;
	combined_dist := DISTRIBUTE(combined, HASH(entity_rsn));
	combined_sort := SORT(combined_dist, entity_rsn, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase rollupBase(Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase L,
																																  Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate	(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate		(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
	END;
	
	baserollup			 					:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
	// Return
	tools.mac_WriteFile(Corp2_Raw_OR.Filenames(pversion).Base.TranDBExtract.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OR.Build_Bases_TranDBExtract attribute')
									 );

END;
