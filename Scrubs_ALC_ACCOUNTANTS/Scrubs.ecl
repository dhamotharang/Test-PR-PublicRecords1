IMPORT ut,SALT32;
IMPORT Scrubs,ALC; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_ALC_ACCOUNTANTS)
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 bar_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 dpv_Invalid;
    UNSIGNED1 addr_type_Invalid;
    UNSIGNED1 county_cd_Invalid;
    UNSIGNED1 job_code_Invalid;
    UNSIGNED1 nielsen_county_cd_Invalid;
    UNSIGNED1 number_of_employees_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 company_type_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 list_id_Invalid;
    UNSIGNED1 scno_Invalid;
    UNSIGNED1 custno_Invalid;
    UNSIGNED1 license_no_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 orig_date_Invalid;
    UNSIGNED1 exp_date_Invalid;
    UNSIGNED1 degree_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_ALC_ACCOUNTANTS)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_ALC_ACCOUNTANTS) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fname_Invalid := Fields.InValid_fname((SALT32.StrType)le.fname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT32.StrType)le.lname);
    SELF.title_Invalid := Fields.InValid_title((SALT32.StrType)le.title);
    SELF.state_Invalid := Fields.InValid_state((SALT32.StrType)le.state);
    SELF.zip_Invalid := Fields.InValid_zip((SALT32.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT32.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT32.StrType)le.cart);
    SELF.bar_Invalid := Fields.InValid_bar((SALT32.StrType)le.bar);
    SELF.gender_Invalid := Fields.InValid_gender((SALT32.StrType)le.gender);
    SELF.dpv_Invalid := Fields.InValid_dpv((SALT32.StrType)le.dpv);
    SELF.addr_type_Invalid := Fields.InValid_addr_type((SALT32.StrType)le.addr_type);
    SELF.county_cd_Invalid := Fields.InValid_county_cd((SALT32.StrType)le.county_cd);
    SELF.job_code_Invalid := Fields.InValid_job_code((SALT32.StrType)le.job_code);
    SELF.nielsen_county_cd_Invalid := Fields.InValid_nielsen_county_cd((SALT32.StrType)le.nielsen_county_cd);
    SELF.number_of_employees_Invalid := Fields.InValid_number_of_employees((SALT32.StrType)le.number_of_employees);
    SELF.msa_Invalid := Fields.InValid_msa((SALT32.StrType)le.msa);
    SELF.company_type_Invalid := Fields.InValid_company_type((SALT32.StrType)le.company_type);
    SELF.phone_Invalid := Fields.InValid_phone((SALT32.StrType)le.phone);
    SELF.list_id_Invalid := Fields.InValid_list_id((SALT32.StrType)le.list_id);
    SELF.scno_Invalid := Fields.InValid_scno((SALT32.StrType)le.scno);
    SELF.custno_Invalid := Fields.InValid_custno((SALT32.StrType)le.custno);
    SELF.license_no_Invalid := Fields.InValid_license_no((SALT32.StrType)le.license_no,(SALT32.StrType)le.state);
    SELF.dob_Invalid := Fields.InValid_dob((SALT32.StrType)le.dob);
    SELF.orig_date_Invalid := Fields.InValid_orig_date((SALT32.StrType)le.orig_date);
    SELF.exp_date_Invalid := Fields.InValid_exp_date((SALT32.StrType)le.exp_date);
    SELF.degree_Invalid := Fields.InValid_degree((SALT32.StrType)le.degree);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_ALC_ACCOUNTANTS);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fname_Invalid << 0 ) + ( le.lname_Invalid << 1 ) + ( le.title_Invalid << 2 ) + ( le.state_Invalid << 3 ) + ( le.zip_Invalid << 4 ) + ( le.zip4_Invalid << 5 ) + ( le.cart_Invalid << 6 ) + ( le.bar_Invalid << 7 ) + ( le.gender_Invalid << 8 ) + ( le.dpv_Invalid << 9 ) + ( le.addr_type_Invalid << 10 ) + ( le.county_cd_Invalid << 11 ) + ( le.job_code_Invalid << 12 ) + ( le.nielsen_county_cd_Invalid << 13 ) + ( le.number_of_employees_Invalid << 14 ) + ( le.msa_Invalid << 15 ) + ( le.company_type_Invalid << 16 ) + ( le.phone_Invalid << 17 ) + ( le.list_id_Invalid << 18 ) + ( le.scno_Invalid << 19 ) + ( le.custno_Invalid << 20 ) + ( le.license_no_Invalid << 21 ) + ( le.dob_Invalid << 23 ) + ( le.orig_date_Invalid << 25 ) + ( le.exp_date_Invalid << 26 ) + ( le.degree_Invalid << 27 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_ALC_ACCOUNTANTS);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.bar_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.dpv_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.addr_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.county_cd_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.job_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.nielsen_county_cd_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.number_of_employees_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.company_type_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.list_id_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.scno_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.custno_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.license_no_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.orig_date_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.exp_date_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.degree_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    bar_ALLOW_ErrorCount := COUNT(GROUP,h.bar_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    dpv_ALLOW_ErrorCount := COUNT(GROUP,h.dpv_Invalid=1);
    addr_type_ALLOW_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=1);
    county_cd_ALLOW_ErrorCount := COUNT(GROUP,h.county_cd_Invalid=1);
    job_code_ALLOW_ErrorCount := COUNT(GROUP,h.job_code_Invalid=1);
    nielsen_county_cd_ALLOW_ErrorCount := COUNT(GROUP,h.nielsen_county_cd_Invalid=1);
    number_of_employees_ALLOW_ErrorCount := COUNT(GROUP,h.number_of_employees_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    company_type_ENUM_ErrorCount := COUNT(GROUP,h.company_type_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    list_id_ALLOW_ErrorCount := COUNT(GROUP,h.list_id_Invalid=1);
    scno_ALLOW_ErrorCount := COUNT(GROUP,h.scno_Invalid=1);
    custno_ALLOW_ErrorCount := COUNT(GROUP,h.custno_Invalid=1);
    license_no_ALLOW_ErrorCount := COUNT(GROUP,h.license_no_Invalid=1);
    license_no_CUSTOM_ErrorCount := COUNT(GROUP,h.license_no_Invalid=2);
    license_no_Total_ErrorCount := COUNT(GROUP,h.license_no_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    orig_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_date_Invalid=1);
    exp_date_ALLOW_ErrorCount := COUNT(GROUP,h.exp_date_Invalid=1);
    degree_ALLOW_ErrorCount := COUNT(GROUP,h.degree_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.fname_Invalid,le.lname_Invalid,le.title_Invalid,le.state_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.bar_Invalid,le.gender_Invalid,le.dpv_Invalid,le.addr_type_Invalid,le.county_cd_Invalid,le.job_code_Invalid,le.nielsen_county_cd_Invalid,le.number_of_employees_Invalid,le.msa_Invalid,le.company_type_Invalid,le.phone_Invalid,le.list_id_Invalid,le.scno_Invalid,le.custno_Invalid,le.license_no_Invalid,le.dob_Invalid,le.orig_date_Invalid,le.exp_date_Invalid,le.degree_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_bar(le.bar_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_dpv(le.dpv_Invalid),Fields.InvalidMessage_addr_type(le.addr_type_Invalid),Fields.InvalidMessage_county_cd(le.county_cd_Invalid),Fields.InvalidMessage_job_code(le.job_code_Invalid),Fields.InvalidMessage_nielsen_county_cd(le.nielsen_county_cd_Invalid),Fields.InvalidMessage_number_of_employees(le.number_of_employees_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_company_type(le.company_type_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_list_id(le.list_id_Invalid),Fields.InvalidMessage_scno(le.scno_Invalid),Fields.InvalidMessage_custno(le.custno_Invalid),Fields.InvalidMessage_license_no(le.license_no_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_orig_date(le.orig_date_Invalid),Fields.InvalidMessage_exp_date(le.exp_date_Invalid),Fields.InvalidMessage_degree(le.degree_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bar_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dpv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.job_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nielsen_county_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.number_of_employees_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.list_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.scno_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.custno_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_no_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exp_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.degree_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fname','lname','title','state','zip','zip4','cart','bar','gender','dpv','addr_type','county_cd','job_code','nielsen_county_cd','number_of_employees','msa','company_type','phone','list_id','scno','custno','license_no','dob','orig_date','exp_date','degree','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphaspacequote','invalid_alphaspacequote','invalid_alphaspace','invalid_alpha','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_gender','invalid_alpha','invalid_addr_type','invalid_alphanumeric','invalid_job_code','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_company_type','invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_license_number','invalid_date','invalid_slash_date','invalid_slash_date','invalid_alphaspaceperiod','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.fname,(SALT32.StrType)le.lname,(SALT32.StrType)le.title,(SALT32.StrType)le.state,(SALT32.StrType)le.zip,(SALT32.StrType)le.zip4,(SALT32.StrType)le.cart,(SALT32.StrType)le.bar,(SALT32.StrType)le.gender,(SALT32.StrType)le.dpv,(SALT32.StrType)le.addr_type,(SALT32.StrType)le.county_cd,(SALT32.StrType)le.job_code,(SALT32.StrType)le.nielsen_county_cd,(SALT32.StrType)le.number_of_employees,(SALT32.StrType)le.msa,(SALT32.StrType)le.company_type,(SALT32.StrType)le.phone,(SALT32.StrType)le.list_id,(SALT32.StrType)le.scno,(SALT32.StrType)le.custno,(SALT32.StrType)le.license_no,(SALT32.StrType)le.dob,(SALT32.StrType)le.orig_date,(SALT32.StrType)le.exp_date,(SALT32.StrType)le.degree,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,26,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'fname:invalid_alphaspacequote:ALLOW'
          ,'lname:invalid_alphaspacequote:ALLOW'
          ,'title:invalid_alphaspace:ALLOW'
          ,'state:invalid_alpha:ALLOW'
          ,'zip:invalid_numeric:ALLOW'
          ,'zip4:invalid_numeric:ALLOW'
          ,'cart:invalid_alphanumeric:ALLOW'
          ,'bar:invalid_numeric:ALLOW'
          ,'gender:invalid_gender:ENUM'
          ,'dpv:invalid_alpha:ALLOW'
          ,'addr_type:invalid_addr_type:ALLOW'
          ,'county_cd:invalid_alphanumeric:ALLOW'
          ,'job_code:invalid_job_code:ALLOW'
          ,'nielsen_county_cd:invalid_alphanumeric:ALLOW'
          ,'number_of_employees:invalid_numeric:ALLOW'
          ,'msa:invalid_numeric:ALLOW'
          ,'company_type:invalid_company_type:ENUM'
          ,'phone:invalid_numeric:ALLOW'
          ,'list_id:invalid_numeric:ALLOW'
          ,'scno:invalid_numeric:ALLOW'
          ,'custno:invalid_alphanumeric:ALLOW'
          ,'license_no:invalid_license_number:ALLOW','license_no:invalid_license_number:CUSTOM'
          ,'dob:invalid_date:ALLOW','dob:invalid_date:CUSTOM'
          ,'orig_date:invalid_slash_date:ALLOW'
          ,'exp_date:invalid_slash_date:ALLOW'
          ,'degree:invalid_alphaspaceperiod:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_zip(1)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_cart(1)
          ,Fields.InvalidMessage_bar(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_dpv(1)
          ,Fields.InvalidMessage_addr_type(1)
          ,Fields.InvalidMessage_county_cd(1)
          ,Fields.InvalidMessage_job_code(1)
          ,Fields.InvalidMessage_nielsen_county_cd(1)
          ,Fields.InvalidMessage_number_of_employees(1)
          ,Fields.InvalidMessage_msa(1)
          ,Fields.InvalidMessage_company_type(1)
          ,Fields.InvalidMessage_phone(1)
          ,Fields.InvalidMessage_list_id(1)
          ,Fields.InvalidMessage_scno(1)
          ,Fields.InvalidMessage_custno(1)
          ,Fields.InvalidMessage_license_no(1),Fields.InvalidMessage_license_no(2)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_orig_date(1)
          ,Fields.InvalidMessage_exp_date(1)
          ,Fields.InvalidMessage_degree(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.bar_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.dpv_ALLOW_ErrorCount
          ,le.addr_type_ALLOW_ErrorCount
          ,le.county_cd_ALLOW_ErrorCount
          ,le.job_code_ALLOW_ErrorCount
          ,le.nielsen_county_cd_ALLOW_ErrorCount
          ,le.number_of_employees_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.company_type_ENUM_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.list_id_ALLOW_ErrorCount
          ,le.scno_ALLOW_ErrorCount
          ,le.custno_ALLOW_ErrorCount
          ,le.license_no_ALLOW_ErrorCount,le.license_no_CUSTOM_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_CUSTOM_ErrorCount
          ,le.orig_date_ALLOW_ErrorCount
          ,le.exp_date_ALLOW_ErrorCount
          ,le.degree_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.bar_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.dpv_ALLOW_ErrorCount
          ,le.addr_type_ALLOW_ErrorCount
          ,le.county_cd_ALLOW_ErrorCount
          ,le.job_code_ALLOW_ErrorCount
          ,le.nielsen_county_cd_ALLOW_ErrorCount
          ,le.number_of_employees_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.company_type_ENUM_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.list_id_ALLOW_ErrorCount
          ,le.scno_ALLOW_ErrorCount
          ,le.custno_ALLOW_ErrorCount
          ,le.license_no_ALLOW_ErrorCount,le.license_no_CUSTOM_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_CUSTOM_ErrorCount
          ,le.orig_date_ALLOW_ErrorCount
          ,le.exp_date_ALLOW_ErrorCount
          ,le.degree_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,28,Into(LEFT,COUNTER));
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
