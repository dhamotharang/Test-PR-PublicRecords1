IMPORT tools, corp2;

EXPORT Build_Bases_f03_Agent(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.Agent_03_Layout)		  pInf03_Agent   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f03_Agent,
	DATASET(Corp2_Raw_OK.Layouts.Agent_03_LayoutBase)	pBasef03_Agent 	= IF(Corp2_Raw_OK._Flags.Base.f03_Agent, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f03_Agent.qa, 	DATASET([], Corp2_Raw_OK.Layouts.Agent_03_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.Agent_03_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.Agent_03_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f03_Agent update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf03_Agent, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef03_Agent;
	combined_dist := DISTRIBUTE(combined, HASH(f03_Filing_Number));
	combined_sort := SORT(combined_dist, f03_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.Agent_03_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.Agent_03_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.Agent_03_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef03_Agent			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f03_Agent.New, basef03_Agent, Build_f03_Agent_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f03_Agent_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f03_Agent attribute')
									 );

END;
