IMPORT tools, Corp2;

EXPORT Build_Bases_CorpOfficers(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean 																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn)	pInCorpOfficers   	= Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment := FALSE).Input.CorpOfficers.Logical,
	DATASET(Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase)pBaseCorpOfficers 	= IF(Corp2_Raw_NE._Flags.Base.CorpOfficers, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.CorpOfficers.qa, 	DATASET([], Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase))
) := MODULE

	Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase standardize_input(Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:=  L;
		
	end;

	// Take the CorpOfficers update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorpOfficers, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseCorpOfficers;
	combined_dist := DISTRIBUTE(combined, HASH(AcctNumber));
	combined_sort := SORT(combined_dist, AcctNumber, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase rollupBase( Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase L,
																													Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															RollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_NE.Filenames(pversion).Base.CorpOfficers.New, baseactions, Build_CorpOfficers_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_CorpOfficers_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NE.Build_Bases_CorpOfficers attribute')
									 );

END;
