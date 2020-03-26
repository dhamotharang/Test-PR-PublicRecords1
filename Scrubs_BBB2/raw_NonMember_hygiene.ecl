IMPORT SALT311,STD;
EXPORT raw_NonMember_hygiene(dataset(raw_NonMember_layout_BBB2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_bbb_id_cnt := COUNT(GROUP,h.bbb_id <> (TYPEOF(h.bbb_id))'');
    populated_bbb_id_pcnt := AVE(GROUP,IF(h.bbb_id = (TYPEOF(h.bbb_id))'',0,100));
    maxlength_bbb_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bbb_id)));
    avelength_bbb_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bbb_id)),h.bbb_id<>(typeof(h.bbb_id))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_type_cnt := COUNT(GROUP,h.phone_type <> (TYPEOF(h.phone_type))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_listing_month_cnt := COUNT(GROUP,h.listing_month <> (TYPEOF(h.listing_month))'');
    populated_listing_month_pcnt := AVE(GROUP,IF(h.listing_month = (TYPEOF(h.listing_month))'',0,100));
    maxlength_listing_month := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_month)));
    avelength_listing_month := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_month)),h.listing_month<>(typeof(h.listing_month))'');
    populated_listing_day_cnt := COUNT(GROUP,h.listing_day <> (TYPEOF(h.listing_day))'');
    populated_listing_day_pcnt := AVE(GROUP,IF(h.listing_day = (TYPEOF(h.listing_day))'',0,100));
    maxlength_listing_day := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_day)));
    avelength_listing_day := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_day)),h.listing_day<>(typeof(h.listing_day))'');
    populated_listing_year_cnt := COUNT(GROUP,h.listing_year <> (TYPEOF(h.listing_year))'');
    populated_listing_year_pcnt := AVE(GROUP,IF(h.listing_year = (TYPEOF(h.listing_year))'',0,100));
    maxlength_listing_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_year)));
    avelength_listing_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.listing_year)),h.listing_year<>(typeof(h.listing_year))'');
    populated_http_link_cnt := COUNT(GROUP,h.http_link <> (TYPEOF(h.http_link))'');
    populated_http_link_pcnt := AVE(GROUP,IF(h.http_link = (TYPEOF(h.http_link))'',0,100));
    maxlength_http_link := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.http_link)));
    avelength_http_link := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.http_link)),h.http_link<>(typeof(h.http_link))'');
    populated_non_member_title_cnt := COUNT(GROUP,h.non_member_title <> (TYPEOF(h.non_member_title))'');
    populated_non_member_title_pcnt := AVE(GROUP,IF(h.non_member_title = (TYPEOF(h.non_member_title))'',0,100));
    maxlength_non_member_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_member_title)));
    avelength_non_member_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_member_title)),h.non_member_title<>(typeof(h.non_member_title))'');
    populated_non_member_category_cnt := COUNT(GROUP,h.non_member_category <> (TYPEOF(h.non_member_category))'');
    populated_non_member_category_pcnt := AVE(GROUP,IF(h.non_member_category = (TYPEOF(h.non_member_category))'',0,100));
    maxlength_non_member_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_member_category)));
    avelength_non_member_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_member_category)),h.non_member_category<>(typeof(h.non_member_category))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_bbb_id_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_listing_month_pcnt *   0.00 / 100 + T.Populated_listing_day_pcnt *   0.00 / 100 + T.Populated_listing_year_pcnt *   0.00 / 100 + T.Populated_http_link_pcnt *   0.00 / 100 + T.Populated_non_member_title_pcnt *   0.00 / 100 + T.Populated_non_member_category_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'bbb_id','company_name','address','country','phone','phone_type','listing_month','listing_day','listing_year','http_link','non_member_title','non_member_category');
  SELF.populated_pcnt := CHOOSE(C,le.populated_bbb_id_pcnt,le.populated_company_name_pcnt,le.populated_address_pcnt,le.populated_country_pcnt,le.populated_phone_pcnt,le.populated_phone_type_pcnt,le.populated_listing_month_pcnt,le.populated_listing_day_pcnt,le.populated_listing_year_pcnt,le.populated_http_link_pcnt,le.populated_non_member_title_pcnt,le.populated_non_member_category_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_bbb_id,le.maxlength_company_name,le.maxlength_address,le.maxlength_country,le.maxlength_phone,le.maxlength_phone_type,le.maxlength_listing_month,le.maxlength_listing_day,le.maxlength_listing_year,le.maxlength_http_link,le.maxlength_non_member_title,le.maxlength_non_member_category);
  SELF.avelength := CHOOSE(C,le.avelength_bbb_id,le.avelength_company_name,le.avelength_address,le.avelength_country,le.avelength_phone,le.avelength_phone_type,le.avelength_listing_month,le.avelength_listing_day,le.avelength_listing_year,le.avelength_http_link,le.avelength_non_member_title,le.avelength_non_member_category);
