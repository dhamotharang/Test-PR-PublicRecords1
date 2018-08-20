IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Orange_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Input_CA_Orange_Layout_FBNV2)
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 file_date_Invalid;
    UNSIGNED1 regis_nbr_Invalid;
    UNSIGNED1 prep_bus_addr_line1_Invalid;
    UNSIGNED1 prep_bus_addr_line_last_Invalid;
    UNSIGNED1 prep_owner_addr_line1_Invalid;
    UNSIGNED1 prep_owner_addr_line_last_Invalid;
    UNSIGNED1 cname_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 last_name_company_Invalid;
    UNSIGNED1 owner_address_Invalid;
    UNSIGNED1 owner_city_Invalid;
    UNSIGNED1 owner_state_Invalid;
    UNSIGNED1 phone_nbr_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_CA_Orange_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_CA_Orange_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.business_name_Invalid := Input_CA_Orange_Fields.InValid_business_name((SALT37.StrType)le.business_name);
    SELF.file_date_Invalid := Input_CA_Orange_Fields.InValid_file_date((SALT37.StrType)le.file_date);
    SELF.regis_nbr_Invalid := Input_CA_Orange_Fields.InValid_regis_nbr((SALT37.StrType)le.regis_nbr);
    SELF.prep_bus_addr_line1_Invalid := Input_CA_Orange_Fields.InValid_prep_bus_addr_line1((SALT37.StrType)le.prep_bus_addr_line1);
    SELF.prep_bus_addr_line_last_Invalid := Input_CA_Orange_Fields.InValid_prep_bus_addr_line_last((SALT37.StrType)le.prep_bus_addr_line_last);
    SELF.prep_owner_addr_line1_Invalid := Input_CA_Orange_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1);
    SELF.prep_owner_addr_line_last_Invalid := Input_CA_Orange_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last);
    SELF.cname_Invalid := Input_CA_Orange_Fields.InValid_cname((SALT37.StrType)le.cname);
    SELF.first_name_Invalid := Input_CA_Orange_Fields.InValid_first_name((SALT37.StrType)le.first_name);
    SELF.middle_name_Invalid := Input_CA_Orange_Fields.InValid_middle_name((SALT37.StrType)le.middle_name);
    SELF.last_name_company_Invalid := Input_CA_Orange_Fields.InValid_last_name_company((SALT37.StrType)le.last_name_company);
    SELF.owner_address_Invalid := Input_CA_Orange_Fields.InValid_owner_address((SALT37.StrType)le.owner_address);
    SELF.owner_city_Invalid := Input_CA_Orange_Fields.InValid_owner_city((SALT37.StrType)le.owner_city);
    SELF.owner_state_Invalid := Input_CA_Orange_Fields.InValid_owner_state((SALT37.StrType)le.owner_state);
    SELF.phone_nbr_Invalid := Input_CA_Orange_Fields.InValid_phone_nbr((SALT37.StrType)le.phone_nbr);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_CA_Orange_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.business_name_Invalid << 0 ) + ( le.file_date_Invalid << 1 ) + ( le.regis_nbr_Invalid << 2 ) + ( le.prep_bus_addr_line1_Invalid << 3 ) + ( le.prep_bus_addr_line_last_Invalid << 4 ) + ( le.prep_owner_addr_line1_Invalid << 5 ) + ( le.prep_owner_addr_line_last_Invalid << 6 ) + ( le.cname_Invalid << 7 ) + ( le.first_name_Invalid << 8 ) + ( le.middle_name_Invalid << 9 ) + ( le.last_name_company_Invalid << 10 ) + ( le.owner_address_Invalid << 11 ) + ( le.owner_city_Invalid << 12 ) + ( le.owner_state_Invalid << 13 ) + ( le.phone_nbr_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_CA_Orange_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.regis_nbr_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.prep_bus_addr_line1_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.prep_bus_addr_line_last_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.prep_owner_addr_line1_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prep_owner_addr_line_last_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.cname_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.last_name_company_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.owner_address_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.owner_city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.owner_state_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.phone_nbr_Invalid := (le.ScrubsBits1 >> 14) & 1;
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
    regis_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.regis_nbr_Invalid=1);
    prep_bus_addr_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_bus_addr_line1_Invalid=1);
    prep_bus_addr_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_bus_addr_line_last_Invalid=1);
    prep_owner_addr_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line1_Invalid=1);
    prep_owner_addr_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line_last_Invalid=1);
    cname_LENGTH_ErrorCount := COUNT(GROUP,h.cname_Invalid=1);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    middle_name_LENGTH_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    last_name_company_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_company_Invalid=1);
    owner_address_LENGTH_ErrorCount := COUNT(GROUP,h.owner_address_Invalid=1);
    owner_city_LENGTH_ErrorCount := COUNT(GROUP,h.owner_city_Invalid=1);
    owner_state_LENGTH_ErrorCount := COUNT(GROUP,h.owner_state_Invalid=1);
    phone_nbr_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_nbr_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.business_name_Invalid,le.file_date_Invalid,le.regis_nbr_Invalid,le.prep_bus_addr_line1_Invalid,le.prep_bus_addr_line_last_Invalid,le.prep_owner_addr_line1_Invalid,le.prep_owner_addr_line_last_Invalid,le.cname_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.last_name_company_Invalid,le.owner_address_Invalid,le.owner_city_Invalid,le.owner_state_Invalid,le.phone_nbr_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_CA_Orange_Fields.InvalidMessage_business_name(le.business_name_Invalid),Input_CA_Orange_Fields.InvalidMessage_file_date(le.file_date_Invalid),Input_CA_Orange_Fields.InvalidMessage_regis_nbr(le.regis_nbr_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line1(le.prep_bus_addr_line1_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line_last(le.prep_bus_addr_line_last_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line1(le.prep_owner_addr_line1_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line_last(le.prep_owner_addr_line_last_Invalid),Input_CA_Orange_Fields.InvalidMessage_cname(le.cname_Invalid),Input_CA_Orange_Fields.InvalidMessage_first_name(le.first_name_Invalid),Input_CA_Orange_Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Input_CA_Orange_Fields.InvalidMessage_last_name_company(le.last_name_company_Invalid),Input_CA_Orange_Fields.InvalidMessage_owner_address(le.owner_address_Invalid),Input_CA_Orange_Fields.InvalidMessage_owner_city(le.owner_city_Invalid),Input_CA_Orange_Fields.InvalidMessage_owner_state(le.owner_state_Invalid),Input_CA_Orange_Fields.InvalidMessage_phone_nbr(le.phone_nbr_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.business_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.file_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.regis_nbr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_bus_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_bus_addr_line_last_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line_last_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.cname_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.last_name_company_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.owner_address_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.owner_city_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.owner_state_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_nbr_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'business_name','file_date','regis_nbr','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname','first_name','middle_name','last_name_company','owner_address','owner_city','owner_state','phone_nbr','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.business_name,(SALT37.StrType)le.file_date,(SALT37.StrType)le.regis_nbr,(SALT37.StrType)le.prep_bus_addr_line1,(SALT37.StrType)le.prep_bus_addr_line_last,(SALT37.StrType)le.prep_owner_addr_line1,(SALT37.StrType)le.prep_owner_addr_line_last,(SALT37.StrType)le.cname,(SALT37.StrType)le.first_name,(SALT37.StrType)le.middle_name,(SALT37.StrType)le.last_name_company,(SALT37.StrType)le.owner_address,(SALT37.StrType)le.owner_city,(SALT37.StrType)le.owner_state,(SALT37.StrType)le.phone_nbr,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,15,Into(LEFT,COUNTER));
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
          ,'regis_nbr:invalid_mandatory:LENGTH'
          ,'prep_bus_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_bus_addr_line_last:invalid_mandatory:LENGTH'
          ,'prep_owner_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_owner_addr_line_last:invalid_mandatory:LENGTH'
          ,'cname:invalid_mandatory:LENGTH'
          ,'first_name:invalid_mandatory:LENGTH'
          ,'middle_name:invalid_mandatory:LENGTH'
          ,'last_name_company:invalid_mandatory:LENGTH'
          ,'owner_address:invalid_mandatory:LENGTH'
          ,'owner_city:invalid_mandatory:LENGTH'
          ,'owner_state:invalid_mandatory:LENGTH'
          ,'phone_nbr:invalid_phone:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_CA_Orange_Fields.InvalidMessage_business_name(1)
          ,Input_CA_Orange_Fields.InvalidMessage_file_date(1)
          ,Input_CA_Orange_Fields.InvalidMessage_regis_nbr(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line1(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line_last(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line1(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line_last(1)
          ,Input_CA_Orange_Fields.InvalidMessage_cname(1)
          ,Input_CA_Orange_Fields.InvalidMessage_first_name(1)
          ,Input_CA_Orange_Fields.InvalidMessage_middle_name(1)
          ,Input_CA_Orange_Fields.InvalidMessage_last_name_company(1)
          ,Input_CA_Orange_Fields.InvalidMessage_owner_address(1)
          ,Input_CA_Orange_Fields.InvalidMessage_owner_city(1)
          ,Input_CA_Orange_Fields.InvalidMessage_owner_state(1)
          ,Input_CA_Orange_Fields.InvalidMessage_phone_nbr(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.business_name_LENGTH_ErrorCount
          ,le.file_date_CUSTOM_ErrorCount
          ,le.regis_nbr_LENGTH_ErrorCount
          ,le.prep_bus_addr_line1_LENGTH_ErrorCount
          ,le.prep_bus_addr_line_last_LENGTH_ErrorCount
          ,le.prep_owner_addr_line1_LENGTH_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTH_ErrorCount
          ,le.cname_LENGTH_ErrorCount
          ,le.first_name_LENGTH_ErrorCount
          ,le.middle_name_LENGTH_ErrorCount
          ,le.last_name_company_LENGTH_ErrorCount
          ,le.owner_address_LENGTH_ErrorCount
          ,le.owner_city_LENGTH_ErrorCount
          ,le.owner_state_LENGTH_ErrorCount
          ,le.phone_nbr_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.business_name_LENGTH_ErrorCount
          ,le.file_date_CUSTOM_ErrorCount
          ,le.regis_nbr_LENGTH_ErrorCount
          ,le.prep_bus_addr_line1_LENGTH_ErrorCount
          ,le.prep_bus_addr_line_last_LENGTH_ErrorCount
          ,le.prep_owner_addr_line1_LENGTH_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTH_ErrorCount
          ,le.cname_LENGTH_ErrorCount
          ,le.first_name_LENGTH_ErrorCount
          ,le.middle_name_LENGTH_ErrorCount
          ,le.last_name_company_LENGTH_ErrorCount
          ,le.owner_address_LENGTH_ErrorCount
          ,le.owner_city_LENGTH_ErrorCount
          ,le.owner_state_LENGTH_ErrorCount
          ,le.phone_nbr_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,15,Into(LEFT,COUNTER));
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
