IMPORT tools, corp2;

EXPORT Build_Bases_f12_CorpType(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.CorpType_12_Layout)		  pInf12_CorpType   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f12_CorpType,
	DATASET(Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase)	pBasef12_CorpType 	= IF(Corp2_Raw_OK._Flags.Base.f12_CorpType, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f12_CorpType.qa, 	DATASET([], Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.CorpType_12_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f12_CorpType update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf12_CorpType, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef12_CorpType;
	combined_dist := DISTRIBUTE(combined, HASH(f12_Corp_Type_ID));
	combined_sort := SORT(combined_dist, f12_Corp_Type_ID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef12_CorpType			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f12_CorpType.New, basef12_CorpType, Build_f12_CorpType_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f12_CorpType_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f12_CorpType attribute')
									 );

END;