END;
EXPORT invSummary := NORMALIZE(summary0, 12, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.bbb_id),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.listing_month),TRIM((SALT311.StrType)le.listing_day),TRIM((SALT311.StrType)le.listing_year),TRIM((SALT311.StrType)le.http_link),TRIM((SALT311.StrType)le.non_member_title),TRIM((SALT311.StrType)le.non_member_category)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,12,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 12);
  SELF.FldNo2 := 1 + (C % 12);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.bbb_id),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.listing_month),TRIM((SALT311.StrType)le.listing_day),TRIM((SALT311.StrType)le.listing_year),TRIM((SALT311.StrType)le.http_link),TRIM((SALT311.StrType)le.non_member_title),TRIM((SALT311.StrType)le.non_member_category)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.bbb_id),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.listing_month),TRIM((SALT311.StrType)le.listing_day),TRIM((SALT311.StrType)le.listing_year),TRIM((SALT311.StrType)le.http_link),TRIM((SALT311.StrType)le.non_member_title),TRIM((SALT311.StrType)le.non_member_category)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),12*12,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'bbb_id'}
      ,{2,'company_name'}
      ,{3,'address'}
      ,{4,'country'}
      ,{5,'phone'}
      ,{6,'phone_type'}
      ,{7,'listing_month'}
      ,{8,'listing_day'}
      ,{9,'listing_year'}
      ,{10,'http_link'}
      ,{11,'non_member_title'}
      ,{12,'non_member_category'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_NonMember_Fields.InValid_bbb_id((SALT311.StrType)le.bbb_id),
    raw_NonMember_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    raw_NonMember_Fields.InValid_address((SALT311.StrType)le.address),
    raw_NonMember_Fields.InValid_country((SALT311.StrType)le.country),
    raw_NonMember_Fields.InValid_phone((SALT311.StrType)le.phone),
    raw_NonMember_Fields.InValid_phone_type((SALT311.StrType)le.phone_type),
    raw_NonMember_Fields.InValid_listing_month((SALT311.StrType)le.listing_month),
    raw_NonMember_Fields.InValid_listing_day((SALT311.StrType)le.listing_day),
    raw_NonMember_Fields.InValid_listing_year((SALT311.StrType)le.listing_year,(SALT311.StrType)le.listing_month,(SALT311.StrType)le.listing_day),
    raw_NonMember_Fields.InValid_http_link((SALT311.StrType)le.http_link),
    raw_NonMember_Fields.InValid_non_member_title((SALT311.StrType)le.non_member_title),
    raw_NonMember_Fields.InValid_non_member_category((SALT311.StrType)le.non_member_category),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,12,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_NonMember_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_bbb_id','invalid_chk_blanks','invalid_chk_addr','invalid_country','invalid_phone','invalid_phone_type','Unknown','Unknown','invalid_listing_year','invalid_http_link','invalid_chk_blanks','invalid_chk_blanks');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_NonMember_Fields.InValidMessage_bbb_id(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_address(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_country(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_phone(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_listing_month(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_listing_day(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_listing_year(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_http_link(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_non_member_title(TotalErrors.ErrorNum),raw_NonMember_Fields.InValidMessage_non_member_category(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BBB2, raw_NonMember_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
