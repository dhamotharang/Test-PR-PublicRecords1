IMPORT tools, Corp2;

EXPORT Build_Bases_BusEntity(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.BusEntityIn)							pInBusEntity   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusEntity.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusEntityLayoutBase)			pBaseBusEntity 	= IF(Corp2_Raw_MD._Flags.Base.BusEntity, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusEntity.qa, 	DATASET([], Corp2_Raw_MD.Layouts.BusEntityLayoutBase))
) := MODULE

	// Take the BusEntity update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	Corp2_Raw_MD.Layouts.BusEntityLayoutBase standardize_input(Corp2_Raw_MD.Layouts.BusEntityIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
	workingUpdate := PROJECT(pInBusEntity, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseBusEntity;
	combined_dist := DISTRIBUTE(combined, HASH(id_bus_prefix +  id_bus));
	combined_sort := SORT(combined_dist,RECORD,EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MD.Layouts.BusEntityLayoutBase rollupBase(Corp2_Raw_MD.Layouts.BusEntityLayoutBase L,
																											Corp2_Raw_MD.Layouts.BusEntityLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.BusEntity.New, baseactions, Build_BusEntity_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_BusEntity_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_BusEntity attribute')
									 );

END;
