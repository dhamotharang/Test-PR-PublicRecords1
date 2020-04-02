IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_Frandx) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_brand_name_cnt := COUNT(GROUP,h.brand_name <> (TYPEOF(h.brand_name))'');
    populated_brand_name_pcnt := AVE(GROUP,IF(h.brand_name = (TYPEOF(h.brand_name))'',0,100));
    maxlength_brand_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_name)));
    avelength_brand_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_name)),h.brand_name<>(typeof(h.brand_name))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_exec_full_name_cnt := COUNT(GROUP,h.exec_full_name <> (TYPEOF(h.exec_full_name))'');
    populated_exec_full_name_pcnt := AVE(GROUP,IF(h.exec_full_name = (TYPEOF(h.exec_full_name))'',0,100));
    maxlength_exec_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exec_full_name)));
    avelength_exec_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exec_full_name)),h.exec_full_name<>(typeof(h.exec_full_name))'');
    populated_franchisee_id_cnt := COUNT(GROUP,h.franchisee_id <> (TYPEOF(h.franchisee_id))'');
    populated_franchisee_id_pcnt := AVE(GROUP,IF(h.franchisee_id = (TYPEOF(h.franchisee_id))'',0,100));
    maxlength_franchisee_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchisee_id)));
    avelength_franchisee_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchisee_id)),h.franchisee_id<>(typeof(h.franchisee_id))'');
    populated_fruns_cnt := COUNT(GROUP,h.fruns <> (TYPEOF(h.fruns))'');
    populated_fruns_pcnt := AVE(GROUP,IF(h.fruns = (TYPEOF(h.fruns))'',0,100));
    maxlength_fruns := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fruns)));
    avelength_fruns := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fruns)),h.fruns<>(typeof(h.fruns))'');
    populated_industry_cnt := COUNT(GROUP,h.industry <> (TYPEOF(h.industry))'');
    populated_industry_pcnt := AVE(GROUP,IF(h.industry = (TYPEOF(h.industry))'',0,100));
    maxlength_industry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry)));
    avelength_industry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry)),h.industry<>(typeof(h.industry))'');
    populated_industry_type_cnt := COUNT(GROUP,h.industry_type <> (TYPEOF(h.industry_type))'');
    populated_industry_type_pcnt := AVE(GROUP,IF(h.industry_type = (TYPEOF(h.industry_type))'',0,100));
    maxlength_industry_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry_type)));
    avelength_industry_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry_type)),h.industry_type<>(typeof(h.industry_type))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_extension_cnt := COUNT(GROUP,h.phone_extension <> (TYPEOF(h.phone_extension))'');
    populated_phone_extension_pcnt := AVE(GROUP,IF(h.phone_extension = (TYPEOF(h.phone_extension))'',0,100));
    maxlength_phone_extension := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_extension)));
    avelength_phone_extension := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_extension)),h.phone_extension<>(typeof(h.phone_extension))'');
    populated_record_id_cnt := COUNT(GROUP,h.record_id <> (TYPEOF(h.record_id))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_relationship_code_cnt := COUNT(GROUP,h.relationship_code <> (TYPEOF(h.relationship_code))'');
    populated_relationship_code_pcnt := AVE(GROUP,IF(h.relationship_code = (TYPEOF(h.relationship_code))'',0,100));
    maxlength_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)));
    avelength_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)),h.relationship_code<>(typeof(h.relationship_code))'');
    populated_secondary_phone_cnt := COUNT(GROUP,h.secondary_phone <> (TYPEOF(h.secondary_phone))'');
    populated_secondary_phone_pcnt := AVE(GROUP,IF(h.secondary_phone = (TYPEOF(h.secondary_phone))'',0,100));
    maxlength_secondary_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.secondary_phone)));
    avelength_secondary_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.secondary_phone)),h.secondary_phone<>(typeof(h.secondary_phone))'');
    populated_sector_cnt := COUNT(GROUP,h.sector <> (TYPEOF(h.sector))'');
    populated_sector_pcnt := AVE(GROUP,IF(h.sector = (TYPEOF(h.sector))'',0,100));
    maxlength_sector := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sector)));
    avelength_sector := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sector)),h.sector<>(typeof(h.sector))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_unit_flag_cnt := COUNT(GROUP,h.unit_flag <> (TYPEOF(h.unit_flag))'');
    populated_unit_flag_pcnt := AVE(GROUP,IF(h.unit_flag = (TYPEOF(h.unit_flag))'',0,100));
    maxlength_unit_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_flag)));
    avelength_unit_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_flag)),h.unit_flag<>(typeof(h.unit_flag))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_zip_code4_cnt := COUNT(GROUP,h.zip_code4 <> (TYPEOF(h.zip_code4))'');
    populated_zip_code4_pcnt := AVE(GROUP,IF(h.zip_code4 = (TYPEOF(h.zip_code4))'',0,100));
    maxlength_zip_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code4)));
    avelength_zip_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code4)),h.zip_code4<>(typeof(h.zip_code4))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_brand_name_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_exec_full_name_pcnt *   0.00 / 100 + T.Populated_franchisee_id_pcnt *   0.00 / 100 + T.Populated_fruns_pcnt *   0.00 / 100 + T.Populated_industry_pcnt *   0.00 / 100 + T.Populated_industry_type_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_extension_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_relationship_code_pcnt *   0.00 / 100 + T.Populated_secondary_phone_pcnt *   0.00 / 100 + T.Populated_sector_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_unit_flag_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_zip_code4_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'address1','address2','brand_name','city','company_name','exec_full_name','franchisee_id','fruns','industry','industry_type','phone','phone_extension','record_id','relationship_code','secondary_phone','sector','sic_code','state','unit_flag','zip_code','zip_code4');
  SELF.populated_pcnt := CHOOSE(C,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_brand_name_pcnt,le.populated_city_pcnt,le.populated_company_name_pcnt,le.populated_exec_full_name_pcnt,le.populated_franchisee_id_pcnt,le.populated_fruns_pcnt,le.populated_industry_pcnt,le.populated_industry_type_pcnt,le.populated_phone_pcnt,le.populated_phone_extension_pcnt,le.populated_record_id_pcnt,le.populated_relationship_code_pcnt,le.populated_secondary_phone_pcnt,le.populated_sector_pcnt,le.populated_sic_code_pcnt,le.populated_state_pcnt,le.populated_unit_flag_pcnt,le.populated_zip_code_pcnt,le.populated_zip_code4_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_address1,le.maxlength_address2,le.maxlength_brand_name,le.maxlength_city,le.maxlength_company_name,le.maxlength_exec_full_name,le.maxlength_franchisee_id,le.maxlength_fruns,le.maxlength_industry,le.maxlength_industry_type,le.maxlength_phone,le.maxlength_phone_extension,le.maxlength_record_id,le.maxlength_relationship_code,le.maxlength_secondary_phone,le.maxlength_sector,le.maxlength_sic_code,le.maxlength_state,le.maxlength_unit_flag,le.maxlength_zip_code,le.maxlength_zip_code4);
  SELF.avelength := CHOOSE(C,le.avelength_address1,le.avelength_address2,le.avelength_brand_name,le.avelength_city,le.avelength_company_name,le.avelength_exec_full_name,le.avelength_franchisee_id,le.avelength_fruns,le.avelength_industry,le.avelength_industry_type,le.avelength_phone,le.avelength_phone_extension,le.avelength_record_id,le.avelength_relationship_code,le.avelength_secondary_phone,le.avelength_sector,le.avelength_sic_code,le.avelength_state,le.avelength_unit_flag,le.avelength_zip_code,le.avelength_zip_code4);
