IMPORT tools, corp2, Corp2_Raw_AZ;

EXPORT Build_Bases_FLMEXT(	
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod

	,DATASET(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn)		pInFLMEXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.FLMEXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase)	pBaseFLMEXTFile = IF(_Flags.Base.FLMEXT 
																																				 ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.FLMEXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase))
		   ) := MODULE

	Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase standardize_FLMEXTInput(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	FLMEXTWorkingUpdate := PROJECT(pInFLMEXTFile, standardize_FLMEXTInput(LEFT));
	FLMEXTCombined 			:= FLMEXTWorkingUpdate + pBaseFLMEXTFile;
	FLMEXTCombined_dist := DISTRIBUTE(FLMEXTCombined, HASH(FILE_NUMBER));
	FLMEXTCombined_sort := SORT(FLMEXTCombined_dist, FILE_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase rollupFLMEXTBase(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase L,
																												 Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseFLMEXT := ROLLUP(	FLMEXTCombined_sort, rollupFLMEXTBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_AZ.Filenames(pversion).Base.FLMEXT.New, baseFLMEXT, Build_FLMEXT_Base);
		

	// --------------------------------
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_FLMEXT_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AZ.Build_Bases_FLMEXT attribute')
									 );

END;
