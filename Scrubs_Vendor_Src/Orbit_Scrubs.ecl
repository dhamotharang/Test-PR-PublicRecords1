IMPORT SALT311,STD;
EXPORT Orbit_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 22;
  EXPORT NumRulesFromFieldType := 22;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 22;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Orbit_Layout_Vendor_Src)
    UNSIGNED1 item_id_Invalid;
    UNSIGNED1 item_name_Invalid;
    UNSIGNED1 item_description_Invalid;
    UNSIGNED1 status_name_Invalid;
    UNSIGNED1 item_source_code_Invalid;
    UNSIGNED1 source_id_Invalid;
    UNSIGNED1 source_name_Invalid;
    UNSIGNED1 source_address1_Invalid;
    UNSIGNED1 source_address2_Invalid;
    UNSIGNED1 source_city_Invalid;
    UNSIGNED1 source_state_Invalid;
    UNSIGNED1 source_zip_Invalid;
    UNSIGNED1 source_phone_Invalid;
    UNSIGNED1 source_website_Invalid;
    UNSIGNED1 unused_source_sourcecodes_Invalid;
    UNSIGNED1 unused_fcra_Invalid;
    UNSIGNED1 unused_fcra_comments_Invalid;
    UNSIGNED1 market_restrict_flag_Invalid;
    UNSIGNED1 unused_market_comments_Invalid;
    UNSIGNED1 unused_contact_name_Invalid;
    UNSIGNED1 unused_contact_phone_Invalid;
    UNSIGNED1 unused_contact_email_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Orbit_Layout_Vendor_Src)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Orbit_Layout_Vendor_Src) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.item_id_Invalid := Orbit_Fields.InValid_item_id((SALT311.StrType)le.item_id);
    SELF.item_name_Invalid := Orbit_Fields.InValid_item_name((SALT311.StrType)le.item_name);
    SELF.item_description_Invalid := Orbit_Fields.InValid_item_description((SALT311.StrType)le.item_description);
    SELF.status_name_Invalid := Orbit_Fields.InValid_status_name((SALT311.StrType)le.status_name);
    SELF.item_source_code_Invalid := Orbit_Fields.InValid_item_source_code((SALT311.StrType)le.item_source_code);
    SELF.source_id_Invalid := Orbit_Fields.InValid_source_id((SALT311.StrType)le.source_id);
    SELF.source_name_Invalid := Orbit_Fields.InValid_source_name((SALT311.StrType)le.source_name);
    SELF.source_address1_Invalid := Orbit_Fields.InValid_source_address1((SALT311.StrType)le.source_address1);
    SELF.source_address2_Invalid := Orbit_Fields.InValid_source_address2((SALT311.StrType)le.source_address2);
    SELF.source_city_Invalid := Orbit_Fields.InValid_source_city((SALT311.StrType)le.source_city);
    SELF.source_state_Invalid := Orbit_Fields.InValid_source_state((SALT311.StrType)le.source_state);
    SELF.source_zip_Invalid := Orbit_Fields.InValid_source_zip((SALT311.StrType)le.source_zip);
    SELF.source_phone_Invalid := Orbit_Fields.InValid_source_phone((SALT311.StrType)le.source_phone);
    SELF.source_website_Invalid := Orbit_Fields.InValid_source_website((SALT311.StrType)le.source_website);
    SELF.unused_source_sourcecodes_Invalid := Orbit_Fields.InValid_unused_source_sourcecodes((SALT311.StrType)le.unused_source_sourcecodes);
    SELF.unused_fcra_Invalid := Orbit_Fields.InValid_unused_fcra((SALT311.StrType)le.unused_fcra);
    SELF.unused_fcra_comments_Invalid := Orbit_Fields.InValid_unused_fcra_comments((SALT311.StrType)le.unused_fcra_comments);
    SELF.market_restrict_flag_Invalid := Orbit_Fields.InValid_market_restrict_flag((SALT311.StrType)le.market_restrict_flag);
    SELF.unused_market_comments_Invalid := Orbit_Fields.InValid_unused_market_comments((SALT311.StrType)le.unused_market_comments);
    SELF.unused_contact_name_Invalid := Orbit_Fields.InValid_unused_contact_name((SALT311.StrType)le.unused_contact_name);
    SELF.unused_contact_phone_Invalid := Orbit_Fields.InValid_unused_contact_phone((SALT311.StrType)le.unused_contact_phone);
    SELF.unused_contact_email_Invalid := Orbit_Fields.InValid_unused_contact_email((SALT311.StrType)le.unused_contact_email);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Orbit_Layout_Vendor_Src);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.item_id_Invalid << 0 ) + ( le.item_name_Invalid << 1 ) + ( le.item_description_Invalid << 2 ) + ( le.status_name_Invalid << 3 ) + ( le.item_source_code_Invalid << 4 ) + ( le.source_id_Invalid << 5 ) + ( le.source_name_Invalid << 6 ) + ( le.source_address1_Invalid << 7 ) + ( le.source_address2_Invalid << 8 ) + ( le.source_city_Invalid << 9 ) + ( le.source_state_Invalid << 10 ) + ( le.source_zip_Invalid << 11 ) + ( le.source_phone_Invalid << 12 ) + ( le.source_website_Invalid << 13 ) + ( le.unused_source_sourcecodes_Invalid << 14 ) + ( le.unused_fcra_Invalid << 15 ) + ( le.unused_fcra_comments_Invalid << 16 ) + ( le.market_restrict_flag_Invalid << 17 ) + ( le.unused_market_comments_Invalid << 18 ) + ( le.unused_contact_name_Invalid << 19 ) + ( le.unused_contact_phone_Invalid << 20 ) + ( le.unused_contact_email_Invalid << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Orbit_Layout_Vendor_Src);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.item_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.item_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.item_description_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.status_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.item_source_code_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.source_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.source_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.source_address1_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.source_address2_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.source_city_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.source_state_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.source_zip_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.source_phone_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.source_website_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.unused_source_sourcecodes_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.unused_fcra_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.unused_fcra_comments_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.market_restrict_flag_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.unused_market_comments_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.unused_contact_name_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.unused_contact_phone_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.unused_contact_email_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    item_id_ALLOW_ErrorCount := COUNT(GROUP,h.item_id_Invalid=1);
    item_name_ALLOW_ErrorCount := COUNT(GROUP,h.item_name_Invalid=1);
    item_description_ALLOW_ErrorCount := COUNT(GROUP,h.item_description_Invalid=1);
    status_name_ALLOW_ErrorCount := COUNT(GROUP,h.status_name_Invalid=1);
    item_source_code_ALLOW_ErrorCount := COUNT(GROUP,h.item_source_code_Invalid=1);
    source_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_id_Invalid=1);
    source_name_ALLOW_ErrorCount := COUNT(GROUP,h.source_name_Invalid=1);
    source_address1_ALLOW_ErrorCount := COUNT(GROUP,h.source_address1_Invalid=1);
    source_address2_ALLOW_ErrorCount := COUNT(GROUP,h.source_address2_Invalid=1);
    source_city_ALLOW_ErrorCount := COUNT(GROUP,h.source_city_Invalid=1);
    source_state_ALLOW_ErrorCount := COUNT(GROUP,h.source_state_Invalid=1);
    source_zip_ALLOW_ErrorCount := COUNT(GROUP,h.source_zip_Invalid=1);
    source_phone_ALLOW_ErrorCount := COUNT(GROUP,h.source_phone_Invalid=1);
    source_website_ALLOW_ErrorCount := COUNT(GROUP,h.source_website_Invalid=1);
    unused_source_sourcecodes_ALLOW_ErrorCount := COUNT(GROUP,h.unused_source_sourcecodes_Invalid=1);
    unused_fcra_ALLOW_ErrorCount := COUNT(GROUP,h.unused_fcra_Invalid=1);
    unused_fcra_comments_ALLOW_ErrorCount := COUNT(GROUP,h.unused_fcra_comments_Invalid=1);
    market_restrict_flag_ALLOW_ErrorCount := COUNT(GROUP,h.market_restrict_flag_Invalid=1);
    unused_market_comments_ALLOW_ErrorCount := COUNT(GROUP,h.unused_market_comments_Invalid=1);
    unused_contact_name_ALLOW_ErrorCount := COUNT(GROUP,h.unused_contact_name_Invalid=1);
    unused_contact_phone_ALLOW_ErrorCount := COUNT(GROUP,h.unused_contact_phone_Invalid=1);
    unused_contact_email_ALLOW_ErrorCount := COUNT(GROUP,h.unused_contact_email_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.item_id_Invalid > 0 OR h.item_name_Invalid > 0 OR h.item_description_Invalid > 0 OR h.status_name_Invalid > 0 OR h.item_source_code_Invalid > 0 OR h.source_id_Invalid > 0 OR h.source_name_Invalid > 0 OR h.source_address1_Invalid > 0 OR h.source_address2_Invalid > 0 OR h.source_city_Invalid > 0 OR h.source_state_Invalid > 0 OR h.source_zip_Invalid > 0 OR h.source_phone_Invalid > 0 OR h.source_website_Invalid > 0 OR h.unused_source_sourcecodes_Invalid > 0 OR h.unused_fcra_Invalid > 0 OR h.unused_fcra_comments_Invalid > 0 OR h.market_restrict_flag_Invalid > 0 OR h.unused_market_comments_Invalid > 0 OR h.unused_contact_name_Invalid > 0 OR h.unused_contact_phone_Invalid > 0 OR h.unused_contact_email_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.item_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.item_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.item_description_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.item_source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_source_sourcecodes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_fcra_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_fcra_comments_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_restrict_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_market_comments_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_contact_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_contact_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_contact_email_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.item_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.item_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.item_description_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.item_source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_source_sourcecodes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_fcra_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_fcra_comments_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_restrict_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_market_comments_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_contact_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_contact_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unused_contact_email_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.item_id_Invalid,le.item_name_Invalid,le.item_description_Invalid,le.status_name_Invalid,le.item_source_code_Invalid,le.source_id_Invalid,le.source_name_Invalid,le.source_address1_Invalid,le.source_address2_Invalid,le.source_city_Invalid,le.source_state_Invalid,le.source_zip_Invalid,le.source_phone_Invalid,le.source_website_Invalid,le.unused_source_sourcecodes_Invalid,le.unused_fcra_Invalid,le.unused_fcra_comments_Invalid,le.market_restrict_flag_Invalid,le.unused_market_comments_Invalid,le.unused_contact_name_Invalid,le.unused_contact_phone_Invalid,le.unused_contact_email_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Orbit_Fields.InvalidMessage_item_id(le.item_id_Invalid),Orbit_Fields.InvalidMessage_item_name(le.item_name_Invalid),Orbit_Fields.InvalidMessage_item_description(le.item_description_Invalid),Orbit_Fields.InvalidMessage_status_name(le.status_name_Invalid),Orbit_Fields.InvalidMessage_item_source_code(le.item_source_code_Invalid),Orbit_Fields.InvalidMessage_source_id(le.source_id_Invalid),Orbit_Fields.InvalidMessage_source_name(le.source_name_Invalid),Orbit_Fields.InvalidMessage_source_address1(le.source_address1_Invalid),Orbit_Fields.InvalidMessage_source_address2(le.source_address2_Invalid),Orbit_Fields.InvalidMessage_source_city(le.source_city_Invalid),Orbit_Fields.InvalidMessage_source_state(le.source_state_Invalid),Orbit_Fields.InvalidMessage_source_zip(le.source_zip_Invalid),Orbit_Fields.InvalidMessage_source_phone(le.source_phone_Invalid),Orbit_Fields.InvalidMessage_source_website(le.source_website_Invalid),Orbit_Fields.InvalidMessage_unused_source_sourcecodes(le.unused_source_sourcecodes_Invalid),Orbit_Fields.InvalidMessage_unused_fcra(le.unused_fcra_Invalid),Orbit_Fields.InvalidMessage_unused_fcra_comments(le.unused_fcra_comments_Invalid),Orbit_Fields.InvalidMessage_market_restrict_flag(le.market_restrict_flag_Invalid),Orbit_Fields.InvalidMessage_unused_market_comments(le.unused_market_comments_Invalid),Orbit_Fields.InvalidMessage_unused_contact_name(le.unused_contact_name_Invalid),Orbit_Fields.InvalidMessage_unused_contact_phone(le.unused_contact_phone_Invalid),Orbit_Fields.InvalidMessage_unused_contact_email(le.unused_contact_email_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.item_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.item_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.item_description_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.item_source_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_source_sourcecodes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_fcra_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_fcra_comments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_restrict_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_market_comments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_contact_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_contact_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unused_contact_email_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_name','unused_contact_phone','unused_contact_email','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_category_name','unused_contact_phone','unused_contact_email','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.item_id,(SALT311.StrType)le.item_name,(SALT311.StrType)le.item_description,(SALT311.StrType)le.status_name,(SALT311.StrType)le.item_source_code,(SALT311.StrType)le.source_id,(SALT311.StrType)le.source_name,(SALT311.StrType)le.source_address1,(SALT311.StrType)le.source_address2,(SALT311.StrType)le.source_city,(SALT311.StrType)le.source_state,(SALT311.StrType)le.source_zip,(SALT311.StrType)le.source_phone,(SALT311.StrType)le.source_website,(SALT311.StrType)le.unused_source_sourcecodes,(SALT311.StrType)le.unused_fcra,(SALT311.StrType)le.unused_fcra_comments,(SALT311.StrType)le.market_restrict_flag,(SALT311.StrType)le.unused_market_comments,(SALT311.StrType)le.unused_contact_name,(SALT311.StrType)le.unused_contact_phone,(SALT311.StrType)le.unused_contact_email,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Orbit_Layout_Vendor_Src) prevDS = DATASET([], Orbit_Layout_Vendor_Src), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'item_id:item_id:ALLOW'
          ,'item_name:item_name:ALLOW'
          ,'item_description:item_description:ALLOW'
          ,'status_name:status_name:ALLOW'
          ,'item_source_code:item_source_code:ALLOW'
          ,'source_id:source_id:ALLOW'
          ,'source_name:source_name:ALLOW'
          ,'source_address1:source_address1:ALLOW'
          ,'source_address2:source_address2:ALLOW'
          ,'source_city:source_city:ALLOW'
          ,'source_state:source_state:ALLOW'
          ,'source_zip:source_zip:ALLOW'
          ,'source_phone:source_phone:ALLOW'
          ,'source_website:source_website:ALLOW'
          ,'unused_source_sourcecodes:unused_source_sourcecodes:ALLOW'
          ,'unused_fcra:unused_fcra:ALLOW'
          ,'unused_fcra_comments:unused_fcra_comments:ALLOW'
          ,'market_restrict_flag:market_restrict_flag:ALLOW'
          ,'unused_market_comments:unused_market_comments:ALLOW'
          ,'unused_contact_name:unused_contact_category_name:ALLOW'
          ,'unused_contact_phone:unused_contact_phone:ALLOW'
          ,'unused_contact_email:unused_contact_email:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Orbit_Fields.InvalidMessage_item_id(1)
          ,Orbit_Fields.InvalidMessage_item_name(1)
          ,Orbit_Fields.InvalidMessage_item_description(1)
          ,Orbit_Fields.InvalidMessage_status_name(1)
          ,Orbit_Fields.InvalidMessage_item_source_code(1)
          ,Orbit_Fields.InvalidMessage_source_id(1)
          ,Orbit_Fields.InvalidMessage_source_name(1)
          ,Orbit_Fields.InvalidMessage_source_address1(1)
          ,Orbit_Fields.InvalidMessage_source_address2(1)
          ,Orbit_Fields.InvalidMessage_source_city(1)
          ,Orbit_Fields.InvalidMessage_source_state(1)
          ,Orbit_Fields.InvalidMessage_source_zip(1)
          ,Orbit_Fields.InvalidMessage_source_phone(1)
          ,Orbit_Fields.InvalidMessage_source_website(1)
          ,Orbit_Fields.InvalidMessage_unused_source_sourcecodes(1)
          ,Orbit_Fields.InvalidMessage_unused_fcra(1)
          ,Orbit_Fields.InvalidMessage_unused_fcra_comments(1)
          ,Orbit_Fields.InvalidMessage_market_restrict_flag(1)
          ,Orbit_Fields.InvalidMessage_unused_market_comments(1)
          ,Orbit_Fields.InvalidMessage_unused_contact_name(1)
          ,Orbit_Fields.InvalidMessage_unused_contact_phone(1)
          ,Orbit_Fields.InvalidMessage_unused_contact_email(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.item_id_ALLOW_ErrorCount
          ,le.item_name_ALLOW_ErrorCount
          ,le.item_description_ALLOW_ErrorCount
          ,le.status_name_ALLOW_ErrorCount
          ,le.item_source_code_ALLOW_ErrorCount
          ,le.source_id_ALLOW_ErrorCount
          ,le.source_name_ALLOW_ErrorCount
          ,le.source_address1_ALLOW_ErrorCount
          ,le.source_address2_ALLOW_ErrorCount
          ,le.source_city_ALLOW_ErrorCount
          ,le.source_state_ALLOW_ErrorCount
          ,le.source_zip_ALLOW_ErrorCount
          ,le.source_phone_ALLOW_ErrorCount
          ,le.source_website_ALLOW_ErrorCount
          ,le.unused_source_sourcecodes_ALLOW_ErrorCount
          ,le.unused_fcra_ALLOW_ErrorCount
          ,le.unused_fcra_comments_ALLOW_ErrorCount
          ,le.market_restrict_flag_ALLOW_ErrorCount
          ,le.unused_market_comments_ALLOW_ErrorCount
          ,le.unused_contact_name_ALLOW_ErrorCount
          ,le.unused_contact_phone_ALLOW_ErrorCount
          ,le.unused_contact_email_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.item_id_ALLOW_ErrorCount
          ,le.item_name_ALLOW_ErrorCount
          ,le.item_description_ALLOW_ErrorCount
          ,le.status_name_ALLOW_ErrorCount
          ,le.item_source_code_ALLOW_ErrorCount
          ,le.source_id_ALLOW_ErrorCount
          ,le.source_name_ALLOW_ErrorCount
          ,le.source_address1_ALLOW_ErrorCount
          ,le.source_address2_ALLOW_ErrorCount
          ,le.source_city_ALLOW_ErrorCount
          ,le.source_state_ALLOW_ErrorCount
          ,le.source_zip_ALLOW_ErrorCount
          ,le.source_phone_ALLOW_ErrorCount
          ,le.source_website_ALLOW_ErrorCount
          ,le.unused_source_sourcecodes_ALLOW_ErrorCount
          ,le.unused_fcra_ALLOW_ErrorCount
          ,le.unused_fcra_comments_ALLOW_ErrorCount
          ,le.market_restrict_flag_ALLOW_ErrorCount
          ,le.unused_market_comments_ALLOW_ErrorCount
          ,le.unused_contact_name_ALLOW_ErrorCount
          ,le.unused_contact_phone_ALLOW_ErrorCount
          ,le.unused_contact_email_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Orbit_hygiene(PROJECT(h, Orbit_Layout_Vendor_Src));
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
          ,'item_id:' + getFieldTypeText(h.item_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'item_name:' + getFieldTypeText(h.item_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'item_description:' + getFieldTypeText(h.item_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status_name:' + getFieldTypeText(h.status_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'item_source_code:' + getFieldTypeText(h.item_source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_id:' + getFieldTypeText(h.source_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_name:' + getFieldTypeText(h.source_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_address1:' + getFieldTypeText(h.source_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_address2:' + getFieldTypeText(h.source_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_city:' + getFieldTypeText(h.source_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_state:' + getFieldTypeText(h.source_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_zip:' + getFieldTypeText(h.source_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_phone:' + getFieldTypeText(h.source_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_website:' + getFieldTypeText(h.source_website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_source_sourcecodes:' + getFieldTypeText(h.unused_source_sourcecodes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_fcra:' + getFieldTypeText(h.unused_fcra) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_fcra_comments:' + getFieldTypeText(h.unused_fcra_comments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_restrict_flag:' + getFieldTypeText(h.market_restrict_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_market_comments:' + getFieldTypeText(h.unused_market_comments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_contact_category_name:' + getFieldTypeText(h.unused_contact_category_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_contact_name:' + getFieldTypeText(h.unused_contact_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_contact_phone:' + getFieldTypeText(h.unused_contact_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unused_contact_email:' + getFieldTypeText(h.unused_contact_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_item_id_cnt
          ,le.populated_item_name_cnt
          ,le.populated_item_description_cnt
          ,le.populated_status_name_cnt
          ,le.populated_item_source_code_cnt
          ,le.populated_source_id_cnt
          ,le.populated_source_name_cnt
          ,le.populated_source_address1_cnt
          ,le.populated_source_address2_cnt
          ,le.populated_source_city_cnt
          ,le.populated_source_state_cnt
          ,le.populated_source_zip_cnt
          ,le.populated_source_phone_cnt
          ,le.populated_source_website_cnt
          ,le.populated_unused_source_sourcecodes_cnt
          ,le.populated_unused_fcra_cnt
          ,le.populated_unused_fcra_comments_cnt
          ,le.populated_market_restrict_flag_cnt
          ,le.populated_unused_market_comments_cnt
          ,le.populated_unused_contact_category_name_cnt
          ,le.populated_unused_contact_name_cnt
          ,le.populated_unused_contact_phone_cnt
          ,le.populated_unused_contact_email_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_item_id_pcnt
          ,le.populated_item_name_pcnt
          ,le.populated_item_description_pcnt
          ,le.populated_status_name_pcnt
          ,le.populated_item_source_code_pcnt
          ,le.populated_source_id_pcnt
          ,le.populated_source_name_pcnt
          ,le.populated_source_address1_pcnt
          ,le.populated_source_address2_pcnt
          ,le.populated_source_city_pcnt
          ,le.populated_source_state_pcnt
          ,le.populated_source_zip_pcnt
          ,le.populated_source_phone_pcnt
          ,le.populated_source_website_pcnt
          ,le.populated_unused_source_sourcecodes_pcnt
          ,le.populated_unused_fcra_pcnt
          ,le.populated_unused_fcra_comments_pcnt
          ,le.populated_market_restrict_flag_pcnt
          ,le.populated_unused_market_comments_pcnt
          ,le.populated_unused_contact_category_name_pcnt
          ,le.populated_unused_contact_name_pcnt
          ,le.populated_unused_contact_phone_pcnt
          ,le.populated_unused_contact_email_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,23,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Orbit_Delta(prevDS, PROJECT(h, Orbit_Layout_Vendor_Src));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),23,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Orbit_Layout_Vendor_Src) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Vendor_Src, Orbit_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
