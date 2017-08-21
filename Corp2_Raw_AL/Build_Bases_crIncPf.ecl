IMPORT tools, corp2, Corp2_Raw_AL;

EXPORT Build_Bases_crIncPf(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                               pUseProd,
	DATASET(Corp2_Raw_AL.Layouts.IncorporatorLayoutIn)		pIncrIncPf   	= Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crIncPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.IncorporatorLayoutBase)	pBasecrIncPf 	= IF(Corp2_Raw_AL._Flags.Base.crIncPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crIncPf.qa, 	DATASET([], Corp2_Raw_AL.Layouts.IncorporatorLayoutBase))
) := MODULE

	Corp2_Raw_AL.Layouts.IncorporatorLayoutBase standardize_input(Corp2_Raw_AL.Layouts.IncorporatorLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the AL crIncPf update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrIncPf, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrIncPf;
	combined_dist := DISTRIBUTE(combined, HASH(account_number));
	combined_sort := SORT(combined_dist, account_number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AL.Layouts.IncorporatorLayoutBase rollupBase(	Corp2_Raw_AL.Layouts.IncorporatorLayoutBase L,
																											Corp2_Raw_AL.Layouts.IncorporatorLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basecrIncPf			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_AL.Filenames(pversion).Base.crIncPf.New, basecrIncPf, Build_crIncPf_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crIncPf_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AL.Build_Bases_crIncPf attribute')
									 );

END;
