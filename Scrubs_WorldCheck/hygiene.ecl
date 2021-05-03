IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_WorldCheck) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_uid_cnt := COUNT(GROUP,h.uid <> (TYPEOF(h.uid))'');
    populated_uid_pcnt := AVE(GROUP,IF(h.uid = (TYPEOF(h.uid))'',0,100));
    maxlength_uid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.uid)));
    avelength_uid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.uid)),h.uid<>(typeof(h.uid))'');
    populated_key_cnt := COUNT(GROUP,h.key <> (TYPEOF(h.key))'');
    populated_key_pcnt := AVE(GROUP,IF(h.key = (TYPEOF(h.key))'',0,100));
    maxlength_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.key)));
    avelength_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.key)),h.key<>(typeof(h.key))'');
    populated_name_orig_cnt := COUNT(GROUP,h.name_orig <> (TYPEOF(h.name_orig))'');
    populated_name_orig_pcnt := AVE(GROUP,IF(h.name_orig = (TYPEOF(h.name_orig))'',0,100));
    maxlength_name_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_orig)));
    avelength_name_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_orig)),h.name_orig<>(typeof(h.name_orig))'');
    populated_name_type_cnt := COUNT(GROUP,h.name_type <> (TYPEOF(h.name_type))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_category_cnt := COUNT(GROUP,h.category <> (TYPEOF(h.category))'');
    populated_category_pcnt := AVE(GROUP,IF(h.category = (TYPEOF(h.category))'',0,100));
    maxlength_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)));
    avelength_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)),h.category<>(typeof(h.category))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_sub_category_cnt := COUNT(GROUP,h.sub_category <> (TYPEOF(h.sub_category))'');
    populated_sub_category_pcnt := AVE(GROUP,IF(h.sub_category = (TYPEOF(h.sub_category))'',0,100));
    maxlength_sub_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_category)));
    avelength_sub_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_category)),h.sub_category<>(typeof(h.sub_category))'');
    populated_position_cnt := COUNT(GROUP,h.position <> (TYPEOF(h.position))'');
    populated_position_pcnt := AVE(GROUP,IF(h.position = (TYPEOF(h.position))'',0,100));
    maxlength_position := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.position)));
    avelength_position := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.position)),h.position<>(typeof(h.position))'');
    populated_age_cnt := COUNT(GROUP,h.age <> (TYPEOF(h.age))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_date_of_birth_cnt := COUNT(GROUP,h.date_of_birth <> (TYPEOF(h.date_of_birth))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_places_of_birth_cnt := COUNT(GROUP,h.places_of_birth <> (TYPEOF(h.places_of_birth))'');
    populated_places_of_birth_pcnt := AVE(GROUP,IF(h.places_of_birth = (TYPEOF(h.places_of_birth))'',0,100));
    maxlength_places_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.places_of_birth)));
    avelength_places_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.places_of_birth)),h.places_of_birth<>(typeof(h.places_of_birth))'');
    populated_date_of_death_cnt := COUNT(GROUP,h.date_of_death <> (TYPEOF(h.date_of_death))'');
    populated_date_of_death_pcnt := AVE(GROUP,IF(h.date_of_death = (TYPEOF(h.date_of_death))'',0,100));
    maxlength_date_of_death := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_death)));
    avelength_date_of_death := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_death)),h.date_of_death<>(typeof(h.date_of_death))'');
    populated_passports_cnt := COUNT(GROUP,h.passports <> (TYPEOF(h.passports))'');
    populated_passports_pcnt := AVE(GROUP,IF(h.passports = (TYPEOF(h.passports))'',0,100));
    maxlength_passports := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.passports)));
    avelength_passports := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.passports)),h.passports<>(typeof(h.passports))'');
    populated_social_security_number_cnt := COUNT(GROUP,h.social_security_number <> (TYPEOF(h.social_security_number))'');
    populated_social_security_number_pcnt := AVE(GROUP,IF(h.social_security_number = (TYPEOF(h.social_security_number))'',0,100));
    maxlength_social_security_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.social_security_number)));
    avelength_social_security_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.social_security_number)),h.social_security_number<>(typeof(h.social_security_number))'');
    populated_location_cnt := COUNT(GROUP,h.location <> (TYPEOF(h.location))'');
    populated_location_pcnt := AVE(GROUP,IF(h.location = (TYPEOF(h.location))'',0,100));
    maxlength_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location)));
    avelength_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location)),h.location<>(typeof(h.location))'');
    populated_countries_cnt := COUNT(GROUP,h.countries <> (TYPEOF(h.countries))'');
    populated_countries_pcnt := AVE(GROUP,IF(h.countries = (TYPEOF(h.countries))'',0,100));
    maxlength_countries := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countries)));
    avelength_countries := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countries)),h.countries<>(typeof(h.countries))'');
    populated_e_i_ind_cnt := COUNT(GROUP,h.e_i_ind <> (TYPEOF(h.e_i_ind))'');
    populated_e_i_ind_pcnt := AVE(GROUP,IF(h.e_i_ind = (TYPEOF(h.e_i_ind))'',0,100));
    maxlength_e_i_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_i_ind)));
    avelength_e_i_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_i_ind)),h.e_i_ind<>(typeof(h.e_i_ind))'');
    populated_keywords_cnt := COUNT(GROUP,h.keywords <> (TYPEOF(h.keywords))'');
    populated_keywords_pcnt := AVE(GROUP,IF(h.keywords = (TYPEOF(h.keywords))'',0,100));
    maxlength_keywords := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.keywords)));
    avelength_keywords := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.keywords)),h.keywords<>(typeof(h.keywords))'');
    populated_entered_cnt := COUNT(GROUP,h.entered <> (TYPEOF(h.entered))'');
    populated_entered_pcnt := AVE(GROUP,IF(h.entered = (TYPEOF(h.entered))'',0,100));
    maxlength_entered := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entered)));
    avelength_entered := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entered)),h.entered<>(typeof(h.entered))'');
    populated_updated_cnt := COUNT(GROUP,h.updated <> (TYPEOF(h.updated))'');
    populated_updated_pcnt := AVE(GROUP,IF(h.updated = (TYPEOF(h.updated))'',0,100));
    maxlength_updated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.updated)));
    avelength_updated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.updated)),h.updated<>(typeof(h.updated))'');
    populated_editor_cnt := COUNT(GROUP,h.editor <> (TYPEOF(h.editor))'');
    populated_editor_pcnt := AVE(GROUP,IF(h.editor = (TYPEOF(h.editor))'',0,100));
    maxlength_editor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.editor)));
    avelength_editor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.editor)),h.editor<>(typeof(h.editor))'');
    populated_age_as_of_date_cnt := COUNT(GROUP,h.age_as_of_date <> (TYPEOF(h.age_as_of_date))'');
    populated_age_as_of_date_pcnt := AVE(GROUP,IF(h.age_as_of_date = (TYPEOF(h.age_as_of_date))'',0,100));
    maxlength_age_as_of_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.age_as_of_date)));
    avelength_age_as_of_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.age_as_of_date)),h.age_as_of_date<>(typeof(h.age_as_of_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_uid_pcnt *   0.00 / 100 + T.Populated_key_pcnt *   0.00 / 100 + T.Populated_name_orig_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_category_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_sub_category_pcnt *   0.00 / 100 + T.Populated_position_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_places_of_birth_pcnt *   0.00 / 100 + T.Populated_date_of_death_pcnt *   0.00 / 100 + T.Populated_passports_pcnt *   0.00 / 100 + T.Populated_social_security_number_pcnt *   0.00 / 100 + T.Populated_location_pcnt *   0.00 / 100 + T.Populated_countries_pcnt *   0.00 / 100 + T.Populated_e_i_ind_pcnt *   0.00 / 100 + T.Populated_keywords_pcnt *   0.00 / 100 + T.Populated_entered_pcnt *   0.00 / 100 + T.Populated_updated_pcnt *   0.00 / 100 + T.Populated_editor_pcnt *   0.00 / 100 + T.Populated_age_as_of_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'uid','key','name_orig','name_type','last_name','first_name','category','title','sub_category','position','age','date_of_birth','places_of_birth','date_of_death','passports','social_security_number','location','countries','e_i_ind','keywords','entered','updated','editor','age_as_of_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_uid_pcnt,le.populated_key_pcnt,le.populated_name_orig_pcnt,le.populated_name_type_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_category_pcnt,le.populated_title_pcnt,le.populated_sub_category_pcnt,le.populated_position_pcnt,le.populated_age_pcnt,le.populated_date_of_birth_pcnt,le.populated_places_of_birth_pcnt,le.populated_date_of_death_pcnt,le.populated_passports_pcnt,le.populated_social_security_number_pcnt,le.populated_location_pcnt,le.populated_countries_pcnt,le.populated_e_i_ind_pcnt,le.populated_keywords_pcnt,le.populated_entered_pcnt,le.populated_updated_pcnt,le.populated_editor_pcnt,le.populated_age_as_of_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_uid,le.maxlength_key,le.maxlength_name_orig,le.maxlength_name_type,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_category,le.maxlength_title,le.maxlength_sub_category,le.maxlength_position,le.maxlength_age,le.maxlength_date_of_birth,le.maxlength_places_of_birth,le.maxlength_date_of_death,le.maxlength_passports,le.maxlength_social_security_number,le.maxlength_location,le.maxlength_countries,le.maxlength_e_i_ind,le.maxlength_keywords,le.maxlength_entered,le.maxlength_updated,le.maxlength_editor,le.maxlength_age_as_of_date);
  SELF.avelength := CHOOSE(C,le.avelength_uid,le.avelength_key,le.avelength_name_orig,le.avelength_name_type,le.avelength_last_name,le.avelength_first_name,le.avelength_category,le.avelength_title,le.avelength_sub_category,le.avelength_position,le.avelength_age,le.avelength_date_of_birth,le.avelength_places_of_birth,le.avelength_date_of_death,le.avelength_passports,le.avelength_social_security_number,le.avelength_location,le.avelength_countries,le.avelength_e_i_ind,le.avelength_keywords,le.avelength_entered,le.avelength_updated,le.avelength_editor,le.avelength_age_as_of_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 24, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.uid),IF (le.key <> 0,TRIM((SALT311.StrType)le.key), ''),TRIM((SALT311.StrType)le.name_orig),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.sub_category),TRIM((SALT311.StrType)le.position),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.places_of_birth),TRIM((SALT311.StrType)le.date_of_death),TRIM((SALT311.StrType)le.passports),TRIM((SALT311.StrType)le.social_security_number),TRIM((SALT311.StrType)le.location),TRIM((SALT311.StrType)le.countries),TRIM((SALT311.StrType)le.e_i_ind),TRIM((SALT311.StrType)le.keywords),TRIM((SALT311.StrType)le.entered),TRIM((SALT311.StrType)le.updated),TRIM((SALT311.StrType)le.editor),TRIM((SALT311.StrType)le.age_as_of_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,24,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 24);
  SELF.FldNo2 := 1 + (C % 24);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.uid),IF (le.key <> 0,TRIM((SALT311.StrType)le.key), ''),TRIM((SALT311.StrType)le.name_orig),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.sub_category),TRIM((SALT311.StrType)le.position),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.places_of_birth),TRIM((SALT311.StrType)le.date_of_death),TRIM((SALT311.StrType)le.passports),TRIM((SALT311.StrType)le.social_security_number),TRIM((SALT311.StrType)le.location),TRIM((SALT311.StrType)le.countries),TRIM((SALT311.StrType)le.e_i_ind),TRIM((SALT311.StrType)le.keywords),TRIM((SALT311.StrType)le.entered),TRIM((SALT311.StrType)le.updated),TRIM((SALT311.StrType)le.editor),TRIM((SALT311.StrType)le.age_as_of_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.uid),IF (le.key <> 0,TRIM((SALT311.StrType)le.key), ''),TRIM((SALT311.StrType)le.name_orig),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.sub_category),TRIM((SALT311.StrType)le.position),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.places_of_birth),TRIM((SALT311.StrType)le.date_of_death),TRIM((SALT311.StrType)le.passports),TRIM((SALT311.StrType)le.social_security_number),TRIM((SALT311.StrType)le.location),TRIM((SALT311.StrType)le.countries),TRIM((SALT311.StrType)le.e_i_ind),TRIM((SALT311.StrType)le.keywords),TRIM((SALT311.StrType)le.entered),TRIM((SALT311.StrType)le.updated),TRIM((SALT311.StrType)le.editor),TRIM((SALT311.StrType)le.age_as_of_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),24*24,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'uid'}
      ,{2,'key'}
      ,{3,'name_orig'}
      ,{4,'name_type'}
      ,{5,'last_name'}
      ,{6,'first_name'}
      ,{7,'category'}
      ,{8,'title'}
      ,{9,'sub_category'}
      ,{10,'position'}
      ,{11,'age'}
      ,{12,'date_of_birth'}
      ,{13,'places_of_birth'}
      ,{14,'date_of_death'}
      ,{15,'passports'}
      ,{16,'social_security_number'}
      ,{17,'location'}
      ,{18,'countries'}
      ,{19,'e_i_ind'}
      ,{20,'keywords'}
      ,{21,'entered'}
      ,{22,'updated'}
      ,{23,'editor'}
      ,{24,'age_as_of_date'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_uid((SALT311.StrType)le.uid),
    Fields.InValid_key((SALT311.StrType)le.key),
    Fields.InValid_name_orig((SALT311.StrType)le.name_orig),
    Fields.InValid_name_type((SALT311.StrType)le.name_type),
    Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Fields.InValid_first_name((SALT311.StrType)le.first_name),
    Fields.InValid_category((SALT311.StrType)le.category),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_sub_category((SALT311.StrType)le.sub_category),
    Fields.InValid_position((SALT311.StrType)le.position),
    Fields.InValid_age((SALT311.StrType)le.age),
    Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth),
    Fields.InValid_places_of_birth((SALT311.StrType)le.places_of_birth),
    Fields.InValid_date_of_death((SALT311.StrType)le.date_of_death),
    Fields.InValid_passports((SALT311.StrType)le.passports),
    Fields.InValid_social_security_number((SALT311.StrType)le.social_security_number),
    Fields.InValid_location((SALT311.StrType)le.location),
    Fields.InValid_countries((SALT311.StrType)le.countries),
    Fields.InValid_e_i_ind((SALT311.StrType)le.e_i_ind),
    Fields.InValid_keywords((SALT311.StrType)le.keywords),
    Fields.InValid_entered((SALT311.StrType)le.entered),
    Fields.InValid_updated((SALT311.StrType)le.updated),
    Fields.InValid_editor((SALT311.StrType)le.editor),
    Fields.InValid_age_as_of_date((SALT311.StrType)le.age_as_of_date),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Unknown','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaCaps','Invalid_AlphaChar','Invalid_No','Invalid_Date','Invalid_AlphaChar','Invalid_Date','Unknown','Invalid_SSN','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Ind','Invalid_Keywords','Invalid_Date','Invalid_Date','Invalid_AlphaChar','Invalid_Date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_uid(TotalErrors.ErrorNum),Fields.InValidMessage_key(TotalErrors.ErrorNum),Fields.InValidMessage_name_orig(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_category(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_sub_category(TotalErrors.ErrorNum),Fields.InValidMessage_position(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_places_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_death(TotalErrors.ErrorNum),Fields.InValidMessage_passports(TotalErrors.ErrorNum),Fields.InValidMessage_social_security_number(TotalErrors.ErrorNum),Fields.InValidMessage_location(TotalErrors.ErrorNum),Fields.InValidMessage_countries(TotalErrors.ErrorNum),Fields.InValidMessage_e_i_ind(TotalErrors.ErrorNum),Fields.InValidMessage_keywords(TotalErrors.ErrorNum),Fields.InValidMessage_entered(TotalErrors.ErrorNum),Fields.InValidMessage_updated(TotalErrors.ErrorNum),Fields.InValidMessage_editor(TotalErrors.ErrorNum),Fields.InValidMessage_age_as_of_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_WorldCheck, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
