import Gateway, PublicRecords_KEL;

EXPORT Interface_Mini_Options (PublicRecords_KEL.Interface_Options OptionsRaw) := MODULE(PublicRecords_KEL.Interface_Options)
	EXPORT STRING100 AttributeSetName := OptionsRaw.AttributeSetName;
	EXPORT STRING100 VersionName := OptionsRaw.VersionName;
	EXPORT BOOLEAN isFCRA := OptionsRaw.isFCRA;
	EXPORT STRING8 ArchiveDate := OptionsRaw.ArchiveDate;
	EXPORT STRING250 InputFileName := OptionsRaw.InputFileName;
	EXPORT STRING100 IntendedPurpose := OptionsRaw.IntendedPurpose;
	EXPORT STRING100 Data_Restriction_Mask := OptionsRaw.Data_Restriction_Mask;
	EXPORT STRING100 Data_Permission_Mask := OptionsRaw.Data_Permission_Mask;
	EXPORT UNSIGNED GLBAPurpose := OptionsRaw.GLBAPurpose;
	EXPORT UNSIGNED DPPAPurpose := OptionsRaw.DPPAPurpose;
	EXPORT BOOLEAN Override_Experian_Restriction := OptionsRaw.Override_Experian_Restriction;
	EXPORT STRING100 Allowed_Sources := OptionsRaw.Allowed_Sources;
	EXPORT INTEGER ScoreThreshold := OptionsRaw.ScoreThreshold;
	EXPORT BOOLEAN ExcludeConsumerAttributes := OptionsRaw.ExcludeConsumerAttributes;
	EXPORT BOOLEAN isMarketing := OptionsRaw.isMarketing ;// When TRUE enables Marketing Restrictions
	EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := OptionsRaw.Allowed_Sources_Dataset;
	EXPORT DATA57 KEL_Permissions_Mask := OptionsRaw.KEL_Permissions_Mask ;// Set by PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate()
	EXPORT BOOLEAN OutputMasterResults := OptionsRaw.OutputMasterResults;
	EXPORT BOOLEAN IncludeMinors := OptionsRaw.IncludeMinors;
	EXPORT INTEGER upperage := OptionsRaw.upperage;
	EXPORT STRING5 IndustryClass := OptionsRaw.IndustryClass;
	EXPORT DATASET(Gateway.Layouts.Config) Gateways := OptionsRaw.Gateways;
		
	EXPORT BOOLEAN isBRM_Marketing := OptionsRaw.isBRM_Marketing;

	// BIP Append Options
	EXPORT UNSIGNED BIPAppendScoreThreshold := OptionsRaw.BIPAppendScoreThreshold;
	EXPORT UNSIGNED BIPAppendWeightThreshold := OptionsRaw.BIPAppendWeightThreshold;
	EXPORT BOOLEAN BIPAppendPrimForce := OptionsRaw.BIPAppendPrimForce;
	EXPORT BOOLEAN BIPAppendReAppend := OptionsRaw.BIPAppendReAppend;
	EXPORT BOOLEAN BIPAppendIncludeAuthRep := OptionsRaw.BIPAppendIncludeAuthRep;

	// CCPA Options
	EXPORT UNSIGNED1 LexIdSourceOptout := OptionsRaw.LexIdSourceOptout;
	EXPORT STRING100 TransactionID := OptionsRaw.TransactionID;
	EXPORT STRING100 BatchUID := OptionsRaw.BatchUID;
	EXPORT UNSIGNED6 GlobalCompanyId := OptionsRaw.GlobalCompanyId;
	
	// Performance options to turn ON/OFF ENTITIES in during FDC build.
	// By default, all ENTITIES are OFF.
	EXPORT BOOLEAN IncludeAccident := FALSE;
	EXPORT BOOLEAN IncludeAddress := FALSE;
	EXPORT BOOLEAN IncludeAddressSummary := FALSE;
	EXPORT BOOLEAN IncludeAircraft := FALSE;
	EXPORT BOOLEAN IncludeBankruptcy := FALSE;
	EXPORT BOOLEAN IncludeBusinessSele := FALSE;
	EXPORT BOOLEAN IncludeBusinessProx := FALSE;
	EXPORT BOOLEAN IncludeCriminalOffender := FALSE;
	EXPORT BOOLEAN IncludeCriminalOffense := FALSE;
	EXPORT BOOLEAN IncludeCriminalPunishment := FALSE;
	EXPORT BOOLEAN IncludeDriversLicense := FALSE;
	EXPORT BOOLEAN IncludeEducation := FALSE;
	EXPORT BOOLEAN IncludeEmail := FALSE;
	EXPORT BOOLEAN IncludeEBRTradeline := TRUE;
	EXPORT BOOLEAN IncludeEmployment := FALSE;
	EXPORT BOOLEAN IncludeGeolink := FALSE;
	EXPORT BOOLEAN IncludeHousehold := FALSE;
	EXPORT BOOLEAN IncludeInquiry := FALSE;
	EXPORT BOOLEAN IncludeLienJudgment := FALSE;
	EXPORT BOOLEAN IncludePerson := FALSE;
	EXPORT BOOLEAN IncludePhone := FALSE;
	EXPORT BOOLEAN IncludeProfessionalLicense := FALSE;
	EXPORT BOOLEAN IncludeProperty := FALSE;
	EXPORT BOOLEAN IncludePropertyEvent := FALSE;
	EXPORT BOOLEAN IncludeSexOffender := FALSE;
	EXPORT BOOLEAN IncludeSocialSecurityNumber := FALSE;
	EXPORT BOOLEAN IncludeSurname := FALSE;
	EXPORT BOOLEAN IncludeTIN := FALSE;
	EXPORT BOOLEAN IncludeTradeline := FALSE;
	EXPORT BOOLEAN IncludeUtility := FALSE;
	EXPORT BOOLEAN IncludeVehicle := FALSE;
	EXPORT BOOLEAN IncludeWatercraft := FALSE;
	EXPORT BOOLEAN IncludeZipCode := FALSE;
	EXPORT BOOLEAN IncludeUCC := FALSE;
  EXPORT BOOLEAN IncludeNameSummary := FALSE;
  EXPORT BOOLEAN IncludePhoneSummary := FALSE;
	EXPORT BOOLEAN IncludeSSNSummary := FALSE;
	EXPORT BOOLEAN IncludeOverrides := TRUE;
	EXPORT BOOLEAN IncludeMini := TRUE;

	
	// Performance options to turn ON/OFF ASSOCIATIONS in during FDC build. 
	// By default, we'll check if their related ENTITIES are needed.
	EXPORT BOOLEAN IncludeAddressDriversLicense := IncludeAddress AND IncludeDriversLicense;
	EXPORT BOOLEAN IncludeAddressInquiry := IncludeAddress AND IncludeInquiry;
	EXPORT BOOLEAN IncludeAddressPhone := IncludeAddress AND IncludePhone;
	EXPORT BOOLEAN IncludeAddressProperty := IncludeAddress AND IncludeProperty;
	EXPORT BOOLEAN IncludeAddressPropertyEvent := IncludeAddressProperty AND IncludePropertyEvent;
	EXPORT BOOLEAN IncludeAddressUtility := IncludeAddress AND IncludeUtility;
	EXPORT BOOLEAN IncludeAddressVehicle := IncludeAddress AND IncludeVehicle;
	EXPORT BOOLEAN IncludeAircraftOwner := IncludeAircraft AND IncludePerson;	
	EXPORT BOOLEAN IncludeCriminalDetails := IncludeCriminalOffender AND IncludeCriminalOffense AND IncludeCriminalPunishment;
	EXPORT BOOLEAN IncludeDriversLicenseInquiry := IncludeDriversLicense AND IncludeInquiry;
	EXPORT BOOLEAN IncludeEducationStudentAddress := IncludeEducation AND IncludeAddress;
	EXPORT BOOLEAN IncludeEmailHousehold := IncludeHousehold AND IncludeEmail;
	EXPORT BOOLEAN IncludeEmailInquiry := IncludeInquiry AND IncludeEmail;
	EXPORT BOOLEAN IncludeEmploymentBusinessAddress := IncludeEmployment AND IncludeAddress;
	EXPORT BOOLEAN IncludeEmploymentPerson := IncludeEmployment AND IncludePerson;
	EXPORT BOOLEAN IncludeFirstDegreeAssociations := IncludePerson;
	EXPORT BOOLEAN IncludeHouseholdMember := IncludePerson;
	EXPORT BOOLEAN IncludeHouseholdPhone := IncludeHousehold AND IncludePhone;
	EXPORT BOOLEAN IncludeOffenderAddress := IncludeCriminalOffender AND IncludeAddress;
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
	EXPORT BOOLEAN IncludePersonPropertyEvent := IncludePersonProperty AND IncludePropertyEvent;
	EXPORT BOOLEAN IncludePersonSexOffender := IncludePerson AND IncludeSexOffender;
	EXPORT BOOLEAN IncludePersonSSN := IncludePerson AND IncludeSocialSecurityNumber;
	EXPORT BOOLEAN IncludePersonVehicle := IncludePerson AND IncludeVehicle;
	EXPORT BOOLEAN IncludePersonUCC := IncludePerson AND IncludeUCC;
	EXPORT BOOLEAN IncludePhoneInquiry := IncludePhone AND IncludeInquiry;
	EXPORT BOOLEAN IncludeProfessionalLicensePerson := IncludeProfessionalLicense AND IncludePerson;
	EXPORT BOOLEAN IncludeProxPhoneNumber := IncludeBusinessProx AND IncludePhone;
	EXPORT BOOLEAN IncludeProxAddress   := IncludeBusinessProx AND IncludeAddress;
	EXPORT BOOLEAN IncludeProxPerson  := IncludeBusinessProx AND IncludePerson;
	EXPORT BOOLEAN IncludeProxTIN := IncludeTIN AND IncludeBusinessProx;	
	EXPORT BOOLEAN IncludeProxUtility   := IncludeBusinessProx AND IncludeUtility;
	EXPORT BOOLEAN IncludeProxEmail   := IncludeBusinessProx AND IncludeEmail;
	EXPORT BOOLEAN IncludeSeleAddress := IncludeAddress AND IncludeBusinessSele;	
	EXPORT BOOLEAN IncludeSeleAircraft := IncludeAircraft AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleBankruptcy := IncludeBusinessSele AND IncludeBankruptcy;
	EXPORT BOOLEAN IncludeSeleEmail   := IncludeBusinessSele AND IncludeEmail;
	EXPORT BOOLEAN IncludeSeleEBRTradeline := IncludeEBRTradeline AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSelePerson := IncludePerson AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleProperty := IncludeProperty AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSelePropertyEvent := IncludeSeleProperty AND IncludePropertyEvent;
	EXPORT BOOLEAN IncludeSelePhoneNumber := IncludePhone AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleInquiry := IncludeInquiry AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleUCC := IncludeBusinessSele AND IncludeUCC;
	EXPORT BOOLEAN IncludeSeleTIN := IncludeBusinessSele AND IncludeTIN;
	EXPORT BOOLEAN IncludeSeleTradeline := IncludeBusinessSele AND IncludeTradeline;
	EXPORT BOOLEAN IncludeSeleUtility   := IncludeBusinessSele AND IncludeUtility;
	EXPORT BOOLEAN IncludeSeleWatercraft := IncludeWatercraft AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSeleVehicle := IncludeVehicle AND IncludeBusinessSele;
	EXPORT BOOLEAN IncludeSSNAddress := IncludeSocialSecurityNumber AND IncludeAddress;
	EXPORT BOOLEAN IncludeSSNInquiry := IncludeSocialSecurityNumber AND IncludeInquiry;
	EXPORT BOOLEAN IncludeSSNProperty := IncludeSocialSecurityNumber AND IncludeProperty;
	EXPORT BOOLEAN IncludeSSNPhone := IncludeSocialSecurityNumber AND IncludePhone;
	EXPORT BOOLEAN IncludeTINAddress := IncludeAddress AND IncludeTIN;
	EXPORT BOOLEAN IncludeTINInquiry := IncludeInquiry AND IncludeTIN;
	EXPORT BOOLEAN IncludeTINPhone := IncludePhone AND IncludeTIN;
	EXPORT BOOLEAN IncludeUtilityAddress := IncludeUtility AND IncludeAddress;
	EXPORT BOOLEAN IncludeUtilityPerson := IncludeUtility AND IncludePerson;
	EXPORT BOOLEAN IncludeUtilityPhone := IncludeUtility AND IncludePhone;
	EXPORT BOOLEAN IncludeWatercraftOwner := IncludeWatercraft AND IncludePerson;
	EXPORT BOOLEAN IncludeZipCodePerson := IncludeZipCode AND IncludePerson;
	EXPORT BOOLEAN IncludePersonLienJudgment := IncludePerson AND IncludeLienJudgment;
	EXPORT BOOLEAN IncludeSeleLienJudgment := IncludeBusinessSele AND IncludeLienJudgment;
 	EXPORT BOOLEAN IncludeSelePersonSurname := IncludeBusinessSele AND IncludeSurname AND IncludeSelePerson; 	
	EXPORT BOOLEAN IncludeProxPersonSurname := IncludeBusinessProx AND IncludeSurname AND IncludeProxPerson; 


END;	