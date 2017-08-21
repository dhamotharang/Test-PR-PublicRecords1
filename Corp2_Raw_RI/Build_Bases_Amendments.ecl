IMPORT tools, Corp2;

EXPORT Build_Bases_Amendments(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN                                         pUseOtherEnvironment,
	DATASET(Corp2_Raw_RI.Layouts.AmendmentsIn)			pInAmendments   	= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Amendments.logical,
	DATASET(Corp2_Raw_RI.Layouts.AmendmentsBase)		pBaseAmendments 	= IF(Corp2_Raw_RI._Flags.Base.Amendments, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Amendments.qa, 	DATASET([], Corp2_Raw_RI.Layouts.AmendmentsBase))
) := MODULE

	Corp2_Raw_RI.Layouts.AmendmentsBase standardize_input(Corp2_Raw_RI.Layouts.AmendmentsIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Amendments update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInAmendments, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseAmendments;
	combined_dist := DISTRIBUTE(combined, HASH(Entity_id));
	combined_sort := SORT(combined_dist, Entity_id, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_RI.Layouts.AmendmentsBase rollupBase(Corp2_Raw_RI.Layouts.AmendmentsBase L  ,Corp2_Raw_RI.Layouts.AmendmentsBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_RI.Filenames(pversion).Base.Amendments.New, baseactions, Build_Amendments_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Amendments_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_RI.Build_Bases_Amendments attribute')
									 );

END;
