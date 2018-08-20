IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Business_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Base_Business_Layout_FBNV2)
    UNSIGNED1 bus_name_Invalid;
    UNSIGNED1 filing_jurisdiction_Invalid;
    UNSIGNED1 filing_date_Invalid;
    UNSIGNED1 filing_number_Invalid;
    UNSIGNED1 filing_type_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Business_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Business_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.bus_name_Invalid := Base_Business_Fields.InValid_bus_name((SALT37.StrType)le.bus_name);
    SELF.filing_jurisdiction_Invalid := Base_Business_Fields.InValid_filing_jurisdiction((SALT37.StrType)le.filing_jurisdiction);
    SELF.filing_date_Invalid := Base_Business_Fields.InValid_filing_date((SALT37.StrType)le.filing_date);
    SELF.filing_number_Invalid := Base_Business_Fields.InValid_filing_number((SALT37.StrType)le.filing_number);
    SELF.filing_type_Invalid := Base_Business_Fields.InValid_filing_type((SALT37.StrType)le.filing_type);
    SELF.prep_addr_line1_Invalid := Base_Business_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Business_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Business_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.bus_name_Invalid << 0 ) + ( le.filing_jurisdiction_Invalid << 1 ) + ( le.filing_date_Invalid << 2 ) + ( le.filing_number_Invalid << 3 ) + ( le.filing_type_Invalid << 4 ) + ( le.prep_addr_line1_Invalid << 5 ) + ( le.prep_addr_line_last_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Business_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.bus_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.filing_jurisdiction_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.filing_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.filing_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.filing_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    bus_name_LENGTH_ErrorCount := COUNT(GROUP,h.bus_name_Invalid=1);
    filing_jurisdiction_LENGTH_ErrorCount := COUNT(GROUP,h.filing_jurisdiction_Invalid=1);
    filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    filing_number_LENGTH_ErrorCount := COUNT(GROUP,h.filing_number_Invalid=1);
    filing_type_LENGTH_ErrorCount := COUNT(GROUP,h.filing_type_Invalid=1);
    prep_addr_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.bus_name_Invalid,le.filing_jurisdiction_Invalid,le.filing_date_Invalid,le.filing_number_Invalid,le.filing_type_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Business_Fields.InvalidMessage_bus_name(le.bus_name_Invalid),Base_Business_Fields.InvalidMessage_filing_jurisdiction(le.filing_jurisdiction_Invalid),Base_Business_Fields.InvalidMessage_filing_date(le.filing_date_Invalid),Base_Business_Fields.InvalidMessage_filing_number(le.filing_number_Invalid),Base_Business_Fields.InvalidMessage_filing_type(le.filing_type_Invalid),Base_Business_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Business_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.bus_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_jurisdiction_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'bus_name','filing_jurisdiction','filing_date','filing_number','filing_type','prep_addr_line1','prep_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.bus_name,(SALT37.StrType)le.filing_jurisdiction,(SALT37.StrType)le.filing_date,(SALT37.StrType)le.filing_number,(SALT37.StrType)le.filing_type,(SALT37.StrType)le.prep_addr_line1,(SALT37.StrType)le.prep_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'bus_name:invalid_mandatory:LENGTH'
          ,'filing_jurisdiction:invalid_mandatory:LENGTH'
          ,'filing_date:invalid_general_date:CUSTOM'
          ,'filing_number:invalid_mandatory:LENGTH'
          ,'filing_type:invalid_mandatory:LENGTH'
          ,'prep_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_addr_line_last:invalid_mandatory:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Business_Fields.InvalidMessage_bus_name(1)
          ,Base_Business_Fields.InvalidMessage_filing_jurisdiction(1)
          ,Base_Business_Fields.InvalidMessage_filing_date(1)
          ,Base_Business_Fields.InvalidMessage_filing_number(1)
          ,Base_Business_Fields.InvalidMessage_filing_type(1)
          ,Base_Business_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Business_Fields.InvalidMessage_prep_addr_line_last(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.bus_name_LENGTH_ErrorCount
          ,le.filing_jurisdiction_LENGTH_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_number_LENGTH_ErrorCount
          ,le.filing_type_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.bus_name_LENGTH_ErrorCount
          ,le.filing_jurisdiction_LENGTH_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_number_LENGTH_ErrorCount
          ,le.filing_type_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,7,Into(LEFT,COUNTER));
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
