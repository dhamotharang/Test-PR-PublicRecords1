IMPORT ut,SALT31;
EXPORT HmsStlic_hygiene(dataset(HmsStlic_layout_HmsStlic) h) := MODULE
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
    populated_graduated_pcnt := AVE(GROUP,IF(h.graduated = (TYPEOF(h.graduated))'',0,100));
    maxlength_graduated := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.graduated)));
    avelength_graduated := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.graduated)),h.graduated<>(typeof(h.graduated))'');
    populated_school_pcnt := AVE(GROUP,IF(h.school = (TYPEOF(h.school))'',0,100));
    maxlength_school := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.school)));
    avelength_school := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.school)),h.school<>(typeof(h.school))'');
    populated_location_pcnt := AVE(GROUP,IF(h.location = (TYPEOF(h.location))'',0,100));
    maxlength_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.location)));
    avelength_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.location)),h.location<>(typeof(h.location))'');
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
    populated_csr_number_pcnt := AVE(GROUP,IF(h.csr_number = (TYPEOF(h.csr_number))'',0,100));
    maxlength_csr_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_number)));
    avelength_csr_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_number)),h.csr_number<>(typeof(h.csr_number))'');
    populated_dea_number_pcnt := AVE(GROUP,IF(h.dea_number = (TYPEOF(h.dea_number))'',0,100));
    maxlength_dea_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_number)));
    avelength_dea_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_number)),h.dea_number<>(typeof(h.dea_number))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_phone1_pcnt := AVE(GROUP,IF(h.clean_phone1 = (TYPEOF(h.clean_phone1))'',0,100));
    maxlength_clean_phone1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone1)));
    avelength_clean_phone1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone1)),h.clean_phone1<>(typeof(h.clean_phone1))'');
    populated_clean_phone2_pcnt := AVE(GROUP,IF(h.clean_phone2 = (TYPEOF(h.clean_phone2))'',0,100));
    maxlength_clean_phone2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone2)));
    avelength_clean_phone2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone2)),h.clean_phone2<>(typeof(h.clean_phone2))'');
    populated_clean_phone3_pcnt := AVE(GROUP,IF(h.clean_phone3 = (TYPEOF(h.clean_phone3))'',0,100));
    maxlength_clean_phone3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone3)));
    avelength_clean_phone3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone3)),h.clean_phone3<>(typeof(h.clean_phone3))'');
    populated_clean_fax1_pcnt := AVE(GROUP,IF(h.clean_fax1 = (TYPEOF(h.clean_fax1))'',0,100));
    maxlength_clean_fax1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_fax1)));
    avelength_clean_fax1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_fax1)),h.clean_fax1<>(typeof(h.clean_fax1))'');
    populated_clean_fax2_pcnt := AVE(GROUP,IF(h.clean_fax2 = (TYPEOF(h.clean_fax2))'',0,100));
    maxlength_clean_fax2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_fax2)));
    avelength_clean_fax2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_fax2)),h.clean_fax2<>(typeof(h.clean_fax2))'');
    populated_clean_fax3_pcnt := AVE(GROUP,IF(h.clean_fax3 = (TYPEOF(h.clean_fax3))'',0,100));
    maxlength_clean_fax3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_fax3)));
    avelength_clean_fax3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_fax3)),h.clean_fax3<>(typeof(h.clean_fax3))'');
    populated_clean_other_phone1_pcnt := AVE(GROUP,IF(h.clean_other_phone1 = (TYPEOF(h.clean_other_phone1))'',0,100));
    maxlength_clean_other_phone1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_other_phone1)));
    avelength_clean_other_phone1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_other_phone1)),h.clean_other_phone1<>(typeof(h.clean_other_phone1))'');
    populated_clean_dateofbirth_pcnt := AVE(GROUP,IF(h.clean_dateofbirth = (TYPEOF(h.clean_dateofbirth))'',0,100));
    maxlength_clean_dateofbirth := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dateofbirth)));
    avelength_clean_dateofbirth := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dateofbirth)),h.clean_dateofbirth<>(typeof(h.clean_dateofbirth))'');
    populated_clean_dateofdeath_pcnt := AVE(GROUP,IF(h.clean_dateofdeath = (TYPEOF(h.clean_dateofdeath))'',0,100));
    maxlength_clean_dateofdeath := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dateofdeath)));
    avelength_clean_dateofdeath := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dateofdeath)),h.clean_dateofdeath<>(typeof(h.clean_dateofdeath))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_clean_issue_date_pcnt := AVE(GROUP,IF(h.clean_issue_date = (TYPEOF(h.clean_issue_date))'',0,100));
    maxlength_clean_issue_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_issue_date)));
    avelength_clean_issue_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_issue_date)),h.clean_issue_date<>(typeof(h.clean_issue_date))'');
    populated_clean_expiration_date_pcnt := AVE(GROUP,IF(h.clean_expiration_date = (TYPEOF(h.clean_expiration_date))'',0,100));
    maxlength_clean_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_expiration_date)));
    avelength_clean_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_expiration_date)),h.clean_expiration_date<>(typeof(h.clean_expiration_date))'');
    populated_clean_offense_date_pcnt := AVE(GROUP,IF(h.clean_offense_date = (TYPEOF(h.clean_offense_date))'',0,100));
    maxlength_clean_offense_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_offense_date)));
    avelength_clean_offense_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_offense_date)),h.clean_offense_date<>(typeof(h.clean_offense_date))'');
    populated_clean_action_date_pcnt := AVE(GROUP,IF(h.clean_action_date = (TYPEOF(h.clean_action_date))'',0,100));
    maxlength_clean_action_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_action_date)));
    avelength_clean_action_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_action_date)),h.clean_action_date<>(typeof(h.clean_action_date))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_in_state_pcnt := AVE(GROUP,IF(h.in_state = (TYPEOF(h.in_state))'',0,100));
    maxlength_in_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_state)));
    avelength_in_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_state)),h.in_state<>(typeof(h.in_state))'');
    populated_in_class_pcnt := AVE(GROUP,IF(h.in_class = (TYPEOF(h.in_class))'',0,100));
    maxlength_in_class := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_class)));
    avelength_in_class := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_class)),h.in_class<>(typeof(h.in_class))'');
    populated_in_status_pcnt := AVE(GROUP,IF(h.in_status = (TYPEOF(h.in_status))'',0,100));
    maxlength_in_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_status)));
    avelength_in_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_status)),h.in_status<>(typeof(h.in_status))'');
    populated_in_qualifier1_pcnt := AVE(GROUP,IF(h.in_qualifier1 = (TYPEOF(h.in_qualifier1))'',0,100));
    maxlength_in_qualifier1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_qualifier1)));
    avelength_in_qualifier1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_qualifier1)),h.in_qualifier1<>(typeof(h.in_qualifier1))'');
    populated_in_qualifier2_pcnt := AVE(GROUP,IF(h.in_qualifier2 = (TYPEOF(h.in_qualifier2))'',0,100));
    maxlength_in_qualifier2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_qualifier2)));
    avelength_in_qualifier2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_qualifier2)),h.in_qualifier2<>(typeof(h.in_qualifier2))'');
    populated_mapped_class_pcnt := AVE(GROUP,IF(h.mapped_class = (TYPEOF(h.mapped_class))'',0,100));
    maxlength_mapped_class := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_class)));
    avelength_mapped_class := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_class)),h.mapped_class<>(typeof(h.mapped_class))'');
    populated_mapped_status_pcnt := AVE(GROUP,IF(h.mapped_status = (TYPEOF(h.mapped_status))'',0,100));
    maxlength_mapped_status := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_status)));
    avelength_mapped_status := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_status)),h.mapped_status<>(typeof(h.mapped_status))'');
    populated_mapped_qualifier1_pcnt := AVE(GROUP,IF(h.mapped_qualifier1 = (TYPEOF(h.mapped_qualifier1))'',0,100));
    maxlength_mapped_qualifier1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_qualifier1)));
    avelength_mapped_qualifier1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_qualifier1)),h.mapped_qualifier1<>(typeof(h.mapped_qualifier1))'');
    populated_mapped_qualifier2_pcnt := AVE(GROUP,IF(h.mapped_qualifier2 = (TYPEOF(h.mapped_qualifier2))'',0,100));
    maxlength_mapped_qualifier2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_qualifier2)));
    avelength_mapped_qualifier2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_qualifier2)),h.mapped_qualifier2<>(typeof(h.mapped_qualifier2))'');
    populated_mapped_pdma_pcnt := AVE(GROUP,IF(h.mapped_pdma = (TYPEOF(h.mapped_pdma))'',0,100));
    maxlength_mapped_pdma := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_pdma)));
    avelength_mapped_pdma := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_pdma)),h.mapped_pdma<>(typeof(h.mapped_pdma))'');
    populated_mapped_pract_type_pcnt := AVE(GROUP,IF(h.mapped_pract_type = (TYPEOF(h.mapped_pract_type))'',0,100));
    maxlength_mapped_pract_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_pract_type)));
    avelength_mapped_pract_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mapped_pract_type)),h.mapped_pract_type<>(typeof(h.mapped_pract_type))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_taxonomy_code_pcnt := AVE(GROUP,IF(h.taxonomy_code = (TYPEOF(h.taxonomy_code))'',0,100));
    maxlength_taxonomy_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_code)));
    avelength_taxonomy_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy_code)),h.taxonomy_code<>(typeof(h.taxonomy_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ln_key_pcnt *   0.00 / 100 + T.Populated_hms_src_pcnt *   0.00 / 100 + T.Populated_key_pcnt *   0.00 / 100 + T.Populated_id_pcnt *   0.00 / 100 + T.Populated_entityid_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_license_class_type_pcnt *   0.00 / 100 + T.Populated_license_state_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_issue_date_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_qualifier1_pcnt *   0.00 / 100 + T.Populated_qualifier2_pcnt *   0.00 / 100 + T.Populated_qualifier3_pcnt *   0.00 / 100 + T.Populated_qualifier4_pcnt *   0.00 / 100 + T.Populated_qualifier5_pcnt *   0.00 / 100 + T.Populated_rawclass_pcnt *   0.00 / 100 + T.Populated_rawissue_date_pcnt *   0.00 / 100 + T.Populated_rawexpiration_date_pcnt *   0.00 / 100 + T.Populated_rawstatus_pcnt *   0.00 / 100 + T.Populated_raw_number_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_first_pcnt *   0.00 / 100 + T.Populated_middle_pcnt *   0.00 / 100 + T.Populated_last_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_cred_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_dateofbirth_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_dateofdeath_pcnt *   0.00 / 100 + T.Populated_firmname_pcnt *   0.00 / 100 + T.Populated_street1_pcnt *   0.00 / 100 + T.Populated_street2_pcnt *   0.00 / 100 + T.Populated_street3_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_address_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_phone1_pcnt *   0.00 / 100 + T.Populated_phone2_pcnt *   0.00 / 100 + T.Populated_phone3_pcnt *   0.00 / 100 + T.Populated_fax1_pcnt *   0.00 / 100 + T.Populated_fax2_pcnt *   0.00 / 100 + T.Populated_fax3_pcnt *   0.00 / 100 + T.Populated_other_phone1_pcnt *   0.00 / 100 + T.Populated_description_pcnt *   0.00 / 100 + T.Populated_specialty_class_type_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_language_pcnt *   0.00 / 100 + T.Populated_graduated_pcnt *   0.00 / 100 + T.Populated_school_pcnt *   0.00 / 100 + T.Populated_location_pcnt *   0.00 / 100 + T.Populated_board_pcnt *   0.00 / 100 + T.Populated_offense_pcnt *   0.00 / 100 + T.Populated_offense_date_pcnt *   0.00 / 100 + T.Populated_action_pcnt *   0.00 / 100 + T.Populated_action_date_pcnt *   0.00 / 100 + T.Populated_action_start_pcnt *   0.00 / 100 + T.Populated_action_end_pcnt *   0.00 / 100 + T.Populated_npi_number_pcnt *   0.00 / 100 + T.Populated_csr_number_pcnt *   0.00 / 100 + T.Populated_dea_number_pcnt *   0.00 / 100 + T.Populated_prepped_addr1_pcnt *   0.00 / 100 + T.Populated_prepped_addr2_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_phone1_pcnt *   0.00 / 100 + T.Populated_clean_phone2_pcnt *   0.00 / 100 + T.Populated_clean_phone3_pcnt *   0.00 / 100 + T.Populated_clean_fax1_pcnt *   0.00 / 100 + T.Populated_clean_fax2_pcnt *   0.00 / 100 + T.Populated_clean_fax3_pcnt *   0.00 / 100 + T.Populated_clean_other_phone1_pcnt *   0.00 / 100 + T.Populated_clean_dateofbirth_pcnt *   0.00 / 100 + T.Populated_clean_dateofdeath_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_clean_issue_date_pcnt *   0.00 / 100 + T.Populated_clean_expiration_date_pcnt *   0.00 / 100 + T.Populated_clean_offense_date_pcnt *   0.00 / 100 + T.Populated_clean_action_date_pcnt *   0.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_lnpid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_in_state_pcnt *   0.00 / 100 + T.Populated_in_class_pcnt *   0.00 / 100 + T.Populated_in_status_pcnt *   0.00 / 100 + T.Populated_in_qualifier1_pcnt *   0.00 / 100 + T.Populated_in_qualifier2_pcnt *   0.00 / 100 + T.Populated_mapped_class_pcnt *   0.00 / 100 + T.Populated_mapped_status_pcnt *   0.00 / 100 + T.Populated_mapped_qualifier1_pcnt *   0.00 / 100 + T.Populated_mapped_qualifier2_pcnt *   0.00 / 100 + T.Populated_mapped_pdma_pcnt *   0.00 / 100 + T.Populated_mapped_pract_type_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_taxonomy_code_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','graduated','school','location','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','csr_number','dea_number','prepped_addr1','prepped_addr2','clean_phone','clean_phone1','clean_phone2','clean_phone3','clean_fax1','clean_fax2','clean_fax3','clean_other_phone1','clean_dateofbirth','clean_dateofdeath','clean_company_name','clean_issue_date','clean_expiration_date','clean_offense_date','clean_action_date','src','zip','zip4','bdid','bdid_score','lnpid','did','did_score','dt_vendor_first_reported','dt_vendor_last_reported','in_state','in_class','in_status','in_qualifier1','in_qualifier2','mapped_class','mapped_status','mapped_qualifier1','mapped_qualifier2','mapped_pdma','mapped_pract_type','source_code','taxonomy_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ln_key_pcnt,le.populated_hms_src_pcnt,le.populated_key_pcnt,le.populated_id_pcnt,le.populated_entityid_pcnt,le.populated_license_number_pcnt,le.populated_license_class_type_pcnt,le.populated_license_state_pcnt,le.populated_status_pcnt,le.populated_issue_date_pcnt,le.populated_expiration_date_pcnt,le.populated_qualifier1_pcnt,le.populated_qualifier2_pcnt,le.populated_qualifier3_pcnt,le.populated_qualifier4_pcnt,le.populated_qualifier5_pcnt,le.populated_rawclass_pcnt,le.populated_rawissue_date_pcnt,le.populated_rawexpiration_date_pcnt,le.populated_rawstatus_pcnt,le.populated_raw_number_pcnt,le.populated_name_pcnt,le.populated_first_pcnt,le.populated_middle_pcnt,le.populated_last_pcnt,le.populated_suffix_pcnt,le.populated_cred_pcnt,le.populated_age_pcnt,le.populated_dateofbirth_pcnt,le.populated_email_pcnt,le.populated_gender_pcnt,le.populated_dateofdeath_pcnt,le.populated_firmname_pcnt,le.populated_street1_pcnt,le.populated_street2_pcnt,le.populated_street3_pcnt,le.populated_city_pcnt,le.populated_address_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_county_pcnt,le.populated_country_pcnt,le.populated_address_type_pcnt,le.populated_phone1_pcnt,le.populated_phone2_pcnt,le.populated_phone3_pcnt,le.populated_fax1_pcnt,le.populated_fax2_pcnt,le.populated_fax3_pcnt,le.populated_other_phone1_pcnt,le.populated_description_pcnt,le.populated_specialty_class_type_pcnt,le.populated_phone_number_pcnt,le.populated_phone_type_pcnt,le.populated_language_pcnt,le.populated_graduated_pcnt,le.populated_school_pcnt,le.populated_location_pcnt,le.populated_board_pcnt,le.populated_offense_pcnt,le.populated_offense_date_pcnt,le.populated_action_pcnt,le.populated_action_date_pcnt,le.populated_action_start_pcnt,le.populated_action_end_pcnt,le.populated_npi_number_pcnt,le.populated_csr_number_pcnt,le.populated_dea_number_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prepped_addr2_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_phone1_pcnt,le.populated_clean_phone2_pcnt,le.populated_clean_phone3_pcnt,le.populated_clean_fax1_pcnt,le.populated_clean_fax2_pcnt,le.populated_clean_fax3_pcnt,le.populated_clean_other_phone1_pcnt,le.populated_clean_dateofbirth_pcnt,le.populated_clean_dateofdeath_pcnt,le.populated_clean_company_name_pcnt,le.populated_clean_issue_date_pcnt,le.populated_clean_expiration_date_pcnt,le.populated_clean_offense_date_pcnt,le.populated_clean_action_date_pcnt,le.populated_src_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_lnpid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_in_state_pcnt,le.populated_in_class_pcnt,le.populated_in_status_pcnt,le.populated_in_qualifier1_pcnt,le.populated_in_qualifier2_pcnt,le.populated_mapped_class_pcnt,le.populated_mapped_status_pcnt,le.populated_mapped_qualifier1_pcnt,le.populated_mapped_qualifier2_pcnt,le.populated_mapped_pdma_pcnt,le.populated_mapped_pract_type_pcnt,le.populated_source_code_pcnt,le.populated_taxonomy_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ln_key,le.maxlength_hms_src,le.maxlength_key,le.maxlength_id,le.maxlength_entityid,le.maxlength_license_number,le.maxlength_license_class_type,le.maxlength_license_state,le.maxlength_status,le.maxlength_issue_date,le.maxlength_expiration_date,le.maxlength_qualifier1,le.maxlength_qualifier2,le.maxlength_qualifier3,le.maxlength_qualifier4,le.maxlength_qualifier5,le.maxlength_rawclass,le.maxlength_rawissue_date,le.maxlength_rawexpiration_date,le.maxlength_rawstatus,le.maxlength_raw_number,le.maxlength_name,le.maxlength_first,le.maxlength_middle,le.maxlength_last,le.maxlength_suffix,le.maxlength_cred,le.maxlength_age,le.maxlength_dateofbirth,le.maxlength_email,le.maxlength_gender,le.maxlength_dateofdeath,le.maxlength_firmname,le.maxlength_street1,le.maxlength_street2,le.maxlength_street3,le.maxlength_city,le.maxlength_address_state,le.maxlength_orig_zip,le.maxlength_orig_county,le.maxlength_country,le.maxlength_address_type,le.maxlength_phone1,le.maxlength_phone2,le.maxlength_phone3,le.maxlength_fax1,le.maxlength_fax2,le.maxlength_fax3,le.maxlength_other_phone1,le.maxlength_description,le.maxlength_specialty_class_type,le.maxlength_phone_number,le.maxlength_phone_type,le.maxlength_language,le.maxlength_graduated,le.maxlength_school,le.maxlength_location,le.maxlength_board,le.maxlength_offense,le.maxlength_offense_date,le.maxlength_action,le.maxlength_action_date,le.maxlength_action_start,le.maxlength_action_end,le.maxlength_npi_number,le.maxlength_csr_number,le.maxlength_dea_number,le.maxlength_prepped_addr1,le.maxlength_prepped_addr2,le.maxlength_clean_phone,le.maxlength_clean_phone1,le.maxlength_clean_phone2,le.maxlength_clean_phone3,le.maxlength_clean_fax1,le.maxlength_clean_fax2,le.maxlength_clean_fax3,le.maxlength_clean_other_phone1,le.maxlength_clean_dateofbirth,le.maxlength_clean_dateofdeath,le.maxlength_clean_company_name,le.maxlength_clean_issue_date,le.maxlength_clean_expiration_date,le.maxlength_clean_offense_date,le.maxlength_clean_action_date,le.maxlength_src,le.maxlength_zip,le.maxlength_zip4,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_lnpid,le.maxlength_did,le.maxlength_did_score,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_in_state,le.maxlength_in_class,le.maxlength_in_status,le.maxlength_in_qualifier1,le.maxlength_in_qualifier2,le.maxlength_mapped_class,le.maxlength_mapped_status,le.maxlength_mapped_qualifier1,le.maxlength_mapped_qualifier2,le.maxlength_mapped_pdma,le.maxlength_mapped_pract_type,le.maxlength_source_code,le.maxlength_taxonomy_code);
  SELF.avelength := CHOOSE(C,le.avelength_ln_key,le.avelength_hms_src,le.avelength_key,le.avelength_id,le.avelength_entityid,le.avelength_license_number,le.avelength_license_class_type,le.avelength_license_state,le.avelength_status,le.avelength_issue_date,le.avelength_expiration_date,le.avelength_qualifier1,le.avelength_qualifier2,le.avelength_qualifier3,le.avelength_qualifier4,le.avelength_qualifier5,le.avelength_rawclass,le.avelength_rawissue_date,le.avelength_rawexpiration_date,le.avelength_rawstatus,le.avelength_raw_number,le.avelength_name,le.avelength_first,le.avelength_middle,le.avelength_last,le.avelength_suffix,le.avelength_cred,le.avelength_age,le.avelength_dateofbirth,le.avelength_email,le.avelength_gender,le.avelength_dateofdeath,le.avelength_firmname,le.avelength_street1,le.avelength_street2,le.avelength_street3,le.avelength_city,le.avelength_address_state,le.avelength_orig_zip,le.avelength_orig_county,le.avelength_country,le.avelength_address_type,le.avelength_phone1,le.avelength_phone2,le.avelength_phone3,le.avelength_fax1,le.avelength_fax2,le.avelength_fax3,le.avelength_other_phone1,le.avelength_description,le.avelength_specialty_class_type,le.avelength_phone_number,le.avelength_phone_type,le.avelength_language,le.avelength_graduated,le.avelength_school,le.avelength_location,le.avelength_board,le.avelength_offense,le.avelength_offense_date,le.avelength_action,le.avelength_action_date,le.avelength_action_start,le.avelength_action_end,le.avelength_npi_number,le.avelength_csr_number,le.avelength_dea_number,le.avelength_prepped_addr1,le.avelength_prepped_addr2,le.avelength_clean_phone,le.avelength_clean_phone1,le.avelength_clean_phone2,le.avelength_clean_phone3,le.avelength_clean_fax1,le.avelength_clean_fax2,le.avelength_clean_fax3,le.avelength_clean_other_phone1,le.avelength_clean_dateofbirth,le.avelength_clean_dateofdeath,le.avelength_clean_company_name,le.avelength_clean_issue_date,le.avelength_clean_expiration_date,le.avelength_clean_offense_date,le.avelength_clean_action_date,le.avelength_src,le.avelength_zip,le.avelength_zip4,le.avelength_bdid,le.avelength_bdid_score,le.avelength_lnpid,le.avelength_did,le.avelength_did_score,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_in_state,le.avelength_in_class,le.avelength_in_status,le.avelength_in_qualifier1,le.avelength_in_qualifier2,le.avelength_mapped_class,le.avelength_mapped_status,le.avelength_mapped_qualifier1,le.avelength_mapped_qualifier2,le.avelength_mapped_pdma,le.avelength_mapped_pract_type,le.avelength_source_code,le.avelength_taxonomy_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 107, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.ln_key),TRIM((SALT31.StrType)le.hms_src),TRIM((SALT31.StrType)le.key),TRIM((SALT31.StrType)le.id),TRIM((SALT31.StrType)le.entityid),TRIM((SALT31.StrType)le.license_number),TRIM((SALT31.StrType)le.license_class_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.status),TRIM((SALT31.StrType)le.issue_date),TRIM((SALT31.StrType)le.expiration_date),TRIM((SALT31.StrType)le.qualifier1),TRIM((SALT31.StrType)le.qualifier2),TRIM((SALT31.StrType)le.qualifier3),TRIM((SALT31.StrType)le.qualifier4),TRIM((SALT31.StrType)le.qualifier5),TRIM((SALT31.StrType)le.rawclass),TRIM((SALT31.StrType)le.rawissue_date),TRIM((SALT31.StrType)le.rawexpiration_date),TRIM((SALT31.StrType)le.rawstatus),TRIM((SALT31.StrType)le.raw_number),TRIM((SALT31.StrType)le.name),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.age),TRIM((SALT31.StrType)le.dateofbirth),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.dateofdeath),TRIM((SALT31.StrType)le.firmname),TRIM((SALT31.StrType)le.street1),TRIM((SALT31.StrType)le.street2),TRIM((SALT31.StrType)le.street3),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.address_state),TRIM((SALT31.StrType)le.orig_zip),TRIM((SALT31.StrType)le.orig_county),TRIM((SALT31.StrType)le.country),TRIM((SALT31.StrType)le.address_type),TRIM((SALT31.StrType)le.phone1),TRIM((SALT31.StrType)le.phone2),TRIM((SALT31.StrType)le.phone3),TRIM((SALT31.StrType)le.fax1),TRIM((SALT31.StrType)le.fax2),TRIM((SALT31.StrType)le.fax3),TRIM((SALT31.StrType)le.other_phone1),TRIM((SALT31.StrType)le.description),TRIM((SALT31.StrType)le.specialty_class_type),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_type),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.graduated),TRIM((SALT31.StrType)le.school),TRIM((SALT31.StrType)le.location),TRIM((SALT31.StrType)le.board),TRIM((SALT31.StrType)le.offense),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.action),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.action_start),TRIM((SALT31.StrType)le.action_end),TRIM((SALT31.StrType)le.npi_number),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.dea_number),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.clean_phone1),TRIM((SALT31.StrType)le.clean_phone2),TRIM((SALT31.StrType)le.clean_phone3),TRIM((SALT31.StrType)le.clean_fax1),TRIM((SALT31.StrType)le.clean_fax2),TRIM((SALT31.StrType)le.clean_fax3),TRIM((SALT31.StrType)le.clean_other_phone1),TRIM((SALT31.StrType)le.clean_dateofbirth),TRIM((SALT31.StrType)le.clean_dateofdeath),TRIM((SALT31.StrType)le.clean_company_name),TRIM((SALT31.StrType)le.clean_issue_date),TRIM((SALT31.StrType)le.clean_expiration_date),TRIM((SALT31.StrType)le.clean_offense_date),TRIM((SALT31.StrType)le.clean_action_date),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.in_state),TRIM((SALT31.StrType)le.in_class),TRIM((SALT31.StrType)le.in_status),TRIM((SALT31.StrType)le.in_qualifier1),TRIM((SALT31.StrType)le.in_qualifier2),TRIM((SALT31.StrType)le.mapped_class),TRIM((SALT31.StrType)le.mapped_status),TRIM((SALT31.StrType)le.mapped_qualifier1),TRIM((SALT31.StrType)le.mapped_qualifier2),TRIM((SALT31.StrType)le.mapped_pdma),TRIM((SALT31.StrType)le.mapped_pract_type),TRIM((SALT31.StrType)le.source_code),TRIM((SALT31.StrType)le.taxonomy_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,107,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 107);
  SELF.FldNo2 := 1 + (C % 107);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.ln_key),TRIM((SALT31.StrType)le.hms_src),TRIM((SALT31.StrType)le.key),TRIM((SALT31.StrType)le.id),TRIM((SALT31.StrType)le.entityid),TRIM((SALT31.StrType)le.license_number),TRIM((SALT31.StrType)le.license_class_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.status),TRIM((SALT31.StrType)le.issue_date),TRIM((SALT31.StrType)le.expiration_date),TRIM((SALT31.StrType)le.qualifier1),TRIM((SALT31.StrType)le.qualifier2),TRIM((SALT31.StrType)le.qualifier3),TRIM((SALT31.StrType)le.qualifier4),TRIM((SALT31.StrType)le.qualifier5),TRIM((SALT31.StrType)le.rawclass),TRIM((SALT31.StrType)le.rawissue_date),TRIM((SALT31.StrType)le.rawexpiration_date),TRIM((SALT31.StrType)le.rawstatus),TRIM((SALT31.StrType)le.raw_number),TRIM((SALT31.StrType)le.name),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.age),TRIM((SALT31.StrType)le.dateofbirth),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.dateofdeath),TRIM((SALT31.StrType)le.firmname),TRIM((SALT31.StrType)le.street1),TRIM((SALT31.StrType)le.street2),TRIM((SALT31.StrType)le.street3),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.address_state),TRIM((SALT31.StrType)le.orig_zip),TRIM((SALT31.StrType)le.orig_county),TRIM((SALT31.StrType)le.country),TRIM((SALT31.StrType)le.address_type),TRIM((SALT31.StrType)le.phone1),TRIM((SALT31.StrType)le.phone2),TRIM((SALT31.StrType)le.phone3),TRIM((SALT31.StrType)le.fax1),TRIM((SALT31.StrType)le.fax2),TRIM((SALT31.StrType)le.fax3),TRIM((SALT31.StrType)le.other_phone1),TRIM((SALT31.StrType)le.description),TRIM((SALT31.StrType)le.specialty_class_type),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_type),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.graduated),TRIM((SALT31.StrType)le.school),TRIM((SALT31.StrType)le.location),TRIM((SALT31.StrType)le.board),TRIM((SALT31.StrType)le.offense),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.action),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.action_start),TRIM((SALT31.StrType)le.action_end),TRIM((SALT31.StrType)le.npi_number),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.dea_number),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.clean_phone1),TRIM((SALT31.StrType)le.clean_phone2),TRIM((SALT31.StrType)le.clean_phone3),TRIM((SALT31.StrType)le.clean_fax1),TRIM((SALT31.StrType)le.clean_fax2),TRIM((SALT31.StrType)le.clean_fax3),TRIM((SALT31.StrType)le.clean_other_phone1),TRIM((SALT31.StrType)le.clean_dateofbirth),TRIM((SALT31.StrType)le.clean_dateofdeath),TRIM((SALT31.StrType)le.clean_company_name),TRIM((SALT31.StrType)le.clean_issue_date),TRIM((SALT31.StrType)le.clean_expiration_date),TRIM((SALT31.StrType)le.clean_offense_date),TRIM((SALT31.StrType)le.clean_action_date),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.in_state),TRIM((SALT31.StrType)le.in_class),TRIM((SALT31.StrType)le.in_status),TRIM((SALT31.StrType)le.in_qualifier1),TRIM((SALT31.StrType)le.in_qualifier2),TRIM((SALT31.StrType)le.mapped_class),TRIM((SALT31.StrType)le.mapped_status),TRIM((SALT31.StrType)le.mapped_qualifier1),TRIM((SALT31.StrType)le.mapped_qualifier2),TRIM((SALT31.StrType)le.mapped_pdma),TRIM((SALT31.StrType)le.mapped_pract_type),TRIM((SALT31.StrType)le.source_code),TRIM((SALT31.StrType)le.taxonomy_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.ln_key),TRIM((SALT31.StrType)le.hms_src),TRIM((SALT31.StrType)le.key),TRIM((SALT31.StrType)le.id),TRIM((SALT31.StrType)le.entityid),TRIM((SALT31.StrType)le.license_number),TRIM((SALT31.StrType)le.license_class_type),TRIM((SALT31.StrType)le.license_state),TRIM((SALT31.StrType)le.status),TRIM((SALT31.StrType)le.issue_date),TRIM((SALT31.StrType)le.expiration_date),TRIM((SALT31.StrType)le.qualifier1),TRIM((SALT31.StrType)le.qualifier2),TRIM((SALT31.StrType)le.qualifier3),TRIM((SALT31.StrType)le.qualifier4),TRIM((SALT31.StrType)le.qualifier5),TRIM((SALT31.StrType)le.rawclass),TRIM((SALT31.StrType)le.rawissue_date),TRIM((SALT31.StrType)le.rawexpiration_date),TRIM((SALT31.StrType)le.rawstatus),TRIM((SALT31.StrType)le.raw_number),TRIM((SALT31.StrType)le.name),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.age),TRIM((SALT31.StrType)le.dateofbirth),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.gender),TRIM((SALT31.StrType)le.dateofdeath),TRIM((SALT31.StrType)le.firmname),TRIM((SALT31.StrType)le.street1),TRIM((SALT31.StrType)le.street2),TRIM((SALT31.StrType)le.street3),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.address_state),TRIM((SALT31.StrType)le.orig_zip),TRIM((SALT31.StrType)le.orig_county),TRIM((SALT31.StrType)le.country),TRIM((SALT31.StrType)le.address_type),TRIM((SALT31.StrType)le.phone1),TRIM((SALT31.StrType)le.phone2),TRIM((SALT31.StrType)le.phone3),TRIM((SALT31.StrType)le.fax1),TRIM((SALT31.StrType)le.fax2),TRIM((SALT31.StrType)le.fax3),TRIM((SALT31.StrType)le.other_phone1),TRIM((SALT31.StrType)le.description),TRIM((SALT31.StrType)le.specialty_class_type),TRIM((SALT31.StrType)le.phone_number),TRIM((SALT31.StrType)le.phone_type),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.graduated),TRIM((SALT31.StrType)le.school),TRIM((SALT31.StrType)le.location),TRIM((SALT31.StrType)le.board),TRIM((SALT31.StrType)le.offense),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.action),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.action_start),TRIM((SALT31.StrType)le.action_end),TRIM((SALT31.StrType)le.npi_number),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.dea_number),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.clean_phone1),TRIM((SALT31.StrType)le.clean_phone2),TRIM((SALT31.StrType)le.clean_phone3),TRIM((SALT31.StrType)le.clean_fax1),TRIM((SALT31.StrType)le.clean_fax2),TRIM((SALT31.StrType)le.clean_fax3),TRIM((SALT31.StrType)le.clean_other_phone1),TRIM((SALT31.StrType)le.clean_dateofbirth),TRIM((SALT31.StrType)le.clean_dateofdeath),TRIM((SALT31.StrType)le.clean_company_name),TRIM((SALT31.StrType)le.clean_issue_date),TRIM((SALT31.StrType)le.clean_expiration_date),TRIM((SALT31.StrType)le.clean_offense_date),TRIM((SALT31.StrType)le.clean_action_date),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.in_state),TRIM((SALT31.StrType)le.in_class),TRIM((SALT31.StrType)le.in_status),TRIM((SALT31.StrType)le.in_qualifier1),TRIM((SALT31.StrType)le.in_qualifier2),TRIM((SALT31.StrType)le.mapped_class),TRIM((SALT31.StrType)le.mapped_status),TRIM((SALT31.StrType)le.mapped_qualifier1),TRIM((SALT31.StrType)le.mapped_qualifier2),TRIM((SALT31.StrType)le.mapped_pdma),TRIM((SALT31.StrType)le.mapped_pract_type),TRIM((SALT31.StrType)le.source_code),TRIM((SALT31.StrType)le.taxonomy_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),107*107,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{11,'expiration_date'}
      ,{12,'qualifier1'}
      ,{13,'qualifier2'}
      ,{14,'qualifier3'}
      ,{15,'qualifier4'}
      ,{16,'qualifier5'}
      ,{17,'rawclass'}
      ,{18,'rawissue_date'}
      ,{19,'rawexpiration_date'}
      ,{20,'rawstatus'}
      ,{21,'raw_number'}
      ,{22,'name'}
      ,{23,'first'}
      ,{24,'middle'}
      ,{25,'last'}
      ,{26,'suffix'}
      ,{27,'cred'}
      ,{28,'age'}
      ,{29,'dateofbirth'}
      ,{30,'email'}
      ,{31,'gender'}
      ,{32,'dateofdeath'}
      ,{33,'firmname'}
      ,{34,'street1'}
      ,{35,'street2'}
      ,{36,'street3'}
      ,{37,'city'}
      ,{38,'address_state'}
      ,{39,'orig_zip'}
      ,{40,'orig_county'}
      ,{41,'country'}
      ,{42,'address_type'}
      ,{43,'phone1'}
      ,{44,'phone2'}
      ,{45,'phone3'}
      ,{46,'fax1'}
      ,{47,'fax2'}
      ,{48,'fax3'}
      ,{49,'other_phone1'}
      ,{50,'description'}
      ,{51,'specialty_class_type'}
      ,{52,'phone_number'}
      ,{53,'phone_type'}
      ,{54,'language'}
      ,{55,'graduated'}
      ,{56,'school'}
      ,{57,'location'}
      ,{58,'board'}
      ,{59,'offense'}
      ,{60,'offense_date'}
      ,{61,'action'}
      ,{62,'action_date'}
      ,{63,'action_start'}
      ,{64,'action_end'}
      ,{65,'npi_number'}
      ,{66,'csr_number'}
      ,{67,'dea_number'}
      ,{68,'prepped_addr1'}
      ,{69,'prepped_addr2'}
      ,{70,'clean_phone'}
      ,{71,'clean_phone1'}
      ,{72,'clean_phone2'}
      ,{73,'clean_phone3'}
      ,{74,'clean_fax1'}
      ,{75,'clean_fax2'}
      ,{76,'clean_fax3'}
      ,{77,'clean_other_phone1'}
      ,{78,'clean_dateofbirth'}
      ,{79,'clean_dateofdeath'}
      ,{80,'clean_company_name'}
      ,{81,'clean_issue_date'}
      ,{82,'clean_expiration_date'}
      ,{83,'clean_offense_date'}
      ,{84,'clean_action_date'}
      ,{85,'src'}
      ,{86,'zip'}
      ,{87,'zip4'}
      ,{88,'bdid'}
      ,{89,'bdid_score'}
      ,{90,'lnpid'}
      ,{91,'did'}
      ,{92,'did_score'}
      ,{93,'dt_vendor_first_reported'}
      ,{94,'dt_vendor_last_reported'}
      ,{95,'in_state'}
      ,{96,'in_class'}
      ,{97,'in_status'}
      ,{98,'in_qualifier1'}
      ,{99,'in_qualifier2'}
      ,{100,'mapped_class'}
      ,{101,'mapped_status'}
      ,{102,'mapped_qualifier1'}
      ,{103,'mapped_qualifier2'}
      ,{104,'mapped_pdma'}
      ,{105,'mapped_pract_type'}
      ,{106,'source_code'}
      ,{107,'taxonomy_code'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    HmsStlic_Fields.InValid_ln_key((SALT31.StrType)le.ln_key),
    HmsStlic_Fields.InValid_hms_src((SALT31.StrType)le.hms_src),
    HmsStlic_Fields.InValid_key((SALT31.StrType)le.key),
    HmsStlic_Fields.InValid_id((SALT31.StrType)le.id),
    HmsStlic_Fields.InValid_entityid((SALT31.StrType)le.entityid),
    HmsStlic_Fields.InValid_license_number((SALT31.StrType)le.license_number),
    HmsStlic_Fields.InValid_license_class_type((SALT31.StrType)le.license_class_type),
    HmsStlic_Fields.InValid_license_state((SALT31.StrType)le.license_state),
    HmsStlic_Fields.InValid_status((SALT31.StrType)le.status),
    HmsStlic_Fields.InValid_issue_date((SALT31.StrType)le.issue_date),
    HmsStlic_Fields.InValid_expiration_date((SALT31.StrType)le.expiration_date),
    HmsStlic_Fields.InValid_qualifier1((SALT31.StrType)le.qualifier1),
    HmsStlic_Fields.InValid_qualifier2((SALT31.StrType)le.qualifier2),
    HmsStlic_Fields.InValid_qualifier3((SALT31.StrType)le.qualifier3),
    HmsStlic_Fields.InValid_qualifier4((SALT31.StrType)le.qualifier4),
    HmsStlic_Fields.InValid_qualifier5((SALT31.StrType)le.qualifier5),
    HmsStlic_Fields.InValid_rawclass((SALT31.StrType)le.rawclass),
    HmsStlic_Fields.InValid_rawissue_date((SALT31.StrType)le.rawissue_date),
    HmsStlic_Fields.InValid_rawexpiration_date((SALT31.StrType)le.rawexpiration_date),
    HmsStlic_Fields.InValid_rawstatus((SALT31.StrType)le.rawstatus),
    HmsStlic_Fields.InValid_raw_number((SALT31.StrType)le.raw_number),
    HmsStlic_Fields.InValid_name((SALT31.StrType)le.name),
    HmsStlic_Fields.InValid_first((SALT31.StrType)le.first),
    HmsStlic_Fields.InValid_middle((SALT31.StrType)le.middle),
    HmsStlic_Fields.InValid_last((SALT31.StrType)le.last),
    HmsStlic_Fields.InValid_suffix((SALT31.StrType)le.suffix),
    HmsStlic_Fields.InValid_cred((SALT31.StrType)le.cred),
    HmsStlic_Fields.InValid_age((SALT31.StrType)le.age),
    HmsStlic_Fields.InValid_dateofbirth((SALT31.StrType)le.dateofbirth),
    HmsStlic_Fields.InValid_email((SALT31.StrType)le.email),
    HmsStlic_Fields.InValid_gender((SALT31.StrType)le.gender),
    HmsStlic_Fields.InValid_dateofdeath((SALT31.StrType)le.dateofdeath),
    HmsStlic_Fields.InValid_firmname((SALT31.StrType)le.firmname),
    HmsStlic_Fields.InValid_street1((SALT31.StrType)le.street1),
    HmsStlic_Fields.InValid_street2((SALT31.StrType)le.street2),
    HmsStlic_Fields.InValid_street3((SALT31.StrType)le.street3),
    HmsStlic_Fields.InValid_city((SALT31.StrType)le.city),
    HmsStlic_Fields.InValid_address_state((SALT31.StrType)le.address_state),
    HmsStlic_Fields.InValid_orig_zip((SALT31.StrType)le.orig_zip),
    HmsStlic_Fields.InValid_orig_county((SALT31.StrType)le.orig_county),
    HmsStlic_Fields.InValid_country((SALT31.StrType)le.country),
    HmsStlic_Fields.InValid_address_type((SALT31.StrType)le.address_type),
    HmsStlic_Fields.InValid_phone1((SALT31.StrType)le.phone1),
    HmsStlic_Fields.InValid_phone2((SALT31.StrType)le.phone2),
    HmsStlic_Fields.InValid_phone3((SALT31.StrType)le.phone3),
    HmsStlic_Fields.InValid_fax1((SALT31.StrType)le.fax1),
    HmsStlic_Fields.InValid_fax2((SALT31.StrType)le.fax2),
    HmsStlic_Fields.InValid_fax3((SALT31.StrType)le.fax3),
    HmsStlic_Fields.InValid_other_phone1((SALT31.StrType)le.other_phone1),
    HmsStlic_Fields.InValid_description((SALT31.StrType)le.description),
    HmsStlic_Fields.InValid_specialty_class_type((SALT31.StrType)le.specialty_class_type),
    HmsStlic_Fields.InValid_phone_number((SALT31.StrType)le.phone_number),
    HmsStlic_Fields.InValid_phone_type((SALT31.StrType)le.phone_type),
    HmsStlic_Fields.InValid_language((SALT31.StrType)le.language),
    HmsStlic_Fields.InValid_graduated((SALT31.StrType)le.graduated),
    HmsStlic_Fields.InValid_school((SALT31.StrType)le.school),
    HmsStlic_Fields.InValid_location((SALT31.StrType)le.location),
    HmsStlic_Fields.InValid_board((SALT31.StrType)le.board),
    HmsStlic_Fields.InValid_offense((SALT31.StrType)le.offense),
    HmsStlic_Fields.InValid_offense_date((SALT31.StrType)le.offense_date),
    HmsStlic_Fields.InValid_action((SALT31.StrType)le.action),
    HmsStlic_Fields.InValid_action_date((SALT31.StrType)le.action_date),
    HmsStlic_Fields.InValid_action_start((SALT31.StrType)le.action_start),
    HmsStlic_Fields.InValid_action_end((SALT31.StrType)le.action_end),
    HmsStlic_Fields.InValid_npi_number((SALT31.StrType)le.npi_number),
    HmsStlic_Fields.InValid_csr_number((SALT31.StrType)le.csr_number),
    HmsStlic_Fields.InValid_dea_number((SALT31.StrType)le.dea_number),
    HmsStlic_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1),
    HmsStlic_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2),
    HmsStlic_Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone),
    HmsStlic_Fields.InValid_clean_phone1((SALT31.StrType)le.clean_phone1),
    HmsStlic_Fields.InValid_clean_phone2((SALT31.StrType)le.clean_phone2),
    HmsStlic_Fields.InValid_clean_phone3((SALT31.StrType)le.clean_phone3),
    HmsStlic_Fields.InValid_clean_fax1((SALT31.StrType)le.clean_fax1),
    HmsStlic_Fields.InValid_clean_fax2((SALT31.StrType)le.clean_fax2),
    HmsStlic_Fields.InValid_clean_fax3((SALT31.StrType)le.clean_fax3),
    HmsStlic_Fields.InValid_clean_other_phone1((SALT31.StrType)le.clean_other_phone1),
    HmsStlic_Fields.InValid_clean_dateofbirth((SALT31.StrType)le.clean_dateofbirth),
    HmsStlic_Fields.InValid_clean_dateofdeath((SALT31.StrType)le.clean_dateofdeath),
    HmsStlic_Fields.InValid_clean_company_name((SALT31.StrType)le.clean_company_name),
    HmsStlic_Fields.InValid_clean_issue_date((SALT31.StrType)le.clean_issue_date),
    HmsStlic_Fields.InValid_clean_expiration_date((SALT31.StrType)le.clean_expiration_date),
    HmsStlic_Fields.InValid_clean_offense_date((SALT31.StrType)le.clean_offense_date),
    HmsStlic_Fields.InValid_clean_action_date((SALT31.StrType)le.clean_action_date),
    HmsStlic_Fields.InValid_src((SALT31.StrType)le.src),
    HmsStlic_Fields.InValid_zip((SALT31.StrType)le.zip),
    HmsStlic_Fields.InValid_zip4((SALT31.StrType)le.zip4),
    HmsStlic_Fields.InValid_bdid((SALT31.StrType)le.bdid),
    HmsStlic_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score),
    HmsStlic_Fields.InValid_lnpid((SALT31.StrType)le.lnpid),
    HmsStlic_Fields.InValid_did((SALT31.StrType)le.did),
    HmsStlic_Fields.InValid_did_score((SALT31.StrType)le.did_score),
    HmsStlic_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported),
    HmsStlic_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported),
    HmsStlic_Fields.InValid_in_state((SALT31.StrType)le.in_state),
    HmsStlic_Fields.InValid_in_class((SALT31.StrType)le.in_class),
    HmsStlic_Fields.InValid_in_status((SALT31.StrType)le.in_status),
    HmsStlic_Fields.InValid_in_qualifier1((SALT31.StrType)le.in_qualifier1),
    HmsStlic_Fields.InValid_in_qualifier2((SALT31.StrType)le.in_qualifier2),
    HmsStlic_Fields.InValid_mapped_class((SALT31.StrType)le.mapped_class),
    HmsStlic_Fields.InValid_mapped_status((SALT31.StrType)le.mapped_status),
    HmsStlic_Fields.InValid_mapped_qualifier1((SALT31.StrType)le.mapped_qualifier1),
    HmsStlic_Fields.InValid_mapped_qualifier2((SALT31.StrType)le.mapped_qualifier2),
    HmsStlic_Fields.InValid_mapped_pdma((SALT31.StrType)le.mapped_pdma),
    HmsStlic_Fields.InValid_mapped_pract_type((SALT31.StrType)le.mapped_pract_type),
    HmsStlic_Fields.InValid_source_code((SALT31.StrType)le.source_code),
    HmsStlic_Fields.InValid_taxonomy_code((SALT31.StrType)le.taxonomy_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,107,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := HmsStlic_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','graduated','school','location','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','csr_number','dea_number','prepped_addr1','prepped_addr2','clean_phone','clean_phone1','clean_phone2','clean_phone3','clean_fax1','clean_fax2','clean_fax3','clean_other_phone1','clean_dateofbirth','clean_dateofdeath','clean_company_name','clean_issue_date','clean_expiration_date','clean_offense_date','clean_action_date','src','zip','zip4','bdid','bdid_score','lnpid','did','did_score','dt_vendor_first_reported','dt_vendor_last_reported','in_state','in_class','in_status','in_qualifier1','in_qualifier2','mapped_class','mapped_status','mapped_qualifier1','mapped_qualifier2','mapped_pdma','mapped_pract_type','source_code','taxonomy_code');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,HmsStlic_Fields.InValidMessage_ln_key(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_hms_src(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_key(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_id(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_entityid(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_license_number(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_license_class_type(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_license_state(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_status(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_issue_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_qualifier1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_qualifier2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_qualifier3(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_qualifier4(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_qualifier5(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_rawclass(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_rawissue_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_rawexpiration_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_rawstatus(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_raw_number(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_name(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_first(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_middle(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_last(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_cred(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_age(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_dateofbirth(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_email(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_gender(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_dateofdeath(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_firmname(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_street1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_street2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_street3(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_city(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_address_state(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_country(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_address_type(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_phone1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_phone2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_phone3(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_fax1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_fax2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_fax3(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_other_phone1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_description(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_specialty_class_type(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_language(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_graduated(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_school(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_location(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_board(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_offense(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_offense_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_action(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_action_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_action_start(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_action_end(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_npi_number(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_csr_number(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_dea_number(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_phone1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_phone2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_phone3(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_fax1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_fax2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_fax3(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_other_phone1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_dateofbirth(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_dateofdeath(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_issue_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_expiration_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_offense_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_clean_action_date(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_src(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_zip(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_did(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_in_state(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_in_class(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_in_status(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_in_qualifier1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_in_qualifier2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_mapped_class(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_mapped_status(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_mapped_qualifier1(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_mapped_qualifier2(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_mapped_pdma(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_mapped_pract_type(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),HmsStlic_Fields.InValidMessage_taxonomy_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
