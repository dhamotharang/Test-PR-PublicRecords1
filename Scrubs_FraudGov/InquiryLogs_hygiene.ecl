IMPORT SALT39,STD;
EXPORT InquiryLogs_hygiene(dataset(InquiryLogs_layout_InquiryLogs) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_datetime_cnt := COUNT(GROUP,h.datetime <> (TYPEOF(h.datetime))'');
    populated_datetime_pcnt := AVE(GROUP,IF(h.datetime = (TYPEOF(h.datetime))'',0,100));
    maxlength_datetime := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.datetime)));
    avelength_datetime := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.datetime)),h.datetime<>(typeof(h.datetime))'');
    populated_full_name_cnt := COUNT(GROUP,h.full_name <> (TYPEOF(h.full_name))'');
    populated_full_name_pcnt := AVE(GROUP,IF(h.full_name = (TYPEOF(h.full_name))'',0,100));
    maxlength_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.full_name)));
    avelength_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.full_name)),h.full_name<>(typeof(h.full_name))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_appended_ssn_cnt := COUNT(GROUP,h.appended_ssn <> (TYPEOF(h.appended_ssn))'');
    populated_appended_ssn_pcnt := AVE(GROUP,IF(h.appended_ssn = (TYPEOF(h.appended_ssn))'',0,100));
    maxlength_appended_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.appended_ssn)));
    avelength_appended_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.appended_ssn)),h.appended_ssn<>(typeof(h.appended_ssn))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_personal_phone_cnt := COUNT(GROUP,h.personal_phone <> (TYPEOF(h.personal_phone))'');
    populated_personal_phone_pcnt := AVE(GROUP,IF(h.personal_phone = (TYPEOF(h.personal_phone))'',0,100));
    maxlength_personal_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.personal_phone)));
    avelength_personal_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.personal_phone)),h.personal_phone<>(typeof(h.personal_phone))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_email_address_cnt := COUNT(GROUP,h.email_address <> (TYPEOF(h.email_address))'');
    populated_email_address_pcnt := AVE(GROUP,IF(h.email_address = (TYPEOF(h.email_address))'',0,100));
    maxlength_email_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.email_address)));
    avelength_email_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.email_address)),h.email_address<>(typeof(h.email_address))'');
    populated_dl_st_cnt := COUNT(GROUP,h.dl_st <> (TYPEOF(h.dl_st))'');
    populated_dl_st_pcnt := AVE(GROUP,IF(h.dl_st = (TYPEOF(h.dl_st))'',0,100));
    maxlength_dl_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dl_st)));
    avelength_dl_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dl_st)),h.dl_st<>(typeof(h.dl_st))'');
    populated_dl_cnt := COUNT(GROUP,h.dl <> (TYPEOF(h.dl))'');
    populated_dl_pcnt := AVE(GROUP,IF(h.dl = (TYPEOF(h.dl))'',0,100));
    maxlength_dl := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dl)));
    avelength_dl := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dl)),h.dl<>(typeof(h.dl))'');
    populated_ipaddr_cnt := COUNT(GROUP,h.ipaddr <> (TYPEOF(h.ipaddr))'');
    populated_ipaddr_pcnt := AVE(GROUP,IF(h.ipaddr = (TYPEOF(h.ipaddr))'',0,100));
    maxlength_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ipaddr)));
    avelength_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ipaddr)),h.ipaddr<>(typeof(h.ipaddr))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_Source_cnt := COUNT(GROUP,h.Source <> (TYPEOF(h.Source))'');
    populated_Source_pcnt := AVE(GROUP,IF(h.Source = (TYPEOF(h.Source))'',0,100));
    maxlength_Source := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Source)));
    avelength_Source := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Source)),h.Source<>(typeof(h.Source))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_datetime_pcnt *   0.00 / 100 + T.Populated_full_name_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_appended_ssn_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_personal_phone_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_email_address_pcnt *   0.00 / 100 + T.Populated_dl_st_pcnt *   0.00 / 100 + T.Populated_dl_pcnt *   0.00 / 100 + T.Populated_ipaddr_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_Source_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'transaction_id','datetime','full_name','title','fname','mname','lname','name_suffix','ssn','appended_ssn','address','city','state','zip','fips_county','personal_phone','dob','email_address','dl_st','dl','ipaddr','geo_lat','geo_long','Source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_transaction_id_pcnt,le.populated_datetime_pcnt,le.populated_full_name_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_ssn_pcnt,le.populated_appended_ssn_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_fips_county_pcnt,le.populated_personal_phone_pcnt,le.populated_dob_pcnt,le.populated_email_address_pcnt,le.populated_dl_st_pcnt,le.populated_dl_pcnt,le.populated_ipaddr_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_Source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_transaction_id,le.maxlength_datetime,le.maxlength_full_name,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_ssn,le.maxlength_appended_ssn,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_fips_county,le.maxlength_personal_phone,le.maxlength_dob,le.maxlength_email_address,le.maxlength_dl_st,le.maxlength_dl,le.maxlength_ipaddr,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_Source);
  SELF.avelength := CHOOSE(C,le.avelength_transaction_id,le.avelength_datetime,le.avelength_full_name,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_ssn,le.avelength_appended_ssn,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_fips_county,le.avelength_personal_phone,le.avelength_dob,le.avelength_email_address,le.avelength_dl_st,le.avelength_dl,le.avelength_ipaddr,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_Source);
