IMPORT tools, corp2;

EXPORT Build_Bases_Hist(
	STRING  pfiledate,
	STRING  pversion,
	BOOLEAN	puseprod,
	DATASET(Corp2_Raw_CA.Layouts.HistLayoutIn)	 pInHist   	= Corp2_Raw_CA.Files(pfiledate,pUseProd).Input.Hist.logical,
	DATASET(Corp2_Raw_CA.Layouts.HistLayoutBase) pBaseHist 	= IF(Corp2_Raw_CA._Flags.Base.Hist, Corp2_Raw_CA.Files(,pUseOtherEnvironment := FALSE).Base.Hist.qa, 	DATASET([], Corp2_Raw_CA.Layouts.HistLayoutBase))
) := MODULE

	Corp2_Raw_CA.Layouts.HistLayoutBase standardize_input(Corp2_Raw_CA.Layouts.HistLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the Hist update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInHist, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseHist;
	combined_dist := DISTRIBUTE(combined, HASH(Corp_Number));
	combined_sort := SORT(combined_dist, Corp_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CA.Layouts.HistLayoutBase rollupBase( Corp2_Raw_CA.Layouts.HistLayoutBase L,
																									Corp2_Raw_CA.Layouts.HistLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseHist			 := ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_last_received, dt_first_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CA.Filenames(pversion).Base.Hist.New, baseHist, Build_Hist_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Hist_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CA.Build_Bases_Hist attribute')
									 );

END;
