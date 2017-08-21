IMPORT SALT37;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_bk_withdrawnstatus)
    UNSIGNED1 logid_Invalid;
    UNSIGNED1 logdate_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 defendantid_Invalid;
    UNSIGNED1 currentchapter_Invalid;
    UNSIGNED1 previouschapter_Invalid;
    UNSIGNED1 conversionid_Invalid;
    UNSIGNED1 convertdate_Invalid;
    UNSIGNED1 currentdisposition_Invalid;
    UNSIGNED1 dcode_Invalid;
    UNSIGNED1 currentdispositiondate_Invalid;
    UNSIGNED1 intseed_Invalid;
    UNSIGNED1 pid_Invalid;
    UNSIGNED1 tmsid_Invalid;
    UNSIGNED1 vacateid_Invalid;
    UNSIGNED1 vacatedate_Invalid;
    UNSIGNED1 vacateddisposition_Invalid;
    UNSIGNED1 vacateddispositiondate_Invalid;
    UNSIGNED1 withdrawnid_Invalid;
    UNSIGNED1 originalwithdrawndate_Invalid;
    UNSIGNED1 withdrawndate_Invalid;
    UNSIGNED1 withdrawndisposition_Invalid;
    UNSIGNED1 withdrawndispositiondate_Invalid;
    UNSIGNED1 originalwithdrawndispositiondate_Invalid;
    UNSIGNED1 filedinerror_Invalid;
    UNSIGNED1 reopendate_Invalid;
    UNSIGNED1 lastupdateddate_Invalid;
    UNSIGNED1 iscurrent_Invalid;
    UNSIGNED1 __filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_bk_withdrawnstatus)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_bk_withdrawnstatus) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.logid_Invalid := Fields.InValid_logid((SALT37.StrType)le.logid);
    SELF.logdate_Invalid := Fields.InValid_logdate((SALT37.StrType)le.logdate);
    SELF.caseid_Invalid := Fields.InValid_caseid((SALT37.StrType)le.caseid);
    SELF.defendantid_Invalid := Fields.InValid_defendantid((SALT37.StrType)le.defendantid);
    SELF.currentchapter_Invalid := Fields.InValid_currentchapter((SALT37.StrType)le.currentchapter);
    SELF.previouschapter_Invalid := Fields.InValid_previouschapter((SALT37.StrType)le.previouschapter);
    SELF.conversionid_Invalid := Fields.InValid_conversionid((SALT37.StrType)le.conversionid);
    SELF.convertdate_Invalid := Fields.InValid_convertdate((SALT37.StrType)le.convertdate);
    SELF.currentdisposition_Invalid := Fields.InValid_currentdisposition((SALT37.StrType)le.currentdisposition);
    SELF.dcode_Invalid := Fields.InValid_dcode((SALT37.StrType)le.dcode);
    SELF.currentdispositiondate_Invalid := Fields.InValid_currentdispositiondate((SALT37.StrType)le.currentdispositiondate);
    SELF.intseed_Invalid := Fields.InValid_intseed((SALT37.StrType)le.intseed);
    SELF.pid_Invalid := Fields.InValid_pid((SALT37.StrType)le.pid);
    SELF.tmsid_Invalid := Fields.InValid_tmsid((SALT37.StrType)le.tmsid);
    SELF.vacateid_Invalid := Fields.InValid_vacateid((SALT37.StrType)le.vacateid);
    SELF.vacatedate_Invalid := Fields.InValid_vacatedate((SALT37.StrType)le.vacatedate);
    SELF.vacateddisposition_Invalid := Fields.InValid_vacateddisposition((SALT37.StrType)le.vacateddisposition);
    SELF.vacateddispositiondate_Invalid := Fields.InValid_vacateddispositiondate((SALT37.StrType)le.vacateddispositiondate);
    SELF.withdrawnid_Invalid := Fields.InValid_withdrawnid((SALT37.StrType)le.withdrawnid);
    SELF.originalwithdrawndate_Invalid := Fields.InValid_originalwithdrawndate((SALT37.StrType)le.originalwithdrawndate);
    SELF.withdrawndate_Invalid := Fields.InValid_withdrawndate((SALT37.StrType)le.withdrawndate);
    SELF.withdrawndisposition_Invalid := Fields.InValid_withdrawndisposition((SALT37.StrType)le.withdrawndisposition);
    SELF.withdrawndispositiondate_Invalid := Fields.InValid_withdrawndispositiondate((SALT37.StrType)le.withdrawndispositiondate);
    SELF.originalwithdrawndispositiondate_Invalid := Fields.InValid_originalwithdrawndispositiondate((SALT37.StrType)le.originalwithdrawndispositiondate);
    SELF.filedinerror_Invalid := Fields.InValid_filedinerror((SALT37.StrType)le.filedinerror);
    SELF.reopendate_Invalid := Fields.InValid_reopendate((SALT37.StrType)le.reopendate);
    SELF.lastupdateddate_Invalid := Fields.InValid_lastupdateddate((SALT37.StrType)le.lastupdateddate);
    SELF.iscurrent_Invalid := Fields.InValid_iscurrent((SALT37.StrType)le.iscurrent);
    SELF.__filename_Invalid := Fields.InValid___filename((SALT37.StrType)le.__filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_bk_withdrawnstatus);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.logid_Invalid << 0 ) + ( le.logdate_Invalid << 3 ) + ( le.caseid_Invalid << 6 ) + ( le.defendantid_Invalid << 9 ) + ( le.currentchapter_Invalid << 12 ) + ( le.previouschapter_Invalid << 15 ) + ( le.conversionid_Invalid << 18 ) + ( le.convertdate_Invalid << 21 ) + ( le.currentdisposition_Invalid << 24 ) + ( le.dcode_Invalid << 27 ) + ( le.currentdispositiondate_Invalid << 30 ) + ( le.intseed_Invalid << 33 ) + ( le.pid_Invalid << 36 ) + ( le.tmsid_Invalid << 39 ) + ( le.vacateid_Invalid << 42 ) + ( le.vacatedate_Invalid << 45 ) + ( le.vacateddisposition_Invalid << 48 ) + ( le.vacateddispositiondate_Invalid << 51 ) + ( le.withdrawnid_Invalid << 54 ) + ( le.originalwithdrawndate_Invalid << 57 ) + ( le.withdrawndate_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.withdrawndisposition_Invalid << 0 ) + ( le.withdrawndispositiondate_Invalid << 3 ) + ( le.originalwithdrawndispositiondate_Invalid << 6 ) + ( le.filedinerror_Invalid << 9 ) + ( le.reopendate_Invalid << 12 ) + ( le.lastupdateddate_Invalid << 15 ) + ( le.iscurrent_Invalid << 18 ) + ( le.__filename_Invalid << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_bk_withdrawnstatus);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.logid_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.logdate_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.defendantid_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.currentchapter_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.previouschapter_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.conversionid_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.convertdate_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.currentdisposition_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.dcode_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.currentdispositiondate_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.intseed_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.pid_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.tmsid_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.vacateid_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.vacatedate_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.vacateddisposition_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.vacateddispositiondate_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.withdrawnid_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.originalwithdrawndate_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.withdrawndate_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.withdrawndisposition_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.withdrawndispositiondate_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.originalwithdrawndispositiondate_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.filedinerror_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.reopendate_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.lastupdateddate_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.iscurrent_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.__filename_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    logid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.logid_Invalid=1);
    logid_ALLOW_ErrorCount := COUNT(GROUP,h.logid_Invalid=2);
    logid_LENGTH_ErrorCount := COUNT(GROUP,h.logid_Invalid=3);
    logid_WORDS_ErrorCount := COUNT(GROUP,h.logid_Invalid=4);
    logid_Total_ErrorCount := COUNT(GROUP,h.logid_Invalid>0);
    logdate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.logdate_Invalid=1);
    logdate_ALLOW_ErrorCount := COUNT(GROUP,h.logdate_Invalid=2);
    logdate_LENGTH_ErrorCount := COUNT(GROUP,h.logdate_Invalid=3);
    logdate_WORDS_ErrorCount := COUNT(GROUP,h.logdate_Invalid=4);
    logdate_Total_ErrorCount := COUNT(GROUP,h.logdate_Invalid>0);
    caseid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    caseid_ALLOW_ErrorCount := COUNT(GROUP,h.caseid_Invalid=2);
    caseid_LENGTH_ErrorCount := COUNT(GROUP,h.caseid_Invalid=3);
    caseid_WORDS_ErrorCount := COUNT(GROUP,h.caseid_Invalid=4);
    caseid_Total_ErrorCount := COUNT(GROUP,h.caseid_Invalid>0);
    defendantid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.defendantid_Invalid=1);
    defendantid_ALLOW_ErrorCount := COUNT(GROUP,h.defendantid_Invalid=2);
    defendantid_LENGTH_ErrorCount := COUNT(GROUP,h.defendantid_Invalid=3);
    defendantid_WORDS_ErrorCount := COUNT(GROUP,h.defendantid_Invalid=4);
    defendantid_Total_ErrorCount := COUNT(GROUP,h.defendantid_Invalid>0);
    currentchapter_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentchapter_Invalid=1);
    currentchapter_ALLOW_ErrorCount := COUNT(GROUP,h.currentchapter_Invalid=2);
    currentchapter_LENGTH_ErrorCount := COUNT(GROUP,h.currentchapter_Invalid=3);
    currentchapter_WORDS_ErrorCount := COUNT(GROUP,h.currentchapter_Invalid=4);
    currentchapter_Total_ErrorCount := COUNT(GROUP,h.currentchapter_Invalid>0);
    previouschapter_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previouschapter_Invalid=1);
    previouschapter_ALLOW_ErrorCount := COUNT(GROUP,h.previouschapter_Invalid=2);
    previouschapter_LENGTH_ErrorCount := COUNT(GROUP,h.previouschapter_Invalid=3);
    previouschapter_WORDS_ErrorCount := COUNT(GROUP,h.previouschapter_Invalid=4);
    previouschapter_Total_ErrorCount := COUNT(GROUP,h.previouschapter_Invalid>0);
    conversionid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.conversionid_Invalid=1);
    conversionid_ALLOW_ErrorCount := COUNT(GROUP,h.conversionid_Invalid=2);
    conversionid_LENGTH_ErrorCount := COUNT(GROUP,h.conversionid_Invalid=3);
    conversionid_WORDS_ErrorCount := COUNT(GROUP,h.conversionid_Invalid=4);
    conversionid_Total_ErrorCount := COUNT(GROUP,h.conversionid_Invalid>0);
    convertdate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.convertdate_Invalid=1);
    convertdate_ALLOW_ErrorCount := COUNT(GROUP,h.convertdate_Invalid=2);
    convertdate_LENGTH_ErrorCount := COUNT(GROUP,h.convertdate_Invalid=3);
    convertdate_WORDS_ErrorCount := COUNT(GROUP,h.convertdate_Invalid=4);
    convertdate_Total_ErrorCount := COUNT(GROUP,h.convertdate_Invalid>0);
    currentdisposition_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentdisposition_Invalid=1);
    currentdisposition_ALLOW_ErrorCount := COUNT(GROUP,h.currentdisposition_Invalid=2);
    currentdisposition_LENGTH_ErrorCount := COUNT(GROUP,h.currentdisposition_Invalid=3);
    currentdisposition_WORDS_ErrorCount := COUNT(GROUP,h.currentdisposition_Invalid=4);
    currentdisposition_Total_ErrorCount := COUNT(GROUP,h.currentdisposition_Invalid>0);
    dcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dcode_Invalid=1);
    dcode_ALLOW_ErrorCount := COUNT(GROUP,h.dcode_Invalid=2);
    dcode_LENGTH_ErrorCount := COUNT(GROUP,h.dcode_Invalid=3);
    dcode_WORDS_ErrorCount := COUNT(GROUP,h.dcode_Invalid=4);
    dcode_Total_ErrorCount := COUNT(GROUP,h.dcode_Invalid>0);
    currentdispositiondate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.currentdispositiondate_Invalid=1);
    currentdispositiondate_ALLOW_ErrorCount := COUNT(GROUP,h.currentdispositiondate_Invalid=2);
    currentdispositiondate_LENGTH_ErrorCount := COUNT(GROUP,h.currentdispositiondate_Invalid=3);
    currentdispositiondate_WORDS_ErrorCount := COUNT(GROUP,h.currentdispositiondate_Invalid=4);
    currentdispositiondate_Total_ErrorCount := COUNT(GROUP,h.currentdispositiondate_Invalid>0);
    intseed_LEFTTRIM_ErrorCount := COUNT(GROUP,h.intseed_Invalid=1);
    intseed_ALLOW_ErrorCount := COUNT(GROUP,h.intseed_Invalid=2);
    intseed_LENGTH_ErrorCount := COUNT(GROUP,h.intseed_Invalid=3);
    intseed_WORDS_ErrorCount := COUNT(GROUP,h.intseed_Invalid=4);
    intseed_Total_ErrorCount := COUNT(GROUP,h.intseed_Invalid>0);
    pid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pid_Invalid=1);
    pid_ALLOW_ErrorCount := COUNT(GROUP,h.pid_Invalid=2);
    pid_LENGTH_ErrorCount := COUNT(GROUP,h.pid_Invalid=3);
    pid_WORDS_ErrorCount := COUNT(GROUP,h.pid_Invalid=4);
    pid_Total_ErrorCount := COUNT(GROUP,h.pid_Invalid>0);
    tmsid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=1);
    tmsid_ALLOW_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=2);
    tmsid_LENGTH_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=3);
    tmsid_WORDS_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=4);
    tmsid_Total_ErrorCount := COUNT(GROUP,h.tmsid_Invalid>0);
    vacateid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.vacateid_Invalid=1);
    vacateid_ALLOW_ErrorCount := COUNT(GROUP,h.vacateid_Invalid=2);
    vacateid_LENGTH_ErrorCount := COUNT(GROUP,h.vacateid_Invalid=3);
    vacateid_WORDS_ErrorCount := COUNT(GROUP,h.vacateid_Invalid=4);
    vacateid_Total_ErrorCount := COUNT(GROUP,h.vacateid_Invalid>0);
    vacatedate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.vacatedate_Invalid=1);
    vacatedate_ALLOW_ErrorCount := COUNT(GROUP,h.vacatedate_Invalid=2);
    vacatedate_LENGTH_ErrorCount := COUNT(GROUP,h.vacatedate_Invalid=3);
    vacatedate_WORDS_ErrorCount := COUNT(GROUP,h.vacatedate_Invalid=4);
    vacatedate_Total_ErrorCount := COUNT(GROUP,h.vacatedate_Invalid>0);
    vacateddisposition_LEFTTRIM_ErrorCount := COUNT(GROUP,h.vacateddisposition_Invalid=1);
    vacateddisposition_ALLOW_ErrorCount := COUNT(GROUP,h.vacateddisposition_Invalid=2);
    vacateddisposition_LENGTH_ErrorCount := COUNT(GROUP,h.vacateddisposition_Invalid=3);
    vacateddisposition_WORDS_ErrorCount := COUNT(GROUP,h.vacateddisposition_Invalid=4);
    vacateddisposition_Total_ErrorCount := COUNT(GROUP,h.vacateddisposition_Invalid>0);
    vacateddispositiondate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.vacateddispositiondate_Invalid=1);
    vacateddispositiondate_ALLOW_ErrorCount := COUNT(GROUP,h.vacateddispositiondate_Invalid=2);
    vacateddispositiondate_LENGTH_ErrorCount := COUNT(GROUP,h.vacateddispositiondate_Invalid=3);
    vacateddispositiondate_WORDS_ErrorCount := COUNT(GROUP,h.vacateddispositiondate_Invalid=4);
    vacateddispositiondate_Total_ErrorCount := COUNT(GROUP,h.vacateddispositiondate_Invalid>0);
    withdrawnid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.withdrawnid_Invalid=1);
    withdrawnid_ALLOW_ErrorCount := COUNT(GROUP,h.withdrawnid_Invalid=2);
    withdrawnid_LENGTH_ErrorCount := COUNT(GROUP,h.withdrawnid_Invalid=3);
    withdrawnid_WORDS_ErrorCount := COUNT(GROUP,h.withdrawnid_Invalid=4);
    withdrawnid_Total_ErrorCount := COUNT(GROUP,h.withdrawnid_Invalid>0);
    originalwithdrawndate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.originalwithdrawndate_Invalid=1);
    originalwithdrawndate_ALLOW_ErrorCount := COUNT(GROUP,h.originalwithdrawndate_Invalid=2);
    originalwithdrawndate_LENGTH_ErrorCount := COUNT(GROUP,h.originalwithdrawndate_Invalid=3);
    originalwithdrawndate_WORDS_ErrorCount := COUNT(GROUP,h.originalwithdrawndate_Invalid=4);
    originalwithdrawndate_Total_ErrorCount := COUNT(GROUP,h.originalwithdrawndate_Invalid>0);
    withdrawndate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.withdrawndate_Invalid=1);
    withdrawndate_ALLOW_ErrorCount := COUNT(GROUP,h.withdrawndate_Invalid=2);
    withdrawndate_LENGTH_ErrorCount := COUNT(GROUP,h.withdrawndate_Invalid=3);
    withdrawndate_WORDS_ErrorCount := COUNT(GROUP,h.withdrawndate_Invalid=4);
    withdrawndate_Total_ErrorCount := COUNT(GROUP,h.withdrawndate_Invalid>0);
    withdrawndisposition_LEFTTRIM_ErrorCount := COUNT(GROUP,h.withdrawndisposition_Invalid=1);
    withdrawndisposition_ALLOW_ErrorCount := COUNT(GROUP,h.withdrawndisposition_Invalid=2);
    withdrawndisposition_LENGTH_ErrorCount := COUNT(GROUP,h.withdrawndisposition_Invalid=3);
    withdrawndisposition_WORDS_ErrorCount := COUNT(GROUP,h.withdrawndisposition_Invalid=4);
    withdrawndisposition_Total_ErrorCount := COUNT(GROUP,h.withdrawndisposition_Invalid>0);
    withdrawndispositiondate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.withdrawndispositiondate_Invalid=1);
    withdrawndispositiondate_ALLOW_ErrorCount := COUNT(GROUP,h.withdrawndispositiondate_Invalid=2);
    withdrawndispositiondate_LENGTH_ErrorCount := COUNT(GROUP,h.withdrawndispositiondate_Invalid=3);
    withdrawndispositiondate_WORDS_ErrorCount := COUNT(GROUP,h.withdrawndispositiondate_Invalid=4);
    withdrawndispositiondate_Total_ErrorCount := COUNT(GROUP,h.withdrawndispositiondate_Invalid>0);
    originalwithdrawndispositiondate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.originalwithdrawndispositiondate_Invalid=1);
    originalwithdrawndispositiondate_ALLOW_ErrorCount := COUNT(GROUP,h.originalwithdrawndispositiondate_Invalid=2);
    originalwithdrawndispositiondate_LENGTH_ErrorCount := COUNT(GROUP,h.originalwithdrawndispositiondate_Invalid=3);
    originalwithdrawndispositiondate_WORDS_ErrorCount := COUNT(GROUP,h.originalwithdrawndispositiondate_Invalid=4);
    originalwithdrawndispositiondate_Total_ErrorCount := COUNT(GROUP,h.originalwithdrawndispositiondate_Invalid>0);
    filedinerror_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filedinerror_Invalid=1);
    filedinerror_ALLOW_ErrorCount := COUNT(GROUP,h.filedinerror_Invalid=2);
    filedinerror_LENGTH_ErrorCount := COUNT(GROUP,h.filedinerror_Invalid=3);
    filedinerror_WORDS_ErrorCount := COUNT(GROUP,h.filedinerror_Invalid=4);
    filedinerror_Total_ErrorCount := COUNT(GROUP,h.filedinerror_Invalid>0);
    reopendate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.reopendate_Invalid=1);
    reopendate_ALLOW_ErrorCount := COUNT(GROUP,h.reopendate_Invalid=2);
    reopendate_LENGTH_ErrorCount := COUNT(GROUP,h.reopendate_Invalid=3);
    reopendate_WORDS_ErrorCount := COUNT(GROUP,h.reopendate_Invalid=4);
    reopendate_Total_ErrorCount := COUNT(GROUP,h.reopendate_Invalid>0);
    lastupdateddate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lastupdateddate_Invalid=1);
    lastupdateddate_ALLOW_ErrorCount := COUNT(GROUP,h.lastupdateddate_Invalid=2);
    lastupdateddate_LENGTH_ErrorCount := COUNT(GROUP,h.lastupdateddate_Invalid=3);
    lastupdateddate_WORDS_ErrorCount := COUNT(GROUP,h.lastupdateddate_Invalid=4);
    lastupdateddate_Total_ErrorCount := COUNT(GROUP,h.lastupdateddate_Invalid>0);
    iscurrent_LEFTTRIM_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=1);
    iscurrent_ALLOW_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=2);
    iscurrent_LENGTH_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=3);
    iscurrent_WORDS_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=4);
    iscurrent_Total_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid>0);
    __filename_LEFTTRIM_ErrorCount := COUNT(GROUP,h.__filename_Invalid=1);
    __filename_ALLOW_ErrorCount := COUNT(GROUP,h.__filename_Invalid=2);
    __filename_LENGTH_ErrorCount := COUNT(GROUP,h.__filename_Invalid=3);
    __filename_WORDS_ErrorCount := COUNT(GROUP,h.__filename_Invalid=4);
    __filename_Total_ErrorCount := COUNT(GROUP,h.__filename_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.logid_Invalid,le.logdate_Invalid,le.caseid_Invalid,le.defendantid_Invalid,le.currentchapter_Invalid,le.previouschapter_Invalid,le.conversionid_Invalid,le.convertdate_Invalid,le.currentdisposition_Invalid,le.dcode_Invalid,le.currentdispositiondate_Invalid,le.intseed_Invalid,le.pid_Invalid,le.tmsid_Invalid,le.vacateid_Invalid,le.vacatedate_Invalid,le.vacateddisposition_Invalid,le.vacateddispositiondate_Invalid,le.withdrawnid_Invalid,le.originalwithdrawndate_Invalid,le.withdrawndate_Invalid,le.withdrawndisposition_Invalid,le.withdrawndispositiondate_Invalid,le.originalwithdrawndispositiondate_Invalid,le.filedinerror_Invalid,le.reopendate_Invalid,le.lastupdateddate_Invalid,le.iscurrent_Invalid,le.__filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_logid(le.logid_Invalid),Fields.InvalidMessage_logdate(le.logdate_Invalid),Fields.InvalidMessage_caseid(le.caseid_Invalid),Fields.InvalidMessage_defendantid(le.defendantid_Invalid),Fields.InvalidMessage_currentchapter(le.currentchapter_Invalid),Fields.InvalidMessage_previouschapter(le.previouschapter_Invalid),Fields.InvalidMessage_conversionid(le.conversionid_Invalid),Fields.InvalidMessage_convertdate(le.convertdate_Invalid),Fields.InvalidMessage_currentdisposition(le.currentdisposition_Invalid),Fields.InvalidMessage_dcode(le.dcode_Invalid),Fields.InvalidMessage_currentdispositiondate(le.currentdispositiondate_Invalid),Fields.InvalidMessage_intseed(le.intseed_Invalid),Fields.InvalidMessage_pid(le.pid_Invalid),Fields.InvalidMessage_tmsid(le.tmsid_Invalid),Fields.InvalidMessage_vacateid(le.vacateid_Invalid),Fields.InvalidMessage_vacatedate(le.vacatedate_Invalid),Fields.InvalidMessage_vacateddisposition(le.vacateddisposition_Invalid),Fields.InvalidMessage_vacateddispositiondate(le.vacateddispositiondate_Invalid),Fields.InvalidMessage_withdrawnid(le.withdrawnid_Invalid),Fields.InvalidMessage_originalwithdrawndate(le.originalwithdrawndate_Invalid),Fields.InvalidMessage_withdrawndate(le.withdrawndate_Invalid),Fields.InvalidMessage_withdrawndisposition(le.withdrawndisposition_Invalid),Fields.InvalidMessage_withdrawndispositiondate(le.withdrawndispositiondate_Invalid),Fields.InvalidMessage_originalwithdrawndispositiondate(le.originalwithdrawndispositiondate_Invalid),Fields.InvalidMessage_filedinerror(le.filedinerror_Invalid),Fields.InvalidMessage_reopendate(le.reopendate_Invalid),Fields.InvalidMessage_lastupdateddate(le.lastupdateddate_Invalid),Fields.InvalidMessage_iscurrent(le.iscurrent_Invalid),Fields.InvalidMessage___filename(le.__filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.logid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.logdate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.defendantid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentchapter_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previouschapter_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.conversionid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.convertdate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentdisposition_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.currentdispositiondate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.intseed_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.pid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.tmsid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.vacateid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.vacatedate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.vacateddisposition_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.vacateddispositiondate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.withdrawnid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.originalwithdrawndate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.withdrawndate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.withdrawndisposition_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.withdrawndispositiondate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.originalwithdrawndispositiondate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filedinerror_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.reopendate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lastupdateddate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.iscurrent_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.__filename_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'logid','logdate','caseid','defendantid','currentchapter','previouschapter','conversionid','convertdate','currentdisposition','dcode','currentdispositiondate','intseed','pid','tmsid','vacateid','vacatedate','vacateddisposition','vacateddispositiondate','withdrawnid','originalwithdrawndate','withdrawndate','withdrawndisposition','withdrawndispositiondate','originalwithdrawndispositiondate','filedinerror','reopendate','lastupdateddate','iscurrent','__filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'logid','logdate','caseid','defendantid','currentchapter','previouschapter','conversionid','convertdate','currentdisposition','dcode','currentdispositiondate','intseed','pid','tmsid','vacateid','vacatedate','vacateddisposition','vacateddispositiondate','withdrawnid','originalwithdrawndate','withdrawndate','withdrawndisposition','withdrawndispositiondate','originalwithdrawndispositiondate','filedinerror','reopendate','lastupdateddate','iscurrent','__filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.logid,(SALT37.StrType)le.logdate,(SALT37.StrType)le.caseid,(SALT37.StrType)le.defendantid,(SALT37.StrType)le.currentchapter,(SALT37.StrType)le.previouschapter,(SALT37.StrType)le.conversionid,(SALT37.StrType)le.convertdate,(SALT37.StrType)le.currentdisposition,(SALT37.StrType)le.dcode,(SALT37.StrType)le.currentdispositiondate,(SALT37.StrType)le.intseed,(SALT37.StrType)le.pid,(SALT37.StrType)le.tmsid,(SALT37.StrType)le.vacateid,(SALT37.StrType)le.vacatedate,(SALT37.StrType)le.vacateddisposition,(SALT37.StrType)le.vacateddispositiondate,(SALT37.StrType)le.withdrawnid,(SALT37.StrType)le.originalwithdrawndate,(SALT37.StrType)le.withdrawndate,(SALT37.StrType)le.withdrawndisposition,(SALT37.StrType)le.withdrawndispositiondate,(SALT37.StrType)le.originalwithdrawndispositiondate,(SALT37.StrType)le.filedinerror,(SALT37.StrType)le.reopendate,(SALT37.StrType)le.lastupdateddate,(SALT37.StrType)le.iscurrent,(SALT37.StrType)le.__filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,29,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'logid:logid:LEFTTRIM','logid:logid:ALLOW','logid:logid:LENGTH','logid:logid:WORDS'
          ,'logdate:logdate:LEFTTRIM','logdate:logdate:ALLOW','logdate:logdate:LENGTH','logdate:logdate:WORDS'
          ,'caseid:caseid:LEFTTRIM','caseid:caseid:ALLOW','caseid:caseid:LENGTH','caseid:caseid:WORDS'
          ,'defendantid:defendantid:LEFTTRIM','defendantid:defendantid:ALLOW','defendantid:defendantid:LENGTH','defendantid:defendantid:WORDS'
          ,'currentchapter:currentchapter:LEFTTRIM','currentchapter:currentchapter:ALLOW','currentchapter:currentchapter:LENGTH','currentchapter:currentchapter:WORDS'
          ,'previouschapter:previouschapter:LEFTTRIM','previouschapter:previouschapter:ALLOW','previouschapter:previouschapter:LENGTH','previouschapter:previouschapter:WORDS'
          ,'conversionid:conversionid:LEFTTRIM','conversionid:conversionid:ALLOW','conversionid:conversionid:LENGTH','conversionid:conversionid:WORDS'
          ,'convertdate:convertdate:LEFTTRIM','convertdate:convertdate:ALLOW','convertdate:convertdate:LENGTH','convertdate:convertdate:WORDS'
          ,'currentdisposition:currentdisposition:LEFTTRIM','currentdisposition:currentdisposition:ALLOW','currentdisposition:currentdisposition:LENGTH','currentdisposition:currentdisposition:WORDS'
          ,'dcode:dcode:LEFTTRIM','dcode:dcode:ALLOW','dcode:dcode:LENGTH','dcode:dcode:WORDS'
          ,'currentdispositiondate:currentdispositiondate:LEFTTRIM','currentdispositiondate:currentdispositiondate:ALLOW','currentdispositiondate:currentdispositiondate:LENGTH','currentdispositiondate:currentdispositiondate:WORDS'
          ,'intseed:intseed:LEFTTRIM','intseed:intseed:ALLOW','intseed:intseed:LENGTH','intseed:intseed:WORDS'
          ,'pid:pid:LEFTTRIM','pid:pid:ALLOW','pid:pid:LENGTH','pid:pid:WORDS'
          ,'tmsid:tmsid:LEFTTRIM','tmsid:tmsid:ALLOW','tmsid:tmsid:LENGTH','tmsid:tmsid:WORDS'
          ,'vacateid:vacateid:LEFTTRIM','vacateid:vacateid:ALLOW','vacateid:vacateid:LENGTH','vacateid:vacateid:WORDS'
          ,'vacatedate:vacatedate:LEFTTRIM','vacatedate:vacatedate:ALLOW','vacatedate:vacatedate:LENGTH','vacatedate:vacatedate:WORDS'
          ,'vacateddisposition:vacateddisposition:LEFTTRIM','vacateddisposition:vacateddisposition:ALLOW','vacateddisposition:vacateddisposition:LENGTH','vacateddisposition:vacateddisposition:WORDS'
          ,'vacateddispositiondate:vacateddispositiondate:LEFTTRIM','vacateddispositiondate:vacateddispositiondate:ALLOW','vacateddispositiondate:vacateddispositiondate:LENGTH','vacateddispositiondate:vacateddispositiondate:WORDS'
          ,'withdrawnid:withdrawnid:LEFTTRIM','withdrawnid:withdrawnid:ALLOW','withdrawnid:withdrawnid:LENGTH','withdrawnid:withdrawnid:WORDS'
          ,'originalwithdrawndate:originalwithdrawndate:LEFTTRIM','originalwithdrawndate:originalwithdrawndate:ALLOW','originalwithdrawndate:originalwithdrawndate:LENGTH','originalwithdrawndate:originalwithdrawndate:WORDS'
          ,'withdrawndate:withdrawndate:LEFTTRIM','withdrawndate:withdrawndate:ALLOW','withdrawndate:withdrawndate:LENGTH','withdrawndate:withdrawndate:WORDS'
          ,'withdrawndisposition:withdrawndisposition:LEFTTRIM','withdrawndisposition:withdrawndisposition:ALLOW','withdrawndisposition:withdrawndisposition:LENGTH','withdrawndisposition:withdrawndisposition:WORDS'
          ,'withdrawndispositiondate:withdrawndispositiondate:LEFTTRIM','withdrawndispositiondate:withdrawndispositiondate:ALLOW','withdrawndispositiondate:withdrawndispositiondate:LENGTH','withdrawndispositiondate:withdrawndispositiondate:WORDS'
          ,'originalwithdrawndispositiondate:originalwithdrawndispositiondate:LEFTTRIM','originalwithdrawndispositiondate:originalwithdrawndispositiondate:ALLOW','originalwithdrawndispositiondate:originalwithdrawndispositiondate:LENGTH','originalwithdrawndispositiondate:originalwithdrawndispositiondate:WORDS'
          ,'filedinerror:filedinerror:LEFTTRIM','filedinerror:filedinerror:ALLOW','filedinerror:filedinerror:LENGTH','filedinerror:filedinerror:WORDS'
          ,'reopendate:reopendate:LEFTTRIM','reopendate:reopendate:ALLOW','reopendate:reopendate:LENGTH','reopendate:reopendate:WORDS'
          ,'lastupdateddate:lastupdateddate:LEFTTRIM','lastupdateddate:lastupdateddate:ALLOW','lastupdateddate:lastupdateddate:LENGTH','lastupdateddate:lastupdateddate:WORDS'
          ,'iscurrent:iscurrent:LEFTTRIM','iscurrent:iscurrent:ALLOW','iscurrent:iscurrent:LENGTH','iscurrent:iscurrent:WORDS'
          ,'__filename:__filename:LEFTTRIM','__filename:__filename:ALLOW','__filename:__filename:LENGTH','__filename:__filename:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_logid(1),Fields.InvalidMessage_logid(2),Fields.InvalidMessage_logid(3),Fields.InvalidMessage_logid(4)
          ,Fields.InvalidMessage_logdate(1),Fields.InvalidMessage_logdate(2),Fields.InvalidMessage_logdate(3),Fields.InvalidMessage_logdate(4)
          ,Fields.InvalidMessage_caseid(1),Fields.InvalidMessage_caseid(2),Fields.InvalidMessage_caseid(3),Fields.InvalidMessage_caseid(4)
          ,Fields.InvalidMessage_defendantid(1),Fields.InvalidMessage_defendantid(2),Fields.InvalidMessage_defendantid(3),Fields.InvalidMessage_defendantid(4)
          ,Fields.InvalidMessage_currentchapter(1),Fields.InvalidMessage_currentchapter(2),Fields.InvalidMessage_currentchapter(3),Fields.InvalidMessage_currentchapter(4)
          ,Fields.InvalidMessage_previouschapter(1),Fields.InvalidMessage_previouschapter(2),Fields.InvalidMessage_previouschapter(3),Fields.InvalidMessage_previouschapter(4)
          ,Fields.InvalidMessage_conversionid(1),Fields.InvalidMessage_conversionid(2),Fields.InvalidMessage_conversionid(3),Fields.InvalidMessage_conversionid(4)
          ,Fields.InvalidMessage_convertdate(1),Fields.InvalidMessage_convertdate(2),Fields.InvalidMessage_convertdate(3),Fields.InvalidMessage_convertdate(4)
          ,Fields.InvalidMessage_currentdisposition(1),Fields.InvalidMessage_currentdisposition(2),Fields.InvalidMessage_currentdisposition(3),Fields.InvalidMessage_currentdisposition(4)
          ,Fields.InvalidMessage_dcode(1),Fields.InvalidMessage_dcode(2),Fields.InvalidMessage_dcode(3),Fields.InvalidMessage_dcode(4)
          ,Fields.InvalidMessage_currentdispositiondate(1),Fields.InvalidMessage_currentdispositiondate(2),Fields.InvalidMessage_currentdispositiondate(3),Fields.InvalidMessage_currentdispositiondate(4)
          ,Fields.InvalidMessage_intseed(1),Fields.InvalidMessage_intseed(2),Fields.InvalidMessage_intseed(3),Fields.InvalidMessage_intseed(4)
          ,Fields.InvalidMessage_pid(1),Fields.InvalidMessage_pid(2),Fields.InvalidMessage_pid(3),Fields.InvalidMessage_pid(4)
          ,Fields.InvalidMessage_tmsid(1),Fields.InvalidMessage_tmsid(2),Fields.InvalidMessage_tmsid(3),Fields.InvalidMessage_tmsid(4)
          ,Fields.InvalidMessage_vacateid(1),Fields.InvalidMessage_vacateid(2),Fields.InvalidMessage_vacateid(3),Fields.InvalidMessage_vacateid(4)
          ,Fields.InvalidMessage_vacatedate(1),Fields.InvalidMessage_vacatedate(2),Fields.InvalidMessage_vacatedate(3),Fields.InvalidMessage_vacatedate(4)
          ,Fields.InvalidMessage_vacateddisposition(1),Fields.InvalidMessage_vacateddisposition(2),Fields.InvalidMessage_vacateddisposition(3),Fields.InvalidMessage_vacateddisposition(4)
          ,Fields.InvalidMessage_vacateddispositiondate(1),Fields.InvalidMessage_vacateddispositiondate(2),Fields.InvalidMessage_vacateddispositiondate(3),Fields.InvalidMessage_vacateddispositiondate(4)
          ,Fields.InvalidMessage_withdrawnid(1),Fields.InvalidMessage_withdrawnid(2),Fields.InvalidMessage_withdrawnid(3),Fields.InvalidMessage_withdrawnid(4)
          ,Fields.InvalidMessage_originalwithdrawndate(1),Fields.InvalidMessage_originalwithdrawndate(2),Fields.InvalidMessage_originalwithdrawndate(3),Fields.InvalidMessage_originalwithdrawndate(4)
          ,Fields.InvalidMessage_withdrawndate(1),Fields.InvalidMessage_withdrawndate(2),Fields.InvalidMessage_withdrawndate(3),Fields.InvalidMessage_withdrawndate(4)
          ,Fields.InvalidMessage_withdrawndisposition(1),Fields.InvalidMessage_withdrawndisposition(2),Fields.InvalidMessage_withdrawndisposition(3),Fields.InvalidMessage_withdrawndisposition(4)
          ,Fields.InvalidMessage_withdrawndispositiondate(1),Fields.InvalidMessage_withdrawndispositiondate(2),Fields.InvalidMessage_withdrawndispositiondate(3),Fields.InvalidMessage_withdrawndispositiondate(4)
          ,Fields.InvalidMessage_originalwithdrawndispositiondate(1),Fields.InvalidMessage_originalwithdrawndispositiondate(2),Fields.InvalidMessage_originalwithdrawndispositiondate(3),Fields.InvalidMessage_originalwithdrawndispositiondate(4)
          ,Fields.InvalidMessage_filedinerror(1),Fields.InvalidMessage_filedinerror(2),Fields.InvalidMessage_filedinerror(3),Fields.InvalidMessage_filedinerror(4)
          ,Fields.InvalidMessage_reopendate(1),Fields.InvalidMessage_reopendate(2),Fields.InvalidMessage_reopendate(3),Fields.InvalidMessage_reopendate(4)
          ,Fields.InvalidMessage_lastupdateddate(1),Fields.InvalidMessage_lastupdateddate(2),Fields.InvalidMessage_lastupdateddate(3),Fields.InvalidMessage_lastupdateddate(4)
          ,Fields.InvalidMessage_iscurrent(1),Fields.InvalidMessage_iscurrent(2),Fields.InvalidMessage_iscurrent(3),Fields.InvalidMessage_iscurrent(4)
          ,Fields.InvalidMessage___filename(1),Fields.InvalidMessage___filename(2),Fields.InvalidMessage___filename(3),Fields.InvalidMessage___filename(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.logid_LEFTTRIM_ErrorCount,le.logid_ALLOW_ErrorCount,le.logid_LENGTH_ErrorCount,le.logid_WORDS_ErrorCount
          ,le.logdate_LEFTTRIM_ErrorCount,le.logdate_ALLOW_ErrorCount,le.logdate_LENGTH_ErrorCount,le.logdate_WORDS_ErrorCount
          ,le.caseid_LEFTTRIM_ErrorCount,le.caseid_ALLOW_ErrorCount,le.caseid_LENGTH_ErrorCount,le.caseid_WORDS_ErrorCount
          ,le.defendantid_LEFTTRIM_ErrorCount,le.defendantid_ALLOW_ErrorCount,le.defendantid_LENGTH_ErrorCount,le.defendantid_WORDS_ErrorCount
          ,le.currentchapter_LEFTTRIM_ErrorCount,le.currentchapter_ALLOW_ErrorCount,le.currentchapter_LENGTH_ErrorCount,le.currentchapter_WORDS_ErrorCount
          ,le.previouschapter_LEFTTRIM_ErrorCount,le.previouschapter_ALLOW_ErrorCount,le.previouschapter_LENGTH_ErrorCount,le.previouschapter_WORDS_ErrorCount
          ,le.conversionid_LEFTTRIM_ErrorCount,le.conversionid_ALLOW_ErrorCount,le.conversionid_LENGTH_ErrorCount,le.conversionid_WORDS_ErrorCount
          ,le.convertdate_LEFTTRIM_ErrorCount,le.convertdate_ALLOW_ErrorCount,le.convertdate_LENGTH_ErrorCount,le.convertdate_WORDS_ErrorCount
          ,le.currentdisposition_LEFTTRIM_ErrorCount,le.currentdisposition_ALLOW_ErrorCount,le.currentdisposition_LENGTH_ErrorCount,le.currentdisposition_WORDS_ErrorCount
          ,le.dcode_LEFTTRIM_ErrorCount,le.dcode_ALLOW_ErrorCount,le.dcode_LENGTH_ErrorCount,le.dcode_WORDS_ErrorCount
          ,le.currentdispositiondate_LEFTTRIM_ErrorCount,le.currentdispositiondate_ALLOW_ErrorCount,le.currentdispositiondate_LENGTH_ErrorCount,le.currentdispositiondate_WORDS_ErrorCount
          ,le.intseed_LEFTTRIM_ErrorCount,le.intseed_ALLOW_ErrorCount,le.intseed_LENGTH_ErrorCount,le.intseed_WORDS_ErrorCount
          ,le.pid_LEFTTRIM_ErrorCount,le.pid_ALLOW_ErrorCount,le.pid_LENGTH_ErrorCount,le.pid_WORDS_ErrorCount
          ,le.tmsid_LEFTTRIM_ErrorCount,le.tmsid_ALLOW_ErrorCount,le.tmsid_LENGTH_ErrorCount,le.tmsid_WORDS_ErrorCount
          ,le.vacateid_LEFTTRIM_ErrorCount,le.vacateid_ALLOW_ErrorCount,le.vacateid_LENGTH_ErrorCount,le.vacateid_WORDS_ErrorCount
          ,le.vacatedate_LEFTTRIM_ErrorCount,le.vacatedate_ALLOW_ErrorCount,le.vacatedate_LENGTH_ErrorCount,le.vacatedate_WORDS_ErrorCount
          ,le.vacateddisposition_LEFTTRIM_ErrorCount,le.vacateddisposition_ALLOW_ErrorCount,le.vacateddisposition_LENGTH_ErrorCount,le.vacateddisposition_WORDS_ErrorCount
          ,le.vacateddispositiondate_LEFTTRIM_ErrorCount,le.vacateddispositiondate_ALLOW_ErrorCount,le.vacateddispositiondate_LENGTH_ErrorCount,le.vacateddispositiondate_WORDS_ErrorCount
          ,le.withdrawnid_LEFTTRIM_ErrorCount,le.withdrawnid_ALLOW_ErrorCount,le.withdrawnid_LENGTH_ErrorCount,le.withdrawnid_WORDS_ErrorCount
          ,le.originalwithdrawndate_LEFTTRIM_ErrorCount,le.originalwithdrawndate_ALLOW_ErrorCount,le.originalwithdrawndate_LENGTH_ErrorCount,le.originalwithdrawndate_WORDS_ErrorCount
          ,le.withdrawndate_LEFTTRIM_ErrorCount,le.withdrawndate_ALLOW_ErrorCount,le.withdrawndate_LENGTH_ErrorCount,le.withdrawndate_WORDS_ErrorCount
          ,le.withdrawndisposition_LEFTTRIM_ErrorCount,le.withdrawndisposition_ALLOW_ErrorCount,le.withdrawndisposition_LENGTH_ErrorCount,le.withdrawndisposition_WORDS_ErrorCount
          ,le.withdrawndispositiondate_LEFTTRIM_ErrorCount,le.withdrawndispositiondate_ALLOW_ErrorCount,le.withdrawndispositiondate_LENGTH_ErrorCount,le.withdrawndispositiondate_WORDS_ErrorCount
          ,le.originalwithdrawndispositiondate_LEFTTRIM_ErrorCount,le.originalwithdrawndispositiondate_ALLOW_ErrorCount,le.originalwithdrawndispositiondate_LENGTH_ErrorCount,le.originalwithdrawndispositiondate_WORDS_ErrorCount
          ,le.filedinerror_LEFTTRIM_ErrorCount,le.filedinerror_ALLOW_ErrorCount,le.filedinerror_LENGTH_ErrorCount,le.filedinerror_WORDS_ErrorCount
          ,le.reopendate_LEFTTRIM_ErrorCount,le.reopendate_ALLOW_ErrorCount,le.reopendate_LENGTH_ErrorCount,le.reopendate_WORDS_ErrorCount
          ,le.lastupdateddate_LEFTTRIM_ErrorCount,le.lastupdateddate_ALLOW_ErrorCount,le.lastupdateddate_LENGTH_ErrorCount,le.lastupdateddate_WORDS_ErrorCount
          ,le.iscurrent_LEFTTRIM_ErrorCount,le.iscurrent_ALLOW_ErrorCount,le.iscurrent_LENGTH_ErrorCount,le.iscurrent_WORDS_ErrorCount
          ,le.__filename_LEFTTRIM_ErrorCount,le.__filename_ALLOW_ErrorCount,le.__filename_LENGTH_ErrorCount,le.__filename_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.logid_LEFTTRIM_ErrorCount,le.logid_ALLOW_ErrorCount,le.logid_LENGTH_ErrorCount,le.logid_WORDS_ErrorCount
          ,le.logdate_LEFTTRIM_ErrorCount,le.logdate_ALLOW_ErrorCount,le.logdate_LENGTH_ErrorCount,le.logdate_WORDS_ErrorCount
          ,le.caseid_LEFTTRIM_ErrorCount,le.caseid_ALLOW_ErrorCount,le.caseid_LENGTH_ErrorCount,le.caseid_WORDS_ErrorCount
          ,le.defendantid_LEFTTRIM_ErrorCount,le.defendantid_ALLOW_ErrorCount,le.defendantid_LENGTH_ErrorCount,le.defendantid_WORDS_ErrorCount
          ,le.currentchapter_LEFTTRIM_ErrorCount,le.currentchapter_ALLOW_ErrorCount,le.currentchapter_LENGTH_ErrorCount,le.currentchapter_WORDS_ErrorCount
          ,le.previouschapter_LEFTTRIM_ErrorCount,le.previouschapter_ALLOW_ErrorCount,le.previouschapter_LENGTH_ErrorCount,le.previouschapter_WORDS_ErrorCount
          ,le.conversionid_LEFTTRIM_ErrorCount,le.conversionid_ALLOW_ErrorCount,le.conversionid_LENGTH_ErrorCount,le.conversionid_WORDS_ErrorCount
          ,le.convertdate_LEFTTRIM_ErrorCount,le.convertdate_ALLOW_ErrorCount,le.convertdate_LENGTH_ErrorCount,le.convertdate_WORDS_ErrorCount
          ,le.currentdisposition_LEFTTRIM_ErrorCount,le.currentdisposition_ALLOW_ErrorCount,le.currentdisposition_LENGTH_ErrorCount,le.currentdisposition_WORDS_ErrorCount
          ,le.dcode_LEFTTRIM_ErrorCount,le.dcode_ALLOW_ErrorCount,le.dcode_LENGTH_ErrorCount,le.dcode_WORDS_ErrorCount
          ,le.currentdispositiondate_LEFTTRIM_ErrorCount,le.currentdispositiondate_ALLOW_ErrorCount,le.currentdispositiondate_LENGTH_ErrorCount,le.currentdispositiondate_WORDS_ErrorCount
          ,le.intseed_LEFTTRIM_ErrorCount,le.intseed_ALLOW_ErrorCount,le.intseed_LENGTH_ErrorCount,le.intseed_WORDS_ErrorCount
          ,le.pid_LEFTTRIM_ErrorCount,le.pid_ALLOW_ErrorCount,le.pid_LENGTH_ErrorCount,le.pid_WORDS_ErrorCount
          ,le.tmsid_LEFTTRIM_ErrorCount,le.tmsid_ALLOW_ErrorCount,le.tmsid_LENGTH_ErrorCount,le.tmsid_WORDS_ErrorCount
          ,le.vacateid_LEFTTRIM_ErrorCount,le.vacateid_ALLOW_ErrorCount,le.vacateid_LENGTH_ErrorCount,le.vacateid_WORDS_ErrorCount
          ,le.vacatedate_LEFTTRIM_ErrorCount,le.vacatedate_ALLOW_ErrorCount,le.vacatedate_LENGTH_ErrorCount,le.vacatedate_WORDS_ErrorCount
          ,le.vacateddisposition_LEFTTRIM_ErrorCount,le.vacateddisposition_ALLOW_ErrorCount,le.vacateddisposition_LENGTH_ErrorCount,le.vacateddisposition_WORDS_ErrorCount
          ,le.vacateddispositiondate_LEFTTRIM_ErrorCount,le.vacateddispositiondate_ALLOW_ErrorCount,le.vacateddispositiondate_LENGTH_ErrorCount,le.vacateddispositiondate_WORDS_ErrorCount
          ,le.withdrawnid_LEFTTRIM_ErrorCount,le.withdrawnid_ALLOW_ErrorCount,le.withdrawnid_LENGTH_ErrorCount,le.withdrawnid_WORDS_ErrorCount
          ,le.originalwithdrawndate_LEFTTRIM_ErrorCount,le.originalwithdrawndate_ALLOW_ErrorCount,le.originalwithdrawndate_LENGTH_ErrorCount,le.originalwithdrawndate_WORDS_ErrorCount
          ,le.withdrawndate_LEFTTRIM_ErrorCount,le.withdrawndate_ALLOW_ErrorCount,le.withdrawndate_LENGTH_ErrorCount,le.withdrawndate_WORDS_ErrorCount
          ,le.withdrawndisposition_LEFTTRIM_ErrorCount,le.withdrawndisposition_ALLOW_ErrorCount,le.withdrawndisposition_LENGTH_ErrorCount,le.withdrawndisposition_WORDS_ErrorCount
          ,le.withdrawndispositiondate_LEFTTRIM_ErrorCount,le.withdrawndispositiondate_ALLOW_ErrorCount,le.withdrawndispositiondate_LENGTH_ErrorCount,le.withdrawndispositiondate_WORDS_ErrorCount
          ,le.originalwithdrawndispositiondate_LEFTTRIM_ErrorCount,le.originalwithdrawndispositiondate_ALLOW_ErrorCount,le.originalwithdrawndispositiondate_LENGTH_ErrorCount,le.originalwithdrawndispositiondate_WORDS_ErrorCount
          ,le.filedinerror_LEFTTRIM_ErrorCount,le.filedinerror_ALLOW_ErrorCount,le.filedinerror_LENGTH_ErrorCount,le.filedinerror_WORDS_ErrorCount
          ,le.reopendate_LEFTTRIM_ErrorCount,le.reopendate_ALLOW_ErrorCount,le.reopendate_LENGTH_ErrorCount,le.reopendate_WORDS_ErrorCount
          ,le.lastupdateddate_LEFTTRIM_ErrorCount,le.lastupdateddate_ALLOW_ErrorCount,le.lastupdateddate_LENGTH_ErrorCount,le.lastupdateddate_WORDS_ErrorCount
          ,le.iscurrent_LEFTTRIM_ErrorCount,le.iscurrent_ALLOW_ErrorCount,le.iscurrent_LENGTH_ErrorCount,le.iscurrent_WORDS_ErrorCount
          ,le.__filename_LEFTTRIM_ErrorCount,le.__filename_ALLOW_ErrorCount,le.__filename_LENGTH_ErrorCount,le.__filename_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,116,Into(LEFT,COUNTER));
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
