IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File_phonesplus_Base)
    UNSIGNED1 npa_Invalid;
    UNSIGNED1 phone7_Invalid;
    UNSIGNED1 cellphone_Invalid;
    UNSIGNED1 origname_Invalid;
    UNSIGNED1 origzip_Invalid;
    UNSIGNED1 orig_phone_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 orig_listing_type_Invalid;
    UNSIGNED1 orig_phone_type_Invalid;
    UNSIGNED1 orig_phone_usage_Invalid;
    UNSIGNED1 company_Invalid;
    UNSIGNED1 orig_phone_reg_dt_Invalid;
    UNSIGNED1 orig_carrier_name_Invalid;
    UNSIGNED1 orig_conf_score_Invalid;
    UNSIGNED1 append_npa_effective_dt_Invalid;
    UNSIGNED1 append_npa_last_change_dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File_phonesplus_Base)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_File_phonesplus_Base) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.npa_Invalid := Fields.InValid_npa((SALT30.StrType)le.npa);
    SELF.phone7_Invalid := Fields.InValid_phone7((SALT30.StrType)le.phone7);
    SELF.cellphone_Invalid := Fields.InValid_cellphone((SALT30.StrType)le.cellphone);
    SELF.origname_Invalid := Fields.InValid_origname((SALT30.StrType)le.origname);
    SELF.origzip_Invalid := Fields.InValid_origzip((SALT30.StrType)le.origzip);
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT30.StrType)le.orig_phone);
    SELF.dob_Invalid := Fields.InValid_dob((SALT30.StrType)le.dob);
    SELF.gender_Invalid := Fields.InValid_gender((SALT30.StrType)le.gender);
    SELF.orig_listing_type_Invalid := Fields.InValid_orig_listing_type((SALT30.StrType)le.orig_listing_type);
    SELF.orig_phone_type_Invalid := Fields.InValid_orig_phone_type((SALT30.StrType)le.orig_phone_type);
    SELF.orig_phone_usage_Invalid := Fields.InValid_orig_phone_usage((SALT30.StrType)le.orig_phone_usage);
    SELF.company_Invalid := Fields.InValid_company((SALT30.StrType)le.company);
    SELF.orig_phone_reg_dt_Invalid := Fields.InValid_orig_phone_reg_dt((SALT30.StrType)le.orig_phone_reg_dt);
    SELF.orig_carrier_name_Invalid := Fields.InValid_orig_carrier_name((SALT30.StrType)le.orig_carrier_name);
    SELF.orig_conf_score_Invalid := Fields.InValid_orig_conf_score((SALT30.StrType)le.orig_conf_score);
    SELF.append_npa_effective_dt_Invalid := Fields.InValid_append_npa_effective_dt((SALT30.StrType)le.append_npa_effective_dt);
    SELF.append_npa_last_change_dt_Invalid := Fields.InValid_append_npa_last_change_dt((SALT30.StrType)le.append_npa_last_change_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,Into(LEFT));
  EXPORT WithinList1 := DEDUP(SORT(TABLE(npa_list,{npa}),npa),ALL) : PERSIST('~temp::Scrubs_Phonesplus_v2_Base::npa_list::npa',EXPIRE(Config.PersistExpire));
  ExpandedWithinInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.npa=RIGHT.npa AND LEFT.npa_Invalid=0, TRANSFORM(Expanded_Layout, SELF.npa_Invalid:=3,SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile1 := PROJECT(ExpandedWithinInfile1, TRANSFORM(Expanded_Layout, SELF.npa_Invalid:=MAP(LEFT.npa_Invalid=3 => 0, LEFT.npa_Invalid=0 => 3, LEFT.npa_Invalid),SELF:=LEFT));
  EXPORT ExpandedInfile := ExpandedInfile1;
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.npa_Invalid << 0 ) + ( le.phone7_Invalid << 2 ) + ( le.cellphone_Invalid << 3 ) + ( le.origname_Invalid << 4 ) + ( le.origzip_Invalid << 6 ) + ( le.orig_phone_Invalid << 8 ) + ( le.dob_Invalid << 9 ) + ( le.gender_Invalid << 11 ) + ( le.orig_listing_type_Invalid << 12 ) + ( le.orig_phone_type_Invalid << 13 ) + ( le.orig_phone_usage_Invalid << 14 ) + ( le.company_Invalid << 15 ) + ( le.orig_phone_reg_dt_Invalid << 16 ) + ( le.orig_carrier_name_Invalid << 18 ) + ( le.orig_conf_score_Invalid << 19 ) + ( le.append_npa_effective_dt_Invalid << 20 ) + ( le.append_npa_last_change_dt_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File_phonesplus_Base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.npa_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.phone7_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.cellphone_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.origname_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.origzip_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_phone_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_listing_type_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_phone_type_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_phone_usage_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.company_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_phone_reg_dt_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_carrier_name_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_conf_score_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.append_npa_effective_dt_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.append_npa_last_change_dt_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    npa_ALLOW_ErrorCount := COUNT(GROUP,h.npa_Invalid=1);
    npa_LENGTH_ErrorCount := COUNT(GROUP,h.npa_Invalid=2);
    npa_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.npa_Invalid=3);
    npa_Total_ErrorCount := COUNT(GROUP,h.npa_Invalid>0);
    phone7_ALLOW_ErrorCount := COUNT(GROUP,h.phone7_Invalid=1);
    cellphone_ALLOW_ErrorCount := COUNT(GROUP,h.cellphone_Invalid=1);
    origname_ALLOW_ErrorCount := COUNT(GROUP,h.origname_Invalid=1);
    origname_LENGTH_ErrorCount := COUNT(GROUP,h.origname_Invalid=2);
    origname_Total_ErrorCount := COUNT(GROUP,h.origname_Invalid>0);
    origzip_ALLOW_ErrorCount := COUNT(GROUP,h.origzip_Invalid=1);
    origzip_LENGTH_ErrorCount := COUNT(GROUP,h.origzip_Invalid=2);
    origzip_Total_ErrorCount := COUNT(GROUP,h.origzip_Invalid>0);
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    orig_listing_type_ALLOW_ErrorCount := COUNT(GROUP,h.orig_listing_type_Invalid=1);
    orig_phone_type_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_type_Invalid=1);
    orig_phone_usage_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_usage_Invalid=1);
    company_ALLOW_ErrorCount := COUNT(GROUP,h.company_Invalid=1);
    orig_phone_reg_dt_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_reg_dt_Invalid=1);
    orig_phone_reg_dt_LENGTH_ErrorCount := COUNT(GROUP,h.orig_phone_reg_dt_Invalid=2);
    orig_phone_reg_dt_Total_ErrorCount := COUNT(GROUP,h.orig_phone_reg_dt_Invalid>0);
    orig_carrier_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_carrier_name_Invalid=1);
    orig_conf_score_ALLOW_ErrorCount := COUNT(GROUP,h.orig_conf_score_Invalid=1);
    append_npa_effective_dt_ALLOW_ErrorCount := COUNT(GROUP,h.append_npa_effective_dt_Invalid=1);
    append_npa_effective_dt_LENGTH_ErrorCount := COUNT(GROUP,h.append_npa_effective_dt_Invalid=2);
    append_npa_effective_dt_Total_ErrorCount := COUNT(GROUP,h.append_npa_effective_dt_Invalid>0);
    append_npa_last_change_dt_ALLOW_ErrorCount := COUNT(GROUP,h.append_npa_last_change_dt_Invalid=1);
    append_npa_last_change_dt_LENGTH_ErrorCount := COUNT(GROUP,h.append_npa_last_change_dt_Invalid=2);
    append_npa_last_change_dt_Total_ErrorCount := COUNT(GROUP,h.append_npa_last_change_dt_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,vendor,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.npa_Invalid,le.phone7_Invalid,le.cellphone_Invalid,le.origname_Invalid,le.origzip_Invalid,le.orig_phone_Invalid,le.dob_Invalid,le.gender_Invalid,le.orig_listing_type_Invalid,le.orig_phone_type_Invalid,le.orig_phone_usage_Invalid,le.company_Invalid,le.orig_phone_reg_dt_Invalid,le.orig_carrier_name_Invalid,le.orig_conf_score_Invalid,le.append_npa_effective_dt_Invalid,le.append_npa_last_change_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_npa(le.npa_Invalid),Fields.InvalidMessage_phone7(le.phone7_Invalid),Fields.InvalidMessage_cellphone(le.cellphone_Invalid),Fields.InvalidMessage_origname(le.origname_Invalid),Fields.InvalidMessage_origzip(le.origzip_Invalid),Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_orig_listing_type(le.orig_listing_type_Invalid),Fields.InvalidMessage_orig_phone_type(le.orig_phone_type_Invalid),Fields.InvalidMessage_orig_phone_usage(le.orig_phone_usage_Invalid),Fields.InvalidMessage_company(le.company_Invalid),Fields.InvalidMessage_orig_phone_reg_dt(le.orig_phone_reg_dt_Invalid),Fields.InvalidMessage_orig_carrier_name(le.orig_carrier_name_Invalid),Fields.InvalidMessage_orig_conf_score(le.orig_conf_score_Invalid),Fields.InvalidMessage_append_npa_effective_dt(le.append_npa_effective_dt_Invalid),Fields.InvalidMessage_append_npa_last_change_dt(le.append_npa_last_change_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.npa_Invalid,'ALLOW','LENGTH','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.phone7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cellphone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.origname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.origzip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_listing_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_phone_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_phone_usage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_phone_reg_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_carrier_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_conf_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_npa_effective_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.append_npa_last_change_dt_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'npa','phone7','cellphone','origname','origzip','orig_phone','dob','gender','orig_listing_type','orig_phone_type','orig_phone_usage','company','orig_phone_reg_dt','orig_carrier_name','orig_conf_score','append_npa_effective_dt','append_npa_last_change_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'npa','phone','phone','alpha','zip','phone','date','sex','Listing_type','phone_type','phone_Usage','Comp_name','date_alt','Comp_name','conf_score','date','date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.npa,(SALT30.StrType)le.phone7,(SALT30.StrType)le.cellphone,(SALT30.StrType)le.origname,(SALT30.StrType)le.origzip,(SALT30.StrType)le.orig_phone,(SALT30.StrType)le.dob,(SALT30.StrType)le.gender,(SALT30.StrType)le.orig_listing_type,(SALT30.StrType)le.orig_phone_type,(SALT30.StrType)le.orig_phone_usage,(SALT30.StrType)le.company,(SALT30.StrType)le.orig_phone_reg_dt,(SALT30.StrType)le.orig_carrier_name,(SALT30.StrType)le.orig_conf_score,(SALT30.StrType)le.append_npa_effective_dt,(SALT30.StrType)le.append_npa_last_change_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := CHOOSE(c
          ,'npa:npa:ALLOW','npa:npa:LENGTH','npa:npa:WITHIN_FILE'
          ,'phone7:phone:ALLOW'
          ,'cellphone:phone:ALLOW'
          ,'origname:alpha:ALLOW','origname:alpha:LENGTH'
          ,'origzip:zip:ALLOW','origzip:zip:LENGTH'
          ,'orig_phone:phone:ALLOW'
          ,'dob:date:ALLOW','dob:date:LENGTH'
          ,'gender:sex:ENUM'
          ,'orig_listing_type:Listing_type:ALLOW'
          ,'orig_phone_type:phone_type:ALLOW'
          ,'orig_phone_usage:phone_Usage:ALLOW'
          ,'company:Comp_name:ALLOW'
          ,'orig_phone_reg_dt:date_alt:ALLOW','orig_phone_reg_dt:date_alt:LENGTH'
          ,'orig_carrier_name:Comp_name:ALLOW'
          ,'orig_conf_score:conf_score:ALLOW'
          ,'append_npa_effective_dt:date:ALLOW','append_npa_effective_dt:date:LENGTH'
          ,'append_npa_last_change_dt:date:ALLOW','append_npa_last_change_dt:date:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.npa_ALLOW_ErrorCount,le.npa_LENGTH_ErrorCount,le.npa_WITHIN_FILE_ErrorCount
          ,le.phone7_ALLOW_ErrorCount
          ,le.cellphone_ALLOW_ErrorCount
          ,le.origname_ALLOW_ErrorCount,le.origname_LENGTH_ErrorCount
          ,le.origzip_ALLOW_ErrorCount,le.origzip_LENGTH_ErrorCount
          ,le.orig_phone_ALLOW_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.orig_listing_type_ALLOW_ErrorCount
          ,le.orig_phone_type_ALLOW_ErrorCount
          ,le.orig_phone_usage_ALLOW_ErrorCount
          ,le.company_ALLOW_ErrorCount
          ,le.orig_phone_reg_dt_ALLOW_ErrorCount,le.orig_phone_reg_dt_LENGTH_ErrorCount
          ,le.orig_carrier_name_ALLOW_ErrorCount
          ,le.orig_conf_score_ALLOW_ErrorCount
          ,le.append_npa_effective_dt_ALLOW_ErrorCount,le.append_npa_effective_dt_LENGTH_ErrorCount
          ,le.append_npa_last_change_dt_ALLOW_ErrorCount,le.append_npa_last_change_dt_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.npa_ALLOW_ErrorCount,le.npa_LENGTH_ErrorCount,le.npa_WITHIN_FILE_ErrorCount
          ,le.phone7_ALLOW_ErrorCount
          ,le.cellphone_ALLOW_ErrorCount
          ,le.origname_ALLOW_ErrorCount,le.origname_LENGTH_ErrorCount
          ,le.origzip_ALLOW_ErrorCount,le.origzip_LENGTH_ErrorCount
          ,le.orig_phone_ALLOW_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.orig_listing_type_ALLOW_ErrorCount
          ,le.orig_phone_type_ALLOW_ErrorCount
          ,le.orig_phone_usage_ALLOW_ErrorCount
          ,le.company_ALLOW_ErrorCount
          ,le.orig_phone_reg_dt_ALLOW_ErrorCount,le.orig_phone_reg_dt_LENGTH_ErrorCount
          ,le.orig_carrier_name_ALLOW_ErrorCount
          ,le.orig_conf_score_ALLOW_ErrorCount
          ,le.append_npa_effective_dt_ALLOW_ErrorCount,le.append_npa_effective_dt_LENGTH_ErrorCount
          ,le.append_npa_last_change_dt_ALLOW_ErrorCount,le.append_npa_last_change_dt_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,25,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
