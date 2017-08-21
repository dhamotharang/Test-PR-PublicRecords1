IMPORT tools, corp2;

EXPORT Build_Bases_Stock(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.StockLayout)		    pInStockFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.StockFile,
	DATASET(Corp2_Raw_NY.Layouts.StockLayoutBase)	  pBaseStockFile   = IF(Corp2_Raw_NY._Flags.Base.Stock, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, 	DATASET([], Corp2_Raw_NY.Layouts.StockLayoutBase))
) := MODULE

  // -----------------------------
  // Build Stock Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.StockLayoutBase standardize_StockInput(Corp2_Raw_NY.Layouts.StockLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	StockWorkingUpdate := PROJECT(pInStockFile, standardize_StockInput(LEFT));
	StockCombined 			:= StockWorkingUpdate + pBaseStockFile;
	StockCombined_dist := DISTRIBUTE(StockCombined, HASH(Stock_corpidno));
	StockCombined_sort := SORT(StockCombined_dist, Stock_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.StockLayoutBase rollupStockBase(Corp2_Raw_NY.Layouts.StockLayoutBase L,
																												     Corp2_Raw_NY.Layouts.StockLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseStock := ROLLUP(	StockCombined_sort, rollupStockBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.Stock.New, baseStock, Build_Stock_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Stock_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_Stock attribute')
									 );

END; 