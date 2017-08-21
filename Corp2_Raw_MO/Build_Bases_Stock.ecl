IMPORT tools, corp2;

EXPORT Build_Bases_Stock(
	STRING																				pfiledate,
	STRING																				pversion,
	Boolean 																			pUseOtherEnvironment,
	DATASET(Corp2_Raw_MO.Layouts.StockLayoutIn)		pInStock   	= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Stock.Logical,
	DATASET(Corp2_Raw_MO.Layouts.StockLayoutBase)	pBaseStock 	= IF(Corp2_Raw_MO._Flags.Base.Stock, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, 	DATASET([], Corp2_Raw_MO.Layouts.StockLayoutBase))
) := MODULE

	Corp2_Raw_MO.Layouts.StockLayoutBase standardize_input(Corp2_Raw_MO.Layouts.StockLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the  Stock update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInStock, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseStock;
	combined_dist := DISTRIBUTE(combined, HASH(CorpID));
	combined_sort := SORT(combined_dist, CorpID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MO.Layouts.StockLayoutBase rollupBase(Corp2_Raw_MO.Layouts.StockLayoutBase L,
																									Corp2_Raw_MO.Layouts.StockLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_MO.Filenames(pversion).Base.Stock.New, baseactions, Build_Stock_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Stock_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MO.Build_Bases_Stock attribute')
									 );

END;
