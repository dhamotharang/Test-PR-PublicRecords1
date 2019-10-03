EXPORT mac_append_provider_best_data  (Infile,Input_LNPID = '',
																			 Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
																			 Input_LIC_STATE = '',Input_LIC_NBR = '',
																			 Input_DEA_NUMBER = '',Input_NPI_NUMBER = '',in_prefix = 'idv') := FUNCTIONMACRO

	import hipie_ecl, Health_Provider_Services;	
	
	Layout_best := RECORD
		UNSIGNED8 uniqueID;
		recordof(infile);
		UNSIGNED8 PREFIX_LexID;
		STRING1	  Header_Entity_Type;
		STRING9	  Header_SSN;
		STRING9	  Header_Consumer_SSN;
		UNSIGNED4 Header_DateOfBirth;
		UNSIGNED4 Header_Consumer_DateOfBirth;
		STRING25  Header_LicenseNumber;
		STRING25  Header_CleanedLicenseNumber;
		STRING2	  Header_LicenseState;
		STRING60  Header_LicenseType;
		STRING60  Header_LicenseStatus;
		UNSIGNED4 Header_DateLicenseExpired; 
		STRING1	  Header_DeathIndicator;
		UNSIGNED4 Header_DateOfDeath;
		UNSIGNED4 Header_BillingTaxID;
		STRING10  Header_Phone;
		STRING10  Header_Fax;
		STRING6	  Header_UPIN;
		STRING10  Header_NPINUMBER;
		UNSIGNED4 Header_DateNPIDeactivated;		
		STRING1	  Header_DEABusinessActivityIndicator;		
		STRING10  Header_DEANumber;
		UNSIGNED4 Header_DateDEAExpired;
		BOOLEAN	  Header_isStateSanction;
		BOOLEAN	  Header_isOfficeOfInspectorGeneralSanction;
		BOOLEAN	  Header_isOfficeOfPersonalManagementSanction;
		STRING10  Header_Taxonomy;
		STRING50  Header_TaxonomyDescription;		
		STRING3	  Header_SpecialityCode;	
		STRING1	  Header_ProviderStatus;
		UNSIGNED4 Header_LicenseCount;
		UNSIGNED4 Header_LicenseStateCount;
		UNSIGNED4 Header_ActiveLicenseCount;
		UNSIGNED4 Header_InactiveLicenseCount;
		UNSIGNED4 Header_RevokedLicenseCount;
		UNSIGNED4 Header_DEACount;
		UNSIGNED4 Header_ActiveDEACount;
		UNSIGNED4 Header_ExpiredDEACount;
		UNSIGNED4 Header_DeactivedNPICount;		
		STRING10  Header_PracticePrimaryRange;
		STRING2   Header_PracticePreDirection;
		STRING28  Header_PracticePrimaryName;
		STRING4   Header_PracticeAddressSuffix;
		STRING2   Header_PracticePostDirection;
		STRING10  Header_PracticeUnitDesignation;
		STRING8   Header_PracticeSecondaryRange;
		STRING25  Header_PracticeCityName_Vanity;
		STRING2   Header_PracticeState;
		STRING5   Header_PracticeZip5;
		UNSIGNED4 Header_PracticeAddressLastVerified;
		UNSIGNED4 Client_DateLicenseExpired;
		STRING60  Client_LicenseType;		
		STRING60  Client_LicenseStatus;		
		UNSIGNED4 Client_DateNPIDeactivated;
		STRING1	  Client_NPIFlag;
		UNSIGNED4 Client_DateDEAExpired;		
		STRING1	  Client_DEAFlag;		
		STRING40	Group_Key;
	END;
	
	Health_Provider_Services.mac_append_provider_data  (Infile,Input_LNPID,
																	Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_Name,Input_ST,Input_ZIP,
																	Input_LIC_STATE,Input_LIC_NBR,
																	Input_DEA_NUMBER,Input_NPI_NUMBER,Outfile);

	Results := hipie_ecl.macFieldRename(Outfile, in_prefix, 'prefix_',,true);

	RETURN Results;
ENDMACRO;