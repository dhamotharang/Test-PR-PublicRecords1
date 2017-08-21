IMPORT tools, corp2, Corp2_Raw_AZ;

EXPORT Build_Bases_OFFEXT(	
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod

	,DATASET(Corp2_Raw_AZ.Layouts.OFFEXT_LayoutIn)		pInOFFEXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.OFFEXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase)	pBaseOFFEXTFile = IF(_Flags.Base.OFFEXT 
																																				 ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.OFFEXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase))
		   ) := MODULE

	Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase standardize_OFFEXTInput(Corp2_Raw_AZ.Layouts.OFFEXT_LayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	OFFEXTWorkingUpdate := PROJECT(pInOFFEXTFile, standardize_OFFEXTInput(LEFT));
	OFFEXTCombined 			:= OFFEXTWorkingUpdate + pBaseOFFEXTFile;
	OFFEXTCombined_dist := DISTRIBUTE(OFFEXTCombined, HASH(OFFICER_FILE_NUMBER));
	OFFEXTCombined_sort := SORT(OFFEXTCombined_dist, OFFICER_FILE_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase rollupOFFEXTBase(Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase L,
																												 Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseOFFEXT := ROLLUP(	OFFEXTCombined_sort, rollupOFFEXTBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_AZ.Filenames(pversion).Base.OFFEXT.New, baseOFFEXT, Build_OFFEXT_Base);
		

	// --------------------------------
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_OFFEXT_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AZ.Build_Bases_OFFEXT attribute')
									 );

END;
