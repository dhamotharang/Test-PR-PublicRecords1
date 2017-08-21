IMPORT tools, corp2;

EXPORT Build_Bases_Stock(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.StockLayoutIn)		pInStock   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fStock,
	DATASET(Corp2_Raw_CT.Layouts.StockLayoutBase)	pBaseStock 	= IF(Corp2_Raw_CT._Flags.Base.Stock, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, 	DATASET([], Corp2_Raw_CT.Layouts.StockLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.StockLayoutBase standardize_input(Corp2_Raw_CT.Layouts.StockLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA Stock update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInStock, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseStock;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.StockLayoutBase rollupBase(Corp2_Raw_CT.Layouts.StockLayoutBase L,
																										  Corp2_Raw_CT.Layouts.StockLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseStock			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.Stock.New, baseStock, Build_Stock_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Stock_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_Stock attribute')
									 );

END;
