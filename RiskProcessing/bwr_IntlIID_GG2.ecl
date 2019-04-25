#WORKUNIT('NAME','Intl ID GG2 IVI Score');

IMPORT IntlIID_GG2,iesp,Gateway,riskwise;

inputRec := RECORD
  STRING Account;
	UNICODE FirstName;
	UNICODE MiddleName;
	UNICODE MaidenName;
	UNICODE LastName;
	UNICODE FirstSurname;
	UNICODE SecondSurname;
	UNICODE GivenNames;
	UNICODE Surname;
	UNICODE FirstInitial;
	UNICODE MiddleInitial;
	UNICODE GivenInitials;
	STRING1 Gender;
	STRING4 YearOfBirth;
	STRING2 MonthOfBirth;
	STRING2 DayOfBirth;
	UNICODE Address1;
	UNICODE Address2;
	STRING StreetNumber;
	STRING HouseNumber;
	STRING CivicNumber;
	UNICODE AreaNumbers;
	UNICODE StreetName;
	UNICODE StreetType;
	UNICODE BuildingName;
	UNICODE BuildingNumber;
	STRING BlockNumber;
	STRING UnitNumber;
	STRING RoomNumber;
	UNICODE HouseExtension;
	STRING FloorNumber;
	UNICODE Suburb;
	UNICODE City;
	UNICODE Aza;
	UNICODE Municipality;
	UNICODE State;
	UNICODE Province;
	UNICODE County;
	UNICODE District;
	UNICODE Prefecture;
	STRING PostalCode;
	STRING CountryCode;
	STRING Telephone;
	STRING CellNumber;
	STRING WorkTelephone;
	STRING RTACardNumber;
	STRING SocialInsuranceNumber;
	STRING HongKongIDNumber;
	STRING PersonalPublicServiceNumber;
	STRING CURPIDNumber;
	UNICODE StateOfBirth;
	STRING NRICNumber;
	STRING NHSNumber;
	STRING NationalIDNumber;
	UNICODE CityOfIssue;
	UNICODE CountyOfIssue;
	UNICODE DistrictOfIssue;
	UNICODE ProvinceOfIssue;
	STRING DriverLicenceNumber;
	STRING DriverLicenceVersionNumber;
	STRING DriverLicenceState;
	STRING4 YearOfExpiry;
	STRING2 MonthOfExpiry;
	STRING2 DayOfExpiry;
	STRING PassportNumber;
	STRING PassportFullName;
	STRING PassportMRZLine1;
	STRING PassportMRZLine2;
	STRING PassportCountry;
	UNICODE PlaceOfBirth;
	UNICODE CountryOfBirth;
	UNICODE FamilyNameAtBirth;
	UNICODE FamilyNameAtCitizenship;
	STRING4 PassportYearOfExpiry;
	STRING2 PassportMonthOfExpiry;
	STRING2 PassportDayOfExpiry;
	STRING MedicareNumber;
	STRING MedicareReference;
	BOOLEAN AustraliaDriverLicence;
	BOOLEAN AustraliaMedicare;
	BOOLEAN AustraliaPassport;
	BOOLEAN AustralianElectoralRoll;
	BOOLEAN NewZealandDriverLicence;
  STRING IPAddress;
	STRING VisaMRZLine1;
	STRING VisaMRZLine2;
  // options
	BOOLEAN PassportValidationOnly;
	BOOLEAN VisaValidationOnly;
	BOOLEAN IncludeOFAC;
	BOOLEAN IncludeOtherWatchLists;
	BOOLEAN UseDOBFilter;
	INTEGER DOBRadius;
	STRING GlobalWatchlistThreshold;
	STRING WatchList1;
	STRING WatchList2;
	STRING WatchList3;
	STRING WatchList4;
	STRING WatchList5;
	STRING WatchList6;
	STRING WatchList7;
END;

input_file := '~bweiner::in::iidi_test_in_1405014';
output_file := '~bweiner::out::iidi_testrecs_out_20140519';

