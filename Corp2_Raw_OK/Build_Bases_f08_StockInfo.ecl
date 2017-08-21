IMPORT tools, corp2;

EXPORT Build_Bases_f08_StockInfo(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.StockInfo_08_Layout)		  pInf08_StockInfo   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f08_StockInfo,
	DATASET(Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase)	pBasef08_StockInfo 	= IF(Corp2_Raw_OK._Flags.Base.f08_StockInfo, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f08_StockInfo.qa, 	DATASET([], Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.StockInfo_08_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f08_StockInfo update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf08_StockInfo, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef08_StockInfo;
	combined_dist := DISTRIBUTE(combined, HASH(f08_Filing_Number));
	combined_sort := SORT(combined_dist, f08_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef08_StockInfo			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f08_StockInfo.New, basef08_StockInfo, Build_f08_StockInfo_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f08_StockInfo_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f08_StockInfo attribute')
									 );

END;
