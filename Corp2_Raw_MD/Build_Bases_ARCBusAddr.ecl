IMPORT tools, Corp2;

EXPORT Build_Bases_ARCBusAddr(
	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN																	        		pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.BusAddrIn)							pInARCBusAddr   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ARCBusAddr.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusAddrLayoutBase)			pBaseARCBusAddr 	= IF(Corp2_Raw_MD._Flags.Base.ARCBusAddr, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.ARCBusAddr.qa, 	DATASET([], Corp2_Raw_MD.Layouts.BusAddrLayoutBase))
) := MODULE
  
	//BusAddr & ARCBusAddr both have same layout	
	Corp2_Raw_MD.Layouts.BusAddrLayoutBase standardize_input(Corp2_Raw_MD.Layouts.BusAddrIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
 // Take ARCBusAddr update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInARCBusAddr, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseARCBusAddr;
	combined_dist := DISTRIBUTE(combined, HASH(id_bus_prefix +  id_bus));
	combined_sort := SORT(combined_dist, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MD.Layouts.BusAddrLayoutBase rollupBase(Corp2_Raw_MD.Layouts.BusAddrLayoutBase L,
																										Corp2_Raw_MD.Layouts.BusAddrLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.ARCBusAddr.New, baseactions, Build_ARCBusAddr_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_ARCBusAddr_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_ARCBusAddr attribute')
									 );

END;
