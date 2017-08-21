IMPORT corp2, tools;

EXPORT Build_Bases_NamesHist(
	STRING																					   pfiledate,
	STRING																					   pversion,
	BOOLEAN																					   puseprod,
	DATASET(Corp2_Raw_VA.Layouts.NamesHistLayoutIn)		 pInNamesHist   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.NamesHist.Logical,
	DATASET(Corp2_Raw_VA.Layouts.NamesHistLayoutBase)	 pBaseNamesHist 	= IF(Corp2_Raw_VA._Flags.Base.NamesHist, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.NamesHist.qa, 	DATASET([], Corp2_Raw_VA.Layouts.NamesHistLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.NamesHistLayoutBase standardize_input(Corp2_Raw_VA.Layouts.NamesHistLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA NamesHist update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInNamesHist, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseNamesHist;
	combined_dist := DISTRIBUTE(combined, HASH(nmhist_entity_id));
	combined_sort := SORT(combined_dist, nmhist_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.NamesHistLayoutBase rollupBase(Corp2_Raw_VA.Layouts.NamesHistLayoutBase L,
																							        Corp2_Raw_VA.Layouts.NamesHistLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseNamesHist			 := ROLLUP(	combined_sort,
												      	rollupBase(LEFT, RIGHT),
												      	RECORD,
													      EXCEPT dt_first_received, dt_last_received,
												       	LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.NamesHist.New, baseNamesHist, Build_NamesHist_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_NamesHist_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_NamesHist attribute')
									 );

END;
