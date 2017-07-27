/* EditsV2 - Inquiry/Order related layouts definition */
EXPORT Layouts_Order := MODULE
	
	// RI Record - Report usage codes - type of search, etc.
	EXPORT RI01_V2 := RECORD
		STRING3	 UnitNum;
		STRING4  RecCode;
		
		STRING6  AcctNum;
		STRING3	 AcctSufNum;
		
		STRING15 CustBillIdText;
		STRING60 QuotebackText;
		
		STRING4	 ReportCode;
		STRING1  ReportVerCode;
		STRING6  Filler;
		
		STRING2  ReportUseCode;
		STRING7  ReportWrkdLocCode;
		STRING1  ProdLineCode;
		STRING1  Filler2;
		
		STRING2  RecVerNum;
		STRING8  ReportOrderDate;
		STRING27 Filler3;
	END;
	
	// PI Record - Personal Data
	EXPORT PI01_V2 := RECORD
		STRING3  UnitNum;
		STRING4  RecCode;
		
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
		STRING1  MarrStatCode;
		
		STRING3  EyeCode;
		STRING3  HairCode;
		STRING1  RaceCode;
		STRING36 Filler1;
	END;
	
	// AL Record - Address Data
	EXPORT AL01_V2 := RECORD
		STRING3  UnitNum;
		STRING4  RecCode;
		
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
		
		STRING15 CntyName;
		STRING10 CnssTrct;
		STRING30 Filler1;
	END;
	
	// DL Record - Drivers License Data
	EXPORT DL01_V2 := RECORD
		STRING3  UnitNum;
		STRING4  RecCode;
		
		STRING2  ClassCode;
		STRING25 LicNum;
		STRING2  StateCode;
		
		STRING114 Filler1;
	END;
	
	// Record RP01 
	EXPORT RP01_V2 := RECORD
		STRING3  UnitNum;
		STRING4  RecCode;
		STRING50 RptRqstrName;
		STRING50 CoName;		
		STRING2  ClassCode;
		STRING41 Filler1;
	END;	
	
	// Record RI02 
	EXPORT RI02_V2 := RECORD
		STRING3  UnitNum;
		STRING4  RecCode;
		STRING10 CustOrgLvl1Code;
		STRING10 CustOrgLvl2Code;
		STRING10 CustOrgLvl3Code;
		STRING10 CustOrgLvl4Code;
		STRING10 RptSplFldId1Desc;
		STRING10 RptSplFldId2Desc;
		STRING10 RptSplFldId3Desc;
		STRING10 RptSplFldIdADesc;
		STRING10 RptSplFldIdBDesc;
		STRING10 RptSplFldIdCDesc;
		STRING4  RptSpecFldId1Num;
		STRING39 Filler1;
	END;	
	
	// EditsV2_Order (Generic)
	EXPORT Order := RECORD
		DATASET (RI01_V2) RI01_Recs{MAXCOUNT(20)};
		DATASET (PI01_V2) PI01_Recs{MAXCOUNT(20)};
		DATASET (AL01_V2) AL01_Recs{MAXCOUNT(20)};
		DATASET (DL01_V2) DL01_Recs{MAXCOUNT(20)};
		DATASET (RP01_V2) RP01_Recs{MAXCOUNT(20)};
		DATASET (RI02_V2) RI02_Recs{MAXCOUNT(20)};
	END;
	
END;
