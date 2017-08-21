IMPORT tools, corp2;

EXPORT Build_Bases_General(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_CT.Layouts.GeneralLayoutIn)		pInGeneral   	= Corp2_Raw_CT.Files(pfiledate,pUseProd).Input.fGeneral,
	DATASET(Corp2_Raw_CT.Layouts.GeneralLayoutBase)	pBaseGeneral 	= IF(Corp2_Raw_CT._Flags.Base.General, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.General.qa, 	DATASET([], Corp2_Raw_CT.Layouts.GeneralLayoutBase))
) := MODULE

	Corp2_Raw_CT.Layouts.GeneralLayoutBase standardize_input(Corp2_Raw_CT.Layouts.GeneralLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
	end;

	// Take the IA General update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInGeneral, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseGeneral;
	combined_dist := DISTRIBUTE(combined, HASH(idBus));
	combined_sort := SORT(combined_dist, idBus, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CT.Layouts.GeneralLayoutBase rollupBase(Corp2_Raw_CT.Layouts.GeneralLayoutBase L,
																										  Corp2_Raw_CT.Layouts.GeneralLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseGeneral			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CT.Filenames(pversion).Base.General.New, baseGeneral, Build_General_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_General_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases_General attribute')
									 );

END;
