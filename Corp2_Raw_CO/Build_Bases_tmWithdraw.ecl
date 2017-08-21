IMPORT corp2, tools;

EXPORT Build_Bases_TMWithdraw(
	STRING																						pfiledate,
	STRING																						ptmfiledate,	
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pInTMWithdraw   = Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.TMWithdraw.Logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBaseTMWithdraw = IF(Corp2_Raw_CO._Flags().Base.TMWithdraw, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.TMWithdraw.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase))
) := MODULE

	Corp2_Raw_CO.Layouts.TradeMarkLayoutBase standardize_input(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the CO Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTMWithdraw, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseTMWithdraw;
	combined_dist := DISTRIBUTE(combined, HASH(TradeMarkID));
	combined_sort := SORT(combined_dist, TradeMarkID, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_CO.Layouts.TradeMarkLayoutBase rollupBase(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase L,
																										  Corp2_Raw_CO.Layouts.TradeMarkLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	baseTMWithdraw := ROLLUP(	combined_sort,
													  rollupBase(LEFT, RIGHT),
													  RECORD,
													  EXCEPT dt_first_received, dt_last_received,
													  LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CO.Filenames(pversion).Base.TMWithdraw.New, baseTMWithdraw, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											IF(Corp2_Raw_CO._Flags(pfiledate,ptmfiledate,puseprod).Input.TMWithdraw, //if an input file exists, then build new base file
												 Build_Base,
												 OUTPUT('No "TMWithdraw" file exists, skipping Corp2_Raw_CO.Build_Bases_TMWithdraw attribute')
												),
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CO.Build_Bases_TMWithdraw attribute')
									 );

END;