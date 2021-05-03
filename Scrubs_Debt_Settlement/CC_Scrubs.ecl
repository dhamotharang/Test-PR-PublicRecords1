IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Debt_Settlement; // Import modules for FieldTypes attribute definitions
EXPORT CC_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 18;
  EXPORT NumRulesFromFieldType := 18;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(CC_Layout_Debt_Settlement)
    UNSIGNED1 idnum_Invalid;
    UNSIGNED1 businessname_Invalid;
    UNSIGNED1 dba_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 url_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 licensedatefrom_Invalid;
    UNSIGNED1 licensedateto_Invalid;
    UNSIGNED1 orgtype_Invalid;
    UNSIGNED1 source_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CC_Layout_Debt_Settlement)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(CC_Layout_Debt_Settlement) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.idnum_Invalid := CC_Fields.InValid_idnum((SALT311.StrType)le.idnum);
    SELF.businessname_Invalid := CC_Fields.InValid_businessname((SALT311.StrType)le.businessname);
    SELF.dba_Invalid := CC_Fields.InValid_dba((SALT311.StrType)le.dba);
    SELF.orgid_Invalid := CC_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.address1_Invalid := CC_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := CC_Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.city_Invalid := CC_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := CC_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_Invalid := CC_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := CC_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.phone_Invalid := CC_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.url_Invalid := CC_Fields.InValid_url((SALT311.StrType)le.url);
    SELF.status_Invalid := CC_Fields.InValid_status((SALT311.StrType)le.status);
    SELF.licensedatefrom_Invalid := CC_Fields.InValid_licensedatefrom((SALT311.StrType)le.licensedatefrom);
    SELF.licensedateto_Invalid := CC_Fields.InValid_licensedateto((SALT311.StrType)le.licensedateto);
    SELF.orgtype_Invalid := CC_Fields.InValid_orgtype((SALT311.StrType)le.orgtype);
    SELF.source_Invalid := CC_Fields.InValid_source((SALT311.StrType)le.source);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),CC_Layout_Debt_Settlement);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.idnum_Invalid << 0 ) + ( le.businessname_Invalid << 1 ) + ( le.dba_Invalid << 3 ) + ( le.orgid_Invalid << 4 ) + ( le.address1_Invalid << 5 ) + ( le.address2_Invalid << 6 ) + ( le.city_Invalid << 7 ) + ( le.state_Invalid << 8 ) + ( le.zip_Invalid << 9 ) + ( le.zip4_Invalid << 10 ) + ( le.phone_Invalid << 11 ) + ( le.url_Invalid << 12 ) + ( le.status_Invalid << 13 ) + ( le.licensedatefrom_Invalid << 14 ) + ( le.licensedateto_Invalid << 15 ) + ( le.orgtype_Invalid << 16 ) + ( le.source_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,CC_Layout_Debt_Settlement);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.idnum_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.businessname_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.dba_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.url_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.licensedatefrom_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.licensedateto_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orgtype_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    idnum_CUSTOM_ErrorCount := COUNT(GROUP,h.idnum_Invalid=1);
    businessname_CUSTOM_ErrorCount := COUNT(GROUP,h.businessname_Invalid=1);
    businessname_LENGTHS_ErrorCount := COUNT(GROUP,h.businessname_Invalid=2);
    businessname_Total_ErrorCount := COUNT(GROUP,h.businessname_Invalid>0);
    dba_CUSTOM_ErrorCount := COUNT(GROUP,h.dba_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address2_CUSTOM_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    url_CUSTOM_ErrorCount := COUNT(GROUP,h.url_Invalid=1);
    status_CUSTOM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    licensedatefrom_CUSTOM_ErrorCount := COUNT(GROUP,h.licensedatefrom_Invalid=1);
    licensedateto_CUSTOM_ErrorCount := COUNT(GROUP,h.licensedateto_Invalid=1);
    orgtype_CUSTOM_ErrorCount := COUNT(GROUP,h.orgtype_Invalid=1);
    source_LENGTHS_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.idnum_Invalid > 0 OR h.businessname_Invalid > 0 OR h.dba_Invalid > 0 OR h.orgid_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.phone_Invalid > 0 OR h.url_Invalid > 0 OR h.status_Invalid > 0 OR h.licensedatefrom_Invalid > 0 OR h.licensedateto_Invalid > 0 OR h.orgtype_Invalid > 0 OR h.source_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.idnum_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessname_Total_ErrorCount > 0, 1, 0) + IF(le.dba_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensedatefrom_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensedateto_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgtype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.idnum_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dba_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensedatefrom_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensedateto_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgtype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.idnum_Invalid,le.businessname_Invalid,le.dba_Invalid,le.orgid_Invalid,le.address1_Invalid,le.address2_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.zip4_Invalid,le.phone_Invalid,le.url_Invalid,le.status_Invalid,le.licensedatefrom_Invalid,le.licensedateto_Invalid,le.orgtype_Invalid,le.source_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CC_Fields.InvalidMessage_idnum(le.idnum_Invalid),CC_Fields.InvalidMessage_businessname(le.businessname_Invalid),CC_Fields.InvalidMessage_dba(le.dba_Invalid),CC_Fields.InvalidMessage_orgid(le.orgid_Invalid),CC_Fields.InvalidMessage_address1(le.address1_Invalid),CC_Fields.InvalidMessage_address2(le.address2_Invalid),CC_Fields.InvalidMessage_city(le.city_Invalid),CC_Fields.InvalidMessage_state(le.state_Invalid),CC_Fields.InvalidMessage_zip(le.zip_Invalid),CC_Fields.InvalidMessage_zip4(le.zip4_Invalid),CC_Fields.InvalidMessage_phone(le.phone_Invalid),CC_Fields.InvalidMessage_url(le.url_Invalid),CC_Fields.InvalidMessage_status(le.status_Invalid),CC_Fields.InvalidMessage_licensedatefrom(le.licensedatefrom_Invalid),CC_Fields.InvalidMessage_licensedateto(le.licensedateto_Invalid),CC_Fields.InvalidMessage_orgtype(le.orgtype_Invalid),CC_Fields.InvalidMessage_source(le.source_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.idnum_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.businessname_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dba_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.url_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensedatefrom_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensedateto_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgtype_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'idnum','businessname','dba','orgid','address1','address2','city','state','zip','zip4','phone','url','status','licensedatefrom','licensedateto','orgtype','source','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_id','Invalid_mandatory_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_St','Invalid_zip','Invalid_zip4','Invalid_Phone','Invalid_alpha','Invalid_Status','Invalid_Date','Invalid_Future_Date','Invalid_OrgType','Invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.idnum,(SALT311.StrType)le.businessname,(SALT311.StrType)le.dba,(SALT311.StrType)le.orgid,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.phone,(SALT311.StrType)le.url,(SALT311.StrType)le.status,(SALT311.StrType)le.licensedatefrom,(SALT311.StrType)le.licensedateto,(SALT311.StrType)le.orgtype,(SALT311.StrType)le.source,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(CC_Layout_Debt_Settlement) prevDS = DATASET([], CC_Layout_Debt_Settlement), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'idnum:Invalid_id:CUSTOM'
          ,'businessname:Invalid_mandatory_alpha:CUSTOM','businessname:Invalid_mandatory_alpha:LENGTHS'
          ,'dba:Invalid_alpha:CUSTOM'
          ,'orgid:Invalid_alpha:CUSTOM'
          ,'address1:Invalid_alpha:CUSTOM'
          ,'address2:Invalid_alpha:CUSTOM'
          ,'city:Invalid_alpha:CUSTOM'
          ,'state:Invalid_St:CUSTOM'
          ,'zip:Invalid_zip:CUSTOM'
          ,'zip4:Invalid_zip4:CUSTOM'
          ,'phone:Invalid_Phone:CUSTOM'
          ,'url:Invalid_alpha:CUSTOM'
          ,'status:Invalid_Status:CUSTOM'
          ,'licensedatefrom:Invalid_Date:CUSTOM'
          ,'licensedateto:Invalid_Future_Date:CUSTOM'
          ,'orgtype:Invalid_OrgType:CUSTOM'
          ,'source:Invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,CC_Fields.InvalidMessage_idnum(1)
          ,CC_Fields.InvalidMessage_businessname(1),CC_Fields.InvalidMessage_businessname(2)
          ,CC_Fields.InvalidMessage_dba(1)
          ,CC_Fields.InvalidMessage_orgid(1)
          ,CC_Fields.InvalidMessage_address1(1)
          ,CC_Fields.InvalidMessage_address2(1)
          ,CC_Fields.InvalidMessage_city(1)
          ,CC_Fields.InvalidMessage_state(1)
          ,CC_Fields.InvalidMessage_zip(1)
          ,CC_Fields.InvalidMessage_zip4(1)
          ,CC_Fields.InvalidMessage_phone(1)
          ,CC_Fields.InvalidMessage_url(1)
          ,CC_Fields.InvalidMessage_status(1)
          ,CC_Fields.InvalidMessage_licensedatefrom(1)
          ,CC_Fields.InvalidMessage_licensedateto(1)
          ,CC_Fields.InvalidMessage_orgtype(1)
          ,CC_Fields.InvalidMessage_source(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.idnum_CUSTOM_ErrorCount
          ,le.businessname_CUSTOM_ErrorCount,le.businessname_LENGTHS_ErrorCount
          ,le.dba_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.address2_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.status_CUSTOM_ErrorCount
          ,le.licensedatefrom_CUSTOM_ErrorCount
          ,le.licensedateto_CUSTOM_ErrorCount
          ,le.orgtype_CUSTOM_ErrorCount
          ,le.source_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.idnum_CUSTOM_ErrorCount
          ,le.businessname_CUSTOM_ErrorCount,le.businessname_LENGTHS_ErrorCount
          ,le.dba_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.address2_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.status_CUSTOM_ErrorCount
          ,le.licensedatefrom_CUSTOM_ErrorCount
          ,le.licensedateto_CUSTOM_ErrorCount
          ,le.orgtype_CUSTOM_ErrorCount
          ,le.source_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := CC_hygiene(PROJECT(h, CC_Layout_Debt_Settlement));
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
          ,'idnum:' + getFieldTypeText(h.idnum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessname:' + getFieldTypeText(h.businessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba:' + getFieldTypeText(h.dba) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax:' + getFieldTypeText(h.fax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensedatefrom:' + getFieldTypeText(h.licensedatefrom) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensedateto:' + getFieldTypeText(h.licensedateto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgtype:' + getFieldTypeText(h.orgtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_idnum_cnt
          ,le.populated_businessname_cnt
          ,le.populated_dba_cnt
          ,le.populated_orgid_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_phone_cnt
          ,le.populated_fax_cnt
          ,le.populated_email_cnt
          ,le.populated_url_cnt
          ,le.populated_status_cnt
          ,le.populated_licensedatefrom_cnt
          ,le.populated_licensedateto_cnt
          ,le.populated_orgtype_cnt
          ,le.populated_source_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_idnum_pcnt
          ,le.populated_businessname_pcnt
          ,le.populated_dba_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_fax_pcnt
          ,le.populated_email_pcnt
          ,le.populated_url_pcnt
          ,le.populated_status_pcnt
          ,le.populated_licensedatefrom_pcnt
          ,le.populated_licensedateto_pcnt
          ,le.populated_orgtype_pcnt
          ,le.populated_source_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,19,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := CC_Delta(prevDS, PROJECT(h, CC_Layout_Debt_Settlement));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),19,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(CC_Layout_Debt_Settlement) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Debt_Settlement, CC_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
