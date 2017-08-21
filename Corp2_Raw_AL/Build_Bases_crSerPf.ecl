IMPORT tools, corp2, Corp2_Raw_AL;

EXPORT Build_Bases_crSerPf(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN                                         pUseProd,
	DATASET(Corp2_Raw_AL.Layouts.ServiceLayoutIn)		pIncrSerPf   	= Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crSerPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.ServiceLayoutBase)	pBasecrSerPf 	= IF(Corp2_Raw_AL._Flags.Base.crSerPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crSerPf.qa, 	DATASET([], Corp2_Raw_AL.Layouts.ServiceLayoutBase))
) := MODULE

	Corp2_Raw_AL.Layouts.ServiceLayoutBase standardize_input(Corp2_Raw_AL.Layouts.ServiceLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the AL crSerPf update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrSerPf, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrSerPf;
	combined_dist := DISTRIBUTE(combined, HASH(account_number));
	combined_sort := SORT(combined_dist, account_number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AL.Layouts.ServiceLayoutBase rollupBase(	Corp2_Raw_AL.Layouts.ServiceLayoutBase L,
																											Corp2_Raw_AL.Layouts.ServiceLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basecrSerPf			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_AL.Filenames(pversion).Base.crSerPf.New, basecrSerPf, Build_crSerPf_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crSerPf_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AL.Build_Bases_crSerPf attribute')
									 );

END;
