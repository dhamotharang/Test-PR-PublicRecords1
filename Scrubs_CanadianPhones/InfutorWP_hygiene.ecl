IMPORT SALT311,STD;
EXPORT InfutorWP_hygiene(dataset(InfutorWP_layout_CanadianPhones) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_can_phone_cnt := COUNT(GROUP,h.can_phone <> (TYPEOF(h.can_phone))'');
    populated_can_phone_pcnt := AVE(GROUP,IF(h.can_phone = (TYPEOF(h.can_phone))'',0,100));
    maxlength_can_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_phone)));
    avelength_can_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_phone)),h.can_phone<>(typeof(h.can_phone))'');
    populated_can_title_cnt := COUNT(GROUP,h.can_title <> (TYPEOF(h.can_title))'');
    populated_can_title_pcnt := AVE(GROUP,IF(h.can_title = (TYPEOF(h.can_title))'',0,100));
    maxlength_can_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_title)));
    avelength_can_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_title)),h.can_title<>(typeof(h.can_title))'');
    populated_can_fname_cnt := COUNT(GROUP,h.can_fname <> (TYPEOF(h.can_fname))'');
    populated_can_fname_pcnt := AVE(GROUP,IF(h.can_fname = (TYPEOF(h.can_fname))'',0,100));
    maxlength_can_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_fname)));
    avelength_can_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_fname)),h.can_fname<>(typeof(h.can_fname))'');
    populated_can_lname_cnt := COUNT(GROUP,h.can_lname <> (TYPEOF(h.can_lname))'');
    populated_can_lname_pcnt := AVE(GROUP,IF(h.can_lname = (TYPEOF(h.can_lname))'',0,100));
    maxlength_can_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_lname)));
    avelength_can_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_lname)),h.can_lname<>(typeof(h.can_lname))'');
    populated_can_suffix_cnt := COUNT(GROUP,h.can_suffix <> (TYPEOF(h.can_suffix))'');
    populated_can_suffix_pcnt := AVE(GROUP,IF(h.can_suffix = (TYPEOF(h.can_suffix))'',0,100));
    maxlength_can_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_suffix)));
    avelength_can_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_suffix)),h.can_suffix<>(typeof(h.can_suffix))'');
    populated_can_address1_cnt := COUNT(GROUP,h.can_address1 <> (TYPEOF(h.can_address1))'');
    populated_can_address1_pcnt := AVE(GROUP,IF(h.can_address1 = (TYPEOF(h.can_address1))'',0,100));
    maxlength_can_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_address1)));
    avelength_can_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_address1)),h.can_address1<>(typeof(h.can_address1))'');
    populated_can_house_cnt := COUNT(GROUP,h.can_house <> (TYPEOF(h.can_house))'');
    populated_can_house_pcnt := AVE(GROUP,IF(h.can_house = (TYPEOF(h.can_house))'',0,100));
    maxlength_can_house := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_house)));
    avelength_can_house := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_house)),h.can_house<>(typeof(h.can_house))'');
    populated_can_predir_cnt := COUNT(GROUP,h.can_predir <> (TYPEOF(h.can_predir))'');
    populated_can_predir_pcnt := AVE(GROUP,IF(h.can_predir = (TYPEOF(h.can_predir))'',0,100));
    maxlength_can_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_predir)));
    avelength_can_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_predir)),h.can_predir<>(typeof(h.can_predir))'');
    populated_can_street_cnt := COUNT(GROUP,h.can_street <> (TYPEOF(h.can_street))'');
    populated_can_street_pcnt := AVE(GROUP,IF(h.can_street = (TYPEOF(h.can_street))'',0,100));
    maxlength_can_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_street)));
    avelength_can_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_street)),h.can_street<>(typeof(h.can_street))'');
    populated_can_strtype_cnt := COUNT(GROUP,h.can_strtype <> (TYPEOF(h.can_strtype))'');
    populated_can_strtype_pcnt := AVE(GROUP,IF(h.can_strtype = (TYPEOF(h.can_strtype))'',0,100));
    maxlength_can_strtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_strtype)));
    avelength_can_strtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_strtype)),h.can_strtype<>(typeof(h.can_strtype))'');
    populated_can_postdir_cnt := COUNT(GROUP,h.can_postdir <> (TYPEOF(h.can_postdir))'');
    populated_can_postdir_pcnt := AVE(GROUP,IF(h.can_postdir = (TYPEOF(h.can_postdir))'',0,100));
    maxlength_can_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_postdir)));
    avelength_can_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_postdir)),h.can_postdir<>(typeof(h.can_postdir))'');
    populated_can_apttype_cnt := COUNT(GROUP,h.can_apttype <> (TYPEOF(h.can_apttype))'');
    populated_can_apttype_pcnt := AVE(GROUP,IF(h.can_apttype = (TYPEOF(h.can_apttype))'',0,100));
    maxlength_can_apttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_apttype)));
    avelength_can_apttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_apttype)),h.can_apttype<>(typeof(h.can_apttype))'');
    populated_can_aptnbr_cnt := COUNT(GROUP,h.can_aptnbr <> (TYPEOF(h.can_aptnbr))'');
    populated_can_aptnbr_pcnt := AVE(GROUP,IF(h.can_aptnbr = (TYPEOF(h.can_aptnbr))'',0,100));
    maxlength_can_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_aptnbr)));
    avelength_can_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_aptnbr)),h.can_aptnbr<>(typeof(h.can_aptnbr))'');
    populated_can_city_cnt := COUNT(GROUP,h.can_city <> (TYPEOF(h.can_city))'');
    populated_can_city_pcnt := AVE(GROUP,IF(h.can_city = (TYPEOF(h.can_city))'',0,100));
    maxlength_can_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_city)));
    avelength_can_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_city)),h.can_city<>(typeof(h.can_city))'');
    populated_can_province_cnt := COUNT(GROUP,h.can_province <> (TYPEOF(h.can_province))'');
    populated_can_province_pcnt := AVE(GROUP,IF(h.can_province = (TYPEOF(h.can_province))'',0,100));
    maxlength_can_province := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_province)));
    avelength_can_province := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_province)),h.can_province<>(typeof(h.can_province))'');
    populated_can_postalcd_cnt := COUNT(GROUP,h.can_postalcd <> (TYPEOF(h.can_postalcd))'');
    populated_can_postalcd_pcnt := AVE(GROUP,IF(h.can_postalcd = (TYPEOF(h.can_postalcd))'',0,100));
    maxlength_can_postalcd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_postalcd)));
    avelength_can_postalcd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_postalcd)),h.can_postalcd<>(typeof(h.can_postalcd))'');
    populated_can_lang_cnt := COUNT(GROUP,h.can_lang <> (TYPEOF(h.can_lang))'');
    populated_can_lang_pcnt := AVE(GROUP,IF(h.can_lang = (TYPEOF(h.can_lang))'',0,100));
    maxlength_can_lang := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_lang)));
    avelength_can_lang := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_lang)),h.can_lang<>(typeof(h.can_lang))'');
    populated_can_rectype_cnt := COUNT(GROUP,h.can_rectype <> (TYPEOF(h.can_rectype))'');
    populated_can_rectype_pcnt := AVE(GROUP,IF(h.can_rectype = (TYPEOF(h.can_rectype))'',0,100));
    maxlength_can_rectype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_rectype)));
    avelength_can_rectype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.can_rectype)),h.can_rectype<>(typeof(h.can_rectype))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_can_phone_pcnt *   0.00 / 100 + T.Populated_can_title_pcnt *   0.00 / 100 + T.Populated_can_fname_pcnt *   0.00 / 100 + T.Populated_can_lname_pcnt *   0.00 / 100 + T.Populated_can_suffix_pcnt *   0.00 / 100 + T.Populated_can_address1_pcnt *   0.00 / 100 + T.Populated_can_house_pcnt *   0.00 / 100 + T.Populated_can_predir_pcnt *   0.00 / 100 + T.Populated_can_street_pcnt *   0.00 / 100 + T.Populated_can_strtype_pcnt *   0.00 / 100 + T.Populated_can_postdir_pcnt *   0.00 / 100 + T.Populated_can_apttype_pcnt *   0.00 / 100 + T.Populated_can_aptnbr_pcnt *   0.00 / 100 + T.Populated_can_city_pcnt *   0.00 / 100 + T.Populated_can_province_pcnt *   0.00 / 100 + T.Populated_can_postalcd_pcnt *   0.00 / 100 + T.Populated_can_lang_pcnt *   0.00 / 100 + T.Populated_can_rectype_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'can_phone','can_title','can_fname','can_lname','can_suffix','can_address1','can_house','can_predir','can_street','can_strtype','can_postdir','can_apttype','can_aptnbr','can_city','can_province','can_postalcd','can_lang','can_rectype');
  SELF.populated_pcnt := CHOOSE(C,le.populated_can_phone_pcnt,le.populated_can_title_pcnt,le.populated_can_fname_pcnt,le.populated_can_lname_pcnt,le.populated_can_suffix_pcnt,le.populated_can_address1_pcnt,le.populated_can_house_pcnt,le.populated_can_predir_pcnt,le.populated_can_street_pcnt,le.populated_can_strtype_pcnt,le.populated_can_postdir_pcnt,le.populated_can_apttype_pcnt,le.populated_can_aptnbr_pcnt,le.populated_can_city_pcnt,le.populated_can_province_pcnt,le.populated_can_postalcd_pcnt,le.populated_can_lang_pcnt,le.populated_can_rectype_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_can_phone,le.maxlength_can_title,le.maxlength_can_fname,le.maxlength_can_lname,le.maxlength_can_suffix,le.maxlength_can_address1,le.maxlength_can_house,le.maxlength_can_predir,le.maxlength_can_street,le.maxlength_can_strtype,le.maxlength_can_postdir,le.maxlength_can_apttype,le.maxlength_can_aptnbr,le.maxlength_can_city,le.maxlength_can_province,le.maxlength_can_postalcd,le.maxlength_can_lang,le.maxlength_can_rectype);
  SELF.avelength := CHOOSE(C,le.avelength_can_phone,le.avelength_can_title,le.avelength_can_fname,le.avelength_can_lname,le.avelength_can_suffix,le.avelength_can_address1,le.avelength_can_house,le.avelength_can_predir,le.avelength_can_street,le.avelength_can_strtype,le.avelength_can_postdir,le.avelength_can_apttype,le.avelength_can_aptnbr,le.avelength_can_city,le.avelength_can_province,le.avelength_can_postalcd,le.avelength_can_lang,le.avelength_can_rectype);
