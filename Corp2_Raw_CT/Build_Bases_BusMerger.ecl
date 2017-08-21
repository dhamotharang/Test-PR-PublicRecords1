IMPORT tools, corp2;

EXPORT Build_Bases_BusMerger(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.BusMergerLayoutIn)		pInBusMerger   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fBusMerger,
	DATASET(Corp2_Raw_CT.Layouts.BusMergerLayoutBase)	pBaseBusMerger 	= IF(Corp2_Raw_CT._Flags.Base.BusMerger, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusMerger.qa, 	DATASET([], Corp2_Raw_CT.Layouts.BusMergerLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.BusMergerLayoutBase standardize_input(Corp2_Raw_CT.Layouts.BusMergerLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA BusMerger update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInBusMerger, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseBusMerger;
	combined_dist := DISTRIBUTE(combined, HASH(idSurvBus));
	combined_sort := SORT(combined_dist, idSurvBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.BusMergerLayoutBase rollupBase(Corp2_Raw_CT.Layouts.BusMergerLayoutBase L,
																										  Corp2_Raw_CT.Layouts.BusMergerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseBusMerger			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.BusMerger.New, baseBusMerger, Build_BusMerger_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_BusMerger_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_BusMerger attribute')
									 );

END;
