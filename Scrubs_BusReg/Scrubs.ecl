IMPORT SALT36;
IMPORT Scrubs_BusReg,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_in_BusReg)
    UNSIGNED1 ofc1_title_Invalid;
    UNSIGNED1 ofc1_gender_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 corpcode_Invalid;
    UNSIGNED1 sos_code_Invalid;
    UNSIGNED1 filing_cod_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 filing_num_Invalid;
    UNSIGNED1 start_date_Invalid;
    UNSIGNED1 file_date_Invalid;
    UNSIGNED1 form_date_Invalid;
    UNSIGNED1 disol_date_Invalid;
    UNSIGNED1 rpt_date_Invalid;
    UNSIGNED1 chang_date_Invalid;
    UNSIGNED1 ofc2_title_Invalid;
    UNSIGNED1 ofc3_title_Invalid;
    UNSIGNED1 ofc4_title_Invalid;
    UNSIGNED1 ofc5_title_Invalid;
    UNSIGNED1 ofc6_title_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_in_BusReg)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_in_BusReg) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ofc1_title_Invalid := Fields.InValid_ofc1_title((SALT36.StrType)le.ofc1_title);
    SELF.ofc1_gender_Invalid := Fields.InValid_ofc1_gender((SALT36.StrType)le.ofc1_gender);
    SELF.county_Invalid := Fields.InValid_county((SALT36.StrType)le.county);
    SELF.corpcode_Invalid := Fields.InValid_corpcode((SALT36.StrType)le.corpcode);
    SELF.sos_code_Invalid := Fields.InValid_sos_code((SALT36.StrType)le.sos_code);
    SELF.filing_cod_Invalid := Fields.InValid_filing_cod((SALT36.StrType)le.filing_cod);
    SELF.status_Invalid := Fields.InValid_status((SALT36.StrType)le.status);
    SELF.filing_num_Invalid := Fields.InValid_filing_num((SALT36.StrType)le.filing_num);
    SELF.start_date_Invalid := Fields.InValid_start_date((SALT36.StrType)le.start_date);
    SELF.file_date_Invalid := Fields.InValid_file_date((SALT36.StrType)le.file_date);
    SELF.form_date_Invalid := Fields.InValid_form_date((SALT36.StrType)le.form_date);
    SELF.disol_date_Invalid := Fields.InValid_disol_date((SALT36.StrType)le.disol_date);
    SELF.rpt_date_Invalid := Fields.InValid_rpt_date((SALT36.StrType)le.rpt_date);
    SELF.chang_date_Invalid := Fields.InValid_chang_date((SALT36.StrType)le.chang_date);
    SELF.ofc2_title_Invalid := Fields.InValid_ofc2_title((SALT36.StrType)le.ofc2_title);
    SELF.ofc3_title_Invalid := Fields.InValid_ofc3_title((SALT36.StrType)le.ofc3_title);
    SELF.ofc4_title_Invalid := Fields.InValid_ofc4_title((SALT36.StrType)le.ofc4_title);
    SELF.ofc5_title_Invalid := Fields.InValid_ofc5_title((SALT36.StrType)le.ofc5_title);
    SELF.ofc6_title_Invalid := Fields.InValid_ofc6_title((SALT36.StrType)le.ofc6_title);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_in_BusReg);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ofc1_title_Invalid << 0 ) + ( le.ofc1_gender_Invalid << 1 ) + ( le.county_Invalid << 2 ) + ( le.corpcode_Invalid << 3 ) + ( le.sos_code_Invalid << 4 ) + ( le.filing_cod_Invalid << 5 ) + ( le.status_Invalid << 6 ) + ( le.filing_num_Invalid << 7 ) + ( le.start_date_Invalid << 8 ) + ( le.file_date_Invalid << 10 ) + ( le.form_date_Invalid << 12 ) + ( le.disol_date_Invalid << 14 ) + ( le.rpt_date_Invalid << 16 ) + ( le.chang_date_Invalid << 18 ) + ( le.ofc2_title_Invalid << 20 ) + ( le.ofc3_title_Invalid << 21 ) + ( le.ofc4_title_Invalid << 22 ) + ( le.ofc5_title_Invalid << 23 ) + ( le.ofc6_title_Invalid << 24 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_in_BusReg);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ofc1_title_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.ofc1_gender_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.corpcode_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.sos_code_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.filing_cod_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.filing_num_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.start_date_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.file_date_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.form_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.disol_date_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.rpt_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.chang_date_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.ofc2_title_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.ofc3_title_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.ofc4_title_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.ofc5_title_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.ofc6_title_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ofc1_title_ENUM_ErrorCount := COUNT(GROUP,h.ofc1_title_Invalid=1);
    ofc1_gender_ENUM_ErrorCount := COUNT(GROUP,h.ofc1_gender_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    corpcode_ENUM_ErrorCount := COUNT(GROUP,h.corpcode_Invalid=1);
    sos_code_ENUM_ErrorCount := COUNT(GROUP,h.sos_code_Invalid=1);
    filing_cod_ENUM_ErrorCount := COUNT(GROUP,h.filing_cod_Invalid=1);
    status_ENUM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    filing_num_ALLOW_ErrorCount := COUNT(GROUP,h.filing_num_Invalid=1);
    start_date_ALLOW_ErrorCount := COUNT(GROUP,h.start_date_Invalid=1);
    start_date_CUSTOM_ErrorCount := COUNT(GROUP,h.start_date_Invalid=2);
    start_date_Total_ErrorCount := COUNT(GROUP,h.start_date_Invalid>0);
    file_date_ALLOW_ErrorCount := COUNT(GROUP,h.file_date_Invalid=1);
    file_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_date_Invalid=2);
    file_date_Total_ErrorCount := COUNT(GROUP,h.file_date_Invalid>0);
    form_date_ALLOW_ErrorCount := COUNT(GROUP,h.form_date_Invalid=1);
    form_date_CUSTOM_ErrorCount := COUNT(GROUP,h.form_date_Invalid=2);
    form_date_Total_ErrorCount := COUNT(GROUP,h.form_date_Invalid>0);
    disol_date_ALLOW_ErrorCount := COUNT(GROUP,h.disol_date_Invalid=1);
    disol_date_CUSTOM_ErrorCount := COUNT(GROUP,h.disol_date_Invalid=2);
    disol_date_Total_ErrorCount := COUNT(GROUP,h.disol_date_Invalid>0);
    rpt_date_ALLOW_ErrorCount := COUNT(GROUP,h.rpt_date_Invalid=1);
    rpt_date_CUSTOM_ErrorCount := COUNT(GROUP,h.rpt_date_Invalid=2);
    rpt_date_Total_ErrorCount := COUNT(GROUP,h.rpt_date_Invalid>0);
    chang_date_ALLOW_ErrorCount := COUNT(GROUP,h.chang_date_Invalid=1);
    chang_date_CUSTOM_ErrorCount := COUNT(GROUP,h.chang_date_Invalid=2);
    chang_date_Total_ErrorCount := COUNT(GROUP,h.chang_date_Invalid>0);
    ofc2_title_ENUM_ErrorCount := COUNT(GROUP,h.ofc2_title_Invalid=1);
    ofc3_title_ENUM_ErrorCount := COUNT(GROUP,h.ofc3_title_Invalid=1);
    ofc4_title_ENUM_ErrorCount := COUNT(GROUP,h.ofc4_title_Invalid=1);
    ofc5_title_ENUM_ErrorCount := COUNT(GROUP,h.ofc5_title_Invalid=1);
    ofc6_title_ENUM_ErrorCount := COUNT(GROUP,h.ofc6_title_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r):independent;
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ofc1_title_Invalid,le.ofc1_gender_Invalid,le.county_Invalid,le.corpcode_Invalid,le.sos_code_Invalid,le.filing_cod_Invalid,le.status_Invalid,le.filing_num_Invalid,le.start_date_Invalid,le.file_date_Invalid,le.form_date_Invalid,le.disol_date_Invalid,le.rpt_date_Invalid,le.chang_date_Invalid,le.ofc2_title_Invalid,le.ofc3_title_Invalid,le.ofc4_title_Invalid,le.ofc5_title_Invalid,le.ofc6_title_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ofc1_title(le.ofc1_title_Invalid),Fields.InvalidMessage_ofc1_gender(le.ofc1_gender_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_corpcode(le.corpcode_Invalid),Fields.InvalidMessage_sos_code(le.sos_code_Invalid),Fields.InvalidMessage_filing_cod(le.filing_cod_Invalid),Fields.InvalidMessage_status(le.status_Invalid),Fields.InvalidMessage_filing_num(le.filing_num_Invalid),Fields.InvalidMessage_start_date(le.start_date_Invalid),Fields.InvalidMessage_file_date(le.file_date_Invalid),Fields.InvalidMessage_form_date(le.form_date_Invalid),Fields.InvalidMessage_disol_date(le.disol_date_Invalid),Fields.InvalidMessage_rpt_date(le.rpt_date_Invalid),Fields.InvalidMessage_chang_date(le.chang_date_Invalid),Fields.InvalidMessage_ofc2_title(le.ofc2_title_Invalid),Fields.InvalidMessage_ofc3_title(le.ofc3_title_Invalid),Fields.InvalidMessage_ofc4_title(le.ofc4_title_Invalid),Fields.InvalidMessage_ofc5_title(le.ofc5_title_Invalid),Fields.InvalidMessage_ofc6_title(le.ofc6_title_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ofc1_title_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ofc1_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corpcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sos_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.filing_cod_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.filing_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.start_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.form_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.disol_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.rpt_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.chang_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.ofc2_title_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ofc3_title_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ofc4_title_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ofc5_title_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ofc6_title_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ofc1_title','ofc1_gender','county','corpcode','sos_code','filing_cod','status','filing_num','start_date','file_date','form_date','disol_date','rpt_date','chang_date','ofc2_title','ofc3_title','ofc4_title','ofc5_title','ofc6_title','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_ofc1_title','invalid_ofc1_gender','invalid_county','invalid_corpcode','invalid_sos_code','invalid_filing_code','invalid_status','invalid_filing_num','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_ofc1_title','invalid_ofc1_title','invalid_ofc1_title','invalid_ofc1_title','invalid_ofc1_title','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.ofc1_title,(SALT36.StrType)le.ofc1_gender,(SALT36.StrType)le.county,(SALT36.StrType)le.corpcode,(SALT36.StrType)le.sos_code,(SALT36.StrType)le.filing_cod,(SALT36.StrType)le.status,(SALT36.StrType)le.filing_num,(SALT36.StrType)le.start_date,(SALT36.StrType)le.file_date,(SALT36.StrType)le.form_date,(SALT36.StrType)le.disol_date,(SALT36.StrType)le.rpt_date,(SALT36.StrType)le.chang_date,(SALT36.StrType)le.ofc2_title,(SALT36.StrType)le.ofc3_title,(SALT36.StrType)le.ofc4_title,(SALT36.StrType)le.ofc5_title,(SALT36.StrType)le.ofc6_title,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ofc1_title:invalid_ofc1_title:ENUM'
          ,'ofc1_gender:invalid_ofc1_gender:ENUM'
          ,'county:invalid_county:ALLOW'
          ,'corpcode:invalid_corpcode:ENUM'
          ,'sos_code:invalid_sos_code:ENUM'
          ,'filing_cod:invalid_filing_code:ENUM'
          ,'status:invalid_status:ENUM'
          ,'filing_num:invalid_filing_num:ALLOW'
          ,'start_date:invalid_date:ALLOW','start_date:invalid_date:CUSTOM'
          ,'file_date:invalid_date:ALLOW','file_date:invalid_date:CUSTOM'
          ,'form_date:invalid_date:ALLOW','form_date:invalid_date:CUSTOM'
          ,'disol_date:invalid_date:ALLOW','disol_date:invalid_date:CUSTOM'
          ,'rpt_date:invalid_date:ALLOW','rpt_date:invalid_date:CUSTOM'
          ,'chang_date:invalid_date:ALLOW','chang_date:invalid_date:CUSTOM'
          ,'ofc2_title:invalid_ofc1_title:ENUM'
          ,'ofc3_title:invalid_ofc1_title:ENUM'
          ,'ofc4_title:invalid_ofc1_title:ENUM'
          ,'ofc5_title:invalid_ofc1_title:ENUM'
          ,'ofc6_title:invalid_ofc1_title:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ofc1_title(1)
          ,Fields.InvalidMessage_ofc1_gender(1)
          ,Fields.InvalidMessage_county(1)
          ,Fields.InvalidMessage_corpcode(1)
          ,Fields.InvalidMessage_sos_code(1)
          ,Fields.InvalidMessage_filing_cod(1)
          ,Fields.InvalidMessage_status(1)
          ,Fields.InvalidMessage_filing_num(1)
          ,Fields.InvalidMessage_start_date(1),Fields.InvalidMessage_start_date(2)
          ,Fields.InvalidMessage_file_date(1),Fields.InvalidMessage_file_date(2)
          ,Fields.InvalidMessage_form_date(1),Fields.InvalidMessage_form_date(2)
          ,Fields.InvalidMessage_disol_date(1),Fields.InvalidMessage_disol_date(2)
          ,Fields.InvalidMessage_rpt_date(1),Fields.InvalidMessage_rpt_date(2)
          ,Fields.InvalidMessage_chang_date(1),Fields.InvalidMessage_chang_date(2)
          ,Fields.InvalidMessage_ofc2_title(1)
          ,Fields.InvalidMessage_ofc3_title(1)
          ,Fields.InvalidMessage_ofc4_title(1)
          ,Fields.InvalidMessage_ofc5_title(1)
          ,Fields.InvalidMessage_ofc6_title(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ofc1_title_ENUM_ErrorCount
          ,le.ofc1_gender_ENUM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.corpcode_ENUM_ErrorCount
          ,le.sos_code_ENUM_ErrorCount
          ,le.filing_cod_ENUM_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.filing_num_ALLOW_ErrorCount
          ,le.start_date_ALLOW_ErrorCount,le.start_date_CUSTOM_ErrorCount
          ,le.file_date_ALLOW_ErrorCount,le.file_date_CUSTOM_ErrorCount
          ,le.form_date_ALLOW_ErrorCount,le.form_date_CUSTOM_ErrorCount
          ,le.disol_date_ALLOW_ErrorCount,le.disol_date_CUSTOM_ErrorCount
          ,le.rpt_date_ALLOW_ErrorCount,le.rpt_date_CUSTOM_ErrorCount
          ,le.chang_date_ALLOW_ErrorCount,le.chang_date_CUSTOM_ErrorCount
          ,le.ofc2_title_ENUM_ErrorCount
          ,le.ofc3_title_ENUM_ErrorCount
          ,le.ofc4_title_ENUM_ErrorCount
          ,le.ofc5_title_ENUM_ErrorCount
          ,le.ofc6_title_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ofc1_title_ENUM_ErrorCount
          ,le.ofc1_gender_ENUM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.corpcode_ENUM_ErrorCount
          ,le.sos_code_ENUM_ErrorCount
          ,le.filing_cod_ENUM_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.filing_num_ALLOW_ErrorCount
          ,le.start_date_ALLOW_ErrorCount,le.start_date_CUSTOM_ErrorCount
          ,le.file_date_ALLOW_ErrorCount,le.file_date_CUSTOM_ErrorCount
          ,le.form_date_ALLOW_ErrorCount,le.form_date_CUSTOM_ErrorCount
          ,le.disol_date_ALLOW_ErrorCount,le.disol_date_CUSTOM_ErrorCount
          ,le.rpt_date_ALLOW_ErrorCount,le.rpt_date_CUSTOM_ErrorCount
          ,le.chang_date_ALLOW_ErrorCount,le.chang_date_CUSTOM_ErrorCount
          ,le.ofc2_title_ENUM_ErrorCount
          ,le.ofc3_title_ENUM_ErrorCount
          ,le.ofc4_title_ENUM_ErrorCount
          ,le.ofc5_title_ENUM_ErrorCount
          ,le.ofc6_title_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,25,Into(LEFT,COUNTER));
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
