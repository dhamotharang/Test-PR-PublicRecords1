IMPORT SALT311,STD;
EXPORT raw_hygiene(dataset(raw_layout_Fed_Bureau_Prisons) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
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
    populated_caseid_cnt := COUNT(GROUP,h.caseid <> (TYPEOF(h.caseid))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_casenumber_cnt := COUNT(GROUP,h.casenumber <> (TYPEOF(h.casenumber))'');
    populated_casenumber_pcnt := AVE(GROUP,IF(h.casenumber = (TYPEOF(h.casenumber))'',0,100));
    maxlength_casenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casenumber)));
    avelength_casenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casenumber)),h.casenumber<>(typeof(h.casenumber))'');
    populated_casetitle_cnt := COUNT(GROUP,h.casetitle <> (TYPEOF(h.casetitle))'');
    populated_casetitle_pcnt := AVE(GROUP,IF(h.casetitle = (TYPEOF(h.casetitle))'',0,100));
    maxlength_casetitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetitle)));
    avelength_casetitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetitle)),h.casetitle<>(typeof(h.casetitle))'');
    populated_casetype_cnt := COUNT(GROUP,h.casetype <> (TYPEOF(h.casetype))'');
    populated_casetype_pcnt := AVE(GROUP,IF(h.casetype = (TYPEOF(h.casetype))'',0,100));
    maxlength_casetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)));
    avelength_casetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casetype)),h.casetype<>(typeof(h.casetype))'');
    populated_casestatus_cnt := COUNT(GROUP,h.casestatus <> (TYPEOF(h.casestatus))'');
    populated_casestatus_pcnt := AVE(GROUP,IF(h.casestatus = (TYPEOF(h.casestatus))'',0,100));
    maxlength_casestatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casestatus)));
    avelength_casestatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casestatus)),h.casestatus<>(typeof(h.casestatus))'');
    populated_casestatusdate_cnt := COUNT(GROUP,h.casestatusdate <> (TYPEOF(h.casestatusdate))'');
    populated_casestatusdate_pcnt := AVE(GROUP,IF(h.casestatusdate = (TYPEOF(h.casestatusdate))'',0,100));
    maxlength_casestatusdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casestatusdate)));
    avelength_casestatusdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casestatusdate)),h.casestatusdate<>(typeof(h.casestatusdate))'');
    populated_casecomments_cnt := COUNT(GROUP,h.casecomments <> (TYPEOF(h.casecomments))'');
    populated_casecomments_pcnt := AVE(GROUP,IF(h.casecomments = (TYPEOF(h.casecomments))'',0,100));
    maxlength_casecomments := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.casecomments)));
    avelength_casecomments := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.casecomments)),h.casecomments<>(typeof(h.casecomments))'');
    populated_fileddate_cnt := COUNT(GROUP,h.fileddate <> (TYPEOF(h.fileddate))'');
    populated_fileddate_pcnt := AVE(GROUP,IF(h.fileddate = (TYPEOF(h.fileddate))'',0,100));
    maxlength_fileddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fileddate)));
    avelength_fileddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fileddate)),h.fileddate<>(typeof(h.fileddate))'');
    populated_caseinfo_cnt := COUNT(GROUP,h.caseinfo <> (TYPEOF(h.caseinfo))'');
    populated_caseinfo_pcnt := AVE(GROUP,IF(h.caseinfo = (TYPEOF(h.caseinfo))'',0,100));
    maxlength_caseinfo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseinfo)));
    avelength_caseinfo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseinfo)),h.caseinfo<>(typeof(h.caseinfo))'');
    populated_docketnumber_cnt := COUNT(GROUP,h.docketnumber <> (TYPEOF(h.docketnumber))'');
    populated_docketnumber_pcnt := AVE(GROUP,IF(h.docketnumber = (TYPEOF(h.docketnumber))'',0,100));
    maxlength_docketnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.docketnumber)));
    avelength_docketnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.docketnumber)),h.docketnumber<>(typeof(h.docketnumber))'');
    populated_offensecode_cnt := COUNT(GROUP,h.offensecode <> (TYPEOF(h.offensecode))'');
    populated_offensecode_pcnt := AVE(GROUP,IF(h.offensecode = (TYPEOF(h.offensecode))'',0,100));
    maxlength_offensecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensecode)));
    avelength_offensecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensecode)),h.offensecode<>(typeof(h.offensecode))'');
    populated_offensedesc_cnt := COUNT(GROUP,h.offensedesc <> (TYPEOF(h.offensedesc))'');
    populated_offensedesc_pcnt := AVE(GROUP,IF(h.offensedesc = (TYPEOF(h.offensedesc))'',0,100));
    maxlength_offensedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensedesc)));
    avelength_offensedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensedesc)),h.offensedesc<>(typeof(h.offensedesc))'');
    populated_offensedate_cnt := COUNT(GROUP,h.offensedate <> (TYPEOF(h.offensedate))'');
    populated_offensedate_pcnt := AVE(GROUP,IF(h.offensedate = (TYPEOF(h.offensedate))'',0,100));
    maxlength_offensedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensedate)));
    avelength_offensedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensedate)),h.offensedate<>(typeof(h.offensedate))'');
    populated_offensetype_cnt := COUNT(GROUP,h.offensetype <> (TYPEOF(h.offensetype))'');
    populated_offensetype_pcnt := AVE(GROUP,IF(h.offensetype = (TYPEOF(h.offensetype))'',0,100));
    maxlength_offensetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensetype)));
    avelength_offensetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensetype)),h.offensetype<>(typeof(h.offensetype))'');
    populated_offensedegree_cnt := COUNT(GROUP,h.offensedegree <> (TYPEOF(h.offensedegree))'');
    populated_offensedegree_pcnt := AVE(GROUP,IF(h.offensedegree = (TYPEOF(h.offensedegree))'',0,100));
    maxlength_offensedegree := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensedegree)));
    avelength_offensedegree := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensedegree)),h.offensedegree<>(typeof(h.offensedegree))'');
    populated_offenseclass_cnt := COUNT(GROUP,h.offenseclass <> (TYPEOF(h.offenseclass))'');
    populated_offenseclass_pcnt := AVE(GROUP,IF(h.offenseclass = (TYPEOF(h.offenseclass))'',0,100));
    maxlength_offenseclass := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offenseclass)));
    avelength_offenseclass := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offenseclass)),h.offenseclass<>(typeof(h.offenseclass))'');
    populated_dispositionstatus_cnt := COUNT(GROUP,h.dispositionstatus <> (TYPEOF(h.dispositionstatus))'');
    populated_dispositionstatus_pcnt := AVE(GROUP,IF(h.dispositionstatus = (TYPEOF(h.dispositionstatus))'',0,100));
    maxlength_dispositionstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispositionstatus)));
    avelength_dispositionstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispositionstatus)),h.dispositionstatus<>(typeof(h.dispositionstatus))'');
    populated_dispositionstatusdate_cnt := COUNT(GROUP,h.dispositionstatusdate <> (TYPEOF(h.dispositionstatusdate))'');
    populated_dispositionstatusdate_pcnt := AVE(GROUP,IF(h.dispositionstatusdate = (TYPEOF(h.dispositionstatusdate))'',0,100));
    maxlength_dispositionstatusdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispositionstatusdate)));
    avelength_dispositionstatusdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispositionstatusdate)),h.dispositionstatusdate<>(typeof(h.dispositionstatusdate))'');
    populated_disposition_cnt := COUNT(GROUP,h.disposition <> (TYPEOF(h.disposition))'');
    populated_disposition_pcnt := AVE(GROUP,IF(h.disposition = (TYPEOF(h.disposition))'',0,100));
    maxlength_disposition := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.disposition)));
    avelength_disposition := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.disposition)),h.disposition<>(typeof(h.disposition))'');
    populated_dispositiondate_cnt := COUNT(GROUP,h.dispositiondate <> (TYPEOF(h.dispositiondate))'');
    populated_dispositiondate_pcnt := AVE(GROUP,IF(h.dispositiondate = (TYPEOF(h.dispositiondate))'',0,100));
    maxlength_dispositiondate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispositiondate)));
    avelength_dispositiondate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispositiondate)),h.dispositiondate<>(typeof(h.dispositiondate))'');
    populated_offenselocation_cnt := COUNT(GROUP,h.offenselocation <> (TYPEOF(h.offenselocation))'');
    populated_offenselocation_pcnt := AVE(GROUP,IF(h.offenselocation = (TYPEOF(h.offenselocation))'',0,100));
    maxlength_offenselocation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offenselocation)));
    avelength_offenselocation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offenselocation)),h.offenselocation<>(typeof(h.offenselocation))'');
    populated_finaloffense_cnt := COUNT(GROUP,h.finaloffense <> (TYPEOF(h.finaloffense))'');
    populated_finaloffense_pcnt := AVE(GROUP,IF(h.finaloffense = (TYPEOF(h.finaloffense))'',0,100));
    maxlength_finaloffense := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.finaloffense)));
    avelength_finaloffense := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.finaloffense)),h.finaloffense<>(typeof(h.finaloffense))'');
    populated_finaloffensedate_cnt := COUNT(GROUP,h.finaloffensedate <> (TYPEOF(h.finaloffensedate))'');
    populated_finaloffensedate_pcnt := AVE(GROUP,IF(h.finaloffensedate = (TYPEOF(h.finaloffensedate))'',0,100));
    maxlength_finaloffensedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.finaloffensedate)));
    avelength_finaloffensedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.finaloffensedate)),h.finaloffensedate<>(typeof(h.finaloffensedate))'');
    populated_offensecount_cnt := COUNT(GROUP,h.offensecount <> (TYPEOF(h.offensecount))'');
    populated_offensecount_pcnt := AVE(GROUP,IF(h.offensecount = (TYPEOF(h.offensecount))'',0,100));
    maxlength_offensecount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensecount)));
    avelength_offensecount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensecount)),h.offensecount<>(typeof(h.offensecount))'');
    populated_victimunder18_cnt := COUNT(GROUP,h.victimunder18 <> (TYPEOF(h.victimunder18))'');
    populated_victimunder18_pcnt := AVE(GROUP,IF(h.victimunder18 = (TYPEOF(h.victimunder18))'',0,100));
    maxlength_victimunder18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.victimunder18)));
    avelength_victimunder18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.victimunder18)),h.victimunder18<>(typeof(h.victimunder18))'');
    populated_prioroffenseflag_cnt := COUNT(GROUP,h.prioroffenseflag <> (TYPEOF(h.prioroffenseflag))'');
    populated_prioroffenseflag_pcnt := AVE(GROUP,IF(h.prioroffenseflag = (TYPEOF(h.prioroffenseflag))'',0,100));
    maxlength_prioroffenseflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prioroffenseflag)));
    avelength_prioroffenseflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prioroffenseflag)),h.prioroffenseflag<>(typeof(h.prioroffenseflag))'');
    populated_initialplea_cnt := COUNT(GROUP,h.initialplea <> (TYPEOF(h.initialplea))'');
    populated_initialplea_pcnt := AVE(GROUP,IF(h.initialplea = (TYPEOF(h.initialplea))'',0,100));
    maxlength_initialplea := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialplea)));
    avelength_initialplea := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialplea)),h.initialplea<>(typeof(h.initialplea))'');
    populated_initialpleadate_cnt := COUNT(GROUP,h.initialpleadate <> (TYPEOF(h.initialpleadate))'');
    populated_initialpleadate_pcnt := AVE(GROUP,IF(h.initialpleadate = (TYPEOF(h.initialpleadate))'',0,100));
    maxlength_initialpleadate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialpleadate)));
    avelength_initialpleadate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialpleadate)),h.initialpleadate<>(typeof(h.initialpleadate))'');
    populated_finalruling_cnt := COUNT(GROUP,h.finalruling <> (TYPEOF(h.finalruling))'');
    populated_finalruling_pcnt := AVE(GROUP,IF(h.finalruling = (TYPEOF(h.finalruling))'',0,100));
    maxlength_finalruling := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.finalruling)));
    avelength_finalruling := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.finalruling)),h.finalruling<>(typeof(h.finalruling))'');
    populated_finalrulingdate_cnt := COUNT(GROUP,h.finalrulingdate <> (TYPEOF(h.finalrulingdate))'');
    populated_finalrulingdate_pcnt := AVE(GROUP,IF(h.finalrulingdate = (TYPEOF(h.finalrulingdate))'',0,100));
    maxlength_finalrulingdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.finalrulingdate)));
    avelength_finalrulingdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.finalrulingdate)),h.finalrulingdate<>(typeof(h.finalrulingdate))'');
    populated_appealstatus_cnt := COUNT(GROUP,h.appealstatus <> (TYPEOF(h.appealstatus))'');
    populated_appealstatus_pcnt := AVE(GROUP,IF(h.appealstatus = (TYPEOF(h.appealstatus))'',0,100));
    maxlength_appealstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appealstatus)));
    avelength_appealstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appealstatus)),h.appealstatus<>(typeof(h.appealstatus))'');
    populated_appealdate_cnt := COUNT(GROUP,h.appealdate <> (TYPEOF(h.appealdate))'');
    populated_appealdate_pcnt := AVE(GROUP,IF(h.appealdate = (TYPEOF(h.appealdate))'',0,100));
    maxlength_appealdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appealdate)));
    avelength_appealdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appealdate)),h.appealdate<>(typeof(h.appealdate))'');
    populated_courtname_cnt := COUNT(GROUP,h.courtname <> (TYPEOF(h.courtname))'');
    populated_courtname_pcnt := AVE(GROUP,IF(h.courtname = (TYPEOF(h.courtname))'',0,100));
    maxlength_courtname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtname)));
    avelength_courtname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtname)),h.courtname<>(typeof(h.courtname))'');
    populated_fineamount_cnt := COUNT(GROUP,h.fineamount <> (TYPEOF(h.fineamount))'');
    populated_fineamount_pcnt := AVE(GROUP,IF(h.fineamount = (TYPEOF(h.fineamount))'',0,100));
    maxlength_fineamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fineamount)));
    avelength_fineamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fineamount)),h.fineamount<>(typeof(h.fineamount))'');
    populated_courtfee_cnt := COUNT(GROUP,h.courtfee <> (TYPEOF(h.courtfee))'');
    populated_courtfee_pcnt := AVE(GROUP,IF(h.courtfee = (TYPEOF(h.courtfee))'',0,100));
    maxlength_courtfee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtfee)));
    avelength_courtfee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtfee)),h.courtfee<>(typeof(h.courtfee))'');
    populated_restitution_cnt := COUNT(GROUP,h.restitution <> (TYPEOF(h.restitution))'');
    populated_restitution_pcnt := AVE(GROUP,IF(h.restitution = (TYPEOF(h.restitution))'',0,100));
    maxlength_restitution := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.restitution)));
    avelength_restitution := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.restitution)),h.restitution<>(typeof(h.restitution))'');
    populated_trialtype_cnt := COUNT(GROUP,h.trialtype <> (TYPEOF(h.trialtype))'');
    populated_trialtype_pcnt := AVE(GROUP,IF(h.trialtype = (TYPEOF(h.trialtype))'',0,100));
    maxlength_trialtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trialtype)));
    avelength_trialtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trialtype)),h.trialtype<>(typeof(h.trialtype))'');
    populated_courtdate_cnt := COUNT(GROUP,h.courtdate <> (TYPEOF(h.courtdate))'');
    populated_courtdate_pcnt := AVE(GROUP,IF(h.courtdate = (TYPEOF(h.courtdate))'',0,100));
    maxlength_courtdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtdate)));
    avelength_courtdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtdate)),h.courtdate<>(typeof(h.courtdate))'');
    populated_classification_code_cnt := COUNT(GROUP,h.classification_code <> (TYPEOF(h.classification_code))'');
    populated_classification_code_pcnt := AVE(GROUP,IF(h.classification_code = (TYPEOF(h.classification_code))'',0,100));
    maxlength_classification_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classification_code)));
    avelength_classification_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classification_code)),h.classification_code<>(typeof(h.classification_code))'');
    populated_sub_classification_code_cnt := COUNT(GROUP,h.sub_classification_code <> (TYPEOF(h.sub_classification_code))'');
    populated_sub_classification_code_pcnt := AVE(GROUP,IF(h.sub_classification_code = (TYPEOF(h.sub_classification_code))'',0,100));
    maxlength_sub_classification_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_classification_code)));
    avelength_sub_classification_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_classification_code)),h.sub_classification_code<>(typeof(h.sub_classification_code))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_sourceid2_cnt := COUNT(GROUP,h.sourceid2 <> (TYPEOF(h.sourceid2))'');
    populated_sourceid2_pcnt := AVE(GROUP,IF(h.sourceid2 = (TYPEOF(h.sourceid2))'',0,100));
    maxlength_sourceid2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid2)));
    avelength_sourceid2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid2)),h.sourceid2<>(typeof(h.sourceid2))'');
    populated_sentencedate_cnt := COUNT(GROUP,h.sentencedate <> (TYPEOF(h.sentencedate))'');
    populated_sentencedate_pcnt := AVE(GROUP,IF(h.sentencedate = (TYPEOF(h.sentencedate))'',0,100));
    maxlength_sentencedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencedate)));
    avelength_sentencedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencedate)),h.sentencedate<>(typeof(h.sentencedate))'');
    populated_sentencebegindate_cnt := COUNT(GROUP,h.sentencebegindate <> (TYPEOF(h.sentencebegindate))'');
    populated_sentencebegindate_pcnt := AVE(GROUP,IF(h.sentencebegindate = (TYPEOF(h.sentencebegindate))'',0,100));
    maxlength_sentencebegindate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencebegindate)));
    avelength_sentencebegindate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencebegindate)),h.sentencebegindate<>(typeof(h.sentencebegindate))'');
    populated_sentenceenddate_cnt := COUNT(GROUP,h.sentenceenddate <> (TYPEOF(h.sentenceenddate))'');
    populated_sentenceenddate_pcnt := AVE(GROUP,IF(h.sentenceenddate = (TYPEOF(h.sentenceenddate))'',0,100));
    maxlength_sentenceenddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceenddate)));
    avelength_sentenceenddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceenddate)),h.sentenceenddate<>(typeof(h.sentenceenddate))'');
    populated_sentencetype_cnt := COUNT(GROUP,h.sentencetype <> (TYPEOF(h.sentencetype))'');
    populated_sentencetype_pcnt := AVE(GROUP,IF(h.sentencetype = (TYPEOF(h.sentencetype))'',0,100));
    maxlength_sentencetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencetype)));
    avelength_sentencetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencetype)),h.sentencetype<>(typeof(h.sentencetype))'');
    populated_sentencemaxyears_cnt := COUNT(GROUP,h.sentencemaxyears <> (TYPEOF(h.sentencemaxyears))'');
    populated_sentencemaxyears_pcnt := AVE(GROUP,IF(h.sentencemaxyears = (TYPEOF(h.sentencemaxyears))'',0,100));
    maxlength_sentencemaxyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemaxyears)));
    avelength_sentencemaxyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemaxyears)),h.sentencemaxyears<>(typeof(h.sentencemaxyears))'');
    populated_sentencemaxmonths_cnt := COUNT(GROUP,h.sentencemaxmonths <> (TYPEOF(h.sentencemaxmonths))'');
    populated_sentencemaxmonths_pcnt := AVE(GROUP,IF(h.sentencemaxmonths = (TYPEOF(h.sentencemaxmonths))'',0,100));
    maxlength_sentencemaxmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemaxmonths)));
    avelength_sentencemaxmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemaxmonths)),h.sentencemaxmonths<>(typeof(h.sentencemaxmonths))'');
    populated_sentencemaxdays_cnt := COUNT(GROUP,h.sentencemaxdays <> (TYPEOF(h.sentencemaxdays))'');
    populated_sentencemaxdays_pcnt := AVE(GROUP,IF(h.sentencemaxdays = (TYPEOF(h.sentencemaxdays))'',0,100));
    maxlength_sentencemaxdays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemaxdays)));
    avelength_sentencemaxdays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemaxdays)),h.sentencemaxdays<>(typeof(h.sentencemaxdays))'');
    populated_sentenceminyears_cnt := COUNT(GROUP,h.sentenceminyears <> (TYPEOF(h.sentenceminyears))'');
    populated_sentenceminyears_pcnt := AVE(GROUP,IF(h.sentenceminyears = (TYPEOF(h.sentenceminyears))'',0,100));
    maxlength_sentenceminyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceminyears)));
    avelength_sentenceminyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceminyears)),h.sentenceminyears<>(typeof(h.sentenceminyears))'');
    populated_sentenceminmonths_cnt := COUNT(GROUP,h.sentenceminmonths <> (TYPEOF(h.sentenceminmonths))'');
    populated_sentenceminmonths_pcnt := AVE(GROUP,IF(h.sentenceminmonths = (TYPEOF(h.sentenceminmonths))'',0,100));
    maxlength_sentenceminmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceminmonths)));
    avelength_sentenceminmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceminmonths)),h.sentenceminmonths<>(typeof(h.sentenceminmonths))'');
    populated_sentencemindays_cnt := COUNT(GROUP,h.sentencemindays <> (TYPEOF(h.sentencemindays))'');
    populated_sentencemindays_pcnt := AVE(GROUP,IF(h.sentencemindays = (TYPEOF(h.sentencemindays))'',0,100));
    maxlength_sentencemindays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemindays)));
    avelength_sentencemindays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencemindays)),h.sentencemindays<>(typeof(h.sentencemindays))'');
    populated_scheduledreleasedate_cnt := COUNT(GROUP,h.scheduledreleasedate <> (TYPEOF(h.scheduledreleasedate))'');
    populated_scheduledreleasedate_pcnt := AVE(GROUP,IF(h.scheduledreleasedate = (TYPEOF(h.scheduledreleasedate))'',0,100));
    maxlength_scheduledreleasedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.scheduledreleasedate)));
    avelength_scheduledreleasedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.scheduledreleasedate)),h.scheduledreleasedate<>(typeof(h.scheduledreleasedate))'');
    populated_actualreleasedate_cnt := COUNT(GROUP,h.actualreleasedate <> (TYPEOF(h.actualreleasedate))'');
    populated_actualreleasedate_pcnt := AVE(GROUP,IF(h.actualreleasedate = (TYPEOF(h.actualreleasedate))'',0,100));
    maxlength_actualreleasedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.actualreleasedate)));
    avelength_actualreleasedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.actualreleasedate)),h.actualreleasedate<>(typeof(h.actualreleasedate))'');
    populated_sentencestatus_cnt := COUNT(GROUP,h.sentencestatus <> (TYPEOF(h.sentencestatus))'');
    populated_sentencestatus_pcnt := AVE(GROUP,IF(h.sentencestatus = (TYPEOF(h.sentencestatus))'',0,100));
    maxlength_sentencestatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencestatus)));
    avelength_sentencestatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentencestatus)),h.sentencestatus<>(typeof(h.sentencestatus))'');
    populated_timeservedyears_cnt := COUNT(GROUP,h.timeservedyears <> (TYPEOF(h.timeservedyears))'');
    populated_timeservedyears_pcnt := AVE(GROUP,IF(h.timeservedyears = (TYPEOF(h.timeservedyears))'',0,100));
    maxlength_timeservedyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeservedyears)));
    avelength_timeservedyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeservedyears)),h.timeservedyears<>(typeof(h.timeservedyears))'');
    populated_timeservedmonths_cnt := COUNT(GROUP,h.timeservedmonths <> (TYPEOF(h.timeservedmonths))'');
    populated_timeservedmonths_pcnt := AVE(GROUP,IF(h.timeservedmonths = (TYPEOF(h.timeservedmonths))'',0,100));
    maxlength_timeservedmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeservedmonths)));
    avelength_timeservedmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeservedmonths)),h.timeservedmonths<>(typeof(h.timeservedmonths))'');
    populated_timeserveddays_cnt := COUNT(GROUP,h.timeserveddays <> (TYPEOF(h.timeserveddays))'');
    populated_timeserveddays_pcnt := AVE(GROUP,IF(h.timeserveddays = (TYPEOF(h.timeserveddays))'',0,100));
    maxlength_timeserveddays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeserveddays)));
    avelength_timeserveddays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timeserveddays)),h.timeserveddays<>(typeof(h.timeserveddays))'');
    populated_publicservicehours_cnt := COUNT(GROUP,h.publicservicehours <> (TYPEOF(h.publicservicehours))'');
    populated_publicservicehours_pcnt := AVE(GROUP,IF(h.publicservicehours = (TYPEOF(h.publicservicehours))'',0,100));
    maxlength_publicservicehours := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicservicehours)));
    avelength_publicservicehours := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicservicehours)),h.publicservicehours<>(typeof(h.publicservicehours))'');
    populated_sentenceadditionalinfo_cnt := COUNT(GROUP,h.sentenceadditionalinfo <> (TYPEOF(h.sentenceadditionalinfo))'');
    populated_sentenceadditionalinfo_pcnt := AVE(GROUP,IF(h.sentenceadditionalinfo = (TYPEOF(h.sentenceadditionalinfo))'',0,100));
    maxlength_sentenceadditionalinfo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceadditionalinfo)));
    avelength_sentenceadditionalinfo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sentenceadditionalinfo)),h.sentenceadditionalinfo<>(typeof(h.sentenceadditionalinfo))'');
    populated_communitysupervisioncounty_cnt := COUNT(GROUP,h.communitysupervisioncounty <> (TYPEOF(h.communitysupervisioncounty))'');
    populated_communitysupervisioncounty_pcnt := AVE(GROUP,IF(h.communitysupervisioncounty = (TYPEOF(h.communitysupervisioncounty))'',0,100));
    maxlength_communitysupervisioncounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisioncounty)));
    avelength_communitysupervisioncounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisioncounty)),h.communitysupervisioncounty<>(typeof(h.communitysupervisioncounty))'');
    populated_communitysupervisionyears_cnt := COUNT(GROUP,h.communitysupervisionyears <> (TYPEOF(h.communitysupervisionyears))'');
    populated_communitysupervisionyears_pcnt := AVE(GROUP,IF(h.communitysupervisionyears = (TYPEOF(h.communitysupervisionyears))'',0,100));
    maxlength_communitysupervisionyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisionyears)));
    avelength_communitysupervisionyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisionyears)),h.communitysupervisionyears<>(typeof(h.communitysupervisionyears))'');
    populated_communitysupervisionmonths_cnt := COUNT(GROUP,h.communitysupervisionmonths <> (TYPEOF(h.communitysupervisionmonths))'');
    populated_communitysupervisionmonths_pcnt := AVE(GROUP,IF(h.communitysupervisionmonths = (TYPEOF(h.communitysupervisionmonths))'',0,100));
    maxlength_communitysupervisionmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisionmonths)));
    avelength_communitysupervisionmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisionmonths)),h.communitysupervisionmonths<>(typeof(h.communitysupervisionmonths))'');
    populated_communitysupervisiondays_cnt := COUNT(GROUP,h.communitysupervisiondays <> (TYPEOF(h.communitysupervisiondays))'');
    populated_communitysupervisiondays_pcnt := AVE(GROUP,IF(h.communitysupervisiondays = (TYPEOF(h.communitysupervisiondays))'',0,100));
    maxlength_communitysupervisiondays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisiondays)));
    avelength_communitysupervisiondays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.communitysupervisiondays)),h.communitysupervisiondays<>(typeof(h.communitysupervisiondays))'');
    populated_parolebegindate_cnt := COUNT(GROUP,h.parolebegindate <> (TYPEOF(h.parolebegindate))'');
    populated_parolebegindate_pcnt := AVE(GROUP,IF(h.parolebegindate = (TYPEOF(h.parolebegindate))'',0,100));
    maxlength_parolebegindate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolebegindate)));
    avelength_parolebegindate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolebegindate)),h.parolebegindate<>(typeof(h.parolebegindate))'');
    populated_paroleenddate_cnt := COUNT(GROUP,h.paroleenddate <> (TYPEOF(h.paroleenddate))'');
    populated_paroleenddate_pcnt := AVE(GROUP,IF(h.paroleenddate = (TYPEOF(h.paroleenddate))'',0,100));
    maxlength_paroleenddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleenddate)));
    avelength_paroleenddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleenddate)),h.paroleenddate<>(typeof(h.paroleenddate))'');
    populated_paroleeligibilitydate_cnt := COUNT(GROUP,h.paroleeligibilitydate <> (TYPEOF(h.paroleeligibilitydate))'');
    populated_paroleeligibilitydate_pcnt := AVE(GROUP,IF(h.paroleeligibilitydate = (TYPEOF(h.paroleeligibilitydate))'',0,100));
    maxlength_paroleeligibilitydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleeligibilitydate)));
    avelength_paroleeligibilitydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleeligibilitydate)),h.paroleeligibilitydate<>(typeof(h.paroleeligibilitydate))'');
    populated_parolehearingdate_cnt := COUNT(GROUP,h.parolehearingdate <> (TYPEOF(h.parolehearingdate))'');
    populated_parolehearingdate_pcnt := AVE(GROUP,IF(h.parolehearingdate = (TYPEOF(h.parolehearingdate))'',0,100));
    maxlength_parolehearingdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolehearingdate)));
    avelength_parolehearingdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolehearingdate)),h.parolehearingdate<>(typeof(h.parolehearingdate))'');
    populated_parolemaxyears_cnt := COUNT(GROUP,h.parolemaxyears <> (TYPEOF(h.parolemaxyears))'');
    populated_parolemaxyears_pcnt := AVE(GROUP,IF(h.parolemaxyears = (TYPEOF(h.parolemaxyears))'',0,100));
    maxlength_parolemaxyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemaxyears)));
    avelength_parolemaxyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemaxyears)),h.parolemaxyears<>(typeof(h.parolemaxyears))'');
    populated_parolemaxmonths_cnt := COUNT(GROUP,h.parolemaxmonths <> (TYPEOF(h.parolemaxmonths))'');
    populated_parolemaxmonths_pcnt := AVE(GROUP,IF(h.parolemaxmonths = (TYPEOF(h.parolemaxmonths))'',0,100));
    maxlength_parolemaxmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemaxmonths)));
    avelength_parolemaxmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemaxmonths)),h.parolemaxmonths<>(typeof(h.parolemaxmonths))'');
    populated_parolemaxdays_cnt := COUNT(GROUP,h.parolemaxdays <> (TYPEOF(h.parolemaxdays))'');
    populated_parolemaxdays_pcnt := AVE(GROUP,IF(h.parolemaxdays = (TYPEOF(h.parolemaxdays))'',0,100));
    maxlength_parolemaxdays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemaxdays)));
    avelength_parolemaxdays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemaxdays)),h.parolemaxdays<>(typeof(h.parolemaxdays))'');
    populated_paroleminyears_cnt := COUNT(GROUP,h.paroleminyears <> (TYPEOF(h.paroleminyears))'');
    populated_paroleminyears_pcnt := AVE(GROUP,IF(h.paroleminyears = (TYPEOF(h.paroleminyears))'',0,100));
    maxlength_paroleminyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleminyears)));
    avelength_paroleminyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleminyears)),h.paroleminyears<>(typeof(h.paroleminyears))'');
    populated_paroleminmonths_cnt := COUNT(GROUP,h.paroleminmonths <> (TYPEOF(h.paroleminmonths))'');
    populated_paroleminmonths_pcnt := AVE(GROUP,IF(h.paroleminmonths = (TYPEOF(h.paroleminmonths))'',0,100));
    maxlength_paroleminmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleminmonths)));
    avelength_paroleminmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleminmonths)),h.paroleminmonths<>(typeof(h.paroleminmonths))'');
    populated_parolemindays_cnt := COUNT(GROUP,h.parolemindays <> (TYPEOF(h.parolemindays))'');
    populated_parolemindays_pcnt := AVE(GROUP,IF(h.parolemindays = (TYPEOF(h.parolemindays))'',0,100));
    maxlength_parolemindays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemindays)));
    avelength_parolemindays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolemindays)),h.parolemindays<>(typeof(h.parolemindays))'');
    populated_parolestatus_cnt := COUNT(GROUP,h.parolestatus <> (TYPEOF(h.parolestatus))'');
    populated_parolestatus_pcnt := AVE(GROUP,IF(h.parolestatus = (TYPEOF(h.parolestatus))'',0,100));
    maxlength_parolestatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolestatus)));
    avelength_parolestatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parolestatus)),h.parolestatus<>(typeof(h.parolestatus))'');
    populated_paroleofficer_cnt := COUNT(GROUP,h.paroleofficer <> (TYPEOF(h.paroleofficer))'');
    populated_paroleofficer_pcnt := AVE(GROUP,IF(h.paroleofficer = (TYPEOF(h.paroleofficer))'',0,100));
    maxlength_paroleofficer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleofficer)));
    avelength_paroleofficer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleofficer)),h.paroleofficer<>(typeof(h.paroleofficer))'');
    populated_paroleoffcerphone_cnt := COUNT(GROUP,h.paroleoffcerphone <> (TYPEOF(h.paroleoffcerphone))'');
    populated_paroleoffcerphone_pcnt := AVE(GROUP,IF(h.paroleoffcerphone = (TYPEOF(h.paroleoffcerphone))'',0,100));
    maxlength_paroleoffcerphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleoffcerphone)));
    avelength_paroleoffcerphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.paroleoffcerphone)),h.paroleoffcerphone<>(typeof(h.paroleoffcerphone))'');
    populated_probationbegindate_cnt := COUNT(GROUP,h.probationbegindate <> (TYPEOF(h.probationbegindate))'');
    populated_probationbegindate_pcnt := AVE(GROUP,IF(h.probationbegindate = (TYPEOF(h.probationbegindate))'',0,100));
    maxlength_probationbegindate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationbegindate)));
    avelength_probationbegindate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationbegindate)),h.probationbegindate<>(typeof(h.probationbegindate))'');
    populated_probationenddate_cnt := COUNT(GROUP,h.probationenddate <> (TYPEOF(h.probationenddate))'');
    populated_probationenddate_pcnt := AVE(GROUP,IF(h.probationenddate = (TYPEOF(h.probationenddate))'',0,100));
    maxlength_probationenddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationenddate)));
    avelength_probationenddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationenddate)),h.probationenddate<>(typeof(h.probationenddate))'');
    populated_probationmaxyears_cnt := COUNT(GROUP,h.probationmaxyears <> (TYPEOF(h.probationmaxyears))'');
    populated_probationmaxyears_pcnt := AVE(GROUP,IF(h.probationmaxyears = (TYPEOF(h.probationmaxyears))'',0,100));
    maxlength_probationmaxyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmaxyears)));
    avelength_probationmaxyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmaxyears)),h.probationmaxyears<>(typeof(h.probationmaxyears))'');
    populated_probationmaxmonths_cnt := COUNT(GROUP,h.probationmaxmonths <> (TYPEOF(h.probationmaxmonths))'');
    populated_probationmaxmonths_pcnt := AVE(GROUP,IF(h.probationmaxmonths = (TYPEOF(h.probationmaxmonths))'',0,100));
    maxlength_probationmaxmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmaxmonths)));
    avelength_probationmaxmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmaxmonths)),h.probationmaxmonths<>(typeof(h.probationmaxmonths))'');
    populated_probationmaxdays_cnt := COUNT(GROUP,h.probationmaxdays <> (TYPEOF(h.probationmaxdays))'');
    populated_probationmaxdays_pcnt := AVE(GROUP,IF(h.probationmaxdays = (TYPEOF(h.probationmaxdays))'',0,100));
    maxlength_probationmaxdays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmaxdays)));
    avelength_probationmaxdays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmaxdays)),h.probationmaxdays<>(typeof(h.probationmaxdays))'');
    populated_probationminyears_cnt := COUNT(GROUP,h.probationminyears <> (TYPEOF(h.probationminyears))'');
    populated_probationminyears_pcnt := AVE(GROUP,IF(h.probationminyears = (TYPEOF(h.probationminyears))'',0,100));
    maxlength_probationminyears := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationminyears)));
    avelength_probationminyears := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationminyears)),h.probationminyears<>(typeof(h.probationminyears))'');
    populated_probationminmonths_cnt := COUNT(GROUP,h.probationminmonths <> (TYPEOF(h.probationminmonths))'');
    populated_probationminmonths_pcnt := AVE(GROUP,IF(h.probationminmonths = (TYPEOF(h.probationminmonths))'',0,100));
    maxlength_probationminmonths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationminmonths)));
    avelength_probationminmonths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationminmonths)),h.probationminmonths<>(typeof(h.probationminmonths))'');
    populated_probationmindays_cnt := COUNT(GROUP,h.probationmindays <> (TYPEOF(h.probationmindays))'');
    populated_probationmindays_pcnt := AVE(GROUP,IF(h.probationmindays = (TYPEOF(h.probationmindays))'',0,100));
    maxlength_probationmindays := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmindays)));
    avelength_probationmindays := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationmindays)),h.probationmindays<>(typeof(h.probationmindays))'');
    populated_probationstatus_cnt := COUNT(GROUP,h.probationstatus <> (TYPEOF(h.probationstatus))'');
    populated_probationstatus_pcnt := AVE(GROUP,IF(h.probationstatus = (TYPEOF(h.probationstatus))'',0,100));
    maxlength_probationstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationstatus)));
    avelength_probationstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probationstatus)),h.probationstatus<>(typeof(h.probationstatus))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourcetype_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_recordtype_pcnt *   0.00 / 100 + T.Populated_recorduploaddate_pcnt *   0.00 / 100 + T.Populated_docnumber_pcnt *   0.00 / 100 + T.Populated_fbinumber_pcnt *   0.00 / 100 + T.Populated_stateidnumber_pcnt *   0.00 / 100 + T.Populated_inmatenumber_pcnt *   0.00 / 100 + T.Populated_aliennumber_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_defendantstatus_pcnt *   0.00 / 100 + T.Populated_defendantadditionalinfo_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_birthcity_pcnt *   0.00 / 100 + T.Populated_birthplace_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_haircolor_pcnt *   0.00 / 100 + T.Populated_eyecolor_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_ethnicity_pcnt *   0.00 / 100 + T.Populated_skincolor_pcnt *   0.00 / 100 + T.Populated_bodymarks_pcnt *   0.00 / 100 + T.Populated_physicalbuild_pcnt *   0.00 / 100 + T.Populated_photoname_pcnt *   0.00 / 100 + T.Populated_dlnumber_pcnt *   0.00 / 100 + T.Populated_dlstate_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phonetype_pcnt *   0.00 / 100 + T.Populated_uscitizenflag_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_unit_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_institutionname_pcnt *   0.00 / 100 + T.Populated_institutiondetails_pcnt *   0.00 / 100 + T.Populated_institutionreceiptdate_pcnt *   0.00 / 100 + T.Populated_releasetolocation_pcnt *   0.00 / 100 + T.Populated_releasetodetails_pcnt *   0.00 / 100 + T.Populated_deceasedflag_pcnt *   0.00 / 100 + T.Populated_deceaseddate_pcnt *   0.00 / 100 + T.Populated_healthflag_pcnt *   0.00 / 100 + T.Populated_healthdesc_pcnt *   0.00 / 100 + T.Populated_bloodtype_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrydate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregexpirationdate_pcnt *   0.00 / 100 + T.Populated_sexoffenderregistrynumber_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_casenumber_pcnt *   0.00 / 100 + T.Populated_casetitle_pcnt *   0.00 / 100 + T.Populated_casetype_pcnt *   0.00 / 100 + T.Populated_casestatus_pcnt *   0.00 / 100 + T.Populated_casestatusdate_pcnt *   0.00 / 100 + T.Populated_casecomments_pcnt *   0.00 / 100 + T.Populated_fileddate_pcnt *   0.00 / 100 + T.Populated_caseinfo_pcnt *   0.00 / 100 + T.Populated_docketnumber_pcnt *   0.00 / 100 + T.Populated_offensecode_pcnt *   0.00 / 100 + T.Populated_offensedesc_pcnt *   0.00 / 100 + T.Populated_offensedate_pcnt *   0.00 / 100 + T.Populated_offensetype_pcnt *   0.00 / 100 + T.Populated_offensedegree_pcnt *   0.00 / 100 + T.Populated_offenseclass_pcnt *   0.00 / 100 + T.Populated_dispositionstatus_pcnt *   0.00 / 100 + T.Populated_dispositionstatusdate_pcnt *   0.00 / 100 + T.Populated_disposition_pcnt *   0.00 / 100 + T.Populated_dispositiondate_pcnt *   0.00 / 100 + T.Populated_offenselocation_pcnt *   0.00 / 100 + T.Populated_finaloffense_pcnt *   0.00 / 100 + T.Populated_finaloffensedate_pcnt *   0.00 / 100 + T.Populated_offensecount_pcnt *   0.00 / 100 + T.Populated_victimunder18_pcnt *   0.00 / 100 + T.Populated_prioroffenseflag_pcnt *   0.00 / 100 + T.Populated_initialplea_pcnt *   0.00 / 100 + T.Populated_initialpleadate_pcnt *   0.00 / 100 + T.Populated_finalruling_pcnt *   0.00 / 100 + T.Populated_finalrulingdate_pcnt *   0.00 / 100 + T.Populated_appealstatus_pcnt *   0.00 / 100 + T.Populated_appealdate_pcnt *   0.00 / 100 + T.Populated_courtname_pcnt *   0.00 / 100 + T.Populated_fineamount_pcnt *   0.00 / 100 + T.Populated_courtfee_pcnt *   0.00 / 100 + T.Populated_restitution_pcnt *   0.00 / 100 + T.Populated_trialtype_pcnt *   0.00 / 100 + T.Populated_courtdate_pcnt *   0.00 / 100 + T.Populated_classification_code_pcnt *   0.00 / 100 + T.Populated_sub_classification_code_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_sourceid2_pcnt *   0.00 / 100 + T.Populated_sentencedate_pcnt *   0.00 / 100 + T.Populated_sentencebegindate_pcnt *   0.00 / 100 + T.Populated_sentenceenddate_pcnt *   0.00 / 100 + T.Populated_sentencetype_pcnt *   0.00 / 100 + T.Populated_sentencemaxyears_pcnt *   0.00 / 100 + T.Populated_sentencemaxmonths_pcnt *   0.00 / 100 + T.Populated_sentencemaxdays_pcnt *   0.00 / 100 + T.Populated_sentenceminyears_pcnt *   0.00 / 100 + T.Populated_sentenceminmonths_pcnt *   0.00 / 100 + T.Populated_sentencemindays_pcnt *   0.00 / 100 + T.Populated_scheduledreleasedate_pcnt *   0.00 / 100 + T.Populated_actualreleasedate_pcnt *   0.00 / 100 + T.Populated_sentencestatus_pcnt *   0.00 / 100 + T.Populated_timeservedyears_pcnt *   0.00 / 100 + T.Populated_timeservedmonths_pcnt *   0.00 / 100 + T.Populated_timeserveddays_pcnt *   0.00 / 100 + T.Populated_publicservicehours_pcnt *   0.00 / 100 + T.Populated_sentenceadditionalinfo_pcnt *   0.00 / 100 + T.Populated_communitysupervisioncounty_pcnt *   0.00 / 100 + T.Populated_communitysupervisionyears_pcnt *   0.00 / 100 + T.Populated_communitysupervisionmonths_pcnt *   0.00 / 100 + T.Populated_communitysupervisiondays_pcnt *   0.00 / 100 + T.Populated_parolebegindate_pcnt *   0.00 / 100 + T.Populated_paroleenddate_pcnt *   0.00 / 100 + T.Populated_paroleeligibilitydate_pcnt *   0.00 / 100 + T.Populated_parolehearingdate_pcnt *   0.00 / 100 + T.Populated_parolemaxyears_pcnt *   0.00 / 100 + T.Populated_parolemaxmonths_pcnt *   0.00 / 100 + T.Populated_parolemaxdays_pcnt *   0.00 / 100 + T.Populated_paroleminyears_pcnt *   0.00 / 100 + T.Populated_paroleminmonths_pcnt *   0.00 / 100 + T.Populated_parolemindays_pcnt *   0.00 / 100 + T.Populated_parolestatus_pcnt *   0.00 / 100 + T.Populated_paroleofficer_pcnt *   0.00 / 100 + T.Populated_paroleoffcerphone_pcnt *   0.00 / 100 + T.Populated_probationbegindate_pcnt *   0.00 / 100 + T.Populated_probationenddate_pcnt *   0.00 / 100 + T.Populated_probationmaxyears_pcnt *   0.00 / 100 + T.Populated_probationmaxmonths_pcnt *   0.00 / 100 + T.Populated_probationmaxdays_pcnt *   0.00 / 100 + T.Populated_probationminyears_pcnt *   0.00 / 100 + T.Populated_probationminmonths_pcnt *   0.00 / 100 + T.Populated_probationmindays_pcnt *   0.00 / 100 + T.Populated_probationstatus_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid','caseid','casenumber','casetitle','casetype','casestatus','casestatusdate','casecomments','fileddate','caseinfo','docketnumber','offensecode','offensedesc','offensedate','offensetype','offensedegree','offenseclass','dispositionstatus','dispositionstatusdate','disposition','dispositiondate','offenselocation','finaloffense','finaloffensedate','offensecount','victimunder18','prioroffenseflag','initialplea','initialpleadate','finalruling','finalrulingdate','appealstatus','appealdate','courtname','fineamount','courtfee','restitution','trialtype','courtdate','classification_code','sub_classification_code','state','zip','sourceid2','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_sourcename_pcnt,le.populated_sourcetype_pcnt,le.populated_statecode_pcnt,le.populated_recordtype_pcnt,le.populated_recorduploaddate_pcnt,le.populated_docnumber_pcnt,le.populated_fbinumber_pcnt,le.populated_stateidnumber_pcnt,le.populated_inmatenumber_pcnt,le.populated_aliennumber_pcnt,le.populated_orig_ssn_pcnt,le.populated_nametype_pcnt,le.populated_name_pcnt,le.populated_lastname_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_suffix_pcnt,le.populated_defendantstatus_pcnt,le.populated_defendantadditionalinfo_pcnt,le.populated_dob_pcnt,le.populated_birthcity_pcnt,le.populated_birthplace_pcnt,le.populated_age_pcnt,le.populated_gender_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_haircolor_pcnt,le.populated_eyecolor_pcnt,le.populated_race_pcnt,le.populated_ethnicity_pcnt,le.populated_skincolor_pcnt,le.populated_bodymarks_pcnt,le.populated_physicalbuild_pcnt,le.populated_photoname_pcnt,le.populated_dlnumber_pcnt,le.populated_dlstate_pcnt,le.populated_phone_pcnt,le.populated_phonetype_pcnt,le.populated_uscitizenflag_pcnt,le.populated_addresstype_pcnt,le.populated_street_pcnt,le.populated_unit_pcnt,le.populated_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_county_pcnt,le.populated_institutionname_pcnt,le.populated_institutiondetails_pcnt,le.populated_institutionreceiptdate_pcnt,le.populated_releasetolocation_pcnt,le.populated_releasetodetails_pcnt,le.populated_deceasedflag_pcnt,le.populated_deceaseddate_pcnt,le.populated_healthflag_pcnt,le.populated_healthdesc_pcnt,le.populated_bloodtype_pcnt,le.populated_sexoffenderregistrydate_pcnt,le.populated_sexoffenderregexpirationdate_pcnt,le.populated_sexoffenderregistrynumber_pcnt,le.populated_sourceid_pcnt,le.populated_caseid_pcnt,le.populated_casenumber_pcnt,le.populated_casetitle_pcnt,le.populated_casetype_pcnt,le.populated_casestatus_pcnt,le.populated_casestatusdate_pcnt,le.populated_casecomments_pcnt,le.populated_fileddate_pcnt,le.populated_caseinfo_pcnt,le.populated_docketnumber_pcnt,le.populated_offensecode_pcnt,le.populated_offensedesc_pcnt,le.populated_offensedate_pcnt,le.populated_offensetype_pcnt,le.populated_offensedegree_pcnt,le.populated_offenseclass_pcnt,le.populated_dispositionstatus_pcnt,le.populated_dispositionstatusdate_pcnt,le.populated_disposition_pcnt,le.populated_dispositiondate_pcnt,le.populated_offenselocation_pcnt,le.populated_finaloffense_pcnt,le.populated_finaloffensedate_pcnt,le.populated_offensecount_pcnt,le.populated_victimunder18_pcnt,le.populated_prioroffenseflag_pcnt,le.populated_initialplea_pcnt,le.populated_initialpleadate_pcnt,le.populated_finalruling_pcnt,le.populated_finalrulingdate_pcnt,le.populated_appealstatus_pcnt,le.populated_appealdate_pcnt,le.populated_courtname_pcnt,le.populated_fineamount_pcnt,le.populated_courtfee_pcnt,le.populated_restitution_pcnt,le.populated_trialtype_pcnt,le.populated_courtdate_pcnt,le.populated_classification_code_pcnt,le.populated_sub_classification_code_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_sourceid2_pcnt,le.populated_sentencedate_pcnt,le.populated_sentencebegindate_pcnt,le.populated_sentenceenddate_pcnt,le.populated_sentencetype_pcnt,le.populated_sentencemaxyears_pcnt,le.populated_sentencemaxmonths_pcnt,le.populated_sentencemaxdays_pcnt,le.populated_sentenceminyears_pcnt,le.populated_sentenceminmonths_pcnt,le.populated_sentencemindays_pcnt,le.populated_scheduledreleasedate_pcnt,le.populated_actualreleasedate_pcnt,le.populated_sentencestatus_pcnt,le.populated_timeservedyears_pcnt,le.populated_timeservedmonths_pcnt,le.populated_timeserveddays_pcnt,le.populated_publicservicehours_pcnt,le.populated_sentenceadditionalinfo_pcnt,le.populated_communitysupervisioncounty_pcnt,le.populated_communitysupervisionyears_pcnt,le.populated_communitysupervisionmonths_pcnt,le.populated_communitysupervisiondays_pcnt,le.populated_parolebegindate_pcnt,le.populated_paroleenddate_pcnt,le.populated_paroleeligibilitydate_pcnt,le.populated_parolehearingdate_pcnt,le.populated_parolemaxyears_pcnt,le.populated_parolemaxmonths_pcnt,le.populated_parolemaxdays_pcnt,le.populated_paroleminyears_pcnt,le.populated_paroleminmonths_pcnt,le.populated_parolemindays_pcnt,le.populated_parolestatus_pcnt,le.populated_paroleofficer_pcnt,le.populated_paroleoffcerphone_pcnt,le.populated_probationbegindate_pcnt,le.populated_probationenddate_pcnt,le.populated_probationmaxyears_pcnt,le.populated_probationmaxmonths_pcnt,le.populated_probationmaxdays_pcnt,le.populated_probationminyears_pcnt,le.populated_probationminmonths_pcnt,le.populated_probationmindays_pcnt,le.populated_probationstatus_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_sourcename,le.maxlength_sourcetype,le.maxlength_statecode,le.maxlength_recordtype,le.maxlength_recorduploaddate,le.maxlength_docnumber,le.maxlength_fbinumber,le.maxlength_stateidnumber,le.maxlength_inmatenumber,le.maxlength_aliennumber,le.maxlength_orig_ssn,le.maxlength_nametype,le.maxlength_name,le.maxlength_lastname,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_suffix,le.maxlength_defendantstatus,le.maxlength_defendantadditionalinfo,le.maxlength_dob,le.maxlength_birthcity,le.maxlength_birthplace,le.maxlength_age,le.maxlength_gender,le.maxlength_height,le.maxlength_weight,le.maxlength_haircolor,le.maxlength_eyecolor,le.maxlength_race,le.maxlength_ethnicity,le.maxlength_skincolor,le.maxlength_bodymarks,le.maxlength_physicalbuild,le.maxlength_photoname,le.maxlength_dlnumber,le.maxlength_dlstate,le.maxlength_phone,le.maxlength_phonetype,le.maxlength_uscitizenflag,le.maxlength_addresstype,le.maxlength_street,le.maxlength_unit,le.maxlength_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_county,le.maxlength_institutionname,le.maxlength_institutiondetails,le.maxlength_institutionreceiptdate,le.maxlength_releasetolocation,le.maxlength_releasetodetails,le.maxlength_deceasedflag,le.maxlength_deceaseddate,le.maxlength_healthflag,le.maxlength_healthdesc,le.maxlength_bloodtype,le.maxlength_sexoffenderregistrydate,le.maxlength_sexoffenderregexpirationdate,le.maxlength_sexoffenderregistrynumber,le.maxlength_sourceid,le.maxlength_caseid,le.maxlength_casenumber,le.maxlength_casetitle,le.maxlength_casetype,le.maxlength_casestatus,le.maxlength_casestatusdate,le.maxlength_casecomments,le.maxlength_fileddate,le.maxlength_caseinfo,le.maxlength_docketnumber,le.maxlength_offensecode,le.maxlength_offensedesc,le.maxlength_offensedate,le.maxlength_offensetype,le.maxlength_offensedegree,le.maxlength_offenseclass,le.maxlength_dispositionstatus,le.maxlength_dispositionstatusdate,le.maxlength_disposition,le.maxlength_dispositiondate,le.maxlength_offenselocation,le.maxlength_finaloffense,le.maxlength_finaloffensedate,le.maxlength_offensecount,le.maxlength_victimunder18,le.maxlength_prioroffenseflag,le.maxlength_initialplea,le.maxlength_initialpleadate,le.maxlength_finalruling,le.maxlength_finalrulingdate,le.maxlength_appealstatus,le.maxlength_appealdate,le.maxlength_courtname,le.maxlength_fineamount,le.maxlength_courtfee,le.maxlength_restitution,le.maxlength_trialtype,le.maxlength_courtdate,le.maxlength_classification_code,le.maxlength_sub_classification_code,le.maxlength_state,le.maxlength_zip,le.maxlength_sourceid2,le.maxlength_sentencedate,le.maxlength_sentencebegindate,le.maxlength_sentenceenddate,le.maxlength_sentencetype,le.maxlength_sentencemaxyears,le.maxlength_sentencemaxmonths,le.maxlength_sentencemaxdays,le.maxlength_sentenceminyears,le.maxlength_sentenceminmonths,le.maxlength_sentencemindays,le.maxlength_scheduledreleasedate,le.maxlength_actualreleasedate,le.maxlength_sentencestatus,le.maxlength_timeservedyears,le.maxlength_timeservedmonths,le.maxlength_timeserveddays,le.maxlength_publicservicehours,le.maxlength_sentenceadditionalinfo,le.maxlength_communitysupervisioncounty,le.maxlength_communitysupervisionyears,le.maxlength_communitysupervisionmonths,le.maxlength_communitysupervisiondays,le.maxlength_parolebegindate,le.maxlength_paroleenddate,le.maxlength_paroleeligibilitydate,le.maxlength_parolehearingdate,le.maxlength_parolemaxyears,le.maxlength_parolemaxmonths,le.maxlength_parolemaxdays,le.maxlength_paroleminyears,le.maxlength_paroleminmonths,le.maxlength_parolemindays,le.maxlength_parolestatus,le.maxlength_paroleofficer,le.maxlength_paroleoffcerphone,le.maxlength_probationbegindate,le.maxlength_probationenddate,le.maxlength_probationmaxyears,le.maxlength_probationmaxmonths,le.maxlength_probationmaxdays,le.maxlength_probationminyears,le.maxlength_probationminmonths,le.maxlength_probationmindays,le.maxlength_probationstatus);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_sourcename,le.avelength_sourcetype,le.avelength_statecode,le.avelength_recordtype,le.avelength_recorduploaddate,le.avelength_docnumber,le.avelength_fbinumber,le.avelength_stateidnumber,le.avelength_inmatenumber,le.avelength_aliennumber,le.avelength_orig_ssn,le.avelength_nametype,le.avelength_name,le.avelength_lastname,le.avelength_firstname,le.avelength_middlename,le.avelength_suffix,le.avelength_defendantstatus,le.avelength_defendantadditionalinfo,le.avelength_dob,le.avelength_birthcity,le.avelength_birthplace,le.avelength_age,le.avelength_gender,le.avelength_height,le.avelength_weight,le.avelength_haircolor,le.avelength_eyecolor,le.avelength_race,le.avelength_ethnicity,le.avelength_skincolor,le.avelength_bodymarks,le.avelength_physicalbuild,le.avelength_photoname,le.avelength_dlnumber,le.avelength_dlstate,le.avelength_phone,le.avelength_phonetype,le.avelength_uscitizenflag,le.avelength_addresstype,le.avelength_street,le.avelength_unit,le.avelength_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_county,le.avelength_institutionname,le.avelength_institutiondetails,le.avelength_institutionreceiptdate,le.avelength_releasetolocation,le.avelength_releasetodetails,le.avelength_deceasedflag,le.avelength_deceaseddate,le.avelength_healthflag,le.avelength_healthdesc,le.avelength_bloodtype,le.avelength_sexoffenderregistrydate,le.avelength_sexoffenderregexpirationdate,le.avelength_sexoffenderregistrynumber,le.avelength_sourceid,le.avelength_caseid,le.avelength_casenumber,le.avelength_casetitle,le.avelength_casetype,le.avelength_casestatus,le.avelength_casestatusdate,le.avelength_casecomments,le.avelength_fileddate,le.avelength_caseinfo,le.avelength_docketnumber,le.avelength_offensecode,le.avelength_offensedesc,le.avelength_offensedate,le.avelength_offensetype,le.avelength_offensedegree,le.avelength_offenseclass,le.avelength_dispositionstatus,le.avelength_dispositionstatusdate,le.avelength_disposition,le.avelength_dispositiondate,le.avelength_offenselocation,le.avelength_finaloffense,le.avelength_finaloffensedate,le.avelength_offensecount,le.avelength_victimunder18,le.avelength_prioroffenseflag,le.avelength_initialplea,le.avelength_initialpleadate,le.avelength_finalruling,le.avelength_finalrulingdate,le.avelength_appealstatus,le.avelength_appealdate,le.avelength_courtname,le.avelength_fineamount,le.avelength_courtfee,le.avelength_restitution,le.avelength_trialtype,le.avelength_courtdate,le.avelength_classification_code,le.avelength_sub_classification_code,le.avelength_state,le.avelength_zip,le.avelength_sourceid2,le.avelength_sentencedate,le.avelength_sentencebegindate,le.avelength_sentenceenddate,le.avelength_sentencetype,le.avelength_sentencemaxyears,le.avelength_sentencemaxmonths,le.avelength_sentencemaxdays,le.avelength_sentenceminyears,le.avelength_sentenceminmonths,le.avelength_sentencemindays,le.avelength_scheduledreleasedate,le.avelength_actualreleasedate,le.avelength_sentencestatus,le.avelength_timeservedyears,le.avelength_timeservedmonths,le.avelength_timeserveddays,le.avelength_publicservicehours,le.avelength_sentenceadditionalinfo,le.avelength_communitysupervisioncounty,le.avelength_communitysupervisionyears,le.avelength_communitysupervisionmonths,le.avelength_communitysupervisiondays,le.avelength_parolebegindate,le.avelength_paroleenddate,le.avelength_paroleeligibilitydate,le.avelength_parolehearingdate,le.avelength_parolemaxyears,le.avelength_parolemaxmonths,le.avelength_parolemaxdays,le.avelength_paroleminyears,le.avelength_paroleminmonths,le.avelength_parolemindays,le.avelength_parolestatus,le.avelength_paroleofficer,le.avelength_paroleoffcerphone,le.avelength_probationbegindate,le.avelength_probationenddate,le.avelength_probationmaxyears,le.avelength_probationmaxmonths,le.avelength_probationmaxdays,le.avelength_probationminyears,le.avelength_probationminmonths,le.avelength_probationmindays,le.avelength_probationstatus);
