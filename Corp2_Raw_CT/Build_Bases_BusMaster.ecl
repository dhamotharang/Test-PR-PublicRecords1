IMPORT tools, corp2;

EXPORT Build_Bases_BusMaster(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.BusMasterLayoutIn)		pInBusMaster   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fBusMaster,
	DATASET(Corp2_Raw_CT.Layouts.BusMasterLayoutBase)	pBaseBusMaster 	= IF(Corp2_Raw_CT._Flags.Base.BusMaster, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusMaster.qa, 	DATASET([], Corp2_Raw_CT.Layouts.BusMasterLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.BusMasterLayoutBase standardize_input(Corp2_Raw_CT.Layouts.BusMasterLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA BusMaster update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInBusMaster, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseBusMaster;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.BusMasterLayoutBase rollupBase(Corp2_Raw_CT.Layouts.BusMasterLayoutBase L,
																										  Corp2_Raw_CT.Layouts.BusMasterLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseBusMaster			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.BusMaster.New, baseBusMaster, Build_BusMaster_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_BusMaster_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_BusMaster attribute')
									 );

END;