iesp.gg2_iid_intl.t_InstantIDIntl2Request toGG2Request(inputRec L,INTEGER seqNum) := TRANSFORM
	// SELF.User.ReferenceCode:='12345';
	// SELF.User.BillingCode:='54321';
	SELF.User.QueryId:= L.Account;
	SELF.User.AccountNumber:=''; // Account Number goes here
	SELF.Options.IncludeOFAC:=L.IncludeOFAC;
	SELF.Options.IncludeOtherWatchLists:=L.IncludeOtherWatchLists;
	SELF.Options.UseDOBFilter:=L.UseDOBFilter;
	SELF.Options.DOBRadius:=L.DOBRadius;
	SELF.Options.GlobalWatchlistThreshold:=L.GlobalWatchlistThreshold;
	SELF.Options.WatchList:=DATASET([{L.WatchList1},{L.WatchList2},{L.WatchList3},{L.WatchList4},{L.WatchList5},{L.WatchList6},{L.WatchList7}],iesp.share.t_StringArrayItem);
	SELF.Options.PassportValidationOnly:=L.PassportValidationOnly;
	SELF.Options.VisaValidationOnly:=L.VisaValidationOnly;
	                             //======================================================================================================
	SELF.Options.SubAccount:=''; //This is a REQUIRED FIELD, enter the SubAccount number here. Here is the dev account number: 11093677.
	                             //======================================================================================================
	SELF.SearchBy.Country:=L.CountryCode;
	SELF.SearchBy.AustraliaVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.AU,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_AustraliaVerification,
			SELF.Passport:=PROJECT(L,TRANSFORM(iesp.gg2_verify.t_AustraliaPassport,SELF:=LEFT)),
			SELF.Consents:=PROJECT(L,TRANSFORM(iesp.gg2_verify.t_AustraliaDSConsent,SELF:=LEFT)),
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.AustriaVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.AT,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_AustriaVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.BrazilVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.BR,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_BrazilVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.CanadaVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.CA,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_CanadaVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.ChinaVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.CN,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_ChinaVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.GermanyVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.DE,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_GermanyVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.HongKongVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.HK,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_HongKongVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.IrelandVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.IE,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_IrelandVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.JapanVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.JP,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_JapanVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.LuxembourgVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.LU,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_LuxembourgVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.MexicoVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.MX,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_MexicoVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.NetherlandsVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.NL,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_NetherlandsVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.NewZealandVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.NZ,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_NewZealandVerification,
			SELF.Consents:=PROJECT(L,TRANSFORM(iesp.gg2_verify.t_NewZealandDSConsent,SELF:=LEFT)),
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.SingaporeVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.SG,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_SingaporeVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.SouthAfricaVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.ZA,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_SouthAfricaVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.SwitzerlandVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.CH,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_SwitzerlandVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.UnitedKingdomVerification:=IF(L.CountryCode=IntlIID_GG2.Constants.GB,
		PROJECT(L,TRANSFORM(iesp.gg2_verify.t_UnitedKingdomVerification,
			SELF:=LEFT,SELF:=[])));
	SELF.SearchBy.Gender:=L.Gender;
	SELF.SearchBy.PassportInfo.MachineReadableLine1:=L.PassportMRZLine1;
	SELF.SearchBy.PassportInfo.MachineReadableLine2:=L.PassportMRZLine2;
	SELF.SearchBy.VisaInfo.MachineReadableLine1:=L.VisaMRZLine1;
	SELF.SearchBy.VisaInfo.MachineReadableLine2:=L.VisaMRZLine2;
	SELF.SearchBy.IPAddress:=L.IPAddress;
	SELF.AcceptTermsAndConditions:=TRUE;
	SELF:=[];
END;

