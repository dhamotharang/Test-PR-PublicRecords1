IMPORT tools, corp2, Corp2_Raw_AZ;

EXPORT Build_Bases_COREXT(	
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod

	,DATASET(Corp2_Raw_AZ.Layouts.COREXT_LayoutIn)		pInCOREXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.COREXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.COREXT_LayoutBase)	pBaseCOREXTFile = IF(_Flags.Base.COREXT 
																																				 ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.COREXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.COREXT_LayoutBase))
		   ) := MODULE

	Corp2_Raw_AZ.Layouts.COREXT_LayoutBase standardize_COREXTInput(Corp2_Raw_AZ.Layouts.COREXT_LayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	COREXTWorkingUpdate := PROJECT(pInCOREXTFile, standardize_COREXTInput(LEFT));
	COREXTCombined 			:= COREXTWorkingUpdate + pBaseCOREXTFile;
	COREXTCombined_dist := DISTRIBUTE(COREXTCombined, HASH(FILE_NUMBER));
	COREXTCombined_sort := SORT(COREXTCombined_dist, FILE_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AZ.Layouts.COREXT_LayoutBase rollupCOREXTBase(Corp2_Raw_AZ.Layouts.COREXT_LayoutBase L,
																												 Corp2_Raw_AZ.Layouts.COREXT_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseCOREXT := ROLLUP(	COREXTCombined_sort, rollupCOREXTBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_AZ.Filenames(pversion).Base.COREXT.New, baseCOREXT, Build_COREXT_Base);
		

	// --------------------------------
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_COREXT_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AZ.Build_Bases_COREXT attribute')
									 );

END;
