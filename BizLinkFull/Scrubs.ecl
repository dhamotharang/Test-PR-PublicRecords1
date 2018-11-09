IMPORT SALT37;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_BizHead)
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 company_name_prefix_Invalid;
    UNSIGNED1 cnp_name_Invalid;
    UNSIGNED1 company_fein_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 city_clean_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 company_url_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 fname_preferred_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 contact_email_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BizHead)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BizHead) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT37.StrType)le.company_name);
      clean_company_name := (TYPEOF(le.company_name))Fields.Make_company_name((SALT37.StrType)le.company_name);
      clean_company_name_Invalid := Fields.InValid_company_name((SALT37.StrType)clean_company_name);
      SELF.company_name := IF(withOnfail, clean_company_name, le.company_name); // ONFAIL(CLEAN)
    SELF.company_name_prefix_Invalid := Fields.InValid_company_name_prefix((SALT37.StrType)le.company_name_prefix);
      clean_company_name_prefix := (TYPEOF(le.company_name_prefix))Fields.Make_company_name_prefix((SALT37.StrType)le.company_name_prefix);
      clean_company_name_prefix_Invalid := Fields.InValid_company_name_prefix((SALT37.StrType)clean_company_name_prefix);
      SELF.company_name_prefix := IF(withOnfail, clean_company_name_prefix, le.company_name_prefix); // ONFAIL(CLEAN)
    SELF.cnp_name_Invalid := Fields.InValid_cnp_name((SALT37.StrType)le.cnp_name);
      clean_cnp_name := (TYPEOF(le.cnp_name))Fields.Make_cnp_name((SALT37.StrType)le.cnp_name);
      clean_cnp_name_Invalid := Fields.InValid_cnp_name((SALT37.StrType)clean_cnp_name);
      SELF.cnp_name := IF(withOnfail, clean_cnp_name, le.cnp_name); // ONFAIL(CLEAN)
    SELF.company_fein_Invalid := Fields.InValid_company_fein((SALT37.StrType)le.company_fein);
      SELF.company_fein := IF(SELF.company_fein_Invalid=0 OR NOT withOnfail, le.company_fein, (TYPEOF(le.company_fein))''); // ONFAIL(BLANK)
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT37.StrType)le.prim_name);
      clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT37.StrType)le.prim_name);
      clean_prim_name_Invalid := Fields.InValid_prim_name((SALT37.StrType)clean_prim_name);
      SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT37.StrType)le.sec_range);
      clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT37.StrType)le.sec_range);
      clean_sec_range_Invalid := Fields.InValid_sec_range((SALT37.StrType)clean_sec_range);
      SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.city_Invalid := Fields.InValid_city((SALT37.StrType)le.city);
      clean_city := (TYPEOF(le.city))Fields.Make_city((SALT37.StrType)le.city);
      clean_city_Invalid := Fields.InValid_city((SALT37.StrType)clean_city);
      SELF.city := IF(withOnfail, clean_city, le.city); // ONFAIL(CLEAN)
    SELF.city_clean_Invalid := Fields.InValid_city_clean((SALT37.StrType)le.city_clean);
      clean_city_clean := (TYPEOF(le.city_clean))Fields.Make_city_clean((SALT37.StrType)le.city_clean);
      clean_city_clean_Invalid := Fields.InValid_city_clean((SALT37.StrType)clean_city_clean);
      SELF.city_clean := IF(withOnfail, clean_city_clean, le.city_clean); // ONFAIL(CLEAN)
    SELF.st_Invalid := Fields.InValid_st((SALT37.StrType)le.st);
      clean_st := (TYPEOF(le.st))Fields.Make_st((SALT37.StrType)le.st);
      clean_st_Invalid := Fields.InValid_st((SALT37.StrType)clean_st);
      SELF.st := IF(withOnfail, clean_st, le.st); // ONFAIL(CLEAN)
    SELF.zip_Invalid := Fields.InValid_zip((SALT37.StrType)le.zip);
      clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT37.StrType)le.zip);
      clean_zip_Invalid := Fields.InValid_zip((SALT37.StrType)clean_zip);
      SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.company_url_Invalid := Fields.InValid_company_url((SALT37.StrType)le.company_url);
      clean_company_url := (TYPEOF(le.company_url))Fields.Make_company_url((SALT37.StrType)le.company_url);
      clean_company_url_Invalid := Fields.InValid_company_url((SALT37.StrType)clean_company_url);
      SELF.company_url := IF(withOnfail, clean_company_url, le.company_url); // ONFAIL(CLEAN)
    SELF.fname_Invalid := Fields.InValid_fname((SALT37.StrType)le.fname);
      clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT37.StrType)le.fname);
      clean_fname_Invalid := Fields.InValid_fname((SALT37.StrType)clean_fname);
      SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.fname_preferred_Invalid := Fields.InValid_fname_preferred((SALT37.StrType)le.fname_preferred);
      clean_fname_preferred := (TYPEOF(le.fname_preferred))Fields.Make_fname_preferred((SALT37.StrType)le.fname_preferred);
      clean_fname_preferred_Invalid := Fields.InValid_fname_preferred((SALT37.StrType)clean_fname_preferred);
      SELF.fname_preferred := IF(withOnfail, clean_fname_preferred, le.fname_preferred); // ONFAIL(CLEAN)
    SELF.mname_Invalid := Fields.InValid_mname((SALT37.StrType)le.mname);
      clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT37.StrType)le.mname);
      clean_mname_Invalid := Fields.InValid_mname((SALT37.StrType)clean_mname);
      SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.lname_Invalid := Fields.InValid_lname((SALT37.StrType)le.lname);
      clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT37.StrType)le.lname);
      clean_lname_Invalid := Fields.InValid_lname((SALT37.StrType)clean_lname);
      SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT37.StrType)le.name_suffix);
      clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT37.StrType)le.name_suffix);
      clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT37.StrType)clean_name_suffix);
      SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.contact_email_Invalid := Fields.InValid_contact_email((SALT37.StrType)le.contact_email);
      clean_contact_email := (TYPEOF(le.contact_email))Fields.Make_contact_email((SALT37.StrType)le.contact_email);
      clean_contact_email_Invalid := Fields.InValid_contact_email((SALT37.StrType)clean_contact_email);
      SELF.contact_email := IF(withOnfail, clean_contact_email, le.contact_email); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BizHead);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_name_Invalid << 0 ) + ( le.company_name_prefix_Invalid << 2 ) + ( le.cnp_name_Invalid << 4 ) + ( le.company_fein_Invalid << 6 ) + ( le.prim_name_Invalid << 8 ) + ( le.sec_range_Invalid << 10 ) + ( le.city_Invalid << 12 ) + ( le.city_clean_Invalid << 14 ) + ( le.st_Invalid << 16 ) + ( le.zip_Invalid << 18 ) + ( le.company_url_Invalid << 19 ) + ( le.fname_Invalid << 21 ) + ( le.fname_preferred_Invalid << 23 ) + ( le.mname_Invalid << 25 ) + ( le.lname_Invalid << 27 ) + ( le.name_suffix_Invalid << 29 ) + ( le.contact_email_Invalid << 31 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
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
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.company_name_prefix_Invalid <> RIGHT.company_name_prefix_Invalid OR LEFT.cnp_name_Invalid <> RIGHT.cnp_name_Invalid OR LEFT.company_fein_Invalid <> RIGHT.company_fein_Invalid OR LEFT.prim_name_Invalid <> RIGHT.prim_name_Invalid OR LEFT.sec_range_Invalid <> RIGHT.sec_range_Invalid OR LEFT.city_Invalid <> RIGHT.city_Invalid OR LEFT.city_clean_Invalid <> RIGHT.city_clean_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.company_url_Invalid <> RIGHT.company_url_Invalid OR LEFT.fname_Invalid <> RIGHT.fname_Invalid OR LEFT.fname_preferred_Invalid <> RIGHT.fname_preferred_Invalid OR LEFT.mname_Invalid <> RIGHT.mname_Invalid OR LEFT.lname_Invalid <> RIGHT.lname_Invalid OR LEFT.name_suffix_Invalid <> RIGHT.name_suffix_Invalid OR LEFT.contact_email_Invalid <> RIGHT.contact_email_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    company_name_prefix_CAPS_ErrorCount := COUNT(GROUP,h.company_name_prefix_Invalid=1);
    company_name_prefix_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_prefix_Invalid=2);
    company_name_prefix_Total_ErrorCount := COUNT(GROUP,h.company_name_prefix_Invalid>0);
    cnp_name_CAPS_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=1);
    cnp_name_ALLOW_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=2);
    cnp_name_Total_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid>0);
    company_fein_ALLOW_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=1);
    company_fein_LENGTH_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=2);
    company_fein_Total_ErrorCount := COUNT(GROUP,h.company_fein_Invalid>0);
    prim_name_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    sec_range_CAPS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    city_CAPS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    city_clean_CAPS_ErrorCount := COUNT(GROUP,h.city_clean_Invalid=1);
    city_clean_ALLOW_ErrorCount := COUNT(GROUP,h.city_clean_Invalid=2);
    city_clean_Total_ErrorCount := COUNT(GROUP,h.city_clean_Invalid>0);
    st_CAPS_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    company_url_CAPS_ErrorCount := COUNT(GROUP,h.company_url_Invalid=1);
    company_url_ALLOW_ErrorCount := COUNT(GROUP,h.company_url_Invalid=2);
    company_url_Total_ErrorCount := COUNT(GROUP,h.company_url_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    fname_preferred_CAPS_ErrorCount := COUNT(GROUP,h.fname_preferred_Invalid=1);
    fname_preferred_ALLOW_ErrorCount := COUNT(GROUP,h.fname_preferred_Invalid=2);
    fname_preferred_Total_ErrorCount := COUNT(GROUP,h.fname_preferred_Invalid>0);
    mname_CAPS_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    contact_email_CAPS_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_name_Invalid,le.company_name_prefix_Invalid,le.cnp_name_Invalid,le.company_fein_Invalid,le.prim_name_Invalid,le.sec_range_Invalid,le.city_Invalid,le.city_clean_Invalid,le.st_Invalid,le.zip_Invalid,le.company_url_Invalid,le.fname_Invalid,le.fname_preferred_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.contact_email_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_company_name_prefix(le.company_name_prefix_Invalid),Fields.InvalidMessage_cnp_name(le.cnp_name_Invalid),Fields.InvalidMessage_company_fein(le.company_fein_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_city_clean(le.city_clean_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_company_url(le.company_url_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_fname_preferred(le.fname_preferred_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_contact_email(le.contact_email_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_prefix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.cnp_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.company_fein_Invalid,'ALLOW','LENGTH','UNKNOWN')
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
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.company_name,(SALT37.StrType)le.company_name_prefix,(SALT37.StrType)le.cnp_name,(SALT37.StrType)le.company_fein,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.sec_range,(SALT37.StrType)le.city,(SALT37.StrType)le.city_clean,(SALT37.StrType)le.st,(SALT37.StrType)le.zip,(SALT37.StrType)le.company_url,(SALT37.StrType)le.fname,(SALT37.StrType)le.fname_preferred,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname,(SALT37.StrType)le.name_suffix,(SALT37.StrType)le.contact_email,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'company_name:T_ALPHANUM:CAPS','company_name:T_ALPHANUM:ALLOW'
          ,'company_name_prefix:T_ALPHANUM:CAPS','company_name_prefix:T_ALPHANUM:ALLOW'
          ,'cnp_name:T_ALPHANUM:CAPS','cnp_name:T_ALPHANUM:ALLOW'
          ,'company_fein:T_FEIN:ALLOW','company_fein:T_FEIN:LENGTH'
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
          ,'contact_email:T_ALLCAPS:CAPS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
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
          ,Fields.InvalidMessage_contact_email(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount
          ,le.company_name_prefix_CAPS_ErrorCount,le.company_name_prefix_ALLOW_ErrorCount
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount,le.company_fein_LENGTH_ErrorCount
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
          ,le.contact_email_CAPS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount
          ,le.company_name_prefix_CAPS_ErrorCount,le.company_name_prefix_ALLOW_ErrorCount
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount,le.company_fein_LENGTH_ErrorCount
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
          ,le.contact_email_CAPS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,32,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
