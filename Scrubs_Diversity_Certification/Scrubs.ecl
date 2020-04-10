IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 47;
  EXPORT NumRulesFromFieldType := 47;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 39;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Diversity_Certification)
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 dateadded_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 profilelastupdated_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 ethnicity_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 addresscity_Invalid;
    UNSIGNED1 addressstate_Invalid;
    UNSIGNED1 addresszipcode_Invalid;
    UNSIGNED1 addresszip4_Invalid;
    UNSIGNED1 building_Invalid;
    UNSIGNED1 contact_Invalid;
    UNSIGNED1 phone1_Invalid;
    UNSIGNED1 phone2_Invalid;
    UNSIGNED1 phone3_Invalid;
    UNSIGNED1 cell_Invalid;
    UNSIGNED1 fax_Invalid;
    UNSIGNED1 email1_Invalid;
    UNSIGNED1 email2_Invalid;
    UNSIGNED1 email3_Invalid;
    UNSIGNED1 webpage1_Invalid;
    UNSIGNED1 webpage2_Invalid;
    UNSIGNED1 webpage3_Invalid;
    UNSIGNED1 businessname_Invalid;
    UNSIGNED1 dba_Invalid;
    UNSIGNED1 businessid_Invalid;
    UNSIGNED1 natureofbusiness_Invalid;
    UNSIGNED1 businessdescription_Invalid;
    UNSIGNED1 certificatedatefrom1_Invalid;
    UNSIGNED1 certificatedateto1_Invalid;
    UNSIGNED1 certificationnumber1_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Diversity_Certification)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_Diversity_Certification)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dartid:Invalid_No:ALLOW'
          ,'dateadded:Invalid_Date:CUSTOM'
          ,'dateupdated:Invalid_Date:CUSTOM'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'profilelastupdated:Invalid_Date:CUSTOM'
          ,'fname:Invalid_Alpha:ALLOW'
          ,'lname:Invalid_Alpha:ALLOW'
          ,'mname:Invalid_AlphaChar:ALLOW'
          ,'suffix:Invalid_Alpha:ALLOW'
          ,'title:Invalid_AlphaChar:ALLOW'
          ,'ethnicity:Invalid_Alpha:ALLOW'
          ,'gender:Invalid_Alpha:ALLOW'
          ,'address1:Invalid_AlphaNum:ALLOW'
          ,'address2:Invalid_AlphaNum:ALLOW'
          ,'addresscity:Invalid_Alpha:ALLOW'
          ,'addressstate:Invalid_State:ALLOW','addressstate:Invalid_State:LENGTHS'
          ,'addresszipcode:Invalid_Zip:ALLOW','addresszipcode:Invalid_Zip:LENGTHS'
          ,'addresszip4:Invalid_No:ALLOW'
          ,'building:Invalid_Alpha:ALLOW'
          ,'contact:Invalid_Alpha:ALLOW'
          ,'phone1:Invalid_Phone:ALLOW','phone1:Invalid_Phone:LENGTHS'
          ,'phone2:Invalid_Phone:ALLOW','phone2:Invalid_Phone:LENGTHS'
          ,'phone3:Invalid_Phone:ALLOW','phone3:Invalid_Phone:LENGTHS'
          ,'cell:Invalid_Phone:ALLOW','cell:Invalid_Phone:LENGTHS'
          ,'fax:Invalid_Phone:ALLOW','fax:Invalid_Phone:LENGTHS'
          ,'email1:Invalid_AlphaNumChar:ALLOW'
          ,'email2:Invalid_AlphaNumChar:ALLOW'
          ,'email3:Invalid_AlphaNumChar:ALLOW'
          ,'webpage1:Invalid_AlphaNumChar:ALLOW'
          ,'webpage2:Invalid_AlphaNumChar:ALLOW'
          ,'webpage3:Invalid_AlphaNumChar:ALLOW'
          ,'businessname:Invalid_AlphaNum:ALLOW'
          ,'dba:Invalid_AlphaNum:ALLOW'
          ,'businessid:Invalid_No:ALLOW'
          ,'natureofbusiness:Invalid_Alpha:ALLOW'
          ,'businessdescription:Invalid_AlphaChar:ALLOW'
          ,'certificatedatefrom1:Invalid_Date:CUSTOM'
          ,'certificatedateto1:Invalid_Future:CUSTOM'
          ,'certificationnumber1:Invalid_AlphaNumChar:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dartid(1)
          ,Fields.InvalidMessage_dateadded(1)
          ,Fields.InvalidMessage_dateupdated(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_profilelastupdated(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_suffix(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_ethnicity(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_address1(1)
          ,Fields.InvalidMessage_address2(1)
          ,Fields.InvalidMessage_addresscity(1)
          ,Fields.InvalidMessage_addressstate(1),Fields.InvalidMessage_addressstate(2)
          ,Fields.InvalidMessage_addresszipcode(1),Fields.InvalidMessage_addresszipcode(2)
          ,Fields.InvalidMessage_addresszip4(1)
          ,Fields.InvalidMessage_building(1)
          ,Fields.InvalidMessage_contact(1)
          ,Fields.InvalidMessage_phone1(1),Fields.InvalidMessage_phone1(2)
          ,Fields.InvalidMessage_phone2(1),Fields.InvalidMessage_phone2(2)
          ,Fields.InvalidMessage_phone3(1),Fields.InvalidMessage_phone3(2)
          ,Fields.InvalidMessage_cell(1),Fields.InvalidMessage_cell(2)
          ,Fields.InvalidMessage_fax(1),Fields.InvalidMessage_fax(2)
          ,Fields.InvalidMessage_email1(1)
          ,Fields.InvalidMessage_email2(1)
          ,Fields.InvalidMessage_email3(1)
          ,Fields.InvalidMessage_webpage1(1)
          ,Fields.InvalidMessage_webpage2(1)
          ,Fields.InvalidMessage_webpage3(1)
          ,Fields.InvalidMessage_businessname(1)
          ,Fields.InvalidMessage_dba(1)
          ,Fields.InvalidMessage_businessid(1)
          ,Fields.InvalidMessage_natureofbusiness(1)
          ,Fields.InvalidMessage_businessdescription(1)
          ,Fields.InvalidMessage_certificatedatefrom1(1)
          ,Fields.InvalidMessage_certificatedateto1(1)
          ,Fields.InvalidMessage_certificationnumber1(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_Diversity_Certification) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dartid_Invalid := Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.dateadded_Invalid := Fields.InValid_dateadded((SALT311.StrType)le.dateadded);
    SELF.dateupdated_Invalid := Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.profilelastupdated_Invalid := Fields.InValid_profilelastupdated((SALT311.StrType)le.profilelastupdated);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    SELF.ethnicity_Invalid := Fields.InValid_ethnicity((SALT311.StrType)le.ethnicity);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.address1_Invalid := Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.addresscity_Invalid := Fields.InValid_addresscity((SALT311.StrType)le.addresscity);
    SELF.addressstate_Invalid := Fields.InValid_addressstate((SALT311.StrType)le.addressstate);
    SELF.addresszipcode_Invalid := Fields.InValid_addresszipcode((SALT311.StrType)le.addresszipcode);
    SELF.addresszip4_Invalid := Fields.InValid_addresszip4((SALT311.StrType)le.addresszip4);
    SELF.building_Invalid := Fields.InValid_building((SALT311.StrType)le.building);
    SELF.contact_Invalid := Fields.InValid_contact((SALT311.StrType)le.contact);
    SELF.phone1_Invalid := Fields.InValid_phone1((SALT311.StrType)le.phone1);
    SELF.phone2_Invalid := Fields.InValid_phone2((SALT311.StrType)le.phone2);
    SELF.phone3_Invalid := Fields.InValid_phone3((SALT311.StrType)le.phone3);
    SELF.cell_Invalid := Fields.InValid_cell((SALT311.StrType)le.cell);
    SELF.fax_Invalid := Fields.InValid_fax((SALT311.StrType)le.fax);
    SELF.email1_Invalid := Fields.InValid_email1((SALT311.StrType)le.email1);
    SELF.email2_Invalid := Fields.InValid_email2((SALT311.StrType)le.email2);
    SELF.email3_Invalid := Fields.InValid_email3((SALT311.StrType)le.email3);
    SELF.webpage1_Invalid := Fields.InValid_webpage1((SALT311.StrType)le.webpage1);
    SELF.webpage2_Invalid := Fields.InValid_webpage2((SALT311.StrType)le.webpage2);
    SELF.webpage3_Invalid := Fields.InValid_webpage3((SALT311.StrType)le.webpage3);
    SELF.businessname_Invalid := Fields.InValid_businessname((SALT311.StrType)le.businessname);
    SELF.dba_Invalid := Fields.InValid_dba((SALT311.StrType)le.dba);
    SELF.businessid_Invalid := Fields.InValid_businessid((SALT311.StrType)le.businessid);
    SELF.natureofbusiness_Invalid := Fields.InValid_natureofbusiness((SALT311.StrType)le.natureofbusiness);
    SELF.businessdescription_Invalid := Fields.InValid_businessdescription((SALT311.StrType)le.businessdescription);
    SELF.certificatedatefrom1_Invalid := Fields.InValid_certificatedatefrom1((SALT311.StrType)le.certificatedatefrom1);
    SELF.certificatedateto1_Invalid := Fields.InValid_certificatedateto1((SALT311.StrType)le.certificatedateto1);
    SELF.certificationnumber1_Invalid := Fields.InValid_certificationnumber1((SALT311.StrType)le.certificationnumber1);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Diversity_Certification);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dartid_Invalid << 0 ) + ( le.dateadded_Invalid << 1 ) + ( le.dateupdated_Invalid << 2 ) + ( le.state_Invalid << 3 ) + ( le.profilelastupdated_Invalid << 5 ) + ( le.fname_Invalid << 6 ) + ( le.lname_Invalid << 7 ) + ( le.mname_Invalid << 8 ) + ( le.suffix_Invalid << 9 ) + ( le.title_Invalid << 10 ) + ( le.ethnicity_Invalid << 11 ) + ( le.gender_Invalid << 12 ) + ( le.address1_Invalid << 13 ) + ( le.address2_Invalid << 14 ) + ( le.addresscity_Invalid << 15 ) + ( le.addressstate_Invalid << 16 ) + ( le.addresszipcode_Invalid << 18 ) + ( le.addresszip4_Invalid << 20 ) + ( le.building_Invalid << 21 ) + ( le.contact_Invalid << 22 ) + ( le.phone1_Invalid << 23 ) + ( le.phone2_Invalid << 25 ) + ( le.phone3_Invalid << 27 ) + ( le.cell_Invalid << 29 ) + ( le.fax_Invalid << 31 ) + ( le.email1_Invalid << 33 ) + ( le.email2_Invalid << 34 ) + ( le.email3_Invalid << 35 ) + ( le.webpage1_Invalid << 36 ) + ( le.webpage2_Invalid << 37 ) + ( le.webpage3_Invalid << 38 ) + ( le.businessname_Invalid << 39 ) + ( le.dba_Invalid << 40 ) + ( le.businessid_Invalid << 41 ) + ( le.natureofbusiness_Invalid << 42 ) + ( le.businessdescription_Invalid << 43 ) + ( le.certificatedatefrom1_Invalid << 44 ) + ( le.certificatedateto1_Invalid << 45 ) + ( le.certificationnumber1_Invalid << 46 );
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
  EXPORT Infile := PROJECT(h,Layout_Diversity_Certification);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dateadded_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.profilelastupdated_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ethnicity_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.addresscity_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.addressstate_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.addresszipcode_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.addresszip4_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.building_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.contact_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.phone1_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.phone2_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.phone3_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.cell_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.fax_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.email1_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.email2_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.email3_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.webpage1_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.webpage2_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.webpage3_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.businessname_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.dba_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.businessid_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.natureofbusiness_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.businessdescription_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.certificatedatefrom1_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.certificatedateto1_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.certificationnumber1_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dartid_ALLOW_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    dateadded_CUSTOM_ErrorCount := COUNT(GROUP,h.dateadded_Invalid=1);
    dateupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    profilelastupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.profilelastupdated_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    ethnicity_ALLOW_ErrorCount := COUNT(GROUP,h.ethnicity_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    address1_ALLOW_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address2_ALLOW_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    addresscity_ALLOW_ErrorCount := COUNT(GROUP,h.addresscity_Invalid=1);
    addressstate_ALLOW_ErrorCount := COUNT(GROUP,h.addressstate_Invalid=1);
    addressstate_LENGTHS_ErrorCount := COUNT(GROUP,h.addressstate_Invalid=2);
    addressstate_Total_ErrorCount := COUNT(GROUP,h.addressstate_Invalid>0);
    addresszipcode_ALLOW_ErrorCount := COUNT(GROUP,h.addresszipcode_Invalid=1);
    addresszipcode_LENGTHS_ErrorCount := COUNT(GROUP,h.addresszipcode_Invalid=2);
    addresszipcode_Total_ErrorCount := COUNT(GROUP,h.addresszipcode_Invalid>0);
    addresszip4_ALLOW_ErrorCount := COUNT(GROUP,h.addresszip4_Invalid=1);
    building_ALLOW_ErrorCount := COUNT(GROUP,h.building_Invalid=1);
    contact_ALLOW_ErrorCount := COUNT(GROUP,h.contact_Invalid=1);
    phone1_ALLOW_ErrorCount := COUNT(GROUP,h.phone1_Invalid=1);
    phone1_LENGTHS_ErrorCount := COUNT(GROUP,h.phone1_Invalid=2);
    phone1_Total_ErrorCount := COUNT(GROUP,h.phone1_Invalid>0);
    phone2_ALLOW_ErrorCount := COUNT(GROUP,h.phone2_Invalid=1);
    phone2_LENGTHS_ErrorCount := COUNT(GROUP,h.phone2_Invalid=2);
    phone2_Total_ErrorCount := COUNT(GROUP,h.phone2_Invalid>0);
    phone3_ALLOW_ErrorCount := COUNT(GROUP,h.phone3_Invalid=1);
    phone3_LENGTHS_ErrorCount := COUNT(GROUP,h.phone3_Invalid=2);
    phone3_Total_ErrorCount := COUNT(GROUP,h.phone3_Invalid>0);
    cell_ALLOW_ErrorCount := COUNT(GROUP,h.cell_Invalid=1);
    cell_LENGTHS_ErrorCount := COUNT(GROUP,h.cell_Invalid=2);
    cell_Total_ErrorCount := COUNT(GROUP,h.cell_Invalid>0);
    fax_ALLOW_ErrorCount := COUNT(GROUP,h.fax_Invalid=1);
    fax_LENGTHS_ErrorCount := COUNT(GROUP,h.fax_Invalid=2);
    fax_Total_ErrorCount := COUNT(GROUP,h.fax_Invalid>0);
    email1_ALLOW_ErrorCount := COUNT(GROUP,h.email1_Invalid=1);
    email2_ALLOW_ErrorCount := COUNT(GROUP,h.email2_Invalid=1);
    email3_ALLOW_ErrorCount := COUNT(GROUP,h.email3_Invalid=1);
    webpage1_ALLOW_ErrorCount := COUNT(GROUP,h.webpage1_Invalid=1);
    webpage2_ALLOW_ErrorCount := COUNT(GROUP,h.webpage2_Invalid=1);
    webpage3_ALLOW_ErrorCount := COUNT(GROUP,h.webpage3_Invalid=1);
    businessname_ALLOW_ErrorCount := COUNT(GROUP,h.businessname_Invalid=1);
    dba_ALLOW_ErrorCount := COUNT(GROUP,h.dba_Invalid=1);
    businessid_ALLOW_ErrorCount := COUNT(GROUP,h.businessid_Invalid=1);
    natureofbusiness_ALLOW_ErrorCount := COUNT(GROUP,h.natureofbusiness_Invalid=1);
    businessdescription_ALLOW_ErrorCount := COUNT(GROUP,h.businessdescription_Invalid=1);
    certificatedatefrom1_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom1_Invalid=1);
    certificatedateto1_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto1_Invalid=1);
    certificationnumber1_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber1_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dartid_Invalid > 0 OR h.dateadded_Invalid > 0 OR h.dateupdated_Invalid > 0 OR h.state_Invalid > 0 OR h.profilelastupdated_Invalid > 0 OR h.fname_Invalid > 0 OR h.lname_Invalid > 0 OR h.mname_Invalid > 0 OR h.suffix_Invalid > 0 OR h.title_Invalid > 0 OR h.ethnicity_Invalid > 0 OR h.gender_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.addresscity_Invalid > 0 OR h.addressstate_Invalid > 0 OR h.addresszipcode_Invalid > 0 OR h.addresszip4_Invalid > 0 OR h.building_Invalid > 0 OR h.contact_Invalid > 0 OR h.phone1_Invalid > 0 OR h.phone2_Invalid > 0 OR h.phone3_Invalid > 0 OR h.cell_Invalid > 0 OR h.fax_Invalid > 0 OR h.email1_Invalid > 0 OR h.email2_Invalid > 0 OR h.email3_Invalid > 0 OR h.webpage1_Invalid > 0 OR h.webpage2_Invalid > 0 OR h.webpage3_Invalid > 0 OR h.businessname_Invalid > 0 OR h.dba_Invalid > 0 OR h.businessid_Invalid > 0 OR h.natureofbusiness_Invalid > 0 OR h.businessdescription_Invalid > 0 OR h.certificatedatefrom1_Invalid > 0 OR h.certificatedateto1_Invalid > 0 OR h.certificationnumber1_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.profilelastupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ethnicity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_Total_ErrorCount > 0, 1, 0) + IF(le.addresszipcode_Total_ErrorCount > 0, 1, 0) + IF(le.addresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_Total_ErrorCount > 0, 1, 0) + IF(le.phone2_Total_ErrorCount > 0, 1, 0) + IF(le.phone3_Total_ErrorCount > 0, 1, 0) + IF(le.cell_Total_ErrorCount > 0, 1, 0) + IF(le.fax_Total_ErrorCount > 0, 1, 0) + IF(le.email1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.natureofbusiness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessdescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificationnumber1_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.profilelastupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ethnicity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addresszipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresszipcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phone2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phone3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone3_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cell_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cell_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.email1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.natureofbusiness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessdescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificationnumber1_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dartid_Invalid,le.dateadded_Invalid,le.dateupdated_Invalid,le.state_Invalid,le.profilelastupdated_Invalid,le.fname_Invalid,le.lname_Invalid,le.mname_Invalid,le.suffix_Invalid,le.title_Invalid,le.ethnicity_Invalid,le.gender_Invalid,le.address1_Invalid,le.address2_Invalid,le.addresscity_Invalid,le.addressstate_Invalid,le.addresszipcode_Invalid,le.addresszip4_Invalid,le.building_Invalid,le.contact_Invalid,le.phone1_Invalid,le.phone2_Invalid,le.phone3_Invalid,le.cell_Invalid,le.fax_Invalid,le.email1_Invalid,le.email2_Invalid,le.email3_Invalid,le.webpage1_Invalid,le.webpage2_Invalid,le.webpage3_Invalid,le.businessname_Invalid,le.dba_Invalid,le.businessid_Invalid,le.natureofbusiness_Invalid,le.businessdescription_Invalid,le.certificatedatefrom1_Invalid,le.certificatedateto1_Invalid,le.certificationnumber1_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dartid(le.dartid_Invalid),Fields.InvalidMessage_dateadded(le.dateadded_Invalid),Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_profilelastupdated(le.profilelastupdated_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_ethnicity(le.ethnicity_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_address1(le.address1_Invalid),Fields.InvalidMessage_address2(le.address2_Invalid),Fields.InvalidMessage_addresscity(le.addresscity_Invalid),Fields.InvalidMessage_addressstate(le.addressstate_Invalid),Fields.InvalidMessage_addresszipcode(le.addresszipcode_Invalid),Fields.InvalidMessage_addresszip4(le.addresszip4_Invalid),Fields.InvalidMessage_building(le.building_Invalid),Fields.InvalidMessage_contact(le.contact_Invalid),Fields.InvalidMessage_phone1(le.phone1_Invalid),Fields.InvalidMessage_phone2(le.phone2_Invalid),Fields.InvalidMessage_phone3(le.phone3_Invalid),Fields.InvalidMessage_cell(le.cell_Invalid),Fields.InvalidMessage_fax(le.fax_Invalid),Fields.InvalidMessage_email1(le.email1_Invalid),Fields.InvalidMessage_email2(le.email2_Invalid),Fields.InvalidMessage_email3(le.email3_Invalid),Fields.InvalidMessage_webpage1(le.webpage1_Invalid),Fields.InvalidMessage_webpage2(le.webpage2_Invalid),Fields.InvalidMessage_webpage3(le.webpage3_Invalid),Fields.InvalidMessage_businessname(le.businessname_Invalid),Fields.InvalidMessage_dba(le.dba_Invalid),Fields.InvalidMessage_businessid(le.businessid_Invalid),Fields.InvalidMessage_natureofbusiness(le.natureofbusiness_Invalid),Fields.InvalidMessage_businessdescription(le.businessdescription_Invalid),Fields.InvalidMessage_certificatedatefrom1(le.certificatedatefrom1_Invalid),Fields.InvalidMessage_certificatedateto1(le.certificatedateto1_Invalid),Fields.InvalidMessage_certificationnumber1(le.certificationnumber1_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateadded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.profilelastupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ethnicity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addresscity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addressstate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.addresszipcode_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.addresszip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.building_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone1_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.phone2_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.phone3_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cell_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fax_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.email1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.webpage1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.webpage2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.webpage3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.natureofbusiness_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessdescription_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificationnumber1_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dartid','dateadded','dateupdated','state','profilelastupdated','fname','lname','mname','suffix','title','ethnicity','gender','address1','address2','addresscity','addressstate','addresszipcode','addresszip4','building','contact','phone1','phone2','phone3','cell','fax','email1','email2','email3','webpage1','webpage2','webpage3','businessname','dba','businessid','natureofbusiness','businessdescription','certificatedatefrom1','certificatedateto1','certificationnumber1','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_State','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_AlphaNumChar','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dartid,(SALT311.StrType)le.dateadded,(SALT311.StrType)le.dateupdated,(SALT311.StrType)le.state,(SALT311.StrType)le.profilelastupdated,(SALT311.StrType)le.fname,(SALT311.StrType)le.lname,(SALT311.StrType)le.mname,(SALT311.StrType)le.suffix,(SALT311.StrType)le.title,(SALT311.StrType)le.ethnicity,(SALT311.StrType)le.gender,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.addresscity,(SALT311.StrType)le.addressstate,(SALT311.StrType)le.addresszipcode,(SALT311.StrType)le.addresszip4,(SALT311.StrType)le.building,(SALT311.StrType)le.contact,(SALT311.StrType)le.phone1,(SALT311.StrType)le.phone2,(SALT311.StrType)le.phone3,(SALT311.StrType)le.cell,(SALT311.StrType)le.fax,(SALT311.StrType)le.email1,(SALT311.StrType)le.email2,(SALT311.StrType)le.email3,(SALT311.StrType)le.webpage1,(SALT311.StrType)le.webpage2,(SALT311.StrType)le.webpage3,(SALT311.StrType)le.businessname,(SALT311.StrType)le.dba,(SALT311.StrType)le.businessid,(SALT311.StrType)le.natureofbusiness,(SALT311.StrType)le.businessdescription,(SALT311.StrType)le.certificatedatefrom1,(SALT311.StrType)le.certificatedateto1,(SALT311.StrType)le.certificationnumber1,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,39,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Diversity_Certification) prevDS = DATASET([], Layout_Diversity_Certification), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dartid_ALLOW_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.profilelastupdated_CUSTOM_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.ethnicity_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.addresscity_ALLOW_ErrorCount
          ,le.addressstate_ALLOW_ErrorCount,le.addressstate_LENGTHS_ErrorCount
          ,le.addresszipcode_ALLOW_ErrorCount,le.addresszipcode_LENGTHS_ErrorCount
          ,le.addresszip4_ALLOW_ErrorCount
          ,le.building_ALLOW_ErrorCount
          ,le.contact_ALLOW_ErrorCount
          ,le.phone1_ALLOW_ErrorCount,le.phone1_LENGTHS_ErrorCount
          ,le.phone2_ALLOW_ErrorCount,le.phone2_LENGTHS_ErrorCount
          ,le.phone3_ALLOW_ErrorCount,le.phone3_LENGTHS_ErrorCount
          ,le.cell_ALLOW_ErrorCount,le.cell_LENGTHS_ErrorCount
          ,le.fax_ALLOW_ErrorCount,le.fax_LENGTHS_ErrorCount
          ,le.email1_ALLOW_ErrorCount
          ,le.email2_ALLOW_ErrorCount
          ,le.email3_ALLOW_ErrorCount
          ,le.webpage1_ALLOW_ErrorCount
          ,le.webpage2_ALLOW_ErrorCount
          ,le.webpage3_ALLOW_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.businessid_ALLOW_ErrorCount
          ,le.natureofbusiness_ALLOW_ErrorCount
          ,le.businessdescription_ALLOW_ErrorCount
          ,le.certificatedatefrom1_CUSTOM_ErrorCount
          ,le.certificatedateto1_CUSTOM_ErrorCount
          ,le.certificationnumber1_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dartid_ALLOW_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.profilelastupdated_CUSTOM_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.ethnicity_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.addresscity_ALLOW_ErrorCount
          ,le.addressstate_ALLOW_ErrorCount,le.addressstate_LENGTHS_ErrorCount
          ,le.addresszipcode_ALLOW_ErrorCount,le.addresszipcode_LENGTHS_ErrorCount
          ,le.addresszip4_ALLOW_ErrorCount
          ,le.building_ALLOW_ErrorCount
          ,le.contact_ALLOW_ErrorCount
          ,le.phone1_ALLOW_ErrorCount,le.phone1_LENGTHS_ErrorCount
          ,le.phone2_ALLOW_ErrorCount,le.phone2_LENGTHS_ErrorCount
          ,le.phone3_ALLOW_ErrorCount,le.phone3_LENGTHS_ErrorCount
          ,le.cell_ALLOW_ErrorCount,le.cell_LENGTHS_ErrorCount
          ,le.fax_ALLOW_ErrorCount,le.fax_LENGTHS_ErrorCount
          ,le.email1_ALLOW_ErrorCount
          ,le.email2_ALLOW_ErrorCount
          ,le.email3_ALLOW_ErrorCount
          ,le.webpage1_ALLOW_ErrorCount
          ,le.webpage2_ALLOW_ErrorCount
          ,le.webpage3_ALLOW_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.businessid_ALLOW_ErrorCount
          ,le.natureofbusiness_ALLOW_ErrorCount
          ,le.businessdescription_ALLOW_ErrorCount
          ,le.certificatedatefrom1_CUSTOM_ErrorCount
          ,le.certificatedateto1_CUSTOM_ErrorCount
          ,le.certificationnumber1_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
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
    mod_hygiene := hygiene(PROJECT(h, Layout_Diversity_Certification));
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
          ,'dartid:' + getFieldTypeText(h.dartid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateadded:' + getFieldTypeText(h.dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateupdated:' + getFieldTypeText(h.dateupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website:' + getFieldTypeText(h.website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'profilelastupdated:' + getFieldTypeText(h.profilelastupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'servicearea:' + getFieldTypeText(h.servicearea) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region1:' + getFieldTypeText(h.region1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region2:' + getFieldTypeText(h.region2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region3:' + getFieldTypeText(h.region3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region4:' + getFieldTypeText(h.region4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region5:' + getFieldTypeText(h.region5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ethnicity:' + getFieldTypeText(h.ethnicity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresscity:' + getFieldTypeText(h.addresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressstate:' + getFieldTypeText(h.addressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresszipcode:' + getFieldTypeText(h.addresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresszip4:' + getFieldTypeText(h.addresszip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building:' + getFieldTypeText(h.building) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact:' + getFieldTypeText(h.contact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone1:' + getFieldTypeText(h.phone1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone2:' + getFieldTypeText(h.phone2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone3:' + getFieldTypeText(h.phone3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cell:' + getFieldTypeText(h.cell) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax:' + getFieldTypeText(h.fax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email1:' + getFieldTypeText(h.email1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email2:' + getFieldTypeText(h.email2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email3:' + getFieldTypeText(h.email3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'webpage1:' + getFieldTypeText(h.webpage1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'webpage2:' + getFieldTypeText(h.webpage2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'webpage3:' + getFieldTypeText(h.webpage3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessname:' + getFieldTypeText(h.businessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba:' + getFieldTypeText(h.dba) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessid:' + getFieldTypeText(h.businessid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype1:' + getFieldTypeText(h.businesstype1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation1:' + getFieldTypeText(h.businesslocation1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype2:' + getFieldTypeText(h.businesstype2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation2:' + getFieldTypeText(h.businesslocation2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype3:' + getFieldTypeText(h.businesstype3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation3:' + getFieldTypeText(h.businesslocation3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype4:' + getFieldTypeText(h.businesstype4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation4:' + getFieldTypeText(h.businesslocation4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype5:' + getFieldTypeText(h.businesstype5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation5:' + getFieldTypeText(h.businesslocation5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry:' + getFieldTypeText(h.industry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trade:' + getFieldTypeText(h.trade) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'resourcedescription:' + getFieldTypeText(h.resourcedescription) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'natureofbusiness:' + getFieldTypeText(h.natureofbusiness) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessdescription:' + getFieldTypeText(h.businessdescription) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessstructure:' + getFieldTypeText(h.businessstructure) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'totalemployees:' + getFieldTypeText(h.totalemployees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'avgcontractsize:' + getFieldTypeText(h.avgcontractsize) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmid:' + getFieldTypeText(h.firmid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddress:' + getFieldTypeText(h.firmlocationaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddresscity:' + getFieldTypeText(h.firmlocationaddresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddresszip4:' + getFieldTypeText(h.firmlocationaddresszip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddresszipcode:' + getFieldTypeText(h.firmlocationaddresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationcounty:' + getFieldTypeText(h.firmlocationcounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationstate:' + getFieldTypeText(h.firmlocationstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certfed:' + getFieldTypeText(h.certfed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certstate:' + getFieldTypeText(h.certstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractsfederal:' + getFieldTypeText(h.contractsfederal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractsva:' + getFieldTypeText(h.contractsva) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractscommercial:' + getFieldTypeText(h.contractscommercial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractorgovernmentprime:' + getFieldTypeText(h.contractorgovernmentprime) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractorgovernmentsub:' + getFieldTypeText(h.contractorgovernmentsub) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractornongovernment:' + getFieldTypeText(h.contractornongovernment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'registeredgovernmentbus:' + getFieldTypeText(h.registeredgovernmentbus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'registerednongovernmentbus:' + getFieldTypeText(h.registerednongovernmentbus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clearancelevelpersonnel:' + getFieldTypeText(h.clearancelevelpersonnel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clearancelevelfacility:' + getFieldTypeText(h.clearancelevelfacility) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom1:' + getFieldTypeText(h.certificatedatefrom1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto1:' + getFieldTypeText(h.certificatedateto1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus1:' + getFieldTypeText(h.certificatestatus1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber1:' + getFieldTypeText(h.certificationnumber1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype1:' + getFieldTypeText(h.certificationtype1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom2:' + getFieldTypeText(h.certificatedatefrom2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto2:' + getFieldTypeText(h.certificatedateto2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus2:' + getFieldTypeText(h.certificatestatus2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber2:' + getFieldTypeText(h.certificationnumber2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype2:' + getFieldTypeText(h.certificationtype2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom3:' + getFieldTypeText(h.certificatedatefrom3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto3:' + getFieldTypeText(h.certificatedateto3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus3:' + getFieldTypeText(h.certificatestatus3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber3:' + getFieldTypeText(h.certificationnumber3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype3:' + getFieldTypeText(h.certificationtype3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom4:' + getFieldTypeText(h.certificatedatefrom4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto4:' + getFieldTypeText(h.certificatedateto4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus4:' + getFieldTypeText(h.certificatestatus4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber4:' + getFieldTypeText(h.certificationnumber4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype4:' + getFieldTypeText(h.certificationtype4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom5:' + getFieldTypeText(h.certificatedatefrom5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto5:' + getFieldTypeText(h.certificatedateto5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus5:' + getFieldTypeText(h.certificatestatus5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber5:' + getFieldTypeText(h.certificationnumber5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype5:' + getFieldTypeText(h.certificationtype5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom6:' + getFieldTypeText(h.certificatedatefrom6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto6:' + getFieldTypeText(h.certificatedateto6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus6:' + getFieldTypeText(h.certificatestatus6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber6:' + getFieldTypeText(h.certificationnumber6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype6:' + getFieldTypeText(h.certificationtype6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'starrating:' + getFieldTypeText(h.starrating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assets:' + getFieldTypeText(h.assets) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'biddescription:' + getFieldTypeText(h.biddescription) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'competitiveadvantage:' + getFieldTypeText(h.competitiveadvantage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cagecode:' + getFieldTypeText(h.cagecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'capabilitiesnarrative:' + getFieldTypeText(h.capabilitiesnarrative) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'category:' + getFieldTypeText(h.category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chtrclass:' + getFieldTypeText(h.chtrclass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription1:' + getFieldTypeText(h.productdescription1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription2:' + getFieldTypeText(h.productdescription2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription3:' + getFieldTypeText(h.productdescription3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription4:' + getFieldTypeText(h.productdescription4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription5:' + getFieldTypeText(h.productdescription5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription1:' + getFieldTypeText(h.classdescription1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription1:' + getFieldTypeText(h.subclassdescription1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription2:' + getFieldTypeText(h.classdescription2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription2:' + getFieldTypeText(h.subclassdescription2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription3:' + getFieldTypeText(h.classdescription3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription3:' + getFieldTypeText(h.subclassdescription3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription4:' + getFieldTypeText(h.classdescription4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription4:' + getFieldTypeText(h.subclassdescription4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription5:' + getFieldTypeText(h.classdescription5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription5:' + getFieldTypeText(h.subclassdescription5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classifications:' + getFieldTypeText(h.classifications) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity1:' + getFieldTypeText(h.commodity1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity2:' + getFieldTypeText(h.commodity2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity3:' + getFieldTypeText(h.commodity3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity4:' + getFieldTypeText(h.commodity4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity5:' + getFieldTypeText(h.commodity5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity6:' + getFieldTypeText(h.commodity6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity7:' + getFieldTypeText(h.commodity7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity8:' + getFieldTypeText(h.commodity8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'completedate:' + getFieldTypeText(h.completedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crossreference:' + getFieldTypeText(h.crossreference) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateestablished:' + getFieldTypeText(h.dateestablished) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessage:' + getFieldTypeText(h.businessage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deposits:' + getFieldTypeText(h.deposits) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dunsnumber:' + getFieldTypeText(h.dunsnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'enttype:' + getFieldTypeText(h.enttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expirationdate:' + getFieldTypeText(h.expirationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extendeddate:' + getFieldTypeText(h.extendeddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'issuingauthority:' + getFieldTypeText(h.issuingauthority) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'keywords:' + getFieldTypeText(h.keywords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensenumber:' + getFieldTypeText(h.licensenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensetype:' + getFieldTypeText(h.licensetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mincd:' + getFieldTypeText(h.mincd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'minorityaffiliation:' + getFieldTypeText(h.minorityaffiliation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'minorityownershipdate:' + getFieldTypeText(h.minorityownershipdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode1:' + getFieldTypeText(h.siccode1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode2:' + getFieldTypeText(h.siccode2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode3:' + getFieldTypeText(h.siccode3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode4:' + getFieldTypeText(h.siccode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode5:' + getFieldTypeText(h.siccode5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode6:' + getFieldTypeText(h.siccode6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode7:' + getFieldTypeText(h.siccode7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode8:' + getFieldTypeText(h.siccode8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode1:' + getFieldTypeText(h.naicscode1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode2:' + getFieldTypeText(h.naicscode2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode3:' + getFieldTypeText(h.naicscode3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode4:' + getFieldTypeText(h.naicscode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode5:' + getFieldTypeText(h.naicscode5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode6:' + getFieldTypeText(h.naicscode6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode7:' + getFieldTypeText(h.naicscode7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode8:' + getFieldTypeText(h.naicscode8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prequalify:' + getFieldTypeText(h.prequalify) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory1:' + getFieldTypeText(h.procurementcategory1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory1:' + getFieldTypeText(h.subprocurementcategory1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory2:' + getFieldTypeText(h.procurementcategory2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory2:' + getFieldTypeText(h.subprocurementcategory2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory3:' + getFieldTypeText(h.procurementcategory3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory3:' + getFieldTypeText(h.subprocurementcategory3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory4:' + getFieldTypeText(h.procurementcategory4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory4:' + getFieldTypeText(h.subprocurementcategory4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory5:' + getFieldTypeText(h.procurementcategory5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory5:' + getFieldTypeText(h.subprocurementcategory5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'renewal:' + getFieldTypeText(h.renewal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'renewaldate:' + getFieldTypeText(h.renewaldate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unitedcertprogrampartner:' + getFieldTypeText(h.unitedcertprogrampartner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendorkey:' + getFieldTypeText(h.vendorkey) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendornumber:' + getFieldTypeText(h.vendornumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode1:' + getFieldTypeText(h.workcode1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode2:' + getFieldTypeText(h.workcode2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode3:' + getFieldTypeText(h.workcode3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode4:' + getFieldTypeText(h.workcode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode5:' + getFieldTypeText(h.workcode5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode6:' + getFieldTypeText(h.workcode6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode7:' + getFieldTypeText(h.workcode7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode8:' + getFieldTypeText(h.workcode8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exporter:' + getFieldTypeText(h.exporter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportbusinessactivities:' + getFieldTypeText(h.exportbusinessactivities) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportto:' + getFieldTypeText(h.exportto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportbusinessrelationships:' + getFieldTypeText(h.exportbusinessrelationships) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportobjectives:' + getFieldTypeText(h.exportobjectives) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference1:' + getFieldTypeText(h.reference1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference2:' + getFieldTypeText(h.reference2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference3:' + getFieldTypeText(h.reference3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dartid_cnt
          ,le.populated_dateadded_cnt
          ,le.populated_dateupdated_cnt
          ,le.populated_website_cnt
          ,le.populated_state_cnt
          ,le.populated_profilelastupdated_cnt
          ,le.populated_county_cnt
          ,le.populated_servicearea_cnt
          ,le.populated_region1_cnt
          ,le.populated_region2_cnt
          ,le.populated_region3_cnt
          ,le.populated_region4_cnt
          ,le.populated_region5_cnt
          ,le.populated_fname_cnt
          ,le.populated_lname_cnt
          ,le.populated_mname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_title_cnt
          ,le.populated_ethnicity_cnt
          ,le.populated_gender_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_addresscity_cnt
          ,le.populated_addressstate_cnt
          ,le.populated_addresszipcode_cnt
          ,le.populated_addresszip4_cnt
          ,le.populated_building_cnt
          ,le.populated_contact_cnt
          ,le.populated_phone1_cnt
          ,le.populated_phone2_cnt
          ,le.populated_phone3_cnt
          ,le.populated_cell_cnt
          ,le.populated_fax_cnt
          ,le.populated_email1_cnt
          ,le.populated_email2_cnt
          ,le.populated_email3_cnt
          ,le.populated_webpage1_cnt
          ,le.populated_webpage2_cnt
          ,le.populated_webpage3_cnt
          ,le.populated_businessname_cnt
          ,le.populated_dba_cnt
          ,le.populated_businessid_cnt
          ,le.populated_businesstype1_cnt
          ,le.populated_businesslocation1_cnt
          ,le.populated_businesstype2_cnt
          ,le.populated_businesslocation2_cnt
          ,le.populated_businesstype3_cnt
          ,le.populated_businesslocation3_cnt
          ,le.populated_businesstype4_cnt
          ,le.populated_businesslocation4_cnt
          ,le.populated_businesstype5_cnt
          ,le.populated_businesslocation5_cnt
          ,le.populated_industry_cnt
          ,le.populated_trade_cnt
          ,le.populated_resourcedescription_cnt
          ,le.populated_natureofbusiness_cnt
          ,le.populated_businessdescription_cnt
          ,le.populated_businessstructure_cnt
          ,le.populated_totalemployees_cnt
          ,le.populated_avgcontractsize_cnt
          ,le.populated_firmid_cnt
          ,le.populated_firmlocationaddress_cnt
          ,le.populated_firmlocationaddresscity_cnt
          ,le.populated_firmlocationaddresszip4_cnt
          ,le.populated_firmlocationaddresszipcode_cnt
          ,le.populated_firmlocationcounty_cnt
          ,le.populated_firmlocationstate_cnt
          ,le.populated_certfed_cnt
          ,le.populated_certstate_cnt
          ,le.populated_contractsfederal_cnt
          ,le.populated_contractsva_cnt
          ,le.populated_contractscommercial_cnt
          ,le.populated_contractorgovernmentprime_cnt
          ,le.populated_contractorgovernmentsub_cnt
          ,le.populated_contractornongovernment_cnt
          ,le.populated_registeredgovernmentbus_cnt
          ,le.populated_registerednongovernmentbus_cnt
          ,le.populated_clearancelevelpersonnel_cnt
          ,le.populated_clearancelevelfacility_cnt
          ,le.populated_certificatedatefrom1_cnt
          ,le.populated_certificatedateto1_cnt
          ,le.populated_certificatestatus1_cnt
          ,le.populated_certificationnumber1_cnt
          ,le.populated_certificationtype1_cnt
          ,le.populated_certificatedatefrom2_cnt
          ,le.populated_certificatedateto2_cnt
          ,le.populated_certificatestatus2_cnt
          ,le.populated_certificationnumber2_cnt
          ,le.populated_certificationtype2_cnt
          ,le.populated_certificatedatefrom3_cnt
          ,le.populated_certificatedateto3_cnt
          ,le.populated_certificatestatus3_cnt
          ,le.populated_certificationnumber3_cnt
          ,le.populated_certificationtype3_cnt
          ,le.populated_certificatedatefrom4_cnt
          ,le.populated_certificatedateto4_cnt
          ,le.populated_certificatestatus4_cnt
          ,le.populated_certificationnumber4_cnt
          ,le.populated_certificationtype4_cnt
          ,le.populated_certificatedatefrom5_cnt
          ,le.populated_certificatedateto5_cnt
          ,le.populated_certificatestatus5_cnt
          ,le.populated_certificationnumber5_cnt
          ,le.populated_certificationtype5_cnt
          ,le.populated_certificatedatefrom6_cnt
          ,le.populated_certificatedateto6_cnt
          ,le.populated_certificatestatus6_cnt
          ,le.populated_certificationnumber6_cnt
          ,le.populated_certificationtype6_cnt
          ,le.populated_starrating_cnt
          ,le.populated_assets_cnt
          ,le.populated_biddescription_cnt
          ,le.populated_competitiveadvantage_cnt
          ,le.populated_cagecode_cnt
          ,le.populated_capabilitiesnarrative_cnt
          ,le.populated_category_cnt
          ,le.populated_chtrclass_cnt
          ,le.populated_productdescription1_cnt
          ,le.populated_productdescription2_cnt
          ,le.populated_productdescription3_cnt
          ,le.populated_productdescription4_cnt
          ,le.populated_productdescription5_cnt
          ,le.populated_classdescription1_cnt
          ,le.populated_subclassdescription1_cnt
          ,le.populated_classdescription2_cnt
          ,le.populated_subclassdescription2_cnt
          ,le.populated_classdescription3_cnt
          ,le.populated_subclassdescription3_cnt
          ,le.populated_classdescription4_cnt
          ,le.populated_subclassdescription4_cnt
          ,le.populated_classdescription5_cnt
          ,le.populated_subclassdescription5_cnt
          ,le.populated_classifications_cnt
          ,le.populated_commodity1_cnt
          ,le.populated_commodity2_cnt
          ,le.populated_commodity3_cnt
          ,le.populated_commodity4_cnt
          ,le.populated_commodity5_cnt
          ,le.populated_commodity6_cnt
          ,le.populated_commodity7_cnt
          ,le.populated_commodity8_cnt
          ,le.populated_completedate_cnt
          ,le.populated_crossreference_cnt
          ,le.populated_dateestablished_cnt
          ,le.populated_businessage_cnt
          ,le.populated_deposits_cnt
          ,le.populated_dunsnumber_cnt
          ,le.populated_enttype_cnt
          ,le.populated_expirationdate_cnt
          ,le.populated_extendeddate_cnt
          ,le.populated_issuingauthority_cnt
          ,le.populated_keywords_cnt
          ,le.populated_licensenumber_cnt
          ,le.populated_licensetype_cnt
          ,le.populated_mincd_cnt
          ,le.populated_minorityaffiliation_cnt
          ,le.populated_minorityownershipdate_cnt
          ,le.populated_siccode1_cnt
          ,le.populated_siccode2_cnt
          ,le.populated_siccode3_cnt
          ,le.populated_siccode4_cnt
          ,le.populated_siccode5_cnt
          ,le.populated_siccode6_cnt
          ,le.populated_siccode7_cnt
          ,le.populated_siccode8_cnt
          ,le.populated_naicscode1_cnt
          ,le.populated_naicscode2_cnt
          ,le.populated_naicscode3_cnt
          ,le.populated_naicscode4_cnt
          ,le.populated_naicscode5_cnt
          ,le.populated_naicscode6_cnt
          ,le.populated_naicscode7_cnt
          ,le.populated_naicscode8_cnt
          ,le.populated_prequalify_cnt
          ,le.populated_procurementcategory1_cnt
          ,le.populated_subprocurementcategory1_cnt
          ,le.populated_procurementcategory2_cnt
          ,le.populated_subprocurementcategory2_cnt
          ,le.populated_procurementcategory3_cnt
          ,le.populated_subprocurementcategory3_cnt
          ,le.populated_procurementcategory4_cnt
          ,le.populated_subprocurementcategory4_cnt
          ,le.populated_procurementcategory5_cnt
          ,le.populated_subprocurementcategory5_cnt
          ,le.populated_renewal_cnt
          ,le.populated_renewaldate_cnt
          ,le.populated_unitedcertprogrampartner_cnt
          ,le.populated_vendorkey_cnt
          ,le.populated_vendornumber_cnt
          ,le.populated_workcode1_cnt
          ,le.populated_workcode2_cnt
          ,le.populated_workcode3_cnt
          ,le.populated_workcode4_cnt
          ,le.populated_workcode5_cnt
          ,le.populated_workcode6_cnt
          ,le.populated_workcode7_cnt
          ,le.populated_workcode8_cnt
          ,le.populated_exporter_cnt
          ,le.populated_exportbusinessactivities_cnt
          ,le.populated_exportto_cnt
          ,le.populated_exportbusinessrelationships_cnt
          ,le.populated_exportobjectives_cnt
          ,le.populated_reference1_cnt
          ,le.populated_reference2_cnt
          ,le.populated_reference3_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dartid_pcnt
          ,le.populated_dateadded_pcnt
          ,le.populated_dateupdated_pcnt
          ,le.populated_website_pcnt
          ,le.populated_state_pcnt
          ,le.populated_profilelastupdated_pcnt
          ,le.populated_county_pcnt
          ,le.populated_servicearea_pcnt
          ,le.populated_region1_pcnt
          ,le.populated_region2_pcnt
          ,le.populated_region3_pcnt
          ,le.populated_region4_pcnt
          ,le.populated_region5_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_title_pcnt
          ,le.populated_ethnicity_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_addresscity_pcnt
          ,le.populated_addressstate_pcnt
          ,le.populated_addresszipcode_pcnt
          ,le.populated_addresszip4_pcnt
          ,le.populated_building_pcnt
          ,le.populated_contact_pcnt
          ,le.populated_phone1_pcnt
          ,le.populated_phone2_pcnt
          ,le.populated_phone3_pcnt
          ,le.populated_cell_pcnt
          ,le.populated_fax_pcnt
          ,le.populated_email1_pcnt
          ,le.populated_email2_pcnt
          ,le.populated_email3_pcnt
          ,le.populated_webpage1_pcnt
          ,le.populated_webpage2_pcnt
          ,le.populated_webpage3_pcnt
          ,le.populated_businessname_pcnt
          ,le.populated_dba_pcnt
          ,le.populated_businessid_pcnt
          ,le.populated_businesstype1_pcnt
          ,le.populated_businesslocation1_pcnt
          ,le.populated_businesstype2_pcnt
          ,le.populated_businesslocation2_pcnt
          ,le.populated_businesstype3_pcnt
          ,le.populated_businesslocation3_pcnt
          ,le.populated_businesstype4_pcnt
          ,le.populated_businesslocation4_pcnt
          ,le.populated_businesstype5_pcnt
          ,le.populated_businesslocation5_pcnt
          ,le.populated_industry_pcnt
          ,le.populated_trade_pcnt
          ,le.populated_resourcedescription_pcnt
          ,le.populated_natureofbusiness_pcnt
          ,le.populated_businessdescription_pcnt
          ,le.populated_businessstructure_pcnt
          ,le.populated_totalemployees_pcnt
          ,le.populated_avgcontractsize_pcnt
          ,le.populated_firmid_pcnt
          ,le.populated_firmlocationaddress_pcnt
          ,le.populated_firmlocationaddresscity_pcnt
          ,le.populated_firmlocationaddresszip4_pcnt
          ,le.populated_firmlocationaddresszipcode_pcnt
          ,le.populated_firmlocationcounty_pcnt
          ,le.populated_firmlocationstate_pcnt
          ,le.populated_certfed_pcnt
          ,le.populated_certstate_pcnt
          ,le.populated_contractsfederal_pcnt
          ,le.populated_contractsva_pcnt
          ,le.populated_contractscommercial_pcnt
          ,le.populated_contractorgovernmentprime_pcnt
          ,le.populated_contractorgovernmentsub_pcnt
          ,le.populated_contractornongovernment_pcnt
          ,le.populated_registeredgovernmentbus_pcnt
          ,le.populated_registerednongovernmentbus_pcnt
          ,le.populated_clearancelevelpersonnel_pcnt
          ,le.populated_clearancelevelfacility_pcnt
          ,le.populated_certificatedatefrom1_pcnt
          ,le.populated_certificatedateto1_pcnt
          ,le.populated_certificatestatus1_pcnt
          ,le.populated_certificationnumber1_pcnt
          ,le.populated_certificationtype1_pcnt
          ,le.populated_certificatedatefrom2_pcnt
          ,le.populated_certificatedateto2_pcnt
          ,le.populated_certificatestatus2_pcnt
          ,le.populated_certificationnumber2_pcnt
          ,le.populated_certificationtype2_pcnt
          ,le.populated_certificatedatefrom3_pcnt
          ,le.populated_certificatedateto3_pcnt
          ,le.populated_certificatestatus3_pcnt
          ,le.populated_certificationnumber3_pcnt
          ,le.populated_certificationtype3_pcnt
          ,le.populated_certificatedatefrom4_pcnt
          ,le.populated_certificatedateto4_pcnt
          ,le.populated_certificatestatus4_pcnt
          ,le.populated_certificationnumber4_pcnt
          ,le.populated_certificationtype4_pcnt
          ,le.populated_certificatedatefrom5_pcnt
          ,le.populated_certificatedateto5_pcnt
          ,le.populated_certificatestatus5_pcnt
          ,le.populated_certificationnumber5_pcnt
          ,le.populated_certificationtype5_pcnt
          ,le.populated_certificatedatefrom6_pcnt
          ,le.populated_certificatedateto6_pcnt
          ,le.populated_certificatestatus6_pcnt
          ,le.populated_certificationnumber6_pcnt
          ,le.populated_certificationtype6_pcnt
          ,le.populated_starrating_pcnt
          ,le.populated_assets_pcnt
          ,le.populated_biddescription_pcnt
          ,le.populated_competitiveadvantage_pcnt
          ,le.populated_cagecode_pcnt
          ,le.populated_capabilitiesnarrative_pcnt
          ,le.populated_category_pcnt
          ,le.populated_chtrclass_pcnt
          ,le.populated_productdescription1_pcnt
          ,le.populated_productdescription2_pcnt
          ,le.populated_productdescription3_pcnt
          ,le.populated_productdescription4_pcnt
          ,le.populated_productdescription5_pcnt
          ,le.populated_classdescription1_pcnt
          ,le.populated_subclassdescription1_pcnt
          ,le.populated_classdescription2_pcnt
          ,le.populated_subclassdescription2_pcnt
          ,le.populated_classdescription3_pcnt
          ,le.populated_subclassdescription3_pcnt
          ,le.populated_classdescription4_pcnt
          ,le.populated_subclassdescription4_pcnt
          ,le.populated_classdescription5_pcnt
          ,le.populated_subclassdescription5_pcnt
          ,le.populated_classifications_pcnt
          ,le.populated_commodity1_pcnt
          ,le.populated_commodity2_pcnt
          ,le.populated_commodity3_pcnt
          ,le.populated_commodity4_pcnt
          ,le.populated_commodity5_pcnt
          ,le.populated_commodity6_pcnt
          ,le.populated_commodity7_pcnt
          ,le.populated_commodity8_pcnt
          ,le.populated_completedate_pcnt
          ,le.populated_crossreference_pcnt
          ,le.populated_dateestablished_pcnt
          ,le.populated_businessage_pcnt
          ,le.populated_deposits_pcnt
          ,le.populated_dunsnumber_pcnt
          ,le.populated_enttype_pcnt
          ,le.populated_expirationdate_pcnt
          ,le.populated_extendeddate_pcnt
          ,le.populated_issuingauthority_pcnt
          ,le.populated_keywords_pcnt
          ,le.populated_licensenumber_pcnt
          ,le.populated_licensetype_pcnt
          ,le.populated_mincd_pcnt
          ,le.populated_minorityaffiliation_pcnt
          ,le.populated_minorityownershipdate_pcnt
          ,le.populated_siccode1_pcnt
          ,le.populated_siccode2_pcnt
          ,le.populated_siccode3_pcnt
          ,le.populated_siccode4_pcnt
          ,le.populated_siccode5_pcnt
          ,le.populated_siccode6_pcnt
          ,le.populated_siccode7_pcnt
          ,le.populated_siccode8_pcnt
          ,le.populated_naicscode1_pcnt
          ,le.populated_naicscode2_pcnt
          ,le.populated_naicscode3_pcnt
          ,le.populated_naicscode4_pcnt
          ,le.populated_naicscode5_pcnt
          ,le.populated_naicscode6_pcnt
          ,le.populated_naicscode7_pcnt
          ,le.populated_naicscode8_pcnt
          ,le.populated_prequalify_pcnt
          ,le.populated_procurementcategory1_pcnt
          ,le.populated_subprocurementcategory1_pcnt
          ,le.populated_procurementcategory2_pcnt
          ,le.populated_subprocurementcategory2_pcnt
          ,le.populated_procurementcategory3_pcnt
          ,le.populated_subprocurementcategory3_pcnt
          ,le.populated_procurementcategory4_pcnt
          ,le.populated_subprocurementcategory4_pcnt
          ,le.populated_procurementcategory5_pcnt
          ,le.populated_subprocurementcategory5_pcnt
          ,le.populated_renewal_pcnt
          ,le.populated_renewaldate_pcnt
          ,le.populated_unitedcertprogrampartner_pcnt
          ,le.populated_vendorkey_pcnt
          ,le.populated_vendornumber_pcnt
          ,le.populated_workcode1_pcnt
          ,le.populated_workcode2_pcnt
          ,le.populated_workcode3_pcnt
          ,le.populated_workcode4_pcnt
          ,le.populated_workcode5_pcnt
          ,le.populated_workcode6_pcnt
          ,le.populated_workcode7_pcnt
          ,le.populated_workcode8_pcnt
          ,le.populated_exporter_pcnt
          ,le.populated_exportbusinessactivities_pcnt
          ,le.populated_exportto_pcnt
          ,le.populated_exportbusinessrelationships_pcnt
          ,le.populated_exportobjectives_pcnt
          ,le.populated_reference1_pcnt
          ,le.populated_reference2_pcnt
          ,le.populated_reference3_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,205,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Diversity_Certification));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),205,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Diversity_Certification) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Diversity_Certification, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
