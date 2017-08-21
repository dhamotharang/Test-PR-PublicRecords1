IMPORT ut,SALT35;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_BASE)
    UNSIGNED1 isContact_Invalid;
    UNSIGNED1 active_duns_number_Invalid;
    UNSIGNED1 active_enterprise_number_Invalid;
    UNSIGNED1 ebr_file_number_Invalid;
    UNSIGNED1 active_domestic_corp_key_Invalid;
    UNSIGNED1 foreign_corp_key_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid; 
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 company_fein_Invalid;
    UNSIGNED1 company_phone_Invalid;
    UNSIGNED1 company_inc_state_Invalid;
    UNSIGNED1 company_charter_number_Invalid;
    UNSIGNED1 contact_ssn_Invalid;
    UNSIGNED1 contact_email_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BASE)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BASE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.isContact_Invalid := Fields.InValid_isContact((SALT35.StrType)le.isContact);
    SELF.active_duns_number_Invalid := Fields.InValid_active_duns_number((SALT35.StrType)le.active_duns_number);
    SELF.active_enterprise_number_Invalid := Fields.InValid_active_enterprise_number((SALT35.StrType)le.active_enterprise_number);
    SELF.ebr_file_number_Invalid := Fields.InValid_ebr_file_number((SALT35.StrType)le.ebr_file_number);
    SELF.active_domestic_corp_key_Invalid := Fields.InValid_active_domestic_corp_key((SALT35.StrType)le.active_domestic_corp_key);
    SELF.foreign_corp_key_Invalid := Fields.InValid_foreign_corp_key((SALT35.StrType)le.foreign_corp_key);
    SELF.fname_Invalid := Fields.InValid_fname((SALT35.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT35.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT35.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT35.StrType)le.name_suffix);
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT35.StrType)le.company_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT35.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT35.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT35.StrType)le.zip4);
    SELF.company_fein_Invalid := Fields.InValid_company_fein((SALT35.StrType)le.company_fein);
    SELF.company_phone_Invalid := Fields.InValid_company_phone((SALT35.StrType)le.company_phone);
    SELF.company_inc_state_Invalid := Fields.InValid_company_inc_state((SALT35.StrType)le.company_inc_state);
    SELF.company_charter_number_Invalid := Fields.InValid_company_charter_number((SALT35.StrType)le.company_charter_number);
    SELF.contact_ssn_Invalid := Fields.InValid_contact_ssn((SALT35.StrType)le.contact_ssn);
    SELF.contact_email_Invalid := Fields.InValid_contact_email((SALT35.StrType)le.contact_email);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BASE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.isContact_Invalid << 0 ) + ( le.active_duns_number_Invalid << 2 ) + ( le.active_enterprise_number_Invalid << 4 ) + ( le.ebr_file_number_Invalid << 6 ) + ( le.active_domestic_corp_key_Invalid << 8 ) + ( le.foreign_corp_key_Invalid << 10 ) + ( le.fname_Invalid << 12 ) + ( le.mname_Invalid << 13 ) + ( le.lname_Invalid << 14 ) + ( le.name_suffix_Invalid << 15 ) + ( le.company_name_Invalid << 16 ) + ( le.v_city_name_Invalid << 17 ) + ( le.st_Invalid << 19 ) + ( le.zip_Invalid << 21 ) + ( le.zip4_Invalid << 23 ) + ( le.company_fein_Invalid << 25 ) + ( le.company_phone_Invalid << 26 ) + ( le.company_inc_state_Invalid << 27 ) + ( le.company_charter_number_Invalid << 29 ) + ( le.contact_ssn_Invalid << 30 ) + ( le.contact_email_Invalid << 32 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_BASE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.isContact_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.active_duns_number_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.active_enterprise_number_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.ebr_file_number_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.active_domestic_corp_key_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.foreign_corp_key_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.company_fein_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.company_phone_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.company_inc_state_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.company_charter_number_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.contact_ssn_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.contact_email_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.isContact_Invalid <> RIGHT.isContact_Invalid OR LEFT.active_duns_number_Invalid <> RIGHT.active_duns_number_Invalid OR LEFT.active_enterprise_number_Invalid <> RIGHT.active_enterprise_number_Invalid OR LEFT.ebr_file_number_Invalid <> RIGHT.ebr_file_number_Invalid OR LEFT.active_domestic_corp_key_Invalid <> RIGHT.active_domestic_corp_key_Invalid OR LEFT.foreign_corp_key_Invalid <> RIGHT.foreign_corp_key_Invalid OR LEFT.fname_Invalid <> RIGHT.fname_Invalid OR LEFT.mname_Invalid <> RIGHT.mname_Invalid OR LEFT.lname_Invalid <> RIGHT.lname_Invalid OR LEFT.name_suffix_Invalid <> RIGHT.name_suffix_Invalid OR LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.v_city_name_Invalid <> RIGHT.v_city_name_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.zip4_Invalid <> RIGHT.zip4_Invalid OR LEFT.company_fein_Invalid <> RIGHT.company_fein_Invalid OR LEFT.company_phone_Invalid <> RIGHT.company_phone_Invalid OR LEFT.company_inc_state_Invalid <> RIGHT.company_inc_state_Invalid OR LEFT.company_charter_number_Invalid <> RIGHT.company_charter_number_Invalid OR LEFT.contact_ssn_Invalid <> RIGHT.contact_ssn_Invalid OR LEFT.contact_email_Invalid <> RIGHT.contact_email_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    isContact_ALLOW_ErrorCount := COUNT(GROUP,h.isContact_Invalid=1);
    isContact_LENGTH_ErrorCount := COUNT(GROUP,h.isContact_Invalid=2);
    isContact_Total_ErrorCount := COUNT(GROUP,h.isContact_Invalid>0);
    active_duns_number_ALLOW_ErrorCount := COUNT(GROUP,h.active_duns_number_Invalid=1);
    active_duns_number_LENGTH_ErrorCount := COUNT(GROUP,h.active_duns_number_Invalid=2);
    active_duns_number_Total_ErrorCount := COUNT(GROUP,h.active_duns_number_Invalid>0);
    active_enterprise_number_ALLOW_ErrorCount := COUNT(GROUP,h.active_enterprise_number_Invalid=1);
    active_enterprise_number_LENGTH_ErrorCount := COUNT(GROUP,h.active_enterprise_number_Invalid=2);
    active_enterprise_number_Total_ErrorCount := COUNT(GROUP,h.active_enterprise_number_Invalid>0);
    ebr_file_number_ALLOW_ErrorCount := COUNT(GROUP,h.ebr_file_number_Invalid=1);
    ebr_file_number_LENGTH_ErrorCount := COUNT(GROUP,h.ebr_file_number_Invalid=2);
    ebr_file_number_Total_ErrorCount := COUNT(GROUP,h.ebr_file_number_Invalid>0);
    active_domestic_corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.active_domestic_corp_key_Invalid=1);
    active_domestic_corp_key_CUSTOM_ErrorCount := COUNT(GROUP,h.active_domestic_corp_key_Invalid=2);
    active_domestic_corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.active_domestic_corp_key_Invalid=3);
    active_domestic_corp_key_Total_ErrorCount := COUNT(GROUP,h.active_domestic_corp_key_Invalid>0);
    foreign_corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.foreign_corp_key_Invalid=1);
    foreign_corp_key_CUSTOM_ErrorCount := COUNT(GROUP,h.foreign_corp_key_Invalid=2);
    foreign_corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.foreign_corp_key_Invalid=3);
    foreign_corp_key_Total_ErrorCount := COUNT(GROUP,h.foreign_corp_key_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    company_name_LENGTH_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    company_fein_ALLOW_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=1);
    company_phone_ALLOW_ErrorCount := COUNT(GROUP,h.company_phone_Invalid=1);
    company_inc_state_ALLOW_ErrorCount := COUNT(GROUP,h.company_inc_state_Invalid=1);
    company_inc_state_LENGTH_ErrorCount := COUNT(GROUP,h.company_inc_state_Invalid=2);
    company_inc_state_Total_ErrorCount := COUNT(GROUP,h.company_inc_state_Invalid>0);
    company_charter_number_ALLOW_ErrorCount := COUNT(GROUP,h.company_charter_number_Invalid=1);
    contact_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=1);
    contact_ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=2);
    contact_ssn_Total_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid>0);
    contact_email_ALLOW_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=1);
    contact_email_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=2);
    contact_email_LENGTH_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=3);
    contact_email_Total_ErrorCount := COUNT(GROUP,h.contact_email_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.isContact_Invalid,le.active_duns_number_Invalid,le.active_enterprise_number_Invalid,le.ebr_file_number_Invalid,le.active_domestic_corp_key_Invalid,le.foreign_corp_key_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.company_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.company_fein_Invalid,le.company_phone_Invalid,le.company_inc_state_Invalid,le.company_charter_number_Invalid,le.contact_ssn_Invalid,le.contact_email_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_isContact(le.isContact_Invalid),Fields.InvalidMessage_active_duns_number(le.active_duns_number_Invalid),Fields.InvalidMessage_active_enterprise_number(le.active_enterprise_number_Invalid),Fields.InvalidMessage_ebr_file_number(le.ebr_file_number_Invalid),Fields.InvalidMessage_active_domestic_corp_key(le.active_domestic_corp_key_Invalid),Fields.InvalidMessage_foreign_corp_key(le.foreign_corp_key_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_company_fein(le.company_fein_Invalid),Fields.InvalidMessage_company_phone(le.company_phone_Invalid),Fields.InvalidMessage_company_inc_state(le.company_inc_state_Invalid),Fields.InvalidMessage_company_charter_number(le.company_charter_number_Invalid),Fields.InvalidMessage_contact_ssn(le.contact_ssn_Invalid),Fields.InvalidMessage_contact_email(le.contact_email_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.isContact_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.active_duns_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.active_enterprise_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ebr_file_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.active_domestic_corp_key_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.foreign_corp_key_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.company_fein_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_inc_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.company_charter_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_ssn_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_email_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'isContact','active_duns_number','active_enterprise_number','ebr_file_number','active_domestic_corp_key','foreign_corp_key','fname','mname','lname','name_suffix','company_name','v_city_name','st','zip','zip4','company_fein','company_phone','company_inc_state','company_charter_number','contact_ssn','contact_email','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'fld_contact','number09','number9','number09','CORPKEY_FMT','CORPKEY_FMT','NAME','NAME','NAME','WORDSTR','Noblanks','CITY','alpha_st','zip5','hasZip4','number','number','alpha02','NAME','SSN_FMT','EMAIL_FMT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.isContact,(SALT35.StrType)le.active_duns_number,(SALT35.StrType)le.active_enterprise_number,(SALT35.StrType)le.ebr_file_number,(SALT35.StrType)le.active_domestic_corp_key,(SALT35.StrType)le.foreign_corp_key,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname,(SALT35.StrType)le.lname,(SALT35.StrType)le.name_suffix,(SALT35.StrType)le.company_name,(SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip,(SALT35.StrType)le.zip4,(SALT35.StrType)le.company_fein,(SALT35.StrType)le.company_phone,(SALT35.StrType)le.company_inc_state,(SALT35.StrType)le.company_charter_number,(SALT35.StrType)le.contact_ssn,(SALT35.StrType)le.contact_email,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,21,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'isContact:fld_contact:ALLOW','isContact:fld_contact:LENGTH'
          ,'active_duns_number:number09:ALLOW','active_duns_number:number09:LENGTH'
          ,'active_enterprise_number:number9:ALLOW','active_enterprise_number:number9:LENGTH'
          ,'ebr_file_number:number09:ALLOW','ebr_file_number:number09:LENGTH'
          ,'active_domestic_corp_key:CORPKEY_FMT:ALLOW','active_domestic_corp_key:CORPKEY_FMT:CUSTOM','active_domestic_corp_key:CORPKEY_FMT:LENGTH'
          ,'foreign_corp_key:CORPKEY_FMT:ALLOW','foreign_corp_key:CORPKEY_FMT:CUSTOM','foreign_corp_key:CORPKEY_FMT:LENGTH'
          ,'fname:NAME:ALLOW'
          ,'mname:NAME:ALLOW'
          ,'lname:NAME:ALLOW'
          ,'name_suffix:WORDSTR:ALLOW'
          ,'company_name:Noblanks:LENGTH'
          ,'v_city_name:CITY:ALLOW','v_city_name:CITY:LENGTH'
          ,'st:alpha_st:ALLOW','st:alpha_st:LENGTH'
          ,'zip:zip5:ALLOW','zip:zip5:LENGTH'
          ,'zip4:hasZip4:ALLOW','zip4:hasZip4:LENGTH'
          ,'company_fein:number:ALLOW'
          ,'company_phone:number:ALLOW'
          ,'company_inc_state:alpha02:ALLOW','company_inc_state:alpha02:LENGTH'
          ,'company_charter_number:NAME:ALLOW'
          ,'contact_ssn:SSN_FMT:ALLOW','contact_ssn:SSN_FMT:CUSTOM'
          ,'contact_email:EMAIL_FMT:ALLOW','contact_email:EMAIL_FMT:CUSTOM','contact_email:EMAIL_FMT:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_isContact(1),Fields.InvalidMessage_isContact(2)
          ,Fields.InvalidMessage_active_duns_number(1),Fields.InvalidMessage_active_duns_number(2)
          ,Fields.InvalidMessage_active_enterprise_number(1),Fields.InvalidMessage_active_enterprise_number(2)
          ,Fields.InvalidMessage_ebr_file_number(1),Fields.InvalidMessage_ebr_file_number(2)
          ,Fields.InvalidMessage_active_domestic_corp_key(1),Fields.InvalidMessage_active_domestic_corp_key(2),Fields.InvalidMessage_active_domestic_corp_key(3)
          ,Fields.InvalidMessage_foreign_corp_key(1),Fields.InvalidMessage_foreign_corp_key(2),Fields.InvalidMessage_foreign_corp_key(3)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_company_name(1)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_company_fein(1)
          ,Fields.InvalidMessage_company_phone(1)
          ,Fields.InvalidMessage_company_inc_state(1),Fields.InvalidMessage_company_inc_state(2)
          ,Fields.InvalidMessage_company_charter_number(1)
          ,Fields.InvalidMessage_contact_ssn(1),Fields.InvalidMessage_contact_ssn(2)
          ,Fields.InvalidMessage_contact_email(1),Fields.InvalidMessage_contact_email(2),Fields.InvalidMessage_contact_email(3),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.isContact_ALLOW_ErrorCount,le.isContact_LENGTH_ErrorCount
          ,le.active_duns_number_ALLOW_ErrorCount,le.active_duns_number_LENGTH_ErrorCount
          ,le.active_enterprise_number_ALLOW_ErrorCount,le.active_enterprise_number_LENGTH_ErrorCount
          ,le.ebr_file_number_ALLOW_ErrorCount,le.ebr_file_number_LENGTH_ErrorCount
          ,le.active_domestic_corp_key_ALLOW_ErrorCount,le.active_domestic_corp_key_CUSTOM_ErrorCount,le.active_domestic_corp_key_LENGTH_ErrorCount
          ,le.foreign_corp_key_ALLOW_ErrorCount,le.foreign_corp_key_CUSTOM_ErrorCount,le.foreign_corp_key_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.company_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount
          ,le.company_phone_ALLOW_ErrorCount
          ,le.company_inc_state_ALLOW_ErrorCount,le.company_inc_state_LENGTH_ErrorCount
          ,le.company_charter_number_ALLOW_ErrorCount
          ,le.contact_ssn_ALLOW_ErrorCount,le.contact_ssn_CUSTOM_ErrorCount
          ,le.contact_email_ALLOW_ErrorCount,le.contact_email_CUSTOM_ErrorCount,le.contact_email_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.isContact_ALLOW_ErrorCount,le.isContact_LENGTH_ErrorCount
          ,le.active_duns_number_ALLOW_ErrorCount,le.active_duns_number_LENGTH_ErrorCount
          ,le.active_enterprise_number_ALLOW_ErrorCount,le.active_enterprise_number_LENGTH_ErrorCount
          ,le.ebr_file_number_ALLOW_ErrorCount,le.ebr_file_number_LENGTH_ErrorCount
          ,le.active_domestic_corp_key_ALLOW_ErrorCount,le.active_domestic_corp_key_CUSTOM_ErrorCount,le.active_domestic_corp_key_LENGTH_ErrorCount
          ,le.foreign_corp_key_ALLOW_ErrorCount,le.foreign_corp_key_CUSTOM_ErrorCount,le.foreign_corp_key_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.company_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount
          ,le.company_phone_ALLOW_ErrorCount
          ,le.company_inc_state_ALLOW_ErrorCount,le.company_inc_state_LENGTH_ErrorCount
          ,le.company_charter_number_ALLOW_ErrorCount
          ,le.contact_ssn_ALLOW_ErrorCount,le.contact_ssn_CUSTOM_ErrorCount
          ,le.contact_email_ALLOW_ErrorCount,le.contact_email_CUSTOM_ErrorCount,le.contact_email_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,37,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT35.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT35.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
