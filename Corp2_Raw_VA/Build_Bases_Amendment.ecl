IMPORT corp2, tools;

EXPORT Build_Bases_Amendment(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_VA.Layouts.AmendmentLayoutIn)				pInAmendment   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.Amendment.Logical,
	DATASET(Corp2_Raw_VA.Layouts.AmendmentLayoutBase)			pBaseAmendment 	= IF(Corp2_Raw_VA._Flags.Base.Amendment, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Amendment.qa, 	DATASET([], Corp2_Raw_VA.Layouts.AmendmentLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.AmendmentLayoutBase standardize_input(Corp2_Raw_VA.Layouts.AmendmentLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA Amendment update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInAmendment, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseAmendment;
	combined_dist := DISTRIBUTE(combined, HASH(amend_entity_id));
	combined_sort := SORT(combined_dist, amend_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.AmendmentLayoutBase rollupBase(Corp2_Raw_VA.Layouts.AmendmentLayoutBase L,
																											Corp2_Raw_VA.Layouts.AmendmentLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseAmend			 := ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_first_received, dt_last_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.Amendment.New, baseAmend, Build_Amendment_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Amendment_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_Amendment attribute')
									 );

END;
