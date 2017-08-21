IMPORT ut,SALT33;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_sexoffender_main)
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 offender_status_Invalid;
    UNSIGNED1 reg_date_1_Invalid;
    UNSIGNED1 reg_date_2_Invalid;
    UNSIGNED1 registration_address_1_Invalid;
    UNSIGNED1 registration_address_2_Invalid;
    UNSIGNED1 registration_address_3_Invalid;
    UNSIGNED1 registration_address_4_Invalid;
    UNSIGNED1 doc_number_Invalid;
    UNSIGNED1 sor_number_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 dob_aka_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 height_Invalid;
    UNSIGNED1 image_link_Invalid;
    UNSIGNED1 image_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_sexoffender_main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_sexoffender_main) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.lname_Invalid := Fields.InValid_lname((SALT33.StrType)le.lname);
    SELF.fname_Invalid := Fields.InValid_fname((SALT33.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT33.StrType)le.mname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix);
    SELF.offender_status_Invalid := Fields.InValid_offender_status((SALT33.StrType)le.offender_status);
    SELF.reg_date_1_Invalid := Fields.InValid_reg_date_1((SALT33.StrType)le.reg_date_1);
    SELF.reg_date_2_Invalid := Fields.InValid_reg_date_2((SALT33.StrType)le.reg_date_2);
    SELF.registration_address_1_Invalid := Fields.InValid_registration_address_1((SALT33.StrType)le.registration_address_1);
    SELF.registration_address_2_Invalid := Fields.InValid_registration_address_2((SALT33.StrType)le.registration_address_2);
    SELF.registration_address_3_Invalid := Fields.InValid_registration_address_3((SALT33.StrType)le.registration_address_3);
    SELF.registration_address_4_Invalid := Fields.InValid_registration_address_4((SALT33.StrType)le.registration_address_4);
    SELF.doc_number_Invalid := Fields.InValid_doc_number((SALT33.StrType)le.doc_number);
    SELF.sor_number_Invalid := Fields.InValid_sor_number((SALT33.StrType)le.sor_number);
    SELF.dob_Invalid := Fields.InValid_dob((SALT33.StrType)le.dob);
    SELF.dob_aka_Invalid := Fields.InValid_dob_aka((SALT33.StrType)le.dob_aka);
    SELF.age_Invalid := Fields.InValid_age((SALT33.StrType)le.age);
    SELF.height_Invalid := Fields.InValid_height((SALT33.StrType)le.height);
    SELF.image_link_Invalid := Fields.InValid_image_link((SALT33.StrType)le.image_link);
    SELF.image_date_Invalid := Fields.InValid_image_date((SALT33.StrType)le.image_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_sexoffender_main);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.lname_Invalid << 0 ) + ( le.fname_Invalid << 1 ) + ( le.mname_Invalid << 2 ) + ( le.name_suffix_Invalid << 3 ) + ( le.offender_status_Invalid << 4 ) + ( le.reg_date_1_Invalid << 5 ) + ( le.reg_date_2_Invalid << 6 ) + ( le.registration_address_1_Invalid << 7 ) + ( le.registration_address_2_Invalid << 8 ) + ( le.registration_address_3_Invalid << 9 ) + ( le.registration_address_4_Invalid << 10 ) + ( le.doc_number_Invalid << 11 ) + ( le.sor_number_Invalid << 12 ) + ( le.dob_Invalid << 13 ) + ( le.dob_aka_Invalid << 14 ) + ( le.age_Invalid << 15 ) + ( le.height_Invalid << 16 ) + ( le.image_link_Invalid << 17 ) + ( le.image_date_Invalid << 19 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_sexoffender_main);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.lname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.offender_status_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.reg_date_1_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.reg_date_2_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.registration_address_1_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.registration_address_2_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.registration_address_3_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.registration_address_4_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.doc_number_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sor_number_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.dob_aka_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.height_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.image_link_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.image_date_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.orig_state_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    offender_status_LENGTH_ErrorCount := COUNT(GROUP,h.offender_status_Invalid=1);
    reg_date_1_ALLOW_ErrorCount := COUNT(GROUP,h.reg_date_1_Invalid=1);
    reg_date_2_ALLOW_ErrorCount := COUNT(GROUP,h.reg_date_2_Invalid=1);
    registration_address_1_LENGTH_ErrorCount := COUNT(GROUP,h.registration_address_1_Invalid=1);
    registration_address_2_LENGTH_ErrorCount := COUNT(GROUP,h.registration_address_2_Invalid=1);
    registration_address_3_LENGTH_ErrorCount := COUNT(GROUP,h.registration_address_3_Invalid=1);
    registration_address_4_LENGTH_ErrorCount := COUNT(GROUP,h.registration_address_4_Invalid=1);
    doc_number_LENGTH_ErrorCount := COUNT(GROUP,h.doc_number_Invalid=1);
    sor_number_LENGTH_ErrorCount := COUNT(GROUP,h.sor_number_Invalid=1);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_aka_ALLOW_ErrorCount := COUNT(GROUP,h.dob_aka_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    height_LENGTH_ErrorCount := COUNT(GROUP,h.height_Invalid=1);
    image_link_ALLOW_ErrorCount := COUNT(GROUP,h.image_link_Invalid=1);
    image_link_LENGTH_ErrorCount := COUNT(GROUP,h.image_link_Invalid=2);
    image_link_Total_ErrorCount := COUNT(GROUP,h.image_link_Invalid>0);
    image_date_ALLOW_ErrorCount := COUNT(GROUP,h.image_date_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,orig_state_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.orig_state_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.lname_Invalid,le.fname_Invalid,le.mname_Invalid,le.name_suffix_Invalid,le.offender_status_Invalid,le.reg_date_1_Invalid,le.reg_date_2_Invalid,le.registration_address_1_Invalid,le.registration_address_2_Invalid,le.registration_address_3_Invalid,le.registration_address_4_Invalid,le.doc_number_Invalid,le.sor_number_Invalid,le.dob_Invalid,le.dob_aka_Invalid,le.age_Invalid,le.height_Invalid,le.image_link_Invalid,le.image_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_offender_status(le.offender_status_Invalid),Fields.InvalidMessage_reg_date_1(le.reg_date_1_Invalid),Fields.InvalidMessage_reg_date_2(le.reg_date_2_Invalid),Fields.InvalidMessage_registration_address_1(le.registration_address_1_Invalid),Fields.InvalidMessage_registration_address_2(le.registration_address_2_Invalid),Fields.InvalidMessage_registration_address_3(le.registration_address_3_Invalid),Fields.InvalidMessage_registration_address_4(le.registration_address_4_Invalid),Fields.InvalidMessage_doc_number(le.doc_number_Invalid),Fields.InvalidMessage_sor_number(le.sor_number_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_dob_aka(le.dob_aka_Invalid),Fields.InvalidMessage_age(le.age_Invalid),Fields.InvalidMessage_height(le.height_Invalid),Fields.InvalidMessage_image_link(le.image_link_Invalid),Fields.InvalidMessage_image_date(le.image_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.offender_status_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.reg_date_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reg_date_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.registration_address_1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_address_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_address_3_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.registration_address_4_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.doc_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.sor_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_aka_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.height_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.image_link_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.image_date_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'lname','fname','mname','name_suffix','offender_status','reg_date_1','reg_date_2','registration_address_1','registration_address_2','registration_address_3','registration_address_4','doc_number','sor_number','dob','dob_aka','age','height','image_link','image_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_lname','invalid_fname','invalid_mname','invalid_sname','invalid_offender_status','invalid_date','invalid_date','invalid_registration_address_1','invalid_registration_address_2','invalid_registration_address_3','invalid_registration_address_4','invalid_doc_number','invalid_sor_number','invalid_date','invalid_date','invalid_age','invalid_height','invalid_image_link','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.lname,(SALT33.StrType)le.fname,(SALT33.StrType)le.mname,(SALT33.StrType)le.name_suffix,(SALT33.StrType)le.offender_status,(SALT33.StrType)le.reg_date_1,(SALT33.StrType)le.reg_date_2,(SALT33.StrType)le.registration_address_1,(SALT33.StrType)le.registration_address_2,(SALT33.StrType)le.registration_address_3,(SALT33.StrType)le.registration_address_4,(SALT33.StrType)le.doc_number,(SALT33.StrType)le.sor_number,(SALT33.StrType)le.dob,(SALT33.StrType)le.dob_aka,(SALT33.StrType)le.age,(SALT33.StrType)le.height,(SALT33.StrType)le.image_link,(SALT33.StrType)le.image_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.orig_state_code;
      SELF.ruledesc := CHOOSE(c
          ,'lname:invalid_lname:ALLOW'
          ,'fname:invalid_fname:ALLOW'
          ,'mname:invalid_mname:ALLOW'
          ,'name_suffix:invalid_sname:ALLOW'
          ,'offender_status:invalid_offender_status:LENGTH'
          ,'reg_date_1:invalid_date:ALLOW'
          ,'reg_date_2:invalid_date:ALLOW'
          ,'registration_address_1:invalid_registration_address_1:LENGTH'
          ,'registration_address_2:invalid_registration_address_2:LENGTH'
          ,'registration_address_3:invalid_registration_address_3:LENGTH'
          ,'registration_address_4:invalid_registration_address_4:LENGTH'
          ,'doc_number:invalid_doc_number:LENGTH'
          ,'sor_number:invalid_sor_number:LENGTH'
          ,'dob:invalid_date:ALLOW'
          ,'dob_aka:invalid_date:ALLOW'
          ,'age:invalid_age:ALLOW'
          ,'height:invalid_height:LENGTH'
          ,'image_link:invalid_image_link:ALLOW','image_link:invalid_image_link:LENGTH'
          ,'image_date:invalid_date:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_offender_status(1)
          ,Fields.InvalidMessage_reg_date_1(1)
          ,Fields.InvalidMessage_reg_date_2(1)
          ,Fields.InvalidMessage_registration_address_1(1)
          ,Fields.InvalidMessage_registration_address_2(1)
          ,Fields.InvalidMessage_registration_address_3(1)
          ,Fields.InvalidMessage_registration_address_4(1)
          ,Fields.InvalidMessage_doc_number(1)
          ,Fields.InvalidMessage_sor_number(1)
          ,Fields.InvalidMessage_dob(1)
          ,Fields.InvalidMessage_dob_aka(1)
          ,Fields.InvalidMessage_age(1)
          ,Fields.InvalidMessage_height(1)
          ,Fields.InvalidMessage_image_link(1),Fields.InvalidMessage_image_link(2)
          ,Fields.InvalidMessage_image_date(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.lname_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.offender_status_LENGTH_ErrorCount
          ,le.reg_date_1_ALLOW_ErrorCount
          ,le.reg_date_2_ALLOW_ErrorCount
          ,le.registration_address_1_LENGTH_ErrorCount
          ,le.registration_address_2_LENGTH_ErrorCount
          ,le.registration_address_3_LENGTH_ErrorCount
          ,le.registration_address_4_LENGTH_ErrorCount
          ,le.doc_number_LENGTH_ErrorCount
          ,le.sor_number_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.dob_aka_ALLOW_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.height_LENGTH_ErrorCount
          ,le.image_link_ALLOW_ErrorCount,le.image_link_LENGTH_ErrorCount
          ,le.image_date_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.lname_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.offender_status_LENGTH_ErrorCount
          ,le.reg_date_1_ALLOW_ErrorCount
          ,le.reg_date_2_ALLOW_ErrorCount
          ,le.registration_address_1_LENGTH_ErrorCount
          ,le.registration_address_2_LENGTH_ErrorCount
          ,le.registration_address_3_LENGTH_ErrorCount
          ,le.registration_address_4_LENGTH_ErrorCount
          ,le.doc_number_LENGTH_ErrorCount
          ,le.sor_number_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.dob_aka_ALLOW_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.height_LENGTH_ErrorCount
          ,le.image_link_ALLOW_ErrorCount,le.image_link_LENGTH_ErrorCount
          ,le.image_date_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,20,Into(LEFT,COUNTER));
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
