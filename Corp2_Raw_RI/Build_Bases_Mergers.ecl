IMPORT tools, Corp2;

EXPORT Build_Bases_Mergers(
	STRING																			pfiledate,
	STRING																			pversion,
	BOOLEAN                                     pUseOtherEnvironment,
	DATASET(Corp2_Raw_RI.Layouts.MergersIn)			pInMergers   	= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Mergers.logical,
	DATASET(Corp2_Raw_RI.Layouts.MergersBase)		pBaseMergers 	= IF(Corp2_Raw_RI._Flags.Base.Mergers, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Mergers.qa, 	DATASET([], Corp2_Raw_RI.Layouts.MergersBase))
) := MODULE

	Corp2_Raw_RI.Layouts.MergersBase standardize_input(Corp2_Raw_RI.Layouts.MergersIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the  Mergers update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInMergers, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseMergers;
	combined_dist := DISTRIBUTE(combined, HASH(MergedEntity_ID,SurvivingEntity_ID));
	combined_sort := SORT(combined_dist, MergedEntity_ID,SurvivingEntity_ID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_RI.Layouts.MergersBase rollupBase(Corp2_Raw_RI.Layouts.MergersBase L  ,Corp2_Raw_RI.Layouts.MergersBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_RI.Filenames(pversion).Base.Mergers.New, baseactions, Build_Mergers_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Mergers_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_RI.Build_Bases_Mergers attribute')
									 );

END;
