IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT BaseSpoofing_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(BaseSpoofing_Layout_PhoneFraud)
    UNSIGNED1 date_file_loaded_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_origin_Invalid;
    UNSIGNED1 id_value_Invalid;
    UNSIGNED1 event_date_Invalid;
    UNSIGNED1 event_time_Invalid;
    UNSIGNED1 date_added_Invalid;
    UNSIGNED1 time_added_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BaseSpoofing_Layout_PhoneFraud)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(BaseSpoofing_Layout_PhoneFraud) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.date_file_loaded_Invalid := BaseSpoofing_Fields.InValid_date_file_loaded((SALT36.StrType)le.date_file_loaded);
    SELF.phone_Invalid := BaseSpoofing_Fields.InValid_phone((SALT36.StrType)le.phone);
      SELF.phone := IF(SELF.phone_Invalid=0 OR NOT withOnfail, le.phone, SKIP); // ONFAIL(REJECT)
    SELF.phone_origin_Invalid := BaseSpoofing_Fields.InValid_phone_origin((SALT36.StrType)le.phone_origin);
      SELF.phone_origin := IF(SELF.phone_origin_Invalid=0 OR NOT withOnfail, le.phone_origin, SKIP); // ONFAIL(REJECT)
    SELF.id_value_Invalid := BaseSpoofing_Fields.InValid_id_value((SALT36.StrType)le.id_value);
    SELF.event_date_Invalid := BaseSpoofing_Fields.InValid_event_date((SALT36.StrType)le.event_date);
    SELF.event_time_Invalid := BaseSpoofing_Fields.InValid_event_time((SALT36.StrType)le.event_time);
    SELF.date_added_Invalid := BaseSpoofing_Fields.InValid_date_added((SALT36.StrType)le.date_added);
    SELF.time_added_Invalid := BaseSpoofing_Fields.InValid_time_added((SALT36.StrType)le.time_added);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),BaseSpoofing_Layout_PhoneFraud);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_file_loaded_Invalid << 0 ) + ( le.phone_Invalid << 1 ) + ( le.phone_origin_Invalid << 3 ) + ( le.id_value_Invalid << 5 ) + ( le.event_date_Invalid << 7 ) + ( le.event_time_Invalid << 8 ) + ( le.date_added_Invalid << 9 ) + ( le.time_added_Invalid << 10 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,BaseSpoofing_Layout_PhoneFraud);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_file_loaded_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.phone_origin_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.id_value_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.event_date_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.event_time_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.time_added_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_file_loaded_CUSTOM_ErrorCount := COUNT(GROUP,h.date_file_loaded_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    phone_origin_ALLOW_ErrorCount := COUNT(GROUP,h.phone_origin_Invalid=1);
    phone_origin_LENGTH_ErrorCount := COUNT(GROUP,h.phone_origin_Invalid=2);
    phone_origin_Total_ErrorCount := COUNT(GROUP,h.phone_origin_Invalid>0);
    id_value_ALLOW_ErrorCount := COUNT(GROUP,h.id_value_Invalid=1);
    id_value_LENGTH_ErrorCount := COUNT(GROUP,h.id_value_Invalid=2);
    id_value_Total_ErrorCount := COUNT(GROUP,h.id_value_Invalid>0);
    event_date_ALLOW_ErrorCount := COUNT(GROUP,h.event_date_Invalid=1);
    event_time_ALLOW_ErrorCount := COUNT(GROUP,h.event_time_Invalid=1);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    time_added_ALLOW_ErrorCount := COUNT(GROUP,h.time_added_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_file_loaded_Invalid,le.phone_Invalid,le.phone_origin_Invalid,le.id_value_Invalid,le.event_date_Invalid,le.event_time_Invalid,le.date_added_Invalid,le.time_added_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BaseSpoofing_Fields.InvalidMessage_date_file_loaded(le.date_file_loaded_Invalid),BaseSpoofing_Fields.InvalidMessage_phone(le.phone_Invalid),BaseSpoofing_Fields.InvalidMessage_phone_origin(le.phone_origin_Invalid),BaseSpoofing_Fields.InvalidMessage_id_value(le.id_value_Invalid),BaseSpoofing_Fields.InvalidMessage_event_date(le.event_date_Invalid),BaseSpoofing_Fields.InvalidMessage_event_time(le.event_time_Invalid),BaseSpoofing_Fields.InvalidMessage_date_added(le.date_added_Invalid),BaseSpoofing_Fields.InvalidMessage_time_added(le.time_added_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_file_loaded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.id_value_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.event_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.event_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.time_added_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_file_loaded','phone','phone_origin','id_value','event_date','event_time','date_added','time_added','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Phone','Invalid_Phone_Origin','Invalid_ID','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.date_file_loaded,(SALT36.StrType)le.phone,(SALT36.StrType)le.phone_origin,(SALT36.StrType)le.id_value,(SALT36.StrType)le.event_date,(SALT36.StrType)le.event_time,(SALT36.StrType)le.date_added,(SALT36.StrType)le.time_added,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'date_file_loaded:Invalid_Date:CUSTOM'
          ,'phone:Invalid_Phone:ALLOW','phone:Invalid_Phone:LENGTH'
          ,'phone_origin:Invalid_Phone_Origin:ALLOW','phone_origin:Invalid_Phone_Origin:LENGTH'
          ,'id_value:Invalid_ID:ALLOW','id_value:Invalid_ID:LENGTH'
          ,'event_date:Invalid_Num:ALLOW'
          ,'event_time:Invalid_Num:ALLOW'
          ,'date_added:Invalid_Num:ALLOW'
          ,'time_added:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,BaseSpoofing_Fields.InvalidMessage_date_file_loaded(1)
          ,BaseSpoofing_Fields.InvalidMessage_phone(1),BaseSpoofing_Fields.InvalidMessage_phone(2)
          ,BaseSpoofing_Fields.InvalidMessage_phone_origin(1),BaseSpoofing_Fields.InvalidMessage_phone_origin(2)
          ,BaseSpoofing_Fields.InvalidMessage_id_value(1),BaseSpoofing_Fields.InvalidMessage_id_value(2)
          ,BaseSpoofing_Fields.InvalidMessage_event_date(1)
          ,BaseSpoofing_Fields.InvalidMessage_event_time(1)
          ,BaseSpoofing_Fields.InvalidMessage_date_added(1)
          ,BaseSpoofing_Fields.InvalidMessage_time_added(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.date_file_loaded_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.phone_origin_ALLOW_ErrorCount,le.phone_origin_LENGTH_ErrorCount
          ,le.id_value_ALLOW_ErrorCount,le.id_value_LENGTH_ErrorCount
          ,le.event_date_ALLOW_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.time_added_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.date_file_loaded_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.phone_origin_ALLOW_ErrorCount,le.phone_origin_LENGTH_ErrorCount
          ,le.id_value_ALLOW_ErrorCount,le.id_value_LENGTH_ErrorCount
          ,le.event_date_ALLOW_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.time_added_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,11,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
