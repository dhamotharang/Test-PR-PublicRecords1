IMPORT tools, corp2;

EXPORT Build_Bases_ForStat(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.ForStatLayoutIn)		pInForStat   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fForStat,
	DATASET(Corp2_Raw_CT.Layouts.ForStatLayoutBase)	pBaseForStat 	= IF(Corp2_Raw_CT._Flags.Base.ForStat, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.ForStat.qa, 	DATASET([], Corp2_Raw_CT.Layouts.ForStatLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.ForStatLayoutBase standardize_input(Corp2_Raw_CT.Layouts.ForStatLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA ForStat update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInForStat, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseForStat;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.ForStatLayoutBase rollupBase(Corp2_Raw_CT.Layouts.ForStatLayoutBase L,
																										  Corp2_Raw_CT.Layouts.ForStatLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseForStat			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.ForStat.New, baseForStat, Build_ForStat_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_ForStat_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_ForStat attribute')
									 );

END;
