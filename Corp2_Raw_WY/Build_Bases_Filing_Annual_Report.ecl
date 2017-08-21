IMPORT corp2, tools, ut;

EXPORT Build_Bases_Filing_Annual_Report(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_WY.Layouts.FilingARLayoutIn)		pInCorps   = Corp2_Raw_WY.Files(pfiledate,pUseProd).Input.FilingAR.Sprayed,
	DATASET(Corp2_Raw_WY.Layouts.FilingARLayoutBase)	pBaseCorps = IF(Corp2_Raw_WY._Flags.Base.FilingAR, Corp2_Raw_WY.Files(,pUseOtherEnvironment := FALSE).Base.FilingAR.qa, DATASET([], Corp2_Raw_WY.Layouts.FilingARLayoutBase))
) := MODULE

	Corp2_Raw_WY.Layouts.FilingARLayoutBase standardize_input(Corp2_Raw_WY.Layouts.FilingARLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the WY Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorps, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorps;
	combined_dist := DISTRIBUTE(combined, HASH(filing_id));
	combined_sort := SORT(combined_dist, filing_id, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WY.Layouts.FilingARLayoutBase rollupBase(	Corp2_Raw_WY.Layouts.FilingARLayoutBase L,
																																Corp2_Raw_WY.Layouts.FilingARLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baserollup 								:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_WY.Filenames(pversion).Base.FilingAR.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WY.Build_Bases_Filing_Annual_Report attribute')
									 );

END;