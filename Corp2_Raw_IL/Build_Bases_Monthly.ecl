IMPORT corp2, tools;

EXPORT Build_Bases_Monthly(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,	
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutIn)		pInMaster   			= Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Monthly.MasterString.Logical,
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutBase)	pBaseMaster 			= IF(Corp2_Raw_IL._Flags.Base.Monthly.Master, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Monthly.Master.qa, DATASET([], Corp2_Raw_IL.Layouts.StringLayoutBase)),
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutIn)		pInAssumedNames   = Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Monthly.AssumedNamesString.Logical,
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutBase)	pBaseAssumedNames = IF(Corp2_Raw_IL._Flags.Base.Monthly.AssumedNames, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Monthly.AssumedNames.qa, DATASET([], Corp2_Raw_IL.Layouts.StringLayoutBase)),
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutIn)		pInStock   				= Corp2_Raw_IL.Files(pfiledate,pUseProd).Input.Monthly.StockString.Logical,
	DATASET(Corp2_Raw_IL.Layouts.StringLayoutBase)	pBaseStock 			  = IF(Corp2_Raw_IL._Flags.Base.Monthly.Stock, Corp2_Raw_IL.Files(,pUseOtherEnvironment := FALSE).Base.Monthly.Stock.qa, DATASET([], Corp2_Raw_IL.Layouts.StringLayoutBase))
) := MODULE

  // -----------------------------
  // Build Master Base File
	// -----------------------------
	Corp2_Raw_IL.Layouts.StringLayoutBase standardize_MasterInput(Corp2_Raw_IL.Layouts.StringLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	MasterWorkingUpdate := PROJECT(pInMaster, standardize_MasterInput(LEFT));
	MasterCombined 			:= MasterWorkingUpdate + pBaseMaster;
	MasterCombined_dist := DISTRIBUTE(MasterCombined, HASH(payload));
	MasterCombined_sort := SORT(MasterCombined_dist, payload, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.StringLayoutBase rollupMasterBase(Corp2_Raw_IL.Layouts.StringLayoutBase L,
																												 Corp2_Raw_IL.Layouts.StringLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF                    := L;
	END;
	
	BaseMaster		 						:= ROLLUP(MasterCombined_sort,
																			rollupMasterBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
																			
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Monthly.Master.New, baseMaster, Build_Master_Base);

  // -----------------------------
  // Build AssumedNames Base File
	// -----------------------------		
	Corp2_Raw_IL.Layouts.StringLayoutBase standardize_AssumedNamesInput(Corp2_Raw_IL.Layouts.StringLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;		
	
	AssumedNamesWorkingUpdate := PROJECT(pInAssumedNames, standardize_AssumedNamesInput(LEFT));
	AssumedNamesCombined 			:= AssumedNamesWorkingUpdate + pBaseAssumedNames;
	AssumedNamesCombined_dist := DISTRIBUTE(AssumedNamesCombined, HASH(payload));
	AssumedNamesCombined_sort := SORT(AssumedNamesCombined_dist, payload, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.StringLayoutBase rollupAssumedNamesBase(Corp2_Raw_IL.Layouts.StringLayoutBase L,
																															 Corp2_Raw_IL.Layouts.StringLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF                    := L;
	END;
	
	baseAssumedNames		 			:= ROLLUP(AssumedNamesCombined_sort,
																			rollupAssumedNamesBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
																			
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Monthly.AssumedNames.New, baseAssumedNames, Build_AssumedNames_Base);

	// -----------------------------
  // Build Stock Base File
	// -----------------------------
	Corp2_Raw_IL.Layouts.StringLayoutBase standardize_StockInput(Corp2_Raw_IL.Layouts.StringLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	StockWorkingUpdate := PROJECT(pInStock, standardize_StockInput(LEFT));
	StockCombined 		 := StockWorkingUpdate + pBaseStock;
	StockCombined_dist := DISTRIBUTE(StockCombined, HASH(payload));
	StockCombined_sort := SORT(StockCombined_dist, payload, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_IL.Layouts.StringLayoutBase rollupStockBase(Corp2_Raw_IL.Layouts.StringLayoutBase L,
																												Corp2_Raw_IL.Layouts.StringLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF                    := L;
	END;
	
	baseStock						 			:= ROLLUP(StockCombined_sort,
																			rollupStockBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
																			
	tools.mac_WriteFile(Corp2_Raw_IL.Filenames(pversion).Base.Monthly.Stock.New, baseStock, Build_Stock_Base);

	// --------------------------------
	EXPORT full_build := SEQUENTIAL(	Build_Master_Base,
																		Build_AssumedNames_Base,
																		Build_Stock_Base,
																		Promote(pversion).Monthly.buildfiles.New2Built,
																		Promote().Monthly.BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IL.Build_Bases_Monthly attribute')
									);

END;