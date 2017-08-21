IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RawSpoofing_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(RawSpoofing_Layout_PhoneFraud)
    UNSIGNED1 id_value_Invalid;
    UNSIGNED1 event_time_Invalid;
    UNSIGNED1 spoofed_phone_number_Invalid;
    UNSIGNED1 destination_number_Invalid;
    UNSIGNED1 source_phone_number_Invalid;
    UNSIGNED1 date_added_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RawSpoofing_Layout_PhoneFraud)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(RawSpoofing_Layout_PhoneFraud) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.id_value_Invalid := RawSpoofing_Fields.InValid_id_value((SALT36.StrType)le.id_value);
    SELF.event_time_Invalid := RawSpoofing_Fields.InValid_event_time((SALT36.StrType)le.event_time);
    SELF.spoofed_phone_number_Invalid := RawSpoofing_Fields.InValid_spoofed_phone_number((SALT36.StrType)le.spoofed_phone_number);
    SELF.destination_number_Invalid := RawSpoofing_Fields.InValid_destination_number((SALT36.StrType)le.destination_number);
    SELF.source_phone_number_Invalid := RawSpoofing_Fields.InValid_source_phone_number((SALT36.StrType)le.source_phone_number);
    SELF.date_added_Invalid := RawSpoofing_Fields.InValid_date_added((SALT36.StrType)le.date_added);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RawSpoofing_Layout_PhoneFraud);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.id_value_Invalid << 0 ) + ( le.event_time_Invalid << 2 ) + ( le.spoofed_phone_number_Invalid << 3 ) + ( le.destination_number_Invalid << 4 ) + ( le.source_phone_number_Invalid << 5 ) + ( le.date_added_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RawSpoofing_Layout_PhoneFraud);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.id_value_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.event_time_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.spoofed_phone_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.destination_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.source_phone_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    id_value_ALLOW_ErrorCount := COUNT(GROUP,h.id_value_Invalid=1);
    id_value_LENGTH_ErrorCount := COUNT(GROUP,h.id_value_Invalid=2);
    id_value_Total_ErrorCount := COUNT(GROUP,h.id_value_Invalid>0);
    event_time_ALLOW_ErrorCount := COUNT(GROUP,h.event_time_Invalid=1);
    spoofed_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.spoofed_phone_number_Invalid=1);
    destination_number_ALLOW_ErrorCount := COUNT(GROUP,h.destination_number_Invalid=1);
    source_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.source_phone_number_Invalid=1);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.id_value_Invalid,le.event_time_Invalid,le.spoofed_phone_number_Invalid,le.destination_number_Invalid,le.source_phone_number_Invalid,le.date_added_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RawSpoofing_Fields.InvalidMessage_id_value(le.id_value_Invalid),RawSpoofing_Fields.InvalidMessage_event_time(le.event_time_Invalid),RawSpoofing_Fields.InvalidMessage_spoofed_phone_number(le.spoofed_phone_number_Invalid),RawSpoofing_Fields.InvalidMessage_destination_number(le.destination_number_Invalid),RawSpoofing_Fields.InvalidMessage_source_phone_number(le.source_phone_number_Invalid),RawSpoofing_Fields.InvalidMessage_date_added(le.date_added_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.id_value_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.event_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spoofed_phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.destination_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'id_value','event_time','spoofed_phone_number','destination_number','source_phone_number','date_added','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_ID','Invalid_Event_Time','Invalid_Phone_Number','Invalid_Phone_Number','Invalid_Phone_Number','Invalid_Date_Added','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.id_value,(SALT36.StrType)le.event_time,(SALT36.StrType)le.spoofed_phone_number,(SALT36.StrType)le.destination_number,(SALT36.StrType)le.source_phone_number,(SALT36.StrType)le.date_added,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'id_value:Invalid_ID:ALLOW','id_value:Invalid_ID:LENGTH'
          ,'event_time:Invalid_Event_Time:ALLOW'
          ,'spoofed_phone_number:Invalid_Phone_Number:ALLOW'
          ,'destination_number:Invalid_Phone_Number:ALLOW'
          ,'source_phone_number:Invalid_Phone_Number:ALLOW'
          ,'date_added:Invalid_Date_Added:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,RawSpoofing_Fields.InvalidMessage_id_value(1),RawSpoofing_Fields.InvalidMessage_id_value(2)
          ,RawSpoofing_Fields.InvalidMessage_event_time(1)
          ,RawSpoofing_Fields.InvalidMessage_spoofed_phone_number(1)
          ,RawSpoofing_Fields.InvalidMessage_destination_number(1)
          ,RawSpoofing_Fields.InvalidMessage_source_phone_number(1)
          ,RawSpoofing_Fields.InvalidMessage_date_added(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.id_value_ALLOW_ErrorCount,le.id_value_LENGTH_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.spoofed_phone_number_ALLOW_ErrorCount
          ,le.destination_number_ALLOW_ErrorCount
          ,le.source_phone_number_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.id_value_ALLOW_ErrorCount,le.id_value_LENGTH_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.spoofed_phone_number_ALLOW_ErrorCount
          ,le.destination_number_ALLOW_ErrorCount
          ,le.source_phone_number_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,7,Into(LEFT,COUNTER));
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
