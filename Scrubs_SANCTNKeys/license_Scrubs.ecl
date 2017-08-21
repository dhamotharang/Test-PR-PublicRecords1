IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_SANCTNKeys; // Import modules for FieldTypes attribute definitions
EXPORT license_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(license_Layout_SANCTNKeys)
    UNSIGNED1 batch_number_Invalid;
    UNSIGNED1 incident_number_Invalid;
    UNSIGNED1 party_number_Invalid;
    UNSIGNED1 order_number_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 license_type_Invalid;
    UNSIGNED1 license_state_Invalid;
    UNSIGNED1 cln_license_number_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(license_Layout_SANCTNKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(license_Layout_SANCTNKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_number_Invalid := license_Fields.InValid_batch_number((SALT33.StrType)le.batch_number);
    SELF.incident_number_Invalid := license_Fields.InValid_incident_number((SALT33.StrType)le.incident_number);
    SELF.party_number_Invalid := license_Fields.InValid_party_number((SALT33.StrType)le.party_number);
    SELF.order_number_Invalid := license_Fields.InValid_order_number((SALT33.StrType)le.order_number);
    SELF.license_number_Invalid := license_Fields.InValid_license_number((SALT33.StrType)le.license_number);
    SELF.license_type_Invalid := license_Fields.InValid_license_type((SALT33.StrType)le.license_type);
    SELF.license_state_Invalid := license_Fields.InValid_license_state((SALT33.StrType)le.license_state);
    SELF.cln_license_number_Invalid := license_Fields.InValid_cln_license_number((SALT33.StrType)le.cln_license_number);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),license_Layout_SANCTNKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_number_Invalid << 0 ) + ( le.incident_number_Invalid << 2 ) + ( le.party_number_Invalid << 3 ) + ( le.order_number_Invalid << 4 ) + ( le.license_number_Invalid << 5 ) + ( le.license_type_Invalid << 6 ) + ( le.license_state_Invalid << 7 ) + ( le.cln_license_number_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,license_Layout_SANCTNKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_number_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.incident_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.party_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.order_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.license_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.license_state_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.cln_license_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_number_ALLOW_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=1);
    batch_number_LENGTH_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=2);
    batch_number_Total_ErrorCount := COUNT(GROUP,h.batch_number_Invalid>0);
    incident_number_ALLOW_ErrorCount := COUNT(GROUP,h.incident_number_Invalid=1);
    party_number_ALLOW_ErrorCount := COUNT(GROUP,h.party_number_Invalid=1);
    order_number_ALLOW_ErrorCount := COUNT(GROUP,h.order_number_Invalid=1);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.license_type_Invalid=1);
    license_state_CUSTOM_ErrorCount := COUNT(GROUP,h.license_state_Invalid=1);
    cln_license_number_ALLOW_ErrorCount := COUNT(GROUP,h.cln_license_number_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_number_Invalid,le.incident_number_Invalid,le.party_number_Invalid,le.order_number_Invalid,le.license_number_Invalid,le.license_type_Invalid,le.license_state_Invalid,le.cln_license_number_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,license_Fields.InvalidMessage_batch_number(le.batch_number_Invalid),license_Fields.InvalidMessage_incident_number(le.incident_number_Invalid),license_Fields.InvalidMessage_party_number(le.party_number_Invalid),license_Fields.InvalidMessage_order_number(le.order_number_Invalid),license_Fields.InvalidMessage_license_number(le.license_number_Invalid),license_Fields.InvalidMessage_license_type(le.license_type_Invalid),license_Fields.InvalidMessage_license_state(le.license_state_Invalid),license_Fields.InvalidMessage_cln_license_number(le.cln_license_number_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.incident_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.order_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_license_number_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch_number','incident_number','party_number','order_number','license_number','license_type','license_state','cln_license_number','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_LicenseNumber','Invalid_LicenseType','Invalid_State','Invalid_ClnLicenseNumber','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.batch_number,(SALT33.StrType)le.incident_number,(SALT33.StrType)le.party_number,(SALT33.StrType)le.order_number,(SALT33.StrType)le.license_number,(SALT33.StrType)le.license_type,(SALT33.StrType)le.license_state,(SALT33.StrType)le.cln_license_number,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'batch_number:Invalid_Batch:ALLOW','batch_number:Invalid_Batch:LENGTH'
          ,'incident_number:Invalid_Num:ALLOW'
          ,'party_number:Invalid_Num:ALLOW'
          ,'order_number:Invalid_Num:ALLOW'
          ,'license_number:Invalid_LicenseNumber:ALLOW'
          ,'license_type:Invalid_LicenseType:CUSTOM'
          ,'license_state:Invalid_State:CUSTOM'
          ,'cln_license_number:Invalid_ClnLicenseNumber:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,license_Fields.InvalidMessage_batch_number(1),license_Fields.InvalidMessage_batch_number(2)
          ,license_Fields.InvalidMessage_incident_number(1)
          ,license_Fields.InvalidMessage_party_number(1)
          ,license_Fields.InvalidMessage_order_number(1)
          ,license_Fields.InvalidMessage_license_number(1)
          ,license_Fields.InvalidMessage_license_type(1)
          ,license_Fields.InvalidMessage_license_state(1)
          ,license_Fields.InvalidMessage_cln_license_number(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount
          ,le.license_type_CUSTOM_ErrorCount
          ,le.license_state_CUSTOM_ErrorCount
          ,le.cln_license_number_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount
          ,le.license_type_CUSTOM_ErrorCount
          ,le.license_state_CUSTOM_ErrorCount
          ,le.cln_license_number_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,9,Into(LEFT,COUNTER));
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
