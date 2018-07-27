IMPORT SALT39,STD;
EXPORT NAC_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 32;
  EXPORT NumRulesFromFieldType := 32;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 18;
  EXPORT NumFieldsWithPossibleEdits := 6;
  EXPORT NumRulesWithPossibleEdits := 17;
  EXPORT Expanded_Layout := RECORD(NAC_Layout_NAC)
    UNSIGNED1 SearchAddress1StreetAddress1_Invalid;
    UNSIGNED1 SearchAddress1StreetAddress2_Invalid;
    UNSIGNED1 SearchAddress1City_Invalid;
    UNSIGNED1 SearchAddress1State_Invalid;
    BOOLEAN SearchAddress1State_wouldClean;
    UNSIGNED1 SearchAddress1Zip_Invalid;
    BOOLEAN SearchAddress1Zip_wouldClean;
    UNSIGNED1 SearchAddress2StreetAddress1_Invalid;
    UNSIGNED1 SearchAddress2StreetAddress2_Invalid;
    UNSIGNED1 SearchAddress2City_Invalid;
    UNSIGNED1 SearchAddress2State_Invalid;
    BOOLEAN SearchAddress2State_wouldClean;
    UNSIGNED1 SearchAddress2Zip_Invalid;
    BOOLEAN SearchAddress2Zip_wouldClean;
    UNSIGNED1 SearchCaseId_Invalid;
    UNSIGNED1 enduserip_Invalid;
    BOOLEAN enduserip_wouldClean;
    UNSIGNED1 CaseID_Invalid;
    UNSIGNED1 ClientFirstName_Invalid;
    UNSIGNED1 ClientMiddleName_Invalid;
    UNSIGNED1 ClientLastName_Invalid;
    UNSIGNED1 ClientPhone_Invalid;
    BOOLEAN ClientPhone_wouldClean;
    UNSIGNED1 ClientEmail_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(NAC_Layout_NAC)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(NAC_Layout_NAC) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.SearchAddress1StreetAddress1_Invalid := NAC_Fields.InValid_SearchAddress1StreetAddress1((SALT39.StrType)le.SearchAddress1StreetAddress1);
    SELF.SearchAddress1StreetAddress2_Invalid := NAC_Fields.InValid_SearchAddress1StreetAddress2((SALT39.StrType)le.SearchAddress1StreetAddress2);
    SELF.SearchAddress1City_Invalid := NAC_Fields.InValid_SearchAddress1City((SALT39.StrType)le.SearchAddress1City);
    SELF.SearchAddress1State_Invalid := NAC_Fields.InValid_SearchAddress1State((SALT39.StrType)le.SearchAddress1State);
    SELF.SearchAddress1State := IF(SELF.SearchAddress1State_Invalid=0 OR NOT withOnfail, le.SearchAddress1State, (TYPEOF(le.SearchAddress1State))''); // ONFAIL(BLANK)
    SELF.SearchAddress1State_wouldClean :=  SELF.SearchAddress1State_Invalid > 0;
    SELF.SearchAddress1Zip_Invalid := NAC_Fields.InValid_SearchAddress1Zip((SALT39.StrType)le.SearchAddress1Zip);
    SELF.SearchAddress1Zip := IF(SELF.SearchAddress1Zip_Invalid=0 OR NOT withOnfail, le.SearchAddress1Zip, (TYPEOF(le.SearchAddress1Zip))''); // ONFAIL(BLANK)
    SELF.SearchAddress1Zip_wouldClean :=  SELF.SearchAddress1Zip_Invalid > 0;
    SELF.SearchAddress2StreetAddress1_Invalid := NAC_Fields.InValid_SearchAddress2StreetAddress1((SALT39.StrType)le.SearchAddress2StreetAddress1);
    SELF.SearchAddress2StreetAddress2_Invalid := NAC_Fields.InValid_SearchAddress2StreetAddress2((SALT39.StrType)le.SearchAddress2StreetAddress2);
    SELF.SearchAddress2City_Invalid := NAC_Fields.InValid_SearchAddress2City((SALT39.StrType)le.SearchAddress2City);
    SELF.SearchAddress2State_Invalid := NAC_Fields.InValid_SearchAddress2State((SALT39.StrType)le.SearchAddress2State);
    SELF.SearchAddress2State := IF(SELF.SearchAddress2State_Invalid=0 OR NOT withOnfail, le.SearchAddress2State, (TYPEOF(le.SearchAddress2State))''); // ONFAIL(BLANK)
    SELF.SearchAddress2State_wouldClean :=  SELF.SearchAddress2State_Invalid > 0;
    SELF.SearchAddress2Zip_Invalid := NAC_Fields.InValid_SearchAddress2Zip((SALT39.StrType)le.SearchAddress2Zip);
    SELF.SearchAddress2Zip := IF(SELF.SearchAddress2Zip_Invalid=0 OR NOT withOnfail, le.SearchAddress2Zip, (TYPEOF(le.SearchAddress2Zip))''); // ONFAIL(BLANK)
    SELF.SearchAddress2Zip_wouldClean :=  SELF.SearchAddress2Zip_Invalid > 0;
    SELF.SearchCaseId_Invalid := NAC_Fields.InValid_SearchCaseId((SALT39.StrType)le.SearchCaseId);
    SELF.enduserip_Invalid := NAC_Fields.InValid_enduserip((SALT39.StrType)le.enduserip);
    SELF.enduserip := IF(SELF.enduserip_Invalid=0 OR NOT withOnfail, le.enduserip, (TYPEOF(le.enduserip))''); // ONFAIL(BLANK)
    SELF.enduserip_wouldClean :=  SELF.enduserip_Invalid > 0;
    SELF.CaseID_Invalid := NAC_Fields.InValid_CaseID((SALT39.StrType)le.CaseID);
    SELF.ClientFirstName_Invalid := NAC_Fields.InValid_ClientFirstName((SALT39.StrType)le.ClientFirstName);
    SELF.ClientMiddleName_Invalid := NAC_Fields.InValid_ClientMiddleName((SALT39.StrType)le.ClientMiddleName);
    SELF.ClientLastName_Invalid := NAC_Fields.InValid_ClientLastName((SALT39.StrType)le.ClientLastName);
    SELF.ClientPhone_Invalid := NAC_Fields.InValid_ClientPhone((SALT39.StrType)le.ClientPhone);
    SELF.ClientPhone := IF(SELF.ClientPhone_Invalid=0 OR NOT withOnfail, le.ClientPhone, (TYPEOF(le.ClientPhone))''); // ONFAIL(BLANK)
    SELF.ClientPhone_wouldClean :=  SELF.ClientPhone_Invalid > 0;
    SELF.ClientEmail_Invalid := NAC_Fields.InValid_ClientEmail((SALT39.StrType)le.ClientEmail);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),NAC_Layout_NAC);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.SearchAddress1StreetAddress1_Invalid << 0 ) + ( le.SearchAddress1StreetAddress2_Invalid << 1 ) + ( le.SearchAddress1City_Invalid << 2 ) + ( le.SearchAddress1State_Invalid << 3 ) + ( le.SearchAddress1Zip_Invalid << 5 ) + ( le.SearchAddress2StreetAddress1_Invalid << 7 ) + ( le.SearchAddress2StreetAddress2_Invalid << 8 ) + ( le.SearchAddress2City_Invalid << 9 ) + ( le.SearchAddress2State_Invalid << 10 ) + ( le.SearchAddress2Zip_Invalid << 12 ) + ( le.SearchCaseId_Invalid << 14 ) + ( le.enduserip_Invalid << 15 ) + ( le.CaseID_Invalid << 17 ) + ( le.ClientFirstName_Invalid << 18 ) + ( le.ClientMiddleName_Invalid << 20 ) + ( le.ClientLastName_Invalid << 22 ) + ( le.ClientPhone_Invalid << 24 ) + ( le.ClientEmail_Invalid << 26 );
    SELF.ScrubsCleanBits1 := ( IF(le.SearchAddress1State_wouldClean, 1, 0) << 0 ) + ( IF(le.SearchAddress1Zip_wouldClean, 1, 0) << 1 ) + ( IF(le.SearchAddress2State_wouldClean, 1, 0) << 2 ) + ( IF(le.SearchAddress2Zip_wouldClean, 1, 0) << 3 ) + ( IF(le.enduserip_wouldClean, 1, 0) << 4 ) + ( IF(le.ClientPhone_wouldClean, 1, 0) << 5 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,NAC_Layout_NAC);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.SearchAddress1StreetAddress1_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.SearchAddress1StreetAddress2_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.SearchAddress1City_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.SearchAddress1State_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.SearchAddress1Zip_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.SearchAddress2StreetAddress1_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.SearchAddress2StreetAddress2_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.SearchAddress2City_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.SearchAddress2State_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.SearchAddress2Zip_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.SearchCaseId_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.enduserip_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.CaseID_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ClientFirstName_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.ClientMiddleName_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.ClientLastName_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.ClientPhone_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.ClientEmail_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.SearchAddress1State_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.SearchAddress1Zip_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.SearchAddress2State_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.SearchAddress2Zip_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.enduserip_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.ClientPhone_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    SearchAddress1StreetAddress1_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress1StreetAddress1_Invalid=1);
    SearchAddress1StreetAddress2_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress1StreetAddress2_Invalid=1);
    SearchAddress1City_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress1City_Invalid=1);
    SearchAddress1State_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SearchAddress1State_Invalid=1);
    SearchAddress1State_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SearchAddress1State_Invalid=1 AND h.SearchAddress1State_wouldClean);
    SearchAddress1State_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress1State_Invalid=2);
    SearchAddress1State_ALLOW_WouldModifyCount := COUNT(GROUP,h.SearchAddress1State_Invalid=2 AND h.SearchAddress1State_wouldClean);
    SearchAddress1State_LENGTHS_ErrorCount := COUNT(GROUP,h.SearchAddress1State_Invalid=3);
    SearchAddress1State_LENGTHS_WouldModifyCount := COUNT(GROUP,h.SearchAddress1State_Invalid=3 AND h.SearchAddress1State_wouldClean);
    SearchAddress1State_Total_ErrorCount := COUNT(GROUP,h.SearchAddress1State_Invalid>0);
    SearchAddress1Zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid=1);
    SearchAddress1Zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid=1 AND h.SearchAddress1Zip_wouldClean);
    SearchAddress1Zip_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid=2);
    SearchAddress1Zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid=2 AND h.SearchAddress1Zip_wouldClean);
    SearchAddress1Zip_LENGTHS_ErrorCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid=3);
    SearchAddress1Zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid=3 AND h.SearchAddress1Zip_wouldClean);
    SearchAddress1Zip_Total_ErrorCount := COUNT(GROUP,h.SearchAddress1Zip_Invalid>0);
    SearchAddress2StreetAddress1_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress2StreetAddress1_Invalid=1);
    SearchAddress2StreetAddress2_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress2StreetAddress2_Invalid=1);
    SearchAddress2City_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress2City_Invalid=1);
    SearchAddress2State_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SearchAddress2State_Invalid=1);
    SearchAddress2State_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SearchAddress2State_Invalid=1 AND h.SearchAddress2State_wouldClean);
    SearchAddress2State_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress2State_Invalid=2);
    SearchAddress2State_ALLOW_WouldModifyCount := COUNT(GROUP,h.SearchAddress2State_Invalid=2 AND h.SearchAddress2State_wouldClean);
    SearchAddress2State_LENGTHS_ErrorCount := COUNT(GROUP,h.SearchAddress2State_Invalid=3);
    SearchAddress2State_LENGTHS_WouldModifyCount := COUNT(GROUP,h.SearchAddress2State_Invalid=3 AND h.SearchAddress2State_wouldClean);
    SearchAddress2State_Total_ErrorCount := COUNT(GROUP,h.SearchAddress2State_Invalid>0);
    SearchAddress2Zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid=1);
    SearchAddress2Zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid=1 AND h.SearchAddress2Zip_wouldClean);
    SearchAddress2Zip_ALLOW_ErrorCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid=2);
    SearchAddress2Zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid=2 AND h.SearchAddress2Zip_wouldClean);
    SearchAddress2Zip_LENGTHS_ErrorCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid=3);
    SearchAddress2Zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid=3 AND h.SearchAddress2Zip_wouldClean);
    SearchAddress2Zip_Total_ErrorCount := COUNT(GROUP,h.SearchAddress2Zip_Invalid>0);
    SearchCaseId_ALLOW_ErrorCount := COUNT(GROUP,h.SearchCaseId_Invalid=1);
    enduserip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.enduserip_Invalid=1);
    enduserip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.enduserip_Invalid=1 AND h.enduserip_wouldClean);
    enduserip_ALLOW_ErrorCount := COUNT(GROUP,h.enduserip_Invalid=2);
    enduserip_ALLOW_WouldModifyCount := COUNT(GROUP,h.enduserip_Invalid=2 AND h.enduserip_wouldClean);
    enduserip_Total_ErrorCount := COUNT(GROUP,h.enduserip_Invalid>0);
    CaseID_ALLOW_ErrorCount := COUNT(GROUP,h.CaseID_Invalid=1);
    ClientFirstName_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ClientFirstName_Invalid=1);
    ClientFirstName_ALLOW_ErrorCount := COUNT(GROUP,h.ClientFirstName_Invalid=2);
    ClientFirstName_Total_ErrorCount := COUNT(GROUP,h.ClientFirstName_Invalid>0);
    ClientMiddleName_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ClientMiddleName_Invalid=1);
    ClientMiddleName_ALLOW_ErrorCount := COUNT(GROUP,h.ClientMiddleName_Invalid=2);
    ClientMiddleName_Total_ErrorCount := COUNT(GROUP,h.ClientMiddleName_Invalid>0);
    ClientLastName_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ClientLastName_Invalid=1);
    ClientLastName_ALLOW_ErrorCount := COUNT(GROUP,h.ClientLastName_Invalid=2);
    ClientLastName_Total_ErrorCount := COUNT(GROUP,h.ClientLastName_Invalid>0);
    ClientPhone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ClientPhone_Invalid=1);
    ClientPhone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ClientPhone_Invalid=1 AND h.ClientPhone_wouldClean);
    ClientPhone_ALLOW_ErrorCount := COUNT(GROUP,h.ClientPhone_Invalid=2);
    ClientPhone_ALLOW_WouldModifyCount := COUNT(GROUP,h.ClientPhone_Invalid=2 AND h.ClientPhone_wouldClean);
    ClientPhone_LENGTHS_ErrorCount := COUNT(GROUP,h.ClientPhone_Invalid=3);
    ClientPhone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ClientPhone_Invalid=3 AND h.ClientPhone_wouldClean);
    ClientPhone_Total_ErrorCount := COUNT(GROUP,h.ClientPhone_Invalid>0);
    ClientEmail_ALLOW_ErrorCount := COUNT(GROUP,h.ClientEmail_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.SearchAddress1StreetAddress1_Invalid > 0 OR h.SearchAddress1StreetAddress2_Invalid > 0 OR h.SearchAddress1City_Invalid > 0 OR h.SearchAddress1State_Invalid > 0 OR h.SearchAddress1Zip_Invalid > 0 OR h.SearchAddress2StreetAddress1_Invalid > 0 OR h.SearchAddress2StreetAddress2_Invalid > 0 OR h.SearchAddress2City_Invalid > 0 OR h.SearchAddress2State_Invalid > 0 OR h.SearchAddress2Zip_Invalid > 0 OR h.SearchCaseId_Invalid > 0 OR h.enduserip_Invalid > 0 OR h.CaseID_Invalid > 0 OR h.ClientFirstName_Invalid > 0 OR h.ClientMiddleName_Invalid > 0 OR h.ClientLastName_Invalid > 0 OR h.ClientPhone_Invalid > 0 OR h.ClientEmail_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.SearchAddress1State_wouldClean OR h.SearchAddress1Zip_wouldClean OR h.SearchAddress2State_wouldClean OR h.SearchAddress2Zip_wouldClean OR h.enduserip_wouldClean OR h.ClientPhone_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.SearchAddress1StreetAddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1StreetAddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1State_Total_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1Zip_Total_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2StreetAddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2StreetAddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2State_Total_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2Zip_Total_ErrorCount > 0, 1, 0) + IF(le.SearchCaseId_ALLOW_ErrorCount > 0, 1, 0) + IF(le.enduserip_Total_ErrorCount > 0, 1, 0) + IF(le.CaseID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ClientFirstName_Total_ErrorCount > 0, 1, 0) + IF(le.ClientMiddleName_Total_ErrorCount > 0, 1, 0) + IF(le.ClientLastName_Total_ErrorCount > 0, 1, 0) + IF(le.ClientPhone_Total_ErrorCount > 0, 1, 0) + IF(le.ClientEmail_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.SearchAddress1StreetAddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1StreetAddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1State_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1State_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1Zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1Zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress1Zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2StreetAddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2StreetAddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2State_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2State_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2Zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2Zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SearchAddress2Zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.SearchCaseId_ALLOW_ErrorCount > 0, 1, 0) + IF(le.enduserip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.enduserip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.CaseID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ClientFirstName_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ClientFirstName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ClientMiddleName_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ClientMiddleName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ClientLastName_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ClientLastName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ClientPhone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ClientPhone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ClientPhone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ClientEmail_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.SearchAddress1State_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress1State_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress1State_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress1Zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress1Zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress1Zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress2State_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress2State_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress2State_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress2Zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress2Zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.SearchAddress2Zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.enduserip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.enduserip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ClientPhone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ClientPhone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ClientPhone_LENGTHS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.SearchAddress1StreetAddress1_Invalid,le.SearchAddress1StreetAddress2_Invalid,le.SearchAddress1City_Invalid,le.SearchAddress1State_Invalid,le.SearchAddress1Zip_Invalid,le.SearchAddress2StreetAddress1_Invalid,le.SearchAddress2StreetAddress2_Invalid,le.SearchAddress2City_Invalid,le.SearchAddress2State_Invalid,le.SearchAddress2Zip_Invalid,le.SearchCaseId_Invalid,le.enduserip_Invalid,le.CaseID_Invalid,le.ClientFirstName_Invalid,le.ClientMiddleName_Invalid,le.ClientLastName_Invalid,le.ClientPhone_Invalid,le.ClientEmail_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,NAC_Fields.InvalidMessage_SearchAddress1StreetAddress1(le.SearchAddress1StreetAddress1_Invalid),NAC_Fields.InvalidMessage_SearchAddress1StreetAddress2(le.SearchAddress1StreetAddress2_Invalid),NAC_Fields.InvalidMessage_SearchAddress1City(le.SearchAddress1City_Invalid),NAC_Fields.InvalidMessage_SearchAddress1State(le.SearchAddress1State_Invalid),NAC_Fields.InvalidMessage_SearchAddress1Zip(le.SearchAddress1Zip_Invalid),NAC_Fields.InvalidMessage_SearchAddress2StreetAddress1(le.SearchAddress2StreetAddress1_Invalid),NAC_Fields.InvalidMessage_SearchAddress2StreetAddress2(le.SearchAddress2StreetAddress2_Invalid),NAC_Fields.InvalidMessage_SearchAddress2City(le.SearchAddress2City_Invalid),NAC_Fields.InvalidMessage_SearchAddress2State(le.SearchAddress2State_Invalid),NAC_Fields.InvalidMessage_SearchAddress2Zip(le.SearchAddress2Zip_Invalid),NAC_Fields.InvalidMessage_SearchCaseId(le.SearchCaseId_Invalid),NAC_Fields.InvalidMessage_enduserip(le.enduserip_Invalid),NAC_Fields.InvalidMessage_CaseID(le.CaseID_Invalid),NAC_Fields.InvalidMessage_ClientFirstName(le.ClientFirstName_Invalid),NAC_Fields.InvalidMessage_ClientMiddleName(le.ClientMiddleName_Invalid),NAC_Fields.InvalidMessage_ClientLastName(le.ClientLastName_Invalid),NAC_Fields.InvalidMessage_ClientPhone(le.ClientPhone_Invalid),NAC_Fields.InvalidMessage_ClientEmail(le.ClientEmail_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.SearchAddress1StreetAddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SearchAddress1StreetAddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SearchAddress1City_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SearchAddress1State_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.SearchAddress1Zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.SearchAddress2StreetAddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SearchAddress2StreetAddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SearchAddress2City_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SearchAddress2State_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.SearchAddress2Zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.SearchCaseId_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.enduserip_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.CaseID_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ClientFirstName_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ClientMiddleName_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ClientLastName_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ClientPhone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ClientEmail_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'SearchAddress1StreetAddress1','SearchAddress1StreetAddress2','SearchAddress1City','SearchAddress1State','SearchAddress1Zip','SearchAddress2StreetAddress1','SearchAddress2StreetAddress2','SearchAddress2City','SearchAddress2State','SearchAddress2Zip','SearchCaseId','enduserip','CaseID','ClientFirstName','ClientMiddleName','ClientLastName','ClientPhone','ClientEmail','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_alphanumeric','invalid_ip','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_phone','invalid_email','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.SearchAddress1StreetAddress1,(SALT39.StrType)le.SearchAddress1StreetAddress2,(SALT39.StrType)le.SearchAddress1City,(SALT39.StrType)le.SearchAddress1State,(SALT39.StrType)le.SearchAddress1Zip,(SALT39.StrType)le.SearchAddress2StreetAddress1,(SALT39.StrType)le.SearchAddress2StreetAddress2,(SALT39.StrType)le.SearchAddress2City,(SALT39.StrType)le.SearchAddress2State,(SALT39.StrType)le.SearchAddress2Zip,(SALT39.StrType)le.SearchCaseId,(SALT39.StrType)le.enduserip,(SALT39.StrType)le.CaseID,(SALT39.StrType)le.ClientFirstName,(SALT39.StrType)le.ClientMiddleName,(SALT39.StrType)le.ClientLastName,(SALT39.StrType)le.ClientPhone,(SALT39.StrType)le.ClientEmail,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(NAC_Layout_NAC) prevDS = DATASET([], NAC_Layout_NAC), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'SearchAddress1StreetAddress1:invalid_alphanumeric:ALLOW'
          ,'SearchAddress1StreetAddress2:invalid_alphanumeric:ALLOW'
          ,'SearchAddress1City:invalid_alphanumeric:ALLOW'
          ,'SearchAddress1State:invalid_state:LEFTTRIM','SearchAddress1State:invalid_state:ALLOW','SearchAddress1State:invalid_state:LENGTHS'
          ,'SearchAddress1Zip:invalid_zip:LEFTTRIM','SearchAddress1Zip:invalid_zip:ALLOW','SearchAddress1Zip:invalid_zip:LENGTHS'
          ,'SearchAddress2StreetAddress1:invalid_alphanumeric:ALLOW'
          ,'SearchAddress2StreetAddress2:invalid_alphanumeric:ALLOW'
          ,'SearchAddress2City:invalid_alphanumeric:ALLOW'
          ,'SearchAddress2State:invalid_state:LEFTTRIM','SearchAddress2State:invalid_state:ALLOW','SearchAddress2State:invalid_state:LENGTHS'
          ,'SearchAddress2Zip:invalid_zip:LEFTTRIM','SearchAddress2Zip:invalid_zip:ALLOW','SearchAddress2Zip:invalid_zip:LENGTHS'
          ,'SearchCaseId:invalid_alphanumeric:ALLOW'
          ,'enduserip:invalid_ip:LEFTTRIM','enduserip:invalid_ip:ALLOW'
          ,'CaseID:invalid_alphanumeric:ALLOW'
          ,'ClientFirstName:invalid_name:LEFTTRIM','ClientFirstName:invalid_name:ALLOW'
          ,'ClientMiddleName:invalid_name:LEFTTRIM','ClientMiddleName:invalid_name:ALLOW'
          ,'ClientLastName:invalid_name:LEFTTRIM','ClientLastName:invalid_name:ALLOW'
          ,'ClientPhone:invalid_phone:LEFTTRIM','ClientPhone:invalid_phone:ALLOW','ClientPhone:invalid_phone:LENGTHS'
          ,'ClientEmail:invalid_email:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,NAC_Fields.InvalidMessage_SearchAddress1StreetAddress1(1)
          ,NAC_Fields.InvalidMessage_SearchAddress1StreetAddress2(1)
          ,NAC_Fields.InvalidMessage_SearchAddress1City(1)
          ,NAC_Fields.InvalidMessage_SearchAddress1State(1),NAC_Fields.InvalidMessage_SearchAddress1State(2),NAC_Fields.InvalidMessage_SearchAddress1State(3)
          ,NAC_Fields.InvalidMessage_SearchAddress1Zip(1),NAC_Fields.InvalidMessage_SearchAddress1Zip(2),NAC_Fields.InvalidMessage_SearchAddress1Zip(3)
          ,NAC_Fields.InvalidMessage_SearchAddress2StreetAddress1(1)
          ,NAC_Fields.InvalidMessage_SearchAddress2StreetAddress2(1)
          ,NAC_Fields.InvalidMessage_SearchAddress2City(1)
          ,NAC_Fields.InvalidMessage_SearchAddress2State(1),NAC_Fields.InvalidMessage_SearchAddress2State(2),NAC_Fields.InvalidMessage_SearchAddress2State(3)
          ,NAC_Fields.InvalidMessage_SearchAddress2Zip(1),NAC_Fields.InvalidMessage_SearchAddress2Zip(2),NAC_Fields.InvalidMessage_SearchAddress2Zip(3)
          ,NAC_Fields.InvalidMessage_SearchCaseId(1)
          ,NAC_Fields.InvalidMessage_enduserip(1),NAC_Fields.InvalidMessage_enduserip(2)
          ,NAC_Fields.InvalidMessage_CaseID(1)
          ,NAC_Fields.InvalidMessage_ClientFirstName(1),NAC_Fields.InvalidMessage_ClientFirstName(2)
          ,NAC_Fields.InvalidMessage_ClientMiddleName(1),NAC_Fields.InvalidMessage_ClientMiddleName(2)
          ,NAC_Fields.InvalidMessage_ClientLastName(1),NAC_Fields.InvalidMessage_ClientLastName(2)
          ,NAC_Fields.InvalidMessage_ClientPhone(1),NAC_Fields.InvalidMessage_ClientPhone(2),NAC_Fields.InvalidMessage_ClientPhone(3)
          ,NAC_Fields.InvalidMessage_ClientEmail(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.SearchAddress1StreetAddress1_ALLOW_ErrorCount
          ,le.SearchAddress1StreetAddress2_ALLOW_ErrorCount
          ,le.SearchAddress1City_ALLOW_ErrorCount
          ,le.SearchAddress1State_LEFTTRIM_ErrorCount,le.SearchAddress1State_ALLOW_ErrorCount,le.SearchAddress1State_LENGTHS_ErrorCount
          ,le.SearchAddress1Zip_LEFTTRIM_ErrorCount,le.SearchAddress1Zip_ALLOW_ErrorCount,le.SearchAddress1Zip_LENGTHS_ErrorCount
          ,le.SearchAddress2StreetAddress1_ALLOW_ErrorCount
          ,le.SearchAddress2StreetAddress2_ALLOW_ErrorCount
          ,le.SearchAddress2City_ALLOW_ErrorCount
          ,le.SearchAddress2State_LEFTTRIM_ErrorCount,le.SearchAddress2State_ALLOW_ErrorCount,le.SearchAddress2State_LENGTHS_ErrorCount
          ,le.SearchAddress2Zip_LEFTTRIM_ErrorCount,le.SearchAddress2Zip_ALLOW_ErrorCount,le.SearchAddress2Zip_LENGTHS_ErrorCount
          ,le.SearchCaseId_ALLOW_ErrorCount
          ,le.enduserip_LEFTTRIM_ErrorCount,le.enduserip_ALLOW_ErrorCount
          ,le.CaseID_ALLOW_ErrorCount
          ,le.ClientFirstName_LEFTTRIM_ErrorCount,le.ClientFirstName_ALLOW_ErrorCount
          ,le.ClientMiddleName_LEFTTRIM_ErrorCount,le.ClientMiddleName_ALLOW_ErrorCount
          ,le.ClientLastName_LEFTTRIM_ErrorCount,le.ClientLastName_ALLOW_ErrorCount
          ,le.ClientPhone_LEFTTRIM_ErrorCount,le.ClientPhone_ALLOW_ErrorCount,le.ClientPhone_LENGTHS_ErrorCount
          ,le.ClientEmail_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.SearchAddress1StreetAddress1_ALLOW_ErrorCount
          ,le.SearchAddress1StreetAddress2_ALLOW_ErrorCount
          ,le.SearchAddress1City_ALLOW_ErrorCount
          ,le.SearchAddress1State_LEFTTRIM_ErrorCount,le.SearchAddress1State_ALLOW_ErrorCount,le.SearchAddress1State_LENGTHS_ErrorCount
          ,le.SearchAddress1Zip_LEFTTRIM_ErrorCount,le.SearchAddress1Zip_ALLOW_ErrorCount,le.SearchAddress1Zip_LENGTHS_ErrorCount
          ,le.SearchAddress2StreetAddress1_ALLOW_ErrorCount
          ,le.SearchAddress2StreetAddress2_ALLOW_ErrorCount
          ,le.SearchAddress2City_ALLOW_ErrorCount
          ,le.SearchAddress2State_LEFTTRIM_ErrorCount,le.SearchAddress2State_ALLOW_ErrorCount,le.SearchAddress2State_LENGTHS_ErrorCount
          ,le.SearchAddress2Zip_LEFTTRIM_ErrorCount,le.SearchAddress2Zip_ALLOW_ErrorCount,le.SearchAddress2Zip_LENGTHS_ErrorCount
          ,le.SearchCaseId_ALLOW_ErrorCount
          ,le.enduserip_LEFTTRIM_ErrorCount,le.enduserip_ALLOW_ErrorCount
          ,le.CaseID_ALLOW_ErrorCount
          ,le.ClientFirstName_LEFTTRIM_ErrorCount,le.ClientFirstName_ALLOW_ErrorCount
          ,le.ClientMiddleName_LEFTTRIM_ErrorCount,le.ClientMiddleName_ALLOW_ErrorCount
          ,le.ClientLastName_LEFTTRIM_ErrorCount,le.ClientLastName_ALLOW_ErrorCount
          ,le.ClientPhone_LEFTTRIM_ErrorCount,le.ClientPhone_ALLOW_ErrorCount,le.ClientPhone_LENGTHS_ErrorCount
          ,le.ClientEmail_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := NAC_hygiene(PROJECT(h, NAC_Layout_NAC));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'SearchAddress1StreetAddress1:' + getFieldTypeText(h.SearchAddress1StreetAddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress1StreetAddress2:' + getFieldTypeText(h.SearchAddress1StreetAddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress1City:' + getFieldTypeText(h.SearchAddress1City) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress1State:' + getFieldTypeText(h.SearchAddress1State) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress1Zip:' + getFieldTypeText(h.SearchAddress1Zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress2StreetAddress1:' + getFieldTypeText(h.SearchAddress2StreetAddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress2StreetAddress2:' + getFieldTypeText(h.SearchAddress2StreetAddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress2City:' + getFieldTypeText(h.SearchAddress2City) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress2State:' + getFieldTypeText(h.SearchAddress2State) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchAddress2Zip:' + getFieldTypeText(h.SearchAddress2Zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SearchCaseId:' + getFieldTypeText(h.SearchCaseId) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'enduserip:' + getFieldTypeText(h.enduserip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CaseID:' + getFieldTypeText(h.CaseID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ClientFirstName:' + getFieldTypeText(h.ClientFirstName) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ClientMiddleName:' + getFieldTypeText(h.ClientMiddleName) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ClientLastName:' + getFieldTypeText(h.ClientLastName) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ClientPhone:' + getFieldTypeText(h.ClientPhone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ClientEmail:' + getFieldTypeText(h.ClientEmail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_SearchAddress1StreetAddress1_cnt
          ,le.populated_SearchAddress1StreetAddress2_cnt
          ,le.populated_SearchAddress1City_cnt
          ,le.populated_SearchAddress1State_cnt
          ,le.populated_SearchAddress1Zip_cnt
          ,le.populated_SearchAddress2StreetAddress1_cnt
          ,le.populated_SearchAddress2StreetAddress2_cnt
          ,le.populated_SearchAddress2City_cnt
          ,le.populated_SearchAddress2State_cnt
          ,le.populated_SearchAddress2Zip_cnt
          ,le.populated_SearchCaseId_cnt
          ,le.populated_enduserip_cnt
          ,le.populated_CaseID_cnt
          ,le.populated_ClientFirstName_cnt
          ,le.populated_ClientMiddleName_cnt
          ,le.populated_ClientLastName_cnt
          ,le.populated_ClientPhone_cnt
          ,le.populated_ClientEmail_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_SearchAddress1StreetAddress1_pcnt
          ,le.populated_SearchAddress1StreetAddress2_pcnt
          ,le.populated_SearchAddress1City_pcnt
          ,le.populated_SearchAddress1State_pcnt
          ,le.populated_SearchAddress1Zip_pcnt
          ,le.populated_SearchAddress2StreetAddress1_pcnt
          ,le.populated_SearchAddress2StreetAddress2_pcnt
          ,le.populated_SearchAddress2City_pcnt
          ,le.populated_SearchAddress2State_pcnt
          ,le.populated_SearchAddress2Zip_pcnt
          ,le.populated_SearchCaseId_pcnt
          ,le.populated_enduserip_pcnt
          ,le.populated_CaseID_pcnt
          ,le.populated_ClientFirstName_pcnt
          ,le.populated_ClientMiddleName_pcnt
          ,le.populated_ClientLastName_pcnt
          ,le.populated_ClientPhone_pcnt
          ,le.populated_ClientEmail_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,18,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := NAC_Delta(prevDS, PROJECT(h, NAC_Layout_NAC));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),18,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(NAC_Layout_NAC) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FraudGov, NAC_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
