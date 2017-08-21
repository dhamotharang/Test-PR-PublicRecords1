IMPORT ut,SALT33;
EXPORT LIDBReceived_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(LIDBReceived_Layout_PhonesInfo)
    UNSIGNED1 reference_id_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 reply_code_Invalid;
    UNSIGNED1 local_routing_number_Invalid;
    UNSIGNED1 account_owner_Invalid;
    UNSIGNED1 carrier_name_Invalid;
    UNSIGNED1 carrier_category_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(LIDBReceived_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(LIDBReceived_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.reference_id_Invalid := LIDBReceived_Fields.InValid_reference_id((SALT33.StrType)le.reference_id);
    SELF.phone_Invalid := LIDBReceived_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF.reply_code_Invalid := LIDBReceived_Fields.InValid_reply_code((SALT33.StrType)le.reply_code);
    SELF.local_routing_number_Invalid := LIDBReceived_Fields.InValid_local_routing_number((SALT33.StrType)le.local_routing_number);
    SELF.account_owner_Invalid := LIDBReceived_Fields.InValid_account_owner((SALT33.StrType)le.account_owner);
    SELF.carrier_name_Invalid := LIDBReceived_Fields.InValid_carrier_name((SALT33.StrType)le.carrier_name);
    SELF.carrier_category_Invalid := LIDBReceived_Fields.InValid_carrier_category((SALT33.StrType)le.carrier_category);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),LIDBReceived_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.reference_id_Invalid << 0 ) + ( le.phone_Invalid << 1 ) + ( le.reply_code_Invalid << 2 ) + ( le.local_routing_number_Invalid << 3 ) + ( le.account_owner_Invalid << 4 ) + ( le.carrier_name_Invalid << 5 ) + ( le.carrier_category_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,LIDBReceived_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.reference_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.reply_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.local_routing_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.account_owner_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.carrier_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.carrier_category_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    reference_id_ALLOW_ErrorCount := COUNT(GROUP,h.reference_id_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    reply_code_ALLOW_ErrorCount := COUNT(GROUP,h.reply_code_Invalid=1);
    local_routing_number_ALLOW_ErrorCount := COUNT(GROUP,h.local_routing_number_Invalid=1);
    account_owner_ALLOW_ErrorCount := COUNT(GROUP,h.account_owner_Invalid=1);
    carrier_name_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid=1);
    carrier_category_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_category_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.reference_id_Invalid,le.phone_Invalid,le.reply_code_Invalid,le.local_routing_number_Invalid,le.account_owner_Invalid,le.carrier_name_Invalid,le.carrier_category_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,LIDBReceived_Fields.InvalidMessage_reference_id(le.reference_id_Invalid),LIDBReceived_Fields.InvalidMessage_phone(le.phone_Invalid),LIDBReceived_Fields.InvalidMessage_reply_code(le.reply_code_Invalid),LIDBReceived_Fields.InvalidMessage_local_routing_number(le.local_routing_number_Invalid),LIDBReceived_Fields.InvalidMessage_account_owner(le.account_owner_Invalid),LIDBReceived_Fields.InvalidMessage_carrier_name(le.carrier_name_Invalid),LIDBReceived_Fields.InvalidMessage_carrier_category(le.carrier_category_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.reference_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reply_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.local_routing_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.account_owner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_category_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'reference_id','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_RefID','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_AccOwn','Invalid_Char','Invalid_Char','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.reference_id,(SALT33.StrType)le.phone,(SALT33.StrType)le.reply_code,(SALT33.StrType)le.local_routing_number,(SALT33.StrType)le.account_owner,(SALT33.StrType)le.carrier_name,(SALT33.StrType)le.carrier_category,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'reference_id:Invalid_RefID:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'reply_code:Invalid_Num:ALLOW'
          ,'local_routing_number:Invalid_Num:ALLOW'
          ,'account_owner:Invalid_AccOwn:ALLOW'
          ,'carrier_name:Invalid_Char:ALLOW'
          ,'carrier_category:Invalid_Char:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,LIDBReceived_Fields.InvalidMessage_reference_id(1)
          ,LIDBReceived_Fields.InvalidMessage_phone(1)
          ,LIDBReceived_Fields.InvalidMessage_reply_code(1)
          ,LIDBReceived_Fields.InvalidMessage_local_routing_number(1)
          ,LIDBReceived_Fields.InvalidMessage_account_owner(1)
          ,LIDBReceived_Fields.InvalidMessage_carrier_name(1)
          ,LIDBReceived_Fields.InvalidMessage_carrier_category(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.reference_id_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_name_ALLOW_ErrorCount
          ,le.carrier_category_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.reference_id_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_name_ALLOW_ErrorCount
          ,le.carrier_category_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
