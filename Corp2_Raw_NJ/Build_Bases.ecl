IMPORT tools, Corp2, Corp2_Raw_NJ;

EXPORT Build_Bases(	
	STRING	pfiledate,
	STRING	pversion,
	DATASET(Corp2_Raw_NJ.Layouts.BusinessLayoutIn)		pInBusinessFile   = Corp2_Raw_NJ.Files(pfiledate,pUseOtherEnvironment := FALSE).Input.PipeDelim,
	DATASET(Corp2_Raw_NJ.Layouts.BusinessLayoutBase)	pBaseBusinessFile = IF(_Flags.Base.Corporation 
																																						,Corp2_Raw_NJ.Files(,pUseOtherEnvironment := FALSE).Base.Corporation.qa
																																						,DATASET([],Corp2_Raw_NJ.Layouts.BusinessLayoutBase)))
	:= MODULE

	Corp2_Raw_NJ.Layouts.BusinessLayoutBase standardize_input(Corp2_Raw_NJ.Layouts.BusinessLayoutIn L) := TRANSFORM
		self.action_type				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the NJ Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInBusinessFile, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseBusinessFile;
	combined_dist := DISTRIBUTE(combined, HASH(Business_ID));
	combined_sort := SORT(combined_dist, Business_ID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NJ.Layouts.BusinessLayoutBase rollupBase(	Corp2_Raw_NJ.Layouts.BusinessLayoutBase L,
																													Corp2_Raw_NJ.Layouts.BusinessLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baseBusiness := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NJ.Filenames(pversion).Base.Business.New, baseBusiness, Build_Business_Base);
																		
	EXPORT full_build := sequential(	Build_Business_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NJ.Build_Bases attribute')
									 );

END;
