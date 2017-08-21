IMPORT tools, corp2;

EXPORT Build_Bases_Chairman(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.ChairmanLayout)		    pInChairmanFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.ChairmanFile,
	DATASET(Corp2_Raw_NY.Layouts.ChairmanLayoutBase)	  pBaseChairmanFile   = IF(Corp2_Raw_NY._Flags.Base.Chairman, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Chairman.qa, 	DATASET([], Corp2_Raw_NY.Layouts.ChairmanLayoutBase))
) := MODULE

  // -----------------------------
  // Build Chairman Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.ChairmanLayoutBase standardize_ChairmanInput(Corp2_Raw_NY.Layouts.ChairmanLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	ChairmanWorkingUpdate := PROJECT(pInChairmanFile, standardize_ChairmanInput(LEFT));
	ChairmanCombined 			:= ChairmanWorkingUpdate + pBaseChairmanFile;
	ChairmanCombined_dist := DISTRIBUTE(ChairmanCombined, HASH(Chairman_corpidno));
	ChairmanCombined_sort := SORT(ChairmanCombined_dist, Chairman_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.ChairmanLayoutBase rollupChairmanBase(Corp2_Raw_NY.Layouts.ChairmanLayoutBase L,
																												     Corp2_Raw_NY.Layouts.ChairmanLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseChairman := ROLLUP(	ChairmanCombined_sort, rollupChairmanBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.Chairman.New, baseChairman, Build_Chairman_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Chairman_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_Chairman attribute')
									 );

END;