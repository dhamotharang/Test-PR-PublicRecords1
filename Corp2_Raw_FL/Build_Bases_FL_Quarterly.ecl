IMPORT tools, corp2, Corp2_Raw_FL;

EXPORT Build_Bases_FL_Quarterly(	
   STRING                                           pfiledate  
	,STRING                                           pversion
	,BOOLEAN                                          pUseProd
	,DATASET(Corp2_Raw_FL.Layouts.CorpFileLayoutIn)		pInCorpFile    = Corp2_Raw_FL.Files(pfiledate,pUseProd).Input.CorpFile.logical
  ,DATASET(Corp2_Raw_FL.Layouts.CorpFileLayoutBase)	pBaseCorpFile  = IF(_Flags.Base.CorpFile 
																																						    ,Corp2_Raw_FL.Files(,pUseOtherEnvironment := FALSE).Base.CorpFile.qa
																																						    ,DATASET([],Corp2_Raw_FL.Layouts.CorpFileLayoutBase))
	,DATASET(Corp2_Raw_FL.Layouts.EventFileLayoutIn)	pInEventFile   = Corp2_Raw_FL.Files(pfiledate,pUseProd).Input.EventFile.logical
	,DATASET(Corp2_Raw_FL.Layouts.EventFileLayoutBase)pBaseEventFile = IF(_Flags.Base.EventFile 
																																						    ,Corp2_Raw_FL.Files(,pUseOtherEnvironment := FALSE).Base.EventFile.qa
																																						    ,DATASET([],Corp2_Raw_FL.Layouts.EventFileLayoutBase))																																					
	   ) := MODULE

  Corp2_Raw_FL.Layouts.CorpFileLayoutBase standardize_input(Corp2_Raw_FL.Layouts.CorpFileLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the FL CorpFile update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpFile, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpFile;
	combined_dist := DISTRIBUTE(combined, HASH(ANN_COR_NUMBER));
	combined_sort := SORT(combined_dist, ANN_COR_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_FL.Layouts.CorpFileLayoutBase rollupBase(Corp2_Raw_FL.Layouts.CorpFileLayoutBase L,
																											Corp2_Raw_FL.Layouts.CorpFileLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseCorpFile			 := ROLLUP(	combined_sort,
														    rollupBase(LEFT, RIGHT),
															  RECORD,
															  EXCEPT dt_last_received, dt_first_received,
															  LOCAL);
															

	tools.mac_WriteFile(Corp2_Raw_FL.Filenames(pversion).Base.CorpFile.New, baseCorpFile, Build_CorpFile_Base);
		
  Corp2_Raw_FL.Layouts.EventFileLayoutBase standardize_input(Corp2_Raw_FL.Layouts.EventFileLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the FL EventFile update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInEventFile, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseEventFile;
	combined_dist := DISTRIBUTE(combined, HASH(COR_EVENT_DOC_NUMBER));
	combined_sort := SORT(combined_dist, COR_EVENT_DOC_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_FL.Layouts.EventFileLayoutBase rollupBase(Corp2_Raw_FL.Layouts.EventFileLayoutBase L,
																											Corp2_Raw_FL.Layouts.EventFileLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseEventFile			 := ROLLUP(	combined_sort,
															  rollupBase(LEFT, RIGHT),
															  RECORD,
															  EXCEPT dt_last_received, dt_first_received,
															  LOCAL);

	tools.mac_WriteFile(Corp2_Raw_FL.Filenames(pversion).Base.EventFile.New, baseEventFile, Build_Event_Base);

	// --------------------------------
	EXPORT full_build := SEQUENTIAL(	Build_CorpFile_Base,
																		Build_Event_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_FL.Build_Bases_FL_Quarterly attribute')
									 );

END;
