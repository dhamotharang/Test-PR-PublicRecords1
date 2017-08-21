IMPORT corp2, tools;

EXPORT Build_Bases_Merger(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,
	DATASET(Corp2_Raw_VA.Layouts.MergersLayoutIn)		pInMerger   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.Merger.Logical,
	DATASET(Corp2_Raw_VA.Layouts.MergersLayoutBase)	pBaseMerger 	= IF(Corp2_Raw_VA._Flags.Base.Merger, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa, 	DATASET([], Corp2_Raw_VA.Layouts.MergersLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.MergersLayoutBase standardize_input(Corp2_Raw_VA.Layouts.MergersLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA Merger update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInMerger, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseMerger;
	combined_dist := DISTRIBUTE(combined, HASH(merg_entity_id));
	combined_sort := SORT(combined_dist, merg_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.MergersLayoutBase rollupBase(Corp2_Raw_VA.Layouts.MergersLayoutBase L,
																							      Corp2_Raw_VA.Layouts.MergersLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseMerger			 := ROLLUP(	combined_sort,
													    rollupBase(LEFT, RIGHT),
												    	RECORD,
												    	EXCEPT dt_first_received, dt_last_received,
												    	LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.Merger.New, baseMerger, Build_Merger_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Merger_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_Merger attribute')
									 );

END;
