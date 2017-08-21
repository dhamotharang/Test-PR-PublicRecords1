IMPORT tools, Corp2, Corp2_Raw_AK;

EXPORT Build_Bases(	
	 STRING																								pfiledate
	,STRING																								pversion
	,BOOLEAN																							puseprod
	,DATASET(Corp2_Raw_AK.Layouts.CorporationsLayoutIn)		pInCorporationsFile   = Corp2_Raw_AK.Files(pfiledate,puseprod).Input.Corporations.logical
	,DATASET(Corp2_Raw_AK.Layouts.CorporationsLayoutBase)	pBaseCorporationsFile = IF(_Flags.Base.Corporations 
																																						    ,Corp2_Raw_AK.Files(,pUseOtherEnvironment := FALSE).Base.Corporations.qa
																																						    ,DATASET([],Corp2_Raw_AK.Layouts.CorporationsLayoutBase))
	,DATASET(Corp2_Raw_AK.Layouts.OfficialsLayoutIn)		  pInOfficialsFile      = Corp2_Raw_AK.Files(pfiledate,puseprod).Input.Officials.logical
	,DATASET(Corp2_Raw_AK.Layouts.OfficialsLayoutBase)	  pBaseOfficialsFile    = IF(_Flags.Base.Officials 
																																						    ,Corp2_Raw_AK.Files(,pUseOtherEnvironment := FALSE).Base.Officials.qa
																																						    ,DATASET([],Corp2_Raw_AK.Layouts.OfficialsLayoutBase))																																					
	   ) := MODULE

  // -----------------------------
  // Build Corporations Base File
	// -----------------------------
	Corp2_Raw_AK.Layouts.CorporationsLayoutBase standardize_CorporationsInput(Corp2_Raw_AK.Layouts.CorporationsLayoutIn L) := TRANSFORM
		self.action_type				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	CWorkingUpdate := PROJECT(pInCorporationsFile, standardize_CorporationsInput(LEFT));
	Ccombined 			:= CworkingUpdate + pBaseCorporationsFile;
	Ccombined_dist := DISTRIBUTE(Ccombined, HASH(EntityNumber));
	Ccombined_sort := SORT(Ccombined_dist, EntityNumber, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AK.Layouts.CorporationsLayoutBase rollupCBase(Corp2_Raw_AK.Layouts.CorporationsLayoutBase L,
																													Corp2_Raw_AK.Layouts.CorporationsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseCorporations := ROLLUP(	Ccombined_sort, rollupCBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_AK.Filenames(pversion).Base.Corporations.New, baseCorporations, Build_Corporations_Base);
		
  // -----------------------------
  // Build Officials Base File
	// -----------------------------		
	Corp2_Raw_AK.Layouts.OfficialsLayoutBase standardize_OfficialsInput(Corp2_Raw_AK.Layouts.OfficialsLayoutIn L) := TRANSFORM
		self.action_type				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;		
	
	OWorkingUpdate := PROJECT(pInOfficialsFile, standardize_OfficialsInput(LEFT));
	Ocombined 			:= OworkingUpdate + pBaseOfficialsFile;
	Ocombined_dist := DISTRIBUTE(Ocombined, HASH(ParentEntityNumber));
	Ocombined_sort := SORT(Ocombined_dist, ParentEntityNumber, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_AK.Layouts.OfficialsLayoutBase rollupOBase(	Corp2_Raw_AK.Layouts.OfficialsLayoutBase L,
																												Corp2_Raw_AK.Layouts.OfficialsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseOfficials := ROLLUP(	Ocombined_sort, rollupOBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_AK.Filenames(pversion).Base.Officials.New, baseOfficials, Build_Officials_Base);

	// --------------------------------
	EXPORT full_build := sequential(	Build_Corporations_Base,
																		Build_Officials_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AK.Build_Bases attribute')
									 );

END;
