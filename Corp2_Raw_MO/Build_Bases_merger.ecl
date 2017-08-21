IMPORT tools, corp2;

EXPORT Build_Bases_merger(
	STRING																					pfiledate,
	STRING																					pversion,
	Boolean 																				pUseOtherEnvironment,
	DATASET(Corp2_Raw_MO.Layouts.mergerLayoutIn)		pInmerger   	= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.merger.Logical,
	DATASET(Corp2_Raw_MO.Layouts.mergerLayoutBase)	pBasemerger 	= IF(Corp2_Raw_MO._Flags.Base.merger, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.merger.qa, 	DATASET([], Corp2_Raw_MO.Layouts.mergerLayoutBase))
) := MODULE

	Corp2_Raw_MO.Layouts.mergerLayoutBase standardize_input(Corp2_Raw_MO.Layouts.mergerLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the  merger update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInmerger, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasemerger;
	combined_dist := DISTRIBUTE(combined, HASH(SurvivorCorpID,MergedCorpID));
	combined_sort := SORT(combined_dist, SurvivorCorpID,MergedCorpID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MO.Layouts.mergerLayoutBase rollupBase(Corp2_Raw_MO.Layouts.mergerLayoutBase L,
																									 Corp2_Raw_MO.Layouts.mergerLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_MO.Filenames(pversion).Base.merger.New, baseactions, Build_merger_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_merger_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MO.Build_Bases_merger attribute')
									 );

END;
