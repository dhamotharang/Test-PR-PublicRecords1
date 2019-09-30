IMPORT PublicRecords_KEL, Gateway;

EXPORT Interface_Options := INTERFACE
	EXPORT STRING AttributeSetName := '';
	EXPORT STRING VersionName := '';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := '0';
	EXPORT STRING InputFileName := '';
	EXPORT STRING PermissiblePurpose := '';
	EXPORT STRING Data_Restriction_Mask := '';
	EXPORT STRING Data_Permission_Mask := '';
	EXPORT UNSIGNED GLBAPurpose := 0;
	EXPORT UNSIGNED DPPAPurpose := 0;
	EXPORT BOOLEAN Override_Experian_Restriction := FALSE;
	EXPORT STRING Allowed_Sources := '';
	EXPORT INTEGER ScoreThreshold := 80;
	EXPORT BOOLEAN ExcludeConsumerAttributes := FALSE;
	EXPORT BOOLEAN isMarketing := FALSE; // When TRUE enables Marketing Restrictions
	EXPORT UNSIGNED8 KEL_Permissions_Mask := 0; // Set by PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate()
	EXPORT BOOLEAN OutputMasterResults := FALSE;
	
		SHARED gateways_in := Gateway.Configuration.Get();
		SHARED Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
			SELF.servicename := le.servicename;
			SELF.url := le.url; 
			SELF := le;
		END;

	EXPORT DATASET(Gateway.Layouts.Config) Gateways := PROJECT(gateways_in, gw_switch(LEFT));
	
	// BIP Append Options
	EXPORT UNSIGNED BIPAppendScoreThreshold := 75;
	EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
	EXPORT BOOLEAN BIPAppendPrimForce := FALSE;
	EXPORT BOOLEAN BIPAppendReAppend := TRUE;
	EXPORT BOOLEAN BIPAppendIncludeAuthRep := FALSE;

	// CCPA Options
	EXPORT UNSIGNED1 LexIdSourceOptout := 1;
	EXPORT STRING TransactionID := '';
	EXPORT STRING BatchUID := '';
	EXPORT UNSIGNED6 GlobalCompanyId := 0;
	
	// Performance options to turn ON/OFF ENTITIES in during FDC build.
	// By default, all ENTITIES are ON.
	EXPORT BOOLEAN IncludeAccident := TRUE;
	EXPORT BOOLEAN IncludeAddress := TRUE;
	EXPORT BOOLEAN IncludeAircraft := TRUE;
	EXPORT BOOLEAN IncludeBankruptcy := TRUE;
	EXPORT BOOLEAN IncludeBusiness := TRUE;
	EXPORT BOOLEAN IncludeBusinessSele := TRUE;
	EXPORT BOOLEAN IncludeBusinessProx := TRUE;
	EXPORT BOOLEAN IncludeCorporateFiling := TRUE;
	EXPORT BOOLEAN IncludeCriminalOffender := TRUE;
	EXPORT BOOLEAN IncludeCriminalOffense := TRUE;
	EXPORT BOOLEAN IncludeCriminalPunishment := TRUE;
	EXPORT BOOLEAN IncludeDriversLicense := TRUE;
	EXPORT BOOLEAN IncludeEducation := TRUE;
	EXPORT BOOLEAN IncludeEmail := TRUE;
	EXPORT BOOLEAN IncludeEmployment := TRUE;
	EXPORT BOOLEAN IncludeHousehold := TRUE;
	EXPORT BOOLEAN IncludeInquiry := TRUE;
	EXPORT BOOLEAN IncludePerson := TRUE;
	EXPORT BOOLEAN IncludePhone := TRUE;
	EXPORT BOOLEAN IncludeProfessionalLicense := TRUE;
	EXPORT BOOLEAN IncludeProperty := TRUE;
	EXPORT BOOLEAN IncludeSocialSecurityNumber := TRUE;
	EXPORT BOOLEAN IncludeTIN := TRUE;
	EXPORT BOOLEAN IncludeTradeline := TRUE;
	EXPORT BOOLEAN IncludeUtility := TRUE;
	EXPORT BOOLEAN IncludeVehicle := TRUE;
	EXPORT BOOLEAN IncludeWatercraft := TRUE;
	EXPORT BOOLEAN IncludeZipCode := TRUE;
	EXPORT BOOLEAN IncludeUCC := TRUE;
	EXPORT BOOLEAN IncludeSeleUCC := TRUE;
	EXPORT BOOLEAN IncludePersonUCC := TRUE;

	
	// Performance options to turn ON/OFF ASSOCIATIONS in during FDC build. 
	// By default, we'll check if their related ENTITIES are needed.
	EXPORT BOOLEAN IncludeAccidentAddress := IncludeAccident AND IncludeAddress;
	EXPORT BOOLEAN IncludeAccidentDriversLicense := IncludeAccident AND IncludeDriversLicense;
	EXPORT BOOLEAN IncludeAddressDriversLicense := IncludeAddress AND IncludeDriversLicense;
	EXPORT BOOLEAN IncludeAddressInquiry := IncludeAddress AND IncludeInquiry;
	EXPORT BOOLEAN IncludeAddressPhone := IncludeAddress AND IncludePhone;
	EXPORT BOOLEAN IncludeAddressProperty := IncludeAddress AND IncludeProperty;
	EXPORT BOOLEAN IncludeAddressUtility := IncludeAddress AND IncludeUtility;
	EXPORT BOOLEAN IncludeAddressVehicle := IncludeAddress AND IncludeVehicle;
	EXPORT BOOLEAN IncludeAircraftAddress := IncludeAircraft AND IncludeAddress;
	EXPORT BOOLEAN IncludeAircraftOwner := IncludeAircraft AND IncludePerson;	
	EXPORT BOOLEAN IncludeBusinessUCC := IncludeBusinessSele AND IncludeUCC;
	EXPORT BOOLEAN IncludeCriminalDetails := IncludeCriminalOffender AND IncludeCriminalOffense AND IncludeCriminalPunishment;
	EXPORT BOOLEAN IncludeDriversLicenseInquiry := IncludeDriversLicense AND IncludeInquiry;
	EXPORT BOOLEAN IncludeEducationSSN := IncludeEducation AND IncludeSocialSecurityNumber;
	EXPORT BOOLEAN IncludeEducationStudentAddress := IncludeEducation AND IncludeAddress;
	EXPORT BOOLEAN IncludeEmailHousehold := IncludeHousehold AND IncludeEmail;
	EXPORT BOOLEAN IncludeEmploymentBusiness := IncludeEmployment AND IncludeBusiness;
	EXPORT BOOLEAN IncludeEmploymentBusinessAddress := IncludeEmployment AND IncludeAddress;
	EXPORT BOOLEAN IncludeEmploymentPerson := IncludeEmployment AND IncludePerson;
	EXPORT BOOLEAN IncludeEmploymentSSN := IncludeEmployment AND IncludeSocialSecurityNumber;
	EXPORT BOOLEAN IncludeFirstDegreeAssociations := IncludePerson;
	EXPORT BOOLEAN IncludeFirstDegreeRelative := IncludePerson;
	EXPORT BOOLEAN IncludeHouseholdMember := IncludePerson;
	EXPORT BOOLEAN IncludeHouseholdPhone := IncludeHousehold AND IncludePhone;
	EXPORT BOOLEAN IncludeOffenderAddress := IncludeCriminalOffender AND IncludeAddress;
	EXPORT BOOLEAN IncludeOffenderSSN := IncludeCriminalOffender AND IncludeSocialSecurityNumber;
	EXPORT BOOLEAN IncludePersonAccident := IncludePerson AND IncludeAccident;
	EXPORT BOOLEAN IncludePersonAddress := IncludePerson AND IncludeAddress;
	EXPORT BOOLEAN IncludePersonBankruptcy := IncludePerson AND IncludeBankruptcy;
	EXPORT BOOLEAN IncludePersonDriversLicense := IncludePerson AND IncludeDriversLicense;
	EXPORT BOOLEAN IncludePersonEducation := IncludePerson AND IncludeEducation;
	EXPORT BOOLEAN IncludePersonEmail := IncludePerson AND IncludeEmail;
	EXPORT BOOLEAN IncludePersonEmailPhoneAddress := IncludePerson AND IncludeEmail AND IncludeAddress AND IncludePhone;
	EXPORT BOOLEAN IncludePersonInquiry := IncludePerson AND IncludeInquiry;
	EXPORT BOOLEAN IncludePersonOffender := IncludePerson AND IncludeCriminalOffender;
	EXPORT BOOLEAN IncludePersonOffenses := IncludePerson AND IncludeCriminalOffense;
	EXPORT BOOLEAN IncludePersonPhone := IncludePerson AND IncludePhone;
	EXPORT BOOLEAN IncludePersonProperty := IncludePerson AND IncludeProperty;
	EXPORT BOOLEAN IncludePersonSSN := IncludePerson AND IncludeSocialSecurityNumber;
	EXPORT BOOLEAN IncludePersonVehicle := IncludePerson AND IncludeVehicle;
	EXPORT BOOLEAN IncludePhoneInquiry := IncludePhone AND IncludeInquiry;
	EXPORT BOOLEAN IncludePhoneSSN := IncludePhone AND IncludeSocialSecurityNumber;
	EXPORT BOOLEAN IncludeProfessionalLicenseAddress  := IncludeProfessionalLicense AND IncludeAddress;
	EXPORT BOOLEAN IncludeProfessionalLicensePerson := IncludeProfessionalLicense AND IncludePerson;
	EXPORT BOOLEAN IncludeProfessionalLicensePhone := IncludeProfessionalLicense AND IncludePhone;
	EXPORT BOOLEAN IncludeProxPhoneNumber := IncludeBusinessProx AND IncludePhone;
	EXPORT BOOLEAN IncludeProxAddress   := IncludeBusinessProx AND IncludeAddress;
	EXPORT BOOLEAN IncludeProxPerson  := IncludeBusinessProx AND IncludePerson;
	EXPORT BOOLEAN IncludeProxPhone   := IncludeBusinessProx AND IncludePhone;
	EXPORT BOOLEAN IncludeProxTIN := IncludeTIN AND IncludeBusinessProx;	
	EXPORT BOOLEAN IncludeProxUtility   := IncludeBusinessProx AND IncludeUtility;
	EXPORT BOOLEAN IncludeSecondDegreeAssociations := IncludePerson;
	EXPORT BOOLEAN IncludeSeleAddress := IncludeAddress AND IncludeBusinessSele;	
	EXPORT BOOLEAN IncludeSeleAircraft := IncludeAircraft AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleBankruptcy := IncludeBusinessSele AND IncludeBankruptcy;
	EXPORT BOOLEAN IncludeSelePerson := IncludePerson AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSelePhoneNumber := IncludePhone AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleVehicle := IncludeVehicle AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleWatercraft := IncludeWatercraft AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSSNAddress := IncludeSocialSecurityNumber AND IncludeAddress;
	EXPORT BOOLEAN IncludeSSNBankruptcy := IncludeSocialSecurityNumber AND IncludeBankruptcy;
	EXPORT BOOLEAN IncludeSSNInquiry := IncludeSocialSecurityNumber AND IncludeInquiry;
	EXPORT BOOLEAN IncludeSSNProperty := IncludeSocialSecurityNumber AND IncludeProperty;
	EXPORT BOOLEAN IncludeTINBusinessSele := IncludeBusinessSele AND IncludeTIN;
	EXPORT BOOLEAN IncludeTINPhone := IncludePhone AND IncludeTIN;
	EXPORT BOOLEAN IncludeTINAddress := IncludeAddress AND IncludeTIN;
	EXPORT BOOLEAN IncludeTradelineBusiness := IncludeBusiness AND IncludeTradeline;
	EXPORT BOOLEAN IncludeUtilityHomeAddress := IncludeUtility AND IncludeAddress;
	EXPORT BOOLEAN IncludeUtilityPerson := IncludeUtility AND IncludePerson;
	EXPORT BOOLEAN IncludeUtilityPhone := IncludeUtility AND IncludePhone;
	EXPORT BOOLEAN IncludeWatercraftAddress := IncludeWatercraft AND IncludeAddress;
	EXPORT BOOLEAN IncludeWatercraftOwner := IncludeWatercraft AND IncludePerson;
	EXPORT BOOLEAN IncludeZipCodePerson := IncludeZipCode AND IncludePerson;
END;	