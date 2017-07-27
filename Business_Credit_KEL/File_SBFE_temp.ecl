IMPORT Business_Credit, Business_Risk_BIP;

LoadDate_Layout := RECORD
 	STRING14 load_date;
	STRING8 load_dateYYYYMMDD;
END;

LinkId_Layout := RECORD
	RECORDOF(Business_Credit.Key_LinkIds().key);
	UNSIGNED4 Seq:=0;
	UNSIGNED4 acct_no:=0;
	UNSIGNED3 HistoryDate:=(INTEGER)Business_Risk_BIP.Constants.NinesDate;
	UNSIGNED6 HistoryDateTime:=(INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	UNSIGNED1 HistoryDateLength:=0;
	LoadDate_Layout;
END;

Tradeline_Layout := RECORD
	UNSIGNED4 seq_num;
	UNSIGNED4 seq := 0;
	UNSIGNED4 acct_no:= 0;
	UNSIGNED6 HistoryDateTime:=(INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	LoadDate_Layout;
	RECORDOF(Business_Credit.Key_tradeline());
END;

BusinessClassification_Layout := RECORD
	UNSIGNED4 seq_num;
	UNSIGNED4 Seq := 0;
	UNSIGNED4 acct_no :=0;
	UNSIGNED6 HistoryDateTime:=(INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	LoadDate_Layout;
	RECORDOF(Business_Credit.Key_BusinessClassification());
END;
	
BusinessInformation_Layout := RECORD
	UNSIGNED4 seq_num;
	UNSIGNED4 Seq:=0;
	UNSIGNED4 acct_no :=0;
	LoadDate_Layout;
	UNSIGNED3 HistoryDate:=(INTEGER)Business_Risk_BIP.Constants.NinesDate;
	UNSIGNED6 HistoryDateTime:=(INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	UNSIGNED1 HistoryDateLength:=0;
	RECORDOF(Business_Credit.Key_BusinessInformation());
	DATASET(BusinessClassification_Layout) BusinessClassification;
END;

BusinessOwner_Layout := RECORD
	UNSIGNED4 seq_num;
	UNSIGNED4 Seq := 0;
	UNSIGNED4 acct_no :=0;
	UNSIGNED6 HistoryDateTime:=(INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	LoadDate_Layout;
	RECORDOF(Business_Credit.Key_BusinessOwner());
END;

IndividualOwner_Layout := RECORD
	UNSIGNED4 seq_num;
	UNSIGNED4 Seq := 0;
	UNSIGNED4 acct_no :=0;
	UNSIGNED6 HistoryDateTime:=(INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	LoadDate_Layout;
	RECORDOF(Business_Credit.Key_IndividualOwner());
END;

Layout := RECORD
	UNSIGNED4 Seq := 0;
	UNSIGNED3 HistoryDate := (INTEGER)Business_Risk_BIP.Constants.NinesDate;
	UNSIGNED6 HistoryDateTime := (INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
	UNSIGNED1 HistoryDateLength := 0;
	DATASET(LinkId_Layout) linkids;
	DATASET(Tradeline_Layout) tradelines;
	DATASET(BusinessInformation_Layout) BusinessInformation;
	DATASET(BusinessClassification_Layout) BusinessClassification;
	DATASET(BusinessOwner_Layout) BusinessOwner;
	DATASET(IndividualOwner_Layout) IndividualOwner;
END;

EXPORT File_SBFE_temp := PROJECT(Business_Credit.Key_LinkIds().Key, TRANSFORM(layout, SELF := LEFT, SELF :=[]));
// File_SBFE_temp only returns a blank file.
// We just need to 'fake' a file in the correct layout for FDC mode so that the KEL will compile.
// The real data SBFE data we want to use is gathered in  Business_Credit_KEL.GLUE_fdc_append.