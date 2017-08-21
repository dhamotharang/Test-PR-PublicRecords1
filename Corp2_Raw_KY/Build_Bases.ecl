IMPORT corp2, tools;

EXPORT Build_Bases( STRING																									pfiledate,
										STRING																									pversion,										
										BOOLEAN 																								puseprod,
										DATASET(Corp2_Raw_KY.Layouts.CompanyLayoutIn)						pIn_Company    					= Corp2_raw_KY.Files(pfiledate,puseprod).Input.Companies,
										DATASET(Corp2_Raw_KY.Layouts.CompanyLayoutBase)					pBase_Company 					= IF(_Flags.Base.companies, Corp2_Raw_KY.Files(,pUseOtherEnvironment := FALSE).Base.Companies.qa, DATASET([], Corp2_Raw_KY.Layouts.CompanyLayoutBase)),
										DATASET(Corp2_Raw_KY.Layouts.OfficerLayoutIn)						pIn_Officer   					= Corp2_raw_KY.Files(pfiledate,puseprod).Input.Officer,
										DATASET(Corp2_Raw_KY.Layouts.OfficerLayoutBase)	  			pBase_Officer 					= IF(_Flags.Base.Officer, Corp2_Raw_KY.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, DATASET([], Corp2_Raw_KY.Layouts.OfficerLayoutBase)),
										DATASET(Corp2_Raw_KY.Layouts.InitialOfficersLayoutIn)		pIn_InitialOfficers   	= Corp2_raw_KY.Files(pfiledate,puseprod).Input.InitialOfficers,
										DATASET(Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase)	pBase_InitialOfficers 	= IF(_Flags.Base.InitialOfficers, Corp2_Raw_KY.Files(,pUseOtherEnvironment := FALSE).Base.InitialOfficers.qa, DATASET([], Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase))
									):= MODULE
									 
	Corp2_Raw_KY.Layouts.CompanyLayoutBase standardize_CompanyInput(Corp2_Raw_KY.Layouts.CompanyLayoutIn L) := TRANSFORM
		
		self.action_flag				    := 'U';
		self.dt_first_received	    := (integer)pversion;
		self.dt_last_received			  := (integer)pversion;
		self                        := l;

	end;

	// Take the KY Corp update file, add received dates, and PROJECT it into the base layout.
	workingCompanyUpdate := PROJECT(pIn_Company, standardize_CompanyInput(LEFT));

	// Combine base and update career to determine what's new.
	combined_company			:= workingCompanyUpdate + pBase_Company;
	combined_company_dist := DISTRIBUTE(combined_company, HASH32(ID));
	combined_company_sort := SORT(combined_company_dist, id, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_KY.Layouts.CompanyLayoutBase rollupCompanyBase(Corp2_Raw_KY.Layouts.CompanyLayoutBase L,
																													 Corp2_Raw_KY.Layouts.CompanyLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseCompany := ROLLUP(combined_company_sort,
												rollupCompanyBase(LEFT, RIGHT),
												RECORD,
												EXCEPT dt_first_received, dt_last_received,
												LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_KY.Filenames(pversion).Base.companies.New, baseCompany, Build_Company_Base);
  
	Corp2_Raw_KY.Layouts.OfficerLayoutBase standardize_OfficersInput(Corp2_Raw_KY.Layouts.OfficerLayoutIn  L) := TRANSFORM
		
		self.action_flag				    := 'U';
		self.dt_first_received	    := (integer)pversion;
		self.dt_last_received			  := (integer)pversion;
		self                        := l;
		
	end;

	// Take the KY Corp update file, add received dates, and PROJECT it into the base layout.
	workingOfficerUpdate := PROJECT(pIn_Officer, standardize_OfficersInput(LEFT));

	// Combine base and update career to determine what's new.
	combined_officer 			:= workingOfficerUpdate + pBase_Officer;
	combined_officer_dist := DISTRIBUTE(combined_officer, HASH32(ID));
	combined_officer_sort := SORT(combined_officer_dist, id, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_KY.Layouts.OfficerLayoutBase rollupOfficerBase( Corp2_Raw_KY.Layouts.OfficerLayoutBase L,
																														Corp2_Raw_KY.Layouts.OfficerLayoutBase R) := TRANSFORM
																										 
    SELF.dt_first_received	:= corp2.EarliestDate	(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate		(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseOfficer := ROLLUP(combined_officer_sort,
												rollupOfficerBase(LEFT, RIGHT),
												RECORD,
												EXCEPT dt_last_received, dt_first_received,
												LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_KY.Filenames(pversion).Base.Officer.New, baseOfficer,Build_Officer_Base);

	Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase standardize_InitialOfficersInput(Corp2_Raw_KY.Layouts.InitialOfficersLayoutIn  L) := TRANSFORM
		
		self.action_flag				    := 'U';
		self.dt_first_received	    := (integer)pversion;
		self.dt_last_received			  := (integer)pversion;
		self                        := l;
		
	end;

	// Take the KY Corp update file, add received dates, and PROJECT it into the base layout.
	workingInitialOfficersUpdate := PROJECT(pIn_InitialOfficers, standardize_InitialOfficersInput(LEFT));

	// Combine base and update career to determine what's new.
	combined_InitialOfficers 			:= workingInitialOfficersUpdate + pBase_InitialOfficers;
	combined_InitialOfficers_dist := DISTRIBUTE(combined_InitialOfficers, HASH32(ID));
	combined_InitialOfficers_sort := SORT(combined_InitialOfficers_dist, id, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase rollupInitialOfficersBase( Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase L,
																																						Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase R) := TRANSFORM
																										 
    SELF.dt_first_received	:= corp2.EarliestDate	(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate		(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseInitialOfficers := ROLLUP(combined_InitialOfficers_sort,
																rollupInitialOfficersBase(LEFT, RIGHT),
																RECORD,
																EXCEPT dt_last_received, dt_first_received,
																LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_KY.Filenames(pversion).Base.InitialOfficers.New, baseInitialOfficers,Build_InitialOfficers_Base);
	
	
	EXPORT full_build := sequential(	Build_Company_Base,
																		Build_Officer_Base,
																		Build_InitialOfficers_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_KY.Build_Bases attribute')
									 );

END;