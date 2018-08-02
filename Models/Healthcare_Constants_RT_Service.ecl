EXPORT Healthcare_Constants_RT_Service := MODULE
	
	Export CFG_False := false;
	Export CFG_True := true;
	Export CFG_MBS_ACTIVE := true;

	Export _blank := '';

	Export Socio_product_id := '16';
	Export Socio_sub_product_id := '160004';

	Export CFG_MBS_SubscribedToReadmissionScore := 'SubscribedToReadmissionScore';
	Export CFG_MBS_SubscribedToHealthAttributesV3 := 'SubscribedToHealthAttributesV3';
	// Export CFG_MBS_SubscribedToMedicationAdherenceScore := 'SubscribedToMedicationAdherenceScore';

	// Error Messages Section
	Export InvalidInput_Code := 303;
	Export InvalidInput_Message := 'INVALID INPUT';
	Export AttributesSubFailMessage := 'ATTRIBUTES OPTION IS NOT SUBSCRIBED';
	Export ReadmissionSubFailMessage := 'READMISSION SCORE IS NOT SUBSCRIBED';
	Export SubInvalidRequest := 'INVALID REQUEST. ';
	Export INTEGER Name_First_Rej_Code := 8;
	Export Name_First_Rej_Message := 'INVALID OR BLANK FIRST NAME';
	Export INTEGER Name_Last_Rej_Code := 4;
	Export Name_Last_Rej_Message := 'INVALID OR BLANK LAST NAME';
	Export INTEGER Street_addr_Rej_Code := 512;
	Export Street_addr_Rej_Message := 'INVALID OR BLANK STREET ADDRESS';
	Export INTEGER p_City_name_Rej_Code := 1024;
	Export p_City_name_Rej_Message := 'INVALID OR BLANK CITY';
	Export INTEGER ST_name_Rej_Code := 2048;
	Export ST_name_Rej_Message := 'INVALID OR BLANK STATE';
	Export INTEGER Z5_Rej_Code := 4096;
	Export Z5_Rej_Message := 'INVALID OR BLANK ZIP CODE';
	Export INTEGER DOB_Rej_Code := 256;
	Export DOB_Rej_Message := 'INVALID OR BLANK DATE OF BIRTH';
	Export INTEGER MemberGender_Rej_Code := 16777216;
	Export MemberGender_Rej_Message := 'INVALID OR BLANK GENDER';
	Export INTEGER SSN_Rej_Code := 128;
	Export SSN_Rej_Message := 'INVALID OR BLANK SSN';
	Export INTEGER Minor_Rej_Code := 666666;
	Export Minor_Rej_Message := 'INPUT RECORD IS A MINOR';
	Export INTEGER ADLScoreFail_Code := 10;
	Export ADLScoreFail_Message := 'MINIMUM CONFIDENCE SCORE THRESHOLD NOT MET';
	Export GLBRequiredFail_Message := 'A VALID GLB PERMISSIBLE PURPOSE IS REQUIRED TO USE THIS PRODUCT.';
	Export GLBInvalidFail_Message := 'SUPPLIED GLB PURPOSE IS NOT AN APPROVED USAGE VALUE.';
	Export DPPAInvalidFail_Message := 'THERE IS NO DPPA PERMISSIBLE PURPOSE FOR THIS PRODUCT.';

	Export InvalidAdmitDate_FieldName := 'AdmitDate';
	Export InvalidAdmitDate_Code := '67108864';
	Export InvalidAdmitDate_Message := 'INVALID OR BLANK ADMIT DATE';
	Export InvalidPatientType_FieldName := 'PatientType';
	Export InvalidPatientType_Code := '999999';
	Export InvalidPatientType_Message := 'INVALID PATIENT TYPE';
	Export InvalidFinancialClass_FieldName := 'FinancialClass';
	Export InvalidFinancialClass_Code := '888888';
	Export InvalidFinancialClass_Message := 'INVALID FINANCIAL CLASS';
	Export InvalidDiagnosisCode_FieldName := 'DiagnosisCode';
	Export InvalidDiagnosisCode_Code := '777777';
	Export InvalidDiagnosisCode_Message := 'INVALID DIAGNOSIS CODE';

	Export CFG_MBS_SuppressAccident	:= 'SuppressAccident';
	Export CFG_MBS_SuppressAddressStability := 'SuppressAddressStability';
	Export CFG_MBS_SuppressAsset := 'SuppressAsset';
	Export CFG_MBS_SuppressCurrentAddress := 'SuppressCurrentAddress';
	Export CFG_MBS_SuppressDemographics := 'SuppressDemographics';
	Export CFG_MBS_SuppressDerogatoryRecord := 'SuppressDerogatoryRecord';
	Export CFG_MBS_SuppressDerogatoryCrimeRecord := 'SuppressDerogatoryCrimeRecord';
	Export CFG_MBS_SuppressDerogatoryFinancialRecord := 'SuppressDerogatoryFinancialRecord';
	Export CFG_MBS_SuppressEducation := 'SuppressEducation';
	Export CFG_MBS_SuppressIdentityActivity := 'SuppressIdentityActivity';
	Export CFG_MBS_SuppressIdentityAssociation := 'SuppressIdentityAssociation';
	Export CFG_MBS_SuppressIdentityFraudRisk := 'SuppressIdentityFraudRisk';
	Export CFG_MBS_SuppressIdentityProductSearchEvent := 'SuppressIdentityProductSearchEvent';
	Export CFG_MBS_SuppressIdentityValidation := 'SuppressIdentityValidation';
	Export CFG_MBS_SuppressIdentityVariation := 'SuppressIdentityVariation';
	Export CFG_MBS_SuppressIncome := 'SuppressIncome';
	Export CFG_MBS_SuppressInputAddress := 'SuppressInputAddress';
	Export CFG_MBS_SuppressInputSSN := 'SuppressInputSSN';
	Export CFG_MBS_SuppressInterests := 'SuppressInterests';
	Export CFG_MBS_SuppressMostRecentAddress := 'SuppressMostRecentAddress';
	Export CFG_MBS_SuppressNonDerogatoryRecord := 'SuppressNonDerogatoryRecord';
	Export CFG_MBS_SuppressNonDerogatoryOccupationalRecord := 'SuppressNonDerogatoryOccupationalRecord';
	Export CFG_MBS_SuppressPhone := 'SuppressPhone';
	Export CFG_MBS_SuppressPreviousAddress := 'SuppressPreviousAddress';
	Export CFG_MBS_SuppressSubprimeRequests := 'SuppressSubprimeRequests';

	Export CFG_MBS_ReadmissionScore_Category_5_High := 'ReadmissionScore_Category_5_High';
	Export CFG_MBS_ReadmissionScore_Category_5_Low := 'ReadmissionScore_Category_5_Low';
	Export CFG_MBS_ReadmissionScore_Category_4_High := 'ReadmissionScore_Category_4_High';
	Export CFG_MBS_ReadmissionScore_Category_4_Low := 'ReadmissionScore_Category_4_Low';
	Export CFG_MBS_ReadmissionScore_Category_3_High := 'ReadmissionScore_Category_3_High';
	Export CFG_MBS_ReadmissionScore_Category_3_Low := 'ReadmissionScore_Category_3_Low';
	Export CFG_MBS_ReadmissionScore_Category_2_High := 'ReadmissionScore_Category_2_High';
	Export CFG_MBS_ReadmissionScore_Category_2_Low := 'ReadmissionScore_Category_2_Low';
	Export CFG_MBS_ReadmissionScore_Category_1_High := 'ReadmissionScore_Category_1_High';
	Export CFG_MBS_ReadmissionScore_Category_1_Low := 'ReadmissionScore_Category_1_Low';

	Export	DECIMAL5_2 val_ReadmissionScore_Category_5_High	:= 100 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_5_Low	:= 34.81 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_4_High	:= 34.80 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_4_Low	:= 16.33 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_3_High	:= 16.32 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_3_Low	:= 12.23 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_2_High	:= 12.22 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_2_Low	:= 8.53 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_1_High	:= 8.52 ;
	Export	DECIMAL5_2 val_ReadmissionScore_Category_1_Low	:= 0 ;

	Export usage_GLB_Value := '06';

	export authorized_DPPA := 0;
	export authorized_GLBA := 6;
	export default_DataRestriction := '000000000000010000000000000000'; 
	export default_DataPermission := '000000000000000000000000000000';  
	export default_LeadIntegrity_Version := 4;
	export default_BocaShell_Version := 41;
	export default_ProfileBooster_Version := 1; //or v1/V1
	export default_ProfileBooster_AttributesVersionRequest := 'PBATTRV1';
	export default_onThor := false;
	export unsigned default_adl_score_filter_val := 80;
END;