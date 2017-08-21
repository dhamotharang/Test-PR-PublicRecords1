IMPORT tools, corp2;

EXPORT Build_Bases_OrigPart(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.OrigPartLayout)		    pInOrigPartFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.OrigPartFile,
	DATASET(Corp2_Raw_NY.Layouts.OrigPartLayoutBase)	  pBaseOrigPartFile   = IF(Corp2_Raw_NY._Flags.Base.OrigPart, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.OrigPart.qa, 	DATASET([], Corp2_Raw_NY.Layouts.OrigPartLayoutBase))
) := MODULE

  // -----------------------------
  // Build OrigPart Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.OrigPartLayoutBase standardize_OrigPartInput(Corp2_Raw_NY.Layouts.OrigPartLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	OrigPartWorkingUpdate := PROJECT(pInOrigPartFile, standardize_OrigPartInput(LEFT));
	OrigPartCombined 			:= OrigPartWorkingUpdate + pBaseOrigPartFile;
	OrigPartCombined_dist := DISTRIBUTE(OrigPartCombined, HASH(OrigPart_corpidno));
	OrigPartCombined_sort := SORT(OrigPartCombined_dist, OrigPart_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.OrigPartLayoutBase rollupOrigPartBase(Corp2_Raw_NY.Layouts.OrigPartLayoutBase L,
																												     Corp2_Raw_NY.Layouts.OrigPartLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseOrigPart := ROLLUP(	OrigPartCombined_sort, rollupOrigPartBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.OrigPart.New, baseOrigPart, Build_OrigPart_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_OrigPart_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_OrigPart attribute')
									 );

END;