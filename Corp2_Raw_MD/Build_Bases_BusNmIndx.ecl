IMPORT tools, Corp2;

EXPORT Build_Bases_BusNmIndx(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.BusNmIndxIn)							pInBusNmIndx   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusNmIndx.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase)			pBaseBusNmIndx 	= IF(Corp2_Raw_MD._Flags.Base.BusNmIndx, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusNmIndx.qa, 	DATASET([], Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase standardize_input(Corp2_Raw_MD.Layouts.BusNmIndxIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the BusNmIndx update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInBusNmIndx, standardize_input(LEFT));

	// Combine Update with Previous Base..
	combined 			:= workingUpdate + pBaseBusNmIndx;
	combined_dist := DISTRIBUTE(combined, HASH(id_bus_prefix +  id_bus));
	combined_sort := SORT(combined_dist, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase rollupBase(Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase L,
																											Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.BusNmIndx.New, baseactions, Build_BusNmIndx_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_BusNmIndx_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_BusNmIndx attribute')
									 );

END;