IMPORT tools, Corp2;

EXPORT Build_Bases_FilingType(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.FilingTypeIn)						pInFilingType   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.FilingType.logical,
	DATASET(Corp2_Raw_MD.Layouts.FilingTypeLayoutBase)		pBaseFilingType 	= IF(Corp2_Raw_MD._Flags.Base.FilingType, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.FilingType.qa, 	DATASET([], Corp2_Raw_MD.Layouts.FilingTypeLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.FilingTypeLayoutBase standardize_input(Corp2_Raw_MD.Layouts.FilingTypeIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take FilingType update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInFilingType, standardize_input(LEFT));

	// Combine Update with Previous Base
	combined 			:= workingUpdate + pBaseFilingType;
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received);//Small look table type file , not adding distribut
	
	Corp2_Raw_MD.Layouts.FilingTypeLayoutBase rollupBase(Corp2_Raw_MD.Layouts.FilingTypeLayoutBase L,
																											 Corp2_Raw_MD.Layouts.FilingTypeLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received
														);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.FilingType.New, baseactions, Build_FilingType_Base);

	EXPORT full_build := SEQUENTIAL(Build_FilingType_Base,
																	Promote(pversion).buildfiles.New2Built,
																	Promote().BuildFiles.Built2QA);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_FilingType_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_FilingType attribute')
									 );

END;
