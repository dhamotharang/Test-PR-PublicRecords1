IMPORT corp2, tools;

EXPORT Build_Bases_tmTransfer(
	STRING																						pfiledate,
	STRING																						ptmfiledate,	
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmTransfer   = Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmTransfer.Logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmTransfer = IF(Corp2_Raw_CO._Flags().Base.tmTransfer, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmTransfer.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase))
) := MODULE

	Corp2_Raw_CO.Layouts.TradeMarkLayoutBase standardize_input(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the CO Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIntmTransfer, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasetmTransfer;
	combined_dist := DISTRIBUTE(combined, HASH(TradeMarkID));
	combined_sort := SORT(combined_dist, TradeMarkID, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_CO.Layouts.TradeMarkLayoutBase rollupBase(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase L,
																										  Corp2_Raw_CO.Layouts.TradeMarkLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	basetmTransfer := ROLLUP(	combined_sort,
													  rollupBase(LEFT, RIGHT),
													  RECORD,
													  EXCEPT dt_first_received, dt_last_received,
													  LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CO.Filenames(pversion).Base.tmTransfer.New, basetmTransfer, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CO.Build_Bases_tmTransfer attribute')
									 );

END;