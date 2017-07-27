IMPORT AutokeyI, AutoStandardI, Gateway;

EXPORT IParam := MODULE
	
	EXPORT ak_params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT boolean workHard := true;
		EXPORT boolean noFail := false;
		EXPORT boolean isdeepDive := false;
		EXPORT STRING TransactionId := '';
	END; 

	EXPORT functions_params := interface
		(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params)
	END;

	EXPORT search_params := interface(
		ak_params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		AutoStandardI.InterfaceTranslator.dob_mask_value.params)
			EXPORT STRING QueryId := '' ;
			EXPORT STRING UniqueId := '';
			EXPORT STRING ProductType := '';
			EXPORT STRING TransactionId := '';
			EXPORT STRING NationalId := '';
			EXPORT STRING CompanyId := '' ;	
	END;

	EXPORT IIDI2_search_params := interface(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		AutoStandardI.InterfaceTranslator.dob_mask_value.params)
			
			EXPORT STRING QueryId := '' ;
			EXPORT STRING ProductType := '';
			EXPORT STRING TransactionId := '';
			EXPORT STRING NationalId := '';
			EXPORT Unicode NationalId_City_Issued := '';
			EXPORT Unicode NationalId_District_Issued := '';
			EXPORT Unicode NationalId_County_Issued := '';
			EXPORT Unicode NationalId_Province_Issued := '';
			EXPORT STRING IGender := '';
			EXPORT Unicode NewFirstName := '';
			EXPORT Unicode NewMiddleName := '';
			EXPORT Unicode NewLastName := '';
			EXPORT Unicode FullName := '';
			EXPORT Unicode MaidenName := '';
			EXPORT STRING IDL_Number := '';
			EXPORT STRING DL_Version_Number := '';
			EXPORT STRING IDL_State := '';
			EXPORT STRING DL_Expire_Date := '';
			EXPORT STRING CompanyId := '';	
			EXPORT Unicode StreetAddress1 := '';
			EXPORT Unicode StreetAddress2 := '';
			EXPORT STRING UnitNumber := '';
			EXPORT Unicode BuildingNumber := '';
			EXPORT Unicode BuildingName := '';
			EXPORT STRING FloorNumber := '';
			EXPORT Unicode StreetNumber := '';
			EXPORT Unicode StreetName := '';
			EXPORT Unicode StreetType := '';
			EXPORT Unicode Suburb := '';
			EXPORT Unicode ICity := '';
			EXPORT Unicode District := '';
			EXPORT Unicode ICounty := '';
			EXPORT Unicode IState := '';
			EXPORT STRING2 CountryId := '';
			EXPORT STRING Postal_Code := '';
			EXPORT STRING IPhone := '';
			EXPORT STRING MobilePhone := '';
			EXPORT STRING WorkPhone := '';
			EXPORT STRING DateOfBirth := '';
			EXPORT STRING Passport_Number := '';
			EXPORT STRING Passport_Expire_Date := '';
			EXPORT Unicode Passport_Place_Birth := '';
			EXPORT Unicode Passport_Country_Birth := '';
			EXPORT Unicode Passport_Family_Name_Birth := '';
	END;
	
	EXPORT summary_params := interface(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params)
		EXPORT BOOLEAN IncludeRedFlags   := FALSE;
		EXPORT BOOLEAN IncludeFraudPoint := FALSE;	
		EXPORT STRING8 StartDate        := ''    : STORED('StartDate');
		EXPORT STRING8 EndDate          := ''    : STORED('EndDate');
		EXPORT STRING CompanyId         := ''    : STORED('CompanyId') ;	
	END;
	
	EXPORT IIDI2_summary_params := interface(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params)
		EXPORT STRING8 StartDate        := '';
		EXPORT STRING8 EndDate          := '';
		EXPORT STRING CompanyId         := '';	
		EXPORT STRING CountryId         := '';	
	END;	
	
END;