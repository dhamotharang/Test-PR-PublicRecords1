IMPORT tools, Corp2;

EXPORT Build_Bases_Text_Information(
	STRING																									pfiledate,
	STRING																									pversion,
	BOOLEAN																				  	      pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Text_InformationLayoutIn)	pInText_Information   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Text_Information.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Text_InformationLayoutBase)pBaseText_Information 	= IF(Corp2_Raw_OH._Flags.Base.Text_Information, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Text_Information.qa, 	DATASET([], Corp2_Raw_OH.Layouts.Text_InformationLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.Text_InformationLayoutBase standardize_input(Corp2_Raw_OH.Layouts.Text_InformationLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take Text_Information update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInText_Information, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseText_Information;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.Text_InformationLayoutBase rollupBase(Corp2_Raw_OH.Layouts.Text_InformationLayoutBase L,
																														 Corp2_Raw_OH.Layouts.Text_InformationLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Text_Information.New, baseactions, Build_Text_Information_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Text_Information_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Text_Information attribute')
									 );

END;
