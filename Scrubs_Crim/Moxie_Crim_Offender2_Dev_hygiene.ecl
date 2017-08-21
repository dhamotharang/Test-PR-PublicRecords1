IMPORT ut,SALT33;
EXPORT Moxie_Crim_Offender2_Dev_hygiene(dataset(Moxie_Crim_Offender2_Dev_layout_crim) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.vendor);    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
    populated_offender_key_pcnt := AVE(GROUP,IF(h.offender_key = (TYPEOF(h.offender_key))'',0,100));
    maxlength_offender_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_key)));
    avelength_offender_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_key)),h.offender_key<>(typeof(h.offender_key))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_id_num_pcnt := AVE(GROUP,IF(h.id_num = (TYPEOF(h.id_num))'',0,100));
    maxlength_id_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.id_num)));
    avelength_id_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.id_num)),h.id_num<>(typeof(h.id_num))'');
    populated_pty_nm_pcnt := AVE(GROUP,IF(h.pty_nm = (TYPEOF(h.pty_nm))'',0,100));
    maxlength_pty_nm := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pty_nm)));
    avelength_pty_nm := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pty_nm)),h.pty_nm<>(typeof(h.pty_nm))'');
    populated_pty_nm_fmt_pcnt := AVE(GROUP,IF(h.pty_nm_fmt = (TYPEOF(h.pty_nm_fmt))'',0,100));
    maxlength_pty_nm_fmt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pty_nm_fmt)));
    avelength_pty_nm_fmt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pty_nm_fmt)),h.pty_nm_fmt<>(typeof(h.pty_nm_fmt))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_pty_typ_pcnt := AVE(GROUP,IF(h.pty_typ = (TYPEOF(h.pty_typ))'',0,100));
    maxlength_pty_typ := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pty_typ)));
    avelength_pty_typ := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pty_typ)),h.pty_typ<>(typeof(h.pty_typ))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_ntype_pcnt := AVE(GROUP,IF(h.ntype = (TYPEOF(h.ntype))'',0,100));
    maxlength_ntype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ntype)));
    avelength_ntype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ntype)),h.ntype<>(typeof(h.ntype))'');
    populated_nindicator_pcnt := AVE(GROUP,IF(h.nindicator = (TYPEOF(h.nindicator))'',0,100));
    maxlength_nindicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nindicator)));
    avelength_nindicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nindicator)),h.nindicator<>(typeof(h.nindicator))'');
    populated_nitro_flag_pcnt := AVE(GROUP,IF(h.nitro_flag = (TYPEOF(h.nitro_flag))'',0,100));
    maxlength_nitro_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nitro_flag)));
    avelength_nitro_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nitro_flag)),h.nitro_flag<>(typeof(h.nitro_flag))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_case_num_pcnt := AVE(GROUP,IF(h.case_num = (TYPEOF(h.case_num))'',0,100));
    maxlength_case_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_num)));
    avelength_case_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_num)),h.case_num<>(typeof(h.case_num))'');
    populated_case_court_pcnt := AVE(GROUP,IF(h.case_court = (TYPEOF(h.case_court))'',0,100));
    maxlength_case_court := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_court)));
    avelength_case_court := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_court)),h.case_court<>(typeof(h.case_court))'');
    populated_case_date_pcnt := AVE(GROUP,IF(h.case_date = (TYPEOF(h.case_date))'',0,100));
    maxlength_case_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_date)));
    avelength_case_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_date)),h.case_date<>(typeof(h.case_date))'');
    populated_case_type_pcnt := AVE(GROUP,IF(h.case_type = (TYPEOF(h.case_type))'',0,100));
    maxlength_case_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_type)));
    avelength_case_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_type)),h.case_type<>(typeof(h.case_type))'');
    populated_case_type_desc_pcnt := AVE(GROUP,IF(h.case_type_desc = (TYPEOF(h.case_type_desc))'',0,100));
    maxlength_case_type_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_type_desc)));
    avelength_case_type_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_type_desc)),h.case_type_desc<>(typeof(h.case_type_desc))'');
    populated_county_of_origin_pcnt := AVE(GROUP,IF(h.county_of_origin = (TYPEOF(h.county_of_origin))'',0,100));
    maxlength_county_of_origin := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county_of_origin)));
    avelength_county_of_origin := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county_of_origin)),h.county_of_origin<>(typeof(h.county_of_origin))'');
    populated_dle_num_pcnt := AVE(GROUP,IF(h.dle_num = (TYPEOF(h.dle_num))'',0,100));
    maxlength_dle_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dle_num)));
    avelength_dle_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dle_num)),h.dle_num<>(typeof(h.dle_num))'');
    populated_fbi_num_pcnt := AVE(GROUP,IF(h.fbi_num = (TYPEOF(h.fbi_num))'',0,100));
    maxlength_fbi_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fbi_num)));
    avelength_fbi_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fbi_num)),h.fbi_num<>(typeof(h.fbi_num))'');
    populated_doc_num_pcnt := AVE(GROUP,IF(h.doc_num = (TYPEOF(h.doc_num))'',0,100));
    maxlength_doc_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.doc_num)));
    avelength_doc_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.doc_num)),h.doc_num<>(typeof(h.doc_num))'');
    populated_ins_num_pcnt := AVE(GROUP,IF(h.ins_num = (TYPEOF(h.ins_num))'',0,100));
    maxlength_ins_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ins_num)));
    avelength_ins_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ins_num)),h.ins_num<>(typeof(h.ins_num))'');
    populated_dl_num_pcnt := AVE(GROUP,IF(h.dl_num = (TYPEOF(h.dl_num))'',0,100));
    maxlength_dl_num := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dl_num)));
    avelength_dl_num := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dl_num)),h.dl_num<>(typeof(h.dl_num))'');
    populated_dl_state_pcnt := AVE(GROUP,IF(h.dl_state = (TYPEOF(h.dl_state))'',0,100));
    maxlength_dl_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dl_state)));
    avelength_dl_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dl_state)),h.dl_state<>(typeof(h.dl_state))'');
    populated_citizenship_pcnt := AVE(GROUP,IF(h.citizenship = (TYPEOF(h.citizenship))'',0,100));
    maxlength_citizenship := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.citizenship)));
    avelength_citizenship := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.citizenship)),h.citizenship<>(typeof(h.citizenship))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_dob_alias_pcnt := AVE(GROUP,IF(h.dob_alias = (TYPEOF(h.dob_alias))'',0,100));
    maxlength_dob_alias := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob_alias)));
    avelength_dob_alias := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob_alias)),h.dob_alias<>(typeof(h.dob_alias))'');
    populated_county_of_birth_pcnt := AVE(GROUP,IF(h.county_of_birth = (TYPEOF(h.county_of_birth))'',0,100));
    maxlength_county_of_birth := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county_of_birth)));
    avelength_county_of_birth := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county_of_birth)),h.county_of_birth<>(typeof(h.county_of_birth))'');
    populated_place_of_birth_pcnt := AVE(GROUP,IF(h.place_of_birth = (TYPEOF(h.place_of_birth))'',0,100));
    maxlength_place_of_birth := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.place_of_birth)));
    avelength_place_of_birth := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.place_of_birth)),h.place_of_birth<>(typeof(h.place_of_birth))'');
    populated_street_address_1_pcnt := AVE(GROUP,IF(h.street_address_1 = (TYPEOF(h.street_address_1))'',0,100));
    maxlength_street_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_1)));
    avelength_street_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_1)),h.street_address_1<>(typeof(h.street_address_1))'');
    populated_street_address_2_pcnt := AVE(GROUP,IF(h.street_address_2 = (TYPEOF(h.street_address_2))'',0,100));
    maxlength_street_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_2)));
    avelength_street_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_2)),h.street_address_2<>(typeof(h.street_address_2))'');
    populated_street_address_3_pcnt := AVE(GROUP,IF(h.street_address_3 = (TYPEOF(h.street_address_3))'',0,100));
    maxlength_street_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_3)));
    avelength_street_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_3)),h.street_address_3<>(typeof(h.street_address_3))'');
    populated_street_address_4_pcnt := AVE(GROUP,IF(h.street_address_4 = (TYPEOF(h.street_address_4))'',0,100));
    maxlength_street_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_4)));
    avelength_street_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_4)),h.street_address_4<>(typeof(h.street_address_4))'');
    populated_street_address_5_pcnt := AVE(GROUP,IF(h.street_address_5 = (TYPEOF(h.street_address_5))'',0,100));
    maxlength_street_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_5)));
    avelength_street_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.street_address_5)),h.street_address_5<>(typeof(h.street_address_5))'');
    populated_current_residence_county_pcnt := AVE(GROUP,IF(h.current_residence_county = (TYPEOF(h.current_residence_county))'',0,100));
    maxlength_current_residence_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.current_residence_county)));
    avelength_current_residence_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.current_residence_county)),h.current_residence_county<>(typeof(h.current_residence_county))'');
    populated_legal_residence_county_pcnt := AVE(GROUP,IF(h.legal_residence_county = (TYPEOF(h.legal_residence_county))'',0,100));
    maxlength_legal_residence_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_residence_county)));
    avelength_legal_residence_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_residence_county)),h.legal_residence_county<>(typeof(h.legal_residence_county))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_race_desc_pcnt := AVE(GROUP,IF(h.race_desc = (TYPEOF(h.race_desc))'',0,100));
    maxlength_race_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.race_desc)));
    avelength_race_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.race_desc)),h.race_desc<>(typeof(h.race_desc))'');
    populated_sex_pcnt := AVE(GROUP,IF(h.sex = (TYPEOF(h.sex))'',0,100));
    maxlength_sex := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sex)));
    avelength_sex := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sex)),h.sex<>(typeof(h.sex))'');
    populated_hair_color_pcnt := AVE(GROUP,IF(h.hair_color = (TYPEOF(h.hair_color))'',0,100));
    maxlength_hair_color := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.hair_color)));
    avelength_hair_color := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.hair_color)),h.hair_color<>(typeof(h.hair_color))'');
    populated_hair_color_desc_pcnt := AVE(GROUP,IF(h.hair_color_desc = (TYPEOF(h.hair_color_desc))'',0,100));
    maxlength_hair_color_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.hair_color_desc)));
    avelength_hair_color_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.hair_color_desc)),h.hair_color_desc<>(typeof(h.hair_color_desc))'');
    populated_eye_color_pcnt := AVE(GROUP,IF(h.eye_color = (TYPEOF(h.eye_color))'',0,100));
    maxlength_eye_color := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.eye_color)));
    avelength_eye_color := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.eye_color)),h.eye_color<>(typeof(h.eye_color))'');
    populated_eye_color_desc_pcnt := AVE(GROUP,IF(h.eye_color_desc = (TYPEOF(h.eye_color_desc))'',0,100));
    maxlength_eye_color_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.eye_color_desc)));
    avelength_eye_color_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.eye_color_desc)),h.eye_color_desc<>(typeof(h.eye_color_desc))'');
    populated_skin_color_pcnt := AVE(GROUP,IF(h.skin_color = (TYPEOF(h.skin_color))'',0,100));
    maxlength_skin_color := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.skin_color)));
    avelength_skin_color := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.skin_color)),h.skin_color<>(typeof(h.skin_color))'');
    populated_skin_color_desc_pcnt := AVE(GROUP,IF(h.skin_color_desc = (TYPEOF(h.skin_color_desc))'',0,100));
    maxlength_skin_color_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.skin_color_desc)));
    avelength_skin_color_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.skin_color_desc)),h.skin_color_desc<>(typeof(h.skin_color_desc))'');
    populated_scars_marks_tattoos_1_pcnt := AVE(GROUP,IF(h.scars_marks_tattoos_1 = (TYPEOF(h.scars_marks_tattoos_1))'',0,100));
    maxlength_scars_marks_tattoos_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_1)));
    avelength_scars_marks_tattoos_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_1)),h.scars_marks_tattoos_1<>(typeof(h.scars_marks_tattoos_1))'');
    populated_scars_marks_tattoos_2_pcnt := AVE(GROUP,IF(h.scars_marks_tattoos_2 = (TYPEOF(h.scars_marks_tattoos_2))'',0,100));
    maxlength_scars_marks_tattoos_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_2)));
    avelength_scars_marks_tattoos_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_2)),h.scars_marks_tattoos_2<>(typeof(h.scars_marks_tattoos_2))'');
    populated_scars_marks_tattoos_3_pcnt := AVE(GROUP,IF(h.scars_marks_tattoos_3 = (TYPEOF(h.scars_marks_tattoos_3))'',0,100));
    maxlength_scars_marks_tattoos_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_3)));
    avelength_scars_marks_tattoos_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_3)),h.scars_marks_tattoos_3<>(typeof(h.scars_marks_tattoos_3))'');
    populated_scars_marks_tattoos_4_pcnt := AVE(GROUP,IF(h.scars_marks_tattoos_4 = (TYPEOF(h.scars_marks_tattoos_4))'',0,100));
    maxlength_scars_marks_tattoos_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_4)));
    avelength_scars_marks_tattoos_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_4)),h.scars_marks_tattoos_4<>(typeof(h.scars_marks_tattoos_4))'');
    populated_scars_marks_tattoos_5_pcnt := AVE(GROUP,IF(h.scars_marks_tattoos_5 = (TYPEOF(h.scars_marks_tattoos_5))'',0,100));
    maxlength_scars_marks_tattoos_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_5)));
    avelength_scars_marks_tattoos_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos_5)),h.scars_marks_tattoos_5<>(typeof(h.scars_marks_tattoos_5))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_party_status_pcnt := AVE(GROUP,IF(h.party_status = (TYPEOF(h.party_status))'',0,100));
    maxlength_party_status := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_status)));
    avelength_party_status := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_status)),h.party_status<>(typeof(h.party_status))'');
    populated_party_status_desc_pcnt := AVE(GROUP,IF(h.party_status_desc = (TYPEOF(h.party_status_desc))'',0,100));
    maxlength_party_status_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_status_desc)));
    avelength_party_status_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.party_status_desc)),h.party_status_desc<>(typeof(h.party_status_desc))'');
    populated__3g_offender_pcnt := AVE(GROUP,IF(h._3g_offender = (TYPEOF(h._3g_offender))'',0,100));
    maxlength__3g_offender := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h._3g_offender)));
    avelength__3g_offender := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h._3g_offender)),h._3g_offender<>(typeof(h._3g_offender))'');
    populated_violent_offender_pcnt := AVE(GROUP,IF(h.violent_offender = (TYPEOF(h.violent_offender))'',0,100));
    maxlength_violent_offender := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.violent_offender)));
    avelength_violent_offender := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.violent_offender)),h.violent_offender<>(typeof(h.violent_offender))'');
    populated_sex_offender_pcnt := AVE(GROUP,IF(h.sex_offender = (TYPEOF(h.sex_offender))'',0,100));
    maxlength_sex_offender := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sex_offender)));
    avelength_sex_offender := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sex_offender)),h.sex_offender<>(typeof(h.sex_offender))'');
    populated_vop_offender_pcnt := AVE(GROUP,IF(h.vop_offender = (TYPEOF(h.vop_offender))'',0,100));
    maxlength_vop_offender := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vop_offender)));
    avelength_vop_offender := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vop_offender)),h.vop_offender<>(typeof(h.vop_offender))'');
    populated_data_type_pcnt := AVE(GROUP,IF(h.data_type = (TYPEOF(h.data_type))'',0,100));
    maxlength_data_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.data_type)));
    avelength_data_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.data_type)),h.data_type<>(typeof(h.data_type))'');
    populated_record_setup_date_pcnt := AVE(GROUP,IF(h.record_setup_date = (TYPEOF(h.record_setup_date))'',0,100));
    maxlength_record_setup_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_setup_date)));
    avelength_record_setup_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_setup_date)),h.record_setup_date<>(typeof(h.record_setup_date))'');
    populated_datasource_pcnt := AVE(GROUP,IF(h.datasource = (TYPEOF(h.datasource))'',0,100));
    maxlength_datasource := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.datasource)));
    avelength_datasource := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.datasource)),h.datasource<>(typeof(h.datasource))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_ace_fips_county_pcnt := AVE(GROUP,IF(h.ace_fips_county = (TYPEOF(h.ace_fips_county))'',0,100));
    maxlength_ace_fips_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ace_fips_county)));
    avelength_ace_fips_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ace_fips_county)),h.ace_fips_county<>(typeof(h.ace_fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_clean_errors_pcnt := AVE(GROUP,IF(h.clean_errors = (TYPEOF(h.clean_errors))'',0,100));
    maxlength_clean_errors := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_errors)));
    avelength_clean_errors := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_errors)),h.clean_errors<>(typeof(h.clean_errors))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_score_pcnt := AVE(GROUP,IF(h.score = (TYPEOF(h.score))'',0,100));
    maxlength_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.score)));
    avelength_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.score)),h.score<>(typeof(h.score))'');
    populated_ssn_appended_pcnt := AVE(GROUP,IF(h.ssn_appended = (TYPEOF(h.ssn_appended))'',0,100));
    maxlength_ssn_appended := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn_appended)));
    avelength_ssn_appended := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn_appended)),h.ssn_appended<>(typeof(h.ssn_appended))'');
    populated_curr_incar_flag_pcnt := AVE(GROUP,IF(h.curr_incar_flag = (TYPEOF(h.curr_incar_flag))'',0,100));
    maxlength_curr_incar_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_incar_flag)));
    avelength_curr_incar_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_incar_flag)),h.curr_incar_flag<>(typeof(h.curr_incar_flag))'');
    populated_curr_parole_flag_pcnt := AVE(GROUP,IF(h.curr_parole_flag = (TYPEOF(h.curr_parole_flag))'',0,100));
    maxlength_curr_parole_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_parole_flag)));
    avelength_curr_parole_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_parole_flag)),h.curr_parole_flag<>(typeof(h.curr_parole_flag))'');
    populated_curr_probation_flag_pcnt := AVE(GROUP,IF(h.curr_probation_flag = (TYPEOF(h.curr_probation_flag))'',0,100));
    maxlength_curr_probation_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_probation_flag)));
    avelength_curr_probation_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_probation_flag)),h.curr_probation_flag<>(typeof(h.curr_probation_flag))'');
    populated_src_upload_date_pcnt := AVE(GROUP,IF(h.src_upload_date = (TYPEOF(h.src_upload_date))'',0,100));
    maxlength_src_upload_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.src_upload_date)));
    avelength_src_upload_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.src_upload_date)),h.src_upload_date<>(typeof(h.src_upload_date))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_image_link_pcnt := AVE(GROUP,IF(h.image_link = (TYPEOF(h.image_link))'',0,100));
    maxlength_image_link := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.image_link)));
    avelength_image_link := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.image_link)),h.image_link<>(typeof(h.image_link))'');
    populated_fcra_conviction_flag_pcnt := AVE(GROUP,IF(h.fcra_conviction_flag = (TYPEOF(h.fcra_conviction_flag))'',0,100));
    maxlength_fcra_conviction_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_conviction_flag)));
    avelength_fcra_conviction_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_conviction_flag)),h.fcra_conviction_flag<>(typeof(h.fcra_conviction_flag))'');
    populated_fcra_traffic_flag_pcnt := AVE(GROUP,IF(h.fcra_traffic_flag = (TYPEOF(h.fcra_traffic_flag))'',0,100));
    maxlength_fcra_traffic_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_traffic_flag)));
    avelength_fcra_traffic_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_traffic_flag)),h.fcra_traffic_flag<>(typeof(h.fcra_traffic_flag))'');
    populated_fcra_date_pcnt := AVE(GROUP,IF(h.fcra_date = (TYPEOF(h.fcra_date))'',0,100));
    maxlength_fcra_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)));
    avelength_fcra_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)),h.fcra_date<>(typeof(h.fcra_date))'');
    populated_fcra_date_type_pcnt := AVE(GROUP,IF(h.fcra_date_type = (TYPEOF(h.fcra_date_type))'',0,100));
    maxlength_fcra_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)));
    avelength_fcra_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)),h.fcra_date_type<>(typeof(h.fcra_date_type))'');
    populated_conviction_override_date_pcnt := AVE(GROUP,IF(h.conviction_override_date = (TYPEOF(h.conviction_override_date))'',0,100));
    maxlength_conviction_override_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)));
    avelength_conviction_override_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)),h.conviction_override_date<>(typeof(h.conviction_override_date))'');
    populated_conviction_override_date_type_pcnt := AVE(GROUP,IF(h.conviction_override_date_type = (TYPEOF(h.conviction_override_date_type))'',0,100));
    maxlength_conviction_override_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)));
    avelength_conviction_override_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)),h.conviction_override_date_type<>(typeof(h.conviction_override_date_type))'');
    populated_offense_score_pcnt := AVE(GROUP,IF(h.offense_score = (TYPEOF(h.offense_score))'',0,100));
    maxlength_offense_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_score)));
    avelength_offense_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_score)),h.offense_score<>(typeof(h.offense_score))'');
    populated_offender_persistent_id_pcnt := AVE(GROUP,IF(h.offender_persistent_id = (TYPEOF(h.offender_persistent_id))'',0,100));
    maxlength_offender_persistent_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_persistent_id)));
    avelength_offender_persistent_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_persistent_id)),h.offender_persistent_id<>(typeof(h.offender_persistent_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100 + T.Populated_offender_key_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_id_num_pcnt *   0.00 / 100 + T.Populated_pty_nm_pcnt *   0.00 / 100 + T.Populated_pty_nm_fmt_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_pty_typ_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_ntype_pcnt *   0.00 / 100 + T.Populated_nindicator_pcnt *   0.00 / 100 + T.Populated_nitro_flag_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_case_num_pcnt *   0.00 / 100 + T.Populated_case_court_pcnt *   0.00 / 100 + T.Populated_case_date_pcnt *   0.00 / 100 + T.Populated_case_type_pcnt *   0.00 / 100 + T.Populated_case_type_desc_pcnt *   0.00 / 100 + T.Populated_county_of_origin_pcnt *   0.00 / 100 + T.Populated_dle_num_pcnt *   0.00 / 100 + T.Populated_fbi_num_pcnt *   0.00 / 100 + T.Populated_doc_num_pcnt *   0.00 / 100 + T.Populated_ins_num_pcnt *   0.00 / 100 + T.Populated_dl_num_pcnt *   0.00 / 100 + T.Populated_dl_state_pcnt *   0.00 / 100 + T.Populated_citizenship_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_dob_alias_pcnt *   0.00 / 100 + T.Populated_county_of_birth_pcnt *   0.00 / 100 + T.Populated_place_of_birth_pcnt *   0.00 / 100 + T.Populated_street_address_1_pcnt *   0.00 / 100 + T.Populated_street_address_2_pcnt *   0.00 / 100 + T.Populated_street_address_3_pcnt *   0.00 / 100 + T.Populated_street_address_4_pcnt *   0.00 / 100 + T.Populated_street_address_5_pcnt *   0.00 / 100 + T.Populated_current_residence_county_pcnt *   0.00 / 100 + T.Populated_legal_residence_county_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_race_desc_pcnt *   0.00 / 100 + T.Populated_sex_pcnt *   0.00 / 100 + T.Populated_hair_color_pcnt *   0.00 / 100 + T.Populated_hair_color_desc_pcnt *   0.00 / 100 + T.Populated_eye_color_pcnt *   0.00 / 100 + T.Populated_eye_color_desc_pcnt *   0.00 / 100 + T.Populated_skin_color_pcnt *   0.00 / 100 + T.Populated_skin_color_desc_pcnt *   0.00 / 100 + T.Populated_scars_marks_tattoos_1_pcnt *   0.00 / 100 + T.Populated_scars_marks_tattoos_2_pcnt *   0.00 / 100 + T.Populated_scars_marks_tattoos_3_pcnt *   0.00 / 100 + T.Populated_scars_marks_tattoos_4_pcnt *   0.00 / 100 + T.Populated_scars_marks_tattoos_5_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_party_status_pcnt *   0.00 / 100 + T.Populated_party_status_desc_pcnt *   0.00 / 100 + T.Populated__3g_offender_pcnt *   0.00 / 100 + T.Populated_violent_offender_pcnt *   0.00 / 100 + T.Populated_sex_offender_pcnt *   0.00 / 100 + T.Populated_vop_offender_pcnt *   0.00 / 100 + T.Populated_data_type_pcnt *   0.00 / 100 + T.Populated_record_setup_date_pcnt *   0.00 / 100 + T.Populated_datasource_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_ace_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_errors_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_ssn_appended_pcnt *   0.00 / 100 + T.Populated_curr_incar_flag_pcnt *   0.00 / 100 + T.Populated_curr_parole_flag_pcnt *   0.00 / 100 + T.Populated_curr_probation_flag_pcnt *   0.00 / 100 + T.Populated_src_upload_date_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_image_link_pcnt *   0.00 / 100 + T.Populated_fcra_conviction_flag_pcnt *   0.00 / 100 + T.Populated_fcra_traffic_flag_pcnt *   0.00 / 100 + T.Populated_fcra_date_pcnt *   0.00 / 100 + T.Populated_fcra_date_type_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_type_pcnt *   0.00 / 100 + T.Populated_offense_score_pcnt *   0.00 / 100 + T.Populated_offender_persistent_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_file_date_pcnt*ri.Populated_file_date_pcnt *   0.00 / 10000 + le.Populated_offender_key_pcnt*ri.Populated_offender_key_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_id_num_pcnt*ri.Populated_id_num_pcnt *   0.00 / 10000 + le.Populated_pty_nm_pcnt*ri.Populated_pty_nm_pcnt *   0.00 / 10000 + le.Populated_pty_nm_fmt_pcnt*ri.Populated_pty_nm_fmt_pcnt *   0.00 / 10000 + le.Populated_orig_lname_pcnt*ri.Populated_orig_lname_pcnt *   0.00 / 10000 + le.Populated_orig_fname_pcnt*ri.Populated_orig_fname_pcnt *   0.00 / 10000 + le.Populated_orig_mname_pcnt*ri.Populated_orig_mname_pcnt *   0.00 / 10000 + le.Populated_orig_name_suffix_pcnt*ri.Populated_orig_name_suffix_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_pty_typ_pcnt*ri.Populated_pty_typ_pcnt *   0.00 / 10000 + le.Populated_nid_pcnt*ri.Populated_nid_pcnt *   0.00 / 10000 + le.Populated_ntype_pcnt*ri.Populated_ntype_pcnt *   0.00 / 10000 + le.Populated_nindicator_pcnt*ri.Populated_nindicator_pcnt *   0.00 / 10000 + le.Populated_nitro_flag_pcnt*ri.Populated_nitro_flag_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_case_num_pcnt*ri.Populated_case_num_pcnt *   0.00 / 10000 + le.Populated_case_court_pcnt*ri.Populated_case_court_pcnt *   0.00 / 10000 + le.Populated_case_date_pcnt*ri.Populated_case_date_pcnt *   0.00 / 10000 + le.Populated_case_type_pcnt*ri.Populated_case_type_pcnt *   0.00 / 10000 + le.Populated_case_type_desc_pcnt*ri.Populated_case_type_desc_pcnt *   0.00 / 10000 + le.Populated_county_of_origin_pcnt*ri.Populated_county_of_origin_pcnt *   0.00 / 10000 + le.Populated_dle_num_pcnt*ri.Populated_dle_num_pcnt *   0.00 / 10000 + le.Populated_fbi_num_pcnt*ri.Populated_fbi_num_pcnt *   0.00 / 10000 + le.Populated_doc_num_pcnt*ri.Populated_doc_num_pcnt *   0.00 / 10000 + le.Populated_ins_num_pcnt*ri.Populated_ins_num_pcnt *   0.00 / 10000 + le.Populated_dl_num_pcnt*ri.Populated_dl_num_pcnt *   0.00 / 10000 + le.Populated_dl_state_pcnt*ri.Populated_dl_state_pcnt *   0.00 / 10000 + le.Populated_citizenship_pcnt*ri.Populated_citizenship_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_dob_alias_pcnt*ri.Populated_dob_alias_pcnt *   0.00 / 10000 + le.Populated_county_of_birth_pcnt*ri.Populated_county_of_birth_pcnt *   0.00 / 10000 + le.Populated_place_of_birth_pcnt*ri.Populated_place_of_birth_pcnt *   0.00 / 10000 + le.Populated_street_address_1_pcnt*ri.Populated_street_address_1_pcnt *   0.00 / 10000 + le.Populated_street_address_2_pcnt*ri.Populated_street_address_2_pcnt *   0.00 / 10000 + le.Populated_street_address_3_pcnt*ri.Populated_street_address_3_pcnt *   0.00 / 10000 + le.Populated_street_address_4_pcnt*ri.Populated_street_address_4_pcnt *   0.00 / 10000 + le.Populated_street_address_5_pcnt*ri.Populated_street_address_5_pcnt *   0.00 / 10000 + le.Populated_current_residence_county_pcnt*ri.Populated_current_residence_county_pcnt *   0.00 / 10000 + le.Populated_legal_residence_county_pcnt*ri.Populated_legal_residence_county_pcnt *   0.00 / 10000 + le.Populated_race_pcnt*ri.Populated_race_pcnt *   0.00 / 10000 + le.Populated_race_desc_pcnt*ri.Populated_race_desc_pcnt *   0.00 / 10000 + le.Populated_sex_pcnt*ri.Populated_sex_pcnt *   0.00 / 10000 + le.Populated_hair_color_pcnt*ri.Populated_hair_color_pcnt *   0.00 / 10000 + le.Populated_hair_color_desc_pcnt*ri.Populated_hair_color_desc_pcnt *   0.00 / 10000 + le.Populated_eye_color_pcnt*ri.Populated_eye_color_pcnt *   0.00 / 10000 + le.Populated_eye_color_desc_pcnt*ri.Populated_eye_color_desc_pcnt *   0.00 / 10000 + le.Populated_skin_color_pcnt*ri.Populated_skin_color_pcnt *   0.00 / 10000 + le.Populated_skin_color_desc_pcnt*ri.Populated_skin_color_desc_pcnt *   0.00 / 10000 + le.Populated_scars_marks_tattoos_1_pcnt*ri.Populated_scars_marks_tattoos_1_pcnt *   0.00 / 10000 + le.Populated_scars_marks_tattoos_2_pcnt*ri.Populated_scars_marks_tattoos_2_pcnt *   0.00 / 10000 + le.Populated_scars_marks_tattoos_3_pcnt*ri.Populated_scars_marks_tattoos_3_pcnt *   0.00 / 10000 + le.Populated_scars_marks_tattoos_4_pcnt*ri.Populated_scars_marks_tattoos_4_pcnt *   0.00 / 10000 + le.Populated_scars_marks_tattoos_5_pcnt*ri.Populated_scars_marks_tattoos_5_pcnt *   0.00 / 10000 + le.Populated_height_pcnt*ri.Populated_height_pcnt *   0.00 / 10000 + le.Populated_weight_pcnt*ri.Populated_weight_pcnt *   0.00 / 10000 + le.Populated_party_status_pcnt*ri.Populated_party_status_pcnt *   0.00 / 10000 + le.Populated_party_status_desc_pcnt*ri.Populated_party_status_desc_pcnt *   0.00 / 10000 + le.Populated__3g_offender_pcnt*ri.Populated__3g_offender_pcnt *   0.00 / 10000 + le.Populated_violent_offender_pcnt*ri.Populated_violent_offender_pcnt *   0.00 / 10000 + le.Populated_sex_offender_pcnt*ri.Populated_sex_offender_pcnt *   0.00 / 10000 + le.Populated_vop_offender_pcnt*ri.Populated_vop_offender_pcnt *   0.00 / 10000 + le.Populated_data_type_pcnt*ri.Populated_data_type_pcnt *   0.00 / 10000 + le.Populated_record_setup_date_pcnt*ri.Populated_record_setup_date_pcnt *   0.00 / 10000 + le.Populated_datasource_pcnt*ri.Populated_datasource_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_ace_fips_st_pcnt*ri.Populated_ace_fips_st_pcnt *   0.00 / 10000 + le.Populated_ace_fips_county_pcnt*ri.Populated_ace_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_clean_errors_pcnt*ri.Populated_clean_errors_pcnt *   0.00 / 10000 + le.Populated_county_name_pcnt*ri.Populated_county_name_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_score_pcnt*ri.Populated_score_pcnt *   0.00 / 10000 + le.Populated_ssn_appended_pcnt*ri.Populated_ssn_appended_pcnt *   0.00 / 10000 + le.Populated_curr_incar_flag_pcnt*ri.Populated_curr_incar_flag_pcnt *   0.00 / 10000 + le.Populated_curr_parole_flag_pcnt*ri.Populated_curr_parole_flag_pcnt *   0.00 / 10000 + le.Populated_curr_probation_flag_pcnt*ri.Populated_curr_probation_flag_pcnt *   0.00 / 10000 + le.Populated_src_upload_date_pcnt*ri.Populated_src_upload_date_pcnt *   0.00 / 10000 + le.Populated_age_pcnt*ri.Populated_age_pcnt *   0.00 / 10000 + le.Populated_image_link_pcnt*ri.Populated_image_link_pcnt *   0.00 / 10000 + le.Populated_fcra_conviction_flag_pcnt*ri.Populated_fcra_conviction_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_traffic_flag_pcnt*ri.Populated_fcra_traffic_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_date_pcnt*ri.Populated_fcra_date_pcnt *   0.00 / 10000 + le.Populated_fcra_date_type_pcnt*ri.Populated_fcra_date_type_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_pcnt*ri.Populated_conviction_override_date_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_type_pcnt*ri.Populated_conviction_override_date_type_pcnt *   0.00 / 10000 + le.Populated_offense_score_pcnt*ri.Populated_offense_score_pcnt *   0.00 / 10000 + le.Populated_offender_persistent_id_pcnt*ri.Populated_offender_persistent_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','file_date','offender_key','vendor','source_file','record_type','orig_state','id_num','pty_nm','pty_nm_fmt','orig_lname','orig_fname','orig_mname','orig_name_suffix','lname','fname','mname','name_suffix','pty_typ','nid','ntype','nindicator','nitro_flag','ssn','case_num','case_court','case_date','case_type','case_type_desc','county_of_origin','dle_num','fbi_num','doc_num','ins_num','dl_num','dl_state','citizenship','dob','dob_alias','county_of_birth','place_of_birth','street_address_1','street_address_2','street_address_3','street_address_4','street_address_5','current_residence_county','legal_residence_county','race','race_desc','sex','hair_color','hair_color_desc','eye_color','eye_color_desc','skin_color','skin_color_desc','scars_marks_tattoos_1','scars_marks_tattoos_2','scars_marks_tattoos_3','scars_marks_tattoos_4','scars_marks_tattoos_5','height','weight','party_status','party_status_desc','_3g_offender','violent_offender','sex_offender','vop_offender','data_type','record_setup_date','datasource','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','clean_errors','county_name','did','score','ssn_appended','curr_incar_flag','curr_parole_flag','curr_probation_flag','src_upload_date','age','image_link','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offender_persistent_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_file_date_pcnt,le.populated_offender_key_pcnt,le.populated_vendor_pcnt,le.populated_source_file_pcnt,le.populated_record_type_pcnt,le.populated_orig_state_pcnt,le.populated_id_num_pcnt,le.populated_pty_nm_pcnt,le.populated_pty_nm_fmt_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_lname_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_name_suffix_pcnt,le.populated_pty_typ_pcnt,le.populated_nid_pcnt,le.populated_ntype_pcnt,le.populated_nindicator_pcnt,le.populated_nitro_flag_pcnt,le.populated_ssn_pcnt,le.populated_case_num_pcnt,le.populated_case_court_pcnt,le.populated_case_date_pcnt,le.populated_case_type_pcnt,le.populated_case_type_desc_pcnt,le.populated_county_of_origin_pcnt,le.populated_dle_num_pcnt,le.populated_fbi_num_pcnt,le.populated_doc_num_pcnt,le.populated_ins_num_pcnt,le.populated_dl_num_pcnt,le.populated_dl_state_pcnt,le.populated_citizenship_pcnt,le.populated_dob_pcnt,le.populated_dob_alias_pcnt,le.populated_county_of_birth_pcnt,le.populated_place_of_birth_pcnt,le.populated_street_address_1_pcnt,le.populated_street_address_2_pcnt,le.populated_street_address_3_pcnt,le.populated_street_address_4_pcnt,le.populated_street_address_5_pcnt,le.populated_current_residence_county_pcnt,le.populated_legal_residence_county_pcnt,le.populated_race_pcnt,le.populated_race_desc_pcnt,le.populated_sex_pcnt,le.populated_hair_color_pcnt,le.populated_hair_color_desc_pcnt,le.populated_eye_color_pcnt,le.populated_eye_color_desc_pcnt,le.populated_skin_color_pcnt,le.populated_skin_color_desc_pcnt,le.populated_scars_marks_tattoos_1_pcnt,le.populated_scars_marks_tattoos_2_pcnt,le.populated_scars_marks_tattoos_3_pcnt,le.populated_scars_marks_tattoos_4_pcnt,le.populated_scars_marks_tattoos_5_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_party_status_pcnt,le.populated_party_status_desc_pcnt,le.populated__3g_offender_pcnt,le.populated_violent_offender_pcnt,le.populated_sex_offender_pcnt,le.populated_vop_offender_pcnt,le.populated_data_type_pcnt,le.populated_record_setup_date_pcnt,le.populated_datasource_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_ace_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_clean_errors_pcnt,le.populated_county_name_pcnt,le.populated_did_pcnt,le.populated_score_pcnt,le.populated_ssn_appended_pcnt,le.populated_curr_incar_flag_pcnt,le.populated_curr_parole_flag_pcnt,le.populated_curr_probation_flag_pcnt,le.populated_src_upload_date_pcnt,le.populated_age_pcnt,le.populated_image_link_pcnt,le.populated_fcra_conviction_flag_pcnt,le.populated_fcra_traffic_flag_pcnt,le.populated_fcra_date_pcnt,le.populated_fcra_date_type_pcnt,le.populated_conviction_override_date_pcnt,le.populated_conviction_override_date_type_pcnt,le.populated_offense_score_pcnt,le.populated_offender_persistent_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_file_date,le.maxlength_offender_key,le.maxlength_vendor,le.maxlength_source_file,le.maxlength_record_type,le.maxlength_orig_state,le.maxlength_id_num,le.maxlength_pty_nm,le.maxlength_pty_nm_fmt,le.maxlength_orig_lname,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_name_suffix,le.maxlength_lname,le.maxlength_fname,le.maxlength_mname,le.maxlength_name_suffix,le.maxlength_pty_typ,le.maxlength_nid,le.maxlength_ntype,le.maxlength_nindicator,le.maxlength_nitro_flag,le.maxlength_ssn,le.maxlength_case_num,le.maxlength_case_court,le.maxlength_case_date,le.maxlength_case_type,le.maxlength_case_type_desc,le.maxlength_county_of_origin,le.maxlength_dle_num,le.maxlength_fbi_num,le.maxlength_doc_num,le.maxlength_ins_num,le.maxlength_dl_num,le.maxlength_dl_state,le.maxlength_citizenship,le.maxlength_dob,le.maxlength_dob_alias,le.maxlength_county_of_birth,le.maxlength_place_of_birth,le.maxlength_street_address_1,le.maxlength_street_address_2,le.maxlength_street_address_3,le.maxlength_street_address_4,le.maxlength_street_address_5,le.maxlength_current_residence_county,le.maxlength_legal_residence_county,le.maxlength_race,le.maxlength_race_desc,le.maxlength_sex,le.maxlength_hair_color,le.maxlength_hair_color_desc,le.maxlength_eye_color,le.maxlength_eye_color_desc,le.maxlength_skin_color,le.maxlength_skin_color_desc,le.maxlength_scars_marks_tattoos_1,le.maxlength_scars_marks_tattoos_2,le.maxlength_scars_marks_tattoos_3,le.maxlength_scars_marks_tattoos_4,le.maxlength_scars_marks_tattoos_5,le.maxlength_height,le.maxlength_weight,le.maxlength_party_status,le.maxlength_party_status_desc,le.maxlength__3g_offender,le.maxlength_violent_offender,le.maxlength_sex_offender,le.maxlength_vop_offender,le.maxlength_data_type,le.maxlength_record_setup_date,le.maxlength_datasource,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_ace_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_clean_errors,le.maxlength_county_name,le.maxlength_did,le.maxlength_score,le.maxlength_ssn_appended,le.maxlength_curr_incar_flag,le.maxlength_curr_parole_flag,le.maxlength_curr_probation_flag,le.maxlength_src_upload_date,le.maxlength_age,le.maxlength_image_link,le.maxlength_fcra_conviction_flag,le.maxlength_fcra_traffic_flag,le.maxlength_fcra_date,le.maxlength_fcra_date_type,le.maxlength_conviction_override_date,le.maxlength_conviction_override_date_type,le.maxlength_offense_score,le.maxlength_offender_persistent_id);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_file_date,le.avelength_offender_key,le.avelength_vendor,le.avelength_source_file,le.avelength_record_type,le.avelength_orig_state,le.avelength_id_num,le.avelength_pty_nm,le.avelength_pty_nm_fmt,le.avelength_orig_lname,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_name_suffix,le.avelength_lname,le.avelength_fname,le.avelength_mname,le.avelength_name_suffix,le.avelength_pty_typ,le.avelength_nid,le.avelength_ntype,le.avelength_nindicator,le.avelength_nitro_flag,le.avelength_ssn,le.avelength_case_num,le.avelength_case_court,le.avelength_case_date,le.avelength_case_type,le.avelength_case_type_desc,le.avelength_county_of_origin,le.avelength_dle_num,le.avelength_fbi_num,le.avelength_doc_num,le.avelength_ins_num,le.avelength_dl_num,le.avelength_dl_state,le.avelength_citizenship,le.avelength_dob,le.avelength_dob_alias,le.avelength_county_of_birth,le.avelength_place_of_birth,le.avelength_street_address_1,le.avelength_street_address_2,le.avelength_street_address_3,le.avelength_street_address_4,le.avelength_street_address_5,le.avelength_current_residence_county,le.avelength_legal_residence_county,le.avelength_race,le.avelength_race_desc,le.avelength_sex,le.avelength_hair_color,le.avelength_hair_color_desc,le.avelength_eye_color,le.avelength_eye_color_desc,le.avelength_skin_color,le.avelength_skin_color_desc,le.avelength_scars_marks_tattoos_1,le.avelength_scars_marks_tattoos_2,le.avelength_scars_marks_tattoos_3,le.avelength_scars_marks_tattoos_4,le.avelength_scars_marks_tattoos_5,le.avelength_height,le.avelength_weight,le.avelength_party_status,le.avelength_party_status_desc,le.avelength__3g_offender,le.avelength_violent_offender,le.avelength_sex_offender,le.avelength_vop_offender,le.avelength_data_type,le.avelength_record_setup_date,le.avelength_datasource,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_ace_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_clean_errors,le.avelength_county_name,le.avelength_did,le.avelength_score,le.avelength_ssn_appended,le.avelength_curr_incar_flag,le.avelength_curr_parole_flag,le.avelength_curr_probation_flag,le.avelength_src_upload_date,le.avelength_age,le.avelength_image_link,le.avelength_fcra_conviction_flag,le.avelength_fcra_traffic_flag,le.avelength_fcra_date,le.avelength_fcra_date_type,le.avelength_conviction_override_date,le.avelength_conviction_override_date_type,le.avelength_offense_score,le.avelength_offender_persistent_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 119, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.file_date),TRIM((SALT33.StrType)le.offender_key),TRIM((SALT33.StrType)le.vendor),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.id_num),TRIM((SALT33.StrType)le.pty_nm),TRIM((SALT33.StrType)le.pty_nm_fmt),TRIM((SALT33.StrType)le.orig_lname),TRIM((SALT33.StrType)le.orig_fname),TRIM((SALT33.StrType)le.orig_mname),TRIM((SALT33.StrType)le.orig_name_suffix),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.pty_typ),IF (le.nid <> 0,TRIM((SALT33.StrType)le.nid), ''),TRIM((SALT33.StrType)le.ntype),IF (le.nindicator <> 0,TRIM((SALT33.StrType)le.nindicator), ''),TRIM((SALT33.StrType)le.nitro_flag),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.case_num),TRIM((SALT33.StrType)le.case_court),TRIM((SALT33.StrType)le.case_date),TRIM((SALT33.StrType)le.case_type),TRIM((SALT33.StrType)le.case_type_desc),TRIM((SALT33.StrType)le.county_of_origin),TRIM((SALT33.StrType)le.dle_num),TRIM((SALT33.StrType)le.fbi_num),TRIM((SALT33.StrType)le.doc_num),TRIM((SALT33.StrType)le.ins_num),TRIM((SALT33.StrType)le.dl_num),TRIM((SALT33.StrType)le.dl_state),TRIM((SALT33.StrType)le.citizenship),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.dob_alias),TRIM((SALT33.StrType)le.county_of_birth),TRIM((SALT33.StrType)le.place_of_birth),TRIM((SALT33.StrType)le.street_address_1),TRIM((SALT33.StrType)le.street_address_2),TRIM((SALT33.StrType)le.street_address_3),TRIM((SALT33.StrType)le.street_address_4),TRIM((SALT33.StrType)le.street_address_5),TRIM((SALT33.StrType)le.current_residence_county),TRIM((SALT33.StrType)le.legal_residence_county),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.race_desc),TRIM((SALT33.StrType)le.sex),TRIM((SALT33.StrType)le.hair_color),TRIM((SALT33.StrType)le.hair_color_desc),TRIM((SALT33.StrType)le.eye_color),TRIM((SALT33.StrType)le.eye_color_desc),TRIM((SALT33.StrType)le.skin_color),TRIM((SALT33.StrType)le.skin_color_desc),TRIM((SALT33.StrType)le.scars_marks_tattoos_1),TRIM((SALT33.StrType)le.scars_marks_tattoos_2),TRIM((SALT33.StrType)le.scars_marks_tattoos_3),TRIM((SALT33.StrType)le.scars_marks_tattoos_4),TRIM((SALT33.StrType)le.scars_marks_tattoos_5),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.party_status),TRIM((SALT33.StrType)le.party_status_desc),TRIM((SALT33.StrType)le._3g_offender),TRIM((SALT33.StrType)le.violent_offender),TRIM((SALT33.StrType)le.sex_offender),TRIM((SALT33.StrType)le.vop_offender),TRIM((SALT33.StrType)le.data_type),TRIM((SALT33.StrType)le.record_setup_date),TRIM((SALT33.StrType)le.datasource),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.ace_fips_st),TRIM((SALT33.StrType)le.ace_fips_county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.clean_errors <> 0,TRIM((SALT33.StrType)le.clean_errors), ''),TRIM((SALT33.StrType)le.county_name),TRIM((SALT33.StrType)le.did),TRIM((SALT33.StrType)le.score),TRIM((SALT33.StrType)le.ssn_appended),TRIM((SALT33.StrType)le.curr_incar_flag),TRIM((SALT33.StrType)le.curr_parole_flag),TRIM((SALT33.StrType)le.curr_probation_flag),TRIM((SALT33.StrType)le.src_upload_date),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.image_link),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offender_persistent_id <> 0,TRIM((SALT33.StrType)le.offender_persistent_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,119,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 119);
  SELF.FldNo2 := 1 + (C % 119);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.file_date),TRIM((SALT33.StrType)le.offender_key),TRIM((SALT33.StrType)le.vendor),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.id_num),TRIM((SALT33.StrType)le.pty_nm),TRIM((SALT33.StrType)le.pty_nm_fmt),TRIM((SALT33.StrType)le.orig_lname),TRIM((SALT33.StrType)le.orig_fname),TRIM((SALT33.StrType)le.orig_mname),TRIM((SALT33.StrType)le.orig_name_suffix),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.pty_typ),IF (le.nid <> 0,TRIM((SALT33.StrType)le.nid), ''),TRIM((SALT33.StrType)le.ntype),IF (le.nindicator <> 0,TRIM((SALT33.StrType)le.nindicator), ''),TRIM((SALT33.StrType)le.nitro_flag),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.case_num),TRIM((SALT33.StrType)le.case_court),TRIM((SALT33.StrType)le.case_date),TRIM((SALT33.StrType)le.case_type),TRIM((SALT33.StrType)le.case_type_desc),TRIM((SALT33.StrType)le.county_of_origin),TRIM((SALT33.StrType)le.dle_num),TRIM((SALT33.StrType)le.fbi_num),TRIM((SALT33.StrType)le.doc_num),TRIM((SALT33.StrType)le.ins_num),TRIM((SALT33.StrType)le.dl_num),TRIM((SALT33.StrType)le.dl_state),TRIM((SALT33.StrType)le.citizenship),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.dob_alias),TRIM((SALT33.StrType)le.county_of_birth),TRIM((SALT33.StrType)le.place_of_birth),TRIM((SALT33.StrType)le.street_address_1),TRIM((SALT33.StrType)le.street_address_2),TRIM((SALT33.StrType)le.street_address_3),TRIM((SALT33.StrType)le.street_address_4),TRIM((SALT33.StrType)le.street_address_5),TRIM((SALT33.StrType)le.current_residence_county),TRIM((SALT33.StrType)le.legal_residence_county),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.race_desc),TRIM((SALT33.StrType)le.sex),TRIM((SALT33.StrType)le.hair_color),TRIM((SALT33.StrType)le.hair_color_desc),TRIM((SALT33.StrType)le.eye_color),TRIM((SALT33.StrType)le.eye_color_desc),TRIM((SALT33.StrType)le.skin_color),TRIM((SALT33.StrType)le.skin_color_desc),TRIM((SALT33.StrType)le.scars_marks_tattoos_1),TRIM((SALT33.StrType)le.scars_marks_tattoos_2),TRIM((SALT33.StrType)le.scars_marks_tattoos_3),TRIM((SALT33.StrType)le.scars_marks_tattoos_4),TRIM((SALT33.StrType)le.scars_marks_tattoos_5),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.party_status),TRIM((SALT33.StrType)le.party_status_desc),TRIM((SALT33.StrType)le._3g_offender),TRIM((SALT33.StrType)le.violent_offender),TRIM((SALT33.StrType)le.sex_offender),TRIM((SALT33.StrType)le.vop_offender),TRIM((SALT33.StrType)le.data_type),TRIM((SALT33.StrType)le.record_setup_date),TRIM((SALT33.StrType)le.datasource),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.ace_fips_st),TRIM((SALT33.StrType)le.ace_fips_county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.clean_errors <> 0,TRIM((SALT33.StrType)le.clean_errors), ''),TRIM((SALT33.StrType)le.county_name),TRIM((SALT33.StrType)le.did),TRIM((SALT33.StrType)le.score),TRIM((SALT33.StrType)le.ssn_appended),TRIM((SALT33.StrType)le.curr_incar_flag),TRIM((SALT33.StrType)le.curr_parole_flag),TRIM((SALT33.StrType)le.curr_probation_flag),TRIM((SALT33.StrType)le.src_upload_date),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.image_link),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offender_persistent_id <> 0,TRIM((SALT33.StrType)le.offender_persistent_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.file_date),TRIM((SALT33.StrType)le.offender_key),TRIM((SALT33.StrType)le.vendor),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.id_num),TRIM((SALT33.StrType)le.pty_nm),TRIM((SALT33.StrType)le.pty_nm_fmt),TRIM((SALT33.StrType)le.orig_lname),TRIM((SALT33.StrType)le.orig_fname),TRIM((SALT33.StrType)le.orig_mname),TRIM((SALT33.StrType)le.orig_name_suffix),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.pty_typ),IF (le.nid <> 0,TRIM((SALT33.StrType)le.nid), ''),TRIM((SALT33.StrType)le.ntype),IF (le.nindicator <> 0,TRIM((SALT33.StrType)le.nindicator), ''),TRIM((SALT33.StrType)le.nitro_flag),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.case_num),TRIM((SALT33.StrType)le.case_court),TRIM((SALT33.StrType)le.case_date),TRIM((SALT33.StrType)le.case_type),TRIM((SALT33.StrType)le.case_type_desc),TRIM((SALT33.StrType)le.county_of_origin),TRIM((SALT33.StrType)le.dle_num),TRIM((SALT33.StrType)le.fbi_num),TRIM((SALT33.StrType)le.doc_num),TRIM((SALT33.StrType)le.ins_num),TRIM((SALT33.StrType)le.dl_num),TRIM((SALT33.StrType)le.dl_state),TRIM((SALT33.StrType)le.citizenship),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.dob_alias),TRIM((SALT33.StrType)le.county_of_birth),TRIM((SALT33.StrType)le.place_of_birth),TRIM((SALT33.StrType)le.street_address_1),TRIM((SALT33.StrType)le.street_address_2),TRIM((SALT33.StrType)le.street_address_3),TRIM((SALT33.StrType)le.street_address_4),TRIM((SALT33.StrType)le.street_address_5),TRIM((SALT33.StrType)le.current_residence_county),TRIM((SALT33.StrType)le.legal_residence_county),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.race_desc),TRIM((SALT33.StrType)le.sex),TRIM((SALT33.StrType)le.hair_color),TRIM((SALT33.StrType)le.hair_color_desc),TRIM((SALT33.StrType)le.eye_color),TRIM((SALT33.StrType)le.eye_color_desc),TRIM((SALT33.StrType)le.skin_color),TRIM((SALT33.StrType)le.skin_color_desc),TRIM((SALT33.StrType)le.scars_marks_tattoos_1),TRIM((SALT33.StrType)le.scars_marks_tattoos_2),TRIM((SALT33.StrType)le.scars_marks_tattoos_3),TRIM((SALT33.StrType)le.scars_marks_tattoos_4),TRIM((SALT33.StrType)le.scars_marks_tattoos_5),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.party_status),TRIM((SALT33.StrType)le.party_status_desc),TRIM((SALT33.StrType)le._3g_offender),TRIM((SALT33.StrType)le.violent_offender),TRIM((SALT33.StrType)le.sex_offender),TRIM((SALT33.StrType)le.vop_offender),TRIM((SALT33.StrType)le.data_type),TRIM((SALT33.StrType)le.record_setup_date),TRIM((SALT33.StrType)le.datasource),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dpbc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.ace_fips_st),TRIM((SALT33.StrType)le.ace_fips_county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.clean_errors <> 0,TRIM((SALT33.StrType)le.clean_errors), ''),TRIM((SALT33.StrType)le.county_name),TRIM((SALT33.StrType)le.did),TRIM((SALT33.StrType)le.score),TRIM((SALT33.StrType)le.ssn_appended),TRIM((SALT33.StrType)le.curr_incar_flag),TRIM((SALT33.StrType)le.curr_parole_flag),TRIM((SALT33.StrType)le.curr_probation_flag),TRIM((SALT33.StrType)le.src_upload_date),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.image_link),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offender_persistent_id <> 0,TRIM((SALT33.StrType)le.offender_persistent_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),119*119,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'file_date'}
      ,{3,'offender_key'}
      ,{4,'vendor'}
      ,{5,'source_file'}
      ,{6,'record_type'}
      ,{7,'orig_state'}
      ,{8,'id_num'}
      ,{9,'pty_nm'}
      ,{10,'pty_nm_fmt'}
      ,{11,'orig_lname'}
      ,{12,'orig_fname'}
      ,{13,'orig_mname'}
      ,{14,'orig_name_suffix'}
      ,{15,'lname'}
      ,{16,'fname'}
      ,{17,'mname'}
      ,{18,'name_suffix'}
      ,{19,'pty_typ'}
      ,{20,'nid'}
      ,{21,'ntype'}
      ,{22,'nindicator'}
      ,{23,'nitro_flag'}
      ,{24,'ssn'}
      ,{25,'case_num'}
      ,{26,'case_court'}
      ,{27,'case_date'}
      ,{28,'case_type'}
      ,{29,'case_type_desc'}
      ,{30,'county_of_origin'}
      ,{31,'dle_num'}
      ,{32,'fbi_num'}
      ,{33,'doc_num'}
      ,{34,'ins_num'}
      ,{35,'dl_num'}
      ,{36,'dl_state'}
      ,{37,'citizenship'}
      ,{38,'dob'}
      ,{39,'dob_alias'}
      ,{40,'county_of_birth'}
      ,{41,'place_of_birth'}
      ,{42,'street_address_1'}
      ,{43,'street_address_2'}
      ,{44,'street_address_3'}
      ,{45,'street_address_4'}
      ,{46,'street_address_5'}
      ,{47,'current_residence_county'}
      ,{48,'legal_residence_county'}
      ,{49,'race'}
      ,{50,'race_desc'}
      ,{51,'sex'}
      ,{52,'hair_color'}
      ,{53,'hair_color_desc'}
      ,{54,'eye_color'}
      ,{55,'eye_color_desc'}
      ,{56,'skin_color'}
      ,{57,'skin_color_desc'}
      ,{58,'scars_marks_tattoos_1'}
      ,{59,'scars_marks_tattoos_2'}
      ,{60,'scars_marks_tattoos_3'}
      ,{61,'scars_marks_tattoos_4'}
      ,{62,'scars_marks_tattoos_5'}
      ,{63,'height'}
      ,{64,'weight'}
      ,{65,'party_status'}
      ,{66,'party_status_desc'}
      ,{67,'_3g_offender'}
      ,{68,'violent_offender'}
      ,{69,'sex_offender'}
      ,{70,'vop_offender'}
      ,{71,'data_type'}
      ,{72,'record_setup_date'}
      ,{73,'datasource'}
      ,{74,'prim_range'}
      ,{75,'predir'}
      ,{76,'prim_name'}
      ,{77,'addr_suffix'}
      ,{78,'postdir'}
      ,{79,'unit_desig'}
      ,{80,'sec_range'}
      ,{81,'p_city_name'}
      ,{82,'v_city_name'}
      ,{83,'st'}
      ,{84,'zip5'}
      ,{85,'zip4'}
      ,{86,'cart'}
      ,{87,'cr_sort_sz'}
      ,{88,'lot'}
      ,{89,'lot_order'}
      ,{90,'dpbc'}
      ,{91,'chk_digit'}
      ,{92,'rec_type'}
      ,{93,'ace_fips_st'}
      ,{94,'ace_fips_county'}
      ,{95,'geo_lat'}
      ,{96,'geo_long'}
      ,{97,'msa'}
      ,{98,'geo_blk'}
      ,{99,'geo_match'}
      ,{100,'err_stat'}
      ,{101,'clean_errors'}
      ,{102,'county_name'}
      ,{103,'did'}
      ,{104,'score'}
      ,{105,'ssn_appended'}
      ,{106,'curr_incar_flag'}
      ,{107,'curr_parole_flag'}
      ,{108,'curr_probation_flag'}
      ,{109,'src_upload_date'}
      ,{110,'age'}
      ,{111,'image_link'}
      ,{112,'fcra_conviction_flag'}
      ,{113,'fcra_traffic_flag'}
      ,{114,'fcra_date'}
      ,{115,'fcra_date_type'}
      ,{116,'conviction_override_date'}
      ,{117,'conviction_override_date_type'}
      ,{118,'offense_score'}
      ,{119,'offender_persistent_id'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Moxie_Crim_Offender2_Dev_Fields.InValid_process_date((SALT33.StrType)le.process_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_file_date((SALT33.StrType)le.file_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_offender_key((SALT33.StrType)le.offender_key),
    Moxie_Crim_Offender2_Dev_Fields.InValid_vendor((SALT33.StrType)le.vendor),
    Moxie_Crim_Offender2_Dev_Fields.InValid_source_file((SALT33.StrType)le.source_file),
    Moxie_Crim_Offender2_Dev_Fields.InValid_record_type((SALT33.StrType)le.record_type),
    Moxie_Crim_Offender2_Dev_Fields.InValid_orig_state((SALT33.StrType)le.orig_state),
    Moxie_Crim_Offender2_Dev_Fields.InValid_id_num((SALT33.StrType)le.id_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_pty_nm((SALT33.StrType)le.pty_nm),
    Moxie_Crim_Offender2_Dev_Fields.InValid_pty_nm_fmt((SALT33.StrType)le.pty_nm_fmt),
    Moxie_Crim_Offender2_Dev_Fields.InValid_orig_lname((SALT33.StrType)le.orig_lname),
    Moxie_Crim_Offender2_Dev_Fields.InValid_orig_fname((SALT33.StrType)le.orig_fname),
    Moxie_Crim_Offender2_Dev_Fields.InValid_orig_mname((SALT33.StrType)le.orig_mname),
    Moxie_Crim_Offender2_Dev_Fields.InValid_orig_name_suffix((SALT33.StrType)le.orig_name_suffix),
    Moxie_Crim_Offender2_Dev_Fields.InValid_lname((SALT33.StrType)le.lname),
    Moxie_Crim_Offender2_Dev_Fields.InValid_fname((SALT33.StrType)le.fname),
    Moxie_Crim_Offender2_Dev_Fields.InValid_mname((SALT33.StrType)le.mname),
    Moxie_Crim_Offender2_Dev_Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix),
    Moxie_Crim_Offender2_Dev_Fields.InValid_pty_typ((SALT33.StrType)le.pty_typ),
    Moxie_Crim_Offender2_Dev_Fields.InValid_nid((SALT33.StrType)le.nid),
    Moxie_Crim_Offender2_Dev_Fields.InValid_ntype((SALT33.StrType)le.ntype),
    Moxie_Crim_Offender2_Dev_Fields.InValid_nindicator((SALT33.StrType)le.nindicator),
    Moxie_Crim_Offender2_Dev_Fields.InValid_nitro_flag((SALT33.StrType)le.nitro_flag),
    Moxie_Crim_Offender2_Dev_Fields.InValid_ssn((SALT33.StrType)le.ssn),
    Moxie_Crim_Offender2_Dev_Fields.InValid_case_num((SALT33.StrType)le.case_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_case_court((SALT33.StrType)le.case_court),
    Moxie_Crim_Offender2_Dev_Fields.InValid_case_date((SALT33.StrType)le.case_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_case_type((SALT33.StrType)le.case_type),
    Moxie_Crim_Offender2_Dev_Fields.InValid_case_type_desc((SALT33.StrType)le.case_type_desc),
    Moxie_Crim_Offender2_Dev_Fields.InValid_county_of_origin((SALT33.StrType)le.county_of_origin),
    Moxie_Crim_Offender2_Dev_Fields.InValid_dle_num((SALT33.StrType)le.dle_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_fbi_num((SALT33.StrType)le.fbi_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_doc_num((SALT33.StrType)le.doc_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_ins_num((SALT33.StrType)le.ins_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_dl_num((SALT33.StrType)le.dl_num),
    Moxie_Crim_Offender2_Dev_Fields.InValid_dl_state((SALT33.StrType)le.dl_state),
    Moxie_Crim_Offender2_Dev_Fields.InValid_citizenship((SALT33.StrType)le.citizenship),
    Moxie_Crim_Offender2_Dev_Fields.InValid_dob((SALT33.StrType)le.dob),
    Moxie_Crim_Offender2_Dev_Fields.InValid_dob_alias((SALT33.StrType)le.dob_alias),
    Moxie_Crim_Offender2_Dev_Fields.InValid_county_of_birth((SALT33.StrType)le.county_of_birth),
    Moxie_Crim_Offender2_Dev_Fields.InValid_place_of_birth((SALT33.StrType)le.place_of_birth),
    Moxie_Crim_Offender2_Dev_Fields.InValid_street_address_1((SALT33.StrType)le.street_address_1),
    Moxie_Crim_Offender2_Dev_Fields.InValid_street_address_2((SALT33.StrType)le.street_address_2),
    Moxie_Crim_Offender2_Dev_Fields.InValid_street_address_3((SALT33.StrType)le.street_address_3),
    Moxie_Crim_Offender2_Dev_Fields.InValid_street_address_4((SALT33.StrType)le.street_address_4),
    Moxie_Crim_Offender2_Dev_Fields.InValid_street_address_5((SALT33.StrType)le.street_address_5),
    Moxie_Crim_Offender2_Dev_Fields.InValid_current_residence_county((SALT33.StrType)le.current_residence_county),
    Moxie_Crim_Offender2_Dev_Fields.InValid_legal_residence_county((SALT33.StrType)le.legal_residence_county),
    Moxie_Crim_Offender2_Dev_Fields.InValid_race((SALT33.StrType)le.race),
    Moxie_Crim_Offender2_Dev_Fields.InValid_race_desc((SALT33.StrType)le.race_desc),
    Moxie_Crim_Offender2_Dev_Fields.InValid_sex((SALT33.StrType)le.sex),
    Moxie_Crim_Offender2_Dev_Fields.InValid_hair_color((SALT33.StrType)le.hair_color),
    Moxie_Crim_Offender2_Dev_Fields.InValid_hair_color_desc((SALT33.StrType)le.hair_color_desc),
    Moxie_Crim_Offender2_Dev_Fields.InValid_eye_color((SALT33.StrType)le.eye_color),
    Moxie_Crim_Offender2_Dev_Fields.InValid_eye_color_desc((SALT33.StrType)le.eye_color_desc),
    Moxie_Crim_Offender2_Dev_Fields.InValid_skin_color((SALT33.StrType)le.skin_color),
    Moxie_Crim_Offender2_Dev_Fields.InValid_skin_color_desc((SALT33.StrType)le.skin_color_desc),
    Moxie_Crim_Offender2_Dev_Fields.InValid_scars_marks_tattoos_1((SALT33.StrType)le.scars_marks_tattoos_1),
    Moxie_Crim_Offender2_Dev_Fields.InValid_scars_marks_tattoos_2((SALT33.StrType)le.scars_marks_tattoos_2),
    Moxie_Crim_Offender2_Dev_Fields.InValid_scars_marks_tattoos_3((SALT33.StrType)le.scars_marks_tattoos_3),
    Moxie_Crim_Offender2_Dev_Fields.InValid_scars_marks_tattoos_4((SALT33.StrType)le.scars_marks_tattoos_4),
    Moxie_Crim_Offender2_Dev_Fields.InValid_scars_marks_tattoos_5((SALT33.StrType)le.scars_marks_tattoos_5),
    Moxie_Crim_Offender2_Dev_Fields.InValid_height((SALT33.StrType)le.height),
    Moxie_Crim_Offender2_Dev_Fields.InValid_weight((SALT33.StrType)le.weight),
    Moxie_Crim_Offender2_Dev_Fields.InValid_party_status((SALT33.StrType)le.party_status),
    Moxie_Crim_Offender2_Dev_Fields.InValid_party_status_desc((SALT33.StrType)le.party_status_desc),
    Moxie_Crim_Offender2_Dev_Fields.InValid__3g_offender((SALT33.StrType)le._3g_offender),
    Moxie_Crim_Offender2_Dev_Fields.InValid_violent_offender((SALT33.StrType)le.violent_offender),
    Moxie_Crim_Offender2_Dev_Fields.InValid_sex_offender((SALT33.StrType)le.sex_offender),
    Moxie_Crim_Offender2_Dev_Fields.InValid_vop_offender((SALT33.StrType)le.vop_offender),
    Moxie_Crim_Offender2_Dev_Fields.InValid_data_type((SALT33.StrType)le.data_type),
    Moxie_Crim_Offender2_Dev_Fields.InValid_record_setup_date((SALT33.StrType)le.record_setup_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_datasource((SALT33.StrType)le.datasource),
    Moxie_Crim_Offender2_Dev_Fields.InValid_prim_range((SALT33.StrType)le.prim_range),
    Moxie_Crim_Offender2_Dev_Fields.InValid_predir((SALT33.StrType)le.predir),
    Moxie_Crim_Offender2_Dev_Fields.InValid_prim_name((SALT33.StrType)le.prim_name),
    Moxie_Crim_Offender2_Dev_Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix),
    Moxie_Crim_Offender2_Dev_Fields.InValid_postdir((SALT33.StrType)le.postdir),
    Moxie_Crim_Offender2_Dev_Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig),
    Moxie_Crim_Offender2_Dev_Fields.InValid_sec_range((SALT33.StrType)le.sec_range),
    Moxie_Crim_Offender2_Dev_Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name),
    Moxie_Crim_Offender2_Dev_Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name),
    Moxie_Crim_Offender2_Dev_Fields.InValid_st((SALT33.StrType)le.st),
    Moxie_Crim_Offender2_Dev_Fields.InValid_zip5((SALT33.StrType)le.zip5),
    Moxie_Crim_Offender2_Dev_Fields.InValid_zip4((SALT33.StrType)le.zip4),
    Moxie_Crim_Offender2_Dev_Fields.InValid_cart((SALT33.StrType)le.cart),
    Moxie_Crim_Offender2_Dev_Fields.InValid_cr_sort_sz((SALT33.StrType)le.cr_sort_sz),
    Moxie_Crim_Offender2_Dev_Fields.InValid_lot((SALT33.StrType)le.lot),
    Moxie_Crim_Offender2_Dev_Fields.InValid_lot_order((SALT33.StrType)le.lot_order),
    Moxie_Crim_Offender2_Dev_Fields.InValid_dpbc((SALT33.StrType)le.dpbc),
    Moxie_Crim_Offender2_Dev_Fields.InValid_chk_digit((SALT33.StrType)le.chk_digit),
    Moxie_Crim_Offender2_Dev_Fields.InValid_rec_type((SALT33.StrType)le.rec_type),
    Moxie_Crim_Offender2_Dev_Fields.InValid_ace_fips_st((SALT33.StrType)le.ace_fips_st),
    Moxie_Crim_Offender2_Dev_Fields.InValid_ace_fips_county((SALT33.StrType)le.ace_fips_county),
    Moxie_Crim_Offender2_Dev_Fields.InValid_geo_lat((SALT33.StrType)le.geo_lat),
    Moxie_Crim_Offender2_Dev_Fields.InValid_geo_long((SALT33.StrType)le.geo_long),
    Moxie_Crim_Offender2_Dev_Fields.InValid_msa((SALT33.StrType)le.msa),
    Moxie_Crim_Offender2_Dev_Fields.InValid_geo_blk((SALT33.StrType)le.geo_blk),
    Moxie_Crim_Offender2_Dev_Fields.InValid_geo_match((SALT33.StrType)le.geo_match),
    Moxie_Crim_Offender2_Dev_Fields.InValid_err_stat((SALT33.StrType)le.err_stat),
    Moxie_Crim_Offender2_Dev_Fields.InValid_clean_errors((SALT33.StrType)le.clean_errors),
    Moxie_Crim_Offender2_Dev_Fields.InValid_county_name((SALT33.StrType)le.county_name),
    Moxie_Crim_Offender2_Dev_Fields.InValid_did((SALT33.StrType)le.did),
    Moxie_Crim_Offender2_Dev_Fields.InValid_score((SALT33.StrType)le.score),
    Moxie_Crim_Offender2_Dev_Fields.InValid_ssn_appended((SALT33.StrType)le.ssn_appended),
    Moxie_Crim_Offender2_Dev_Fields.InValid_curr_incar_flag((SALT33.StrType)le.curr_incar_flag),
    Moxie_Crim_Offender2_Dev_Fields.InValid_curr_parole_flag((SALT33.StrType)le.curr_parole_flag),
    Moxie_Crim_Offender2_Dev_Fields.InValid_curr_probation_flag((SALT33.StrType)le.curr_probation_flag),
    Moxie_Crim_Offender2_Dev_Fields.InValid_src_upload_date((SALT33.StrType)le.src_upload_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_age((SALT33.StrType)le.age),
    Moxie_Crim_Offender2_Dev_Fields.InValid_image_link((SALT33.StrType)le.image_link),
    Moxie_Crim_Offender2_Dev_Fields.InValid_fcra_conviction_flag((SALT33.StrType)le.fcra_conviction_flag),
    Moxie_Crim_Offender2_Dev_Fields.InValid_fcra_traffic_flag((SALT33.StrType)le.fcra_traffic_flag),
    Moxie_Crim_Offender2_Dev_Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type),
    Moxie_Crim_Offender2_Dev_Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date),
    Moxie_Crim_Offender2_Dev_Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type),
    Moxie_Crim_Offender2_Dev_Fields.InValid_offense_score((SALT33.StrType)le.offense_score),
    Moxie_Crim_Offender2_Dev_Fields.InValid_offender_persistent_id((SALT33.StrType)le.offender_persistent_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,119,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := Moxie_Crim_Offender2_Dev_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Current_Date','Invalid_Current_Date','Non_Blank','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_DOB','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Moxie_Crim_Offender2_Dev_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_file_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_offender_key(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_id_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_pty_nm(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_pty_nm_fmt(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_pty_typ(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_nid(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_ntype(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_nindicator(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_nitro_flag(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_case_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_case_court(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_case_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_case_type(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_case_type_desc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_county_of_origin(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_dle_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_fbi_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_doc_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_ins_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_dl_num(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_dl_state(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_citizenship(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_dob_alias(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_county_of_birth(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_place_of_birth(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_street_address_1(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_street_address_2(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_street_address_3(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_street_address_4(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_street_address_5(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_current_residence_county(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_legal_residence_county(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_race(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_race_desc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_sex(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_hair_color(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_hair_color_desc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_eye_color(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_eye_color_desc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_skin_color(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_skin_color_desc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_scars_marks_tattoos_1(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_scars_marks_tattoos_2(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_scars_marks_tattoos_3(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_scars_marks_tattoos_4(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_scars_marks_tattoos_5(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_height(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_weight(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_party_status(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_party_status_desc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage__3g_offender(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_violent_offender(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_sex_offender(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_vop_offender(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_data_type(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_record_setup_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_datasource(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_st(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_ace_fips_county(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_clean_errors(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_did(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_score(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_ssn_appended(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_curr_incar_flag(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_curr_parole_flag(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_curr_probation_flag(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_src_upload_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_age(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_image_link(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_fcra_conviction_flag(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_fcra_traffic_flag(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_fcra_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_fcra_date_type(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_conviction_override_date(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_conviction_override_date_type(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_offense_score(TotalErrors.ErrorNum),Moxie_Crim_Offender2_Dev_Fields.InValidMessage_offender_persistent_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
