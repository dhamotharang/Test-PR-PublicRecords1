IMPORT tools, corp2;

EXPORT Build_Bases_Forms(
	STRING																				pfiledate,
	STRING																				pversion,
	BOOLEAN                                       puseprod,
	DATASET(Corp2_Raw_MS.Layouts.FormsLayoutIn)		pInForms   = Corp2_Raw_MS.Files(pfiledate,pUseOtherEnvironment := FALSE).Input.Forms.logical,
	DATASET(Corp2_Raw_MS.Layouts.FormsLayoutBase)	pBaseForms = IF(Corp2_Raw_MS._Flags.Base.Forms, Corp2_Raw_MS.Files(,pUseOtherEnvironment := FALSE).Base.Forms.qa, 	DATASET([], Corp2_Raw_MS.Layouts.FormsLayoutBase))
) := MODULE

	Corp2_Raw_MS.Layouts.FormsLayoutBase standardize_input(Corp2_Raw_MS.Layouts.FormsLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the Forms update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInForms, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseForms;
	combined_dist := DISTRIBUTE(combined, HASH(EntityId));
	combined_sort := SORT(combined_dist, EntityId, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_MS.Layouts.FormsLayoutBase rollupBase(	Corp2_Raw_MS.Layouts.FormsLayoutBase L,
																											Corp2_Raw_MS.Layouts.FormsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseForms			 := ROLLUP(combined_sort,
													 rollupBase(LEFT, RIGHT),
													 RECORD,
													 EXCEPT dt_last_received, dt_first_received,
													 LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MS.Filenames(pversion).Base.Forms.New, baseForms, Build_Forms_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Forms_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MS.Build_Bases_Forms attribute')
									 );

END;
