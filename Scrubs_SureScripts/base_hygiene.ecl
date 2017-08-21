IMPORT ut,SALT31;
EXPORT base_hygiene(dataset(base_layout_base) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_version_pcnt := AVE(GROUP,IF(h.version = (TYPEOF(h.version))'',0,100));
    maxlength_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.version)));
    avelength_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.version)),h.version<>(typeof(h.version))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_upin_pcnt := AVE(GROUP,IF(h.upin = (TYPEOF(h.upin))'',0,100));
    maxlength_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.upin)));
    avelength_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.upin)),h.upin<>(typeof(h.upin))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_textservicelevelchange_pcnt := AVE(GROUP,IF(h.textservicelevelchange = (TYPEOF(h.textservicelevelchange))'',0,100));
    maxlength_textservicelevelchange := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevelchange)));
    avelength_textservicelevelchange := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevelchange)),h.textservicelevelchange<>(typeof(h.textservicelevelchange))'');
    populated_textservicelevel_pcnt := AVE(GROUP,IF(h.textservicelevel = (TYPEOF(h.textservicelevel))'',0,100));
    maxlength_textservicelevel := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevel)));
    avelength_textservicelevel := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevel)),h.textservicelevel<>(typeof(h.textservicelevel))'');
    populated_suffixname_pcnt := AVE(GROUP,IF(h.suffixname = (TYPEOF(h.suffixname))'',0,100));
    maxlength_suffixname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffixname)));
    avelength_suffixname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffixname)),h.suffixname<>(typeof(h.suffixname))'');
    populated_statelicensenumber_pcnt := AVE(GROUP,IF(h.statelicensenumber = (TYPEOF(h.statelicensenumber))'',0,100));
    maxlength_statelicensenumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.statelicensenumber)));
    avelength_statelicensenumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.statelicensenumber)),h.statelicensenumber<>(typeof(h.statelicensenumber))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_spi_pcnt := AVE(GROUP,IF(h.spi = (TYPEOF(h.spi))'',0,100));
    maxlength_spi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.spi)));
    avelength_spi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.spi)),h.spi<>(typeof(h.spi))'');
    populated_specialtycodeprimary_pcnt := AVE(GROUP,IF(h.specialtycodeprimary = (TYPEOF(h.specialtycodeprimary))'',0,100));
    maxlength_specialtycodeprimary := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialtycodeprimary)));
    avelength_specialtycodeprimary := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialtycodeprimary)),h.specialtycodeprimary<>(typeof(h.specialtycodeprimary))'');
    populated_specialitytype4_pcnt := AVE(GROUP,IF(h.specialitytype4 = (TYPEOF(h.specialitytype4))'',0,100));
    maxlength_specialitytype4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype4)));
    avelength_specialitytype4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype4)),h.specialitytype4<>(typeof(h.specialitytype4))'');
    populated_specialitytype3_pcnt := AVE(GROUP,IF(h.specialitytype3 = (TYPEOF(h.specialitytype3))'',0,100));
    maxlength_specialitytype3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype3)));
    avelength_specialitytype3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype3)),h.specialitytype3<>(typeof(h.specialitytype3))'');
    populated_specialitytype2_pcnt := AVE(GROUP,IF(h.specialitytype2 = (TYPEOF(h.specialitytype2))'',0,100));
    maxlength_specialitytype2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype2)));
    avelength_specialitytype2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype2)),h.specialitytype2<>(typeof(h.specialitytype2))'');
    populated_specialitytype1_pcnt := AVE(GROUP,IF(h.specialitytype1 = (TYPEOF(h.specialitytype1))'',0,100));
    maxlength_specialitytype1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype1)));
    avelength_specialitytype1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype1)),h.specialitytype1<>(typeof(h.specialitytype1))'');
    populated_socialsecurity_pcnt := AVE(GROUP,IF(h.socialsecurity = (TYPEOF(h.socialsecurity))'',0,100));
    maxlength_socialsecurity := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.socialsecurity)));
    avelength_socialsecurity := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.socialsecurity)),h.socialsecurity<>(typeof(h.socialsecurity))'');
    populated_servicelevel_pcnt := AVE(GROUP,IF(h.servicelevel = (TYPEOF(h.servicelevel))'',0,100));
    maxlength_servicelevel := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.servicelevel)));
    avelength_servicelevel := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.servicelevel)),h.servicelevel<>(typeof(h.servicelevel))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_recordchange_pcnt := AVE(GROUP,IF(h.recordchange = (TYPEOF(h.recordchange))'',0,100));
    maxlength_recordchange := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.recordchange)));
    avelength_recordchange := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.recordchange)),h.recordchange<>(typeof(h.recordchange))'');
    populated_priorauthorization_pcnt := AVE(GROUP,IF(h.priorauthorization = (TYPEOF(h.priorauthorization))'',0,100));
    maxlength_priorauthorization := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.priorauthorization)));
    avelength_priorauthorization := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.priorauthorization)),h.priorauthorization<>(typeof(h.priorauthorization))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prefixname_pcnt := AVE(GROUP,IF(h.prefixname = (TYPEOF(h.prefixname))'',0,100));
    maxlength_prefixname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prefixname)));
    avelength_prefixname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prefixname)),h.prefixname<>(typeof(h.prefixname))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_pponumber_pcnt := AVE(GROUP,IF(h.pponumber = (TYPEOF(h.pponumber))'',0,100));
    maxlength_pponumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pponumber)));
    avelength_pponumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pponumber)),h.pponumber<>(typeof(h.pponumber))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_phoneprimary_pcnt := AVE(GROUP,IF(h.phoneprimary = (TYPEOF(h.phoneprimary))'',0,100));
    maxlength_phoneprimary := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phoneprimary)));
    avelength_phoneprimary := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phoneprimary)),h.phoneprimary<>(typeof(h.phoneprimary))'');
    populated_phonealt5qualifier_pcnt := AVE(GROUP,IF(h.phonealt5qualifier = (TYPEOF(h.phonealt5qualifier))'',0,100));
    maxlength_phonealt5qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5qualifier)));
    avelength_phonealt5qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5qualifier)),h.phonealt5qualifier<>(typeof(h.phonealt5qualifier))'');
    populated_phonealt5_pcnt := AVE(GROUP,IF(h.phonealt5 = (TYPEOF(h.phonealt5))'',0,100));
    maxlength_phonealt5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5)));
    avelength_phonealt5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5)),h.phonealt5<>(typeof(h.phonealt5))'');
    populated_phonealt4qualifier_pcnt := AVE(GROUP,IF(h.phonealt4qualifier = (TYPEOF(h.phonealt4qualifier))'',0,100));
    maxlength_phonealt4qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4qualifier)));
    avelength_phonealt4qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4qualifier)),h.phonealt4qualifier<>(typeof(h.phonealt4qualifier))'');
    populated_phonealt4_pcnt := AVE(GROUP,IF(h.phonealt4 = (TYPEOF(h.phonealt4))'',0,100));
    maxlength_phonealt4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4)));
    avelength_phonealt4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4)),h.phonealt4<>(typeof(h.phonealt4))'');
    populated_phonealt3qualifier_pcnt := AVE(GROUP,IF(h.phonealt3qualifier = (TYPEOF(h.phonealt3qualifier))'',0,100));
    maxlength_phonealt3qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3qualifier)));
    avelength_phonealt3qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3qualifier)),h.phonealt3qualifier<>(typeof(h.phonealt3qualifier))'');
    populated_phonealt3_pcnt := AVE(GROUP,IF(h.phonealt3 = (TYPEOF(h.phonealt3))'',0,100));
    maxlength_phonealt3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3)));
    avelength_phonealt3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3)),h.phonealt3<>(typeof(h.phonealt3))'');
    populated_phonealt2qualifier_pcnt := AVE(GROUP,IF(h.phonealt2qualifier = (TYPEOF(h.phonealt2qualifier))'',0,100));
    maxlength_phonealt2qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2qualifier)));
    avelength_phonealt2qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2qualifier)),h.phonealt2qualifier<>(typeof(h.phonealt2qualifier))'');
    populated_phonealt2_pcnt := AVE(GROUP,IF(h.phonealt2 = (TYPEOF(h.phonealt2))'',0,100));
    maxlength_phonealt2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2)));
    avelength_phonealt2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2)),h.phonealt2<>(typeof(h.phonealt2))'');
    populated_phonealt1qualifier_pcnt := AVE(GROUP,IF(h.phonealt1qualifier = (TYPEOF(h.phonealt1qualifier))'',0,100));
    maxlength_phonealt1qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1qualifier)));
    avelength_phonealt1qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1qualifier)),h.phonealt1qualifier<>(typeof(h.phonealt1qualifier))'');
    populated_phonealt1_pcnt := AVE(GROUP,IF(h.phonealt1 = (TYPEOF(h.phonealt1))'',0,100));
    maxlength_phonealt1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1)));
    avelength_phonealt1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1)),h.phonealt1<>(typeof(h.phonealt1))'');
    populated_partneraccount_pcnt := AVE(GROUP,IF(h.partneraccount = (TYPEOF(h.partneraccount))'',0,100));
    maxlength_partneraccount := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.partneraccount)));
    avelength_partneraccount := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.partneraccount)),h.partneraccount<>(typeof(h.partneraccount))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_oldservicelevel_pcnt := AVE(GROUP,IF(h.oldservicelevel = (TYPEOF(h.oldservicelevel))'',0,100));
    maxlength_oldservicelevel := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.oldservicelevel)));
    avelength_oldservicelevel := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.oldservicelevel)),h.oldservicelevel<>(typeof(h.oldservicelevel))'');
    populated_npilocation_pcnt := AVE(GROUP,IF(h.npilocation = (TYPEOF(h.npilocation))'',0,100));
    maxlength_npilocation := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npilocation)));
    avelength_npilocation := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npilocation)),h.npilocation<>(typeof(h.npilocation))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_mutuallydefined_pcnt := AVE(GROUP,IF(h.mutuallydefined = (TYPEOF(h.mutuallydefined))'',0,100));
    maxlength_mutuallydefined := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mutuallydefined)));
    avelength_mutuallydefined := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mutuallydefined)),h.mutuallydefined<>(typeof(h.mutuallydefined))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_medicarenumber_pcnt := AVE(GROUP,IF(h.medicarenumber = (TYPEOF(h.medicarenumber))'',0,100));
    maxlength_medicarenumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicarenumber)));
    avelength_medicarenumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicarenumber)),h.medicarenumber<>(typeof(h.medicarenumber))'');
    populated_medicaidnumber_pcnt := AVE(GROUP,IF(h.medicaidnumber = (TYPEOF(h.medicaidnumber))'',0,100));
    maxlength_medicaidnumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaidnumber)));
    avelength_medicaidnumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaidnumber)),h.medicaidnumber<>(typeof(h.medicaidnumber))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_lastmodifieddate_pcnt := AVE(GROUP,IF(h.lastmodifieddate = (TYPEOF(h.lastmodifieddate))'',0,100));
    maxlength_lastmodifieddate := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastmodifieddate)));
    avelength_lastmodifieddate := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastmodifieddate)),h.lastmodifieddate<>(typeof(h.lastmodifieddate))'');
    populated_instorencpdpid_pcnt := AVE(GROUP,IF(h.instorencpdpid = (TYPEOF(h.instorencpdpid))'',0,100));
    maxlength_instorencpdpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.instorencpdpid)));
    avelength_instorencpdpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.instorencpdpid)),h.instorencpdpid<>(typeof(h.instorencpdpid))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_fileid_pcnt := AVE(GROUP,IF(h.fileid = (TYPEOF(h.fileid))'',0,100));
    maxlength_fileid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fileid)));
    avelength_fileid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fileid)),h.fileid<>(typeof(h.fileid))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_dentistlicensenumber_pcnt := AVE(GROUP,IF(h.dentistlicensenumber = (TYPEOF(h.dentistlicensenumber))'',0,100));
    maxlength_dentistlicensenumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dentistlicensenumber)));
    avelength_dentistlicensenumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dentistlicensenumber)),h.dentistlicensenumber<>(typeof(h.dentistlicensenumber))'');
    populated_dea_pcnt := AVE(GROUP,IF(h.dea = (TYPEOF(h.dea))'',0,100));
    maxlength_dea := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea)));
    avelength_dea := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea)),h.dea<>(typeof(h.dea))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_clinicname_pcnt := AVE(GROUP,IF(h.clinicname = (TYPEOF(h.clinicname))'',0,100));
    maxlength_clinicname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clinicname)));
    avelength_clinicname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clinicname)),h.clinicname<>(typeof(h.clinicname))'');
    populated_clean_clinic_name_pcnt := AVE(GROUP,IF(h.clean_clinic_name = (TYPEOF(h.clean_clinic_name))'',0,100));
    maxlength_clean_clinic_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_clinic_name)));
    avelength_clean_clinic_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_clinic_name)),h.clean_clinic_name<>(typeof(h.clean_clinic_name))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_best_dob_pcnt := AVE(GROUP,IF(h.best_dob = (TYPEOF(h.best_dob))'',0,100));
    maxlength_best_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)));
    avelength_best_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)),h.best_dob<>(typeof(h.best_dob))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_addressline2_pcnt := AVE(GROUP,IF(h.addressline2 = (TYPEOF(h.addressline2))'',0,100));
    maxlength_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline2)));
    avelength_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline2)),h.addressline2<>(typeof(h.addressline2))'');
    populated_addressline1_pcnt := AVE(GROUP,IF(h.addressline1 = (TYPEOF(h.addressline1))'',0,100));
    maxlength_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline1)));
    avelength_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline1)),h.addressline1<>(typeof(h.addressline1))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_activestarttime_pcnt := AVE(GROUP,IF(h.activestarttime = (TYPEOF(h.activestarttime))'',0,100));
    maxlength_activestarttime := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.activestarttime)));
    avelength_activestarttime := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.activestarttime)),h.activestarttime<>(typeof(h.activestarttime))'');
    populated_activeendtime_pcnt := AVE(GROUP,IF(h.activeendtime = (TYPEOF(h.activeendtime))'',0,100));
    maxlength_activeendtime := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.activeendtime)));
    avelength_activeendtime := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.activeendtime)),h.activeendtime<>(typeof(h.activeendtime))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_version_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_upin_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_textservicelevelchange_pcnt *   0.00 / 100 + T.Populated_textservicelevel_pcnt *   0.00 / 100 + T.Populated_suffixname_pcnt *   0.00 / 100 + T.Populated_statelicensenumber_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_spi_pcnt *   0.00 / 100 + T.Populated_specialtycodeprimary_pcnt *   0.00 / 100 + T.Populated_specialitytype4_pcnt *   0.00 / 100 + T.Populated_specialitytype3_pcnt *   0.00 / 100 + T.Populated_specialitytype2_pcnt *   0.00 / 100 + T.Populated_specialitytype1_pcnt *   0.00 / 100 + T.Populated_socialsecurity_pcnt *   0.00 / 100 + T.Populated_servicelevel_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_recordchange_pcnt *   0.00 / 100 + T.Populated_priorauthorization_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_prepped_addr2_pcnt *   0.00 / 100 + T.Populated_prepped_addr1_pcnt *   0.00 / 100 + T.Populated_prefixname_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_pponumber_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_phoneprimary_pcnt *   0.00 / 100 + T.Populated_phonealt5qualifier_pcnt *   0.00 / 100 + T.Populated_phonealt5_pcnt *   0.00 / 100 + T.Populated_phonealt4qualifier_pcnt *   0.00 / 100 + T.Populated_phonealt4_pcnt *   0.00 / 100 + T.Populated_phonealt3qualifier_pcnt *   0.00 / 100 + T.Populated_phonealt3_pcnt *   0.00 / 100 + T.Populated_phonealt2qualifier_pcnt *   0.00 / 100 + T.Populated_phonealt2_pcnt *   0.00 / 100 + T.Populated_phonealt1qualifier_pcnt *   0.00 / 100 + T.Populated_phonealt1_pcnt *   0.00 / 100 + T.Populated_partneraccount_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_oldservicelevel_pcnt *   0.00 / 100 + T.Populated_npilocation_pcnt *   0.00 / 100 + T.Populated_npi_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_mutuallydefined_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_medicarenumber_pcnt *   0.00 / 100 + T.Populated_medicaidnumber_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lnpid_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_lastmodifieddate_pcnt *   0.00 / 100 + T.Populated_instorencpdpid_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_fileid_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_dentistlicensenumber_pcnt *   0.00 / 100 + T.Populated_dea_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clinicname_pcnt *   0.00 / 100 + T.Populated_clean_clinic_name_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_best_dob_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_addressline2_pcnt *   0.00 / 100 + T.Populated_addressline1_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_activestarttime_pcnt *   0.00 / 100 + T.Populated_activeendtime_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'zipcode','zip','zip4','version','v_city_name','upin','unit_desig','title','textservicelevelchange','textservicelevel','suffixname','statelicensenumber','state','st','spi','specialtycodeprimary','specialitytype4','specialitytype3','specialitytype2','specialitytype1','socialsecurity','servicelevel','sec_range','recordchange','priorauthorization','prim_range','prim_name','prepped_addr2','prepped_addr1','prefixname','predir','pponumber','postdir','phoneprimary','phonealt5qualifier','phonealt5','phonealt4qualifier','phonealt4','phonealt3qualifier','phonealt3','phonealt2qualifier','phonealt2','phonealt1qualifier','phonealt1','partneraccount','p_city_name','oldservicelevel','npilocation','npi','nid','name_type','name_suffix','mutuallydefined','mname','middlename','medicarenumber','medicaidnumber','lot','lnpid','lname','lastname','lastmodifieddate','instorencpdpid','fname','firstname','fileid','fax','email','dt_vendor_last_reported','dt_vendor_first_reported','dt_last_seen','dt_first_seen','did_score','did','dentistlicensenumber','dea','cr_sort_sz','clinicname','clean_clinic_name','city','cart','best_ssn','best_dob','bdid_score','bdid','addressline2','addressline1','addr_suffix','activestarttime','activeendtime');
  SELF.populated_pcnt := CHOOSE(C,le.populated_zipcode_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_version_pcnt,le.populated_v_city_name_pcnt,le.populated_upin_pcnt,le.populated_unit_desig_pcnt,le.populated_title_pcnt,le.populated_textservicelevelchange_pcnt,le.populated_textservicelevel_pcnt,le.populated_suffixname_pcnt,le.populated_statelicensenumber_pcnt,le.populated_state_pcnt,le.populated_st_pcnt,le.populated_spi_pcnt,le.populated_specialtycodeprimary_pcnt,le.populated_specialitytype4_pcnt,le.populated_specialitytype3_pcnt,le.populated_specialitytype2_pcnt,le.populated_specialitytype1_pcnt,le.populated_socialsecurity_pcnt,le.populated_servicelevel_pcnt,le.populated_sec_range_pcnt,le.populated_recordchange_pcnt,le.populated_priorauthorization_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_prepped_addr2_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prefixname_pcnt,le.populated_predir_pcnt,le.populated_pponumber_pcnt,le.populated_postdir_pcnt,le.populated_phoneprimary_pcnt,le.populated_phonealt5qualifier_pcnt,le.populated_phonealt5_pcnt,le.populated_phonealt4qualifier_pcnt,le.populated_phonealt4_pcnt,le.populated_phonealt3qualifier_pcnt,le.populated_phonealt3_pcnt,le.populated_phonealt2qualifier_pcnt,le.populated_phonealt2_pcnt,le.populated_phonealt1qualifier_pcnt,le.populated_phonealt1_pcnt,le.populated_partneraccount_pcnt,le.populated_p_city_name_pcnt,le.populated_oldservicelevel_pcnt,le.populated_npilocation_pcnt,le.populated_npi_pcnt,le.populated_nid_pcnt,le.populated_name_type_pcnt,le.populated_name_suffix_pcnt,le.populated_mutuallydefined_pcnt,le.populated_mname_pcnt,le.populated_middlename_pcnt,le.populated_medicarenumber_pcnt,le.populated_medicaidnumber_pcnt,le.populated_lot_pcnt,le.populated_lnpid_pcnt,le.populated_lname_pcnt,le.populated_lastname_pcnt,le.populated_lastmodifieddate_pcnt,le.populated_instorencpdpid_pcnt,le.populated_fname_pcnt,le.populated_firstname_pcnt,le.populated_fileid_pcnt,le.populated_fax_pcnt,le.populated_email_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_first_seen_pcnt,le.populated_did_score_pcnt,le.populated_did_pcnt,le.populated_dentistlicensenumber_pcnt,le.populated_dea_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_clinicname_pcnt,le.populated_clean_clinic_name_pcnt,le.populated_city_pcnt,le.populated_cart_pcnt,le.populated_best_ssn_pcnt,le.populated_best_dob_pcnt,le.populated_bdid_score_pcnt,le.populated_bdid_pcnt,le.populated_addressline2_pcnt,le.populated_addressline1_pcnt,le.populated_addr_suffix_pcnt,le.populated_activestarttime_pcnt,le.populated_activeendtime_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_zipcode,le.maxlength_zip,le.maxlength_zip4,le.maxlength_version,le.maxlength_v_city_name,le.maxlength_upin,le.maxlength_unit_desig,le.maxlength_title,le.maxlength_textservicelevelchange,le.maxlength_textservicelevel,le.maxlength_suffixname,le.maxlength_statelicensenumber,le.maxlength_state,le.maxlength_st,le.maxlength_spi,le.maxlength_specialtycodeprimary,le.maxlength_specialitytype4,le.maxlength_specialitytype3,le.maxlength_specialitytype2,le.maxlength_specialitytype1,le.maxlength_socialsecurity,le.maxlength_servicelevel,le.maxlength_sec_range,le.maxlength_recordchange,le.maxlength_priorauthorization,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_prepped_addr2,le.maxlength_prepped_addr1,le.maxlength_prefixname,le.maxlength_predir,le.maxlength_pponumber,le.maxlength_postdir,le.maxlength_phoneprimary,le.maxlength_phonealt5qualifier,le.maxlength_phonealt5,le.maxlength_phonealt4qualifier,le.maxlength_phonealt4,le.maxlength_phonealt3qualifier,le.maxlength_phonealt3,le.maxlength_phonealt2qualifier,le.maxlength_phonealt2,le.maxlength_phonealt1qualifier,le.maxlength_phonealt1,le.maxlength_partneraccount,le.maxlength_p_city_name,le.maxlength_oldservicelevel,le.maxlength_npilocation,le.maxlength_npi,le.maxlength_nid,le.maxlength_name_type,le.maxlength_name_suffix,le.maxlength_mutuallydefined,le.maxlength_mname,le.maxlength_middlename,le.maxlength_medicarenumber,le.maxlength_medicaidnumber,le.maxlength_lot,le.maxlength_lnpid,le.maxlength_lname,le.maxlength_lastname,le.maxlength_lastmodifieddate,le.maxlength_instorencpdpid,le.maxlength_fname,le.maxlength_firstname,le.maxlength_fileid,le.maxlength_fax,le.maxlength_email,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_last_seen,le.maxlength_dt_first_seen,le.maxlength_did_score,le.maxlength_did,le.maxlength_dentistlicensenumber,le.maxlength_dea,le.maxlength_cr_sort_sz,le.maxlength_clinicname,le.maxlength_clean_clinic_name,le.maxlength_city,le.maxlength_cart,le.maxlength_best_ssn,le.maxlength_best_dob,le.maxlength_bdid_score,le.maxlength_bdid,le.maxlength_addressline2,le.maxlength_addressline1,le.maxlength_addr_suffix,le.maxlength_activestarttime,le.maxlength_activeendtime);
  SELF.avelength := CHOOSE(C,le.avelength_zipcode,le.avelength_zip,le.avelength_zip4,le.avelength_version,le.avelength_v_city_name,le.avelength_upin,le.avelength_unit_desig,le.avelength_title,le.avelength_textservicelevelchange,le.avelength_textservicelevel,le.avelength_suffixname,le.avelength_statelicensenumber,le.avelength_state,le.avelength_st,le.avelength_spi,le.avelength_specialtycodeprimary,le.avelength_specialitytype4,le.avelength_specialitytype3,le.avelength_specialitytype2,le.avelength_specialitytype1,le.avelength_socialsecurity,le.avelength_servicelevel,le.avelength_sec_range,le.avelength_recordchange,le.avelength_priorauthorization,le.avelength_prim_range,le.avelength_prim_name,le.avelength_prepped_addr2,le.avelength_prepped_addr1,le.avelength_prefixname,le.avelength_predir,le.avelength_pponumber,le.avelength_postdir,le.avelength_phoneprimary,le.avelength_phonealt5qualifier,le.avelength_phonealt5,le.avelength_phonealt4qualifier,le.avelength_phonealt4,le.avelength_phonealt3qualifier,le.avelength_phonealt3,le.avelength_phonealt2qualifier,le.avelength_phonealt2,le.avelength_phonealt1qualifier,le.avelength_phonealt1,le.avelength_partneraccount,le.avelength_p_city_name,le.avelength_oldservicelevel,le.avelength_npilocation,le.avelength_npi,le.avelength_nid,le.avelength_name_type,le.avelength_name_suffix,le.avelength_mutuallydefined,le.avelength_mname,le.avelength_middlename,le.avelength_medicarenumber,le.avelength_medicaidnumber,le.avelength_lot,le.avelength_lnpid,le.avelength_lname,le.avelength_lastname,le.avelength_lastmodifieddate,le.avelength_instorencpdpid,le.avelength_fname,le.avelength_firstname,le.avelength_fileid,le.avelength_fax,le.avelength_email,le.avelength_dt_vendor_last_reported,le.avelength_dt_vendor_first_reported,le.avelength_dt_last_seen,le.avelength_dt_first_seen,le.avelength_did_score,le.avelength_did,le.avelength_dentistlicensenumber,le.avelength_dea,le.avelength_cr_sort_sz,le.avelength_clinicname,le.avelength_clean_clinic_name,le.avelength_city,le.avelength_cart,le.avelength_best_ssn,le.avelength_best_dob,le.avelength_bdid_score,le.avelength_bdid,le.avelength_addressline2,le.avelength_addressline1,le.avelength_addr_suffix,le.avelength_activestarttime,le.avelength_activeendtime);
