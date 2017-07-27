export Customer_License_Search_Constants := MODULE
	EXPORT MAX_RECS_ON_JOIN := 1000;
	EXPORT MI_CUSTOMER := '1535116';
	Export CUST_LIC_CODESV3_FILENAME := 'HEALTHCARE_CUST_LIC';
	Export CUST_LIC_CODESV3_FIELDNAME := 'VALID_ACCT';
	Export MI_LicenseType_R := 1;
	Export MI_LicenseType_E := 2;
	Export MI_LicenseType_L := 3;
	Export MI_LicenseType_A := 4;
	Export MI_LicenseType_N := 5;
END;