IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_FL_Filing_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Input_FL_Filing_Layout_FBNV2)
    UNSIGNED1 fic_fil_name_Invalid;
    UNSIGNED1 fic_owner_name_Invalid;
    UNSIGNED1 fic_fil_date_Invalid;
    UNSIGNED1 fic_fil_doc_num_Invalid;
    UNSIGNED1 fic_owner_doc_num_Invalid;
    UNSIGNED1 p_owner_name_Invalid;
    UNSIGNED1 c_owner_name_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
    UNSIGNED1 prep_owner_addr_line1_Invalid;
    UNSIGNED1 prep_owner_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_FL_Filing_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_FL_Filing_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fic_fil_name_Invalid := Input_FL_Filing_Fields.InValid_fic_fil_name((SALT37.StrType)le.fic_fil_name);
    SELF.fic_owner_name_Invalid := Input_FL_Filing_Fields.InValid_fic_owner_name((SALT37.StrType)le.fic_owner_name);
    SELF.fic_fil_date_Invalid := Input_FL_Filing_Fields.InValid_fic_fil_date((SALT37.StrType)le.fic_fil_date);
    SELF.fic_fil_doc_num_Invalid := Input_FL_Filing_Fields.InValid_fic_fil_doc_num((SALT37.StrType)le.fic_fil_doc_num);
    SELF.fic_owner_doc_num_Invalid := Input_FL_Filing_Fields.InValid_fic_owner_doc_num((SALT37.StrType)le.fic_owner_doc_num);
    SELF.p_owner_name_Invalid := Input_FL_Filing_Fields.InValid_p_owner_name((SALT37.StrType)le.p_owner_name);
    SELF.c_owner_name_Invalid := Input_FL_Filing_Fields.InValid_c_owner_name((SALT37.StrType)le.c_owner_name);
    SELF.prep_addr_line1_Invalid := Input_FL_Filing_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Input_FL_Filing_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last);
    SELF.prep_owner_addr_line1_Invalid := Input_FL_Filing_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1);
    SELF.prep_owner_addr_line_last_Invalid := Input_FL_Filing_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_FL_Filing_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fic_fil_name_Invalid << 0 ) + ( le.fic_owner_name_Invalid << 1 ) + ( le.fic_fil_date_Invalid << 2 ) + ( le.fic_fil_doc_num_Invalid << 3 ) + ( le.fic_owner_doc_num_Invalid << 4 ) + ( le.p_owner_name_Invalid << 5 ) + ( le.c_owner_name_Invalid << 6 ) + ( le.prep_addr_line1_Invalid << 7 ) + ( le.prep_addr_line_last_Invalid << 8 ) + ( le.prep_owner_addr_line1_Invalid << 9 ) + ( le.prep_owner_addr_line_last_Invalid << 10 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_FL_Filing_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fic_fil_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fic_owner_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.fic_fil_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.fic_fil_doc_num_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fic_owner_doc_num_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.p_owner_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.c_owner_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.prep_owner_addr_line1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.prep_owner_addr_line_last_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fic_fil_name_LENGTH_ErrorCount := COUNT(GROUP,h.fic_fil_name_Invalid=1);
    fic_owner_name_LENGTH_ErrorCount := COUNT(GROUP,h.fic_owner_name_Invalid=1);
    fic_fil_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fic_fil_date_Invalid=1);
    fic_fil_doc_num_LENGTH_ErrorCount := COUNT(GROUP,h.fic_fil_doc_num_Invalid=1);
    fic_owner_doc_num_LENGTH_ErrorCount := COUNT(GROUP,h.fic_owner_doc_num_Invalid=1);
    p_owner_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_owner_name_Invalid=1);
    c_owner_name_LENGTH_ErrorCount := COUNT(GROUP,h.c_owner_name_Invalid=1);
    prep_addr_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    prep_owner_addr_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line1_Invalid=1);
    prep_owner_addr_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line_last_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.fic_fil_name_Invalid,le.fic_owner_name_Invalid,le.fic_fil_date_Invalid,le.fic_fil_doc_num_Invalid,le.fic_owner_doc_num_Invalid,le.p_owner_name_Invalid,le.c_owner_name_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,le.prep_owner_addr_line1_Invalid,le.prep_owner_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_FL_Filing_Fields.InvalidMessage_fic_fil_name(le.fic_fil_name_Invalid),Input_FL_Filing_Fields.InvalidMessage_fic_owner_name(le.fic_owner_name_Invalid),Input_FL_Filing_Fields.InvalidMessage_fic_fil_date(le.fic_fil_date_Invalid),Input_FL_Filing_Fields.InvalidMessage_fic_fil_doc_num(le.fic_fil_doc_num_Invalid),Input_FL_Filing_Fields.InvalidMessage_fic_owner_doc_num(le.fic_owner_doc_num_Invalid),Input_FL_Filing_Fields.InvalidMessage_p_owner_name(le.p_owner_name_Invalid),Input_FL_Filing_Fields.InvalidMessage_c_owner_name(le.c_owner_name_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line1(le.prep_owner_addr_line1_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line_last(le.prep_owner_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fic_fil_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.fic_owner_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.fic_fil_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fic_fil_doc_num_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.fic_owner_doc_num_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.p_owner_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.c_owner_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line_last_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fic_fil_name','fic_owner_name','fic_fil_date','fic_fil_doc_num','fic_owner_doc_num','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.fic_fil_name,(SALT37.StrType)le.fic_owner_name,(SALT37.StrType)le.fic_fil_date,(SALT37.StrType)le.fic_fil_doc_num,(SALT37.StrType)le.fic_owner_doc_num,(SALT37.StrType)le.p_owner_name,(SALT37.StrType)le.c_owner_name,(SALT37.StrType)le.prep_addr_line1,(SALT37.StrType)le.prep_addr_line_last,(SALT37.StrType)le.prep_owner_addr_line1,(SALT37.StrType)le.prep_owner_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'fic_fil_name:invalid_mandatory:LENGTH'
          ,'fic_owner_name:invalid_mandatory:LENGTH'
          ,'fic_fil_date:invalid_general_date:CUSTOM'
          ,'fic_fil_doc_num:invalid_mandatory:LENGTH'
          ,'fic_owner_doc_num:invalid_mandatory:LENGTH'
          ,'p_owner_name:invalid_mandatory:LENGTH'
          ,'c_owner_name:invalid_mandatory:LENGTH'
          ,'prep_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_addr_line_last:invalid_mandatory:LENGTH'
          ,'prep_owner_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_owner_addr_line_last:invalid_mandatory:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_FL_Filing_Fields.InvalidMessage_fic_fil_name(1)
          ,Input_FL_Filing_Fields.InvalidMessage_fic_owner_name(1)
          ,Input_FL_Filing_Fields.InvalidMessage_fic_fil_date(1)
          ,Input_FL_Filing_Fields.InvalidMessage_fic_fil_doc_num(1)
          ,Input_FL_Filing_Fields.InvalidMessage_fic_owner_doc_num(1)
          ,Input_FL_Filing_Fields.InvalidMessage_p_owner_name(1)
          ,Input_FL_Filing_Fields.InvalidMessage_c_owner_name(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_addr_line1(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_addr_line_last(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line1(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line_last(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fic_fil_name_LENGTH_ErrorCount
          ,le.fic_owner_name_LENGTH_ErrorCount
          ,le.fic_fil_date_CUSTOM_ErrorCount
          ,le.fic_fil_doc_num_LENGTH_ErrorCount
          ,le.fic_owner_doc_num_LENGTH_ErrorCount
          ,le.p_owner_name_LENGTH_ErrorCount
          ,le.c_owner_name_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount
          ,le.prep_owner_addr_line1_LENGTH_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.fic_fil_name_LENGTH_ErrorCount
          ,le.fic_owner_name_LENGTH_ErrorCount
          ,le.fic_fil_date_CUSTOM_ErrorCount
          ,le.fic_fil_doc_num_LENGTH_ErrorCount
          ,le.fic_owner_doc_num_LENGTH_ErrorCount
          ,le.p_owner_name_LENGTH_ErrorCount
          ,le.c_owner_name_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount
          ,le.prep_owner_addr_line1_LENGTH_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,11,Into(LEFT,COUNTER));
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
