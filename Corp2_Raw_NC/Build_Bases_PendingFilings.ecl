IMPORT tools, corp2;

EXPORT Build_Bases_PendingFilings(
	STRING																											pfiledate,
	STRING																						  				pversion,
	Boolean 																										pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.PendingFilingsLayoutIn)				pInPendingFilings   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.PendingFilings.logical,
	DATASET(Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase)			pBasePendingFilings 	= IF(Corp2_Raw_NC._Flags.Base.PendingFilings, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.PendingFilings.qa,	DATASET([], Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase))
) := MODULE

	Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase standardize_input(Corp2_Raw_NC.Layouts.PendingFilingsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the PendingFilings update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInPendingFilings, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasePendingFilings;
	combined_dist := DISTRIBUTE(combined, HASH(Filings_PitemID));
	combined_sort := SORT(combined_dist, Filings_PitemID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase rollupBase(Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase L,
																													 Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NC.Filenames(pversion).Base.PendingFilings.New, baseactions, Build_PendingFilings_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_PendingFilings_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases_PendingFilings attribute')
									 );

END;
