IMPORT ut,SALT31;
EXPORT HmsCsr_hygiene(dataset(HmsCsr_layout_HmsCsr) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ln_key_pcnt := AVE(GROUP,IF(h.ln_key = (TYPEOF(h.ln_key))'',0,100));
    maxlength_ln_key := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ln_key)));
    avelength_ln_key := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ln_key)),h.ln_key<>(typeof(h.ln_key))'');
    populated_hms_src_pcnt := AVE(GROUP,IF(h.hms_src = (TYPEOF(h.hms_src))'',0,100));
    maxlength_hms_src := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hms_src)));
    avelength_hms_src := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hms_src)),h.hms_src<>(typeof(h.hms_src))'');
    populated_key_pcnt := AVE(GROUP,IF(h.key = (TYPEOF(h.key))'',0,100));
    maxlength_key := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.key)));
    avelength_key := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.key)),h.key<>(typeof(h.key))'');
    populated_id_pcnt := AVE(GROUP,IF(h.id = (TYPEOF(h.id))'',0,100));
    maxlength_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.id)));
    avelength_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.id)),h.id<>(typeof(h.id))'');
    populated_entityid_pcnt := AVE(GROUP,IF(h.entityid = (TYPEOF(h.entityid))'',0,100));
    maxlength_entityid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.entityid)));
    avelength_entityid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.entityid)),h.entityid<>(typeof(h.entityid))'');
    populated_license_number_pcnt := AVE(GROUP,IF(h.license_number = (TYPEOF(h.license_number))'',0,100));
    maxlength_license_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_number)));
    avelength_license_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_number)),h.license_number<>(typeof(h.license_number))'');
    populated_license_class_type_pcnt := AVE(GROUP,IF(h.license_class_type = (TYPEOF(h.license_class_type))'',0,100));
    maxlength_license_class_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_class_type)));
    avelength_license_class_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_class_type)),h.license_class_type<>(typeof(h.license_class_type))'');
    populated_license_state_pcnt := AVE(GROUP,IF(h.license_state = (TYPEOF(h.license_state))'',0,100));
    maxlength_license_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_state)));
    avelength_license_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_state)),h.license_state<>(typeof(h.license_state))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_issue_date_pcnt := AVE(GROUP,IF(h.issue_date = (TYPEOF(h.issue_date))'',0,100));
    maxlength_issue_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.issue_date)));
    avelength_issue_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.issue_date)),h.issue_date<>(typeof(h.issue_date))'');
    populated_renewal_date_pcnt := AVE(GROUP,IF(h.renewal_date = (TYPEOF(h.renewal_date))'',0,100));
    maxlength_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.renewal_date)));
    avelength_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.renewal_date)),h.renewal_date<>(typeof(h.renewal_date))'');
    populated_expiration_date_pcnt := AVE(GROUP,IF(h.expiration_date = (TYPEOF(h.expiration_date))'',0,100));
    maxlength_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.expiration_date)));
    avelength_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.expiration_date)),h.expiration_date<>(typeof(h.expiration_date))'');
    populated_qualifier1_pcnt := AVE(GROUP,IF(h.qualifier1 = (TYPEOF(h.qualifier1))'',0,100));
    maxlength_qualifier1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier1)));
    avelength_qualifier1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier1)),h.qualifier1<>(typeof(h.qualifier1))'');
    populated_qualifier2_pcnt := AVE(GROUP,IF(h.qualifier2 = (TYPEOF(h.qualifier2))'',0,100));
    maxlength_qualifier2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier2)));
    avelength_qualifier2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier2)),h.qualifier2<>(typeof(h.qualifier2))'');
    populated_qualifier3_pcnt := AVE(GROUP,IF(h.qualifier3 = (TYPEOF(h.qualifier3))'',0,100));
    maxlength_qualifier3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier3)));
    avelength_qualifier3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier3)),h.qualifier3<>(typeof(h.qualifier3))'');
    populated_qualifier4_pcnt := AVE(GROUP,IF(h.qualifier4 = (TYPEOF(h.qualifier4))'',0,100));
    maxlength_qualifier4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier4)));
    avelength_qualifier4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier4)),h.qualifier4<>(typeof(h.qualifier4))'');
    populated_qualifier5_pcnt := AVE(GROUP,IF(h.qualifier5 = (TYPEOF(h.qualifier5))'',0,100));
    maxlength_qualifier5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier5)));
    avelength_qualifier5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.qualifier5)),h.qualifier5<>(typeof(h.qualifier5))'');
    populated_rawclass_pcnt := AVE(GROUP,IF(h.rawclass = (TYPEOF(h.rawclass))'',0,100));
    maxlength_rawclass := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawclass)));
    avelength_rawclass := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawclass)),h.rawclass<>(typeof(h.rawclass))'');
    populated_rawissue_date_pcnt := AVE(GROUP,IF(h.rawissue_date = (TYPEOF(h.rawissue_date))'',0,100));
    maxlength_rawissue_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawissue_date)));
    avelength_rawissue_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawissue_date)),h.rawissue_date<>(typeof(h.rawissue_date))'');
    populated_rawexpiration_date_pcnt := AVE(GROUP,IF(h.rawexpiration_date = (TYPEOF(h.rawexpiration_date))'',0,100));
    maxlength_rawexpiration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawexpiration_date)));
    avelength_rawexpiration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawexpiration_date)),h.rawexpiration_date<>(typeof(h.rawexpiration_date))'');
    populated_rawstatus_pcnt := AVE(GROUP,IF(h.rawstatus = (TYPEOF(h.rawstatus))'',0,100));
    maxlength_rawstatus := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawstatus)));
    avelength_rawstatus := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawstatus)),h.rawstatus<>(typeof(h.rawstatus))'');
    populated_raw_number_pcnt := AVE(GROUP,IF(h.raw_number = (TYPEOF(h.raw_number))'',0,100));
    maxlength_raw_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_number)));
    avelength_raw_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_number)),h.raw_number<>(typeof(h.raw_number))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_prefix_pcnt := AVE(GROUP,IF(h.prefix = (TYPEOF(h.prefix))'',0,100));
    maxlength_prefix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prefix)));
    avelength_prefix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prefix)),h.prefix<>(typeof(h.prefix))'');
    populated_first_pcnt := AVE(GROUP,IF(h.first = (TYPEOF(h.first))'',0,100));
    maxlength_first := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.first)));
    avelength_first := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.first)),h.first<>(typeof(h.first))'');
    populated_middle_pcnt := AVE(GROUP,IF(h.middle = (TYPEOF(h.middle))'',0,100));
    maxlength_middle := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.middle)));
    avelength_middle := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.middle)),h.middle<>(typeof(h.middle))'');
    populated_last_pcnt := AVE(GROUP,IF(h.last = (TYPEOF(h.last))'',0,100));
    maxlength_last := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.last)));
    avelength_last := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.last)),h.last<>(typeof(h.last))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_cred_pcnt := AVE(GROUP,IF(h.cred = (TYPEOF(h.cred))'',0,100));
    maxlength_cred := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cred)));
    avelength_cred := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cred)),h.cred<>(typeof(h.cred))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_dateofbirth_pcnt := AVE(GROUP,IF(h.dateofbirth = (TYPEOF(h.dateofbirth))'',0,100));
    maxlength_dateofbirth := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dateofbirth)));
    avelength_dateofbirth := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dateofbirth)),h.dateofbirth<>(typeof(h.dateofbirth))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_dateofdeath_pcnt := AVE(GROUP,IF(h.dateofdeath = (TYPEOF(h.dateofdeath))'',0,100));
    maxlength_dateofdeath := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dateofdeath)));
    avelength_dateofdeath := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dateofdeath)),h.dateofdeath<>(typeof(h.dateofdeath))'');
    populated_employer_identification_number_pcnt := AVE(GROUP,IF(h.employer_identification_number = (TYPEOF(h.employer_identification_number))'',0,100));
    maxlength_employer_identification_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.employer_identification_number)));
    avelength_employer_identification_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.employer_identification_number)),h.employer_identification_number<>(typeof(h.employer_identification_number))'');
    populated_raw_full_address_pcnt := AVE(GROUP,IF(h.raw_full_address = (TYPEOF(h.raw_full_address))'',0,100));
    maxlength_raw_full_address := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_full_address)));
    avelength_raw_full_address := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_full_address)),h.raw_full_address<>(typeof(h.raw_full_address))'');
    populated_firmname_pcnt := AVE(GROUP,IF(h.firmname = (TYPEOF(h.firmname))'',0,100));
    maxlength_firmname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.firmname)));
    avelength_firmname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.firmname)),h.firmname<>(typeof(h.firmname))'');
    populated_street1_pcnt := AVE(GROUP,IF(h.street1 = (TYPEOF(h.street1))'',0,100));
    maxlength_street1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.street1)));
    avelength_street1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.street1)),h.street1<>(typeof(h.street1))'');
    populated_street2_pcnt := AVE(GROUP,IF(h.street2 = (TYPEOF(h.street2))'',0,100));
    maxlength_street2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.street2)));
    avelength_street2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.street2)),h.street2<>(typeof(h.street2))'');
    populated_street3_pcnt := AVE(GROUP,IF(h.street3 = (TYPEOF(h.street3))'',0,100));
    maxlength_street3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.street3)));
    avelength_street3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.street3)),h.street3<>(typeof(h.street3))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_address_state_pcnt := AVE(GROUP,IF(h.address_state = (TYPEOF(h.address_state))'',0,100));
    maxlength_address_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_state)));
    avelength_address_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_state)),h.address_state<>(typeof(h.address_state))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_county_pcnt := AVE(GROUP,IF(h.orig_county = (TYPEOF(h.orig_county))'',0,100));
    maxlength_orig_county := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orig_county)));
    avelength_orig_county := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orig_county)),h.orig_county<>(typeof(h.orig_county))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_address_type_pcnt := AVE(GROUP,IF(h.address_type = (TYPEOF(h.address_type))'',0,100));
    maxlength_address_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_type)));
    avelength_address_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_type)),h.address_type<>(typeof(h.address_type))'');
    populated_phone1_pcnt := AVE(GROUP,IF(h.phone1 = (TYPEOF(h.phone1))'',0,100));
    maxlength_phone1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone1)));
    avelength_phone1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone1)),h.phone1<>(typeof(h.phone1))'');
    populated_phone2_pcnt := AVE(GROUP,IF(h.phone2 = (TYPEOF(h.phone2))'',0,100));
    maxlength_phone2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone2)));
    avelength_phone2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone2)),h.phone2<>(typeof(h.phone2))'');
    populated_phone3_pcnt := AVE(GROUP,IF(h.phone3 = (TYPEOF(h.phone3))'',0,100));
    maxlength_phone3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone3)));
    avelength_phone3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone3)),h.phone3<>(typeof(h.phone3))'');
    populated_fax1_pcnt := AVE(GROUP,IF(h.fax1 = (TYPEOF(h.fax1))'',0,100));
    maxlength_fax1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax1)));
    avelength_fax1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax1)),h.fax1<>(typeof(h.fax1))'');
    populated_fax2_pcnt := AVE(GROUP,IF(h.fax2 = (TYPEOF(h.fax2))'',0,100));
    maxlength_fax2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax2)));
    avelength_fax2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax2)),h.fax2<>(typeof(h.fax2))'');
    populated_fax3_pcnt := AVE(GROUP,IF(h.fax3 = (TYPEOF(h.fax3))'',0,100));
    maxlength_fax3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax3)));
    avelength_fax3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax3)),h.fax3<>(typeof(h.fax3))'');
    populated_other_phone1_pcnt := AVE(GROUP,IF(h.other_phone1 = (TYPEOF(h.other_phone1))'',0,100));
    maxlength_other_phone1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_phone1)));
    avelength_other_phone1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_phone1)),h.other_phone1<>(typeof(h.other_phone1))'');
    populated_description_pcnt := AVE(GROUP,IF(h.description = (TYPEOF(h.description))'',0,100));
    maxlength_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.description)));
    avelength_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.description)),h.description<>(typeof(h.description))'');
    populated_specialty_class_type_pcnt := AVE(GROUP,IF(h.specialty_class_type = (TYPEOF(h.specialty_class_type))'',0,100));
    maxlength_specialty_class_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialty_class_type)));
    avelength_specialty_class_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialty_class_type)),h.specialty_class_type<>(typeof(h.specialty_class_type))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_language_pcnt := AVE(GROUP,IF(h.language = (TYPEOF(h.language))'',0,100));
    maxlength_language := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.language)));
    avelength_language := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.language)),h.language<>(typeof(h.language))'');
    populated_degree_pcnt := AVE(GROUP,IF(h.degree = (TYPEOF(h.degree))'',0,100));
    maxlength_degree := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.degree)));
    avelength_degree := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.degree)),h.degree<>(typeof(h.degree))'');
    populated_graduated_pcnt := AVE(GROUP,IF(h.graduated = (TYPEOF(h.graduated))'',0,100));
    maxlength_graduated := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.graduated)));
    avelength_graduated := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.graduated)),h.graduated<>(typeof(h.graduated))'');
    populated_school_pcnt := AVE(GROUP,IF(h.school = (TYPEOF(h.school))'',0,100));
    maxlength_school := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.school)));
    avelength_school := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.school)),h.school<>(typeof(h.school))'');
    populated_location_pcnt := AVE(GROUP,IF(h.location = (TYPEOF(h.location))'',0,100));
    maxlength_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.location)));
    avelength_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.location)),h.location<>(typeof(h.location))'');
    populated_fine_pcnt := AVE(GROUP,IF(h.fine = (TYPEOF(h.fine))'',0,100));
    maxlength_fine := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fine)));
    avelength_fine := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fine)),h.fine<>(typeof(h.fine))'');
    populated_board_pcnt := AVE(GROUP,IF(h.board = (TYPEOF(h.board))'',0,100));
    maxlength_board := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.board)));
    avelength_board := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.board)),h.board<>(typeof(h.board))'');
    populated_offense_pcnt := AVE(GROUP,IF(h.offense = (TYPEOF(h.offense))'',0,100));
    maxlength_offense := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense)));
    avelength_offense := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense)),h.offense<>(typeof(h.offense))'');
    populated_offense_date_pcnt := AVE(GROUP,IF(h.offense_date = (TYPEOF(h.offense_date))'',0,100));
    maxlength_offense_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_date)));
    avelength_offense_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_date)),h.offense_date<>(typeof(h.offense_date))'');
    populated_action_pcnt := AVE(GROUP,IF(h.action = (TYPEOF(h.action))'',0,100));
    maxlength_action := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action)));
    avelength_action := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action)),h.action<>(typeof(h.action))'');
    populated_action_date_pcnt := AVE(GROUP,IF(h.action_date = (TYPEOF(h.action_date))'',0,100));
    maxlength_action_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_date)));
    avelength_action_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_date)),h.action_date<>(typeof(h.action_date))'');
    populated_action_start_pcnt := AVE(GROUP,IF(h.action_start = (TYPEOF(h.action_start))'',0,100));
    maxlength_action_start := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_start)));
    avelength_action_start := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_start)),h.action_start<>(typeof(h.action_start))'');
    populated_action_end_pcnt := AVE(GROUP,IF(h.action_end = (TYPEOF(h.action_end))'',0,100));
    maxlength_action_end := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_end)));
    avelength_action_end := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_end)),h.action_end<>(typeof(h.action_end))'');
    populated_npi_number_pcnt := AVE(GROUP,IF(h.npi_number = (TYPEOF(h.npi_number))'',0,100));
    maxlength_npi_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_number)));
    avelength_npi_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_number)),h.npi_number<>(typeof(h.npi_number))'');
    populated_replacement_number_pcnt := AVE(GROUP,IF(h.replacement_number = (TYPEOF(h.replacement_number))'',0,100));
    maxlength_replacement_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.replacement_number)));
    avelength_replacement_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.replacement_number)),h.replacement_number<>(typeof(h.replacement_number))'');
    populated_enumeration_date_pcnt := AVE(GROUP,IF(h.enumeration_date = (TYPEOF(h.enumeration_date))'',0,100));
    maxlength_enumeration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.enumeration_date)));
    avelength_enumeration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.enumeration_date)),h.enumeration_date<>(typeof(h.enumeration_date))'');
    populated_last_update_date_pcnt := AVE(GROUP,IF(h.last_update_date = (TYPEOF(h.last_update_date))'',0,100));
    maxlength_last_update_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.last_update_date)));
    avelength_last_update_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.last_update_date)),h.last_update_date<>(typeof(h.last_update_date))'');
    populated_deactivation_date_pcnt := AVE(GROUP,IF(h.deactivation_date = (TYPEOF(h.deactivation_date))'',0,100));
    maxlength_deactivation_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.deactivation_date)));
    avelength_deactivation_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.deactivation_date)),h.deactivation_date<>(typeof(h.deactivation_date))'');
    populated_reactivation_date_pcnt := AVE(GROUP,IF(h.reactivation_date = (TYPEOF(h.reactivation_date))'',0,100));
    maxlength_reactivation_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.reactivation_date)));
    avelength_reactivation_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.reactivation_date)),h.reactivation_date<>(typeof(h.reactivation_date))'');
    populated_deactivation_reason_pcnt := AVE(GROUP,IF(h.deactivation_reason = (TYPEOF(h.deactivation_reason))'',0,100));
    maxlength_deactivation_reason := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.deactivation_reason)));
    avelength_deactivation_reason := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.deactivation_reason)),h.deactivation_reason<>(typeof(h.deactivation_reason))'');
    populated_csr_number_pcnt := AVE(GROUP,IF(h.csr_number = (TYPEOF(h.csr_number))'',0,100));
    maxlength_csr_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_number)));
    avelength_csr_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_number)),h.csr_number<>(typeof(h.csr_number))'');
    populated_credential_type_pcnt := AVE(GROUP,IF(h.credential_type = (TYPEOF(h.credential_type))'',0,100));
    maxlength_credential_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.credential_type)));
    avelength_credential_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.credential_type)),h.credential_type<>(typeof(h.credential_type))'');
    populated_csr_status_pcnt := AVE(GROUP,IF(h.csr_status = (TYPEOF(h.csr_status))'',0,100));
    maxlength_csr_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_status)));
    avelength_csr_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_status)),h.csr_status<>(typeof(h.csr_status))'');
    populated_sub_status_pcnt := AVE(GROUP,IF(h.sub_status = (TYPEOF(h.sub_status))'',0,100));
    maxlength_sub_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sub_status)));
    avelength_sub_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sub_status)),h.sub_status<>(typeof(h.sub_status))'');
    populated_csr_state_pcnt := AVE(GROUP,IF(h.csr_state = (TYPEOF(h.csr_state))'',0,100));
    maxlength_csr_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_state)));
    avelength_csr_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_state)),h.csr_state<>(typeof(h.csr_state))'');
    populated_csr_issue_date_pcnt := AVE(GROUP,IF(h.csr_issue_date = (TYPEOF(h.csr_issue_date))'',0,100));
    maxlength_csr_issue_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_issue_date)));
    avelength_csr_issue_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_issue_date)),h.csr_issue_date<>(typeof(h.csr_issue_date))'');
    populated_effective_date_pcnt := AVE(GROUP,IF(h.effective_date = (TYPEOF(h.effective_date))'',0,100));
    maxlength_effective_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.effective_date)));
    avelength_effective_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.effective_date)),h.effective_date<>(typeof(h.effective_date))'');
    populated_csr_expiration_date_pcnt := AVE(GROUP,IF(h.csr_expiration_date = (TYPEOF(h.csr_expiration_date))'',0,100));
    maxlength_csr_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_expiration_date)));
    avelength_csr_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_expiration_date)),h.csr_expiration_date<>(typeof(h.csr_expiration_date))'');
    populated_discipline_pcnt := AVE(GROUP,IF(h.discipline = (TYPEOF(h.discipline))'',0,100));
    maxlength_discipline := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.discipline)));
    avelength_discipline := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.discipline)),h.discipline<>(typeof(h.discipline))'');
    populated_all_schedules_pcnt := AVE(GROUP,IF(h.all_schedules = (TYPEOF(h.all_schedules))'',0,100));
    maxlength_all_schedules := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.all_schedules)));
    avelength_all_schedules := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.all_schedules)),h.all_schedules<>(typeof(h.all_schedules))'');
    populated_schedule_1_pcnt := AVE(GROUP,IF(h.schedule_1 = (TYPEOF(h.schedule_1))'',0,100));
    maxlength_schedule_1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_1)));
    avelength_schedule_1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_1)),h.schedule_1<>(typeof(h.schedule_1))'');
    populated_schedule_2_pcnt := AVE(GROUP,IF(h.schedule_2 = (TYPEOF(h.schedule_2))'',0,100));
    maxlength_schedule_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_2)));
    avelength_schedule_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_2)),h.schedule_2<>(typeof(h.schedule_2))'');
    populated_schedule_2n_pcnt := AVE(GROUP,IF(h.schedule_2n = (TYPEOF(h.schedule_2n))'',0,100));
    maxlength_schedule_2n := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_2n)));
    avelength_schedule_2n := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_2n)),h.schedule_2n<>(typeof(h.schedule_2n))'');
    populated_schedule_3_pcnt := AVE(GROUP,IF(h.schedule_3 = (TYPEOF(h.schedule_3))'',0,100));
    maxlength_schedule_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_3)));
    avelength_schedule_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_3)),h.schedule_3<>(typeof(h.schedule_3))'');
    populated_schedule_3n_pcnt := AVE(GROUP,IF(h.schedule_3n = (TYPEOF(h.schedule_3n))'',0,100));
    maxlength_schedule_3n := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_3n)));
    avelength_schedule_3n := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_3n)),h.schedule_3n<>(typeof(h.schedule_3n))'');
    populated_schedule_4_pcnt := AVE(GROUP,IF(h.schedule_4 = (TYPEOF(h.schedule_4))'',0,100));
    maxlength_schedule_4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_4)));
    avelength_schedule_4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_4)),h.schedule_4<>(typeof(h.schedule_4))'');
    populated_schedule_5_pcnt := AVE(GROUP,IF(h.schedule_5 = (TYPEOF(h.schedule_5))'',0,100));
    maxlength_schedule_5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_5)));
    avelength_schedule_5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_5)),h.schedule_5<>(typeof(h.schedule_5))'');
    populated_schedule_6_pcnt := AVE(GROUP,IF(h.schedule_6 = (TYPEOF(h.schedule_6))'',0,100));
    maxlength_schedule_6 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_6)));
    avelength_schedule_6 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedule_6)),h.schedule_6<>(typeof(h.schedule_6))'');
    populated_raw_status_pcnt := AVE(GROUP,IF(h.raw_status = (TYPEOF(h.raw_status))'',0,100));
    maxlength_raw_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_status)));
    avelength_raw_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_status)),h.raw_status<>(typeof(h.raw_status))'');
    populated_raw_sub_status1_pcnt := AVE(GROUP,IF(h.raw_sub_status1 = (TYPEOF(h.raw_sub_status1))'',0,100));
    maxlength_raw_sub_status1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_sub_status1)));
    avelength_raw_sub_status1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_sub_status1)),h.raw_sub_status1<>(typeof(h.raw_sub_status1))'');
    populated_raw_sub_status2_pcnt := AVE(GROUP,IF(h.raw_sub_status2 = (TYPEOF(h.raw_sub_status2))'',0,100));
    maxlength_raw_sub_status2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_sub_status2)));
    avelength_raw_sub_status2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.raw_sub_status2)),h.raw_sub_status2<>(typeof(h.raw_sub_status2))'');
    populated_dea_number_pcnt := AVE(GROUP,IF(h.dea_number = (TYPEOF(h.dea_number))'',0,100));
    maxlength_dea_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_number)));
    avelength_dea_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_number)),h.dea_number<>(typeof(h.dea_number))'');
    populated_schedules_pcnt := AVE(GROUP,IF(h.schedules = (TYPEOF(h.schedules))'',0,100));
    maxlength_schedules := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedules)));
    avelength_schedules := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.schedules)),h.schedules<>(typeof(h.schedules))'');
    populated_dea_expiration_date_pcnt := AVE(GROUP,IF(h.dea_expiration_date = (TYPEOF(h.dea_expiration_date))'',0,100));
    maxlength_dea_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_expiration_date)));
    avelength_dea_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_expiration_date)),h.dea_expiration_date<>(typeof(h.dea_expiration_date))'');
    populated_activity_pcnt := AVE(GROUP,IF(h.activity = (TYPEOF(h.activity))'',0,100));
    maxlength_activity := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.activity)));
    avelength_activity := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.activity)),h.activity<>(typeof(h.activity))'');
    populated_bac_pcnt := AVE(GROUP,IF(h.bac = (TYPEOF(h.bac))'',0,100));
    maxlength_bac := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bac)));
    avelength_bac := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bac)),h.bac<>(typeof(h.bac))'');
    populated_bac_subcode_pcnt := AVE(GROUP,IF(h.bac_subcode = (TYPEOF(h.bac_subcode))'',0,100));
    maxlength_bac_subcode := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bac_subcode)));
    avelength_bac_subcode := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bac_subcode)),h.bac_subcode<>(typeof(h.bac_subcode))'');
    populated_payment_pcnt := AVE(GROUP,IF(h.payment = (TYPEOF(h.payment))'',0,100));
    maxlength_payment := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.payment)));
    avelength_payment := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.payment)),h.payment<>(typeof(h.payment))'');
    populated_medicaid_number_pcnt := AVE(GROUP,IF(h.medicaid_number = (TYPEOF(h.medicaid_number))'',0,100));
    maxlength_medicaid_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaid_number)));
    avelength_medicaid_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaid_number)),h.medicaid_number<>(typeof(h.medicaid_number))'');
    populated_medicaid_status_pcnt := AVE(GROUP,IF(h.medicaid_status = (TYPEOF(h.medicaid_status))'',0,100));
    maxlength_medicaid_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaid_status)));
    avelength_medicaid_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaid_status)),h.medicaid_status<>(typeof(h.medicaid_status))'');
    populated_medicaid_state_pcnt := AVE(GROUP,IF(h.medicaid_state = (TYPEOF(h.medicaid_state))'',0,100));
    maxlength_medicaid_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaid_state)));
    avelength_medicaid_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaid_state)),h.medicaid_state<>(typeof(h.medicaid_state))'');
    populated_participation_flag_pcnt := AVE(GROUP,IF(h.participation_flag = (TYPEOF(h.participation_flag))'',0,100));
    maxlength_participation_flag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.participation_flag)));
    avelength_participation_flag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.participation_flag)),h.participation_flag<>(typeof(h.participation_flag))'');
    populated_taxonomy_npi_number_pcnt := AVE(GROUP,IF(h.taxonomy_npi_number = (TYPEOF(h.taxonomy_npi_number))'',0,100));
    maxlength_taxonomy_npi_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_npi_number)));
    avelength_taxonomy_npi_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_npi_number)),h.taxonomy_npi_number<>(typeof(h.taxonomy_npi_number))'');
    populated_taxonomy_code_pcnt := AVE(GROUP,IF(h.taxonomy_code = (TYPEOF(h.taxonomy_code))'',0,100));
    maxlength_taxonomy_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_code)));
    avelength_taxonomy_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_code)),h.taxonomy_code<>(typeof(h.taxonomy_code))'');
    populated_taxonomy_order_number_pcnt := AVE(GROUP,IF(h.taxonomy_order_number = (TYPEOF(h.taxonomy_order_number))'',0,100));
    maxlength_taxonomy_order_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_order_number)));
    avelength_taxonomy_order_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_order_number)),h.taxonomy_order_number<>(typeof(h.taxonomy_order_number))'');
    populated_license_number_state_code_pcnt := AVE(GROUP,IF(h.license_number_state_code = (TYPEOF(h.license_number_state_code))'',0,100));
    maxlength_license_number_state_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_number_state_code)));
    avelength_license_number_state_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.license_number_state_code)),h.license_number_state_code<>(typeof(h.license_number_state_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ln_key_pcnt *   0.00 / 100 + T.Populated_hms_src_pcnt *   0.00 / 100 + T.Populated_key_pcnt *   0.00 / 100 + T.Populated_id_pcnt *   0.00 / 100 + T.Populated_entityid_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_license_class_type_pcnt *   0.00 / 100 + T.Populated_license_state_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_issue_date_pcnt *   0.00 / 100 + T.Populated_renewal_date_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_qualifier1_pcnt *   0.00 / 100 + T.Populated_qualifier2_pcnt *   0.00 / 100 + T.Populated_qualifier3_pcnt *   0.00 / 100 + T.Populated_qualifier4_pcnt *   0.00 / 100 + T.Populated_qualifier5_pcnt *   0.00 / 100 + T.Populated_rawclass_pcnt *   0.00 / 100 + T.Populated_rawissue_date_pcnt *   0.00 / 100 + T.Populated_rawexpiration_date_pcnt *   0.00 / 100 + T.Populated_rawstatus_pcnt *   0.00 / 100 + T.Populated_raw_number_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_prefix_pcnt *   0.00 / 100 + T.Populated_first_pcnt *   0.00 / 100 + T.Populated_middle_pcnt *   0.00 / 100 + T.Populated_last_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_cred_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_dateofbirth_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_dateofdeath_pcnt *   0.00 / 100 + T.Populated_employer_identification_number_pcnt *   0.00 / 100 + T.Populated_raw_full_address_pcnt *   0.00 / 100 + T.Populated_firmname_pcnt *   0.00 / 100 + T.Populated_street1_pcnt *   0.00 / 100 + T.Populated_street2_pcnt *   0.00 / 100 + T.Populated_street3_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_address_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_phone1_pcnt *   0.00 / 100 + T.Populated_phone2_pcnt *   0.00 / 100 + T.Populated_phone3_pcnt *   0.00 / 100 + T.Populated_fax1_pcnt *   0.00 / 100 + T.Populated_fax2_pcnt *   0.00 / 100 + T.Populated_fax3_pcnt *   0.00 / 100 + T.Populated_other_phone1_pcnt *   0.00 / 100 + T.Populated_description_pcnt *   0.00 / 100 + T.Populated_specialty_class_type_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_language_pcnt *   0.00 / 100 + T.Populated_degree_pcnt *   0.00 / 100 + T.Populated_graduated_pcnt *   0.00 / 100 + T.Populated_school_pcnt *   0.00 / 100 + T.Populated_location_pcnt *   0.00 / 100 + T.Populated_fine_pcnt *   0.00 / 100 + T.Populated_board_pcnt *   0.00 / 100 + T.Populated_offense_pcnt *   0.00 / 100 + T.Populated_offense_date_pcnt *   0.00 / 100 + T.Populated_action_pcnt *   0.00 / 100 + T.Populated_action_date_pcnt *   0.00 / 100 + T.Populated_action_start_pcnt *   0.00 / 100 + T.Populated_action_end_pcnt *   0.00 / 100 + T.Populated_npi_number_pcnt *   0.00 / 100 + T.Populated_replacement_number_pcnt *   0.00 / 100 + T.Populated_enumeration_date_pcnt *   0.00 / 100 + T.Populated_last_update_date_pcnt *   0.00 / 100 + T.Populated_deactivation_date_pcnt *   0.00 / 100 + T.Populated_reactivation_date_pcnt *   0.00 / 100 + T.Populated_deactivation_reason_pcnt *   0.00 / 100 + T.Populated_csr_number_pcnt *   0.00 / 100 + T.Populated_credential_type_pcnt *   0.00 / 100 + T.Populated_csr_status_pcnt *   0.00 / 100 + T.Populated_sub_status_pcnt *   0.00 / 100 + T.Populated_csr_state_pcnt *   0.00 / 100 + T.Populated_csr_issue_date_pcnt *   0.00 / 100 + T.Populated_effective_date_pcnt *   0.00 / 100 + T.Populated_csr_expiration_date_pcnt *   0.00 / 100 + T.Populated_discipline_pcnt *   0.00 / 100 + T.Populated_all_schedules_pcnt *   0.00 / 100 + T.Populated_schedule_1_pcnt *   0.00 / 100 + T.Populated_schedule_2_pcnt *   0.00 / 100 + T.Populated_schedule_2n_pcnt *   0.00 / 100 + T.Populated_schedule_3_pcnt *   0.00 / 100 + T.Populated_schedule_3n_pcnt *   0.00 / 100 + T.Populated_schedule_4_pcnt *   0.00 / 100 + T.Populated_schedule_5_pcnt *   0.00 / 100 + T.Populated_schedule_6_pcnt *   0.00 / 100 + T.Populated_raw_status_pcnt *   0.00 / 100 + T.Populated_raw_sub_status1_pcnt *   0.00 / 100 + T.Populated_raw_sub_status2_pcnt *   0.00 / 100 + T.Populated_dea_number_pcnt *   0.00 / 100 + T.Populated_schedules_pcnt *   0.00 / 100 + T.Populated_dea_expiration_date_pcnt *   0.00 / 100 + T.Populated_activity_pcnt *   0.00 / 100 + T.Populated_bac_pcnt *   0.00 / 100 + T.Populated_bac_subcode_pcnt *   0.00 / 100 + T.Populated_payment_pcnt *   0.00 / 100 + T.Populated_medicaid_number_pcnt *   0.00 / 100 + T.Populated_medicaid_status_pcnt *   0.00 / 100 + T.Populated_medicaid_state_pcnt *   0.00 / 100 + T.Populated_participation_flag_pcnt *   0.00 / 100 + T.Populated_taxonomy_npi_number_pcnt *   0.00 / 100 + T.Populated_taxonomy_code_pcnt *   0.00 / 100 + T.Populated_taxonomy_order_number_pcnt *   0.00 / 100 + T.Populated_license_number_state_code_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','renewal_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','prefix','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','employer_identification_number','raw_full_address','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','degree','graduated','school','location','fine','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','replacement_number','enumeration_date','last_update_date','deactivation_date','reactivation_date','deactivation_reason','csr_number','credential_type','csr_status','sub_status','csr_state','csr_issue_date','effective_date','csr_expiration_date','discipline','all_schedules','schedule_1','schedule_2','schedule_2n','schedule_3','schedule_3n','schedule_4','schedule_5','schedule_6','raw_status','raw_sub_status1','raw_sub_status2','dea_number','schedules','dea_expiration_date','activity','bac','bac_subcode','payment','medicaid_number','medicaid_status','medicaid_state','participation_flag','taxonomy_npi_number','taxonomy_code','taxonomy_order_number','license_number_state_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ln_key_pcnt,le.populated_hms_src_pcnt,le.populated_key_pcnt,le.populated_id_pcnt,le.populated_entityid_pcnt,le.populated_license_number_pcnt,le.populated_license_class_type_pcnt,le.populated_license_state_pcnt,le.populated_status_pcnt,le.populated_issue_date_pcnt,le.populated_renewal_date_pcnt,le.populated_expiration_date_pcnt,le.populated_qualifier1_pcnt,le.populated_qualifier2_pcnt,le.populated_qualifier3_pcnt,le.populated_qualifier4_pcnt,le.populated_qualifier5_pcnt,le.populated_rawclass_pcnt,le.populated_rawissue_date_pcnt,le.populated_rawexpiration_date_pcnt,le.populated_rawstatus_pcnt,le.populated_raw_number_pcnt,le.populated_name_pcnt,le.populated_prefix_pcnt,le.populated_first_pcnt,le.populated_middle_pcnt,le.populated_last_pcnt,le.populated_suffix_pcnt,le.populated_cred_pcnt,le.populated_age_pcnt,le.populated_dateofbirth_pcnt,le.populated_email_pcnt,le.populated_gender_pcnt,le.populated_dateofdeath_pcnt,le.populated_employer_identification_number_pcnt,le.populated_raw_full_address_pcnt,le.populated_firmname_pcnt,le.populated_street1_pcnt,le.populated_street2_pcnt,le.populated_street3_pcnt,le.populated_city_pcnt,le.populated_address_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_county_pcnt,le.populated_country_pcnt,le.populated_address_type_pcnt,le.populated_phone1_pcnt,le.populated_phone2_pcnt,le.populated_phone3_pcnt,le.populated_fax1_pcnt,le.populated_fax2_pcnt,le.populated_fax3_pcnt,le.populated_other_phone1_pcnt,le.populated_description_pcnt,le.populated_specialty_class_type_pcnt,le.populated_phone_number_pcnt,le.populated_phone_type_pcnt,le.populated_language_pcnt,le.populated_degree_pcnt,le.populated_graduated_pcnt,le.populated_school_pcnt,le.populated_location_pcnt,le.populated_fine_pcnt,le.populated_board_pcnt,le.populated_offense_pcnt,le.populated_offense_date_pcnt,le.populated_action_pcnt,le.populated_action_date_pcnt,le.populated_action_start_pcnt,le.populated_action_end_pcnt,le.populated_npi_number_pcnt,le.populated_replacement_number_pcnt,le.populated_enumeration_date_pcnt,le.populated_last_update_date_pcnt,le.populated_deactivation_date_pcnt,le.populated_reactivation_date_pcnt,le.populated_deactivation_reason_pcnt,le.populated_csr_number_pcnt,le.populated_credential_type_pcnt,le.populated_csr_status_pcnt,le.populated_sub_status_pcnt,le.populated_csr_state_pcnt,le.populated_csr_issue_date_pcnt,le.populated_effective_date_pcnt,le.populated_csr_expiration_date_pcnt,le.populated_discipline_pcnt,le.populated_all_schedules_pcnt,le.populated_schedule_1_pcnt,le.populated_schedule_2_pcnt,le.populated_schedule_2n_pcnt,le.populated_schedule_3_pcnt,le.populated_schedule_3n_pcnt,le.populated_schedule_4_pcnt,le.populated_schedule_5_pcnt,le.populated_schedule_6_pcnt,le.populated_raw_status_pcnt,le.populated_raw_sub_status1_pcnt,le.populated_raw_sub_status2_pcnt,le.populated_dea_number_pcnt,le.populated_schedules_pcnt,le.populated_dea_expiration_date_pcnt,le.populated_activity_pcnt,le.populated_bac_pcnt,le.populated_bac_subcode_pcnt,le.populated_payment_pcnt,le.populated_medicaid_number_pcnt,le.populated_medicaid_status_pcnt,le.populated_medicaid_state_pcnt,le.populated_participation_flag_pcnt,le.populated_taxonomy_npi_number_pcnt,le.populated_taxonomy_code_pcnt,le.populated_taxonomy_order_number_pcnt,le.populated_license_number_state_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ln_key,le.maxlength_hms_src,le.maxlength_key,le.maxlength_id,le.maxlength_entityid,le.maxlength_license_number,le.maxlength_license_class_type,le.maxlength_license_state,le.maxlength_status,le.maxlength_issue_date,le.maxlength_renewal_date,le.maxlength_expiration_date,le.maxlength_qualifier1,le.maxlength_qualifier2,le.maxlength_qualifier3,le.maxlength_qualifier4,le.maxlength_qualifier5,le.maxlength_rawclass,le.maxlength_rawissue_date,le.maxlength_rawexpiration_date,le.maxlength_rawstatus,le.maxlength_raw_number,le.maxlength_name,le.maxlength_prefix,le.maxlength_first,le.maxlength_middle,le.maxlength_last,le.maxlength_suffix,le.maxlength_cred,le.maxlength_age,le.maxlength_dateofbirth,le.maxlength_email,le.maxlength_gender,le.maxlength_dateofdeath,le.maxlength_employer_identification_number,le.maxlength_raw_full_address,le.maxlength_firmname,le.maxlength_street1,le.maxlength_street2,le.maxlength_street3,le.maxlength_city,le.maxlength_address_state,le.maxlength_orig_zip,le.maxlength_orig_county,le.maxlength_country,le.maxlength_address_type,le.maxlength_phone1,le.maxlength_phone2,le.maxlength_phone3,le.maxlength_fax1,le.maxlength_fax2,le.maxlength_fax3,le.maxlength_other_phone1,le.maxlength_description,le.maxlength_specialty_class_type,le.maxlength_phone_number,le.maxlength_phone_type,le.maxlength_language,le.maxlength_degree,le.maxlength_graduated,le.maxlength_school,le.maxlength_location,le.maxlength_fine,le.maxlength_board,le.maxlength_offense,le.maxlength_offense_date,le.maxlength_action,le.maxlength_action_date,le.maxlength_action_start,le.maxlength_action_end,le.maxlength_npi_number,le.maxlength_replacement_number,le.maxlength_enumeration_date,le.maxlength_last_update_date,le.maxlength_deactivation_date,le.maxlength_reactivation_date,le.maxlength_deactivation_reason,le.maxlength_csr_number,le.maxlength_credential_type,le.maxlength_csr_status,le.maxlength_sub_status,le.maxlength_csr_state,le.maxlength_csr_issue_date,le.maxlength_effective_date,le.maxlength_csr_expiration_date,le.maxlength_discipline,le.maxlength_all_schedules,le.maxlength_schedule_1,le.maxlength_schedule_2,le.maxlength_schedule_2n,le.maxlength_schedule_3,le.maxlength_schedule_3n,le.maxlength_schedule_4,le.maxlength_schedule_5,le.maxlength_schedule_6,le.maxlength_raw_status,le.maxlength_raw_sub_status1,le.maxlength_raw_sub_status2,le.maxlength_dea_number,le.maxlength_schedules,le.maxlength_dea_expiration_date,le.maxlength_activity,le.maxlength_bac,le.maxlength_bac_subcode,le.maxlength_payment,le.maxlength_medicaid_number,le.maxlength_medicaid_status,le.maxlength_medicaid_state,le.maxlength_participation_flag,le.maxlength_taxonomy_npi_number,le.maxlength_taxonomy_code,le.maxlength_taxonomy_order_number,le.maxlength_license_number_state_code);
  SELF.avelength := CHOOSE(C,le.avelength_ln_key,le.avelength_hms_src,le.avelength_key,le.avelength_id,le.avelength_entityid,le.avelength_license_number,le.avelength_license_class_type,le.avelength_license_state,le.avelength_status,le.avelength_issue_date,le.avelength_renewal_date,le.avelength_expiration_date,le.avelength_qualifier1,le.avelength_qualifier2,le.avelength_qualifier3,le.avelength_qualifier4,le.avelength_qualifier5,le.avelength_rawclass,le.avelength_rawissue_date,le.avelength_rawexpiration_date,le.avelength_rawstatus,le.avelength_raw_number,le.avelength_name,le.avelength_prefix,le.avelength_first,le.avelength_middle,le.avelength_last,le.avelength_suffix,le.avelength_cred,le.avelength_age,le.avelength_dateofbirth,le.avelength_email,le.avelength_gender,le.avelength_dateofdeath,le.avelength_employer_identification_number,le.avelength_raw_full_address,le.avelength_firmname,le.avelength_street1,le.avelength_street2,le.avelength_street3,le.avelength_city,le.avelength_address_state,le.avelength_orig_zip,le.avelength_orig_county,le.avelength_country,le.avelength_address_type,le.avelength_phone1,le.avelength_phone2,le.avelength_phone3,le.avelength_fax1,le.avelength_fax2,le.avelength_fax3,le.avelength_other_phone1,le.avelength_description,le.avelength_specialty_class_type,le.avelength_phone_number,le.avelength_phone_type,le.avelength_language,le.avelength_degree,le.avelength_graduated,le.avelength_school,le.avelength_location,le.avelength_fine,le.avelength_board,le.avelength_offense,le.avelength_offense_date,le.avelength_action,le.avelength_action_date,le.avelength_action_start,le.avelength_action_end,le.avelength_npi_number,le.avelength_replacement_number,le.avelength_enumeration_date,le.avelength_last_update_date,le.avelength_deactivation_date,le.avelength_reactivation_date,le.avelength_deactivation_reason,le.avelength_csr_number,le.avelength_credential_type,le.avelength_csr_status,le.avelength_sub_status,le.avelength_csr_state,le.avelength_csr_issue_date,le.avelength_effective_date,le.avelength_csr_expiration_date,le.avelength_discipline,le.avelength_all_schedules,le.avelength_schedule_1,le.avelength_schedule_2,le.avelength_schedule_2n,le.avelength_schedule_3,le.avelength_schedule_3n,le.avelength_schedule_4,le.avelength_schedule_5,le.avelength_schedule_6,le.avelength_raw_status,le.avelength_raw_sub_status1,le.avelength_raw_sub_status2,le.avelength_dea_number,le.avelength_schedules,le.avelength_dea_expiration_date,le.avelength_activity,le.avelength_bac,le.avelength_bac_subcode,le.avelength_payment,le.avelength_medicaid_number,le.avelength_medicaid_status,le.avelength_medicaid_state,le.avelength_participation_flag,le.avelength_taxonomy_npi_number,le.avelength_taxonomy_code,le.avelength_taxonomy_order_number,le.avelength_license_number_state_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 113, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.ln_key),TRIM((SALT31.StrType)le.hms_src),TRIM((SALT31.StrType)le.key),TRIM((SALT31.StrType)le.id),TRIM((SALT31.StrType)le.entityid),TRIM((SALT31.StrType)le.license_number),TRIM((SALT31.StrType)le.license_class_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.status),TRIM((SALT31.StrType)le.issue_date),TRIM((SALT31.StrType)le.renewal_date),TRIM((SALT31.StrType)le.expiration_date),TRIM((SALT31.StrType)le.qualifier1),TRIM((SALT31.StrType)le.qualifier2),TRIM((SALT31.StrType)le.qualifier3),TRIM((SALT31.StrType)le.qualifier4),TRIM((SALT31.StrType)le.qualifier5),TRIM((SALT31.StrType)le.rawclass),TRIM((SALT31.StrType)le.rawissue_date),TRIM((SALT31.StrType)le.rawexpiration_date),TRIM((SALT31.StrType)le.rawstatus),TRIM((SALT31.StrType)le.raw_number),TRIM((SALT31.StrType)le.name),TRIM((SALT31.StrType)le.prefix),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.age),TRIM((SALT31.StrType)le.dateofbirth),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.dateofdeath),TRIM((SALT31.StrType)le.employer_identification_number),TRIM((SALT31.StrType)le.raw_full_address),TRIM((SALT31.StrType)le.firmname),TRIM((SALT31.StrType)le.street1),TRIM((SALT31.StrType)le.street2),TRIM((SALT31.StrType)le.street3),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.address_state),TRIM((SALT31.StrType)le.orig_zip),TRIM((SALT31.StrType)le.orig_county),TRIM((SALT31.StrType)le.country),TRIM((SALT31.StrType)le.address_type),TRIM((SALT31.StrType)le.phone1),TRIM((SALT31.StrType)le.phone2),TRIM((SALT31.StrType)le.phone3),TRIM((SALT31.StrType)le.fax1),TRIM((SALT31.StrType)le.fax2),TRIM((SALT31.StrType)le.fax3),TRIM((SALT31.StrType)le.other_phone1),TRIM((SALT31.StrType)le.description),TRIM((SALT31.StrType)le.specialty_class_type),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_type),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.degree),TRIM((SALT31.StrType)le.graduated),TRIM((SALT31.StrType)le.school),TRIM((SALT31.StrType)le.location),TRIM((SALT31.StrType)le.fine),TRIM((SALT31.StrType)le.board),TRIM((SALT31.StrType)le.offense),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.action),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.action_start),TRIM((SALT31.StrType)le.action_end),TRIM((SALT31.StrType)le.npi_number),TRIM((SALT31.StrType)le.replacement_number),TRIM((SALT31.StrType)le.enumeration_date),TRIM((SALT31.StrType)le.last_update_date),TRIM((SALT31.StrType)le.deactivation_date),TRIM((SALT31.StrType)le.reactivation_date),TRIM((SALT31.StrType)le.deactivation_reason),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.credential_type),TRIM((SALT31.StrType)le.csr_status),TRIM((SALT31.StrType)le.sub_status),TRIM((SALT31.StrType)le.csr_state),TRIM((SALT31.StrType)le.csr_issue_date),TRIM((SALT31.StrType)le.effective_date),TRIM((SALT31.StrType)le.csr_expiration_date),TRIM((SALT31.StrType)le.discipline),TRIM((SALT31.StrType)le.all_schedules),TRIM((SALT31.StrType)le.schedule_1),TRIM((SALT31.StrType)le.schedule_2),TRIM((SALT31.StrType)le.schedule_2n),TRIM((SALT31.StrType)le.schedule_3),TRIM((SALT31.StrType)le.schedule_3n),TRIM((SALT31.StrType)le.schedule_4),TRIM((SALT31.StrType)le.schedule_5),TRIM((SALT31.StrType)le.schedule_6),TRIM((SALT31.StrType)le.raw_status),TRIM((SALT31.StrType)le.raw_sub_status1),TRIM((SALT31.StrType)le.raw_sub_status2),TRIM((SALT31.StrType)le.dea_number),TRIM((SALT31.StrType)le.schedules),TRIM((SALT31.StrType)le.dea_expiration_date),TRIM((SALT31.StrType)le.activity),TRIM((SALT31.StrType)le.bac),TRIM((SALT31.StrType)le.bac_subcode),TRIM((SALT31.StrType)le.payment),TRIM((SALT31.StrType)le.medicaid_number),TRIM((SALT31.StrType)le.medicaid_status),TRIM((SALT31.StrType)le.medicaid_state),TRIM((SALT31.StrType)le.participation_flag),TRIM((SALT31.StrType)le.taxonomy_npi_number),TRIM((SALT31.StrType)le.taxonomy_code),TRIM((SALT31.StrType)le.taxonomy_order_number),TRIM((SALT31.StrType)le.license_number_state_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,113,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 113);
  SELF.FldNo2 := 1 + (C % 113);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.ln_key),TRIM((SALT31.StrType)le.hms_src),TRIM((SALT31.StrType)le.key),TRIM((SALT31.StrType)le.id),TRIM((SALT31.StrType)le.entityid),TRIM((SALT31.StrType)le.license_number),TRIM((SALT31.StrType)le.license_class_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.status),TRIM((SALT31.StrType)le.issue_date),TRIM((SALT31.StrType)le.renewal_date),TRIM((SALT31.StrType)le.expiration_date),TRIM((SALT31.StrType)le.qualifier1),TRIM((SALT31.StrType)le.qualifier2),TRIM((SALT31.StrType)le.qualifier3),TRIM((SALT31.StrType)le.qualifier4),TRIM((SALT31.StrType)le.qualifier5),TRIM((SALT31.StrType)le.rawclass),TRIM((SALT31.StrType)le.rawissue_date),TRIM((SALT31.StrType)le.rawexpiration_date),TRIM((SALT31.StrType)le.rawstatus),TRIM((SALT31.StrType)le.raw_number),TRIM((SALT31.StrType)le.name),TRIM((SALT31.StrType)le.prefix),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.age),TRIM((SALT31.StrType)le.dateofbirth),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.dateofdeath),TRIM((SALT31.StrType)le.employer_identification_number),TRIM((SALT31.StrType)le.raw_full_address),TRIM((SALT31.StrType)le.firmname),TRIM((SALT31.StrType)le.street1),TRIM((SALT31.StrType)le.street2),TRIM((SALT31.StrType)le.street3),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.address_state),TRIM((SALT31.StrType)le.orig_zip),TRIM((SALT31.StrType)le.orig_county),TRIM((SALT31.StrType)le.country),TRIM((SALT31.StrType)le.address_type),TRIM((SALT31.StrType)le.phone1),TRIM((SALT31.StrType)le.phone2),TRIM((SALT31.StrType)le.phone3),TRIM((SALT31.StrType)le.fax1),TRIM((SALT31.StrType)le.fax2),TRIM((SALT31.StrType)le.fax3),TRIM((SALT31.StrType)le.other_phone1),TRIM((SALT31.StrType)le.description),TRIM((SALT31.StrType)le.specialty_class_type),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_type),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.degree),TRIM((SALT31.StrType)le.graduated),TRIM((SALT31.StrType)le.school),TRIM((SALT31.StrType)le.location),TRIM((SALT31.StrType)le.fine),TRIM((SALT31.StrType)le.board),TRIM((SALT31.StrType)le.offense),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.action),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.action_start),TRIM((SALT31.StrType)le.action_end),TRIM((SALT31.StrType)le.npi_number),TRIM((SALT31.StrType)le.replacement_number),TRIM((SALT31.StrType)le.enumeration_date),TRIM((SALT31.StrType)le.last_update_date),TRIM((SALT31.StrType)le.deactivation_date),TRIM((SALT31.StrType)le.reactivation_date),TRIM((SALT31.StrType)le.deactivation_reason),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.credential_type),TRIM((SALT31.StrType)le.csr_status),TRIM((SALT31.StrType)le.sub_status),TRIM((SALT31.StrType)le.csr_state),TRIM((SALT31.StrType)le.csr_issue_date),TRIM((SALT31.StrType)le.effective_date),TRIM((SALT31.StrType)le.csr_expiration_date),TRIM((SALT31.StrType)le.discipline),TRIM((SALT31.StrType)le.all_schedules),TRIM((SALT31.StrType)le.schedule_1),TRIM((SALT31.StrType)le.schedule_2),TRIM((SALT31.StrType)le.schedule_2n),TRIM((SALT31.StrType)le.schedule_3),TRIM((SALT31.StrType)le.schedule_3n),TRIM((SALT31.StrType)le.schedule_4),TRIM((SALT31.StrType)le.schedule_5),TRIM((SALT31.StrType)le.schedule_6),TRIM((SALT31.StrType)le.raw_status),TRIM((SALT31.StrType)le.raw_sub_status1),TRIM((SALT31.StrType)le.raw_sub_status2),TRIM((SALT31.StrType)le.dea_number),TRIM((SALT31.StrType)le.schedules),TRIM((SALT31.StrType)le.dea_expiration_date),TRIM((SALT31.StrType)le.activity),TRIM((SALT31.StrType)le.bac),TRIM((SALT31.StrType)le.bac_subcode),TRIM((SALT31.StrType)le.payment),TRIM((SALT31.StrType)le.medicaid_number),TRIM((SALT31.StrType)le.medicaid_status),TRIM((SALT31.StrType)le.medicaid_state),TRIM((SALT31.StrType)le.participation_flag),TRIM((SALT31.StrType)le.taxonomy_npi_number),TRIM((SALT31.StrType)le.taxonomy_code),TRIM((SALT31.StrType)le.taxonomy_order_number),TRIM((SALT31.StrType)le.license_number_state_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.ln_key),TRIM((SALT31.StrType)le.hms_src),TRIM((SALT31.StrType)le.key),TRIM((SALT31.StrType)le.id),TRIM((SALT31.StrType)le.entityid),TRIM((SALT31.StrType)le.license_number),TRIM((SALT31.StrType)le.license_class_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.status),TRIM((SALT31.StrType)le.issue_date),TRIM((SALT31.StrType)le.renewal_date),TRIM((SALT31.StrType)le.expiration_date),TRIM((SALT31.StrType)le.qualifier1),TRIM((SALT31.StrType)le.qualifier2),TRIM((SALT31.StrType)le.qualifier3),TRIM((SALT31.StrType)le.qualifier4),TRIM((SALT31.StrType)le.qualifier5),TRIM((SALT31.StrType)le.rawclass),TRIM((SALT31.StrType)le.rawissue_date),TRIM((SALT31.StrType)le.rawexpiration_date),TRIM((SALT31.StrType)le.rawstatus),TRIM((SALT31.StrType)le.raw_number),TRIM((SALT31.StrType)le.name),TRIM((SALT31.StrType)le.prefix),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.age),TRIM((SALT31.StrType)le.dateofbirth),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.dateofdeath),TRIM((SALT31.StrType)le.employer_identification_number),TRIM((SALT31.StrType)le.raw_full_address),TRIM((SALT31.StrType)le.firmname),TRIM((SALT31.StrType)le.street1),TRIM((SALT31.StrType)le.street2),TRIM((SALT31.StrType)le.street3),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.address_state),TRIM((SALT31.StrType)le.orig_zip),TRIM((SALT31.StrType)le.orig_county),TRIM((SALT31.StrType)le.country),TRIM((SALT31.StrType)le.address_type),TRIM((SALT31.StrType)le.phone1),TRIM((SALT31.StrType)le.phone2),TRIM((SALT31.StrType)le.phone3),TRIM((SALT31.StrType)le.fax1),TRIM((SALT31.StrType)le.fax2),TRIM((SALT31.StrType)le.fax3),TRIM((SALT31.StrType)le.other_phone1),TRIM((SALT31.StrType)le.description),TRIM((SALT31.StrType)le.specialty_class_type),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_type),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.degree),TRIM((SALT31.StrType)le.graduated),TRIM((SALT31.StrType)le.school),TRIM((SALT31.StrType)le.location),TRIM((SALT31.StrType)le.fine),TRIM((SALT31.StrType)le.board),TRIM((SALT31.StrType)le.offense),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.action),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.action_start),TRIM((SALT31.StrType)le.action_end),TRIM((SALT31.StrType)le.npi_number),TRIM((SALT31.StrType)le.replacement_number),TRIM((SALT31.StrType)le.enumeration_date),TRIM((SALT31.StrType)le.last_update_date),TRIM((SALT31.StrType)le.deactivation_date),TRIM((SALT31.StrType)le.reactivation_date),TRIM((SALT31.StrType)le.deactivation_reason),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.credential_type),TRIM((SALT31.StrType)le.csr_status),TRIM((SALT31.StrType)le.sub_status),TRIM((SALT31.StrType)le.csr_state),TRIM((SALT31.StrType)le.csr_issue_date),TRIM((SALT31.StrType)le.effective_date),TRIM((SALT31.StrType)le.csr_expiration_date),TRIM((SALT31.StrType)le.discipline),TRIM((SALT31.StrType)le.all_schedules),TRIM((SALT31.StrType)le.schedule_1),TRIM((SALT31.StrType)le.schedule_2),TRIM((SALT31.StrType)le.schedule_2n),TRIM((SALT31.StrType)le.schedule_3),TRIM((SALT31.StrType)le.schedule_3n),TRIM((SALT31.StrType)le.schedule_4),TRIM((SALT31.StrType)le.schedule_5),TRIM((SALT31.StrType)le.schedule_6),TRIM((SALT31.StrType)le.raw_status),TRIM((SALT31.StrType)le.raw_sub_status1),TRIM((SALT31.StrType)le.raw_sub_status2),TRIM((SALT31.StrType)le.dea_number),TRIM((SALT31.StrType)le.schedules),TRIM((SALT31.StrType)le.dea_expiration_date),TRIM((SALT31.StrType)le.activity),TRIM((SALT31.StrType)le.bac),TRIM((SALT31.StrType)le.bac_subcode),TRIM((SALT31.StrType)le.payment),TRIM((SALT31.StrType)le.medicaid_number),TRIM((SALT31.StrType)le.medicaid_status),TRIM((SALT31.StrType)le.medicaid_state),TRIM((SALT31.StrType)le.participation_flag),TRIM((SALT31.StrType)le.taxonomy_npi_number),TRIM((SALT31.StrType)le.taxonomy_code),TRIM((SALT31.StrType)le.taxonomy_order_number),TRIM((SALT31.StrType)le.license_number_state_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),113*113,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ln_key'}
      ,{2,'hms_src'}
      ,{3,'key'}
      ,{4,'id'}
      ,{5,'entityid'}
      ,{6,'license_number'}
      ,{7,'license_class_type'}
      ,{8,'license_state'}
      ,{9,'status'}
      ,{10,'issue_date'}
      ,{11,'renewal_date'}
      ,{12,'expiration_date'}
      ,{13,'qualifier1'}
      ,{14,'qualifier2'}
      ,{15,'qualifier3'}
      ,{16,'qualifier4'}
      ,{17,'qualifier5'}
      ,{18,'rawclass'}
      ,{19,'rawissue_date'}
      ,{20,'rawexpiration_date'}
      ,{21,'rawstatus'}
      ,{22,'raw_number'}
      ,{23,'name'}
      ,{24,'prefix'}
      ,{25,'first'}
      ,{26,'middle'}
      ,{27,'last'}
      ,{28,'suffix'}
      ,{29,'cred'}
      ,{30,'age'}
      ,{31,'dateofbirth'}
      ,{32,'email'}
      ,{33,'gender'}
      ,{34,'dateofdeath'}
      ,{35,'employer_identification_number'}
      ,{36,'raw_full_address'}
      ,{37,'firmname'}
      ,{38,'street1'}
      ,{39,'street2'}
      ,{40,'street3'}
      ,{41,'city'}
      ,{42,'address_state'}
      ,{43,'orig_zip'}
      ,{44,'orig_county'}
      ,{45,'country'}
      ,{46,'address_type'}
      ,{47,'phone1'}
      ,{48,'phone2'}
      ,{49,'phone3'}
      ,{50,'fax1'}
      ,{51,'fax2'}
      ,{52,'fax3'}
      ,{53,'other_phone1'}
      ,{54,'description'}
      ,{55,'specialty_class_type'}
      ,{56,'phone_number'}
      ,{57,'phone_type'}
      ,{58,'language'}
      ,{59,'degree'}
      ,{60,'graduated'}
      ,{61,'school'}
      ,{62,'location'}
      ,{63,'fine'}
      ,{64,'board'}
      ,{65,'offense'}
      ,{66,'offense_date'}
      ,{67,'action'}
      ,{68,'action_date'}
      ,{69,'action_start'}
      ,{70,'action_end'}
      ,{71,'npi_number'}
      ,{72,'replacement_number'}
      ,{73,'enumeration_date'}
      ,{74,'last_update_date'}
      ,{75,'deactivation_date'}
      ,{76,'reactivation_date'}
      ,{77,'deactivation_reason'}
      ,{78,'csr_number'}
      ,{79,'credential_type'}
      ,{80,'csr_status'}
      ,{81,'sub_status'}
      ,{82,'csr_state'}
      ,{83,'csr_issue_date'}
      ,{84,'effective_date'}
      ,{85,'csr_expiration_date'}
      ,{86,'discipline'}
      ,{87,'all_schedules'}
      ,{88,'schedule_1'}
      ,{89,'schedule_2'}
      ,{90,'schedule_2n'}
      ,{91,'schedule_3'}
      ,{92,'schedule_3n'}
      ,{93,'schedule_4'}
      ,{94,'schedule_5'}
      ,{95,'schedule_6'}
      ,{96,'raw_status'}
      ,{97,'raw_sub_status1'}
      ,{98,'raw_sub_status2'}
      ,{99,'dea_number'}
      ,{100,'schedules'}
      ,{101,'dea_expiration_date'}
      ,{102,'activity'}
      ,{103,'bac'}
      ,{104,'bac_subcode'}
      ,{105,'payment'}
      ,{106,'medicaid_number'}
      ,{107,'medicaid_status'}
      ,{108,'medicaid_state'}
      ,{109,'participation_flag'}
      ,{110,'taxonomy_npi_number'}
      ,{111,'taxonomy_code'}
      ,{112,'taxonomy_order_number'}
      ,{113,'license_number_state_code'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    HmsCsr_Fields.InValid_ln_key((SALT31.StrType)le.ln_key),
    HmsCsr_Fields.InValid_hms_src((SALT31.StrType)le.hms_src),
    HmsCsr_Fields.InValid_key((SALT31.StrType)le.key),
    HmsCsr_Fields.InValid_id((SALT31.StrType)le.id),
    HmsCsr_Fields.InValid_entityid((SALT31.StrType)le.entityid),
    HmsCsr_Fields.InValid_license_number((SALT31.StrType)le.license_number),
    HmsCsr_Fields.InValid_license_class_type((SALT31.StrType)le.license_class_type),
    HmsCsr_Fields.InValid_license_state((SALT31.StrType)le.license_state),
    HmsCsr_Fields.InValid_status((SALT31.StrType)le.status),
    HmsCsr_Fields.InValid_issue_date((SALT31.StrType)le.issue_date),
    HmsCsr_Fields.InValid_renewal_date((SALT31.StrType)le.renewal_date),
    HmsCsr_Fields.InValid_expiration_date((SALT31.StrType)le.expiration_date),
    HmsCsr_Fields.InValid_qualifier1((SALT31.StrType)le.qualifier1),
    HmsCsr_Fields.InValid_qualifier2((SALT31.StrType)le.qualifier2),
    HmsCsr_Fields.InValid_qualifier3((SALT31.StrType)le.qualifier3),
    HmsCsr_Fields.InValid_qualifier4((SALT31.StrType)le.qualifier4),
    HmsCsr_Fields.InValid_qualifier5((SALT31.StrType)le.qualifier5),
    HmsCsr_Fields.InValid_rawclass((SALT31.StrType)le.rawclass),
    HmsCsr_Fields.InValid_rawissue_date((SALT31.StrType)le.rawissue_date),
    HmsCsr_Fields.InValid_rawexpiration_date((SALT31.StrType)le.rawexpiration_date),
    HmsCsr_Fields.InValid_rawstatus((SALT31.StrType)le.rawstatus),
    HmsCsr_Fields.InValid_raw_number((SALT31.StrType)le.raw_number),
    HmsCsr_Fields.InValid_name((SALT31.StrType)le.name),
    HmsCsr_Fields.InValid_prefix((SALT31.StrType)le.prefix),
    HmsCsr_Fields.InValid_first((SALT31.StrType)le.first),
    HmsCsr_Fields.InValid_middle((SALT31.StrType)le.middle),
    HmsCsr_Fields.InValid_last((SALT31.StrType)le.last),
    HmsCsr_Fields.InValid_suffix((SALT31.StrType)le.suffix),
    HmsCsr_Fields.InValid_cred((SALT31.StrType)le.cred),
    HmsCsr_Fields.InValid_age((SALT31.StrType)le.age),
    HmsCsr_Fields.InValid_dateofbirth((SALT31.StrType)le.dateofbirth),
    HmsCsr_Fields.InValid_email((SALT31.StrType)le.email),
    HmsCsr_Fields.InValid_gender((SALT31.StrType)le.gender),
    HmsCsr_Fields.InValid_dateofdeath((SALT31.StrType)le.dateofdeath),
    HmsCsr_Fields.InValid_employer_identification_number((SALT31.StrType)le.employer_identification_number),
    HmsCsr_Fields.InValid_raw_full_address((SALT31.StrType)le.raw_full_address),
    HmsCsr_Fields.InValid_firmname((SALT31.StrType)le.firmname),
    HmsCsr_Fields.InValid_street1((SALT31.StrType)le.street1),
    HmsCsr_Fields.InValid_street2((SALT31.StrType)le.street2),
    HmsCsr_Fields.InValid_street3((SALT31.StrType)le.street3),
    HmsCsr_Fields.InValid_city((SALT31.StrType)le.city),
    HmsCsr_Fields.InValid_address_state((SALT31.StrType)le.address_state),
    HmsCsr_Fields.InValid_orig_zip((SALT31.StrType)le.orig_zip),
    HmsCsr_Fields.InValid_orig_county((SALT31.StrType)le.orig_county),
    HmsCsr_Fields.InValid_country((SALT31.StrType)le.country),
    HmsCsr_Fields.InValid_address_type((SALT31.StrType)le.address_type),
    HmsCsr_Fields.InValid_phone1((SALT31.StrType)le.phone1),
    HmsCsr_Fields.InValid_phone2((SALT31.StrType)le.phone2),
    HmsCsr_Fields.InValid_phone3((SALT31.StrType)le.phone3),
    HmsCsr_Fields.InValid_fax1((SALT31.StrType)le.fax1),
    HmsCsr_Fields.InValid_fax2((SALT31.StrType)le.fax2),
    HmsCsr_Fields.InValid_fax3((SALT31.StrType)le.fax3),
    HmsCsr_Fields.InValid_other_phone1((SALT31.StrType)le.other_phone1),
    HmsCsr_Fields.InValid_description((SALT31.StrType)le.description),
    HmsCsr_Fields.InValid_specialty_class_type((SALT31.StrType)le.specialty_class_type),
    HmsCsr_Fields.InValid_phone_number((SALT31.StrType)le.phone_number),
    HmsCsr_Fields.InValid_phone_type((SALT31.StrType)le.phone_type),
    HmsCsr_Fields.InValid_language((SALT31.StrType)le.language),
    HmsCsr_Fields.InValid_degree((SALT31.StrType)le.degree),
    HmsCsr_Fields.InValid_graduated((SALT31.StrType)le.graduated),
    HmsCsr_Fields.InValid_school((SALT31.StrType)le.school),
    HmsCsr_Fields.InValid_location((SALT31.StrType)le.location),
    HmsCsr_Fields.InValid_fine((SALT31.StrType)le.fine),
    HmsCsr_Fields.InValid_board((SALT31.StrType)le.board),
    HmsCsr_Fields.InValid_offense((SALT31.StrType)le.offense),
    HmsCsr_Fields.InValid_offense_date((SALT31.StrType)le.offense_date),
    HmsCsr_Fields.InValid_action((SALT31.StrType)le.action),
    HmsCsr_Fields.InValid_action_date((SALT31.StrType)le.action_date),
    HmsCsr_Fields.InValid_action_start((SALT31.StrType)le.action_start),
    HmsCsr_Fields.InValid_action_end((SALT31.StrType)le.action_end),
    HmsCsr_Fields.InValid_npi_number((SALT31.StrType)le.npi_number),
    HmsCsr_Fields.InValid_replacement_number((SALT31.StrType)le.replacement_number),
    HmsCsr_Fields.InValid_enumeration_date((SALT31.StrType)le.enumeration_date),
    HmsCsr_Fields.InValid_last_update_date((SALT31.StrType)le.last_update_date),
    HmsCsr_Fields.InValid_deactivation_date((SALT31.StrType)le.deactivation_date),
    HmsCsr_Fields.InValid_reactivation_date((SALT31.StrType)le.reactivation_date),
    HmsCsr_Fields.InValid_deactivation_reason((SALT31.StrType)le.deactivation_reason),
    HmsCsr_Fields.InValid_csr_number((SALT31.StrType)le.csr_number),
    HmsCsr_Fields.InValid_credential_type((SALT31.StrType)le.credential_type),
    HmsCsr_Fields.InValid_csr_status((SALT31.StrType)le.csr_status),
    HmsCsr_Fields.InValid_sub_status((SALT31.StrType)le.sub_status),
    HmsCsr_Fields.InValid_csr_state((SALT31.StrType)le.csr_state),
    HmsCsr_Fields.InValid_csr_issue_date((SALT31.StrType)le.csr_issue_date),
    HmsCsr_Fields.InValid_effective_date((SALT31.StrType)le.effective_date),
    HmsCsr_Fields.InValid_csr_expiration_date((SALT31.StrType)le.csr_expiration_date),
    HmsCsr_Fields.InValid_discipline((SALT31.StrType)le.discipline),
    HmsCsr_Fields.InValid_all_schedules((SALT31.StrType)le.all_schedules),
    HmsCsr_Fields.InValid_schedule_1((SALT31.StrType)le.schedule_1),
    HmsCsr_Fields.InValid_schedule_2((SALT31.StrType)le.schedule_2),
    HmsCsr_Fields.InValid_schedule_2n((SALT31.StrType)le.schedule_2n),
    HmsCsr_Fields.InValid_schedule_3((SALT31.StrType)le.schedule_3),
    HmsCsr_Fields.InValid_schedule_3n((SALT31.StrType)le.schedule_3n),
    HmsCsr_Fields.InValid_schedule_4((SALT31.StrType)le.schedule_4),
    HmsCsr_Fields.InValid_schedule_5((SALT31.StrType)le.schedule_5),
    HmsCsr_Fields.InValid_schedule_6((SALT31.StrType)le.schedule_6),
    HmsCsr_Fields.InValid_raw_status((SALT31.StrType)le.raw_status),
    HmsCsr_Fields.InValid_raw_sub_status1((SALT31.StrType)le.raw_sub_status1),
    HmsCsr_Fields.InValid_raw_sub_status2((SALT31.StrType)le.raw_sub_status2),
    HmsCsr_Fields.InValid_dea_number((SALT31.StrType)le.dea_number),
    HmsCsr_Fields.InValid_schedules((SALT31.StrType)le.schedules),
    HmsCsr_Fields.InValid_dea_expiration_date((SALT31.StrType)le.dea_expiration_date),
    HmsCsr_Fields.InValid_activity((SALT31.StrType)le.activity),
    HmsCsr_Fields.InValid_bac((SALT31.StrType)le.bac),
    HmsCsr_Fields.InValid_bac_subcode((SALT31.StrType)le.bac_subcode),
    HmsCsr_Fields.InValid_payment((SALT31.StrType)le.payment),
    HmsCsr_Fields.InValid_medicaid_number((SALT31.StrType)le.medicaid_number),
    HmsCsr_Fields.InValid_medicaid_status((SALT31.StrType)le.medicaid_status),
    HmsCsr_Fields.InValid_medicaid_state((SALT31.StrType)le.medicaid_state),
    HmsCsr_Fields.InValid_participation_flag((SALT31.StrType)le.participation_flag),
    HmsCsr_Fields.InValid_taxonomy_npi_number((SALT31.StrType)le.taxonomy_npi_number),
    HmsCsr_Fields.InValid_taxonomy_code((SALT31.StrType)le.taxonomy_code),
    HmsCsr_Fields.InValid_taxonomy_order_number((SALT31.StrType)le.taxonomy_order_number),
    HmsCsr_Fields.InValid_license_number_state_code((SALT31.StrType)le.license_number_state_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,113,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := HmsCsr_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','renewal_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','prefix','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','Unknown','Unknown','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','degree','graduated','school','location','fine','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','replacement_number','enumeration_date','last_update_date','deactivation_date','reactivation_date','deactivation_reason','csr_number','credential_type','csr_status','sub_status','csr_state','csr_issue_date','effective_date','csr_expiration_date','discipline','all_schedules','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','dea_expiration_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,HmsCsr_Fields.InValidMessage_ln_key(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_hms_src(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_key(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_id(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_entityid(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_license_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_license_class_type(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_license_state(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_status(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_issue_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_renewal_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_qualifier1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_qualifier2(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_qualifier3(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_qualifier4(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_qualifier5(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_rawclass(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_rawissue_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_rawexpiration_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_rawstatus(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_raw_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_name(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_prefix(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_first(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_middle(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_last(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_cred(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_age(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_dateofbirth(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_email(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_gender(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_dateofdeath(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_employer_identification_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_raw_full_address(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_firmname(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_street1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_street2(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_street3(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_city(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_address_state(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_country(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_address_type(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_phone1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_phone2(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_phone3(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_fax1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_fax2(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_fax3(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_other_phone1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_description(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_specialty_class_type(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_language(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_degree(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_graduated(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_school(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_location(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_fine(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_board(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_offense(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_offense_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_action(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_action_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_action_start(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_action_end(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_npi_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_replacement_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_enumeration_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_last_update_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_deactivation_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_reactivation_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_deactivation_reason(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_csr_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_credential_type(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_csr_status(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_sub_status(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_csr_state(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_csr_issue_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_effective_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_csr_expiration_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_discipline(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_all_schedules(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_2(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_2n(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_3(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_3n(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_4(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_5(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedule_6(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_raw_status(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_raw_sub_status1(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_raw_sub_status2(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_dea_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_schedules(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_dea_expiration_date(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_activity(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_bac(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_bac_subcode(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_payment(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_medicaid_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_medicaid_status(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_medicaid_state(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_participation_flag(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_taxonomy_npi_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_taxonomy_code(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_taxonomy_order_number(TotalErrors.ErrorNum),HmsCsr_Fields.InValidMessage_license_number_state_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
