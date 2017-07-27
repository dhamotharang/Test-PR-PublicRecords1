IMPORT iesp, IntlIID_GG2;

EXPORT GetIntlIID_GG2(DATASET(IntlIID_GG2.Layouts.ExtInputRequest) inputReq, STRING20 TestDataTableName) := FUNCTION

	hashValues := RECORD
		STRING20 DatasetName;
		Seed_Files.Layout_IntlIID_GG2.hashFirstName;
		Seed_Files.Layout_IntlIID_GG2.hashLastName;
		Seed_Files.Layout_IntlIID_GG2.hashNationalID;
		Seed_Files.Layout_IntlIID_GG2.hashPostalCode;
		Seed_Files.Layout_IntlIID_GG2.hashTelephone;
		STRING2 correctedCountryCode;
		STRING30 correctedCountry;
		DATA16 hashValue;
	END;

	hashValues getHashValues(IntlIID_GG2.Layouts.ExtInputRequest L) := TRANSFORM
		srchBy:=IntlIID_GG2.Functions.getSearchBySuperSet(L);
		SELF.DatasetName:=stringlib.stringtouppercase(TestDataTableName);
		SELF.hashFirstName:=unicodelib.unicodetouppercase(
										IF(srchBy.GivenNames   <>'',TRIM(srchBy.GivenNames)   ,'') + TRIM(srchBy.FirstName));
		SELF.hashLastName:=unicodelib.unicodetouppercase(
										IF(srchBy.MaidenName   <>'',TRIM(srchBy.MaidenName)   ,'') +
										IF(srchBy.Surname      <>'',TRIM(srchBy.Surname)      ,'') +
										IF(srchBy.FirstSurname <>'',TRIM(srchBy.FirstSurname) ,'') +
										IF(srchBy.SecondSurname<>'',TRIM(srchBy.SecondSurname),'') + TRIM(srchBy.LastName));
		SELF.hashNationalID:=stringlib.stringtouppercase(
										TRIM(srchBy.RTACardNumber) +
										TRIM(srchBy.SocialInsuranceNumber) +
										TRIM(srchBy.HongKongIDNumber) +
										TRIM(srchBy.PersonalPublicServiceNumber) +
										TRIM(srchBy.CURPIDNumber) +
										TRIM(srchBy.NRICNumber) +
										TRIM(srchBy.NHSNumber) +
										TRIM(srchBy.NationalIDNumber));
		SELF.hashPostalCode:=unicodelib.unicodetouppercase((UNICODE)srchBy.PostalCode);
		SELF.hashTelephone:=srchBy.Telephone;
		SELF.correctedCountryCode:=L.correctedCountryCode;
		SELF.correctedCountry:=L.correctedCountry;
		SELF:=[];
	END;

	iesp.gg2_iid_intl.t_InstantIDIntlPassport passportVisaInfo(Key_IntlIID_GG2 L, BOOLEAN isPP) := TRANSFORM
		SELF.Number := IF(isPP,L.PP_Number,L.VS_Number);
		PP_Date8 := INTFORMAT((INTEGER)L.PP_YearOfExpiration,4,1)+INTFORMAT((INTEGER)L.PP_MonthOfExpiration,2,1)+INTFORMAT((INTEGER)L.PP_DayOfExpiration,2,1);
		VS_Date8 := INTFORMAT((INTEGER)L.VS_YearOfExpiration,4,1)+INTFORMAT((INTEGER)L.VS_MonthOfExpiration,2,1)+INTFORMAT((INTEGER)L.VS_DayOfExpiration,2,1);
		SELF.ExpirationDate := IF(isPP,iesp.ECL2ESP.toDatestring8(PP_Date8),iesp.ECL2ESP.toDatestring8(VS_Date8));
		SELF.Country := IF(isPP,L.PP_Country,L.VS_Country);
		SELF.MachineReadableLine1 := IF(isPP,L.PP_MachineReadableLine1,L.VS_MachineReadableLine1);
		SELF.MachineReadableLine2 := IF(isPP,L.PP_MachineReadableLine2,L.VS_MachineReadableLine2);
	END;

	iesp.gg2_response.t_DatasourceResponse dataSourceFields(Key_IntlIID_GG2 L, INTEGER seq) := TRANSFORM
		SELF.FirstName                   := IF(seq=1,L.DS1_FirstName                  ,L.DS2_FirstName                  );
		SELF.MiddleName                  := IF(seq=1,L.DS1_MiddleName                 ,L.DS2_MiddleName                 );
		SELF.LastName                    := IF(seq=1,L.DS1_LastName                   ,L.DS2_LastName                   );
		SELF.GivenNames                  := IF(seq=1,L.DS1_GivenNames                 ,L.DS2_GivenNames                 );
		SELF.Surname                     := IF(seq=1,L.DS1_Surname                    ,L.DS2_Surname                    );
		SELF.FirstSurname                := IF(seq=1,L.DS1_FirstSurname               ,L.DS2_FirstSurname               );
		SELF.SecondSurname               := IF(seq=1,L.DS1_SecondSurname              ,L.DS2_SecondSurname              );
		SELF.MaidenName                  := IF(seq=1,L.DS1_MaidenName                 ,L.DS2_MaidenName                 );
		SELF.FirstInitial                := IF(seq=1,L.DS1_FirstInitial               ,L.DS2_FirstInitial               );
		SELF.MiddleInitial               := IF(seq=1,L.DS1_MiddleInitial              ,L.DS2_MiddleInitial              );
		SELF.GivenInitials               := IF(seq=1,L.DS1_GivenInitials              ,L.DS2_GivenInitials              );
		SELF.Gender                      := IF(seq=1,L.DS1_Gender                     ,L.DS2_Gender                     );
		SELF.YearOfBirth                 := IF(seq=1,L.DS1_YearOfBirth                ,L.DS2_YearOfBirth                );
		SELF.MonthOfBirth                := IF(seq=1,L.DS1_MonthOfBirth               ,L.DS2_MonthOfBirth               );
		SELF.DayOfBirth                  := IF(seq=1,L.DS1_DayOfBirth                 ,L.DS2_DayOfBirth                 );
		SELF.Address1                    := IF(seq=1,L.DS1_Address1                   ,L.DS2_Address1                   );
		SELF.Address2                    := IF(seq=1,L.DS1_Address2                   ,L.DS2_Address2                   );
		SELF.StreetNumber                := IF(seq=1,L.DS1_StreetNumber               ,L.DS2_StreetNumber               );
		SELF.HouseNumber                 := IF(seq=1,L.DS1_HouseNumber                ,L.DS2_HouseNumber                );
		SELF.CivicNumber                 := IF(seq=1,L.DS1_CivicNumber                ,L.DS2_CivicNumber                );
		SELF.AreaNumbers                 := IF(seq=1,L.DS1_AreaNumbers                ,L.DS2_AreaNumbers                );
		SELF.StreetName                  := IF(seq=1,L.DS1_StreetName                 ,L.DS2_StreetName                 );
		SELF.StreetType                  := IF(seq=1,L.DS1_StreetType                 ,L.DS2_StreetType                 );
		SELF.BuildingName                := IF(seq=1,L.DS1_BuildingName               ,L.DS2_BuildingName               );
		SELF.BuildingNumber              := IF(seq=1,L.DS1_BuildingNumber             ,L.DS2_BuildingNumber             );
		SELF.BlockNumber                 := IF(seq=1,L.DS1_BlockNumber                ,L.DS2_BlockNumber                );
		SELF.UnitNumber                  := IF(seq=1,L.DS1_UnitNumber                 ,L.DS2_UnitNumber                 );
		SELF.RoomNumber                  := IF(seq=1,L.DS1_RoomNumber                 ,L.DS2_RoomNumber                 );
		SELF.HouseExtension              := IF(seq=1,L.DS1_HouseExtension             ,L.DS2_HouseExtension             );
		SELF.FloorNumber                 := IF(seq=1,L.DS1_FloorNumber                ,L.DS2_FloorNumber                );
		SELF.Suburb                      := IF(seq=1,L.DS1_Suburb                     ,L.DS2_Suburb                     );
		SELF.Aza                         := IF(seq=1,L.DS1_Aza                        ,L.DS2_Aza                        );
		SELF.City                        := IF(seq=1,L.DS1_City                       ,L.DS2_City                       );
		SELF.Municipality                := IF(seq=1,L.DS1_Municipality               ,L.DS2_Municipality               );
		SELF.Province                    := IF(seq=1,L.DS1_Province                   ,L.DS2_Province                   );
		SELF.County                      := IF(seq=1,L.DS1_County                     ,L.DS2_County                     );
		SELF.State                       := IF(seq=1,L.DS1_State                      ,L.DS2_State                      );
		SELF.District                    := IF(seq=1,L.DS1_District                   ,L.DS2_District                   );
		SELF.Prefecture                  := IF(seq=1,L.DS1_Prefecture                 ,L.DS2_Prefecture                 );
		SELF.PostalCode                  := IF(seq=1,L.DS1_PostalCode                 ,L.DS2_PostalCode                 );
		SELF.CountryCode                 := IF(seq=1,L.DS1_CountryCode                ,L.DS2_CountryCode                );
		SELF.Telephone                   := IF(seq=1,L.DS1_Telephone                  ,L.DS2_Telephone                  );
		SELF.CellNumber                  := IF(seq=1,L.DS1_CellNumber                 ,L.DS2_CellNumber                 );
		SELF.WorkTelephone               := IF(seq=1,L.DS1_WorkTelephone              ,L.DS2_WorkTelephone              );
		SELF.RTACardNumber               := IF(seq=1,L.DS1_RTACardNumber              ,L.DS2_RTACardNumber              );
		SELF.SocialInsuranceNumber       := IF(seq=1,L.DS1_SocialInsuranceNumber      ,L.DS2_SocialInsuranceNumber      );
		SELF.NationalIDNumber            := IF(seq=1,L.DS1_NationalIDNumber           ,L.DS2_NationalIDNumber           );
		SELF.HongKongIDNumber            := IF(seq=1,L.DS1_HongKongIDNumber           ,L.DS2_HongKongIDNumber           );
		SELF.PersonalPublicServiceNumber := IF(seq=1,L.DS1_PersonalPublicServiceNumber,L.DS2_PersonalPublicServiceNumber);
		SELF.CURPIDNumber                := IF(seq=1,L.DS1_CURPIDNumber               ,L.DS2_CURPIDNumber               );
		SELF.StateOfBirth                := IF(seq=1,L.DS1_StateOfBirth               ,L.DS2_StateOfBirth               );
		SELF.NRICNumber                  := IF(seq=1,L.DS1_NRICNumber                 ,L.DS2_NRICNumber                 );
		SELF.NHSNumber                   := IF(seq=1,L.DS1_NHSNumber                  ,L.DS2_NHSNumber                  );
		SELF.CityOfIssue                 := IF(seq=1,L.DS1_CityOfIssue                ,L.DS2_CityOfIssue                );
		SELF.CountyOfIssue               := IF(seq=1,L.DS1_CountyOfIssue              ,L.DS2_CountyOfIssue              );
		SELF.DistrictOfIssue             := IF(seq=1,L.DS1_DistrictOfIssue            ,L.DS2_DistrictOfIssue            );
		SELF.ProvinceOfIssue             := IF(seq=1,L.DS1_ProvinceOfIssue            ,L.DS2_ProvinceOfIssue            );
		SELF.DriverLicenceNumber         := IF(seq=1,L.DS1_DriverLicenceNumber        ,L.DS2_DriverLicenceNumber        );
		SELF.DriverLicenceVersionNumber  := IF(seq=1,L.DS1_DriverLicenceVersionNumber ,L.DS2_DriverLicenceVersionNumber );
		SELF.DriverLicenceState          := IF(seq=1,L.DS1_DriverLicenceState         ,L.DS2_DriverLicenceState         );
		SELF.YearOfExpiry                := IF(seq=1,L.DS1_YearOfExpiry               ,L.DS2_YearOfExpiry               );
		SELF.MonthOfExpiry               := IF(seq=1,L.DS1_MonthOfExpiry              ,L.DS2_MonthOfExpiry              );
		SELF.DayOfExpiry                 := IF(seq=1,L.DS1_DayOfExpiry                ,L.DS2_DayOfExpiry                );
		SELF.PassportNumber              := IF(seq=1,L.DS1_PassportNumber             ,L.DS2_PassportNumber             );
		SELF.PassportFullName            := IF(seq=1,L.DS1_PassportFullName           ,L.DS2_PassportFullName           );
		SELF.PassportMRZLine1            := IF(seq=1,L.DS1_PassportMRZLine1           ,L.DS2_PassportMRZLine1           );
		SELF.PassportMRZLine2            := IF(seq=1,L.DS1_PassportMRZLine2           ,L.DS2_PassportMRZLine2           );
		SELF.PassportCountry             := IF(seq=1,L.DS1_PassportCountry            ,L.DS2_PassportCountry            );
		SELF.PlaceOfBirth                := IF(seq=1,L.DS1_PlaceOfBirth               ,L.DS2_PlaceOfBirth               );
		SELF.CountryOfBirth              := IF(seq=1,L.DS1_CountryOfBirth             ,L.DS2_CountryOfBirth             );
		SELF.FamilyNameAtBirth           := IF(seq=1,L.DS1_FamilyNameAtBirth          ,L.DS2_FamilyNameAtBirth          );
		SELF.FamilyNameAtCitizenship     := IF(seq=1,L.DS1_FamilyNameAtCitizenship    ,L.DS2_FamilyNameAtCitizenship    );
		SELF.PassportYearOfExpiry        := IF(seq=1,L.DS1_PassportYearOfExpiry       ,L.DS2_PassportYearOfExpiry       );
		SELF.PassportMonthOfExpiry       := IF(seq=1,L.DS1_PassportMonthOfExpiry      ,L.DS2_PassportMonthOfExpiry      );
		SELF.PassportDayOfExpiry         := IF(seq=1,L.DS1_PassportDayOfExpiry        ,L.DS2_PassportDayOfExpiry        );
		SELF.MedicareNumber              := IF(seq=1,L.DS1_MedicareNumber             ,L.DS2_MedicareNumber             );
		SELF.MedicareReference           := IF(seq=1,L.DS1_MedicareReference          ,L.DS2_MedicareReference          );
	END;

	iesp.gg2_response.t_DatasourceResult dataSourceResult(Key_IntlIID_GG2 L, INTEGER seq) := TRANSFORM
		SELF.DatasourceName := IF(seq=1,L.DS1_DatasourceName,L.DS2_DatasourceName);
		SELF.DatasourceStatus := IF(seq=1,L.DS1_DatasourceStatus,L.DS2_DatasourceStatus);
		dsError1 := DATASET([{L.DS1_ErrorCode,L.DS1_ErrorMessage}],iesp.gg2_response.t_ServiceError);
		dsError2 := DATASET([{L.DS2_ErrorCode,L.DS2_ErrorMessage}],iesp.gg2_response.t_ServiceError);
		SELF.Errors := IF(seq=1,dsError1,dsError2);
		SELF.DatasourceFields := PROJECT(L,dataSourceFields(LEFT,seq));
		dsAppended1 := DATASET([{L.DS1_AppendedFieldName,L.DS1_AppendedFieldValue}],iesp.gg2_response.t_AppendedField);
		dsAppended2 := DATASET([{L.DS2_AppendedFieldName,L.DS2_AppendedFieldValue}],iesp.gg2_response.t_AppendedField);
		SELF.AppendedFields := IF(seq=1,dsAppended1,dsAppended2);
		dsGroup1 := DATASET([{'',L.DS1_FieldGroupName}],iesp.gg2_response.t_FieldGroup);
		dsGroup2 := DATASET([{'',L.DS2_FieldGroupName}],iesp.gg2_response.t_FieldGroup);
		SELF.FieldGroups := IF(seq=1,dsGroup1,dsGroup2);
	END;

	iesp.gg2_response.t_GDCRecord verificationRecord(Key_IntlIID_GG2 L) := TRANSFORM
		dsDSR := PROJECT(L,dataSourceResult(LEFT,1))+PROJECT(L,dataSourceResult(LEFT,2));
		SELF.DatasourceResults := dsDSR(DatasourceName!='');
		SELF.Errors := DATASET([{L.ErrorCode,L.ErrorMessage}],iesp.gg2_response.t_ServiceError);
		SELF.RecordStatus := L.RecordStatus;
		SELF.TransactionRecordID := L.TransactionRecordID;
	END;

	iesp.gg2_iid_intl.t_InstantIDIntl2Response getIntlIIDSeeds(hashValues L, Key_IntlIID_GG2 R) := TRANSFORM
		SELF._header.Status := R.Status;
		SELF._header.Message := R.Message;
		SELF._header.QueryID := R.QueryID;
		SELF._header.TransactionID := R.TransactionID;

		SELF.result.inputEcho.Country := R.Country;
		SELF.result.inputEcho.AustraliaVerification:=IF(R.Country=IntlIID_GG2.Constants.AU,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_AustraliaVerification,
				SELF.Passport:=PROJECT(R,TRANSFORM(iesp.gg2_verify.t_AustraliaPassport,SELF:=LEFT)),
				SELF.Consents:=PROJECT(R,TRANSFORM(iesp.gg2_verify.t_AustraliaDSConsent,SELF:=LEFT)),
				SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.AustriaVerification:=IF(R.Country=IntlIID_GG2.Constants.AT,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_AustriaVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.BrazilVerification:=IF(R.Country=IntlIID_GG2.Constants.BR,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_BrazilVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.CanadaVerification:=IF(R.Country=IntlIID_GG2.Constants.CA,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_CanadaVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.ChinaVerification:=IF(R.Country=IntlIID_GG2.Constants.CN,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_ChinaVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.GermanyVerification:=IF(R.Country=IntlIID_GG2.Constants.DE,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_GermanyVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.HongKongVerification:=IF(R.Country=IntlIID_GG2.Constants.HK,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_HongKongVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.IrelandVerification:=IF(R.Country=IntlIID_GG2.Constants.IE,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_IrelandVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.JapanVerification:=IF(R.Country=IntlIID_GG2.Constants.JP,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_JapanVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.LuxembourgVerification:=IF(R.Country=IntlIID_GG2.Constants.LU,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_LuxembourgVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.MexicoVerification:=IF(R.Country=IntlIID_GG2.Constants.MX,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_MexicoVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.NetherlandsVerification:=IF(R.Country=IntlIID_GG2.Constants.NL,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_NetherlandsVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.NewZealandVerification:=IF(R.Country=IntlIID_GG2.Constants.NZ,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_NewZealandVerification,
				SELF.Consents:=PROJECT(R,TRANSFORM(iesp.gg2_verify.t_NewZealandDSConsent,SELF:=LEFT)),
				SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.SingaporeVerification:=IF(R.Country=IntlIID_GG2.Constants.SG,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_SingaporeVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.SouthAfricaVerification:=IF(R.Country=IntlIID_GG2.Constants.ZA,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_SouthAfricaVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.SwitzerlandVerification:=IF(R.Country=IntlIID_GG2.Constants.CH,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_SwitzerlandVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.UnitedKingdomVerification:=IF(R.Country=IntlIID_GG2.Constants.GB,
			PROJECT(R,TRANSFORM(iesp.gg2_verify.t_UnitedKingdomVerification,SELF:=LEFT,SELF:=[])));
		SELF.result.inputEcho.Gender := R.PP_VS_Gender;
		SELF.result.inputEcho.passportInfo := PROJECT(R,passportVisaInfo(LEFT,TRUE));
		SELF.result.inputEcho.visaInfo := PROJECT(R,passportVisaInfo(LEFT,FALSE));
		SELF.result.inputEcho.IPAddress := R.IPAddress;

		dsRiskIndicators := DATASET([
			{R.RC1_RiskCode,R.RC1_Description},{R.RC2_RiskCode,R.RC2_Description},
			{R.RC3_RiskCode,R.RC3_Description},{R.RC4_RiskCode,R.RC4_Description},
			{R.RC5_RiskCode,R.RC5_Description},{R.RC6_RiskCode,R.RC6_Description},
			{R.RC7_RiskCode,R.RC7_Description},{R.RC8_RiskCode,R.RC8_Description},
			{R.RC9_RiskCode,R.RC9_Description},{R.RC10_RiskCode,R.RC10_Description}
		],iesp.share.t_RiskIndicator);
		SELF.result.RiskIndicators := CHOOSEN(dsRiskIndicators(RiskCode!=''),iesp.Constants.MaxCountHRI);

		dsVerificationResults := DATASET([
			{IntlIID_GG2.Constants.FIRSTNAME                  ,R.VR_FirstName,                   R.VR_FirstNameCnt},
			{IntlIID_GG2.Constants.MIDDLENAME                 ,R.VR_MiddleName,                  R.VR_MiddleNameCnt},
			{IntlIID_GG2.Constants.LASTNAME                   ,R.VR_LastName,                    R.VR_LastNameCnt},
			{IntlIID_GG2.Constants.GIVENNAMES                 ,R.VR_GivenNames,                  R.VR_GivenNamesCnt},
			{IntlIID_GG2.Constants.SURNAME                    ,R.VR_Surname,                     R.VR_SurnameCnt},
			{IntlIID_GG2.Constants.FIRSTSURNAME               ,R.VR_FirstSurname,                R.VR_FirstSurnameCnt},
			{IntlIID_GG2.Constants.SECONDSURNAME              ,R.VR_SecondSurname,               R.VR_SecondSurnameCnt},
			{IntlIID_GG2.Constants.MAIDENNAME                 ,R.VR_MaidenName,                  R.VR_MaidenNameCnt},
			{IntlIID_GG2.Constants.FIRSTINITIAL               ,R.VR_FirstInitial,                R.VR_FirstInitialCnt},
			{IntlIID_GG2.Constants.MIDDLEINITIAL              ,R.VR_MiddleInitial,               R.VR_MiddleInitialCnt},
			{IntlIID_GG2.Constants.GIVENINITIALS              ,R.VR_GivenInitials,               R.VR_GivenInitialsCnt},
			{IntlIID_GG2.Constants.GENDER                     ,R.VR_Gender,                      R.VR_GenderCnt},
			{IntlIID_GG2.Constants.YEAROFBIRTH                ,R.VR_YearOfBirth,                 R.VR_YearOfBirthCnt},
			{IntlIID_GG2.Constants.MONTHOFBIRTH               ,R.VR_MonthOfBirth,                R.VR_MonthOfBirthCnt},
			{IntlIID_GG2.Constants.DAYOFBIRTH                 ,R.VR_DayOfBirth,                  R.VR_DayOfBirthCnt},
			{IntlIID_GG2.Constants.ADDRESS1                   ,R.VR_Address1,                    R.VR_Address1Cnt},
			{IntlIID_GG2.Constants.ADDRESS2                   ,R.VR_Address2,                    R.VR_Address2Cnt},
			{IntlIID_GG2.Constants.STREETNUMBER               ,R.VR_StreetNumber,                R.VR_StreetNumberCnt},
			{IntlIID_GG2.Constants.HOUSENUMBER                ,R.VR_HouseNumber,                 R.VR_HouseNumberCnt},
			{IntlIID_GG2.Constants.CIVICNUMBER                ,R.VR_CivicNumber,                 R.VR_CivicNumberCnt},
			{IntlIID_GG2.Constants.AREANUMBERS                ,R.VR_AreaNumbers,                 R.VR_AreaNumbersCnt},
			{IntlIID_GG2.Constants.STREETNAME                 ,R.VR_StreetName,                  R.VR_StreetNameCnt},
			{IntlIID_GG2.Constants.STREETTYPE                 ,R.VR_StreetType,                  R.VR_StreetTypeCnt},
			{IntlIID_GG2.Constants.BUILDINGNAME               ,R.VR_BuildingName,                R.VR_BuildingNameCnt},
			{IntlIID_GG2.Constants.BUILDINGNUMBER             ,R.VR_BuildingNumber,              R.VR_BuildingNumberCnt},
			{IntlIID_GG2.Constants.BLOCKNUMBER                ,R.VR_BlockNumber,                 R.VR_BlockNumberCnt},
			{IntlIID_GG2.Constants.UNITNUMBER                 ,R.VR_UnitNumber,                  R.VR_UnitNumberCnt},
			{IntlIID_GG2.Constants.ROOMNUMBER                 ,R.VR_RoomNumber,                  R.VR_RoomNumberCnt},
			{IntlIID_GG2.Constants.HOUSEEXTENSION             ,R.VR_HouseExtension,              R.VR_HouseExtensionCnt},
			{IntlIID_GG2.Constants.FLOORNUMBER                ,R.VR_FloorNumber,                 R.VR_FloorNumberCnt},
			{IntlIID_GG2.Constants.SUBURB                     ,R.VR_Suburb,                      R.VR_SuburbCnt},
			{IntlIID_GG2.Constants.AZA                        ,R.VR_Aza,                         R.VR_AzaCnt},
			{IntlIID_GG2.Constants.CITY                       ,R.VR_City,                        R.VR_CityCnt},
			{IntlIID_GG2.Constants.MUNICIPALITY               ,R.VR_Municipality,                R.VR_MunicipalityCnt},
			{IntlIID_GG2.Constants.PROVINCE                   ,R.VR_Province,                    R.VR_ProvinceCnt},
			{IntlIID_GG2.Constants.COUNTY                     ,R.VR_County,                      R.VR_CountyCnt},
			{IntlIID_GG2.Constants.STATE                      ,R.VR_State,                       R.VR_StateCnt},
			{IntlIID_GG2.Constants.DISTRICT                   ,R.VR_District,                    R.VR_DistrictCnt},
			{IntlIID_GG2.Constants.PREFECTURE                 ,R.VR_Prefecture,                  R.VR_PrefectureCnt},
			{IntlIID_GG2.Constants.POSTALCODE                 ,R.VR_PostalCode,                  R.VR_PostalCodeCnt},
			{IntlIID_GG2.Constants.COUNTRYCODE                ,R.VR_CountryCode,                 R.VR_CountryCodeCnt},
			{IntlIID_GG2.Constants.TELEPHONE                  ,R.VR_Telephone,                   R.VR_TelephoneCnt},
			{IntlIID_GG2.Constants.CELLNUMBER                 ,R.VR_CellNumber,                  R.VR_CellNumberCnt},
			{IntlIID_GG2.Constants.WORKTELEPHONE              ,R.VR_WorkTelephone,               R.VR_WorkTelephoneCnt},
			{IntlIID_GG2.Constants.RTACARDNUMBER              ,R.VR_RTACardNumber,               R.VR_RTACardNumberCnt},
			{IntlIID_GG2.Constants.SOCIALINSURANCENUMBER      ,R.VR_SocialInsuranceNumber,       R.VR_SocialInsuranceNumberCnt},
			{IntlIID_GG2.Constants.HONGKONGIDNUMBER           ,R.VR_HongKongIDNumber,            R.VR_HongKongIDNumberCnt},
			{IntlIID_GG2.Constants.PERSONALPUBLICSERVICENUMBER,R.VR_PersonalPublicServiceNumber, R.VR_PersonalPublicServiceNumberCnt},
			{IntlIID_GG2.Constants.CURPIDNUMBER               ,R.VR_CURPIDNumber,                R.VR_CURPIDNumberCnt},
			{IntlIID_GG2.Constants.STATEOFBIRTH               ,R.VR_StateOfBirth,                R.VR_StateOfBirthCnt},
			{IntlIID_GG2.Constants.NRICNUMBER                 ,R.VR_NricNumber,                  R.VR_NricNumberCnt},
			{IntlIID_GG2.Constants.NHSNUMBER                  ,R.VR_NHSNumber,                   R.VR_NHSNumberCnt},
			{IntlIID_GG2.Constants.NATIONALIDNUMBER           ,R.VR_NationalIDNumber,            R.VR_NationalIDNumberCnt},
			{IntlIID_GG2.Constants.CITYOFISSUE                ,R.VR_CityOfIssue,                 R.VR_CityOfIssueCnt},
			{IntlIID_GG2.Constants.COUNTYOFISSUE              ,R.VR_CountyOfIssue,               R.VR_CountyOfIssueCnt},
			{IntlIID_GG2.Constants.DISTRICTOFISSUE            ,R.VR_DistrictOfIssue,             R.VR_DistrictOfIssueCnt},
			{IntlIID_GG2.Constants.PROVINCEOFISSUE            ,R.VR_ProvinceOfIssue,             R.VR_ProvinceOfIssueCnt},
			{IntlIID_GG2.Constants.DRIVERLICENCENUMBER        ,R.VR_DriverLicenceNumber,         R.VR_DriverLicenceNumberCnt},
			{IntlIID_GG2.Constants.DRIVERLICENCEVERSIONNUMBER ,R.VR_DriverLicenceVersionNumber,  R.VR_DriverLicenceVersionNumberCnt},
			{IntlIID_GG2.Constants.DRIVERLICENCESTATE         ,R.VR_DriverLicenceState,          R.VR_DriverLicenceStateCnt},
			{IntlIID_GG2.Constants.YEAROFEXPIRY               ,R.VR_YearOfExpiry,                R.VR_YearOfExpiryCnt},
			{IntlIID_GG2.Constants.MONTHOFEXPIRY              ,R.VR_MonthOfExpiry,               R.VR_MonthOfExpiryCnt},
			{IntlIID_GG2.Constants.DAYOFEXPIRY                ,R.VR_DayOfExpiry,                 R.VR_DayOfExpiryCnt},
			{IntlIID_GG2.Constants.PASSPORTNUMBER             ,R.VR_PassportNumber,              R.VR_PassportNumberCnt},
			{IntlIID_GG2.Constants.PASSPORTFULLNAME           ,R.VR_PassportFullName,            R.VR_PassportFullNameCnt},
			{IntlIID_GG2.Constants.PASSPORTMRZLINE1           ,R.VR_PassportMRZLine1,            R.VR_PassportMRZLine1Cnt},
			{IntlIID_GG2.Constants.PASSPORTMRZLINE2           ,R.VR_PassportMRZLine2,            R.VR_PassportMRZLine2Cnt},
			{IntlIID_GG2.Constants.PASSPORTCOUNTRY            ,R.VR_PassportCountry,             R.VR_PassportCountryCnt},
			{IntlIID_GG2.Constants.PLACEOFBIRTH               ,R.VR_PlaceOfBirth,                R.VR_PlaceOfBirthCnt},
			{IntlIID_GG2.Constants.COUNTRYOFBIRTH             ,R.VR_CountryOfBirth,              R.VR_CountryOfBirthCnt},
			{IntlIID_GG2.Constants.FAMILYNAMEATBIRTH          ,R.VR_FamilyNameAtBirth,           R.VR_FamilyNameAtBirthCnt},
			{IntlIID_GG2.Constants.FAMILYNAMEATCITIZENSHIP    ,R.VR_FamilyNameAtCitizenship,     R.VR_FamilyNameAtCitizenshipCnt},
			{IntlIID_GG2.Constants.PASSPORTYEAROFEXPIRY       ,R.VR_PassportYearOfExpiry,        R.VR_PassportYearOfExpiryCnt},
			{IntlIID_GG2.Constants.PASSPORTMONTHOFEXPIRY      ,R.VR_PassportMonthOfExpiry,       R.VR_PassportMonthOfExpiryCnt},
			{IntlIID_GG2.Constants.PASSPORTDAYOFEXPIRY        ,R.VR_PassportDayOfExpiry,         R.VR_PassportDayOfExpiryCnt},
			{IntlIID_GG2.Constants.MEDICARENUMBER             ,R.VR_MedicareNumber,              R.VR_MedicareNumberCnt},
			{IntlIID_GG2.Constants.MEDICAREREFERENCE          ,R.VR_MedicareReference,           R.VR_MedicareReferenceCnt}
		],iesp.gg2_iid_intl.t_InstantIDIntlVerificationResult);
		dsFieldNamesByCountry := NORMALIZE(IntlIID_GG2.Constants.outputFields(CountryName=L.correctedCountry),
			LEFT.Fields,TRANSFORM(IntlIID_GG2.Layouts.Fields,SELF:=RIGHT));
		dsVR := PROJECT(JOIN(dsVerificationResults,dsFieldNamesByCountry,LEFT.FieldName=RIGHT.FieldName,
			ALL,KEEP(1)),TRANSFORM(iesp.gg2_iid_intl.t_InstantIDIntlVerificationResult,SELF:=LEFT));
		SELF.result.VerificationResults := CHOOSEN(dsVR,iesp.Constants.MaxCountVerificationResults);

		dsWatchList := DATASET([
			{R.WL_Table,R.WL_RecordNumber,
			{R.WL_Full,R.WL_First,R.WL_Middle,R.WL_Last,R.WL_Suffix,R.WL_Prefix},
			{R.WL_StreetNumber,R.WL_StreetPreDirection,R.WL_StreetName,R.WL_StreetSuffix,R.WL_StreetPostDirection,
			 R.WL_UnitDesignation,R.WL_UnitNumber,R.WL_StreetAddress1,R.WL_StreetAddress2,
			 R.WL_City,R.WL_State,R.WL_Zip5,R.WL_Zip4,R.WL_County,R.WL_PostalCode,R.WL_StateCityZip},
			 R.WL_Country,R.WL_EntityName,R.WL_Sequence}
		],iesp.instantid.t_WatchList);
		SELF.result.WatchList := dsWatchList[1];
		SELF.result.WatchLists := dsWatchList;

		SELF.result.IPAddressInfo := PROJECT(R,TRANSFORM(iesp.gg2_iid_intl.t_InstantIDIntlIPAddressInfo,
			SELF.Country:=R.IP_Country,SELF.City:=R.IP_City,SELF:=LEFT));

		SELF.result.VerificationRecord := PROJECT(R,verificationRecord(LEFT));
		SELF.CountrySettings := IntlIID_GG2.Functions.getCountrySettings(L.correctedCountry);
		SELF.result := R;
		SELF:=[];
	END;

	hashTable := PROJECT(inputReq,getHashValues(LEFT));

	seedFile := JOIN(hashTable,Key_IntlIID_GG2,  
							KEYED(RIGHT.DatasetName=LEFT.DatasetName) AND 
							KEYED(RIGHT.hashvalue=Hash_IntlIID(LEFT.hashFirstName,LEFT.hashLastName,LEFT.hashNationalID,LEFT.hashPostalCode,LEFT.hashTelephone)), 
							getIntlIIDSeeds(LEFT,RIGHT),LEFT OUTER,KEEP(1));			

	// OUTPUT(PROJECT(hashTable,TRANSFORM(hashValues,
		// SELF.hashValue:=Hash_IntlIID(LEFT.hashFirstName,LEFT.hashLastName,LEFT.hashNationalID,LEFT.hashPostalCode,LEFT.hashTelephone),SELF:=LEFT)));
	RETURN seedFile;
END;