IMPORT tools, Corp2;

EXPORT Build_Bases(
  STRING																				  pfiledate,
	STRING																					pversion,
	Boolean 																				pUseOtherEnvironment,
	DATASET(Corp2_Raw_WI.Layouts.fullLine_Layout)		pIncomfichexsFile   = Corp2_Raw_WI.Files(pfiledate,pUseOtherEnvironment).input.ComfichexFixed,
	DATASET(Corp2_Raw_WI.Layouts.fullLine_Raw_Base)	pBasecomfichexsFile = IF(_Flags.Base.comfichex, Corp2_Raw_WI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.comfichex.qa, DATASET([], Corp2_Raw_WI.Layouts.fullLine_Raw_Base))) := MODULE
	
	Corp2_Raw_WI.Layouts.fullLine_Raw_Base standardize_input(Corp2_Raw_WI.Layouts.fullLine_Layout L) := TRANSFORM
		
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									  := L;
		
	end;
	
	// Take the update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pIncomfichexsFile, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasecomfichexsFile;	
	combined_dist := DISTRIBUTE(combined, hash(org_id));
	combined_sort := SORT(combined_dist, org_id, record, except dt_first_received, dt_last_received,action_flag, LOCAL);
	
	Corp2_Raw_WI.Layouts.fullLine_Raw_Base rollupBase(Corp2_Raw_WI.Layouts.fullLine_Raw_Base L,
																										Corp2_Raw_WI.Layouts.fullLine_Raw_Base R) := TRANSFORM
																												
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate  (L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	basecomfichexs := ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT action_flag, dt_first_received, dt_last_received,
														LOCAL
													);
													
	tools.mac_WriteFile(Corp2_Raw_WI.Filenames(pversion).Base.comfichex.New, basecomfichexs, Build_comfichex_Base);

	EXPORT full_build := sequential(	Build_comfichex_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																	);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WI.Build_Bases attribute')
									 );

END;