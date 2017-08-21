IMPORT tools, corp2;

EXPORT Build_Bases_TradeMark(
	STRING																					  pfiledate,
	STRING																					  pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn)		pInTradeMark1  = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeMark1.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn)	  pInTradeMark2  = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeMark2.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeMarkLayoutBase)	pBaseTradeMark = IF(Corp2_Raw_ND._Flags.Base.TradeMark, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.TradeMark.qa, 	DATASET([], Corp2_Raw_ND.Layouts.TradeMarkLayoutBase))
) := MODULE

	Corp2_Raw_ND.Layouts.TradeMarkLayoutBase standardize_input(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the TradeMark1 & TradeMark2 update files, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTradeMark1 + pInTradeMark2, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseTradeMark;
	combined_dist := DISTRIBUTE(combined, HASH(RSID));
	combined_sort := SORT(combined_dist, RSID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_ND.Layouts.TradeMarkLayoutBase rollupBase(Corp2_Raw_ND.Layouts.TradeMarkLayoutBase L,
																									    Corp2_Raw_ND.Layouts.TradeMarkLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseTradeMark	:= ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_last_received, dt_first_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_ND.Filenames(pversion).Base.TradeMark.New, baseTradeMark, Build_TradeMark_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
							     Build_TradeMark_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ND.Build_Bases_TradeMark attribute')
									 );

END;
