IMPORT SALT311,STD;
EXPORT raw_Member_hygiene(dataset(raw_Member_layout_BBB2) h) := MODULE
 
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
    populated_member_title_cnt := COUNT(GROUP,h.member_title <> (TYPEOF(h.member_title))'');
    populated_member_title_pcnt := AVE(GROUP,IF(h.member_title = (TYPEOF(h.member_title))'',0,100));
    maxlength_member_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_title)));
    avelength_member_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_title)),h.member_title<>(typeof(h.member_title))'');
    populated_member_attr_name1_cnt := COUNT(GROUP,h.member_attr_name1 <> (TYPEOF(h.member_attr_name1))'');
    populated_member_attr_name1_pcnt := AVE(GROUP,IF(h.member_attr_name1 = (TYPEOF(h.member_attr_name1))'',0,100));
    maxlength_member_attr_name1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr_name1)));
    avelength_member_attr_name1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr_name1)),h.member_attr_name1<>(typeof(h.member_attr_name1))'');
    populated_member_attr1_cnt := COUNT(GROUP,h.member_attr1 <> (TYPEOF(h.member_attr1))'');
    populated_member_attr1_pcnt := AVE(GROUP,IF(h.member_attr1 = (TYPEOF(h.member_attr1))'',0,100));
    maxlength_member_attr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr1)));
    avelength_member_attr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr1)),h.member_attr1<>(typeof(h.member_attr1))'');
    populated_member_attr_name2_cnt := COUNT(GROUP,h.member_attr_name2 <> (TYPEOF(h.member_attr_name2))'');
    populated_member_attr_name2_pcnt := AVE(GROUP,IF(h.member_attr_name2 = (TYPEOF(h.member_attr_name2))'',0,100));
    maxlength_member_attr_name2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr_name2)));
    avelength_member_attr_name2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr_name2)),h.member_attr_name2<>(typeof(h.member_attr_name2))'');
    populated_member_attr2_cnt := COUNT(GROUP,h.member_attr2 <> (TYPEOF(h.member_attr2))'');
    populated_member_attr2_pcnt := AVE(GROUP,IF(h.member_attr2 = (TYPEOF(h.member_attr2))'',0,100));
    maxlength_member_attr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr2)));
    avelength_member_attr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_attr2)),h.member_attr2<>(typeof(h.member_attr2))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_bbb_id_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_listing_month_pcnt *   0.00 / 100 + T.Populated_listing_day_pcnt *   0.00 / 100 + T.Populated_listing_year_pcnt *   0.00 / 100 + T.Populated_http_link_pcnt *   0.00 / 100 + T.Populated_member_title_pcnt *   0.00 / 100 + T.Populated_member_attr_name1_pcnt *   0.00 / 100 + T.Populated_member_attr1_pcnt *   0.00 / 100 + T.Populated_member_attr_name2_pcnt *   0.00 / 100 + T.Populated_member_attr2_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'bbb_id','company_name','address','country','phone','phone_type','listing_month','listing_day','listing_year','http_link','member_title','member_attr_name1','member_attr1','member_attr_name2','member_attr2');
  SELF.populated_pcnt := CHOOSE(C,le.populated_bbb_id_pcnt,le.populated_company_name_pcnt,le.populated_address_pcnt,le.populated_country_pcnt,le.populated_phone_pcnt,le.populated_phone_type_pcnt,le.populated_listing_month_pcnt,le.populated_listing_day_pcnt,le.populated_listing_year_pcnt,le.populated_http_link_pcnt,le.populated_member_title_pcnt,le.populated_member_attr_name1_pcnt,le.populated_member_attr1_pcnt,le.populated_member_attr_name2_pcnt,le.populated_member_attr2_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_bbb_id,le.maxlength_company_name,le.maxlength_address,le.maxlength_country,le.maxlength_phone,le.maxlength_phone_type,le.maxlength_listing_month,le.maxlength_listing_day,le.maxlength_listing_year,le.maxlength_http_link,le.maxlength_member_title,le.maxlength_member_attr_name1,le.maxlength_member_attr1,le.maxlength_member_attr_name2,le.maxlength_member_attr2);
  SELF.avelength := CHOOSE(C,le.avelength_bbb_id,le.avelength_company_name,le.avelength_address,le.avelength_country,le.avelength_phone,le.avelength_phone_type,le.avelength_listing_month,le.avelength_listing_day,le.avelength_listing_year,le.avelength_http_link,le.avelength_member_title,le.avelength_member_attr_name1,le.avelength_member_attr1,le.avelength_member_attr_name2,le.avelength_member_attr2);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.bbb_id),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.listing_month),TRIM((SALT311.StrType)le.listing_day),TRIM((SALT311.StrType)le.listing_year),TRIM((SALT311.StrType)le.http_link),TRIM((SALT311.StrType)le.member_title),TRIM((SALT311.StrType)le.member_attr_name1),TRIM((SALT311.StrType)le.member_attr1),TRIM((SALT311.StrType)le.member_attr_name2),TRIM((SALT311.StrType)le.member_attr2)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.bbb_id),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.listing_month),TRIM((SALT311.StrType)le.listing_day),TRIM((SALT311.StrType)le.listing_year),TRIM((SALT311.StrType)le.http_link),TRIM((SALT311.StrType)le.member_title),TRIM((SALT311.StrType)le.member_attr_name1),TRIM((SALT311.StrType)le.member_attr1),TRIM((SALT311.StrType)le.member_attr_name2),TRIM((SALT311.StrType)le.member_attr2)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.bbb_id),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.listing_month),TRIM((SALT311.StrType)le.listing_day),TRIM((SALT311.StrType)le.listing_year),TRIM((SALT311.StrType)le.http_link),TRIM((SALT311.StrType)le.member_title),TRIM((SALT311.StrType)le.member_attr_name1),TRIM((SALT311.StrType)le.member_attr1),TRIM((SALT311.StrType)le.member_attr_name2),TRIM((SALT311.StrType)le.member_attr2)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{11,'member_title'}
      ,{12,'member_attr_name1'}
      ,{13,'member_attr1'}
      ,{14,'member_attr_name2'}
      ,{15,'member_attr2'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_Member_Fields.InValid_bbb_id((SALT311.StrType)le.bbb_id),
    raw_Member_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    raw_Member_Fields.InValid_address((SALT311.StrType)le.address),
    raw_Member_Fields.InValid_country((SALT311.StrType)le.country),
    raw_Member_Fields.InValid_phone((SALT311.StrType)le.phone),
    raw_Member_Fields.InValid_phone_type((SALT311.StrType)le.phone_type),
    raw_Member_Fields.InValid_listing_month((SALT311.StrType)le.listing_month),
    raw_Member_Fields.InValid_listing_day((SALT311.StrType)le.listing_day),
    raw_Member_Fields.InValid_listing_year((SALT311.StrType)le.listing_year,(SALT311.StrType)le.listing_month,(SALT311.StrType)le.listing_day),
    raw_Member_Fields.InValid_http_link((SALT311.StrType)le.http_link),
    raw_Member_Fields.InValid_member_title((SALT311.StrType)le.member_title),
    raw_Member_Fields.InValid_member_attr_name1((SALT311.StrType)le.member_attr_name1),
    raw_Member_Fields.InValid_member_attr1((SALT311.StrType)le.member_attr1),
    raw_Member_Fields.InValid_member_attr_name2((SALT311.StrType)le.member_attr_name2),
    raw_Member_Fields.InValid_member_attr2((SALT311.StrType)le.member_attr2),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,15,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_Member_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_bbb_id','invalid_chk_blanks','invalid_chk_blanks','invalid_country','invalid_phone','invalid_phone_type','Unknown','Unknown','invalid_listing_year','invalid_http_link','invalid_chk_blanks','invalid_member_attr_name1','invalid_member_attr1','invalid_member_attr_name2','invalid_chk_blanks');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_Member_Fields.InValidMessage_bbb_id(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_address(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_country(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_phone(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_listing_month(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_listing_day(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_listing_year(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_http_link(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_member_title(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_member_attr_name1(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_member_attr1(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_member_attr_name2(TotalErrors.ErrorNum),raw_Member_Fields.InValidMessage_member_attr2(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BBB2, raw_Member_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
