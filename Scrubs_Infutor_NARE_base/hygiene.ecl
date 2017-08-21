IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Infutor_NARE_base) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_idnum_pcnt := AVE(GROUP,IF(h.idnum = (TYPEOF(h.idnum))'',0,100));
    maxlength_idnum := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.idnum)));
    avelength_idnum := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.idnum)),h.idnum<>(typeof(h.idnum))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_rectype_pcnt := AVE(GROUP,IF(h.rectype = (TYPEOF(h.rectype))'',0,100));
    maxlength_rectype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rectype)));
    avelength_rectype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rectype)),h.rectype<>(typeof(h.rectype))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_addrline1_pcnt := AVE(GROUP,IF(h.addrline1 = (TYPEOF(h.addrline1))'',0,100));
    maxlength_addrline1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addrline1)));
    avelength_addrline1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addrline1)),h.addrline1<>(typeof(h.addrline1))'');
    populated_streetnum_pcnt := AVE(GROUP,IF(h.streetnum = (TYPEOF(h.streetnum))'',0,100));
    maxlength_streetnum := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetnum)));
    avelength_streetnum := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetnum)),h.streetnum<>(typeof(h.streetnum))'');
    populated_streetpredir_pcnt := AVE(GROUP,IF(h.streetpredir = (TYPEOF(h.streetpredir))'',0,100));
    maxlength_streetpredir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetpredir)));
    avelength_streetpredir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetpredir)),h.streetpredir<>(typeof(h.streetpredir))'');
    populated_streetname_pcnt := AVE(GROUP,IF(h.streetname = (TYPEOF(h.streetname))'',0,100));
    maxlength_streetname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetname)));
    avelength_streetname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetname)),h.streetname<>(typeof(h.streetname))'');
    populated_streetsuffix_pcnt := AVE(GROUP,IF(h.streetsuffix = (TYPEOF(h.streetsuffix))'',0,100));
    maxlength_streetsuffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetsuffix)));
    avelength_streetsuffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetsuffix)),h.streetsuffix<>(typeof(h.streetsuffix))'');
    populated_streetpostdir_pcnt := AVE(GROUP,IF(h.streetpostdir = (TYPEOF(h.streetpostdir))'',0,100));
    maxlength_streetpostdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetpostdir)));
    avelength_streetpostdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.streetpostdir)),h.streetpostdir<>(typeof(h.streetpostdir))'');
    populated_apttype_pcnt := AVE(GROUP,IF(h.apttype = (TYPEOF(h.apttype))'',0,100));
    maxlength_apttype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.apttype)));
    avelength_apttype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.apttype)),h.apttype<>(typeof(h.apttype))'');
    populated_aptnum_pcnt := AVE(GROUP,IF(h.aptnum = (TYPEOF(h.aptnum))'',0,100));
    maxlength_aptnum := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.aptnum)));
    avelength_aptnum := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.aptnum)),h.aptnum<>(typeof(h.aptnum))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_zipplus4_pcnt := AVE(GROUP,IF(h.zipplus4 = (TYPEOF(h.zipplus4))'',0,100));
    maxlength_zipplus4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zipplus4)));
    avelength_zipplus4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zipplus4)),h.zipplus4<>(typeof(h.zipplus4))'');
    populated_dpc_pcnt := AVE(GROUP,IF(h.dpc = (TYPEOF(h.dpc))'',0,100));
    maxlength_dpc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpc)));
    avelength_dpc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpc)),h.dpc<>(typeof(h.dpc))'');
    populated_z4type_pcnt := AVE(GROUP,IF(h.z4type = (TYPEOF(h.z4type))'',0,100));
    maxlength_z4type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.z4type)));
    avelength_z4type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.z4type)),h.z4type<>(typeof(h.z4type))'');
    populated_crte_pcnt := AVE(GROUP,IF(h.crte = (TYPEOF(h.crte))'',0,100));
    maxlength_crte := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crte)));
    avelength_crte := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crte)),h.crte<>(typeof(h.crte))'');
    populated_fipscounty_pcnt := AVE(GROUP,IF(h.fipscounty = (TYPEOF(h.fipscounty))'',0,100));
    maxlength_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fipscounty)));
    avelength_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fipscounty)),h.fipscounty<>(typeof(h.fipscounty))'');
    populated_dpv_pcnt := AVE(GROUP,IF(h.dpv = (TYPEOF(h.dpv))'',0,100));
    maxlength_dpv := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpv)));
    avelength_dpv := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpv)),h.dpv<>(typeof(h.dpv))'');
    populated_vacantflag_pcnt := AVE(GROUP,IF(h.vacantflag = (TYPEOF(h.vacantflag))'',0,100));
    maxlength_vacantflag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vacantflag)));
    avelength_vacantflag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vacantflag)),h.vacantflag<>(typeof(h.vacantflag))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone2_pcnt := AVE(GROUP,IF(h.phone2 = (TYPEOF(h.phone2))'',0,100));
    maxlength_phone2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone2)));
    avelength_phone2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone2)),h.phone2<>(typeof(h.phone2))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_ipaddr_pcnt := AVE(GROUP,IF(h.ipaddr = (TYPEOF(h.ipaddr))'',0,100));
    maxlength_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ipaddr)));
    avelength_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ipaddr)),h.ipaddr<>(typeof(h.ipaddr))'');
    populated_wesitetype_pcnt := AVE(GROUP,IF(h.wesitetype = (TYPEOF(h.wesitetype))'',0,100));
    maxlength_wesitetype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.wesitetype)));
    avelength_wesitetype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.wesitetype)),h.wesitetype<>(typeof(h.wesitetype))'');
    populated_datefirstseen_pcnt := AVE(GROUP,IF(h.datefirstseen = (TYPEOF(h.datefirstseen))'',0,100));
    maxlength_datefirstseen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datefirstseen)));
    avelength_datefirstseen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datefirstseen)),h.datefirstseen<>(typeof(h.datefirstseen))'');
    populated_datelastseen_pcnt := AVE(GROUP,IF(h.datelastseen = (TYPEOF(h.datelastseen))'',0,100));
    maxlength_datelastseen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datelastseen)));
    avelength_datelastseen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datelastseen)),h.datelastseen<>(typeof(h.datelastseen))'');
    populated_filedate_pcnt := AVE(GROUP,IF(h.filedate = (TYPEOF(h.filedate))'',0,100));
    maxlength_filedate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filedate)));
    avelength_filedate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filedate)),h.filedate<>(typeof(h.filedate))'');
    populated_confidencescore_pcnt := AVE(GROUP,IF(h.confidencescore = (TYPEOF(h.confidencescore))'',0,100));
    maxlength_confidencescore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.confidencescore)));
    avelength_confidencescore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.confidencescore)),h.confidencescore<>(typeof(h.confidencescore))'');
    populated_occurance_pcnt := AVE(GROUP,IF(h.occurance = (TYPEOF(h.occurance))'',0,100));
    maxlength_occurance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.occurance)));
    avelength_occurance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.occurance)),h.occurance<>(typeof(h.occurance))'');
    populated_persistid_pcnt := AVE(GROUP,IF(h.persistid = (TYPEOF(h.persistid))'',0,100));
    maxlength_persistid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistid)));
    avelength_persistid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistid)),h.persistid<>(typeof(h.persistid))'');
    populated_emailsuppressioncd_pcnt := AVE(GROUP,IF(h.emailsuppressioncd = (TYPEOF(h.emailsuppressioncd))'',0,100));
    maxlength_emailsuppressioncd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.emailsuppressioncd)));
    avelength_emailsuppressioncd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.emailsuppressioncd)),h.emailsuppressioncd<>(typeof(h.emailsuppressioncd))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_clean_title_pcnt := AVE(GROUP,IF(h.clean_title = (TYPEOF(h.clean_title))'',0,100));
    maxlength_clean_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_title)));
    avelength_clean_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_title)),h.clean_title<>(typeof(h.clean_title))'');
    populated_clean_fname_pcnt := AVE(GROUP,IF(h.clean_fname = (TYPEOF(h.clean_fname))'',0,100));
    maxlength_clean_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_fname)));
    avelength_clean_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_fname)),h.clean_fname<>(typeof(h.clean_fname))'');
    populated_clean_mname_pcnt := AVE(GROUP,IF(h.clean_mname = (TYPEOF(h.clean_mname))'',0,100));
    maxlength_clean_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_mname)));
    avelength_clean_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_mname)),h.clean_mname<>(typeof(h.clean_mname))'');
    populated_clean_lname_pcnt := AVE(GROUP,IF(h.clean_lname = (TYPEOF(h.clean_lname))'',0,100));
    maxlength_clean_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lname)));
    avelength_clean_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lname)),h.clean_lname<>(typeof(h.clean_lname))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_append_prep_address_situs_pcnt := AVE(GROUP,IF(h.append_prep_address_situs = (TYPEOF(h.append_prep_address_situs))'',0,100));
    maxlength_append_prep_address_situs := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_prep_address_situs)));
    avelength_append_prep_address_situs := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_prep_address_situs)),h.append_prep_address_situs<>(typeof(h.append_prep_address_situs))'');
    populated_append_prep_address_last_situs_pcnt := AVE(GROUP,IF(h.append_prep_address_last_situs = (TYPEOF(h.append_prep_address_last_situs))'',0,100));
    maxlength_append_prep_address_last_situs := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_prep_address_last_situs)));
    avelength_append_prep_address_last_situs := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_prep_address_last_situs)),h.append_prep_address_last_situs<>(typeof(h.append_prep_address_last_situs))'');
    populated_clean_prim_range_pcnt := AVE(GROUP,IF(h.clean_prim_range = (TYPEOF(h.clean_prim_range))'',0,100));
    maxlength_clean_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_prim_range)));
    avelength_clean_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_prim_range)),h.clean_prim_range<>(typeof(h.clean_prim_range))'');
    populated_clean_predir_pcnt := AVE(GROUP,IF(h.clean_predir = (TYPEOF(h.clean_predir))'',0,100));
    maxlength_clean_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_predir)));
    avelength_clean_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_predir)),h.clean_predir<>(typeof(h.clean_predir))'');
    populated_clean_prim_name_pcnt := AVE(GROUP,IF(h.clean_prim_name = (TYPEOF(h.clean_prim_name))'',0,100));
    maxlength_clean_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_prim_name)));
    avelength_clean_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_prim_name)),h.clean_prim_name<>(typeof(h.clean_prim_name))'');
    populated_clean_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_addr_suffix = (TYPEOF(h.clean_addr_suffix))'',0,100));
    maxlength_clean_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_addr_suffix)));
    avelength_clean_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_addr_suffix)),h.clean_addr_suffix<>(typeof(h.clean_addr_suffix))'');
    populated_clean_postdir_pcnt := AVE(GROUP,IF(h.clean_postdir = (TYPEOF(h.clean_postdir))'',0,100));
    maxlength_clean_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_postdir)));
    avelength_clean_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_postdir)),h.clean_postdir<>(typeof(h.clean_postdir))'');
    populated_clean_unit_desig_pcnt := AVE(GROUP,IF(h.clean_unit_desig = (TYPEOF(h.clean_unit_desig))'',0,100));
    maxlength_clean_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_unit_desig)));
    avelength_clean_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_unit_desig)),h.clean_unit_desig<>(typeof(h.clean_unit_desig))'');
    populated_clean_sec_range_pcnt := AVE(GROUP,IF(h.clean_sec_range = (TYPEOF(h.clean_sec_range))'',0,100));
    maxlength_clean_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_sec_range)));
    avelength_clean_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_sec_range)),h.clean_sec_range<>(typeof(h.clean_sec_range))'');
    populated_clean_p_city_name_pcnt := AVE(GROUP,IF(h.clean_p_city_name = (TYPEOF(h.clean_p_city_name))'',0,100));
    maxlength_clean_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_p_city_name)));
    avelength_clean_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_p_city_name)),h.clean_p_city_name<>(typeof(h.clean_p_city_name))'');
    populated_clean_v_city_name_pcnt := AVE(GROUP,IF(h.clean_v_city_name = (TYPEOF(h.clean_v_city_name))'',0,100));
    maxlength_clean_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_v_city_name)));
    avelength_clean_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_v_city_name)),h.clean_v_city_name<>(typeof(h.clean_v_city_name))'');
    populated_clean_st_pcnt := AVE(GROUP,IF(h.clean_st = (TYPEOF(h.clean_st))'',0,100));
    maxlength_clean_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_st)));
    avelength_clean_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_st)),h.clean_st<>(typeof(h.clean_st))'');
    populated_clean_zip_pcnt := AVE(GROUP,IF(h.clean_zip = (TYPEOF(h.clean_zip))'',0,100));
    maxlength_clean_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_zip)));
    avelength_clean_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_zip)),h.clean_zip<>(typeof(h.clean_zip))'');
    populated_clean_zip4_pcnt := AVE(GROUP,IF(h.clean_zip4 = (TYPEOF(h.clean_zip4))'',0,100));
    maxlength_clean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_zip4)));
    avelength_clean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_zip4)),h.clean_zip4<>(typeof(h.clean_zip4))'');
    populated_clean_cart_pcnt := AVE(GROUP,IF(h.clean_cart = (TYPEOF(h.clean_cart))'',0,100));
    maxlength_clean_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_cart)));
    avelength_clean_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_cart)),h.clean_cart<>(typeof(h.clean_cart))'');
    populated_clean_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_cr_sort_sz = (TYPEOF(h.clean_cr_sort_sz))'',0,100));
    maxlength_clean_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_cr_sort_sz)));
    avelength_clean_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_cr_sort_sz)),h.clean_cr_sort_sz<>(typeof(h.clean_cr_sort_sz))'');
    populated_clean_lot_pcnt := AVE(GROUP,IF(h.clean_lot = (TYPEOF(h.clean_lot))'',0,100));
    maxlength_clean_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lot)));
    avelength_clean_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lot)),h.clean_lot<>(typeof(h.clean_lot))'');
    populated_clean_lot_order_pcnt := AVE(GROUP,IF(h.clean_lot_order = (TYPEOF(h.clean_lot_order))'',0,100));
    maxlength_clean_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lot_order)));
    avelength_clean_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lot_order)),h.clean_lot_order<>(typeof(h.clean_lot_order))'');
    populated_clean_dbpc_pcnt := AVE(GROUP,IF(h.clean_dbpc = (TYPEOF(h.clean_dbpc))'',0,100));
    maxlength_clean_dbpc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_dbpc)));
    avelength_clean_dbpc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_dbpc)),h.clean_dbpc<>(typeof(h.clean_dbpc))'');
    populated_clean_chk_digit_pcnt := AVE(GROUP,IF(h.clean_chk_digit = (TYPEOF(h.clean_chk_digit))'',0,100));
    maxlength_clean_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_chk_digit)));
    avelength_clean_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_chk_digit)),h.clean_chk_digit<>(typeof(h.clean_chk_digit))'');
    populated_clean_rec_type_pcnt := AVE(GROUP,IF(h.clean_rec_type = (TYPEOF(h.clean_rec_type))'',0,100));
    maxlength_clean_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_rec_type)));
    avelength_clean_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_rec_type)),h.clean_rec_type<>(typeof(h.clean_rec_type))'');
    populated_clean_county_pcnt := AVE(GROUP,IF(h.clean_county = (TYPEOF(h.clean_county))'',0,100));
    maxlength_clean_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_county)));
    avelength_clean_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_county)),h.clean_county<>(typeof(h.clean_county))'');
    populated_clean_geo_lat_pcnt := AVE(GROUP,IF(h.clean_geo_lat = (TYPEOF(h.clean_geo_lat))'',0,100));
    maxlength_clean_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_lat)));
    avelength_clean_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_lat)),h.clean_geo_lat<>(typeof(h.clean_geo_lat))'');
    populated_clean_geo_long_pcnt := AVE(GROUP,IF(h.clean_geo_long = (TYPEOF(h.clean_geo_long))'',0,100));
    maxlength_clean_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_long)));
    avelength_clean_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_long)),h.clean_geo_long<>(typeof(h.clean_geo_long))'');
    populated_clean_msa_pcnt := AVE(GROUP,IF(h.clean_msa = (TYPEOF(h.clean_msa))'',0,100));
    maxlength_clean_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_msa)));
    avelength_clean_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_msa)),h.clean_msa<>(typeof(h.clean_msa))'');
    populated_clean_geo_blk_pcnt := AVE(GROUP,IF(h.clean_geo_blk = (TYPEOF(h.clean_geo_blk))'',0,100));
    maxlength_clean_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_blk)));
    avelength_clean_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_blk)),h.clean_geo_blk<>(typeof(h.clean_geo_blk))'');
    populated_clean_geo_match_pcnt := AVE(GROUP,IF(h.clean_geo_match = (TYPEOF(h.clean_geo_match))'',0,100));
    maxlength_clean_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_match)));
    avelength_clean_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_geo_match)),h.clean_geo_match<>(typeof(h.clean_geo_match))'');
    populated_clean_err_stat_pcnt := AVE(GROUP,IF(h.clean_err_stat = (TYPEOF(h.clean_err_stat))'',0,100));
    maxlength_clean_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_err_stat)));
    avelength_clean_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_err_stat)),h.clean_err_stat<>(typeof(h.clean_err_stat))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_current_rec_flag_pcnt := AVE(GROUP,IF(h.current_rec_flag = (TYPEOF(h.current_rec_flag))'',0,100));
    maxlength_current_rec_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_rec_flag)));
    avelength_current_rec_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_rec_flag)),h.current_rec_flag<>(typeof(h.current_rec_flag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_idnum_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_rectype_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_addrline1_pcnt *   0.00 / 100 + T.Populated_streetnum_pcnt *   0.00 / 100 + T.Populated_streetpredir_pcnt *   0.00 / 100 + T.Populated_streetname_pcnt *   0.00 / 100 + T.Populated_streetsuffix_pcnt *   0.00 / 100 + T.Populated_streetpostdir_pcnt *   0.00 / 100 + T.Populated_apttype_pcnt *   0.00 / 100 + T.Populated_aptnum_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_zipplus4_pcnt *   0.00 / 100 + T.Populated_dpc_pcnt *   0.00 / 100 + T.Populated_z4type_pcnt *   0.00 / 100 + T.Populated_crte_pcnt *   0.00 / 100 + T.Populated_fipscounty_pcnt *   0.00 / 100 + T.Populated_dpv_pcnt *   0.00 / 100 + T.Populated_vacantflag_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone2_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_ipaddr_pcnt *   0.00 / 100 + T.Populated_wesitetype_pcnt *   0.00 / 100 + T.Populated_datefirstseen_pcnt *   0.00 / 100 + T.Populated_datelastseen_pcnt *   0.00 / 100 + T.Populated_filedate_pcnt *   0.00 / 100 + T.Populated_confidencescore_pcnt *   0.00 / 100 + T.Populated_occurance_pcnt *   0.00 / 100 + T.Populated_persistid_pcnt *   0.00 / 100 + T.Populated_emailsuppressioncd_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_clean_title_pcnt *   0.00 / 100 + T.Populated_clean_fname_pcnt *   0.00 / 100 + T.Populated_clean_mname_pcnt *   0.00 / 100 + T.Populated_clean_lname_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_append_prep_address_situs_pcnt *   0.00 / 100 + T.Populated_append_prep_address_last_situs_pcnt *   0.00 / 100 + T.Populated_clean_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_predir_pcnt *   0.00 / 100 + T.Populated_clean_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_postdir_pcnt *   0.00 / 100 + T.Populated_clean_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_st_pcnt *   0.00 / 100 + T.Populated_clean_zip_pcnt *   0.00 / 100 + T.Populated_clean_zip4_pcnt *   0.00 / 100 + T.Populated_clean_cart_pcnt *   0.00 / 100 + T.Populated_clean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_lot_pcnt *   0.00 / 100 + T.Populated_clean_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_dbpc_pcnt *   0.00 / 100 + T.Populated_clean_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_county_pcnt *   0.00 / 100 + T.Populated_clean_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_msa_pcnt *   0.00 / 100 + T.Populated_clean_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_err_stat_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_current_rec_flag_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'idnum','firstname','middlename','lastname','suffix','rectype','gender','dob','addrline1','streetnum','streetpredir','streetname','streetsuffix','streetpostdir','apttype','aptnum','city','state','zipcode','zipplus4','dpc','z4type','crte','fipscounty','dpv','vacantflag','phone','phone2','email','url','ipaddr','wesitetype','datefirstseen','datelastseen','filedate','confidencescore','occurance','persistid','emailsuppressioncd','age','persistent_record_id','did','did_score','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','rawaid','append_prep_address_situs','append_prep_address_last_situs','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dbpc','clean_chk_digit','clean_rec_type','clean_county','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','current_rec_flag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_idnum_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_lastname_pcnt,le.populated_suffix_pcnt,le.populated_rectype_pcnt,le.populated_gender_pcnt,le.populated_dob_pcnt,le.populated_addrline1_pcnt,le.populated_streetnum_pcnt,le.populated_streetpredir_pcnt,le.populated_streetname_pcnt,le.populated_streetsuffix_pcnt,le.populated_streetpostdir_pcnt,le.populated_apttype_pcnt,le.populated_aptnum_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_zipplus4_pcnt,le.populated_dpc_pcnt,le.populated_z4type_pcnt,le.populated_crte_pcnt,le.populated_fipscounty_pcnt,le.populated_dpv_pcnt,le.populated_vacantflag_pcnt,le.populated_phone_pcnt,le.populated_phone2_pcnt,le.populated_email_pcnt,le.populated_url_pcnt,le.populated_ipaddr_pcnt,le.populated_wesitetype_pcnt,le.populated_datefirstseen_pcnt,le.populated_datelastseen_pcnt,le.populated_filedate_pcnt,le.populated_confidencescore_pcnt,le.populated_occurance_pcnt,le.populated_persistid_pcnt,le.populated_emailsuppressioncd_pcnt,le.populated_age_pcnt,le.populated_persistent_record_id_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_clean_title_pcnt,le.populated_clean_fname_pcnt,le.populated_clean_mname_pcnt,le.populated_clean_lname_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_rawaid_pcnt,le.populated_append_prep_address_situs_pcnt,le.populated_append_prep_address_last_situs_pcnt,le.populated_clean_prim_range_pcnt,le.populated_clean_predir_pcnt,le.populated_clean_prim_name_pcnt,le.populated_clean_addr_suffix_pcnt,le.populated_clean_postdir_pcnt,le.populated_clean_unit_desig_pcnt,le.populated_clean_sec_range_pcnt,le.populated_clean_p_city_name_pcnt,le.populated_clean_v_city_name_pcnt,le.populated_clean_st_pcnt,le.populated_clean_zip_pcnt,le.populated_clean_zip4_pcnt,le.populated_clean_cart_pcnt,le.populated_clean_cr_sort_sz_pcnt,le.populated_clean_lot_pcnt,le.populated_clean_lot_order_pcnt,le.populated_clean_dbpc_pcnt,le.populated_clean_chk_digit_pcnt,le.populated_clean_rec_type_pcnt,le.populated_clean_county_pcnt,le.populated_clean_geo_lat_pcnt,le.populated_clean_geo_long_pcnt,le.populated_clean_msa_pcnt,le.populated_clean_geo_blk_pcnt,le.populated_clean_geo_match_pcnt,le.populated_clean_err_stat_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_current_rec_flag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_idnum,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_lastname,le.maxlength_suffix,le.maxlength_rectype,le.maxlength_gender,le.maxlength_dob,le.maxlength_addrline1,le.maxlength_streetnum,le.maxlength_streetpredir,le.maxlength_streetname,le.maxlength_streetsuffix,le.maxlength_streetpostdir,le.maxlength_apttype,le.maxlength_aptnum,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_zipplus4,le.maxlength_dpc,le.maxlength_z4type,le.maxlength_crte,le.maxlength_fipscounty,le.maxlength_dpv,le.maxlength_vacantflag,le.maxlength_phone,le.maxlength_phone2,le.maxlength_email,le.maxlength_url,le.maxlength_ipaddr,le.maxlength_wesitetype,le.maxlength_datefirstseen,le.maxlength_datelastseen,le.maxlength_filedate,le.maxlength_confidencescore,le.maxlength_occurance,le.maxlength_persistid,le.maxlength_emailsuppressioncd,le.maxlength_age,le.maxlength_persistent_record_id,le.maxlength_did,le.maxlength_did_score,le.maxlength_clean_title,le.maxlength_clean_fname,le.maxlength_clean_mname,le.maxlength_clean_lname,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_rawaid,le.maxlength_append_prep_address_situs,le.maxlength_append_prep_address_last_situs,le.maxlength_clean_prim_range,le.maxlength_clean_predir,le.maxlength_clean_prim_name,le.maxlength_clean_addr_suffix,le.maxlength_clean_postdir,le.maxlength_clean_unit_desig,le.maxlength_clean_sec_range,le.maxlength_clean_p_city_name,le.maxlength_clean_v_city_name,le.maxlength_clean_st,le.maxlength_clean_zip,le.maxlength_clean_zip4,le.maxlength_clean_cart,le.maxlength_clean_cr_sort_sz,le.maxlength_clean_lot,le.maxlength_clean_lot_order,le.maxlength_clean_dbpc,le.maxlength_clean_chk_digit,le.maxlength_clean_rec_type,le.maxlength_clean_county,le.maxlength_clean_geo_lat,le.maxlength_clean_geo_long,le.maxlength_clean_msa,le.maxlength_clean_geo_blk,le.maxlength_clean_geo_match,le.maxlength_clean_err_stat,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_current_rec_flag);
  SELF.avelength := CHOOSE(C,le.avelength_idnum,le.avelength_firstname,le.avelength_middlename,le.avelength_lastname,le.avelength_suffix,le.avelength_rectype,le.avelength_gender,le.avelength_dob,le.avelength_addrline1,le.avelength_streetnum,le.avelength_streetpredir,le.avelength_streetname,le.avelength_streetsuffix,le.avelength_streetpostdir,le.avelength_apttype,le.avelength_aptnum,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_zipplus4,le.avelength_dpc,le.avelength_z4type,le.avelength_crte,le.avelength_fipscounty,le.avelength_dpv,le.avelength_vacantflag,le.avelength_phone,le.avelength_phone2,le.avelength_email,le.avelength_url,le.avelength_ipaddr,le.avelength_wesitetype,le.avelength_datefirstseen,le.avelength_datelastseen,le.avelength_filedate,le.avelength_confidencescore,le.avelength_occurance,le.avelength_persistid,le.avelength_emailsuppressioncd,le.avelength_age,le.avelength_persistent_record_id,le.avelength_did,le.avelength_did_score,le.avelength_clean_title,le.avelength_clean_fname,le.avelength_clean_mname,le.avelength_clean_lname,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_rawaid,le.avelength_append_prep_address_situs,le.avelength_append_prep_address_last_situs,le.avelength_clean_prim_range,le.avelength_clean_predir,le.avelength_clean_prim_name,le.avelength_clean_addr_suffix,le.avelength_clean_postdir,le.avelength_clean_unit_desig,le.avelength_clean_sec_range,le.avelength_clean_p_city_name,le.avelength_clean_v_city_name,le.avelength_clean_st,le.avelength_clean_zip,le.avelength_clean_zip4,le.avelength_clean_cart,le.avelength_clean_cr_sort_sz,le.avelength_clean_lot,le.avelength_clean_lot_order,le.avelength_clean_dbpc,le.avelength_clean_chk_digit,le.avelength_clean_rec_type,le.avelength_clean_county,le.avelength_clean_geo_lat,le.avelength_clean_geo_long,le.avelength_clean_msa,le.avelength_clean_geo_blk,le.avelength_clean_geo_match,le.avelength_clean_err_stat,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_current_rec_flag);
END;
EXPORT invSummary := NORMALIZE(summary0, 84, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.idnum),TRIM((SALT30.StrType)le.firstname),TRIM((SALT30.StrType)le.middlename),TRIM((SALT30.StrType)le.lastname),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.rectype),TRIM((SALT30.StrType)le.gender),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.addrline1),TRIM((SALT30.StrType)le.streetnum),TRIM((SALT30.StrType)le.streetpredir),TRIM((SALT30.StrType)le.streetname),TRIM((SALT30.StrType)le.streetsuffix),TRIM((SALT30.StrType)le.streetpostdir),TRIM((SALT30.StrType)le.apttype),TRIM((SALT30.StrType)le.aptnum),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zipcode),TRIM((SALT30.StrType)le.zipplus4),TRIM((SALT30.StrType)le.dpc),TRIM((SALT30.StrType)le.z4type),TRIM((SALT30.StrType)le.crte),TRIM((SALT30.StrType)le.fipscounty),TRIM((SALT30.StrType)le.dpv),TRIM((SALT30.StrType)le.vacantflag),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.phone2),TRIM((SALT30.StrType)le.email),TRIM((SALT30.StrType)le.url),TRIM((SALT30.StrType)le.ipaddr),TRIM((SALT30.StrType)le.wesitetype),TRIM((SALT30.StrType)le.datefirstseen),TRIM((SALT30.StrType)le.datelastseen),TRIM((SALT30.StrType)le.filedate),TRIM((SALT30.StrType)le.confidencescore),TRIM((SALT30.StrType)le.occurance),TRIM((SALT30.StrType)le.persistid),TRIM((SALT30.StrType)le.emailsuppressioncd),TRIM((SALT30.StrType)le.age),TRIM((SALT30.StrType)le.persistent_record_id),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.clean_title),TRIM((SALT30.StrType)le.clean_fname),TRIM((SALT30.StrType)le.clean_mname),TRIM((SALT30.StrType)le.clean_lname),TRIM((SALT30.StrType)le.clean_name_suffix),TRIM((SALT30.StrType)le.clean_name_score),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.append_prep_address_situs),TRIM((SALT30.StrType)le.append_prep_address_last_situs),TRIM((SALT30.StrType)le.clean_prim_range),TRIM((SALT30.StrType)le.clean_predir),TRIM((SALT30.StrType)le.clean_prim_name),TRIM((SALT30.StrType)le.clean_addr_suffix),TRIM((SALT30.StrType)le.clean_postdir),TRIM((SALT30.StrType)le.clean_unit_desig),TRIM((SALT30.StrType)le.clean_sec_range),TRIM((SALT30.StrType)le.clean_p_city_name),TRIM((SALT30.StrType)le.clean_v_city_name),TRIM((SALT30.StrType)le.clean_st),TRIM((SALT30.StrType)le.clean_zip),TRIM((SALT30.StrType)le.clean_zip4),TRIM((SALT30.StrType)le.clean_cart),TRIM((SALT30.StrType)le.clean_cr_sort_sz),TRIM((SALT30.StrType)le.clean_lot),TRIM((SALT30.StrType)le.clean_lot_order),TRIM((SALT30.StrType)le.clean_dbpc),TRIM((SALT30.StrType)le.clean_chk_digit),TRIM((SALT30.StrType)le.clean_rec_type),TRIM((SALT30.StrType)le.clean_county),TRIM((SALT30.StrType)le.clean_geo_lat),TRIM((SALT30.StrType)le.clean_geo_long),TRIM((SALT30.StrType)le.clean_msa),TRIM((SALT30.StrType)le.clean_geo_blk),TRIM((SALT30.StrType)le.clean_geo_match),TRIM((SALT30.StrType)le.clean_err_stat),TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.current_rec_flag)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,84,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 84);
  SELF.FldNo2 := 1 + (C % 84);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.idnum),TRIM((SALT30.StrType)le.firstname),TRIM((SALT30.StrType)le.middlename),TRIM((SALT30.StrType)le.lastname),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.rectype),TRIM((SALT30.StrType)le.gender),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.addrline1),TRIM((SALT30.StrType)le.streetnum),TRIM((SALT30.StrType)le.streetpredir),TRIM((SALT30.StrType)le.streetname),TRIM((SALT30.StrType)le.streetsuffix),TRIM((SALT30.StrType)le.streetpostdir),TRIM((SALT30.StrType)le.apttype),TRIM((SALT30.StrType)le.aptnum),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zipcode),TRIM((SALT30.StrType)le.zipplus4),TRIM((SALT30.StrType)le.dpc),TRIM((SALT30.StrType)le.z4type),TRIM((SALT30.StrType)le.crte),TRIM((SALT30.StrType)le.fipscounty),TRIM((SALT30.StrType)le.dpv),TRIM((SALT30.StrType)le.vacantflag),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.phone2),TRIM((SALT30.StrType)le.email),TRIM((SALT30.StrType)le.url),TRIM((SALT30.StrType)le.ipaddr),TRIM((SALT30.StrType)le.wesitetype),TRIM((SALT30.StrType)le.datefirstseen),TRIM((SALT30.StrType)le.datelastseen),TRIM((SALT30.StrType)le.filedate),TRIM((SALT30.StrType)le.confidencescore),TRIM((SALT30.StrType)le.occurance),TRIM((SALT30.StrType)le.persistid),TRIM((SALT30.StrType)le.emailsuppressioncd),TRIM((SALT30.StrType)le.age),TRIM((SALT30.StrType)le.persistent_record_id),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.clean_title),TRIM((SALT30.StrType)le.clean_fname),TRIM((SALT30.StrType)le.clean_mname),TRIM((SALT30.StrType)le.clean_lname),TRIM((SALT30.StrType)le.clean_name_suffix),TRIM((SALT30.StrType)le.clean_name_score),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.append_prep_address_situs),TRIM((SALT30.StrType)le.append_prep_address_last_situs),TRIM((SALT30.StrType)le.clean_prim_range),TRIM((SALT30.StrType)le.clean_predir),TRIM((SALT30.StrType)le.clean_prim_name),TRIM((SALT30.StrType)le.clean_addr_suffix),TRIM((SALT30.StrType)le.clean_postdir),TRIM((SALT30.StrType)le.clean_unit_desig),TRIM((SALT30.StrType)le.clean_sec_range),TRIM((SALT30.StrType)le.clean_p_city_name),TRIM((SALT30.StrType)le.clean_v_city_name),TRIM((SALT30.StrType)le.clean_st),TRIM((SALT30.StrType)le.clean_zip),TRIM((SALT30.StrType)le.clean_zip4),TRIM((SALT30.StrType)le.clean_cart),TRIM((SALT30.StrType)le.clean_cr_sort_sz),TRIM((SALT30.StrType)le.clean_lot),TRIM((SALT30.StrType)le.clean_lot_order),TRIM((SALT30.StrType)le.clean_dbpc),TRIM((SALT30.StrType)le.clean_chk_digit),TRIM((SALT30.StrType)le.clean_rec_type),TRIM((SALT30.StrType)le.clean_county),TRIM((SALT30.StrType)le.clean_geo_lat),TRIM((SALT30.StrType)le.clean_geo_long),TRIM((SALT30.StrType)le.clean_msa),TRIM((SALT30.StrType)le.clean_geo_blk),TRIM((SALT30.StrType)le.clean_geo_match),TRIM((SALT30.StrType)le.clean_err_stat),TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.current_rec_flag)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.idnum),TRIM((SALT30.StrType)le.firstname),TRIM((SALT30.StrType)le.middlename),TRIM((SALT30.StrType)le.lastname),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.rectype),TRIM((SALT30.StrType)le.gender),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.addrline1),TRIM((SALT30.StrType)le.streetnum),TRIM((SALT30.StrType)le.streetpredir),TRIM((SALT30.StrType)le.streetname),TRIM((SALT30.StrType)le.streetsuffix),TRIM((SALT30.StrType)le.streetpostdir),TRIM((SALT30.StrType)le.apttype),TRIM((SALT30.StrType)le.aptnum),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zipcode),TRIM((SALT30.StrType)le.zipplus4),TRIM((SALT30.StrType)le.dpc),TRIM((SALT30.StrType)le.z4type),TRIM((SALT30.StrType)le.crte),TRIM((SALT30.StrType)le.fipscounty),TRIM((SALT30.StrType)le.dpv),TRIM((SALT30.StrType)le.vacantflag),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.phone2),TRIM((SALT30.StrType)le.email),TRIM((SALT30.StrType)le.url),TRIM((SALT30.StrType)le.ipaddr),TRIM((SALT30.StrType)le.wesitetype),TRIM((SALT30.StrType)le.datefirstseen),TRIM((SALT30.StrType)le.datelastseen),TRIM((SALT30.StrType)le.filedate),TRIM((SALT30.StrType)le.confidencescore),TRIM((SALT30.StrType)le.occurance),TRIM((SALT30.StrType)le.persistid),TRIM((SALT30.StrType)le.emailsuppressioncd),TRIM((SALT30.StrType)le.age),TRIM((SALT30.StrType)le.persistent_record_id),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.clean_title),TRIM((SALT30.StrType)le.clean_fname),TRIM((SALT30.StrType)le.clean_mname),TRIM((SALT30.StrType)le.clean_lname),TRIM((SALT30.StrType)le.clean_name_suffix),TRIM((SALT30.StrType)le.clean_name_score),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.append_prep_address_situs),TRIM((SALT30.StrType)le.append_prep_address_last_situs),TRIM((SALT30.StrType)le.clean_prim_range),TRIM((SALT30.StrType)le.clean_predir),TRIM((SALT30.StrType)le.clean_prim_name),TRIM((SALT30.StrType)le.clean_addr_suffix),TRIM((SALT30.StrType)le.clean_postdir),TRIM((SALT30.StrType)le.clean_unit_desig),TRIM((SALT30.StrType)le.clean_sec_range),TRIM((SALT30.StrType)le.clean_p_city_name),TRIM((SALT30.StrType)le.clean_v_city_name),TRIM((SALT30.StrType)le.clean_st),TRIM((SALT30.StrType)le.clean_zip),TRIM((SALT30.StrType)le.clean_zip4),TRIM((SALT30.StrType)le.clean_cart),TRIM((SALT30.StrType)le.clean_cr_sort_sz),TRIM((SALT30.StrType)le.clean_lot),TRIM((SALT30.StrType)le.clean_lot_order),TRIM((SALT30.StrType)le.clean_dbpc),TRIM((SALT30.StrType)le.clean_chk_digit),TRIM((SALT30.StrType)le.clean_rec_type),TRIM((SALT30.StrType)le.clean_county),TRIM((SALT30.StrType)le.clean_geo_lat),TRIM((SALT30.StrType)le.clean_geo_long),TRIM((SALT30.StrType)le.clean_msa),TRIM((SALT30.StrType)le.clean_geo_blk),TRIM((SALT30.StrType)le.clean_geo_match),TRIM((SALT30.StrType)le.clean_err_stat),TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.current_rec_flag)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),84*84,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'idnum'}
      ,{2,'firstname'}
      ,{3,'middlename'}
      ,{4,'lastname'}
      ,{5,'suffix'}
      ,{6,'rectype'}
      ,{7,'gender'}
      ,{8,'dob'}
      ,{9,'addrline1'}
      ,{10,'streetnum'}
      ,{11,'streetpredir'}
      ,{12,'streetname'}
      ,{13,'streetsuffix'}
      ,{14,'streetpostdir'}
      ,{15,'apttype'}
      ,{16,'aptnum'}
      ,{17,'city'}
      ,{18,'state'}
      ,{19,'zipcode'}
      ,{20,'zipplus4'}
      ,{21,'dpc'}
      ,{22,'z4type'}
      ,{23,'crte'}
      ,{24,'fipscounty'}
      ,{25,'dpv'}
      ,{26,'vacantflag'}
      ,{27,'phone'}
      ,{28,'phone2'}
      ,{29,'email'}
      ,{30,'url'}
      ,{31,'ipaddr'}
      ,{32,'wesitetype'}
      ,{33,'datefirstseen'}
      ,{34,'datelastseen'}
      ,{35,'filedate'}
      ,{36,'confidencescore'}
      ,{37,'occurance'}
      ,{38,'persistid'}
      ,{39,'emailsuppressioncd'}
      ,{40,'age'}
      ,{41,'persistent_record_id'}
      ,{42,'did'}
      ,{43,'did_score'}
      ,{44,'clean_title'}
      ,{45,'clean_fname'}
      ,{46,'clean_mname'}
      ,{47,'clean_lname'}
      ,{48,'clean_name_suffix'}
      ,{49,'clean_name_score'}
      ,{50,'rawaid'}
      ,{51,'append_prep_address_situs'}
      ,{52,'append_prep_address_last_situs'}
      ,{53,'clean_prim_range'}
      ,{54,'clean_predir'}
      ,{55,'clean_prim_name'}
      ,{56,'clean_addr_suffix'}
      ,{57,'clean_postdir'}
      ,{58,'clean_unit_desig'}
      ,{59,'clean_sec_range'}
      ,{60,'clean_p_city_name'}
      ,{61,'clean_v_city_name'}
      ,{62,'clean_st'}
      ,{63,'clean_zip'}
      ,{64,'clean_zip4'}
      ,{65,'clean_cart'}
      ,{66,'clean_cr_sort_sz'}
      ,{67,'clean_lot'}
      ,{68,'clean_lot_order'}
      ,{69,'clean_dbpc'}
      ,{70,'clean_chk_digit'}
      ,{71,'clean_rec_type'}
      ,{72,'clean_county'}
      ,{73,'clean_geo_lat'}
      ,{74,'clean_geo_long'}
      ,{75,'clean_msa'}
      ,{76,'clean_geo_blk'}
      ,{77,'clean_geo_match'}
      ,{78,'clean_err_stat'}
      ,{79,'process_date'}
      ,{80,'date_first_seen'}
      ,{81,'date_last_seen'}
      ,{82,'date_vendor_first_reported'}
      ,{83,'date_vendor_last_reported'}
      ,{84,'current_rec_flag'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_idnum((SALT30.StrType)le.idnum),
    Fields.InValid_firstname((SALT30.StrType)le.firstname),
    Fields.InValid_middlename((SALT30.StrType)le.middlename),
    Fields.InValid_lastname((SALT30.StrType)le.lastname),
    Fields.InValid_suffix((SALT30.StrType)le.suffix),
    Fields.InValid_rectype((SALT30.StrType)le.rectype),
    Fields.InValid_gender((SALT30.StrType)le.gender),
    Fields.InValid_dob((SALT30.StrType)le.dob),
    Fields.InValid_addrline1((SALT30.StrType)le.addrline1),
    Fields.InValid_streetnum((SALT30.StrType)le.streetnum),
    Fields.InValid_streetpredir((SALT30.StrType)le.streetpredir),
    Fields.InValid_streetname((SALT30.StrType)le.streetname),
    Fields.InValid_streetsuffix((SALT30.StrType)le.streetsuffix),
    Fields.InValid_streetpostdir((SALT30.StrType)le.streetpostdir),
    Fields.InValid_apttype((SALT30.StrType)le.apttype),
    Fields.InValid_aptnum((SALT30.StrType)le.aptnum),
    Fields.InValid_city((SALT30.StrType)le.city),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_zipcode((SALT30.StrType)le.zipcode),
    Fields.InValid_zipplus4((SALT30.StrType)le.zipplus4),
    Fields.InValid_dpc((SALT30.StrType)le.dpc),
    Fields.InValid_z4type((SALT30.StrType)le.z4type),
    Fields.InValid_crte((SALT30.StrType)le.crte),
    Fields.InValid_fipscounty((SALT30.StrType)le.fipscounty),
    Fields.InValid_dpv((SALT30.StrType)le.dpv),
    Fields.InValid_vacantflag((SALT30.StrType)le.vacantflag),
    Fields.InValid_phone((SALT30.StrType)le.phone),
    Fields.InValid_phone2((SALT30.StrType)le.phone2),
    Fields.InValid_email((SALT30.StrType)le.email),
    Fields.InValid_url((SALT30.StrType)le.url),
    Fields.InValid_ipaddr((SALT30.StrType)le.ipaddr),
    Fields.InValid_wesitetype((SALT30.StrType)le.wesitetype),
    Fields.InValid_datefirstseen((SALT30.StrType)le.datefirstseen),
    Fields.InValid_datelastseen((SALT30.StrType)le.datelastseen),
    Fields.InValid_filedate((SALT30.StrType)le.filedate),
    Fields.InValid_confidencescore((SALT30.StrType)le.confidencescore),
    Fields.InValid_occurance((SALT30.StrType)le.occurance),
    Fields.InValid_persistid((SALT30.StrType)le.persistid),
    Fields.InValid_emailsuppressioncd((SALT30.StrType)le.emailsuppressioncd),
    Fields.InValid_age((SALT30.StrType)le.age),
    Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_did_score((SALT30.StrType)le.did_score),
    Fields.InValid_clean_title((SALT30.StrType)le.clean_title),
    Fields.InValid_clean_fname((SALT30.StrType)le.clean_fname),
    Fields.InValid_clean_mname((SALT30.StrType)le.clean_mname),
    Fields.InValid_clean_lname((SALT30.StrType)le.clean_lname),
    Fields.InValid_clean_name_suffix((SALT30.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT30.StrType)le.clean_name_score),
    Fields.InValid_rawaid((SALT30.StrType)le.rawaid),
    Fields.InValid_append_prep_address_situs((SALT30.StrType)le.append_prep_address_situs),
    Fields.InValid_append_prep_address_last_situs((SALT30.StrType)le.append_prep_address_last_situs),
    Fields.InValid_clean_prim_range((SALT30.StrType)le.clean_prim_range),
    Fields.InValid_clean_predir((SALT30.StrType)le.clean_predir),
    Fields.InValid_clean_prim_name((SALT30.StrType)le.clean_prim_name),
    Fields.InValid_clean_addr_suffix((SALT30.StrType)le.clean_addr_suffix),
    Fields.InValid_clean_postdir((SALT30.StrType)le.clean_postdir),
    Fields.InValid_clean_unit_desig((SALT30.StrType)le.clean_unit_desig),
    Fields.InValid_clean_sec_range((SALT30.StrType)le.clean_sec_range),
    Fields.InValid_clean_p_city_name((SALT30.StrType)le.clean_p_city_name),
    Fields.InValid_clean_v_city_name((SALT30.StrType)le.clean_v_city_name),
    Fields.InValid_clean_st((SALT30.StrType)le.clean_st),
    Fields.InValid_clean_zip((SALT30.StrType)le.clean_zip),
    Fields.InValid_clean_zip4((SALT30.StrType)le.clean_zip4),
    Fields.InValid_clean_cart((SALT30.StrType)le.clean_cart),
    Fields.InValid_clean_cr_sort_sz((SALT30.StrType)le.clean_cr_sort_sz),
    Fields.InValid_clean_lot((SALT30.StrType)le.clean_lot),
    Fields.InValid_clean_lot_order((SALT30.StrType)le.clean_lot_order),
    Fields.InValid_clean_dbpc((SALT30.StrType)le.clean_dbpc),
    Fields.InValid_clean_chk_digit((SALT30.StrType)le.clean_chk_digit),
    Fields.InValid_clean_rec_type((SALT30.StrType)le.clean_rec_type),
    Fields.InValid_clean_county((SALT30.StrType)le.clean_county),
    Fields.InValid_clean_geo_lat((SALT30.StrType)le.clean_geo_lat),
    Fields.InValid_clean_geo_long((SALT30.StrType)le.clean_geo_long),
    Fields.InValid_clean_msa((SALT30.StrType)le.clean_msa),
    Fields.InValid_clean_geo_blk((SALT30.StrType)le.clean_geo_blk),
    Fields.InValid_clean_geo_match((SALT30.StrType)le.clean_geo_match),
    Fields.InValid_clean_err_stat((SALT30.StrType)le.clean_err_stat),
    Fields.InValid_process_date((SALT30.StrType)le.process_date),
    Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported),
    Fields.InValid_current_rec_flag((SALT30.StrType)le.current_rec_flag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,84,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','invalid_gender','invalid_dob','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_zip','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','invalid_phone','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','invalid_numeric','Unknown','Unknown','Unknown','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','Unknown','Unknown','Unknown','Unknown','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','Unknown','Unknown','invalid_alnum','invalid_alnum','invalid_state','invalid_zip','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_idnum(TotalErrors.ErrorNum),Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_rectype(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_addrline1(TotalErrors.ErrorNum),Fields.InValidMessage_streetnum(TotalErrors.ErrorNum),Fields.InValidMessage_streetpredir(TotalErrors.ErrorNum),Fields.InValidMessage_streetname(TotalErrors.ErrorNum),Fields.InValidMessage_streetsuffix(TotalErrors.ErrorNum),Fields.InValidMessage_streetpostdir(TotalErrors.ErrorNum),Fields.InValidMessage_apttype(TotalErrors.ErrorNum),Fields.InValidMessage_aptnum(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_zipplus4(TotalErrors.ErrorNum),Fields.InValidMessage_dpc(TotalErrors.ErrorNum),Fields.InValidMessage_z4type(TotalErrors.ErrorNum),Fields.InValidMessage_crte(TotalErrors.ErrorNum),Fields.InValidMessage_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_dpv(TotalErrors.ErrorNum),Fields.InValidMessage_vacantflag(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_phone2(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum),Fields.InValidMessage_ipaddr(TotalErrors.ErrorNum),Fields.InValidMessage_wesitetype(TotalErrors.ErrorNum),Fields.InValidMessage_datefirstseen(TotalErrors.ErrorNum),Fields.InValidMessage_datelastseen(TotalErrors.ErrorNum),Fields.InValidMessage_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_confidencescore(TotalErrors.ErrorNum),Fields.InValidMessage_occurance(TotalErrors.ErrorNum),Fields.InValidMessage_persistid(TotalErrors.ErrorNum),Fields.InValidMessage_emailsuppressioncd(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_title(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_mname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_address_situs(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_address_last_situs(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_county(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec_flag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
