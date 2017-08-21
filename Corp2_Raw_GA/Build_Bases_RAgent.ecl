IMPORT corp2, tools, ut;

EXPORT Build_Bases_RAgent(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                               pUseProd,
	DATASET(Corp2_Raw_GA.Layouts.RAgentLayoutIn)					pInRAgent   	= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.RAgent.logical,
	DATASET(Corp2_Raw_GA.Layouts.RAgentLayoutBase)				pBaseRAgent 	= IF(Corp2_Raw_GA._Flags.Base.RAgent, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.RAgent.qa, 	DATASET([], Corp2_Raw_GA.Layouts.RAgentLayoutBase))
) := MODULE

	Corp2_Raw_GA.Layouts.RAgentLayoutBase standardize_input(Corp2_Raw_GA.Layouts.RAgentLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF 										:=  L;
		SELF 										:=  [];
		
	END;

	// Take the NV RAgent update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInRAgent, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseRAgent;
	combined_dist := DISTRIBUTE(combined, HASH(RegisteredAgentId));
	combined_sort := SORT(combined_dist, RegisteredAgentId, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_GA.Layouts.RAgentLayoutBase rollupBase(	Corp2_Raw_GA.Layouts.RAgentLayoutBase L,
																										Corp2_Raw_GA.Layouts.RAgentLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF                    := L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_GA.Filenames(pversion).Base.RAgent.New, baseactions, Build_RAgent_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_RAgent_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_GA.Build_Bases_RAgent attribute')
									 );

END;