END;
EXPORT invSummary := NORMALIZE(summary0, 21, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.brand_name),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.exec_full_name),TRIM((SALT311.StrType)le.franchisee_id),TRIM((SALT311.StrType)le.fruns),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.industry_type),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_extension),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.secondary_phone),TRIM((SALT311.StrType)le.sector),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.unit_flag),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.zip_code4)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,21,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 21);
  SELF.FldNo2 := 1 + (C % 21);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.brand_name),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.exec_full_name),TRIM((SALT311.StrType)le.franchisee_id),TRIM((SALT311.StrType)le.fruns),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.industry_type),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_extension),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.secondary_phone),TRIM((SALT311.StrType)le.sector),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.unit_flag),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.zip_code4)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.brand_name),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.exec_full_name),TRIM((SALT311.StrType)le.franchisee_id),TRIM((SALT311.StrType)le.fruns),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.industry_type),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_extension),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.secondary_phone),TRIM((SALT311.StrType)le.sector),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.unit_flag),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.zip_code4)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),21*21,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'address1'}
      ,{2,'address2'}
      ,{3,'brand_name'}
      ,{4,'city'}
      ,{5,'company_name'}
      ,{6,'exec_full_name'}
      ,{7,'franchisee_id'}
      ,{8,'fruns'}
      ,{9,'industry'}
      ,{10,'industry_type'}
      ,{11,'phone'}
      ,{12,'phone_extension'}
      ,{13,'record_id'}
      ,{14,'relationship_code'}
      ,{15,'secondary_phone'}
      ,{16,'sector'}
      ,{17,'sic_code'}
      ,{18,'state'}
      ,{19,'unit_flag'}
      ,{20,'zip_code'}
      ,{21,'zip_code4'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_address1((SALT311.StrType)le.address1),
    Input_Fields.InValid_address2((SALT311.StrType)le.address2),
    Input_Fields.InValid_brand_name((SALT311.StrType)le.brand_name),
    Input_Fields.InValid_city((SALT311.StrType)le.city),
    Input_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Input_Fields.InValid_exec_full_name((SALT311.StrType)le.exec_full_name),
    Input_Fields.InValid_franchisee_id((SALT311.StrType)le.franchisee_id),
    Input_Fields.InValid_fruns((SALT311.StrType)le.fruns),
    Input_Fields.InValid_industry((SALT311.StrType)le.industry),
    Input_Fields.InValid_industry_type((SALT311.StrType)le.industry_type),
    Input_Fields.InValid_phone((SALT311.StrType)le.phone),
    Input_Fields.InValid_phone_extension((SALT311.StrType)le.phone_extension),
    Input_Fields.InValid_record_id((SALT311.StrType)le.record_id),
    Input_Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code),
    Input_Fields.InValid_secondary_phone((SALT311.StrType)le.secondary_phone),
    Input_Fields.InValid_sector((SALT311.StrType)le.sector),
    Input_Fields.InValid_sic_code((SALT311.StrType)le.sic_code),
    Input_Fields.InValid_state((SALT311.StrType)le.state),
    Input_Fields.InValid_unit_flag((SALT311.StrType)le.unit_flag),
    Input_Fields.InValid_zip_code((SALT311.StrType)le.zip_code),
    Input_Fields.InValid_zip_code4((SALT311.StrType)le.zip_code4),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,21,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alpha','Unknown','invalid_alpha','invalid_alpha','invalid_company_name','Unknown','invalid_franchisee_id','invalid_fruns','invalid_alpha','invalid_industry_type','invalid_phone','invalid_numeric','invalid_nonempty_number','invalid_relationship_code','invalid_secondary_phone','invalid_alpha','invalid_sic_code','invalid_state','invalid_unit_flag','invalid_zip_code','invalid_zip_code4');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_brand_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exec_full_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_franchisee_id(TotalErrors.ErrorNum),Input_Fields.InValidMessage_fruns(TotalErrors.ErrorNum),Input_Fields.InValidMessage_industry(TotalErrors.ErrorNum),Input_Fields.InValidMessage_industry_type(TotalErrors.ErrorNum),Input_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_phone_extension(TotalErrors.ErrorNum),Input_Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Input_Fields.InValidMessage_relationship_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_secondary_phone(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sector(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_unit_flag(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zip_code4(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Frandx, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
