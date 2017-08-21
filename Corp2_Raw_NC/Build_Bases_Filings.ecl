IMPORT tools, corp2;

EXPORT Build_Bases_Filings(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean 																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.FilingsLayoutIn)				pInFilings   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Filings.logical,
	DATASET(Corp2_Raw_NC.Layouts.FilingsLayoutBase)			pBaseFilings 	= IF(Corp2_Raw_NC._Flags.Base.Filings, Corp2_Raw_NC.Files(,pUseOtherEnvironment:= FALSE).Base.Filings.qa, 	DATASET([], Corp2_Raw_NC.Layouts.FilingsLayoutBase))
) := MODULE

	Corp2_Raw_NC.Layouts.FilingsLayoutBase standardize_input(Corp2_Raw_NC.Layouts.FilingsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the Filings update file,stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInFilings, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseFilings;
	combined_dist := DISTRIBUTE(combined, HASH(Filings_PitemID));
	combined_sort := SORT(combined_dist, Filings_PitemID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NC.Layouts.FilingsLayoutBase rollupBase(Corp2_Raw_NC.Layouts.FilingsLayoutBase L,
																										Corp2_Raw_NC.Layouts.FilingsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NC.Filenames(pversion).Base.Filings.New, baseactions, Build_Filings_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Filings_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases_Filings attribute')
									 );

END;
