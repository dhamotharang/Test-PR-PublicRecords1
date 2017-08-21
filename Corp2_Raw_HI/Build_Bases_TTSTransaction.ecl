IMPORT corp2, tools;

EXPORT Build_Bases_TTSTransaction(
	STRING																									pfiledate,
	STRING																									pversion,
	BOOLEAN																									puseprod,
	DATASET(Corp2_Raw_HI.Layouts.TTSTransactionLayoutIn)		pInTTSTransaction   = Corp2_Raw_HI.Files(pfiledate,puseprod).Input.TTSTransaction.logical,
	DATASET(Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase)	pBaseTTSTransaction = IF(Corp2_Raw_HI._Flags.Base.TTSTransaction, Corp2_Raw_HI.Files(,pUseOtherEnvironment := FALSE).Base.TTSTransaction.qa, DATASET([], Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase))
) := MODULE

	Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase standardize_input(Corp2_Raw_HI.Layouts.TTSTransactionLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the current update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTTSTransaction, standardize_input(LEFT));

	// Combine update with previous base.
	combined 			:= workingUpdate + pBaseTTSTransaction;
	combined_dist := DISTRIBUTE(combined, HASH(filenumber, filesuffix));
	combined_sort := SORT(combined_dist, filenumber, filesuffix, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase rollupBase(Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase L,
																													 Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	baseTTSTransaction 				:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_HI.Filenames(pversion).Base.TTSTransaction.New, baseTTSTransaction, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_HI.Build_Bases_TTSTransaction attribute')
									 );

END;