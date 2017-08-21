IMPORT tools, corp2, Corp2_Raw_AZ;

EXPORT Build_Bases_CHGEXT(	
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod

	,DATASET(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn)		pInCHGEXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.CHGEXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase)	pBaseCHGEXTFile = IF(_Flags.Base.CHGEXT 
																																				 ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.CHGEXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase))
		   ) := MODULE

	Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase standardize_CHGEXTInput(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	CHGEXTWorkingUpdate := PROJECT(pInCHGEXTFile, standardize_CHGEXTInput(LEFT));
	CHGEXTCombined 			:= CHGEXTWorkingUpdate + pBaseCHGEXTFile;
	CHGEXTCombined_dist := DISTRIBUTE(CHGEXTCombined, HASH(FILE_NUMBER));
	CHGEXTCombined_sort := SORT(CHGEXTCombined_dist, FILE_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase rollupCHGEXTBase(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase L,
																												 Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseCHGEXT := ROLLUP(	CHGEXTCombined_sort, rollupCHGEXTBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_AZ.Filenames(pversion).Base.CHGEXT.New, baseCHGEXT, Build_CHGEXT_Base);
		

	// --------------------------------
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_CHGEXT_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AZ.Build_Bases_CHGEXT attribute')
									 );

END;