END;
EXPORT invSummary := NORMALIZE(summary0, 90, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.zipcode),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.version),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.textservicelevelchange),TRIM((SALT31.StrType)le.textservicelevel),TRIM((SALT31.StrType)le.suffixname),TRIM((SALT31.StrType)le.statelicensenumber),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.spi),TRIM((SALT31.StrType)le.specialtycodeprimary),TRIM((SALT31.StrType)le.specialitytype4),TRIM((SALT31.StrType)le.specialitytype3),TRIM((SALT31.StrType)le.specialitytype2),TRIM((SALT31.StrType)le.specialitytype1),TRIM((SALT31.StrType)le.socialsecurity),TRIM((SALT31.StrType)le.servicelevel),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.recordchange),TRIM((SALT31.StrType)le.priorauthorization),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prefixname),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.pponumber),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.phoneprimary),TRIM((SALT31.StrType)le.phonealt5qualifier),TRIM((SALT31.StrType)le.phonealt5),TRIM((SALT31.StrType)le.phonealt4qualifier),TRIM((SALT31.StrType)le.phonealt4),TRIM((SALT31.StrType)le.phonealt3qualifier),TRIM((SALT31.StrType)le.phonealt3),TRIM((SALT31.StrType)le.phonealt2qualifier),TRIM((SALT31.StrType)le.phonealt2),TRIM((SALT31.StrType)le.phonealt1qualifier),TRIM((SALT31.StrType)le.phonealt1),TRIM((SALT31.StrType)le.partneraccount),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.oldservicelevel),TRIM((SALT31.StrType)le.npilocation),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.mutuallydefined),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.middlename),TRIM((SALT31.StrType)le.medicarenumber),TRIM((SALT31.StrType)le.medicaidnumber),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.lastmodifieddate),TRIM((SALT31.StrType)le.instorencpdpid),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.fileid),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.dentistlicensenumber),TRIM((SALT31.StrType)le.dea),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.clinicname),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.addressline2),TRIM((SALT31.StrType)le.addressline1),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.activestarttime),TRIM((SALT31.StrType)le.activeendtime)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,90,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 90);
  SELF.FldNo2 := 1 + (C % 90);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.zipcode),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.version),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.textservicelevelchange),TRIM((SALT31.StrType)le.textservicelevel),TRIM((SALT31.StrType)le.suffixname),TRIM((SALT31.StrType)le.statelicensenumber),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.spi),TRIM((SALT31.StrType)le.specialtycodeprimary),TRIM((SALT31.StrType)le.specialitytype4),TRIM((SALT31.StrType)le.specialitytype3),TRIM((SALT31.StrType)le.specialitytype2),TRIM((SALT31.StrType)le.specialitytype1),TRIM((SALT31.StrType)le.socialsecurity),TRIM((SALT31.StrType)le.servicelevel),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.recordchange),TRIM((SALT31.StrType)le.priorauthorization),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prefixname),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.pponumber),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.phoneprimary),TRIM((SALT31.StrType)le.phonealt5qualifier),TRIM((SALT31.StrType)le.phonealt5),TRIM((SALT31.StrType)le.phonealt4qualifier),TRIM((SALT31.StrType)le.phonealt4),TRIM((SALT31.StrType)le.phonealt3qualifier),TRIM((SALT31.StrType)le.phonealt3),TRIM((SALT31.StrType)le.phonealt2qualifier),TRIM((SALT31.StrType)le.phonealt2),TRIM((SALT31.StrType)le.phonealt1qualifier),TRIM((SALT31.StrType)le.phonealt1),TRIM((SALT31.StrType)le.partneraccount),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.oldservicelevel),TRIM((SALT31.StrType)le.npilocation),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.mutuallydefined),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.middlename),TRIM((SALT31.StrType)le.medicarenumber),TRIM((SALT31.StrType)le.medicaidnumber),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.lastmodifieddate),TRIM((SALT31.StrType)le.instorencpdpid),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.fileid),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.dentistlicensenumber),TRIM((SALT31.StrType)le.dea),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.clinicname),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.addressline2),TRIM((SALT31.StrType)le.addressline1),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.activestarttime),TRIM((SALT31.StrType)le.activeendtime)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.zipcode),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.version),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.textservicelevelchange),TRIM((SALT31.StrType)le.textservicelevel),TRIM((SALT31.StrType)le.suffixname),TRIM((SALT31.StrType)le.statelicensenumber),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.spi),TRIM((SALT31.StrType)le.specialtycodeprimary),TRIM((SALT31.StrType)le.specialitytype4),TRIM((SALT31.StrType)le.specialitytype3),TRIM((SALT31.StrType)le.specialitytype2),TRIM((SALT31.StrType)le.specialitytype1),TRIM((SALT31.StrType)le.socialsecurity),TRIM((SALT31.StrType)le.servicelevel),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.recordchange),TRIM((SALT31.StrType)le.priorauthorization),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prefixname),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.pponumber),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.phoneprimary),TRIM((SALT31.StrType)le.phonealt5qualifier),TRIM((SALT31.StrType)le.phonealt5),TRIM((SALT31.StrType)le.phonealt4qualifier),TRIM((SALT31.StrType)le.phonealt4),TRIM((SALT31.StrType)le.phonealt3qualifier),TRIM((SALT31.StrType)le.phonealt3),TRIM((SALT31.StrType)le.phonealt2qualifier),TRIM((SALT31.StrType)le.phonealt2),TRIM((SALT31.StrType)le.phonealt1qualifier),TRIM((SALT31.StrType)le.phonealt1),TRIM((SALT31.StrType)le.partneraccount),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.oldservicelevel),TRIM((SALT31.StrType)le.npilocation),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.mutuallydefined),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.middlename),TRIM((SALT31.StrType)le.medicarenumber),TRIM((SALT31.StrType)le.medicaidnumber),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.lastmodifieddate),TRIM((SALT31.StrType)le.instorencpdpid),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.fileid),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.dentistlicensenumber),TRIM((SALT31.StrType)le.dea),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.clinicname),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.addressline2),TRIM((SALT31.StrType)le.addressline1),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.activestarttime),TRIM((SALT31.StrType)le.activeendtime)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),90*90,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'zipcode'}
      ,{2,'zip'}
      ,{3,'zip4'}
      ,{4,'version'}
      ,{5,'v_city_name'}
      ,{6,'upin'}
      ,{7,'unit_desig'}
      ,{8,'title'}
      ,{9,'textservicelevelchange'}
      ,{10,'textservicelevel'}
      ,{11,'suffixname'}
      ,{12,'statelicensenumber'}
      ,{13,'state'}
      ,{14,'st'}
      ,{15,'spi'}
      ,{16,'specialtycodeprimary'}
      ,{17,'specialitytype4'}
      ,{18,'specialitytype3'}
      ,{19,'specialitytype2'}
      ,{20,'specialitytype1'}
      ,{21,'socialsecurity'}
      ,{22,'servicelevel'}
      ,{23,'sec_range'}
      ,{24,'recordchange'}
      ,{25,'priorauthorization'}
      ,{26,'prim_range'}
      ,{27,'prim_name'}
      ,{28,'prepped_addr2'}
      ,{29,'prepped_addr1'}
      ,{30,'prefixname'}
      ,{31,'predir'}
      ,{32,'pponumber'}
      ,{33,'postdir'}
      ,{34,'phoneprimary'}
      ,{35,'phonealt5qualifier'}
      ,{36,'phonealt5'}
      ,{37,'phonealt4qualifier'}
      ,{38,'phonealt4'}
      ,{39,'phonealt3qualifier'}
      ,{40,'phonealt3'}
      ,{41,'phonealt2qualifier'}
      ,{42,'phonealt2'}
      ,{43,'phonealt1qualifier'}
      ,{44,'phonealt1'}
      ,{45,'partneraccount'}
      ,{46,'p_city_name'}
      ,{47,'oldservicelevel'}
      ,{48,'npilocation'}
      ,{49,'npi'}
      ,{50,'nid'}
      ,{51,'name_type'}
      ,{52,'name_suffix'}
      ,{53,'mutuallydefined'}
      ,{54,'mname'}
      ,{55,'middlename'}
      ,{56,'medicarenumber'}
      ,{57,'medicaidnumber'}
      ,{58,'lot'}
      ,{59,'lnpid'}
      ,{60,'lname'}
      ,{61,'lastname'}
      ,{62,'lastmodifieddate'}
      ,{63,'instorencpdpid'}
      ,{64,'fname'}
      ,{65,'firstname'}
      ,{66,'fileid'}
      ,{67,'fax'}
      ,{68,'email'}
      ,{69,'dt_vendor_last_reported'}
      ,{70,'dt_vendor_first_reported'}
      ,{71,'dt_last_seen'}
      ,{72,'dt_first_seen'}
      ,{73,'did_score'}
      ,{74,'did'}
      ,{75,'dentistlicensenumber'}
      ,{76,'dea'}
      ,{77,'cr_sort_sz'}
      ,{78,'clinicname'}
      ,{79,'clean_clinic_name'}
      ,{80,'city'}
      ,{81,'cart'}
      ,{82,'best_ssn'}
      ,{83,'best_dob'}
      ,{84,'bdid_score'}
      ,{85,'bdid'}
      ,{86,'addressline2'}
      ,{87,'addressline1'}
      ,{88,'addr_suffix'}
      ,{89,'activestarttime'}
      ,{90,'activeendtime'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    base_Fields.InValid_zipcode((SALT31.StrType)le.zipcode),
    base_Fields.InValid_zip((SALT31.StrType)le.zip),
    base_Fields.InValid_zip4((SALT31.StrType)le.zip4),
    base_Fields.InValid_version((SALT31.StrType)le.version),
    base_Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name),
    base_Fields.InValid_upin((SALT31.StrType)le.upin),
    base_Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig),
    base_Fields.InValid_title((SALT31.StrType)le.title),
    base_Fields.InValid_textservicelevelchange((SALT31.StrType)le.textservicelevelchange),
    base_Fields.InValid_textservicelevel((SALT31.StrType)le.textservicelevel),
    base_Fields.InValid_suffixname((SALT31.StrType)le.suffixname),
    base_Fields.InValid_statelicensenumber((SALT31.StrType)le.statelicensenumber),
    base_Fields.InValid_state((SALT31.StrType)le.state),
    base_Fields.InValid_st((SALT31.StrType)le.st),
    base_Fields.InValid_spi((SALT31.StrType)le.spi),
    base_Fields.InValid_specialtycodeprimary((SALT31.StrType)le.specialtycodeprimary),
    base_Fields.InValid_specialitytype4((SALT31.StrType)le.specialitytype4),
    base_Fields.InValid_specialitytype3((SALT31.StrType)le.specialitytype3),
    base_Fields.InValid_specialitytype2((SALT31.StrType)le.specialitytype2),
    base_Fields.InValid_specialitytype1((SALT31.StrType)le.specialitytype1),
    base_Fields.InValid_socialsecurity((SALT31.StrType)le.socialsecurity),
    base_Fields.InValid_servicelevel((SALT31.StrType)le.servicelevel),
    base_Fields.InValid_sec_range((SALT31.StrType)le.sec_range),
    base_Fields.InValid_recordchange((SALT31.StrType)le.recordchange),
    base_Fields.InValid_priorauthorization((SALT31.StrType)le.priorauthorization),
    base_Fields.InValid_prim_range((SALT31.StrType)le.prim_range),
    base_Fields.InValid_prim_name((SALT31.StrType)le.prim_name),
    base_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2),
    base_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1),
    base_Fields.InValid_prefixname((SALT31.StrType)le.prefixname),
    base_Fields.InValid_predir((SALT31.StrType)le.predir),
    base_Fields.InValid_pponumber((SALT31.StrType)le.pponumber),
    base_Fields.InValid_postdir((SALT31.StrType)le.postdir),
    base_Fields.InValid_phoneprimary((SALT31.StrType)le.phoneprimary),
    base_Fields.InValid_phonealt5qualifier((SALT31.StrType)le.phonealt5qualifier),
    base_Fields.InValid_phonealt5((SALT31.StrType)le.phonealt5),
    base_Fields.InValid_phonealt4qualifier((SALT31.StrType)le.phonealt4qualifier),
    base_Fields.InValid_phonealt4((SALT31.StrType)le.phonealt4),
    base_Fields.InValid_phonealt3qualifier((SALT31.StrType)le.phonealt3qualifier),
    base_Fields.InValid_phonealt3((SALT31.StrType)le.phonealt3),
    base_Fields.InValid_phonealt2qualifier((SALT31.StrType)le.phonealt2qualifier),
    base_Fields.InValid_phonealt2((SALT31.StrType)le.phonealt2),
    base_Fields.InValid_phonealt1qualifier((SALT31.StrType)le.phonealt1qualifier),
    base_Fields.InValid_phonealt1((SALT31.StrType)le.phonealt1),
    base_Fields.InValid_partneraccount((SALT31.StrType)le.partneraccount),
    base_Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name),
    base_Fields.InValid_oldservicelevel((SALT31.StrType)le.oldservicelevel),
    base_Fields.InValid_npilocation((SALT31.StrType)le.npilocation),
    base_Fields.InValid_npi((SALT31.StrType)le.npi),
    base_Fields.InValid_nid((SALT31.StrType)le.nid),
    base_Fields.InValid_name_type((SALT31.StrType)le.name_type),
    base_Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix),
    base_Fields.InValid_mutuallydefined((SALT31.StrType)le.mutuallydefined),
    base_Fields.InValid_mname((SALT31.StrType)le.mname),
    base_Fields.InValid_middlename((SALT31.StrType)le.middlename),
    base_Fields.InValid_medicarenumber((SALT31.StrType)le.medicarenumber),
    base_Fields.InValid_medicaidnumber((SALT31.StrType)le.medicaidnumber),
    base_Fields.InValid_lot((SALT31.StrType)le.lot),
    base_Fields.InValid_lnpid((SALT31.StrType)le.lnpid),
    base_Fields.InValid_lname((SALT31.StrType)le.lname),
    base_Fields.InValid_lastname((SALT31.StrType)le.lastname),
    base_Fields.InValid_lastmodifieddate((SALT31.StrType)le.lastmodifieddate),
    base_Fields.InValid_instorencpdpid((SALT31.StrType)le.instorencpdpid),
    base_Fields.InValid_fname((SALT31.StrType)le.fname),
    base_Fields.InValid_firstname((SALT31.StrType)le.firstname),
    base_Fields.InValid_fileid((SALT31.StrType)le.fileid),
    base_Fields.InValid_fax((SALT31.StrType)le.fax),
    base_Fields.InValid_email((SALT31.StrType)le.email),
    base_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported),
    base_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported),
    base_Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen),
    base_Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen),
    base_Fields.InValid_did_score((SALT31.StrType)le.did_score),
    base_Fields.InValid_did((SALT31.StrType)le.did),
    base_Fields.InValid_dentistlicensenumber((SALT31.StrType)le.dentistlicensenumber),
    base_Fields.InValid_dea((SALT31.StrType)le.dea),
    base_Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz),
    base_Fields.InValid_clinicname((SALT31.StrType)le.clinicname),
    base_Fields.InValid_clean_clinic_name((SALT31.StrType)le.clean_clinic_name),
    base_Fields.InValid_city((SALT31.StrType)le.city),
    base_Fields.InValid_cart((SALT31.StrType)le.cart),
    base_Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn),
    base_Fields.InValid_best_dob((SALT31.StrType)le.best_dob),
    base_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score),
    base_Fields.InValid_bdid((SALT31.StrType)le.bdid),
    base_Fields.InValid_addressline2((SALT31.StrType)le.addressline2),
    base_Fields.InValid_addressline1((SALT31.StrType)le.addressline1),
    base_Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix),
    base_Fields.InValid_activestarttime((SALT31.StrType)le.activestarttime),
    base_Fields.InValid_activeendtime((SALT31.StrType)le.activeendtime),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,90,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'zipcode','zip','zip4','version','v_city_name','upin','unit_desig','title','textservicelevelchange','textservicelevel','suffixname','statelicensenumber','state','st','spi','specialtycodeprimary','specialitytype4','specialitytype3','specialitytype2','specialitytype1','socialsecurity','servicelevel','sec_range','recordchange','priorauthorization','prim_range','prim_name','prepped_addr2','prepped_addr1','prefixname','predir','pponumber','postdir','phoneprimary','phonealt5qualifier','phonealt5','phonealt4qualifier','phonealt4','phonealt3qualifier','phonealt3','phonealt2qualifier','phonealt2','phonealt1qualifier','phonealt1','partneraccount','p_city_name','oldservicelevel','npilocation','npi','nid','name_type','name_suffix','mutuallydefined','mname','middlename','medicarenumber','medicaidnumber','lot','lnpid','lname','lastname','lastmodifieddate','instorencpdpid','fname','firstname','fileid','fax','email','dt_vendor_last_reported','dt_vendor_first_reported','dt_last_seen','dt_first_seen','did_score','did','dentistlicensenumber','dea','cr_sort_sz','clinicname','clean_clinic_name','city','cart','best_ssn','best_dob','bdid_score','bdid','addressline2','addressline1','addr_suffix','activestarttime','activeendtime');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,base_Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),base_Fields.InValidMessage_version(TotalErrors.ErrorNum),base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),base_Fields.InValidMessage_upin(TotalErrors.ErrorNum),base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),base_Fields.InValidMessage_title(TotalErrors.ErrorNum),base_Fields.InValidMessage_textservicelevelchange(TotalErrors.ErrorNum),base_Fields.InValidMessage_textservicelevel(TotalErrors.ErrorNum),base_Fields.InValidMessage_suffixname(TotalErrors.ErrorNum),base_Fields.InValidMessage_statelicensenumber(TotalErrors.ErrorNum),base_Fields.InValidMessage_state(TotalErrors.ErrorNum),base_Fields.InValidMessage_st(TotalErrors.ErrorNum),base_Fields.InValidMessage_spi(TotalErrors.ErrorNum),base_Fields.InValidMessage_specialtycodeprimary(TotalErrors.ErrorNum),base_Fields.InValidMessage_specialitytype4(TotalErrors.ErrorNum),base_Fields.InValidMessage_specialitytype3(TotalErrors.ErrorNum),base_Fields.InValidMessage_specialitytype2(TotalErrors.ErrorNum),base_Fields.InValidMessage_specialitytype1(TotalErrors.ErrorNum),base_Fields.InValidMessage_socialsecurity(TotalErrors.ErrorNum),base_Fields.InValidMessage_servicelevel(TotalErrors.ErrorNum),base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),base_Fields.InValidMessage_recordchange(TotalErrors.ErrorNum),base_Fields.InValidMessage_priorauthorization(TotalErrors.ErrorNum),base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),base_Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),base_Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),base_Fields.InValidMessage_prefixname(TotalErrors.ErrorNum),base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),base_Fields.InValidMessage_pponumber(TotalErrors.ErrorNum),base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),base_Fields.InValidMessage_phoneprimary(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt5qualifier(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt5(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt4qualifier(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt4(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt3qualifier(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt3(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt2qualifier(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt2(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt1qualifier(TotalErrors.ErrorNum),base_Fields.InValidMessage_phonealt1(TotalErrors.ErrorNum),base_Fields.InValidMessage_partneraccount(TotalErrors.ErrorNum),base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),base_Fields.InValidMessage_oldservicelevel(TotalErrors.ErrorNum),base_Fields.InValidMessage_npilocation(TotalErrors.ErrorNum),base_Fields.InValidMessage_npi(TotalErrors.ErrorNum),base_Fields.InValidMessage_nid(TotalErrors.ErrorNum),base_Fields.InValidMessage_name_type(TotalErrors.ErrorNum),base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),base_Fields.InValidMessage_mutuallydefined(TotalErrors.ErrorNum),base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),base_Fields.InValidMessage_middlename(TotalErrors.ErrorNum),base_Fields.InValidMessage_medicarenumber(TotalErrors.ErrorNum),base_Fields.InValidMessage_medicaidnumber(TotalErrors.ErrorNum),base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),base_Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),base_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),base_Fields.InValidMessage_lastmodifieddate(TotalErrors.ErrorNum),base_Fields.InValidMessage_instorencpdpid(TotalErrors.ErrorNum),base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),base_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),base_Fields.InValidMessage_fileid(TotalErrors.ErrorNum),base_Fields.InValidMessage_fax(TotalErrors.ErrorNum),base_Fields.InValidMessage_email(TotalErrors.ErrorNum),base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),base_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),base_Fields.InValidMessage_did(TotalErrors.ErrorNum),base_Fields.InValidMessage_dentistlicensenumber(TotalErrors.ErrorNum),base_Fields.InValidMessage_dea(TotalErrors.ErrorNum),base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),base_Fields.InValidMessage_clinicname(TotalErrors.ErrorNum),base_Fields.InValidMessage_clean_clinic_name(TotalErrors.ErrorNum),base_Fields.InValidMessage_city(TotalErrors.ErrorNum),base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),base_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),base_Fields.InValidMessage_best_dob(TotalErrors.ErrorNum),base_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),base_Fields.InValidMessage_addressline2(TotalErrors.ErrorNum),base_Fields.InValidMessage_addressline1(TotalErrors.ErrorNum),base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),base_Fields.InValidMessage_activestarttime(TotalErrors.ErrorNum),base_Fields.InValidMessage_activeendtime(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
