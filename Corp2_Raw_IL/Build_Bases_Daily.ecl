IMPORT corp2, tools;

EXPORT Build_Bases_Daily(
	STRING																									pfiledate,
	STRING																									pversion,
	BOOLEAN																									puseprod,	
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutIn)						pInMasterRaw   				= Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Daily.MasterString.Logical,
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutBase)					pBaseMasterRaw				= IF(Corp2_Raw_IL._Flags.Base.Daily.MasterRaw, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Daily.MasterRaw.qa, DATASET([], Corp2_Raw_IL.Layouts.StringLayoutBase)),
	DATASET(Corp2_Raw_IL.Layouts.MasterLayoutIn)						pInMasterFlat   			= Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Daily.Master,
	DATASET(Corp2_Raw_IL.Layouts.MasterLayoutBase)					pBaseFlatMaster 			= IF(Corp2_Raw_IL._Flags.Base.Daily.Master, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Daily.Master.qa, DATASET([], Corp2_Raw_IL.Layouts.MasterLayoutBase)),
	DATASET(Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutIn)		pInAssumedNamesFlat   = Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Daily.AssumedNames,
	DATASET(Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase)	pBaseAssumedNamesFlat = IF(Corp2_Raw_IL._Flags.Base.Daily.Master, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Daily.AssumedNames.qa, DATASET([], Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase)),
	DATASET(Corp2_Raw_IL.Layouts.StockLayoutIn)							pInStockFlat   				= Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Daily.Stock,
	DATASET(Corp2_Raw_IL.Layouts.StockLayoutBase)						pBaseStockFlat 			  = IF(Corp2_Raw_IL._Flags.Base.Daily.Master, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Daily.Stock.qa, DATASET([], Corp2_Raw_IL.Layouts.StockLayoutBase))
	
) := MODULE
  // -----------------------------
  // Build Master Base File (RAW)
	// -----------------------------
	Corp2_Raw_IL.Layouts.StringLayoutBase Standardize_MasterRawInput(Corp2_Raw_IL.Layouts.StringLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF 										:=   L;
	END;

	MasterRawWorkingUpdate 		:= PROJECT(pInMasterRaw, Standardize_MasterRawInput(LEFT));

	MasterRawCombined 				:= MasterRawWorkingUpdate + pBaseMasterRaw;
  //Cannot distribute or sort on MasterRaw file because multiple
	//records create a logical record and no field within the data
	//indicates the grouping of records.  A logical group is identified
	//by a record of '$'.

	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Daily.MasterRaw.New, MasterRawCombined, Build_MasterRaw_Base);

  // -----------------------------
  // Build Master Base File (FLAT)
	// -----------------------------
	Corp2_Raw_IL.Layouts.MasterLayoutBase Standardize_MasterFlatInput(Corp2_Raw_IL.Layouts.MasterLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	MasterFlatWorkingUpdate 	:= PROJECT(pInMasterFlat, Standardize_MasterFlatInput(LEFT));
	MasterFlatCombined 				:= MasterFlatWorkingUpdate + pBaseFlatMaster;
	MasterFlatCombined_dist 	:= DISTRIBUTE(MasterFlatCombined, HASH(cd41100_file_number));
	MasterFlatCombined_sort 	:= SORT(MasterFlatCombined_dist, cd41100_file_number, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.MasterLayoutBase rollupMasterBase(Corp2_Raw_IL.Layouts.MasterLayoutBase L,
																												 Corp2_Raw_IL.Layouts.MasterLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF                    := L;
	END;
	
	BaseMasterFlat 						:= ROLLUP(MasterFlatCombined_sort,
																			rollupMasterBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
																			
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Daily.Master.New, BaseMasterFlat, Build_MasterFlat_Base);
		
  // -----------------------------
  // Build AssumedNames Base File
	// -----------------------------		
	Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase Standardize_AssumedNamesFlatInput (Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;		
	
	AssumedNamesFlatWorkingUpdate := PROJECT(pInAssumedNamesFlat, Standardize_AssumedNamesFlatInput(LEFT));
	AssumedNamesFlatCombined 			:= AssumedNamesFlatWorkingUpdate + pBaseAssumedNamesFlat;
	AssumedNamesFlatCombined_dist := DISTRIBUTE(AssumedNamesFlatCombined, HASH(cd40008_file_number));
	AssumedNamesFlatCombined_sort := SORT(AssumedNamesFlatCombined_dist, cd40008_file_number, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase rollupAssumedNamesBase(Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase L,
																															 Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutBase R) := TRANSFORM
    SELF.dt_first_received			:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 			:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF                        := L;
	END;
	
	BaseAssumedNamesFlat 					:= ROLLUP(AssumedNamesFlatCombined_sort,
																					rollupAssumedNamesBase(LEFT, RIGHT),
																					RECORD,
																					EXCEPT dt_first_received, dt_last_received,
																					LOCAL);
																					
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Daily.AssumedNames.New, BaseAssumedNamesFlat, Build_AssumedNamesFlat_Base);

	// -----------------------------
  // Build Stock Base File
	// -----------------------------
	Corp2_Raw_IL.Layouts.StockLayoutBase Standardize_StockFlatInput(Corp2_Raw_IL.Layouts.StockLayoutIn L) := TRANSFORM
		SELF.action_flag						:=	'U';
		SELF.dt_first_received			:=	(INTEGER)pversion;
		SELF.dt_last_received				:=	(INTEGER)pversion;
		SELF                        :=  L;
		SELF                        :=  [];
	END;

	StockFlatWorkingUpdate 				:= PROJECT(pInStockFlat, Standardize_StockFlatInput(LEFT));
	StockFlatCombined 		 				:= StockFlatWorkingUpdate + pBaseStockFlat;
	StockFlatCombined_dist 				:= DISTRIBUTE(StockFlatCombined, HASH(cd40019_file_number));
	StockFlatCombined_sort 				:= SORT(StockFlatCombined_dist, cd40019_file_number, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.StockLayoutBase rollupStockBase(Corp2_Raw_IL.Layouts.StockLayoutBase L,
																											 Corp2_Raw_IL.Layouts.StockLayoutBase R) := TRANSFORM
    SELF.dt_first_received			:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 			:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF                        := L;
	END;
	
	BaseStockFlat 								:= ROLLUP(StockFlatCombined_sort,
																					rollupStockBase(LEFT, RIGHT),
																					RECORD,
																					EXCEPT dt_first_received, dt_last_received,
																					LOCAL);
																					
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Daily.Stock.New, BaseStockFlat, Build_StockFlat_Base);

	// --------------------------------
	EXPORT full_build := SEQUENTIAL(	Build_MasterRaw_Base,
																		Build_MasterFlat_Base,
																		Build_AssumedNamesFlat_Base,
																		Build_StockFlat_Base,
																		Promote(pversion).Daily.buildfiles.New2Built,
																		Promote().Daily.BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IL.Build_Bases_Daily attribute')
									);

END;