input := DATASET(input_file, inputRec, CSV(QUOTE('"')));
// input := DATASET([
	// {'01','JOHN','HENRY','','SMITH','','','','','','','','M','1983','3','5','','','10','','','','LAWFORD','ST','','','','3','','','','DONCASTER','','','','VIC','','','','','3108','AU','03 9896 8785','','','','','','','','','','','','','','','','076310691','','VIC','2014','4','3','N1236548','','','','AU','MELBOURNE','AU','SMITH','SMITH','2014','4','3','5643513953','2',TRUE,TRUE,TRUE,TRUE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'02','LUKAS','','','BERGER','','','','','','','','','1988','8','4','','','','12','','','UNT FELDSTR','','','','','','','','','','INNSBRUCK','','','','','','','','8326','AT','948371694','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'03','JOSE AFONSO','','','SILVA SANTOS','','','','','','','','M','1978','6','13','RUA DOM HENRIQUE, 101, AP 234','','','','','','','','','','','','','','','VILA PERI','FORTALEZA','','','CE','','','','','60730-120','BR','12345678','','','','','','','','','','','123.456.789-92','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'04','SUSAN','','','MITCHELL','','','','','','','','','1966','7','9','','','','','203','','LYNNVIEW','RD SE','','','','','','','','','','','CALGARY','','AB','','','','T2C2C6','CA','7804685132','','','','865148654','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'05','','','','','','',U'言明',U'胡','','','','','1976','6','5','','','34','','','',U'斗门',U'路',U'梦怡轩',U'5棟','','','505','','','',U'珠海','','','',U'广东','',U'香洲','','','CN','87513544','','','','','','','','','','','440861896421345987',U'珠海','',U'香洲',U'广东','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'06','HANZ','','','BERGER','','','','','','','','M','1988','8','4','','','','24','','','UNT FELDSTR','','','','','','','','','','PITTEN','','','','','','','','8266','DE','948371694','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'07','ANDREW','','','ALLEN','','','','','','','','','2012','12','12','','','','','','','QUEEN\'S ROAD CENTRAL','','CHEUNG KONG CENTER','2','','68/F','','','','','HONG KONG','','','','','','KOWLOON','','','HK','1234 5678','','','','','A234456','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'08','JUSTIN','JOHN','','WILLIAMS','','','','','','','','','1988','8','4','513 SAINT MARYS PARK','','','','','','','','','','','','','','','','CARLOW','','','','','CARLOW','','','','IE','5997864564','','','','','','1234567TW','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'09',U'健太','','','','','','',U'山本','','','','M','1980','12','7','','','','','',U'９００－２０１','','',U'旭ケ丘１－１０－１－３０６','','','','','','','','',U'和倉町ヨ',U'七尾市','','','','',U'石川県','100-8994','JP','845313','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'10','LUIS','','','SANTER','','','','','','','','','2012','12','12','','','','68','','','RUE DE STRASBOURG','','','','','','','','','','LUXEMBOURG','','','','','','','','2560','LU','6251140504','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'11','JOSE','','','','SANTANO','MARTINEZ','','','','','','M','2012','12','12','68 CONSUELO','','','','','','','','','','','','','','','','HERMOSILLO','','','SONORA','','','','','83010','MX','6251140504','','','','','','','HEGG560427MVZRRL05','SONORA','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'12','','','','BAKX','','','MELLISA ANNE LAUREN','','','','','','1983','11','21','','','','3','','','MEERKOETSTRAAT','','','','','','','','','','BREDA','','','','','','','','3827BE','NL','106511294','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'13','SNOW','WHITE','','HUNTSMAN','','','','','','','','','1976','3','6','','','','2','','','RIVERGLADE','DRIVE','','','','25D','','','','HAMILTON','HAMILTON','','','','','','','','3284','NZ','78475332','','','','','','','','','','','','','','','','8465341','3','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,TRUE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'14','HARRY','','','KIM','','','','','','','','','1944','4','4','','','5','','','','CLEMENTI','AVENUE','','','347','','','','','','','','','','','','','','120347','SG','897653264','','','','','','','','','S6971548E','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'15','LUKAS','','','KENNY','','','','','','','','','1976','3','4','56 RODONDO ROAD','','','','','','','','','','','','','','','PRETORIA','PRETORIA','','','','EASTERN CAPE','','','','9585','ZA','258375948','835237129','235784592','','','','','','','','','8001015009087','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'16','LUKAS','','','GRUBER','','','','','','','','','1988','8','4','','','','','','','DENKMASCHINENSTRASSE','','','3','','','','','','','ZÜRICH','','','','','','','','8266','CH','948371694','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'17','JULIA','','','AUDI','','','','','','','','','1979','10','26','','','','','','','MOORFOOT','WAY','BECK','12','','1','','','','','LIVERPOOL','','','','','','','','L33 1WZ','GB','865413985','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'18','PASSPORT','VALIDATION','','ONLY','','','','','','','','M','1976','7','4','','','','','','','','','','','','','','','','','','','','','','','','','','AU','','','','','','','','','','','','','','','','','','','','','','','','','PPUSADANDY<<YANKEE<DOODLE<<<<<<<<<<<<<<<<<<<','AMERICAN<4USA7607040M2607045PATRIOT<<<<<<<44','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',TRUE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'19','VISA','VALIDATION','','ONLY','','','','','','','','M','1976','7','4','','','','','','','','','','','','','','','','','','','','','','','','','','AU','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','VPUSADANDY<<YANKEE<DOODLE<<<<<<<<<<<<<<<<<<<','AMERICAN<4USA7607040M2607045PATRIOT<<<<<<<44',FALSE,TRUE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'20','IP','ADDRESS','','INFO','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','AU','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',TRUE,TRUE,TRUE,TRUE,FALSE,'138.12.4.174','','',FALSE,FALSE,FALSE,FALSE,FALSE,0,'','','','','','','',''},
	// {'21','YASIN','','','CHOUKA','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','DE','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',FALSE,FALSE,FALSE,FALSE,FALSE,'','','',FALSE,FALSE,TRUE,TRUE,FALSE,0,'0.84','FCEN','IMW','OFAC','OSFI','SDT','BIS','UNNT'},
	// {'22','JAY','DONALD','','HASTINGS','','','','','','','','M','1976','7','4','','','','','','','','','','','','','','','','','','','','','','','','','','AU','','','','','','','','','','','','','','','','','','','','','','','','','PPUSADANDY<<YANKEE<DOODLE<<<<<<<<<<<<<<<<<<<','AMERICAN<4USA7607040M2607045PATRIOT<<<<<<<44','','','','','','','','','','',TRUE,TRUE,TRUE,TRUE,FALSE,'138.12.4.174','VPUSADANDY<<YANKEE<DOODLE<<<<<<<<<<<<<<<<<<<','AMERICAN<4USA7607040M2607045PATRIOT<<<<<<<44',FALSE,FALSE,TRUE,TRUE,FALSE,0,'0.84','FCEN','IMW','OFAC','OSFI','SDT','BIS','UNNT'}
// ],inputRec);

gg2Req := PROJECT(input,toGG2Request(LEFT,COUNTER));

gateways := DATASET([
	{'gg2verification','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/WsGatewayEx/?ver_=1.7','',[]},
	{'netacuity','http://rw_score_dev:Password01@rwgatewaycert.sc.seisint.com:7726/WsGateway/?ver_=1.93','',[]}
],Gateway.Layouts.Config);

OUTPUT(input,NAMED('input'));
OUTPUT(gg2Req,NAMED('gg2Req'));
OUTPUT(gateways,NAMED('gateways'));

soapRec := RECORD
	DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Request) InstantIDIntl2Request;
	DATASET(Gateway.Layouts.Config)	gateways;
END;

extResp := RECORD
	(iesp.gg2_iid_intl.t_InstantIDIntl2Response)
	iesp.share.t_WsException.Code;
	iesp.share.t_WsException.Message;
END;

extResp failX(soapRec L) := TRANSFORM
	SELF.Code := FAILCODE;
	SELF.Message := FAILMESSAGE;
	SELF := L;
	SELF := [];
END;

// roxieIP := riskwise.shortcuts.QA_neutral_roxieIP;
roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;

soapReq := DISTRIBUTE(PROJECT(gg2Req,TRANSFORM(soapRec,SELF.InstantIDIntl2Request:=LEFT,SELF.gateways:=gateways)), RANDOM()); 
soapResp := SOAPCALL(soapReq,roxieIP,'IntlIID_GG2.SearchService',
	{soapReq},DATASET(extResp),ONFAIL(failX(LEFT)),
	RETRY(0),TIMEOUT(300),TRIM,LOG);

