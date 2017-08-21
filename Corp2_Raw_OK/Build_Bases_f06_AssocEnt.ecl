IMPORT tools, corp2;

EXPORT Build_Bases_f06_AssocEnt(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.AssocEnt_06_Layout)		  pInf06_AssocEnt   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f06_AssocEnt,
	DATASET(Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase)	pBasef06_AssocEnt 	= IF(Corp2_Raw_OK._Flags.Base.f06_AssocEnt, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f06_AssocEnt.qa, 	DATASET([], Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.AssocEnt_06_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f06_AssocEnt update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf06_AssocEnt, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef06_AssocEnt;
	combined_dist := DISTRIBUTE(combined, HASH(f06_Filing_Number));
	combined_sort := SORT(combined_dist, f06_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef06_AssocEnt			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f06_AssocEnt.New, basef06_AssocEnt, Build_f06_AssocEnt_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f06_AssocEnt_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f06_AssocEnt attribute')
									 );

END;
