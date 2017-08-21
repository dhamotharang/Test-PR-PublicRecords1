IMPORT tools, corp2, Corp2_Raw_FL;

EXPORT Build_Bases_FLTM(	
   STRING                                         pfiledate  
	,STRING                                         pversion
	,BOOLEAN                                        pUseProd
	,DATASET(Corp2_Raw_FL.Layouts.TMFileLayoutIn)		pInTMFile   = Corp2_Raw_FL.Files(pfiledate,pUseProd).Input.TMFile.logical
	,DATASET(Corp2_Raw_FL.Layouts.TMFileLayoutBase)	pBaseTMFile = IF(_Flags.Base.TMFile 
																																						    ,Corp2_Raw_FL.Files(,pUseOtherEnvironment := FALSE).Base.TMFile.qa
																																						    ,DATASET([],Corp2_Raw_FL.Layouts.TMFileLayoutBase))
	   ) := MODULE

  // -----------------------------
  // Build TMFile Base File
	// -----------------------------
Corp2_Raw_FL.Layouts.TMFileLayoutBase standardize_input(Corp2_Raw_FL.Layouts.TMFileLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the AL TMFile update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTMFile, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseTMFile;
	combined_dist := DISTRIBUTE(combined, HASH(TM_NUMBER));
	combined_sort := SORT(combined_dist, TM_NUMBER, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_FL.Layouts.TMFileLayoutBase rollupBase(	Corp2_Raw_FL.Layouts.TMFileLayoutBase L,
																											Corp2_Raw_FL.Layouts.TMFileLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseTMFile			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_FL.Filenames(pversion).Base.TMFile.New, baseTMFile, Build_TM_Base);
		
  
	// --------------------------------
	EXPORT full_build := SEQUENTIAL(	Build_TM_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_FL.Build_Bases_FLTM attribute')
									 );

END;
