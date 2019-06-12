﻿IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_San_Diego_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Input_CA_San_Diego_Layout_FBNV2)
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 file_date_Invalid;
    UNSIGNED1 prev_file_date_Invalid;
    UNSIGNED1 file_number_Invalid;
    UNSIGNED1 prev_file_number_Invalid;
    UNSIGNED1 filing_type_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_CA_San_Diego_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_CA_San_Diego_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.business_name_Invalid := Input_CA_San_Diego_Fields.InValid_business_name((SALT37.StrType)le.business_name);
    SELF.file_date_Invalid := Input_CA_San_Diego_Fields.InValid_file_date((SALT37.StrType)le.file_date);
    SELF.prev_file_date_Invalid := Input_CA_San_Diego_Fields.InValid_prev_file_date((SALT37.StrType)le.prev_file_date);
    SELF.file_number_Invalid := Input_CA_San_Diego_Fields.InValid_file_number((SALT37.StrType)le.file_number);
    SELF.prev_file_number_Invalid := Input_CA_San_Diego_Fields.InValid_prev_file_number((SALT37.StrType)le.prev_file_number);
    SELF.filing_type_Invalid := Input_CA_San_Diego_Fields.InValid_filing_type((SALT37.StrType)le.filing_type);
    SELF.prep_addr_line1_Invalid := Input_CA_San_Diego_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Input_CA_San_Diego_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_CA_San_Diego_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.business_name_Invalid << 0 ) + ( le.file_date_Invalid << 1 ) + ( le.prev_file_date_Invalid << 2 ) + ( le.file_number_Invalid << 3 ) + ( le.prev_file_number_Invalid << 4 ) + ( le.filing_type_Invalid << 5 ) + ( le.prep_addr_line1_Invalid << 6 ) + ( le.prep_addr_line_last_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_CA_San_Diego_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.prev_file_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.file_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.prev_file_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.filing_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    business_name_LENGTH_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    file_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_date_Invalid=1);
    prev_file_date_CUSTOM_ErrorCount := COUNT(GROUP,h.prev_file_date_Invalid=1);
    file_number_LENGTH_ErrorCount := COUNT(GROUP,h.file_number_Invalid=1);
    prev_file_number_LENGTH_ErrorCount := COUNT(GROUP,h.prev_file_number_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.business_name_Invalid,le.file_date_Invalid,le.prev_file_date_Invalid,le.file_number_Invalid,le.prev_file_number_Invalid,le.filing_type_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_CA_San_Diego_Fields.InvalidMessage_business_name(le.business_name_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_file_date(le.file_date_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_prev_file_date(le.prev_file_date_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_file_number(le.file_number_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_prev_file_number(le.prev_file_number_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_filing_type(le.filing_type_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Input_CA_San_Diego_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.business_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.file_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prev_file_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prev_file_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'business_name','file_date','prev_file_date','file_number','prev_file_number','filing_type','prep_addr_line1','prep_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_general_date','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.business_name,(SALT37.StrType)le.file_date,(SALT37.StrType)le.prev_file_date,(SALT37.StrType)le.file_number,(SALT37.StrType)le.prev_file_number,(SALT37.StrType)le.filing_type,(SALT37.StrType)le.prep_addr_line1,(SALT37.StrType)le.prep_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'business_name:invalid_mandatory:LENGTH'
          ,'file_date:invalid_general_date:CUSTOM'
          ,'prev_file_date:invalid_general_date:CUSTOM'
          ,'file_number:invalid_mandatory:LENGTH'
          ,'prev_file_number:invalid_mandatory:LENGTH'
          ,'filing_type:invalid_mandatory:LENGTH'
          ,'prep_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_addr_line_last:invalid_mandatory:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_CA_San_Diego_Fields.InvalidMessage_business_name(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_file_date(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_prev_file_date(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_file_number(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_prev_file_number(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_filing_type(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_prep_addr_line1(1)
          ,Input_CA_San_Diego_Fields.InvalidMessage_prep_addr_line_last(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.business_name_LENGTH_ErrorCount
          ,le.file_date_CUSTOM_ErrorCount
          ,le.prev_file_date_CUSTOM_ErrorCount
          ,le.file_number_LENGTH_ErrorCount
          ,le.prev_file_number_LENGTH_ErrorCount
          ,le.filing_type_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.business_name_LENGTH_ErrorCount
          ,le.file_date_CUSTOM_ErrorCount
          ,le.prev_file_date_CUSTOM_ErrorCount
          ,le.file_number_LENGTH_ErrorCount
          ,le.prev_file_number_LENGTH_ErrorCount
          ,le.filing_type_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,8,Into(LEFT,COUNTER));
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
