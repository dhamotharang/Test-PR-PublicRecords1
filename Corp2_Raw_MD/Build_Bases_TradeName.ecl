IMPORT tools, Corp2;

EXPORT Build_Bases_TradeName(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,
	DATASET(Corp2_Raw_MD.Layouts.TradeNameIn)							pInTradeName   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.TradeName.logical,
	DATASET(Corp2_Raw_MD.Layouts.TradeNameLayoutBase)			pBaseTradeName 	= IF(Corp2_Raw_MD._Flags.Base.TradeName, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.TradeName.qa, 	DATASET([], Corp2_Raw_MD.Layouts.TradeNameLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.TradeNameLayoutBase standardize_input(Corp2_Raw_MD.Layouts.TradeNameIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
	// Take TradeName update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInTradeName, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseTradeName;
	combined_dist := DISTRIBUTE(combined, HASH(id_bus_prefix +  id_bus));
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MD.Layouts.TradeNameLayoutBase rollupBase(Corp2_Raw_MD.Layouts.TradeNameLayoutBase L,
																											Corp2_Raw_MD.Layouts.TradeNameLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.TradeName.New, baseactions, Build_TradeName_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_TradeName_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_TradeName attribute')
									 );

END;
