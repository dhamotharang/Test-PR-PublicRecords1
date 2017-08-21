IMPORT tools, Corp2;

EXPORT Build_Bases_RegisterAgent(
	STRING																								pfiledate,
	STRING																								pversion,	
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_NE.Layouts.RegisterAgentLayoutIn)		pInRegisterAgent   	= Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment := FALSE).Input.RegisterAgent.Logical,
	DATASET(Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase)	pBaseRegisterAgent  = IF(Corp2_Raw_NE._Flags.Base.RegisterAgent, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.RegisterAgent.qa, 	DATASET([], Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase))
) := MODULE

	Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase standardize_input(Corp2_Raw_NE.Layouts.RegisterAgentLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the RegisterAgent update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInRegisterAgent, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseRegisterAgent;
	combined_dist := DISTRIBUTE(combined, HASH(AcctNumber));
	combined_sort := SORT(combined_dist, AcctNumber, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase rollupBase(Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase L,
																													Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															RollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_NE.Filenames(pversion).Base.RegisterAgent.New, baseactions, Build_RegisterAgent_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_RegisterAgent_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NE.Build_Bases_RegisterAgent attribute')
									 );

END;
