IMPORT SALT37;
EXPORT MasterIdIndTypeIncl_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl)
    UNSIGNED1 fdn_ind_type_gc_id_inclusion_Invalid;
    UNSIGNED1 fdn_file_info_id_Invalid;
    UNSIGNED1 ind_type_Invalid;
    UNSIGNED1 inclusion_id_Invalid;
    UNSIGNED1 inclusion_type_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 date_added_Invalid;
    UNSIGNED1 user_added_Invalid;
    UNSIGNED1 date_changed_Invalid;
    UNSIGNED1 user_changed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fdn_ind_type_gc_id_inclusion_Invalid := MasterIdIndTypeIncl_Fields.InValid_fdn_ind_type_gc_id_inclusion((SALT37.StrType)le.fdn_ind_type_gc_id_inclusion);
    SELF.fdn_file_info_id_Invalid := MasterIdIndTypeIncl_Fields.InValid_fdn_file_info_id((SALT37.StrType)le.fdn_file_info_id);
    SELF.ind_type_Invalid := MasterIdIndTypeIncl_Fields.InValid_ind_type((SALT37.StrType)le.ind_type);
    SELF.inclusion_id_Invalid := MasterIdIndTypeIncl_Fields.InValid_inclusion_id((SALT37.StrType)le.inclusion_id);
    SELF.inclusion_type_Invalid := MasterIdIndTypeIncl_Fields.InValid_inclusion_type((SALT37.StrType)le.inclusion_type);
    SELF.status_Invalid := MasterIdIndTypeIncl_Fields.InValid_status((SALT37.StrType)le.status);
    SELF.date_added_Invalid := MasterIdIndTypeIncl_Fields.InValid_date_added((SALT37.StrType)le.date_added);
    SELF.user_added_Invalid := MasterIdIndTypeIncl_Fields.InValid_user_added((SALT37.StrType)le.user_added);
    SELF.date_changed_Invalid := MasterIdIndTypeIncl_Fields.InValid_date_changed((SALT37.StrType)le.date_changed);
    SELF.user_changed_Invalid := MasterIdIndTypeIncl_Fields.InValid_user_changed((SALT37.StrType)le.user_changed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fdn_ind_type_gc_id_inclusion_Invalid << 0 ) + ( le.fdn_file_info_id_Invalid << 1 ) + ( le.ind_type_Invalid << 2 ) + ( le.inclusion_id_Invalid << 3 ) + ( le.inclusion_type_Invalid << 4 ) + ( le.status_Invalid << 5 ) + ( le.date_added_Invalid << 6 ) + ( le.user_added_Invalid << 7 ) + ( le.date_changed_Invalid << 8 ) + ( le.user_changed_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fdn_ind_type_gc_id_inclusion_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fdn_file_info_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.ind_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.inclusion_id_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.inclusion_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.user_added_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.date_changed_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.user_changed_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_ind_type_gc_id_inclusion_Invalid=1);
    fdn_file_info_id_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_file_info_id_Invalid=1);
    ind_type_ALLOW_ErrorCount := COUNT(GROUP,h.ind_type_Invalid=1);
    inclusion_id_ALLOW_ErrorCount := COUNT(GROUP,h.inclusion_id_Invalid=1);
    inclusion_type_ALLOW_ErrorCount := COUNT(GROUP,h.inclusion_type_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    user_added_ALLOW_ErrorCount := COUNT(GROUP,h.user_added_Invalid=1);
    date_changed_ALLOW_ErrorCount := COUNT(GROUP,h.date_changed_Invalid=1);
    user_changed_ALLOW_ErrorCount := COUNT(GROUP,h.user_changed_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.fdn_ind_type_gc_id_inclusion_Invalid,le.fdn_file_info_id_Invalid,le.ind_type_Invalid,le.inclusion_id_Invalid,le.inclusion_type_Invalid,le.status_Invalid,le.date_added_Invalid,le.user_added_Invalid,le.date_changed_Invalid,le.user_changed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_ind_type_gc_id_inclusion(le.fdn_ind_type_gc_id_inclusion_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_file_info_id(le.fdn_file_info_id_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_ind_type(le.ind_type_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_id(le.inclusion_id_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_type(le.inclusion_type_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_status(le.status_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_date_added(le.date_added_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_user_added(le.user_added_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_date_changed(le.date_changed_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_user_changed(le.user_changed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fdn_ind_type_gc_id_inclusion_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fdn_file_info_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ind_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inclusion_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inclusion_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.user_added_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_changed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.user_changed_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.fdn_ind_type_gc_id_inclusion,(SALT37.StrType)le.fdn_file_info_id,(SALT37.StrType)le.ind_type,(SALT37.StrType)le.inclusion_id,(SALT37.StrType)le.inclusion_type,(SALT37.StrType)le.status,(SALT37.StrType)le.date_added,(SALT37.StrType)le.user_added,(SALT37.StrType)le.date_changed,(SALT37.StrType)le.user_changed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'fdn_ind_type_gc_id_inclusion:invalid_numeric:ALLOW'
          ,'fdn_file_info_id:invalid_numeric:ALLOW'
          ,'ind_type:invalid_numeric:ALLOW'
          ,'inclusion_id:invalid_numeric:ALLOW'
          ,'inclusion_type:invalid_alphanumeric:ALLOW'
          ,'status:invalid_numeric:ALLOW'
          ,'date_added:invalid_alphanumeric:ALLOW'
          ,'user_added:invalid_alphanumeric:ALLOW'
          ,'date_changed:invalid_alphanumeric:ALLOW'
          ,'user_changed:invalid_alphanumeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_ind_type_gc_id_inclusion(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_file_info_id(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_ind_type(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_id(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_type(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_status(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_date_added(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_user_added(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_date_changed(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_user_changed(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.ind_type_ALLOW_ErrorCount
          ,le.inclusion_id_ALLOW_ErrorCount
          ,le.inclusion_type_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.user_added_ALLOW_ErrorCount
          ,le.date_changed_ALLOW_ErrorCount
          ,le.user_changed_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.ind_type_ALLOW_ErrorCount
          ,le.inclusion_id_ALLOW_ErrorCount
          ,le.inclusion_type_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.user_added_ALLOW_ErrorCount
          ,le.date_changed_ALLOW_ErrorCount
          ,le.user_changed_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,10,Into(LEFT,COUNTER));
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
