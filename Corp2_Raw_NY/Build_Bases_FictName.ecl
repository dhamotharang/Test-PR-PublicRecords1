IMPORT tools, corp2;

EXPORT Build_Bases_FictName(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.FictNameLayout)		    pInFictNameFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.FictNameFile,
	DATASET(Corp2_Raw_NY.Layouts.FictNameLayoutBase)	  pBaseFictNameFile   = IF(Corp2_Raw_NY._Flags.Base.FictName, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.FictName.qa, 	DATASET([], Corp2_Raw_NY.Layouts.FictNameLayoutBase))
) := MODULE

  // -----------------------------
  // Build FictName Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.FictNameLayoutBase standardize_FictNameInput(Corp2_Raw_NY.Layouts.FictNameLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	FictNameWorkingUpdate := PROJECT(pInFictNameFile, standardize_FictNameInput(LEFT));
	FictNameCombined 			:= FictNameWorkingUpdate + pBaseFictNameFile;
	FictNameCombined_dist := DISTRIBUTE(FictNameCombined, HASH(FictName_corpidno));
	FictNameCombined_sort := SORT(FictNameCombined_dist, FictName_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.FictNameLayoutBase rollupFictNameBase(Corp2_Raw_NY.Layouts.FictNameLayoutBase L,
																												     Corp2_Raw_NY.Layouts.FictNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseFictName := ROLLUP(	FictNameCombined_sort, rollupFictNameBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.FictName.New, baseFictName, Build_FictName_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_FictName_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_FictName attribute')
									 );

END;