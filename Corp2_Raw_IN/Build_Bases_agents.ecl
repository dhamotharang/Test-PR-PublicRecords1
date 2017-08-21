IMPORT tools, Corp2;

EXPORT Build_Bases_agents(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean                                             pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpagentsLayoutIn)		pInagents   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.Corpagents.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpagentsLayoutBase)	pBaseagents 	= IF(Corp2_Raw_IN._Flags.Base.Corpagents, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.Corpagents.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpagentsLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpagentsLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpagentsLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	//Take the IN agents update file,stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInagents, standardize_input(LEFT));
	
	//Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBaseagents;
  combined_dist := DISTRIBUTE(combined, HASH(agen_packet_number));
  combined_sort := SORT(combined_dist, agen_packet_number, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);

	
	Corp2_Raw_IN.Layouts.CorpagentsLayoutBase rollupBase(Corp2_Raw_IN.Layouts.CorpagentsLayoutBase L,
																											 Corp2_Raw_IN.Layouts.CorpagentsLayoutBase R) := TRANSFORM
																											 
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP( combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
	
	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.Corpagents.New, baseactions, Build_agents_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_agents_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_agents attribute')
									 );

END;
