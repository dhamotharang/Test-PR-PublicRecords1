IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_In_ME_MEDCERT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_cnt := COUNT(GROUP,h.append_process_date <> (TYPEOF(h.append_process_date))'');
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_credential_type_cnt := COUNT(GROUP,h.orig_credential_type <> (TYPEOF(h.orig_credential_type))'');
    populated_orig_credential_type_pcnt := AVE(GROUP,IF(h.orig_credential_type = (TYPEOF(h.orig_credential_type))'',0,100));
    maxlength_orig_credential_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_credential_type)));
    avelength_orig_credential_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_credential_type)),h.orig_credential_type<>(typeof(h.orig_credential_type))'');
    populated_orig_id_terminal_date_cnt := COUNT(GROUP,h.orig_id_terminal_date <> (TYPEOF(h.orig_id_terminal_date))'');
    populated_orig_id_terminal_date_pcnt := AVE(GROUP,IF(h.orig_id_terminal_date = (TYPEOF(h.orig_id_terminal_date))'',0,100));
    maxlength_orig_id_terminal_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_id_terminal_date)));
    avelength_orig_id_terminal_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_id_terminal_date)),h.orig_id_terminal_date<>(typeof(h.orig_id_terminal_date))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mi_cnt := COUNT(GROUP,h.orig_mi <> (TYPEOF(h.orig_mi))'');
    populated_orig_mi_pcnt := AVE(GROUP,IF(h.orig_mi = (TYPEOF(h.orig_mi))'',0,100));
    maxlength_orig_mi := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mi)));
    avelength_orig_mi := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mi)),h.orig_mi<>(typeof(h.orig_mi))'');
    populated_orig_namesuf_cnt := COUNT(GROUP,h.orig_namesuf <> (TYPEOF(h.orig_namesuf))'');
    populated_orig_namesuf_pcnt := AVE(GROUP,IF(h.orig_namesuf = (TYPEOF(h.orig_namesuf))'',0,100));
    maxlength_orig_namesuf := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_namesuf)));
    avelength_orig_namesuf := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_namesuf)),h.orig_namesuf<>(typeof(h.orig_namesuf))'');
    populated_orig_street_cnt := COUNT(GROUP,h.orig_street <> (TYPEOF(h.orig_street))'');
    populated_orig_street_pcnt := AVE(GROUP,IF(h.orig_street = (TYPEOF(h.orig_street))'',0,100));
    maxlength_orig_street := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_street)));
    avelength_orig_street := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_street)),h.orig_street<>(typeof(h.orig_street))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_drivered_cnt := COUNT(GROUP,h.orig_drivered <> (TYPEOF(h.orig_drivered))'');
    populated_orig_drivered_pcnt := AVE(GROUP,IF(h.orig_drivered = (TYPEOF(h.orig_drivered))'',0,100));
    maxlength_orig_drivered := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_drivered)));
    avelength_orig_drivered := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_drivered)),h.orig_drivered<>(typeof(h.orig_drivered))'');
    populated_orig_sex_cnt := COUNT(GROUP,h.orig_sex <> (TYPEOF(h.orig_sex))'');
    populated_orig_sex_pcnt := AVE(GROUP,IF(h.orig_sex = (TYPEOF(h.orig_sex))'',0,100));
    maxlength_orig_sex := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_sex)));
    avelength_orig_sex := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_sex)),h.orig_sex<>(typeof(h.orig_sex))'');
    populated_orig_height_cnt := COUNT(GROUP,h.orig_height <> (TYPEOF(h.orig_height))'');
    populated_orig_height_pcnt := AVE(GROUP,IF(h.orig_height = (TYPEOF(h.orig_height))'',0,100));
    maxlength_orig_height := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_height)));
    avelength_orig_height := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_height)),h.orig_height<>(typeof(h.orig_height))'');
    populated_orig_height2_cnt := COUNT(GROUP,h.orig_height2 <> (TYPEOF(h.orig_height2))'');
    populated_orig_height2_pcnt := AVE(GROUP,IF(h.orig_height2 = (TYPEOF(h.orig_height2))'',0,100));
    maxlength_orig_height2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_height2)));
    avelength_orig_height2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_height2)),h.orig_height2<>(typeof(h.orig_height2))'');
    populated_orig_weight_cnt := COUNT(GROUP,h.orig_weight <> (TYPEOF(h.orig_weight))'');
    populated_orig_weight_pcnt := AVE(GROUP,IF(h.orig_weight = (TYPEOF(h.orig_weight))'',0,100));
    maxlength_orig_weight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_weight)));
    avelength_orig_weight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_weight)),h.orig_weight<>(typeof(h.orig_weight))'');
    populated_orig_hair_cnt := COUNT(GROUP,h.orig_hair <> (TYPEOF(h.orig_hair))'');
    populated_orig_hair_pcnt := AVE(GROUP,IF(h.orig_hair = (TYPEOF(h.orig_hair))'',0,100));
    maxlength_orig_hair := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_hair)));
    avelength_orig_hair := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_hair)),h.orig_hair<>(typeof(h.orig_hair))'');
    populated_orig_eyes_cnt := COUNT(GROUP,h.orig_eyes <> (TYPEOF(h.orig_eyes))'');
    populated_orig_eyes_pcnt := AVE(GROUP,IF(h.orig_eyes = (TYPEOF(h.orig_eyes))'',0,100));
    maxlength_orig_eyes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_eyes)));
    avelength_orig_eyes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_eyes)),h.orig_eyes<>(typeof(h.orig_eyes))'');
    populated_orig_dlexpiredate_cnt := COUNT(GROUP,h.orig_dlexpiredate <> (TYPEOF(h.orig_dlexpiredate))'');
    populated_orig_dlexpiredate_pcnt := AVE(GROUP,IF(h.orig_dlexpiredate = (TYPEOF(h.orig_dlexpiredate))'',0,100));
    maxlength_orig_dlexpiredate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlexpiredate)));
    avelength_orig_dlexpiredate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlexpiredate)),h.orig_dlexpiredate<>(typeof(h.orig_dlexpiredate))'');
    populated_orig_dlstat_cnt := COUNT(GROUP,h.orig_dlstat <> (TYPEOF(h.orig_dlstat))'');
    populated_orig_dlstat_pcnt := AVE(GROUP,IF(h.orig_dlstat = (TYPEOF(h.orig_dlstat))'',0,100));
    maxlength_orig_dlstat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlstat)));
    avelength_orig_dlstat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlstat)),h.orig_dlstat<>(typeof(h.orig_dlstat))'');
    populated_orig_dlissuedate_cnt := COUNT(GROUP,h.orig_dlissuedate <> (TYPEOF(h.orig_dlissuedate))'');
    populated_orig_dlissuedate_pcnt := AVE(GROUP,IF(h.orig_dlissuedate = (TYPEOF(h.orig_dlissuedate))'',0,100));
    maxlength_orig_dlissuedate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlissuedate)));
    avelength_orig_dlissuedate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlissuedate)),h.orig_dlissuedate<>(typeof(h.orig_dlissuedate))'');
    populated_orig_originalissuedate_cnt := COUNT(GROUP,h.orig_originalissuedate <> (TYPEOF(h.orig_originalissuedate))'');
    populated_orig_originalissuedate_pcnt := AVE(GROUP,IF(h.orig_originalissuedate = (TYPEOF(h.orig_originalissuedate))'',0,100));
    maxlength_orig_originalissuedate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_originalissuedate)));
    avelength_orig_originalissuedate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_originalissuedate)),h.orig_originalissuedate<>(typeof(h.orig_originalissuedate))'');
    populated_orig_regstatfr_cnt := COUNT(GROUP,h.orig_regstatfr <> (TYPEOF(h.orig_regstatfr))'');
    populated_orig_regstatfr_pcnt := AVE(GROUP,IF(h.orig_regstatfr = (TYPEOF(h.orig_regstatfr))'',0,100));
    maxlength_orig_regstatfr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_regstatfr)));
    avelength_orig_regstatfr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_regstatfr)),h.orig_regstatfr<>(typeof(h.orig_regstatfr))'');
    populated_orig_regstatcr_cnt := COUNT(GROUP,h.orig_regstatcr <> (TYPEOF(h.orig_regstatcr))'');
    populated_orig_regstatcr_pcnt := AVE(GROUP,IF(h.orig_regstatcr = (TYPEOF(h.orig_regstatcr))'',0,100));
    maxlength_orig_regstatcr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_regstatcr)));
    avelength_orig_regstatcr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_regstatcr)),h.orig_regstatcr<>(typeof(h.orig_regstatcr))'');
    populated_orig_dlclass_cnt := COUNT(GROUP,h.orig_dlclass <> (TYPEOF(h.orig_dlclass))'');
    populated_orig_dlclass_pcnt := AVE(GROUP,IF(h.orig_dlclass = (TYPEOF(h.orig_dlclass))'',0,100));
    maxlength_orig_dlclass := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlclass)));
    avelength_orig_dlclass := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dlclass)),h.orig_dlclass<>(typeof(h.orig_dlclass))'');
    populated_orig_historynum_cnt := COUNT(GROUP,h.orig_historynum <> (TYPEOF(h.orig_historynum))'');
    populated_orig_historynum_pcnt := AVE(GROUP,IF(h.orig_historynum = (TYPEOF(h.orig_historynum))'',0,100));
    maxlength_orig_historynum := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_historynum)));
    avelength_orig_historynum := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_historynum)),h.orig_historynum<>(typeof(h.orig_historynum))'');
    populated_orig_disabledvet_cnt := COUNT(GROUP,h.orig_disabledvet <> (TYPEOF(h.orig_disabledvet))'');
    populated_orig_disabledvet_pcnt := AVE(GROUP,IF(h.orig_disabledvet = (TYPEOF(h.orig_disabledvet))'',0,100));
    maxlength_orig_disabledvet := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_disabledvet)));
    avelength_orig_disabledvet := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_disabledvet)),h.orig_disabledvet<>(typeof(h.orig_disabledvet))'');
    populated_orig_photo_cnt := COUNT(GROUP,h.orig_photo <> (TYPEOF(h.orig_photo))'');
    populated_orig_photo_pcnt := AVE(GROUP,IF(h.orig_photo = (TYPEOF(h.orig_photo))'',0,100));
    maxlength_orig_photo := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_photo)));
    avelength_orig_photo := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_photo)),h.orig_photo<>(typeof(h.orig_photo))'');
    populated_orig_habitualoffender_cnt := COUNT(GROUP,h.orig_habitualoffender <> (TYPEOF(h.orig_habitualoffender))'');
    populated_orig_habitualoffender_pcnt := AVE(GROUP,IF(h.orig_habitualoffender = (TYPEOF(h.orig_habitualoffender))'',0,100));
    maxlength_orig_habitualoffender := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_habitualoffender)));
    avelength_orig_habitualoffender := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_habitualoffender)),h.orig_habitualoffender<>(typeof(h.orig_habitualoffender))'');
    populated_orig_restrictions_cnt := COUNT(GROUP,h.orig_restrictions <> (TYPEOF(h.orig_restrictions))'');
    populated_orig_restrictions_pcnt := AVE(GROUP,IF(h.orig_restrictions = (TYPEOF(h.orig_restrictions))'',0,100));
    maxlength_orig_restrictions := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_restrictions)));
    avelength_orig_restrictions := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_restrictions)),h.orig_restrictions<>(typeof(h.orig_restrictions))'');
    populated_orig_endorsements_cnt := COUNT(GROUP,h.orig_endorsements <> (TYPEOF(h.orig_endorsements))'');
    populated_orig_endorsements_pcnt := AVE(GROUP,IF(h.orig_endorsements = (TYPEOF(h.orig_endorsements))'',0,100));
    maxlength_orig_endorsements := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements)));
    avelength_orig_endorsements := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements)),h.orig_endorsements<>(typeof(h.orig_endorsements))'');
    populated_orig_endorsements2_cnt := COUNT(GROUP,h.orig_endorsements2 <> (TYPEOF(h.orig_endorsements2))'');
    populated_orig_endorsements2_pcnt := AVE(GROUP,IF(h.orig_endorsements2 = (TYPEOF(h.orig_endorsements2))'',0,100));
    maxlength_orig_endorsements2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements2)));
    avelength_orig_endorsements2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements2)),h.orig_endorsements2<>(typeof(h.orig_endorsements2))'');
    populated_orig_endorsements3_cnt := COUNT(GROUP,h.orig_endorsements3 <> (TYPEOF(h.orig_endorsements3))'');
    populated_orig_endorsements3_pcnt := AVE(GROUP,IF(h.orig_endorsements3 = (TYPEOF(h.orig_endorsements3))'',0,100));
    maxlength_orig_endorsements3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements3)));
    avelength_orig_endorsements3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements3)),h.orig_endorsements3<>(typeof(h.orig_endorsements3))'');
    populated_orig_endorsements4_cnt := COUNT(GROUP,h.orig_endorsements4 <> (TYPEOF(h.orig_endorsements4))'');
    populated_orig_endorsements4_pcnt := AVE(GROUP,IF(h.orig_endorsements4 = (TYPEOF(h.orig_endorsements4))'',0,100));
    maxlength_orig_endorsements4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements4)));
    avelength_orig_endorsements4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements4)),h.orig_endorsements4<>(typeof(h.orig_endorsements4))'');
    populated_orig_endorsements5_cnt := COUNT(GROUP,h.orig_endorsements5 <> (TYPEOF(h.orig_endorsements5))'');
    populated_orig_endorsements5_pcnt := AVE(GROUP,IF(h.orig_endorsements5 = (TYPEOF(h.orig_endorsements5))'',0,100));
    maxlength_orig_endorsements5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements5)));
    avelength_orig_endorsements5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements5)),h.orig_endorsements5<>(typeof(h.orig_endorsements5))'');
    populated_orig_endorsements6_cnt := COUNT(GROUP,h.orig_endorsements6 <> (TYPEOF(h.orig_endorsements6))'');
    populated_orig_endorsements6_pcnt := AVE(GROUP,IF(h.orig_endorsements6 = (TYPEOF(h.orig_endorsements6))'',0,100));
    maxlength_orig_endorsements6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements6)));
    avelength_orig_endorsements6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements6)),h.orig_endorsements6<>(typeof(h.orig_endorsements6))'');
    populated_orig_endorsements7_cnt := COUNT(GROUP,h.orig_endorsements7 <> (TYPEOF(h.orig_endorsements7))'');
    populated_orig_endorsements7_pcnt := AVE(GROUP,IF(h.orig_endorsements7 = (TYPEOF(h.orig_endorsements7))'',0,100));
    maxlength_orig_endorsements7 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements7)));
    avelength_orig_endorsements7 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements7)),h.orig_endorsements7<>(typeof(h.orig_endorsements7))'');
    populated_orig_endorsements8_cnt := COUNT(GROUP,h.orig_endorsements8 <> (TYPEOF(h.orig_endorsements8))'');
    populated_orig_endorsements8_pcnt := AVE(GROUP,IF(h.orig_endorsements8 = (TYPEOF(h.orig_endorsements8))'',0,100));
    maxlength_orig_endorsements8 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements8)));
    avelength_orig_endorsements8 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements8)),h.orig_endorsements8<>(typeof(h.orig_endorsements8))'');
    populated_orig_endorsements9_cnt := COUNT(GROUP,h.orig_endorsements9 <> (TYPEOF(h.orig_endorsements9))'');
    populated_orig_endorsements9_pcnt := AVE(GROUP,IF(h.orig_endorsements9 = (TYPEOF(h.orig_endorsements9))'',0,100));
    maxlength_orig_endorsements9 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements9)));
    avelength_orig_endorsements9 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements9)),h.orig_endorsements9<>(typeof(h.orig_endorsements9))'');
    populated_orig_endorsements10_cnt := COUNT(GROUP,h.orig_endorsements10 <> (TYPEOF(h.orig_endorsements10))'');
    populated_orig_endorsements10_pcnt := AVE(GROUP,IF(h.orig_endorsements10 = (TYPEOF(h.orig_endorsements10))'',0,100));
    maxlength_orig_endorsements10 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements10)));
    avelength_orig_endorsements10 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements10)),h.orig_endorsements10<>(typeof(h.orig_endorsements10))'');
    populated_orig_endorsements11_20_cnt := COUNT(GROUP,h.orig_endorsements11_20 <> (TYPEOF(h.orig_endorsements11_20))'');
    populated_orig_endorsements11_20_pcnt := AVE(GROUP,IF(h.orig_endorsements11_20 = (TYPEOF(h.orig_endorsements11_20))'',0,100));
    maxlength_orig_endorsements11_20 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements11_20)));
    avelength_orig_endorsements11_20 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_endorsements11_20)),h.orig_endorsements11_20<>(typeof(h.orig_endorsements11_20))'');
    populated_orig_comm_driv_status_cnt := COUNT(GROUP,h.orig_comm_driv_status <> (TYPEOF(h.orig_comm_driv_status))'');
    populated_orig_comm_driv_status_pcnt := AVE(GROUP,IF(h.orig_comm_driv_status = (TYPEOF(h.orig_comm_driv_status))'',0,100));
    maxlength_orig_comm_driv_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_comm_driv_status)));
    avelength_orig_comm_driv_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_comm_driv_status)),h.orig_comm_driv_status<>(typeof(h.orig_comm_driv_status))'');
    populated_orig_disabled_vet_type_cnt := COUNT(GROUP,h.orig_disabled_vet_type <> (TYPEOF(h.orig_disabled_vet_type))'');
    populated_orig_disabled_vet_type_pcnt := AVE(GROUP,IF(h.orig_disabled_vet_type = (TYPEOF(h.orig_disabled_vet_type))'',0,100));
    maxlength_orig_disabled_vet_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_disabled_vet_type)));
    avelength_orig_disabled_vet_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_disabled_vet_type)),h.orig_disabled_vet_type<>(typeof(h.orig_disabled_vet_type))'');
    populated_orig_organ_donor_cnt := COUNT(GROUP,h.orig_organ_donor <> (TYPEOF(h.orig_organ_donor))'');
    populated_orig_organ_donor_pcnt := AVE(GROUP,IF(h.orig_organ_donor = (TYPEOF(h.orig_organ_donor))'',0,100));
    maxlength_orig_organ_donor := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_organ_donor)));
    avelength_orig_organ_donor := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_organ_donor)),h.orig_organ_donor<>(typeof(h.orig_organ_donor))'');
    populated_orig_crlf_cnt := COUNT(GROUP,h.orig_crlf <> (TYPEOF(h.orig_crlf))'');
    populated_orig_crlf_pcnt := AVE(GROUP,IF(h.orig_crlf = (TYPEOF(h.orig_crlf))'',0,100));
    maxlength_orig_crlf := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_crlf)));
    avelength_orig_crlf := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_crlf)),h.orig_crlf<>(typeof(h.orig_crlf))'');
    populated_clean_name_prefix_cnt := COUNT(GROUP,h.clean_name_prefix <> (TYPEOF(h.clean_name_prefix))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_name_first_cnt := COUNT(GROUP,h.clean_name_first <> (TYPEOF(h.clean_name_first))'');
    populated_clean_name_first_pcnt := AVE(GROUP,IF(h.clean_name_first = (TYPEOF(h.clean_name_first))'',0,100));
    maxlength_clean_name_first := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_first)));
    avelength_clean_name_first := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_first)),h.clean_name_first<>(typeof(h.clean_name_first))'');
    populated_clean_name_middle_cnt := COUNT(GROUP,h.clean_name_middle <> (TYPEOF(h.clean_name_middle))'');
    populated_clean_name_middle_pcnt := AVE(GROUP,IF(h.clean_name_middle = (TYPEOF(h.clean_name_middle))'',0,100));
    maxlength_clean_name_middle := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_middle)));
    avelength_clean_name_middle := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_middle)),h.clean_name_middle<>(typeof(h.clean_name_middle))'');
    populated_clean_name_last_cnt := COUNT(GROUP,h.clean_name_last <> (TYPEOF(h.clean_name_last))'');
    populated_clean_name_last_pcnt := AVE(GROUP,IF(h.clean_name_last = (TYPEOF(h.clean_name_last))'',0,100));
    maxlength_clean_name_last := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_last)));
    avelength_clean_name_last := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_last)),h.clean_name_last<>(typeof(h.clean_name_last))'');
    populated_clean_name_suffix_cnt := COUNT(GROUP,h.clean_name_suffix <> (TYPEOF(h.clean_name_suffix))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_cnt := COUNT(GROUP,h.clean_name_score <> (TYPEOF(h.clean_name_score))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
    populated_clean_prim_range_cnt := COUNT(GROUP,h.clean_prim_range <> (TYPEOF(h.clean_prim_range))'');
    populated_clean_prim_range_pcnt := AVE(GROUP,IF(h.clean_prim_range = (TYPEOF(h.clean_prim_range))'',0,100));
    maxlength_clean_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_prim_range)));
    avelength_clean_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_prim_range)),h.clean_prim_range<>(typeof(h.clean_prim_range))'');
    populated_clean_predir_cnt := COUNT(GROUP,h.clean_predir <> (TYPEOF(h.clean_predir))'');
    populated_clean_predir_pcnt := AVE(GROUP,IF(h.clean_predir = (TYPEOF(h.clean_predir))'',0,100));
    maxlength_clean_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_predir)));
    avelength_clean_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_predir)),h.clean_predir<>(typeof(h.clean_predir))'');
    populated_clean_prim_name_cnt := COUNT(GROUP,h.clean_prim_name <> (TYPEOF(h.clean_prim_name))'');
    populated_clean_prim_name_pcnt := AVE(GROUP,IF(h.clean_prim_name = (TYPEOF(h.clean_prim_name))'',0,100));
    maxlength_clean_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_prim_name)));
    avelength_clean_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_prim_name)),h.clean_prim_name<>(typeof(h.clean_prim_name))'');
    populated_clean_addr_suffix_cnt := COUNT(GROUP,h.clean_addr_suffix <> (TYPEOF(h.clean_addr_suffix))'');
    populated_clean_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_addr_suffix = (TYPEOF(h.clean_addr_suffix))'',0,100));
    maxlength_clean_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_addr_suffix)));
    avelength_clean_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_addr_suffix)),h.clean_addr_suffix<>(typeof(h.clean_addr_suffix))'');
    populated_clean_postdir_cnt := COUNT(GROUP,h.clean_postdir <> (TYPEOF(h.clean_postdir))'');
    populated_clean_postdir_pcnt := AVE(GROUP,IF(h.clean_postdir = (TYPEOF(h.clean_postdir))'',0,100));
    maxlength_clean_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_postdir)));
    avelength_clean_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_postdir)),h.clean_postdir<>(typeof(h.clean_postdir))'');
    populated_clean_unit_desig_cnt := COUNT(GROUP,h.clean_unit_desig <> (TYPEOF(h.clean_unit_desig))'');
    populated_clean_unit_desig_pcnt := AVE(GROUP,IF(h.clean_unit_desig = (TYPEOF(h.clean_unit_desig))'',0,100));
    maxlength_clean_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_unit_desig)));
    avelength_clean_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_unit_desig)),h.clean_unit_desig<>(typeof(h.clean_unit_desig))'');
    populated_clean_sec_range_cnt := COUNT(GROUP,h.clean_sec_range <> (TYPEOF(h.clean_sec_range))'');
    populated_clean_sec_range_pcnt := AVE(GROUP,IF(h.clean_sec_range = (TYPEOF(h.clean_sec_range))'',0,100));
    maxlength_clean_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_sec_range)));
    avelength_clean_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_sec_range)),h.clean_sec_range<>(typeof(h.clean_sec_range))'');
    populated_clean_p_city_name_cnt := COUNT(GROUP,h.clean_p_city_name <> (TYPEOF(h.clean_p_city_name))'');
    populated_clean_p_city_name_pcnt := AVE(GROUP,IF(h.clean_p_city_name = (TYPEOF(h.clean_p_city_name))'',0,100));
    maxlength_clean_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_p_city_name)));
    avelength_clean_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_p_city_name)),h.clean_p_city_name<>(typeof(h.clean_p_city_name))'');
    populated_clean_v_city_name_cnt := COUNT(GROUP,h.clean_v_city_name <> (TYPEOF(h.clean_v_city_name))'');
    populated_clean_v_city_name_pcnt := AVE(GROUP,IF(h.clean_v_city_name = (TYPEOF(h.clean_v_city_name))'',0,100));
    maxlength_clean_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_v_city_name)));
    avelength_clean_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_v_city_name)),h.clean_v_city_name<>(typeof(h.clean_v_city_name))'');
    populated_clean_st_cnt := COUNT(GROUP,h.clean_st <> (TYPEOF(h.clean_st))'');
    populated_clean_st_pcnt := AVE(GROUP,IF(h.clean_st = (TYPEOF(h.clean_st))'',0,100));
    maxlength_clean_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_st)));
    avelength_clean_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_st)),h.clean_st<>(typeof(h.clean_st))'');
    populated_clean_zip_cnt := COUNT(GROUP,h.clean_zip <> (TYPEOF(h.clean_zip))'');
    populated_clean_zip_pcnt := AVE(GROUP,IF(h.clean_zip = (TYPEOF(h.clean_zip))'',0,100));
    maxlength_clean_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_zip)));
    avelength_clean_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_zip)),h.clean_zip<>(typeof(h.clean_zip))'');
    populated_clean_zip4_cnt := COUNT(GROUP,h.clean_zip4 <> (TYPEOF(h.clean_zip4))'');
    populated_clean_zip4_pcnt := AVE(GROUP,IF(h.clean_zip4 = (TYPEOF(h.clean_zip4))'',0,100));
    maxlength_clean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_zip4)));
    avelength_clean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_zip4)),h.clean_zip4<>(typeof(h.clean_zip4))'');
    populated_clean_cart_cnt := COUNT(GROUP,h.clean_cart <> (TYPEOF(h.clean_cart))'');
    populated_clean_cart_pcnt := AVE(GROUP,IF(h.clean_cart = (TYPEOF(h.clean_cart))'',0,100));
    maxlength_clean_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_cart)));
    avelength_clean_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_cart)),h.clean_cart<>(typeof(h.clean_cart))'');
    populated_clean_cr_sort_sz_cnt := COUNT(GROUP,h.clean_cr_sort_sz <> (TYPEOF(h.clean_cr_sort_sz))'');
    populated_clean_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_cr_sort_sz = (TYPEOF(h.clean_cr_sort_sz))'',0,100));
    maxlength_clean_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_cr_sort_sz)));
    avelength_clean_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_cr_sort_sz)),h.clean_cr_sort_sz<>(typeof(h.clean_cr_sort_sz))'');
    populated_clean_lot_cnt := COUNT(GROUP,h.clean_lot <> (TYPEOF(h.clean_lot))'');
    populated_clean_lot_pcnt := AVE(GROUP,IF(h.clean_lot = (TYPEOF(h.clean_lot))'',0,100));
    maxlength_clean_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_lot)));
    avelength_clean_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_lot)),h.clean_lot<>(typeof(h.clean_lot))'');
    populated_clean_lot_order_cnt := COUNT(GROUP,h.clean_lot_order <> (TYPEOF(h.clean_lot_order))'');
    populated_clean_lot_order_pcnt := AVE(GROUP,IF(h.clean_lot_order = (TYPEOF(h.clean_lot_order))'',0,100));
    maxlength_clean_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_lot_order)));
    avelength_clean_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_lot_order)),h.clean_lot_order<>(typeof(h.clean_lot_order))'');
    populated_clean_dpbc_cnt := COUNT(GROUP,h.clean_dpbc <> (TYPEOF(h.clean_dpbc))'');
    populated_clean_dpbc_pcnt := AVE(GROUP,IF(h.clean_dpbc = (TYPEOF(h.clean_dpbc))'',0,100));
    maxlength_clean_dpbc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_dpbc)));
    avelength_clean_dpbc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_dpbc)),h.clean_dpbc<>(typeof(h.clean_dpbc))'');
    populated_clean_chk_digit_cnt := COUNT(GROUP,h.clean_chk_digit <> (TYPEOF(h.clean_chk_digit))'');
    populated_clean_chk_digit_pcnt := AVE(GROUP,IF(h.clean_chk_digit = (TYPEOF(h.clean_chk_digit))'',0,100));
    maxlength_clean_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_chk_digit)));
    avelength_clean_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_chk_digit)),h.clean_chk_digit<>(typeof(h.clean_chk_digit))'');
    populated_clean_record_type_cnt := COUNT(GROUP,h.clean_record_type <> (TYPEOF(h.clean_record_type))'');
    populated_clean_record_type_pcnt := AVE(GROUP,IF(h.clean_record_type = (TYPEOF(h.clean_record_type))'',0,100));
    maxlength_clean_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_record_type)));
    avelength_clean_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_record_type)),h.clean_record_type<>(typeof(h.clean_record_type))'');
    populated_clean_ace_fips_st_cnt := COUNT(GROUP,h.clean_ace_fips_st <> (TYPEOF(h.clean_ace_fips_st))'');
    populated_clean_ace_fips_st_pcnt := AVE(GROUP,IF(h.clean_ace_fips_st = (TYPEOF(h.clean_ace_fips_st))'',0,100));
    maxlength_clean_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_ace_fips_st)));
    avelength_clean_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_ace_fips_st)),h.clean_ace_fips_st<>(typeof(h.clean_ace_fips_st))'');
    populated_clean_fipscounty_cnt := COUNT(GROUP,h.clean_fipscounty <> (TYPEOF(h.clean_fipscounty))'');
    populated_clean_fipscounty_pcnt := AVE(GROUP,IF(h.clean_fipscounty = (TYPEOF(h.clean_fipscounty))'',0,100));
    maxlength_clean_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_fipscounty)));
    avelength_clean_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_fipscounty)),h.clean_fipscounty<>(typeof(h.clean_fipscounty))'');
    populated_clean_geo_lat_cnt := COUNT(GROUP,h.clean_geo_lat <> (TYPEOF(h.clean_geo_lat))'');
    populated_clean_geo_lat_pcnt := AVE(GROUP,IF(h.clean_geo_lat = (TYPEOF(h.clean_geo_lat))'',0,100));
    maxlength_clean_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_lat)));
    avelength_clean_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_lat)),h.clean_geo_lat<>(typeof(h.clean_geo_lat))'');
    populated_clean_geo_long_cnt := COUNT(GROUP,h.clean_geo_long <> (TYPEOF(h.clean_geo_long))'');
    populated_clean_geo_long_pcnt := AVE(GROUP,IF(h.clean_geo_long = (TYPEOF(h.clean_geo_long))'',0,100));
    maxlength_clean_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_long)));
    avelength_clean_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_long)),h.clean_geo_long<>(typeof(h.clean_geo_long))'');
    populated_clean_msa_cnt := COUNT(GROUP,h.clean_msa <> (TYPEOF(h.clean_msa))'');
    populated_clean_msa_pcnt := AVE(GROUP,IF(h.clean_msa = (TYPEOF(h.clean_msa))'',0,100));
    maxlength_clean_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_msa)));
    avelength_clean_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_msa)),h.clean_msa<>(typeof(h.clean_msa))'');
    populated_clean_geo_blk_cnt := COUNT(GROUP,h.clean_geo_blk <> (TYPEOF(h.clean_geo_blk))'');
    populated_clean_geo_blk_pcnt := AVE(GROUP,IF(h.clean_geo_blk = (TYPEOF(h.clean_geo_blk))'',0,100));
    maxlength_clean_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_blk)));
    avelength_clean_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_blk)),h.clean_geo_blk<>(typeof(h.clean_geo_blk))'');
    populated_clean_geo_match_cnt := COUNT(GROUP,h.clean_geo_match <> (TYPEOF(h.clean_geo_match))'');
    populated_clean_geo_match_pcnt := AVE(GROUP,IF(h.clean_geo_match = (TYPEOF(h.clean_geo_match))'',0,100));
    maxlength_clean_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_match)));
    avelength_clean_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_geo_match)),h.clean_geo_match<>(typeof(h.clean_geo_match))'');
    populated_clean_err_stat_cnt := COUNT(GROUP,h.clean_err_stat <> (TYPEOF(h.clean_err_stat))'');
    populated_clean_err_stat_pcnt := AVE(GROUP,IF(h.clean_err_stat = (TYPEOF(h.clean_err_stat))'',0,100));
    maxlength_clean_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_err_stat)));
    avelength_clean_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_err_stat)),h.clean_err_stat<>(typeof(h.clean_err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_credential_type_pcnt *   0.00 / 100 + T.Populated_orig_id_terminal_date_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mi_pcnt *   0.00 / 100 + T.Populated_orig_namesuf_pcnt *   0.00 / 100 + T.Populated_orig_street_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_drivered_pcnt *   0.00 / 100 + T.Populated_orig_sex_pcnt *   0.00 / 100 + T.Populated_orig_height_pcnt *   0.00 / 100 + T.Populated_orig_height2_pcnt *   0.00 / 100 + T.Populated_orig_weight_pcnt *   0.00 / 100 + T.Populated_orig_hair_pcnt *   0.00 / 100 + T.Populated_orig_eyes_pcnt *   0.00 / 100 + T.Populated_orig_dlexpiredate_pcnt *   0.00 / 100 + T.Populated_orig_dlstat_pcnt *   0.00 / 100 + T.Populated_orig_dlissuedate_pcnt *   0.00 / 100 + T.Populated_orig_originalissuedate_pcnt *   0.00 / 100 + T.Populated_orig_regstatfr_pcnt *   0.00 / 100 + T.Populated_orig_regstatcr_pcnt *   0.00 / 100 + T.Populated_orig_dlclass_pcnt *   0.00 / 100 + T.Populated_orig_historynum_pcnt *   0.00 / 100 + T.Populated_orig_disabledvet_pcnt *   0.00 / 100 + T.Populated_orig_photo_pcnt *   0.00 / 100 + T.Populated_orig_habitualoffender_pcnt *   0.00 / 100 + T.Populated_orig_restrictions_pcnt *   0.00 / 100 + T.Populated_orig_endorsements_pcnt *   0.00 / 100 + T.Populated_orig_endorsements2_pcnt *   0.00 / 100 + T.Populated_orig_endorsements3_pcnt *   0.00 / 100 + T.Populated_orig_endorsements4_pcnt *   0.00 / 100 + T.Populated_orig_endorsements5_pcnt *   0.00 / 100 + T.Populated_orig_endorsements6_pcnt *   0.00 / 100 + T.Populated_orig_endorsements7_pcnt *   0.00 / 100 + T.Populated_orig_endorsements8_pcnt *   0.00 / 100 + T.Populated_orig_endorsements9_pcnt *   0.00 / 100 + T.Populated_orig_endorsements10_pcnt *   0.00 / 100 + T.Populated_orig_endorsements11_20_pcnt *   0.00 / 100 + T.Populated_orig_comm_driv_status_pcnt *   0.00 / 100 + T.Populated_orig_disabled_vet_type_pcnt *   0.00 / 100 + T.Populated_orig_organ_donor_pcnt *   0.00 / 100 + T.Populated_orig_crlf_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_clean_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_predir_pcnt *   0.00 / 100 + T.Populated_clean_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_postdir_pcnt *   0.00 / 100 + T.Populated_clean_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_st_pcnt *   0.00 / 100 + T.Populated_clean_zip_pcnt *   0.00 / 100 + T.Populated_clean_zip4_pcnt *   0.00 / 100 + T.Populated_clean_cart_pcnt *   0.00 / 100 + T.Populated_clean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_lot_pcnt *   0.00 / 100 + T.Populated_clean_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_dpbc_pcnt *   0.00 / 100 + T.Populated_clean_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_record_type_pcnt *   0.00 / 100 + T.Populated_clean_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_clean_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_msa_pcnt *   0.00 / 100 + T.Populated_clean_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'append_process_date','orig_dob','orig_credential_type','orig_id_terminal_date','orig_lname','orig_fname','orig_mi','orig_namesuf','orig_street','orig_city','orig_state','orig_zip','orig_drivered','orig_sex','orig_height','orig_height2','orig_weight','orig_hair','orig_eyes','orig_dlexpiredate','orig_dlstat','orig_dlissuedate','orig_originalissuedate','orig_regstatfr','orig_regstatcr','orig_dlclass','orig_historynum','orig_disabledvet','orig_photo','orig_habitualoffender','orig_restrictions','orig_endorsements','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_endorsements6','orig_endorsements7','orig_endorsements8','orig_endorsements9','orig_endorsements10','orig_endorsements11_20','orig_comm_driv_status','orig_disabled_vet_type','orig_organ_donor','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_credential_type_pcnt,le.populated_orig_id_terminal_date_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mi_pcnt,le.populated_orig_namesuf_pcnt,le.populated_orig_street_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_drivered_pcnt,le.populated_orig_sex_pcnt,le.populated_orig_height_pcnt,le.populated_orig_height2_pcnt,le.populated_orig_weight_pcnt,le.populated_orig_hair_pcnt,le.populated_orig_eyes_pcnt,le.populated_orig_dlexpiredate_pcnt,le.populated_orig_dlstat_pcnt,le.populated_orig_dlissuedate_pcnt,le.populated_orig_originalissuedate_pcnt,le.populated_orig_regstatfr_pcnt,le.populated_orig_regstatcr_pcnt,le.populated_orig_dlclass_pcnt,le.populated_orig_historynum_pcnt,le.populated_orig_disabledvet_pcnt,le.populated_orig_photo_pcnt,le.populated_orig_habitualoffender_pcnt,le.populated_orig_restrictions_pcnt,le.populated_orig_endorsements_pcnt,le.populated_orig_endorsements2_pcnt,le.populated_orig_endorsements3_pcnt,le.populated_orig_endorsements4_pcnt,le.populated_orig_endorsements5_pcnt,le.populated_orig_endorsements6_pcnt,le.populated_orig_endorsements7_pcnt,le.populated_orig_endorsements8_pcnt,le.populated_orig_endorsements9_pcnt,le.populated_orig_endorsements10_pcnt,le.populated_orig_endorsements11_20_pcnt,le.populated_orig_comm_driv_status_pcnt,le.populated_orig_disabled_vet_type_pcnt,le.populated_orig_organ_donor_pcnt,le.populated_orig_crlf_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_clean_prim_range_pcnt,le.populated_clean_predir_pcnt,le.populated_clean_prim_name_pcnt,le.populated_clean_addr_suffix_pcnt,le.populated_clean_postdir_pcnt,le.populated_clean_unit_desig_pcnt,le.populated_clean_sec_range_pcnt,le.populated_clean_p_city_name_pcnt,le.populated_clean_v_city_name_pcnt,le.populated_clean_st_pcnt,le.populated_clean_zip_pcnt,le.populated_clean_zip4_pcnt,le.populated_clean_cart_pcnt,le.populated_clean_cr_sort_sz_pcnt,le.populated_clean_lot_pcnt,le.populated_clean_lot_order_pcnt,le.populated_clean_dpbc_pcnt,le.populated_clean_chk_digit_pcnt,le.populated_clean_record_type_pcnt,le.populated_clean_ace_fips_st_pcnt,le.populated_clean_fipscounty_pcnt,le.populated_clean_geo_lat_pcnt,le.populated_clean_geo_long_pcnt,le.populated_clean_msa_pcnt,le.populated_clean_geo_blk_pcnt,le.populated_clean_geo_match_pcnt,le.populated_clean_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_orig_dob,le.maxlength_orig_credential_type,le.maxlength_orig_id_terminal_date,le.maxlength_orig_lname,le.maxlength_orig_fname,le.maxlength_orig_mi,le.maxlength_orig_namesuf,le.maxlength_orig_street,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_drivered,le.maxlength_orig_sex,le.maxlength_orig_height,le.maxlength_orig_height2,le.maxlength_orig_weight,le.maxlength_orig_hair,le.maxlength_orig_eyes,le.maxlength_orig_dlexpiredate,le.maxlength_orig_dlstat,le.maxlength_orig_dlissuedate,le.maxlength_orig_originalissuedate,le.maxlength_orig_regstatfr,le.maxlength_orig_regstatcr,le.maxlength_orig_dlclass,le.maxlength_orig_historynum,le.maxlength_orig_disabledvet,le.maxlength_orig_photo,le.maxlength_orig_habitualoffender,le.maxlength_orig_restrictions,le.maxlength_orig_endorsements,le.maxlength_orig_endorsements2,le.maxlength_orig_endorsements3,le.maxlength_orig_endorsements4,le.maxlength_orig_endorsements5,le.maxlength_orig_endorsements6,le.maxlength_orig_endorsements7,le.maxlength_orig_endorsements8,le.maxlength_orig_endorsements9,le.maxlength_orig_endorsements10,le.maxlength_orig_endorsements11_20,le.maxlength_orig_comm_driv_status,le.maxlength_orig_disabled_vet_type,le.maxlength_orig_organ_donor,le.maxlength_orig_crlf,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_clean_prim_range,le.maxlength_clean_predir,le.maxlength_clean_prim_name,le.maxlength_clean_addr_suffix,le.maxlength_clean_postdir,le.maxlength_clean_unit_desig,le.maxlength_clean_sec_range,le.maxlength_clean_p_city_name,le.maxlength_clean_v_city_name,le.maxlength_clean_st,le.maxlength_clean_zip,le.maxlength_clean_zip4,le.maxlength_clean_cart,le.maxlength_clean_cr_sort_sz,le.maxlength_clean_lot,le.maxlength_clean_lot_order,le.maxlength_clean_dpbc,le.maxlength_clean_chk_digit,le.maxlength_clean_record_type,le.maxlength_clean_ace_fips_st,le.maxlength_clean_fipscounty,le.maxlength_clean_geo_lat,le.maxlength_clean_geo_long,le.maxlength_clean_msa,le.maxlength_clean_geo_blk,le.maxlength_clean_geo_match,le.maxlength_clean_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_orig_dob,le.avelength_orig_credential_type,le.avelength_orig_id_terminal_date,le.avelength_orig_lname,le.avelength_orig_fname,le.avelength_orig_mi,le.avelength_orig_namesuf,le.avelength_orig_street,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_drivered,le.avelength_orig_sex,le.avelength_orig_height,le.avelength_orig_height2,le.avelength_orig_weight,le.avelength_orig_hair,le.avelength_orig_eyes,le.avelength_orig_dlexpiredate,le.avelength_orig_dlstat,le.avelength_orig_dlissuedate,le.avelength_orig_originalissuedate,le.avelength_orig_regstatfr,le.avelength_orig_regstatcr,le.avelength_orig_dlclass,le.avelength_orig_historynum,le.avelength_orig_disabledvet,le.avelength_orig_photo,le.avelength_orig_habitualoffender,le.avelength_orig_restrictions,le.avelength_orig_endorsements,le.avelength_orig_endorsements2,le.avelength_orig_endorsements3,le.avelength_orig_endorsements4,le.avelength_orig_endorsements5,le.avelength_orig_endorsements6,le.avelength_orig_endorsements7,le.avelength_orig_endorsements8,le.avelength_orig_endorsements9,le.avelength_orig_endorsements10,le.avelength_orig_endorsements11_20,le.avelength_orig_comm_driv_status,le.avelength_orig_disabled_vet_type,le.avelength_orig_organ_donor,le.avelength_orig_crlf,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_clean_prim_range,le.avelength_clean_predir,le.avelength_clean_prim_name,le.avelength_clean_addr_suffix,le.avelength_clean_postdir,le.avelength_clean_unit_desig,le.avelength_clean_sec_range,le.avelength_clean_p_city_name,le.avelength_clean_v_city_name,le.avelength_clean_st,le.avelength_clean_zip,le.avelength_clean_zip4,le.avelength_clean_cart,le.avelength_clean_cr_sort_sz,le.avelength_clean_lot,le.avelength_clean_lot_order,le.avelength_clean_dpbc,le.avelength_clean_chk_digit,le.avelength_clean_record_type,le.avelength_clean_ace_fips_st,le.avelength_clean_fipscounty,le.avelength_clean_geo_lat,le.avelength_clean_geo_long,le.avelength_clean_msa,le.avelength_clean_geo_blk,le.avelength_clean_geo_match,le.avelength_clean_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 79, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.append_process_date),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_credential_type),TRIM((SALT38.StrType)le.orig_id_terminal_date),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_mi),TRIM((SALT38.StrType)le.orig_namesuf),TRIM((SALT38.StrType)le.orig_street),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_drivered),TRIM((SALT38.StrType)le.orig_sex),TRIM((SALT38.StrType)le.orig_height),TRIM((SALT38.StrType)le.orig_height2),TRIM((SALT38.StrType)le.orig_weight),TRIM((SALT38.StrType)le.orig_hair),TRIM((SALT38.StrType)le.orig_eyes),TRIM((SALT38.StrType)le.orig_dlexpiredate),TRIM((SALT38.StrType)le.orig_dlstat),TRIM((SALT38.StrType)le.orig_dlissuedate),TRIM((SALT38.StrType)le.orig_originalissuedate),TRIM((SALT38.StrType)le.orig_regstatfr),TRIM((SALT38.StrType)le.orig_regstatcr),TRIM((SALT38.StrType)le.orig_dlclass),TRIM((SALT38.StrType)le.orig_historynum),TRIM((SALT38.StrType)le.orig_disabledvet),TRIM((SALT38.StrType)le.orig_photo),TRIM((SALT38.StrType)le.orig_habitualoffender),TRIM((SALT38.StrType)le.orig_restrictions),TRIM((SALT38.StrType)le.orig_endorsements),TRIM((SALT38.StrType)le.orig_endorsements2),TRIM((SALT38.StrType)le.orig_endorsements3),TRIM((SALT38.StrType)le.orig_endorsements4),TRIM((SALT38.StrType)le.orig_endorsements5),TRIM((SALT38.StrType)le.orig_endorsements6),TRIM((SALT38.StrType)le.orig_endorsements7),TRIM((SALT38.StrType)le.orig_endorsements8),TRIM((SALT38.StrType)le.orig_endorsements9),TRIM((SALT38.StrType)le.orig_endorsements10),TRIM((SALT38.StrType)le.orig_endorsements11_20),TRIM((SALT38.StrType)le.orig_comm_driv_status),TRIM((SALT38.StrType)le.orig_disabled_vet_type),TRIM((SALT38.StrType)le.orig_organ_donor),TRIM((SALT38.StrType)le.orig_crlf),TRIM((SALT38.StrType)le.clean_name_prefix),TRIM((SALT38.StrType)le.clean_name_first),TRIM((SALT38.StrType)le.clean_name_middle),TRIM((SALT38.StrType)le.clean_name_last),TRIM((SALT38.StrType)le.clean_name_suffix),TRIM((SALT38.StrType)le.clean_name_score),TRIM((SALT38.StrType)le.clean_prim_range),TRIM((SALT38.StrType)le.clean_predir),TRIM((SALT38.StrType)le.clean_prim_name),TRIM((SALT38.StrType)le.clean_addr_suffix),TRIM((SALT38.StrType)le.clean_postdir),TRIM((SALT38.StrType)le.clean_unit_desig),TRIM((SALT38.StrType)le.clean_sec_range),TRIM((SALT38.StrType)le.clean_p_city_name),TRIM((SALT38.StrType)le.clean_v_city_name),TRIM((SALT38.StrType)le.clean_st),TRIM((SALT38.StrType)le.clean_zip),TRIM((SALT38.StrType)le.clean_zip4),TRIM((SALT38.StrType)le.clean_cart),TRIM((SALT38.StrType)le.clean_cr_sort_sz),TRIM((SALT38.StrType)le.clean_lot),TRIM((SALT38.StrType)le.clean_lot_order),TRIM((SALT38.StrType)le.clean_dpbc),TRIM((SALT38.StrType)le.clean_chk_digit),TRIM((SALT38.StrType)le.clean_record_type),TRIM((SALT38.StrType)le.clean_ace_fips_st),TRIM((SALT38.StrType)le.clean_fipscounty),TRIM((SALT38.StrType)le.clean_geo_lat),TRIM((SALT38.StrType)le.clean_geo_long),TRIM((SALT38.StrType)le.clean_msa),TRIM((SALT38.StrType)le.clean_geo_blk),TRIM((SALT38.StrType)le.clean_geo_match),TRIM((SALT38.StrType)le.clean_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,79,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 79);
  SELF.FldNo2 := 1 + (C % 79);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.append_process_date),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_credential_type),TRIM((SALT38.StrType)le.orig_id_terminal_date),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_mi),TRIM((SALT38.StrType)le.orig_namesuf),TRIM((SALT38.StrType)le.orig_street),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_drivered),TRIM((SALT38.StrType)le.orig_sex),TRIM((SALT38.StrType)le.orig_height),TRIM((SALT38.StrType)le.orig_height2),TRIM((SALT38.StrType)le.orig_weight),TRIM((SALT38.StrType)le.orig_hair),TRIM((SALT38.StrType)le.orig_eyes),TRIM((SALT38.StrType)le.orig_dlexpiredate),TRIM((SALT38.StrType)le.orig_dlstat),TRIM((SALT38.StrType)le.orig_dlissuedate),TRIM((SALT38.StrType)le.orig_originalissuedate),TRIM((SALT38.StrType)le.orig_regstatfr),TRIM((SALT38.StrType)le.orig_regstatcr),TRIM((SALT38.StrType)le.orig_dlclass),TRIM((SALT38.StrType)le.orig_historynum),TRIM((SALT38.StrType)le.orig_disabledvet),TRIM((SALT38.StrType)le.orig_photo),TRIM((SALT38.StrType)le.orig_habitualoffender),TRIM((SALT38.StrType)le.orig_restrictions),TRIM((SALT38.StrType)le.orig_endorsements),TRIM((SALT38.StrType)le.orig_endorsements2),TRIM((SALT38.StrType)le.orig_endorsements3),TRIM((SALT38.StrType)le.orig_endorsements4),TRIM((SALT38.StrType)le.orig_endorsements5),TRIM((SALT38.StrType)le.orig_endorsements6),TRIM((SALT38.StrType)le.orig_endorsements7),TRIM((SALT38.StrType)le.orig_endorsements8),TRIM((SALT38.StrType)le.orig_endorsements9),TRIM((SALT38.StrType)le.orig_endorsements10),TRIM((SALT38.StrType)le.orig_endorsements11_20),TRIM((SALT38.StrType)le.orig_comm_driv_status),TRIM((SALT38.StrType)le.orig_disabled_vet_type),TRIM((SALT38.StrType)le.orig_organ_donor),TRIM((SALT38.StrType)le.orig_crlf),TRIM((SALT38.StrType)le.clean_name_prefix),TRIM((SALT38.StrType)le.clean_name_first),TRIM((SALT38.StrType)le.clean_name_middle),TRIM((SALT38.StrType)le.clean_name_last),TRIM((SALT38.StrType)le.clean_name_suffix),TRIM((SALT38.StrType)le.clean_name_score),TRIM((SALT38.StrType)le.clean_prim_range),TRIM((SALT38.StrType)le.clean_predir),TRIM((SALT38.StrType)le.clean_prim_name),TRIM((SALT38.StrType)le.clean_addr_suffix),TRIM((SALT38.StrType)le.clean_postdir),TRIM((SALT38.StrType)le.clean_unit_desig),TRIM((SALT38.StrType)le.clean_sec_range),TRIM((SALT38.StrType)le.clean_p_city_name),TRIM((SALT38.StrType)le.clean_v_city_name),TRIM((SALT38.StrType)le.clean_st),TRIM((SALT38.StrType)le.clean_zip),TRIM((SALT38.StrType)le.clean_zip4),TRIM((SALT38.StrType)le.clean_cart),TRIM((SALT38.StrType)le.clean_cr_sort_sz),TRIM((SALT38.StrType)le.clean_lot),TRIM((SALT38.StrType)le.clean_lot_order),TRIM((SALT38.StrType)le.clean_dpbc),TRIM((SALT38.StrType)le.clean_chk_digit),TRIM((SALT38.StrType)le.clean_record_type),TRIM((SALT38.StrType)le.clean_ace_fips_st),TRIM((SALT38.StrType)le.clean_fipscounty),TRIM((SALT38.StrType)le.clean_geo_lat),TRIM((SALT38.StrType)le.clean_geo_long),TRIM((SALT38.StrType)le.clean_msa),TRIM((SALT38.StrType)le.clean_geo_blk),TRIM((SALT38.StrType)le.clean_geo_match),TRIM((SALT38.StrType)le.clean_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.append_process_date),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_credential_type),TRIM((SALT38.StrType)le.orig_id_terminal_date),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_mi),TRIM((SALT38.StrType)le.orig_namesuf),TRIM((SALT38.StrType)le.orig_street),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_drivered),TRIM((SALT38.StrType)le.orig_sex),TRIM((SALT38.StrType)le.orig_height),TRIM((SALT38.StrType)le.orig_height2),TRIM((SALT38.StrType)le.orig_weight),TRIM((SALT38.StrType)le.orig_hair),TRIM((SALT38.StrType)le.orig_eyes),TRIM((SALT38.StrType)le.orig_dlexpiredate),TRIM((SALT38.StrType)le.orig_dlstat),TRIM((SALT38.StrType)le.orig_dlissuedate),TRIM((SALT38.StrType)le.orig_originalissuedate),TRIM((SALT38.StrType)le.orig_regstatfr),TRIM((SALT38.StrType)le.orig_regstatcr),TRIM((SALT38.StrType)le.orig_dlclass),TRIM((SALT38.StrType)le.orig_historynum),TRIM((SALT38.StrType)le.orig_disabledvet),TRIM((SALT38.StrType)le.orig_photo),TRIM((SALT38.StrType)le.orig_habitualoffender),TRIM((SALT38.StrType)le.orig_restrictions),TRIM((SALT38.StrType)le.orig_endorsements),TRIM((SALT38.StrType)le.orig_endorsements2),TRIM((SALT38.StrType)le.orig_endorsements3),TRIM((SALT38.StrType)le.orig_endorsements4),TRIM((SALT38.StrType)le.orig_endorsements5),TRIM((SALT38.StrType)le.orig_endorsements6),TRIM((SALT38.StrType)le.orig_endorsements7),TRIM((SALT38.StrType)le.orig_endorsements8),TRIM((SALT38.StrType)le.orig_endorsements9),TRIM((SALT38.StrType)le.orig_endorsements10),TRIM((SALT38.StrType)le.orig_endorsements11_20),TRIM((SALT38.StrType)le.orig_comm_driv_status),TRIM((SALT38.StrType)le.orig_disabled_vet_type),TRIM((SALT38.StrType)le.orig_organ_donor),TRIM((SALT38.StrType)le.orig_crlf),TRIM((SALT38.StrType)le.clean_name_prefix),TRIM((SALT38.StrType)le.clean_name_first),TRIM((SALT38.StrType)le.clean_name_middle),TRIM((SALT38.StrType)le.clean_name_last),TRIM((SALT38.StrType)le.clean_name_suffix),TRIM((SALT38.StrType)le.clean_name_score),TRIM((SALT38.StrType)le.clean_prim_range),TRIM((SALT38.StrType)le.clean_predir),TRIM((SALT38.StrType)le.clean_prim_name),TRIM((SALT38.StrType)le.clean_addr_suffix),TRIM((SALT38.StrType)le.clean_postdir),TRIM((SALT38.StrType)le.clean_unit_desig),TRIM((SALT38.StrType)le.clean_sec_range),TRIM((SALT38.StrType)le.clean_p_city_name),TRIM((SALT38.StrType)le.clean_v_city_name),TRIM((SALT38.StrType)le.clean_st),TRIM((SALT38.StrType)le.clean_zip),TRIM((SALT38.StrType)le.clean_zip4),TRIM((SALT38.StrType)le.clean_cart),TRIM((SALT38.StrType)le.clean_cr_sort_sz),TRIM((SALT38.StrType)le.clean_lot),TRIM((SALT38.StrType)le.clean_lot_order),TRIM((SALT38.StrType)le.clean_dpbc),TRIM((SALT38.StrType)le.clean_chk_digit),TRIM((SALT38.StrType)le.clean_record_type),TRIM((SALT38.StrType)le.clean_ace_fips_st),TRIM((SALT38.StrType)le.clean_fipscounty),TRIM((SALT38.StrType)le.clean_geo_lat),TRIM((SALT38.StrType)le.clean_geo_long),TRIM((SALT38.StrType)le.clean_msa),TRIM((SALT38.StrType)le.clean_geo_blk),TRIM((SALT38.StrType)le.clean_geo_match),TRIM((SALT38.StrType)le.clean_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),79*79,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'orig_dob'}
      ,{3,'orig_credential_type'}
      ,{4,'orig_id_terminal_date'}
      ,{5,'orig_lname'}
      ,{6,'orig_fname'}
      ,{7,'orig_mi'}
      ,{8,'orig_namesuf'}
      ,{9,'orig_street'}
      ,{10,'orig_city'}
      ,{11,'orig_state'}
      ,{12,'orig_zip'}
      ,{13,'orig_drivered'}
      ,{14,'orig_sex'}
      ,{15,'orig_height'}
      ,{16,'orig_height2'}
      ,{17,'orig_weight'}
      ,{18,'orig_hair'}
      ,{19,'orig_eyes'}
      ,{20,'orig_dlexpiredate'}
      ,{21,'orig_dlstat'}
      ,{22,'orig_dlissuedate'}
      ,{23,'orig_originalissuedate'}
      ,{24,'orig_regstatfr'}
      ,{25,'orig_regstatcr'}
      ,{26,'orig_dlclass'}
      ,{27,'orig_historynum'}
      ,{28,'orig_disabledvet'}
      ,{29,'orig_photo'}
      ,{30,'orig_habitualoffender'}
      ,{31,'orig_restrictions'}
      ,{32,'orig_endorsements'}
      ,{33,'orig_endorsements2'}
      ,{34,'orig_endorsements3'}
      ,{35,'orig_endorsements4'}
      ,{36,'orig_endorsements5'}
      ,{37,'orig_endorsements6'}
      ,{38,'orig_endorsements7'}
      ,{39,'orig_endorsements8'}
      ,{40,'orig_endorsements9'}
      ,{41,'orig_endorsements10'}
      ,{42,'orig_endorsements11_20'}
      ,{43,'orig_comm_driv_status'}
      ,{44,'orig_disabled_vet_type'}
      ,{45,'orig_organ_donor'}
      ,{46,'orig_crlf'}
      ,{47,'clean_name_prefix'}
      ,{48,'clean_name_first'}
      ,{49,'clean_name_middle'}
      ,{50,'clean_name_last'}
      ,{51,'clean_name_suffix'}
      ,{52,'clean_name_score'}
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
      ,{69,'clean_dpbc'}
      ,{70,'clean_chk_digit'}
      ,{71,'clean_record_type'}
      ,{72,'clean_ace_fips_st'}
      ,{73,'clean_fipscounty'}
      ,{74,'clean_geo_lat'}
      ,{75,'clean_geo_long'}
      ,{76,'clean_msa'}
      ,{77,'clean_geo_blk'}
      ,{78,'clean_geo_match'}
      ,{79,'clean_err_stat'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_append_process_date((SALT38.StrType)le.append_process_date),
    Fields.InValid_orig_dob((SALT38.StrType)le.orig_dob),
    Fields.InValid_orig_credential_type((SALT38.StrType)le.orig_credential_type),
    Fields.InValid_orig_id_terminal_date((SALT38.StrType)le.orig_id_terminal_date),
    Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname,(SALT38.StrType)le.orig_fname),
    Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname,(SALT38.StrType)le.orig_lname),
    Fields.InValid_orig_mi((SALT38.StrType)le.orig_mi),
    Fields.InValid_orig_namesuf((SALT38.StrType)le.orig_namesuf),
    Fields.InValid_orig_street((SALT38.StrType)le.orig_street),
    Fields.InValid_orig_city((SALT38.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT38.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT38.StrType)le.orig_zip),
    Fields.InValid_orig_drivered((SALT38.StrType)le.orig_drivered),
    Fields.InValid_orig_sex((SALT38.StrType)le.orig_sex),
    Fields.InValid_orig_height((SALT38.StrType)le.orig_height),
    Fields.InValid_orig_height2((SALT38.StrType)le.orig_height2),
    Fields.InValid_orig_weight((SALT38.StrType)le.orig_weight),
    Fields.InValid_orig_hair((SALT38.StrType)le.orig_hair),
    Fields.InValid_orig_eyes((SALT38.StrType)le.orig_eyes),
    Fields.InValid_orig_dlexpiredate((SALT38.StrType)le.orig_dlexpiredate),
    Fields.InValid_orig_dlstat((SALT38.StrType)le.orig_dlstat),
    Fields.InValid_orig_dlissuedate((SALT38.StrType)le.orig_dlissuedate),
    Fields.InValid_orig_originalissuedate((SALT38.StrType)le.orig_originalissuedate),
    Fields.InValid_orig_regstatfr((SALT38.StrType)le.orig_regstatfr),
    Fields.InValid_orig_regstatcr((SALT38.StrType)le.orig_regstatcr),
    Fields.InValid_orig_dlclass((SALT38.StrType)le.orig_dlclass),
    Fields.InValid_orig_historynum((SALT38.StrType)le.orig_historynum),
    Fields.InValid_orig_disabledvet((SALT38.StrType)le.orig_disabledvet),
    Fields.InValid_orig_photo((SALT38.StrType)le.orig_photo),
    Fields.InValid_orig_habitualoffender((SALT38.StrType)le.orig_habitualoffender),
    Fields.InValid_orig_restrictions((SALT38.StrType)le.orig_restrictions),
    Fields.InValid_orig_endorsements((SALT38.StrType)le.orig_endorsements),
    Fields.InValid_orig_endorsements2((SALT38.StrType)le.orig_endorsements2),
    Fields.InValid_orig_endorsements3((SALT38.StrType)le.orig_endorsements3),
    Fields.InValid_orig_endorsements4((SALT38.StrType)le.orig_endorsements4),
    Fields.InValid_orig_endorsements5((SALT38.StrType)le.orig_endorsements5),
    Fields.InValid_orig_endorsements6((SALT38.StrType)le.orig_endorsements6),
    Fields.InValid_orig_endorsements7((SALT38.StrType)le.orig_endorsements7),
    Fields.InValid_orig_endorsements8((SALT38.StrType)le.orig_endorsements8),
    Fields.InValid_orig_endorsements9((SALT38.StrType)le.orig_endorsements9),
    Fields.InValid_orig_endorsements10((SALT38.StrType)le.orig_endorsements10),
    Fields.InValid_orig_endorsements11_20((SALT38.StrType)le.orig_endorsements11_20),
    Fields.InValid_orig_comm_driv_status((SALT38.StrType)le.orig_comm_driv_status),
    Fields.InValid_orig_disabled_vet_type((SALT38.StrType)le.orig_disabled_vet_type),
    Fields.InValid_orig_organ_donor((SALT38.StrType)le.orig_organ_donor),
    Fields.InValid_orig_crlf((SALT38.StrType)le.orig_crlf),
    Fields.InValid_clean_name_prefix((SALT38.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.Clean_name_last),
    Fields.InValid_clean_name_middle((SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.Clean_name_last),
    Fields.InValid_clean_name_last((SALT38.StrType)le.clean_name_last,(SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_suffix((SALT38.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT38.StrType)le.clean_name_score),
    Fields.InValid_clean_prim_range((SALT38.StrType)le.clean_prim_range),
    Fields.InValid_clean_predir((SALT38.StrType)le.clean_predir),
    Fields.InValid_clean_prim_name((SALT38.StrType)le.clean_prim_name),
    Fields.InValid_clean_addr_suffix((SALT38.StrType)le.clean_addr_suffix),
    Fields.InValid_clean_postdir((SALT38.StrType)le.clean_postdir),
    Fields.InValid_clean_unit_desig((SALT38.StrType)le.clean_unit_desig),
    Fields.InValid_clean_sec_range((SALT38.StrType)le.clean_sec_range),
    Fields.InValid_clean_p_city_name((SALT38.StrType)le.clean_p_city_name),
    Fields.InValid_clean_v_city_name((SALT38.StrType)le.clean_v_city_name),
    Fields.InValid_clean_st((SALT38.StrType)le.clean_st),
    Fields.InValid_clean_zip((SALT38.StrType)le.clean_zip),
    Fields.InValid_clean_zip4((SALT38.StrType)le.clean_zip4),
    Fields.InValid_clean_cart((SALT38.StrType)le.clean_cart),
    Fields.InValid_clean_cr_sort_sz((SALT38.StrType)le.clean_cr_sort_sz),
    Fields.InValid_clean_lot((SALT38.StrType)le.clean_lot),
    Fields.InValid_clean_lot_order((SALT38.StrType)le.clean_lot_order),
    Fields.InValid_clean_dpbc((SALT38.StrType)le.clean_dpbc),
    Fields.InValid_clean_chk_digit((SALT38.StrType)le.clean_chk_digit),
    Fields.InValid_clean_record_type((SALT38.StrType)le.clean_record_type),
    Fields.InValid_clean_ace_fips_st((SALT38.StrType)le.clean_ace_fips_st),
    Fields.InValid_clean_fipscounty((SALT38.StrType)le.clean_fipscounty),
    Fields.InValid_clean_geo_lat((SALT38.StrType)le.clean_geo_lat),
    Fields.InValid_clean_geo_long((SALT38.StrType)le.clean_geo_long),
    Fields.InValid_clean_msa((SALT38.StrType)le.clean_msa),
    Fields.InValid_clean_geo_blk((SALT38.StrType)le.clean_geo_blk),
    Fields.InValid_clean_geo_match((SALT38.StrType)le.clean_geo_match),
    Fields.InValid_clean_err_stat((SALT38.StrType)le.clean_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,79,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_process_date','invalid_Past_Date','invalid_orig_credential_type','invalid_Past_Date','invalid_orig_lname','invalid_orig_fname','invalid_Alpha','Unknown','invalid_mandatory','invalid_mandatory','invalid_orig_state','invalid_orig_zip','Unknown','invalid_orig_sex','invalid_Num','invalid_Num','invalid_Num','invalid_orig_hair','invalid_orig_eyes','invalid_General_Date','invalid_orig_dlstat','invalid_Past_Date','invalid_Past_Date','invalid_boolean','invalid_boolean','invalid_orig_dlclass','invalid_Num','Unknown','Unknown','Unknown','invalid_Alpha_Numeric','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','Unknown','invalid_orig_comm_driv_status','Unknown','invalid_boolean','Unknown','Unknown','invalid_clean_name_first','invalid_clean_name_middle','invalid_clean_name_last','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_orig_state','invalid_zip5','invalid_zip4','invalid_clean_cart','Unknown','invalid_clean_lot','invalid_clean_lot_order','invalid_clean_dpbc','invalid_clean_chk_digit','Unknown','invalid_clean_fips_state','invalid_clean_fips_county','invalid_clean_geo','invalid_clean_geo','invalid_clean_msa','Unknown','invalid_clean_geo_match','invalid_clean_err_stat');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_credential_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_id_terminal_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mi(TotalErrors.ErrorNum),Fields.InValidMessage_orig_namesuf(TotalErrors.ErrorNum),Fields.InValidMessage_orig_street(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_drivered(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sex(TotalErrors.ErrorNum),Fields.InValidMessage_orig_height(TotalErrors.ErrorNum),Fields.InValidMessage_orig_height2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_weight(TotalErrors.ErrorNum),Fields.InValidMessage_orig_hair(TotalErrors.ErrorNum),Fields.InValidMessage_orig_eyes(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlexpiredate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlstat(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlissuedate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_originalissuedate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_regstatfr(TotalErrors.ErrorNum),Fields.InValidMessage_orig_regstatcr(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlclass(TotalErrors.ErrorNum),Fields.InValidMessage_orig_historynum(TotalErrors.ErrorNum),Fields.InValidMessage_orig_disabledvet(TotalErrors.ErrorNum),Fields.InValidMessage_orig_photo(TotalErrors.ErrorNum),Fields.InValidMessage_orig_habitualoffender(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements6(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements7(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements8(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements9(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements10(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements11_20(TotalErrors.ErrorNum),Fields.InValidMessage_orig_comm_driv_status(TotalErrors.ErrorNum),Fields.InValidMessage_orig_disabled_vet_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_organ_donor(TotalErrors.ErrorNum),Fields.InValidMessage_orig_crlf(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_ME_MEDCERT, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
