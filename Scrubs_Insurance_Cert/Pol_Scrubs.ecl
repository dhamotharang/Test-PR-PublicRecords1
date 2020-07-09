IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Pol_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 39;
  EXPORT NumRulesFromFieldType := 39;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 35;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Pol_Layout_Insurance_Cert)
    UNSIGNED1 date_firstseen_Invalid;
    UNSIGNED1 date_lastseen_Invalid;
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 insuranceprovider_Invalid;
    UNSIGNED1 policynumber_Invalid;
    UNSIGNED1 coveragestartdate_Invalid;
    UNSIGNED1 coverageexpirationdate_Invalid;
    UNSIGNED1 coveragewrapup_Invalid;
    UNSIGNED1 policystatus_Invalid;
    UNSIGNED1 insuranceprovideraddressline_Invalid;
    UNSIGNED1 insuranceprovideraddressline2_Invalid;
    UNSIGNED1 insuranceprovidercity_Invalid;
    UNSIGNED1 insuranceproviderstate_Invalid;
    UNSIGNED1 insuranceproviderzip_Invalid;
    UNSIGNED1 insuranceproviderzip4_Invalid;
    UNSIGNED1 insuranceproviderphone_Invalid;
    UNSIGNED1 insuranceproviderfax_Invalid;
    UNSIGNED1 coveragereinstatedate_Invalid;
    UNSIGNED1 coveragecancellationdate_Invalid;
    UNSIGNED1 coveragewrapupdate_Invalid;
    UNSIGNED1 businessnameduringcoverage_Invalid;
    UNSIGNED1 addresslineduringcoverage_Invalid;
    UNSIGNED1 addressline2duringcoverage_Invalid;
    UNSIGNED1 cityduringcoverage_Invalid;
    UNSIGNED1 stateduringcoverage_Invalid;
    UNSIGNED1 zipduringcoverage_Invalid;
    UNSIGNED1 zip4duringcoverage_Invalid;
    UNSIGNED1 numberofemployeesduringcoverage_Invalid;
    UNSIGNED1 insuranceprovidercontactdept_Invalid;
    UNSIGNED1 insurancetype_Invalid;
    UNSIGNED1 coverageposteddate_Invalid;
    UNSIGNED1 coverageamountfrom_Invalid;
    UNSIGNED1 coverageamountto_Invalid;
    UNSIGNED1 append_mailaddress1_Invalid;
    UNSIGNED1 append_mailaddresslast_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Pol_Layout_Insurance_Cert)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Pol_Layout_Insurance_Cert)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'date_firstseen:Invalid_Date:CUSTOM'
          ,'date_lastseen:Invalid_Date:CUSTOM'
          ,'dartid:Invalid_No:ALLOW'
          ,'insuranceprovider:Invalid_AlphaChar:CUSTOM'
          ,'policynumber:Invalid_AlphaNumChar:CUSTOM'
          ,'coveragestartdate:Invalid_Date:CUSTOM'
          ,'coverageexpirationdate:Invalid_Date:CUSTOM'
          ,'coveragewrapup:Invalid_Alpha:CUSTOM'
          ,'policystatus:Invalid_Alpha:CUSTOM'
          ,'insuranceprovideraddressline:Invalid_AlphaNum:CUSTOM'
          ,'insuranceprovideraddressline2:Invalid_AlphaNum:CUSTOM'
          ,'insuranceprovidercity:Invalid_AlphaChar:CUSTOM'
          ,'insuranceproviderstate:Invalid_State:LENGTHS'
          ,'insuranceproviderzip:Invalid_Zip:ALLOW','insuranceproviderzip:Invalid_Zip:LENGTHS'
          ,'insuranceproviderzip4:Invalid_No:ALLOW'
          ,'insuranceproviderphone:Invalid_Phone:ALLOW','insuranceproviderphone:Invalid_Phone:LENGTHS'
          ,'insuranceproviderfax:Invalid_Phone:ALLOW','insuranceproviderfax:Invalid_Phone:LENGTHS'
          ,'coveragereinstatedate:Invalid_Date:CUSTOM'
          ,'coveragecancellationdate:Invalid_Date:CUSTOM'
          ,'coveragewrapupdate:Invalid_Date:CUSTOM'
          ,'businessnameduringcoverage:Invalid_Alpha:CUSTOM'
          ,'addresslineduringcoverage:Invalid_AlphaNum:CUSTOM'
          ,'addressline2duringcoverage:Invalid_AlphaNum:CUSTOM'
          ,'cityduringcoverage:Invalid_AlphaChar:CUSTOM'
          ,'stateduringcoverage:Invalid_State:LENGTHS'
          ,'zipduringcoverage:Invalid_Zip:ALLOW','zipduringcoverage:Invalid_Zip:LENGTHS'
          ,'zip4duringcoverage:Invalid_No:ALLOW'
          ,'numberofemployeesduringcoverage:Invalid_AlphaNum:CUSTOM'
          ,'insuranceprovidercontactdept:Invalid_AlphaNumChar:CUSTOM'
          ,'insurancetype:Invalid_Alpha:CUSTOM'
          ,'coverageposteddate:Invalid_Date:CUSTOM'
          ,'coverageamountfrom:Invalid_No:ALLOW'
          ,'coverageamountto:Invalid_No:ALLOW'
          ,'append_mailaddress1:Invalid_AlphaNum:CUSTOM'
          ,'append_mailaddresslast:Invalid_AlphaNumChar:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Pol_Fields.InvalidMessage_date_firstseen(1)
          ,Pol_Fields.InvalidMessage_date_lastseen(1)
          ,Pol_Fields.InvalidMessage_dartid(1)
          ,Pol_Fields.InvalidMessage_insuranceprovider(1)
          ,Pol_Fields.InvalidMessage_policynumber(1)
          ,Pol_Fields.InvalidMessage_coveragestartdate(1)
          ,Pol_Fields.InvalidMessage_coverageexpirationdate(1)
          ,Pol_Fields.InvalidMessage_coveragewrapup(1)
          ,Pol_Fields.InvalidMessage_policystatus(1)
          ,Pol_Fields.InvalidMessage_insuranceprovideraddressline(1)
          ,Pol_Fields.InvalidMessage_insuranceprovideraddressline2(1)
          ,Pol_Fields.InvalidMessage_insuranceprovidercity(1)
          ,Pol_Fields.InvalidMessage_insuranceproviderstate(1)
          ,Pol_Fields.InvalidMessage_insuranceproviderzip(1),Pol_Fields.InvalidMessage_insuranceproviderzip(2)
          ,Pol_Fields.InvalidMessage_insuranceproviderzip4(1)
          ,Pol_Fields.InvalidMessage_insuranceproviderphone(1),Pol_Fields.InvalidMessage_insuranceproviderphone(2)
          ,Pol_Fields.InvalidMessage_insuranceproviderfax(1),Pol_Fields.InvalidMessage_insuranceproviderfax(2)
          ,Pol_Fields.InvalidMessage_coveragereinstatedate(1)
          ,Pol_Fields.InvalidMessage_coveragecancellationdate(1)
          ,Pol_Fields.InvalidMessage_coveragewrapupdate(1)
          ,Pol_Fields.InvalidMessage_businessnameduringcoverage(1)
          ,Pol_Fields.InvalidMessage_addresslineduringcoverage(1)
          ,Pol_Fields.InvalidMessage_addressline2duringcoverage(1)
          ,Pol_Fields.InvalidMessage_cityduringcoverage(1)
          ,Pol_Fields.InvalidMessage_stateduringcoverage(1)
          ,Pol_Fields.InvalidMessage_zipduringcoverage(1),Pol_Fields.InvalidMessage_zipduringcoverage(2)
          ,Pol_Fields.InvalidMessage_zip4duringcoverage(1)
          ,Pol_Fields.InvalidMessage_numberofemployeesduringcoverage(1)
          ,Pol_Fields.InvalidMessage_insuranceprovidercontactdept(1)
          ,Pol_Fields.InvalidMessage_insurancetype(1)
          ,Pol_Fields.InvalidMessage_coverageposteddate(1)
          ,Pol_Fields.InvalidMessage_coverageamountfrom(1)
          ,Pol_Fields.InvalidMessage_coverageamountto(1)
          ,Pol_Fields.InvalidMessage_append_mailaddress1(1)
          ,Pol_Fields.InvalidMessage_append_mailaddresslast(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Pol_Layout_Insurance_Cert) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.date_firstseen_Invalid := Pol_Fields.InValid_date_firstseen((SALT311.StrType)le.date_firstseen);
    SELF.date_lastseen_Invalid := Pol_Fields.InValid_date_lastseen((SALT311.StrType)le.date_lastseen);
    SELF.dartid_Invalid := Pol_Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.insuranceprovider_Invalid := Pol_Fields.InValid_insuranceprovider((SALT311.StrType)le.insuranceprovider);
    SELF.policynumber_Invalid := Pol_Fields.InValid_policynumber((SALT311.StrType)le.policynumber);
    SELF.coveragestartdate_Invalid := Pol_Fields.InValid_coveragestartdate((SALT311.StrType)le.coveragestartdate);
    SELF.coverageexpirationdate_Invalid := Pol_Fields.InValid_coverageexpirationdate((SALT311.StrType)le.coverageexpirationdate);
    SELF.coveragewrapup_Invalid := Pol_Fields.InValid_coveragewrapup((SALT311.StrType)le.coveragewrapup);
    SELF.policystatus_Invalid := Pol_Fields.InValid_policystatus((SALT311.StrType)le.policystatus);
    SELF.insuranceprovideraddressline_Invalid := Pol_Fields.InValid_insuranceprovideraddressline((SALT311.StrType)le.insuranceprovideraddressline);
    SELF.insuranceprovideraddressline2_Invalid := Pol_Fields.InValid_insuranceprovideraddressline2((SALT311.StrType)le.insuranceprovideraddressline2);
    SELF.insuranceprovidercity_Invalid := Pol_Fields.InValid_insuranceprovidercity((SALT311.StrType)le.insuranceprovidercity);
    SELF.insuranceproviderstate_Invalid := Pol_Fields.InValid_insuranceproviderstate((SALT311.StrType)le.insuranceproviderstate);
    SELF.insuranceproviderzip_Invalid := Pol_Fields.InValid_insuranceproviderzip((SALT311.StrType)le.insuranceproviderzip);
    SELF.insuranceproviderzip4_Invalid := Pol_Fields.InValid_insuranceproviderzip4((SALT311.StrType)le.insuranceproviderzip4);
    SELF.insuranceproviderphone_Invalid := Pol_Fields.InValid_insuranceproviderphone((SALT311.StrType)le.insuranceproviderphone);
    SELF.insuranceproviderfax_Invalid := Pol_Fields.InValid_insuranceproviderfax((SALT311.StrType)le.insuranceproviderfax);
    SELF.coveragereinstatedate_Invalid := Pol_Fields.InValid_coveragereinstatedate((SALT311.StrType)le.coveragereinstatedate);
    SELF.coveragecancellationdate_Invalid := Pol_Fields.InValid_coveragecancellationdate((SALT311.StrType)le.coveragecancellationdate);
    SELF.coveragewrapupdate_Invalid := Pol_Fields.InValid_coveragewrapupdate((SALT311.StrType)le.coveragewrapupdate);
    SELF.businessnameduringcoverage_Invalid := Pol_Fields.InValid_businessnameduringcoverage((SALT311.StrType)le.businessnameduringcoverage);
    SELF.addresslineduringcoverage_Invalid := Pol_Fields.InValid_addresslineduringcoverage((SALT311.StrType)le.addresslineduringcoverage);
    SELF.addressline2duringcoverage_Invalid := Pol_Fields.InValid_addressline2duringcoverage((SALT311.StrType)le.addressline2duringcoverage);
    SELF.cityduringcoverage_Invalid := Pol_Fields.InValid_cityduringcoverage((SALT311.StrType)le.cityduringcoverage);
    SELF.stateduringcoverage_Invalid := Pol_Fields.InValid_stateduringcoverage((SALT311.StrType)le.stateduringcoverage);
    SELF.zipduringcoverage_Invalid := Pol_Fields.InValid_zipduringcoverage((SALT311.StrType)le.zipduringcoverage);
    SELF.zip4duringcoverage_Invalid := Pol_Fields.InValid_zip4duringcoverage((SALT311.StrType)le.zip4duringcoverage);
    SELF.numberofemployeesduringcoverage_Invalid := Pol_Fields.InValid_numberofemployeesduringcoverage((SALT311.StrType)le.numberofemployeesduringcoverage);
    SELF.insuranceprovidercontactdept_Invalid := Pol_Fields.InValid_insuranceprovidercontactdept((SALT311.StrType)le.insuranceprovidercontactdept);
    SELF.insurancetype_Invalid := Pol_Fields.InValid_insurancetype((SALT311.StrType)le.insurancetype);
    SELF.coverageposteddate_Invalid := Pol_Fields.InValid_coverageposteddate((SALT311.StrType)le.coverageposteddate);
    SELF.coverageamountfrom_Invalid := Pol_Fields.InValid_coverageamountfrom((SALT311.StrType)le.coverageamountfrom);
    SELF.coverageamountto_Invalid := Pol_Fields.InValid_coverageamountto((SALT311.StrType)le.coverageamountto);
    SELF.append_mailaddress1_Invalid := Pol_Fields.InValid_append_mailaddress1((SALT311.StrType)le.append_mailaddress1);
    SELF.append_mailaddresslast_Invalid := Pol_Fields.InValid_append_mailaddresslast((SALT311.StrType)le.append_mailaddresslast);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Pol_Layout_Insurance_Cert);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_firstseen_Invalid << 0 ) + ( le.date_lastseen_Invalid << 1 ) + ( le.dartid_Invalid << 2 ) + ( le.insuranceprovider_Invalid << 3 ) + ( le.policynumber_Invalid << 4 ) + ( le.coveragestartdate_Invalid << 5 ) + ( le.coverageexpirationdate_Invalid << 6 ) + ( le.coveragewrapup_Invalid << 7 ) + ( le.policystatus_Invalid << 8 ) + ( le.insuranceprovideraddressline_Invalid << 9 ) + ( le.insuranceprovideraddressline2_Invalid << 10 ) + ( le.insuranceprovidercity_Invalid << 11 ) + ( le.insuranceproviderstate_Invalid << 12 ) + ( le.insuranceproviderzip_Invalid << 13 ) + ( le.insuranceproviderzip4_Invalid << 15 ) + ( le.insuranceproviderphone_Invalid << 16 ) + ( le.insuranceproviderfax_Invalid << 18 ) + ( le.coveragereinstatedate_Invalid << 20 ) + ( le.coveragecancellationdate_Invalid << 21 ) + ( le.coveragewrapupdate_Invalid << 22 ) + ( le.businessnameduringcoverage_Invalid << 23 ) + ( le.addresslineduringcoverage_Invalid << 24 ) + ( le.addressline2duringcoverage_Invalid << 25 ) + ( le.cityduringcoverage_Invalid << 26 ) + ( le.stateduringcoverage_Invalid << 27 ) + ( le.zipduringcoverage_Invalid << 28 ) + ( le.zip4duringcoverage_Invalid << 30 ) + ( le.numberofemployeesduringcoverage_Invalid << 31 ) + ( le.insuranceprovidercontactdept_Invalid << 32 ) + ( le.insurancetype_Invalid << 33 ) + ( le.coverageposteddate_Invalid << 34 ) + ( le.coverageamountfrom_Invalid << 35 ) + ( le.coverageamountto_Invalid << 36 ) + ( le.append_mailaddress1_Invalid << 37 ) + ( le.append_mailaddresslast_Invalid << 38 );
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
  EXPORT Infile := PROJECT(h,Pol_Layout_Insurance_Cert);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_firstseen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_lastseen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.insuranceprovider_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.policynumber_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.coveragestartdate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.coverageexpirationdate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.coveragewrapup_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.policystatus_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.insuranceprovideraddressline_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.insuranceprovideraddressline2_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.insuranceprovidercity_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.insuranceproviderstate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.insuranceproviderzip_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.insuranceproviderzip4_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.insuranceproviderphone_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.insuranceproviderfax_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.coveragereinstatedate_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.coveragecancellationdate_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.coveragewrapupdate_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.businessnameduringcoverage_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.addresslineduringcoverage_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.addressline2duringcoverage_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.cityduringcoverage_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.stateduringcoverage_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.zipduringcoverage_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.zip4duringcoverage_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.numberofemployeesduringcoverage_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.insuranceprovidercontactdept_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.insurancetype_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.coverageposteddate_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.coverageamountfrom_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.coverageamountto_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.append_mailaddress1_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.append_mailaddresslast_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_firstseen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_firstseen_Invalid=1);
    date_lastseen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_lastseen_Invalid=1);
    dartid_ALLOW_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    insuranceprovider_CUSTOM_ErrorCount := COUNT(GROUP,h.insuranceprovider_Invalid=1);
    policynumber_CUSTOM_ErrorCount := COUNT(GROUP,h.policynumber_Invalid=1);
    coveragestartdate_CUSTOM_ErrorCount := COUNT(GROUP,h.coveragestartdate_Invalid=1);
    coverageexpirationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.coverageexpirationdate_Invalid=1);
    coveragewrapup_CUSTOM_ErrorCount := COUNT(GROUP,h.coveragewrapup_Invalid=1);
    policystatus_CUSTOM_ErrorCount := COUNT(GROUP,h.policystatus_Invalid=1);
    insuranceprovideraddressline_CUSTOM_ErrorCount := COUNT(GROUP,h.insuranceprovideraddressline_Invalid=1);
    insuranceprovideraddressline2_CUSTOM_ErrorCount := COUNT(GROUP,h.insuranceprovideraddressline2_Invalid=1);
    insuranceprovidercity_CUSTOM_ErrorCount := COUNT(GROUP,h.insuranceprovidercity_Invalid=1);
    insuranceproviderstate_LENGTHS_ErrorCount := COUNT(GROUP,h.insuranceproviderstate_Invalid=1);
    insuranceproviderzip_ALLOW_ErrorCount := COUNT(GROUP,h.insuranceproviderzip_Invalid=1);
    insuranceproviderzip_LENGTHS_ErrorCount := COUNT(GROUP,h.insuranceproviderzip_Invalid=2);
    insuranceproviderzip_Total_ErrorCount := COUNT(GROUP,h.insuranceproviderzip_Invalid>0);
    insuranceproviderzip4_ALLOW_ErrorCount := COUNT(GROUP,h.insuranceproviderzip4_Invalid=1);
    insuranceproviderphone_ALLOW_ErrorCount := COUNT(GROUP,h.insuranceproviderphone_Invalid=1);
    insuranceproviderphone_LENGTHS_ErrorCount := COUNT(GROUP,h.insuranceproviderphone_Invalid=2);
    insuranceproviderphone_Total_ErrorCount := COUNT(GROUP,h.insuranceproviderphone_Invalid>0);
    insuranceproviderfax_ALLOW_ErrorCount := COUNT(GROUP,h.insuranceproviderfax_Invalid=1);
    insuranceproviderfax_LENGTHS_ErrorCount := COUNT(GROUP,h.insuranceproviderfax_Invalid=2);
    insuranceproviderfax_Total_ErrorCount := COUNT(GROUP,h.insuranceproviderfax_Invalid>0);
    coveragereinstatedate_CUSTOM_ErrorCount := COUNT(GROUP,h.coveragereinstatedate_Invalid=1);
    coveragecancellationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.coveragecancellationdate_Invalid=1);
    coveragewrapupdate_CUSTOM_ErrorCount := COUNT(GROUP,h.coveragewrapupdate_Invalid=1);
    businessnameduringcoverage_CUSTOM_ErrorCount := COUNT(GROUP,h.businessnameduringcoverage_Invalid=1);
    addresslineduringcoverage_CUSTOM_ErrorCount := COUNT(GROUP,h.addresslineduringcoverage_Invalid=1);
    addressline2duringcoverage_CUSTOM_ErrorCount := COUNT(GROUP,h.addressline2duringcoverage_Invalid=1);
    cityduringcoverage_CUSTOM_ErrorCount := COUNT(GROUP,h.cityduringcoverage_Invalid=1);
    stateduringcoverage_LENGTHS_ErrorCount := COUNT(GROUP,h.stateduringcoverage_Invalid=1);
    zipduringcoverage_ALLOW_ErrorCount := COUNT(GROUP,h.zipduringcoverage_Invalid=1);
    zipduringcoverage_LENGTHS_ErrorCount := COUNT(GROUP,h.zipduringcoverage_Invalid=2);
    zipduringcoverage_Total_ErrorCount := COUNT(GROUP,h.zipduringcoverage_Invalid>0);
    zip4duringcoverage_ALLOW_ErrorCount := COUNT(GROUP,h.zip4duringcoverage_Invalid=1);
    numberofemployeesduringcoverage_CUSTOM_ErrorCount := COUNT(GROUP,h.numberofemployeesduringcoverage_Invalid=1);
    insuranceprovidercontactdept_CUSTOM_ErrorCount := COUNT(GROUP,h.insuranceprovidercontactdept_Invalid=1);
    insurancetype_CUSTOM_ErrorCount := COUNT(GROUP,h.insurancetype_Invalid=1);
    coverageposteddate_CUSTOM_ErrorCount := COUNT(GROUP,h.coverageposteddate_Invalid=1);
    coverageamountfrom_ALLOW_ErrorCount := COUNT(GROUP,h.coverageamountfrom_Invalid=1);
    coverageamountto_ALLOW_ErrorCount := COUNT(GROUP,h.coverageamountto_Invalid=1);
    append_mailaddress1_CUSTOM_ErrorCount := COUNT(GROUP,h.append_mailaddress1_Invalid=1);
    append_mailaddresslast_CUSTOM_ErrorCount := COUNT(GROUP,h.append_mailaddresslast_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.date_firstseen_Invalid > 0 OR h.date_lastseen_Invalid > 0 OR h.dartid_Invalid > 0 OR h.insuranceprovider_Invalid > 0 OR h.policynumber_Invalid > 0 OR h.coveragestartdate_Invalid > 0 OR h.coverageexpirationdate_Invalid > 0 OR h.coveragewrapup_Invalid > 0 OR h.policystatus_Invalid > 0 OR h.insuranceprovideraddressline_Invalid > 0 OR h.insuranceprovideraddressline2_Invalid > 0 OR h.insuranceprovidercity_Invalid > 0 OR h.insuranceproviderstate_Invalid > 0 OR h.insuranceproviderzip_Invalid > 0 OR h.insuranceproviderzip4_Invalid > 0 OR h.insuranceproviderphone_Invalid > 0 OR h.insuranceproviderfax_Invalid > 0 OR h.coveragereinstatedate_Invalid > 0 OR h.coveragecancellationdate_Invalid > 0 OR h.coveragewrapupdate_Invalid > 0 OR h.businessnameduringcoverage_Invalid > 0 OR h.addresslineduringcoverage_Invalid > 0 OR h.addressline2duringcoverage_Invalid > 0 OR h.cityduringcoverage_Invalid > 0 OR h.stateduringcoverage_Invalid > 0 OR h.zipduringcoverage_Invalid > 0 OR h.zip4duringcoverage_Invalid > 0 OR h.numberofemployeesduringcoverage_Invalid > 0 OR h.insuranceprovidercontactdept_Invalid > 0 OR h.insurancetype_Invalid > 0 OR h.coverageposteddate_Invalid > 0 OR h.coverageamountfrom_Invalid > 0 OR h.coverageamountto_Invalid > 0 OR h.append_mailaddress1_Invalid > 0 OR h.append_mailaddresslast_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.date_firstseen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_lastseen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceprovider_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.policynumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragestartdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coverageexpirationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragewrapup_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.policystatus_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovideraddressline_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovideraddressline2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovidercity_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderzip_Total_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderphone_Total_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderfax_Total_ErrorCount > 0, 1, 0) + IF(le.coveragereinstatedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragecancellationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragewrapupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessnameduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addresslineduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addressline2duringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cityduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.stateduringcoverage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zipduringcoverage_Total_ErrorCount > 0, 1, 0) + IF(le.zip4duringcoverage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.numberofemployeesduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovidercontactdept_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insurancetype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coverageposteddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coverageamountfrom_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverageamountto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_mailaddress1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.append_mailaddresslast_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.date_firstseen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_lastseen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceprovider_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.policynumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragestartdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coverageexpirationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragewrapup_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.policystatus_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovideraddressline_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovideraddressline2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovidercity_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderzip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderphone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderfax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insuranceproviderfax_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coveragereinstatedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragecancellationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coveragewrapupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessnameduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addresslineduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addressline2duringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cityduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.stateduringcoverage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zipduringcoverage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipduringcoverage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4duringcoverage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.numberofemployeesduringcoverage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insuranceprovidercontactdept_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insurancetype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coverageposteddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coverageamountfrom_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverageamountto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_mailaddress1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.append_mailaddresslast_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_firstseen_Invalid,le.date_lastseen_Invalid,le.dartid_Invalid,le.insuranceprovider_Invalid,le.policynumber_Invalid,le.coveragestartdate_Invalid,le.coverageexpirationdate_Invalid,le.coveragewrapup_Invalid,le.policystatus_Invalid,le.insuranceprovideraddressline_Invalid,le.insuranceprovideraddressline2_Invalid,le.insuranceprovidercity_Invalid,le.insuranceproviderstate_Invalid,le.insuranceproviderzip_Invalid,le.insuranceproviderzip4_Invalid,le.insuranceproviderphone_Invalid,le.insuranceproviderfax_Invalid,le.coveragereinstatedate_Invalid,le.coveragecancellationdate_Invalid,le.coveragewrapupdate_Invalid,le.businessnameduringcoverage_Invalid,le.addresslineduringcoverage_Invalid,le.addressline2duringcoverage_Invalid,le.cityduringcoverage_Invalid,le.stateduringcoverage_Invalid,le.zipduringcoverage_Invalid,le.zip4duringcoverage_Invalid,le.numberofemployeesduringcoverage_Invalid,le.insuranceprovidercontactdept_Invalid,le.insurancetype_Invalid,le.coverageposteddate_Invalid,le.coverageamountfrom_Invalid,le.coverageamountto_Invalid,le.append_mailaddress1_Invalid,le.append_mailaddresslast_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Pol_Fields.InvalidMessage_date_firstseen(le.date_firstseen_Invalid),Pol_Fields.InvalidMessage_date_lastseen(le.date_lastseen_Invalid),Pol_Fields.InvalidMessage_dartid(le.dartid_Invalid),Pol_Fields.InvalidMessage_insuranceprovider(le.insuranceprovider_Invalid),Pol_Fields.InvalidMessage_policynumber(le.policynumber_Invalid),Pol_Fields.InvalidMessage_coveragestartdate(le.coveragestartdate_Invalid),Pol_Fields.InvalidMessage_coverageexpirationdate(le.coverageexpirationdate_Invalid),Pol_Fields.InvalidMessage_coveragewrapup(le.coveragewrapup_Invalid),Pol_Fields.InvalidMessage_policystatus(le.policystatus_Invalid),Pol_Fields.InvalidMessage_insuranceprovideraddressline(le.insuranceprovideraddressline_Invalid),Pol_Fields.InvalidMessage_insuranceprovideraddressline2(le.insuranceprovideraddressline2_Invalid),Pol_Fields.InvalidMessage_insuranceprovidercity(le.insuranceprovidercity_Invalid),Pol_Fields.InvalidMessage_insuranceproviderstate(le.insuranceproviderstate_Invalid),Pol_Fields.InvalidMessage_insuranceproviderzip(le.insuranceproviderzip_Invalid),Pol_Fields.InvalidMessage_insuranceproviderzip4(le.insuranceproviderzip4_Invalid),Pol_Fields.InvalidMessage_insuranceproviderphone(le.insuranceproviderphone_Invalid),Pol_Fields.InvalidMessage_insuranceproviderfax(le.insuranceproviderfax_Invalid),Pol_Fields.InvalidMessage_coveragereinstatedate(le.coveragereinstatedate_Invalid),Pol_Fields.InvalidMessage_coveragecancellationdate(le.coveragecancellationdate_Invalid),Pol_Fields.InvalidMessage_coveragewrapupdate(le.coveragewrapupdate_Invalid),Pol_Fields.InvalidMessage_businessnameduringcoverage(le.businessnameduringcoverage_Invalid),Pol_Fields.InvalidMessage_addresslineduringcoverage(le.addresslineduringcoverage_Invalid),Pol_Fields.InvalidMessage_addressline2duringcoverage(le.addressline2duringcoverage_Invalid),Pol_Fields.InvalidMessage_cityduringcoverage(le.cityduringcoverage_Invalid),Pol_Fields.InvalidMessage_stateduringcoverage(le.stateduringcoverage_Invalid),Pol_Fields.InvalidMessage_zipduringcoverage(le.zipduringcoverage_Invalid),Pol_Fields.InvalidMessage_zip4duringcoverage(le.zip4duringcoverage_Invalid),Pol_Fields.InvalidMessage_numberofemployeesduringcoverage(le.numberofemployeesduringcoverage_Invalid),Pol_Fields.InvalidMessage_insuranceprovidercontactdept(le.insuranceprovidercontactdept_Invalid),Pol_Fields.InvalidMessage_insurancetype(le.insurancetype_Invalid),Pol_Fields.InvalidMessage_coverageposteddate(le.coverageposteddate_Invalid),Pol_Fields.InvalidMessage_coverageamountfrom(le.coverageamountfrom_Invalid),Pol_Fields.InvalidMessage_coverageamountto(le.coverageamountto_Invalid),Pol_Fields.InvalidMessage_append_mailaddress1(le.append_mailaddress1_Invalid),Pol_Fields.InvalidMessage_append_mailaddresslast(le.append_mailaddresslast_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_firstseen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_lastseen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.insuranceprovider_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.policynumber_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coveragestartdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coverageexpirationdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coveragewrapup_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.policystatus_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insuranceprovideraddressline_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insuranceprovideraddressline2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insuranceprovidercity_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insuranceproviderstate_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.insuranceproviderzip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.insuranceproviderzip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.insuranceproviderphone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.insuranceproviderfax_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.coveragereinstatedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coveragecancellationdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coveragewrapupdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.businessnameduringcoverage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addresslineduringcoverage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addressline2duringcoverage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cityduringcoverage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.stateduringcoverage_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.zipduringcoverage_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4duringcoverage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.numberofemployeesduringcoverage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insuranceprovidercontactdept_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insurancetype_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coverageposteddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coverageamountfrom_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coverageamountto_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_mailaddress1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.append_mailaddresslast_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_firstseen','date_lastseen','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto','append_mailaddress1','append_mailaddresslast','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_No','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_Phone','Invalid_Phone','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNumChar','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.date_firstseen,(SALT311.StrType)le.date_lastseen,(SALT311.StrType)le.dartid,(SALT311.StrType)le.insuranceprovider,(SALT311.StrType)le.policynumber,(SALT311.StrType)le.coveragestartdate,(SALT311.StrType)le.coverageexpirationdate,(SALT311.StrType)le.coveragewrapup,(SALT311.StrType)le.policystatus,(SALT311.StrType)le.insuranceprovideraddressline,(SALT311.StrType)le.insuranceprovideraddressline2,(SALT311.StrType)le.insuranceprovidercity,(SALT311.StrType)le.insuranceproviderstate,(SALT311.StrType)le.insuranceproviderzip,(SALT311.StrType)le.insuranceproviderzip4,(SALT311.StrType)le.insuranceproviderphone,(SALT311.StrType)le.insuranceproviderfax,(SALT311.StrType)le.coveragereinstatedate,(SALT311.StrType)le.coveragecancellationdate,(SALT311.StrType)le.coveragewrapupdate,(SALT311.StrType)le.businessnameduringcoverage,(SALT311.StrType)le.addresslineduringcoverage,(SALT311.StrType)le.addressline2duringcoverage,(SALT311.StrType)le.cityduringcoverage,(SALT311.StrType)le.stateduringcoverage,(SALT311.StrType)le.zipduringcoverage,(SALT311.StrType)le.zip4duringcoverage,(SALT311.StrType)le.numberofemployeesduringcoverage,(SALT311.StrType)le.insuranceprovidercontactdept,(SALT311.StrType)le.insurancetype,(SALT311.StrType)le.coverageposteddate,(SALT311.StrType)le.coverageamountfrom,(SALT311.StrType)le.coverageamountto,(SALT311.StrType)le.append_mailaddress1,(SALT311.StrType)le.append_mailaddresslast,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,35,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Pol_Layout_Insurance_Cert) prevDS = DATASET([], Pol_Layout_Insurance_Cert), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.date_firstseen_CUSTOM_ErrorCount
          ,le.date_lastseen_CUSTOM_ErrorCount
          ,le.dartid_ALLOW_ErrorCount
          ,le.insuranceprovider_CUSTOM_ErrorCount
          ,le.policynumber_CUSTOM_ErrorCount
          ,le.coveragestartdate_CUSTOM_ErrorCount
          ,le.coverageexpirationdate_CUSTOM_ErrorCount
          ,le.coveragewrapup_CUSTOM_ErrorCount
          ,le.policystatus_CUSTOM_ErrorCount
          ,le.insuranceprovideraddressline_CUSTOM_ErrorCount
          ,le.insuranceprovideraddressline2_CUSTOM_ErrorCount
          ,le.insuranceprovidercity_CUSTOM_ErrorCount
          ,le.insuranceproviderstate_LENGTHS_ErrorCount
          ,le.insuranceproviderzip_ALLOW_ErrorCount,le.insuranceproviderzip_LENGTHS_ErrorCount
          ,le.insuranceproviderzip4_ALLOW_ErrorCount
          ,le.insuranceproviderphone_ALLOW_ErrorCount,le.insuranceproviderphone_LENGTHS_ErrorCount
          ,le.insuranceproviderfax_ALLOW_ErrorCount,le.insuranceproviderfax_LENGTHS_ErrorCount
          ,le.coveragereinstatedate_CUSTOM_ErrorCount
          ,le.coveragecancellationdate_CUSTOM_ErrorCount
          ,le.coveragewrapupdate_CUSTOM_ErrorCount
          ,le.businessnameduringcoverage_CUSTOM_ErrorCount
          ,le.addresslineduringcoverage_CUSTOM_ErrorCount
          ,le.addressline2duringcoverage_CUSTOM_ErrorCount
          ,le.cityduringcoverage_CUSTOM_ErrorCount
          ,le.stateduringcoverage_LENGTHS_ErrorCount
          ,le.zipduringcoverage_ALLOW_ErrorCount,le.zipduringcoverage_LENGTHS_ErrorCount
          ,le.zip4duringcoverage_ALLOW_ErrorCount
          ,le.numberofemployeesduringcoverage_CUSTOM_ErrorCount
          ,le.insuranceprovidercontactdept_CUSTOM_ErrorCount
          ,le.insurancetype_CUSTOM_ErrorCount
          ,le.coverageposteddate_CUSTOM_ErrorCount
          ,le.coverageamountfrom_ALLOW_ErrorCount
          ,le.coverageamountto_ALLOW_ErrorCount
          ,le.append_mailaddress1_CUSTOM_ErrorCount
          ,le.append_mailaddresslast_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.date_firstseen_CUSTOM_ErrorCount
          ,le.date_lastseen_CUSTOM_ErrorCount
          ,le.dartid_ALLOW_ErrorCount
          ,le.insuranceprovider_CUSTOM_ErrorCount
          ,le.policynumber_CUSTOM_ErrorCount
          ,le.coveragestartdate_CUSTOM_ErrorCount
          ,le.coverageexpirationdate_CUSTOM_ErrorCount
          ,le.coveragewrapup_CUSTOM_ErrorCount
          ,le.policystatus_CUSTOM_ErrorCount
          ,le.insuranceprovideraddressline_CUSTOM_ErrorCount
          ,le.insuranceprovideraddressline2_CUSTOM_ErrorCount
          ,le.insuranceprovidercity_CUSTOM_ErrorCount
          ,le.insuranceproviderstate_LENGTHS_ErrorCount
          ,le.insuranceproviderzip_ALLOW_ErrorCount,le.insuranceproviderzip_LENGTHS_ErrorCount
          ,le.insuranceproviderzip4_ALLOW_ErrorCount
          ,le.insuranceproviderphone_ALLOW_ErrorCount,le.insuranceproviderphone_LENGTHS_ErrorCount
          ,le.insuranceproviderfax_ALLOW_ErrorCount,le.insuranceproviderfax_LENGTHS_ErrorCount
          ,le.coveragereinstatedate_CUSTOM_ErrorCount
          ,le.coveragecancellationdate_CUSTOM_ErrorCount
          ,le.coveragewrapupdate_CUSTOM_ErrorCount
          ,le.businessnameduringcoverage_CUSTOM_ErrorCount
          ,le.addresslineduringcoverage_CUSTOM_ErrorCount
          ,le.addressline2duringcoverage_CUSTOM_ErrorCount
          ,le.cityduringcoverage_CUSTOM_ErrorCount
          ,le.stateduringcoverage_LENGTHS_ErrorCount
          ,le.zipduringcoverage_ALLOW_ErrorCount,le.zipduringcoverage_LENGTHS_ErrorCount
          ,le.zip4duringcoverage_ALLOW_ErrorCount
          ,le.numberofemployeesduringcoverage_CUSTOM_ErrorCount
          ,le.insuranceprovidercontactdept_CUSTOM_ErrorCount
          ,le.insurancetype_CUSTOM_ErrorCount
          ,le.coverageposteddate_CUSTOM_ErrorCount
          ,le.coverageamountfrom_ALLOW_ErrorCount
          ,le.coverageamountto_ALLOW_ErrorCount
          ,le.append_mailaddress1_CUSTOM_ErrorCount
          ,le.append_mailaddresslast_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Pol_hygiene(PROJECT(h, Pol_Layout_Insurance_Cert));
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
          ,'date_firstseen:' + getFieldTypeText(h.date_firstseen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_lastseen:' + getFieldTypeText(h.date_lastseen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lninscertrecordid:' + getFieldTypeText(h.lninscertrecordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dartid:' + getFieldTypeText(h.dartid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceprovider:' + getFieldTypeText(h.insuranceprovider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policynumber:' + getFieldTypeText(h.policynumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coveragestartdate:' + getFieldTypeText(h.coveragestartdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverageexpirationdate:' + getFieldTypeText(h.coverageexpirationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coveragewrapup:' + getFieldTypeText(h.coveragewrapup) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policystatus:' + getFieldTypeText(h.policystatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceprovideraddressline:' + getFieldTypeText(h.insuranceprovideraddressline) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceprovideraddressline2:' + getFieldTypeText(h.insuranceprovideraddressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceprovidercity:' + getFieldTypeText(h.insuranceprovidercity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceproviderstate:' + getFieldTypeText(h.insuranceproviderstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceproviderzip:' + getFieldTypeText(h.insuranceproviderzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceproviderzip4:' + getFieldTypeText(h.insuranceproviderzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceproviderphone:' + getFieldTypeText(h.insuranceproviderphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceproviderfax:' + getFieldTypeText(h.insuranceproviderfax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coveragereinstatedate:' + getFieldTypeText(h.coveragereinstatedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coveragecancellationdate:' + getFieldTypeText(h.coveragecancellationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coveragewrapupdate:' + getFieldTypeText(h.coveragewrapupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessnameduringcoverage:' + getFieldTypeText(h.businessnameduringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresslineduringcoverage:' + getFieldTypeText(h.addresslineduringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressline2duringcoverage:' + getFieldTypeText(h.addressline2duringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cityduringcoverage:' + getFieldTypeText(h.cityduringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stateduringcoverage:' + getFieldTypeText(h.stateduringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipduringcoverage:' + getFieldTypeText(h.zipduringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4duringcoverage:' + getFieldTypeText(h.zip4duringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'numberofemployeesduringcoverage:' + getFieldTypeText(h.numberofemployeesduringcoverage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuranceprovidercontactdept:' + getFieldTypeText(h.insuranceprovidercontactdept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insurancetype:' + getFieldTypeText(h.insurancetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverageposteddate:' + getFieldTypeText(h.coverageposteddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverageamountfrom:' + getFieldTypeText(h.coverageamountfrom) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverageamountto:' + getFieldTypeText(h.coverageamountto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unique_id:' + getFieldTypeText(h.unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_mailaddress1:' + getFieldTypeText(h.append_mailaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_mailaddresslast:' + getFieldTypeText(h.append_mailaddresslast) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_mailrawaid:' + getFieldTypeText(h.append_mailrawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_mailaceaid:' + getFieldTypeText(h.append_mailaceaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_date_firstseen_cnt
          ,le.populated_date_lastseen_cnt
          ,le.populated_bdid_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_lninscertrecordid_cnt
          ,le.populated_dartid_cnt
          ,le.populated_insuranceprovider_cnt
          ,le.populated_policynumber_cnt
          ,le.populated_coveragestartdate_cnt
          ,le.populated_coverageexpirationdate_cnt
          ,le.populated_coveragewrapup_cnt
          ,le.populated_policystatus_cnt
          ,le.populated_insuranceprovideraddressline_cnt
          ,le.populated_insuranceprovideraddressline2_cnt
          ,le.populated_insuranceprovidercity_cnt
          ,le.populated_insuranceproviderstate_cnt
          ,le.populated_insuranceproviderzip_cnt
          ,le.populated_insuranceproviderzip4_cnt
          ,le.populated_insuranceproviderphone_cnt
          ,le.populated_insuranceproviderfax_cnt
          ,le.populated_coveragereinstatedate_cnt
          ,le.populated_coveragecancellationdate_cnt
          ,le.populated_coveragewrapupdate_cnt
          ,le.populated_businessnameduringcoverage_cnt
          ,le.populated_addresslineduringcoverage_cnt
          ,le.populated_addressline2duringcoverage_cnt
          ,le.populated_cityduringcoverage_cnt
          ,le.populated_stateduringcoverage_cnt
          ,le.populated_zipduringcoverage_cnt
          ,le.populated_zip4duringcoverage_cnt
          ,le.populated_numberofemployeesduringcoverage_cnt
          ,le.populated_insuranceprovidercontactdept_cnt
          ,le.populated_insurancetype_cnt
          ,le.populated_coverageposteddate_cnt
          ,le.populated_coverageamountfrom_cnt
          ,le.populated_coverageamountto_cnt
          ,le.populated_unique_id_cnt
          ,le.populated_append_mailaddress1_cnt
          ,le.populated_append_mailaddresslast_cnt
          ,le.populated_append_mailrawaid_cnt
          ,le.populated_append_mailaceaid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_date_firstseen_pcnt
          ,le.populated_date_lastseen_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_lninscertrecordid_pcnt
          ,le.populated_dartid_pcnt
          ,le.populated_insuranceprovider_pcnt
          ,le.populated_policynumber_pcnt
          ,le.populated_coveragestartdate_pcnt
          ,le.populated_coverageexpirationdate_pcnt
          ,le.populated_coveragewrapup_pcnt
          ,le.populated_policystatus_pcnt
          ,le.populated_insuranceprovideraddressline_pcnt
          ,le.populated_insuranceprovideraddressline2_pcnt
          ,le.populated_insuranceprovidercity_pcnt
          ,le.populated_insuranceproviderstate_pcnt
          ,le.populated_insuranceproviderzip_pcnt
          ,le.populated_insuranceproviderzip4_pcnt
          ,le.populated_insuranceproviderphone_pcnt
          ,le.populated_insuranceproviderfax_pcnt
          ,le.populated_coveragereinstatedate_pcnt
          ,le.populated_coveragecancellationdate_pcnt
          ,le.populated_coveragewrapupdate_pcnt
          ,le.populated_businessnameduringcoverage_pcnt
          ,le.populated_addresslineduringcoverage_pcnt
          ,le.populated_addressline2duringcoverage_pcnt
          ,le.populated_cityduringcoverage_pcnt
          ,le.populated_stateduringcoverage_pcnt
          ,le.populated_zipduringcoverage_pcnt
          ,le.populated_zip4duringcoverage_pcnt
          ,le.populated_numberofemployeesduringcoverage_pcnt
          ,le.populated_insuranceprovidercontactdept_pcnt
          ,le.populated_insurancetype_pcnt
          ,le.populated_coverageposteddate_pcnt
          ,le.populated_coverageamountfrom_pcnt
          ,le.populated_coverageamountto_pcnt
          ,le.populated_unique_id_pcnt
          ,le.populated_append_mailaddress1_pcnt
          ,le.populated_append_mailaddresslast_pcnt
          ,le.populated_append_mailrawaid_pcnt
          ,le.populated_append_mailaceaid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,61,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Pol_Delta(prevDS, PROJECT(h, Pol_Layout_Insurance_Cert));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),61,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Pol_Layout_Insurance_Cert) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Insurance_Cert, Pol_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
