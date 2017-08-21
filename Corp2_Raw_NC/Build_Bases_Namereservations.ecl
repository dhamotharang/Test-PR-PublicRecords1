IMPORT tools, corp2;

EXPORT Build_Bases_NameReservations(
	STRING																									 pfiledate,
	STRING																									 pversion,
	Boolean 																								 pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.NameReservationsLayoutIn)	 pInNameReservations   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.NameReservations.logical,
	DATASET(Corp2_Raw_NC.Layouts.NameReservationsLayoutBase) pBaseNameReservations 	= IF(Corp2_Raw_NC._Flags.Base.NameReservations, Corp2_Raw_NC.Files(pUseOtherEnvironment := FALSE).Base.NameReservations.qa, 	DATASET([], Corp2_Raw_NC.Layouts.NameReservationsLayoutBase))
) := MODULE

	Corp2_Raw_NC.Layouts.NameReservationsLayoutBase standardize_input(Corp2_Raw_NC.Layouts.NameReservationsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the NameReservations update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInNameReservations, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseNameReservations;
	combined_dist := DISTRIBUTE(combined, HASH(EntityID));
	combined_sort := SORT(combined_dist, EntityID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NC.Layouts.NameReservationsLayoutBase rollupBase(Corp2_Raw_NC.Layouts.NameReservationsLayoutBase L,
																														 Corp2_Raw_NC.Layouts.NameReservationsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NC.Filenames(pversion).Base.NameReservations.New, baseactions, Build_NameReservations_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_NameReservations_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases_NameReservations attribute')
									 );

END;