OUTPUT(roxieIP,NAMED('roxieIP'));
OUTPUT(soapReq,NAMED('soapReq'));
OUTPUT(soapResp,NAMED('soapResp'));

LOADXML('<xml/>');

// 4 datasets to flatten
#DECLARE(riskIndicatorsCnt);
#DECLARE(verificationResultsCnt);
#DECLARE(datasourceResultsCnt);
#DECLARE(appendedFieldsCnt);

// # of flattened dataset records
#SET(riskIndicatorsCnt,4); // China static test has 4 risk indicators
#SET(verificationResultsCnt,35); // Australia static test has 35 verification results
#SET(datasourceResultsCnt,13); // Australia static test has 13 data source results
#SET(appendedFieldsCnt,4); // United Kingdom static test has 4 appended field results

#DECLARE(defineRiskIndicators);
#SET(defineRiskIndicators,'');
#DECLARE(assignRiskIndicators);
#SET(assignRiskIndicators,'');
#DECLARE(riCnt);
#SET(riCnt,1);
#LOOP
	#IF(%riCnt% > %riskIndicatorsCnt%)
		#BREAK;
	#ELSE
		#APPEND(defineRiskIndicators,
			'STRING4 RiskCode_'      + %'riCnt'% + ';' +
			'STRING150 Description_' + %'riCnt'% + ';' );
		#APPEND(assignRiskIndicators,
			'SELF.RiskCode_'    + %'riCnt'% + ':=L.Result.RiskIndicators[' + %'riCnt'% + '].RiskCode;'    +
			'SELF.Description_' + %'riCnt'% + ':=L.Result.RiskIndicators[' + %'riCnt'% + '].Description;' );
		#SET(riCnt,%riCnt% + 1)
	#END
#END

#DECLARE(defineVerificationResults);
#SET(defineVerificationResults,'');
#DECLARE(assignVerificationResults);
#SET(assignVerificationResults,'');
#DECLARE(vrCnt);
#SET(vrCnt,1);
#LOOP
	#IF(%vrCnt% > %verificationResultsCnt%)
		#BREAK;
	#ELSE
		#APPEND(defineVerificationResults,
			'STRING30 FieldName_' + %'vrCnt'% + ';' +
			'BOOLEAN IsVerified_' + %'vrCnt'% + ';' +
			'INTEGER Count_'      + %'vrCnt'% + ';' );
		#APPEND(assignVerificationResults,
			'SELF.FieldName_'  + %'vrCnt'% + ':=L.Result.VerificationResults[' + %'vrCnt'% + '].FieldName;'  +
			'SELF.IsVerified_' + %'vrCnt'% + ':=L.Result.VerificationResults[' + %'vrCnt'% + '].IsVerified;' +
			'SELF.Count_'      + %'vrCnt'% + ':=L.Result.VerificationResults[' + %'vrCnt'% + '].Count;'      );
		#SET(vrCnt,%vrCnt% + 1)
	#END
#END

