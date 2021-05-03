IMPORT SALT311,STD;
EXPORT Contacts_hygiene(dataset(Contacts_layout_Sheila_Greco) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_raw_aid_cnt := COUNT(GROUP,h.raw_aid <> (TYPEOF(h.raw_aid))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_rawfields_maincontactid_cnt := COUNT(GROUP,h.rawfields_maincontactid <> (TYPEOF(h.rawfields_maincontactid))'');
    populated_rawfields_maincontactid_pcnt := AVE(GROUP,IF(h.rawfields_maincontactid = (TYPEOF(h.rawfields_maincontactid))'',0,100));
    maxlength_rawfields_maincontactid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_maincontactid)));
    avelength_rawfields_maincontactid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_maincontactid)),h.rawfields_maincontactid<>(typeof(h.rawfields_maincontactid))'');
    populated_rawfields_maincompanyid_cnt := COUNT(GROUP,h.rawfields_maincompanyid <> (TYPEOF(h.rawfields_maincompanyid))'');
    populated_rawfields_maincompanyid_pcnt := AVE(GROUP,IF(h.rawfields_maincompanyid = (TYPEOF(h.rawfields_maincompanyid))'',0,100));
    maxlength_rawfields_maincompanyid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_maincompanyid)));
    avelength_rawfields_maincompanyid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_maincompanyid)),h.rawfields_maincompanyid<>(typeof(h.rawfields_maincompanyid))'');
    populated_rawfields_active_cnt := COUNT(GROUP,h.rawfields_active <> (TYPEOF(h.rawfields_active))'');
    populated_rawfields_active_pcnt := AVE(GROUP,IF(h.rawfields_active = (TYPEOF(h.rawfields_active))'',0,100));
    maxlength_rawfields_active := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_active)));
    avelength_rawfields_active := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_active)),h.rawfields_active<>(typeof(h.rawfields_active))'');
    populated_rawfields_firstname_cnt := COUNT(GROUP,h.rawfields_firstname <> (TYPEOF(h.rawfields_firstname))'');
    populated_rawfields_firstname_pcnt := AVE(GROUP,IF(h.rawfields_firstname = (TYPEOF(h.rawfields_firstname))'',0,100));
    maxlength_rawfields_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_firstname)));
    avelength_rawfields_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_firstname)),h.rawfields_firstname<>(typeof(h.rawfields_firstname))'');
    populated_rawfields_midinital_cnt := COUNT(GROUP,h.rawfields_midinital <> (TYPEOF(h.rawfields_midinital))'');
    populated_rawfields_midinital_pcnt := AVE(GROUP,IF(h.rawfields_midinital = (TYPEOF(h.rawfields_midinital))'',0,100));
    maxlength_rawfields_midinital := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_midinital)));
    avelength_rawfields_midinital := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_midinital)),h.rawfields_midinital<>(typeof(h.rawfields_midinital))'');
    populated_rawfields_lastname_cnt := COUNT(GROUP,h.rawfields_lastname <> (TYPEOF(h.rawfields_lastname))'');
    populated_rawfields_lastname_pcnt := AVE(GROUP,IF(h.rawfields_lastname = (TYPEOF(h.rawfields_lastname))'',0,100));
    maxlength_rawfields_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_lastname)));
    avelength_rawfields_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_lastname)),h.rawfields_lastname<>(typeof(h.rawfields_lastname))'');
    populated_rawfields_age_cnt := COUNT(GROUP,h.rawfields_age <> (TYPEOF(h.rawfields_age))'');
    populated_rawfields_age_pcnt := AVE(GROUP,IF(h.rawfields_age = (TYPEOF(h.rawfields_age))'',0,100));
    maxlength_rawfields_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_age)));
    avelength_rawfields_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_age)),h.rawfields_age<>(typeof(h.rawfields_age))'');
    populated_rawfields_gender_cnt := COUNT(GROUP,h.rawfields_gender <> (TYPEOF(h.rawfields_gender))'');
    populated_rawfields_gender_pcnt := AVE(GROUP,IF(h.rawfields_gender = (TYPEOF(h.rawfields_gender))'',0,100));
    maxlength_rawfields_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_gender)));
    avelength_rawfields_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_gender)),h.rawfields_gender<>(typeof(h.rawfields_gender))'');
    populated_rawfields_primarytitle_cnt := COUNT(GROUP,h.rawfields_primarytitle <> (TYPEOF(h.rawfields_primarytitle))'');
    populated_rawfields_primarytitle_pcnt := AVE(GROUP,IF(h.rawfields_primarytitle = (TYPEOF(h.rawfields_primarytitle))'',0,100));
    maxlength_rawfields_primarytitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_primarytitle)));
    avelength_rawfields_primarytitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_primarytitle)),h.rawfields_primarytitle<>(typeof(h.rawfields_primarytitle))'');
    populated_rawfields_titlelevel1_cnt := COUNT(GROUP,h.rawfields_titlelevel1 <> (TYPEOF(h.rawfields_titlelevel1))'');
    populated_rawfields_titlelevel1_pcnt := AVE(GROUP,IF(h.rawfields_titlelevel1 = (TYPEOF(h.rawfields_titlelevel1))'',0,100));
    maxlength_rawfields_titlelevel1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_titlelevel1)));
    avelength_rawfields_titlelevel1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_titlelevel1)),h.rawfields_titlelevel1<>(typeof(h.rawfields_titlelevel1))'');
    populated_rawfields_primarydept_cnt := COUNT(GROUP,h.rawfields_primarydept <> (TYPEOF(h.rawfields_primarydept))'');
    populated_rawfields_primarydept_pcnt := AVE(GROUP,IF(h.rawfields_primarydept = (TYPEOF(h.rawfields_primarydept))'',0,100));
    maxlength_rawfields_primarydept := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_primarydept)));
    avelength_rawfields_primarydept := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_primarydept)),h.rawfields_primarydept<>(typeof(h.rawfields_primarydept))'');
    populated_rawfields_secondtitle_cnt := COUNT(GROUP,h.rawfields_secondtitle <> (TYPEOF(h.rawfields_secondtitle))'');
    populated_rawfields_secondtitle_pcnt := AVE(GROUP,IF(h.rawfields_secondtitle = (TYPEOF(h.rawfields_secondtitle))'',0,100));
    maxlength_rawfields_secondtitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_secondtitle)));
    avelength_rawfields_secondtitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_secondtitle)),h.rawfields_secondtitle<>(typeof(h.rawfields_secondtitle))'');
    populated_rawfields_titlelevel2_cnt := COUNT(GROUP,h.rawfields_titlelevel2 <> (TYPEOF(h.rawfields_titlelevel2))'');
    populated_rawfields_titlelevel2_pcnt := AVE(GROUP,IF(h.rawfields_titlelevel2 = (TYPEOF(h.rawfields_titlelevel2))'',0,100));
    maxlength_rawfields_titlelevel2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_titlelevel2)));
    avelength_rawfields_titlelevel2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_titlelevel2)),h.rawfields_titlelevel2<>(typeof(h.rawfields_titlelevel2))'');
    populated_rawfields_seconddept_cnt := COUNT(GROUP,h.rawfields_seconddept <> (TYPEOF(h.rawfields_seconddept))'');
    populated_rawfields_seconddept_pcnt := AVE(GROUP,IF(h.rawfields_seconddept = (TYPEOF(h.rawfields_seconddept))'',0,100));
    maxlength_rawfields_seconddept := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_seconddept)));
    avelength_rawfields_seconddept := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_seconddept)),h.rawfields_seconddept<>(typeof(h.rawfields_seconddept))'');
    populated_rawfields_thirdtitle_cnt := COUNT(GROUP,h.rawfields_thirdtitle <> (TYPEOF(h.rawfields_thirdtitle))'');
    populated_rawfields_thirdtitle_pcnt := AVE(GROUP,IF(h.rawfields_thirdtitle = (TYPEOF(h.rawfields_thirdtitle))'',0,100));
    maxlength_rawfields_thirdtitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_thirdtitle)));
    avelength_rawfields_thirdtitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_thirdtitle)),h.rawfields_thirdtitle<>(typeof(h.rawfields_thirdtitle))'');
    populated_rawfields_titlelevel3_cnt := COUNT(GROUP,h.rawfields_titlelevel3 <> (TYPEOF(h.rawfields_titlelevel3))'');
    populated_rawfields_titlelevel3_pcnt := AVE(GROUP,IF(h.rawfields_titlelevel3 = (TYPEOF(h.rawfields_titlelevel3))'',0,100));
    maxlength_rawfields_titlelevel3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_titlelevel3)));
    avelength_rawfields_titlelevel3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_titlelevel3)),h.rawfields_titlelevel3<>(typeof(h.rawfields_titlelevel3))'');
    populated_rawfields_thirddept_cnt := COUNT(GROUP,h.rawfields_thirddept <> (TYPEOF(h.rawfields_thirddept))'');
    populated_rawfields_thirddept_pcnt := AVE(GROUP,IF(h.rawfields_thirddept = (TYPEOF(h.rawfields_thirddept))'',0,100));
    maxlength_rawfields_thirddept := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_thirddept)));
    avelength_rawfields_thirddept := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_thirddept)),h.rawfields_thirddept<>(typeof(h.rawfields_thirddept))'');
    populated_rawfields_skillcategory_cnt := COUNT(GROUP,h.rawfields_skillcategory <> (TYPEOF(h.rawfields_skillcategory))'');
    populated_rawfields_skillcategory_pcnt := AVE(GROUP,IF(h.rawfields_skillcategory = (TYPEOF(h.rawfields_skillcategory))'',0,100));
    maxlength_rawfields_skillcategory := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_skillcategory)));
    avelength_rawfields_skillcategory := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_skillcategory)),h.rawfields_skillcategory<>(typeof(h.rawfields_skillcategory))'');
    populated_rawfields_skillsubcategory_cnt := COUNT(GROUP,h.rawfields_skillsubcategory <> (TYPEOF(h.rawfields_skillsubcategory))'');
    populated_rawfields_skillsubcategory_pcnt := AVE(GROUP,IF(h.rawfields_skillsubcategory = (TYPEOF(h.rawfields_skillsubcategory))'',0,100));
    maxlength_rawfields_skillsubcategory := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_skillsubcategory)));
    avelength_rawfields_skillsubcategory := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_skillsubcategory)),h.rawfields_skillsubcategory<>(typeof(h.rawfields_skillsubcategory))'');
    populated_rawfields_reportto_cnt := COUNT(GROUP,h.rawfields_reportto <> (TYPEOF(h.rawfields_reportto))'');
    populated_rawfields_reportto_pcnt := AVE(GROUP,IF(h.rawfields_reportto = (TYPEOF(h.rawfields_reportto))'',0,100));
    maxlength_rawfields_reportto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_reportto)));
    avelength_rawfields_reportto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_reportto)),h.rawfields_reportto<>(typeof(h.rawfields_reportto))'');
    populated_rawfields_officephone_cnt := COUNT(GROUP,h.rawfields_officephone <> (TYPEOF(h.rawfields_officephone))'');
    populated_rawfields_officephone_pcnt := AVE(GROUP,IF(h.rawfields_officephone = (TYPEOF(h.rawfields_officephone))'',0,100));
    maxlength_rawfields_officephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officephone)));
    avelength_rawfields_officephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officephone)),h.rawfields_officephone<>(typeof(h.rawfields_officephone))'');
    populated_rawfields_officeext_cnt := COUNT(GROUP,h.rawfields_officeext <> (TYPEOF(h.rawfields_officeext))'');
    populated_rawfields_officeext_pcnt := AVE(GROUP,IF(h.rawfields_officeext = (TYPEOF(h.rawfields_officeext))'',0,100));
    maxlength_rawfields_officeext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeext)));
    avelength_rawfields_officeext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeext)),h.rawfields_officeext<>(typeof(h.rawfields_officeext))'');
    populated_rawfields_officefax_cnt := COUNT(GROUP,h.rawfields_officefax <> (TYPEOF(h.rawfields_officefax))'');
    populated_rawfields_officefax_pcnt := AVE(GROUP,IF(h.rawfields_officefax = (TYPEOF(h.rawfields_officefax))'',0,100));
    maxlength_rawfields_officefax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officefax)));
    avelength_rawfields_officefax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officefax)),h.rawfields_officefax<>(typeof(h.rawfields_officefax))'');
    populated_rawfields_officeemail_cnt := COUNT(GROUP,h.rawfields_officeemail <> (TYPEOF(h.rawfields_officeemail))'');
    populated_rawfields_officeemail_pcnt := AVE(GROUP,IF(h.rawfields_officeemail = (TYPEOF(h.rawfields_officeemail))'',0,100));
    maxlength_rawfields_officeemail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeemail)));
    avelength_rawfields_officeemail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeemail)),h.rawfields_officeemail<>(typeof(h.rawfields_officeemail))'');
    populated_rawfields_directdial_cnt := COUNT(GROUP,h.rawfields_directdial <> (TYPEOF(h.rawfields_directdial))'');
    populated_rawfields_directdial_pcnt := AVE(GROUP,IF(h.rawfields_directdial = (TYPEOF(h.rawfields_directdial))'',0,100));
    maxlength_rawfields_directdial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_directdial)));
    avelength_rawfields_directdial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_directdial)),h.rawfields_directdial<>(typeof(h.rawfields_directdial))'');
    populated_rawfields_mobilephone_cnt := COUNT(GROUP,h.rawfields_mobilephone <> (TYPEOF(h.rawfields_mobilephone))'');
    populated_rawfields_mobilephone_pcnt := AVE(GROUP,IF(h.rawfields_mobilephone = (TYPEOF(h.rawfields_mobilephone))'',0,100));
    maxlength_rawfields_mobilephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_mobilephone)));
    avelength_rawfields_mobilephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_mobilephone)),h.rawfields_mobilephone<>(typeof(h.rawfields_mobilephone))'');
    populated_rawfields_officeaddress1_cnt := COUNT(GROUP,h.rawfields_officeaddress1 <> (TYPEOF(h.rawfields_officeaddress1))'');
    populated_rawfields_officeaddress1_pcnt := AVE(GROUP,IF(h.rawfields_officeaddress1 = (TYPEOF(h.rawfields_officeaddress1))'',0,100));
    maxlength_rawfields_officeaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeaddress1)));
    avelength_rawfields_officeaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeaddress1)),h.rawfields_officeaddress1<>(typeof(h.rawfields_officeaddress1))'');
    populated_rawfields_officeaddress2_cnt := COUNT(GROUP,h.rawfields_officeaddress2 <> (TYPEOF(h.rawfields_officeaddress2))'');
    populated_rawfields_officeaddress2_pcnt := AVE(GROUP,IF(h.rawfields_officeaddress2 = (TYPEOF(h.rawfields_officeaddress2))'',0,100));
    maxlength_rawfields_officeaddress2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeaddress2)));
    avelength_rawfields_officeaddress2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officeaddress2)),h.rawfields_officeaddress2<>(typeof(h.rawfields_officeaddress2))'');
    populated_rawfields_officecity_cnt := COUNT(GROUP,h.rawfields_officecity <> (TYPEOF(h.rawfields_officecity))'');
    populated_rawfields_officecity_pcnt := AVE(GROUP,IF(h.rawfields_officecity = (TYPEOF(h.rawfields_officecity))'',0,100));
    maxlength_rawfields_officecity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officecity)));
    avelength_rawfields_officecity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officecity)),h.rawfields_officecity<>(typeof(h.rawfields_officecity))'');
    populated_rawfields_officestate_cnt := COUNT(GROUP,h.rawfields_officestate <> (TYPEOF(h.rawfields_officestate))'');
    populated_rawfields_officestate_pcnt := AVE(GROUP,IF(h.rawfields_officestate = (TYPEOF(h.rawfields_officestate))'',0,100));
    maxlength_rawfields_officestate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officestate)));
    avelength_rawfields_officestate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officestate)),h.rawfields_officestate<>(typeof(h.rawfields_officestate))'');
    populated_rawfields_officezip_cnt := COUNT(GROUP,h.rawfields_officezip <> (TYPEOF(h.rawfields_officezip))'');
    populated_rawfields_officezip_pcnt := AVE(GROUP,IF(h.rawfields_officezip = (TYPEOF(h.rawfields_officezip))'',0,100));
    maxlength_rawfields_officezip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officezip)));
    avelength_rawfields_officezip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officezip)),h.rawfields_officezip<>(typeof(h.rawfields_officezip))'');
    populated_rawfields_officecountry_cnt := COUNT(GROUP,h.rawfields_officecountry <> (TYPEOF(h.rawfields_officecountry))'');
    populated_rawfields_officecountry_pcnt := AVE(GROUP,IF(h.rawfields_officecountry = (TYPEOF(h.rawfields_officecountry))'',0,100));
    maxlength_rawfields_officecountry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officecountry)));
    avelength_rawfields_officecountry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_officecountry)),h.rawfields_officecountry<>(typeof(h.rawfields_officecountry))'');
    populated_rawfields_school_cnt := COUNT(GROUP,h.rawfields_school <> (TYPEOF(h.rawfields_school))'');
    populated_rawfields_school_pcnt := AVE(GROUP,IF(h.rawfields_school = (TYPEOF(h.rawfields_school))'',0,100));
    maxlength_rawfields_school := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_school)));
    avelength_rawfields_school := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_school)),h.rawfields_school<>(typeof(h.rawfields_school))'');
    populated_rawfields_degree_cnt := COUNT(GROUP,h.rawfields_degree <> (TYPEOF(h.rawfields_degree))'');
    populated_rawfields_degree_pcnt := AVE(GROUP,IF(h.rawfields_degree = (TYPEOF(h.rawfields_degree))'',0,100));
    maxlength_rawfields_degree := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_degree)));
    avelength_rawfields_degree := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_degree)),h.rawfields_degree<>(typeof(h.rawfields_degree))'');
    populated_rawfields_graduationyear_cnt := COUNT(GROUP,h.rawfields_graduationyear <> (TYPEOF(h.rawfields_graduationyear))'');
    populated_rawfields_graduationyear_pcnt := AVE(GROUP,IF(h.rawfields_graduationyear = (TYPEOF(h.rawfields_graduationyear))'',0,100));
    maxlength_rawfields_graduationyear := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_graduationyear)));
    avelength_rawfields_graduationyear := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_graduationyear)),h.rawfields_graduationyear<>(typeof(h.rawfields_graduationyear))'');
    populated_rawfields_country_cnt := COUNT(GROUP,h.rawfields_country <> (TYPEOF(h.rawfields_country))'');
    populated_rawfields_country_pcnt := AVE(GROUP,IF(h.rawfields_country = (TYPEOF(h.rawfields_country))'',0,100));
    maxlength_rawfields_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_country)));
    avelength_rawfields_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_country)),h.rawfields_country<>(typeof(h.rawfields_country))'');
    populated_rawfields_salary_cnt := COUNT(GROUP,h.rawfields_salary <> (TYPEOF(h.rawfields_salary))'');
    populated_rawfields_salary_pcnt := AVE(GROUP,IF(h.rawfields_salary = (TYPEOF(h.rawfields_salary))'',0,100));
    maxlength_rawfields_salary := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_salary)));
    avelength_rawfields_salary := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_salary)),h.rawfields_salary<>(typeof(h.rawfields_salary))'');
    populated_rawfields_bonus_cnt := COUNT(GROUP,h.rawfields_bonus <> (TYPEOF(h.rawfields_bonus))'');
    populated_rawfields_bonus_pcnt := AVE(GROUP,IF(h.rawfields_bonus = (TYPEOF(h.rawfields_bonus))'',0,100));
    maxlength_rawfields_bonus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_bonus)));
    avelength_rawfields_bonus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_bonus)),h.rawfields_bonus<>(typeof(h.rawfields_bonus))'');
    populated_rawfields_compensation_cnt := COUNT(GROUP,h.rawfields_compensation <> (TYPEOF(h.rawfields_compensation))'');
    populated_rawfields_compensation_pcnt := AVE(GROUP,IF(h.rawfields_compensation = (TYPEOF(h.rawfields_compensation))'',0,100));
    maxlength_rawfields_compensation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_compensation)));
    avelength_rawfields_compensation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_compensation)),h.rawfields_compensation<>(typeof(h.rawfields_compensation))'');
    populated_rawfields_citizenship_cnt := COUNT(GROUP,h.rawfields_citizenship <> (TYPEOF(h.rawfields_citizenship))'');
    populated_rawfields_citizenship_pcnt := AVE(GROUP,IF(h.rawfields_citizenship = (TYPEOF(h.rawfields_citizenship))'',0,100));
    maxlength_rawfields_citizenship := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_citizenship)));
    avelength_rawfields_citizenship := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_citizenship)),h.rawfields_citizenship<>(typeof(h.rawfields_citizenship))'');
    populated_rawfields_diversitycandidate_cnt := COUNT(GROUP,h.rawfields_diversitycandidate <> (TYPEOF(h.rawfields_diversitycandidate))'');
    populated_rawfields_diversitycandidate_pcnt := AVE(GROUP,IF(h.rawfields_diversitycandidate = (TYPEOF(h.rawfields_diversitycandidate))'',0,100));
    maxlength_rawfields_diversitycandidate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_diversitycandidate)));
    avelength_rawfields_diversitycandidate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_diversitycandidate)),h.rawfields_diversitycandidate<>(typeof(h.rawfields_diversitycandidate))'');
    populated_rawfields_entrydate_cnt := COUNT(GROUP,h.rawfields_entrydate <> (TYPEOF(h.rawfields_entrydate))'');
    populated_rawfields_entrydate_pcnt := AVE(GROUP,IF(h.rawfields_entrydate = (TYPEOF(h.rawfields_entrydate))'',0,100));
    maxlength_rawfields_entrydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_entrydate)));
    avelength_rawfields_entrydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_entrydate)),h.rawfields_entrydate<>(typeof(h.rawfields_entrydate))'');
    populated_rawfields_lastupdate_cnt := COUNT(GROUP,h.rawfields_lastupdate <> (TYPEOF(h.rawfields_lastupdate))'');
    populated_rawfields_lastupdate_pcnt := AVE(GROUP,IF(h.rawfields_lastupdate = (TYPEOF(h.rawfields_lastupdate))'',0,100));
    maxlength_rawfields_lastupdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_lastupdate)));
    avelength_rawfields_lastupdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawfields_lastupdate)),h.rawfields_lastupdate<>(typeof(h.rawfields_lastupdate))'');
    populated_clean_contact_name_title_cnt := COUNT(GROUP,h.clean_contact_name_title <> (TYPEOF(h.clean_contact_name_title))'');
    populated_clean_contact_name_title_pcnt := AVE(GROUP,IF(h.clean_contact_name_title = (TYPEOF(h.clean_contact_name_title))'',0,100));
    maxlength_clean_contact_name_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_title)));
    avelength_clean_contact_name_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_title)),h.clean_contact_name_title<>(typeof(h.clean_contact_name_title))'');
    populated_clean_contact_name_fname_cnt := COUNT(GROUP,h.clean_contact_name_fname <> (TYPEOF(h.clean_contact_name_fname))'');
    populated_clean_contact_name_fname_pcnt := AVE(GROUP,IF(h.clean_contact_name_fname = (TYPEOF(h.clean_contact_name_fname))'',0,100));
    maxlength_clean_contact_name_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_fname)));
    avelength_clean_contact_name_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_fname)),h.clean_contact_name_fname<>(typeof(h.clean_contact_name_fname))'');
    populated_clean_contact_name_mname_cnt := COUNT(GROUP,h.clean_contact_name_mname <> (TYPEOF(h.clean_contact_name_mname))'');
    populated_clean_contact_name_mname_pcnt := AVE(GROUP,IF(h.clean_contact_name_mname = (TYPEOF(h.clean_contact_name_mname))'',0,100));
    maxlength_clean_contact_name_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_mname)));
    avelength_clean_contact_name_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_mname)),h.clean_contact_name_mname<>(typeof(h.clean_contact_name_mname))'');
    populated_clean_contact_name_lname_cnt := COUNT(GROUP,h.clean_contact_name_lname <> (TYPEOF(h.clean_contact_name_lname))'');
    populated_clean_contact_name_lname_pcnt := AVE(GROUP,IF(h.clean_contact_name_lname = (TYPEOF(h.clean_contact_name_lname))'',0,100));
    maxlength_clean_contact_name_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_lname)));
    avelength_clean_contact_name_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_lname)),h.clean_contact_name_lname<>(typeof(h.clean_contact_name_lname))'');
    populated_clean_contact_name_name_suffix_cnt := COUNT(GROUP,h.clean_contact_name_name_suffix <> (TYPEOF(h.clean_contact_name_name_suffix))'');
    populated_clean_contact_name_name_suffix_pcnt := AVE(GROUP,IF(h.clean_contact_name_name_suffix = (TYPEOF(h.clean_contact_name_name_suffix))'',0,100));
    maxlength_clean_contact_name_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_name_suffix)));
    avelength_clean_contact_name_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_name_suffix)),h.clean_contact_name_name_suffix<>(typeof(h.clean_contact_name_name_suffix))'');
    populated_clean_contact_name_name_score_cnt := COUNT(GROUP,h.clean_contact_name_name_score <> (TYPEOF(h.clean_contact_name_name_score))'');
    populated_clean_contact_name_name_score_pcnt := AVE(GROUP,IF(h.clean_contact_name_name_score = (TYPEOF(h.clean_contact_name_name_score))'',0,100));
    maxlength_clean_contact_name_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_name_score)));
    avelength_clean_contact_name_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_name_name_score)),h.clean_contact_name_name_score<>(typeof(h.clean_contact_name_name_score))'');
    populated_clean_contact_address_prim_range_cnt := COUNT(GROUP,h.clean_contact_address_prim_range <> (TYPEOF(h.clean_contact_address_prim_range))'');
    populated_clean_contact_address_prim_range_pcnt := AVE(GROUP,IF(h.clean_contact_address_prim_range = (TYPEOF(h.clean_contact_address_prim_range))'',0,100));
    maxlength_clean_contact_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_prim_range)));
    avelength_clean_contact_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_prim_range)),h.clean_contact_address_prim_range<>(typeof(h.clean_contact_address_prim_range))'');
    populated_clean_contact_address_predir_cnt := COUNT(GROUP,h.clean_contact_address_predir <> (TYPEOF(h.clean_contact_address_predir))'');
    populated_clean_contact_address_predir_pcnt := AVE(GROUP,IF(h.clean_contact_address_predir = (TYPEOF(h.clean_contact_address_predir))'',0,100));
    maxlength_clean_contact_address_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_predir)));
    avelength_clean_contact_address_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_predir)),h.clean_contact_address_predir<>(typeof(h.clean_contact_address_predir))'');
    populated_clean_contact_address_prim_name_cnt := COUNT(GROUP,h.clean_contact_address_prim_name <> (TYPEOF(h.clean_contact_address_prim_name))'');
    populated_clean_contact_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_contact_address_prim_name = (TYPEOF(h.clean_contact_address_prim_name))'',0,100));
    maxlength_clean_contact_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_prim_name)));
    avelength_clean_contact_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_prim_name)),h.clean_contact_address_prim_name<>(typeof(h.clean_contact_address_prim_name))'');
    populated_clean_contact_address_addr_suffix_cnt := COUNT(GROUP,h.clean_contact_address_addr_suffix <> (TYPEOF(h.clean_contact_address_addr_suffix))'');
    populated_clean_contact_address_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_contact_address_addr_suffix = (TYPEOF(h.clean_contact_address_addr_suffix))'',0,100));
    maxlength_clean_contact_address_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_addr_suffix)));
    avelength_clean_contact_address_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_addr_suffix)),h.clean_contact_address_addr_suffix<>(typeof(h.clean_contact_address_addr_suffix))'');
    populated_clean_contact_address_postdir_cnt := COUNT(GROUP,h.clean_contact_address_postdir <> (TYPEOF(h.clean_contact_address_postdir))'');
    populated_clean_contact_address_postdir_pcnt := AVE(GROUP,IF(h.clean_contact_address_postdir = (TYPEOF(h.clean_contact_address_postdir))'',0,100));
    maxlength_clean_contact_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_postdir)));
    avelength_clean_contact_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_postdir)),h.clean_contact_address_postdir<>(typeof(h.clean_contact_address_postdir))'');
    populated_clean_contact_address_unit_desig_cnt := COUNT(GROUP,h.clean_contact_address_unit_desig <> (TYPEOF(h.clean_contact_address_unit_desig))'');
    populated_clean_contact_address_unit_desig_pcnt := AVE(GROUP,IF(h.clean_contact_address_unit_desig = (TYPEOF(h.clean_contact_address_unit_desig))'',0,100));
    maxlength_clean_contact_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_unit_desig)));
    avelength_clean_contact_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_unit_desig)),h.clean_contact_address_unit_desig<>(typeof(h.clean_contact_address_unit_desig))'');
    populated_clean_contact_address_sec_range_cnt := COUNT(GROUP,h.clean_contact_address_sec_range <> (TYPEOF(h.clean_contact_address_sec_range))'');
    populated_clean_contact_address_sec_range_pcnt := AVE(GROUP,IF(h.clean_contact_address_sec_range = (TYPEOF(h.clean_contact_address_sec_range))'',0,100));
    maxlength_clean_contact_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_sec_range)));
    avelength_clean_contact_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_sec_range)),h.clean_contact_address_sec_range<>(typeof(h.clean_contact_address_sec_range))'');
    populated_clean_contact_address_p_city_name_cnt := COUNT(GROUP,h.clean_contact_address_p_city_name <> (TYPEOF(h.clean_contact_address_p_city_name))'');
    populated_clean_contact_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_contact_address_p_city_name = (TYPEOF(h.clean_contact_address_p_city_name))'',0,100));
    maxlength_clean_contact_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_p_city_name)));
    avelength_clean_contact_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_p_city_name)),h.clean_contact_address_p_city_name<>(typeof(h.clean_contact_address_p_city_name))'');
    populated_clean_contact_address_v_city_name_cnt := COUNT(GROUP,h.clean_contact_address_v_city_name <> (TYPEOF(h.clean_contact_address_v_city_name))'');
    populated_clean_contact_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_contact_address_v_city_name = (TYPEOF(h.clean_contact_address_v_city_name))'',0,100));
    maxlength_clean_contact_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_v_city_name)));
    avelength_clean_contact_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_v_city_name)),h.clean_contact_address_v_city_name<>(typeof(h.clean_contact_address_v_city_name))'');
    populated_clean_contact_address_st_cnt := COUNT(GROUP,h.clean_contact_address_st <> (TYPEOF(h.clean_contact_address_st))'');
    populated_clean_contact_address_st_pcnt := AVE(GROUP,IF(h.clean_contact_address_st = (TYPEOF(h.clean_contact_address_st))'',0,100));
    maxlength_clean_contact_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_st)));
    avelength_clean_contact_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_st)),h.clean_contact_address_st<>(typeof(h.clean_contact_address_st))'');
    populated_clean_contact_address_zip_cnt := COUNT(GROUP,h.clean_contact_address_zip <> (TYPEOF(h.clean_contact_address_zip))'');
    populated_clean_contact_address_zip_pcnt := AVE(GROUP,IF(h.clean_contact_address_zip = (TYPEOF(h.clean_contact_address_zip))'',0,100));
    maxlength_clean_contact_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_zip)));
    avelength_clean_contact_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_zip)),h.clean_contact_address_zip<>(typeof(h.clean_contact_address_zip))'');
    populated_clean_contact_address_zip4_cnt := COUNT(GROUP,h.clean_contact_address_zip4 <> (TYPEOF(h.clean_contact_address_zip4))'');
    populated_clean_contact_address_zip4_pcnt := AVE(GROUP,IF(h.clean_contact_address_zip4 = (TYPEOF(h.clean_contact_address_zip4))'',0,100));
    maxlength_clean_contact_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_zip4)));
    avelength_clean_contact_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_zip4)),h.clean_contact_address_zip4<>(typeof(h.clean_contact_address_zip4))'');
    populated_clean_contact_address_cart_cnt := COUNT(GROUP,h.clean_contact_address_cart <> (TYPEOF(h.clean_contact_address_cart))'');
    populated_clean_contact_address_cart_pcnt := AVE(GROUP,IF(h.clean_contact_address_cart = (TYPEOF(h.clean_contact_address_cart))'',0,100));
    maxlength_clean_contact_address_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_cart)));
    avelength_clean_contact_address_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_cart)),h.clean_contact_address_cart<>(typeof(h.clean_contact_address_cart))'');
    populated_clean_contact_address_cr_sort_sz_cnt := COUNT(GROUP,h.clean_contact_address_cr_sort_sz <> (TYPEOF(h.clean_contact_address_cr_sort_sz))'');
    populated_clean_contact_address_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_contact_address_cr_sort_sz = (TYPEOF(h.clean_contact_address_cr_sort_sz))'',0,100));
    maxlength_clean_contact_address_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_cr_sort_sz)));
    avelength_clean_contact_address_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_cr_sort_sz)),h.clean_contact_address_cr_sort_sz<>(typeof(h.clean_contact_address_cr_sort_sz))'');
    populated_clean_contact_address_lot_cnt := COUNT(GROUP,h.clean_contact_address_lot <> (TYPEOF(h.clean_contact_address_lot))'');
    populated_clean_contact_address_lot_pcnt := AVE(GROUP,IF(h.clean_contact_address_lot = (TYPEOF(h.clean_contact_address_lot))'',0,100));
    maxlength_clean_contact_address_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_lot)));
    avelength_clean_contact_address_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_lot)),h.clean_contact_address_lot<>(typeof(h.clean_contact_address_lot))'');
    populated_clean_contact_address_lot_order_cnt := COUNT(GROUP,h.clean_contact_address_lot_order <> (TYPEOF(h.clean_contact_address_lot_order))'');
    populated_clean_contact_address_lot_order_pcnt := AVE(GROUP,IF(h.clean_contact_address_lot_order = (TYPEOF(h.clean_contact_address_lot_order))'',0,100));
    maxlength_clean_contact_address_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_lot_order)));
    avelength_clean_contact_address_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_lot_order)),h.clean_contact_address_lot_order<>(typeof(h.clean_contact_address_lot_order))'');
    populated_clean_contact_address_dbpc_cnt := COUNT(GROUP,h.clean_contact_address_dbpc <> (TYPEOF(h.clean_contact_address_dbpc))'');
    populated_clean_contact_address_dbpc_pcnt := AVE(GROUP,IF(h.clean_contact_address_dbpc = (TYPEOF(h.clean_contact_address_dbpc))'',0,100));
    maxlength_clean_contact_address_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_dbpc)));
    avelength_clean_contact_address_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_dbpc)),h.clean_contact_address_dbpc<>(typeof(h.clean_contact_address_dbpc))'');
    populated_clean_contact_address_chk_digit_cnt := COUNT(GROUP,h.clean_contact_address_chk_digit <> (TYPEOF(h.clean_contact_address_chk_digit))'');
    populated_clean_contact_address_chk_digit_pcnt := AVE(GROUP,IF(h.clean_contact_address_chk_digit = (TYPEOF(h.clean_contact_address_chk_digit))'',0,100));
    maxlength_clean_contact_address_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_chk_digit)));
    avelength_clean_contact_address_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_chk_digit)),h.clean_contact_address_chk_digit<>(typeof(h.clean_contact_address_chk_digit))'');
    populated_clean_contact_address_rec_type_cnt := COUNT(GROUP,h.clean_contact_address_rec_type <> (TYPEOF(h.clean_contact_address_rec_type))'');
    populated_clean_contact_address_rec_type_pcnt := AVE(GROUP,IF(h.clean_contact_address_rec_type = (TYPEOF(h.clean_contact_address_rec_type))'',0,100));
    maxlength_clean_contact_address_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_rec_type)));
    avelength_clean_contact_address_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_rec_type)),h.clean_contact_address_rec_type<>(typeof(h.clean_contact_address_rec_type))'');
    populated_clean_contact_address_fips_state_cnt := COUNT(GROUP,h.clean_contact_address_fips_state <> (TYPEOF(h.clean_contact_address_fips_state))'');
    populated_clean_contact_address_fips_state_pcnt := AVE(GROUP,IF(h.clean_contact_address_fips_state = (TYPEOF(h.clean_contact_address_fips_state))'',0,100));
    maxlength_clean_contact_address_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_fips_state)));
    avelength_clean_contact_address_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_fips_state)),h.clean_contact_address_fips_state<>(typeof(h.clean_contact_address_fips_state))'');
    populated_clean_contact_address_fips_county_cnt := COUNT(GROUP,h.clean_contact_address_fips_county <> (TYPEOF(h.clean_contact_address_fips_county))'');
    populated_clean_contact_address_fips_county_pcnt := AVE(GROUP,IF(h.clean_contact_address_fips_county = (TYPEOF(h.clean_contact_address_fips_county))'',0,100));
    maxlength_clean_contact_address_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_fips_county)));
    avelength_clean_contact_address_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_fips_county)),h.clean_contact_address_fips_county<>(typeof(h.clean_contact_address_fips_county))'');
    populated_clean_contact_address_geo_lat_cnt := COUNT(GROUP,h.clean_contact_address_geo_lat <> (TYPEOF(h.clean_contact_address_geo_lat))'');
    populated_clean_contact_address_geo_lat_pcnt := AVE(GROUP,IF(h.clean_contact_address_geo_lat = (TYPEOF(h.clean_contact_address_geo_lat))'',0,100));
    maxlength_clean_contact_address_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_lat)));
    avelength_clean_contact_address_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_lat)),h.clean_contact_address_geo_lat<>(typeof(h.clean_contact_address_geo_lat))'');
    populated_clean_contact_address_geo_long_cnt := COUNT(GROUP,h.clean_contact_address_geo_long <> (TYPEOF(h.clean_contact_address_geo_long))'');
    populated_clean_contact_address_geo_long_pcnt := AVE(GROUP,IF(h.clean_contact_address_geo_long = (TYPEOF(h.clean_contact_address_geo_long))'',0,100));
    maxlength_clean_contact_address_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_long)));
    avelength_clean_contact_address_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_long)),h.clean_contact_address_geo_long<>(typeof(h.clean_contact_address_geo_long))'');
    populated_clean_contact_address_msa_cnt := COUNT(GROUP,h.clean_contact_address_msa <> (TYPEOF(h.clean_contact_address_msa))'');
    populated_clean_contact_address_msa_pcnt := AVE(GROUP,IF(h.clean_contact_address_msa = (TYPEOF(h.clean_contact_address_msa))'',0,100));
    maxlength_clean_contact_address_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_msa)));
    avelength_clean_contact_address_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_msa)),h.clean_contact_address_msa<>(typeof(h.clean_contact_address_msa))'');
    populated_clean_contact_address_geo_blk_cnt := COUNT(GROUP,h.clean_contact_address_geo_blk <> (TYPEOF(h.clean_contact_address_geo_blk))'');
    populated_clean_contact_address_geo_blk_pcnt := AVE(GROUP,IF(h.clean_contact_address_geo_blk = (TYPEOF(h.clean_contact_address_geo_blk))'',0,100));
    maxlength_clean_contact_address_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_blk)));
    avelength_clean_contact_address_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_blk)),h.clean_contact_address_geo_blk<>(typeof(h.clean_contact_address_geo_blk))'');
    populated_clean_contact_address_geo_match_cnt := COUNT(GROUP,h.clean_contact_address_geo_match <> (TYPEOF(h.clean_contact_address_geo_match))'');
    populated_clean_contact_address_geo_match_pcnt := AVE(GROUP,IF(h.clean_contact_address_geo_match = (TYPEOF(h.clean_contact_address_geo_match))'',0,100));
    maxlength_clean_contact_address_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_match)));
    avelength_clean_contact_address_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_geo_match)),h.clean_contact_address_geo_match<>(typeof(h.clean_contact_address_geo_match))'');
    populated_clean_contact_address_err_stat_cnt := COUNT(GROUP,h.clean_contact_address_err_stat <> (TYPEOF(h.clean_contact_address_err_stat))'');
    populated_clean_contact_address_err_stat_pcnt := AVE(GROUP,IF(h.clean_contact_address_err_stat = (TYPEOF(h.clean_contact_address_err_stat))'',0,100));
    maxlength_clean_contact_address_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_err_stat)));
    avelength_clean_contact_address_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_contact_address_err_stat)),h.clean_contact_address_err_stat<>(typeof(h.clean_contact_address_err_stat))'');
    populated_clean_dates_entrydate_cnt := COUNT(GROUP,h.clean_dates_entrydate <> (TYPEOF(h.clean_dates_entrydate))'');
    populated_clean_dates_entrydate_pcnt := AVE(GROUP,IF(h.clean_dates_entrydate = (TYPEOF(h.clean_dates_entrydate))'',0,100));
    maxlength_clean_dates_entrydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_entrydate)));
    avelength_clean_dates_entrydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_entrydate)),h.clean_dates_entrydate<>(typeof(h.clean_dates_entrydate))'');
    populated_clean_dates_lastupdate_cnt := COUNT(GROUP,h.clean_dates_lastupdate <> (TYPEOF(h.clean_dates_lastupdate))'');
    populated_clean_dates_lastupdate_pcnt := AVE(GROUP,IF(h.clean_dates_lastupdate = (TYPEOF(h.clean_dates_lastupdate))'',0,100));
    maxlength_clean_dates_lastupdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_lastupdate)));
    avelength_clean_dates_lastupdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dates_lastupdate)),h.clean_dates_lastupdate<>(typeof(h.clean_dates_lastupdate))'');
    populated_clean_phones_officephone_cnt := COUNT(GROUP,h.clean_phones_officephone <> (TYPEOF(h.clean_phones_officephone))'');
    populated_clean_phones_officephone_pcnt := AVE(GROUP,IF(h.clean_phones_officephone = (TYPEOF(h.clean_phones_officephone))'',0,100));
    maxlength_clean_phones_officephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_officephone)));
    avelength_clean_phones_officephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_officephone)),h.clean_phones_officephone<>(typeof(h.clean_phones_officephone))'');
    populated_clean_phones_directdial_cnt := COUNT(GROUP,h.clean_phones_directdial <> (TYPEOF(h.clean_phones_directdial))'');
    populated_clean_phones_directdial_pcnt := AVE(GROUP,IF(h.clean_phones_directdial = (TYPEOF(h.clean_phones_directdial))'',0,100));
    maxlength_clean_phones_directdial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_directdial)));
    avelength_clean_phones_directdial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_directdial)),h.clean_phones_directdial<>(typeof(h.clean_phones_directdial))'');
    populated_clean_phones_mobilephone_cnt := COUNT(GROUP,h.clean_phones_mobilephone <> (TYPEOF(h.clean_phones_mobilephone))'');
    populated_clean_phones_mobilephone_pcnt := AVE(GROUP,IF(h.clean_phones_mobilephone = (TYPEOF(h.clean_phones_mobilephone))'',0,100));
    maxlength_clean_phones_mobilephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_mobilephone)));
    avelength_clean_phones_mobilephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phones_mobilephone)),h.clean_phones_mobilephone<>(typeof(h.clean_phones_mobilephone))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_rawfields_maincontactid_pcnt *   0.00 / 100 + T.Populated_rawfields_maincompanyid_pcnt *   0.00 / 100 + T.Populated_rawfields_active_pcnt *   0.00 / 100 + T.Populated_rawfields_firstname_pcnt *   0.00 / 100 + T.Populated_rawfields_midinital_pcnt *   0.00 / 100 + T.Populated_rawfields_lastname_pcnt *   0.00 / 100 + T.Populated_rawfields_age_pcnt *   0.00 / 100 + T.Populated_rawfields_gender_pcnt *   0.00 / 100 + T.Populated_rawfields_primarytitle_pcnt *   0.00 / 100 + T.Populated_rawfields_titlelevel1_pcnt *   0.00 / 100 + T.Populated_rawfields_primarydept_pcnt *   0.00 / 100 + T.Populated_rawfields_secondtitle_pcnt *   0.00 / 100 + T.Populated_rawfields_titlelevel2_pcnt *   0.00 / 100 + T.Populated_rawfields_seconddept_pcnt *   0.00 / 100 + T.Populated_rawfields_thirdtitle_pcnt *   0.00 / 100 + T.Populated_rawfields_titlelevel3_pcnt *   0.00 / 100 + T.Populated_rawfields_thirddept_pcnt *   0.00 / 100 + T.Populated_rawfields_skillcategory_pcnt *   0.00 / 100 + T.Populated_rawfields_skillsubcategory_pcnt *   0.00 / 100 + T.Populated_rawfields_reportto_pcnt *   0.00 / 100 + T.Populated_rawfields_officephone_pcnt *   0.00 / 100 + T.Populated_rawfields_officeext_pcnt *   0.00 / 100 + T.Populated_rawfields_officefax_pcnt *   0.00 / 100 + T.Populated_rawfields_officeemail_pcnt *   0.00 / 100 + T.Populated_rawfields_directdial_pcnt *   0.00 / 100 + T.Populated_rawfields_mobilephone_pcnt *   0.00 / 100 + T.Populated_rawfields_officeaddress1_pcnt *   0.00 / 100 + T.Populated_rawfields_officeaddress2_pcnt *   0.00 / 100 + T.Populated_rawfields_officecity_pcnt *   0.00 / 100 + T.Populated_rawfields_officestate_pcnt *   0.00 / 100 + T.Populated_rawfields_officezip_pcnt *   0.00 / 100 + T.Populated_rawfields_officecountry_pcnt *   0.00 / 100 + T.Populated_rawfields_school_pcnt *   0.00 / 100 + T.Populated_rawfields_degree_pcnt *   0.00 / 100 + T.Populated_rawfields_graduationyear_pcnt *   0.00 / 100 + T.Populated_rawfields_country_pcnt *   0.00 / 100 + T.Populated_rawfields_salary_pcnt *   0.00 / 100 + T.Populated_rawfields_bonus_pcnt *   0.00 / 100 + T.Populated_rawfields_compensation_pcnt *   0.00 / 100 + T.Populated_rawfields_citizenship_pcnt *   0.00 / 100 + T.Populated_rawfields_diversitycandidate_pcnt *   0.00 / 100 + T.Populated_rawfields_entrydate_pcnt *   0.00 / 100 + T.Populated_rawfields_lastupdate_pcnt *   0.00 / 100 + T.Populated_clean_contact_name_title_pcnt *   0.00 / 100 + T.Populated_clean_contact_name_fname_pcnt *   0.00 / 100 + T.Populated_clean_contact_name_mname_pcnt *   0.00 / 100 + T.Populated_clean_contact_name_lname_pcnt *   0.00 / 100 + T.Populated_clean_contact_name_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_contact_name_name_score_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_predir_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_postdir_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_st_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_zip4_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_cart_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_lot_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_dbpc_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_fips_state_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_fips_county_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_msa_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_contact_address_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_dates_entrydate_pcnt *   0.00 / 100 + T.Populated_clean_dates_lastupdate_pcnt *   0.00 / 100 + T.Populated_clean_phones_officephone_pcnt *   0.00 / 100 + T.Populated_clean_phones_directdial_pcnt *   0.00 / 100 + T.Populated_clean_phones_mobilephone_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'did','did_score','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincontactid','rawfields_maincompanyid','rawfields_active','rawfields_firstname','rawfields_midinital','rawfields_lastname','rawfields_age','rawfields_gender','rawfields_primarytitle','rawfields_titlelevel1','rawfields_primarydept','rawfields_secondtitle','rawfields_titlelevel2','rawfields_seconddept','rawfields_thirdtitle','rawfields_titlelevel3','rawfields_thirddept','rawfields_skillcategory','rawfields_skillsubcategory','rawfields_reportto','rawfields_officephone','rawfields_officeext','rawfields_officefax','rawfields_officeemail','rawfields_directdial','rawfields_mobilephone','rawfields_officeaddress1','rawfields_officeaddress2','rawfields_officecity','rawfields_officestate','rawfields_officezip','rawfields_officecountry','rawfields_school','rawfields_degree','rawfields_graduationyear','rawfields_country','rawfields_salary','rawfields_bonus','rawfields_compensation','rawfields_citizenship','rawfields_diversitycandidate','rawfields_entrydate','rawfields_lastupdate','clean_contact_name_title','clean_contact_name_fname','clean_contact_name_mname','clean_contact_name_lname','clean_contact_name_name_suffix','clean_contact_name_name_score','clean_contact_address_prim_range','clean_contact_address_predir','clean_contact_address_prim_name','clean_contact_address_addr_suffix','clean_contact_address_postdir','clean_contact_address_unit_desig','clean_contact_address_sec_range','clean_contact_address_p_city_name','clean_contact_address_v_city_name','clean_contact_address_st','clean_contact_address_zip','clean_contact_address_zip4','clean_contact_address_cart','clean_contact_address_cr_sort_sz','clean_contact_address_lot','clean_contact_address_lot_order','clean_contact_address_dbpc','clean_contact_address_chk_digit','clean_contact_address_rec_type','clean_contact_address_fips_state','clean_contact_address_fips_county','clean_contact_address_geo_lat','clean_contact_address_geo_long','clean_contact_address_msa','clean_contact_address_geo_blk','clean_contact_address_geo_match','clean_contact_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_officephone','clean_phones_directdial','clean_phones_mobilephone','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_rawfields_maincontactid_pcnt,le.populated_rawfields_maincompanyid_pcnt,le.populated_rawfields_active_pcnt,le.populated_rawfields_firstname_pcnt,le.populated_rawfields_midinital_pcnt,le.populated_rawfields_lastname_pcnt,le.populated_rawfields_age_pcnt,le.populated_rawfields_gender_pcnt,le.populated_rawfields_primarytitle_pcnt,le.populated_rawfields_titlelevel1_pcnt,le.populated_rawfields_primarydept_pcnt,le.populated_rawfields_secondtitle_pcnt,le.populated_rawfields_titlelevel2_pcnt,le.populated_rawfields_seconddept_pcnt,le.populated_rawfields_thirdtitle_pcnt,le.populated_rawfields_titlelevel3_pcnt,le.populated_rawfields_thirddept_pcnt,le.populated_rawfields_skillcategory_pcnt,le.populated_rawfields_skillsubcategory_pcnt,le.populated_rawfields_reportto_pcnt,le.populated_rawfields_officephone_pcnt,le.populated_rawfields_officeext_pcnt,le.populated_rawfields_officefax_pcnt,le.populated_rawfields_officeemail_pcnt,le.populated_rawfields_directdial_pcnt,le.populated_rawfields_mobilephone_pcnt,le.populated_rawfields_officeaddress1_pcnt,le.populated_rawfields_officeaddress2_pcnt,le.populated_rawfields_officecity_pcnt,le.populated_rawfields_officestate_pcnt,le.populated_rawfields_officezip_pcnt,le.populated_rawfields_officecountry_pcnt,le.populated_rawfields_school_pcnt,le.populated_rawfields_degree_pcnt,le.populated_rawfields_graduationyear_pcnt,le.populated_rawfields_country_pcnt,le.populated_rawfields_salary_pcnt,le.populated_rawfields_bonus_pcnt,le.populated_rawfields_compensation_pcnt,le.populated_rawfields_citizenship_pcnt,le.populated_rawfields_diversitycandidate_pcnt,le.populated_rawfields_entrydate_pcnt,le.populated_rawfields_lastupdate_pcnt,le.populated_clean_contact_name_title_pcnt,le.populated_clean_contact_name_fname_pcnt,le.populated_clean_contact_name_mname_pcnt,le.populated_clean_contact_name_lname_pcnt,le.populated_clean_contact_name_name_suffix_pcnt,le.populated_clean_contact_name_name_score_pcnt,le.populated_clean_contact_address_prim_range_pcnt,le.populated_clean_contact_address_predir_pcnt,le.populated_clean_contact_address_prim_name_pcnt,le.populated_clean_contact_address_addr_suffix_pcnt,le.populated_clean_contact_address_postdir_pcnt,le.populated_clean_contact_address_unit_desig_pcnt,le.populated_clean_contact_address_sec_range_pcnt,le.populated_clean_contact_address_p_city_name_pcnt,le.populated_clean_contact_address_v_city_name_pcnt,le.populated_clean_contact_address_st_pcnt,le.populated_clean_contact_address_zip_pcnt,le.populated_clean_contact_address_zip4_pcnt,le.populated_clean_contact_address_cart_pcnt,le.populated_clean_contact_address_cr_sort_sz_pcnt,le.populated_clean_contact_address_lot_pcnt,le.populated_clean_contact_address_lot_order_pcnt,le.populated_clean_contact_address_dbpc_pcnt,le.populated_clean_contact_address_chk_digit_pcnt,le.populated_clean_contact_address_rec_type_pcnt,le.populated_clean_contact_address_fips_state_pcnt,le.populated_clean_contact_address_fips_county_pcnt,le.populated_clean_contact_address_geo_lat_pcnt,le.populated_clean_contact_address_geo_long_pcnt,le.populated_clean_contact_address_msa_pcnt,le.populated_clean_contact_address_geo_blk_pcnt,le.populated_clean_contact_address_geo_match_pcnt,le.populated_clean_contact_address_err_stat_pcnt,le.populated_clean_dates_entrydate_pcnt,le.populated_clean_dates_lastupdate_pcnt,le.populated_clean_phones_officephone_pcnt,le.populated_clean_phones_directdial_pcnt,le.populated_clean_phones_mobilephone_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_rawfields_maincontactid,le.maxlength_rawfields_maincompanyid,le.maxlength_rawfields_active,le.maxlength_rawfields_firstname,le.maxlength_rawfields_midinital,le.maxlength_rawfields_lastname,le.maxlength_rawfields_age,le.maxlength_rawfields_gender,le.maxlength_rawfields_primarytitle,le.maxlength_rawfields_titlelevel1,le.maxlength_rawfields_primarydept,le.maxlength_rawfields_secondtitle,le.maxlength_rawfields_titlelevel2,le.maxlength_rawfields_seconddept,le.maxlength_rawfields_thirdtitle,le.maxlength_rawfields_titlelevel3,le.maxlength_rawfields_thirddept,le.maxlength_rawfields_skillcategory,le.maxlength_rawfields_skillsubcategory,le.maxlength_rawfields_reportto,le.maxlength_rawfields_officephone,le.maxlength_rawfields_officeext,le.maxlength_rawfields_officefax,le.maxlength_rawfields_officeemail,le.maxlength_rawfields_directdial,le.maxlength_rawfields_mobilephone,le.maxlength_rawfields_officeaddress1,le.maxlength_rawfields_officeaddress2,le.maxlength_rawfields_officecity,le.maxlength_rawfields_officestate,le.maxlength_rawfields_officezip,le.maxlength_rawfields_officecountry,le.maxlength_rawfields_school,le.maxlength_rawfields_degree,le.maxlength_rawfields_graduationyear,le.maxlength_rawfields_country,le.maxlength_rawfields_salary,le.maxlength_rawfields_bonus,le.maxlength_rawfields_compensation,le.maxlength_rawfields_citizenship,le.maxlength_rawfields_diversitycandidate,le.maxlength_rawfields_entrydate,le.maxlength_rawfields_lastupdate,le.maxlength_clean_contact_name_title,le.maxlength_clean_contact_name_fname,le.maxlength_clean_contact_name_mname,le.maxlength_clean_contact_name_lname,le.maxlength_clean_contact_name_name_suffix,le.maxlength_clean_contact_name_name_score,le.maxlength_clean_contact_address_prim_range,le.maxlength_clean_contact_address_predir,le.maxlength_clean_contact_address_prim_name,le.maxlength_clean_contact_address_addr_suffix,le.maxlength_clean_contact_address_postdir,le.maxlength_clean_contact_address_unit_desig,le.maxlength_clean_contact_address_sec_range,le.maxlength_clean_contact_address_p_city_name,le.maxlength_clean_contact_address_v_city_name,le.maxlength_clean_contact_address_st,le.maxlength_clean_contact_address_zip,le.maxlength_clean_contact_address_zip4,le.maxlength_clean_contact_address_cart,le.maxlength_clean_contact_address_cr_sort_sz,le.maxlength_clean_contact_address_lot,le.maxlength_clean_contact_address_lot_order,le.maxlength_clean_contact_address_dbpc,le.maxlength_clean_contact_address_chk_digit,le.maxlength_clean_contact_address_rec_type,le.maxlength_clean_contact_address_fips_state,le.maxlength_clean_contact_address_fips_county,le.maxlength_clean_contact_address_geo_lat,le.maxlength_clean_contact_address_geo_long,le.maxlength_clean_contact_address_msa,le.maxlength_clean_contact_address_geo_blk,le.maxlength_clean_contact_address_geo_match,le.maxlength_clean_contact_address_err_stat,le.maxlength_clean_dates_entrydate,le.maxlength_clean_dates_lastupdate,le.maxlength_clean_phones_officephone,le.maxlength_clean_phones_directdial,le.maxlength_clean_phones_mobilephone,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_rawfields_maincontactid,le.avelength_rawfields_maincompanyid,le.avelength_rawfields_active,le.avelength_rawfields_firstname,le.avelength_rawfields_midinital,le.avelength_rawfields_lastname,le.avelength_rawfields_age,le.avelength_rawfields_gender,le.avelength_rawfields_primarytitle,le.avelength_rawfields_titlelevel1,le.avelength_rawfields_primarydept,le.avelength_rawfields_secondtitle,le.avelength_rawfields_titlelevel2,le.avelength_rawfields_seconddept,le.avelength_rawfields_thirdtitle,le.avelength_rawfields_titlelevel3,le.avelength_rawfields_thirddept,le.avelength_rawfields_skillcategory,le.avelength_rawfields_skillsubcategory,le.avelength_rawfields_reportto,le.avelength_rawfields_officephone,le.avelength_rawfields_officeext,le.avelength_rawfields_officefax,le.avelength_rawfields_officeemail,le.avelength_rawfields_directdial,le.avelength_rawfields_mobilephone,le.avelength_rawfields_officeaddress1,le.avelength_rawfields_officeaddress2,le.avelength_rawfields_officecity,le.avelength_rawfields_officestate,le.avelength_rawfields_officezip,le.avelength_rawfields_officecountry,le.avelength_rawfields_school,le.avelength_rawfields_degree,le.avelength_rawfields_graduationyear,le.avelength_rawfields_country,le.avelength_rawfields_salary,le.avelength_rawfields_bonus,le.avelength_rawfields_compensation,le.avelength_rawfields_citizenship,le.avelength_rawfields_diversitycandidate,le.avelength_rawfields_entrydate,le.avelength_rawfields_lastupdate,le.avelength_clean_contact_name_title,le.avelength_clean_contact_name_fname,le.avelength_clean_contact_name_mname,le.avelength_clean_contact_name_lname,le.avelength_clean_contact_name_name_suffix,le.avelength_clean_contact_name_name_score,le.avelength_clean_contact_address_prim_range,le.avelength_clean_contact_address_predir,le.avelength_clean_contact_address_prim_name,le.avelength_clean_contact_address_addr_suffix,le.avelength_clean_contact_address_postdir,le.avelength_clean_contact_address_unit_desig,le.avelength_clean_contact_address_sec_range,le.avelength_clean_contact_address_p_city_name,le.avelength_clean_contact_address_v_city_name,le.avelength_clean_contact_address_st,le.avelength_clean_contact_address_zip,le.avelength_clean_contact_address_zip4,le.avelength_clean_contact_address_cart,le.avelength_clean_contact_address_cr_sort_sz,le.avelength_clean_contact_address_lot,le.avelength_clean_contact_address_lot_order,le.avelength_clean_contact_address_dbpc,le.avelength_clean_contact_address_chk_digit,le.avelength_clean_contact_address_rec_type,le.avelength_clean_contact_address_fips_state,le.avelength_clean_contact_address_fips_county,le.avelength_clean_contact_address_geo_lat,le.avelength_clean_contact_address_geo_long,le.avelength_clean_contact_address_msa,le.avelength_clean_contact_address_geo_blk,le.avelength_clean_contact_address_geo_match,le.avelength_clean_contact_address_err_stat,le.avelength_clean_dates_entrydate,le.avelength_clean_dates_lastupdate,le.avelength_clean_phones_officephone,le.avelength_clean_phones_directdial,le.avelength_clean_phones_mobilephone,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 94, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.rawfields_maincontactid),TRIM((SALT311.StrType)le.rawfields_maincompanyid),TRIM((SALT311.StrType)le.rawfields_active),TRIM((SALT311.StrType)le.rawfields_firstname),TRIM((SALT311.StrType)le.rawfields_midinital),TRIM((SALT311.StrType)le.rawfields_lastname),TRIM((SALT311.StrType)le.rawfields_age),TRIM((SALT311.StrType)le.rawfields_gender),TRIM((SALT311.StrType)le.rawfields_primarytitle),TRIM((SALT311.StrType)le.rawfields_titlelevel1),TRIM((SALT311.StrType)le.rawfields_primarydept),TRIM((SALT311.StrType)le.rawfields_secondtitle),TRIM((SALT311.StrType)le.rawfields_titlelevel2),TRIM((SALT311.StrType)le.rawfields_seconddept),TRIM((SALT311.StrType)le.rawfields_thirdtitle),TRIM((SALT311.StrType)le.rawfields_titlelevel3),TRIM((SALT311.StrType)le.rawfields_thirddept),TRIM((SALT311.StrType)le.rawfields_skillcategory),TRIM((SALT311.StrType)le.rawfields_skillsubcategory),TRIM((SALT311.StrType)le.rawfields_reportto),TRIM((SALT311.StrType)le.rawfields_officephone),TRIM((SALT311.StrType)le.rawfields_officeext),TRIM((SALT311.StrType)le.rawfields_officefax),TRIM((SALT311.StrType)le.rawfields_officeemail),TRIM((SALT311.StrType)le.rawfields_directdial),TRIM((SALT311.StrType)le.rawfields_mobilephone),TRIM((SALT311.StrType)le.rawfields_officeaddress1),TRIM((SALT311.StrType)le.rawfields_officeaddress2),TRIM((SALT311.StrType)le.rawfields_officecity),TRIM((SALT311.StrType)le.rawfields_officestate),TRIM((SALT311.StrType)le.rawfields_officezip),TRIM((SALT311.StrType)le.rawfields_officecountry),TRIM((SALT311.StrType)le.rawfields_school),TRIM((SALT311.StrType)le.rawfields_degree),TRIM((SALT311.StrType)le.rawfields_graduationyear),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_salary),TRIM((SALT311.StrType)le.rawfields_bonus),TRIM((SALT311.StrType)le.rawfields_compensation),TRIM((SALT311.StrType)le.rawfields_citizenship),TRIM((SALT311.StrType)le.rawfields_diversitycandidate),TRIM((SALT311.StrType)le.rawfields_entrydate),TRIM((SALT311.StrType)le.rawfields_lastupdate),TRIM((SALT311.StrType)le.clean_contact_name_title),TRIM((SALT311.StrType)le.clean_contact_name_fname),TRIM((SALT311.StrType)le.clean_contact_name_mname),TRIM((SALT311.StrType)le.clean_contact_name_lname),TRIM((SALT311.StrType)le.clean_contact_name_name_suffix),TRIM((SALT311.StrType)le.clean_contact_name_name_score),TRIM((SALT311.StrType)le.clean_contact_address_prim_range),TRIM((SALT311.StrType)le.clean_contact_address_predir),TRIM((SALT311.StrType)le.clean_contact_address_prim_name),TRIM((SALT311.StrType)le.clean_contact_address_addr_suffix),TRIM((SALT311.StrType)le.clean_contact_address_postdir),TRIM((SALT311.StrType)le.clean_contact_address_unit_desig),TRIM((SALT311.StrType)le.clean_contact_address_sec_range),TRIM((SALT311.StrType)le.clean_contact_address_p_city_name),TRIM((SALT311.StrType)le.clean_contact_address_v_city_name),TRIM((SALT311.StrType)le.clean_contact_address_st),TRIM((SALT311.StrType)le.clean_contact_address_zip),TRIM((SALT311.StrType)le.clean_contact_address_zip4),TRIM((SALT311.StrType)le.clean_contact_address_cart),TRIM((SALT311.StrType)le.clean_contact_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_contact_address_lot),TRIM((SALT311.StrType)le.clean_contact_address_lot_order),TRIM((SALT311.StrType)le.clean_contact_address_dbpc),TRIM((SALT311.StrType)le.clean_contact_address_chk_digit),TRIM((SALT311.StrType)le.clean_contact_address_rec_type),TRIM((SALT311.StrType)le.clean_contact_address_fips_state),TRIM((SALT311.StrType)le.clean_contact_address_fips_county),TRIM((SALT311.StrType)le.clean_contact_address_geo_lat),TRIM((SALT311.StrType)le.clean_contact_address_geo_long),TRIM((SALT311.StrType)le.clean_contact_address_msa),TRIM((SALT311.StrType)le.clean_contact_address_geo_blk),TRIM((SALT311.StrType)le.clean_contact_address_geo_match),TRIM((SALT311.StrType)le.clean_contact_address_err_stat),IF (le.clean_dates_entrydate <> 0,TRIM((SALT311.StrType)le.clean_dates_entrydate), ''),IF (le.clean_dates_lastupdate <> 0,TRIM((SALT311.StrType)le.clean_dates_lastupdate), ''),TRIM((SALT311.StrType)le.clean_phones_officephone),TRIM((SALT311.StrType)le.clean_phones_directdial),TRIM((SALT311.StrType)le.clean_phones_mobilephone),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,94,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 94);
  SELF.FldNo2 := 1 + (C % 94);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.rawfields_maincontactid),TRIM((SALT311.StrType)le.rawfields_maincompanyid),TRIM((SALT311.StrType)le.rawfields_active),TRIM((SALT311.StrType)le.rawfields_firstname),TRIM((SALT311.StrType)le.rawfields_midinital),TRIM((SALT311.StrType)le.rawfields_lastname),TRIM((SALT311.StrType)le.rawfields_age),TRIM((SALT311.StrType)le.rawfields_gender),TRIM((SALT311.StrType)le.rawfields_primarytitle),TRIM((SALT311.StrType)le.rawfields_titlelevel1),TRIM((SALT311.StrType)le.rawfields_primarydept),TRIM((SALT311.StrType)le.rawfields_secondtitle),TRIM((SALT311.StrType)le.rawfields_titlelevel2),TRIM((SALT311.StrType)le.rawfields_seconddept),TRIM((SALT311.StrType)le.rawfields_thirdtitle),TRIM((SALT311.StrType)le.rawfields_titlelevel3),TRIM((SALT311.StrType)le.rawfields_thirddept),TRIM((SALT311.StrType)le.rawfields_skillcategory),TRIM((SALT311.StrType)le.rawfields_skillsubcategory),TRIM((SALT311.StrType)le.rawfields_reportto),TRIM((SALT311.StrType)le.rawfields_officephone),TRIM((SALT311.StrType)le.rawfields_officeext),TRIM((SALT311.StrType)le.rawfields_officefax),TRIM((SALT311.StrType)le.rawfields_officeemail),TRIM((SALT311.StrType)le.rawfields_directdial),TRIM((SALT311.StrType)le.rawfields_mobilephone),TRIM((SALT311.StrType)le.rawfields_officeaddress1),TRIM((SALT311.StrType)le.rawfields_officeaddress2),TRIM((SALT311.StrType)le.rawfields_officecity),TRIM((SALT311.StrType)le.rawfields_officestate),TRIM((SALT311.StrType)le.rawfields_officezip),TRIM((SALT311.StrType)le.rawfields_officecountry),TRIM((SALT311.StrType)le.rawfields_school),TRIM((SALT311.StrType)le.rawfields_degree),TRIM((SALT311.StrType)le.rawfields_graduationyear),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_salary),TRIM((SALT311.StrType)le.rawfields_bonus),TRIM((SALT311.StrType)le.rawfields_compensation),TRIM((SALT311.StrType)le.rawfields_citizenship),TRIM((SALT311.StrType)le.rawfields_diversitycandidate),TRIM((SALT311.StrType)le.rawfields_entrydate),TRIM((SALT311.StrType)le.rawfields_lastupdate),TRIM((SALT311.StrType)le.clean_contact_name_title),TRIM((SALT311.StrType)le.clean_contact_name_fname),TRIM((SALT311.StrType)le.clean_contact_name_mname),TRIM((SALT311.StrType)le.clean_contact_name_lname),TRIM((SALT311.StrType)le.clean_contact_name_name_suffix),TRIM((SALT311.StrType)le.clean_contact_name_name_score),TRIM((SALT311.StrType)le.clean_contact_address_prim_range),TRIM((SALT311.StrType)le.clean_contact_address_predir),TRIM((SALT311.StrType)le.clean_contact_address_prim_name),TRIM((SALT311.StrType)le.clean_contact_address_addr_suffix),TRIM((SALT311.StrType)le.clean_contact_address_postdir),TRIM((SALT311.StrType)le.clean_contact_address_unit_desig),TRIM((SALT311.StrType)le.clean_contact_address_sec_range),TRIM((SALT311.StrType)le.clean_contact_address_p_city_name),TRIM((SALT311.StrType)le.clean_contact_address_v_city_name),TRIM((SALT311.StrType)le.clean_contact_address_st),TRIM((SALT311.StrType)le.clean_contact_address_zip),TRIM((SALT311.StrType)le.clean_contact_address_zip4),TRIM((SALT311.StrType)le.clean_contact_address_cart),TRIM((SALT311.StrType)le.clean_contact_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_contact_address_lot),TRIM((SALT311.StrType)le.clean_contact_address_lot_order),TRIM((SALT311.StrType)le.clean_contact_address_dbpc),TRIM((SALT311.StrType)le.clean_contact_address_chk_digit),TRIM((SALT311.StrType)le.clean_contact_address_rec_type),TRIM((SALT311.StrType)le.clean_contact_address_fips_state),TRIM((SALT311.StrType)le.clean_contact_address_fips_county),TRIM((SALT311.StrType)le.clean_contact_address_geo_lat),TRIM((SALT311.StrType)le.clean_contact_address_geo_long),TRIM((SALT311.StrType)le.clean_contact_address_msa),TRIM((SALT311.StrType)le.clean_contact_address_geo_blk),TRIM((SALT311.StrType)le.clean_contact_address_geo_match),TRIM((SALT311.StrType)le.clean_contact_address_err_stat),IF (le.clean_dates_entrydate <> 0,TRIM((SALT311.StrType)le.clean_dates_entrydate), ''),IF (le.clean_dates_lastupdate <> 0,TRIM((SALT311.StrType)le.clean_dates_lastupdate), ''),TRIM((SALT311.StrType)le.clean_phones_officephone),TRIM((SALT311.StrType)le.clean_phones_directdial),TRIM((SALT311.StrType)le.clean_phones_mobilephone),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.rawfields_maincontactid),TRIM((SALT311.StrType)le.rawfields_maincompanyid),TRIM((SALT311.StrType)le.rawfields_active),TRIM((SALT311.StrType)le.rawfields_firstname),TRIM((SALT311.StrType)le.rawfields_midinital),TRIM((SALT311.StrType)le.rawfields_lastname),TRIM((SALT311.StrType)le.rawfields_age),TRIM((SALT311.StrType)le.rawfields_gender),TRIM((SALT311.StrType)le.rawfields_primarytitle),TRIM((SALT311.StrType)le.rawfields_titlelevel1),TRIM((SALT311.StrType)le.rawfields_primarydept),TRIM((SALT311.StrType)le.rawfields_secondtitle),TRIM((SALT311.StrType)le.rawfields_titlelevel2),TRIM((SALT311.StrType)le.rawfields_seconddept),TRIM((SALT311.StrType)le.rawfields_thirdtitle),TRIM((SALT311.StrType)le.rawfields_titlelevel3),TRIM((SALT311.StrType)le.rawfields_thirddept),TRIM((SALT311.StrType)le.rawfields_skillcategory),TRIM((SALT311.StrType)le.rawfields_skillsubcategory),TRIM((SALT311.StrType)le.rawfields_reportto),TRIM((SALT311.StrType)le.rawfields_officephone),TRIM((SALT311.StrType)le.rawfields_officeext),TRIM((SALT311.StrType)le.rawfields_officefax),TRIM((SALT311.StrType)le.rawfields_officeemail),TRIM((SALT311.StrType)le.rawfields_directdial),TRIM((SALT311.StrType)le.rawfields_mobilephone),TRIM((SALT311.StrType)le.rawfields_officeaddress1),TRIM((SALT311.StrType)le.rawfields_officeaddress2),TRIM((SALT311.StrType)le.rawfields_officecity),TRIM((SALT311.StrType)le.rawfields_officestate),TRIM((SALT311.StrType)le.rawfields_officezip),TRIM((SALT311.StrType)le.rawfields_officecountry),TRIM((SALT311.StrType)le.rawfields_school),TRIM((SALT311.StrType)le.rawfields_degree),TRIM((SALT311.StrType)le.rawfields_graduationyear),TRIM((SALT311.StrType)le.rawfields_country),TRIM((SALT311.StrType)le.rawfields_salary),TRIM((SALT311.StrType)le.rawfields_bonus),TRIM((SALT311.StrType)le.rawfields_compensation),TRIM((SALT311.StrType)le.rawfields_citizenship),TRIM((SALT311.StrType)le.rawfields_diversitycandidate),TRIM((SALT311.StrType)le.rawfields_entrydate),TRIM((SALT311.StrType)le.rawfields_lastupdate),TRIM((SALT311.StrType)le.clean_contact_name_title),TRIM((SALT311.StrType)le.clean_contact_name_fname),TRIM((SALT311.StrType)le.clean_contact_name_mname),TRIM((SALT311.StrType)le.clean_contact_name_lname),TRIM((SALT311.StrType)le.clean_contact_name_name_suffix),TRIM((SALT311.StrType)le.clean_contact_name_name_score),TRIM((SALT311.StrType)le.clean_contact_address_prim_range),TRIM((SALT311.StrType)le.clean_contact_address_predir),TRIM((SALT311.StrType)le.clean_contact_address_prim_name),TRIM((SALT311.StrType)le.clean_contact_address_addr_suffix),TRIM((SALT311.StrType)le.clean_contact_address_postdir),TRIM((SALT311.StrType)le.clean_contact_address_unit_desig),TRIM((SALT311.StrType)le.clean_contact_address_sec_range),TRIM((SALT311.StrType)le.clean_contact_address_p_city_name),TRIM((SALT311.StrType)le.clean_contact_address_v_city_name),TRIM((SALT311.StrType)le.clean_contact_address_st),TRIM((SALT311.StrType)le.clean_contact_address_zip),TRIM((SALT311.StrType)le.clean_contact_address_zip4),TRIM((SALT311.StrType)le.clean_contact_address_cart),TRIM((SALT311.StrType)le.clean_contact_address_cr_sort_sz),TRIM((SALT311.StrType)le.clean_contact_address_lot),TRIM((SALT311.StrType)le.clean_contact_address_lot_order),TRIM((SALT311.StrType)le.clean_contact_address_dbpc),TRIM((SALT311.StrType)le.clean_contact_address_chk_digit),TRIM((SALT311.StrType)le.clean_contact_address_rec_type),TRIM((SALT311.StrType)le.clean_contact_address_fips_state),TRIM((SALT311.StrType)le.clean_contact_address_fips_county),TRIM((SALT311.StrType)le.clean_contact_address_geo_lat),TRIM((SALT311.StrType)le.clean_contact_address_geo_long),TRIM((SALT311.StrType)le.clean_contact_address_msa),TRIM((SALT311.StrType)le.clean_contact_address_geo_blk),TRIM((SALT311.StrType)le.clean_contact_address_geo_match),TRIM((SALT311.StrType)le.clean_contact_address_err_stat),IF (le.clean_dates_entrydate <> 0,TRIM((SALT311.StrType)le.clean_dates_entrydate), ''),IF (le.clean_dates_lastupdate <> 0,TRIM((SALT311.StrType)le.clean_dates_lastupdate), ''),TRIM((SALT311.StrType)le.clean_phones_officephone),TRIM((SALT311.StrType)le.clean_phones_directdial),TRIM((SALT311.StrType)le.clean_phones_mobilephone),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),94*94,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'did'}
      ,{2,'did_score'}
      ,{3,'bdid'}
      ,{4,'bdid_score'}
      ,{5,'raw_aid'}
      ,{6,'ace_aid'}
      ,{7,'dt_first_seen'}
      ,{8,'dt_last_seen'}
      ,{9,'dt_vendor_first_reported'}
      ,{10,'dt_vendor_last_reported'}
      ,{11,'record_type'}
      ,{12,'rawfields_maincontactid'}
      ,{13,'rawfields_maincompanyid'}
      ,{14,'rawfields_active'}
      ,{15,'rawfields_firstname'}
      ,{16,'rawfields_midinital'}
      ,{17,'rawfields_lastname'}
      ,{18,'rawfields_age'}
      ,{19,'rawfields_gender'}
      ,{20,'rawfields_primarytitle'}
      ,{21,'rawfields_titlelevel1'}
      ,{22,'rawfields_primarydept'}
      ,{23,'rawfields_secondtitle'}
      ,{24,'rawfields_titlelevel2'}
      ,{25,'rawfields_seconddept'}
      ,{26,'rawfields_thirdtitle'}
      ,{27,'rawfields_titlelevel3'}
      ,{28,'rawfields_thirddept'}
      ,{29,'rawfields_skillcategory'}
      ,{30,'rawfields_skillsubcategory'}
      ,{31,'rawfields_reportto'}
      ,{32,'rawfields_officephone'}
      ,{33,'rawfields_officeext'}
      ,{34,'rawfields_officefax'}
      ,{35,'rawfields_officeemail'}
      ,{36,'rawfields_directdial'}
      ,{37,'rawfields_mobilephone'}
      ,{38,'rawfields_officeaddress1'}
      ,{39,'rawfields_officeaddress2'}
      ,{40,'rawfields_officecity'}
      ,{41,'rawfields_officestate'}
      ,{42,'rawfields_officezip'}
      ,{43,'rawfields_officecountry'}
      ,{44,'rawfields_school'}
      ,{45,'rawfields_degree'}
      ,{46,'rawfields_graduationyear'}
      ,{47,'rawfields_country'}
      ,{48,'rawfields_salary'}
      ,{49,'rawfields_bonus'}
      ,{50,'rawfields_compensation'}
      ,{51,'rawfields_citizenship'}
      ,{52,'rawfields_diversitycandidate'}
      ,{53,'rawfields_entrydate'}
      ,{54,'rawfields_lastupdate'}
      ,{55,'clean_contact_name_title'}
      ,{56,'clean_contact_name_fname'}
      ,{57,'clean_contact_name_mname'}
      ,{58,'clean_contact_name_lname'}
      ,{59,'clean_contact_name_name_suffix'}
      ,{60,'clean_contact_name_name_score'}
      ,{61,'clean_contact_address_prim_range'}
      ,{62,'clean_contact_address_predir'}
      ,{63,'clean_contact_address_prim_name'}
      ,{64,'clean_contact_address_addr_suffix'}
      ,{65,'clean_contact_address_postdir'}
      ,{66,'clean_contact_address_unit_desig'}
      ,{67,'clean_contact_address_sec_range'}
      ,{68,'clean_contact_address_p_city_name'}
      ,{69,'clean_contact_address_v_city_name'}
      ,{70,'clean_contact_address_st'}
      ,{71,'clean_contact_address_zip'}
      ,{72,'clean_contact_address_zip4'}
      ,{73,'clean_contact_address_cart'}
      ,{74,'clean_contact_address_cr_sort_sz'}
      ,{75,'clean_contact_address_lot'}
      ,{76,'clean_contact_address_lot_order'}
      ,{77,'clean_contact_address_dbpc'}
      ,{78,'clean_contact_address_chk_digit'}
      ,{79,'clean_contact_address_rec_type'}
      ,{80,'clean_contact_address_fips_state'}
      ,{81,'clean_contact_address_fips_county'}
      ,{82,'clean_contact_address_geo_lat'}
      ,{83,'clean_contact_address_geo_long'}
      ,{84,'clean_contact_address_msa'}
      ,{85,'clean_contact_address_geo_blk'}
      ,{86,'clean_contact_address_geo_match'}
      ,{87,'clean_contact_address_err_stat'}
      ,{88,'clean_dates_entrydate'}
      ,{89,'clean_dates_lastupdate'}
      ,{90,'clean_phones_officephone'}
      ,{91,'clean_phones_directdial'}
      ,{92,'clean_phones_mobilephone'}
      ,{93,'global_sid'}
      ,{94,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Contacts_Fields.InValid_did((SALT311.StrType)le.did),
    Contacts_Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Contacts_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Contacts_Fields.InValid_bdid_score((SALT311.StrType)le.bdid_score),
    Contacts_Fields.InValid_raw_aid((SALT311.StrType)le.raw_aid),
    Contacts_Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid),
    Contacts_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Contacts_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Contacts_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Contacts_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Contacts_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Contacts_Fields.InValid_rawfields_maincontactid((SALT311.StrType)le.rawfields_maincontactid),
    Contacts_Fields.InValid_rawfields_maincompanyid((SALT311.StrType)le.rawfields_maincompanyid),
    Contacts_Fields.InValid_rawfields_active((SALT311.StrType)le.rawfields_active),
    Contacts_Fields.InValid_rawfields_firstname((SALT311.StrType)le.rawfields_firstname),
    Contacts_Fields.InValid_rawfields_midinital((SALT311.StrType)le.rawfields_midinital),
    Contacts_Fields.InValid_rawfields_lastname((SALT311.StrType)le.rawfields_lastname),
    Contacts_Fields.InValid_rawfields_age((SALT311.StrType)le.rawfields_age),
    Contacts_Fields.InValid_rawfields_gender((SALT311.StrType)le.rawfields_gender),
    Contacts_Fields.InValid_rawfields_primarytitle((SALT311.StrType)le.rawfields_primarytitle),
    Contacts_Fields.InValid_rawfields_titlelevel1((SALT311.StrType)le.rawfields_titlelevel1),
    Contacts_Fields.InValid_rawfields_primarydept((SALT311.StrType)le.rawfields_primarydept),
    Contacts_Fields.InValid_rawfields_secondtitle((SALT311.StrType)le.rawfields_secondtitle),
    Contacts_Fields.InValid_rawfields_titlelevel2((SALT311.StrType)le.rawfields_titlelevel2),
    Contacts_Fields.InValid_rawfields_seconddept((SALT311.StrType)le.rawfields_seconddept),
    Contacts_Fields.InValid_rawfields_thirdtitle((SALT311.StrType)le.rawfields_thirdtitle),
    Contacts_Fields.InValid_rawfields_titlelevel3((SALT311.StrType)le.rawfields_titlelevel3),
    Contacts_Fields.InValid_rawfields_thirddept((SALT311.StrType)le.rawfields_thirddept),
    Contacts_Fields.InValid_rawfields_skillcategory((SALT311.StrType)le.rawfields_skillcategory),
    Contacts_Fields.InValid_rawfields_skillsubcategory((SALT311.StrType)le.rawfields_skillsubcategory),
    Contacts_Fields.InValid_rawfields_reportto((SALT311.StrType)le.rawfields_reportto),
    Contacts_Fields.InValid_rawfields_officephone((SALT311.StrType)le.rawfields_officephone),
    Contacts_Fields.InValid_rawfields_officeext((SALT311.StrType)le.rawfields_officeext),
    Contacts_Fields.InValid_rawfields_officefax((SALT311.StrType)le.rawfields_officefax),
    Contacts_Fields.InValid_rawfields_officeemail((SALT311.StrType)le.rawfields_officeemail),
    Contacts_Fields.InValid_rawfields_directdial((SALT311.StrType)le.rawfields_directdial),
    Contacts_Fields.InValid_rawfields_mobilephone((SALT311.StrType)le.rawfields_mobilephone),
    Contacts_Fields.InValid_rawfields_officeaddress1((SALT311.StrType)le.rawfields_officeaddress1),
    Contacts_Fields.InValid_rawfields_officeaddress2((SALT311.StrType)le.rawfields_officeaddress2),
    Contacts_Fields.InValid_rawfields_officecity((SALT311.StrType)le.rawfields_officecity),
    Contacts_Fields.InValid_rawfields_officestate((SALT311.StrType)le.rawfields_officestate),
    Contacts_Fields.InValid_rawfields_officezip((SALT311.StrType)le.rawfields_officezip),
    Contacts_Fields.InValid_rawfields_officecountry((SALT311.StrType)le.rawfields_officecountry),
    Contacts_Fields.InValid_rawfields_school((SALT311.StrType)le.rawfields_school),
    Contacts_Fields.InValid_rawfields_degree((SALT311.StrType)le.rawfields_degree),
    Contacts_Fields.InValid_rawfields_graduationyear((SALT311.StrType)le.rawfields_graduationyear),
    Contacts_Fields.InValid_rawfields_country((SALT311.StrType)le.rawfields_country),
    Contacts_Fields.InValid_rawfields_salary((SALT311.StrType)le.rawfields_salary),
    Contacts_Fields.InValid_rawfields_bonus((SALT311.StrType)le.rawfields_bonus),
    Contacts_Fields.InValid_rawfields_compensation((SALT311.StrType)le.rawfields_compensation),
    Contacts_Fields.InValid_rawfields_citizenship((SALT311.StrType)le.rawfields_citizenship),
    Contacts_Fields.InValid_rawfields_diversitycandidate((SALT311.StrType)le.rawfields_diversitycandidate),
    Contacts_Fields.InValid_rawfields_entrydate((SALT311.StrType)le.rawfields_entrydate),
    Contacts_Fields.InValid_rawfields_lastupdate((SALT311.StrType)le.rawfields_lastupdate),
    Contacts_Fields.InValid_clean_contact_name_title((SALT311.StrType)le.clean_contact_name_title),
    Contacts_Fields.InValid_clean_contact_name_fname((SALT311.StrType)le.clean_contact_name_fname),
    Contacts_Fields.InValid_clean_contact_name_mname((SALT311.StrType)le.clean_contact_name_mname),
    Contacts_Fields.InValid_clean_contact_name_lname((SALT311.StrType)le.clean_contact_name_lname),
    Contacts_Fields.InValid_clean_contact_name_name_suffix((SALT311.StrType)le.clean_contact_name_name_suffix),
    Contacts_Fields.InValid_clean_contact_name_name_score((SALT311.StrType)le.clean_contact_name_name_score),
    Contacts_Fields.InValid_clean_contact_address_prim_range((SALT311.StrType)le.clean_contact_address_prim_range),
    Contacts_Fields.InValid_clean_contact_address_predir((SALT311.StrType)le.clean_contact_address_predir),
    Contacts_Fields.InValid_clean_contact_address_prim_name((SALT311.StrType)le.clean_contact_address_prim_name),
    Contacts_Fields.InValid_clean_contact_address_addr_suffix((SALT311.StrType)le.clean_contact_address_addr_suffix),
    Contacts_Fields.InValid_clean_contact_address_postdir((SALT311.StrType)le.clean_contact_address_postdir),
    Contacts_Fields.InValid_clean_contact_address_unit_desig((SALT311.StrType)le.clean_contact_address_unit_desig),
    Contacts_Fields.InValid_clean_contact_address_sec_range((SALT311.StrType)le.clean_contact_address_sec_range),
    Contacts_Fields.InValid_clean_contact_address_p_city_name((SALT311.StrType)le.clean_contact_address_p_city_name),
    Contacts_Fields.InValid_clean_contact_address_v_city_name((SALT311.StrType)le.clean_contact_address_v_city_name),
    Contacts_Fields.InValid_clean_contact_address_st((SALT311.StrType)le.clean_contact_address_st),
    Contacts_Fields.InValid_clean_contact_address_zip((SALT311.StrType)le.clean_contact_address_zip),
    Contacts_Fields.InValid_clean_contact_address_zip4((SALT311.StrType)le.clean_contact_address_zip4),
    Contacts_Fields.InValid_clean_contact_address_cart((SALT311.StrType)le.clean_contact_address_cart),
    Contacts_Fields.InValid_clean_contact_address_cr_sort_sz((SALT311.StrType)le.clean_contact_address_cr_sort_sz),
    Contacts_Fields.InValid_clean_contact_address_lot((SALT311.StrType)le.clean_contact_address_lot),
    Contacts_Fields.InValid_clean_contact_address_lot_order((SALT311.StrType)le.clean_contact_address_lot_order),
    Contacts_Fields.InValid_clean_contact_address_dbpc((SALT311.StrType)le.clean_contact_address_dbpc),
    Contacts_Fields.InValid_clean_contact_address_chk_digit((SALT311.StrType)le.clean_contact_address_chk_digit),
    Contacts_Fields.InValid_clean_contact_address_rec_type((SALT311.StrType)le.clean_contact_address_rec_type),
    Contacts_Fields.InValid_clean_contact_address_fips_state((SALT311.StrType)le.clean_contact_address_fips_state),
    Contacts_Fields.InValid_clean_contact_address_fips_county((SALT311.StrType)le.clean_contact_address_fips_county),
    Contacts_Fields.InValid_clean_contact_address_geo_lat((SALT311.StrType)le.clean_contact_address_geo_lat),
    Contacts_Fields.InValid_clean_contact_address_geo_long((SALT311.StrType)le.clean_contact_address_geo_long),
    Contacts_Fields.InValid_clean_contact_address_msa((SALT311.StrType)le.clean_contact_address_msa),
    Contacts_Fields.InValid_clean_contact_address_geo_blk((SALT311.StrType)le.clean_contact_address_geo_blk),
    Contacts_Fields.InValid_clean_contact_address_geo_match((SALT311.StrType)le.clean_contact_address_geo_match),
    Contacts_Fields.InValid_clean_contact_address_err_stat((SALT311.StrType)le.clean_contact_address_err_stat),
    Contacts_Fields.InValid_clean_dates_entrydate((SALT311.StrType)le.clean_dates_entrydate),
    Contacts_Fields.InValid_clean_dates_lastupdate((SALT311.StrType)le.clean_dates_lastupdate),
    Contacts_Fields.InValid_clean_phones_officephone((SALT311.StrType)le.clean_phones_officephone),
    Contacts_Fields.InValid_clean_phones_directdial((SALT311.StrType)le.clean_phones_directdial),
    Contacts_Fields.InValid_clean_phones_mobilephone((SALT311.StrType)le.clean_phones_mobilephone),
    Contacts_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Contacts_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,94,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Contacts_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaChar','Invalid_Float','Invalid_Float','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_AlphaCaps','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaCaps','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaCaps','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_Date','Invalid_Float','Invalid_Float','Invalid_Float','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Contacts_Fields.InValidMessage_did(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_maincontactid(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_maincompanyid(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_active(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_firstname(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_midinital(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_lastname(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_age(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_gender(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_primarytitle(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_titlelevel1(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_primarydept(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_secondtitle(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_titlelevel2(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_seconddept(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_thirdtitle(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_titlelevel3(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_thirddept(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_skillcategory(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_skillsubcategory(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_reportto(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officephone(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officeext(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officefax(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officeemail(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_directdial(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_mobilephone(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officeaddress1(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officeaddress2(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officecity(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officestate(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officezip(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_officecountry(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_school(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_degree(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_graduationyear(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_country(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_salary(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_bonus(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_compensation(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_citizenship(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_diversitycandidate(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_entrydate(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_rawfields_lastupdate(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_name_title(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_name_fname(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_name_mname(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_name_lname(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_name_name_suffix(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_name_name_score(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_prim_range(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_predir(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_prim_name(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_addr_suffix(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_postdir(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_unit_desig(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_sec_range(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_p_city_name(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_v_city_name(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_st(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_zip(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_zip4(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_cart(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_cr_sort_sz(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_lot(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_lot_order(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_dbpc(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_chk_digit(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_rec_type(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_fips_state(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_fips_county(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_geo_lat(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_geo_long(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_msa(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_geo_blk(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_geo_match(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_contact_address_err_stat(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_dates_entrydate(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_dates_lastupdate(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_phones_officephone(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_phones_directdial(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_clean_phones_mobilephone(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Sheila_Greco, Contacts_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
