IMPORT SALT44,STD;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 32;
  EXPORT NumRulesFromFieldType := 32;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 17;
  EXPORT NumRulesWithPossibleEdits := 32;
  EXPORT Expanded_Layout := RECORD(Layout_BizHead)
    UNSIGNED1 company_name_Invalid;
    BOOLEAN company_name_wouldClean;
    UNSIGNED1 company_name_prefix_Invalid;
    BOOLEAN company_name_prefix_wouldClean;
    UNSIGNED1 cnp_name_Invalid;
    BOOLEAN cnp_name_wouldClean;
    UNSIGNED1 company_fein_Invalid;
    BOOLEAN company_fein_wouldClean;
    UNSIGNED1 prim_name_Invalid;
    BOOLEAN prim_name_wouldClean;
    UNSIGNED1 sec_range_Invalid;
    BOOLEAN sec_range_wouldClean;
    UNSIGNED1 city_Invalid;
    BOOLEAN city_wouldClean;
    UNSIGNED1 city_clean_Invalid;
    BOOLEAN city_clean_wouldClean;
    UNSIGNED1 st_Invalid;
    BOOLEAN st_wouldClean;
    UNSIGNED1 zip_Invalid;
    BOOLEAN zip_wouldClean;
    UNSIGNED1 company_url_Invalid;
    BOOLEAN company_url_wouldClean;
    UNSIGNED1 fname_Invalid;
    BOOLEAN fname_wouldClean;
    UNSIGNED1 fname_preferred_Invalid;
    BOOLEAN fname_preferred_wouldClean;
    UNSIGNED1 mname_Invalid;
    BOOLEAN mname_wouldClean;
    UNSIGNED1 lname_Invalid;
    BOOLEAN lname_wouldClean;
    UNSIGNED1 name_suffix_Invalid;
    BOOLEAN name_suffix_wouldClean;
    UNSIGNED1 contact_email_Invalid;
    BOOLEAN contact_email_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BizHead)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_BizHead)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'company_name:T_ALPHANUM:CAPS','company_name:T_ALPHANUM:ALLOW'
          ,'company_name_prefix:T_ALPHANUM:CAPS','company_name_prefix:T_ALPHANUM:ALLOW'
          ,'cnp_name:T_ALPHANUM:CAPS','cnp_name:T_ALPHANUM:ALLOW'
          ,'company_fein:T_FEIN:ALLOW','company_fein:T_FEIN:LENGTHS'
          ,'prim_name:T_ALPHANUM:CAPS','prim_name:T_ALPHANUM:ALLOW'
          ,'sec_range:T_ALPHANUM:CAPS','sec_range:T_ALPHANUM:ALLOW'
          ,'city:T_ALPHANUM:CAPS','city:T_ALPHANUM:ALLOW'
          ,'city_clean:T_ALPHANUM:CAPS','city_clean:T_ALPHANUM:ALLOW'
          ,'st:T_ALPHA:CAPS','st:T_ALPHA:ALLOW'
          ,'zip:T_NUMBER:ALLOW'
          ,'company_url:T_ALPHANUM:CAPS','company_url:T_ALPHANUM:ALLOW'
          ,'fname:T_ALPHANUM:CAPS','fname:T_ALPHANUM:ALLOW'
          ,'fname_preferred:T_ALPHANUM:CAPS','fname_preferred:T_ALPHANUM:ALLOW'
          ,'mname:T_ALPHANUM:CAPS','mname:T_ALPHANUM:ALLOW'
          ,'lname:T_ALPHANUM:CAPS','lname:T_ALPHANUM:ALLOW'
          ,'name_suffix:T_ALPHANUM:CAPS','name_suffix:T_ALPHANUM:ALLOW'
          ,'contact_email:T_ALLCAPS:CAPS'
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
          ,Fields.InvalidMessage_company_name(1),Fields.InvalidMessage_company_name(2)
          ,Fields.InvalidMessage_company_name_prefix(1),Fields.InvalidMessage_company_name_prefix(2)
          ,Fields.InvalidMessage_cnp_name(1),Fields.InvalidMessage_cnp_name(2)
          ,Fields.InvalidMessage_company_fein(1),Fields.InvalidMessage_company_fein(2)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2)
          ,Fields.InvalidMessage_city(1),Fields.InvalidMessage_city(2)
          ,Fields.InvalidMessage_city_clean(1),Fields.InvalidMessage_city_clean(2)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip(1)
          ,Fields.InvalidMessage_company_url(1),Fields.InvalidMessage_company_url(2)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2)
          ,Fields.InvalidMessage_fname_preferred(1),Fields.InvalidMessage_fname_preferred(2)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2)
          ,Fields.InvalidMessage_contact_email(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
EXPORT FromNone(DATASET(Layout_BizHead) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT44.StrType)le.company_name);
    clean_company_name := (TYPEOF(le.company_name))Fields.Make_company_name((SALT44.StrType)le.company_name);
    clean_company_name_Invalid := Fields.InValid_company_name((SALT44.StrType)clean_company_name);
    SELF.company_name := IF(withOnfail, clean_company_name, le.company_name); // ONFAIL(CLEAN)
    SELF.company_name_wouldClean := TRIM((SALT44.StrType)le.company_name) <> TRIM((SALT44.StrType)clean_company_name);
    SELF.company_name_prefix_Invalid := Fields.InValid_company_name_prefix((SALT44.StrType)le.company_name_prefix);
    clean_company_name_prefix := (TYPEOF(le.company_name_prefix))Fields.Make_company_name_prefix((SALT44.StrType)le.company_name_prefix);
    clean_company_name_prefix_Invalid := Fields.InValid_company_name_prefix((SALT44.StrType)clean_company_name_prefix);
    SELF.company_name_prefix := IF(withOnfail, clean_company_name_prefix, le.company_name_prefix); // ONFAIL(CLEAN)
    SELF.company_name_prefix_wouldClean := TRIM((SALT44.StrType)le.company_name_prefix) <> TRIM((SALT44.StrType)clean_company_name_prefix);
    SELF.cnp_name_Invalid := Fields.InValid_cnp_name((SALT44.StrType)le.cnp_name);
    clean_cnp_name := (TYPEOF(le.cnp_name))Fields.Make_cnp_name((SALT44.StrType)le.cnp_name);
    clean_cnp_name_Invalid := Fields.InValid_cnp_name((SALT44.StrType)clean_cnp_name);
    SELF.cnp_name := IF(withOnfail, clean_cnp_name, le.cnp_name); // ONFAIL(CLEAN)
    SELF.cnp_name_wouldClean := TRIM((SALT44.StrType)le.cnp_name) <> TRIM((SALT44.StrType)clean_cnp_name);
    SELF.company_fein_Invalid := Fields.InValid_company_fein((SALT44.StrType)le.company_fein);
    SELF.company_fein := IF(SELF.company_fein_Invalid=0 OR NOT withOnfail, le.company_fein, (TYPEOF(le.company_fein))''); // ONFAIL(BLANK)
    SELF.company_fein_wouldClean :=  SELF.company_fein_Invalid > 0;
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT44.StrType)le.prim_name);
    clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT44.StrType)le.prim_name);
    clean_prim_name_Invalid := Fields.InValid_prim_name((SALT44.StrType)clean_prim_name);
    SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.prim_name_wouldClean := TRIM((SALT44.StrType)le.prim_name) <> TRIM((SALT44.StrType)clean_prim_name);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT44.StrType)le.sec_range);
    clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT44.StrType)le.sec_range);
    clean_sec_range_Invalid := Fields.InValid_sec_range((SALT44.StrType)clean_sec_range);
    SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.sec_range_wouldClean := TRIM((SALT44.StrType)le.sec_range) <> TRIM((SALT44.StrType)clean_sec_range);
    SELF.city_Invalid := Fields.InValid_city((SALT44.StrType)le.city);
    clean_city := (TYPEOF(le.city))Fields.Make_city((SALT44.StrType)le.city);
    clean_city_Invalid := Fields.InValid_city((SALT44.StrType)clean_city);
    SELF.city := IF(withOnfail, clean_city, le.city); // ONFAIL(CLEAN)
    SELF.city_wouldClean := TRIM((SALT44.StrType)le.city) <> TRIM((SALT44.StrType)clean_city);
    SELF.city_clean_Invalid := Fields.InValid_city_clean((SALT44.StrType)le.city_clean);
    clean_city_clean := (TYPEOF(le.city_clean))Fields.Make_city_clean((SALT44.StrType)le.city_clean);
    clean_city_clean_Invalid := Fields.InValid_city_clean((SALT44.StrType)clean_city_clean);
    SELF.city_clean := IF(withOnfail, clean_city_clean, le.city_clean); // ONFAIL(CLEAN)
    SELF.city_clean_wouldClean := TRIM((SALT44.StrType)le.city_clean) <> TRIM((SALT44.StrType)clean_city_clean);
    SELF.st_Invalid := Fields.InValid_st((SALT44.StrType)le.st);
    clean_st := (TYPEOF(le.st))Fields.Make_st((SALT44.StrType)le.st);
    clean_st_Invalid := Fields.InValid_st((SALT44.StrType)clean_st);
    SELF.st := IF(withOnfail, clean_st, le.st); // ONFAIL(CLEAN)
    SELF.st_wouldClean := TRIM((SALT44.StrType)le.st) <> TRIM((SALT44.StrType)clean_st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT44.StrType)le.zip);
    clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT44.StrType)le.zip);
    clean_zip_Invalid := Fields.InValid_zip((SALT44.StrType)clean_zip);
    SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.zip_wouldClean := TRIM((SALT44.StrType)le.zip) <> TRIM((SALT44.StrType)clean_zip);
    SELF.company_url_Invalid := Fields.InValid_company_url((SALT44.StrType)le.company_url);
    clean_company_url := (TYPEOF(le.company_url))Fields.Make_company_url((SALT44.StrType)le.company_url);
    clean_company_url_Invalid := Fields.InValid_company_url((SALT44.StrType)clean_company_url);
    SELF.company_url := IF(withOnfail, clean_company_url, le.company_url); // ONFAIL(CLEAN)
    SELF.company_url_wouldClean := TRIM((SALT44.StrType)le.company_url) <> TRIM((SALT44.StrType)clean_company_url);
    SELF.fname_Invalid := Fields.InValid_fname((SALT44.StrType)le.fname);
    clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT44.StrType)le.fname);
    clean_fname_Invalid := Fields.InValid_fname((SALT44.StrType)clean_fname);
    SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.fname_wouldClean := TRIM((SALT44.StrType)le.fname) <> TRIM((SALT44.StrType)clean_fname);
    SELF.fname_preferred_Invalid := Fields.InValid_fname_preferred((SALT44.StrType)le.fname_preferred);
    clean_fname_preferred := (TYPEOF(le.fname_preferred))Fields.Make_fname_preferred((SALT44.StrType)le.fname_preferred);
    clean_fname_preferred_Invalid := Fields.InValid_fname_preferred((SALT44.StrType)clean_fname_preferred);
    SELF.fname_preferred := IF(withOnfail, clean_fname_preferred, le.fname_preferred); // ONFAIL(CLEAN)
    SELF.fname_preferred_wouldClean := TRIM((SALT44.StrType)le.fname_preferred) <> TRIM((SALT44.StrType)clean_fname_preferred);
    SELF.mname_Invalid := Fields.InValid_mname((SALT44.StrType)le.mname);
    clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT44.StrType)le.mname);
    clean_mname_Invalid := Fields.InValid_mname((SALT44.StrType)clean_mname);
    SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.mname_wouldClean := TRIM((SALT44.StrType)le.mname) <> TRIM((SALT44.StrType)clean_mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT44.StrType)le.lname);
    clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT44.StrType)le.lname);
    clean_lname_Invalid := Fields.InValid_lname((SALT44.StrType)clean_lname);
    SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.lname_wouldClean := TRIM((SALT44.StrType)le.lname) <> TRIM((SALT44.StrType)clean_lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT44.StrType)le.name_suffix);
    clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT44.StrType)le.name_suffix);
    clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT44.StrType)clean_name_suffix);
    SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_suffix_wouldClean := TRIM((SALT44.StrType)le.name_suffix) <> TRIM((SALT44.StrType)clean_name_suffix);
    SELF.contact_email_Invalid := Fields.InValid_contact_email((SALT44.StrType)le.contact_email);
    clean_contact_email := (TYPEOF(le.contact_email))Fields.Make_contact_email((SALT44.StrType)le.contact_email);
    clean_contact_email_Invalid := Fields.InValid_contact_email((SALT44.StrType)clean_contact_email);
    SELF.contact_email := IF(withOnfail, clean_contact_email, le.contact_email); // ONFAIL(CLEAN)
    SELF.contact_email_wouldClean := TRIM((SALT44.StrType)le.contact_email) <> TRIM((SALT44.StrType)clean_contact_email);

    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BizHead);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_name_Invalid << 0 ) + ( le.company_name_prefix_Invalid << 2 ) + ( le.cnp_name_Invalid << 4 ) + ( le.company_fein_Invalid << 6 ) + ( le.prim_name_Invalid << 8 ) + ( le.sec_range_Invalid << 10 ) + ( le.city_Invalid << 12 ) + ( le.city_clean_Invalid << 14 ) + ( le.st_Invalid << 16 ) + ( le.zip_Invalid << 18 ) + ( le.company_url_Invalid << 19 ) + ( le.fname_Invalid << 21 ) + ( le.fname_preferred_Invalid << 23 ) + ( le.mname_Invalid << 25 ) + ( le.lname_Invalid << 27 ) + ( le.name_suffix_Invalid << 29 ) + ( le.contact_email_Invalid << 31 );
    SELF.ScrubsCleanBits1 := ( IF(le.company_name_wouldClean, 1, 0) << 0 ) + ( IF(le.company_name_prefix_wouldClean, 1, 0) << 1 ) + ( IF(le.cnp_name_wouldClean, 1, 0) << 2 ) + ( IF(le.company_fein_wouldClean, 1, 0) << 3 ) + ( IF(le.prim_name_wouldClean, 1, 0) << 4 ) + ( IF(le.sec_range_wouldClean, 1, 0) << 5 ) + ( IF(le.city_wouldClean, 1, 0) << 6 ) + ( IF(le.city_clean_wouldClean, 1, 0) << 7 ) + ( IF(le.st_wouldClean, 1, 0) << 8 ) + ( IF(le.zip_wouldClean, 1, 0) << 9 ) + ( IF(le.company_url_wouldClean, 1, 0) << 10 ) + ( IF(le.fname_wouldClean, 1, 0) << 11 ) + ( IF(le.fname_preferred_wouldClean, 1, 0) << 12 ) + ( IF(le.mname_wouldClean, 1, 0) << 13 ) + ( IF(le.lname_wouldClean, 1, 0) << 14 ) + ( IF(le.name_suffix_wouldClean, 1, 0) << 15 ) + ( IF(le.contact_email_wouldClean, 1, 0) << 16 );
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
  EXPORT Infile := PROJECT(h,Layout_BizHead);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.company_name_prefix_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.cnp_name_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.company_fein_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.city_clean_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.company_url_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.fname_preferred_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.contact_email_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.company_name_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.company_name_prefix_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.cnp_name_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.company_fein_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.prim_name_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.sec_range_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.city_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.city_clean_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.st_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.zip_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.company_url_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.fname_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.fname_preferred_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.mname_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.lname_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.name_suffix_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.contact_email_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.company_name_prefix_Invalid <> RIGHT.company_name_prefix_Invalid OR LEFT.cnp_name_Invalid <> RIGHT.cnp_name_Invalid OR LEFT.company_fein_Invalid <> RIGHT.company_fein_Invalid OR LEFT.prim_name_Invalid <> RIGHT.prim_name_Invalid OR LEFT.sec_range_Invalid <> RIGHT.sec_range_Invalid OR LEFT.city_Invalid <> RIGHT.city_Invalid OR LEFT.city_clean_Invalid <> RIGHT.city_clean_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.company_url_Invalid <> RIGHT.company_url_Invalid OR LEFT.fname_Invalid <> RIGHT.fname_Invalid OR LEFT.fname_preferred_Invalid <> RIGHT.fname_preferred_Invalid OR LEFT.mname_Invalid <> RIGHT.mname_Invalid OR LEFT.lname_Invalid <> RIGHT.lname_Invalid OR LEFT.name_suffix_Invalid <> RIGHT.name_suffix_Invalid OR LEFT.contact_email_Invalid <> RIGHT.contact_email_Invalid), TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_CAPS_WouldModifyCount := COUNT(GROUP,h.company_name_Invalid=1 AND h.company_name_wouldClean);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.company_name_Invalid=2 AND h.company_name_wouldClean);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    company_name_prefix_CAPS_ErrorCount := COUNT(GROUP,h.company_name_prefix_Invalid=1);
    company_name_prefix_CAPS_WouldModifyCount := COUNT(GROUP,h.company_name_prefix_Invalid=1 AND h.company_name_prefix_wouldClean);
    company_name_prefix_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_prefix_Invalid=2);
    company_name_prefix_ALLOW_WouldModifyCount := COUNT(GROUP,h.company_name_prefix_Invalid=2 AND h.company_name_prefix_wouldClean);
    company_name_prefix_Total_ErrorCount := COUNT(GROUP,h.company_name_prefix_Invalid>0);
    cnp_name_CAPS_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=1);
    cnp_name_CAPS_WouldModifyCount := COUNT(GROUP,h.cnp_name_Invalid=1 AND h.cnp_name_wouldClean);
    cnp_name_ALLOW_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=2);
    cnp_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.cnp_name_Invalid=2 AND h.cnp_name_wouldClean);
    cnp_name_Total_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid>0);
    company_fein_ALLOW_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=1);
    company_fein_ALLOW_WouldModifyCount := COUNT(GROUP,h.company_fein_Invalid=1 AND h.company_fein_wouldClean);
    company_fein_LENGTHS_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=2);
    company_fein_LENGTHS_WouldModifyCount := COUNT(GROUP,h.company_fein_Invalid=2 AND h.company_fein_wouldClean);
    company_fein_Total_ErrorCount := COUNT(GROUP,h.company_fein_Invalid>0);
    prim_name_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_CAPS_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=1 AND h.prim_name_wouldClean);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=2 AND h.prim_name_wouldClean);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    sec_range_CAPS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_CAPS_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=1 AND h.sec_range_wouldClean);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=2 AND h.sec_range_wouldClean);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    city_CAPS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_CAPS_WouldModifyCount := COUNT(GROUP,h.city_Invalid=1 AND h.city_wouldClean);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_ALLOW_WouldModifyCount := COUNT(GROUP,h.city_Invalid=2 AND h.city_wouldClean);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    city_clean_CAPS_ErrorCount := COUNT(GROUP,h.city_clean_Invalid=1);
    city_clean_CAPS_WouldModifyCount := COUNT(GROUP,h.city_clean_Invalid=1 AND h.city_clean_wouldClean);
    city_clean_ALLOW_ErrorCount := COUNT(GROUP,h.city_clean_Invalid=2);
    city_clean_ALLOW_WouldModifyCount := COUNT(GROUP,h.city_clean_Invalid=2 AND h.city_clean_wouldClean);
    city_clean_Total_ErrorCount := COUNT(GROUP,h.city_clean_Invalid>0);
    st_CAPS_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_CAPS_WouldModifyCount := COUNT(GROUP,h.st_Invalid=1 AND h.st_wouldClean);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_ALLOW_WouldModifyCount := COUNT(GROUP,h.st_Invalid=2 AND h.st_wouldClean);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=1 AND h.zip_wouldClean);

    company_url_CAPS_ErrorCount := COUNT(GROUP,h.company_url_Invalid=1);
    company_url_CAPS_WouldModifyCount := COUNT(GROUP,h.company_url_Invalid=1 AND h.company_url_wouldClean);
    company_url_ALLOW_ErrorCount := COUNT(GROUP,h.company_url_Invalid=2);
    company_url_ALLOW_WouldModifyCount := COUNT(GROUP,h.company_url_Invalid=2 AND h.company_url_wouldClean);
    company_url_Total_ErrorCount := COUNT(GROUP,h.company_url_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_CAPS_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=1 AND h.fname_wouldClean);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=2 AND h.fname_wouldClean);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    fname_preferred_CAPS_ErrorCount := COUNT(GROUP,h.fname_preferred_Invalid=1);
    fname_preferred_CAPS_WouldModifyCount := COUNT(GROUP,h.fname_preferred_Invalid=1 AND h.fname_preferred_wouldClean);
    fname_preferred_ALLOW_ErrorCount := COUNT(GROUP,h.fname_preferred_Invalid=2);
    fname_preferred_ALLOW_WouldModifyCount := COUNT(GROUP,h.fname_preferred_Invalid=2 AND h.fname_preferred_wouldClean);
    fname_preferred_Total_ErrorCount := COUNT(GROUP,h.fname_preferred_Invalid>0);
    mname_CAPS_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_CAPS_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=1 AND h.mname_wouldClean);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=2 AND h.mname_wouldClean);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_CAPS_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=1 AND h.lname_wouldClean);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=2 AND h.lname_wouldClean);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_CAPS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=1 AND h.name_suffix_wouldClean);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=2 AND h.name_suffix_wouldClean);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    contact_email_CAPS_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=1);
    contact_email_CAPS_WouldModifyCount := COUNT(GROUP,h.contact_email_Invalid=1 AND h.contact_email_wouldClean);

    AnyRule_WithErrorsCount := COUNT(GROUP, h.company_name_Invalid > 0 OR h.company_name_prefix_Invalid > 0 OR h.cnp_name_Invalid > 0 OR h.company_fein_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.city_Invalid > 0 OR h.city_clean_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.company_url_Invalid > 0 OR h.fname_Invalid > 0 OR h.fname_preferred_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.contact_email_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.company_name_wouldClean OR h.company_name_prefix_wouldClean OR h.cnp_name_wouldClean OR h.company_fein_wouldClean OR h.prim_name_wouldClean OR h.sec_range_wouldClean OR h.city_wouldClean OR h.city_clean_wouldClean OR h.st_wouldClean OR h.zip_wouldClean OR h.company_url_wouldClean OR h.fname_wouldClean OR h.fname_preferred_wouldClean OR h.mname_wouldClean OR h.lname_wouldClean OR h.name_suffix_wouldClean OR h.contact_email_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.company_name_Total_ErrorCount > 0, 1, 0) + IF(le.company_name_prefix_Total_ErrorCount > 0, 1, 0) + IF(le.cnp_name_Total_ErrorCount > 0, 1, 0) + IF(le.company_fein_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.city_clean_Total_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_url_Total_ErrorCount > 0, 1, 0) + IF(le.fname_Total_ErrorCount > 0, 1, 0) + IF(le.fname_preferred_Total_ErrorCount > 0, 1, 0) + IF(le.mname_Total_ErrorCount > 0, 1, 0) + IF(le.lname_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.contact_email_CAPS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.company_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_prefix_CAPS_ErrorCount > 0, 1, 0) + IF(le.company_name_prefix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cnp_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.cnp_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_fein_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_fein_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_CAPS_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_CAPS_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_clean_CAPS_ErrorCount > 0, 1, 0) + IF(le.city_clean_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_CAPS_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_url_CAPS_ErrorCount > 0, 1, 0) + IF(le.company_url_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_CAPS_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_preferred_CAPS_ErrorCount > 0, 1, 0) + IF(le.fname_preferred_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_CAPS_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_CAPS_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_CAPS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_email_CAPS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.company_name_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.company_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.company_name_prefix_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.company_name_prefix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cnp_name_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.cnp_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.company_fein_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.company_fein_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_clean_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.city_clean_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.st_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.company_url_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.company_url_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.fname_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.fname_preferred_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.fname_preferred_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mname_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lname_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.contact_email_CAPS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT44.StrType ErrorMessage;
    SALT44.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_name_Invalid,le.company_name_prefix_Invalid,le.cnp_name_Invalid,le.company_fein_Invalid,le.prim_name_Invalid,le.sec_range_Invalid,le.city_Invalid,le.city_clean_Invalid,le.st_Invalid,le.zip_Invalid,le.company_url_Invalid,le.fname_Invalid,le.fname_preferred_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.contact_email_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_company_name_prefix(le.company_name_prefix_Invalid),Fields.InvalidMessage_cnp_name(le.cnp_name_Invalid),Fields.InvalidMessage_company_fein(le.company_fein_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_city_clean(le.city_clean_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_company_url(le.company_url_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_fname_preferred(le.fname_preferred_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_contact_email(le.contact_email_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_prefix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.cnp_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.company_fein_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.city_clean_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_url_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_preferred_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_email_Invalid,'CAPS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'company_name','company_name_prefix','cnp_name','company_fein','prim_name','sec_range','city','city_clean','st','zip','company_url','fname','fname_preferred','mname','lname','name_suffix','contact_email','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_FEIN','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHA','T_NUMBER','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALPHANUM','T_ALLCAPS','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT44.StrType)le.company_name,(SALT44.StrType)le.company_name_prefix,(SALT44.StrType)le.cnp_name,(SALT44.StrType)le.company_fein,(SALT44.StrType)le.prim_name,(SALT44.StrType)le.sec_range,(SALT44.StrType)le.city,(SALT44.StrType)le.city_clean,(SALT44.StrType)le.st,(SALT44.StrType)le.zip,(SALT44.StrType)le.company_url,(SALT44.StrType)le.fname,(SALT44.StrType)le.fname_preferred,(SALT44.StrType)le.mname,(SALT44.StrType)le.lname,(SALT44.StrType)le.name_suffix,(SALT44.StrType)le.contact_email,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_BizHead) prevDS = DATASET([], Layout_BizHead), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT44.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount
          ,le.company_name_prefix_CAPS_ErrorCount,le.company_name_prefix_ALLOW_ErrorCount
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount,le.company_fein_LENGTHS_ErrorCount
          ,le.prim_name_CAPS_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.sec_range_CAPS_ErrorCount,le.sec_range_ALLOW_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.city_clean_CAPS_ErrorCount,le.city_clean_ALLOW_ErrorCount
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.company_url_CAPS_ErrorCount,le.company_url_ALLOW_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.fname_preferred_CAPS_ErrorCount,le.fname_preferred_ALLOW_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.contact_email_CAPS_ErrorCount
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
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount
          ,le.company_name_prefix_CAPS_ErrorCount,le.company_name_prefix_ALLOW_ErrorCount
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount,le.company_fein_LENGTHS_ErrorCount
          ,le.prim_name_CAPS_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.sec_range_CAPS_ErrorCount,le.sec_range_ALLOW_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.city_clean_CAPS_ErrorCount,le.city_clean_ALLOW_ErrorCount
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.company_url_CAPS_ErrorCount,le.company_url_ALLOW_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.fname_preferred_CAPS_ErrorCount,le.fname_preferred_ALLOW_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.contact_email_CAPS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT44.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT44.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_BizHead));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT44.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'parent_proxid:' + getFieldTypeText(h.parent_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sele_proxid:' + getFieldTypeText(h.sele_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'org_proxid:' + getFieldTypeText(h.org_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultimate_proxid:' + getFieldTypeText(h.ultimate_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'has_lgid:' + getFieldTypeText(h.has_lgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_record_id:' + getFieldTypeText(h.source_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_docid:' + getFieldTypeText(h.source_docid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_prefix:' + getFieldTypeText(h.company_name_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_name:' + getFieldTypeText(h.cnp_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_number:' + getFieldTypeText(h.cnp_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_btype:' + getFieldTypeText(h.cnp_btype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_lowv:' + getFieldTypeText(h.cnp_lowv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone:' + getFieldTypeText(h.company_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone_3:' + getFieldTypeText(h.company_phone_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone_3_ex:' + getFieldTypeText(h.company_phone_3_ex) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone_7:' + getFieldTypeText(h.company_phone_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_fein:' + getFieldTypeText(h.company_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_sic_code1:' + getFieldTypeText(h.company_sic_code1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_duns_number:' + getFieldTypeText(h.active_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_clean:' + getFieldTypeText(h.city_clean) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_url:' + getFieldTypeText(h.company_url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'isContact:' + getFieldTypeText(h.isContact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_did:' + getFieldTypeText(h.contact_did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname_preferred:' + getFieldTypeText(h.fname_preferred) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_ssn:' + getFieldTypeText(h.contact_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_email:' + getFieldTypeText(h.contact_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sele_flag:' + getFieldTypeText(h.sele_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'org_flag:' + getFieldTypeText(h.org_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ult_flag:' + getFieldTypeText(h.ult_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fallback_value:' + getFieldTypeText(h.fallback_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_parent_proxid_cnt
          ,le.populated_sele_proxid_cnt
          ,le.populated_org_proxid_cnt
          ,le.populated_ultimate_proxid_cnt
          ,le.populated_has_lgid_cnt
          ,le.populated_empid_cnt
          ,le.populated_source_cnt
          ,le.populated_source_record_id_cnt
          ,le.populated_source_docid_cnt
          ,le.populated_company_name_cnt
          ,le.populated_company_name_prefix_cnt
          ,le.populated_cnp_name_cnt
          ,le.populated_cnp_number_cnt
          ,le.populated_cnp_btype_cnt
          ,le.populated_cnp_lowv_cnt
          ,le.populated_company_phone_cnt
          ,le.populated_company_phone_3_cnt
          ,le.populated_company_phone_3_ex_cnt
          ,le.populated_company_phone_7_cnt
          ,le.populated_company_fein_cnt
          ,le.populated_company_sic_code1_cnt
          ,le.populated_active_duns_number_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_city_cnt
          ,le.populated_city_clean_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_company_url_cnt
          ,le.populated_isContact_cnt
          ,le.populated_contact_did_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_fname_preferred_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_contact_ssn_cnt
          ,le.populated_contact_email_cnt
          ,le.populated_sele_flag_cnt
          ,le.populated_org_flag_cnt
          ,le.populated_ult_flag_cnt
          ,le.populated_fallback_value_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_parent_proxid_pcnt
          ,le.populated_sele_proxid_pcnt
          ,le.populated_org_proxid_pcnt
          ,le.populated_ultimate_proxid_pcnt
          ,le.populated_has_lgid_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_source_pcnt
          ,le.populated_source_record_id_pcnt
          ,le.populated_source_docid_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_company_name_prefix_pcnt
          ,le.populated_cnp_name_pcnt
          ,le.populated_cnp_number_pcnt
          ,le.populated_cnp_btype_pcnt
          ,le.populated_cnp_lowv_pcnt
          ,le.populated_company_phone_pcnt
          ,le.populated_company_phone_3_pcnt
          ,le.populated_company_phone_3_ex_pcnt
          ,le.populated_company_phone_7_pcnt
          ,le.populated_company_fein_pcnt
          ,le.populated_company_sic_code1_pcnt
          ,le.populated_active_duns_number_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_city_pcnt
          ,le.populated_city_clean_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_company_url_pcnt
          ,le.populated_isContact_pcnt
          ,le.populated_contact_did_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_fname_preferred_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_contact_ssn_pcnt
          ,le.populated_contact_email_pcnt
          ,le.populated_sele_flag_pcnt
          ,le.populated_org_flag_pcnt
          ,le.populated_ult_flag_pcnt
          ,le.populated_fallback_value_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,44,xNormHygieneStats(LEFT,COUNTER,'POP'));
  // record count stats
    SALT44.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_BizHead));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),44,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
EXPORT StandardStats(DATASET(Layout_BizHead) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT44.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
  SALT44.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(BizLinkFull, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT44.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT44.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

