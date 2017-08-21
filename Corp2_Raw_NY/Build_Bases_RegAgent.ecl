IMPORT tools, corp2;

EXPORT Build_Bases_RegAgent(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.RegAgentLayout)		    pInRegAgentFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.RegAgentFile,
	DATASET(Corp2_Raw_NY.Layouts.RegAgentLayoutBase)	  pBaseRegAgentFile   = IF(Corp2_Raw_NY._Flags.Base.RegAgent, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.RegAgent.qa, 	DATASET([], Corp2_Raw_NY.Layouts.RegAgentLayoutBase))
) := MODULE

  // -----------------------------
  // Build RegAgent Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.RegAgentLayoutBase standardize_RegAgentInput(Corp2_Raw_NY.Layouts.RegAgentLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	RegAgentWorkingUpdate := PROJECT(pInRegAgentFile, standardize_RegAgentInput(LEFT));
	RegAgentCombined 			:= RegAgentWorkingUpdate + pBaseRegAgentFile;
	RegAgentCombined_dist := DISTRIBUTE(RegAgentCombined, HASH(register_corpidno));
	RegAgentCombined_sort := SORT(RegAgentCombined_dist, register_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.RegAgentLayoutBase rollupRegAgentBase(Corp2_Raw_NY.Layouts.RegAgentLayoutBase L,
																												     Corp2_Raw_NY.Layouts.RegAgentLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseRegAgent := ROLLUP(	RegAgentCombined_sort, rollupRegAgentBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.RegAgent.New, baseRegAgent, Build_RegAgent_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_RegAgent_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_RegAgent attribute')
									 );

END; 