END;
EXPORT invSummary := NORMALIZE(summary0, 24, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.transaction_id),TRIM((SALT39.StrType)le.datetime),TRIM((SALT39.StrType)le.full_name),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.ssn),TRIM((SALT39.StrType)le.appended_ssn),TRIM((SALT39.StrType)le.address),TRIM((SALT39.StrType)le.city),TRIM((SALT39.StrType)le.state),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.fips_county),TRIM((SALT39.StrType)le.personal_phone),TRIM((SALT39.StrType)le.dob),TRIM((SALT39.StrType)le.email_address),TRIM((SALT39.StrType)le.dl_st),TRIM((SALT39.StrType)le.dl),TRIM((SALT39.StrType)le.ipaddr),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.Source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,24,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 24);
  SELF.FldNo2 := 1 + (C % 24);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.transaction_id),TRIM((SALT39.StrType)le.datetime),TRIM((SALT39.StrType)le.full_name),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.ssn),TRIM((SALT39.StrType)le.appended_ssn),TRIM((SALT39.StrType)le.address),TRIM((SALT39.StrType)le.city),TRIM((SALT39.StrType)le.state),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.fips_county),TRIM((SALT39.StrType)le.personal_phone),TRIM((SALT39.StrType)le.dob),TRIM((SALT39.StrType)le.email_address),TRIM((SALT39.StrType)le.dl_st),TRIM((SALT39.StrType)le.dl),TRIM((SALT39.StrType)le.ipaddr),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.Source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.transaction_id),TRIM((SALT39.StrType)le.datetime),TRIM((SALT39.StrType)le.full_name),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.ssn),TRIM((SALT39.StrType)le.appended_ssn),TRIM((SALT39.StrType)le.address),TRIM((SALT39.StrType)le.city),TRIM((SALT39.StrType)le.state),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.fips_county),TRIM((SALT39.StrType)le.personal_phone),TRIM((SALT39.StrType)le.dob),TRIM((SALT39.StrType)le.email_address),TRIM((SALT39.StrType)le.dl_st),TRIM((SALT39.StrType)le.dl),TRIM((SALT39.StrType)le.ipaddr),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.Source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),24*24,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'transaction_id'}
      ,{2,'datetime'}
      ,{3,'full_name'}
      ,{4,'title'}
      ,{5,'fname'}
      ,{6,'mname'}
      ,{7,'lname'}
      ,{8,'name_suffix'}
      ,{9,'ssn'}
      ,{10,'appended_ssn'}
      ,{11,'address'}
      ,{12,'city'}
      ,{13,'state'}
      ,{14,'zip'}
      ,{15,'fips_county'}
      ,{16,'personal_phone'}
      ,{17,'dob'}
      ,{18,'email_address'}
      ,{19,'dl_st'}
      ,{20,'dl'}
      ,{21,'ipaddr'}
      ,{22,'geo_lat'}
      ,{23,'geo_long'}
      ,{24,'Source'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    InquiryLogs_Fields.InValid_transaction_id((SALT39.StrType)le.transaction_id),
    InquiryLogs_Fields.InValid_datetime((SALT39.StrType)le.datetime),
    InquiryLogs_Fields.InValid_full_name((SALT39.StrType)le.full_name),
    InquiryLogs_Fields.InValid_title((SALT39.StrType)le.title),
    InquiryLogs_Fields.InValid_fname((SALT39.StrType)le.fname),
    InquiryLogs_Fields.InValid_mname((SALT39.StrType)le.mname),
    InquiryLogs_Fields.InValid_lname((SALT39.StrType)le.lname),
    InquiryLogs_Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix),
    InquiryLogs_Fields.InValid_ssn((SALT39.StrType)le.ssn),
    InquiryLogs_Fields.InValid_appended_ssn((SALT39.StrType)le.appended_ssn),
    InquiryLogs_Fields.InValid_address((SALT39.StrType)le.address),
    InquiryLogs_Fields.InValid_city((SALT39.StrType)le.city),
    InquiryLogs_Fields.InValid_state((SALT39.StrType)le.state),
    InquiryLogs_Fields.InValid_zip((SALT39.StrType)le.zip),
    InquiryLogs_Fields.InValid_fips_county((SALT39.StrType)le.fips_county),
    InquiryLogs_Fields.InValid_personal_phone((SALT39.StrType)le.personal_phone),
    InquiryLogs_Fields.InValid_dob((SALT39.StrType)le.dob),
    InquiryLogs_Fields.InValid_email_address((SALT39.StrType)le.email_address),
    InquiryLogs_Fields.InValid_dl_st((SALT39.StrType)le.dl_st),
    InquiryLogs_Fields.InValid_dl((SALT39.StrType)le.dl),
    InquiryLogs_Fields.InValid_ipaddr((SALT39.StrType)le.ipaddr),
    InquiryLogs_Fields.InValid_geo_lat((SALT39.StrType)le.geo_lat),
    InquiryLogs_Fields.InValid_geo_long((SALT39.StrType)le.geo_long),
    InquiryLogs_Fields.InValid_Source((SALT39.StrType)le.Source),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,24,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := InquiryLogs_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphanumeric','invalid_date','invalid_name','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_alphanumeric','invalid_ssn','invalid_ssn','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_alphanumeric','invalid_phone','invalid_date','invalid_email','invalid_state','invalid_alphanumeric','invalid_ip','invalid_decimal','invalid_decimal','invalid_alphanumeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,InquiryLogs_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_datetime(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_full_name(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_title(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_fname(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_mname(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_lname(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_appended_ssn(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_address(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_city(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_state(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_zip(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_personal_phone(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_dob(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_email_address(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_dl_st(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_dl(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_ipaddr(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, InquiryLogs_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
