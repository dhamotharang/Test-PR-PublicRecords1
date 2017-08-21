IMPORT tools, corp2, Corp2_Raw_WA;

EXPORT Build_Bases(	
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_WA.Layouts.CorpsLayoutIn)		pInCorpsFile   = Corp2_Raw_WA.Files(pfiledate,puseprod).Input.Corps.logical,
	DATASET(Corp2_Raw_WA.Layouts.CorpsLayoutBase)	pBaseCorpsFile = IF(_Flags.Base.Corps 
																																						,Corp2_Raw_WA.Files(,pUseOtherEnvironment := FALSE).Base.Corps.qa
																																						,DATASET([],Corp2_Raw_WA.Layouts.CorpsLayoutBase)))
	:= MODULE

	Corp2_Raw_WA.Layouts.CorpsLayoutBase standardize_input(Corp2_Raw_WA.Layouts.CorpsLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the WA Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpsFile, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseCorpsFile;
	combined_dist := DISTRIBUTE(combined, HASH(UBI));
	combined_sort := SORT(combined_dist, UBI, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_WA.Layouts.CorpsLayoutBase rollupBase(	Corp2_Raw_WA.Layouts.CorpsLayoutBase L,
																										Corp2_Raw_WA.Layouts.CorpsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseCorps := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_WA.Filenames(pversion).Base.Corps.New, baseCorps, Build_Corps_Base);
																		
	EXPORT full_build := sequential(	Build_Corps_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WA.Build_Bases attribute')
									 );

END;
