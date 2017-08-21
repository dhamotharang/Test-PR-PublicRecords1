IMPORT tools, corp2, Corp2_Raw_AL;

EXPORT Build_Bases_crBusPf(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                               pUseProd,
	DATASET(Corp2_Raw_AL.Layouts.BusinessNameLayoutIn)		pIncrBusPf   	= Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crBusPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.BusinessNameLayoutBase)	pBasecrBusPf 	= IF(Corp2_Raw_AL._Flags.Base.crBusPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crBusPf.qa, 	DATASET([], Corp2_Raw_AL.Layouts.BusinessNameLayoutBase))
) := MODULE

	Corp2_Raw_AL.Layouts.BusinessNameLayoutBase standardize_input(Corp2_Raw_AL.Layouts.BusinessNameLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the AL crBusPf update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrBusPf, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrBusPf;
	combined_dist := DISTRIBUTE(combined, HASH(account_number));
	combined_sort := SORT(combined_dist, account_number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AL.Layouts.BusinessNameLayoutBase rollupBase(	Corp2_Raw_AL.Layouts.BusinessNameLayoutBase L,
																											Corp2_Raw_AL.Layouts.BusinessNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basecrBusPf			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_AL.Filenames(pversion).Base.crBusPf.New, basecrBusPf, Build_crBusPf_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crBusPf_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AL.Build_Bases_crBusPf attribute')
									 );

END;
