IMPORT tools, Corp2;

EXPORT Build_Bases_Document_Transaction(
	STRING																											pfiledate,
	STRING																											pversion,
	BOOLEAN																					            pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Document_TransactionLayoutIn)	pInDocument_Transaction   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Document_Transaction.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase)pBaseDocument_Transaction 	= IF(Corp2_Raw_OH._Flags.Base.Document_Transaction, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Document_Transaction.qa, 	DATASET([], Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase standardize_input(Corp2_Raw_OH.Layouts.Document_TransactionLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Document_Transaction update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInDocument_Transaction, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseDocument_Transaction;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase rollupBase(Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase L,
																																 Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Document_Transaction.New, baseactions, Build_Document_Transaction_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Document_Transaction_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Document_Transaction attribute')
									 );

END;