#DECLARE(defineDatasourceResults);
#SET(defineDatasourceResults,'');
#DECLARE(assignDatasourceResults);
#SET(assignDatasourceResults,'');
#DECLARE(drCnt);
#SET(drCnt,1);
#LOOP
	#IF(%drCnt% > %datasourceResultsCnt%)
		#BREAK;
	#ELSE
		#APPEND(defineDatasourceResults,
			'STRING64 DatasourceName_'              + %'drCnt'% + ';' +
			'STRING8  DatasourceStatus_'            + %'drCnt'% + ';' +
			'STRING8  Code_'                        + %'drCnt'% + ';' +
			'STRING64 Message_'                     + %'drCnt'% + ';' +
			'STRING8  FirstName_'                   + %'drCnt'% + ';' +
			'STRING8  MiddleName_'                  + %'drCnt'% + ';' +
			'STRING8  LastName_'                    + %'drCnt'% + ';' +
			'STRING8  GivenNames_'                  + %'drCnt'% + ';' +
			'STRING8  Surname_'                     + %'drCnt'% + ';' +
			'STRING8  FirstSurname_'                + %'drCnt'% + ';' +
			'STRING8  SecondSurname_'               + %'drCnt'% + ';' +
			'STRING8  MaidenName_'                  + %'drCnt'% + ';' +
			'STRING8  FirstInitial_'                + %'drCnt'% + ';' +
			'STRING8  MiddleInitial_'               + %'drCnt'% + ';' +
			'STRING8  GivenInitials_'               + %'drCnt'% + ';' +
			'STRING8  Gender_'                      + %'drCnt'% + ';' +
			'STRING8  YearOfBirth_'                 + %'drCnt'% + ';' +
			'STRING8  MonthOfBirth_'                + %'drCnt'% + ';' +
			'STRING8  DayOfBirth_'                  + %'drCnt'% + ';' +
			'STRING8  Address1_'                    + %'drCnt'% + ';' +
			'STRING8  Address2_'                    + %'drCnt'% + ';' +
			'STRING8  StreetNumber_'                + %'drCnt'% + ';' +
			'STRING8  HouseNumber_'                 + %'drCnt'% + ';' +
			'STRING8  CivicNumber_'                 + %'drCnt'% + ';' +
			'STRING8  AreaNumbers_'                 + %'drCnt'% + ';' +
			'STRING8  StreetName_'                  + %'drCnt'% + ';' +
			'STRING8  StreetType_'                  + %'drCnt'% + ';' +
			'STRING8  BuildingName_'                + %'drCnt'% + ';' +
			'STRING8  BuildingNumber_'              + %'drCnt'% + ';' +
			'STRING8  BlockNumber_'                 + %'drCnt'% + ';' +
			'STRING8  UnitNumber_'                  + %'drCnt'% + ';' +
			'STRING8  RoomNumber_'                  + %'drCnt'% + ';' +
			'STRING8  HouseExtension_'              + %'drCnt'% + ';' +
			'STRING8  FloorNumber_'                 + %'drCnt'% + ';' +
			'STRING8  Suburb_'                      + %'drCnt'% + ';' +
			'STRING8  Aza_'                         + %'drCnt'% + ';' +
			'STRING8  City_'                        + %'drCnt'% + ';' +
			'STRING8  Municipality_'                + %'drCnt'% + ';' +
			'STRING8  Province_'                    + %'drCnt'% + ';' +
			'STRING8  County_'                      + %'drCnt'% + ';' +
			'STRING8  State_'                       + %'drCnt'% + ';' +
			'STRING8  District_'                    + %'drCnt'% + ';' +
			'STRING8  Prefecture_'                  + %'drCnt'% + ';' +
			'STRING8  PostalCode_'                  + %'drCnt'% + ';' +
			'STRING8  CountryCode_'                 + %'drCnt'% + ';' +
			'STRING8  Telephone_'                   + %'drCnt'% + ';' +
			'STRING8  CellNumber_'                  + %'drCnt'% + ';' +
			'STRING8  WorkTelephone_'               + %'drCnt'% + ';' +
			'STRING8  RTACardNumber_'               + %'drCnt'% + ';' +
			'STRING8  SocialInsuranceNumber_'       + %'drCnt'% + ';' +
			'STRING8  NationalIDNumber_'            + %'drCnt'% + ';' +
			'STRING8  HongKongIDNumber_'            + %'drCnt'% + ';' +
			'STRING8  PersonalPublicServiceNumber_' + %'drCnt'% + ';' +
			'STRING8  CURPIDNumber_'                + %'drCnt'% + ';' +
			'STRING8  StateOfBirth_'                + %'drCnt'% + ';' +
			'STRING8  NricNumber_'                  + %'drCnt'% + ';' +
			// 'STRING8  NHSNumber_'                   + %'drCnt'% + ';' +
			'STRING8  CityOfIssue_'                 + %'drCnt'% + ';' +
			'STRING8  CountyOfIssue_'               + %'drCnt'% + ';' +
			'STRING8  DistrictOfIssue_'             + %'drCnt'% + ';' +
			'STRING8  ProvinceOfIssue_'             + %'drCnt'% + ';' +
			'STRING8  DriverLicenceNumber_'         + %'drCnt'% + ';' +
			'STRING8  DriverLicenceVersionNumber_'  + %'drCnt'% + ';' +
			'STRING8  DriverLicenceState_'          + %'drCnt'% + ';' +
			'STRING8  YearOfExpiry_'                + %'drCnt'% + ';' +
			'STRING8  MonthOfExpiry_'               + %'drCnt'% + ';' +
			'STRING8  DayOfExpiry_'                 + %'drCnt'% + ';' +
			'STRING8  PassportNumber_'              + %'drCnt'% + ';' +
			// 'STRING8  PassportFullName_'            + %'drCnt'% + ';' +
			// 'STRING8  PassportMRZLine1_'            + %'drCnt'% + ';' +
			// 'STRING8  PassportMRZLine2_'            + %'drCnt'% + ';' +
			'STRING8  PassportCountry_'             + %'drCnt'% + ';' +
			'STRING8  PlaceOfBirth_'                + %'drCnt'% + ';' +
			'STRING8  CountryOfBirth_'              + %'drCnt'% + ';' +
			'STRING8  FamilyNameAtBirth_'           + %'drCnt'% + ';' +
			'STRING8  FamilyNameAtCitizenship_'     + %'drCnt'% + ';' +
			'STRING8  PassportYearOfExpiry_'        + %'drCnt'% + ';' +
			'STRING8  PassportMonthOfExpiry_'       + %'drCnt'% + ';' +
			'STRING8  PassportDayOfExpiry_'         + %'drCnt'% + ';' +
			'STRING8  MedicareNumber_'              + %'drCnt'% + ';' +
			'STRING8  MedicareReference_'           + %'drCnt'% + ';' );
		#APPEND(assignDatasourceResults,
			'SELF.DatasourceName_'              + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceName;'                               +
			'SELF.DatasourceStatus_'            + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceStatus;'                             +
			'SELF.Code_'                        + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].Errors[1].Code;'                               +
			'SELF.Message_'                     + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].Errors[1].Message;'                            +
			'SELF.FirstName_'                   + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.FirstName;'                   +
			'SELF.MiddleName_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MiddleName;'                  +
			'SELF.LastName_'                    + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.LastName;'                    +
			'SELF.GivenNames_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.GivenNames;'                  +
			'SELF.Surname_'                     + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Surname;'                     +
			'SELF.FirstSurname_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.FirstSurname;'                +
			'SELF.SecondSurname_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.SecondSurname;'               +
			'SELF.MaidenName_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MaidenName;'                  +
			'SELF.FirstInitial_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.FirstInitial;'                +
			'SELF.MiddleInitial_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MiddleInitial;'               +
			'SELF.GivenInitials_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.GivenInitials;'               +
			'SELF.Gender_'                      + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Gender;'                      +
			'SELF.YearOfBirth_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.YearOfBirth;'                 +
			'SELF.MonthOfBirth_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MonthOfBirth;'                +
			'SELF.DayOfBirth_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.DayOfBirth;'                  +
			'SELF.Address1_'                    + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Address1;'                    +
			'SELF.Address2_'                    + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Address2;'                    +
			'SELF.StreetNumber_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.StreetNumber;'                +
			'SELF.HouseNumber_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.HouseNumber;'                 +
			'SELF.CivicNumber_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CivicNumber;'                 +
			'SELF.AreaNumbers_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.AreaNumbers;'                 +
			'SELF.StreetName_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.StreetName;'                  +
			'SELF.StreetType_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.StreetType;'                  +
			'SELF.BuildingName_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.BuildingName;'                +
			'SELF.BuildingNumber_'              + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.BuildingNumber;'              +
			'SELF.BlockNumber_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.BlockNumber;'                 +
			'SELF.UnitNumber_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.UnitNumber;'                  +
			'SELF.RoomNumber_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.RoomNumber;'                  +
			'SELF.HouseExtension_'              + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.HouseExtension;'              +
			'SELF.FloorNumber_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.FloorNumber;'                 +
			'SELF.Suburb_'                      + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Suburb;'                      +
			'SELF.Aza_'                         + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Aza;'                         +
			'SELF.City_'                        + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.City;'                        +
			'SELF.Municipality_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Municipality;'                +
			'SELF.Province_'                    + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Province;'                    +
			'SELF.County_'                      + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.County;'                      +
			'SELF.State_'                       + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.State;'                       +
			'SELF.District_'                    + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.District;'                    +
			'SELF.Prefecture_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Prefecture;'                  +
			'SELF.PostalCode_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PostalCode;'                  +
			'SELF.CountryCode_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CountryCode;'                 +
			'SELF.Telephone_'                   + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.Telephone;'                   +
			'SELF.CellNumber_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CellNumber;'                  +
			'SELF.WorkTelephone_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.WorkTelephone;'               +
			'SELF.RTACardNumber_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.RTACardNumber;'               +
			'SELF.SocialInsuranceNumber_'       + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.SocialInsuranceNumber;'       +
			'SELF.NationalIDNumber_'            + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.NationalIDNumber;'            +
			'SELF.HongKongIDNumber_'            + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.HongKongIDNumber;'            +
			'SELF.PersonalPublicServiceNumber_' + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PersonalPublicServiceNumber;' +
			'SELF.CURPIDNumber_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CURPIDNumber;'                +
			'SELF.StateOfBirth_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.StateOfBirth;'                +
			'SELF.NricNumber_'                  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.NricNumber;'                  +
			// 'SELF.NHSNumber_'                   + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.NHSNumber;'                   +
			'SELF.CityOfIssue_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CityOfIssue;'                 +
			'SELF.CountyOfIssue_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CountyOfIssue;'               +
			'SELF.DistrictOfIssue_'             + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.DistrictOfIssue;'             +
			'SELF.ProvinceOfIssue_'             + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.ProvinceOfIssue;'             +
			'SELF.DriverLicenceNumber_'         + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.DriverLicenceNumber;'         +
			'SELF.DriverLicenceVersionNumber_'  + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.DriverLicenceVersionNumber;'  +
			'SELF.DriverLicenceState_'          + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.DriverLicenceState;'          +
			'SELF.YearOfExpiry_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.YearOfExpiry;'                +
			'SELF.MonthOfExpiry_'               + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MonthOfExpiry;'               +
			'SELF.DayOfExpiry_'                 + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.DayOfExpiry;'                 +
			'SELF.PassportNumber_'              + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportNumber;'              +
			// 'SELF.PassportFullName_'            + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportFullName;'            +
			// 'SELF.PassportMRZLine1_'            + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportMRZLine1;'            +
			// 'SELF.PassportMRZLine2_'            + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportMRZLine2;'            +
			'SELF.PassportCountry_'             + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportCountry;'             +
			'SELF.PlaceOfBirth_'                + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PlaceOfBirth;'                +
			'SELF.CountryOfBirth_'              + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.CountryOfBirth;'              +
			'SELF.FamilyNameAtBirth_'           + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.FamilyNameAtBirth;'           +
			'SELF.FamilyNameAtCitizenship_'     + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.FamilyNameAtCitizenship;'     +
			'SELF.PassportYearOfExpiry_'        + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportYearOfExpiry;'        +
			'SELF.PassportMonthOfExpiry_'       + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportMonthOfExpiry;'       +
			'SELF.PassportDayOfExpiry_'         + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.PassportDayOfExpiry;'         +
			'SELF.MedicareNumber_'              + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MedicareNumber;'              +
			'SELF.MedicareReference_'           + %'drCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'drCnt'% + '].DatasourceFields.MedicareReference;'           );
		#SET(drCnt,%drCnt% + 1)
	#END
