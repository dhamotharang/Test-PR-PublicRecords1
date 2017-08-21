IMPORT corp2, tools;

EXPORT Build_Bases(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_ME.Layouts.CorpBulkLayoutIn)		pInCorpBulk   = Corp2_Raw_ME.Files(pfiledate,puseprod).Input.CorpBulk.Logical,
	DATASET(Corp2_Raw_ME.Layouts.CorpBulkLayoutBase)	pBaseCorpBulk = IF(Corp2_Raw_ME._Flags.Base.CorpBulk, Corp2_Raw_ME.Files(,pUseOtherEnvironment := FALSE).Base.CorpBulk.qa, DATASET([], Corp2_Raw_ME.Layouts.CorpBulkLayoutBase))
) := MODULE

	Corp2_Raw_ME.Layouts.CorpBulkLayoutBase standardize_input(Corp2_Raw_ME.Layouts.CorpBulkLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:= L;
	end;

	// Take the NM Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpBulk, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpBulk;
	combined_dist := DISTRIBUTE(combined, HASH(corp_id));
	combined_sort := SORT(combined_dist, corp_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_ME.Layouts.CorpBulkLayoutBase rollupBase(	Corp2_Raw_ME.Layouts.CorpBulkLayoutBase L,
																											Corp2_Raw_ME.Layouts.CorpBulkLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	base 						:= ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_ME.Filenames(pversion).Base.CorpBulk.New, base, Build_Corporation_Base);

	EXPORT full_build := sequential(	Build_Corporation_Base,
																		Promote(pversion).buildfiles.New2Built,	
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ME.Build_Bases attribute')
									 );

END;
