IMPORT tools, corp2;

EXPORT Build_Bases(
  STRING																								pfiledate,
	STRING																								pversion,
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_DC.Layouts.CorporationsLayoutIn)		pInCorporationsFile   = Corp2_raw_dc.Files(pfiledate,pUseOtherEnvironment).Input.corporation.Logical,
	DATASET(Corp2_Raw_DC.Layouts.CorporationsLayoutBase)	pBaseCorporationsFile = IF(_Flags.Base.Corporation, Corp2_Raw_DC.Files(,pUseOtherEnvironment).Base.corporation.qa, DATASET([], Corp2_Raw_DC.Layouts.CorporationsLayoutBase))) := MODULE
	
	Corp2_Raw_DC.Layouts.CorporationsLayoutBase standardize_input(Corp2_Raw_DC.Layouts.CorporationsLayoutIn L) := TRANSFORM
		
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 										:= L;
		
	end;

	// Take the DC corp's update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorporationsFile, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseCorporationsFile;
	combined_dist := DISTRIBUTE(combined, HASH(FileNumber));
	combined_sort := SORT(combined_dist, FileNumber, record, except dt_first_received, dt_last_received,action_flag, LOCAL);
	
	Corp2_Raw_DC.Layouts.CorporationsLayoutBase rollupBase(Corp2_Raw_DC.Layouts.CorporationsLayoutBase L,
																												 Corp2_Raw_DC.Layouts.CorporationsLayoutBase R) := TRANSFORM
																												 
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate  (L.dt_last_received, R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	Basecorporations := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,action_flag,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_DC.Filenames(pversion).Base.Corporation.New, Basecorporations, Build_Corporation_Base);

	EXPORT full_build := sequential(	Build_Corporation_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																  );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_DC.Build_Bases attribute')
									 );

END;