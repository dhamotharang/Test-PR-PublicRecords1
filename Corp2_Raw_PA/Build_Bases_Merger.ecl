IMPORT tools, Corp2;

EXPORT Build_Bases_Merger(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_PA.Layouts.MergerLayoutIn)					pInMerger   	= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Merger.logical,
	DATASET(Corp2_Raw_PA.Layouts.MergerLayoutBase)				pBaseMerger 	= IF(Corp2_Raw_PA._Flags.Base.Merger, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa, 	DATASET([], Corp2_Raw_PA.Layouts.MergerLayoutBase))
) := MODULE

	Corp2_Raw_PA.Layouts.MergerLayoutBase standardize_input(Corp2_Raw_PA.Layouts.MergerLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the PA Merger update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInMerger, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseMerger;
	combined_dist := DISTRIBUTE(combined, HASH(survivorcorporationid));
	combined_sort := SORT(combined_dist, survivorcorporationid, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_PA.Layouts.MergerLayoutBase rollupBase(	Corp2_Raw_PA.Layouts.MergerLayoutBase L,
																										Corp2_Raw_PA.Layouts.MergerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseMerger			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_PA.Filenames(pversion).Base.Merger.New, baseMerger, Build_Merger_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Merger_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases_Merger attribute')
									 );

END;
