IMPORT SALT311,STD;
EXPORT CourtLocator_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 22;
  EXPORT NumRulesFromFieldType := 22;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 22;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(CourtLocator_Layout_Vendor_Src)
    UNSIGNED1 fipscode_Invalid;
    UNSIGNED1 statefips_Invalid;
    UNSIGNED1 countyfips_Invalid;
    UNSIGNED1 courtid_Invalid;
    UNSIGNED1 consolidatedcourtid_Invalid;
    UNSIGNED1 masterid_Invalid;
    UNSIGNED1 stateofservice_Invalid;
    UNSIGNED1 countyofservice_Invalid;
    UNSIGNED1 courtname_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 mailaddress1_Invalid;
    UNSIGNED1 mailaddress2_Invalid;
    UNSIGNED1 mailcity_Invalid;
    UNSIGNED1 mailctate_Invalid;
    UNSIGNED1 mailzipcode_Invalid;
    UNSIGNED1 mailzip4_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CourtLocator_Layout_Vendor_Src)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(CourtLocator_Layout_Vendor_Src) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fipscode_Invalid := CourtLocator_Fields.InValid_fipscode((SALT311.StrType)le.fipscode);
    SELF.statefips_Invalid := CourtLocator_Fields.InValid_statefips((SALT311.StrType)le.statefips);
    SELF.countyfips_Invalid := CourtLocator_Fields.InValid_countyfips((SALT311.StrType)le.countyfips);
    SELF.courtid_Invalid := CourtLocator_Fields.InValid_courtid((SALT311.StrType)le.courtid);
    SELF.consolidatedcourtid_Invalid := CourtLocator_Fields.InValid_consolidatedcourtid((SALT311.StrType)le.consolidatedcourtid);
    SELF.masterid_Invalid := CourtLocator_Fields.InValid_masterid((SALT311.StrType)le.masterid);
    SELF.stateofservice_Invalid := CourtLocator_Fields.InValid_stateofservice((SALT311.StrType)le.stateofservice);
    SELF.countyofservice_Invalid := CourtLocator_Fields.InValid_countyofservice((SALT311.StrType)le.countyofservice);
    SELF.courtname_Invalid := CourtLocator_Fields.InValid_courtname((SALT311.StrType)le.courtname);
    SELF.phone_Invalid := CourtLocator_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.address1_Invalid := CourtLocator_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := CourtLocator_Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.city_Invalid := CourtLocator_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := CourtLocator_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zipcode_Invalid := CourtLocator_Fields.InValid_zipcode((SALT311.StrType)le.zipcode);
    SELF.zip4_Invalid := CourtLocator_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.mailaddress1_Invalid := CourtLocator_Fields.InValid_mailaddress1((SALT311.StrType)le.mailaddress1);
    SELF.mailaddress2_Invalid := CourtLocator_Fields.InValid_mailaddress2((SALT311.StrType)le.mailaddress2);
    SELF.mailcity_Invalid := CourtLocator_Fields.InValid_mailcity((SALT311.StrType)le.mailcity);
    SELF.mailctate_Invalid := CourtLocator_Fields.InValid_mailctate((SALT311.StrType)le.mailctate);
    SELF.mailzipcode_Invalid := CourtLocator_Fields.InValid_mailzipcode((SALT311.StrType)le.mailzipcode);
    SELF.mailzip4_Invalid := CourtLocator_Fields.InValid_mailzip4((SALT311.StrType)le.mailzip4);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),CourtLocator_Layout_Vendor_Src);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fipscode_Invalid << 0 ) + ( le.statefips_Invalid << 1 ) + ( le.countyfips_Invalid << 2 ) + ( le.courtid_Invalid << 3 ) + ( le.consolidatedcourtid_Invalid << 4 ) + ( le.masterid_Invalid << 5 ) + ( le.stateofservice_Invalid << 6 ) + ( le.countyofservice_Invalid << 7 ) + ( le.courtname_Invalid << 8 ) + ( le.phone_Invalid << 9 ) + ( le.address1_Invalid << 10 ) + ( le.address2_Invalid << 11 ) + ( le.city_Invalid << 12 ) + ( le.state_Invalid << 13 ) + ( le.zipcode_Invalid << 14 ) + ( le.zip4_Invalid << 15 ) + ( le.mailaddress1_Invalid << 16 ) + ( le.mailaddress2_Invalid << 17 ) + ( le.mailcity_Invalid << 18 ) + ( le.mailctate_Invalid << 19 ) + ( le.mailzipcode_Invalid << 20 ) + ( le.mailzip4_Invalid << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,CourtLocator_Layout_Vendor_Src);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fipscode_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statefips_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.countyfips_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.courtid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.consolidatedcourtid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.masterid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.stateofservice_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.countyofservice_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.courtname_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mailaddress1_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.mailaddress2_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.mailcity_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.mailctate_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.mailzipcode_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.mailzip4_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fipscode_ALLOW_ErrorCount := COUNT(GROUP,h.fipscode_Invalid=1);
    statefips_ALLOW_ErrorCount := COUNT(GROUP,h.statefips_Invalid=1);
    countyfips_ALLOW_ErrorCount := COUNT(GROUP,h.countyfips_Invalid=1);
    courtid_ALLOW_ErrorCount := COUNT(GROUP,h.courtid_Invalid=1);
    consolidatedcourtid_ALLOW_ErrorCount := COUNT(GROUP,h.consolidatedcourtid_Invalid=1);
    masterid_ALLOW_ErrorCount := COUNT(GROUP,h.masterid_Invalid=1);
    stateofservice_ALLOW_ErrorCount := COUNT(GROUP,h.stateofservice_Invalid=1);
    countyofservice_ALLOW_ErrorCount := COUNT(GROUP,h.countyofservice_Invalid=1);
    courtname_ALLOW_ErrorCount := COUNT(GROUP,h.courtname_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    address1_ALLOW_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address2_ALLOW_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    mailaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.mailaddress1_Invalid=1);
    mailaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.mailaddress2_Invalid=1);
    mailcity_ALLOW_ErrorCount := COUNT(GROUP,h.mailcity_Invalid=1);
    mailctate_ALLOW_ErrorCount := COUNT(GROUP,h.mailctate_Invalid=1);
    mailzipcode_ALLOW_ErrorCount := COUNT(GROUP,h.mailzipcode_Invalid=1);
    mailzip4_ALLOW_ErrorCount := COUNT(GROUP,h.mailzip4_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.fipscode_Invalid > 0 OR h.statefips_Invalid > 0 OR h.countyfips_Invalid > 0 OR h.courtid_Invalid > 0 OR h.consolidatedcourtid_Invalid > 0 OR h.masterid_Invalid > 0 OR h.stateofservice_Invalid > 0 OR h.countyofservice_Invalid > 0 OR h.courtname_Invalid > 0 OR h.phone_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.zip4_Invalid > 0 OR h.mailaddress1_Invalid > 0 OR h.mailaddress2_Invalid > 0 OR h.mailcity_Invalid > 0 OR h.mailctate_Invalid > 0 OR h.mailzipcode_Invalid > 0 OR h.mailzip4_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.fipscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statefips_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countyfips_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.consolidatedcourtid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.masterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.stateofservice_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countyofservice_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailctate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailzipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailzip4_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.fipscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statefips_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countyfips_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.consolidatedcourtid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.masterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.stateofservice_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countyofservice_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailctate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailzipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailzip4_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.fipscode_Invalid,le.statefips_Invalid,le.countyfips_Invalid,le.courtid_Invalid,le.consolidatedcourtid_Invalid,le.masterid_Invalid,le.stateofservice_Invalid,le.countyofservice_Invalid,le.courtname_Invalid,le.phone_Invalid,le.address1_Invalid,le.address2_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.zip4_Invalid,le.mailaddress1_Invalid,le.mailaddress2_Invalid,le.mailcity_Invalid,le.mailctate_Invalid,le.mailzipcode_Invalid,le.mailzip4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CourtLocator_Fields.InvalidMessage_fipscode(le.fipscode_Invalid),CourtLocator_Fields.InvalidMessage_statefips(le.statefips_Invalid),CourtLocator_Fields.InvalidMessage_countyfips(le.countyfips_Invalid),CourtLocator_Fields.InvalidMessage_courtid(le.courtid_Invalid),CourtLocator_Fields.InvalidMessage_consolidatedcourtid(le.consolidatedcourtid_Invalid),CourtLocator_Fields.InvalidMessage_masterid(le.masterid_Invalid),CourtLocator_Fields.InvalidMessage_stateofservice(le.stateofservice_Invalid),CourtLocator_Fields.InvalidMessage_countyofservice(le.countyofservice_Invalid),CourtLocator_Fields.InvalidMessage_courtname(le.courtname_Invalid),CourtLocator_Fields.InvalidMessage_phone(le.phone_Invalid),CourtLocator_Fields.InvalidMessage_address1(le.address1_Invalid),CourtLocator_Fields.InvalidMessage_address2(le.address2_Invalid),CourtLocator_Fields.InvalidMessage_city(le.city_Invalid),CourtLocator_Fields.InvalidMessage_state(le.state_Invalid),CourtLocator_Fields.InvalidMessage_zipcode(le.zipcode_Invalid),CourtLocator_Fields.InvalidMessage_zip4(le.zip4_Invalid),CourtLocator_Fields.InvalidMessage_mailaddress1(le.mailaddress1_Invalid),CourtLocator_Fields.InvalidMessage_mailaddress2(le.mailaddress2_Invalid),CourtLocator_Fields.InvalidMessage_mailcity(le.mailcity_Invalid),CourtLocator_Fields.InvalidMessage_mailctate(le.mailctate_Invalid),CourtLocator_Fields.InvalidMessage_mailzipcode(le.mailzipcode_Invalid),CourtLocator_Fields.InvalidMessage_mailzip4(le.mailzip4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fipscode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statefips_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.countyfips_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.courtid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.consolidatedcourtid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.masterid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.stateofservice_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.countyofservice_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.courtname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailaddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailaddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailctate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailzipcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailzip4_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.fipscode,(SALT311.StrType)le.statefips,(SALT311.StrType)le.countyfips,(SALT311.StrType)le.courtid,(SALT311.StrType)le.consolidatedcourtid,(SALT311.StrType)le.masterid,(SALT311.StrType)le.stateofservice,(SALT311.StrType)le.countyofservice,(SALT311.StrType)le.courtname,(SALT311.StrType)le.phone,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zipcode,(SALT311.StrType)le.zip4,(SALT311.StrType)le.mailaddress1,(SALT311.StrType)le.mailaddress2,(SALT311.StrType)le.mailcity,(SALT311.StrType)le.mailctate,(SALT311.StrType)le.mailzipcode,(SALT311.StrType)le.mailzip4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(CourtLocator_Layout_Vendor_Src) prevDS = DATASET([], CourtLocator_Layout_Vendor_Src), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'fipscode:fipscode:ALLOW'
          ,'statefips:statefips:ALLOW'
          ,'countyfips:countyfips:ALLOW'
          ,'courtid:courtid:ALLOW'
          ,'consolidatedcourtid:consolidatedcourtid:ALLOW'
          ,'masterid:masterid:ALLOW'
          ,'stateofservice:stateofservice:ALLOW'
          ,'countyofservice:countyofservice:ALLOW'
          ,'courtname:courtname:ALLOW'
          ,'phone:phone:ALLOW'
          ,'address1:address1:ALLOW'
          ,'address2:address2:ALLOW'
          ,'city:city:ALLOW'
          ,'state:state:ALLOW'
          ,'zipcode:zipcode:ALLOW'
          ,'zip4:zip4:ALLOW'
          ,'mailaddress1:mailaddress1:ALLOW'
          ,'mailaddress2:mailaddress2:ALLOW'
          ,'mailcity:mailcity:ALLOW'
          ,'mailctate:mailctate:ALLOW'
          ,'mailzipcode:mailzipcode:ALLOW'
          ,'mailzip4:mailzip4:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,CourtLocator_Fields.InvalidMessage_fipscode(1)
          ,CourtLocator_Fields.InvalidMessage_statefips(1)
          ,CourtLocator_Fields.InvalidMessage_countyfips(1)
          ,CourtLocator_Fields.InvalidMessage_courtid(1)
          ,CourtLocator_Fields.InvalidMessage_consolidatedcourtid(1)
          ,CourtLocator_Fields.InvalidMessage_masterid(1)
          ,CourtLocator_Fields.InvalidMessage_stateofservice(1)
          ,CourtLocator_Fields.InvalidMessage_countyofservice(1)
          ,CourtLocator_Fields.InvalidMessage_courtname(1)
          ,CourtLocator_Fields.InvalidMessage_phone(1)
          ,CourtLocator_Fields.InvalidMessage_address1(1)
          ,CourtLocator_Fields.InvalidMessage_address2(1)
          ,CourtLocator_Fields.InvalidMessage_city(1)
          ,CourtLocator_Fields.InvalidMessage_state(1)
          ,CourtLocator_Fields.InvalidMessage_zipcode(1)
          ,CourtLocator_Fields.InvalidMessage_zip4(1)
          ,CourtLocator_Fields.InvalidMessage_mailaddress1(1)
          ,CourtLocator_Fields.InvalidMessage_mailaddress2(1)
          ,CourtLocator_Fields.InvalidMessage_mailcity(1)
          ,CourtLocator_Fields.InvalidMessage_mailctate(1)
          ,CourtLocator_Fields.InvalidMessage_mailzipcode(1)
          ,CourtLocator_Fields.InvalidMessage_mailzip4(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fipscode_ALLOW_ErrorCount
          ,le.statefips_ALLOW_ErrorCount
          ,le.countyfips_ALLOW_ErrorCount
          ,le.courtid_ALLOW_ErrorCount
          ,le.consolidatedcourtid_ALLOW_ErrorCount
          ,le.masterid_ALLOW_ErrorCount
          ,le.stateofservice_ALLOW_ErrorCount
          ,le.countyofservice_ALLOW_ErrorCount
          ,le.courtname_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.mailaddress1_ALLOW_ErrorCount
          ,le.mailaddress2_ALLOW_ErrorCount
          ,le.mailcity_ALLOW_ErrorCount
          ,le.mailctate_ALLOW_ErrorCount
          ,le.mailzipcode_ALLOW_ErrorCount
          ,le.mailzip4_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.fipscode_ALLOW_ErrorCount
          ,le.statefips_ALLOW_ErrorCount
          ,le.countyfips_ALLOW_ErrorCount
          ,le.courtid_ALLOW_ErrorCount
          ,le.consolidatedcourtid_ALLOW_ErrorCount
          ,le.masterid_ALLOW_ErrorCount
          ,le.stateofservice_ALLOW_ErrorCount
          ,le.countyofservice_ALLOW_ErrorCount
          ,le.courtname_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.mailaddress1_ALLOW_ErrorCount
          ,le.mailaddress2_ALLOW_ErrorCount
          ,le.mailcity_ALLOW_ErrorCount
          ,le.mailctate_ALLOW_ErrorCount
          ,le.mailzipcode_ALLOW_ErrorCount
          ,le.mailzip4_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := CourtLocator_hygiene(PROJECT(h, CourtLocator_Layout_Vendor_Src));
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
          ,'fipscode:' + getFieldTypeText(h.fipscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statefips:' + getFieldTypeText(h.statefips) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countyfips:' + getFieldTypeText(h.countyfips) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtid:' + getFieldTypeText(h.courtid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consolidatedcourtid:' + getFieldTypeText(h.consolidatedcourtid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'masterid:' + getFieldTypeText(h.masterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stateofservice:' + getFieldTypeText(h.stateofservice) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countyofservice:' + getFieldTypeText(h.countyofservice) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtname:' + getFieldTypeText(h.courtname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailaddress1:' + getFieldTypeText(h.mailaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailaddress2:' + getFieldTypeText(h.mailaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailcity:' + getFieldTypeText(h.mailcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailctate:' + getFieldTypeText(h.mailctate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailzipcode:' + getFieldTypeText(h.mailzipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailzip4:' + getFieldTypeText(h.mailzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_fipscode_cnt
          ,le.populated_statefips_cnt
          ,le.populated_countyfips_cnt
          ,le.populated_courtid_cnt
          ,le.populated_consolidatedcourtid_cnt
          ,le.populated_masterid_cnt
          ,le.populated_stateofservice_cnt
          ,le.populated_countyofservice_cnt
          ,le.populated_courtname_cnt
          ,le.populated_phone_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_zip4_cnt
          ,le.populated_mailaddress1_cnt
          ,le.populated_mailaddress2_cnt
          ,le.populated_mailcity_cnt
          ,le.populated_mailctate_cnt
          ,le.populated_mailzipcode_cnt
          ,le.populated_mailzip4_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_fipscode_pcnt
          ,le.populated_statefips_pcnt
          ,le.populated_countyfips_pcnt
          ,le.populated_courtid_pcnt
          ,le.populated_consolidatedcourtid_pcnt
          ,le.populated_masterid_pcnt
          ,le.populated_stateofservice_pcnt
          ,le.populated_countyofservice_pcnt
          ,le.populated_courtname_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_mailaddress1_pcnt
          ,le.populated_mailaddress2_pcnt
          ,le.populated_mailcity_pcnt
          ,le.populated_mailctate_pcnt
          ,le.populated_mailzipcode_pcnt
          ,le.populated_mailzip4_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := CourtLocator_Delta(prevDS, PROJECT(h, CourtLocator_Layout_Vendor_Src));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(CourtLocator_Layout_Vendor_Src) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Vendor_Src, CourtLocator_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
