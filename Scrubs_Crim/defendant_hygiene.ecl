IMPORT SALT311,STD;
EXPORT defendant_hygiene(dataset(defendant_layout_crim) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.vendor))'', MAX(GROUP,h.vendor));
    NumberOfRecords := COUNT(GROUP);
    populated_recordid_cnt := COUNT(GROUP,h.recordid <> (TYPEOF(h.recordid))'');
    populated_recordid_pcnt := AVE(GROUP,IF(h.recordid = (TYPEOF(h.recordid))'',0,100));
    maxlength_recordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordid)));
    avelength_recordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordid)),h.recordid<>(typeof(h.recordid))'');
    populated_sourcename_cnt := COUNT(GROUP,h.sourcename <> (TYPEOF(h.sourcename))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_sourcetype_cnt := COUNT(GROUP,h.sourcetype <> (TYPEOF(h.sourcetype))'');
    populated_sourcetype_pcnt := AVE(GROUP,IF(h.sourcetype = (TYPEOF(h.sourcetype))'',0,100));
    maxlength_sourcetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcetype)));
    avelength_sourcetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcetype)),h.sourcetype<>(typeof(h.sourcetype))'');
    populated_statecode_cnt := COUNT(GROUP,h.statecode <> (TYPEOF(h.statecode))'');
    populated_statecode_pcnt := AVE(GROUP,IF(h.statecode = (TYPEOF(h.statecode))'',0,100));
    maxlength_statecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statecode)));
    avelength_statecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statecode)),h.statecode<>(typeof(h.statecode))'');
    populated_recordtype_cnt := COUNT(GROUP,h.recordtype <> (TYPEOF(h.recordtype))'');
    populated_recordtype_pcnt := AVE(GROUP,IF(h.recordtype = (TYPEOF(h.recordtype))'',0,100));
    maxlength_recordtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordtype)));
    avelength_recordtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordtype)),h.recordtype<>(typeof(h.recordtype))'');
    populated_recorduploaddate_cnt := COUNT(GROUP,h.recorduploaddate <> (TYPEOF(h.recorduploaddate))'');
    populated_recorduploaddate_pcnt := AVE(GROUP,IF(h.recorduploaddate = (TYPEOF(h.recorduploaddate))'',0,100));
    maxlength_recorduploaddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorduploaddate)));
    avelength_recorduploaddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorduploaddate)),h.recorduploaddate<>(typeof(h.recorduploaddate))'');
    populated_docnumber_cnt := COUNT(GROUP,h.docnumber <> (TYPEOF(h.docnumber))'');
    populated_docnumber_pcnt := AVE(GROUP,IF(h.docnumber = (TYPEOF(h.docnumber))'',0,100));
    maxlength_docnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.docnumber)));
    avelength_docnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.docnumber)),h.docnumber<>(typeof(h.docnumber))'');
    populated_fbinumber_cnt := COUNT(GROUP,h.fbinumber <> (TYPEOF(h.fbinumber))'');
    populated_fbinumber_pcnt := AVE(GROUP,IF(h.fbinumber = (TYPEOF(h.fbinumber))'',0,100));
    maxlength_fbinumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fbinumber)));
    avelength_fbinumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fbinumber)),h.fbinumber<>(typeof(h.fbinumber))'');
    populated_stateidnumber_cnt := COUNT(GROUP,h.stateidnumber <> (TYPEOF(h.stateidnumber))'');
    populated_stateidnumber_pcnt := AVE(GROUP,IF(h.stateidnumber = (TYPEOF(h.stateidnumber))'',0,100));
    maxlength_stateidnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stateidnumber)));
    avelength_stateidnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stateidnumber)),h.stateidnumber<>(typeof(h.stateidnumber))'');
    populated_inmatenumber_cnt := COUNT(GROUP,h.inmatenumber <> (TYPEOF(h.inmatenumber))'');
    populated_inmatenumber_pcnt := AVE(GROUP,IF(h.inmatenumber = (TYPEOF(h.inmatenumber))'',0,100));
    maxlength_inmatenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inmatenumber)));
    avelength_inmatenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inmatenumber)),h.inmatenumber<>(typeof(h.inmatenumber))'');
    populated_aliennumber_cnt := COUNT(GROUP,h.aliennumber <> (TYPEOF(h.aliennumber))'');
    populated_aliennumber_pcnt := AVE(GROUP,IF(h.aliennumber = (TYPEOF(h.aliennumber))'',0,100));
    maxlength_aliennumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aliennumber)));
    avelength_aliennumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aliennumber)),h.aliennumber<>(typeof(h.aliennumber))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_nametype_cnt := COUNT(GROUP,h.nametype <> (TYPEOF(h.nametype))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_cnt := COUNT(GROUP,h.middlename <> (TYPEOF(h.middlename))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_defendantstatus_cnt := COUNT(GROUP,h.defendantstatus <> (TYPEOF(h.defendantstatus))'');
    populated_defendantstatus_pcnt := AVE(GROUP,IF(h.defendantstatus = (TYPEOF(h.defendantstatus))'',0,100));
    maxlength_defendantstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.defendantstatus)));
    avelength_defendantstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.defendantstatus)),h.defendantstatus<>(typeof(h.defendantstatus))'');
    populated_defendantadditionalinfo_cnt := COUNT(GROUP,h.defendantadditionalinfo <> (TYPEOF(h.defendantadditionalinfo))'');
    populated_defendantadditionalinfo_pcnt := AVE(GROUP,IF(h.defendantadditionalinfo = (TYPEOF(h.defendantadditionalinfo))'',0,100));
    maxlength_defendantadditionalinfo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.defendantadditionalinfo)));
    avelength_defendantadditionalinfo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.defendantadditionalinfo)),h.defendantadditionalinfo<>(typeof(h.defendantadditionalinfo))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_birthcity_cnt := COUNT(GROUP,h.birthcity <> (TYPEOF(h.birthcity))'');
    populated_birthcity_pcnt := AVE(GROUP,IF(h.birthcity = (TYPEOF(h.birthcity))'',0,100));
    maxlength_birthcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.birthcity)));
    avelength_birthcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.birthcity)),h.birthcity<>(typeof(h.birthcity))'');
    populated_birthplace_cnt := COUNT(GROUP,h.birthplace <> (TYPEOF(h.birthplace))'');
    populated_birthplace_pcnt := AVE(GROUP,IF(h.birthplace = (TYPEOF(h.birthplace))'',0,100));
    maxlength_birthplace := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.birthplace)));
    avelength_birthplace := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.birthplace)),h.birthplace<>(typeof(h.birthplace))'');
    populated_age_cnt := COUNT(GROUP,h.age <> (TYPEOF(h.age))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_height_cnt := COUNT(GROUP,h.height <> (TYPEOF(h.height))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_cnt := COUNT(GROUP,h.weight <> (TYPEOF(h.weight))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_haircolor_cnt := COUNT(GROUP,h.haircolor <> (TYPEOF(h.haircolor))'');
    populated_haircolor_pcnt := AVE(GROUP,IF(h.haircolor = (TYPEOF(h.haircolor))'',0,100));
    maxlength_haircolor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.haircolor)));
    avelength_haircolor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.haircolor)),h.haircolor<>(typeof(h.haircolor))'');
    populated_eyecolor_cnt := COUNT(GROUP,h.eyecolor <> (TYPEOF(h.eyecolor))'');
    populated_eyecolor_pcnt := AVE(GROUP,IF(h.eyecolor = (TYPEOF(h.eyecolor))'',0,100));
    maxlength_eyecolor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eyecolor)));
    avelength_eyecolor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eyecolor)),h.eyecolor<>(typeof(h.eyecolor))'');
    populated_race_cnt := COUNT(GROUP,h.race <> (TYPEOF(h.race))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_ethnicity_cnt := COUNT(GROUP,h.ethnicity <> (TYPEOF(h.ethnicity))'');
    populated_ethnicity_pcnt := AVE(GROUP,IF(h.ethnicity = (TYPEOF(h.ethnicity))'',0,100));
    maxlength_ethnicity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ethnicity)));
    avelength_ethnicity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ethnicity)),h.ethnicity<>(typeof(h.ethnicity))'');
    populated_skincolor_cnt := COUNT(GROUP,h.skincolor <> (TYPEOF(h.skincolor))'');
    populated_skincolor_pcnt := AVE(GROUP,IF(h.skincolor = (TYPEOF(h.skincolor))'',0,100));
    maxlength_skincolor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.skincolor)));
    avelength_skincolor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.skincolor)),h.skincolor<>(typeof(h.skincolor))'');
    populated_bodymarks_cnt := COUNT(GROUP,h.bodymarks <> (TYPEOF(h.bodymarks))'');
    populated_bodymarks_pcnt := AVE(GROUP,IF(h.bodymarks = (TYPEOF(h.bodymarks))'',0,100));
    maxlength_bodymarks := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bodymarks)));
    avelength_bodymarks := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bodymarks)),h.bodymarks<>(typeof(h.bodymarks))'');
    populated_physicalbuild_cnt := COUNT(GROUP,h.physicalbuild <> (TYPEOF(h.physicalbuild))'');
    populated_physicalbuild_pcnt := AVE(GROUP,IF(h.physicalbuild = (TYPEOF(h.physicalbuild))'',0,100));
    maxlength_physicalbuild := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.physicalbuild)));
    avelength_physicalbuild := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.physicalbuild)),h.physicalbuild<>(typeof(h.physicalbuild))'');
    populated_photoname_cnt := COUNT(GROUP,h.photoname <> (TYPEOF(h.photoname))'');
    populated_photoname_pcnt := AVE(GROUP,IF(h.photoname = (TYPEOF(h.photoname))'',0,100));
    maxlength_photoname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.photoname)));
    avelength_photoname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.photoname)),h.photoname<>(typeof(h.photoname))'');
    populated_dlnumber_cnt := COUNT(GROUP,h.dlnumber <> (TYPEOF(h.dlnumber))'');
    populated_dlnumber_pcnt := AVE(GROUP,IF(h.dlnumber = (TYPEOF(h.dlnumber))'',0,100));
    maxlength_dlnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dlnumber)));
    avelength_dlnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dlnumber)),h.dlnumber<>(typeof(h.dlnumber))'');
    populated_dlstate_cnt := COUNT(GROUP,h.dlstate <> (TYPEOF(h.dlstate))'');
    populated_dlstate_pcnt := AVE(GROUP,IF(h.dlstate = (TYPEOF(h.dlstate))'',0,100));
    maxlength_dlstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dlstate)));
    avelength_dlstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dlstate)),h.dlstate<>(typeof(h.dlstate))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phonetype_cnt := COUNT(GROUP,h.phonetype <> (TYPEOF(h.phonetype))'');
    populated_phonetype_pcnt := AVE(GROUP,IF(h.phonetype = (TYPEOF(h.phonetype))'',0,100));
    maxlength_phonetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonetype)));
    avelength_phonetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonetype)),h.phonetype<>(typeof(h.phonetype))'');
    populated_uscitizenflag_cnt := COUNT(GROUP,h.uscitizenflag <> (TYPEOF(h.uscitizenflag))'');
    populated_uscitizenflag_pcnt := AVE(GROUP,IF(h.uscitizenflag = (TYPEOF(h.uscitizenflag))'',0,100));
    maxlength_uscitizenflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.uscitizenflag)));
    avelength_uscitizenflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.uscitizenflag)),h.uscitizenflag<>(typeof(h.uscitizenflag))'');
    populated_addresstype_cnt := COUNT(GROUP,h.addresstype <> (TYPEOF(h.addresstype))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_street_cnt := COUNT(GROUP,h.street <> (TYPEOF(h.street))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_unit_cnt := COUNT(GROUP,h.unit <> (TYPEOF(h.unit))'');
    populated_unit_pcnt := AVE(GROUP,IF(h.unit = (TYPEOF(h.unit))'',0,100));
    maxlength_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit)));
    avelength_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit)),h.unit<>(typeof(h.unit))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_institutionname_cnt := COUNT(GROUP,h.institutionname <> (TYPEOF(h.institutionname))'');
    populated_institutionname_pcnt := AVE(GROUP,IF(h.institutionname = (TYPEOF(h.institutionname))'',0,100));
    maxlength_institutionname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.institutionname)));
    avelength_institutionname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.institutionname)),h.institutionname<>(typeof(h.institutionname))'');
    populated_institutiondetails_cnt := COUNT(GROUP,h.institutiondetails <> (TYPEOF(h.institutiondetails))'');
    populated_institutiondetails_pcnt := AVE(GROUP,IF(h.institutiondetails = (TYPEOF(h.institutiondetails))'',0,100));
    maxlength_institutiondetails := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.institutiondetails)));
    avelength_institutiondetails := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.institutiondetails)),h.institutiondetails<>(typeof(h.institutiondetails))'');
    populated_institutionreceiptdate_cnt := COUNT(GROUP,h.institutionreceiptdate <> (TYPEOF(h.institutionreceiptdate))'');
    populated_institutionreceiptdate_pcnt := AVE(GROUP,IF(h.institutionreceiptdate = (TYPEOF(h.institutionreceiptdate))'',0,100));
    maxlength_institutionreceiptdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.institutionreceiptdate)));
    avelength_institutionreceiptdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.institutionreceiptdate)),h.institutionreceiptdate<>(typeof(h.institutionreceiptdate))'');
    populated_releasetolocation_cnt := COUNT(GROUP,h.releasetolocation <> (TYPEOF(h.releasetolocation))'');
    populated_releasetolocation_pcnt := AVE(GROUP,IF(h.releasetolocation = (TYPEOF(h.releasetolocation))'',0,100));
    maxlength_releasetolocation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.releasetolocation)));
    avelength_releasetolocation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.releasetolocation)),h.releasetolocation<>(typeof(h.releasetolocation))'');
    populated_releasetodetails_cnt := COUNT(GROUP,h.releasetodetails <> (TYPEOF(h.releasetodetails))'');
    populated_releasetodetails_pcnt := AVE(GROUP,IF(h.releasetodetails = (TYPEOF(h.releasetodetails))'',0,100));
    maxlength_releasetodetails := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.releasetodetails)));
    avelength_releasetodetails := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.releasetodetails)),h.releasetodetails<>(typeof(h.releasetodetails))'');
    populated_deceasedflag_cnt := COUNT(GROUP,h.deceasedflag <> (TYPEOF(h.deceasedflag))'');
    populated_deceasedflag_pcnt := AVE(GROUP,IF(h.deceasedflag = (TYPEOF(h.deceasedflag))'',0,100));
    maxlength_deceasedflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceasedflag)));
    avelength_deceasedflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceasedflag)),h.deceasedflag<>(typeof(h.deceasedflag))'');
    populated_deceaseddate_cnt := COUNT(GROUP,h.deceaseddate <> (TYPEOF(h.deceaseddate))'');
    populated_deceaseddate_pcnt := AVE(GROUP,IF(h.deceaseddate = (TYPEOF(h.deceaseddate))'',0,100));
    maxlength_deceaseddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceaseddate)));
    avelength_deceaseddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceaseddate)),h.deceaseddate<>(typeof(h.deceaseddate))'');
    populated_healthflag_cnt := COUNT(GROUP,h.healthflag <> (TYPEOF(h.healthflag))'');
    populated_healthflag_pcnt := AVE(GROUP,IF(h.healthflag = (TYPEOF(h.healthflag))'',0,100));
    maxlength_healthflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.healthflag)));
    avelength_healthflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.healthflag)),h.healthflag<>(typeof(h.healthflag))'');
    populated_healthdesc_cnt := COUNT(GROUP,h.healthdesc <> (TYPEOF(h.healthdesc))'');
    populated_healthdesc_pcnt := AVE(GROUP,IF(h.healthdesc = (TYPEOF(h.healthdesc))'',0,100));
    maxlength_healthdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.healthdesc)));
    avelength_healthdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.healthdesc)),h.healthdesc<>(typeof(h.healthdesc))'');
    populated_bloodtype_cnt := COUNT(GROUP,h.bloodtype <> (TYPEOF(h.bloodtype))'');
    populated_bloodtype_pcnt := AVE(GROUP,IF(h.bloodtype = (TYPEOF(h.bloodtype))'',0,100));
    maxlength_bloodtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bloodtype)));
    avelength_bloodtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bloodtype)),h.bloodtype<>(typeof(h.bloodtype))'');
    populated_sexoffenderregistrydate_cnt := COUNT(GROUP,h.sexoffenderregistrydate <> (TYPEOF(h.sexoffenderregistrydate))'');
    populated_sexoffenderregistrydate_pcnt := AVE(GROUP,IF(h.sexoffenderregistrydate = (TYPEOF(h.sexoffenderregistrydate))'',0,100));
    maxlength_sexoffenderregistrydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sexoffenderregistrydate)));
    avelength_sexoffenderregistrydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sexoffenderregistrydate)),h.sexoffenderregistrydate<>(typeof(h.sexoffenderregistrydate))'');
    populated_sexoffenderregexpirationdate_cnt := COUNT(GROUP,h.sexoffenderregexpirationdate <> (TYPEOF(h.sexoffenderregexpirationdate))'');
    populated_sexoffenderregexpirationdate_pcnt := AVE(GROUP,IF(h.sexoffenderregexpirationdate = (TYPEOF(h.sexoffenderregexpirationdate))'',0,100));
    maxlength_sexoffenderregexpirationdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sexoffenderregexpirationdate)));
    avelength_sexoffenderregexpirationdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sexoffenderregexpirationdate)),h.sexoffenderregexpirationdate<>(typeof(h.sexoffenderregexpirationdate))'');
    populated_sexoffenderregistrynumber_cnt := COUNT(GROUP,h.sexoffenderregistrynumber <> (TYPEOF(h.sexoffenderregistrynumber))'');
    populated_sexoffenderregistrynumber_pcnt := AVE(GROUP,IF(h.sexoffenderregistrynumber = (TYPEOF(h.sexoffenderregistrynumber))'',0,100));
    maxlength_sexoffenderregistrynumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sexoffenderregistrynumber)));
    avelength_sexoffenderregistrynumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sexoffenderregistrynumber)),h.sexoffenderregistrynumber<>(typeof(h.sexoffenderregistrynumber))'');
    populated_sourceid_cnt := COUNT(GROUP,h.sourceid <> (TYPEOF(h.sourceid))'');
    populated_sourceid_pcnt := AVE(GROUP,IF(h.sourceid = (TYPEOF(h.sourceid))'',0,100));
    maxlength_sourceid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid)));
    avelength_sourceid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid)),h.sourceid<>(typeof(h.sourceid))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourcetype_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_recordtype_pcnt *   0.00 / 100 + T.Populated_recorduploaddate_pcnt *   0.00 / 100 + T.Populated_docnumber_pcnt *   0.00 / 100 + T.Populated_fbinumber_pcnt *   0.00 / 100 + T.Populated_stateidnumber_pcnt *   0.00 / 100 + T.Populated_inmatenumber_pcnt *   0.00 / 100 + T.Populated_aliennumber_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_defendantstatus_pcnt *   0.00 / 100 + T.Populated_defendantadditionalinfo_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_birthcity_pcnt *   0.00 / 100 + T.Populated_birthplace_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_haircolor_pcnt *   0.00 / 100 + T.Populated_eyecolor_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_ethnicity_pcnt *   0.00 / 100 + T.Populated_skincolor_pcnt *   0.00 / 100 + T.Populated_bodymarks_pcnt *   0.00 / 100 + T.Populated_physicalbuild_pcnt *   0.00 / 100 + T.Populated_photoname_pcnt *   0.00 / 100 + T.Populated_dlnumber_pcnt *   0.00 / 100 + T.Populated_dlstate_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phonetype_pcnt *   0.00 / 100 + T.Populated_uscitizenflag_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_unit_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_institutionname_pcnt *   0.00 / 100 + T.Populated_institutiondetails_pcnt *   0.00 / 100 + T.Populated_institutionreceiptdate_pcnt *   0.00 / 100 + T.Populated_releasetolocation_pcnt *   0.00 / 100 + T.Populated_releasetodetails_pcnt *   0.00 / 100 + T.Populated_deceasedflag_pcnt *   0.00 / 100 + T.Populated_deceaseddate_pcnt *   0.00 / 100 + T.Populated_healthflag_pcnt *   0.00 / 100 + T.Populated_healthdesc_pcnt *   0.00 / 100 + T.Populated_bloodtype_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrydate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregexpirationdate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrynumber_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_sourcetype_pcnt*ri.Populated_sourcetype_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_recordtype_pcnt*ri.Populated_recordtype_pcnt *   0.00 / 10000 + le.Populated_recorduploaddate_pcnt*ri.Populated_recorduploaddate_pcnt *   0.00 / 10000 + le.Populated_docnumber_pcnt*ri.Populated_docnumber_pcnt *   0.00 / 10000 + le.Populated_fbinumber_pcnt*ri.Populated_fbinumber_pcnt *   0.00 / 10000 + le.Populated_stateidnumber_pcnt*ri.Populated_stateidnumber_pcnt *   0.00 / 10000 + le.Populated_inmatenumber_pcnt*ri.Populated_inmatenumber_pcnt *   0.00 / 10000 + le.Populated_aliennumber_pcnt*ri.Populated_aliennumber_pcnt *   0.00 / 10000 + le.Populated_orig_ssn_pcnt*ri.Populated_orig_ssn_pcnt *   0.00 / 10000 + le.Populated_nametype_pcnt*ri.Populated_nametype_pcnt *   0.00 / 10000 + le.Populated_name_pcnt*ri.Populated_name_pcnt *   0.00 / 10000 + le.Populated_lastname_pcnt*ri.Populated_lastname_pcnt *   0.00 / 10000 + le.Populated_firstname_pcnt*ri.Populated_firstname_pcnt *   0.00 / 10000 + le.Populated_middlename_pcnt*ri.Populated_middlename_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_defendantstatus_pcnt*ri.Populated_defendantstatus_pcnt *   0.00 / 10000 + le.Populated_defendantadditionalinfo_pcnt*ri.Populated_defendantadditionalinfo_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_birthcity_pcnt*ri.Populated_birthcity_pcnt *   0.00 / 10000 + le.Populated_birthplace_pcnt*ri.Populated_birthplace_pcnt *   0.00 / 10000 + le.Populated_age_pcnt*ri.Populated_age_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_height_pcnt*ri.Populated_height_pcnt *   0.00 / 10000 + le.Populated_weight_pcnt*ri.Populated_weight_pcnt *   0.00 / 10000 + le.Populated_haircolor_pcnt*ri.Populated_haircolor_pcnt *   0.00 / 10000 + le.Populated_eyecolor_pcnt*ri.Populated_eyecolor_pcnt *   0.00 / 10000 + le.Populated_race_pcnt*ri.Populated_race_pcnt *   0.00 / 10000 + le.Populated_ethnicity_pcnt*ri.Populated_ethnicity_pcnt *   0.00 / 10000 + le.Populated_skincolor_pcnt*ri.Populated_skincolor_pcnt *   0.00 / 10000 + le.Populated_bodymarks_pcnt*ri.Populated_bodymarks_pcnt *   0.00 / 10000 + le.Populated_physicalbuild_pcnt*ri.Populated_physicalbuild_pcnt *   0.00 / 10000 + le.Populated_photoname_pcnt*ri.Populated_photoname_pcnt *   0.00 / 10000 + le.Populated_dlnumber_pcnt*ri.Populated_dlnumber_pcnt *   0.00 / 10000 + le.Populated_dlstate_pcnt*ri.Populated_dlstate_pcnt *   0.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *   0.00 / 10000 + le.Populated_phonetype_pcnt*ri.Populated_phonetype_pcnt *   0.00 / 10000 + le.Populated_uscitizenflag_pcnt*ri.Populated_uscitizenflag_pcnt *   0.00 / 10000 + le.Populated_addresstype_pcnt*ri.Populated_addresstype_pcnt *   0.00 / 10000 + le.Populated_street_pcnt*ri.Populated_street_pcnt *   0.00 / 10000 + le.Populated_unit_pcnt*ri.Populated_unit_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_zip_pcnt*ri.Populated_orig_zip_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_institutionname_pcnt*ri.Populated_institutionname_pcnt *   0.00 / 10000 + le.Populated_institutiondetails_pcnt*ri.Populated_institutiondetails_pcnt *   0.00 / 10000 + le.Populated_institutionreceiptdate_pcnt*ri.Populated_institutionreceiptdate_pcnt *   0.00 / 10000 + le.Populated_releasetolocation_pcnt*ri.Populated_releasetolocation_pcnt *   0.00 / 10000 + le.Populated_releasetodetails_pcnt*ri.Populated_releasetodetails_pcnt *   0.00 / 10000 + le.Populated_deceasedflag_pcnt*ri.Populated_deceasedflag_pcnt *   0.00 / 10000 + le.Populated_deceaseddate_pcnt*ri.Populated_deceaseddate_pcnt *   0.00 / 10000 + le.Populated_healthflag_pcnt*ri.Populated_healthflag_pcnt *   0.00 / 10000 + le.Populated_healthdesc_pcnt*ri.Populated_healthdesc_pcnt *   0.00 / 10000 + le.Populated_bloodtype_pcnt*ri.Populated_bloodtype_pcnt *   0.00 / 10000 + le.Populated_sexoffenderregistrydate_pcnt*ri.Populated_sexoffenderregistrydate_pcnt *   0.00 / 10000 + le.Populated_sexoffenderregexpirationdate_pcnt*ri.Populated_sexoffenderregexpirationdate_pcnt *   0.00 / 10000 + le.Populated_sexoffenderregistrynumber_pcnt*ri.Populated_sexoffenderregistrynumber_pcnt *   0.00 / 10000 + le.Populated_sourceid_pcnt*ri.Populated_sourceid_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_sourcename_pcnt,le.populated_sourcetype_pcnt,le.populated_statecode_pcnt,le.populated_recordtype_pcnt,le.populated_recorduploaddate_pcnt,le.populated_docnumber_pcnt,le.populated_fbinumber_pcnt,le.populated_stateidnumber_pcnt,le.populated_inmatenumber_pcnt,le.populated_aliennumber_pcnt,le.populated_orig_ssn_pcnt,le.populated_nametype_pcnt,le.populated_name_pcnt,le.populated_lastname_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_suffix_pcnt,le.populated_defendantstatus_pcnt,le.populated_defendantadditionalinfo_pcnt,le.populated_dob_pcnt,le.populated_birthcity_pcnt,le.populated_birthplace_pcnt,le.populated_age_pcnt,le.populated_gender_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_haircolor_pcnt,le.populated_eyecolor_pcnt,le.populated_race_pcnt,le.populated_ethnicity_pcnt,le.populated_skincolor_pcnt,le.populated_bodymarks_pcnt,le.populated_physicalbuild_pcnt,le.populated_photoname_pcnt,le.populated_dlnumber_pcnt,le.populated_dlstate_pcnt,le.populated_phone_pcnt,le.populated_phonetype_pcnt,le.populated_uscitizenflag_pcnt,le.populated_addresstype_pcnt,le.populated_street_pcnt,le.populated_unit_pcnt,le.populated_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_county_pcnt,le.populated_institutionname_pcnt,le.populated_institutiondetails_pcnt,le.populated_institutionreceiptdate_pcnt,le.populated_releasetolocation_pcnt,le.populated_releasetodetails_pcnt,le.populated_deceasedflag_pcnt,le.populated_deceaseddate_pcnt,le.populated_healthflag_pcnt,le.populated_healthdesc_pcnt,le.populated_bloodtype_pcnt,le.populated_sexoffenderregistrydate_pcnt,le.populated_sexoffenderregexpirationdate_pcnt,le.populated_sexoffenderregistrynumber_pcnt,le.populated_sourceid_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_sourcename,le.maxlength_sourcetype,le.maxlength_statecode,le.maxlength_recordtype,le.maxlength_recorduploaddate,le.maxlength_docnumber,le.maxlength_fbinumber,le.maxlength_stateidnumber,le.maxlength_inmatenumber,le.maxlength_aliennumber,le.maxlength_orig_ssn,le.maxlength_nametype,le.maxlength_name,le.maxlength_lastname,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_suffix,le.maxlength_defendantstatus,le.maxlength_defendantadditionalinfo,le.maxlength_dob,le.maxlength_birthcity,le.maxlength_birthplace,le.maxlength_age,le.maxlength_gender,le.maxlength_height,le.maxlength_weight,le.maxlength_haircolor,le.maxlength_eyecolor,le.maxlength_race,le.maxlength_ethnicity,le.maxlength_skincolor,le.maxlength_bodymarks,le.maxlength_physicalbuild,le.maxlength_photoname,le.maxlength_dlnumber,le.maxlength_dlstate,le.maxlength_phone,le.maxlength_phonetype,le.maxlength_uscitizenflag,le.maxlength_addresstype,le.maxlength_street,le.maxlength_unit,le.maxlength_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_county,le.maxlength_institutionname,le.maxlength_institutiondetails,le.maxlength_institutionreceiptdate,le.maxlength_releasetolocation,le.maxlength_releasetodetails,le.maxlength_deceasedflag,le.maxlength_deceaseddate,le.maxlength_healthflag,le.maxlength_healthdesc,le.maxlength_bloodtype,le.maxlength_sexoffenderregistrydate,le.maxlength_sexoffenderregexpirationdate,le.maxlength_sexoffenderregistrynumber,le.maxlength_sourceid,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_sourcename,le.avelength_sourcetype,le.avelength_statecode,le.avelength_recordtype,le.avelength_recorduploaddate,le.avelength_docnumber,le.avelength_fbinumber,le.avelength_stateidnumber,le.avelength_inmatenumber,le.avelength_aliennumber,le.avelength_orig_ssn,le.avelength_nametype,le.avelength_name,le.avelength_lastname,le.avelength_firstname,le.avelength_middlename,le.avelength_suffix,le.avelength_defendantstatus,le.avelength_defendantadditionalinfo,le.avelength_dob,le.avelength_birthcity,le.avelength_birthplace,le.avelength_age,le.avelength_gender,le.avelength_height,le.avelength_weight,le.avelength_haircolor,le.avelength_eyecolor,le.avelength_race,le.avelength_ethnicity,le.avelength_skincolor,le.avelength_bodymarks,le.avelength_physicalbuild,le.avelength_photoname,le.avelength_dlnumber,le.avelength_dlstate,le.avelength_phone,le.avelength_phonetype,le.avelength_uscitizenflag,le.avelength_addresstype,le.avelength_street,le.avelength_unit,le.avelength_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_county,le.avelength_institutionname,le.avelength_institutiondetails,le.avelength_institutionreceiptdate,le.avelength_releasetolocation,le.avelength_releasetodetails,le.avelength_deceasedflag,le.avelength_deceaseddate,le.avelength_healthflag,le.avelength_healthdesc,le.avelength_bloodtype,le.avelength_sexoffenderregistrydate,le.avelength_sexoffenderregexpirationdate,le.avelength_sexoffenderregistrynumber,le.avelength_sourceid,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 62, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourcetype),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.recordtype),TRIM((SALT311.StrType)le.recorduploaddate),TRIM((SALT311.StrType)le.docnumber),TRIM((SALT311.StrType)le.fbinumber),TRIM((SALT311.StrType)le.stateidnumber),TRIM((SALT311.StrType)le.inmatenumber),TRIM((SALT311.StrType)le.aliennumber),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.defendantstatus),TRIM((SALT311.StrType)le.defendantadditionalinfo),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.birthcity),TRIM((SALT311.StrType)le.birthplace),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.haircolor),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.skincolor),TRIM((SALT311.StrType)le.bodymarks),TRIM((SALT311.StrType)le.physicalbuild),TRIM((SALT311.StrType)le.photoname),TRIM((SALT311.StrType)le.dlnumber),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phonetype),TRIM((SALT311.StrType)le.uscitizenflag),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.institutionname),TRIM((SALT311.StrType)le.institutiondetails),TRIM((SALT311.StrType)le.institutionreceiptdate),TRIM((SALT311.StrType)le.releasetolocation),TRIM((SALT311.StrType)le.releasetodetails),TRIM((SALT311.StrType)le.deceasedflag),TRIM((SALT311.StrType)le.deceaseddate),TRIM((SALT311.StrType)le.healthflag),TRIM((SALT311.StrType)le.healthdesc),TRIM((SALT311.StrType)le.bloodtype),TRIM((SALT311.StrType)le.sexoffenderregistrydate),TRIM((SALT311.StrType)le.sexoffenderregexpirationdate),TRIM((SALT311.StrType)le.sexoffenderregistrynumber),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,62,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 62);
  SELF.FldNo2 := 1 + (C % 62);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourcetype),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.recordtype),TRIM((SALT311.StrType)le.recorduploaddate),TRIM((SALT311.StrType)le.docnumber),TRIM((SALT311.StrType)le.fbinumber),TRIM((SALT311.StrType)le.stateidnumber),TRIM((SALT311.StrType)le.inmatenumber),TRIM((SALT311.StrType)le.aliennumber),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.defendantstatus),TRIM((SALT311.StrType)le.defendantadditionalinfo),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.birthcity),TRIM((SALT311.StrType)le.birthplace),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.haircolor),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.skincolor),TRIM((SALT311.StrType)le.bodymarks),TRIM((SALT311.StrType)le.physicalbuild),TRIM((SALT311.StrType)le.photoname),TRIM((SALT311.StrType)le.dlnumber),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phonetype),TRIM((SALT311.StrType)le.uscitizenflag),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.institutionname),TRIM((SALT311.StrType)le.institutiondetails),TRIM((SALT311.StrType)le.institutionreceiptdate),TRIM((SALT311.StrType)le.releasetolocation),TRIM((SALT311.StrType)le.releasetodetails),TRIM((SALT311.StrType)le.deceasedflag),TRIM((SALT311.StrType)le.deceaseddate),TRIM((SALT311.StrType)le.healthflag),TRIM((SALT311.StrType)le.healthdesc),TRIM((SALT311.StrType)le.bloodtype),TRIM((SALT311.StrType)le.sexoffenderregistrydate),TRIM((SALT311.StrType)le.sexoffenderregexpirationdate),TRIM((SALT311.StrType)le.sexoffenderregistrynumber),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourcetype),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.recordtype),TRIM((SALT311.StrType)le.recorduploaddate),TRIM((SALT311.StrType)le.docnumber),TRIM((SALT311.StrType)le.fbinumber),TRIM((SALT311.StrType)le.stateidnumber),TRIM((SALT311.StrType)le.inmatenumber),TRIM((SALT311.StrType)le.aliennumber),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.defendantstatus),TRIM((SALT311.StrType)le.defendantadditionalinfo),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.birthcity),TRIM((SALT311.StrType)le.birthplace),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.haircolor),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.skincolor),TRIM((SALT311.StrType)le.bodymarks),TRIM((SALT311.StrType)le.physicalbuild),TRIM((SALT311.StrType)le.photoname),TRIM((SALT311.StrType)le.dlnumber),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phonetype),TRIM((SALT311.StrType)le.uscitizenflag),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.institutionname),TRIM((SALT311.StrType)le.institutiondetails),TRIM((SALT311.StrType)le.institutionreceiptdate),TRIM((SALT311.StrType)le.releasetolocation),TRIM((SALT311.StrType)le.releasetodetails),TRIM((SALT311.StrType)le.deceasedflag),TRIM((SALT311.StrType)le.deceaseddate),TRIM((SALT311.StrType)le.healthflag),TRIM((SALT311.StrType)le.healthdesc),TRIM((SALT311.StrType)le.bloodtype),TRIM((SALT311.StrType)le.sexoffenderregistrydate),TRIM((SALT311.StrType)le.sexoffenderregexpirationdate),TRIM((SALT311.StrType)le.sexoffenderregistrynumber),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),62*62,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{61,'sourceid'}
      ,{62,'vendor'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    defendant_Fields.InValid_recordid((SALT311.StrType)le.recordid),
    defendant_Fields.InValid_sourcename((SALT311.StrType)le.sourcename),
    defendant_Fields.InValid_sourcetype((SALT311.StrType)le.sourcetype),
    defendant_Fields.InValid_statecode((SALT311.StrType)le.statecode),
    defendant_Fields.InValid_recordtype((SALT311.StrType)le.recordtype),
    defendant_Fields.InValid_recorduploaddate((SALT311.StrType)le.recorduploaddate),
    defendant_Fields.InValid_docnumber((SALT311.StrType)le.docnumber),
    defendant_Fields.InValid_fbinumber((SALT311.StrType)le.fbinumber),
    defendant_Fields.InValid_stateidnumber((SALT311.StrType)le.stateidnumber),
    defendant_Fields.InValid_inmatenumber((SALT311.StrType)le.inmatenumber),
    defendant_Fields.InValid_aliennumber((SALT311.StrType)le.aliennumber),
    defendant_Fields.InValid_orig_ssn((SALT311.StrType)le.orig_ssn),
    defendant_Fields.InValid_nametype((SALT311.StrType)le.nametype),
    defendant_Fields.InValid_name((SALT311.StrType)le.name),
    defendant_Fields.InValid_lastname((SALT311.StrType)le.lastname),
    defendant_Fields.InValid_firstname((SALT311.StrType)le.firstname),
    defendant_Fields.InValid_middlename((SALT311.StrType)le.middlename),
    defendant_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    defendant_Fields.InValid_defendantstatus((SALT311.StrType)le.defendantstatus),
    defendant_Fields.InValid_defendantadditionalinfo((SALT311.StrType)le.defendantadditionalinfo),
    defendant_Fields.InValid_dob((SALT311.StrType)le.dob),
    defendant_Fields.InValid_birthcity((SALT311.StrType)le.birthcity),
    defendant_Fields.InValid_birthplace((SALT311.StrType)le.birthplace),
    defendant_Fields.InValid_age((SALT311.StrType)le.age),
    defendant_Fields.InValid_gender((SALT311.StrType)le.gender),
    defendant_Fields.InValid_height((SALT311.StrType)le.height),
    defendant_Fields.InValid_weight((SALT311.StrType)le.weight),
    defendant_Fields.InValid_haircolor((SALT311.StrType)le.haircolor),
    defendant_Fields.InValid_eyecolor((SALT311.StrType)le.eyecolor),
    defendant_Fields.InValid_race((SALT311.StrType)le.race),
    defendant_Fields.InValid_ethnicity((SALT311.StrType)le.ethnicity),
    defendant_Fields.InValid_skincolor((SALT311.StrType)le.skincolor),
    defendant_Fields.InValid_bodymarks((SALT311.StrType)le.bodymarks),
    defendant_Fields.InValid_physicalbuild((SALT311.StrType)le.physicalbuild),
    defendant_Fields.InValid_photoname((SALT311.StrType)le.photoname),
    defendant_Fields.InValid_dlnumber((SALT311.StrType)le.dlnumber),
    defendant_Fields.InValid_dlstate((SALT311.StrType)le.dlstate),
    defendant_Fields.InValid_phone((SALT311.StrType)le.phone),
    defendant_Fields.InValid_phonetype((SALT311.StrType)le.phonetype),
    defendant_Fields.InValid_uscitizenflag((SALT311.StrType)le.uscitizenflag),
    defendant_Fields.InValid_addresstype((SALT311.StrType)le.addresstype),
    defendant_Fields.InValid_street((SALT311.StrType)le.street),
    defendant_Fields.InValid_unit((SALT311.StrType)le.unit),
    defendant_Fields.InValid_city((SALT311.StrType)le.city),
    defendant_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    defendant_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    defendant_Fields.InValid_county((SALT311.StrType)le.county),
    defendant_Fields.InValid_institutionname((SALT311.StrType)le.institutionname),
    defendant_Fields.InValid_institutiondetails((SALT311.StrType)le.institutiondetails),
    defendant_Fields.InValid_institutionreceiptdate((SALT311.StrType)le.institutionreceiptdate),
    defendant_Fields.InValid_releasetolocation((SALT311.StrType)le.releasetolocation),
    defendant_Fields.InValid_releasetodetails((SALT311.StrType)le.releasetodetails),
    defendant_Fields.InValid_deceasedflag((SALT311.StrType)le.deceasedflag),
    defendant_Fields.InValid_deceaseddate((SALT311.StrType)le.deceaseddate),
    defendant_Fields.InValid_healthflag((SALT311.StrType)le.healthflag),
    defendant_Fields.InValid_healthdesc((SALT311.StrType)le.healthdesc),
    defendant_Fields.InValid_bloodtype((SALT311.StrType)le.bloodtype),
    defendant_Fields.InValid_sexoffenderregistrydate((SALT311.StrType)le.sexoffenderregistrydate),
    defendant_Fields.InValid_sexoffenderregexpirationdate((SALT311.StrType)le.sexoffenderregexpirationdate),
    defendant_Fields.InValid_sexoffenderregistrynumber((SALT311.StrType)le.sexoffenderregistrynumber),
    defendant_Fields.InValid_sourceid((SALT311.StrType)le.sourceid),
    defendant_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,62,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := defendant_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Unknown','Unknown','Invalid_State','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Inmate_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Invalid_City','Unknown','Unknown','Invalid_Gender','Unknown','Unknown','Unknown','Unknown','Invalid_Race','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_State','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_City','Unknown','Invalid_Zip','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Invalid_Future_Date','Unknown','Unknown','Unknown','Invalid_Current_Date','Invalid_Future_Date','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,defendant_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_sourcetype(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_recordtype(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_recorduploaddate(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_docnumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_fbinumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_stateidnumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_inmatenumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_aliennumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_nametype(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_name(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_middlename(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_defendantstatus(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_defendantadditionalinfo(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_dob(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_birthcity(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_birthplace(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_age(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_gender(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_height(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_weight(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_haircolor(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_eyecolor(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_race(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_ethnicity(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_skincolor(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_bodymarks(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_physicalbuild(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_photoname(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_dlnumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_dlstate(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_phone(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_phonetype(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_uscitizenflag(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_street(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_unit(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_city(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_county(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_institutionname(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_institutiondetails(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_institutionreceiptdate(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_releasetolocation(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_releasetodetails(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_deceasedflag(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_deceaseddate(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_healthflag(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_healthdesc(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_bloodtype(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_sexoffenderregistrydate(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_sexoffenderregexpirationdate(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_sexoffenderregistrynumber(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_sourceid(TotalErrors.ErrorNum),defendant_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, defendant_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
