IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_IDA; // Import modules for FieldTypes attribute definitions
EXPORT RawInput_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 31;
  EXPORT NumRulesFromFieldType := 31;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 1;
  EXPORT NumRulesWithPossibleEdits := 1;
  EXPORT Expanded_Layout := RECORD(RawInput_Layout_IDA)
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 middlename_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 addressline1_Invalid;
    UNSIGNED1 addressline2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 dl_Invalid;
    UNSIGNED1 dlstate_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 clientassigneduniquerecordid_Invalid;
    BOOLEAN clientassigneduniquerecordid_wouldSkip;
    UNSIGNED1 emailaddress_Invalid;
    UNSIGNED1 ipaddress_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RawInput_Layout_IDA)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
  EXPORT Rule_Layout := RECORD(RawInput_Layout_IDA)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'firstname:Invalid_FName:ALLOW','firstname:Invalid_FName:LENGTHS','firstname:Invalid_FName:WORDS'
          ,'middlename:Invalid_MName:ALLOW','middlename:Invalid_MName:LENGTHS','middlename:Invalid_MName:WORDS'
          ,'lastname:Invalid_LName:ALLOW','lastname:Invalid_LName:LENGTHS','lastname:Invalid_LName:WORDS'
          ,'suffix:Invalid_Suffix:ALLOW','suffix:Invalid_Suffix:WORDS'
          ,'addressline1:Invalid_Address1:ALLOW','addressline1:Invalid_Address1:WORDS'
          ,'addressline2:Invalid_Address2:ALLOW','addressline2:Invalid_Address2:WORDS'
          ,'city:Invalid_City:ALLOW','city:Invalid_City:WORDS'
          ,'state:Invalid_State:CUSTOM'
          ,'zip:Invalid_Zip:ALLOW','zip:Invalid_Zip:LENGTHS'
          ,'dob:Invalid_DOB:CUSTOM'
          ,'ssn:Invalid_SSN:ALLOW','ssn:Invalid_SSN:LENGTHS','ssn:Invalid_SSN:WORDS'
          ,'dl:Invalid_DL:CUSTOM'
          ,'dlstate:Invalid_State:CUSTOM'
          ,'phone:Invalid_Phone:ALLOW','phone:Invalid_Phone:LENGTHS'
          ,'clientassigneduniquerecordid:Invalid_Clientassigneduniquerecordid:CUSTOM'
          ,'emailaddress:Invalid_Emailaddress:CUSTOM'
          ,'ipaddress:Invalid_Ipaddress:CUSTOM'
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
          ,RawInput_Fields.InvalidMessage_firstname(1),RawInput_Fields.InvalidMessage_firstname(2),RawInput_Fields.InvalidMessage_firstname(3)
          ,RawInput_Fields.InvalidMessage_middlename(1),RawInput_Fields.InvalidMessage_middlename(2),RawInput_Fields.InvalidMessage_middlename(3)
          ,RawInput_Fields.InvalidMessage_lastname(1),RawInput_Fields.InvalidMessage_lastname(2),RawInput_Fields.InvalidMessage_lastname(3)
          ,RawInput_Fields.InvalidMessage_suffix(1),RawInput_Fields.InvalidMessage_suffix(2)
          ,RawInput_Fields.InvalidMessage_addressline1(1),RawInput_Fields.InvalidMessage_addressline1(2)
          ,RawInput_Fields.InvalidMessage_addressline2(1),RawInput_Fields.InvalidMessage_addressline2(2)
          ,RawInput_Fields.InvalidMessage_city(1),RawInput_Fields.InvalidMessage_city(2)
          ,RawInput_Fields.InvalidMessage_state(1)
          ,RawInput_Fields.InvalidMessage_zip(1),RawInput_Fields.InvalidMessage_zip(2)
          ,RawInput_Fields.InvalidMessage_dob(1)
          ,RawInput_Fields.InvalidMessage_ssn(1),RawInput_Fields.InvalidMessage_ssn(2),RawInput_Fields.InvalidMessage_ssn(3)
          ,RawInput_Fields.InvalidMessage_dl(1)
          ,RawInput_Fields.InvalidMessage_dlstate(1)
          ,RawInput_Fields.InvalidMessage_phone(1),RawInput_Fields.InvalidMessage_phone(2)
          ,RawInput_Fields.InvalidMessage_clientassigneduniquerecordid(1)
          ,RawInput_Fields.InvalidMessage_emailaddress(1)
          ,RawInput_Fields.InvalidMessage_ipaddress(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
EXPORT FromNone(DATASET(RawInput_Layout_IDA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.firstname_Invalid := RawInput_Fields.InValid_firstname((SALT311.StrType)le.firstname);
    SELF.middlename_Invalid := RawInput_Fields.InValid_middlename((SALT311.StrType)le.middlename);
    SELF.lastname_Invalid := RawInput_Fields.InValid_lastname((SALT311.StrType)le.lastname);
    SELF.suffix_Invalid := RawInput_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.addressline1_Invalid := RawInput_Fields.InValid_addressline1((SALT311.StrType)le.addressline1);
    SELF.addressline2_Invalid := RawInput_Fields.InValid_addressline2((SALT311.StrType)le.addressline2);
    SELF.city_Invalid := RawInput_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := RawInput_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_Invalid := RawInput_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.dob_Invalid := RawInput_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.ssn_Invalid := RawInput_Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.dl_Invalid := RawInput_Fields.InValid_dl((SALT311.StrType)le.dl);
    SELF.dlstate_Invalid := RawInput_Fields.InValid_dlstate((SALT311.StrType)le.dlstate);
    SELF.phone_Invalid := RawInput_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.clientassigneduniquerecordid_Invalid := RawInput_Fields.InValid_clientassigneduniquerecordid((SALT311.StrType)le.clientassigneduniquerecordid);
    SELF.clientassigneduniquerecordid := IF(SELF.clientassigneduniquerecordid_Invalid=0 OR NOT withOnfail, le.clientassigneduniquerecordid, SKIP); // ONFAIL(REJECT)
    SELF.clientassigneduniquerecordid_wouldSkip := SELF.clientassigneduniquerecordid_Invalid > 0;
    SELF.emailaddress_Invalid := RawInput_Fields.InValid_emailaddress((SALT311.StrType)le.emailaddress);
    SELF.ipaddress_Invalid := RawInput_Fields.InValid_ipaddress((SALT311.StrType)le.ipaddress);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RawInput_Layout_IDA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.firstname_Invalid << 0 ) + ( le.middlename_Invalid << 2 ) + ( le.lastname_Invalid << 4 ) + ( le.suffix_Invalid << 6 ) + ( le.addressline1_Invalid << 8 ) + ( le.addressline2_Invalid << 10 ) + ( le.city_Invalid << 12 ) + ( le.state_Invalid << 14 ) + ( le.zip_Invalid << 15 ) + ( le.dob_Invalid << 17 ) + ( le.ssn_Invalid << 18 ) + ( le.dl_Invalid << 20 ) + ( le.dlstate_Invalid << 21 ) + ( le.phone_Invalid << 22 ) + ( le.clientassigneduniquerecordid_Invalid << 24 ) + ( le.emailaddress_Invalid << 25 ) + ( le.ipaddress_Invalid << 26 );
    SELF.ScrubsCleanBits1 := ( IF(le.clientassigneduniquerecordid_wouldSkip, 1, 0) << 0 );
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
  EXPORT Infile := PROJECT(h,RawInput_Layout_IDA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.middlename_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.addressline1_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.addressline2_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.dl_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.dlstate_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.clientassigneduniquerecordid_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.emailaddress_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.ipaddress_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.clientassigneduniquerecordid_wouldSkip := le.ScrubsCleanBits1 >> 0;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    firstname_ALLOW_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    firstname_LENGTHS_ErrorCount := COUNT(GROUP,h.firstname_Invalid=2);
    firstname_WORDS_ErrorCount := COUNT(GROUP,h.firstname_Invalid=3);
    firstname_Total_ErrorCount := COUNT(GROUP,h.firstname_Invalid>0);
    middlename_ALLOW_ErrorCount := COUNT(GROUP,h.middlename_Invalid=1);
    middlename_LENGTHS_ErrorCount := COUNT(GROUP,h.middlename_Invalid=2);
    middlename_WORDS_ErrorCount := COUNT(GROUP,h.middlename_Invalid=3);
    middlename_Total_ErrorCount := COUNT(GROUP,h.middlename_Invalid>0);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    lastname_LENGTHS_ErrorCount := COUNT(GROUP,h.lastname_Invalid=2);
    lastname_WORDS_ErrorCount := COUNT(GROUP,h.lastname_Invalid=3);
    lastname_Total_ErrorCount := COUNT(GROUP,h.lastname_Invalid>0);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_WORDS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    addressline1_ALLOW_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=1);
    addressline1_WORDS_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=2);
    addressline1_Total_ErrorCount := COUNT(GROUP,h.addressline1_Invalid>0);
    addressline2_ALLOW_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=1);
    addressline2_WORDS_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=2);
    addressline2_Total_ErrorCount := COUNT(GROUP,h.addressline2_Invalid>0);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_WORDS_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_WORDS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    dl_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_Invalid=1);
    dlstate_CUSTOM_ErrorCount := COUNT(GROUP,h.dlstate_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    clientassigneduniquerecordid_CUSTOM_ErrorCount := COUNT(GROUP,h.clientassigneduniquerecordid_Invalid=1);
    clientassigneduniquerecordid_CUSTOM_WouldSkipRecCount := COUNT(GROUP,h.clientassigneduniquerecordid_Invalid=1 AND h.clientassigneduniquerecordid_wouldSkip);
    emailaddress_CUSTOM_ErrorCount := COUNT(GROUP,h.emailaddress_Invalid=1);
    ipaddress_CUSTOM_ErrorCount := COUNT(GROUP,h.ipaddress_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.firstname_Invalid > 0 OR h.middlename_Invalid > 0 OR h.lastname_Invalid > 0 OR h.suffix_Invalid > 0 OR h.addressline1_Invalid > 0 OR h.addressline2_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.dob_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dl_Invalid > 0 OR h.dlstate_Invalid > 0 OR h.phone_Invalid > 0 OR h.clientassigneduniquerecordid_Invalid > 0 OR h.emailaddress_Invalid > 0 OR h.ipaddress_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.clientassigneduniquerecordid_wouldSkip);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.firstname_Total_ErrorCount > 0, 1, 0) + IF(le.middlename_Total_ErrorCount > 0, 1, 0) + IF(le.lastname_Total_ErrorCount > 0, 1, 0) + IF(le.suffix_Total_ErrorCount > 0, 1, 0) + IF(le.addressline1_Total_ErrorCount > 0, 1, 0) + IF(le.addressline2_Total_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dlstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_Total_ErrorCount > 0, 1, 0) + IF(le.clientassigneduniquerecordid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.emailaddress_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ipaddress_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firstname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.firstname_WORDS_ErrorCount > 0, 1, 0) + IF(le.middlename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middlename_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.middlename_WORDS_ErrorCount > 0, 1, 0) + IF(le.lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lastname_WORDS_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.addressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressline1_WORDS_ErrorCount > 0, 1, 0) + IF(le.addressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressline2_WORDS_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_WORDS_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.dl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dlstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clientassigneduniquerecordid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.emailaddress_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ipaddress_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.clientassigneduniquerecordid_CUSTOM_WouldSkipRecCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.firstname_Invalid,le.middlename_Invalid,le.lastname_Invalid,le.suffix_Invalid,le.addressline1_Invalid,le.addressline2_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.dob_Invalid,le.ssn_Invalid,le.dl_Invalid,le.dlstate_Invalid,le.phone_Invalid,le.clientassigneduniquerecordid_Invalid,le.emailaddress_Invalid,le.ipaddress_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RawInput_Fields.InvalidMessage_firstname(le.firstname_Invalid),RawInput_Fields.InvalidMessage_middlename(le.middlename_Invalid),RawInput_Fields.InvalidMessage_lastname(le.lastname_Invalid),RawInput_Fields.InvalidMessage_suffix(le.suffix_Invalid),RawInput_Fields.InvalidMessage_addressline1(le.addressline1_Invalid),RawInput_Fields.InvalidMessage_addressline2(le.addressline2_Invalid),RawInput_Fields.InvalidMessage_city(le.city_Invalid),RawInput_Fields.InvalidMessage_state(le.state_Invalid),RawInput_Fields.InvalidMessage_zip(le.zip_Invalid),RawInput_Fields.InvalidMessage_dob(le.dob_Invalid),RawInput_Fields.InvalidMessage_ssn(le.ssn_Invalid),RawInput_Fields.InvalidMessage_dl(le.dl_Invalid),RawInput_Fields.InvalidMessage_dlstate(le.dlstate_Invalid),RawInput_Fields.InvalidMessage_phone(le.phone_Invalid),RawInput_Fields.InvalidMessage_clientassigneduniquerecordid(le.clientassigneduniquerecordid_Invalid),RawInput_Fields.InvalidMessage_emailaddress(le.emailaddress_Invalid),RawInput_Fields.InvalidMessage_ipaddress(le.ipaddress_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.firstname_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.middlename_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.addressline1_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.addressline2_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dlstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clientassigneduniquerecordid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.emailaddress_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ipaddress_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'firstname','middlename','lastname','suffix','addressline1','addressline2','city','state','zip','dob','ssn','dl','dlstate','phone','clientassigneduniquerecordid','emailaddress','ipaddress','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_Address1','Invalid_Address2','Invalid_City','Invalid_State','Invalid_Zip','Invalid_DOB','Invalid_SSN','Invalid_DL','Invalid_State','Invalid_Phone','Invalid_Clientassigneduniquerecordid','Invalid_Emailaddress','Invalid_Ipaddress','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.firstname,(SALT311.StrType)le.middlename,(SALT311.StrType)le.lastname,(SALT311.StrType)le.suffix,(SALT311.StrType)le.addressline1,(SALT311.StrType)le.addressline2,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.dob,(SALT311.StrType)le.ssn,(SALT311.StrType)le.dl,(SALT311.StrType)le.dlstate,(SALT311.StrType)le.phone,(SALT311.StrType)le.clientassigneduniquerecordid,(SALT311.StrType)le.emailaddress,(SALT311.StrType)le.ipaddress,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(RawInput_Layout_IDA) prevDS = DATASET([], RawInput_Layout_IDA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTHS_ErrorCount,le.firstname_WORDS_ErrorCount
          ,le.middlename_ALLOW_ErrorCount,le.middlename_LENGTHS_ErrorCount,le.middlename_WORDS_ErrorCount
          ,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTHS_ErrorCount,le.lastname_WORDS_ErrorCount
          ,le.suffix_ALLOW_ErrorCount,le.suffix_WORDS_ErrorCount
          ,le.addressline1_ALLOW_ErrorCount,le.addressline1_WORDS_ErrorCount
          ,le.addressline2_ALLOW_ErrorCount,le.addressline2_WORDS_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_WORDS_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.dl_CUSTOM_ErrorCount
          ,le.dlstate_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTHS_ErrorCount
          ,le.clientassigneduniquerecordid_CUSTOM_ErrorCount
          ,le.emailaddress_CUSTOM_ErrorCount
          ,le.ipaddress_CUSTOM_ErrorCount
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
          ,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTHS_ErrorCount,le.firstname_WORDS_ErrorCount
          ,le.middlename_ALLOW_ErrorCount,le.middlename_LENGTHS_ErrorCount,le.middlename_WORDS_ErrorCount
          ,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTHS_ErrorCount,le.lastname_WORDS_ErrorCount
          ,le.suffix_ALLOW_ErrorCount,le.suffix_WORDS_ErrorCount
          ,le.addressline1_ALLOW_ErrorCount,le.addressline1_WORDS_ErrorCount
          ,le.addressline2_ALLOW_ErrorCount,le.addressline2_WORDS_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_WORDS_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.dl_CUSTOM_ErrorCount
          ,le.dlstate_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTHS_ErrorCount
          ,le.clientassigneduniquerecordid_CUSTOM_ErrorCount
          ,le.emailaddress_CUSTOM_ErrorCount
          ,le.ipaddress_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := RawInput_hygiene(PROJECT(h, RawInput_Layout_IDA));
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
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middlename:' + getFieldTypeText(h.middlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressline1:' + getFieldTypeText(h.addressline1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressline2:' + getFieldTypeText(h.addressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl:' + getFieldTypeText(h.dl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dlstate:' + getFieldTypeText(h.dlstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clientassigneduniquerecordid:' + getFieldTypeText(h.clientassigneduniquerecordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'emailaddress:' + getFieldTypeText(h.emailaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ipaddress:' + getFieldTypeText(h.ipaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_firstname_cnt
          ,le.populated_middlename_cnt
          ,le.populated_lastname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_addressline1_cnt
          ,le.populated_addressline2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_dob_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dl_cnt
          ,le.populated_dlstate_cnt
          ,le.populated_phone_cnt
          ,le.populated_clientassigneduniquerecordid_cnt
          ,le.populated_emailaddress_cnt
          ,le.populated_ipaddress_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_firstname_pcnt
          ,le.populated_middlename_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_addressline1_pcnt
          ,le.populated_addressline2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dl_pcnt
          ,le.populated_dlstate_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_clientassigneduniquerecordid_pcnt
          ,le.populated_emailaddress_pcnt
          ,le.populated_ipaddress_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,17,xNormHygieneStats(LEFT,COUNTER,'POP'));

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

    mod_Delta := RawInput_Delta(prevDS, PROJECT(h, RawInput_Layout_IDA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),17,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(RawInput_Layout_IDA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_IDA, RawInput_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
