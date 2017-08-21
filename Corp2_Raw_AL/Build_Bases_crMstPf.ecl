IMPORT tools, corp2, Corp2_Raw_AL;

EXPORT Build_Bases_crMstPf(
	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN                                             pUseProd,
	DATASET(Corp2_Raw_AL.Layouts.CorpMasterLayoutIn)		pIncrMstPf   	= Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crMstPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.CorpMasterLayoutBase)	pBasecrMstPf 	= IF(Corp2_Raw_AL._Flags.Base.crMstPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crMstPf.qa, 	DATASET([], Corp2_Raw_AL.Layouts.CorpMasterLayoutBase))
) := MODULE

	Corp2_Raw_AL.Layouts.CorpMasterLayoutBase standardize_input(Corp2_Raw_AL.Layouts.CorpMasterLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the AL crMstPf update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrMstPf, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrMstPf;
	combined_dist := DISTRIBUTE(combined, HASH(account_number));
	combined_sort := SORT(combined_dist, account_number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AL.Layouts.CorpMasterLayoutBase rollupBase(	Corp2_Raw_AL.Layouts.CorpMasterLayoutBase L,
																											Corp2_Raw_AL.Layouts.CorpMasterLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basecrMstPf			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_AL.Filenames(pversion).Base.crMstPf.New, basecrMstPf, Build_crMstPf_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crMstPf_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AL.Build_Bases_crMstPf attribute')
									 );

END;
