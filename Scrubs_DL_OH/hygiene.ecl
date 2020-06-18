IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_In_oh) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_key_number_cnt := COUNT(GROUP,h.key_number <> (TYPEOF(h.key_number))'');
    populated_key_number_pcnt := AVE(GROUP,IF(h.key_number = (TYPEOF(h.key_number))'',0,100));
    maxlength_key_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.key_number)));
    avelength_key_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.key_number)),h.key_number<>(typeof(h.key_number))'');
    populated_license_number_cnt := COUNT(GROUP,h.license_number <> (TYPEOF(h.license_number))'');
    populated_license_number_pcnt := AVE(GROUP,IF(h.license_number = (TYPEOF(h.license_number))'',0,100));
    maxlength_license_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_number)));
    avelength_license_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_number)),h.license_number<>(typeof(h.license_number))'');
    populated_license_class_cnt := COUNT(GROUP,h.license_class <> (TYPEOF(h.license_class))'');
    populated_license_class_pcnt := AVE(GROUP,IF(h.license_class = (TYPEOF(h.license_class))'',0,100));
    maxlength_license_class := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_class)));
    avelength_license_class := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_class)),h.license_class<>(typeof(h.license_class))'');
    populated_donor_flag_cnt := COUNT(GROUP,h.donor_flag <> (TYPEOF(h.donor_flag))'');
    populated_donor_flag_pcnt := AVE(GROUP,IF(h.donor_flag = (TYPEOF(h.donor_flag))'',0,100));
    maxlength_donor_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.donor_flag)));
    avelength_donor_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.donor_flag)),h.donor_flag<>(typeof(h.donor_flag))'');
    populated_hair_color_cnt := COUNT(GROUP,h.hair_color <> (TYPEOF(h.hair_color))'');
    populated_hair_color_pcnt := AVE(GROUP,IF(h.hair_color = (TYPEOF(h.hair_color))'',0,100));
    maxlength_hair_color := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hair_color)));
    avelength_hair_color := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hair_color)),h.hair_color<>(typeof(h.hair_color))'');
    populated_eye_color_cnt := COUNT(GROUP,h.eye_color <> (TYPEOF(h.eye_color))'');
    populated_eye_color_pcnt := AVE(GROUP,IF(h.eye_color = (TYPEOF(h.eye_color))'',0,100));
    maxlength_eye_color := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eye_color)));
    avelength_eye_color := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eye_color)),h.eye_color<>(typeof(h.eye_color))'');
    populated_weight_l_cnt := COUNT(GROUP,h.weight_l <> (TYPEOF(h.weight_l))'');
    populated_weight_l_pcnt := AVE(GROUP,IF(h.weight_l = (TYPEOF(h.weight_l))'',0,100));
    maxlength_weight_l := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.weight_l)));
    avelength_weight_l := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.weight_l)),h.weight_l<>(typeof(h.weight_l))'');
    populated_height_feet_cnt := COUNT(GROUP,h.height_feet <> (TYPEOF(h.height_feet))'');
    populated_height_feet_pcnt := AVE(GROUP,IF(h.height_feet = (TYPEOF(h.height_feet))'',0,100));
    maxlength_height_feet := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.height_feet)));
    avelength_height_feet := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.height_feet)),h.height_feet<>(typeof(h.height_feet))'');
    populated_height_inches_cnt := COUNT(GROUP,h.height_inches <> (TYPEOF(h.height_inches))'');
    populated_height_inches_pcnt := AVE(GROUP,IF(h.height_inches = (TYPEOF(h.height_inches))'',0,100));
    maxlength_height_inches := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.height_inches)));
    avelength_height_inches := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.height_inches)),h.height_inches<>(typeof(h.height_inches))'');
    populated_sex_gender_cnt := COUNT(GROUP,h.sex_gender <> (TYPEOF(h.sex_gender))'');
    populated_sex_gender_pcnt := AVE(GROUP,IF(h.sex_gender = (TYPEOF(h.sex_gender))'',0,100));
    maxlength_sex_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sex_gender)));
    avelength_sex_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sex_gender)),h.sex_gender<>(typeof(h.sex_gender))'');
    populated_permanent_license_issue_date_cnt := COUNT(GROUP,h.permanent_license_issue_date <> (TYPEOF(h.permanent_license_issue_date))'');
    populated_permanent_license_issue_date_pcnt := AVE(GROUP,IF(h.permanent_license_issue_date = (TYPEOF(h.permanent_license_issue_date))'',0,100));
    maxlength_permanent_license_issue_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.permanent_license_issue_date)));
    avelength_permanent_license_issue_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.permanent_license_issue_date)),h.permanent_license_issue_date<>(typeof(h.permanent_license_issue_date))'');
    populated_license_expiration_date_cnt := COUNT(GROUP,h.license_expiration_date <> (TYPEOF(h.license_expiration_date))'');
    populated_license_expiration_date_pcnt := AVE(GROUP,IF(h.license_expiration_date = (TYPEOF(h.license_expiration_date))'',0,100));
    maxlength_license_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_expiration_date)));
    avelength_license_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_expiration_date)),h.license_expiration_date<>(typeof(h.license_expiration_date))'');
    populated_restriction_codes_cnt := COUNT(GROUP,h.restriction_codes <> (TYPEOF(h.restriction_codes))'');
    populated_restriction_codes_pcnt := AVE(GROUP,IF(h.restriction_codes = (TYPEOF(h.restriction_codes))'',0,100));
    maxlength_restriction_codes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.restriction_codes)));
    avelength_restriction_codes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.restriction_codes)),h.restriction_codes<>(typeof(h.restriction_codes))'');
    populated_endorsement_codes_cnt := COUNT(GROUP,h.endorsement_codes <> (TYPEOF(h.endorsement_codes))'');
    populated_endorsement_codes_pcnt := AVE(GROUP,IF(h.endorsement_codes = (TYPEOF(h.endorsement_codes))'',0,100));
    maxlength_endorsement_codes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.endorsement_codes)));
    avelength_endorsement_codes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.endorsement_codes)),h.endorsement_codes<>(typeof(h.endorsement_codes))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_cnt := COUNT(GROUP,h.middle_name <> (TYPEOF(h.middle_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_street_address_cnt := COUNT(GROUP,h.street_address <> (TYPEOF(h.street_address))'');
    populated_street_address_pcnt := AVE(GROUP,IF(h.street_address = (TYPEOF(h.street_address))'',0,100));
    maxlength_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)));
    avelength_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)),h.street_address<>(typeof(h.street_address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_county_number_cnt := COUNT(GROUP,h.county_number <> (TYPEOF(h.county_number))'');
    populated_county_number_pcnt := AVE(GROUP,IF(h.county_number = (TYPEOF(h.county_number))'',0,100));
    maxlength_county_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_number)));
    avelength_county_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_number)),h.county_number<>(typeof(h.county_number))'');
    populated_birth_date_cnt := COUNT(GROUP,h.birth_date <> (TYPEOF(h.birth_date))'');
    populated_birth_date_pcnt := AVE(GROUP,IF(h.birth_date = (TYPEOF(h.birth_date))'',0,100));
    maxlength_birth_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.birth_date)));
    avelength_birth_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.birth_date)),h.birth_date<>(typeof(h.birth_date))'');
    populated_clean_name_prefix_cnt := COUNT(GROUP,h.clean_name_prefix <> (TYPEOF(h.clean_name_prefix))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_fname_cnt := COUNT(GROUP,h.clean_fname <> (TYPEOF(h.clean_fname))'');
    populated_clean_fname_pcnt := AVE(GROUP,IF(h.clean_fname = (TYPEOF(h.clean_fname))'',0,100));
    maxlength_clean_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fname)));
    avelength_clean_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fname)),h.clean_fname<>(typeof(h.clean_fname))'');
    populated_clean_mname_cnt := COUNT(GROUP,h.clean_mname <> (TYPEOF(h.clean_mname))'');
    populated_clean_mname_pcnt := AVE(GROUP,IF(h.clean_mname = (TYPEOF(h.clean_mname))'',0,100));
    maxlength_clean_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_mname)));
    avelength_clean_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_mname)),h.clean_mname<>(typeof(h.clean_mname))'');
    populated_clean_lname_cnt := COUNT(GROUP,h.clean_lname <> (TYPEOF(h.clean_lname))'');
    populated_clean_lname_pcnt := AVE(GROUP,IF(h.clean_lname = (TYPEOF(h.clean_lname))'',0,100));
    maxlength_clean_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_lname)));
    avelength_clean_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_lname)),h.clean_lname<>(typeof(h.clean_lname))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_key_number_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_license_class_pcnt *   0.00 / 100 + T.Populated_donor_flag_pcnt *   0.00 / 100 + T.Populated_hair_color_pcnt *   0.00 / 100 + T.Populated_eye_color_pcnt *   0.00 / 100 + T.Populated_weight_l_pcnt *   0.00 / 100 + T.Populated_height_feet_pcnt *   0.00 / 100 + T.Populated_height_inches_pcnt *   0.00 / 100 + T.Populated_sex_gender_pcnt *   0.00 / 100 + T.Populated_permanent_license_issue_date_pcnt *   0.00 / 100 + T.Populated_license_expiration_date_pcnt *   0.00 / 100 + T.Populated_restriction_codes_pcnt *   0.00 / 100 + T.Populated_endorsement_codes_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_street_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_county_number_pcnt *   0.00 / 100 + T.Populated_birth_date_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_fname_pcnt *   0.00 / 100 + T.Populated_clean_mname_pcnt *   0.00 / 100 + T.Populated_clean_lname_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','key_number','license_number','license_class','donor_flag','hair_color','eye_color','weight_l','height_feet','height_inches','sex_gender','permanent_license_issue_date','license_expiration_date','restriction_codes','endorsement_codes','first_name','middle_name','last_name','street_address','city','state','zip_code','county_number','birth_date','clean_name_prefix','clean_fname','clean_mname','clean_lname');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_key_number_pcnt,le.populated_license_number_pcnt,le.populated_license_class_pcnt,le.populated_donor_flag_pcnt,le.populated_hair_color_pcnt,le.populated_eye_color_pcnt,le.populated_weight_l_pcnt,le.populated_height_feet_pcnt,le.populated_height_inches_pcnt,le.populated_sex_gender_pcnt,le.populated_permanent_license_issue_date_pcnt,le.populated_license_expiration_date_pcnt,le.populated_restriction_codes_pcnt,le.populated_endorsement_codes_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_pcnt,le.populated_street_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_county_number_pcnt,le.populated_birth_date_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_fname_pcnt,le.populated_clean_mname_pcnt,le.populated_clean_lname_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_key_number,le.maxlength_license_number,le.maxlength_license_class,le.maxlength_donor_flag,le.maxlength_hair_color,le.maxlength_eye_color,le.maxlength_weight_l,le.maxlength_height_feet,le.maxlength_height_inches,le.maxlength_sex_gender,le.maxlength_permanent_license_issue_date,le.maxlength_license_expiration_date,le.maxlength_restriction_codes,le.maxlength_endorsement_codes,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name,le.maxlength_street_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_county_number,le.maxlength_birth_date,le.maxlength_clean_name_prefix,le.maxlength_clean_fname,le.maxlength_clean_mname,le.maxlength_clean_lname);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_key_number,le.avelength_license_number,le.avelength_license_class,le.avelength_donor_flag,le.avelength_hair_color,le.avelength_eye_color,le.avelength_weight_l,le.avelength_height_feet,le.avelength_height_inches,le.avelength_sex_gender,le.avelength_permanent_license_issue_date,le.avelength_license_expiration_date,le.avelength_restriction_codes,le.avelength_endorsement_codes,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name,le.avelength_street_address,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_county_number,le.avelength_birth_date,le.avelength_clean_name_prefix,le.avelength_clean_fname,le.avelength_clean_mname,le.avelength_clean_lname);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.key_number),TRIM((SALT311.StrType)le.license_number),TRIM((SALT311.StrType)le.license_class),TRIM((SALT311.StrType)le.donor_flag),TRIM((SALT311.StrType)le.hair_color),TRIM((SALT311.StrType)le.eye_color),TRIM((SALT311.StrType)le.weight_l),TRIM((SALT311.StrType)le.height_feet),TRIM((SALT311.StrType)le.height_inches),TRIM((SALT311.StrType)le.sex_gender),TRIM((SALT311.StrType)le.permanent_license_issue_date),TRIM((SALT311.StrType)le.license_expiration_date),TRIM((SALT311.StrType)le.restriction_codes),TRIM((SALT311.StrType)le.endorsement_codes),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.county_number),TRIM((SALT311.StrType)le.birth_date),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.key_number),TRIM((SALT311.StrType)le.license_number),TRIM((SALT311.StrType)le.license_class),TRIM((SALT311.StrType)le.donor_flag),TRIM((SALT311.StrType)le.hair_color),TRIM((SALT311.StrType)le.eye_color),TRIM((SALT311.StrType)le.weight_l),TRIM((SALT311.StrType)le.height_feet),TRIM((SALT311.StrType)le.height_inches),TRIM((SALT311.StrType)le.sex_gender),TRIM((SALT311.StrType)le.permanent_license_issue_date),TRIM((SALT311.StrType)le.license_expiration_date),TRIM((SALT311.StrType)le.restriction_codes),TRIM((SALT311.StrType)le.endorsement_codes),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.county_number),TRIM((SALT311.StrType)le.birth_date),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.key_number),TRIM((SALT311.StrType)le.license_number),TRIM((SALT311.StrType)le.license_class),TRIM((SALT311.StrType)le.donor_flag),TRIM((SALT311.StrType)le.hair_color),TRIM((SALT311.StrType)le.eye_color),TRIM((SALT311.StrType)le.weight_l),TRIM((SALT311.StrType)le.height_feet),TRIM((SALT311.StrType)le.height_inches),TRIM((SALT311.StrType)le.sex_gender),TRIM((SALT311.StrType)le.permanent_license_issue_date),TRIM((SALT311.StrType)le.license_expiration_date),TRIM((SALT311.StrType)le.restriction_codes),TRIM((SALT311.StrType)le.endorsement_codes),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.county_number),TRIM((SALT311.StrType)le.birth_date),TRIM((SALT311.StrType)le.clean_name_prefix),TRIM((SALT311.StrType)le.clean_fname),TRIM((SALT311.StrType)le.clean_mname),TRIM((SALT311.StrType)le.clean_lname)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'key_number'}
      ,{3,'license_number'}
      ,{4,'license_class'}
      ,{5,'donor_flag'}
      ,{6,'hair_color'}
      ,{7,'eye_color'}
      ,{8,'weight_l'}
      ,{9,'height_feet'}
      ,{10,'height_inches'}
      ,{11,'sex_gender'}
      ,{12,'permanent_license_issue_date'}
      ,{13,'license_expiration_date'}
      ,{14,'restriction_codes'}
      ,{15,'endorsement_codes'}
      ,{16,'first_name'}
      ,{17,'middle_name'}
      ,{18,'last_name'}
      ,{19,'street_address'}
      ,{20,'city'}
      ,{21,'state'}
      ,{22,'zip_code'}
      ,{23,'county_number'}
      ,{24,'birth_date'}
      ,{25,'clean_name_prefix'}
      ,{26,'clean_fname'}
      ,{27,'clean_mname'}
      ,{28,'clean_lname'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_key_number((SALT311.StrType)le.key_number),
    Fields.InValid_license_number((SALT311.StrType)le.license_number),
    Fields.InValid_license_class((SALT311.StrType)le.license_class),
    Fields.InValid_donor_flag((SALT311.StrType)le.donor_flag),
    Fields.InValid_hair_color((SALT311.StrType)le.hair_color),
    Fields.InValid_eye_color((SALT311.StrType)le.eye_color),
    Fields.InValid_weight_l((SALT311.StrType)le.weight_l),
    Fields.InValid_height_feet((SALT311.StrType)le.height_feet,(SALT311.StrType)le.height_inches),
    Fields.InValid_height_inches((SALT311.StrType)le.height_inches),
    Fields.InValid_sex_gender((SALT311.StrType)le.sex_gender),
    Fields.InValid_permanent_license_issue_date((SALT311.StrType)le.permanent_license_issue_date),
    Fields.InValid_license_expiration_date((SALT311.StrType)le.license_expiration_date),
    Fields.InValid_restriction_codes((SALT311.StrType)le.restriction_codes),
    Fields.InValid_endorsement_codes((SALT311.StrType)le.endorsement_codes),
    Fields.InValid_first_name((SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_name,(SALT311.StrType)le.last_name),
    Fields.InValid_middle_name((SALT311.StrType)le.middle_name),
    Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Fields.InValid_street_address((SALT311.StrType)le.street_address),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zip_code((SALT311.StrType)le.zip_code),
    Fields.InValid_county_number((SALT311.StrType)le.county_number),
    Fields.InValid_birth_date((SALT311.StrType)le.birth_date),
    Fields.InValid_clean_name_prefix((SALT311.StrType)le.clean_name_prefix),
    Fields.InValid_clean_fname((SALT311.StrType)le.clean_fname,(SALT311.StrType)le.clean_mname,(SALT311.StrType)le.clean_lname),
    Fields.InValid_clean_mname((SALT311.StrType)le.clean_mname),
    Fields.InValid_clean_lname((SALT311.StrType)le.clean_lname),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,28,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_dl_number_check','invalid_dl_number_check','invalid_license_class','invalid_donor_flag','invalid_hair_color','invalid_eye_color','invalid_wgt','invalid_height','Unknown','invalid_gender','invalid_8pastdate','invalid_8generaldate','invalid_restrictions','invalid_endorsements','invalid_name','Unknown','Unknown','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_numeric','invalid_8pastdate','Unknown','invalid_clean_name','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_key_number(TotalErrors.ErrorNum),Fields.InValidMessage_license_number(TotalErrors.ErrorNum),Fields.InValidMessage_license_class(TotalErrors.ErrorNum),Fields.InValidMessage_donor_flag(TotalErrors.ErrorNum),Fields.InValidMessage_hair_color(TotalErrors.ErrorNum),Fields.InValidMessage_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_weight_l(TotalErrors.ErrorNum),Fields.InValidMessage_height_feet(TotalErrors.ErrorNum),Fields.InValidMessage_height_inches(TotalErrors.ErrorNum),Fields.InValidMessage_sex_gender(TotalErrors.ErrorNum),Fields.InValidMessage_permanent_license_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_license_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_restriction_codes(TotalErrors.ErrorNum),Fields.InValidMessage_endorsement_codes(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_county_number(TotalErrors.ErrorNum),Fields.InValidMessage_birth_date(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_mname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lname(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_OH, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
