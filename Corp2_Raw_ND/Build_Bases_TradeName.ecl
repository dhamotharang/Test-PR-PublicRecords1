IMPORT tools, corp2;

EXPORT Build_Bases_TradeName(
	STRING																					  pfiledate,
	STRING																					  pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_ND.Layouts.TradeNameLayoutIn)		pInTradeName1  = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeName1.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeNameLayoutIn)	  pInTradeName2  = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeName2.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeNameLayoutBase)	pBaseTradeName = IF(Corp2_Raw_ND._Flags.Base.TradeName, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.TradeName.qa, 	DATASET([], Corp2_Raw_ND.Layouts.TradeNameLayoutBase))
) := MODULE

	Corp2_Raw_ND.Layouts.TradeNameLayoutBase standardize_input(Corp2_Raw_ND.Layouts.TradeNameLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the TradeName1 & TradeName2 update files, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTradeName1 + pInTradeName2, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseTradeName;
	combined_dist := DISTRIBUTE(combined, HASH(PSID));
	combined_sort := SORT(combined_dist, PSID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_ND.Layouts.TradeNameLayoutBase rollupBase(Corp2_Raw_ND.Layouts.TradeNameLayoutBase L,
																									    Corp2_Raw_ND.Layouts.TradeNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
    SELF                    := L;
	END;
	
	baseTradeName	:= ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_last_received, dt_first_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_ND.Filenames(pversion).Base.TradeName.New, baseTradeName, Build_TradeName_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
							     Build_TradeName_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ND.Build_Bases_TradeName attribute')
									 );

END;