END;
EXPORT invSummary := NORMALIZE(summary0, 18, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.can_phone),TRIM((SALT311.StrType)le.can_title),TRIM((SALT311.StrType)le.can_fname),TRIM((SALT311.StrType)le.can_lname),TRIM((SALT311.StrType)le.can_suffix),TRIM((SALT311.StrType)le.can_address1),TRIM((SALT311.StrType)le.can_house),TRIM((SALT311.StrType)le.can_predir),TRIM((SALT311.StrType)le.can_street),TRIM((SALT311.StrType)le.can_strtype),TRIM((SALT311.StrType)le.can_postdir),TRIM((SALT311.StrType)le.can_apttype),TRIM((SALT311.StrType)le.can_aptnbr),TRIM((SALT311.StrType)le.can_city),TRIM((SALT311.StrType)le.can_province),TRIM((SALT311.StrType)le.can_postalcd),TRIM((SALT311.StrType)le.can_lang),TRIM((SALT311.StrType)le.can_rectype)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,18,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 18);
  SELF.FldNo2 := 1 + (C % 18);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.can_phone),TRIM((SALT311.StrType)le.can_title),TRIM((SALT311.StrType)le.can_fname),TRIM((SALT311.StrType)le.can_lname),TRIM((SALT311.StrType)le.can_suffix),TRIM((SALT311.StrType)le.can_address1),TRIM((SALT311.StrType)le.can_house),TRIM((SALT311.StrType)le.can_predir),TRIM((SALT311.StrType)le.can_street),TRIM((SALT311.StrType)le.can_strtype),TRIM((SALT311.StrType)le.can_postdir),TRIM((SALT311.StrType)le.can_apttype),TRIM((SALT311.StrType)le.can_aptnbr),TRIM((SALT311.StrType)le.can_city),TRIM((SALT311.StrType)le.can_province),TRIM((SALT311.StrType)le.can_postalcd),TRIM((SALT311.StrType)le.can_lang),TRIM((SALT311.StrType)le.can_rectype)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.can_phone),TRIM((SALT311.StrType)le.can_title),TRIM((SALT311.StrType)le.can_fname),TRIM((SALT311.StrType)le.can_lname),TRIM((SALT311.StrType)le.can_suffix),TRIM((SALT311.StrType)le.can_address1),TRIM((SALT311.StrType)le.can_house),TRIM((SALT311.StrType)le.can_predir),TRIM((SALT311.StrType)le.can_street),TRIM((SALT311.StrType)le.can_strtype),TRIM((SALT311.StrType)le.can_postdir),TRIM((SALT311.StrType)le.can_apttype),TRIM((SALT311.StrType)le.can_aptnbr),TRIM((SALT311.StrType)le.can_city),TRIM((SALT311.StrType)le.can_province),TRIM((SALT311.StrType)le.can_postalcd),TRIM((SALT311.StrType)le.can_lang),TRIM((SALT311.StrType)le.can_rectype)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),18*18,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'can_phone'}
      ,{2,'can_title'}
      ,{3,'can_fname'}
      ,{4,'can_lname'}
      ,{5,'can_suffix'}
      ,{6,'can_address1'}
      ,{7,'can_house'}
      ,{8,'can_predir'}
      ,{9,'can_street'}
      ,{10,'can_strtype'}
      ,{11,'can_postdir'}
      ,{12,'can_apttype'}
      ,{13,'can_aptnbr'}
      ,{14,'can_city'}
      ,{15,'can_province'}
      ,{16,'can_postalcd'}
      ,{17,'can_lang'}
      ,{18,'can_rectype'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    InfutorWP_Fields.InValid_can_phone((SALT311.StrType)le.can_phone),
    InfutorWP_Fields.InValid_can_title((SALT311.StrType)le.can_title),
    InfutorWP_Fields.InValid_can_fname((SALT311.StrType)le.can_fname),
    InfutorWP_Fields.InValid_can_lname((SALT311.StrType)le.can_lname),
    InfutorWP_Fields.InValid_can_suffix((SALT311.StrType)le.can_suffix),
    InfutorWP_Fields.InValid_can_address1((SALT311.StrType)le.can_address1),
    InfutorWP_Fields.InValid_can_house((SALT311.StrType)le.can_house),
    InfutorWP_Fields.InValid_can_predir((SALT311.StrType)le.can_predir),
    InfutorWP_Fields.InValid_can_street((SALT311.StrType)le.can_street),
    InfutorWP_Fields.InValid_can_strtype((SALT311.StrType)le.can_strtype),
    InfutorWP_Fields.InValid_can_postdir((SALT311.StrType)le.can_postdir),
    InfutorWP_Fields.InValid_can_apttype((SALT311.StrType)le.can_apttype),
    InfutorWP_Fields.InValid_can_aptnbr((SALT311.StrType)le.can_aptnbr),
    InfutorWP_Fields.InValid_can_city((SALT311.StrType)le.can_city),
    InfutorWP_Fields.InValid_can_province((SALT311.StrType)le.can_province),
    InfutorWP_Fields.InValid_can_postalcd((SALT311.StrType)le.can_postalcd),
    InfutorWP_Fields.InValid_can_lang((SALT311.StrType)le.can_lang),
    InfutorWP_Fields.InValid_can_rectype((SALT311.StrType)le.can_rectype),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,18,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := InfutorWP_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_phone','invalid_alpha','invalid_alpha','invalid_name','invalid_alpha','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_province','invalid_canadian_zip','Unknown','invalid_record_type');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,InfutorWP_Fields.InValidMessage_can_phone(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_title(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_fname(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_lname(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_suffix(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_address1(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_house(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_predir(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_street(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_strtype(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_postdir(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_apttype(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_aptnbr(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_city(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_province(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_postalcd(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_lang(TotalErrors.ErrorNum),InfutorWP_Fields.InValidMessage_can_rectype(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_CanadianPhones, InfutorWP_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
