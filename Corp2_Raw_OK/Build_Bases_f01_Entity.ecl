IMPORT tools, corp2;

EXPORT Build_Bases_f01_Entity(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.Entity_01_Layout)		  pInf01_Entity   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f01_Entity,
	DATASET(Corp2_Raw_OK.Layouts.Entity_01_LayoutBase)	pBasef01_Entity 	= IF(Corp2_Raw_OK._Flags.Base.f01_Entity, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f01_Entity.qa, 	DATASET([], Corp2_Raw_OK.Layouts.Entity_01_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.Entity_01_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.Entity_01_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f01_Entity update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf01_Entity, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef01_Entity;
	combined_dist := DISTRIBUTE(combined, HASH(f01_Filing_Number));
	combined_sort := SORT(combined_dist, f01_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.Entity_01_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.Entity_01_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.Entity_01_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef01_Entity			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f01_Entity.New, basef01_Entity, Build_f01_Entity_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f01_Entity_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f01_Entity attribute')
									 );

END;
