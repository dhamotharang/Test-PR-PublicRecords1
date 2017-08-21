IMPORT tools, Corp2;

EXPORT Build_Bases_BusType(
	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN																	        		pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.BusTypeIn)							pInBusType   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusType.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusTypeLayoutBase)			pBaseBusType 	= IF(Corp2_Raw_MD._Flags.Base.BusType, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusType.qa, 	DATASET([], Corp2_Raw_MD.Layouts.BusTypeLayoutBase))
) := MODULE

	// Take BusType update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	Corp2_Raw_MD.Layouts.BusTypeLayoutBase standardize_input(Corp2_Raw_MD.Layouts.BusTypeIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
	workingUpdate := PROJECT(pInBusType, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseBusType;//Small look table type file , not adding distribute 
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received);
	
	Corp2_Raw_MD.Layouts.BusTypeLayoutBase rollupBase(Corp2_Raw_MD.Layouts.BusTypeLayoutBase L,
																										Corp2_Raw_MD.Layouts.BusTypeLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions	:= ROLLUP(combined_sort,
												rollupBase(LEFT, RIGHT),
												RECORD,
												EXCEPT action_flag, dt_first_received, dt_last_received
												);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.BusType.New, baseactions, Build_BusType_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_BusType_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_BusType attribute')
									 );

END;