IMPORT tools, corp2;

EXPORT Build_Bases_Merger(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.MergerLayoutIn)		  pInMergerFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.MergerUnload,
	DATASET(Corp2_Raw_NY.Layouts.MergerLayoutBase)	  pBaseMergerFile   = IF(Corp2_Raw_NY._Flags.Base.Merger, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa, 	DATASET([], Corp2_Raw_NY.Layouts.MergerLayoutBase))
) := MODULE

  // -----------------------------
  // Build Merger Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.MergerLayoutBase standardize_MergerInput(Corp2_Raw_NY.Layouts.MergerLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	MergerWorkingUpdate := PROJECT(pInMergerFile, standardize_MergerInput(LEFT));
	MergerCombined 			:= MergerWorkingUpdate + pBaseMergerFile;
	MergerCombined_dist := DISTRIBUTE(MergerCombined, HASH(merger_corp_id_no));
	MergerCombined_sort := SORT(MergerCombined_dist, merger_corp_id_no, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.MergerLayoutBase rollupMergerBase(Corp2_Raw_NY.Layouts.MergerLayoutBase L,
																												 Corp2_Raw_NY.Layouts.MergerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseMerger := ROLLUP(	MergerCombined_sort, rollupMergerBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.Merger.New, baseMerger, Build_Merger_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Merger_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_Merger attribute')
									 );

END;