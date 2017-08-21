IMPORT tools, Corp2;

EXPORT Build_Bases_amendments(
	STRING																								pfiledate,
	STRING																								pversion,	
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.amendmentsLayoutIn)			pInamendments   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment:= FALSE).Input.amendments.logical,
	DATASET(Corp2_Raw_WV.Layouts.amendmentsLayoutBase)		pBaseamendments 	= IF(Corp2_Raw_WV._Flags.Base.amendments, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.amendments.qa, 	DATASET([], Corp2_Raw_WV.Layouts.amendmentsLayoutBase))
) := MODULE

	Corp2_Raw_WV.Layouts.amendmentsLayoutBase standardize_input(Corp2_Raw_WV.Layouts.amendmentsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the amendments update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInamendments, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseamendments;
	combined_dist := DISTRIBUTE(combined, HASH(record_did1));
	combined_sort := SORT(combined_dist, record_did1, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WV.Layouts.amendmentsLayoutBase rollupBase(Corp2_Raw_WV.Layouts.amendmentsLayoutBase L,
																											 Corp2_Raw_WV.Layouts.amendmentsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_WV.Filenames(pversion).Base.amendments.New, baseactions, Build_amendments_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_amendments_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases_amendments attribute')
									 );

END;
