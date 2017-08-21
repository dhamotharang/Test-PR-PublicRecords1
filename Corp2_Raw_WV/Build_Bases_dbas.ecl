IMPORT tools, Corp2;

EXPORT Build_Bases_dbas(
	STRING																						pfiledate,
	STRING																						pversion,
	Boolean 																					pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.dbasLayoutIn)				pIndbas   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment:= FALSE).Input.dbas.logical,
	DATASET(Corp2_Raw_WV.Layouts.dbasLayoutBase)			pBasedbas 	= IF(Corp2_Raw_WV._Flags.Base.dbas, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.dbas.qa, 	DATASET([], Corp2_Raw_WV.Layouts.dbasLayoutBase))
) := MODULE

	Corp2_Raw_WV.Layouts.dbasLayoutBase standardize_input(Corp2_Raw_WV.Layouts.dbasLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the dbas update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pIndbas, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasedbas;
	combined_dist := DISTRIBUTE(combined, HASH(record_did));
	combined_sort := SORT(combined_dist, record_did, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WV.Layouts.dbasLayoutBase rollupBase(Corp2_Raw_WV.Layouts.dbasLayoutBase L,
																								 Corp2_Raw_WV.Layouts.dbasLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_WV.Filenames(pversion).Base.dbas.New, baseactions, Build_dbas_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_dbas_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases_dbas attribute')
									 );

END;
