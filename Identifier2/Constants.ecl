EXPORT Constants:= MODULE
  IMPORT STD ;

  EXPORT GovID := Module
   EXPORT UNSIGNED1 FailValue := 0;
   EXPORT UNSIGNED1 PassValue := 1;
   EXPORT UNSIGNED1 DisabledValue := 2;
   
   EXPORT EnumGovIdAttrib := ENUM(UNSIGNED1, SSNFullNameMatch,SSNDeathMatchVerification,SSNExists,MultipleIdentitySSN,SSNLastNameMatch,SSNYOBDateAlert,SSN4FullNameMatch,SSNRandomized,SSNHistory,SSN5FullNameMatch,Addr1Zip_StateMatch,Addr1LastNameMatch,IdentityOccupancyVerified,AddrDeliverable,AddrNotBusiness,AddrNotHighRisk,AddrNotMaildrop,PropertyAndDeed,IdentityOwnershipVerified,NameStreetAddressMatch,NameCityStateMatch,NameZipMatch,Age_Verification,YOBSSNMatch,DOBSSNMatch,DOBFullVerified,DOBMonthYearVerified,DOBYearVerified,DOBMonthDayVerified,PhoneLastNameMatch,PhoneNotMobile,PhoneNotDisconnected,PhoneVerified,PhoneFullNameMatch,DriverLicenseMatch,DriversLicenseVerification,PassportValidation,OFAC,AdditionalWatchlists,LexIDDeathMatch,SSNLowIssuance,SSNSSAValid);

    

   EXPORT String_SSNFullNameMatch := 'SSNFullNameMatch';   //1
   EXPORT String_SSNDeathMatchVerification := 'SSNDeathMatchVerification';   //2
   EXPORT String_SSNExists := 'SSNExists';   //3
   EXPORT String_MultipleIdentitySSN := 'MultipleIdentitySSN';   //4
   EXPORT String_SSNLastNameMatch := 'SSNLastNameMatch';   //5
   EXPORT String_SSNYOBDateAlert := 'SSNYOBDateAlert';   //6
   EXPORT String_SSN4FullNameMatch := 'SSN4FullNameMatch';   //7
   EXPORT String_SSNRandomized := 'SSNRandomized';   //8
   EXPORT String_SSNHistory := 'SSNHistory';   //9
   EXPORT String_SSN5FullNameMatch := 'SSN5FullNameMatch';   //10
   EXPORT String_Addr1Zip_StateMatch := 'Addr1Zip_StateMatch';   //11
   EXPORT String_Addr1LastNameMatch := 'Addr1LastNameMatch';   //12
   EXPORT String_IdentityOccupancyVerified := 'IdentityOccupancyVerified';   //13
   EXPORT String_AddrDeliverable := 'AddrDeliverable';   //14
   EXPORT String_AddrNotBusiness := 'AddrNotBusiness';   //15
   EXPORT String_AddrNotHighRisk := 'AddrNotHighRisk';   //16
   EXPORT String_AddrNotMaildrop := 'AddrNotMaildrop';   //17
   EXPORT String_PropertyAndDeed  := 'PropertyAndDeed';   //18
   EXPORT String_IdentityOwnershipVerified := 'IdentityOwnershipVerified';   //19
   EXPORT String_NameStreetAddressMatch := 'NameStreetAddressMatch';   //20
   EXPORT String_NameCityStateMatch := 'NameCityStateMatch';   //21
   EXPORT String_NameZipMatch := 'NameZipMatch';   //22
   EXPORT String_Age_Verification := 'Age_Verification';   //23
   EXPORT String_YOBSSNMatch := 'YOBSSNMatch';   //24
   EXPORT String_DOBSSNMatch := 'DOBSSNMatch';   //25
   EXPORT String_DOBFullVerified := 'DOBFullVerified';   //26
   EXPORT String_DOBMonthYearVerified := 'DOBMonthYearVerified';   //27
   EXPORT String_DOBYearVerified := 'DOBYearVerified';   //28
   EXPORT String_DOBMonthDayVerified := 'DOBMonthDayVerified';   //29
   EXPORT String_PhoneLastNameMatch := 'PhoneLastNameMatch';   //30
   EXPORT String_PhoneNotMobile := 'PhoneNotMobile';   //31
   EXPORT String_PhoneNotDisconnected := 'PhoneNotDisconnected';   //32
   EXPORT String_PhoneVerified := 'PhoneVerified';   //33
   EXPORT String_PhoneFullNameMatch := 'PhoneFullNameMatch';   //34
   EXPORT String_DriverLicenseMatch := 'DriverLicenseMatch';   //35
   EXPORT String_DriversLicenseVerification := 'DriversLicenseVerification';   //36
   EXPORT String_PassportValidation := 'PassportValidation';   //37
   EXPORT String_OFAC := 'OFAC';   //38
   EXPORT String_AdditionalWatchlists := 'AdditionalWatchlists';   //39
   EXPORT String_LexIDDeathMatch := 'LexIDDeathMatch';   //40
   EXPORT String_SSNLowIssuance := 'SSNLowIssuance';   //41
   EXPORT String_SSNSSAValid := 'SSNSSAValid';   //42

   EXPORT SET OF STRING GovIdAttribSet := [String_SSNFullNameMatch,String_SSNDeathMatchVerification,String_SSNExists,String_MultipleIdentitySSN,String_SSNLastNameMatch,String_SSNYOBDateAlert,String_SSN4FullNameMatch,String_SSNRandomized,String_SSNHistory,String_SSN5FullNameMatch,String_Addr1Zip_StateMatch,String_Addr1LastNameMatch,String_IdentityOccupancyVerified,String_AddrDeliverable,String_AddrNotBusiness,String_AddrNotHighRisk,String_AddrNotMaildrop,String_PropertyAndDeed,String_IdentityOwnershipVerified,String_NameStreetAddressMatch,String_NameCityStateMatch,String_NameZipMatch,String_Age_Verification,String_YOBSSNMatch,String_DOBSSNMatch,String_DOBFullVerified,String_DOBMonthYearVerified,String_DOBYearVerified,String_DOBMonthDayVerified,String_PhoneLastNameMatch,String_PhoneNotMobile,String_PhoneNotDisconnected,String_PhoneVerified,String_PhoneFullNameMatch,String_DriverLicenseMatch,String_DriversLicenseVerification,String_PassportValidation,String_OFAC,String_AdditionalWatchlists,String_LexIDDeathMatch,String_SSNLowIssuance,String_SSNSSAValid];


  END;
END;
;