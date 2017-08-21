IMPORT tools, ut;

EXPORT Build_Bases_Stock(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NV.Layouts.StockLayoutIn)						pInStock   	= Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Stock.Logical,
	DATASET(Corp2_Raw_NV.Layouts.StockLayoutBase)					pBaseStock	= IF(Corp2_Raw_NV._Flags.Base.Stock, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_NV.Layouts.StockLayoutBase))	
) := MODULE

	Corp2_Raw_NV.Layouts.StockLayoutBase standardize_input(Corp2_Raw_NV.Layouts.StockLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the NV Stock update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInStock, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseStock;
	combined_dist := DISTRIBUTE(combined, HASH(corp_id));
	combined_sort := SORT(combined_dist, corp_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_NV.Layouts.StockLayoutBase rollupBase(	Corp2_Raw_NV.Layouts.StockLayoutBase L,
																													Corp2_Raw_NV.Layouts.StockLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= ut.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Max	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basestock 			:= ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NV.Filenames(pversion).Base.Stock.New, basestock, Build_Stock_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Stock_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NV.Build_Bases_Stock attribute')
									 );

END;
