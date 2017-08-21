IMPORT tools, corp2;

EXPORT Build_Bases_ExecOff(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.ExecOffLayout)		    pInExecOffFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.ExecOffFile,
	DATASET(Corp2_Raw_NY.Layouts.ExecOffLayoutBase)	  pBaseExecOffFile   = IF(Corp2_Raw_NY._Flags.Base.ExecOff, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.ExecOff.qa, 	DATASET([], Corp2_Raw_NY.Layouts.ExecOffLayoutBase))
) := MODULE

  // -----------------------------
  // Build ExecOff Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.ExecOffLayoutBase standardize_ExecOffInput(Corp2_Raw_NY.Layouts.ExecOffLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	ExecOffWorkingUpdate := PROJECT(pInExecOffFile, standardize_ExecOffInput(LEFT));
	ExecOffCombined 			:= ExecOffWorkingUpdate + pBaseExecOffFile;
	ExecOffCombined_dist := DISTRIBUTE(ExecOffCombined, HASH(Executive_corpidno));
	ExecOffCombined_sort := SORT(ExecOffCombined_dist, Executive_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.ExecOffLayoutBase rollupExecOffBase(Corp2_Raw_NY.Layouts.ExecOffLayoutBase L,
																												   Corp2_Raw_NY.Layouts.ExecOffLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseExecOff := ROLLUP(	ExecOffCombined_sort, rollupExecOffBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.ExecOff.New, baseExecOff, Build_ExecOff_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_ExecOff_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_ExecOff attribute')
									 );

END;