IMPORT tools, corp2;

EXPORT Build_Bases_crpAgt(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_IA.Layouts.crpAgtLayoutIn)					pIncrpAgt   	= Corp2_Raw_IA.Files(pfiledate,pUseProd).Input.crpAgt.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpAgtLayoutBase)				pBasecrpAgt 	= IF(Corp2_Raw_IA._Flags.Base.crpAgt, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpAgt.qa, 	DATASET([], Corp2_Raw_IA.Layouts.crpAgtLayoutBase))
) := MODULE

	Corp2_Raw_IA.Layouts.crpAgtLayoutBase standardize_input(Corp2_Raw_IA.Layouts.crpAgtLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA crpAgt update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIncrpAgt, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasecrpAgt;
	combined_dist := DISTRIBUTE(combined, HASH(corp_file_no));
	combined_sort := SORT(combined_dist, corp_file_no, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_IA.Layouts.crpAgtLayoutBase rollupBase(	Corp2_Raw_IA.Layouts.crpAgtLayoutBase L,
																											Corp2_Raw_IA.Layouts.crpAgtLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basecrpAgt			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_IA.Filenames(pversion).Base.crpAgt.New, basecrpAgt, Build_crpAgt_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_crpAgt_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IA.Build_Bases_crpAgt attribute')
									 );

END;