#END

#DECLARE(defineAppendedFields);
#SET(defineAppendedFields,'');
#DECLARE(assignAppendedFields);
#SET(assignAppendedFields,'');
#DECLARE(afCnt);
#SET(afCnt,1);
#LOOP
	#IF(%afCnt% > %appendedFieldsCnt%)
		#BREAK;
	#ELSE
		#APPEND(defineAppendedFields,
			'STRING32 FieldName_0' + %'afCnt'% + ';' +
			'STRING8 Value_0'      + %'afCnt'% + ';' );
		#APPEND(assignAppendedFields,
			'SELF.FieldName_0' + %'afCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'afCnt'% + '].AppendedFields[1].FieldName;' +
			'SELF.Value_0'     + %'afCnt'% + ':=L.Result.VerificationRecord.DatasourceResults[' + %'afCnt'% + '].AppendedFields[1].Value;'     );
		#SET(afCnt,%afCnt% + 1)
	#END
#END

flatWatchListRec := RECORD
	STRING WL_Table;
	STRING WL_RecordNumber;
	STRING WL_Full;
	STRING WL_First;
	STRING WL_Middle;
	STRING WL_Last;
	STRING WL_Suffix;
	STRING WL_Prefix;
	STRING WL_StreetNumber;
	STRING WL_StreetPreDirection;
	STRING WL_StreetName;
	STRING WL_StreetSuffix;
	STRING WL_StreetPostDirection;
	STRING WL_UnitDesignation;
	STRING WL_UnitNumber;
	STRING WL_StreetAddress1;
	STRING WL_StreetAddress2;
	STRING WL_City;
	STRING WL_State;
	STRING WL_Zip5;
	STRING WL_Zip4;
	STRING WL_County;
	STRING WL_PostalCode;
	STRING WL_StateCityZip;
	STRING WL_Country;
	STRING WL_EntityName;
	INTEGER WL_Sequence;
