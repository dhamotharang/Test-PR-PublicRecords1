IMPORT SALT311,STD;
EXPORT RDP_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 32;
  EXPORT NumRulesFromFieldType := 32;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 20;
  EXPORT NumFieldsWithPossibleEdits := 8;
  EXPORT NumRulesWithPossibleEdits := 20;
  EXPORT Expanded_Layout := RECORD(RDP_Layout_RDP)
    UNSIGNED1 Transaction_ID_Invalid;
    UNSIGNED1 TransactionDate_Invalid;
    BOOLEAN TransactionDate_wouldClean;
    UNSIGNED1 FirstName_Invalid;
    UNSIGNED1 LastName_Invalid;
    UNSIGNED1 MiddleName_Invalid;
    UNSIGNED1 Suffix_Invalid;
    UNSIGNED1 BirthDate_Invalid;
    BOOLEAN BirthDate_wouldClean;
    UNSIGNED1 SSN_Invalid;
    BOOLEAN SSN_wouldClean;
    UNSIGNED1 Lexid_Input_Invalid;
    UNSIGNED1 Street1_Invalid;
    UNSIGNED1 Street2_Invalid;
    UNSIGNED1 Suite_Invalid;
    UNSIGNED1 City_Invalid;
    UNSIGNED1 State_Invalid;
    BOOLEAN State_wouldClean;
    UNSIGNED1 Zip5_Invalid;
    BOOLEAN Zip5_wouldClean;
    UNSIGNED1 Phone_Invalid;
    BOOLEAN Phone_wouldClean;
    UNSIGNED1 Lexid_Discovered_Invalid;
    UNSIGNED1 RemoteIPAddress_Invalid;
    BOOLEAN RemoteIPAddress_wouldClean;
    UNSIGNED1 ConsumerIPAddress_Invalid;
    BOOLEAN ConsumerIPAddress_wouldClean;
    UNSIGNED1 Email_Address_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RDP_Layout_RDP)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
  EXPORT Rule_Layout := RECORD(RDP_Layout_RDP)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'Transaction_ID:invalid_numeric:ALLOW'
          ,'TransactionDate:invalid_date:LEFTTRIM','TransactionDate:invalid_date:ALLOW'
          ,'FirstName:invalid_alphanumeric:ALLOW'
          ,'LastName:invalid_alphanumeric:ALLOW'
          ,'MiddleName:invalid_alphanumeric:ALLOW'
          ,'Suffix:invalid_alphanumeric:ALLOW'
          ,'BirthDate:invalid_date:LEFTTRIM','BirthDate:invalid_date:ALLOW'
          ,'SSN:invalid_ssn:LEFTTRIM','SSN:invalid_ssn:ALLOW','SSN:invalid_ssn:LENGTHS'
          ,'Lexid_Input:invalid_numeric:ALLOW'
          ,'Street1:invalid_alphanumeric:ALLOW'
          ,'Street2:invalid_alphanumeric:ALLOW'
          ,'Suite:invalid_alphanumeric:ALLOW'
          ,'City:invalid_alphanumeric:ALLOW'
          ,'State:invalid_state:LEFTTRIM','State:invalid_state:ALLOW','State:invalid_state:LENGTHS'
          ,'Zip5:invalid_zip:LEFTTRIM','Zip5:invalid_zip:ALLOW','Zip5:invalid_zip:LENGTHS'
          ,'Phone:invalid_phone:LEFTTRIM','Phone:invalid_phone:ALLOW','Phone:invalid_phone:LENGTHS'
          ,'Lexid_Discovered:invalid_numeric:ALLOW'
          ,'RemoteIPAddress:invalid_ip:LEFTTRIM','RemoteIPAddress:invalid_ip:ALLOW'
          ,'ConsumerIPAddress:invalid_ip:LEFTTRIM','ConsumerIPAddress:invalid_ip:ALLOW'
          ,'Email_Address:invalid_email:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,RDP_Fields.InvalidMessage_Transaction_ID(1)
          ,RDP_Fields.InvalidMessage_TransactionDate(1),RDP_Fields.InvalidMessage_TransactionDate(2)
          ,RDP_Fields.InvalidMessage_FirstName(1)
          ,RDP_Fields.InvalidMessage_LastName(1)
          ,RDP_Fields.InvalidMessage_MiddleName(1)
          ,RDP_Fields.InvalidMessage_Suffix(1)
          ,RDP_Fields.InvalidMessage_BirthDate(1),RDP_Fields.InvalidMessage_BirthDate(2)
          ,RDP_Fields.InvalidMessage_SSN(1),RDP_Fields.InvalidMessage_SSN(2),RDP_Fields.InvalidMessage_SSN(3)
          ,RDP_Fields.InvalidMessage_Lexid_Input(1)
          ,RDP_Fields.InvalidMessage_Street1(1)
          ,RDP_Fields.InvalidMessage_Street2(1)
          ,RDP_Fields.InvalidMessage_Suite(1)
          ,RDP_Fields.InvalidMessage_City(1)
          ,RDP_Fields.InvalidMessage_State(1),RDP_Fields.InvalidMessage_State(2),RDP_Fields.InvalidMessage_State(3)
          ,RDP_Fields.InvalidMessage_Zip5(1),RDP_Fields.InvalidMessage_Zip5(2),RDP_Fields.InvalidMessage_Zip5(3)
          ,RDP_Fields.InvalidMessage_Phone(1),RDP_Fields.InvalidMessage_Phone(2),RDP_Fields.InvalidMessage_Phone(3)
          ,RDP_Fields.InvalidMessage_Lexid_Discovered(1)
          ,RDP_Fields.InvalidMessage_RemoteIPAddress(1),RDP_Fields.InvalidMessage_RemoteIPAddress(2)
          ,RDP_Fields.InvalidMessage_ConsumerIPAddress(1),RDP_Fields.InvalidMessage_ConsumerIPAddress(2)
          ,RDP_Fields.InvalidMessage_Email_Address(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
EXPORT FromNone(DATASET(RDP_Layout_RDP) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.Transaction_ID_Invalid := RDP_Fields.InValid_Transaction_ID((SALT311.StrType)le.Transaction_ID);
    SELF.TransactionDate_Invalid := RDP_Fields.InValid_TransactionDate((SALT311.StrType)le.TransactionDate);
    SELF.TransactionDate := IF(SELF.TransactionDate_Invalid=0 OR NOT withOnfail, le.TransactionDate, (TYPEOF(le.TransactionDate))''); // ONFAIL(BLANK)
    SELF.TransactionDate_wouldClean :=  SELF.TransactionDate_Invalid > 0;
    SELF.FirstName_Invalid := RDP_Fields.InValid_FirstName((SALT311.StrType)le.FirstName);
    SELF.LastName_Invalid := RDP_Fields.InValid_LastName((SALT311.StrType)le.LastName);
    SELF.MiddleName_Invalid := RDP_Fields.InValid_MiddleName((SALT311.StrType)le.MiddleName);
    SELF.Suffix_Invalid := RDP_Fields.InValid_Suffix((SALT311.StrType)le.Suffix);
    SELF.BirthDate_Invalid := RDP_Fields.InValid_BirthDate((SALT311.StrType)le.BirthDate);
    SELF.BirthDate := IF(SELF.BirthDate_Invalid=0 OR NOT withOnfail, le.BirthDate, (TYPEOF(le.BirthDate))''); // ONFAIL(BLANK)
    SELF.BirthDate_wouldClean :=  SELF.BirthDate_Invalid > 0;
    SELF.SSN_Invalid := RDP_Fields.InValid_SSN((SALT311.StrType)le.SSN);
    SELF.SSN := IF(SELF.SSN_Invalid=0 OR NOT withOnfail, le.SSN, (TYPEOF(le.SSN))''); // ONFAIL(BLANK)
    SELF.SSN_wouldClean :=  SELF.SSN_Invalid > 0;
    SELF.Lexid_Input_Invalid := RDP_Fields.InValid_Lexid_Input((SALT311.StrType)le.Lexid_Input);
    SELF.Street1_Invalid := RDP_Fields.InValid_Street1((SALT311.StrType)le.Street1);
    SELF.Street2_Invalid := RDP_Fields.InValid_Street2((SALT311.StrType)le.Street2);
    SELF.Suite_Invalid := RDP_Fields.InValid_Suite((SALT311.StrType)le.Suite);
    SELF.City_Invalid := RDP_Fields.InValid_City((SALT311.StrType)le.City);
    SELF.State_Invalid := RDP_Fields.InValid_State((SALT311.StrType)le.State);
    SELF.State := IF(SELF.State_Invalid=0 OR NOT withOnfail, le.State, (TYPEOF(le.State))''); // ONFAIL(BLANK)
    SELF.State_wouldClean :=  SELF.State_Invalid > 0;
    SELF.Zip5_Invalid := RDP_Fields.InValid_Zip5((SALT311.StrType)le.Zip5);
    SELF.Zip5 := IF(SELF.Zip5_Invalid=0 OR NOT withOnfail, le.Zip5, (TYPEOF(le.Zip5))''); // ONFAIL(BLANK)
    SELF.Zip5_wouldClean :=  SELF.Zip5_Invalid > 0;
    SELF.Phone_Invalid := RDP_Fields.InValid_Phone((SALT311.StrType)le.Phone);
    SELF.Phone := IF(SELF.Phone_Invalid=0 OR NOT withOnfail, le.Phone, (TYPEOF(le.Phone))''); // ONFAIL(BLANK)
    SELF.Phone_wouldClean :=  SELF.Phone_Invalid > 0;
    SELF.Lexid_Discovered_Invalid := RDP_Fields.InValid_Lexid_Discovered((SALT311.StrType)le.Lexid_Discovered);
    SELF.RemoteIPAddress_Invalid := RDP_Fields.InValid_RemoteIPAddress((SALT311.StrType)le.RemoteIPAddress);
    SELF.RemoteIPAddress := IF(SELF.RemoteIPAddress_Invalid=0 OR NOT withOnfail, le.RemoteIPAddress, (TYPEOF(le.RemoteIPAddress))''); // ONFAIL(BLANK)
    SELF.RemoteIPAddress_wouldClean :=  SELF.RemoteIPAddress_Invalid > 0;
    SELF.ConsumerIPAddress_Invalid := RDP_Fields.InValid_ConsumerIPAddress((SALT311.StrType)le.ConsumerIPAddress);
    SELF.ConsumerIPAddress := IF(SELF.ConsumerIPAddress_Invalid=0 OR NOT withOnfail, le.ConsumerIPAddress, (TYPEOF(le.ConsumerIPAddress))''); // ONFAIL(BLANK)
    SELF.ConsumerIPAddress_wouldClean :=  SELF.ConsumerIPAddress_Invalid > 0;
    SELF.Email_Address_Invalid := RDP_Fields.InValid_Email_Address((SALT311.StrType)le.Email_Address);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RDP_Layout_RDP);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.Transaction_ID_Invalid << 0 ) + ( le.TransactionDate_Invalid << 1 ) + ( le.FirstName_Invalid << 3 ) + ( le.LastName_Invalid << 4 ) + ( le.MiddleName_Invalid << 5 ) + ( le.Suffix_Invalid << 6 ) + ( le.BirthDate_Invalid << 7 ) + ( le.SSN_Invalid << 9 ) + ( le.Lexid_Input_Invalid << 11 ) + ( le.Street1_Invalid << 12 ) + ( le.Street2_Invalid << 13 ) + ( le.Suite_Invalid << 14 ) + ( le.City_Invalid << 15 ) + ( le.State_Invalid << 16 ) + ( le.Zip5_Invalid << 18 ) + ( le.Phone_Invalid << 20 ) + ( le.Lexid_Discovered_Invalid << 22 ) + ( le.RemoteIPAddress_Invalid << 23 ) + ( le.ConsumerIPAddress_Invalid << 25 ) + ( le.Email_Address_Invalid << 27 );
    SELF.ScrubsCleanBits1 := ( IF(le.TransactionDate_wouldClean, 1, 0) << 0 ) + ( IF(le.BirthDate_wouldClean, 1, 0) << 1 ) + ( IF(le.SSN_wouldClean, 1, 0) << 2 ) + ( IF(le.State_wouldClean, 1, 0) << 3 ) + ( IF(le.Zip5_wouldClean, 1, 0) << 4 ) + ( IF(le.Phone_wouldClean, 1, 0) << 5 ) + ( IF(le.RemoteIPAddress_wouldClean, 1, 0) << 6 ) + ( IF(le.ConsumerIPAddress_wouldClean, 1, 0) << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RDP_Layout_RDP);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.Transaction_ID_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.TransactionDate_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.FirstName_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.LastName_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.MiddleName_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.Suffix_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.BirthDate_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.SSN_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.Lexid_Input_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.Street1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.Street2_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.Suite_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.City_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.State_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.Zip5_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.Phone_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.Lexid_Discovered_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.RemoteIPAddress_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.ConsumerIPAddress_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.Email_Address_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.TransactionDate_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.BirthDate_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.SSN_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.State_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.Zip5_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.Phone_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.RemoteIPAddress_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.ConsumerIPAddress_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    Transaction_ID_ALLOW_ErrorCount := COUNT(GROUP,h.Transaction_ID_Invalid=1);
    TransactionDate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.TransactionDate_Invalid=1);
    TransactionDate_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.TransactionDate_Invalid=1 AND h.TransactionDate_wouldClean);
    TransactionDate_ALLOW_ErrorCount := COUNT(GROUP,h.TransactionDate_Invalid=2);
    TransactionDate_ALLOW_WouldModifyCount := COUNT(GROUP,h.TransactionDate_Invalid=2 AND h.TransactionDate_wouldClean);
    TransactionDate_Total_ErrorCount := COUNT(GROUP,h.TransactionDate_Invalid>0);
    FirstName_ALLOW_ErrorCount := COUNT(GROUP,h.FirstName_Invalid=1);
    LastName_ALLOW_ErrorCount := COUNT(GROUP,h.LastName_Invalid=1);
    MiddleName_ALLOW_ErrorCount := COUNT(GROUP,h.MiddleName_Invalid=1);
    Suffix_ALLOW_ErrorCount := COUNT(GROUP,h.Suffix_Invalid=1);
    BirthDate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.BirthDate_Invalid=1);
    BirthDate_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.BirthDate_Invalid=1 AND h.BirthDate_wouldClean);
    BirthDate_ALLOW_ErrorCount := COUNT(GROUP,h.BirthDate_Invalid=2);
    BirthDate_ALLOW_WouldModifyCount := COUNT(GROUP,h.BirthDate_Invalid=2 AND h.BirthDate_wouldClean);
    BirthDate_Total_ErrorCount := COUNT(GROUP,h.BirthDate_Invalid>0);
    SSN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SSN_Invalid=1);
    SSN_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=1 AND h.SSN_wouldClean);
    SSN_ALLOW_ErrorCount := COUNT(GROUP,h.SSN_Invalid=2);
    SSN_ALLOW_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=2 AND h.SSN_wouldClean);
    SSN_LENGTHS_ErrorCount := COUNT(GROUP,h.SSN_Invalid=3);
    SSN_LENGTHS_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=3 AND h.SSN_wouldClean);
    SSN_Total_ErrorCount := COUNT(GROUP,h.SSN_Invalid>0);
    Lexid_Input_ALLOW_ErrorCount := COUNT(GROUP,h.Lexid_Input_Invalid=1);
    Street1_ALLOW_ErrorCount := COUNT(GROUP,h.Street1_Invalid=1);
    Street2_ALLOW_ErrorCount := COUNT(GROUP,h.Street2_Invalid=1);
    Suite_ALLOW_ErrorCount := COUNT(GROUP,h.Suite_Invalid=1);
    City_ALLOW_ErrorCount := COUNT(GROUP,h.City_Invalid=1);
    State_LEFTTRIM_ErrorCount := COUNT(GROUP,h.State_Invalid=1);
    State_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.State_Invalid=1 AND h.State_wouldClean);
    State_ALLOW_ErrorCount := COUNT(GROUP,h.State_Invalid=2);
    State_ALLOW_WouldModifyCount := COUNT(GROUP,h.State_Invalid=2 AND h.State_wouldClean);
    State_LENGTHS_ErrorCount := COUNT(GROUP,h.State_Invalid=3);
    State_LENGTHS_WouldModifyCount := COUNT(GROUP,h.State_Invalid=3 AND h.State_wouldClean);
    State_Total_ErrorCount := COUNT(GROUP,h.State_Invalid>0);
    Zip5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.Zip5_Invalid=1);
    Zip5_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.Zip5_Invalid=1 AND h.Zip5_wouldClean);
    Zip5_ALLOW_ErrorCount := COUNT(GROUP,h.Zip5_Invalid=2);
    Zip5_ALLOW_WouldModifyCount := COUNT(GROUP,h.Zip5_Invalid=2 AND h.Zip5_wouldClean);
    Zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.Zip5_Invalid=3);
    Zip5_LENGTHS_WouldModifyCount := COUNT(GROUP,h.Zip5_Invalid=3 AND h.Zip5_wouldClean);
    Zip5_Total_ErrorCount := COUNT(GROUP,h.Zip5_Invalid>0);
    Phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.Phone_Invalid=1);
    Phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.Phone_Invalid=1 AND h.Phone_wouldClean);
    Phone_ALLOW_ErrorCount := COUNT(GROUP,h.Phone_Invalid=2);
    Phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.Phone_Invalid=2 AND h.Phone_wouldClean);
    Phone_LENGTHS_ErrorCount := COUNT(GROUP,h.Phone_Invalid=3);
    Phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.Phone_Invalid=3 AND h.Phone_wouldClean);
    Phone_Total_ErrorCount := COUNT(GROUP,h.Phone_Invalid>0);
    Lexid_Discovered_ALLOW_ErrorCount := COUNT(GROUP,h.Lexid_Discovered_Invalid=1);
    RemoteIPAddress_LEFTTRIM_ErrorCount := COUNT(GROUP,h.RemoteIPAddress_Invalid=1);
    RemoteIPAddress_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.RemoteIPAddress_Invalid=1 AND h.RemoteIPAddress_wouldClean);
    RemoteIPAddress_ALLOW_ErrorCount := COUNT(GROUP,h.RemoteIPAddress_Invalid=2);
    RemoteIPAddress_ALLOW_WouldModifyCount := COUNT(GROUP,h.RemoteIPAddress_Invalid=2 AND h.RemoteIPAddress_wouldClean);
    RemoteIPAddress_Total_ErrorCount := COUNT(GROUP,h.RemoteIPAddress_Invalid>0);
    ConsumerIPAddress_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ConsumerIPAddress_Invalid=1);
    ConsumerIPAddress_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ConsumerIPAddress_Invalid=1 AND h.ConsumerIPAddress_wouldClean);
    ConsumerIPAddress_ALLOW_ErrorCount := COUNT(GROUP,h.ConsumerIPAddress_Invalid=2);
    ConsumerIPAddress_ALLOW_WouldModifyCount := COUNT(GROUP,h.ConsumerIPAddress_Invalid=2 AND h.ConsumerIPAddress_wouldClean);
    ConsumerIPAddress_Total_ErrorCount := COUNT(GROUP,h.ConsumerIPAddress_Invalid>0);
    Email_Address_ALLOW_ErrorCount := COUNT(GROUP,h.Email_Address_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.Transaction_ID_Invalid > 0 OR h.TransactionDate_Invalid > 0 OR h.FirstName_Invalid > 0 OR h.LastName_Invalid > 0 OR h.MiddleName_Invalid > 0 OR h.Suffix_Invalid > 0 OR h.BirthDate_Invalid > 0 OR h.SSN_Invalid > 0 OR h.Lexid_Input_Invalid > 0 OR h.Street1_Invalid > 0 OR h.Street2_Invalid > 0 OR h.Suite_Invalid > 0 OR h.City_Invalid > 0 OR h.State_Invalid > 0 OR h.Zip5_Invalid > 0 OR h.Phone_Invalid > 0 OR h.Lexid_Discovered_Invalid > 0 OR h.RemoteIPAddress_Invalid > 0 OR h.ConsumerIPAddress_Invalid > 0 OR h.Email_Address_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.TransactionDate_wouldClean OR h.BirthDate_wouldClean OR h.SSN_wouldClean OR h.State_wouldClean OR h.Zip5_wouldClean OR h.Phone_wouldClean OR h.RemoteIPAddress_wouldClean OR h.ConsumerIPAddress_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.Transaction_ID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.TransactionDate_Total_ErrorCount > 0, 1, 0) + IF(le.FirstName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.LastName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.MiddleName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.BirthDate_Total_ErrorCount > 0, 1, 0) + IF(le.SSN_Total_ErrorCount > 0, 1, 0) + IF(le.Lexid_Input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Street1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Street2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Suite_ALLOW_ErrorCount > 0, 1, 0) + IF(le.City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_Total_ErrorCount > 0, 1, 0) + IF(le.Zip5_Total_ErrorCount > 0, 1, 0) + IF(le.Phone_Total_ErrorCount > 0, 1, 0) + IF(le.Lexid_Discovered_ALLOW_ErrorCount > 0, 1, 0) + IF(le.RemoteIPAddress_Total_ErrorCount > 0, 1, 0) + IF(le.ConsumerIPAddress_Total_ErrorCount > 0, 1, 0) + IF(le.Email_Address_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.Transaction_ID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.TransactionDate_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.TransactionDate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.FirstName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.LastName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.MiddleName_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.BirthDate_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.BirthDate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SSN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SSN_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SSN_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Lexid_Input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Street1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Street2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Suite_ALLOW_ErrorCount > 0, 1, 0) + IF(le.City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Zip5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.Zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.Phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Lexid_Discovered_ALLOW_ErrorCount > 0, 1, 0) + IF(le.RemoteIPAddress_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.RemoteIPAddress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ConsumerIPAddress_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ConsumerIPAddress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Email_Address_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.TransactionDate_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.TransactionDate_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.BirthDate_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.BirthDate_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.SSN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SSN_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.SSN_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.State_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.State_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.State_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.Zip5_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.Zip5_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.Zip5_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.Phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.Phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.Phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.RemoteIPAddress_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.RemoteIPAddress_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ConsumerIPAddress_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ConsumerIPAddress_ALLOW_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.Transaction_ID_Invalid,le.TransactionDate_Invalid,le.FirstName_Invalid,le.LastName_Invalid,le.MiddleName_Invalid,le.Suffix_Invalid,le.BirthDate_Invalid,le.SSN_Invalid,le.Lexid_Input_Invalid,le.Street1_Invalid,le.Street2_Invalid,le.Suite_Invalid,le.City_Invalid,le.State_Invalid,le.Zip5_Invalid,le.Phone_Invalid,le.Lexid_Discovered_Invalid,le.RemoteIPAddress_Invalid,le.ConsumerIPAddress_Invalid,le.Email_Address_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RDP_Fields.InvalidMessage_Transaction_ID(le.Transaction_ID_Invalid),RDP_Fields.InvalidMessage_TransactionDate(le.TransactionDate_Invalid),RDP_Fields.InvalidMessage_FirstName(le.FirstName_Invalid),RDP_Fields.InvalidMessage_LastName(le.LastName_Invalid),RDP_Fields.InvalidMessage_MiddleName(le.MiddleName_Invalid),RDP_Fields.InvalidMessage_Suffix(le.Suffix_Invalid),RDP_Fields.InvalidMessage_BirthDate(le.BirthDate_Invalid),RDP_Fields.InvalidMessage_SSN(le.SSN_Invalid),RDP_Fields.InvalidMessage_Lexid_Input(le.Lexid_Input_Invalid),RDP_Fields.InvalidMessage_Street1(le.Street1_Invalid),RDP_Fields.InvalidMessage_Street2(le.Street2_Invalid),RDP_Fields.InvalidMessage_Suite(le.Suite_Invalid),RDP_Fields.InvalidMessage_City(le.City_Invalid),RDP_Fields.InvalidMessage_State(le.State_Invalid),RDP_Fields.InvalidMessage_Zip5(le.Zip5_Invalid),RDP_Fields.InvalidMessage_Phone(le.Phone_Invalid),RDP_Fields.InvalidMessage_Lexid_Discovered(le.Lexid_Discovered_Invalid),RDP_Fields.InvalidMessage_RemoteIPAddress(le.RemoteIPAddress_Invalid),RDP_Fields.InvalidMessage_ConsumerIPAddress(le.ConsumerIPAddress_Invalid),RDP_Fields.InvalidMessage_Email_Address(le.Email_Address_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.Transaction_ID_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.TransactionDate_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.FirstName_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.LastName_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.MiddleName_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.BirthDate_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.SSN_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Lexid_Input_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Street1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Street2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Suite_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.City_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.State_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Zip5_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Lexid_Discovered_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.RemoteIPAddress_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ConsumerIPAddress_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.Email_Address_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'Transaction_ID','TransactionDate','FirstName','LastName','MiddleName','Suffix','BirthDate','SSN','Lexid_Input','Street1','Street2','Suite','City','State','Zip5','Phone','Lexid_Discovered','RemoteIPAddress','ConsumerIPAddress','Email_Address','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_date','invalid_ssn','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_phone','invalid_numeric','invalid_ip','invalid_ip','invalid_email','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.Transaction_ID,(SALT311.StrType)le.TransactionDate,(SALT311.StrType)le.FirstName,(SALT311.StrType)le.LastName,(SALT311.StrType)le.MiddleName,(SALT311.StrType)le.Suffix,(SALT311.StrType)le.BirthDate,(SALT311.StrType)le.SSN,(SALT311.StrType)le.Lexid_Input,(SALT311.StrType)le.Street1,(SALT311.StrType)le.Street2,(SALT311.StrType)le.Suite,(SALT311.StrType)le.City,(SALT311.StrType)le.State,(SALT311.StrType)le.Zip5,(SALT311.StrType)le.Phone,(SALT311.StrType)le.Lexid_Discovered,(SALT311.StrType)le.RemoteIPAddress,(SALT311.StrType)le.ConsumerIPAddress,(SALT311.StrType)le.Email_Address,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(RDP_Layout_RDP) prevDS = DATASET([], RDP_Layout_RDP), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.Transaction_ID_ALLOW_ErrorCount
          ,le.TransactionDate_LEFTTRIM_ErrorCount,le.TransactionDate_ALLOW_ErrorCount
          ,le.FirstName_ALLOW_ErrorCount
          ,le.LastName_ALLOW_ErrorCount
          ,le.MiddleName_ALLOW_ErrorCount
          ,le.Suffix_ALLOW_ErrorCount
          ,le.BirthDate_LEFTTRIM_ErrorCount,le.BirthDate_ALLOW_ErrorCount
          ,le.SSN_LEFTTRIM_ErrorCount,le.SSN_ALLOW_ErrorCount,le.SSN_LENGTHS_ErrorCount
          ,le.Lexid_Input_ALLOW_ErrorCount
          ,le.Street1_ALLOW_ErrorCount
          ,le.Street2_ALLOW_ErrorCount
          ,le.Suite_ALLOW_ErrorCount
          ,le.City_ALLOW_ErrorCount
          ,le.State_LEFTTRIM_ErrorCount,le.State_ALLOW_ErrorCount,le.State_LENGTHS_ErrorCount
          ,le.Zip5_LEFTTRIM_ErrorCount,le.Zip5_ALLOW_ErrorCount,le.Zip5_LENGTHS_ErrorCount
          ,le.Phone_LEFTTRIM_ErrorCount,le.Phone_ALLOW_ErrorCount,le.Phone_LENGTHS_ErrorCount
          ,le.Lexid_Discovered_ALLOW_ErrorCount
          ,le.RemoteIPAddress_LEFTTRIM_ErrorCount,le.RemoteIPAddress_ALLOW_ErrorCount
          ,le.ConsumerIPAddress_LEFTTRIM_ErrorCount,le.ConsumerIPAddress_ALLOW_ErrorCount
          ,le.Email_Address_ALLOW_ErrorCount
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
          ,le.Transaction_ID_ALLOW_ErrorCount
          ,le.TransactionDate_LEFTTRIM_ErrorCount,le.TransactionDate_ALLOW_ErrorCount
          ,le.FirstName_ALLOW_ErrorCount
          ,le.LastName_ALLOW_ErrorCount
          ,le.MiddleName_ALLOW_ErrorCount
          ,le.Suffix_ALLOW_ErrorCount
          ,le.BirthDate_LEFTTRIM_ErrorCount,le.BirthDate_ALLOW_ErrorCount
          ,le.SSN_LEFTTRIM_ErrorCount,le.SSN_ALLOW_ErrorCount,le.SSN_LENGTHS_ErrorCount
          ,le.Lexid_Input_ALLOW_ErrorCount
          ,le.Street1_ALLOW_ErrorCount
          ,le.Street2_ALLOW_ErrorCount
          ,le.Suite_ALLOW_ErrorCount
          ,le.City_ALLOW_ErrorCount
          ,le.State_LEFTTRIM_ErrorCount,le.State_ALLOW_ErrorCount,le.State_LENGTHS_ErrorCount
          ,le.Zip5_LEFTTRIM_ErrorCount,le.Zip5_ALLOW_ErrorCount,le.Zip5_LENGTHS_ErrorCount
          ,le.Phone_LEFTTRIM_ErrorCount,le.Phone_ALLOW_ErrorCount,le.Phone_LENGTHS_ErrorCount
          ,le.Lexid_Discovered_ALLOW_ErrorCount
          ,le.RemoteIPAddress_LEFTTRIM_ErrorCount,le.RemoteIPAddress_ALLOW_ErrorCount
          ,le.ConsumerIPAddress_LEFTTRIM_ErrorCount,le.ConsumerIPAddress_ALLOW_ErrorCount
          ,le.Email_Address_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := RDP_hygiene(PROJECT(h, RDP_Layout_RDP));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'Transaction_ID:' + getFieldTypeText(h.Transaction_ID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'TransactionDate:' + getFieldTypeText(h.TransactionDate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FirstName:' + getFieldTypeText(h.FirstName) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LastName:' + getFieldTypeText(h.LastName) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MiddleName:' + getFieldTypeText(h.MiddleName) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Suffix:' + getFieldTypeText(h.Suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BirthDate:' + getFieldTypeText(h.BirthDate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SSN:' + getFieldTypeText(h.SSN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Lexid_Input:' + getFieldTypeText(h.Lexid_Input) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Street1:' + getFieldTypeText(h.Street1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Street2:' + getFieldTypeText(h.Street2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Suite:' + getFieldTypeText(h.Suite) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'City:' + getFieldTypeText(h.City) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'State:' + getFieldTypeText(h.State) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Zip5:' + getFieldTypeText(h.Zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Phone:' + getFieldTypeText(h.Phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Lexid_Discovered:' + getFieldTypeText(h.Lexid_Discovered) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RemoteIPAddress:' + getFieldTypeText(h.RemoteIPAddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ConsumerIPAddress:' + getFieldTypeText(h.ConsumerIPAddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Email_Address:' + getFieldTypeText(h.Email_Address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_Transaction_ID_cnt
          ,le.populated_TransactionDate_cnt
          ,le.populated_FirstName_cnt
          ,le.populated_LastName_cnt
          ,le.populated_MiddleName_cnt
          ,le.populated_Suffix_cnt
          ,le.populated_BirthDate_cnt
          ,le.populated_SSN_cnt
          ,le.populated_Lexid_Input_cnt
          ,le.populated_Street1_cnt
          ,le.populated_Street2_cnt
          ,le.populated_Suite_cnt
          ,le.populated_City_cnt
          ,le.populated_State_cnt
          ,le.populated_Zip5_cnt
          ,le.populated_Phone_cnt
          ,le.populated_Lexid_Discovered_cnt
          ,le.populated_RemoteIPAddress_cnt
          ,le.populated_ConsumerIPAddress_cnt
          ,le.populated_Email_Address_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_Transaction_ID_pcnt
          ,le.populated_TransactionDate_pcnt
          ,le.populated_FirstName_pcnt
          ,le.populated_LastName_pcnt
          ,le.populated_MiddleName_pcnt
          ,le.populated_Suffix_pcnt
          ,le.populated_BirthDate_pcnt
          ,le.populated_SSN_pcnt
          ,le.populated_Lexid_Input_pcnt
          ,le.populated_Street1_pcnt
          ,le.populated_Street2_pcnt
          ,le.populated_Suite_pcnt
          ,le.populated_City_pcnt
          ,le.populated_State_pcnt
          ,le.populated_Zip5_pcnt
          ,le.populated_Phone_pcnt
          ,le.populated_Lexid_Discovered_pcnt
          ,le.populated_RemoteIPAddress_pcnt
          ,le.populated_ConsumerIPAddress_pcnt
          ,le.populated_Email_Address_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,20,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := RDP_Delta(prevDS, PROJECT(h, RDP_Layout_RDP));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),20,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(RDP_Layout_RDP) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FraudGov, RDP_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
