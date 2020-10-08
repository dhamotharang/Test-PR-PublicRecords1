IMPORT ACA, ADVO, Business_Risk, Drivers, dx_header, MDR, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, USPIS_HotList, UT, STD, Doxie, Suppress;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_Address_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																					DATASET(Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries) Inquiries,
																																					UNSIGNED1 DPPAPurpose,
																																					UNSIGNED1 GLBPurpose,
																																					STRING50 DataRestrictionMask,
																																					doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

  todays_date := (string)STD.Date.Today();

	// Address Indexed Keys Used
	ADVOKey := ADVO.Key_Addr1;
	USPISKey := USPIS_HotList.Key_Addr_Search_ZIP;
	CriminalKey := ACA.Key_ACA_Addr;
	FullHeaderKey := dx_header.key_header_address();
	BusinessHeaderKey := Business_Risk.Key_Business_Header_Address;
	AddressRiskKey := Risk_Indicators.Key_HRI_Address_To_SIC;
	
	headerBuild := CHOOSEN(dx_header.key_max_dt_last_seen(), 1);
	headerBuildDate := (((STRING)headerBuild[1].Max_Date_Last_Seen)[1..6]) + '01';
	
	TempAddressRisk := RECORD
		UNSIGNED8 Seq 												:= 0;
		STRING120 StreetAddress1							:= '';
		STRING120	StreetAddress2							:= '';
		STRING25 City													:= '';
		STRING2 State													:= '';
		STRING9 Zip														:= '';
		STRING5 Zip5													:= '';
		STRING4 Zip4													:= '';
		STRING10 Prim_Range										:= '';
		STRING2 Predir												:= '';
		STRING28 Prim_Name										:= '';
		STRING4 Addr_Suffix										:= '';
		STRING2 Postdir												:= '';
		STRING10 Unit_Desig										:= '';
		STRING8 Sec_Range											:= '';
		STRING8 DateFirstSeen									:= '';
		UNSIGNED4 ArchiveDate									:= 0;
		BOOLEAN TransientCommercialIdentity		:= FALSE; // Sic_Code on AddressRiskKey <> ''
		BOOLEAN CorrectionalFacility					:= FALSE; // Sic_Code on AddressRiskKey = '2225'
		BOOLEAN USPIS_Hot_List								:= FALSE; // USPISHotList hit
		STRING100 USPIS_Comment								:= ''; // The RAW USPIS Hot List appended comment
		DATASET(Suspicious_Fraud_LN.layouts.USPISHotListRecs) USPISHotList := DATASET([], Suspicious_Fraud_LN.layouts.USPISHotListRecs);
		BOOLEAN USPIS_FalseIdentification			:= FALSE; // Comment indicated false identification
		BOOLEAN USPIS_IdentityTheft						:= FALSE; // Comment indicated identity theft
		BOOLEAN USPIS_FalseChangeOfAddress		:= FALSE; // Comment indicated a false change of address
		BOOLEAN USPIS_AccountTakeover					:= FALSE; // Comment indicated an account takeover
		BOOLEAN USPIS_FraudulentApplication		:= FALSE; // Comment indicated a fraudulent application
		BOOLEAN USPIS_FraudulentMail					:= FALSE; // Comment indicated fraudulent mail
		BOOLEAN USPIS_ATMDebitCardFraud				:= FALSE; // Comment indicated ATM/Debit card fraud
		BOOLEAN USPIS_FraudulentMerchandise		:= FALSE; // Comment indicated fraudulent merchandise
		BOOLEAN USPIS_FraudulentInvoice				:= FALSE; // Comment indicated fraudulent invoice
		BOOLEAN USPIS_MerchandiseReshipping		:= FALSE; // Comment indicated merchadise reshipping
		BOOLEAN USPIS_NewAccountFraud					:= FALSE; // Comment indicated new account fraud
		BOOLEAN USPIS_Reshipping							:= FALSE; // Comment indicated a reshipping scheme
		BOOLEAN USPIS_Vacant									:= FALSE; // Comment indicated address vacant
		BOOLEAN USPIS_OtherFraud							:= FALSE; // Comment indicated some other fraud scheme not in the above buckets
		BOOLEAN USPIS_Unknown									:= FALSE; // Comment blank but address on USPIS hot list
	END;
	
	TempAddressRisk getUSPISRecords(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, USPISKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.Clean_Input.StreetAddress1;
		SELF.StreetAddress2 := le.Clean_Input.StreetAddress2;
		SELF.City := le.Clean_Input.City;
		SELF.State := le.Clean_Input.State;
		SELF.Zip := le.Clean_Input.Zip;
		SELF.Zip5 := le.Clean_Input.Zip5;
		SELF.Zip4 := le.Clean_Input.Zip4;
		SELF.Prim_Range := le.Clean_Input.Prim_Range;
		SELF.Predir := le.Clean_Input.Predir;
		SELF.Prim_Name := le.Clean_Input.Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Postdir;
		SELF.Unit_Desig := le.Clean_Input.Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		
		SELF.USPIS_Hot_List := TRUE; // We hit the key, we have a USPIS Hot List hit
		SELF.USPIS_Comment := ri.comments;
		todaysDate := IF(le.Clean_Input.ArchiveDate = 999999, todays_date, le.Clean_Input.ArchiveDate + '01');
		cleanedDate := IF(TRIM(ri.dt_first_reported) = '', todaysDate, Suspicious_Fraud_LN.Common.padDate(ri.dt_first_reported[1..8]));
		SELF.DateFirstSeen := cleanedDate;
		cleanComment := StringLib.StringFilter(StringLib.StringToUpperCase(TRIM(ri.comments, ALL)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		
		falseID := 					StringLib.StringFind(cleanComment, 'FALSEIDENTIFICATION', 1) > 0;
		IDTheft :=					StringLib.StringFind(cleanComment, 'IDENTITYTHEFT', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'IDTHEFT', 1) > 0;
		ChangeOfAddress :=	StringLib.StringFind(cleanComment, 'CHANGEOFADDRESS', 1) > 0;
		AcctTakeover :=			StringLib.StringFind(cleanComment, 'TAKEOVER', 1) > 0;
		FraudApp :=					StringLib.StringFind(cleanComment, 'APPLICATION', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'APPS', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'FRAUDAPP', 1) > 0;
		FraudMail :=				StringLib.StringFind(cleanComment, 'UPSSTORE', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'USPS', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'MAIL', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'FININST', 1) > 0 OR 
												StringLib.StringFind(cleanComment, 'CMRA', 1) > 0;
		ATMDebitFraud :=		StringLib.StringFind(cleanComment, 'CARD', 1) > 0;
		Merch :=						StringLib.StringFind(cleanComment, 'MERCHANDISE', 1) > 0 AND 
												StringLib.StringFind(cleanComment, 'SHIPP', 1) <= 0; // MERCHANDISE and not SHIPP
		InvoiceMoney :=			StringLib.StringFind(cleanComment, 'MONEY', 1) > 0 OR
												StringLib.StringFind(cleanComment, 'INVOICE', 1) > 0;
		MerchReship :=			(StringLib.StringFind(cleanComment, '(MERCHANDISE', 1) > 0 AND 
												StringLib.StringFind(cleanComment, 'SHIPP', 1) > 0) OR //(MERCHANDISE and SHIPP) or COLLUSIVE
												StringLib.StringFind(cleanComment, 'COLLUSIVE', 1) > 0;
		NewAccount :=				StringLib.StringFind(cleanComment, 'NEWACC', 1) > 0;
		Reship :=						StringLib.StringFind(cleanComment, 'SHIPP', 1) > 0 AND 
												StringLib.StringFind(cleanComment, 'MERCHANDISE', 1) <= 0; // SHIPP and not MERCHANDISE
		Vacant :=						StringLib.StringFind(cleanComment, 'VACANT', 1) > 0;
		
		Unknown := TRIM(cleanComment) = ''; // Comment section not populated
		
		Other := falseID = FALSE AND IDTheft = FALSE AND ChangeOfAddress = FALSE AND AcctTakeover = FALSE AND
						 FraudApp = FALSE AND FraudMail = FALSE AND ATMDebitFraud = FALSE AND Merch = FALSE AND
						 InvoiceMoney = FALSE AND MerchReship = FALSE AND NewAccount = FALSE AND Reship = FALSE AND
						 Vacant = FALSE AND Unknown = FALSE; // Comment isn't blank and it isn't in one of our other buckets
		SELF.USPISHotList  := IF(falseID, DATASET([{cleanedDate, 'The input Address may have been associated with a false identification'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(IDTheft, DATASET([{cleanedDate, 'The input Address may have been associated with identity theft'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(ChangeOfAddress, DATASET([{cleanedDate, 'The input Address may have been associated with a false change of address'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(AcctTakeover, DATASET([{cleanedDate, 'The input Address may have been associated with an account takeover'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(FraudApp, DATASET([{cleanedDate, 'The input Address may have been associated with a fraudulent application'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(FraudMail, DATASET([{cleanedDate, 'The input Address may have been associated with fraudulent mail'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(ATMDebitFraud, DATASET([{cleanedDate, 'The input Address may have been associated with ATM/Debit Card fraud'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(Merch, DATASET([{cleanedDate, 'The input Address may have been associated with fraudulent merchandise'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(InvoiceMoney, DATASET([{cleanedDate, 'The input Address may have been associated with fraudulent invoices'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(MerchReship, DATASET([{cleanedDate, 'The input Address may have been associated with merchandise/reshipping'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(NewAccount, DATASET([{cleanedDate, 'The input Address may have been associated with new account fraud'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(Reship, DATASET([{cleanedDate, 'The input Address may have been associated with a reshipping scheme'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(Other, DATASET([{cleanedDate, 'The input Address may have been associated with a fraud scheme'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs)) +
													IF(Vacant, DATASET([{cleanedDate, 'The input Address is reported as vacant'}], Suspicious_Fraud_LN.layouts.USPISHotListRecs));

		SELF.USPIS_FalseIdentification := falseID;
		SELF.USPIS_IdentityTheft := IDTheft;
		SELF.USPIS_FalseChangeOfAddress := ChangeOfAddress;
		SELF.USPIS_AccountTakeover := AcctTakeover;
		SELF.USPIS_FraudulentApplication := FraudApp;
		SELF.USPIS_FraudulentMail := FraudMail;
		SELF.USPIS_ATMDebitCardFraud := ATMDebitFraud;
		SELF.USPIS_FraudulentMerchandise := Merch;
		SELF.USPIS_FraudulentInvoice := InvoiceMoney;
		SELF.USPIS_MerchandiseReshipping := MerchReship;
		SELF.USPIS_NewAccountFraud := NewAccount;
		SELF.USPIS_Reshipping := Reship;
		SELF.USPIS_Vacant := Vacant;
		SELF.USPIS_OtherFraud := Other;
		SELF.USPIS_Unknown := Unknown;
		
		SELF := [];
	END;

	getUSPISRaw := JOIN(Input, USPISKey, LEFT.Clean_Input.Prim_Name <> '' AND LEFT.Clean_Input.Zip5 <> '' AND
																		KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip AND LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND
																					LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Addr_Suffix AND
																					LEFT.Clean_Input.Predir = RIGHT.Predir AND LEFT.Clean_Input.Postdir = RIGHT.Postdir) AND 
																		UT.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range) AND 
																		(UNSIGNED)(RIGHT.Dt_First_Reported[1..6]) <= LEFT.Clean_Input.ArchiveDate, // Make sure the date first seen is before our archive "as of" date
														getUSPISRecords(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
													
	TempAddressRisk rollUSPIS(TempAddressRisk le, TempAddressRisk ri) := TRANSFORM
		SELF.USPIS_Hot_List := le.USPIS_Hot_List OR ri.USPIS_Hot_List;
		SELF.USPIS_FalseIdentification := le.USPIS_FalseIdentification OR ri.USPIS_FalseIdentification;
		SELF.USPIS_IdentityTheft := le.USPIS_IdentityTheft OR ri.USPIS_IdentityTheft;
		SELF.USPIS_FalseChangeOfAddress := le.USPIS_FalseChangeOfAddress OR ri.USPIS_FalseChangeOfAddress;
		SELF.USPIS_AccountTakeover := le.USPIS_AccountTakeover OR ri.USPIS_AccountTakeover;
		SELF.USPIS_FraudulentApplication := le.USPIS_FraudulentApplication OR ri.USPIS_FraudulentApplication;
		SELF.USPIS_FraudulentMail := le.USPIS_FraudulentMail OR ri.USPIS_FraudulentMail;
		SELF.USPIS_ATMDebitCardFraud := le.USPIS_ATMDebitCardFraud OR ri.USPIS_ATMDebitCardFraud;
		SELF.USPIS_FraudulentMerchandise := le.USPIS_FraudulentMerchandise OR ri.USPIS_FraudulentMerchandise;
		SELF.USPIS_FraudulentInvoice := le.USPIS_FraudulentInvoice OR ri.USPIS_FraudulentInvoice;
		SELF.USPIS_MerchandiseReshipping := le.USPIS_MerchandiseReshipping OR ri.USPIS_MerchandiseReshipping;
		SELF.USPIS_NewAccountFraud := le.USPIS_NewAccountFraud OR ri.USPIS_NewAccountFraud;
		SELF.USPIS_Reshipping := le.USPIS_Reshipping OR ri.USPIS_Reshipping;
		SELF.USPIS_Vacant := le.USPIS_Vacant OR ri.USPIS_Vacant;
		SELF.USPIS_OtherFraud := le.USPIS_OtherFraud OR ri.USPIS_OtherFraud;
		SELF.USPIS_Unknown := le.USPIS_Unknown OR ri.USPIS_Unknown;
		
		SELF.DateFirstSeen := (STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen);
		SELF.USPISHotList := le.USPISHotList + ri.USPISHotList;
		
		SELF := le;
	END;
	getUSPIS := ROLLUP(getUSPISRaw, LEFT.Seq = RIGHT.Seq, rollUSPIS(LEFT, RIGHT));
	
	TempAddressRisk getHRIAddress(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, AddressRiskKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.Clean_Input.StreetAddress1;
		SELF.StreetAddress2 := le.Clean_Input.StreetAddress2;
		SELF.City := le.Clean_Input.City;
		SELF.State := le.Clean_Input.State;
		SELF.Zip := le.Clean_Input.Zip;
		SELF.Zip5 := le.Clean_Input.Zip5;
		SELF.Zip4 := le.Clean_Input.Zip4;
		SELF.Prim_Range := le.Clean_Input.Prim_Range;
		SELF.Predir := le.Clean_Input.Predir;
		SELF.Prim_Name := le.Clean_Input.Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Postdir;
		SELF.Unit_Desig := le.Clean_Input.Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		todaysDate := IF(le.Clean_Input.ArchiveDate = 999999, todays_date, ((STRING)le.Clean_Input.ArchiveDate)[1..6] + '01');
		cleanedDate := IF((UNSIGNED)ri.dt_first_seen = 0, todaysDate, Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_first_seen));
		SELF.DateFirstSeen := cleanedDate;
		SELF.TransientCommercialIdentity := TRIM(ri.Sic_Code) NOT IN ['', '2225'];
		SELF.CorrectionalFacility := ri.Sic_Code = '2225';
		
		SELF := le;
	END;
	getHRIRaw := JOIN(Input, AddressRiskKey, LEFT.Clean_Input.Prim_Name <> '' AND LEFT.Clean_Input.Zip5 <> '' AND
																		KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Z5 AND LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND
																					LEFT.Clean_Input.Addr_Suffix = RIGHT.Suffix AND LEFT.Clean_Input.Predir = RIGHT.Predir AND 
																					LEFT.Clean_Input.Postdir = RIGHT.Postdir AND LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range) AND 
																		UT.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range) AND 
																		(UNSIGNED)(((STRING)RIGHT.Dt_First_Seen)[1..6]) <= LEFT.Clean_Input.ArchiveDate, // Make sure the date first seen is before our archive "as of" date
														getHRIAddress(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));

	TempAddressRisk rollHRI(TempAddressRisk le, TempAddressRisk ri) := TRANSFORM
		SELF.TransientCommercialIdentity := le.TransientCommercialIdentity OR ri.TransientCommercialIdentity;
		SELF.CorrectionalFacility := le.CorrectionalFacility OR ri.CorrectionalFacility;
		
		SELF.DateFirstSeen := (STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen);
		
		SELF := le;
	END;
	getHRI := ROLLUP(getHRIRaw, LEFT.Seq = RIGHT.Seq, rollHRI(LEFT, RIGHT));

	TempAddressRisk combineUSPISHRI(TempAddressRisk le, TempAddressRisk ri) := TRANSFORM
		// Field could be populated in either USPIS or HRI results, keep whichever is populated
		SELF.Seq := IF(le.Seq <> 0, le.Seq, ri.Seq);
		SELF.ArchiveDate := IF(le.ArchiveDate <> 0, le.ArchiveDate, ri.ArchiveDate);
		SELF.StreetAddress1 := IF(le.StreetAddress1 <> '' , le.StreetAddress1, ri.StreetAddress1);
		SELF.StreetAddress2 := IF(le.StreetAddress2 <> '' , le.StreetAddress2, ri.StreetAddress2);
		SELF.City := IF(le.City <> '' , le.City, ri.City);
		SELF.State := IF(le.State <> '' , le.State, ri.State);
		SELF.Zip := IF(le.Zip <> '' , le.Zip, ri.Zip);
		SELF.Zip5 := IF(le.Zip5 <> '' , le.Zip5, ri.Zip5);
		SELF.Zip4 := IF(le.Zip4 <> '' , le.Zip4, ri.Zip4);
		SELF.Prim_Range := IF(le.Prim_Range <> '' , le.Prim_Range, ri.Prim_Range);
		SELF.Predir := IF(le.Predir <> '' , le.Predir, ri.Predir);
		SELF.Prim_Name := IF(le.Prim_Name <> '' , le.Prim_Name, ri.Prim_Name);
		SELF.Addr_Suffix := IF(le.Addr_Suffix <> '' , le.Addr_Suffix, ri.Addr_Suffix);
		SELF.Postdir := IF(le.Postdir <> '' , le.Postdir, ri.Postdir);
		SELF.Unit_Desig := IF(le.Unit_Desig <> '' , le.Unit_Desig, ri.Unit_Desig);
		SELF.Sec_Range := IF(le.Sec_Range <> '' , le.Sec_Range, ri.Sec_Range);
		SELF.DateFirstSeen := MAP((UNSIGNED)le.DateFirstSeen = 0 => ri.DateFirstSeen,
															(UNSIGNED)ri.DateFirstSeen = 0 => le.DateFirstSeen,
																																(STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen));
		
		// Fields only in the USPIS file
		SELF.USPIS_Hot_List := le.USPIS_Hot_List;
		SELF.USPIS_FalseIdentification := le.USPIS_FalseIdentification;
		SELF.USPIS_IdentityTheft := le.USPIS_IdentityTheft;
		SELF.USPIS_FalseChangeOfAddress := le.USPIS_FalseChangeOfAddress;
		SELF.USPIS_AccountTakeover := le.USPIS_AccountTakeover;
		SELF.USPIS_FraudulentApplication := le.USPIS_FraudulentApplication;
		SELF.USPIS_FraudulentMail := le.USPIS_FraudulentMail;
		SELF.USPIS_ATMDebitCardFraud := le.USPIS_ATMDebitCardFraud;
		SELF.USPIS_FraudulentMerchandise := le.USPIS_FraudulentMerchandise;
		SELF.USPIS_FraudulentInvoice := le.USPIS_FraudulentInvoice;
		SELF.USPIS_MerchandiseReshipping := le.USPIS_MerchandiseReshipping;
		SELF.USPIS_NewAccountFraud := le.USPIS_NewAccountFraud;
		SELF.USPIS_Reshipping := le.USPIS_Reshipping;
		SELF.USPIS_Vacant := le.USPIS_Vacant;
		SELF.USPIS_OtherFraud := le.USPIS_OtherFraud;
		SELF.USPIS_Unknown := le.USPIS_Unknown;
		SELF.USPISHotList := le.USPISHotList;
		// Fields only in the HRI file
		SELF.TransientCommercialIdentity := ri.TransientCommercialIdentity;
		SELF.CorrectionalFacility := ri.CorrectionalFacility;
	END;
	addressRiskSummaryPart1 := JOIN(getUSPIS, getHRI, LEFT.Seq = RIGHT.Seq, combineUSPISHRI(LEFT, RIGHT), FULL OUTER);
	
	TempAddressRisk getCriminalAddress(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, CriminalKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.Clean_Input.StreetAddress1;
		SELF.StreetAddress2 := le.Clean_Input.StreetAddress2;
		SELF.City := le.Clean_Input.City;
		SELF.State := le.Clean_Input.State;
		SELF.Zip := le.Clean_Input.Zip;
		SELF.Zip5 := le.Clean_Input.Zip5;
		SELF.Zip4 := le.Clean_Input.Zip4;
		SELF.Prim_Range := le.Clean_Input.Prim_Range;
		SELF.Predir := le.Clean_Input.Predir;
		SELF.Prim_Name := le.Clean_Input.Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Postdir;
		SELF.Unit_Desig := le.Clean_Input.Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		todaysDate := IF(le.Clean_Input.ArchiveDate = 999999, todays_date, ((STRING)le.Clean_Input.ArchiveDate)[1..6] + '01');
		SELF.DateFirstSeen := todaysDate;
		SELF.CorrectionalFacility := TRUE; // If we hit this key it's a correctional facility
		
		SELF := le;
	END;
	addressRiskSummaryPart2 := JOIN(Input, CriminalKey, LEFT.Clean_Input.Prim_Name <> '' AND LEFT.Clean_Input.Zip5 <> '' AND
																		KEYED(LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND
																					LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND
																					LEFT.Clean_Input.Zip5 = RIGHT.Zip) AND 
																		UT.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range),
														getCriminalAddress(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost));
	
	addressRiskSummary := JOIN(addressRiskSummaryPart1, addressRiskSummaryPart2, LEFT.Seq = RIGHT.Seq, 
																						TRANSFORM(TempAddressRisk, 
																											SELF.TransientCommercialIdentity := IF(RIGHT.CorrectionalFacility = TRUE, FALSE, LEFT.TransientCommercialIdentity); // Can't be just a transient commercial identity if we had a hit on the criminal key
																											SELF.CorrectionalFacility := LEFT.CorrectionalFacility OR RIGHT.CorrectionalFacility;
																											SELF := LEFT), FULL OUTER);
	
	TempADVORisk := RECORD
		UNSIGNED8 Seq 												:= 0;
		STRING120 StreetAddress1							:= '';
		STRING120	StreetAddress2							:= '';
		STRING25 City													:= '';
		STRING2 State													:= '';
		STRING9 Zip														:= '';
		STRING5 Zip5													:= '';
		STRING4 Zip4													:= '';
		STRING10 Prim_Range										:= '';
		STRING2 Predir												:= '';
		STRING28 Prim_Name										:= '';
		STRING4 Addr_Suffix										:= '';
		STRING2 Postdir												:= '';
		STRING10 Unit_Desig										:= '';
		STRING8 Sec_Range											:= '';
		UNSIGNED4 ArchiveDate									:= 0;
		STRING8 DateFirstSeen									:= '';
		BOOLEAN InputPOBox										:= FALSE;
		STRING1 Address_Vacancy_Indicator 		:= ''; // Y/N
		STRING1 College_Indicator					 		:= ''; // Y/N
		STRING1 Seasonal_Delivery_Indicator 	:= ''; // Y/N/E
		STRING1 Drop_Indicator 								:= ''; // Y/N/C
		STRING2 Residential_Or_Business_Ind		:= ''; // A/B/C/D
	END;
	
	TempADVORisk getADVORecords(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, ADVOKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.Clean_Input.StreetAddress1;
		SELF.StreetAddress2 := le.Clean_Input.StreetAddress2;
		SELF.City := le.Clean_Input.City;
		SELF.State := le.Clean_Input.State;
		SELF.Zip := le.Clean_Input.Zip;
		SELF.Zip5 := le.Clean_Input.Zip5;
		SELF.Zip4 := le.Clean_Input.Zip4;
		SELF.Prim_Range := le.Clean_Input.Prim_Range;
		SELF.Predir := le.Clean_Input.Predir;
		SELF.Prim_Name := le.Clean_Input.Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Postdir;
		SELF.Unit_Desig := le.Clean_Input.Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		todaysDate := IF(le.Clean_Input.ArchiveDate = 999999, todays_date, ((STRING)le.Clean_Input.ArchiveDate)[1..6] + '01');
		cleanDate := IF((UNSIGNED)ri.Date_First_Seen = 0, todaysDate, Suspicious_Fraud_LN.Common.padDate((STRING)ri.Date_First_Seen));
		SELF.DateFirstSeen := cleanDate;
		SELF.InputPOBox := TRIM(le.Clean_Input.Prim_Name, ALL)[1..5] = 'POBOX';
		SELF.Address_Vacancy_Indicator := IF(ri.Address_Vacancy_Indicator = '', 'N', ri.Address_Vacancy_Indicator);
		SELF.College_Indicator := IF(ri.College_Indicator = '', 'N', ri.College_Indicator);
		SELF.Seasonal_Delivery_Indicator := IF(ri.Seasonal_Delivery_Indicator = '', 'N', ri.Seasonal_Delivery_Indicator);
		SELF.Drop_Indicator := IF(ri.Drop_Indicator = '', 'N', ri.Drop_Indicator);
		SELF.Residential_Or_Business_Ind := IF(ri.Residential_Or_Business_Ind = '', 'A', ri.Residential_Or_Business_Ind);
	END;
	
	getADVORaw := JOIN(Input, ADVOKey, LEFT.Clean_Input.Prim_Name <> '' AND LEFT.Clean_Input.Zip5 <> '' AND
																		KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip AND LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND
																		LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Addr_Suffix AND 
																		LEFT.Clean_Input.Predir = RIGHT.Predir AND LEFT.Clean_Input.Postdir = RIGHT.Postdir) AND 
																		UT.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range) AND 
																		(UNSIGNED)(RIGHT.Date_First_Seen[1..6]) <= LEFT.Clean_Input.ArchiveDate, // Make sure the date first seen is before our archive "as of" date
														getADVORecords(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
														
	TempADVORisk rollADVO(TempADVORisk le, TempADVORisk ri) := TRANSFORM
		SELF.DateFirstSeen := (STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen);
		SELF.InputPOBox := le.InputPOBox OR ri.InputPOBox;
		SELF.Address_Vacancy_Indicator := IF(le.Address_Vacancy_Indicator = 'Y' OR ri.Address_Vacancy_Indicator = 'Y', 'Y', 'N');
		SELF.College_Indicator := IF(le.College_Indicator = 'Y' OR ri.College_Indicator = 'Y', 'Y', 'N');
		SELF.Seasonal_Delivery_Indicator := MAP(le.Seasonal_Delivery_Indicator = 'E' OR ri.Seasonal_Delivery_Indicator = 'E' => 'E',
																						le.Seasonal_Delivery_Indicator = 'Y' OR ri.Seasonal_Delivery_Indicator = 'Y' => 'Y',
																																																														'N');
		SELF.Drop_Indicator := MAP(le.Drop_Indicator = 'C' OR ri.Drop_Indicator = 'C' => 'C',
															 le.Drop_Indicator = 'Y' OR ri.Drop_Indicator = 'Y' => 'Y',
																																										 'N');
		SELF.Residential_Or_Business_Ind := MAP(le.Residential_Or_Business_Ind = 'D' OR ri.Residential_Or_Business_Ind = 'D' => 'D',
																						le.Residential_Or_Business_Ind = 'C' OR ri.Residential_Or_Business_Ind = 'C' => 'C',
																						le.Residential_Or_Business_Ind = 'B' OR ri.Residential_Or_Business_Ind = 'B' => 'B',
																																																														'A');
		
		SELF := le;
	END;
	
	getADVO := ROLLUP(getADVORaw, LEFT.Seq = RIGHT.Seq, rollADVO(LEFT, RIGHT));

	// Translate the QH and WH Equifax Fast Header sources to EQ
	translateSrc (STRING3 src) := IF(src IN [MDR.SourceTools.src_Equifax_Quick, MDR.SourceTools.src_Equifax_Weekly], MDR.SourceTools.src_Equifax, src);

	// Get all of the address header information
	TempHeader := RECORD
		UNSIGNED8 Seq 												:= 0;
		STRING120 StreetAddress1							:= '';
		STRING120	StreetAddress2							:= '';
		STRING25 City													:= '';
		STRING2 State													:= '';
		STRING9 Zip														:= '';
		STRING5 Zip5													:= '';
		STRING4 Zip4													:= '';
		STRING10 Prim_Range										:= '';
		STRING2 Predir												:= '';
		STRING28 Prim_Name										:= '';
		STRING4 Addr_Suffix										:= '';
		STRING2 Postdir												:= '';
		STRING10 Unit_Desig										:= '';
		STRING8 Sec_Range											:= '';
		UNSIGNED4 ArchiveDate									:= 0;
		BOOLEAN Came_From_FastHeader					:= FALSE;
		STRING8 TodaysDate										:= '';
		STRING8 DateFirstSeen									:= '';
		STRING8 DateLastSeen									:= ''; // Only count unique DID's with a last seen date <= 2 months
		INTEGER DaysLastSeen									:= -1; // Number of days between TodaysDate and DateLastSeen fields
		UNSIGNED8 DID													:= 0;
		UNSIGNED3 UniqueDIDCount							:= 0; // All unique DID's counted for that Address
		UNSIGNED3 UniqueDIDCount2Months				:= 0; // Only count unique DID's with a last seen date <= 2 months
		UNSIGNED3 UniqueDIDCount1Months				:= 0; // Only count unique DID's with a last seen date <= 1 months
	END;
	
	{TempHeader, unsigned4 global_sid} GetHeaderAddress(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, FullHeaderKey ri, BOOLEAN fastHeader) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.Seq := le.Seq;
		SELF.DID := ri.DID;
		SELF.Came_From_FastHeader := fastHeader;
		
		SELF.StreetAddress1 := le.Clean_Input.StreetAddress1;
		SELF.StreetAddress2 := le.Clean_Input.StreetAddress2;
		SELF.City := le.Clean_Input.City;
		SELF.State := le.Clean_Input.State;
		SELF.Zip := le.Clean_Input.Zip;
		SELF.Zip5 := le.Clean_Input.Zip5;
		SELF.Zip4 := le.Clean_Input.Zip4;
		SELF.Prim_Range := le.Clean_Input.Prim_Range;
		SELF.Predir := le.Clean_Input.Predir;
		SELF.Prim_Name := le.Clean_Input.Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Postdir;
		SELF.Unit_Desig := le.Clean_Input.Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		
		todaysDateTemp := IF((INTEGER)todays_date >= le.Clean_Input.ArchiveDate AND le.Clean_Input.ArchiveDate <> 999999, (STRING)le.Clean_Input.ArchiveDate + '01', todays_date);
		// If todaysDate is greater than the header build date, use the header build date
		todaysDate := IF(todaysDateTemp >= headerBuildDate, headerBuildDate, todaysDateTemp);
		
		dt_lastTemp := MAP(ri.dt_last_seen <> 0 => (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_last_seen),
										ri.dt_first_seen <> 0 	=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_first_seen),
																								0);
		dt_last := IF(dt_lastTemp >= (INTEGER)todaysDate, (INTEGER)todaysDate, dt_lastTemp);
		
		dt_first := MAP(ri.dt_first_seen <> 0	=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_first_seen),
																							0);
																							
		// If the Archive Date was before the last header build date, use the Archive Date as todays date
		SELF.TodaysDate := todaysDate;
		dateLastAge := IF(dt_last = 0, -1, (INTEGER)ut.DaysApart((STRING)dt_last, todaysDate));
		SELF.DateFirstSeen := (STRING8)dt_first;
		SELF.DateLastSeen := (STRING8)dt_last;
		SELF.DaysLastSeen := IF((UNSIGNED)todaysDate < dt_last OR dt_last = 0, -1, dateLastAge);
		
		SELF.UniqueDIDCount := 1; // Will rollup later
		SELF.UniqueDIDCount2Months := IF(dateLastAge BETWEEN 0 AND 61 AND dt_last > 0, 1, 0);
		SELF.UniqueDIDCount1Months := IF(dateLastAge BETWEEN 0 AND 31 AND dt_last > 0, 1, 0);
		
		SELF := le;
	END;
	
	fullHeaderAddress_unsuppressed := JOIN(Input, FullHeaderKey, LEFT.Clean_Input.Prim_Name <> '' AND LEFT.Clean_Input.Zip5 <> '' AND
																									KEYED(LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND LEFT.Clean_Input.Zip5 = RIGHT.Zip AND
																										LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range) AND
																									LEFT.Clean_Input.Addr_Suffix = RIGHT.Suffix AND LEFT.Clean_Input.Predir = RIGHT.Predir AND 
																									LEFT.Clean_Input.Postdir = RIGHT.Postdir AND UT.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range) AND
																												translateSrc(RIGHT.src) NOT IN Risk_Indicators.iid_constants.masked_header_sources(DataRestrictionMask, isFCRA := FALSE) AND
																												(Risk_Indicators.iid_constants.glb_ok(GLBPurpose, isFCRA := FALSE)) AND
																												(~MDR.Source_is_DPPA(translateSrc(RIGHT.src)) OR (Risk_Indicators.iid_constants.dppa_ok(DPPAPurpose, isFCRA := FALSE) AND Drivers.state_dppa_ok(dx_header.functions.TranslateSource(translateSrc(RIGHT.src)), DPPAPurpose, translateSrc(RIGHT.src)))) AND
																												~Risk_Indicators.iid_constants.filtered_source(translateSrc(RIGHT.src), RIGHT.st) AND
																												((UNSIGNED)(((STRING)RIGHT.dt_first_seen)[1..6]) <= LEFT.Clean_Input.ArchiveDate AND RIGHT.dt_first_seen <> 0) AND
																									RIGHT.DID <> 0,
																		GetHeaderAddress(LEFT, RIGHT, FALSE), ATMOST(ut.Limits.Header_Per_DID));
	
	fullHeaderAddress := Suppress.Suppress_ReturnOldLayout(fullHeaderAddress_unsuppressed, mod_access, TempHeader);
	// Keep the unique DID's associated with the Address
	headerAddress := DEDUP(SORT(fullHeaderAddress, Seq, Prim_Range, Prim_Name, Zip5, DID, DaysLastSeen, DateFirstSeen, DateLastSeen), Seq, DID);
	
	headerAddressCounted := ROLLUP(headerAddress, LEFT.Seq = RIGHT.Seq, TRANSFORM(TempHeader, SELF.DateFirstSeen := MAP((INTEGER)LEFT.DateFirstSeen = 0		=> RIGHT.DateFirstSeen,
																																																											(INTEGER)RIGHT.DateFirstSeen = 0	=> LEFT.DateFirstSeen,
																																																																													(STRING)MIN((INTEGER)LEFT.DateFirstSeen, (INTEGER)RIGHT.DateFirstSeen));
																																														SELF.UniqueDIDCount := LEFT.UniqueDIDCount + RIGHT.UniqueDIDCount;
																																														SELF.UniqueDIDCount2Months := LEFT.UniqueDIDCount2Months + RIGHT.UniqueDIDCount2Months;
																																														SELF.UniqueDIDCount1Months := LEFT.UniqueDIDCount1Months + RIGHT.UniqueDIDCount1Months;
																																														SELF := LEFT));
	
	// Get all of the address business header information
	TempBusinessHeader := RECORD
		UNSIGNED8 Seq 												:= 0;
		STRING120 StreetAddress1							:= '';
		STRING120	StreetAddress2							:= '';
		STRING25 City													:= '';
		STRING2 State													:= '';
		STRING9 Zip														:= '';
		STRING5 Zip5													:= '';
		STRING4 Zip4													:= '';
		STRING10 Prim_Range										:= '';
		STRING2 Predir												:= '';
		STRING28 Prim_Name										:= '';
		STRING4 Addr_Suffix										:= '';
		STRING2 Postdir												:= '';
		STRING10 Unit_Desig										:= '';
		STRING8 Sec_Range											:= '';
		UNSIGNED4 ArchiveDate									:= 0;
		STRING8 TodaysDate										:= '';
		STRING8 DateFirstSeen									:= '';
		STRING8 DateLastSeen									:= ''; // Only count unique BDID's with a last seen date <= 2 months
		INTEGER DaysLastSeen									:= -1; // Number of days between TodaysDate and DateLastSeen fields
		UNSIGNED8 BDID												:= 0;
		UNSIGNED3 UniqueBDIDCount							:= 0; // All unique BDID's counted for that Address
		UNSIGNED3 UniqueBDIDCount2Months			:= 0; // Only count unique BDID's with a last seen date <= 2 months
		UNSIGNED3 UniqueBDIDCount1Months			:= 0; // Only count unique BDID's with a last seen date <= 1 months
	END;
	
	TempBusinessHeader GetBusinessHeaderAddress(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, BusinessHeaderKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.BDID := ri.BDID;
		
		SELF.StreetAddress1 := le.Clean_Input.StreetAddress1;
		SELF.StreetAddress2 := le.Clean_Input.StreetAddress2;
		SELF.City := le.Clean_Input.City;
		SELF.State := le.Clean_Input.State;
		SELF.Zip := le.Clean_Input.Zip;
		SELF.Zip5 := le.Clean_Input.Zip5;
		SELF.Zip4 := le.Clean_Input.Zip4;
		SELF.Prim_Range := le.Clean_Input.Prim_Range;
		SELF.Predir := le.Clean_Input.Predir;
		SELF.Prim_Name := le.Clean_Input.Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Postdir;
		SELF.Unit_Desig := le.Clean_Input.Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		
		todaysDateTemp := IF((INTEGER)todays_date >= le.Clean_Input.ArchiveDate AND le.Clean_Input.ArchiveDate <> 999999, (STRING)le.Clean_Input.ArchiveDate + '01', todays_date);
		// If todaysDate is greater than the header build date, use the header build date
		todaysDate := IF(todaysDateTemp >= headerBuildDate, headerBuildDate, todaysDateTemp);
		
		dt_lastTemp := MAP(ri.dt_last_seen <> 0							=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_last_seen),
											 ri.dt_vendor_last_reported <> 0	=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_vendor_last_reported),
											 ri.dt_first_seen <> 0						=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_first_seen),
											 ri.dt_vendor_first_reported <> 0	=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_vendor_first_reported),
																														0);
		dt_last := IF(dt_lastTemp >= (INTEGER)todaysDate, (INTEGER)todaysDate, dt_lastTemp);
		
		dt_firstTemp := MAP(ri.dt_first_seen <> 0							=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_first_seen),
												ri.dt_vendor_first_reported <> 0	=> (INTEGER)Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_vendor_first_reported),
																														0);
		dt_first := IF(dt_firstTemp >= (INTEGER)todaysDate, (INTEGER)todaysDate, dt_firstTemp);
																							
		// If the Archive Date was before the last header build date, use the Archive Date as todays date
		SELF.TodaysDate := todaysDate;
		dateLastAge := IF(dt_last = 0, -1, (INTEGER)ut.DaysApart((STRING)dt_last, todaysDate));
		SELF.DateFirstSeen := (STRING8)dt_first;
		SELF.DateLastSeen := (STRING8)dt_last;
		SELF.DaysLastSeen := IF((UNSIGNED)todaysDate < dt_last OR dt_last = 0, -1, dateLastAge);
		
		SELF.UniqueBDIDCount := 1; // Will rollup later
		SELF.UniqueBDIDCount2Months := IF(dateLastAge BETWEEN 0 AND 61 AND dt_last > 0, 1, 0);
		SELF.UniqueBDIDCount1Months := IF(dateLastAge BETWEEN 0 AND 31 AND dt_last > 0, 1, 0);
		
		SELF := le;
	END;
	
	fullBusinessHeaderAddress := JOIN(Input, BusinessHeaderKey, LEFT.Clean_Input.Prim_Name <> '' AND LEFT.Clean_Input.Zip5 <> '' AND
																									KEYED((INTEGER)LEFT.Clean_Input.Zip5 = RIGHT.Zip AND LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND
																												LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name) AND
																									LEFT.Clean_Input.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Clean_Input.Predir = RIGHT.Predir AND 
																									LEFT.Clean_Input.Postdir = RIGHT.Postdir AND UT.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.Sec_Range) AND
																									(((UNSIGNED)(((STRING)RIGHT.dt_first_seen)[1..6]) <= LEFT.Clean_Input.ArchiveDate AND RIGHT.dt_first_seen <> 0) OR
																									(RIGHT.dt_first_seen = 0 AND RIGHT.dt_vendor_first_reported <> 0 AND ((UNSIGNED)(((STRING)RIGHT.dt_vendor_first_reported)[1..6])) <= LEFT.Clean_Input.ArchiveDate)) AND
																									RIGHT.BDID <> 0 AND 
																									doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
																		GetBusinessHeaderAddress(LEFT, RIGHT), ATMOST(ut.Limits.BHEADER_PER_BDID));

	// Keep the unique DID's associated with the Address
	businessHeaderAddress := DEDUP(SORT(fullBusinessHeaderAddress, Seq, Prim_Range, Prim_Name, Zip5, BDID, DaysLastSeen, DateFirstSeen, DateLastSeen), Seq, BDID);
	
	businessHeaderAddressCounted := ROLLUP(businessHeaderAddress, LEFT.Seq = RIGHT.Seq, TRANSFORM(TempBusinessHeader, SELF.DateFirstSeen := MAP((INTEGER)LEFT.DateFirstSeen IN [0, 19000101]	=> RIGHT.DateFirstSeen,
																																																																							(INTEGER)RIGHT.DateFirstSeen IN [0, 19000101]	=> LEFT.DateFirstSeen,
																																																																																									(STRING)MIN((INTEGER)LEFT.DateFirstSeen, (INTEGER)RIGHT.DateFirstSeen));
																																																										SELF.UniqueBDIDCount := LEFT.UniqueBDIDCount + RIGHT.UniqueBDIDCount;
																																																										SELF.UniqueBDIDCount2Months := LEFT.UniqueBDIDCount2Months + RIGHT.UniqueBDIDCount2Months;
																																																										SELF.UniqueBDIDCount1Months := LEFT.UniqueBDIDCount1Months + RIGHT.UniqueBDIDCount1Months;
																																																										SELF := LEFT));
	
	// Get all inquiries record information
	TempInquiryAddress := RECORD
		UNSIGNED8 Seq := 0;
		STRING120 StreetAddress1 := '';
		STRING25 City := '';
		STRING2 State := '';
		STRING9 Zip := '';
		STRING5 Zip5 := '';
		STRING4 Zip4 := '';
		STRING10 Prim_Range := '';
		STRING2 Predir := '';
		STRING28 Prim_Name := '';
		STRING4 Addr_Suffix := '';
		STRING2 Postdir := '';
		STRING10 Unit_Desig := '';
		STRING8 Sec_Range := '';
		// LNRS Counts are all inquiries across LexisNexisRiskSolutions products included in set_valid_suspiciousfraud_functions
		UNSIGNED2 InquiryCountLNRSHour := 0;
		UNSIGNED2 InquiryCountLNRSDay := 0;
		UNSIGNED2 InquiryCountLNRSWeek := 0;
		UNSIGNED2 InquiryCountLNRSMonth := 0;
		UNSIGNED2 InquiryCountLNRSYear := 0;
		UNSIGNED3 InquiryCountLNRS := 0;
		STRING8 DateFirstSeenLNRS := '';
		// LNRSnSF Counts are all inquiries in LNRS excluding Suspicious Fraud Function (nSF = No Suspicious Fraud)
		UNSIGNED2 InquiryCountLNRSnSFHour := 0;
		UNSIGNED2 InquiryCountLNRSnSFDay := 0;
		UNSIGNED2 InquiryCountLNRSnSFWeek := 0;
		UNSIGNED2 InquiryCountLNRSnSFMonth := 0;
		UNSIGNED2 InquiryCountLNRSnSFYear := 0;
		UNSIGNED3 InquiryCountLNRSnSF := 0;
		STRING8 DateFirstSeenLNRSnSF := '';
		// SF Counts are all inquiries to the Suspicious Fraud Function
		UNSIGNED2 InquiryCountSFHour := 0;
		UNSIGNED2 InquiryCountSFDay := 0;
		UNSIGNED2 InquiryCountSFWeek := 0;
		UNSIGNED2 InquiryCountSFMonth := 0;
		UNSIGNED2 InquiryCountSFYear := 0;
		UNSIGNED3 InquiryCountSF := 0;
		STRING8 DateFirstSeenSF := '';
	END;
	TempInquiryAddress getInquiries(Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.Person_Q.Address;
		SELF.City := le.Person_Q.V_City_Name;
		SELF.State := le.Person_Q.State;
		SELF.Zip := TRIM(le.Person_Q.Zip5 + le.Person_Q.Zip4);
		SELF.Zip5 := le.Person_Q.Zip5;
		SELF.Zip4 := le.Person_Q.Zip4;
		SELF.Prim_Range := le.Person_Q.Prim_Range;
		SELF.Predir := le.Person_Q.Predir;
		SELF.Prim_Name := le.Person_Q.Prim_Name;
		SELF.Addr_Suffix := le.Person_Q.Addr_Suffix;
		SELF.Postdir := le.Person_Q.Postdir;
		SELF.Unit_Desig := le.Person_Q.Unit_Desig;
		SELF.Sec_Range := le.Person_Q.Sec_Range;
		
		isSF := le.SuspiciousFraudFunction = TRUE;
		lastHour := le.ageinhours <= 1; // Inquiry within the last hour
		lastDay := le.ageindays <= 1; // Inquiry within the last day
		lastWeek := le.ageinweeks <= 1; // Inquiry within the last week
		lastMonth := le.ageinmonths <= 1; // Inquiry within the last month
		lastYear := le.ageinyears <= 1; // Inquiry within the last year
		
		// LNRS Counts are all inquiries across LexisNexisRiskSolutions products included in set_valid_suspiciousfraud_functions
		SELF.InquiryCountLNRSHour := IF(lastHour, 1, 0);
		SELF.InquiryCountLNRSDay := IF(lastDay, 1, 0);
		SELF.InquiryCountLNRSWeek := IF(lastWeek, 1, 0);
		SELF.InquiryCountLNRSMonth := IF(lastMonth, 1, 0);
		SELF.InquiryCountLNRSYear := IF(lastYear, 1, 0);
		SELF.InquiryCountLNRS := 1;
		SELF.DateFirstSeenLNRS := le.logdate;
		// LNRSnSF Counts are all inquiries in LNRS excluding Suspicious Fraud Function (nSF = No Suspicious Fraud)
		SELF.InquiryCountLNRSnSFHour := IF(~isSF AND lastHour, 1, 0);
		SELF.InquiryCountLNRSnSFDay := IF(~isSF AND lastDay, 1, 0);
		SELF.InquiryCountLNRSnSFWeek := IF(~isSF AND lastWeek, 1, 0);
		SELF.InquiryCountLNRSnSFMonth := IF(~isSF AND lastMonth, 1, 0);
		SELF.InquiryCountLNRSnSFYear := IF(~isSF AND lastYear, 1, 0);
		SELF.InquiryCountLNRSnSF := IF(~isSF, 1, 0);
		SELF.DateFirstSeenLNRSnSF := IF(~isSF, le.logdate, '');
		// SF Counts are all inquiries to the Suspicious Fraud Function
		SELF.InquiryCountSFHour := IF(isSF AND lastHour, 1, 0);
		SELF.InquiryCountSFDay := IF(isSF AND lastDay, 1, 0);
		SELF.InquiryCountSFWeek := IF(isSF AND lastWeek, 1, 0);
		SELF.InquiryCountSFMonth := IF(isSF AND lastMonth, 1, 0);
		SELF.InquiryCountSFYear := IF(isSF AND lastYear, 1, 0);
		SELF.InquiryCountSF := IF(isSF, 1, 0);
		SELF.DateFirstSeenSF := IF(isSF, le.logdate, '');
	END;
	inquiryBucketed := PROJECT(Inquiries, getInquiries(LEFT));
	
	TempInquiryAddress countInquiries(TempInquiryAddress le, TempInquiryAddress ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.StreetAddress1;
		SELF.City := le.City;
		SELF.State := le.State;
		SELF.Zip := le.Zip;
		SELF.Zip5 := le.Zip5;
		SELF.Zip4 := le.Zip4;
		SELF.Prim_Range := le.Prim_Range;
		SELF.Predir := le.Predir;
		SELF.Prim_Name := le.Prim_Name;
		SELF.Addr_Suffix := le.Addr_Suffix;
		SELF.Postdir := le.Postdir;
		SELF.Unit_Desig := le.Unit_Desig;
		SELF.Sec_Range := le.Sec_Range;
		
		SELF.InquiryCountLNRSHour := le.InquiryCountLNRSHour + ri.InquiryCountLNRSHour;
		SELF.InquiryCountLNRSDay := le.InquiryCountLNRSDay + ri.InquiryCountLNRSDay;
		SELF.InquiryCountLNRSWeek := le.InquiryCountLNRSWeek + ri.InquiryCountLNRSWeek;
		SELF.InquiryCountLNRSMonth := le.InquiryCountLNRSMonth + ri.InquiryCountLNRSMonth;
		SELF.InquiryCountLNRSYear := le.InquiryCountLNRSYear + ri.InquiryCountLNRSYear;
		SELF.InquiryCountLNRS := le.InquiryCountLNRS + ri.InquiryCountLNRS;
		SELF.DateFirstSeenLNRS := MAP((UNSIGNED)le.DateFirstSeenLNRS = 0	=> ri.DateFirstSeenLNRS,
																	(UNSIGNED)ri.DateFirstSeenLNRS = 0	=> le.DateFirstSeenLNRS,
																																				(STRING8)MIN((UNSIGNED)le.DateFirstSeenLNRS, (UNSIGNED)ri.DateFirstSeenLNRS));
		
		SELF.InquiryCountLNRSnSFHour := le.InquiryCountLNRSnSFHour + ri.InquiryCountLNRSnSFHour;
		SELF.InquiryCountLNRSnSFDay := le.InquiryCountLNRSnSFDay + ri.InquiryCountLNRSnSFDay;
		SELF.InquiryCountLNRSnSFWeek := le.InquiryCountLNRSnSFWeek + ri.InquiryCountLNRSnSFWeek;
		SELF.InquiryCountLNRSnSFMonth := le.InquiryCountLNRSnSFMonth + ri.InquiryCountLNRSnSFMonth;
		SELF.InquiryCountLNRSnSFYear := le.InquiryCountLNRSnSFYear + ri.InquiryCountLNRSnSFYear;
		SELF.InquiryCountLNRSnSF := le.InquiryCountLNRSnSF + ri.InquiryCountLNRSnSF;
		SELF.DateFirstSeenLNRSnSF := MAP((UNSIGNED)le.DateFirstSeenLNRSnSF = 0	=> ri.DateFirstSeenLNRSnSF,
																		 (UNSIGNED)ri.DateFirstSeenLNRSnSF = 0	=> le.DateFirstSeenLNRSnSF,
																																							(STRING8)MIN((UNSIGNED)le.DateFirstSeenLNRSnSF, (UNSIGNED)ri.DateFirstSeenLNRSnSF));
		
		SELF.InquiryCountSFHour := le.InquiryCountSFHour + ri.InquiryCountSFHour;
		SELF.InquiryCountSFDay := le.InquiryCountSFDay + ri.InquiryCountSFDay;
		SELF.InquiryCountSFWeek := le.InquiryCountSFWeek + ri.InquiryCountSFWeek;
		SELF.InquiryCountSFMonth := le.InquiryCountSFMonth + ri.InquiryCountSFMonth;
		SELF.InquiryCountSFYear := le.InquiryCountSFYear + ri.InquiryCountSFYear;
		SELF.InquiryCountSF := le.InquiryCountSF + ri.InquiryCountSF;
		SELF.DateFirstSeenSF := MAP((UNSIGNED)le.DateFirstSeenSF = 0	=> ri.DateFirstSeenSF,
																(UNSIGNED)ri.DateFirstSeenSF = 0	=> le.DateFirstSeenSF,
																																		(STRING8)MIN((UNSIGNED)le.DateFirstSeenSF, (UNSIGNED)ri.DateFirstSeenSF));
	END;
	inquiriesCounted := ROLLUP(SORT(inquiryBucketed, Seq), LEFT.Seq = RIGHT.Seq, countInquiries(LEFT, RIGHT));
	
	// We have all of the raw data, now generate the Risk Codes!	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getAddressRiskCodes(TempAddressRisk le) := TRANSFORM
		RiskCodesTemp																:= IF(le.TransientCommercialIdentity, Suspicious_Fraud_LN.Common.genRiskCode('A01')) +
																									 IF(le.USPIS_Hot_List, Suspicious_Fraud_LN.Common.genRiskCode('A02')) +
																									 IF(le.CorrectionalFacility, Suspicious_Fraud_LN.Common.genRiskCode('A11')) +
																									 IF(le.USPIS_FalseIdentification, Suspicious_Fraud_LN.Common.genRiskCode('A19')) +
																									 IF(le.USPIS_IdentityTheft, Suspicious_Fraud_LN.Common.genRiskCode('A20')) +
																									 IF(le.USPIS_FalseChangeOfAddress, Suspicious_Fraud_LN.Common.genRiskCode('A21')) +
																									 IF(le.USPIS_AccountTakeover, Suspicious_Fraud_LN.Common.genRiskCode('A22')) +
																									 IF(le.USPIS_FraudulentApplication, Suspicious_Fraud_LN.Common.genRiskCode('A23')) +
																									 IF(le.USPIS_FraudulentMail, Suspicious_Fraud_LN.Common.genRiskCode('A24')) +
																									 IF(le.USPIS_ATMDebitCardFraud, Suspicious_Fraud_LN.Common.genRiskCode('A25')) +
																									 IF(le.USPIS_FraudulentMerchandise, Suspicious_Fraud_LN.Common.genRiskCode('A26')) +
																									 IF(le.USPIS_FraudulentInvoice, Suspicious_Fraud_LN.Common.genRiskCode('A27')) +
																									 IF(le.USPIS_MerchandiseReshipping, Suspicious_Fraud_LN.Common.genRiskCode('A28')) +
																									 IF(le.USPIS_NewAccountFraud, Suspicious_Fraud_LN.Common.genRiskCode('A29')) +
																									 IF(le.USPIS_Reshipping, Suspicious_Fraud_LN.Common.genRiskCode('A30')) +
																									 IF(le.USPIS_OtherFraud, Suspicious_Fraud_LN.Common.genRiskCode('A31')) +
																									 IF(le.USPIS_Vacant, Suspicious_Fraud_LN.Common.genRiskCode('A32'));
		RiskCodes																		:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		AddressHit																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Address.Data_Source					:= IF(AddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Address.DateFirstSeenInFile	:= IF(AddressHit = FALSE OR (INTEGER)le.DateFirstSeen IN [-1, 0], '', le.DateFirstSeen);
		SELF.USPISHotListRecords										:= le.USPISHotList;
		
		SELF.RiskCode_Address												:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.StreetAddress1							:= le.StreetAddress1;
		SELF.Clean_Input.StreetAddress2							:= le.StreetAddress2;
		SELF.Clean_Input.City												:= le.City;
		SELF.Clean_Input.State											:= le.State;
		SELF.Clean_Input.Zip												:= le.Zip;
		SELF.Clean_Input.Zip5												:= le.Zip5;
		SELF.Clean_Input.Zip4												:= le.Zip4;
		SELF.Clean_Input.Prim_Range									:= le.Prim_Range;
		SELF.Clean_Input.Predir											:= le.Predir;
		SELF.Clean_Input.Prim_Name									:= le.Prim_Name;
		SELF.Clean_Input.Addr_Suffix								:= le.Addr_Suffix;
		SELF.Clean_Input.Postdir										:= le.Postdir;
		SELF.Clean_Input.Unit_Desig									:= le.Unit_Desig;
		SELF.Clean_Input.Sec_Range									:= le.Sec_Range;
		SELF.Clean_Input.ArchiveDate								:= le.ArchiveDate;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	addrRiskCodes := PROJECT(addressRiskSummary, getAddressRiskCodes(LEFT)) (ut.Exists2(RiskCode_Address));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getADVORiskCodes(TempADVORisk le) := TRANSFORM
		RiskCodesTemp																:= IF(le.Address_Vacancy_Indicator = 'Y' AND le.InputPOBox = FALSE, Suspicious_Fraud_LN.Common.genRiskCode('A07')) +
																									 IF(le.Seasonal_Delivery_Indicator = 'E' OR le.College_Indicator = 'Y', Suspicious_Fraud_LN.Common.genRiskCode('A09')) +
																									 IF(le.Drop_Indicator = 'C', Suspicious_Fraud_LN.Common.genRiskCode('A17')) +
																									 IF(le.Address_Vacancy_Indicator = 'Y' AND le.InputPOBox = TRUE, Suspicious_Fraud_LN.Common.genRiskCode('A18'));
		RiskCodes																		:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		AddressHit																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Address.Data_Source					:= IF(AddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Address.DateFirstSeenInFile	:= IF(AddressHit = FALSE OR (INTEGER)le.DateFirstSeen IN [-1, 0], '', le.DateFirstSeen);
		
		SELF.RiskCode_Address												:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.StreetAddress1							:= le.StreetAddress1;
		SELF.Clean_Input.StreetAddress2							:= le.StreetAddress2;
		SELF.Clean_Input.City												:= le.City;
		SELF.Clean_Input.State											:= le.State;
		SELF.Clean_Input.Zip												:= le.Zip;
		SELF.Clean_Input.Zip5												:= le.Zip5;
		SELF.Clean_Input.Zip4												:= le.Zip4;
		SELF.Clean_Input.Prim_Range									:= le.Prim_Range;
		SELF.Clean_Input.Predir											:= le.Predir;
		SELF.Clean_Input.Prim_Name									:= le.Prim_Name;
		SELF.Clean_Input.Addr_Suffix								:= le.Addr_Suffix;
		SELF.Clean_Input.Postdir										:= le.Postdir;
		SELF.Clean_Input.Unit_Desig									:= le.Unit_Desig;
		SELF.Clean_Input.Sec_Range									:= le.Sec_Range;
		SELF.Clean_Input.ArchiveDate								:= le.ArchiveDate;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	ADVORiskCodes := PROJECT(getADVO, getADVORiskCodes(LEFT)) (ut.Exists2(RiskCode_Address));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getHeaderRiskCodes(TempHeader le) := TRANSFORM
		RiskCodesTemp																:= IF(le.UniqueDIDCount2Months >= 16, Suspicious_Fraud_LN.Common.genRiskCode('A08'));
		RiskCodes																		:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		AddressHit																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Address.Data_Source					:= IF(AddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Address.DateFirstSeenInFile	:= IF(AddressHit = FALSE OR (INTEGER)le.DateFirstSeen IN [-1, 0], '', le.DateFirstSeen);
		
		SELF.RiskCode_Address												:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.StreetAddress1							:= le.StreetAddress1;
		SELF.Clean_Input.StreetAddress2							:= le.StreetAddress2;
		SELF.Clean_Input.City												:= le.City;
		SELF.Clean_Input.State											:= le.State;
		SELF.Clean_Input.Zip												:= le.Zip;
		SELF.Clean_Input.Zip5												:= le.Zip5;
		SELF.Clean_Input.Zip4												:= le.Zip4;
		SELF.Clean_Input.Prim_Range									:= le.Prim_Range;
		SELF.Clean_Input.Predir											:= le.Predir;
		SELF.Clean_Input.Prim_Name									:= le.Prim_Name;
		SELF.Clean_Input.Addr_Suffix								:= le.Addr_Suffix;
		SELF.Clean_Input.Postdir										:= le.Postdir;
		SELF.Clean_Input.Unit_Desig									:= le.Unit_Desig;
		SELF.Clean_Input.Sec_Range									:= le.Sec_Range;
		SELF.Clean_Input.ArchiveDate								:= le.ArchiveDate;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	HeaderRiskCodes := PROJECT(headerAddressCounted, getHeaderRiskCodes(LEFT)) (ut.Exists2(RiskCode_Address));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getBusinessHeaderRiskCodes(TempBusinessHeader le) := TRANSFORM
		RiskCodesTemp																:= IF(le.UniqueBDIDCount2Months >= 16, Suspicious_Fraud_LN.Common.genRiskCode('A10'));
		RiskCodes																		:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		AddressHit																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Address.Data_Source					:= IF(AddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Address.DateFirstSeenInFile	:= IF(AddressHit = FALSE OR (INTEGER)le.DateFirstSeen IN [-1, 0], '', le.DateFirstSeen);
		
		SELF.RiskCode_Address												:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.StreetAddress1							:= le.StreetAddress1;
		SELF.Clean_Input.StreetAddress2							:= le.StreetAddress2;
		SELF.Clean_Input.City												:= le.City;
		SELF.Clean_Input.State											:= le.State;
		SELF.Clean_Input.Zip												:= le.Zip;
		SELF.Clean_Input.Zip5												:= le.Zip5;
		SELF.Clean_Input.Zip4												:= le.Zip4;
		SELF.Clean_Input.Prim_Range									:= le.Prim_Range;
		SELF.Clean_Input.Predir											:= le.Predir;
		SELF.Clean_Input.Prim_Name									:= le.Prim_Name;
		SELF.Clean_Input.Addr_Suffix								:= le.Addr_Suffix;
		SELF.Clean_Input.Postdir										:= le.Postdir;
		SELF.Clean_Input.Unit_Desig									:= le.Unit_Desig;
		SELF.Clean_Input.Sec_Range									:= le.Sec_Range;
		SELF.Clean_Input.ArchiveDate								:= le.ArchiveDate;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	BusinessHeaderRiskCodes := PROJECT(businessHeaderAddressCounted, getBusinessHeaderRiskCodes(LEFT)) (ut.Exists2(RiskCode_Address));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquiryAddressRiskCodes(TempInquiryAddress le) := TRANSFORM
		RiskCodesLNRSnSFTemp												:= IF(le.InquiryCountLNRSnSFYear >= 30, Suspicious_Fraud_LN.Common.genRiskCode('A03')) + 
																									 IF(le.InquiryCountLNRSnSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('A04')) +
																									 IF(le.InquiryCountLNRSnSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('A05')) +
																									 IF(le.InquiryCountLNRSnSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('A06'));
		RiskCodesLNRSnSF														:= RiskCodesLNRSnSFTemp (TRIM(SuspiciousRiskCode) <> '');
		RiskCodesSFTemp															:= IF(le.InquiryCountSFYear >= 7, Suspicious_Fraud_LN.Common.genRiskCode('A12')) +
																									 IF(le.InquiryCountSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('A13')) +
																									 IF(le.InquiryCountSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('A14')) +
																									 IF(le.InquiryCountSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('A15')) +
																									 IF(le.InquiryCountSFHour >= 1, Suspicious_Fraud_LN.Common.genRiskCode('A16'));
		RiskCodesSF																	:= RiskCodesSFTemp (TRIM(SuspiciousRiskCode) <> '');
		RiskCodes																		:= RiskCodesLNRSnSF + RiskCodesSF;
		LNRSnSFHit																	:= ut.Exists2(RiskCodesLNRSnSF);
		SFHit																				:= ut.Exists2(RiskCodesSF);
		AddressHit 																	:= LNRSnSFHit OR SFHit;
		SELF.Suspicious_Address.Data_Source					:= IF(AddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Address.DateFirstSeenInFile	:= MAP(LNRSnSFHit = TRUE	=> le.DateFirstSeenLNRSnSF,
																											 SFHit = TRUE				=> le.DateFirstSeenSF,
																																						 '');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_Address.InquiryCountHour		:= le.InquiryCountSFHour;
		SELF.Suspicious_Address.InquiryCountDay			:= le.InquiryCountSFDay;
		SELF.Suspicious_Address.InquiryCountWeek		:= le.InquiryCountSFWeek;
		SELF.Suspicious_Address.InquiryCountMonth		:= le.InquiryCountSFMonth;
		SELF.Suspicious_Address.InquiryCountYear		:= le.InquiryCountSFYear;
		SELF.Suspicious_Address.InquiryCount				:= le.InquiryCountSF;
		SELF.RiskCode_Address												:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.StreetAddress1							:= le.StreetAddress1;
		SELF.Clean_Input.City												:= le.City;
		SELF.Clean_Input.State											:= le.State;
		SELF.Clean_Input.Zip												:= le.Zip;
		SELF.Clean_Input.Zip5												:= le.Zip5;
		SELF.Clean_Input.Zip4												:= le.Zip4;
		SELF.Clean_Input.Prim_Range									:= le.Prim_Range;
		SELF.Clean_Input.Predir											:= le.Predir;
		SELF.Clean_Input.Prim_Name									:= le.Prim_Name;
		SELF.Clean_Input.Addr_Suffix								:= le.Addr_Suffix;
		SELF.Clean_Input.Postdir										:= le.Postdir;
		SELF.Clean_Input.Unit_Desig									:= le.Unit_Desig;
		SELF.Clean_Input.Sec_Range									:= le.Sec_Range;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	inquiryAddressRiskCodes := PROJECT(inquiriesCounted, getInquiryAddressRiskCodes(LEFT)) (ut.Exists2(RiskCode_Address));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combineAddressRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_Address.Data_Source := IF(le.Suspicious_Address.Data_Source <> '', le.Suspicious_Address.Data_Source, ri.Suspicious_Address.Data_Source);
		SELF.USPISHotListRecords := le.USPISHotListRecords + ri.USPISHotListRecords;
		SELF.Suspicious_Address.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_Address.DateFirstSeenInFile IN [0, 19000101]	=> ri.Suspicious_Address.DateFirstSeenInFile,
																									 (UNSIGNED)ri.Suspicious_Address.DateFirstSeenInFile IN [0, 19000101]	=> le.Suspicious_Address.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_Address.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_Address.DateFirstSeenInFile));
		SELF.Suspicious_Address.InquiryCountHour := le.Suspicious_Address.InquiryCountHour + ri.Suspicious_Address.InquiryCountHour;
		SELF.Suspicious_Address.InquiryCountDay := le.Suspicious_Address.InquiryCountDay + ri.Suspicious_Address.InquiryCountDay;
		SELF.Suspicious_Address.InquiryCountWeek := le.Suspicious_Address.InquiryCountWeek + ri.Suspicious_Address.InquiryCountWeek;
		SELF.Suspicious_Address.InquiryCountMonth := le.Suspicious_Address.InquiryCountMonth + ri.Suspicious_Address.InquiryCountMonth;
		SELF.Suspicious_Address.InquiryCountYear := le.Suspicious_Address.InquiryCountYear + ri.Suspicious_Address.InquiryCountYear;
		SELF.Suspicious_Address.InquiryCount := le.Suspicious_Address.InquiryCount + ri.Suspicious_Address.InquiryCount;
		SELF.RiskCode_Address := le.RiskCode_Address + ri.RiskCode_Address;
		
		SELF := le;
	END;
	
	addressRiskCodesCombined := SORT(addrRiskCodes + ADVORiskCodes + HeaderRiskCodes + BusinessHeaderRiskCodes + inquiryAddressRiskCodes, Seq);

	addressRiskCodesTemp := ROLLUP(addressRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combineAddressRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanAddressRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_Address, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_Address := sortedCodes;
		sortedUSPISCodes := DEDUP(SORT(le.USPISHotListRecords, -DateAdded, ReasonAdded), DateAdded, ReasonAdded);
		SELF.USPISHotListRecords := sortedUSPISCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanAddressRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_Address;
		sortedUSPISCodes := le.USPISHotListRecords;
		SELF.Suspicious_Address.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		keepUSPISDelimited := CHOOSEN(sortedUSPISCodes, 5); // Keep 5, that's all the delimited fields have room for.
		SELF.Suspicious_Address.USPISHotListDateAdded := Suspicious_Fraud_LN.Common.convertDelimited(keepUSPISDelimited, DateAdded, ',');
		SELF.Suspicious_Address.USPISHotListReason := Suspicious_Fraud_LN.Common.convertDelimited(keepUSPISDelimited, ReasonAdded, ',');
		SELF.Suspicious_Address.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_Address.DateFirstSeenInFile);
		SELF := le;
	END;
	addressRiskCodes1 := PROJECT(addressRiskCodesTemp, cleanAddressRiskCodes1(LEFT));
	addressRiskCodes := PROJECT(NOFOLD(addressRiskCodes1), cleanAddressRiskCodes2(LEFT));

	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(getUSPISRaw, NAMED('getUSPISRaw'));
	// OUTPUT(getUSPIS, NAMED('getUSPIS'));
	// OUTPUT(getHRIRaw, NAMED('getHRIRaw'));
	// OUTPUT(getHRI, NAMED('getHRI'));
	// OUTPUT(getADVORaw, NAMED('getADVORaw'));
	// OUTPUT(getADVO, NAMED('getADVO'));
	// OUTPUT(headerAddressCounted, NAMED('headerAddressCounted'));
	// OUTPUT(businessHeaderAddressCounted, NAMED('businessHeaderAddressCounted'));
	// OUTPUT(inquiryBucketed, NAMED('inquiryAddressBucketed'));
	// OUTPUT(inquiriesCounted, NAMED('inquiriesAddressCounted'));
	// OUTPUT(addressRiskSummary, NAMED('addressRiskSummary'));
	// OUTPUT(addrRiskCodes, NAMED('addrRiskCodes'));
	// OUTPUT(ADVORiskCodes, NAMED('ADVORiskCodes'));
	// OUTPUT(HeaderRiskCodes, NAMED('HeaderRiskCodes'));
	// OUTPUT(BusinessHeaderRiskCodes, NAMED('BusinessHeaderRiskCodes'));
	// OUTPUT(inquiryAddressRiskCodes, NAMED('inquiryAddressRiskCodes'));
	// OUTPUT(addressRiskCodesCombined, NAMED('addressRiskCodesCombined'));
	// OUTPUT(addressRiskCodesTemp, NAMED('addressRiskCodesTemp'));
	// OUTPUT(addressRiskCodes, NAMED('addressRiskCodes'));

	/* ******** END DEBUGGING SECTION **********/
	RETURN (addressRiskCodes);
END;
