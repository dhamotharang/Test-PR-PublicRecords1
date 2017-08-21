IMPORT corp2, tools;

EXPORT Build_Bases_CountyDBExtract(
	STRING																									pfiledate,
	STRING																									pversion,
	BOOLEAN																									puseprod,	
	DATASET(Corp2_Raw_OR.Layouts.CountyDBExtractLayoutIn)		pInCountyDBExtract   	= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.CountyDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase)	pBaseCountyDBExtract 	= IF(Corp2_Raw_OR._Flags.Base.CountyDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.CountyDBExtract.qa, 	DATASET([], Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase))
) := MODULE

	Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase standardize_input(Corp2_Raw_OR.Layouts.CountyDBExtractLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the OR CountyDBExtract update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCountyDBExtract, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCountyDBExtract;
	combined_dist := DISTRIBUTE(combined, HASH(entity_rsn));
	combined_sort := SORT(combined_dist, entity_rsn, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase rollupBase(Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase L,
																														Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase R) := TRANSFORM
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
	tools.mac_WriteFile(Corp2_Raw_OR.Filenames(pversion).Base.CountyDBExtract.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OR.Build_Bases_CountyDBExtract attribute')
									 );

END;
