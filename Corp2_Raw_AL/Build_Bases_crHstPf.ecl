IMPORT tools, corp2, Corp2_Raw_AL;

EXPORT Build_Bases_crHstPf(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN                                         pUseProd,
	DATASET(Corp2_Raw_AL.Layouts.HistoryLayoutIn)		pIncrHstPf   	= Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crHstPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.HistoryLayoutBase)	pBasecrHstPf 	= IF(Corp2_Raw_AL._Flags.Base.crHstPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crHstPf.qa, 	DATASET([], Corp2_Raw_AL.Layouts.HistoryLayoutBase))
) := MODULE

	Corp2_Raw_AL.Layouts.HistoryLayoutBase standardize_input(Corp2_Raw_AL.Layouts.HistoryLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the AL crHstPf update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrHstPf, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrHstPf;
	combined_dist := DISTRIBUTE(combined, HASH(account_number));
	combined_sort := SORT(combined_dist, account_number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AL.Layouts.HistoryLayoutBase rollupBase(	Corp2_Raw_AL.Layouts.HistoryLayoutBase L,
																											Corp2_Raw_AL.Layouts.HistoryLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basecrHstPf			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_AL.Filenames(pversion).Base.crHstPf.New, basecrHstPf, Build_crHstPf_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crHstPf_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AL.Build_Bases_crHstPf attribute')
									 );

END;