END;

flatIPAddressRec := RECORD
	STRING IP_Continent;
	STRING IP_Country;
	STRING IP_RoutingType;
	STRING IP_TopLevelDomain;
	STRING IP_SecondLevelDomain;
	STRING IP_City;
	STRING IP_RegionDescription;
	STRING IP_Latitude;
	STRING IP_Longitude;
END;

flatRec := RECORD
	// header and billing info 
	iesp.share.t_ResponseHeader.QueryId;
	iesp.share.t_ResponseHeader.Status;
	iesp.gg2_iid_intl.t_InstantIDIntlResult.IsBillable;
	iesp.gg2_iid_intl.t_InstantIDIntlResult.BillingCountry;
	iesp.gg2_iid_intl.t_InstantIDIntlResult.BillingCountryCode;
	// errors and exceptions
	INTEGER errorCode;
	STRING256 errorMessage;
	iesp.share.t_WsException.Source;
	iesp.share.t_WsException.Code;
	iesp.share.t_WsException.Location;
	iesp.share.t_WsException.Message;
	// input echo
	inputRec;
	// risk indicators dataset
	%defineRiskIndicators%
	// verification results
	iesp.gg2_iid_intl.t_InstantIDIntlResult.InternationalVerificationIndex;
	iesp.gg2_iid_intl.t_InstantIDIntlResult.ComplianceLevel;
	iesp.gg2_iid_intl.t_InstantIDIntlResult.PassportNumberValidated;
	iesp.gg2_iid_intl.t_InstantIDIntlResult.VisaNumberValidated;
	// watchlist results
	flatWatchListRec;
	// IP address results
	flatIPAddressRec;
	// verification results dataset
	%defineVerificationResults%
	// datasource results dataset
	%defineDatasourceResults%
	// appended fields dataset
	%defineAppendedFields%
END;

