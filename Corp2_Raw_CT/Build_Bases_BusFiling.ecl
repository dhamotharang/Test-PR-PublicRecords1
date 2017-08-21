IMPORT tools, corp2;

EXPORT Build_Bases_BusFiling(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.BusFilingLayoutIn)		pInBusFiling   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fBusFiling,
	DATASET(Corp2_Raw_CT.Layouts.BusFilingLayoutBase)	pBaseBusFiling 	= IF(Corp2_Raw_CT._Flags.Base.BusFiling, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusFiling.qa, 	DATASET([], Corp2_Raw_CT.Layouts.BusFilingLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.BusFilingLayoutBase standardize_input(Corp2_Raw_CT.Layouts.BusFilingLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA BusFiling update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInBusFiling, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseBusFiling;
	combined_dist := DISTRIBUTE(combined, HASH(idBusFlng));
	combined_sort := SORT(combined_dist, idBusFlng, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.BusFilingLayoutBase rollupBase(Corp2_Raw_CT.Layouts.BusFilingLayoutBase L,
																										  Corp2_Raw_CT.Layouts.BusFilingLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseBusFiling			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.BusFiling.New, baseBusFiling, Build_BusFiling_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_BusFiling_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_BusFiling attribute')
									 );

END;
