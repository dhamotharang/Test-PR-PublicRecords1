EXPORT Functions_OneStepPass_Configuration := Module


	Export ConfigurationVerificationFlags := RECORD
		Healthcare_Provider_Services.layouts.Verifications;
	END;
	set of string validConfigNames := ['NAMEADDR','NAMELIC','DEFAULT']; 
	set of string NameVerified := ['NAMEADDR','NAMELIC']; 
	set of string CompanyNameVerified := []; 
	set of string AddressVerified := ['NAMEADDR']; 
	set of string PhoneVerified := []; 
	set of string SSNVerified := ['DEFAULT']; 
	set of string FEINVerified := []; 
	set of string UPINVerified := []; 
	set of string NPISuppliedExists := []; 
	set of string NPIValid := ['DEFAULT']; 
	set of string NPIVerified := ['DEFAULT']; 
	set of string CLIAValid := []; 
	set of string CLIAVerified := []; 
	set of string DEAValid := []; 
	set of string DEA2Valid := []; 
	set of string DEAVerified := []; 
	set of string DEA2Verified := []; 
	set of string AnyLicenseValid := ['NAMELIC','DEFAULT']; 
	set of string AnyLicenseVerified := ['DEFAULT']; 
	set of string License1Valid := []; 
	set of string License1Verified := []; 
	set of string License2Valid := []; 
	set of string License2Verified := []; 
	set of string License3Valid := []; 
	set of string License3Verified := []; 
	set of string License4Valid := []; 
	set of string License4Verified := []; 
	set of string License5Valid := []; 
	set of string License5Verified := []; 
	set of string License6Valid := []; 
	set of string License6Verified := []; 
	set of string License7Valid := []; 
	set of string License7Verified := []; 
	set of string License8Valid := []; 
	set of string License8Verified := []; 
	set of string License9Valid := []; 
	set of string License9Verified := []; 
	set of string License10Valid := []; 
	set of string License10Verified := []; 
	set of string AnyTaxonomyVerified := []; 
	set of string Taxonomy1Verified := []; 
	set of string Taxonomy2Verified := []; 
	set of string Taxonomy3Verified := []; 
	set of string Taxonomy4Verified := []; 
	set of string Taxonomy5Verified := []; 
	set of string MedicalSchoolNameVerified := []; 
	set of string GraduationYearVerified := []; 
	set of string AnyBoardCertifiedSpecialtyVerified := []; 
	set of string AnyBoardCertifiedSpecialtyValid := []; 
	set of string AnyBoardCertifiedSubSpecialtyVerified := []; 
	set of string AnyBoardCertifiedSubSpecialtyValid := []; 
	set of string BoardCertifiedSpecialty1Verified := []; 
	set of string BoardCertifiedSpecialty1Valid := []; 
	set of string BoardCertifiedSubSpecialty1Verified := []; 
	set of string BoardCertifiedSubSpecialty1Valid := []; 
	set of string BoardCertifiedSpecialty2Verified := []; 
	set of string BoardCertifiedSpecialty2Valid := []; 
	set of string BoardCertifiedSubSpecialty2Verified := []; 
	set of string BoardCertifiedSubSpecialty2Valid := []; 
	set of string BoardCertifiedSpecialty3Verified := []; 
	set of string BoardCertifiedSpecialty3Valid := []; 
	set of string BoardCertifiedSubSpecialty3Verified := []; 
	set of string BoardCertifiedSubSpecialty3Valid := []; 
	set of string BoardCertifiedSpecialty4Verified := []; 
	set of string BoardCertifiedSpecialty4Valid := []; 
	set of string BoardCertifiedSubSpecialty4Verified := []; 
	set of string BoardCertifiedSubSpecialty4Valid := []; 
	set of string BoardCertifiedSpecialty5Verified := []; 
	set of string BoardCertifiedSpecialty5Valid := []; 
	set of string BoardCertifiedSubSpecialty5Verified := []; 
	set of string BoardCertifiedSubSpecialty5Valid := []; 
	set of string isAliveNoSanc := ['DEFAULT']; 
	set of string isDead := []; 
	set of string hasSanctions := []; 
	set of string hasEPLSSanctions := []; 
	set of string hasLEIESanctions := []; 
	set of string hasDisciplinarySanctions := []; 

	ConfigurationVerificationFlags getFlags(string userConfigName):=transform
			self.VerificationConfiguration := userConfigName;
			self.VerificationConfigurationStatus := if(userConfigName in validConfigNames,Constants.ONE_STEP_PASS_GOOD_CONFIG,Constants.ONE_STEP_PASS_BAD_CONFIG);
			self.NameVerified := if(userConfigName in NameVerified,true,false);
			self.CompanyNameVerified := if(userConfigName in CompanyNameVerified,true,false);
			self.AddressVerified := if(userConfigName in AddressVerified,true,false);
			self.PhoneVerified := if(userConfigName in PhoneVerified,true,false);
			self.SSNVerified := if(userConfigName in SSNVerified,true,false);
			self.FEINVerified := if(userConfigName in FEINVerified,true,false);
			self.UPINVerified := if(userConfigName in UPINVerified,true,false);
			self.NPISuppliedExists := if(userConfigName in NPISuppliedExists,true,false);
			self.NPIValid := if(userConfigName in NPIValid,true,false);
			self.NPIVerified := if(userConfigName in NPIVerified,true,false);
			self.CLIAValid := if(userConfigName in CLIAValid,true,false);
			self.CLIAVerified := if(userConfigName in CLIAVerified,true,false);
			self.DEAValid := if(userConfigName in DEAValid,true,false);
			self.DEA2Valid := if(userConfigName in DEA2Valid,true,false);
			self.DEAVerified := if(userConfigName in DEAVerified,true,false);
			self.DEA2Verified := if(userConfigName in DEA2Verified,true,false);
			self.LicenseValid := if(userConfigName in AnyLicenseValid,true,false);
			self.LicenseVerified := if(userConfigName in AnyLicenseVerified,true,false);
			self.License1Valid := if(userConfigName in License1Valid,true,false);
			self.License1Verified := if(userConfigName in License1Verified,true,false);
			self.License2Valid := if(userConfigName in License2Valid,true,false);
			self.License2Verified := if(userConfigName in License2Verified,true,false);
			self.License3Valid := if(userConfigName in License3Valid,true,false);
			self.License3Verified := if(userConfigName in License3Verified,true,false);
			self.License4Valid := if(userConfigName in License4Valid,true,false);
			self.License4Verified := if(userConfigName in License4Verified,true,false);
			self.License5Valid := if(userConfigName in License5Valid,true,false);
			self.License5Verified := if(userConfigName in License5Verified,true,false);
			self.License6Valid := if(userConfigName in License6Valid,true,false);
			self.License6Verified := if(userConfigName in License6Verified,true,false);
			self.License7Valid := if(userConfigName in License7Valid,true,false);
			self.License7Verified := if(userConfigName in License7Verified,true,false);
			self.License8Valid := if(userConfigName in License8Valid,true,false);
			self.License8Verified := if(userConfigName in License8Verified,true,false);
			self.License9Valid := if(userConfigName in License9Valid,true,false);
			self.License9Verified := if(userConfigName in License9Verified,true,false);
			self.License10Valid := if(userConfigName in License10Valid,true,false);
			self.License10Verified := if(userConfigName in License10Verified,true,false);
			self.TaxonomyVerified := if(userConfigName in AnyTaxonomyVerified,true,false);
			self.Taxonomy1Verified := if(userConfigName in Taxonomy1Verified,true,false);
			self.Taxonomy2Verified := if(userConfigName in Taxonomy2Verified,true,false);
			self.Taxonomy3Verified := if(userConfigName in Taxonomy3Verified,true,false);
			self.Taxonomy4Verified := if(userConfigName in Taxonomy4Verified,true,false);
			self.Taxonomy5Verified := if(userConfigName in Taxonomy5Verified,true,false);
			self.MedicalSchoolNameVerified := if(userConfigName in MedicalSchoolNameVerified,true,false);
			self.GraduationYearVerified := if(userConfigName in GraduationYearVerified,true,false);
			self.BoardCertifiedSpecialtyValid := if(userConfigName in AnyBoardCertifiedSpecialtyValid,true,false); 
			self.BoardCertifiedSpecialtyVerified := if(userConfigName in AnyBoardCertifiedSpecialtyVerified,true,false); 
			self.BoardCertifiedSubSpecialtyValid := if(userConfigName in AnyBoardCertifiedSubSpecialtyValid,true,false); 
			self.BoardCertifiedSubSpecialtyVerified := if(userConfigName in AnyBoardCertifiedSubSpecialtyVerified,true,false); 
			self.BoardCertifiedSpecialty1Valid := if(userConfigName in BoardCertifiedSpecialty1Valid,true,false); 
			self.BoardCertifiedSpecialty1Verified := if(userConfigName in BoardCertifiedSpecialty1Verified,true,false); 
			self.BoardCertifiedSubSpecialty1Valid := if(userConfigName in BoardCertifiedSubSpecialty1Valid,true,false); 
			self.BoardCertifiedSubSpecialty1Verified := if(userConfigName in BoardCertifiedSubSpecialty1Verified,true,false); 
			self.BoardCertifiedSpecialty2Valid := if(userConfigName in BoardCertifiedSpecialty2Valid,true,false); 
			self.BoardCertifiedSpecialty2Verified := if(userConfigName in BoardCertifiedSpecialty2Verified,true,false); 
			self.BoardCertifiedSubSpecialty2Valid := if(userConfigName in BoardCertifiedSubSpecialty2Valid,true,false); 
			self.BoardCertifiedSubSpecialty2Verified := if(userConfigName in BoardCertifiedSubSpecialty2Verified,true,false); 
			self.BoardCertifiedSpecialty3Valid := if(userConfigName in BoardCertifiedSpecialty3Valid,true,false); 
			self.BoardCertifiedSpecialty3Verified := if(userConfigName in BoardCertifiedSpecialty3Verified,true,false); 
			self.BoardCertifiedSubSpecialty3Valid := if(userConfigName in BoardCertifiedSubSpecialty3Valid,true,false); 
			self.BoardCertifiedSubSpecialty3Verified := if(userConfigName in BoardCertifiedSubSpecialty3Verified,true,false); 
			self.BoardCertifiedSpecialty4Valid := if(userConfigName in BoardCertifiedSpecialty4Valid,true,false); 
			self.BoardCertifiedSpecialty4Verified := if(userConfigName in BoardCertifiedSpecialty4Verified,true,false); 
			self.BoardCertifiedSubSpecialty4Valid := if(userConfigName in BoardCertifiedSubSpecialty4Valid,true,false); 
			self.BoardCertifiedSubSpecialty4Verified := if(userConfigName in BoardCertifiedSubSpecialty4Verified,true,false); 
			self.BoardCertifiedSpecialty5Verified := if(userConfigName in BoardCertifiedSpecialty5Verified,true,false); 
			self.BoardCertifiedSpecialty5Valid := if(userConfigName in BoardCertifiedSpecialty5Valid,true,false); 
			self.BoardCertifiedSubSpecialty5Valid := if(userConfigName in BoardCertifiedSubSpecialty5Valid,true,false); 
			self.BoardCertifiedSubSpecialty5Verified := if(userConfigName in BoardCertifiedSubSpecialty5Verified,true,false); 
			self.isAliveNoSanc := if(userConfigName in isAliveNoSanc,true,false); 
			self.isDead := if(userConfigName in isDead,true,false); 
			self.hasSanctions := if(userConfigName in hasSanctions,true,false); 
			self.hasEPLSSanctions := if(userConfigName in hasEPLSSanctions,true,false); 
			self.hasLEIESanctions := if(userConfigName in hasLEIESanctions,true,false); 
			self.hasDisciplinarySanctions := if(userConfigName in hasDisciplinarySanctions,true,false); 
	end;
	
	Export getConfig(String requestedConfig) := Function
		configName := stringlib.StringToUpperCase(requestedConfig);
		ds := dataset([getFlags(configName)]);
		return ds;
	end;

End;