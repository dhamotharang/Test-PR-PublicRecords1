IMPORT tools, Corp2;

EXPORT Build_Bases_ReserveName(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,
	DATASET(Corp2_Raw_MD.Layouts.ReserveNameIn)						pInReserveName   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ReserveName.logical,
	DATASET(Corp2_Raw_MD.Layouts.ReserveNameLayoutBase)		pBaseReserveName 	= IF(Corp2_Raw_MD._Flags.Base.ReserveName, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.ReserveName.qa, 	DATASET([], Corp2_Raw_MD.Layouts.ReserveNameLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.ReserveNameLayoutBase standardize_input(Corp2_Raw_MD.Layouts.ReserveNameIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take ReserveName update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInReserveName, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseReserveName;
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received);  //payload file , not adding distribute
	
	Corp2_Raw_MD.Layouts.ReserveNameLayoutBase rollupBase(Corp2_Raw_MD.Layouts.ReserveNameLayoutBase L,
																											  Corp2_Raw_MD.Layouts.ReserveNameLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received
													  );

	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.ReserveName.New, baseactions, Build_ReserveName_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_ReserveName_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_ReserveName attribute')
									 );

END;