END;
EXPORT invSummary := NORMALIZE(summary0, 148, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourcetype),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.recordtype),TRIM((SALT311.StrType)le.recorduploaddate),TRIM((SALT311.StrType)le.docnumber),TRIM((SALT311.StrType)le.fbinumber),TRIM((SALT311.StrType)le.stateidnumber),TRIM((SALT311.StrType)le.inmatenumber),TRIM((SALT311.StrType)le.aliennumber),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.defendantstatus),TRIM((SALT311.StrType)le.defendantadditionalinfo),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.birthcity),TRIM((SALT311.StrType)le.birthplace),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.haircolor),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.skincolor),TRIM((SALT311.StrType)le.bodymarks),TRIM((SALT311.StrType)le.physicalbuild),TRIM((SALT311.StrType)le.photoname),TRIM((SALT311.StrType)le.dlnumber),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phonetype),TRIM((SALT311.StrType)le.uscitizenflag),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.institutionname),TRIM((SALT311.StrType)le.institutiondetails),TRIM((SALT311.StrType)le.institutionreceiptdate),TRIM((SALT311.StrType)le.releasetolocation),TRIM((SALT311.StrType)le.releasetodetails),TRIM((SALT311.StrType)le.deceasedflag),TRIM((SALT311.StrType)le.deceaseddate),TRIM((SALT311.StrType)le.healthflag),TRIM((SALT311.StrType)le.healthdesc),TRIM((SALT311.StrType)le.bloodtype),TRIM((SALT311.StrType)le.sexoffenderregistrydate),TRIM((SALT311.StrType)le.sexoffenderregexpirationdate),TRIM((SALT311.StrType)le.sexoffenderregistrynumber),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.casenumber),TRIM((SALT311.StrType)le.casetitle),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.casestatus),TRIM((SALT311.StrType)le.casestatusdate),TRIM((SALT311.StrType)le.casecomments),TRIM((SALT311.StrType)le.fileddate),TRIM((SALT311.StrType)le.caseinfo),TRIM((SALT311.StrType)le.docketnumber),TRIM((SALT311.StrType)le.offensecode),TRIM((SALT311.StrType)le.offensedesc),TRIM((SALT311.StrType)le.offensedate),TRIM((SALT311.StrType)le.offensetype),TRIM((SALT311.StrType)le.offensedegree),TRIM((SALT311.StrType)le.offenseclass),TRIM((SALT311.StrType)le.dispositionstatus),TRIM((SALT311.StrType)le.dispositionstatusdate),TRIM((SALT311.StrType)le.disposition),TRIM((SALT311.StrType)le.dispositiondate),TRIM((SALT311.StrType)le.offenselocation),TRIM((SALT311.StrType)le.finaloffense),TRIM((SALT311.StrType)le.finaloffensedate),TRIM((SALT311.StrType)le.offensecount),TRIM((SALT311.StrType)le.victimunder18),TRIM((SALT311.StrType)le.prioroffenseflag),TRIM((SALT311.StrType)le.initialplea),TRIM((SALT311.StrType)le.initialpleadate),TRIM((SALT311.StrType)le.finalruling),TRIM((SALT311.StrType)le.finalrulingdate),TRIM((SALT311.StrType)le.appealstatus),TRIM((SALT311.StrType)le.appealdate),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.fineamount),TRIM((SALT311.StrType)le.courtfee),TRIM((SALT311.StrType)le.restitution),TRIM((SALT311.StrType)le.trialtype),TRIM((SALT311.StrType)le.courtdate),TRIM((SALT311.StrType)le.classification_code),TRIM((SALT311.StrType)le.sub_classification_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.sourceid2),TRIM((SALT311.StrType)le.sentencedate),TRIM((SALT311.StrType)le.sentencebegindate),TRIM((SALT311.StrType)le.sentenceenddate),TRIM((SALT311.StrType)le.sentencetype),TRIM((SALT311.StrType)le.sentencemaxyears),TRIM((SALT311.StrType)le.sentencemaxmonths),TRIM((SALT311.StrType)le.sentencemaxdays),TRIM((SALT311.StrType)le.sentenceminyears),TRIM((SALT311.StrType)le.sentenceminmonths),TRIM((SALT311.StrType)le.sentencemindays),TRIM((SALT311.StrType)le.scheduledreleasedate),TRIM((SALT311.StrType)le.actualreleasedate),TRIM((SALT311.StrType)le.sentencestatus),TRIM((SALT311.StrType)le.timeservedyears),TRIM((SALT311.StrType)le.timeservedmonths),TRIM((SALT311.StrType)le.timeserveddays),TRIM((SALT311.StrType)le.publicservicehours),TRIM((SALT311.StrType)le.sentenceadditionalinfo),TRIM((SALT311.StrType)le.communitysupervisioncounty),TRIM((SALT311.StrType)le.communitysupervisionyears),TRIM((SALT311.StrType)le.communitysupervisionmonths),TRIM((SALT311.StrType)le.communitysupervisiondays),TRIM((SALT311.StrType)le.parolebegindate),TRIM((SALT311.StrType)le.paroleenddate),TRIM((SALT311.StrType)le.paroleeligibilitydate),TRIM((SALT311.StrType)le.parolehearingdate),TRIM((SALT311.StrType)le.parolemaxyears),TRIM((SALT311.StrType)le.parolemaxmonths),TRIM((SALT311.StrType)le.parolemaxdays),TRIM((SALT311.StrType)le.paroleminyears),TRIM((SALT311.StrType)le.paroleminmonths),TRIM((SALT311.StrType)le.parolemindays),TRIM((SALT311.StrType)le.parolestatus),TRIM((SALT311.StrType)le.paroleofficer),TRIM((SALT311.StrType)le.paroleoffcerphone),TRIM((SALT311.StrType)le.probationbegindate),TRIM((SALT311.StrType)le.probationenddate),TRIM((SALT311.StrType)le.probationmaxyears),TRIM((SALT311.StrType)le.probationmaxmonths),TRIM((SALT311.StrType)le.probationmaxdays),TRIM((SALT311.StrType)le.probationminyears),TRIM((SALT311.StrType)le.probationminmonths),TRIM((SALT311.StrType)le.probationmindays),TRIM((SALT311.StrType)le.probationstatus)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,148,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 148);
  SELF.FldNo2 := 1 + (C % 148);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourcetype),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.recordtype),TRIM((SALT311.StrType)le.recorduploaddate),TRIM((SALT311.StrType)le.docnumber),TRIM((SALT311.StrType)le.fbinumber),TRIM((SALT311.StrType)le.stateidnumber),TRIM((SALT311.StrType)le.inmatenumber),TRIM((SALT311.StrType)le.aliennumber),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.defendantstatus),TRIM((SALT311.StrType)le.defendantadditionalinfo),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.birthcity),TRIM((SALT311.StrType)le.birthplace),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.haircolor),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.skincolor),TRIM((SALT311.StrType)le.bodymarks),TRIM((SALT311.StrType)le.physicalbuild),TRIM((SALT311.StrType)le.photoname),TRIM((SALT311.StrType)le.dlnumber),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phonetype),TRIM((SALT311.StrType)le.uscitizenflag),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.institutionname),TRIM((SALT311.StrType)le.institutiondetails),TRIM((SALT311.StrType)le.institutionreceiptdate),TRIM((SALT311.StrType)le.releasetolocation),TRIM((SALT311.StrType)le.releasetodetails),TRIM((SALT311.StrType)le.deceasedflag),TRIM((SALT311.StrType)le.deceaseddate),TRIM((SALT311.StrType)le.healthflag),TRIM((SALT311.StrType)le.healthdesc),TRIM((SALT311.StrType)le.bloodtype),TRIM((SALT311.StrType)le.sexoffenderregistrydate),TRIM((SALT311.StrType)le.sexoffenderregexpirationdate),TRIM((SALT311.StrType)le.sexoffenderregistrynumber),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.casenumber),TRIM((SALT311.StrType)le.casetitle),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.casestatus),TRIM((SALT311.StrType)le.casestatusdate),TRIM((SALT311.StrType)le.casecomments),TRIM((SALT311.StrType)le.fileddate),TRIM((SALT311.StrType)le.caseinfo),TRIM((SALT311.StrType)le.docketnumber),TRIM((SALT311.StrType)le.offensecode),TRIM((SALT311.StrType)le.offensedesc),TRIM((SALT311.StrType)le.offensedate),TRIM((SALT311.StrType)le.offensetype),TRIM((SALT311.StrType)le.offensedegree),TRIM((SALT311.StrType)le.offenseclass),TRIM((SALT311.StrType)le.dispositionstatus),TRIM((SALT311.StrType)le.dispositionstatusdate),TRIM((SALT311.StrType)le.disposition),TRIM((SALT311.StrType)le.dispositiondate),TRIM((SALT311.StrType)le.offenselocation),TRIM((SALT311.StrType)le.finaloffense),TRIM((SALT311.StrType)le.finaloffensedate),TRIM((SALT311.StrType)le.offensecount),TRIM((SALT311.StrType)le.victimunder18),TRIM((SALT311.StrType)le.prioroffenseflag),TRIM((SALT311.StrType)le.initialplea),TRIM((SALT311.StrType)le.initialpleadate),TRIM((SALT311.StrType)le.finalruling),TRIM((SALT311.StrType)le.finalrulingdate),TRIM((SALT311.StrType)le.appealstatus),TRIM((SALT311.StrType)le.appealdate),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.fineamount),TRIM((SALT311.StrType)le.courtfee),TRIM((SALT311.StrType)le.restitution),TRIM((SALT311.StrType)le.trialtype),TRIM((SALT311.StrType)le.courtdate),TRIM((SALT311.StrType)le.classification_code),TRIM((SALT311.StrType)le.sub_classification_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.sourceid2),TRIM((SALT311.StrType)le.sentencedate),TRIM((SALT311.StrType)le.sentencebegindate),TRIM((SALT311.StrType)le.sentenceenddate),TRIM((SALT311.StrType)le.sentencetype),TRIM((SALT311.StrType)le.sentencemaxyears),TRIM((SALT311.StrType)le.sentencemaxmonths),TRIM((SALT311.StrType)le.sentencemaxdays),TRIM((SALT311.StrType)le.sentenceminyears),TRIM((SALT311.StrType)le.sentenceminmonths),TRIM((SALT311.StrType)le.sentencemindays),TRIM((SALT311.StrType)le.scheduledreleasedate),TRIM((SALT311.StrType)le.actualreleasedate),TRIM((SALT311.StrType)le.sentencestatus),TRIM((SALT311.StrType)le.timeservedyears),TRIM((SALT311.StrType)le.timeservedmonths),TRIM((SALT311.StrType)le.timeserveddays),TRIM((SALT311.StrType)le.publicservicehours),TRIM((SALT311.StrType)le.sentenceadditionalinfo),TRIM((SALT311.StrType)le.communitysupervisioncounty),TRIM((SALT311.StrType)le.communitysupervisionyears),TRIM((SALT311.StrType)le.communitysupervisionmonths),TRIM((SALT311.StrType)le.communitysupervisiondays),TRIM((SALT311.StrType)le.parolebegindate),TRIM((SALT311.StrType)le.paroleenddate),TRIM((SALT311.StrType)le.paroleeligibilitydate),TRIM((SALT311.StrType)le.parolehearingdate),TRIM((SALT311.StrType)le.parolemaxyears),TRIM((SALT311.StrType)le.parolemaxmonths),TRIM((SALT311.StrType)le.parolemaxdays),TRIM((SALT311.StrType)le.paroleminyears),TRIM((SALT311.StrType)le.paroleminmonths),TRIM((SALT311.StrType)le.parolemindays),TRIM((SALT311.StrType)le.parolestatus),TRIM((SALT311.StrType)le.paroleofficer),TRIM((SALT311.StrType)le.paroleoffcerphone),TRIM((SALT311.StrType)le.probationbegindate),TRIM((SALT311.StrType)le.probationenddate),TRIM((SALT311.StrType)le.probationmaxyears),TRIM((SALT311.StrType)le.probationmaxmonths),TRIM((SALT311.StrType)le.probationmaxdays),TRIM((SALT311.StrType)le.probationminyears),TRIM((SALT311.StrType)le.probationminmonths),TRIM((SALT311.StrType)le.probationmindays),TRIM((SALT311.StrType)le.probationstatus)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourcetype),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.recordtype),TRIM((SALT311.StrType)le.recorduploaddate),TRIM((SALT311.StrType)le.docnumber),TRIM((SALT311.StrType)le.fbinumber),TRIM((SALT311.StrType)le.stateidnumber),TRIM((SALT311.StrType)le.inmatenumber),TRIM((SALT311.StrType)le.aliennumber),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.defendantstatus),TRIM((SALT311.StrType)le.defendantadditionalinfo),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.birthcity),TRIM((SALT311.StrType)le.birthplace),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.height),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.haircolor),TRIM((SALT311.StrType)le.eyecolor),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.ethnicity),TRIM((SALT311.StrType)le.skincolor),TRIM((SALT311.StrType)le.bodymarks),TRIM((SALT311.StrType)le.physicalbuild),TRIM((SALT311.StrType)le.photoname),TRIM((SALT311.StrType)le.dlnumber),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phonetype),TRIM((SALT311.StrType)le.uscitizenflag),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.institutionname),TRIM((SALT311.StrType)le.institutiondetails),TRIM((SALT311.StrType)le.institutionreceiptdate),TRIM((SALT311.StrType)le.releasetolocation),TRIM((SALT311.StrType)le.releasetodetails),TRIM((SALT311.StrType)le.deceasedflag),TRIM((SALT311.StrType)le.deceaseddate),TRIM((SALT311.StrType)le.healthflag),TRIM((SALT311.StrType)le.healthdesc),TRIM((SALT311.StrType)le.bloodtype),TRIM((SALT311.StrType)le.sexoffenderregistrydate),TRIM((SALT311.StrType)le.sexoffenderregexpirationdate),TRIM((SALT311.StrType)le.sexoffenderregistrynumber),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.casenumber),TRIM((SALT311.StrType)le.casetitle),TRIM((SALT311.StrType)le.casetype),TRIM((SALT311.StrType)le.casestatus),TRIM((SALT311.StrType)le.casestatusdate),TRIM((SALT311.StrType)le.casecomments),TRIM((SALT311.StrType)le.fileddate),TRIM((SALT311.StrType)le.caseinfo),TRIM((SALT311.StrType)le.docketnumber),TRIM((SALT311.StrType)le.offensecode),TRIM((SALT311.StrType)le.offensedesc),TRIM((SALT311.StrType)le.offensedate),TRIM((SALT311.StrType)le.offensetype),TRIM((SALT311.StrType)le.offensedegree),TRIM((SALT311.StrType)le.offenseclass),TRIM((SALT311.StrType)le.dispositionstatus),TRIM((SALT311.StrType)le.dispositionstatusdate),TRIM((SALT311.StrType)le.disposition),TRIM((SALT311.StrType)le.dispositiondate),TRIM((SALT311.StrType)le.offenselocation),TRIM((SALT311.StrType)le.finaloffense),TRIM((SALT311.StrType)le.finaloffensedate),TRIM((SALT311.StrType)le.offensecount),TRIM((SALT311.StrType)le.victimunder18),TRIM((SALT311.StrType)le.prioroffenseflag),TRIM((SALT311.StrType)le.initialplea),TRIM((SALT311.StrType)le.initialpleadate),TRIM((SALT311.StrType)le.finalruling),TRIM((SALT311.StrType)le.finalrulingdate),TRIM((SALT311.StrType)le.appealstatus),TRIM((SALT311.StrType)le.appealdate),TRIM((SALT311.StrType)le.courtname),TRIM((SALT311.StrType)le.fineamount),TRIM((SALT311.StrType)le.courtfee),TRIM((SALT311.StrType)le.restitution),TRIM((SALT311.StrType)le.trialtype),TRIM((SALT311.StrType)le.courtdate),TRIM((SALT311.StrType)le.classification_code),TRIM((SALT311.StrType)le.sub_classification_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.sourceid2),TRIM((SALT311.StrType)le.sentencedate),TRIM((SALT311.StrType)le.sentencebegindate),TRIM((SALT311.StrType)le.sentenceenddate),TRIM((SALT311.StrType)le.sentencetype),TRIM((SALT311.StrType)le.sentencemaxyears),TRIM((SALT311.StrType)le.sentencemaxmonths),TRIM((SALT311.StrType)le.sentencemaxdays),TRIM((SALT311.StrType)le.sentenceminyears),TRIM((SALT311.StrType)le.sentenceminmonths),TRIM((SALT311.StrType)le.sentencemindays),TRIM((SALT311.StrType)le.scheduledreleasedate),TRIM((SALT311.StrType)le.actualreleasedate),TRIM((SALT311.StrType)le.sentencestatus),TRIM((SALT311.StrType)le.timeservedyears),TRIM((SALT311.StrType)le.timeservedmonths),TRIM((SALT311.StrType)le.timeserveddays),TRIM((SALT311.StrType)le.publicservicehours),TRIM((SALT311.StrType)le.sentenceadditionalinfo),TRIM((SALT311.StrType)le.communitysupervisioncounty),TRIM((SALT311.StrType)le.communitysupervisionyears),TRIM((SALT311.StrType)le.communitysupervisionmonths),TRIM((SALT311.StrType)le.communitysupervisiondays),TRIM((SALT311.StrType)le.parolebegindate),TRIM((SALT311.StrType)le.paroleenddate),TRIM((SALT311.StrType)le.paroleeligibilitydate),TRIM((SALT311.StrType)le.parolehearingdate),TRIM((SALT311.StrType)le.parolemaxyears),TRIM((SALT311.StrType)le.parolemaxmonths),TRIM((SALT311.StrType)le.parolemaxdays),TRIM((SALT311.StrType)le.paroleminyears),TRIM((SALT311.StrType)le.paroleminmonths),TRIM((SALT311.StrType)le.parolemindays),TRIM((SALT311.StrType)le.parolestatus),TRIM((SALT311.StrType)le.paroleofficer),TRIM((SALT311.StrType)le.paroleoffcerphone),TRIM((SALT311.StrType)le.probationbegindate),TRIM((SALT311.StrType)le.probationenddate),TRIM((SALT311.StrType)le.probationmaxyears),TRIM((SALT311.StrType)le.probationmaxmonths),TRIM((SALT311.StrType)le.probationmaxdays),TRIM((SALT311.StrType)le.probationminyears),TRIM((SALT311.StrType)le.probationminmonths),TRIM((SALT311.StrType)le.probationmindays),TRIM((SALT311.StrType)le.probationstatus)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),148*148,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{62,'caseid'}
      ,{63,'casenumber'}
      ,{64,'casetitle'}
      ,{65,'casetype'}
      ,{66,'casestatus'}
      ,{67,'casestatusdate'}
      ,{68,'casecomments'}
      ,{69,'fileddate'}
      ,{70,'caseinfo'}
      ,{71,'docketnumber'}
      ,{72,'offensecode'}
      ,{73,'offensedesc'}
      ,{74,'offensedate'}
      ,{75,'offensetype'}
      ,{76,'offensedegree'}
      ,{77,'offenseclass'}
      ,{78,'dispositionstatus'}
      ,{79,'dispositionstatusdate'}
      ,{80,'disposition'}
      ,{81,'dispositiondate'}
      ,{82,'offenselocation'}
      ,{83,'finaloffense'}
      ,{84,'finaloffensedate'}
      ,{85,'offensecount'}
      ,{86,'victimunder18'}
      ,{87,'prioroffenseflag'}
      ,{88,'initialplea'}
      ,{89,'initialpleadate'}
      ,{90,'finalruling'}
      ,{91,'finalrulingdate'}
      ,{92,'appealstatus'}
      ,{93,'appealdate'}
      ,{94,'courtname'}
      ,{95,'fineamount'}
      ,{96,'courtfee'}
      ,{97,'restitution'}
      ,{98,'trialtype'}
      ,{99,'courtdate'}
      ,{100,'classification_code'}
      ,{101,'sub_classification_code'}
      ,{102,'state'}
      ,{103,'zip'}
      ,{104,'sourceid2'}
      ,{105,'sentencedate'}
      ,{106,'sentencebegindate'}
      ,{107,'sentenceenddate'}
      ,{108,'sentencetype'}
      ,{109,'sentencemaxyears'}
      ,{110,'sentencemaxmonths'}
      ,{111,'sentencemaxdays'}
      ,{112,'sentenceminyears'}
      ,{113,'sentenceminmonths'}
      ,{114,'sentencemindays'}
      ,{115,'scheduledreleasedate'}
      ,{116,'actualreleasedate'}
      ,{117,'sentencestatus'}
      ,{118,'timeservedyears'}
      ,{119,'timeservedmonths'}
      ,{120,'timeserveddays'}
      ,{121,'publicservicehours'}
      ,{122,'sentenceadditionalinfo'}
      ,{123,'communitysupervisioncounty'}
      ,{124,'communitysupervisionyears'}
      ,{125,'communitysupervisionmonths'}
      ,{126,'communitysupervisiondays'}
      ,{127,'parolebegindate'}
      ,{128,'paroleenddate'}
      ,{129,'paroleeligibilitydate'}
      ,{130,'parolehearingdate'}
      ,{131,'parolemaxyears'}
      ,{132,'parolemaxmonths'}
      ,{133,'parolemaxdays'}
      ,{134,'paroleminyears'}
      ,{135,'paroleminmonths'}
      ,{136,'parolemindays'}
      ,{137,'parolestatus'}
      ,{138,'paroleofficer'}
      ,{139,'paroleoffcerphone'}
      ,{140,'probationbegindate'}
      ,{141,'probationenddate'}
      ,{142,'probationmaxyears'}
      ,{143,'probationmaxmonths'}
      ,{144,'probationmaxdays'}
      ,{145,'probationminyears'}
      ,{146,'probationminmonths'}
      ,{147,'probationmindays'}
      ,{148,'probationstatus'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_Fields.InValid_recordid((SALT311.StrType)le.recordid),
    raw_Fields.InValid_sourcename((SALT311.StrType)le.sourcename),
    raw_Fields.InValid_sourcetype((SALT311.StrType)le.sourcetype),
    raw_Fields.InValid_statecode((SALT311.StrType)le.statecode),
    raw_Fields.InValid_recordtype((SALT311.StrType)le.recordtype),
    raw_Fields.InValid_recorduploaddate((SALT311.StrType)le.recorduploaddate),
    raw_Fields.InValid_docnumber((SALT311.StrType)le.docnumber),
    raw_Fields.InValid_fbinumber((SALT311.StrType)le.fbinumber),
    raw_Fields.InValid_stateidnumber((SALT311.StrType)le.stateidnumber),
    raw_Fields.InValid_inmatenumber((SALT311.StrType)le.inmatenumber),
    raw_Fields.InValid_aliennumber((SALT311.StrType)le.aliennumber),
    raw_Fields.InValid_orig_ssn((SALT311.StrType)le.orig_ssn),
    raw_Fields.InValid_nametype((SALT311.StrType)le.nametype),
    raw_Fields.InValid_name((SALT311.StrType)le.name),
    raw_Fields.InValid_lastname((SALT311.StrType)le.lastname),
    raw_Fields.InValid_firstname((SALT311.StrType)le.firstname),
    raw_Fields.InValid_middlename((SALT311.StrType)le.middlename),
    raw_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    raw_Fields.InValid_defendantstatus((SALT311.StrType)le.defendantstatus),
    raw_Fields.InValid_defendantadditionalinfo((SALT311.StrType)le.defendantadditionalinfo),
    raw_Fields.InValid_dob((SALT311.StrType)le.dob),
    raw_Fields.InValid_birthcity((SALT311.StrType)le.birthcity),
    raw_Fields.InValid_birthplace((SALT311.StrType)le.birthplace),
    raw_Fields.InValid_age((SALT311.StrType)le.age),
    raw_Fields.InValid_gender((SALT311.StrType)le.gender),
    raw_Fields.InValid_height((SALT311.StrType)le.height),
    raw_Fields.InValid_weight((SALT311.StrType)le.weight),
    raw_Fields.InValid_haircolor((SALT311.StrType)le.haircolor),
    raw_Fields.InValid_eyecolor((SALT311.StrType)le.eyecolor),
    raw_Fields.InValid_race((SALT311.StrType)le.race),
    raw_Fields.InValid_ethnicity((SALT311.StrType)le.ethnicity),
    raw_Fields.InValid_skincolor((SALT311.StrType)le.skincolor),
    raw_Fields.InValid_bodymarks((SALT311.StrType)le.bodymarks),
    raw_Fields.InValid_physicalbuild((SALT311.StrType)le.physicalbuild),
    raw_Fields.InValid_photoname((SALT311.StrType)le.photoname),
    raw_Fields.InValid_dlnumber((SALT311.StrType)le.dlnumber),
    raw_Fields.InValid_dlstate((SALT311.StrType)le.dlstate),
    raw_Fields.InValid_phone((SALT311.StrType)le.phone),
    raw_Fields.InValid_phonetype((SALT311.StrType)le.phonetype),
    raw_Fields.InValid_uscitizenflag((SALT311.StrType)le.uscitizenflag),
    raw_Fields.InValid_addresstype((SALT311.StrType)le.addresstype),
    raw_Fields.InValid_street((SALT311.StrType)le.street),
    raw_Fields.InValid_unit((SALT311.StrType)le.unit),
    raw_Fields.InValid_city((SALT311.StrType)le.city),
    raw_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    raw_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    raw_Fields.InValid_county((SALT311.StrType)le.county),
    raw_Fields.InValid_institutionname((SALT311.StrType)le.institutionname),
    raw_Fields.InValid_institutiondetails((SALT311.StrType)le.institutiondetails),
    raw_Fields.InValid_institutionreceiptdate((SALT311.StrType)le.institutionreceiptdate),
    raw_Fields.InValid_releasetolocation((SALT311.StrType)le.releasetolocation),
    raw_Fields.InValid_releasetodetails((SALT311.StrType)le.releasetodetails),
    raw_Fields.InValid_deceasedflag((SALT311.StrType)le.deceasedflag),
    raw_Fields.InValid_deceaseddate((SALT311.StrType)le.deceaseddate),
    raw_Fields.InValid_healthflag((SALT311.StrType)le.healthflag),
    raw_Fields.InValid_healthdesc((SALT311.StrType)le.healthdesc),
    raw_Fields.InValid_bloodtype((SALT311.StrType)le.bloodtype),
    raw_Fields.InValid_sexoffenderregistrydate((SALT311.StrType)le.sexoffenderregistrydate),
    raw_Fields.InValid_sexoffenderregexpirationdate((SALT311.StrType)le.sexoffenderregexpirationdate),
    raw_Fields.InValid_sexoffenderregistrynumber((SALT311.StrType)le.sexoffenderregistrynumber),
    raw_Fields.InValid_sourceid((SALT311.StrType)le.sourceid),
    raw_Fields.InValid_caseid((SALT311.StrType)le.caseid),
    raw_Fields.InValid_casenumber((SALT311.StrType)le.casenumber),
    raw_Fields.InValid_casetitle((SALT311.StrType)le.casetitle),
    raw_Fields.InValid_casetype((SALT311.StrType)le.casetype),
    raw_Fields.InValid_casestatus((SALT311.StrType)le.casestatus),
    raw_Fields.InValid_casestatusdate((SALT311.StrType)le.casestatusdate),
    raw_Fields.InValid_casecomments((SALT311.StrType)le.casecomments),
    raw_Fields.InValid_fileddate((SALT311.StrType)le.fileddate),
    raw_Fields.InValid_caseinfo((SALT311.StrType)le.caseinfo),
    raw_Fields.InValid_docketnumber((SALT311.StrType)le.docketnumber),
    raw_Fields.InValid_offensecode((SALT311.StrType)le.offensecode),
    raw_Fields.InValid_offensedesc((SALT311.StrType)le.offensedesc),
    raw_Fields.InValid_offensedate((SALT311.StrType)le.offensedate),
    raw_Fields.InValid_offensetype((SALT311.StrType)le.offensetype),
    raw_Fields.InValid_offensedegree((SALT311.StrType)le.offensedegree),
    raw_Fields.InValid_offenseclass((SALT311.StrType)le.offenseclass),
    raw_Fields.InValid_dispositionstatus((SALT311.StrType)le.dispositionstatus),
    raw_Fields.InValid_dispositionstatusdate((SALT311.StrType)le.dispositionstatusdate),
    raw_Fields.InValid_disposition((SALT311.StrType)le.disposition),
    raw_Fields.InValid_dispositiondate((SALT311.StrType)le.dispositiondate),
    raw_Fields.InValid_offenselocation((SALT311.StrType)le.offenselocation),
    raw_Fields.InValid_finaloffense((SALT311.StrType)le.finaloffense),
    raw_Fields.InValid_finaloffensedate((SALT311.StrType)le.finaloffensedate),
    raw_Fields.InValid_offensecount((SALT311.StrType)le.offensecount),
    raw_Fields.InValid_victimunder18((SALT311.StrType)le.victimunder18),
    raw_Fields.InValid_prioroffenseflag((SALT311.StrType)le.prioroffenseflag),
    raw_Fields.InValid_initialplea((SALT311.StrType)le.initialplea),
    raw_Fields.InValid_initialpleadate((SALT311.StrType)le.initialpleadate),
    raw_Fields.InValid_finalruling((SALT311.StrType)le.finalruling),
    raw_Fields.InValid_finalrulingdate((SALT311.StrType)le.finalrulingdate),
    raw_Fields.InValid_appealstatus((SALT311.StrType)le.appealstatus),
    raw_Fields.InValid_appealdate((SALT311.StrType)le.appealdate),
    raw_Fields.InValid_courtname((SALT311.StrType)le.courtname),
    raw_Fields.InValid_fineamount((SALT311.StrType)le.fineamount),
    raw_Fields.InValid_courtfee((SALT311.StrType)le.courtfee),
    raw_Fields.InValid_restitution((SALT311.StrType)le.restitution),
    raw_Fields.InValid_trialtype((SALT311.StrType)le.trialtype),
    raw_Fields.InValid_courtdate((SALT311.StrType)le.courtdate),
    raw_Fields.InValid_classification_code((SALT311.StrType)le.classification_code),
    raw_Fields.InValid_sub_classification_code((SALT311.StrType)le.sub_classification_code),
    raw_Fields.InValid_state((SALT311.StrType)le.state),
    raw_Fields.InValid_zip((SALT311.StrType)le.zip),
    raw_Fields.InValid_sourceid2((SALT311.StrType)le.sourceid2),
    raw_Fields.InValid_sentencedate((SALT311.StrType)le.sentencedate),
    raw_Fields.InValid_sentencebegindate((SALT311.StrType)le.sentencebegindate),
    raw_Fields.InValid_sentenceenddate((SALT311.StrType)le.sentenceenddate),
    raw_Fields.InValid_sentencetype((SALT311.StrType)le.sentencetype),
    raw_Fields.InValid_sentencemaxyears((SALT311.StrType)le.sentencemaxyears),
    raw_Fields.InValid_sentencemaxmonths((SALT311.StrType)le.sentencemaxmonths),
    raw_Fields.InValid_sentencemaxdays((SALT311.StrType)le.sentencemaxdays),
    raw_Fields.InValid_sentenceminyears((SALT311.StrType)le.sentenceminyears),
    raw_Fields.InValid_sentenceminmonths((SALT311.StrType)le.sentenceminmonths),
    raw_Fields.InValid_sentencemindays((SALT311.StrType)le.sentencemindays),
    raw_Fields.InValid_scheduledreleasedate((SALT311.StrType)le.scheduledreleasedate),
    raw_Fields.InValid_actualreleasedate((SALT311.StrType)le.actualreleasedate),
    raw_Fields.InValid_sentencestatus((SALT311.StrType)le.sentencestatus),
    raw_Fields.InValid_timeservedyears((SALT311.StrType)le.timeservedyears),
    raw_Fields.InValid_timeservedmonths((SALT311.StrType)le.timeservedmonths),
    raw_Fields.InValid_timeserveddays((SALT311.StrType)le.timeserveddays),
    raw_Fields.InValid_publicservicehours((SALT311.StrType)le.publicservicehours),
    raw_Fields.InValid_sentenceadditionalinfo((SALT311.StrType)le.sentenceadditionalinfo),
    raw_Fields.InValid_communitysupervisioncounty((SALT311.StrType)le.communitysupervisioncounty),
    raw_Fields.InValid_communitysupervisionyears((SALT311.StrType)le.communitysupervisionyears),
    raw_Fields.InValid_communitysupervisionmonths((SALT311.StrType)le.communitysupervisionmonths),
    raw_Fields.InValid_communitysupervisiondays((SALT311.StrType)le.communitysupervisiondays),
    raw_Fields.InValid_parolebegindate((SALT311.StrType)le.parolebegindate),
    raw_Fields.InValid_paroleenddate((SALT311.StrType)le.paroleenddate),
    raw_Fields.InValid_paroleeligibilitydate((SALT311.StrType)le.paroleeligibilitydate),
    raw_Fields.InValid_parolehearingdate((SALT311.StrType)le.parolehearingdate),
    raw_Fields.InValid_parolemaxyears((SALT311.StrType)le.parolemaxyears),
    raw_Fields.InValid_parolemaxmonths((SALT311.StrType)le.parolemaxmonths),
    raw_Fields.InValid_parolemaxdays((SALT311.StrType)le.parolemaxdays),
    raw_Fields.InValid_paroleminyears((SALT311.StrType)le.paroleminyears),
    raw_Fields.InValid_paroleminmonths((SALT311.StrType)le.paroleminmonths),
    raw_Fields.InValid_parolemindays((SALT311.StrType)le.parolemindays),
    raw_Fields.InValid_parolestatus((SALT311.StrType)le.parolestatus),
    raw_Fields.InValid_paroleofficer((SALT311.StrType)le.paroleofficer),
    raw_Fields.InValid_paroleoffcerphone((SALT311.StrType)le.paroleoffcerphone),
    raw_Fields.InValid_probationbegindate((SALT311.StrType)le.probationbegindate),
    raw_Fields.InValid_probationenddate((SALT311.StrType)le.probationenddate),
    raw_Fields.InValid_probationmaxyears((SALT311.StrType)le.probationmaxyears),
    raw_Fields.InValid_probationmaxmonths((SALT311.StrType)le.probationmaxmonths),
    raw_Fields.InValid_probationmaxdays((SALT311.StrType)le.probationmaxdays),
    raw_Fields.InValid_probationminyears((SALT311.StrType)le.probationminyears),
    raw_Fields.InValid_probationminmonths((SALT311.StrType)le.probationminmonths),
    raw_Fields.InValid_probationmindays((SALT311.StrType)le.probationmindays),
    raw_Fields.InValid_probationstatus((SALT311.StrType)le.probationstatus),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,148,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_orig_name','invalid_orig_parsed_name','invalid_orig_parsed_name','invalid_orig_parsed_name','invalid_orig_parsed_name','Unknown','Unknown','invalid_number','Unknown','Unknown','invalid_number','invalid_alpha','Unknown','Unknown','Unknown','Unknown','invalid_race','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sourcetype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),raw_Fields.InValidMessage_recordtype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_recorduploaddate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_docnumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_fbinumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_stateidnumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_inmatenumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_aliennumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),raw_Fields.InValidMessage_nametype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_name(TotalErrors.ErrorNum),raw_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_middlename(TotalErrors.ErrorNum),raw_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),raw_Fields.InValidMessage_defendantstatus(TotalErrors.ErrorNum),raw_Fields.InValidMessage_defendantadditionalinfo(TotalErrors.ErrorNum),raw_Fields.InValidMessage_dob(TotalErrors.ErrorNum),raw_Fields.InValidMessage_birthcity(TotalErrors.ErrorNum),raw_Fields.InValidMessage_birthplace(TotalErrors.ErrorNum),raw_Fields.InValidMessage_age(TotalErrors.ErrorNum),raw_Fields.InValidMessage_gender(TotalErrors.ErrorNum),raw_Fields.InValidMessage_height(TotalErrors.ErrorNum),raw_Fields.InValidMessage_weight(TotalErrors.ErrorNum),raw_Fields.InValidMessage_haircolor(TotalErrors.ErrorNum),raw_Fields.InValidMessage_eyecolor(TotalErrors.ErrorNum),raw_Fields.InValidMessage_race(TotalErrors.ErrorNum),raw_Fields.InValidMessage_ethnicity(TotalErrors.ErrorNum),raw_Fields.InValidMessage_skincolor(TotalErrors.ErrorNum),raw_Fields.InValidMessage_bodymarks(TotalErrors.ErrorNum),raw_Fields.InValidMessage_physicalbuild(TotalErrors.ErrorNum),raw_Fields.InValidMessage_photoname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_dlnumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_dlstate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_phone(TotalErrors.ErrorNum),raw_Fields.InValidMessage_phonetype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_uscitizenflag(TotalErrors.ErrorNum),raw_Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_street(TotalErrors.ErrorNum),raw_Fields.InValidMessage_unit(TotalErrors.ErrorNum),raw_Fields.InValidMessage_city(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),raw_Fields.InValidMessage_county(TotalErrors.ErrorNum),raw_Fields.InValidMessage_institutionname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_institutiondetails(TotalErrors.ErrorNum),raw_Fields.InValidMessage_institutionreceiptdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_releasetolocation(TotalErrors.ErrorNum),raw_Fields.InValidMessage_releasetodetails(TotalErrors.ErrorNum),raw_Fields.InValidMessage_deceasedflag(TotalErrors.ErrorNum),raw_Fields.InValidMessage_deceaseddate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_healthflag(TotalErrors.ErrorNum),raw_Fields.InValidMessage_healthdesc(TotalErrors.ErrorNum),raw_Fields.InValidMessage_bloodtype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sexoffenderregistrydate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sexoffenderregexpirationdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sexoffenderregistrynumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sourceid(TotalErrors.ErrorNum),raw_Fields.InValidMessage_caseid(TotalErrors.ErrorNum),raw_Fields.InValidMessage_casenumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_casetitle(TotalErrors.ErrorNum),raw_Fields.InValidMessage_casetype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_casestatus(TotalErrors.ErrorNum),raw_Fields.InValidMessage_casestatusdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_casecomments(TotalErrors.ErrorNum),raw_Fields.InValidMessage_fileddate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_caseinfo(TotalErrors.ErrorNum),raw_Fields.InValidMessage_docketnumber(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offensecode(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offensedesc(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offensedate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offensetype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offensedegree(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offenseclass(TotalErrors.ErrorNum),raw_Fields.InValidMessage_dispositionstatus(TotalErrors.ErrorNum),raw_Fields.InValidMessage_dispositionstatusdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_disposition(TotalErrors.ErrorNum),raw_Fields.InValidMessage_dispositiondate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offenselocation(TotalErrors.ErrorNum),raw_Fields.InValidMessage_finaloffense(TotalErrors.ErrorNum),raw_Fields.InValidMessage_finaloffensedate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_offensecount(TotalErrors.ErrorNum),raw_Fields.InValidMessage_victimunder18(TotalErrors.ErrorNum),raw_Fields.InValidMessage_prioroffenseflag(TotalErrors.ErrorNum),raw_Fields.InValidMessage_initialplea(TotalErrors.ErrorNum),raw_Fields.InValidMessage_initialpleadate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_finalruling(TotalErrors.ErrorNum),raw_Fields.InValidMessage_finalrulingdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_appealstatus(TotalErrors.ErrorNum),raw_Fields.InValidMessage_appealdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_courtname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_fineamount(TotalErrors.ErrorNum),raw_Fields.InValidMessage_courtfee(TotalErrors.ErrorNum),raw_Fields.InValidMessage_restitution(TotalErrors.ErrorNum),raw_Fields.InValidMessage_trialtype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_courtdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_classification_code(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sub_classification_code(TotalErrors.ErrorNum),raw_Fields.InValidMessage_state(TotalErrors.ErrorNum),raw_Fields.InValidMessage_zip(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sourceid2(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencedate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencebegindate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentenceenddate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencetype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencemaxyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencemaxmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencemaxdays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentenceminyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentenceminmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencemindays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_scheduledreleasedate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_actualreleasedate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentencestatus(TotalErrors.ErrorNum),raw_Fields.InValidMessage_timeservedyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_timeservedmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_timeserveddays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_publicservicehours(TotalErrors.ErrorNum),raw_Fields.InValidMessage_sentenceadditionalinfo(TotalErrors.ErrorNum),raw_Fields.InValidMessage_communitysupervisioncounty(TotalErrors.ErrorNum),raw_Fields.InValidMessage_communitysupervisionyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_communitysupervisionmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_communitysupervisiondays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolebegindate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_paroleenddate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_paroleeligibilitydate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolehearingdate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolemaxyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolemaxmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolemaxdays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_paroleminyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_paroleminmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolemindays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_parolestatus(TotalErrors.ErrorNum),raw_Fields.InValidMessage_paroleofficer(TotalErrors.ErrorNum),raw_Fields.InValidMessage_paroleoffcerphone(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationbegindate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationenddate(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationmaxyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationmaxmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationmaxdays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationminyears(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationminmonths(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationmindays(TotalErrors.ErrorNum),raw_Fields.InValidMessage_probationstatus(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(scrubs_Fed_Bureau_Prisons, raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
