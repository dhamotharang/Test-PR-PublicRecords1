IMPORT ut,SALT31;
EXPORT SureScripts_hygiene(dataset(SureScripts_layout_SureScripts) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_best_dob_pcnt := AVE(GROUP,IF(h.best_dob = (TYPEOF(h.best_dob))'',0,100));
    maxlength_best_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)));
    avelength_best_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)),h.best_dob<>(typeof(h.best_dob))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_spi_pcnt := AVE(GROUP,IF(h.spi = (TYPEOF(h.spi))'',0,100));
    maxlength_spi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.spi)));
    avelength_spi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.spi)),h.spi<>(typeof(h.spi))'');
    populated_dea_pcnt := AVE(GROUP,IF(h.dea = (TYPEOF(h.dea))'',0,100));
    maxlength_dea := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea)));
    avelength_dea := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea)),h.dea<>(typeof(h.dea))'');
    populated_statelicensenumber_pcnt := AVE(GROUP,IF(h.statelicensenumber = (TYPEOF(h.statelicensenumber))'',0,100));
    maxlength_statelicensenumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.statelicensenumber)));
    avelength_statelicensenumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.statelicensenumber)),h.statelicensenumber<>(typeof(h.statelicensenumber))'');
    populated_specialtycodeprimary_pcnt := AVE(GROUP,IF(h.specialtycodeprimary = (TYPEOF(h.specialtycodeprimary))'',0,100));
    maxlength_specialtycodeprimary := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialtycodeprimary)));
    avelength_specialtycodeprimary := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialtycodeprimary)),h.specialtycodeprimary<>(typeof(h.specialtycodeprimary))'');
    populated_prefixname_pcnt := AVE(GROUP,IF(h.prefixname = (TYPEOF(h.prefixname))'',0,100));
    maxlength_prefixname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prefixname)));
    avelength_prefixname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prefixname)),h.prefixname<>(typeof(h.prefixname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_suffixname_pcnt := AVE(GROUP,IF(h.suffixname = (TYPEOF(h.suffixname))'',0,100));
    maxlength_suffixname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffixname)));
    avelength_suffixname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffixname)),h.suffixname<>(typeof(h.suffixname))'');
    populated_clinicname_pcnt := AVE(GROUP,IF(h.clinicname = (TYPEOF(h.clinicname))'',0,100));
    maxlength_clinicname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clinicname)));
    avelength_clinicname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clinicname)),h.clinicname<>(typeof(h.clinicname))'');
    populated_addressline1_pcnt := AVE(GROUP,IF(h.addressline1 = (TYPEOF(h.addressline1))'',0,100));
    maxlength_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline1)));
    avelength_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline1)),h.addressline1<>(typeof(h.addressline1))'');
    populated_addressline2_pcnt := AVE(GROUP,IF(h.addressline2 = (TYPEOF(h.addressline2))'',0,100));
    maxlength_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline2)));
    avelength_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addressline2)),h.addressline2<>(typeof(h.addressline2))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_phoneprimary_pcnt := AVE(GROUP,IF(h.phoneprimary = (TYPEOF(h.phoneprimary))'',0,100));
    maxlength_phoneprimary := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phoneprimary)));
    avelength_phoneprimary := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phoneprimary)),h.phoneprimary<>(typeof(h.phoneprimary))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_phonealt1_pcnt := AVE(GROUP,IF(h.phonealt1 = (TYPEOF(h.phonealt1))'',0,100));
    maxlength_phonealt1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1)));
    avelength_phonealt1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1)),h.phonealt1<>(typeof(h.phonealt1))'');
    populated_phonealt1qualifier_pcnt := AVE(GROUP,IF(h.phonealt1qualifier = (TYPEOF(h.phonealt1qualifier))'',0,100));
    maxlength_phonealt1qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1qualifier)));
    avelength_phonealt1qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt1qualifier)),h.phonealt1qualifier<>(typeof(h.phonealt1qualifier))'');
    populated_phonealt2_pcnt := AVE(GROUP,IF(h.phonealt2 = (TYPEOF(h.phonealt2))'',0,100));
    maxlength_phonealt2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2)));
    avelength_phonealt2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2)),h.phonealt2<>(typeof(h.phonealt2))'');
    populated_phonealt2qualifier_pcnt := AVE(GROUP,IF(h.phonealt2qualifier = (TYPEOF(h.phonealt2qualifier))'',0,100));
    maxlength_phonealt2qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2qualifier)));
    avelength_phonealt2qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt2qualifier)),h.phonealt2qualifier<>(typeof(h.phonealt2qualifier))'');
    populated_phonealt3_pcnt := AVE(GROUP,IF(h.phonealt3 = (TYPEOF(h.phonealt3))'',0,100));
    maxlength_phonealt3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3)));
    avelength_phonealt3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3)),h.phonealt3<>(typeof(h.phonealt3))'');
    populated_phonealt3qualifier_pcnt := AVE(GROUP,IF(h.phonealt3qualifier = (TYPEOF(h.phonealt3qualifier))'',0,100));
    maxlength_phonealt3qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3qualifier)));
    avelength_phonealt3qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt3qualifier)),h.phonealt3qualifier<>(typeof(h.phonealt3qualifier))'');
    populated_phonealt4_pcnt := AVE(GROUP,IF(h.phonealt4 = (TYPEOF(h.phonealt4))'',0,100));
    maxlength_phonealt4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4)));
    avelength_phonealt4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4)),h.phonealt4<>(typeof(h.phonealt4))'');
    populated_phonealt4qualifier_pcnt := AVE(GROUP,IF(h.phonealt4qualifier = (TYPEOF(h.phonealt4qualifier))'',0,100));
    maxlength_phonealt4qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4qualifier)));
    avelength_phonealt4qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt4qualifier)),h.phonealt4qualifier<>(typeof(h.phonealt4qualifier))'');
    populated_phonealt5_pcnt := AVE(GROUP,IF(h.phonealt5 = (TYPEOF(h.phonealt5))'',0,100));
    maxlength_phonealt5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5)));
    avelength_phonealt5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5)),h.phonealt5<>(typeof(h.phonealt5))'');
    populated_phonealt5qualifier_pcnt := AVE(GROUP,IF(h.phonealt5qualifier = (TYPEOF(h.phonealt5qualifier))'',0,100));
    maxlength_phonealt5qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5qualifier)));
    avelength_phonealt5qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phonealt5qualifier)),h.phonealt5qualifier<>(typeof(h.phonealt5qualifier))'');
    populated_activestarttime_pcnt := AVE(GROUP,IF(h.activestarttime = (TYPEOF(h.activestarttime))'',0,100));
    maxlength_activestarttime := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.activestarttime)));
    avelength_activestarttime := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.activestarttime)),h.activestarttime<>(typeof(h.activestarttime))'');
    populated_activeendtime_pcnt := AVE(GROUP,IF(h.activeendtime = (TYPEOF(h.activeendtime))'',0,100));
    maxlength_activeendtime := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.activeendtime)));
    avelength_activeendtime := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.activeendtime)),h.activeendtime<>(typeof(h.activeendtime))'');
    populated_servicelevel_pcnt := AVE(GROUP,IF(h.servicelevel = (TYPEOF(h.servicelevel))'',0,100));
    maxlength_servicelevel := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.servicelevel)));
    avelength_servicelevel := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.servicelevel)),h.servicelevel<>(typeof(h.servicelevel))'');
    populated_partneraccount_pcnt := AVE(GROUP,IF(h.partneraccount = (TYPEOF(h.partneraccount))'',0,100));
    maxlength_partneraccount := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.partneraccount)));
    avelength_partneraccount := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.partneraccount)),h.partneraccount<>(typeof(h.partneraccount))'');
    populated_lastmodifieddate_pcnt := AVE(GROUP,IF(h.lastmodifieddate = (TYPEOF(h.lastmodifieddate))'',0,100));
    maxlength_lastmodifieddate := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastmodifieddate)));
    avelength_lastmodifieddate := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastmodifieddate)),h.lastmodifieddate<>(typeof(h.lastmodifieddate))'');
    populated_recordchange_pcnt := AVE(GROUP,IF(h.recordchange = (TYPEOF(h.recordchange))'',0,100));
    maxlength_recordchange := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.recordchange)));
    avelength_recordchange := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.recordchange)),h.recordchange<>(typeof(h.recordchange))'');
    populated_oldservicelevel_pcnt := AVE(GROUP,IF(h.oldservicelevel = (TYPEOF(h.oldservicelevel))'',0,100));
    maxlength_oldservicelevel := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.oldservicelevel)));
    avelength_oldservicelevel := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.oldservicelevel)),h.oldservicelevel<>(typeof(h.oldservicelevel))'');
    populated_textservicelevel_pcnt := AVE(GROUP,IF(h.textservicelevel = (TYPEOF(h.textservicelevel))'',0,100));
    maxlength_textservicelevel := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevel)));
    avelength_textservicelevel := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevel)),h.textservicelevel<>(typeof(h.textservicelevel))'');
    populated_textservicelevelchange_pcnt := AVE(GROUP,IF(h.textservicelevelchange = (TYPEOF(h.textservicelevelchange))'',0,100));
    maxlength_textservicelevelchange := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevelchange)));
    avelength_textservicelevelchange := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.textservicelevelchange)),h.textservicelevelchange<>(typeof(h.textservicelevelchange))'');
    populated_version_pcnt := AVE(GROUP,IF(h.version = (TYPEOF(h.version))'',0,100));
    maxlength_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.version)));
    avelength_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.version)),h.version<>(typeof(h.version))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_npilocation_pcnt := AVE(GROUP,IF(h.npilocation = (TYPEOF(h.npilocation))'',0,100));
    maxlength_npilocation := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npilocation)));
    avelength_npilocation := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npilocation)),h.npilocation<>(typeof(h.npilocation))'');
    populated_specialitytype1_pcnt := AVE(GROUP,IF(h.specialitytype1 = (TYPEOF(h.specialitytype1))'',0,100));
    maxlength_specialitytype1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype1)));
    avelength_specialitytype1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype1)),h.specialitytype1<>(typeof(h.specialitytype1))'');
    populated_specialitytype2_pcnt := AVE(GROUP,IF(h.specialitytype2 = (TYPEOF(h.specialitytype2))'',0,100));
    maxlength_specialitytype2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype2)));
    avelength_specialitytype2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype2)),h.specialitytype2<>(typeof(h.specialitytype2))'');
    populated_specialitytype3_pcnt := AVE(GROUP,IF(h.specialitytype3 = (TYPEOF(h.specialitytype3))'',0,100));
    maxlength_specialitytype3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype3)));
    avelength_specialitytype3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype3)),h.specialitytype3<>(typeof(h.specialitytype3))'');
    populated_specialitytype4_pcnt := AVE(GROUP,IF(h.specialitytype4 = (TYPEOF(h.specialitytype4))'',0,100));
    maxlength_specialitytype4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype4)));
    avelength_specialitytype4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialitytype4)),h.specialitytype4<>(typeof(h.specialitytype4))'');
    populated_fileid_pcnt := AVE(GROUP,IF(h.fileid = (TYPEOF(h.fileid))'',0,100));
    maxlength_fileid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fileid)));
    avelength_fileid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fileid)),h.fileid<>(typeof(h.fileid))'');
    populated_medicarenumber_pcnt := AVE(GROUP,IF(h.medicarenumber = (TYPEOF(h.medicarenumber))'',0,100));
    maxlength_medicarenumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicarenumber)));
    avelength_medicarenumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicarenumber)),h.medicarenumber<>(typeof(h.medicarenumber))'');
    populated_medicaidnumber_pcnt := AVE(GROUP,IF(h.medicaidnumber = (TYPEOF(h.medicaidnumber))'',0,100));
    maxlength_medicaidnumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaidnumber)));
    avelength_medicaidnumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicaidnumber)),h.medicaidnumber<>(typeof(h.medicaidnumber))'');
    populated_dentistlicensenumber_pcnt := AVE(GROUP,IF(h.dentistlicensenumber = (TYPEOF(h.dentistlicensenumber))'',0,100));
    maxlength_dentistlicensenumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dentistlicensenumber)));
    avelength_dentistlicensenumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dentistlicensenumber)),h.dentistlicensenumber<>(typeof(h.dentistlicensenumber))'');
    populated_upin_pcnt := AVE(GROUP,IF(h.upin = (TYPEOF(h.upin))'',0,100));
    maxlength_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.upin)));
    avelength_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.upin)),h.upin<>(typeof(h.upin))'');
    populated_pponumber_pcnt := AVE(GROUP,IF(h.pponumber = (TYPEOF(h.pponumber))'',0,100));
    maxlength_pponumber := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pponumber)));
    avelength_pponumber := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pponumber)),h.pponumber<>(typeof(h.pponumber))'');
    populated_socialsecurity_pcnt := AVE(GROUP,IF(h.socialsecurity = (TYPEOF(h.socialsecurity))'',0,100));
    maxlength_socialsecurity := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.socialsecurity)));
    avelength_socialsecurity := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.socialsecurity)),h.socialsecurity<>(typeof(h.socialsecurity))'');
    populated_priorauthorization_pcnt := AVE(GROUP,IF(h.priorauthorization = (TYPEOF(h.priorauthorization))'',0,100));
    maxlength_priorauthorization := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.priorauthorization)));
    avelength_priorauthorization := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.priorauthorization)),h.priorauthorization<>(typeof(h.priorauthorization))'');
    populated_mutuallydefined_pcnt := AVE(GROUP,IF(h.mutuallydefined = (TYPEOF(h.mutuallydefined))'',0,100));
    maxlength_mutuallydefined := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mutuallydefined)));
    avelength_mutuallydefined := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mutuallydefined)),h.mutuallydefined<>(typeof(h.mutuallydefined))'');
    populated_instorencpdpid_pcnt := AVE(GROUP,IF(h.instorencpdpid = (TYPEOF(h.instorencpdpid))'',0,100));
    maxlength_instorencpdpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.instorencpdpid)));
    avelength_instorencpdpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.instorencpdpid)),h.instorencpdpid<>(typeof(h.instorencpdpid))'');
    populated_spec_code_pcnt := AVE(GROUP,IF(h.spec_code = (TYPEOF(h.spec_code))'',0,100));
    maxlength_spec_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.spec_code)));
    avelength_spec_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.spec_code)),h.spec_code<>(typeof(h.spec_code))'');
    populated_spec_desc_pcnt := AVE(GROUP,IF(h.spec_desc = (TYPEOF(h.spec_desc))'',0,100));
    maxlength_spec_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.spec_desc)));
    avelength_spec_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.spec_desc)),h.spec_desc<>(typeof(h.spec_desc))'');
    populated_activity_code_pcnt := AVE(GROUP,IF(h.activity_code = (TYPEOF(h.activity_code))'',0,100));
    maxlength_activity_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.activity_code)));
    avelength_activity_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.activity_code)),h.activity_code<>(typeof(h.activity_code))'');
    populated_practice_type_code_pcnt := AVE(GROUP,IF(h.practice_type_code = (TYPEOF(h.practice_type_code))'',0,100));
    maxlength_practice_type_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_type_code)));
    avelength_practice_type_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_type_code)),h.practice_type_code<>(typeof(h.practice_type_code))'');
    populated_practice_type_desc_pcnt := AVE(GROUP,IF(h.practice_type_desc = (TYPEOF(h.practice_type_desc))'',0,100));
    maxlength_practice_type_desc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_type_desc)));
    avelength_practice_type_desc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.practice_type_desc)),h.practice_type_desc<>(typeof(h.practice_type_desc))'');
    populated_taxonomy_pcnt := AVE(GROUP,IF(h.taxonomy = (TYPEOF(h.taxonomy))'',0,100));
    maxlength_taxonomy := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy)));
    avelength_taxonomy := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy)),h.taxonomy<>(typeof(h.taxonomy))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_source_rid_pcnt := AVE(GROUP,IF(h.source_rid = (TYPEOF(h.source_rid))'',0,100));
    maxlength_source_rid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_rid)));
    avelength_source_rid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_rid)),h.source_rid<>(typeof(h.source_rid))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_clean_clinic_name_pcnt := AVE(GROUP,IF(h.clean_clinic_name = (TYPEOF(h.clean_clinic_name))'',0,100));
    maxlength_clean_clinic_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_clinic_name)));
    avelength_clean_clinic_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_clinic_name)),h.clean_clinic_name<>(typeof(h.clean_clinic_name))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_st_pcnt := AVE(GROUP,IF(h.fips_st = (TYPEOF(h.fips_st))'',0,100));
    maxlength_fips_st := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_st)));
    avelength_fips_st := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_st)),h.fips_st<>(typeof(h.fips_st))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_did_pcnt *   5.00 / 100 + T.Populated_did_score_pcnt *   5.00 / 100 + T.Populated_bdid_pcnt *   5.00 / 100 + T.Populated_bdid_score_pcnt *   5.00 / 100 + T.Populated_best_dob_pcnt *   5.00 / 100 + T.Populated_best_ssn_pcnt *   5.00 / 100 + T.Populated_spi_pcnt *   5.00 / 100 + T.Populated_dea_pcnt *   5.00 / 100 + T.Populated_statelicensenumber_pcnt *   5.00 / 100 + T.Populated_specialtycodeprimary_pcnt *   5.00 / 100 + T.Populated_prefixname_pcnt *   5.00 / 100 + T.Populated_lastname_pcnt *   5.00 / 100 + T.Populated_firstname_pcnt *   5.00 / 100 + T.Populated_middlename_pcnt *   5.00 / 100 + T.Populated_suffixname_pcnt *   5.00 / 100 + T.Populated_clinicname_pcnt *   5.00 / 100 + T.Populated_addressline1_pcnt *   5.00 / 100 + T.Populated_addressline2_pcnt *   5.00 / 100 + T.Populated_city_pcnt *   5.00 / 100 + T.Populated_state_pcnt *   5.00 / 100 + T.Populated_zipcode_pcnt *   5.00 / 100 + T.Populated_phoneprimary_pcnt *   5.00 / 100 + T.Populated_fax_pcnt *   5.00 / 100 + T.Populated_email_pcnt *   5.00 / 100 + T.Populated_phonealt1_pcnt *   5.00 / 100 + T.Populated_phonealt1qualifier_pcnt *   5.00 / 100 + T.Populated_phonealt2_pcnt *   5.00 / 100 + T.Populated_phonealt2qualifier_pcnt *   5.00 / 100 + T.Populated_phonealt3_pcnt *   5.00 / 100 + T.Populated_phonealt3qualifier_pcnt *   5.00 / 100 + T.Populated_phonealt4_pcnt *   5.00 / 100 + T.Populated_phonealt4qualifier_pcnt *   5.00 / 100 + T.Populated_phonealt5_pcnt *   5.00 / 100 + T.Populated_phonealt5qualifier_pcnt *   5.00 / 100 + T.Populated_activestarttime_pcnt *   5.00 / 100 + T.Populated_activeendtime_pcnt *   5.00 / 100 + T.Populated_servicelevel_pcnt *   5.00 / 100 + T.Populated_partneraccount_pcnt *   5.00 / 100 + T.Populated_lastmodifieddate_pcnt *   5.00 / 100 + T.Populated_recordchange_pcnt *   5.00 / 100 + T.Populated_oldservicelevel_pcnt *   5.00 / 100 + T.Populated_textservicelevel_pcnt *   5.00 / 100 + T.Populated_textservicelevelchange_pcnt *   5.00 / 100 + T.Populated_version_pcnt *   5.00 / 100 + T.Populated_npi_pcnt *   5.00 / 100 + T.Populated_npilocation_pcnt *   5.00 / 100 + T.Populated_specialitytype1_pcnt *   5.00 / 100 + T.Populated_specialitytype2_pcnt *   5.00 / 100 + T.Populated_specialitytype3_pcnt *   5.00 / 100 + T.Populated_specialitytype4_pcnt *   5.00 / 100 + T.Populated_fileid_pcnt *   5.00 / 100 + T.Populated_medicarenumber_pcnt *   5.00 / 100 + T.Populated_medicaidnumber_pcnt *   5.00 / 100 + T.Populated_dentistlicensenumber_pcnt *   5.00 / 100 + T.Populated_upin_pcnt *   5.00 / 100 + T.Populated_pponumber_pcnt *   5.00 / 100 + T.Populated_socialsecurity_pcnt *   5.00 / 100 + T.Populated_priorauthorization_pcnt *   5.00 / 100 + T.Populated_mutuallydefined_pcnt *   5.00 / 100 + T.Populated_instorencpdpid_pcnt *   5.00 / 100 + T.Populated_spec_code_pcnt *   5.00 / 100 + T.Populated_spec_desc_pcnt *   5.00 / 100 + T.Populated_activity_code_pcnt *   5.00 / 100 + T.Populated_practice_type_code_pcnt *   5.00 / 100 + T.Populated_practice_type_desc_pcnt *   5.00 / 100 + T.Populated_taxonomy_pcnt *   5.00 / 100 + T.Populated_src_pcnt *   5.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   5.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   5.00 / 100 + T.Populated_dt_first_seen_pcnt *   5.00 / 100 + T.Populated_dt_last_seen_pcnt *   5.00 / 100 + T.Populated_record_type_pcnt *   5.00 / 100 + T.Populated_source_rid_pcnt *   5.00 / 100 + T.Populated_lnpid_pcnt *   5.00 / 100 + T.Populated_title_pcnt *   5.00 / 100 + T.Populated_fname_pcnt *   5.00 / 100 + T.Populated_mname_pcnt *   5.00 / 100 + T.Populated_lname_pcnt *   5.00 / 100 + T.Populated_name_suffix_pcnt *   5.00 / 100 + T.Populated_name_type_pcnt *   5.00 / 100 + T.Populated_nid_pcnt *   5.00 / 100 + T.Populated_clean_clinic_name_pcnt *   5.00 / 100 + T.Populated_prepped_addr1_pcnt *   5.00 / 100 + T.Populated_prepped_addr2_pcnt *   5.00 / 100 + T.Populated_prim_range_pcnt *   5.00 / 100 + T.Populated_predir_pcnt *   5.00 / 100 + T.Populated_prim_name_pcnt *   5.00 / 100 + T.Populated_addr_suffix_pcnt *   5.00 / 100 + T.Populated_postdir_pcnt *   5.00 / 100 + T.Populated_unit_desig_pcnt *   5.00 / 100 + T.Populated_sec_range_pcnt *   5.00 / 100 + T.Populated_p_city_name_pcnt *   5.00 / 100 + T.Populated_v_city_name_pcnt *   5.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *   5.00 / 100 + T.Populated_zip4_pcnt *   5.00 / 100 + T.Populated_cart_pcnt *   5.00 / 100 + T.Populated_cr_sort_sz_pcnt *   5.00 / 100 + T.Populated_lot_pcnt *   5.00 / 100 + T.Populated_lot_order_pcnt *   5.00 / 100 + T.Populated_dbpc_pcnt *   5.00 / 100 + T.Populated_chk_digit_pcnt *   5.00 / 100 + T.Populated_rec_type_pcnt *   5.00 / 100 + T.Populated_fips_st_pcnt *   5.00 / 100 + T.Populated_fips_county_pcnt *   5.00 / 100 + T.Populated_geo_lat_pcnt *   5.00 / 100 + T.Populated_geo_long_pcnt *   5.00 / 100 + T.Populated_msa_pcnt *   5.00 / 100 + T.Populated_geo_blk_pcnt *   5.00 / 100 + T.Populated_geo_match_pcnt *   5.00 / 100 + T.Populated_err_stat_pcnt *   5.00 / 100 + T.Populated_rawaid_pcnt *   5.00 / 100 + T.Populated_aceaid_pcnt *   5.00 / 100 + T.Populated_clean_phone_pcnt *   5.00 / 100 + T.Populated_dotid_pcnt *   5.00 / 100 + T.Populated_dotscore_pcnt *   5.00 / 100 + T.Populated_dotweight_pcnt *   5.00 / 100 + T.Populated_empid_pcnt *   5.00 / 100 + T.Populated_empscore_pcnt *   5.00 / 100 + T.Populated_empweight_pcnt *   5.00 / 100 + T.Populated_powid_pcnt *   5.00 / 100 + T.Populated_powscore_pcnt *   5.00 / 100 + T.Populated_powweight_pcnt *   5.00 / 100 + T.Populated_proxid_pcnt *   5.00 / 100 + T.Populated_proxscore_pcnt *   5.00 / 100 + T.Populated_proxweight_pcnt *   5.00 / 100 + T.Populated_seleid_pcnt *   5.00 / 100 + T.Populated_selescore_pcnt *   5.00 / 100 + T.Populated_seleweight_pcnt *   5.00 / 100 + T.Populated_orgid_pcnt *   5.00 / 100 + T.Populated_orgscore_pcnt *   5.00 / 100 + T.Populated_orgweight_pcnt *   5.00 / 100 + T.Populated_ultid_pcnt *   5.00 / 100 + T.Populated_ultscore_pcnt *   5.00 / 100 + T.Populated_ultweight_pcnt *   5.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'did','did_score','bdid','bdid_score','best_dob','best_ssn','spi','dea','statelicensenumber','specialtycodeprimary','prefixname','lastname','firstname','middlename','suffixname','clinicname','addressline1','addressline2','city','state','zipcode','phoneprimary','fax','email','phonealt1','phonealt1qualifier','phonealt2','phonealt2qualifier','phonealt3','phonealt3qualifier','phonealt4','phonealt4qualifier','phonealt5','phonealt5qualifier','activestarttime','activeendtime','servicelevel','partneraccount','lastmodifieddate','recordchange','oldservicelevel','textservicelevel','textservicelevelchange','version','npi','npilocation','specialitytype1','specialitytype2','specialitytype3','specialitytype4','fileid','medicarenumber','medicaidnumber','dentistlicensenumber','upin','pponumber','socialsecurity','priorauthorization','mutuallydefined','instorencpdpid','spec_code','spec_desc','activity_code','practice_type_code','practice_type_desc','taxonomy','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_best_dob_pcnt,le.populated_best_ssn_pcnt,le.populated_spi_pcnt,le.populated_dea_pcnt,le.populated_statelicensenumber_pcnt,le.populated_specialtycodeprimary_pcnt,le.populated_prefixname_pcnt,le.populated_lastname_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_suffixname_pcnt,le.populated_clinicname_pcnt,le.populated_addressline1_pcnt,le.populated_addressline2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_phoneprimary_pcnt,le.populated_fax_pcnt,le.populated_email_pcnt,le.populated_phonealt1_pcnt,le.populated_phonealt1qualifier_pcnt,le.populated_phonealt2_pcnt,le.populated_phonealt2qualifier_pcnt,le.populated_phonealt3_pcnt,le.populated_phonealt3qualifier_pcnt,le.populated_phonealt4_pcnt,le.populated_phonealt4qualifier_pcnt,le.populated_phonealt5_pcnt,le.populated_phonealt5qualifier_pcnt,le.populated_activestarttime_pcnt,le.populated_activeendtime_pcnt,le.populated_servicelevel_pcnt,le.populated_partneraccount_pcnt,le.populated_lastmodifieddate_pcnt,le.populated_recordchange_pcnt,le.populated_oldservicelevel_pcnt,le.populated_textservicelevel_pcnt,le.populated_textservicelevelchange_pcnt,le.populated_version_pcnt,le.populated_npi_pcnt,le.populated_npilocation_pcnt,le.populated_specialitytype1_pcnt,le.populated_specialitytype2_pcnt,le.populated_specialitytype3_pcnt,le.populated_specialitytype4_pcnt,le.populated_fileid_pcnt,le.populated_medicarenumber_pcnt,le.populated_medicaidnumber_pcnt,le.populated_dentistlicensenumber_pcnt,le.populated_upin_pcnt,le.populated_pponumber_pcnt,le.populated_socialsecurity_pcnt,le.populated_priorauthorization_pcnt,le.populated_mutuallydefined_pcnt,le.populated_instorencpdpid_pcnt,le.populated_spec_code_pcnt,le.populated_spec_desc_pcnt,le.populated_activity_code_pcnt,le.populated_practice_type_code_pcnt,le.populated_practice_type_desc_pcnt,le.populated_taxonomy_pcnt,le.populated_src_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_source_rid_pcnt,le.populated_lnpid_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_type_pcnt,le.populated_nid_pcnt,le.populated_clean_clinic_name_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prepped_addr2_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_clean_phone_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_best_dob,le.maxlength_best_ssn,le.maxlength_spi,le.maxlength_dea,le.maxlength_statelicensenumber,le.maxlength_specialtycodeprimary,le.maxlength_prefixname,le.maxlength_lastname,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_suffixname,le.maxlength_clinicname,le.maxlength_addressline1,le.maxlength_addressline2,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_phoneprimary,le.maxlength_fax,le.maxlength_email,le.maxlength_phonealt1,le.maxlength_phonealt1qualifier,le.maxlength_phonealt2,le.maxlength_phonealt2qualifier,le.maxlength_phonealt3,le.maxlength_phonealt3qualifier,le.maxlength_phonealt4,le.maxlength_phonealt4qualifier,le.maxlength_phonealt5,le.maxlength_phonealt5qualifier,le.maxlength_activestarttime,le.maxlength_activeendtime,le.maxlength_servicelevel,le.maxlength_partneraccount,le.maxlength_lastmodifieddate,le.maxlength_recordchange,le.maxlength_oldservicelevel,le.maxlength_textservicelevel,le.maxlength_textservicelevelchange,le.maxlength_version,le.maxlength_npi,le.maxlength_npilocation,le.maxlength_specialitytype1,le.maxlength_specialitytype2,le.maxlength_specialitytype3,le.maxlength_specialitytype4,le.maxlength_fileid,le.maxlength_medicarenumber,le.maxlength_medicaidnumber,le.maxlength_dentistlicensenumber,le.maxlength_upin,le.maxlength_pponumber,le.maxlength_socialsecurity,le.maxlength_priorauthorization,le.maxlength_mutuallydefined,le.maxlength_instorencpdpid,le.maxlength_spec_code,le.maxlength_spec_desc,le.maxlength_activity_code,le.maxlength_practice_type_code,le.maxlength_practice_type_desc,le.maxlength_taxonomy,le.maxlength_src,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_record_type,le.maxlength_source_rid,le.maxlength_lnpid,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_type,le.maxlength_nid,le.maxlength_clean_clinic_name,le.maxlength_prepped_addr1,le.maxlength_prepped_addr2,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_clean_phone,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_best_dob,le.avelength_best_ssn,le.avelength_spi,le.avelength_dea,le.avelength_statelicensenumber,le.avelength_specialtycodeprimary,le.avelength_prefixname,le.avelength_lastname,le.avelength_firstname,le.avelength_middlename,le.avelength_suffixname,le.avelength_clinicname,le.avelength_addressline1,le.avelength_addressline2,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_phoneprimary,le.avelength_fax,le.avelength_email,le.avelength_phonealt1,le.avelength_phonealt1qualifier,le.avelength_phonealt2,le.avelength_phonealt2qualifier,le.avelength_phonealt3,le.avelength_phonealt3qualifier,le.avelength_phonealt4,le.avelength_phonealt4qualifier,le.avelength_phonealt5,le.avelength_phonealt5qualifier,le.avelength_activestarttime,le.avelength_activeendtime,le.avelength_servicelevel,le.avelength_partneraccount,le.avelength_lastmodifieddate,le.avelength_recordchange,le.avelength_oldservicelevel,le.avelength_textservicelevel,le.avelength_textservicelevelchange,le.avelength_version,le.avelength_npi,le.avelength_npilocation,le.avelength_specialitytype1,le.avelength_specialitytype2,le.avelength_specialitytype3,le.avelength_specialitytype4,le.avelength_fileid,le.avelength_medicarenumber,le.avelength_medicaidnumber,le.avelength_dentistlicensenumber,le.avelength_upin,le.avelength_pponumber,le.avelength_socialsecurity,le.avelength_priorauthorization,le.avelength_mutuallydefined,le.avelength_instorencpdpid,le.avelength_spec_code,le.avelength_spec_desc,le.avelength_activity_code,le.avelength_practice_type_code,le.avelength_practice_type_desc,le.avelength_taxonomy,le.avelength_src,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_record_type,le.avelength_source_rid,le.avelength_lnpid,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_type,le.avelength_nid,le.avelength_clean_clinic_name,le.avelength_prepped_addr1,le.avelength_prepped_addr2,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_aceaid,le.avelength_clean_phone,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 135, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.spi),TRIM((SALT31.StrType)le.dea),TRIM((SALT31.StrType)le.statelicensenumber),TRIM((SALT31.StrType)le.specialtycodeprimary),TRIM((SALT31.StrType)le.prefixname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.middlename),TRIM((SALT31.StrType)le.suffixname),TRIM((SALT31.StrType)le.clinicname),TRIM((SALT31.StrType)le.addressline1),TRIM((SALT31.StrType)le.addressline2),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.zipcode),TRIM((SALT31.StrType)le.phoneprimary),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.phonealt1),TRIM((SALT31.StrType)le.phonealt1qualifier),TRIM((SALT31.StrType)le.phonealt2),TRIM((SALT31.StrType)le.phonealt2qualifier),TRIM((SALT31.StrType)le.phonealt3),TRIM((SALT31.StrType)le.phonealt3qualifier),TRIM((SALT31.StrType)le.phonealt4),TRIM((SALT31.StrType)le.phonealt4qualifier),TRIM((SALT31.StrType)le.phonealt5),TRIM((SALT31.StrType)le.phonealt5qualifier),TRIM((SALT31.StrType)le.activestarttime),TRIM((SALT31.StrType)le.activeendtime),TRIM((SALT31.StrType)le.servicelevel),TRIM((SALT31.StrType)le.partneraccount),TRIM((SALT31.StrType)le.lastmodifieddate),TRIM((SALT31.StrType)le.recordchange),TRIM((SALT31.StrType)le.oldservicelevel),TRIM((SALT31.StrType)le.textservicelevel),TRIM((SALT31.StrType)le.textservicelevelchange),TRIM((SALT31.StrType)le.version),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.npilocation),TRIM((SALT31.StrType)le.specialitytype1),TRIM((SALT31.StrType)le.specialitytype2),TRIM((SALT31.StrType)le.specialitytype3),TRIM((SALT31.StrType)le.specialitytype4),TRIM((SALT31.StrType)le.fileid),TRIM((SALT31.StrType)le.medicarenumber),TRIM((SALT31.StrType)le.medicaidnumber),TRIM((SALT31.StrType)le.dentistlicensenumber),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.pponumber),TRIM((SALT31.StrType)le.socialsecurity),TRIM((SALT31.StrType)le.priorauthorization),TRIM((SALT31.StrType)le.mutuallydefined),TRIM((SALT31.StrType)le.instorencpdpid),TRIM((SALT31.StrType)le.spec_code),TRIM((SALT31.StrType)le.spec_desc),TRIM((SALT31.StrType)le.activity_code),TRIM((SALT31.StrType)le.practice_type_code),TRIM((SALT31.StrType)le.practice_type_desc),TRIM((SALT31.StrType)le.taxonomy),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,135,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 135);
  SELF.FldNo2 := 1 + (C % 135);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.spi),TRIM((SALT31.StrType)le.dea),TRIM((SALT31.StrType)le.statelicensenumber),TRIM((SALT31.StrType)le.specialtycodeprimary),TRIM((SALT31.StrType)le.prefixname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.middlename),TRIM((SALT31.StrType)le.suffixname),TRIM((SALT31.StrType)le.clinicname),TRIM((SALT31.StrType)le.addressline1),TRIM((SALT31.StrType)le.addressline2),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.zipcode),TRIM((SALT31.StrType)le.phoneprimary),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.phonealt1),TRIM((SALT31.StrType)le.phonealt1qualifier),TRIM((SALT31.StrType)le.phonealt2),TRIM((SALT31.StrType)le.phonealt2qualifier),TRIM((SALT31.StrType)le.phonealt3),TRIM((SALT31.StrType)le.phonealt3qualifier),TRIM((SALT31.StrType)le.phonealt4),TRIM((SALT31.StrType)le.phonealt4qualifier),TRIM((SALT31.StrType)le.phonealt5),TRIM((SALT31.StrType)le.phonealt5qualifier),TRIM((SALT31.StrType)le.activestarttime),TRIM((SALT31.StrType)le.activeendtime),TRIM((SALT31.StrType)le.servicelevel),TRIM((SALT31.StrType)le.partneraccount),TRIM((SALT31.StrType)le.lastmodifieddate),TRIM((SALT31.StrType)le.recordchange),TRIM((SALT31.StrType)le.oldservicelevel),TRIM((SALT31.StrType)le.textservicelevel),TRIM((SALT31.StrType)le.textservicelevelchange),TRIM((SALT31.StrType)le.version),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.npilocation),TRIM((SALT31.StrType)le.specialitytype1),TRIM((SALT31.StrType)le.specialitytype2),TRIM((SALT31.StrType)le.specialitytype3),TRIM((SALT31.StrType)le.specialitytype4),TRIM((SALT31.StrType)le.fileid),TRIM((SALT31.StrType)le.medicarenumber),TRIM((SALT31.StrType)le.medicaidnumber),TRIM((SALT31.StrType)le.dentistlicensenumber),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.pponumber),TRIM((SALT31.StrType)le.socialsecurity),TRIM((SALT31.StrType)le.priorauthorization),TRIM((SALT31.StrType)le.mutuallydefined),TRIM((SALT31.StrType)le.instorencpdpid),TRIM((SALT31.StrType)le.spec_code),TRIM((SALT31.StrType)le.spec_desc),TRIM((SALT31.StrType)le.activity_code),TRIM((SALT31.StrType)le.practice_type_code),TRIM((SALT31.StrType)le.practice_type_desc),TRIM((SALT31.StrType)le.taxonomy),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.spi),TRIM((SALT31.StrType)le.dea),TRIM((SALT31.StrType)le.statelicensenumber),TRIM((SALT31.StrType)le.specialtycodeprimary),TRIM((SALT31.StrType)le.prefixname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.middlename),TRIM((SALT31.StrType)le.suffixname),TRIM((SALT31.StrType)le.clinicname),TRIM((SALT31.StrType)le.addressline1),TRIM((SALT31.StrType)le.addressline2),TRIM((SALT31.StrType)le.city),TRIM((SALT31.StrType)le.state),TRIM((SALT31.StrType)le.zipcode),TRIM((SALT31.StrType)le.phoneprimary),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.email),TRIM((SALT31.StrType)le.phonealt1),TRIM((SALT31.StrType)le.phonealt1qualifier),TRIM((SALT31.StrType)le.phonealt2),TRIM((SALT31.StrType)le.phonealt2qualifier),TRIM((SALT31.StrType)le.phonealt3),TRIM((SALT31.StrType)le.phonealt3qualifier),TRIM((SALT31.StrType)le.phonealt4),TRIM((SALT31.StrType)le.phonealt4qualifier),TRIM((SALT31.StrType)le.phonealt5),TRIM((SALT31.StrType)le.phonealt5qualifier),TRIM((SALT31.StrType)le.activestarttime),TRIM((SALT31.StrType)le.activeendtime),TRIM((SALT31.StrType)le.servicelevel),TRIM((SALT31.StrType)le.partneraccount),TRIM((SALT31.StrType)le.lastmodifieddate),TRIM((SALT31.StrType)le.recordchange),TRIM((SALT31.StrType)le.oldservicelevel),TRIM((SALT31.StrType)le.textservicelevel),TRIM((SALT31.StrType)le.textservicelevelchange),TRIM((SALT31.StrType)le.version),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.npilocation),TRIM((SALT31.StrType)le.specialitytype1),TRIM((SALT31.StrType)le.specialitytype2),TRIM((SALT31.StrType)le.specialitytype3),TRIM((SALT31.StrType)le.specialitytype4),TRIM((SALT31.StrType)le.fileid),TRIM((SALT31.StrType)le.medicarenumber),TRIM((SALT31.StrType)le.medicaidnumber),TRIM((SALT31.StrType)le.dentistlicensenumber),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.pponumber),TRIM((SALT31.StrType)le.socialsecurity),TRIM((SALT31.StrType)le.priorauthorization),TRIM((SALT31.StrType)le.mutuallydefined),TRIM((SALT31.StrType)le.instorencpdpid),TRIM((SALT31.StrType)le.spec_code),TRIM((SALT31.StrType)le.spec_desc),TRIM((SALT31.StrType)le.activity_code),TRIM((SALT31.StrType)le.practice_type_code),TRIM((SALT31.StrType)le.practice_type_desc),TRIM((SALT31.StrType)le.taxonomy),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),135*135,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'did'}
      ,{2,'did_score'}
      ,{3,'bdid'}
      ,{4,'bdid_score'}
      ,{5,'best_dob'}
      ,{6,'best_ssn'}
      ,{7,'spi'}
      ,{8,'dea'}
      ,{9,'statelicensenumber'}
      ,{10,'specialtycodeprimary'}
      ,{11,'prefixname'}
      ,{12,'lastname'}
      ,{13,'firstname'}
      ,{14,'middlename'}
      ,{15,'suffixname'}
      ,{16,'clinicname'}
      ,{17,'addressline1'}
      ,{18,'addressline2'}
      ,{19,'city'}
      ,{20,'state'}
      ,{21,'zipcode'}
      ,{22,'phoneprimary'}
      ,{23,'fax'}
      ,{24,'email'}
      ,{25,'phonealt1'}
      ,{26,'phonealt1qualifier'}
      ,{27,'phonealt2'}
      ,{28,'phonealt2qualifier'}
      ,{29,'phonealt3'}
      ,{30,'phonealt3qualifier'}
      ,{31,'phonealt4'}
      ,{32,'phonealt4qualifier'}
      ,{33,'phonealt5'}
      ,{34,'phonealt5qualifier'}
      ,{35,'activestarttime'}
      ,{36,'activeendtime'}
      ,{37,'servicelevel'}
      ,{38,'partneraccount'}
      ,{39,'lastmodifieddate'}
      ,{40,'recordchange'}
      ,{41,'oldservicelevel'}
      ,{42,'textservicelevel'}
      ,{43,'textservicelevelchange'}
      ,{44,'version'}
      ,{45,'npi'}
      ,{46,'npilocation'}
      ,{47,'specialitytype1'}
      ,{48,'specialitytype2'}
      ,{49,'specialitytype3'}
      ,{50,'specialitytype4'}
      ,{51,'fileid'}
      ,{52,'medicarenumber'}
      ,{53,'medicaidnumber'}
      ,{54,'dentistlicensenumber'}
      ,{55,'upin'}
      ,{56,'pponumber'}
      ,{57,'socialsecurity'}
      ,{58,'priorauthorization'}
      ,{59,'mutuallydefined'}
      ,{60,'instorencpdpid'}
      ,{61,'spec_code'}
      ,{62,'spec_desc'}
      ,{63,'activity_code'}
      ,{64,'practice_type_code'}
      ,{65,'practice_type_desc'}
      ,{66,'taxonomy'}
      ,{67,'src'}
      ,{68,'dt_vendor_first_reported'}
      ,{69,'dt_vendor_last_reported'}
      ,{70,'dt_first_seen'}
      ,{71,'dt_last_seen'}
      ,{72,'record_type'}
      ,{73,'source_rid'}
      ,{74,'lnpid'}
      ,{75,'title'}
      ,{76,'fname'}
      ,{77,'mname'}
      ,{78,'lname'}
      ,{79,'name_suffix'}
      ,{80,'name_type'}
      ,{81,'nid'}
      ,{82,'clean_clinic_name'}
      ,{83,'prepped_addr1'}
      ,{84,'prepped_addr2'}
      ,{85,'prim_range'}
      ,{86,'predir'}
      ,{87,'prim_name'}
      ,{88,'addr_suffix'}
      ,{89,'postdir'}
      ,{90,'unit_desig'}
      ,{91,'sec_range'}
      ,{92,'p_city_name'}
      ,{93,'v_city_name'}
      ,{94,'st'}
      ,{95,'zip'}
      ,{96,'zip4'}
      ,{97,'cart'}
      ,{98,'cr_sort_sz'}
      ,{99,'lot'}
      ,{100,'lot_order'}
      ,{101,'dbpc'}
      ,{102,'chk_digit'}
      ,{103,'rec_type'}
      ,{104,'fips_st'}
      ,{105,'fips_county'}
      ,{106,'geo_lat'}
      ,{107,'geo_long'}
      ,{108,'msa'}
      ,{109,'geo_blk'}
      ,{110,'geo_match'}
      ,{111,'err_stat'}
      ,{112,'rawaid'}
      ,{113,'aceaid'}
      ,{114,'clean_phone'}
      ,{115,'dotid'}
      ,{116,'dotscore'}
      ,{117,'dotweight'}
      ,{118,'empid'}
      ,{119,'empscore'}
      ,{120,'empweight'}
      ,{121,'powid'}
      ,{122,'powscore'}
      ,{123,'powweight'}
      ,{124,'proxid'}
      ,{125,'proxscore'}
      ,{126,'proxweight'}
      ,{127,'seleid'}
      ,{128,'selescore'}
      ,{129,'seleweight'}
      ,{130,'orgid'}
      ,{131,'orgscore'}
      ,{132,'orgweight'}
      ,{133,'ultid'}
      ,{134,'ultscore'}
      ,{135,'ultweight'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    SureScripts_Fields.InValid_did((SALT31.StrType)le.did),
    SureScripts_Fields.InValid_did_score((SALT31.StrType)le.did_score),
    SureScripts_Fields.InValid_bdid((SALT31.StrType)le.bdid),
    SureScripts_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score),
    SureScripts_Fields.InValid_best_dob((SALT31.StrType)le.best_dob),
    SureScripts_Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn),
    SureScripts_Fields.InValid_spi((SALT31.StrType)le.spi),
    SureScripts_Fields.InValid_dea((SALT31.StrType)le.dea),
    SureScripts_Fields.InValid_statelicensenumber((SALT31.StrType)le.statelicensenumber),
    SureScripts_Fields.InValid_specialtycodeprimary((SALT31.StrType)le.specialtycodeprimary),
    SureScripts_Fields.InValid_prefixname((SALT31.StrType)le.prefixname),
    SureScripts_Fields.InValid_lastname((SALT31.StrType)le.lastname),
    SureScripts_Fields.InValid_firstname((SALT31.StrType)le.firstname),
    SureScripts_Fields.InValid_middlename((SALT31.StrType)le.middlename),
    SureScripts_Fields.InValid_suffixname((SALT31.StrType)le.suffixname),
    SureScripts_Fields.InValid_clinicname((SALT31.StrType)le.clinicname),
    SureScripts_Fields.InValid_addressline1((SALT31.StrType)le.addressline1),
    SureScripts_Fields.InValid_addressline2((SALT31.StrType)le.addressline2),
    SureScripts_Fields.InValid_city((SALT31.StrType)le.city),
    SureScripts_Fields.InValid_state((SALT31.StrType)le.state),
    SureScripts_Fields.InValid_zipcode((SALT31.StrType)le.zipcode),
    SureScripts_Fields.InValid_phoneprimary((SALT31.StrType)le.phoneprimary),
    SureScripts_Fields.InValid_fax((SALT31.StrType)le.fax),
    SureScripts_Fields.InValid_email((SALT31.StrType)le.email),
    SureScripts_Fields.InValid_phonealt1((SALT31.StrType)le.phonealt1),
    SureScripts_Fields.InValid_phonealt1qualifier((SALT31.StrType)le.phonealt1qualifier),
    SureScripts_Fields.InValid_phonealt2((SALT31.StrType)le.phonealt2),
    SureScripts_Fields.InValid_phonealt2qualifier((SALT31.StrType)le.phonealt2qualifier),
    SureScripts_Fields.InValid_phonealt3((SALT31.StrType)le.phonealt3),
    SureScripts_Fields.InValid_phonealt3qualifier((SALT31.StrType)le.phonealt3qualifier),
    SureScripts_Fields.InValid_phonealt4((SALT31.StrType)le.phonealt4),
    SureScripts_Fields.InValid_phonealt4qualifier((SALT31.StrType)le.phonealt4qualifier),
    SureScripts_Fields.InValid_phonealt5((SALT31.StrType)le.phonealt5),
    SureScripts_Fields.InValid_phonealt5qualifier((SALT31.StrType)le.phonealt5qualifier),
    SureScripts_Fields.InValid_activestarttime((SALT31.StrType)le.activestarttime),
    SureScripts_Fields.InValid_activeendtime((SALT31.StrType)le.activeendtime),
    SureScripts_Fields.InValid_servicelevel((SALT31.StrType)le.servicelevel),
    SureScripts_Fields.InValid_partneraccount((SALT31.StrType)le.partneraccount),
    SureScripts_Fields.InValid_lastmodifieddate((SALT31.StrType)le.lastmodifieddate),
    SureScripts_Fields.InValid_recordchange((SALT31.StrType)le.recordchange),
    SureScripts_Fields.InValid_oldservicelevel((SALT31.StrType)le.oldservicelevel),
    SureScripts_Fields.InValid_textservicelevel((SALT31.StrType)le.textservicelevel),
    SureScripts_Fields.InValid_textservicelevelchange((SALT31.StrType)le.textservicelevelchange),
    SureScripts_Fields.InValid_version((SALT31.StrType)le.version),
    SureScripts_Fields.InValid_npi((SALT31.StrType)le.npi),
    SureScripts_Fields.InValid_npilocation((SALT31.StrType)le.npilocation),
    SureScripts_Fields.InValid_specialitytype1((SALT31.StrType)le.specialitytype1),
    SureScripts_Fields.InValid_specialitytype2((SALT31.StrType)le.specialitytype2),
    SureScripts_Fields.InValid_specialitytype3((SALT31.StrType)le.specialitytype3),
    SureScripts_Fields.InValid_specialitytype4((SALT31.StrType)le.specialitytype4),
    SureScripts_Fields.InValid_fileid((SALT31.StrType)le.fileid),
    SureScripts_Fields.InValid_medicarenumber((SALT31.StrType)le.medicarenumber),
    SureScripts_Fields.InValid_medicaidnumber((SALT31.StrType)le.medicaidnumber),
    SureScripts_Fields.InValid_dentistlicensenumber((SALT31.StrType)le.dentistlicensenumber),
    SureScripts_Fields.InValid_upin((SALT31.StrType)le.upin),
    SureScripts_Fields.InValid_pponumber((SALT31.StrType)le.pponumber),
    SureScripts_Fields.InValid_socialsecurity((SALT31.StrType)le.socialsecurity),
    SureScripts_Fields.InValid_priorauthorization((SALT31.StrType)le.priorauthorization),
    SureScripts_Fields.InValid_mutuallydefined((SALT31.StrType)le.mutuallydefined),
    SureScripts_Fields.InValid_instorencpdpid((SALT31.StrType)le.instorencpdpid),
    SureScripts_Fields.InValid_spec_code((SALT31.StrType)le.spec_code),
    SureScripts_Fields.InValid_spec_desc((SALT31.StrType)le.spec_desc),
    SureScripts_Fields.InValid_activity_code((SALT31.StrType)le.activity_code),
    SureScripts_Fields.InValid_practice_type_code((SALT31.StrType)le.practice_type_code),
    SureScripts_Fields.InValid_practice_type_desc((SALT31.StrType)le.practice_type_desc),
    SureScripts_Fields.InValid_taxonomy((SALT31.StrType)le.taxonomy),
    SureScripts_Fields.InValid_src((SALT31.StrType)le.src),
    SureScripts_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported),
    SureScripts_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported),
    SureScripts_Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen),
    SureScripts_Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen),
    SureScripts_Fields.InValid_record_type((SALT31.StrType)le.record_type),
    SureScripts_Fields.InValid_source_rid((SALT31.StrType)le.source_rid),
    SureScripts_Fields.InValid_lnpid((SALT31.StrType)le.lnpid),
    SureScripts_Fields.InValid_title((SALT31.StrType)le.title),
    SureScripts_Fields.InValid_fname((SALT31.StrType)le.fname),
    SureScripts_Fields.InValid_mname((SALT31.StrType)le.mname),
    SureScripts_Fields.InValid_lname((SALT31.StrType)le.lname),
    SureScripts_Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix),
    SureScripts_Fields.InValid_name_type((SALT31.StrType)le.name_type),
    SureScripts_Fields.InValid_nid((SALT31.StrType)le.nid),
    SureScripts_Fields.InValid_clean_clinic_name((SALT31.StrType)le.clean_clinic_name),
    SureScripts_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1),
    SureScripts_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2),
    SureScripts_Fields.InValid_prim_range((SALT31.StrType)le.prim_range),
    SureScripts_Fields.InValid_predir((SALT31.StrType)le.predir),
    SureScripts_Fields.InValid_prim_name((SALT31.StrType)le.prim_name),
    SureScripts_Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix),
    SureScripts_Fields.InValid_postdir((SALT31.StrType)le.postdir),
    SureScripts_Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig),
    SureScripts_Fields.InValid_sec_range((SALT31.StrType)le.sec_range),
    SureScripts_Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name),
    SureScripts_Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name),
    SureScripts_Fields.InValid_st((SALT31.StrType)le.st),
    SureScripts_Fields.InValid_zip((SALT31.StrType)le.zip),
    SureScripts_Fields.InValid_zip4((SALT31.StrType)le.zip4),
    SureScripts_Fields.InValid_cart((SALT31.StrType)le.cart),
    SureScripts_Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz),
    SureScripts_Fields.InValid_lot((SALT31.StrType)le.lot),
    SureScripts_Fields.InValid_lot_order((SALT31.StrType)le.lot_order),
    SureScripts_Fields.InValid_dbpc((SALT31.StrType)le.dbpc),
    SureScripts_Fields.InValid_chk_digit((SALT31.StrType)le.chk_digit),
    SureScripts_Fields.InValid_rec_type((SALT31.StrType)le.rec_type),
    SureScripts_Fields.InValid_fips_st((SALT31.StrType)le.fips_st),
    SureScripts_Fields.InValid_fips_county((SALT31.StrType)le.fips_county),
    SureScripts_Fields.InValid_geo_lat((SALT31.StrType)le.geo_lat),
    SureScripts_Fields.InValid_geo_long((SALT31.StrType)le.geo_long),
    SureScripts_Fields.InValid_msa((SALT31.StrType)le.msa),
    SureScripts_Fields.InValid_geo_blk((SALT31.StrType)le.geo_blk),
    SureScripts_Fields.InValid_geo_match((SALT31.StrType)le.geo_match),
    SureScripts_Fields.InValid_err_stat((SALT31.StrType)le.err_stat),
    SureScripts_Fields.InValid_rawaid((SALT31.StrType)le.rawaid),
    SureScripts_Fields.InValid_aceaid((SALT31.StrType)le.aceaid),
    SureScripts_Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone),
    SureScripts_Fields.InValid_dotid((SALT31.StrType)le.dotid),
    SureScripts_Fields.InValid_dotscore((SALT31.StrType)le.dotscore),
    SureScripts_Fields.InValid_dotweight((SALT31.StrType)le.dotweight),
    SureScripts_Fields.InValid_empid((SALT31.StrType)le.empid),
    SureScripts_Fields.InValid_empscore((SALT31.StrType)le.empscore),
    SureScripts_Fields.InValid_empweight((SALT31.StrType)le.empweight),
    SureScripts_Fields.InValid_powid((SALT31.StrType)le.powid),
    SureScripts_Fields.InValid_powscore((SALT31.StrType)le.powscore),
    SureScripts_Fields.InValid_powweight((SALT31.StrType)le.powweight),
    SureScripts_Fields.InValid_proxid((SALT31.StrType)le.proxid),
    SureScripts_Fields.InValid_proxscore((SALT31.StrType)le.proxscore),
    SureScripts_Fields.InValid_proxweight((SALT31.StrType)le.proxweight),
    SureScripts_Fields.InValid_seleid((SALT31.StrType)le.seleid),
    SureScripts_Fields.InValid_selescore((SALT31.StrType)le.selescore),
    SureScripts_Fields.InValid_seleweight((SALT31.StrType)le.seleweight),
    SureScripts_Fields.InValid_orgid((SALT31.StrType)le.orgid),
    SureScripts_Fields.InValid_orgscore((SALT31.StrType)le.orgscore),
    SureScripts_Fields.InValid_orgweight((SALT31.StrType)le.orgweight),
    SureScripts_Fields.InValid_ultid((SALT31.StrType)le.ultid),
    SureScripts_Fields.InValid_ultscore((SALT31.StrType)le.ultscore),
    SureScripts_Fields.InValid_ultweight((SALT31.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,135,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := SureScripts_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'did','did_score','bdid','bdid_score','best_dob','best_ssn','spi','dea','statelicensenumber','specialtycodeprimary','prefixname','lastname','firstname','middlename','suffixname','clinicname','addressline1','addressline2','city','state','zipcode','phoneprimary','fax','email','phonealt1','phonealt1qualifier','phonealt2','phonealt2qualifier','phonealt3','phonealt3qualifier','phonealt4','phonealt4qualifier','phonealt5','phonealt5qualifier','activestarttime','activeendtime','servicelevel','partneraccount','lastmodifieddate','recordchange','oldservicelevel','textservicelevel','textservicelevelchange','version','npi','npilocation','specialitytype1','specialitytype2','specialitytype3','specialitytype4','fileid','medicarenumber','medicaidnumber','dentistlicensenumber','upin','pponumber','socialsecurity','priorauthorization','mutuallydefined','instorencpdpid','spec_code','spec_desc','activity_code','practice_type_code','practice_type_desc','taxonomy','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,SureScripts_Fields.InValidMessage_did(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_best_dob(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_spi(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dea(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_statelicensenumber(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_specialtycodeprimary(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_prefixname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_middlename(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_suffixname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_clinicname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_addressline1(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_addressline2(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_city(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_state(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phoneprimary(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_fax(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_email(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt1(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt1qualifier(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt2(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt2qualifier(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt3(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt3qualifier(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt4(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt4qualifier(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt5(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_phonealt5qualifier(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_activestarttime(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_activeendtime(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_servicelevel(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_partneraccount(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_lastmodifieddate(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_recordchange(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_oldservicelevel(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_textservicelevel(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_textservicelevelchange(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_version(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_npi(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_npilocation(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_specialitytype1(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_specialitytype2(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_specialitytype3(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_specialitytype4(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_fileid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_medicarenumber(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_medicaidnumber(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dentistlicensenumber(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_upin(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_pponumber(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_socialsecurity(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_priorauthorization(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_mutuallydefined(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_instorencpdpid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_spec_code(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_spec_desc(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_activity_code(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_practice_type_code(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_practice_type_desc(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_taxonomy(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_src(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_source_rid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_title(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_fname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_mname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_lname(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_name_type(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_nid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_clean_clinic_name(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_predir(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_st(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_zip(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_cart(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_lot(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_fips_st(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_msa(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_empid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_powid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),SureScripts_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