flatRec flatten(extResp L,inputRec R) := TRANSFORM
	SELF.Account := L._Header.QueryId;
	// header and billing info
	SELF.QueryId:=L._Header.QueryId;
	SELF.Status:=L._Header.Status;
	SELF.IsBillable:=L.Result.IsBillable;
	SELF.BillingCountry:=L.Result.BillingCountry;
	SELF.BillingCountryCode:=L.Result.BillingCountryCode;
	// errors and exceptions
	SELF.errorCode:=L.Code;
	SELF.errorMessage:=L.Message;
	SELF.Source:=L._Header.Exceptions[1].Source;
	SELF.Code:=L._Header.Exceptions[1].Code;
	SELF.Location:=L._Header.Exceptions[1].Location;
	SELF.Message:=L._Header.Exceptions[1].Message;
	// risk indicators dataset
	%assignRiskIndicators%
	// verification results
	SELF.InternationalVerificationIndex:=L.Result.InternationalVerificationIndex;
	SELF.ComplianceLevel:=L.Result.ComplianceLevel;
	SELF.PassportNumberValidated:=L.Result.PassportNumberValidated;
	SELF.VisaNumberValidated:=L.Result.VisaNumberValidated;
	// watchlist results
	SELF.WL_Table:=L.Result.WatchList.Table;
	SELF.WL_RecordNumber:=L.Result.WatchList.RecordNumber;
	SELF.WL_Full:=L.Result.WatchList.Name.Full;
	SELF.WL_First:=L.Result.WatchList.Name.First;
	SELF.WL_Middle:=L.Result.WatchList.Name.Middle;
	SELF.WL_Last:=L.Result.WatchList.Name.Last;
	SELF.WL_Suffix:=L.Result.WatchList.Name.Suffix;
	SELF.WL_Prefix:=L.Result.WatchList.Name.Prefix;
	SELF.WL_StreetNumber:=L.Result.WatchList.Address.StreetNumber;
	SELF.WL_StreetPreDirection:=L.Result.WatchList.Address.StreetPreDirection;
	SELF.WL_StreetName:=L.Result.WatchList.Address.StreetName;
	SELF.WL_StreetSuffix:=L.Result.WatchList.Address.StreetSuffix;
	SELF.WL_StreetPostDirection:=L.Result.WatchList.Address.StreetPostDirection;
	SELF.WL_UnitDesignation:=L.Result.WatchList.Address.UnitDesignation;
	SELF.WL_UnitNumber:=L.Result.WatchList.Address.UnitNumber;
	SELF.WL_StreetAddress1:=L.Result.WatchList.Address.StreetAddress1;
	SELF.WL_StreetAddress2:=L.Result.WatchList.Address.StreetAddress2;
	SELF.WL_City:=L.Result.WatchList.Address.City;
	SELF.WL_State:=L.Result.WatchList.Address.State;
	SELF.WL_Zip5:=L.Result.WatchList.Address.Zip5;
	SELF.WL_Zip4:=L.Result.WatchList.Address.Zip4;
	SELF.WL_County:=L.Result.WatchList.Address.County;
	SELF.WL_PostalCode:=L.Result.WatchList.Address.PostalCode;
	SELF.WL_StateCityZip:=L.Result.WatchList.Address.StateCityZip;
	SELF.WL_Country:=L.Result.WatchList.Country;
	SELF.WL_EntityName:=L.Result.WatchList.EntityName;
	SELF.WL_Sequence:=L.Result.WatchList.Sequence;
	// IP address results
	SELF.IP_Continent:=L.Result.IPAddressInfo.Continent;
	SELF.IP_Country:=L.Result.IPAddressInfo.Country;
	SELF.IP_RoutingType:=L.Result.IPAddressInfo.RoutingType;
	SELF.IP_TopLevelDomain:=L.Result.IPAddressInfo.TopLevelDomain;
	SELF.IP_SecondLevelDomain:=L.Result.IPAddressInfo.SecondLevelDomain;
	SELF.IP_City:=L.Result.IPAddressInfo.City;
	SELF.IP_RegionDescription:=L.Result.IPAddressInfo.RegionDescription;
	SELF.IP_Latitude:=L.Result.IPAddressInfo.Latitude;
	SELF.IP_Longitude:=L.Result.IPAddressInfo.Longitude;
	// verification results dataset
	%assignVerificationResults%
	// datasource results dataset
	%assignDatasourceResults%
	// appended fields
	%assignAppendedFields%
	// input options
	SELF.PassportValidationOnly:=R.PassportValidationOnly;
	SELF.VisaValidationOnly:=R.VisaValidationOnly;
	SELF.IncludeOFAC:=R.IncludeOFAC;
	SELF.IncludeOtherWatchLists:=R.IncludeOtherWatchLists;
	SELF.UseDOBFilter:=R.UseDOBFilter;
	SELF.DOBRadius:=R.DOBRadius;
	SELF.GlobalWatchlistThreshold:=R.GlobalWatchlistThreshold;
	SELF.WatchList1:=R.WatchList1;
	SELF.WatchList2:=R.WatchList2;
	SELF.WatchList3:=R.WatchList3;
	SELF.WatchList4:=R.WatchList4;
	SELF.WatchList5:=R.WatchList5;
	SELF.WatchList6:=R.WatchList6;
	SELF.WatchList7:=R.WatchList7;
	// input echo
	SELF.AustraliaDriverLicence:=L.Result.InputEcho.AustraliaVerification.Consents.AustraliaDriverLicence;
	SELF.AustraliaMedicare:=L.Result.InputEcho.AustraliaVerification.Consents.AustraliaMedicare;
	SELF.AustraliaPassport:=L.Result.InputEcho.AustraliaVerification.Consents.AustraliaPassport;
	SELF.AustralianElectoralRoll:=L.Result.InputEcho.AustraliaVerification.Consents.AustralianElectoralRoll;
	SELF.NewZealandDriverLicence:=L.Result.InputEcho.NewZealandVerification.Consents.NewZealandDriverLicence;
	SELF.Gender:=L.Result.InputEcho.Gender;
	SELF.PassportMRZLine1:=L.Result.InputEcho.PassportInfo.MachineReadableLine1;
	SELF.PassportMRZLine2:=L.Result.InputEcho.PassportInfo.MachineReadableLine2;
	SELF.VisaMRZLine1:=L.Result.InputEcho.VisaInfo.MachineReadableLine1;
	SELF.VisaMRZLine2:=L.Result.InputEcho.VisaInfo.MachineReadableLine2;
	SELF.IPAddress:=L.Result.InputEcho.IPAddress;
	SELF:=IntlIID_GG2.Functions.getSearchBySuperSet(PROJECT(L.Result.InputEcho,
		TRANSFORM(IntlIID_GG2.Layouts.ExtInputRequest,SELF.correctedCountryCode:=LEFT.Country,SELF.SearchBy:=LEFT,SELF:=[])));
	SELF:=[];
END;

flatResults := SORT(JOIN(soapResp,input,LEFT._Header.QueryId=RIGHT.Account,flatten(LEFT,RIGHT)),queryID);

OUTPUT(flatResults,NAMED('flatResults'));
OUTPUT(flatResults(errorcode=0),,output_file,CSV(HEADING,QUOTE('"')),OVERWRITE);
OUTPUT(flatResults(errorcode<>0),,output_file + '_errors',CSV(QUOTE('"')),OVERWRITE);
