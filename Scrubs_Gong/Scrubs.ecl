IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File_Neustar)
    UNSIGNED1 ACTION_CODE_Invalid;
    UNSIGNED1 RECORD_TYPE_Invalid;
    UNSIGNED1 TELEPHONE_Invalid;
    UNSIGNED1 LISTING_TYPE_Invalid;
    UNSIGNED1 BUSINESS_NAME_Invalid;
    UNSIGNED1 INDENT_Invalid;
    UNSIGNED1 LAST_NAME_Invalid;
    UNSIGNED1 SUFFIX_NAME_Invalid;
    UNSIGNED1 FIRST_NAME_Invalid;
    UNSIGNED1 MIDDLE_NAME_Invalid;
    UNSIGNED1 PRE_DIR_Invalid;
    UNSIGNED1 PRIMARY_STREET_NAME_Invalid;
    UNSIGNED1 POST_DIR_Invalid;
    UNSIGNED1 CITY_Invalid;
    UNSIGNED1 STATE_Invalid;
    UNSIGNED1 ZIP_CODE_Invalid;
    UNSIGNED1 ZIP_PLUS4_Invalid;
    UNSIGNED1 ADD_DATE_Invalid;
    UNSIGNED1 OMIT_ADDRESS_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File_Neustar)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_File_Neustar) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ACTION_CODE_Invalid := Fields.InValid_ACTION_CODE((SALT33.StrType)le.ACTION_CODE);
    SELF.RECORD_TYPE_Invalid := Fields.InValid_RECORD_TYPE((SALT33.StrType)le.RECORD_TYPE);
    SELF.TELEPHONE_Invalid := Fields.InValid_TELEPHONE((SALT33.StrType)le.TELEPHONE);
    SELF.LISTING_TYPE_Invalid := Fields.InValid_LISTING_TYPE((SALT33.StrType)le.LISTING_TYPE);
    SELF.BUSINESS_NAME_Invalid := Fields.InValid_BUSINESS_NAME((SALT33.StrType)le.BUSINESS_NAME);
    SELF.INDENT_Invalid := Fields.InValid_INDENT((SALT33.StrType)le.INDENT);
    SELF.LAST_NAME_Invalid := Fields.InValid_LAST_NAME((SALT33.StrType)le.LAST_NAME);
    SELF.SUFFIX_NAME_Invalid := Fields.InValid_SUFFIX_NAME((SALT33.StrType)le.SUFFIX_NAME);
    SELF.FIRST_NAME_Invalid := Fields.InValid_FIRST_NAME((SALT33.StrType)le.FIRST_NAME);
    SELF.MIDDLE_NAME_Invalid := Fields.InValid_MIDDLE_NAME((SALT33.StrType)le.MIDDLE_NAME);
    SELF.PRE_DIR_Invalid := Fields.InValid_PRE_DIR((SALT33.StrType)le.PRE_DIR);
    SELF.PRIMARY_STREET_NAME_Invalid := Fields.InValid_PRIMARY_STREET_NAME((SALT33.StrType)le.PRIMARY_STREET_NAME);
    SELF.POST_DIR_Invalid := Fields.InValid_POST_DIR((SALT33.StrType)le.POST_DIR);
    SELF.CITY_Invalid := Fields.InValid_CITY((SALT33.StrType)le.CITY);
    SELF.STATE_Invalid := Fields.InValid_STATE((SALT33.StrType)le.STATE);
    SELF.ZIP_CODE_Invalid := Fields.InValid_ZIP_CODE((SALT33.StrType)le.ZIP_CODE);
    SELF.ZIP_PLUS4_Invalid := Fields.InValid_ZIP_PLUS4((SALT33.StrType)le.ZIP_PLUS4);
    SELF.ADD_DATE_Invalid := Fields.InValid_ADD_DATE((SALT33.StrType)le.ADD_DATE);
    SELF.OMIT_ADDRESS_Invalid := Fields.InValid_OMIT_ADDRESS((SALT33.StrType)le.OMIT_ADDRESS);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File_Neustar);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ACTION_CODE_Invalid << 0 ) + ( le.RECORD_TYPE_Invalid << 1 ) + ( le.TELEPHONE_Invalid << 2 ) + ( le.LISTING_TYPE_Invalid << 4 ) + ( le.BUSINESS_NAME_Invalid << 5 ) + ( le.INDENT_Invalid << 7 ) + ( le.LAST_NAME_Invalid << 8 ) + ( le.SUFFIX_NAME_Invalid << 10 ) + ( le.FIRST_NAME_Invalid << 12 ) + ( le.MIDDLE_NAME_Invalid << 14 ) + ( le.PRE_DIR_Invalid << 16 ) + ( le.PRIMARY_STREET_NAME_Invalid << 17 ) + ( le.POST_DIR_Invalid << 19 ) + ( le.CITY_Invalid << 20 ) + ( le.STATE_Invalid << 22 ) + ( le.ZIP_CODE_Invalid << 24 ) + ( le.ZIP_PLUS4_Invalid << 26 ) + ( le.ADD_DATE_Invalid << 28 ) + ( le.OMIT_ADDRESS_Invalid << 29 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File_Neustar);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ACTION_CODE_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.RECORD_TYPE_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.TELEPHONE_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.LISTING_TYPE_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.BUSINESS_NAME_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.INDENT_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.LAST_NAME_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.SUFFIX_NAME_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.FIRST_NAME_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.MIDDLE_NAME_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.PRE_DIR_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.PRIMARY_STREET_NAME_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.POST_DIR_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.CITY_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.STATE_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.ZIP_CODE_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.ZIP_PLUS4_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.ADD_DATE_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.OMIT_ADDRESS_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ACTION_CODE_ALLOW_ErrorCount := COUNT(GROUP,h.ACTION_CODE_Invalid=1);
    RECORD_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.RECORD_TYPE_Invalid=1);
    TELEPHONE_ALLOW_ErrorCount := COUNT(GROUP,h.TELEPHONE_Invalid=1);
    TELEPHONE_LENGTH_ErrorCount := COUNT(GROUP,h.TELEPHONE_Invalid=2);
    TELEPHONE_Total_ErrorCount := COUNT(GROUP,h.TELEPHONE_Invalid>0);
    LISTING_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.LISTING_TYPE_Invalid=1);
    BUSINESS_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.BUSINESS_NAME_Invalid=1);
    BUSINESS_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.BUSINESS_NAME_Invalid=2);
    BUSINESS_NAME_Total_ErrorCount := COUNT(GROUP,h.BUSINESS_NAME_Invalid>0);
    INDENT_ALLOW_ErrorCount := COUNT(GROUP,h.INDENT_Invalid=1);
    LAST_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.LAST_NAME_Invalid=1);
    LAST_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.LAST_NAME_Invalid=2);
    LAST_NAME_Total_ErrorCount := COUNT(GROUP,h.LAST_NAME_Invalid>0);
    SUFFIX_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.SUFFIX_NAME_Invalid=1);
    SUFFIX_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.SUFFIX_NAME_Invalid=2);
    SUFFIX_NAME_Total_ErrorCount := COUNT(GROUP,h.SUFFIX_NAME_Invalid>0);
    FIRST_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.FIRST_NAME_Invalid=1);
    FIRST_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.FIRST_NAME_Invalid=2);
    FIRST_NAME_Total_ErrorCount := COUNT(GROUP,h.FIRST_NAME_Invalid>0);
    MIDDLE_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.MIDDLE_NAME_Invalid=1);
    MIDDLE_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.MIDDLE_NAME_Invalid=2);
    MIDDLE_NAME_Total_ErrorCount := COUNT(GROUP,h.MIDDLE_NAME_Invalid>0);
    PRE_DIR_ENUM_ErrorCount := COUNT(GROUP,h.PRE_DIR_Invalid=1);
    PRIMARY_STREET_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.PRIMARY_STREET_NAME_Invalid=1);
    PRIMARY_STREET_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.PRIMARY_STREET_NAME_Invalid=2);
    PRIMARY_STREET_NAME_Total_ErrorCount := COUNT(GROUP,h.PRIMARY_STREET_NAME_Invalid>0);
    POST_DIR_ENUM_ErrorCount := COUNT(GROUP,h.POST_DIR_Invalid=1);
    CITY_ALLOW_ErrorCount := COUNT(GROUP,h.CITY_Invalid=1);
    CITY_LENGTH_ErrorCount := COUNT(GROUP,h.CITY_Invalid=2);
    CITY_Total_ErrorCount := COUNT(GROUP,h.CITY_Invalid>0);
    STATE_ALLOW_ErrorCount := COUNT(GROUP,h.STATE_Invalid=1);
    STATE_LENGTH_ErrorCount := COUNT(GROUP,h.STATE_Invalid=2);
    STATE_Total_ErrorCount := COUNT(GROUP,h.STATE_Invalid>0);
    ZIP_CODE_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_CODE_Invalid=1);
    ZIP_CODE_LENGTH_ErrorCount := COUNT(GROUP,h.ZIP_CODE_Invalid=2);
    ZIP_CODE_Total_ErrorCount := COUNT(GROUP,h.ZIP_CODE_Invalid>0);
    ZIP_PLUS4_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_PLUS4_Invalid=1);
    ZIP_PLUS4_LENGTH_ErrorCount := COUNT(GROUP,h.ZIP_PLUS4_Invalid=2);
    ZIP_PLUS4_Total_ErrorCount := COUNT(GROUP,h.ZIP_PLUS4_Invalid>0);
    ADD_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.ADD_DATE_Invalid=1);
    OMIT_ADDRESS_ALLOW_ErrorCount := COUNT(GROUP,h.OMIT_ADDRESS_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ACTION_CODE_Invalid,le.RECORD_TYPE_Invalid,le.TELEPHONE_Invalid,le.LISTING_TYPE_Invalid,le.BUSINESS_NAME_Invalid,le.INDENT_Invalid,le.LAST_NAME_Invalid,le.SUFFIX_NAME_Invalid,le.FIRST_NAME_Invalid,le.MIDDLE_NAME_Invalid,le.PRE_DIR_Invalid,le.PRIMARY_STREET_NAME_Invalid,le.POST_DIR_Invalid,le.CITY_Invalid,le.STATE_Invalid,le.ZIP_CODE_Invalid,le.ZIP_PLUS4_Invalid,le.ADD_DATE_Invalid,le.OMIT_ADDRESS_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ACTION_CODE(le.ACTION_CODE_Invalid),Fields.InvalidMessage_RECORD_TYPE(le.RECORD_TYPE_Invalid),Fields.InvalidMessage_TELEPHONE(le.TELEPHONE_Invalid),Fields.InvalidMessage_LISTING_TYPE(le.LISTING_TYPE_Invalid),Fields.InvalidMessage_BUSINESS_NAME(le.BUSINESS_NAME_Invalid),Fields.InvalidMessage_INDENT(le.INDENT_Invalid),Fields.InvalidMessage_LAST_NAME(le.LAST_NAME_Invalid),Fields.InvalidMessage_SUFFIX_NAME(le.SUFFIX_NAME_Invalid),Fields.InvalidMessage_FIRST_NAME(le.FIRST_NAME_Invalid),Fields.InvalidMessage_MIDDLE_NAME(le.MIDDLE_NAME_Invalid),Fields.InvalidMessage_PRE_DIR(le.PRE_DIR_Invalid),Fields.InvalidMessage_PRIMARY_STREET_NAME(le.PRIMARY_STREET_NAME_Invalid),Fields.InvalidMessage_POST_DIR(le.POST_DIR_Invalid),Fields.InvalidMessage_CITY(le.CITY_Invalid),Fields.InvalidMessage_STATE(le.STATE_Invalid),Fields.InvalidMessage_ZIP_CODE(le.ZIP_CODE_Invalid),Fields.InvalidMessage_ZIP_PLUS4(le.ZIP_PLUS4_Invalid),Fields.InvalidMessage_ADD_DATE(le.ADD_DATE_Invalid),Fields.InvalidMessage_OMIT_ADDRESS(le.OMIT_ADDRESS_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ACTION_CODE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.RECORD_TYPE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.TELEPHONE_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.LISTING_TYPE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.BUSINESS_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.INDENT_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.LAST_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.SUFFIX_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.FIRST_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.MIDDLE_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.PRE_DIR_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.PRIMARY_STREET_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.POST_DIR_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.CITY_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.STATE_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ZIP_CODE_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ZIP_PLUS4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ADD_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.OMIT_ADDRESS_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ACTION_CODE','RECORD_TYPE','TELEPHONE','LISTING_TYPE','BUSINESS_NAME','INDENT','LAST_NAME','SUFFIX_NAME','FIRST_NAME','MIDDLE_NAME','PRE_DIR','PRIMARY_STREET_NAME','POST_DIR','CITY','STATE','ZIP_CODE','ZIP_PLUS4','ADD_DATE','OMIT_ADDRESS','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'ActionCodes','RecordTypes','phone','PublishCodes','bizname','Numeric','name','name','fname','name','Directional','primname','Directional','cityname','StateAbrv','zip','zip4','Invalid_Date','YesNo','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.ACTION_CODE,(SALT33.StrType)le.RECORD_TYPE,(SALT33.StrType)le.TELEPHONE,(SALT33.StrType)le.LISTING_TYPE,(SALT33.StrType)le.BUSINESS_NAME,(SALT33.StrType)le.INDENT,(SALT33.StrType)le.LAST_NAME,(SALT33.StrType)le.SUFFIX_NAME,(SALT33.StrType)le.FIRST_NAME,(SALT33.StrType)le.MIDDLE_NAME,(SALT33.StrType)le.PRE_DIR,(SALT33.StrType)le.PRIMARY_STREET_NAME,(SALT33.StrType)le.POST_DIR,(SALT33.StrType)le.CITY,(SALT33.StrType)le.STATE,(SALT33.StrType)le.ZIP_CODE,(SALT33.StrType)le.ZIP_PLUS4,(SALT33.StrType)le.ADD_DATE,(SALT33.StrType)le.OMIT_ADDRESS,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ACTION_CODE:ActionCodes:ALLOW'
          ,'RECORD_TYPE:RecordTypes:ALLOW'
          ,'TELEPHONE:phone:ALLOW','TELEPHONE:phone:LENGTH'
          ,'LISTING_TYPE:PublishCodes:ALLOW'
          ,'BUSINESS_NAME:bizname:ALLOW','BUSINESS_NAME:bizname:LENGTH'
          ,'INDENT:Numeric:ALLOW'
          ,'LAST_NAME:name:ALLOW','LAST_NAME:name:LENGTH'
          ,'SUFFIX_NAME:name:ALLOW','SUFFIX_NAME:name:LENGTH'
          ,'FIRST_NAME:fname:ALLOW','FIRST_NAME:fname:LENGTH'
          ,'MIDDLE_NAME:name:ALLOW','MIDDLE_NAME:name:LENGTH'
          ,'PRE_DIR:Directional:ENUM'
          ,'PRIMARY_STREET_NAME:primname:ALLOW','PRIMARY_STREET_NAME:primname:LENGTH'
          ,'POST_DIR:Directional:ENUM'
          ,'CITY:cityname:ALLOW','CITY:cityname:LENGTH'
          ,'STATE:StateAbrv:ALLOW','STATE:StateAbrv:LENGTH'
          ,'ZIP_CODE:zip:ALLOW','ZIP_CODE:zip:LENGTH'
          ,'ZIP_PLUS4:zip4:ALLOW','ZIP_PLUS4:zip4:LENGTH'
          ,'ADD_DATE:Invalid_Date:CUSTOM'
          ,'OMIT_ADDRESS:YesNo:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ACTION_CODE(1)
          ,Fields.InvalidMessage_RECORD_TYPE(1)
          ,Fields.InvalidMessage_TELEPHONE(1),Fields.InvalidMessage_TELEPHONE(2)
          ,Fields.InvalidMessage_LISTING_TYPE(1)
          ,Fields.InvalidMessage_BUSINESS_NAME(1),Fields.InvalidMessage_BUSINESS_NAME(2)
          ,Fields.InvalidMessage_INDENT(1)
          ,Fields.InvalidMessage_LAST_NAME(1),Fields.InvalidMessage_LAST_NAME(2)
          ,Fields.InvalidMessage_SUFFIX_NAME(1),Fields.InvalidMessage_SUFFIX_NAME(2)
          ,Fields.InvalidMessage_FIRST_NAME(1),Fields.InvalidMessage_FIRST_NAME(2)
          ,Fields.InvalidMessage_MIDDLE_NAME(1),Fields.InvalidMessage_MIDDLE_NAME(2)
          ,Fields.InvalidMessage_PRE_DIR(1)
          ,Fields.InvalidMessage_PRIMARY_STREET_NAME(1),Fields.InvalidMessage_PRIMARY_STREET_NAME(2)
          ,Fields.InvalidMessage_POST_DIR(1)
          ,Fields.InvalidMessage_CITY(1),Fields.InvalidMessage_CITY(2)
          ,Fields.InvalidMessage_STATE(1),Fields.InvalidMessage_STATE(2)
          ,Fields.InvalidMessage_ZIP_CODE(1),Fields.InvalidMessage_ZIP_CODE(2)
          ,Fields.InvalidMessage_ZIP_PLUS4(1),Fields.InvalidMessage_ZIP_PLUS4(2)
          ,Fields.InvalidMessage_ADD_DATE(1)
          ,Fields.InvalidMessage_OMIT_ADDRESS(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ACTION_CODE_ALLOW_ErrorCount
          ,le.RECORD_TYPE_ALLOW_ErrorCount
          ,le.TELEPHONE_ALLOW_ErrorCount,le.TELEPHONE_LENGTH_ErrorCount
          ,le.LISTING_TYPE_ALLOW_ErrorCount
          ,le.BUSINESS_NAME_ALLOW_ErrorCount,le.BUSINESS_NAME_LENGTH_ErrorCount
          ,le.INDENT_ALLOW_ErrorCount
          ,le.LAST_NAME_ALLOW_ErrorCount,le.LAST_NAME_LENGTH_ErrorCount
          ,le.SUFFIX_NAME_ALLOW_ErrorCount,le.SUFFIX_NAME_LENGTH_ErrorCount
          ,le.FIRST_NAME_ALLOW_ErrorCount,le.FIRST_NAME_LENGTH_ErrorCount
          ,le.MIDDLE_NAME_ALLOW_ErrorCount,le.MIDDLE_NAME_LENGTH_ErrorCount
          ,le.PRE_DIR_ENUM_ErrorCount
          ,le.PRIMARY_STREET_NAME_ALLOW_ErrorCount,le.PRIMARY_STREET_NAME_LENGTH_ErrorCount
          ,le.POST_DIR_ENUM_ErrorCount
          ,le.CITY_ALLOW_ErrorCount,le.CITY_LENGTH_ErrorCount
          ,le.STATE_ALLOW_ErrorCount,le.STATE_LENGTH_ErrorCount
          ,le.ZIP_CODE_ALLOW_ErrorCount,le.ZIP_CODE_LENGTH_ErrorCount
          ,le.ZIP_PLUS4_ALLOW_ErrorCount,le.ZIP_PLUS4_LENGTH_ErrorCount
          ,le.ADD_DATE_CUSTOM_ErrorCount
          ,le.OMIT_ADDRESS_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ACTION_CODE_ALLOW_ErrorCount
          ,le.RECORD_TYPE_ALLOW_ErrorCount
          ,le.TELEPHONE_ALLOW_ErrorCount,le.TELEPHONE_LENGTH_ErrorCount
          ,le.LISTING_TYPE_ALLOW_ErrorCount
          ,le.BUSINESS_NAME_ALLOW_ErrorCount,le.BUSINESS_NAME_LENGTH_ErrorCount
          ,le.INDENT_ALLOW_ErrorCount
          ,le.LAST_NAME_ALLOW_ErrorCount,le.LAST_NAME_LENGTH_ErrorCount
          ,le.SUFFIX_NAME_ALLOW_ErrorCount,le.SUFFIX_NAME_LENGTH_ErrorCount
          ,le.FIRST_NAME_ALLOW_ErrorCount,le.FIRST_NAME_LENGTH_ErrorCount
          ,le.MIDDLE_NAME_ALLOW_ErrorCount,le.MIDDLE_NAME_LENGTH_ErrorCount
          ,le.PRE_DIR_ENUM_ErrorCount
          ,le.PRIMARY_STREET_NAME_ALLOW_ErrorCount,le.PRIMARY_STREET_NAME_LENGTH_ErrorCount
          ,le.POST_DIR_ENUM_ErrorCount
          ,le.CITY_ALLOW_ErrorCount,le.CITY_LENGTH_ErrorCount
          ,le.STATE_ALLOW_ErrorCount,le.STATE_LENGTH_ErrorCount
          ,le.ZIP_CODE_ALLOW_ErrorCount,le.ZIP_CODE_LENGTH_ErrorCount
          ,le.ZIP_PLUS4_ALLOW_ErrorCount,le.ZIP_PLUS4_LENGTH_ErrorCount
          ,le.ADD_DATE_CUSTOM_ErrorCount
          ,le.OMIT_ADDRESS_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,30,Into(LEFT,COUNTER));
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
