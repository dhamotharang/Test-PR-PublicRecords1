IMPORT corp2, tools, ut;

EXPORT Build_Bases_Stock(
	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN                                             pUseProd,
	DATASET(Corp2_Raw_GA.Layouts.StockLayoutIn)					pInStock   	= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Stock.logical,
	DATASET(Corp2_Raw_GA.Layouts.StockLayoutBase)				pBaseStock 	= IF(Corp2_Raw_GA._Flags.Base.Stock, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, 	DATASET([], Corp2_Raw_GA.Layouts.StockLayoutBase))
) := MODULE

	Corp2_Raw_GA.Layouts.StockLayoutBase standardize_input(Corp2_Raw_GA.Layouts.StockLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 										:= L;
		SELF 										:= [];
		
	END;

	// Take the NV Stock update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInStock, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseStock;
	combined_dist := DISTRIBUTE(combined, HASH(BizEntityId));
	combined_sort := SORT(combined_dist, BizEntityId, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_GA.Layouts.StockLayoutBase rollupBase(Corp2_Raw_GA.Layouts.StockLayoutBase L,
																									Corp2_Raw_GA.Layouts.StockLayoutBase R) := TRANSFORM
																										
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_last_received, dt_first_received,
															LOCAL
														 );

	// Return
	tools.mac_WriteFile(Corp2_Raw_GA.Filenames(pversion).Base.Stock.New, baseactions, Build_Stock_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Stock_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_GA.Build_Bases_Stock attribute')
									 );

END;
