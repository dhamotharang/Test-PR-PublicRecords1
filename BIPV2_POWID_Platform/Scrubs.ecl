IMPORT ut,SALT32;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_POWID)
    UNSIGNED1 cnp_name_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 num_legal_names_Invalid;
    UNSIGNED1 num_incs_Invalid;
    UNSIGNED1 nodes_total_Invalid;
    UNSIGNED1 zip4_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_POWID)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_POWID) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.cnp_name_Invalid := Fields.InValid_cnp_name((SALT32.StrType)le.cnp_name);
      clean_cnp_name := (TYPEOF(le.cnp_name))Fields.Make_cnp_name((SALT32.StrType)le.cnp_name);
      clean_cnp_name_Invalid := Fields.InValid_cnp_name((SALT32.StrType)clean_cnp_name);
      SELF.cnp_name := IF(withOnfail, clean_cnp_name, le.cnp_name); // ONFAIL(CLEAN)
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT32.StrType)le.company_name);
      clean_company_name := (TYPEOF(le.company_name))Fields.Make_company_name((SALT32.StrType)le.company_name);
      clean_company_name_Invalid := Fields.InValid_company_name((SALT32.StrType)clean_company_name);
      SELF.company_name := IF(withOnfail, clean_company_name, le.company_name); // ONFAIL(CLEAN)
    SELF.zip_Invalid := Fields.InValid_zip((SALT32.StrType)le.zip);
    SELF.num_legal_names_Invalid := Fields.InValid_num_legal_names((SALT32.StrType)le.num_legal_names);
      SELF.num_legal_names := IF(SELF.num_legal_names_Invalid=0 OR NOT withOnfail, le.num_legal_names, SKIP); // ONFAIL(REJECT)
    SELF.num_incs_Invalid := Fields.InValid_num_incs((SALT32.StrType)le.num_incs);
      SELF.num_incs := IF(SELF.num_incs_Invalid=0 OR NOT withOnfail, le.num_incs, SKIP); // ONFAIL(REJECT)
    SELF.nodes_total_Invalid := Fields.InValid_nodes_total((SALT32.StrType)le.nodes_total);
      SELF.nodes_total := IF(SELF.nodes_total_Invalid=0 OR NOT withOnfail, le.nodes_total, SKIP); // ONFAIL(REJECT)
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT32.StrType)le.zip4);
      SELF.zip4 := IF(SELF.zip4_Invalid=0 OR NOT withOnfail, le.zip4, SKIP); // ONFAIL(REJECT)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_POWID);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.cnp_name_Invalid << 0 ) + ( le.company_name_Invalid << 2 ) + ( le.zip_Invalid << 4 ) + ( le.num_legal_names_Invalid << 5 ) + ( le.num_incs_Invalid << 6 ) + ( le.nodes_total_Invalid << 7 ) + ( le.zip4_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_POWID);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.cnp_name_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.num_legal_names_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.num_incs_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.nodes_total_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.cnp_name_Invalid <> RIGHT.cnp_name_Invalid OR LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.num_legal_names_Invalid <> RIGHT.num_legal_names_Invalid OR LEFT.num_incs_Invalid <> RIGHT.num_incs_Invalid OR LEFT.nodes_total_Invalid <> RIGHT.nodes_total_Invalid OR LEFT.zip4_Invalid <> RIGHT.zip4_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    cnp_name_CAPS_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=1);
    cnp_name_ALLOW_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=2);
    cnp_name_Total_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid>0);
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    num_legal_names_ENUM_ErrorCount := COUNT(GROUP,h.num_legal_names_Invalid=1);
    num_incs_ENUM_ErrorCount := COUNT(GROUP,h.num_incs_Invalid=1);
    nodes_total_ENUM_ErrorCount := COUNT(GROUP,h.nodes_total_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.cnp_name_Invalid,le.company_name_Invalid,le.zip_Invalid,le.num_legal_names_Invalid,le.num_incs_Invalid,le.nodes_total_Invalid,le.zip4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_cnp_name(le.cnp_name_Invalid),Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_num_legal_names(le.num_legal_names_Invalid),Fields.InvalidMessage_num_incs(le.num_incs_Invalid),Fields.InvalidMessage_nodes_total(le.nodes_total_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.cnp_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.num_legal_names_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.num_incs_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.nodes_total_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'cnp_name','company_name','zip','num_legal_names','num_incs','nodes_total','zip4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'multiword','multiword','number','namesPerAddress','RejectIfOverOne','RejectIfOverOne','hasZip4','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.cnp_name,(SALT32.StrType)le.company_name,(SALT32.StrType)le.zip,(SALT32.StrType)le.num_legal_names,(SALT32.StrType)le.num_incs,(SALT32.StrType)le.nodes_total,(SALT32.StrType)le.zip4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'cnp_name:multiword:CAPS','cnp_name:multiword:ALLOW'
          ,'company_name:multiword:CAPS','company_name:multiword:ALLOW'
          ,'zip:number:ALLOW'
          ,'num_legal_names:namesPerAddress:ENUM'
          ,'num_incs:RejectIfOverOne:ENUM'
          ,'nodes_total:RejectIfOverOne:ENUM'
          ,'zip4:hasZip4:ALLOW','zip4:hasZip4:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_cnp_name(1),Fields.InvalidMessage_cnp_name(2)
          ,Fields.InvalidMessage_company_name(1),Fields.InvalidMessage_company_name(2)
          ,Fields.InvalidMessage_zip(1)
          ,Fields.InvalidMessage_num_legal_names(1)
          ,Fields.InvalidMessage_num_incs(1)
          ,Fields.InvalidMessage_nodes_total(1)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.num_legal_names_ENUM_ErrorCount
          ,le.num_incs_ENUM_ErrorCount
          ,le.nodes_total_ENUM_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.num_legal_names_ENUM_ErrorCount
          ,le.num_incs_ENUM_ErrorCount
          ,le.nodes_total_ENUM_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,10,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
