IMPORT tools, corp2;

EXPORT Build_Bases_crpDes(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_IA.Layouts.crpDesLayoutIn)					pIncrpDes   	= Corp2_Raw_IA.Files(pfiledate,pUseProd).Input.crpDes.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpDesLayoutBase)				pBasecrpDes 	= IF(Corp2_Raw_IA._Flags.Base.crpDes, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpDes.qa, 	DATASET([], Corp2_Raw_IA.Layouts.crpDesLayoutBase))
) := MODULE

	Corp2_Raw_IA.Layouts.crpDesLayoutBase standardize_input(Corp2_Raw_IA.Layouts.crpDesLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA crpDes update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrpDes, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrpDes;
	combined_dist := DISTRIBUTE(combined, HASH(corp_file_no));
	combined_sort := SORT(combined_dist, corp_file_no, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_IA.Layouts.crpDesLayoutBase rollupBase(	Corp2_Raw_IA.Layouts.crpDesLayoutBase L,
																											Corp2_Raw_IA.Layouts.crpDesLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basecrpDes			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_IA.Filenames(pversion).Base.crpDes.New, basecrpDes, Build_crpDes_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crpDes_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IA.Build_Bases_crpDes attribute')
									 );

END;
