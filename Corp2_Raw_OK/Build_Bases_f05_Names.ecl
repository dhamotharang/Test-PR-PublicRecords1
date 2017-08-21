IMPORT tools, corp2;

EXPORT Build_Bases_f05_Names(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.Names_05_Layout)		  pInf05_Names   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f05_Names,
	DATASET(Corp2_Raw_OK.Layouts.Names_05_LayoutBase)	pBasef05_Names 	= IF(Corp2_Raw_OK._Flags.Base.f05_Names, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f05_Names.qa, 	DATASET([], Corp2_Raw_OK.Layouts.Names_05_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.Names_05_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.Names_05_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f05_Names update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf05_Names, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef05_Names;
	combined_dist := DISTRIBUTE(combined, HASH(f05_Filing_Number));
	combined_sort := SORT(combined_dist, f05_Filing_Number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.Names_05_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.Names_05_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.Names_05_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef05_Names			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f05_Names.New, basef05_Names, Build_f05_Names_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f05_Names_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f05_Names attribute')
									 );

END;
