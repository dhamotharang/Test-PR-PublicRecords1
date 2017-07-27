Import Healthcare_Shared;
export Fn_do_OneStepValidation := Module

	EXPORT compareResults2Configuration(string configName, dataset(Healthcare_Shared.Layouts.Verifications) serviceFlags) := Function
		configFlags := Healthcare_Shared.Fn_cfg_OneStep.getConfig(configName);
		cfg_Valid := configFlags[1].VerificationConfigurationStatus = Healthcare_Shared.Constants.ONE_STEP_PASS_GOOD_CONFIG;
		cfg_Name_Required := configFlags[1].NameVerified;
		cfg_Name_Match := configFlags[1].NameVerified = serviceFlags[1].NameVerified;
		cfg_Name_Pass := if(cfg_Name_Required = true,cfg_Name_Match,true);
		cfg_CompanyName_Required := configFlags[1].CompanyNameVerified;
		cfg_CompanyName_Match := configFlags[1].CompanyNameVerified = serviceFlags[1].CompanyNameVerified;
		cfg_CompanyName_Pass := if(cfg_CompanyName_Required = true,cfg_CompanyName_Match,true);
		cfg_Address_Required := configFlags[1].AddressVerified;
		cfg_Address_Match := configFlags[1].AddressVerified = serviceFlags[1].AddressVerified;
		cfg_Address_Pass := if(cfg_Address_Required = true,cfg_Address_Match,true);
		cfg_Phone_Required := configFlags[1].PhoneVerified;
		cfg_Phone_Match := configFlags[1].PhoneVerified = serviceFlags[1].PhoneVerified;
		cfg_Phone_Pass := if(cfg_Phone_Required = true,cfg_Phone_Match,true);
		cfg_SSN_Required := configFlags[1].SSNVerified;
		cfg_SSN_Match := configFlags[1].SSNVerified = serviceFlags[1].SSNVerified;
		cfg_SSN_Pass := if(cfg_SSN_Required = true,cfg_SSN_Match,true);
		cfg_FEIN_Required := configFlags[1].FEINVerified;
		cfg_FEIN_Match := configFlags[1].FEINVerified = serviceFlags[1].FEINVerified;
		cfg_FEIN_Pass := if(cfg_FEIN_Required = true,cfg_FEIN_Match,true);
		cfg_UPIN_Required := configFlags[1].UPINVerified;
		cfg_UPIN_Match := configFlags[1].UPINVerified = serviceFlags[1].UPINVerified;
		cfg_UPIN_Pass := if(cfg_UPIN_Required = true,cfg_UPIN_Match,true);
		cfg_UPINSupplied_Required := configFlags[1].UPINSuppliedExists;
		cfg_UPINSupplied_Match := configFlags[1].UPINSuppliedExists = serviceFlags[1].UPINSuppliedExists;
		cfg_UPINSupplied_Pass := if(cfg_UPINSupplied_Required = true,cfg_UPINSupplied_Match,true);
		cfg_NPISupplied_Required := configFlags[1].NPISuppliedExists;
		cfg_NPISupplied_Match := configFlags[1].NPISuppliedExists = serviceFlags[1].NPISuppliedExists;
		cfg_NPISupplied_Pass := if(cfg_NPISupplied_Required = true,cfg_NPISupplied_Match,true);
		cfg_NPIValid_Required := configFlags[1].NPIValid;
		cfg_NPIValid_Match := configFlags[1].NPIValid = serviceFlags[1].NPIValid;
		cfg_NPIValid_Pass := if(cfg_NPIValid_Required = true,cfg_NPIValid_Match,true);
		cfg_NPIVerified_Required := configFlags[1].NPIVerified;
		cfg_NPIVerified_Match := configFlags[1].NPIVerified = serviceFlags[1].NPIVerified;
		cfg_NPIVerified_Pass := if(cfg_NPIVerified_Required = true,cfg_NPIVerified_Match,true);
		cfg_CLIAValid_Required := configFlags[1].CLIAValid;
		cfg_CLIAValid_Match := configFlags[1].CLIAValid = serviceFlags[1].CLIAValid;
		cfg_CLIAValid_Pass := if(cfg_CLIAValid_Required = true,cfg_CLIAValid_Match,true);
		cfg_CLIAVerified_Required := configFlags[1].CLIAVerified;
		cfg_CLIAVerified_Match := configFlags[1].CLIAVerified = serviceFlags[1].CLIAVerified;
		cfg_CLIAVerified_Pass := if(cfg_CLIAVerified_Required = true,cfg_CLIAVerified_Match,true);
		cfg_DEAValid_Required := configFlags[1].DEAValid;
		cfg_DEAValid_Match := configFlags[1].DEAValid = serviceFlags[1].DEAValid;
		cfg_DEAValid_Pass := if(cfg_DEAValid_Required = true,cfg_DEAValid_Match,true);
		cfg_DEASupplied_Required := configFlags[1].DEASuppliedExists;
		cfg_DEASupplied_Match := configFlags[1].DEASuppliedExists = serviceFlags[1].DEASuppliedExists;
		cfg_DEASupplied_Pass := if(cfg_DEASupplied_Required = true,cfg_DEASupplied_Match,true);
		cfg_DEA2Valid_Required := configFlags[1].DEA2Valid;
		cfg_DEA2Valid_Match := configFlags[1].DEA2Valid = serviceFlags[1].DEA2Valid;
		cfg_DEA2Valid_Pass := if(cfg_DEA2Valid_Required = true,cfg_DEA2Valid_Match,true);
		cfg_DEA2Supplied_Required := configFlags[1].DEA2SuppliedExists;
		cfg_DEA2Supplied_Match := configFlags[1].DEA2SuppliedExists = serviceFlags[1].DEA2SuppliedExists;
		cfg_DEA2Supplied_Pass := if(cfg_DEA2Supplied_Required = true,cfg_DEA2Supplied_Match,true);
		cfg_DEAVerified_Required := configFlags[1].DEAVerified;
		cfg_DEAVerified_Match := configFlags[1].DEAVerified = serviceFlags[1].DEAVerified;
		cfg_DEAVerified_Pass := if(cfg_DEAVerified_Required = true,cfg_DEAVerified_Match,true);
		cfg_DEA2Verified_Required := configFlags[1].DEA2Verified;
		cfg_DEA2Verified_Match := configFlags[1].DEA2Verified = serviceFlags[1].DEA2Verified;
		cfg_DEA2Verified_Pass := if(cfg_DEA2Verified_Required = true,cfg_DEA2Verified_Match,true);
		cfg_NCPDPNumberVerified_Required := configFlags[1].NCPDPNumberVerified;
		cfg_NCPDPNumberVerified_Match := configFlags[1].NCPDPNumberVerified = serviceFlags[1].NCPDPNumberVerified;
		cfg_NCPDPNumberVerified_Pass := if(cfg_NCPDPNumberVerified_Required = true,cfg_NCPDPNumberVerified_Match,true);
		cfg_AnyLicenseValid_Required := configFlags[1].LicenseValid;
		cfg_AnyLicenseValid_Match := serviceFlags[1].LicenseValid or serviceFlags[1].License1Valid or serviceFlags[1].License2Valid or
																 serviceFlags[1].License3Valid or serviceFlags[1].License4Valid or
																 serviceFlags[1].License5Valid or serviceFlags[1].License6Valid or
																 serviceFlags[1].License7Valid or serviceFlags[1].License8Valid or
																 serviceFlags[1].License9Valid or serviceFlags[1].License10Valid;
		cfg_AnyLicenseValid_Pass := if(cfg_AnyLicenseValid_Required = true,cfg_AnyLicenseValid_Match,true);
		cfg_AnyLicenseVerified_Required := configFlags[1].LicenseVerified;
		cfg_AnyLicenseVerified_Match := serviceFlags[1].LicenseVerified or serviceFlags[1].License1Verified or serviceFlags[1].License2Verified or
																 serviceFlags[1].License3Verified or serviceFlags[1].License4Verified or
																 serviceFlags[1].License5Verified or serviceFlags[1].License6Verified or
																 serviceFlags[1].License7Verified or serviceFlags[1].License8Verified or
																 serviceFlags[1].License9Verified or serviceFlags[1].License10Verified;
		cfg_AnyLicenseVerified_Pass := if(cfg_AnyLicenseVerified_Required = true,cfg_AnyLicenseVerified_Match,true);
		cfg_License1Valid_Required := configFlags[1].License1Valid;
		cfg_License1Valid_Match := configFlags[1].License1Valid = serviceFlags[1].LicenseValid;
		cfg_License1Valid_Pass := if(cfg_License1Valid_Required = true,cfg_License1Valid_Match,true);
		cfg_License1Verified_Required := configFlags[1].License1Verified;
		cfg_License1Verified_Match := configFlags[1].License1Verified = serviceFlags[1].LicenseVerified;
		cfg_License1Verified_Pass := if(cfg_License1Verified_Required = true,cfg_License1Verified_Match,true);
		cfg_License1Supplied_Required := configFlags[1].License1SuppliedExists;
		cfg_License1Supplied_Match := configFlags[1].License1SuppliedExists = serviceFlags[1].License1SuppliedExists;
		cfg_License1Supplied_Pass := if(cfg_License1Supplied_Required = true,cfg_License1Supplied_Match,true);
		cfg_License2Valid_Required := configFlags[1].License2Valid;
		cfg_License2Valid_Match := configFlags[1].License2Valid = serviceFlags[1].License2Valid;
		cfg_License2Valid_Pass := if(cfg_License2Valid_Required = true,cfg_License2Valid_Match,true);
		cfg_License2Verified_Required := configFlags[1].License2Verified;
		cfg_License2Verified_Match := configFlags[1].License2Verified = serviceFlags[1].License2Verified;
		cfg_License2Verified_Pass := if(cfg_License2Verified_Required = true,cfg_License2Verified_Match,true);
		cfg_License3Valid_Required := configFlags[1].License3Valid;
		cfg_License3Valid_Match := configFlags[1].License3Valid = serviceFlags[1].License3Valid;
		cfg_License3Valid_Pass := if(cfg_License3Valid_Required = true,cfg_License3Valid_Match,true);
		cfg_License3Verified_Required := configFlags[1].License3Verified;
		cfg_License3Verified_Match := configFlags[1].License3Verified = serviceFlags[1].License3Verified;
		cfg_License3Verified_Pass := if(cfg_License3Verified_Required = true,cfg_License3Verified_Match,true);
		cfg_License4Valid_Required := configFlags[1].License4Valid;
		cfg_License4Valid_Match := configFlags[1].License4Valid = serviceFlags[1].License4Valid;
		cfg_License4Valid_Pass := if(cfg_License4Valid_Required = true,cfg_License4Valid_Match,true);
		cfg_License4Verified_Required := configFlags[1].License4Verified;
		cfg_License4Verified_Match := configFlags[1].License4Verified = serviceFlags[1].License4Verified;
		cfg_License4Verified_Pass := if(cfg_License4Verified_Required = true,cfg_License4Verified_Match,true);
		cfg_License5Valid_Required := configFlags[1].License5Valid;
		cfg_License5Valid_Match := configFlags[1].License5Valid = serviceFlags[1].License5Valid;
		cfg_License5Valid_Pass := if(cfg_License5Valid_Required = true,cfg_License5Valid_Match,true);
		cfg_License5Verified_Required := configFlags[1].License5Verified;
		cfg_License5Verified_Match := configFlags[1].License5Verified = serviceFlags[1].License5Verified;
		cfg_License5Verified_Pass := if(cfg_License5Verified_Required = true,cfg_License5Verified_Match,true);
		cfg_License6Valid_Required := configFlags[1].License6Valid;
		cfg_License6Valid_Match := configFlags[1].License6Valid = serviceFlags[1].License6Valid;
		cfg_License6Valid_Pass := if(cfg_License6Valid_Required = true,cfg_License6Valid_Match,true);
		cfg_License6Verified_Required := configFlags[1].License6Verified;
		cfg_License6Verified_Match := configFlags[1].License6Verified = serviceFlags[1].License6Verified;
		cfg_License6Verified_Pass := if(cfg_License6Verified_Required = true,cfg_License6Verified_Match,true);
		cfg_License7Valid_Required := configFlags[1].License7Valid;
		cfg_License7Valid_Match := configFlags[1].License7Valid = serviceFlags[1].License7Valid;
		cfg_License7Valid_Pass := if(cfg_License7Valid_Required = true,cfg_License7Valid_Match,true);
		cfg_License7Verified_Required := configFlags[1].License7Verified;
		cfg_License7Verified_Match := configFlags[1].License7Verified = serviceFlags[1].License7Verified;
		cfg_License7Verified_Pass := if(cfg_License7Verified_Required = true,cfg_License7Verified_Match,true);
		cfg_License8Valid_Required := configFlags[1].License8Valid;
		cfg_License8Valid_Match := configFlags[1].License8Valid = serviceFlags[1].License8Valid;
		cfg_License8Valid_Pass := if(cfg_License8Valid_Required = true,cfg_License8Valid_Match,true);
		cfg_License8Verified_Required := configFlags[1].License8Verified;
		cfg_License8Verified_Match := configFlags[1].License8Verified = serviceFlags[1].License8Verified;
		cfg_License8Verified_Pass := if(cfg_License8Verified_Required = true,cfg_License8Verified_Match,true);
		cfg_License9Valid_Required := configFlags[1].License9Valid;
		cfg_License9Valid_Match := configFlags[1].License9Valid = serviceFlags[1].License9Valid;
		cfg_License9Valid_Pass := if(cfg_License9Valid_Required = true,cfg_License9Valid_Match,true);
		cfg_License9Verified_Required := configFlags[1].License9Verified;
		cfg_License9Verified_Match := configFlags[1].License9Verified = serviceFlags[1].License9Verified;
		cfg_License9Verified_Pass := if(cfg_License9Verified_Required = true,cfg_License9Verified_Match,true);
		cfg_License10Valid_Required := configFlags[1].License10Valid;
		cfg_License10Valid_Match := configFlags[1].License10Valid = serviceFlags[1].License10Valid;
		cfg_License10Valid_Pass := if(cfg_License10Valid_Required = true,cfg_License10Valid_Match,true);
		cfg_License10Verified_Required := configFlags[1].License10Verified;
		cfg_License10Verified_Match := configFlags[1].License10Verified = serviceFlags[1].License10Verified;
		cfg_License10Verified_Pass := if(cfg_License10Verified_Required = true,cfg_License10Verified_Match,true);
		cfg_AnyTaxonomyVerified_Required := configFlags[1].TaxonomyVerified;
		cfg_AnyTaxonomyVerified_Match := serviceFlags[1].TaxonomyVerified or serviceFlags[1].Taxonomy1Verified or serviceFlags[1].Taxonomy2Verified or
																 serviceFlags[1].Taxonomy3Verified or serviceFlags[1].Taxonomy4Verified or
																 serviceFlags[1].Taxonomy5Verified;
		cfg_AnyTaxonomyVerified_Pass := if(cfg_AnyTaxonomyVerified_Required = true,cfg_AnyTaxonomyVerified_Match,true);
		cfg_Taxonomy1Verified_Required := configFlags[1].Taxonomy1Verified;
		cfg_Taxonomy1Verified_Match := configFlags[1].Taxonomy1Verified = serviceFlags[1].Taxonomy1Verified;
		cfg_Taxonomy1Verified_Pass := if(cfg_Taxonomy1Verified_Required = true,cfg_Taxonomy1Verified_Match,true);
		cfg_Taxonomy2Verified_Required := configFlags[1].Taxonomy2Verified;
		cfg_Taxonomy2Verified_Match := configFlags[1].Taxonomy2Verified = serviceFlags[1].Taxonomy2Verified;
		cfg_Taxonomy2Verified_Pass := if(cfg_Taxonomy2Verified_Required = true,cfg_Taxonomy2Verified_Match,true);
		cfg_Taxonomy3Verified_Required := configFlags[1].Taxonomy3Verified;
		cfg_Taxonomy3Verified_Match := configFlags[1].Taxonomy3Verified = serviceFlags[1].Taxonomy3Verified;
		cfg_Taxonomy3Verified_Pass := if(cfg_Taxonomy3Verified_Required = true,cfg_Taxonomy3Verified_Match,true);
		cfg_Taxonomy4Verified_Required := configFlags[1].Taxonomy4Verified;
		cfg_Taxonomy4Verified_Match := configFlags[1].Taxonomy4Verified = serviceFlags[1].Taxonomy4Verified;
		cfg_Taxonomy4Verified_Pass := if(cfg_Taxonomy4Verified_Required = true,cfg_Taxonomy4Verified_Match,true);
		cfg_Taxonomy5Verified_Required := configFlags[1].Taxonomy5Verified;
		cfg_Taxonomy5Verified_Match := configFlags[1].Taxonomy5Verified = serviceFlags[1].Taxonomy5Verified;
		cfg_Taxonomy5Verified_Pass := if(cfg_Taxonomy5Verified_Required = true,cfg_Taxonomy5Verified_Match,true);
		cfg_MedicalSchoolNameVerified_Required := configFlags[1].MedicalSchoolNameVerified;
		cfg_MedicalSchoolNameVerified_Match := configFlags[1].MedicalSchoolNameVerified = serviceFlags[1].MedicalSchoolNameVerified;
		cfg_MedicalSchoolNameVerified_Pass := if(cfg_MedicalSchoolNameVerified_Required = true,cfg_MedicalSchoolNameVerified_Match,true);
		cfg_GraduationYearVerified_Required := configFlags[1].GraduationYearVerified;
		cfg_GraduationYearVerified_Match := configFlags[1].GraduationYearVerified = serviceFlags[1].GraduationYearVerified;
		cfg_GraduationYearVerified_Pass := if(cfg_GraduationYearVerified_Required = true,cfg_GraduationYearVerified_Match,true);
		cfg_BoardCertifiedSpecialtyValid_Required := configFlags[1].BoardCertifiedSpecialtyValid;
		cfg_BoardCertifiedSpecialtyValid_Match := serviceFlags[1].BoardCertifiedSpecialtyValid or serviceFlags[1].BoardCertifiedSpecialty1Valid or
																							serviceFlags[1].BoardCertifiedSpecialty2Valid or serviceFlags[1].BoardCertifiedSpecialty3Valid or		
																							serviceFlags[1].BoardCertifiedSpecialty4Valid or serviceFlags[1].BoardCertifiedSpecialty5Valid;
		cfg_BoardCertifiedSpecialtyValid_Pass := if(cfg_BoardCertifiedSpecialtyValid_Required = true,cfg_BoardCertifiedSpecialtyValid_Match,true);
		cfg_BoardCertifiedSpecialtyVerified_Required := configFlags[1].BoardCertifiedSpecialtyVerified;
		cfg_BoardCertifiedSpecialtyVerified_Match := serviceFlags[1].BoardCertifiedSpecialtyVerified or serviceFlags[1].BoardCertifiedSpecialty1Verified or
																								 serviceFlags[1].BoardCertifiedSpecialty2Verified or serviceFlags[1].BoardCertifiedSpecialty3Verified or
																								 serviceFlags[1].BoardCertifiedSpecialty4Verified or serviceFlags[1].BoardCertifiedSpecialty5Verified;
		cfg_BoardCertifiedSpecialtyVerified_Pass := if(cfg_BoardCertifiedSpecialtyVerified_Required = true,cfg_BoardCertifiedSpecialtyVerified_Match,true);

		cfg_BoardCertifiedSubSpecialtyValid_Required := configFlags[1].BoardCertifiedSubSpecialtyValid;
		cfg_BoardCertifiedSubSpecialtyValid_Match := serviceFlags[1].BoardCertifiedSubSpecialtyValid or serviceFlags[1].BoardCertifiedSubSpecialty1Valid or
																								 serviceFlags[1].BoardCertifiedSubSpecialty2Valid or serviceFlags[1].BoardCertifiedSubSpecialty3Valid or
																								 serviceFlags[1].BoardCertifiedSubSpecialty4Valid or serviceFlags[1].BoardCertifiedSubSpecialty5Valid;
		cfg_BoardCertifiedSubSpecialtyValid_Pass := if(cfg_BoardCertifiedSubSpecialtyValid_Required = true,cfg_BoardCertifiedSubSpecialtyValid_Match,true);
		cfg_BoardCertifiedSubSpecialtyVerified_Required := configFlags[1].BoardCertifiedSubSpecialtyVerified;
		cfg_BoardCertifiedSubSpecialtyVerified_Match := serviceFlags[1].BoardCertifiedSubSpecialtyVerified or serviceFlags[1].BoardCertifiedSubSpecialty1Verified or
																										serviceFlags[1].BoardCertifiedSubSpecialty2Verified or serviceFlags[1].BoardCertifiedSubSpecialty3Verified or
																										serviceFlags[1].BoardCertifiedSubSpecialty4Verified or serviceFlags[1].BoardCertifiedSubSpecialty5Verified;
		cfg_BoardCertifiedSubSpecialtyVerified_Pass := if(cfg_BoardCertifiedSubSpecialtyVerified_Required = true,cfg_BoardCertifiedSubSpecialtyVerified_Match,true);
		cfg_BoardCertifiedSpecialty1Valid_Required := configFlags[1].BoardCertifiedSpecialty1Valid;
		cfg_BoardCertifiedSpecialty1Valid_Match := configFlags[1].BoardCertifiedSpecialty1Valid = serviceFlags[1].BoardCertifiedSpecialty1Valid;
		cfg_BoardCertifiedSpecialty1Valid_Pass := if(cfg_BoardCertifiedSpecialty1Valid_Required = true,cfg_BoardCertifiedSpecialty1Valid_Match,true);
		cfg_BoardCertifiedSpecialty1Verified_Required := configFlags[1].BoardCertifiedSpecialty1Verified;
		cfg_BoardCertifiedSpecialty1Verified_Match := configFlags[1].BoardCertifiedSpecialty1Verified = serviceFlags[1].BoardCertifiedSpecialty1Verified;
		cfg_BoardCertifiedSpecialty1Verified_Pass := if(cfg_BoardCertifiedSpecialty1Verified_Required = true,cfg_BoardCertifiedSpecialty1Verified_Match,true);
		cfg_BoardCertifiedSubSpecialty1Valid_Required := configFlags[1].BoardCertifiedSubSpecialty1Valid;
		cfg_BoardCertifiedSubSpecialty1Valid_Match := configFlags[1].BoardCertifiedSubSpecialty1Valid = serviceFlags[1].BoardCertifiedSubSpecialty1Valid;
		cfg_BoardCertifiedSubSpecialty1Valid_Pass := if(cfg_BoardCertifiedSubSpecialty1Valid_Required = true,cfg_BoardCertifiedSubSpecialty1Valid_Match,true);
		cfg_BoardCertifiedSubSpecialty1Verified_Required := configFlags[1].BoardCertifiedSubSpecialty1Verified;
		cfg_BoardCertifiedSubSpecialty1Verified_Match := configFlags[1].BoardCertifiedSubSpecialty1Verified = serviceFlags[1].BoardCertifiedSubSpecialty1Verified;
		cfg_BoardCertifiedSubSpecialty1Verified_Pass := if(cfg_BoardCertifiedSubSpecialty1Verified_Required = true,cfg_BoardCertifiedSubSpecialty1Verified_Match,true);
		cfg_BoardCertifiedSpecialty2Valid_Required := configFlags[1].BoardCertifiedSpecialty2Valid;
		cfg_BoardCertifiedSpecialty2Valid_Match := configFlags[1].BoardCertifiedSpecialty2Valid = serviceFlags[1].BoardCertifiedSpecialty2Valid;
		cfg_BoardCertifiedSpecialty2Valid_Pass := if(cfg_BoardCertifiedSpecialty2Valid_Required = true,cfg_BoardCertifiedSpecialty2Valid_Match,true);
		cfg_BoardCertifiedSpecialty2Verified_Required := configFlags[1].BoardCertifiedSpecialty2Verified;
		cfg_BoardCertifiedSpecialty2Verified_Match := configFlags[1].BoardCertifiedSpecialty2Verified = serviceFlags[1].BoardCertifiedSpecialty2Verified;
		cfg_BoardCertifiedSpecialty2Verified_Pass := if(cfg_BoardCertifiedSpecialty2Verified_Required = true,cfg_BoardCertifiedSpecialty2Verified_Match,true);
		cfg_BoardCertifiedSubSpecialty2Valid_Required := configFlags[1].BoardCertifiedSubSpecialty2Valid;
		cfg_BoardCertifiedSubSpecialty2Valid_Match := configFlags[1].BoardCertifiedSubSpecialty2Valid = serviceFlags[1].BoardCertifiedSubSpecialty2Valid;
		cfg_BoardCertifiedSubSpecialty2Valid_Pass := if(cfg_BoardCertifiedSubSpecialty2Valid_Required = true,cfg_BoardCertifiedSubSpecialty2Valid_Match,true);
		cfg_BoardCertifiedSubSpecialty2Verified_Required := configFlags[1].BoardCertifiedSubSpecialty2Verified;
		cfg_BoardCertifiedSubSpecialty2Verified_Match := configFlags[1].BoardCertifiedSubSpecialty2Verified = serviceFlags[1].BoardCertifiedSubSpecialty2Verified;
		cfg_BoardCertifiedSubSpecialty2Verified_Pass := if(cfg_BoardCertifiedSubSpecialty2Verified_Required = true,cfg_BoardCertifiedSubSpecialty2Verified_Match,true);
		cfg_BoardCertifiedSpecialty3Valid_Required := configFlags[1].BoardCertifiedSpecialty3Valid;
		cfg_BoardCertifiedSpecialty3Valid_Match := configFlags[1].BoardCertifiedSpecialty3Valid = serviceFlags[1].BoardCertifiedSpecialty3Valid;
		cfg_BoardCertifiedSpecialty3Valid_Pass := if(cfg_BoardCertifiedSpecialty3Valid_Required = true,cfg_BoardCertifiedSpecialty3Valid_Match,true);
		cfg_BoardCertifiedSpecialty3Verified_Required := configFlags[1].BoardCertifiedSpecialty3Verified;
		cfg_BoardCertifiedSpecialty3Verified_Match := configFlags[1].BoardCertifiedSpecialty3Verified = serviceFlags[1].BoardCertifiedSpecialty3Verified;
		cfg_BoardCertifiedSpecialty3Verified_Pass := if(cfg_BoardCertifiedSpecialty3Verified_Required = true,cfg_BoardCertifiedSpecialty3Verified_Match,true);
		cfg_BoardCertifiedSubSpecialty3Valid_Required := configFlags[1].BoardCertifiedSubSpecialty3Valid;
		cfg_BoardCertifiedSubSpecialty3Valid_Match := configFlags[1].BoardCertifiedSubSpecialty3Valid = serviceFlags[1].BoardCertifiedSubSpecialty3Valid;
		cfg_BoardCertifiedSubSpecialty3Valid_Pass := if(cfg_BoardCertifiedSubSpecialty3Valid_Required = true,cfg_BoardCertifiedSubSpecialty3Valid_Match,true);
		cfg_BoardCertifiedSubSpecialty3Verified_Required := configFlags[1].BoardCertifiedSubSpecialty3Verified;
		cfg_BoardCertifiedSubSpecialty3Verified_Match := configFlags[1].BoardCertifiedSubSpecialty3Verified = serviceFlags[1].BoardCertifiedSubSpecialty3Verified;
		cfg_BoardCertifiedSubSpecialty3Verified_Pass := if(cfg_BoardCertifiedSubSpecialty3Verified_Required = true,cfg_BoardCertifiedSubSpecialty3Verified_Match,true);
		cfg_BoardCertifiedSpecialty4Valid_Required := configFlags[1].BoardCertifiedSpecialty4Valid;
		cfg_BoardCertifiedSpecialty4Valid_Match := configFlags[1].BoardCertifiedSpecialty4Valid = serviceFlags[1].BoardCertifiedSpecialty4Valid;
		cfg_BoardCertifiedSpecialty4Valid_Pass := if(cfg_BoardCertifiedSpecialty4Valid_Required = true,cfg_BoardCertifiedSpecialty4Valid_Match,true);
		cfg_BoardCertifiedSpecialty4Verified_Required := configFlags[1].BoardCertifiedSpecialty4Verified;
		cfg_BoardCertifiedSpecialty4Verified_Match := configFlags[1].BoardCertifiedSpecialty4Verified = serviceFlags[1].BoardCertifiedSpecialty4Verified;
		cfg_BoardCertifiedSpecialty4Verified_Pass := if(cfg_BoardCertifiedSpecialty4Verified_Required = true,cfg_BoardCertifiedSpecialty4Verified_Match,true);
		cfg_BoardCertifiedSubSpecialty4Valid_Required := configFlags[1].BoardCertifiedSubSpecialty4Valid;
		cfg_BoardCertifiedSubSpecialty4Valid_Match := configFlags[1].BoardCertifiedSubSpecialty4Valid = serviceFlags[1].BoardCertifiedSubSpecialty4Valid;
		cfg_BoardCertifiedSubSpecialty4Valid_Pass := if(cfg_BoardCertifiedSubSpecialty4Valid_Required = true,cfg_BoardCertifiedSubSpecialty4Valid_Match,true);
		cfg_BoardCertifiedSubSpecialty4Verified_Required := configFlags[1].BoardCertifiedSubSpecialty4Verified;
		cfg_BoardCertifiedSubSpecialty4Verified_Match := configFlags[1].BoardCertifiedSubSpecialty4Verified = serviceFlags[1].BoardCertifiedSubSpecialty4Verified;
		cfg_BoardCertifiedSubSpecialty4Verified_Pass := if(cfg_BoardCertifiedSubSpecialty4Verified_Required = true,cfg_BoardCertifiedSubSpecialty4Verified_Match,true);
		cfg_BoardCertifiedSpecialty5Valid_Required := configFlags[1].BoardCertifiedSpecialty5Valid;
		cfg_BoardCertifiedSpecialty5Valid_Match := configFlags[1].BoardCertifiedSpecialty5Valid = serviceFlags[1].BoardCertifiedSpecialty5Valid;
		cfg_BoardCertifiedSpecialty5Valid_Pass := if(cfg_BoardCertifiedSpecialty5Valid_Required = true,cfg_BoardCertifiedSpecialty5Valid_Match,true);
		cfg_BoardCertifiedSpecialty5Verified_Required := configFlags[1].BoardCertifiedSpecialty5Verified;
		cfg_BoardCertifiedSpecialty5Verified_Match := configFlags[1].BoardCertifiedSpecialty5Verified = serviceFlags[1].BoardCertifiedSpecialty5Verified;
		cfg_BoardCertifiedSpecialty5Verified_Pass := if(cfg_BoardCertifiedSpecialty5Verified_Required = true,cfg_BoardCertifiedSpecialty5Verified_Match,true);
		cfg_BoardCertifiedSubSpecialty5Valid_Required := configFlags[1].BoardCertifiedSubSpecialty5Valid;
		cfg_BoardCertifiedSubSpecialty5Valid_Match := configFlags[1].BoardCertifiedSubSpecialty5Valid = serviceFlags[1].BoardCertifiedSubSpecialty5Valid;
		cfg_BoardCertifiedSubSpecialty5Valid_Pass := if(cfg_BoardCertifiedSubSpecialty5Valid_Required = true,cfg_BoardCertifiedSubSpecialty5Valid_Match,true);
		cfg_BoardCertifiedSubSpecialty5Verified_Required := configFlags[1].BoardCertifiedSubSpecialty5Verified;
		cfg_BoardCertifiedSubSpecialty5Verified_Match := configFlags[1].BoardCertifiedSubSpecialty5Verified = serviceFlags[1].BoardCertifiedSubSpecialty5Verified;
		cfg_BoardCertifiedSubSpecialty5Verified_Pass := if(cfg_BoardCertifiedSubSpecialty5Verified_Required = true,cfg_BoardCertifiedSubSpecialty5Verified_Match,true);
		cfg_isAliveNoSanc_Required := configFlags[1].isAliveNoSanc;
		cfg_isAliveNoSanc_Match := configFlags[1].isAliveNoSanc = serviceFlags[1].isAliveNoSanc;
		cfg_isAliveNoSanc_Pass := if(cfg_isAliveNoSanc_Required = true,cfg_isAliveNoSanc_Match,true);
		cfg_isDead_Required := configFlags[1].isDead;
		cfg_isDead_Match := configFlags[1].isDead = serviceFlags[1].isDead;
		cfg_isDead_Pass := if(cfg_isDead_Required = true,cfg_isDead_Match,true);
		cfg_hasSanctions_Required := configFlags[1].hasSanctions;
		cfg_hasSanctions_Match := configFlags[1].hasSanctions = serviceFlags[1].hasSanctions;
		cfg_hasSanctions_Pass := if(cfg_hasSanctions_Required = true,cfg_hasSanctions_Match,true);
		cfg_hasEPLSSanctions_Required := configFlags[1].hasEPLSSanctions;
		cfg_hasEPLSSanctions_Match := configFlags[1].hasEPLSSanctions = serviceFlags[1].hasEPLSSanctions;
		cfg_hasEPLSSanctions_Pass := if(cfg_hasEPLSSanctions_Required = true,cfg_hasEPLSSanctions_Match,true);
		cfg_hasLEIESanctions_Required := configFlags[1].hasLEIESanctions;
		cfg_hasLEIESanctions_Match := configFlags[1].hasLEIESanctions = serviceFlags[1].hasLEIESanctions;
		cfg_hasLEIESanctions_Pass := if(cfg_hasLEIESanctions_Required = true,cfg_hasLEIESanctions_Match,true);
		cfg_hasDisciplinarySanctions_Required := configFlags[1].hasDisciplinarySanctions;
		cfg_hasDisciplinarySanctions_Match := configFlags[1].hasDisciplinarySanctions = serviceFlags[1].hasDisciplinarySanctions;
		cfg_hasDisciplinarySanctions_Pass := if(cfg_hasDisciplinarySanctions_Required = true,cfg_hasDisciplinarySanctions_Match,true);

		OneStepOutcome:= cfg_Valid and cfg_Name_Pass and cfg_CompanyName_Pass and cfg_Address_Pass and cfg_Phone_Pass and 
									cfg_SSN_Pass and cfg_FEIN_Pass and cfg_UPIN_Pass and cfg_UPINSupplied_Pass and cfg_NPISupplied_Pass and cfg_NPIValid_Pass and 
									cfg_NPIVerified_Pass and cfg_CLIAValid_Pass and cfg_CLIAVerified_Pass and cfg_DEAValid_Pass and cfg_DEA2Valid_Pass and 
									cfg_DEAVerified_Pass and cfg_DEASupplied_Pass and cfg_DEA2Verified_Pass and cfg_DEA2Supplied_Pass and 
									cfg_NCPDPNumberVerified_Pass and cfg_AnyLicenseValid_Pass and cfg_AnyLicenseVerified_Pass and 
									cfg_License1Valid_Pass and cfg_License1Verified_Pass and cfg_License1Supplied_Pass and
									cfg_License2Valid_Pass and cfg_License2Verified_Pass and 
									cfg_License3Valid_Pass and cfg_License3Verified_Pass and 
									cfg_License4Valid_Pass and cfg_License4Verified_Pass and 
									cfg_License5Valid_Pass and cfg_License5Verified_Pass and 
									cfg_License6Valid_Pass and cfg_License6Verified_Pass and 
									cfg_License7Valid_Pass and cfg_License7Verified_Pass and 
									cfg_License8Valid_Pass and cfg_License8Verified_Pass and 
									cfg_License9Valid_Pass and cfg_License9Verified_Pass and 
									cfg_License10Valid_Pass and cfg_License10Verified_Pass and 
									cfg_AnyTaxonomyVerified_Pass and cfg_Taxonomy1Verified_Pass and cfg_Taxonomy2Verified_Pass and 
									cfg_Taxonomy3Verified_Pass and cfg_Taxonomy4Verified_Pass and cfg_Taxonomy5Verified_Pass and 
									cfg_MedicalSchoolNameVerified_Pass and cfg_GraduationYearVerified_Pass and
									cfg_BoardCertifiedSpecialtyVerified_Pass and cfg_BoardCertifiedSubSpecialtyVerified_Pass and 
									cfg_BoardCertifiedSpecialty1Verified_Pass and cfg_BoardCertifiedSubSpecialty1Verified_Pass and 
									cfg_BoardCertifiedSpecialty2Verified_Pass and cfg_BoardCertifiedSubSpecialty2Verified_Pass and 
									cfg_BoardCertifiedSpecialty3Verified_Pass and cfg_BoardCertifiedSubSpecialty3Verified_Pass and 
									cfg_BoardCertifiedSpecialty4Verified_Pass and cfg_BoardCertifiedSubSpecialty4Verified_Pass and 
									cfg_BoardCertifiedSpecialty5Verified_Pass and cfg_BoardCertifiedSubSpecialty5Verified_Pass and
									cfg_isAliveNoSanc_Pass and cfg_isDead_Pass and cfg_hasSanctions_Pass and 
									cfg_hasEPLSSanctions_Pass and cfg_hasLEIESanctions_Pass and cfg_hasDisciplinarySanctions_Pass;
		// output(configName,Named('configName'));
		// output(serviceFlags,Named('serviceFlags'));
		// output(configFlags,Named('configFlags'));
		// output(cfg_Valid,Named('cfg_Valid'));
		// output(cfg_Name_Pass,Named('cfg_Name_Pass'));
		// output(cfg_CompanyName_Pass,Named('cfg_CompanyName_Pass'));
		// output(cfg_Address_Pass,Named('cfg_Address_Pass'));
		// output(cfg_Phone_Pass,Named('cfg_Phone_Pass'));
		// output(cfg_SSN_Pass,Named('cfg_SSN_Pass'));
		// output(cfg_FEIN_Pass,Named('cfg_FEIN_Pass'));
		// output(cfg_UPIN_Pass,Named('cfg_UPIN_Pass'));
		// output(cfg_NPISupplied_Pass,Named('cfg_NPISupplied_Pass'));
		// output(cfg_NPIValid_Pass,Named('cfg_NPIValid_Pass'));
		// output(cfg_NPIVerified_Pass,Named('cfg_NPIVerified_Pass'));
		// output(cfg_CLIAValid_Pass,Named('cfg_CLIAValid_Pass'));
		// output(cfg_CLIAVerified_Pass,Named('cfg_CLIAVerified_Pass'));
		// output(cfg_DEAValid_Pass,Named('cfg_DEAValid_Pass'));
		// output(cfg_DEA2Valid_Pass,Named('cfg_DEA2Valid_Pass'));
		// output(cfg_DEAVerified_Pass,Named('cfg_DEAVerified_Pass'));
		// output(cfg_DEA2Verified_Pass,Named('cfg_DEA2Verified_Pass'));
		// output(cfg_NCPDPNumberVerified_Pass,Named('cfg_NCPDPNumberVerified_Pass'));
		// output(cfg_AnyLicenseValid_Pass,Named('cfg_AnyLicenseValid_Pass'));
		// output(cfg_AnyLicenseVerified_Pass,Named('cfg_AnyLicenseVerified_Pass'));
		// output(cfg_License1Valid_Pass,Named('cfg_License1Valid_Pass'));
		// output(cfg_License1Verified_Pass,Named('cfg_License1Verified_Pass'));
		// output(cfg_License2Valid_Pass,Named('cfg_License2Valid_Pass'));
		// output(cfg_License2Verified_Pass,Named('cfg_License2Verified_Pass'));
		// output(cfg_License3Valid_Pass,Named('cfg_License3Valid_Pass'));
		// output(cfg_License3Verified_Pass,Named('cfg_License3Verified_Pass'));
		// output(cfg_License4Valid_Pass,Named('cfg_License4Valid_Pass'));
		// output(cfg_License4Verified_Pass,Named('cfg_License4Verified_Pass'));
		// output(cfg_License5Valid_Pass,Named('cfg_License5Valid_Pass'));
		// output(cfg_License5Verified_Pass,Named('cfg_License5Verified_Pass'));
		// output(cfg_License6Valid_Pass,Named('cfg_License6Valid_Pass'));
		// output(cfg_License6Verified_Pass,Named('cfg_License6Verified_Pass'));
		// output(cfg_License7Valid_Pass,Named('cfg_License7Valid_Pass'));
		// output(cfg_License7Verified_Pass,Named('cfg_License7Verified_Pass'));
		// output(cfg_License8Valid_Pass,Named('cfg_License8Valid_Pass'));
		// output(cfg_License8Verified_Pass,Named('cfg_License8Verified_Pass'));
		// output(cfg_License9Valid_Pass,Named('cfg_License9Valid_Pass'));
		// output(cfg_License9Verified_Pass,Named('cfg_License9Verified_Pass'));
		// output(cfg_License10Valid_Pass,Named('cfg_License10Valid_Pass'));
		// output(cfg_License10Verified_Pass,Named('cfg_License10Verified_Pass'));
		// output(cfg_AnyTaxonomyVerified_Pass,Named('cfg_AnyTaxonomyVerified_Pass'));
		// output(cfg_Taxonomy1Verified_Pass,Named('cfg_Taxonomy1Verified_Pass'));
		// output(cfg_Taxonomy2Verified_Pass,Named('cfg_Taxonomy2Verified_Pass'));
		// output(cfg_Taxonomy3Verified_Pass,Named('cfg_Taxonomy3Verified_Pass'));
		// output(cfg_Taxonomy4Verified_Pass,Named('cfg_Taxonomy4Verified_Pass'));
		// output(cfg_Taxonomy5Verified_Pass,Named('cfg_Taxonomy5Verified_Pass'));
		// output(cfg_MedicalSchoolNameVerified_Pass,Named('cfg_MedicalSchoolNameVerified_Pass'));
		// output(cfg_GraduationYearVerified_Pass,Named('cfg_GraduationYearVerified_Pass'));
		// output(cfg_BoardCertifiedSpecialtyVerified_Pass,Named('cfg_BoardCertifiedSpecialtyVerified_Pass'));
		// output(cfg_BoardCertifiedSubSpecialtyVerified_Pass,Named('cfg_BoardCertifiedSubSpecialtyVerified_Pass'));
		// output(cfg_BoardCertifiedSpecialty1Verified_Pass,Named('cfg_BoardCertifiedSpecialty1Verified_Pass'));
		// output(cfg_BoardCertifiedSubSpecialty1Verified_Pass,Named('cfg_BoardCertifiedSubSpecialty1Verified_Pass'));
		// output(cfg_BoardCertifiedSpecialty2Verified_Pass,Named('cfg_BoardCertifiedSpecialty2Verified_Pass'));
		// output(cfg_BoardCertifiedSubSpecialty2Verified_Pass,Named('cfg_BoardCertifiedSubSpecialty2Verified_Pass'));
		// output(cfg_BoardCertifiedSpecialty3Verified_Pass,Named('cfg_BoardCertifiedSpecialty3Verified_Pass'));
		// output(cfg_BoardCertifiedSubSpecialty3Verified_Pass,Named('cfg_BoardCertifiedSubSpecialty3Verified_Pass'));
		// output(cfg_BoardCertifiedSpecialty4Verified_Pass,Named('cfg_BoardCertifiedSpecialty4Verified_Pass'));
		// output(cfg_BoardCertifiedSubSpecialty4Verified_Pass,Named('cfg_BoardCertifiedSubSpecialty4Verified_Pass'));
		// output(cfg_BoardCertifiedSpecialty5Verified_Pass,Named('cfg_BoardCertifiedSpecialty5Verified_Pass'));
		// output(cfg_BoardCertifiedSubSpecialty5Verified_Pass,Named('cfg_BoardCertifiedSubSpecialty5Verified_Pass'));
		ds_results := project(serviceFlags, transform(Healthcare_Shared.Layouts.Verifications, 
																									self.VerificationConfigurationStatus := configFlags[1].VerificationConfigurationStatus; 
																									self.VerificationConfigurationOutcome := OneStepOutcome;
																									self := left));
		return ds_results;
	END;

End;