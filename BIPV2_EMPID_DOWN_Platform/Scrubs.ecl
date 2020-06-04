IMPORT ut,SALT32;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_EmpID)
    UNSIGNED1 contact_ssn_Invalid;
    UNSIGNED1 isContact_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_EmpID)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_EmpID) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.contact_ssn_Invalid := Fields.InValid_contact_ssn((SALT32.StrType)le.contact_ssn);
      clean_contact_ssn := (TYPEOF(le.contact_ssn))Fields.Make_contact_ssn((SALT32.StrType)le.contact_ssn);
      clean_contact_ssn_Invalid := Fields.InValid_contact_ssn((SALT32.StrType)clean_contact_ssn);
      SELF.contact_ssn := IF(withOnfail, clean_contact_ssn, le.contact_ssn); // ONFAIL(CLEAN)
    SELF.isContact_Invalid := Fields.InValid_isContact((SALT32.StrType)le.isContact);
      SELF.isContact := IF(SELF.isContact_Invalid=0 OR NOT withOnfail, le.isContact, SKIP); // ONFAIL(REJECT)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_EmpID);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.contact_ssn_Invalid << 0 ) + ( le.isContact_Invalid << 2 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_EmpID);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.contact_ssn_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.isContact_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.contact_ssn_Invalid <> RIGHT.contact_ssn_Invalid OR LEFT.isContact_Invalid <> RIGHT.isContact_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    contact_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=1);
    contact_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=2);
    contact_ssn_Total_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid>0);
    isContact_ALLOW_ErrorCount := COUNT(GROUP,h.isContact_Invalid=1);
    isContact_LENGTH_ErrorCount := COUNT(GROUP,h.isContact_Invalid=2);
    isContact_Total_ErrorCount := COUNT(GROUP,h.isContact_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.contact_ssn_Invalid,le.isContact_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_contact_ssn(le.contact_ssn_Invalid),Fields.InvalidMessage_isContact(le.isContact_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.contact_ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.isContact_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'contact_ssn','isContact','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'fld_ssn','fld_contact','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.contact_ssn,(SALT32.StrType)le.isContact,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,2,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'contact_ssn:fld_ssn:ALLOW','contact_ssn:fld_ssn:LENGTH'
          ,'isContact:fld_contact:ALLOW','isContact:fld_contact:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_contact_ssn(1),Fields.InvalidMessage_contact_ssn(2)
          ,Fields.InvalidMessage_isContact(1),Fields.InvalidMessage_isContact(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.contact_ssn_ALLOW_ErrorCount,le.contact_ssn_LENGTH_ErrorCount
          ,le.isContact_ALLOW_ErrorCount,le.isContact_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.contact_ssn_ALLOW_ErrorCount,le.contact_ssn_LENGTH_ErrorCount
          ,le.isContact_ALLOW_ErrorCount,le.isContact_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,4,Into(LEFT,COUNTER));
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
