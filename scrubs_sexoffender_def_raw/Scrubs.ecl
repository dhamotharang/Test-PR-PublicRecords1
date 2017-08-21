IMPORT ut,SALT33;
IMPORT scrubs_sexoffender_def_raw; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_sexoffender_def_raw)
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 firstname_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_sexoffender_def_raw)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_sexoffender_def_raw) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.lastname_Invalid := Fields.InValid_lastname((SALT33.StrType)le.lastname);
    SELF.firstname_Invalid := Fields.InValid_firstname((SALT33.StrType)le.firstname);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile0 := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_sexoffender_def_raw);
  EXPORT WithinList1 := DEDUP(SORT(TABLE(scrubs_sexoffender_def_raw.file_valid_lastname,{lastname}),lastname),ALL) : PERSIST('~temp::scrubs_sexoffender_def_raw::scrubs_sexoffender_def_raw.file_valid_lastname::lastname',EXPIRE(Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.lastname=RIGHT.lastname AND LEFT.lastname_Invalid=0, TRANSFORM(Expanded_Layout, SELF.lastname_Invalid:=MAP(RIGHT.lastname<>''=>0,LEFT.lastname_Invalid>0=>LEFT.lastname_Invalid,1),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT WithinList2 := DEDUP(SORT(TABLE(scrubs_sexoffender_def_raw.file_valid_firstname,{firstname}),firstname),ALL) : PERSIST('~temp::scrubs_sexoffender_def_raw::scrubs_sexoffender_def_raw.file_valid_firstname::firstname',EXPIRE(Config.PersistExpire));
  EXPORT ExpandedInfile2 := JOIN(ExpandedInfile1, WithinList2, LEFT.firstname=RIGHT.firstname AND LEFT.firstname_Invalid=0, TRANSFORM(Expanded_Layout, SELF.firstname_Invalid:=MAP(RIGHT.firstname<>''=>0,LEFT.firstname_Invalid>0=>LEFT.firstname_Invalid,1),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile2;
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.lastname_Invalid << 0 ) + ( le.firstname_Invalid << 1 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_sexoffender_def_raw);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    lastname_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    firstname_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.lastname_Invalid,le.firstname_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_lastname(le.lastname_Invalid),Fields.InvalidMessage_firstname(le.firstname_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.lastname_Invalid,'WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'WITHIN_FILE','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'lastname','firstname','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'lastName','firstName','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.lastname,(SALT33.StrType)le.firstname,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,2,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'lastname:lastName:WITHIN_FILE'
          ,'firstname:firstName:WITHIN_FILE','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_lastname(1)
          ,Fields.InvalidMessage_firstname(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.lastname_WITHIN_FILE_ErrorCount
          ,le.firstname_WITHIN_FILE_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.lastname_WITHIN_FILE_ErrorCount
          ,le.firstname_WITHIN_FILE_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,2,Into(LEFT,COUNTER));
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
