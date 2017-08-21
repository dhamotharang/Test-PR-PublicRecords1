IMPORT tools, corp2;

EXPORT Build_Bases_f07_StockData(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.StockData_07_Layout)		  pInf07_StockData   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f07_StockData,
	DATASET(Corp2_Raw_OK.Layouts.StockData_07_LayoutBase)	pBasef07_StockData 	= IF(Corp2_Raw_OK._Flags.Base.f07_StockData, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f07_StockData.qa, 	DATASET([], Corp2_Raw_OK.Layouts.StockData_07_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.StockData_07_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.StockData_07_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f07_StockData update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf07_StockData, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef07_StockData;
	combined_dist := DISTRIBUTE(combined, HASH(f07_Filing_Number));
	combined_sort := SORT(combined_dist, f07_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.StockData_07_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.StockData_07_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.StockData_07_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef07_StockData			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f07_StockData.New, basef07_StockData, Build_f07_StockData_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f07_StockData_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f07_StockData attribute')
									 );

END;
