IMPORT tools, corp2;

EXPORT Build_Bases_Corps(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.CorpsLayoutIn)		pInCorps   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fCorps,
	DATASET(Corp2_Raw_CT.Layouts.CorpsLayoutBase)	pBaseCorps 	= IF(Corp2_Raw_CT._Flags.Base.Corps, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.Corps.qa, 	DATASET([], Corp2_Raw_CT.Layouts.CorpsLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.CorpsLayoutBase standardize_input(Corp2_Raw_CT.Layouts.CorpsLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA Corps update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorps, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorps;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.CorpsLayoutBase rollupBase(Corp2_Raw_CT.Layouts.CorpsLayoutBase L,
																										  Corp2_Raw_CT.Layouts.CorpsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseCorps			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.Corps.New, baseCorps, Build_Corps_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Corps_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_Corps attribute')
									 );

END;
