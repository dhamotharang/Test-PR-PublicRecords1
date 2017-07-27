/* EditsV2 - Response related layouts definition */
EXPORT Layouts_Response := MODULE

	// RI Record - Report usage codes - type of search, etc.
	EXPORT RI51_V2 := RECORD
		STRING3	 UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrNum;
		STRING2  SecOccrNum;
		
		STRING60 QuotebackText;
		STRING4	 ReportCode;
		STRING15 ReportName;
		STRING1  ReportVerCode;
		
		STRING6  AcctNum;
		STRING3	 AcctSufNum;
		
		STRING15 CustBillIdText;
		STRING8  OrderDate;
		STRING8  OrderRecdDate;
		STRING8  CompleteDate;
		
		STRING1  ReportStatusCode;
		STRING2  ReportUseCode;
		STRING14 ReportRefNum;
		STRING4  ReportTime;
		STRING4  ProdCode;

		STRING1  Attch1PrcsngStat;
		STRING1  Attch2PrcsngStat;
		STRING1  Attch3PrcsngStat;
		STRING1  Attch4PrcsngStat;
		STRING1  Attch5PrcsngStat;
		STRING1  Attch6PrcsngStat;
		STRING1  Attch7PrcsngStat;
		STRING1  Attch8PrcsngStat;
		STRING1  Attch9PrcsngStat;
		STRING1  Attch10PrcsngStat;

		STRING1  Filler1;
		STRING2  RecVerNum;
		STRING50 Filler2;
	END;
	
	// PI Record - Personal Data
	EXPORT PI51_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrNum;
		STRING2  SecOccrNum;
		
		STRING2  ClassCode;
		STRING4  PrefName;
		STRING28 LastName;
		STRING20 FirstName;
		STRING15 MidName;
		STRING3  SufName;
		
		STRING8  BirthDate;
		STRING3  AgeCnt;
		STRING1  SexCode;
		STRING9  SsnNum;
		
		STRING1  HtFtCnt;
		STRING2  HtInCnt;
		STRING3  WtCnt;
		
		STRING1  RelCode;
		STRING20 RelDesc;
		STRING1  AddrAssocFlag;
		STRING1  NameAssocFlag;
		STRING8  AssocDate;
		STRING1  MarrStatCode;
		
		STRING1  PrefNameInd;
		STRING1  LastNameInd;
		STRING1  FirstNameInd;
		STRING1  MidNameInd;
		STRING1  SuffNameInd;
		STRING1  BirthDateInd;
		STRING1  AgeInd;
		STRING1  SexInd;
		STRING1  SsnInd;
		STRING1  HtFtInd;
		STRING1  HtInInd;
		STRING1  WtInd;
		STRING1  RelCodeInd;
		STRING1  MarrStatInd;
		STRING1  EyeCodeInd;
		STRING1  HairCodeInd;

		STRING1  RsrvdForPlcyWatchUse;
		STRING1  SsnVerIndInd;
		STRING1  RaceCode;
		STRING1  SrceIndInd;

		STRING3  EyeCode;
		STRING3  HairCode;
		STRING8  ExpireDate;
		STRING2  DepenCnt;
		STRING49 Filler1;
	END;
	
	// AL Record - Address Data
	EXPORT AL51_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrNum;
		STRING2  SecOccrNum;
		
		STRING2  ClassCode;
		STRING1  GroupUseInd;
		
		STRING9  HouseNum;
		STRING20 StrName;
		STRING5  AptNum;
		
		STRING20 CityName;
		STRING2  StateCode;
		STRING5  ZipNum;
		STRING4  ZipSufNum;
		
		STRING2  YrCnt;
		STRING2  MoCnt;
		STRING8  StartDate;
		STRING8  EndDate;
		
		STRING1  HouseInd;
		STRING1  StrInd;
		STRING1  AptInd;
		STRING1  CityInd;
		STRING1  StateInd;
		STRING1  ZipInd;
		STRING1  ZipSufInd;
		STRING1  YrCntInd;
		STRING1  MoCntInd;
		STRING1  StartDateInd;
		STRING1  EndDateInd;

		STRING10 Filler3;

		STRING1  ResOwnInd;
		STRING15 CntyName;
		STRING8  AssocDate;
		STRING1  SrceInd;

		STRING2  AddrTypeCode;
		STRING10 CnssTrct;
		STRING70 Filler5;
	END;
	
	// DL Record - Drivers License Data
	EXPORT DL51_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrNum;
		STRING2  SecOccrNum;
		
		STRING2  ClassCode;
		STRING25 LicNum;
		STRING2  StateCode;
		STRING37 Filler1;

		STRING1  DriverClassInd;
		STRING1  DriverLicInd;
		STRING1  DriverStateInd;
		STRING10 DriverLicTypeDesc;
		STRING15 DriverRestrictText;

		STRING8  LicIssueDate;
		STRING8  LicExprDate;
		STRING8  DataAssocDate;
		STRING1  DataSrceInd;
		STRING97 Filler2;
	END;

	// SH record
	EXPORT SH51_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrNum;
		STRING2  SecOccrNum;
		
		STRING5  SectCode;
		STRING79 SectDesc;
		STRING1  SectFlag;
		STRING131 Filler;
	END;
	
	// RC record
	EXPORT RC51_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrANum;
		STRING2  OccrBNum;
		STRING2  SpcFtnClassCD;
		
		STRING2  Filler1;
		STRING2  SpcFtn1TypeCD;
		STRING1  SpcFtn1StatCD;
		STRING7  SpcFtn1TypeCT;
		STRING202 Filler;
	END;
	
	// RP record
	EXPORT RP51_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  FirstOccrNum;
		STRING2  SecOccrNum;
		STRING50 RQStrName;
		STRING166 Filler1;
	END;
	
	// RI52 record
	EXPORT RI52_V2 := RECORD
		STRING3  UnitNum;
		STRING3  SeqNum;
		STRING4  RecCode;
		STRING2  OccrNum;
		STRING2  SecOccrNum;
		
		STRING2  TypeCode;
		STRING40 AcctName;
		STRING10 OrgCode;
		STRING10 Org2Code;
		STRING10 Org3Code;
		STRING10 Org4Code;
		
		STRING10 SplIdDesc;
		STRING10 SplId2Desc;
		STRING10 SplId3Desc;
		STRING10 SplId4Desc;
		STRING10 SplId5Desc;
		STRING10 SplId6Desc;
		
		STRING14 OrignalRefNum;
		STRING8  OriginalProcDate;
		STRING4  SpecNumField;
		STRING48 Filler1;
	END;
	
	// EditsV2_Response (Generic)
	EXPORT Response := RECORD
		DATASET (RI51_V2) RI51_Recs{MAXCOUNT(20)};
		DATASET (RI52_V2) RI52_Recs{MAXCOUNT(20)};
		DATASET (RP51_V2) RP51_Recs{MAXCOUNT(20)};
		DATASET (RC51_V2) RC51_Inq_Recs{MAXCOUNT(20)};
		
		// Inquiry section
		DATASET (SH51_V2) SH51_Inq_Recs{MAXCOUNT(20)};
		DATASET (PI51_V2) PI51_Inq_Recs{MAXCOUNT(20)};
		DATASET (DL51_V2) DL51_Inq_Recs{MAXCOUNT(20)};
		DATASET (AL51_V2) AL51_Inq_Recs{MAXCOUNT(20)};
		
		// Subject section
		DATASET (SH51_V2) SH51_Recs{MAXCOUNT(20)};
		DATASET (RC51_V2) RC51_Recs{MAXCOUNT(20)};
		DATASET (PI51_V2) PI51_Recs{MAXCOUNT(20)};
		DATASET (DL51_V2) DL51_Recs{MAXCOUNT(20)};
		DATASET (AL51_V2) AL51_Recs{MAXCOUNT(20)};

	END;
	
END;