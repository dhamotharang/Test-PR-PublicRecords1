IMPORT tools, corp2;

EXPORT Build_Bases_CurrPart(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.CurrPartLayout)		    pInCurrPartFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.CurrPartFile,
	DATASET(Corp2_Raw_NY.Layouts.CurrPartLayoutBase)	  pBaseCurrPartFile   = IF(Corp2_Raw_NY._Flags.Base.CurrPart, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.CurrPart.qa, 	DATASET([], Corp2_Raw_NY.Layouts.CurrPartLayoutBase))
) := MODULE

  // -----------------------------
  // Build CurrPart Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.CurrPartLayoutBase standardize_CurrPartInput(Corp2_Raw_NY.Layouts.CurrPartLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	CurrPartWorkingUpdate := PROJECT(pInCurrPartFile, standardize_CurrPartInput(LEFT));
	CurrPartCombined 			:= CurrPartWorkingUpdate + pBaseCurrPartFile;
	CurrPartCombined_dist := DISTRIBUTE(CurrPartCombined, HASH(CurrPart_corpidno));
	CurrPartCombined_sort := SORT(CurrPartCombined_dist, CurrPart_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.CurrPartLayoutBase rollupCurrPartBase(Corp2_Raw_NY.Layouts.CurrPartLayoutBase L,
																												     Corp2_Raw_NY.Layouts.CurrPartLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseCurrPart := ROLLUP(	CurrPartCombined_sort, rollupCurrPartBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.CurrPart.New, baseCurrPart, Build_CurrPart_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_CurrPart_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_CurrPart attribute')
									 );

END;