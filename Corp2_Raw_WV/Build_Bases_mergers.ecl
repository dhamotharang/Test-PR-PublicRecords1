IMPORT tools, Corp2;

EXPORT Build_Bases_mergers(
	STRING																					pfiledate,
	STRING																					pversion,
	Boolean 																				pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.mergersLayoutIn)		pInmergers   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment:= FALSE).Input.mergers.logical,
	DATASET(Corp2_Raw_WV.Layouts.mergersLayoutBase)	pBasemergers 	= IF(Corp2_Raw_WV._Flags.Base.mergers, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.mergers.qa, 	DATASET([], Corp2_Raw_WV.Layouts.mergersLayoutBase))
) := MODULE

	Corp2_Raw_WV.Layouts.mergersLayoutBase standardize_input(Corp2_Raw_WV.Layouts.mergersLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the  mergers update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInmergers, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasemergers;
	combined_dist := DISTRIBUTE(combined, HASH(SurvivingCorpID,MergingCorpID));
	combined_sort := SORT(combined, SurvivingCorpID, MergingCorpID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WV.Layouts.mergersLayoutBase rollupBase( Corp2_Raw_WV.Layouts.mergersLayoutBase L,
																										 Corp2_Raw_WV.Layouts.mergersLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_WV.Filenames(pversion).Base.mergers.New, baseactions, Build_mergers_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_mergers_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases_mergers attribute')
									 );

END;
