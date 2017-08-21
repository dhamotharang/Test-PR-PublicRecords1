IMPORT tools, corp2;

EXPORT Build_Bases_names(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean                                             pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpnamesLayoutIn)		  pInnames   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.Corpnames.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpnamesLayoutBase)	  pBasenames 	= IF(Corp2_Raw_IN._Flags.Base.Corpnames, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.Corpnames.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpnamesLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpnamesLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpnamesLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the IN names update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInnames, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBasenames;
  combined_dist := DISTRIBUTE(combined, HASH(name_packet_number));
  combined_sort := SORT(combined_dist, name_packet_number, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);

	
	Corp2_Raw_IN.Layouts.CorpnamesLayoutBase rollupBase(Corp2_Raw_IN.Layouts.CorpnamesLayoutBase L,
																											Corp2_Raw_IN.Layouts.CorpnamesLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, 
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.Corpnames.New, baseactions, Build_names_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_names_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_names attribute')
									 );

END;
