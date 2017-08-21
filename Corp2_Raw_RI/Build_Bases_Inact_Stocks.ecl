IMPORT tools, Corp2;

EXPORT Build_Bases_Inact_Stocks(
	STRING																			pfiledate,
	STRING																			pversion,
	BOOLEAN                                     pUseOtherEnvironment,
	DATASET(Corp2_Raw_RI.Layouts.StocksIn)			pInStocks   	= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Stocks.logical,
	DATASET(Corp2_Raw_RI.Layouts.StocksBase)		pBaseStocks 	= IF(Corp2_Raw_RI._Flags.Base.Inactive_Stocks, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Stocks.qa, 	DATASET([], Corp2_Raw_RI.Layouts.StocksBase))
) := MODULE

	Corp2_Raw_RI.Layouts.StocksBase standardize_input(Corp2_Raw_RI.Layouts.StocksIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Stocks update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInStocks, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseStocks;
	combined_dist := DISTRIBUTE(combined, HASH(Entity_id));
	combined_sort := SORT(combined_dist, Entity_id, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_RI.Layouts.StocksBase rollupBase(Corp2_Raw_RI.Layouts.StocksBase L  ,Corp2_Raw_RI.Layouts.StocksBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_RI.Filenames(pversion).Base.Inactive_Stocks.New, baseactions, Build_Stocks_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Stocks_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_RI.Build_Bases_Inact_Stocks attribute')
									 );

END;
