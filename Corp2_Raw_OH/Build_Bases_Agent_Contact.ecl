IMPORT tools, Corp2;

EXPORT Build_Bases_Agent_Contact(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Agent_ContactLayoutIn)	 pInAgent_Contact   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Agent_Contact.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase)pBaseAgent_Contact   = IF(Corp2_Raw_OH._Flags.Base.Agent_Contact, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Agent_Contact.qa, 	DATASET([], Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase standardize_input(Corp2_Raw_OH.Layouts.Agent_ContactLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Agent_Contact update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInAgent_Contact, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseAgent_Contact;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase rollupBase(Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase L,
																													Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Agent_Contact.New, baseactions, Build_Agent_Contact_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Agent_Contact_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Agent_Contact attribute')
									 );

END;
