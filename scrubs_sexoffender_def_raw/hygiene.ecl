IMPORT ut,SALT33;
EXPORT hygiene(dataset(layout_sexoffender_def_raw) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_recordid_pcnt := AVE(GROUP,IF(h.recordid = (TYPEOF(h.recordid))'',0,100));
    maxlength_recordid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordid)));
    avelength_recordid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordid)),h.recordid<>(typeof(h.recordid))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_sourcetype_pcnt := AVE(GROUP,IF(h.sourcetype = (TYPEOF(h.sourcetype))'',0,100));
    maxlength_sourcetype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcetype)));
    avelength_sourcetype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcetype)),h.sourcetype<>(typeof(h.sourcetype))'');
    populated_statecode_pcnt := AVE(GROUP,IF(h.statecode = (TYPEOF(h.statecode))'',0,100));
    maxlength_statecode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.statecode)));
    avelength_statecode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.statecode)),h.statecode<>(typeof(h.statecode))'');
    populated_recordtype_pcnt := AVE(GROUP,IF(h.recordtype = (TYPEOF(h.recordtype))'',0,100));
    maxlength_recordtype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordtype)));
    avelength_recordtype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordtype)),h.recordtype<>(typeof(h.recordtype))'');
    populated_recorduploaddate_pcnt := AVE(GROUP,IF(h.recorduploaddate = (TYPEOF(h.recorduploaddate))'',0,100));
    maxlength_recorduploaddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recorduploaddate)));
    avelength_recorduploaddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recorduploaddate)),h.recorduploaddate<>(typeof(h.recorduploaddate))'');
    populated_docnumber_pcnt := AVE(GROUP,IF(h.docnumber = (TYPEOF(h.docnumber))'',0,100));
    maxlength_docnumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.docnumber)));
    avelength_docnumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.docnumber)),h.docnumber<>(typeof(h.docnumber))'');
    populated_fbinumber_pcnt := AVE(GROUP,IF(h.fbinumber = (TYPEOF(h.fbinumber))'',0,100));
    maxlength_fbinumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fbinumber)));
    avelength_fbinumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fbinumber)),h.fbinumber<>(typeof(h.fbinumber))'');
    populated_stateidnumber_pcnt := AVE(GROUP,IF(h.stateidnumber = (TYPEOF(h.stateidnumber))'',0,100));
    maxlength_stateidnumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.stateidnumber)));
    avelength_stateidnumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.stateidnumber)),h.stateidnumber<>(typeof(h.stateidnumber))'');
    populated_inmatenumber_pcnt := AVE(GROUP,IF(h.inmatenumber = (TYPEOF(h.inmatenumber))'',0,100));
    maxlength_inmatenumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.inmatenumber)));
    avelength_inmatenumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.inmatenumber)),h.inmatenumber<>(typeof(h.inmatenumber))'');
    populated_aliennumber_pcnt := AVE(GROUP,IF(h.aliennumber = (TYPEOF(h.aliennumber))'',0,100));
    maxlength_aliennumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.aliennumber)));
    avelength_aliennumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.aliennumber)),h.aliennumber<>(typeof(h.aliennumber))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_defendantstatus_pcnt := AVE(GROUP,IF(h.defendantstatus = (TYPEOF(h.defendantstatus))'',0,100));
    maxlength_defendantstatus := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.defendantstatus)));
    avelength_defendantstatus := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.defendantstatus)),h.defendantstatus<>(typeof(h.defendantstatus))'');
    populated_defendantadditionalinfo_pcnt := AVE(GROUP,IF(h.defendantadditionalinfo = (TYPEOF(h.defendantadditionalinfo))'',0,100));
    maxlength_defendantadditionalinfo := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.defendantadditionalinfo)));
    avelength_defendantadditionalinfo := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.defendantadditionalinfo)),h.defendantadditionalinfo<>(typeof(h.defendantadditionalinfo))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_birthcity_pcnt := AVE(GROUP,IF(h.birthcity = (TYPEOF(h.birthcity))'',0,100));
    maxlength_birthcity := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.birthcity)));
    avelength_birthcity := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.birthcity)),h.birthcity<>(typeof(h.birthcity))'');
    populated_birthplace_pcnt := AVE(GROUP,IF(h.birthplace = (TYPEOF(h.birthplace))'',0,100));
    maxlength_birthplace := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.birthplace)));
    avelength_birthplace := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.birthplace)),h.birthplace<>(typeof(h.birthplace))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_haircolor_pcnt := AVE(GROUP,IF(h.haircolor = (TYPEOF(h.haircolor))'',0,100));
    maxlength_haircolor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.haircolor)));
    avelength_haircolor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.haircolor)),h.haircolor<>(typeof(h.haircolor))'');
    populated_eyecolor_pcnt := AVE(GROUP,IF(h.eyecolor = (TYPEOF(h.eyecolor))'',0,100));
    maxlength_eyecolor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.eyecolor)));
    avelength_eyecolor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.eyecolor)),h.eyecolor<>(typeof(h.eyecolor))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_ethnicity_pcnt := AVE(GROUP,IF(h.ethnicity = (TYPEOF(h.ethnicity))'',0,100));
    maxlength_ethnicity := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ethnicity)));
    avelength_ethnicity := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ethnicity)),h.ethnicity<>(typeof(h.ethnicity))'');
    populated_skincolor_pcnt := AVE(GROUP,IF(h.skincolor = (TYPEOF(h.skincolor))'',0,100));
    maxlength_skincolor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.skincolor)));
    avelength_skincolor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.skincolor)),h.skincolor<>(typeof(h.skincolor))'');
    populated_bodymarks_pcnt := AVE(GROUP,IF(h.bodymarks = (TYPEOF(h.bodymarks))'',0,100));
    maxlength_bodymarks := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.bodymarks)));
    avelength_bodymarks := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.bodymarks)),h.bodymarks<>(typeof(h.bodymarks))'');
    populated_physicalbuild_pcnt := AVE(GROUP,IF(h.physicalbuild = (TYPEOF(h.physicalbuild))'',0,100));
    maxlength_physicalbuild := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.physicalbuild)));
    avelength_physicalbuild := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.physicalbuild)),h.physicalbuild<>(typeof(h.physicalbuild))'');
    populated_photoname_pcnt := AVE(GROUP,IF(h.photoname = (TYPEOF(h.photoname))'',0,100));
    maxlength_photoname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.photoname)));
    avelength_photoname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.photoname)),h.photoname<>(typeof(h.photoname))'');
    populated_dlnumber_pcnt := AVE(GROUP,IF(h.dlnumber = (TYPEOF(h.dlnumber))'',0,100));
    maxlength_dlnumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dlnumber)));
    avelength_dlnumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dlnumber)),h.dlnumber<>(typeof(h.dlnumber))'');
    populated_dlstate_pcnt := AVE(GROUP,IF(h.dlstate = (TYPEOF(h.dlstate))'',0,100));
    maxlength_dlstate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dlstate)));
    avelength_dlstate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dlstate)),h.dlstate<>(typeof(h.dlstate))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phonetype_pcnt := AVE(GROUP,IF(h.phonetype = (TYPEOF(h.phonetype))'',0,100));
    maxlength_phonetype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phonetype)));
    avelength_phonetype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phonetype)),h.phonetype<>(typeof(h.phonetype))'');
    populated_uscitizenflag_pcnt := AVE(GROUP,IF(h.uscitizenflag = (TYPEOF(h.uscitizenflag))'',0,100));
    maxlength_uscitizenflag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.uscitizenflag)));
    avelength_uscitizenflag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.uscitizenflag)),h.uscitizenflag<>(typeof(h.uscitizenflag))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_unit_pcnt := AVE(GROUP,IF(h.unit = (TYPEOF(h.unit))'',0,100));
    maxlength_unit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit)));
    avelength_unit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit)),h.unit<>(typeof(h.unit))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_institutionname_pcnt := AVE(GROUP,IF(h.institutionname = (TYPEOF(h.institutionname))'',0,100));
    maxlength_institutionname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionname)));
    avelength_institutionname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionname)),h.institutionname<>(typeof(h.institutionname))'');
    populated_institutiondetails_pcnt := AVE(GROUP,IF(h.institutiondetails = (TYPEOF(h.institutiondetails))'',0,100));
    maxlength_institutiondetails := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutiondetails)));
    avelength_institutiondetails := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutiondetails)),h.institutiondetails<>(typeof(h.institutiondetails))'');
    populated_institutionreceiptdate_pcnt := AVE(GROUP,IF(h.institutionreceiptdate = (TYPEOF(h.institutionreceiptdate))'',0,100));
    maxlength_institutionreceiptdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionreceiptdate)));
    avelength_institutionreceiptdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.institutionreceiptdate)),h.institutionreceiptdate<>(typeof(h.institutionreceiptdate))'');
    populated_releasetolocation_pcnt := AVE(GROUP,IF(h.releasetolocation = (TYPEOF(h.releasetolocation))'',0,100));
    maxlength_releasetolocation := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetolocation)));
    avelength_releasetolocation := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetolocation)),h.releasetolocation<>(typeof(h.releasetolocation))'');
    populated_releasetodetails_pcnt := AVE(GROUP,IF(h.releasetodetails = (TYPEOF(h.releasetodetails))'',0,100));
    maxlength_releasetodetails := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetodetails)));
    avelength_releasetodetails := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.releasetodetails)),h.releasetodetails<>(typeof(h.releasetodetails))'');
    populated_deceasedflag_pcnt := AVE(GROUP,IF(h.deceasedflag = (TYPEOF(h.deceasedflag))'',0,100));
    maxlength_deceasedflag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceasedflag)));
    avelength_deceasedflag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceasedflag)),h.deceasedflag<>(typeof(h.deceasedflag))'');
    populated_deceaseddate_pcnt := AVE(GROUP,IF(h.deceaseddate = (TYPEOF(h.deceaseddate))'',0,100));
    maxlength_deceaseddate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceaseddate)));
    avelength_deceaseddate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deceaseddate)),h.deceaseddate<>(typeof(h.deceaseddate))'');
    populated_healthflag_pcnt := AVE(GROUP,IF(h.healthflag = (TYPEOF(h.healthflag))'',0,100));
    maxlength_healthflag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthflag)));
    avelength_healthflag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthflag)),h.healthflag<>(typeof(h.healthflag))'');
    populated_healthdesc_pcnt := AVE(GROUP,IF(h.healthdesc = (TYPEOF(h.healthdesc))'',0,100));
    maxlength_healthdesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthdesc)));
    avelength_healthdesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.healthdesc)),h.healthdesc<>(typeof(h.healthdesc))'');
    populated_bloodtype_pcnt := AVE(GROUP,IF(h.bloodtype = (TYPEOF(h.bloodtype))'',0,100));
    maxlength_bloodtype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.bloodtype)));
    avelength_bloodtype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.bloodtype)),h.bloodtype<>(typeof(h.bloodtype))'');
    populated_sexoffenderregistrydate_pcnt := AVE(GROUP,IF(h.sexoffenderregistrydate = (TYPEOF(h.sexoffenderregistrydate))'',0,100));
    maxlength_sexoffenderregistrydate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrydate)));
    avelength_sexoffenderregistrydate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrydate)),h.sexoffenderregistrydate<>(typeof(h.sexoffenderregistrydate))'');
    populated_sexoffenderregexpirationdate_pcnt := AVE(GROUP,IF(h.sexoffenderregexpirationdate = (TYPEOF(h.sexoffenderregexpirationdate))'',0,100));
    maxlength_sexoffenderregexpirationdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregexpirationdate)));
    avelength_sexoffenderregexpirationdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregexpirationdate)),h.sexoffenderregexpirationdate<>(typeof(h.sexoffenderregexpirationdate))'');
    populated_sexoffenderregistrynumber_pcnt := AVE(GROUP,IF(h.sexoffenderregistrynumber = (TYPEOF(h.sexoffenderregistrynumber))'',0,100));
    maxlength_sexoffenderregistrynumber := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrynumber)));
    avelength_sexoffenderregistrynumber := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sexoffenderregistrynumber)),h.sexoffenderregistrynumber<>(typeof(h.sexoffenderregistrynumber))'');
    populated_sourceid_pcnt := AVE(GROUP,IF(h.sourceid = (TYPEOF(h.sourceid))'',0,100));
    maxlength_sourceid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid)));
    avelength_sourceid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourceid)),h.sourceid<>(typeof(h.sourceid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourcetype_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_recordtype_pcnt *   0.00 / 100 + T.Populated_recorduploaddate_pcnt *   0.00 / 100 + T.Populated_docnumber_pcnt *   0.00 / 100 + T.Populated_fbinumber_pcnt *   0.00 / 100 + T.Populated_stateidnumber_pcnt *   0.00 / 100 + T.Populated_inmatenumber_pcnt *   0.00 / 100 + T.Populated_aliennumber_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_defendantstatus_pcnt *   0.00 / 100 + T.Populated_defendantadditionalinfo_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_birthcity_pcnt *   0.00 / 100 + T.Populated_birthplace_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_haircolor_pcnt *   0.00 / 100 + T.Populated_eyecolor_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_ethnicity_pcnt *   0.00 / 100 + T.Populated_skincolor_pcnt *   0.00 / 100 + T.Populated_bodymarks_pcnt *   0.00 / 100 + T.Populated_physicalbuild_pcnt *   0.00 / 100 + T.Populated_photoname_pcnt *   0.00 / 100 + T.Populated_dlnumber_pcnt *   0.00 / 100 + T.Populated_dlstate_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phonetype_pcnt *   0.00 / 100 + T.Populated_uscitizenflag_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_unit_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_institutionname_pcnt *   0.00 / 100 + T.Populated_institutiondetails_pcnt *   0.00 / 100 + T.Populated_institutionreceiptdate_pcnt *   0.00 / 100 + T.Populated_releasetolocation_pcnt *   0.00 / 100 + T.Populated_releasetodetails_pcnt *   0.00 / 100 + T.Populated_deceasedflag_pcnt *   0.00 / 100 + T.Populated_deceaseddate_pcnt *   0.00 / 100 + T.Populated_healthflag_pcnt *   0.00 / 100 + T.Populated_healthdesc_pcnt *   0.00 / 100 + T.Populated_bloodtype_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrydate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregexpirationdate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrynumber_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
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
  SELF.FieldName := CHOOSE(C,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_sourcename_pcnt,le.populated_sourcetype_pcnt,le.populated_statecode_pcnt,le.populated_recordtype_pcnt,le.populated_recorduploaddate_pcnt,le.populated_docnumber_pcnt,le.populated_fbinumber_pcnt,le.populated_stateidnumber_pcnt,le.populated_inmatenumber_pcnt,le.populated_aliennumber_pcnt,le.populated_orig_ssn_pcnt,le.populated_nametype_pcnt,le.populated_name_pcnt,le.populated_lastname_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_suffix_pcnt,le.populated_defendantstatus_pcnt,le.populated_defendantadditionalinfo_pcnt,le.populated_dob_pcnt,le.populated_birthcity_pcnt,le.populated_birthplace_pcnt,le.populated_age_pcnt,le.populated_gender_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_haircolor_pcnt,le.populated_eyecolor_pcnt,le.populated_race_pcnt,le.populated_ethnicity_pcnt,le.populated_skincolor_pcnt,le.populated_bodymarks_pcnt,le.populated_physicalbuild_pcnt,le.populated_photoname_pcnt,le.populated_dlnumber_pcnt,le.populated_dlstate_pcnt,le.populated_phone_pcnt,le.populated_phonetype_pcnt,le.populated_uscitizenflag_pcnt,le.populated_addresstype_pcnt,le.populated_street_pcnt,le.populated_unit_pcnt,le.populated_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_county_pcnt,le.populated_institutionname_pcnt,le.populated_institutiondetails_pcnt,le.populated_institutionreceiptdate_pcnt,le.populated_releasetolocation_pcnt,le.populated_releasetodetails_pcnt,le.populated_deceasedflag_pcnt,le.populated_deceaseddate_pcnt,le.populated_healthflag_pcnt,le.populated_healthdesc_pcnt,le.populated_bloodtype_pcnt,le.populated_sexoffenderregistrydate_pcnt,le.populated_sexoffenderregexpirationdate_pcnt,le.populated_sexoffenderregistrynumber_pcnt,le.populated_sourceid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_sourcename,le.maxlength_sourcetype,le.maxlength_statecode,le.maxlength_recordtype,le.maxlength_recorduploaddate,le.maxlength_docnumber,le.maxlength_fbinumber,le.maxlength_stateidnumber,le.maxlength_inmatenumber,le.maxlength_aliennumber,le.maxlength_orig_ssn,le.maxlength_nametype,le.maxlength_name,le.maxlength_lastname,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_suffix,le.maxlength_defendantstatus,le.maxlength_defendantadditionalinfo,le.maxlength_dob,le.maxlength_birthcity,le.maxlength_birthplace,le.maxlength_age,le.maxlength_gender,le.maxlength_height,le.maxlength_weight,le.maxlength_haircolor,le.maxlength_eyecolor,le.maxlength_race,le.maxlength_ethnicity,le.maxlength_skincolor,le.maxlength_bodymarks,le.maxlength_physicalbuild,le.maxlength_photoname,le.maxlength_dlnumber,le.maxlength_dlstate,le.maxlength_phone,le.maxlength_phonetype,le.maxlength_uscitizenflag,le.maxlength_addresstype,le.maxlength_street,le.maxlength_unit,le.maxlength_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_county,le.maxlength_institutionname,le.maxlength_institutiondetails,le.maxlength_institutionreceiptdate,le.maxlength_releasetolocation,le.maxlength_releasetodetails,le.maxlength_deceasedflag,le.maxlength_deceaseddate,le.maxlength_healthflag,le.maxlength_healthdesc,le.maxlength_bloodtype,le.maxlength_sexoffenderregistrydate,le.maxlength_sexoffenderregexpirationdate,le.maxlength_sexoffenderregistrynumber,le.maxlength_sourceid);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_sourcename,le.avelength_sourcetype,le.avelength_statecode,le.avelength_recordtype,le.avelength_recorduploaddate,le.avelength_docnumber,le.avelength_fbinumber,le.avelength_stateidnumber,le.avelength_inmatenumber,le.avelength_aliennumber,le.avelength_orig_ssn,le.avelength_nametype,le.avelength_name,le.avelength_lastname,le.avelength_firstname,le.avelength_middlename,le.avelength_suffix,le.avelength_defendantstatus,le.avelength_defendantadditionalinfo,le.avelength_dob,le.avelength_birthcity,le.avelength_birthplace,le.avelength_age,le.avelength_gender,le.avelength_height,le.avelength_weight,le.avelength_haircolor,le.avelength_eyecolor,le.avelength_race,le.avelength_ethnicity,le.avelength_skincolor,le.avelength_bodymarks,le.avelength_physicalbuild,le.avelength_photoname,le.avelength_dlnumber,le.avelength_dlstate,le.avelength_phone,le.avelength_phonetype,le.avelength_uscitizenflag,le.avelength_addresstype,le.avelength_street,le.avelength_unit,le.avelength_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_county,le.avelength_institutionname,le.avelength_institutiondetails,le.avelength_institutionreceiptdate,le.avelength_releasetolocation,le.avelength_releasetodetails,le.avelength_deceasedflag,le.avelength_deceaseddate,le.avelength_healthflag,le.avelength_healthdesc,le.avelength_bloodtype,le.avelength_sexoffenderregistrydate,le.avelength_sexoffenderregexpirationdate,le.avelength_sexoffenderregistrynumber,le.avelength_sourceid);
END;
EXPORT invSummary := NORMALIZE(summary0, 61, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourcetype),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.recordtype),TRIM((SALT33.StrType)le.recorduploaddate),TRIM((SALT33.StrType)le.docnumber),TRIM((SALT33.StrType)le.fbinumber),TRIM((SALT33.StrType)le.stateidnumber),TRIM((SALT33.StrType)le.inmatenumber),TRIM((SALT33.StrType)le.aliennumber),TRIM((SALT33.StrType)le.orig_ssn),TRIM((SALT33.StrType)le.nametype),TRIM((SALT33.StrType)le.name),TRIM((SALT33.StrType)le.lastname),TRIM((SALT33.StrType)le.firstname),TRIM((SALT33.StrType)le.middlename),TRIM((SALT33.StrType)le.suffix),TRIM((SALT33.StrType)le.defendantstatus),TRIM((SALT33.StrType)le.defendantadditionalinfo),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.birthcity),TRIM((SALT33.StrType)le.birthplace),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.gender),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.haircolor),TRIM((SALT33.StrType)le.eyecolor),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.ethnicity),TRIM((SALT33.StrType)le.skincolor),TRIM((SALT33.StrType)le.bodymarks),TRIM((SALT33.StrType)le.physicalbuild),TRIM((SALT33.StrType)le.photoname),TRIM((SALT33.StrType)le.dlnumber),TRIM((SALT33.StrType)le.dlstate),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.phonetype),TRIM((SALT33.StrType)le.uscitizenflag),TRIM((SALT33.StrType)le.addresstype),TRIM((SALT33.StrType)le.street),TRIM((SALT33.StrType)le.unit),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_zip),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.institutionname),TRIM((SALT33.StrType)le.institutiondetails),TRIM((SALT33.StrType)le.institutionreceiptdate),TRIM((SALT33.StrType)le.releasetolocation),TRIM((SALT33.StrType)le.releasetodetails),TRIM((SALT33.StrType)le.deceasedflag),TRIM((SALT33.StrType)le.deceaseddate),TRIM((SALT33.StrType)le.healthflag),TRIM((SALT33.StrType)le.healthdesc),TRIM((SALT33.StrType)le.bloodtype),TRIM((SALT33.StrType)le.sexoffenderregistrydate),TRIM((SALT33.StrType)le.sexoffenderregexpirationdate),TRIM((SALT33.StrType)le.sexoffenderregistrynumber),TRIM((SALT33.StrType)le.sourceid)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,61,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 61);
  SELF.FldNo2 := 1 + (C % 61);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourcetype),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.recordtype),TRIM((SALT33.StrType)le.recorduploaddate),TRIM((SALT33.StrType)le.docnumber),TRIM((SALT33.StrType)le.fbinumber),TRIM((SALT33.StrType)le.stateidnumber),TRIM((SALT33.StrType)le.inmatenumber),TRIM((SALT33.StrType)le.aliennumber),TRIM((SALT33.StrType)le.orig_ssn),TRIM((SALT33.StrType)le.nametype),TRIM((SALT33.StrType)le.name),TRIM((SALT33.StrType)le.lastname),TRIM((SALT33.StrType)le.firstname),TRIM((SALT33.StrType)le.middlename),TRIM((SALT33.StrType)le.suffix),TRIM((SALT33.StrType)le.defendantstatus),TRIM((SALT33.StrType)le.defendantadditionalinfo),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.birthcity),TRIM((SALT33.StrType)le.birthplace),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.gender),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.haircolor),TRIM((SALT33.StrType)le.eyecolor),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.ethnicity),TRIM((SALT33.StrType)le.skincolor),TRIM((SALT33.StrType)le.bodymarks),TRIM((SALT33.StrType)le.physicalbuild),TRIM((SALT33.StrType)le.photoname),TRIM((SALT33.StrType)le.dlnumber),TRIM((SALT33.StrType)le.dlstate),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.phonetype),TRIM((SALT33.StrType)le.uscitizenflag),TRIM((SALT33.StrType)le.addresstype),TRIM((SALT33.StrType)le.street),TRIM((SALT33.StrType)le.unit),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_zip),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.institutionname),TRIM((SALT33.StrType)le.institutiondetails),TRIM((SALT33.StrType)le.institutionreceiptdate),TRIM((SALT33.StrType)le.releasetolocation),TRIM((SALT33.StrType)le.releasetodetails),TRIM((SALT33.StrType)le.deceasedflag),TRIM((SALT33.StrType)le.deceaseddate),TRIM((SALT33.StrType)le.healthflag),TRIM((SALT33.StrType)le.healthdesc),TRIM((SALT33.StrType)le.bloodtype),TRIM((SALT33.StrType)le.sexoffenderregistrydate),TRIM((SALT33.StrType)le.sexoffenderregexpirationdate),TRIM((SALT33.StrType)le.sexoffenderregistrynumber),TRIM((SALT33.StrType)le.sourceid)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.sourcetype),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.recordtype),TRIM((SALT33.StrType)le.recorduploaddate),TRIM((SALT33.StrType)le.docnumber),TRIM((SALT33.StrType)le.fbinumber),TRIM((SALT33.StrType)le.stateidnumber),TRIM((SALT33.StrType)le.inmatenumber),TRIM((SALT33.StrType)le.aliennumber),TRIM((SALT33.StrType)le.orig_ssn),TRIM((SALT33.StrType)le.nametype),TRIM((SALT33.StrType)le.name),TRIM((SALT33.StrType)le.lastname),TRIM((SALT33.StrType)le.firstname),TRIM((SALT33.StrType)le.middlename),TRIM((SALT33.StrType)le.suffix),TRIM((SALT33.StrType)le.defendantstatus),TRIM((SALT33.StrType)le.defendantadditionalinfo),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.birthcity),TRIM((SALT33.StrType)le.birthplace),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.gender),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.haircolor),TRIM((SALT33.StrType)le.eyecolor),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.ethnicity),TRIM((SALT33.StrType)le.skincolor),TRIM((SALT33.StrType)le.bodymarks),TRIM((SALT33.StrType)le.physicalbuild),TRIM((SALT33.StrType)le.photoname),TRIM((SALT33.StrType)le.dlnumber),TRIM((SALT33.StrType)le.dlstate),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.phonetype),TRIM((SALT33.StrType)le.uscitizenflag),TRIM((SALT33.StrType)le.addresstype),TRIM((SALT33.StrType)le.street),TRIM((SALT33.StrType)le.unit),TRIM((SALT33.StrType)le.city),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_zip),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.institutionname),TRIM((SALT33.StrType)le.institutiondetails),TRIM((SALT33.StrType)le.institutionreceiptdate),TRIM((SALT33.StrType)le.releasetolocation),TRIM((SALT33.StrType)le.releasetodetails),TRIM((SALT33.StrType)le.deceasedflag),TRIM((SALT33.StrType)le.deceaseddate),TRIM((SALT33.StrType)le.healthflag),TRIM((SALT33.StrType)le.healthdesc),TRIM((SALT33.StrType)le.bloodtype),TRIM((SALT33.StrType)le.sexoffenderregistrydate),TRIM((SALT33.StrType)le.sexoffenderregexpirationdate),TRIM((SALT33.StrType)le.sexoffenderregistrynumber),TRIM((SALT33.StrType)le.sourceid)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),61*61,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'sourcename'}
      ,{3,'sourcetype'}
      ,{4,'statecode'}
      ,{5,'recordtype'}
      ,{6,'recorduploaddate'}
      ,{7,'docnumber'}
      ,{8,'fbinumber'}
      ,{9,'stateidnumber'}
      ,{10,'inmatenumber'}
      ,{11,'aliennumber'}
      ,{12,'orig_ssn'}
      ,{13,'nametype'}
      ,{14,'name'}
      ,{15,'lastname'}
      ,{16,'firstname'}
      ,{17,'middlename'}
      ,{18,'suffix'}
      ,{19,'defendantstatus'}
      ,{20,'defendantadditionalinfo'}
      ,{21,'dob'}
      ,{22,'birthcity'}
      ,{23,'birthplace'}
      ,{24,'age'}
      ,{25,'gender'}
      ,{26,'height'}
      ,{27,'weight'}
      ,{28,'haircolor'}
      ,{29,'eyecolor'}
      ,{30,'race'}
      ,{31,'ethnicity'}
      ,{32,'skincolor'}
      ,{33,'bodymarks'}
      ,{34,'physicalbuild'}
      ,{35,'photoname'}
      ,{36,'dlnumber'}
      ,{37,'dlstate'}
      ,{38,'phone'}
      ,{39,'phonetype'}
      ,{40,'uscitizenflag'}
      ,{41,'addresstype'}
      ,{42,'street'}
      ,{43,'unit'}
      ,{44,'city'}
      ,{45,'orig_state'}
      ,{46,'orig_zip'}
      ,{47,'county'}
      ,{48,'institutionname'}
      ,{49,'institutiondetails'}
      ,{50,'institutionreceiptdate'}
      ,{51,'releasetolocation'}
      ,{52,'releasetodetails'}
      ,{53,'deceasedflag'}
      ,{54,'deceaseddate'}
      ,{55,'healthflag'}
      ,{56,'healthdesc'}
      ,{57,'bloodtype'}
      ,{58,'sexoffenderregistrydate'}
      ,{59,'sexoffenderregexpirationdate'}
      ,{60,'sexoffenderregistrynumber'}
      ,{61,'sourceid'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_recordid((SALT33.StrType)le.recordid),
    Fields.InValid_sourcename((SALT33.StrType)le.sourcename),
    Fields.InValid_sourcetype((SALT33.StrType)le.sourcetype),
    Fields.InValid_statecode((SALT33.StrType)le.statecode),
    Fields.InValid_recordtype((SALT33.StrType)le.recordtype),
    Fields.InValid_recorduploaddate((SALT33.StrType)le.recorduploaddate),
    Fields.InValid_docnumber((SALT33.StrType)le.docnumber),
    Fields.InValid_fbinumber((SALT33.StrType)le.fbinumber),
    Fields.InValid_stateidnumber((SALT33.StrType)le.stateidnumber),
    Fields.InValid_inmatenumber((SALT33.StrType)le.inmatenumber),
    Fields.InValid_aliennumber((SALT33.StrType)le.aliennumber),
    Fields.InValid_orig_ssn((SALT33.StrType)le.orig_ssn),
    Fields.InValid_nametype((SALT33.StrType)le.nametype),
    Fields.InValid_name((SALT33.StrType)le.name),
    Fields.InValid_lastname((SALT33.StrType)le.lastname),
    Fields.InValid_firstname((SALT33.StrType)le.firstname),
    Fields.InValid_middlename((SALT33.StrType)le.middlename),
    Fields.InValid_suffix((SALT33.StrType)le.suffix),
    Fields.InValid_defendantstatus((SALT33.StrType)le.defendantstatus),
    Fields.InValid_defendantadditionalinfo((SALT33.StrType)le.defendantadditionalinfo),
    Fields.InValid_dob((SALT33.StrType)le.dob),
    Fields.InValid_birthcity((SALT33.StrType)le.birthcity),
    Fields.InValid_birthplace((SALT33.StrType)le.birthplace),
    Fields.InValid_age((SALT33.StrType)le.age),
    Fields.InValid_gender((SALT33.StrType)le.gender),
    Fields.InValid_height((SALT33.StrType)le.height),
    Fields.InValid_weight((SALT33.StrType)le.weight),
    Fields.InValid_haircolor((SALT33.StrType)le.haircolor),
    Fields.InValid_eyecolor((SALT33.StrType)le.eyecolor),
    Fields.InValid_race((SALT33.StrType)le.race),
    Fields.InValid_ethnicity((SALT33.StrType)le.ethnicity),
    Fields.InValid_skincolor((SALT33.StrType)le.skincolor),
    Fields.InValid_bodymarks((SALT33.StrType)le.bodymarks),
    Fields.InValid_physicalbuild((SALT33.StrType)le.physicalbuild),
    Fields.InValid_photoname((SALT33.StrType)le.photoname),
    Fields.InValid_dlnumber((SALT33.StrType)le.dlnumber),
    Fields.InValid_dlstate((SALT33.StrType)le.dlstate),
    Fields.InValid_phone((SALT33.StrType)le.phone),
    Fields.InValid_phonetype((SALT33.StrType)le.phonetype),
    Fields.InValid_uscitizenflag((SALT33.StrType)le.uscitizenflag),
    Fields.InValid_addresstype((SALT33.StrType)le.addresstype),
    Fields.InValid_street((SALT33.StrType)le.street),
    Fields.InValid_unit((SALT33.StrType)le.unit),
    Fields.InValid_city((SALT33.StrType)le.city),
    Fields.InValid_orig_state((SALT33.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT33.StrType)le.orig_zip),
    Fields.InValid_county((SALT33.StrType)le.county),
    Fields.InValid_institutionname((SALT33.StrType)le.institutionname),
    Fields.InValid_institutiondetails((SALT33.StrType)le.institutiondetails),
    Fields.InValid_institutionreceiptdate((SALT33.StrType)le.institutionreceiptdate),
    Fields.InValid_releasetolocation((SALT33.StrType)le.releasetolocation),
    Fields.InValid_releasetodetails((SALT33.StrType)le.releasetodetails),
    Fields.InValid_deceasedflag((SALT33.StrType)le.deceasedflag),
    Fields.InValid_deceaseddate((SALT33.StrType)le.deceaseddate),
    Fields.InValid_healthflag((SALT33.StrType)le.healthflag),
    Fields.InValid_healthdesc((SALT33.StrType)le.healthdesc),
    Fields.InValid_bloodtype((SALT33.StrType)le.bloodtype),
    Fields.InValid_sexoffenderregistrydate((SALT33.StrType)le.sexoffenderregistrydate),
    Fields.InValid_sexoffenderregexpirationdate((SALT33.StrType)le.sexoffenderregexpirationdate),
    Fields.InValid_sexoffenderregistrynumber((SALT33.StrType)le.sexoffenderregistrynumber),
    Fields.InValid_sourceid((SALT33.StrType)le.sourceid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,61,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','lastName','firstName','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_recordid(TotalErrors.ErrorNum),Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),Fields.InValidMessage_sourcetype(TotalErrors.ErrorNum),Fields.InValidMessage_statecode(TotalErrors.ErrorNum),Fields.InValidMessage_recordtype(TotalErrors.ErrorNum),Fields.InValidMessage_recorduploaddate(TotalErrors.ErrorNum),Fields.InValidMessage_docnumber(TotalErrors.ErrorNum),Fields.InValidMessage_fbinumber(TotalErrors.ErrorNum),Fields.InValidMessage_stateidnumber(TotalErrors.ErrorNum),Fields.InValidMessage_inmatenumber(TotalErrors.ErrorNum),Fields.InValidMessage_aliennumber(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Fields.InValidMessage_name(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_defendantstatus(TotalErrors.ErrorNum),Fields.InValidMessage_defendantadditionalinfo(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_birthcity(TotalErrors.ErrorNum),Fields.InValidMessage_birthplace(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_weight(TotalErrors.ErrorNum),Fields.InValidMessage_haircolor(TotalErrors.ErrorNum),Fields.InValidMessage_eyecolor(TotalErrors.ErrorNum),Fields.InValidMessage_race(TotalErrors.ErrorNum),Fields.InValidMessage_ethnicity(TotalErrors.ErrorNum),Fields.InValidMessage_skincolor(TotalErrors.ErrorNum),Fields.InValidMessage_bodymarks(TotalErrors.ErrorNum),Fields.InValidMessage_physicalbuild(TotalErrors.ErrorNum),Fields.InValidMessage_photoname(TotalErrors.ErrorNum),Fields.InValidMessage_dlnumber(TotalErrors.ErrorNum),Fields.InValidMessage_dlstate(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_phonetype(TotalErrors.ErrorNum),Fields.InValidMessage_uscitizenflag(TotalErrors.ErrorNum),Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),Fields.InValidMessage_street(TotalErrors.ErrorNum),Fields.InValidMessage_unit(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_institutionname(TotalErrors.ErrorNum),Fields.InValidMessage_institutiondetails(TotalErrors.ErrorNum),Fields.InValidMessage_institutionreceiptdate(TotalErrors.ErrorNum),Fields.InValidMessage_releasetolocation(TotalErrors.ErrorNum),Fields.InValidMessage_releasetodetails(TotalErrors.ErrorNum),Fields.InValidMessage_deceasedflag(TotalErrors.ErrorNum),Fields.InValidMessage_deceaseddate(TotalErrors.ErrorNum),Fields.InValidMessage_healthflag(TotalErrors.ErrorNum),Fields.InValidMessage_healthdesc(TotalErrors.ErrorNum),Fields.InValidMessage_bloodtype(TotalErrors.ErrorNum),Fields.InValidMessage_sexoffenderregistrydate(TotalErrors.ErrorNum),Fields.InValidMessage_sexoffenderregexpirationdate(TotalErrors.ErrorNum),Fields.InValidMessage_sexoffenderregistrynumber(TotalErrors.ErrorNum),Fields.InValidMessage_sourceid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
