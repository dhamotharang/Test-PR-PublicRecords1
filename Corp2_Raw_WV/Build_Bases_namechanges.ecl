IMPORT tools, Corp2;

EXPORT Build_Bases_namechanges(
	STRING																							pfiledate,
	STRING																						  pversion,
	Boolean 																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.namechangesLayoutIn)		pInnamechanges   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment:= FALSE).Input.namechanges.logical,
	DATASET(Corp2_Raw_WV.Layouts.namechangesLayoutBase)	pBasenamechanges 	= IF(Corp2_Raw_WV._Flags.Base.namechanges, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.namechanges.qa, 	DATASET([], Corp2_Raw_WV.Layouts.namechangesLayoutBase))
) := MODULE

	Corp2_Raw_WV.Layouts.namechangesLayoutBase standardize_input(Corp2_Raw_WV.Layouts.namechangesLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the namechanges update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInnamechanges, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasenamechanges;
	combined_dist := DISTRIBUTE(combined, HASH(record_did));
	combined_sort := SORT(combined_dist, record_did, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WV.Layouts.namechangesLayoutBase rollupBase( Corp2_Raw_WV.Layouts.namechangesLayoutBase L,
																												 Corp2_Raw_WV.Layouts.namechangesLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_WV.Filenames(pversion).Base.namechanges.New, baseactions, Build_namechanges_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_namechanges_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases_namechanges attribute')
									 );

END;
