IMPORT tools, corp2;

EXPORT Build_Bases_f17_CorpFiling(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.CorpFiling_17_Layout)		  pInf17_CorpFiling   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f17_CorpFiling,
	DATASET(Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase)	pBasef17_CorpFiling 	= IF(Corp2_Raw_OK._Flags.Base.f17_CorpFiling, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f17_CorpFiling.qa, 	DATASET([], Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.CorpFiling_17_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f17_CorpFiling update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf17_CorpFiling, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef17_CorpFiling;
	combined_dist := DISTRIBUTE(combined, HASH(f17_Filing_Number));
	combined_sort := SORT(combined_dist, f17_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef17_CorpFiling			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f17_CorpFiling.New, basef17_CorpFiling, Build_f17_CorpFiling_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f17_CorpFiling_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f17_CorpFiling attribute')
									 );

END;
