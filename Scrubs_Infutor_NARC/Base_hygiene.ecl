IMPORT SALT38,STD;
EXPORT Base_hygiene(dataset(Base_layout_Infutor_NARC) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_hhid_cnt := COUNT(GROUP,h.orig_hhid <> (TYPEOF(h.orig_hhid))'');
    populated_orig_hhid_pcnt := AVE(GROUP,IF(h.orig_hhid = (TYPEOF(h.orig_hhid))'',0,100));
    maxlength_orig_hhid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_hhid)));
    avelength_orig_hhid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_hhid)),h.orig_hhid<>(typeof(h.orig_hhid))'');
    populated_orig_pid_cnt := COUNT(GROUP,h.orig_pid <> (TYPEOF(h.orig_pid))'');
    populated_orig_pid_pcnt := AVE(GROUP,IF(h.orig_pid = (TYPEOF(h.orig_pid))'',0,100));
    maxlength_orig_pid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_pid)));
    avelength_orig_pid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_pid)),h.orig_pid<>(typeof(h.orig_pid))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_suffix_cnt := COUNT(GROUP,h.orig_suffix <> (TYPEOF(h.orig_suffix))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
    populated_orig_gender_cnt := COUNT(GROUP,h.orig_gender <> (TYPEOF(h.orig_gender))'');
    populated_orig_gender_pcnt := AVE(GROUP,IF(h.orig_gender = (TYPEOF(h.orig_gender))'',0,100));
    maxlength_orig_gender := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_gender)));
    avelength_orig_gender := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_gender)),h.orig_gender<>(typeof(h.orig_gender))'');
    populated_orig_age_cnt := COUNT(GROUP,h.orig_age <> (TYPEOF(h.orig_age))'');
    populated_orig_age_pcnt := AVE(GROUP,IF(h.orig_age = (TYPEOF(h.orig_age))'',0,100));
    maxlength_orig_age := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_age)));
    avelength_orig_age := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_age)),h.orig_age<>(typeof(h.orig_age))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_hhnbr_cnt := COUNT(GROUP,h.orig_hhnbr <> (TYPEOF(h.orig_hhnbr))'');
    populated_orig_hhnbr_pcnt := AVE(GROUP,IF(h.orig_hhnbr = (TYPEOF(h.orig_hhnbr))'',0,100));
    maxlength_orig_hhnbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_hhnbr)));
    avelength_orig_hhnbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_hhnbr)),h.orig_hhnbr<>(typeof(h.orig_hhnbr))'');
    populated_orig_tot_males_cnt := COUNT(GROUP,h.orig_tot_males <> (TYPEOF(h.orig_tot_males))'');
    populated_orig_tot_males_pcnt := AVE(GROUP,IF(h.orig_tot_males = (TYPEOF(h.orig_tot_males))'',0,100));
    maxlength_orig_tot_males := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_tot_males)));
    avelength_orig_tot_males := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_tot_males)),h.orig_tot_males<>(typeof(h.orig_tot_males))'');
    populated_orig_tot_females_cnt := COUNT(GROUP,h.orig_tot_females <> (TYPEOF(h.orig_tot_females))'');
    populated_orig_tot_females_pcnt := AVE(GROUP,IF(h.orig_tot_females = (TYPEOF(h.orig_tot_females))'',0,100));
    maxlength_orig_tot_females := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_tot_females)));
    avelength_orig_tot_females := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_tot_females)),h.orig_tot_females<>(typeof(h.orig_tot_females))'');
    populated_orig_addrid_cnt := COUNT(GROUP,h.orig_addrid <> (TYPEOF(h.orig_addrid))'');
    populated_orig_addrid_pcnt := AVE(GROUP,IF(h.orig_addrid = (TYPEOF(h.orig_addrid))'',0,100));
    maxlength_orig_addrid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_addrid)));
    avelength_orig_addrid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_addrid)),h.orig_addrid<>(typeof(h.orig_addrid))'');
    populated_orig_address_cnt := COUNT(GROUP,h.orig_address <> (TYPEOF(h.orig_address))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_house_cnt := COUNT(GROUP,h.orig_house <> (TYPEOF(h.orig_house))'');
    populated_orig_house_pcnt := AVE(GROUP,IF(h.orig_house = (TYPEOF(h.orig_house))'',0,100));
    maxlength_orig_house := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_house)));
    avelength_orig_house := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_house)),h.orig_house<>(typeof(h.orig_house))'');
    populated_orig_predir_cnt := COUNT(GROUP,h.orig_predir <> (TYPEOF(h.orig_predir))'');
    populated_orig_predir_pcnt := AVE(GROUP,IF(h.orig_predir = (TYPEOF(h.orig_predir))'',0,100));
    maxlength_orig_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_predir)));
    avelength_orig_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_predir)),h.orig_predir<>(typeof(h.orig_predir))'');
    populated_orig_street_cnt := COUNT(GROUP,h.orig_street <> (TYPEOF(h.orig_street))'');
    populated_orig_street_pcnt := AVE(GROUP,IF(h.orig_street = (TYPEOF(h.orig_street))'',0,100));
    maxlength_orig_street := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_street)));
    avelength_orig_street := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_street)),h.orig_street<>(typeof(h.orig_street))'');
    populated_orig_strtype_cnt := COUNT(GROUP,h.orig_strtype <> (TYPEOF(h.orig_strtype))'');
    populated_orig_strtype_pcnt := AVE(GROUP,IF(h.orig_strtype = (TYPEOF(h.orig_strtype))'',0,100));
    maxlength_orig_strtype := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_strtype)));
    avelength_orig_strtype := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_strtype)),h.orig_strtype<>(typeof(h.orig_strtype))'');
    populated_orig_postdir_cnt := COUNT(GROUP,h.orig_postdir <> (TYPEOF(h.orig_postdir))'');
    populated_orig_postdir_pcnt := AVE(GROUP,IF(h.orig_postdir = (TYPEOF(h.orig_postdir))'',0,100));
    maxlength_orig_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_postdir)));
    avelength_orig_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_postdir)),h.orig_postdir<>(typeof(h.orig_postdir))'');
    populated_orig_apttype_cnt := COUNT(GROUP,h.orig_apttype <> (TYPEOF(h.orig_apttype))'');
    populated_orig_apttype_pcnt := AVE(GROUP,IF(h.orig_apttype = (TYPEOF(h.orig_apttype))'',0,100));
    maxlength_orig_apttype := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_apttype)));
    avelength_orig_apttype := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_apttype)),h.orig_apttype<>(typeof(h.orig_apttype))'');
    populated_orig_aptnbr_cnt := COUNT(GROUP,h.orig_aptnbr <> (TYPEOF(h.orig_aptnbr))'');
    populated_orig_aptnbr_pcnt := AVE(GROUP,IF(h.orig_aptnbr = (TYPEOF(h.orig_aptnbr))'',0,100));
    maxlength_orig_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_aptnbr)));
    avelength_orig_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_aptnbr)),h.orig_aptnbr<>(typeof(h.orig_aptnbr))'');
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
    populated_orig_z4_cnt := COUNT(GROUP,h.orig_z4 <> (TYPEOF(h.orig_z4))'');
    populated_orig_z4_pcnt := AVE(GROUP,IF(h.orig_z4 = (TYPEOF(h.orig_z4))'',0,100));
    maxlength_orig_z4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_z4)));
    avelength_orig_z4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_z4)),h.orig_z4<>(typeof(h.orig_z4))'');
    populated_orig_dpc_cnt := COUNT(GROUP,h.orig_dpc <> (TYPEOF(h.orig_dpc))'');
    populated_orig_dpc_pcnt := AVE(GROUP,IF(h.orig_dpc = (TYPEOF(h.orig_dpc))'',0,100));
    maxlength_orig_dpc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dpc)));
    avelength_orig_dpc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dpc)),h.orig_dpc<>(typeof(h.orig_dpc))'');
    populated_orig_z4type_cnt := COUNT(GROUP,h.orig_z4type <> (TYPEOF(h.orig_z4type))'');
    populated_orig_z4type_pcnt := AVE(GROUP,IF(h.orig_z4type = (TYPEOF(h.orig_z4type))'',0,100));
    maxlength_orig_z4type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_z4type)));
    avelength_orig_z4type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_z4type)),h.orig_z4type<>(typeof(h.orig_z4type))'');
    populated_orig_crte_cnt := COUNT(GROUP,h.orig_crte <> (TYPEOF(h.orig_crte))'');
    populated_orig_crte_pcnt := AVE(GROUP,IF(h.orig_crte = (TYPEOF(h.orig_crte))'',0,100));
    maxlength_orig_crte := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_crte)));
    avelength_orig_crte := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_crte)),h.orig_crte<>(typeof(h.orig_crte))'');
    populated_orig_dpv_cnt := COUNT(GROUP,h.orig_dpv <> (TYPEOF(h.orig_dpv))'');
    populated_orig_dpv_pcnt := AVE(GROUP,IF(h.orig_dpv = (TYPEOF(h.orig_dpv))'',0,100));
    maxlength_orig_dpv := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dpv)));
    avelength_orig_dpv := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dpv)),h.orig_dpv<>(typeof(h.orig_dpv))'');
    populated_orig_vacant_cnt := COUNT(GROUP,h.orig_vacant <> (TYPEOF(h.orig_vacant))'');
    populated_orig_vacant_pcnt := AVE(GROUP,IF(h.orig_vacant = (TYPEOF(h.orig_vacant))'',0,100));
    maxlength_orig_vacant := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_vacant)));
    avelength_orig_vacant := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_vacant)),h.orig_vacant<>(typeof(h.orig_vacant))'');
    populated_orig_msa_cnt := COUNT(GROUP,h.orig_msa <> (TYPEOF(h.orig_msa))'');
    populated_orig_msa_pcnt := AVE(GROUP,IF(h.orig_msa = (TYPEOF(h.orig_msa))'',0,100));
    maxlength_orig_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_msa)));
    avelength_orig_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_msa)),h.orig_msa<>(typeof(h.orig_msa))'');
    populated_orig_cbsa_cnt := COUNT(GROUP,h.orig_cbsa <> (TYPEOF(h.orig_cbsa))'');
    populated_orig_cbsa_pcnt := AVE(GROUP,IF(h.orig_cbsa = (TYPEOF(h.orig_cbsa))'',0,100));
    maxlength_orig_cbsa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_cbsa)));
    avelength_orig_cbsa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_cbsa)),h.orig_cbsa<>(typeof(h.orig_cbsa))'');
    populated_orig_county_code_cnt := COUNT(GROUP,h.orig_county_code <> (TYPEOF(h.orig_county_code))'');
    populated_orig_county_code_pcnt := AVE(GROUP,IF(h.orig_county_code = (TYPEOF(h.orig_county_code))'',0,100));
    maxlength_orig_county_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_county_code)));
    avelength_orig_county_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_county_code)),h.orig_county_code<>(typeof(h.orig_county_code))'');
    populated_orig_time_zone_cnt := COUNT(GROUP,h.orig_time_zone <> (TYPEOF(h.orig_time_zone))'');
    populated_orig_time_zone_pcnt := AVE(GROUP,IF(h.orig_time_zone = (TYPEOF(h.orig_time_zone))'',0,100));
    maxlength_orig_time_zone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_time_zone)));
    avelength_orig_time_zone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_time_zone)),h.orig_time_zone<>(typeof(h.orig_time_zone))'');
    populated_orig_daylight_savings_cnt := COUNT(GROUP,h.orig_daylight_savings <> (TYPEOF(h.orig_daylight_savings))'');
    populated_orig_daylight_savings_pcnt := AVE(GROUP,IF(h.orig_daylight_savings = (TYPEOF(h.orig_daylight_savings))'',0,100));
    maxlength_orig_daylight_savings := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_daylight_savings)));
    avelength_orig_daylight_savings := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_daylight_savings)),h.orig_daylight_savings<>(typeof(h.orig_daylight_savings))'');
    populated_orig_lat_long_assignment_level_cnt := COUNT(GROUP,h.orig_lat_long_assignment_level <> (TYPEOF(h.orig_lat_long_assignment_level))'');
    populated_orig_lat_long_assignment_level_pcnt := AVE(GROUP,IF(h.orig_lat_long_assignment_level = (TYPEOF(h.orig_lat_long_assignment_level))'',0,100));
    maxlength_orig_lat_long_assignment_level := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lat_long_assignment_level)));
    avelength_orig_lat_long_assignment_level := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lat_long_assignment_level)),h.orig_lat_long_assignment_level<>(typeof(h.orig_lat_long_assignment_level))'');
    populated_orig_latitude_cnt := COUNT(GROUP,h.orig_latitude <> (TYPEOF(h.orig_latitude))'');
    populated_orig_latitude_pcnt := AVE(GROUP,IF(h.orig_latitude = (TYPEOF(h.orig_latitude))'',0,100));
    maxlength_orig_latitude := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_latitude)));
    avelength_orig_latitude := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_latitude)),h.orig_latitude<>(typeof(h.orig_latitude))'');
    populated_orig_longitude_cnt := COUNT(GROUP,h.orig_longitude <> (TYPEOF(h.orig_longitude))'');
    populated_orig_longitude_pcnt := AVE(GROUP,IF(h.orig_longitude = (TYPEOF(h.orig_longitude))'',0,100));
    maxlength_orig_longitude := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_longitude)));
    avelength_orig_longitude := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_longitude)),h.orig_longitude<>(typeof(h.orig_longitude))'');
    populated_orig_telephonenumber_1_cnt := COUNT(GROUP,h.orig_telephonenumber_1 <> (TYPEOF(h.orig_telephonenumber_1))'');
    populated_orig_telephonenumber_1_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_1 = (TYPEOF(h.orig_telephonenumber_1))'',0,100));
    maxlength_orig_telephonenumber_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_1)));
    avelength_orig_telephonenumber_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_1)),h.orig_telephonenumber_1<>(typeof(h.orig_telephonenumber_1))'');
    populated_orig_validationflag_1_cnt := COUNT(GROUP,h.orig_validationflag_1 <> (TYPEOF(h.orig_validationflag_1))'');
    populated_orig_validationflag_1_pcnt := AVE(GROUP,IF(h.orig_validationflag_1 = (TYPEOF(h.orig_validationflag_1))'',0,100));
    maxlength_orig_validationflag_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_1)));
    avelength_orig_validationflag_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_1)),h.orig_validationflag_1<>(typeof(h.orig_validationflag_1))'');
    populated_orig_validationdate_1_cnt := COUNT(GROUP,h.orig_validationdate_1 <> (TYPEOF(h.orig_validationdate_1))'');
    populated_orig_validationdate_1_pcnt := AVE(GROUP,IF(h.orig_validationdate_1 = (TYPEOF(h.orig_validationdate_1))'',0,100));
    maxlength_orig_validationdate_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_1)));
    avelength_orig_validationdate_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_1)),h.orig_validationdate_1<>(typeof(h.orig_validationdate_1))'');
    populated_orig_dma_tps_dnc_flag_1_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_1 <> (TYPEOF(h.orig_dma_tps_dnc_flag_1))'');
    populated_orig_dma_tps_dnc_flag_1_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_1 = (TYPEOF(h.orig_dma_tps_dnc_flag_1))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_1)));
    avelength_orig_dma_tps_dnc_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_1)),h.orig_dma_tps_dnc_flag_1<>(typeof(h.orig_dma_tps_dnc_flag_1))'');
    populated_orig_telephonenumber_2_cnt := COUNT(GROUP,h.orig_telephonenumber_2 <> (TYPEOF(h.orig_telephonenumber_2))'');
    populated_orig_telephonenumber_2_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_2 = (TYPEOF(h.orig_telephonenumber_2))'',0,100));
    maxlength_orig_telephonenumber_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_2)));
    avelength_orig_telephonenumber_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_2)),h.orig_telephonenumber_2<>(typeof(h.orig_telephonenumber_2))'');
    populated_orig_validation_flag_2_cnt := COUNT(GROUP,h.orig_validation_flag_2 <> (TYPEOF(h.orig_validation_flag_2))'');
    populated_orig_validation_flag_2_pcnt := AVE(GROUP,IF(h.orig_validation_flag_2 = (TYPEOF(h.orig_validation_flag_2))'',0,100));
    maxlength_orig_validation_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validation_flag_2)));
    avelength_orig_validation_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validation_flag_2)),h.orig_validation_flag_2<>(typeof(h.orig_validation_flag_2))'');
    populated_orig_validation_date_2_cnt := COUNT(GROUP,h.orig_validation_date_2 <> (TYPEOF(h.orig_validation_date_2))'');
    populated_orig_validation_date_2_pcnt := AVE(GROUP,IF(h.orig_validation_date_2 = (TYPEOF(h.orig_validation_date_2))'',0,100));
    maxlength_orig_validation_date_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validation_date_2)));
    avelength_orig_validation_date_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validation_date_2)),h.orig_validation_date_2<>(typeof(h.orig_validation_date_2))'');
    populated_orig_dma_tps_dnc_flag_2_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_2 <> (TYPEOF(h.orig_dma_tps_dnc_flag_2))'');
    populated_orig_dma_tps_dnc_flag_2_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_2 = (TYPEOF(h.orig_dma_tps_dnc_flag_2))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_2)));
    avelength_orig_dma_tps_dnc_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_2)),h.orig_dma_tps_dnc_flag_2<>(typeof(h.orig_dma_tps_dnc_flag_2))'');
    populated_orig_telephonenumber_3_cnt := COUNT(GROUP,h.orig_telephonenumber_3 <> (TYPEOF(h.orig_telephonenumber_3))'');
    populated_orig_telephonenumber_3_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_3 = (TYPEOF(h.orig_telephonenumber_3))'',0,100));
    maxlength_orig_telephonenumber_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_3)));
    avelength_orig_telephonenumber_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_3)),h.orig_telephonenumber_3<>(typeof(h.orig_telephonenumber_3))'');
    populated_orig_validationflag_3_cnt := COUNT(GROUP,h.orig_validationflag_3 <> (TYPEOF(h.orig_validationflag_3))'');
    populated_orig_validationflag_3_pcnt := AVE(GROUP,IF(h.orig_validationflag_3 = (TYPEOF(h.orig_validationflag_3))'',0,100));
    maxlength_orig_validationflag_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_3)));
    avelength_orig_validationflag_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_3)),h.orig_validationflag_3<>(typeof(h.orig_validationflag_3))'');
    populated_orig_validationdate_3_cnt := COUNT(GROUP,h.orig_validationdate_3 <> (TYPEOF(h.orig_validationdate_3))'');
    populated_orig_validationdate_3_pcnt := AVE(GROUP,IF(h.orig_validationdate_3 = (TYPEOF(h.orig_validationdate_3))'',0,100));
    maxlength_orig_validationdate_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_3)));
    avelength_orig_validationdate_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_3)),h.orig_validationdate_3<>(typeof(h.orig_validationdate_3))'');
    populated_orig_dma_tps_dnc_flag_3_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_3 <> (TYPEOF(h.orig_dma_tps_dnc_flag_3))'');
    populated_orig_dma_tps_dnc_flag_3_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_3 = (TYPEOF(h.orig_dma_tps_dnc_flag_3))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_3)));
    avelength_orig_dma_tps_dnc_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_3)),h.orig_dma_tps_dnc_flag_3<>(typeof(h.orig_dma_tps_dnc_flag_3))'');
    populated_orig_telephonenumber_4_cnt := COUNT(GROUP,h.orig_telephonenumber_4 <> (TYPEOF(h.orig_telephonenumber_4))'');
    populated_orig_telephonenumber_4_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_4 = (TYPEOF(h.orig_telephonenumber_4))'',0,100));
    maxlength_orig_telephonenumber_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_4)));
    avelength_orig_telephonenumber_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_4)),h.orig_telephonenumber_4<>(typeof(h.orig_telephonenumber_4))'');
    populated_orig_validationflag_4_cnt := COUNT(GROUP,h.orig_validationflag_4 <> (TYPEOF(h.orig_validationflag_4))'');
    populated_orig_validationflag_4_pcnt := AVE(GROUP,IF(h.orig_validationflag_4 = (TYPEOF(h.orig_validationflag_4))'',0,100));
    maxlength_orig_validationflag_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_4)));
    avelength_orig_validationflag_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_4)),h.orig_validationflag_4<>(typeof(h.orig_validationflag_4))'');
    populated_orig_validationdate_4_cnt := COUNT(GROUP,h.orig_validationdate_4 <> (TYPEOF(h.orig_validationdate_4))'');
    populated_orig_validationdate_4_pcnt := AVE(GROUP,IF(h.orig_validationdate_4 = (TYPEOF(h.orig_validationdate_4))'',0,100));
    maxlength_orig_validationdate_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_4)));
    avelength_orig_validationdate_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_4)),h.orig_validationdate_4<>(typeof(h.orig_validationdate_4))'');
    populated_orig_dma_tps_dnc_flag_4_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_4 <> (TYPEOF(h.orig_dma_tps_dnc_flag_4))'');
    populated_orig_dma_tps_dnc_flag_4_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_4 = (TYPEOF(h.orig_dma_tps_dnc_flag_4))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_4)));
    avelength_orig_dma_tps_dnc_flag_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_4)),h.orig_dma_tps_dnc_flag_4<>(typeof(h.orig_dma_tps_dnc_flag_4))'');
    populated_orig_telephonenumber_5_cnt := COUNT(GROUP,h.orig_telephonenumber_5 <> (TYPEOF(h.orig_telephonenumber_5))'');
    populated_orig_telephonenumber_5_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_5 = (TYPEOF(h.orig_telephonenumber_5))'',0,100));
    maxlength_orig_telephonenumber_5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_5)));
    avelength_orig_telephonenumber_5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_5)),h.orig_telephonenumber_5<>(typeof(h.orig_telephonenumber_5))'');
    populated_orig_validationflag_5_cnt := COUNT(GROUP,h.orig_validationflag_5 <> (TYPEOF(h.orig_validationflag_5))'');
    populated_orig_validationflag_5_pcnt := AVE(GROUP,IF(h.orig_validationflag_5 = (TYPEOF(h.orig_validationflag_5))'',0,100));
    maxlength_orig_validationflag_5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_5)));
    avelength_orig_validationflag_5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_5)),h.orig_validationflag_5<>(typeof(h.orig_validationflag_5))'');
    populated_orig_validationdate_5_cnt := COUNT(GROUP,h.orig_validationdate_5 <> (TYPEOF(h.orig_validationdate_5))'');
    populated_orig_validationdate_5_pcnt := AVE(GROUP,IF(h.orig_validationdate_5 = (TYPEOF(h.orig_validationdate_5))'',0,100));
    maxlength_orig_validationdate_5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_5)));
    avelength_orig_validationdate_5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_5)),h.orig_validationdate_5<>(typeof(h.orig_validationdate_5))'');
    populated_orig_dma_tps_dnc_flag_5_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_5 <> (TYPEOF(h.orig_dma_tps_dnc_flag_5))'');
    populated_orig_dma_tps_dnc_flag_5_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_5 = (TYPEOF(h.orig_dma_tps_dnc_flag_5))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_5)));
    avelength_orig_dma_tps_dnc_flag_5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_5)),h.orig_dma_tps_dnc_flag_5<>(typeof(h.orig_dma_tps_dnc_flag_5))'');
    populated_orig_telephonenumber_6_cnt := COUNT(GROUP,h.orig_telephonenumber_6 <> (TYPEOF(h.orig_telephonenumber_6))'');
    populated_orig_telephonenumber_6_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_6 = (TYPEOF(h.orig_telephonenumber_6))'',0,100));
    maxlength_orig_telephonenumber_6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_6)));
    avelength_orig_telephonenumber_6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_6)),h.orig_telephonenumber_6<>(typeof(h.orig_telephonenumber_6))'');
    populated_orig_validationflag_6_cnt := COUNT(GROUP,h.orig_validationflag_6 <> (TYPEOF(h.orig_validationflag_6))'');
    populated_orig_validationflag_6_pcnt := AVE(GROUP,IF(h.orig_validationflag_6 = (TYPEOF(h.orig_validationflag_6))'',0,100));
    maxlength_orig_validationflag_6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_6)));
    avelength_orig_validationflag_6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_6)),h.orig_validationflag_6<>(typeof(h.orig_validationflag_6))'');
    populated_orig_validationdate_6_cnt := COUNT(GROUP,h.orig_validationdate_6 <> (TYPEOF(h.orig_validationdate_6))'');
    populated_orig_validationdate_6_pcnt := AVE(GROUP,IF(h.orig_validationdate_6 = (TYPEOF(h.orig_validationdate_6))'',0,100));
    maxlength_orig_validationdate_6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_6)));
    avelength_orig_validationdate_6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_6)),h.orig_validationdate_6<>(typeof(h.orig_validationdate_6))'');
    populated_orig_dma_tps_dnc_flag_6_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_6 <> (TYPEOF(h.orig_dma_tps_dnc_flag_6))'');
    populated_orig_dma_tps_dnc_flag_6_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_6 = (TYPEOF(h.orig_dma_tps_dnc_flag_6))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_6)));
    avelength_orig_dma_tps_dnc_flag_6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_6)),h.orig_dma_tps_dnc_flag_6<>(typeof(h.orig_dma_tps_dnc_flag_6))'');
    populated_orig_telephonenumber_7_cnt := COUNT(GROUP,h.orig_telephonenumber_7 <> (TYPEOF(h.orig_telephonenumber_7))'');
    populated_orig_telephonenumber_7_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_7 = (TYPEOF(h.orig_telephonenumber_7))'',0,100));
    maxlength_orig_telephonenumber_7 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_7)));
    avelength_orig_telephonenumber_7 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_telephonenumber_7)),h.orig_telephonenumber_7<>(typeof(h.orig_telephonenumber_7))'');
    populated_orig_validationflag_7_cnt := COUNT(GROUP,h.orig_validationflag_7 <> (TYPEOF(h.orig_validationflag_7))'');
    populated_orig_validationflag_7_pcnt := AVE(GROUP,IF(h.orig_validationflag_7 = (TYPEOF(h.orig_validationflag_7))'',0,100));
    maxlength_orig_validationflag_7 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_7)));
    avelength_orig_validationflag_7 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationflag_7)),h.orig_validationflag_7<>(typeof(h.orig_validationflag_7))'');
    populated_orig_validationdate_7_cnt := COUNT(GROUP,h.orig_validationdate_7 <> (TYPEOF(h.orig_validationdate_7))'');
    populated_orig_validationdate_7_pcnt := AVE(GROUP,IF(h.orig_validationdate_7 = (TYPEOF(h.orig_validationdate_7))'',0,100));
    maxlength_orig_validationdate_7 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_7)));
    avelength_orig_validationdate_7 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_validationdate_7)),h.orig_validationdate_7<>(typeof(h.orig_validationdate_7))'');
    populated_orig_dma_tps_dnc_flag_7_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_7 <> (TYPEOF(h.orig_dma_tps_dnc_flag_7))'');
    populated_orig_dma_tps_dnc_flag_7_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_7 = (TYPEOF(h.orig_dma_tps_dnc_flag_7))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_7 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_7)));
    avelength_orig_dma_tps_dnc_flag_7 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dma_tps_dnc_flag_7)),h.orig_dma_tps_dnc_flag_7<>(typeof(h.orig_dma_tps_dnc_flag_7))'');
    populated_orig_tot_phones_cnt := COUNT(GROUP,h.orig_tot_phones <> (TYPEOF(h.orig_tot_phones))'');
    populated_orig_tot_phones_pcnt := AVE(GROUP,IF(h.orig_tot_phones = (TYPEOF(h.orig_tot_phones))'',0,100));
    maxlength_orig_tot_phones := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_tot_phones)));
    avelength_orig_tot_phones := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_tot_phones)),h.orig_tot_phones<>(typeof(h.orig_tot_phones))'');
    populated_orig_length_of_residence_cnt := COUNT(GROUP,h.orig_length_of_residence <> (TYPEOF(h.orig_length_of_residence))'');
    populated_orig_length_of_residence_pcnt := AVE(GROUP,IF(h.orig_length_of_residence = (TYPEOF(h.orig_length_of_residence))'',0,100));
    maxlength_orig_length_of_residence := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_length_of_residence)));
    avelength_orig_length_of_residence := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_length_of_residence)),h.orig_length_of_residence<>(typeof(h.orig_length_of_residence))'');
    populated_orig_homeowner_cnt := COUNT(GROUP,h.orig_homeowner <> (TYPEOF(h.orig_homeowner))'');
    populated_orig_homeowner_pcnt := AVE(GROUP,IF(h.orig_homeowner = (TYPEOF(h.orig_homeowner))'',0,100));
    maxlength_orig_homeowner := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_homeowner)));
    avelength_orig_homeowner := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_homeowner)),h.orig_homeowner<>(typeof(h.orig_homeowner))'');
    populated_orig_estimatedincome_cnt := COUNT(GROUP,h.orig_estimatedincome <> (TYPEOF(h.orig_estimatedincome))'');
    populated_orig_estimatedincome_pcnt := AVE(GROUP,IF(h.orig_estimatedincome = (TYPEOF(h.orig_estimatedincome))'',0,100));
    maxlength_orig_estimatedincome := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_estimatedincome)));
    avelength_orig_estimatedincome := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_estimatedincome)),h.orig_estimatedincome<>(typeof(h.orig_estimatedincome))'');
    populated_orig_dwelling_type_cnt := COUNT(GROUP,h.orig_dwelling_type <> (TYPEOF(h.orig_dwelling_type))'');
    populated_orig_dwelling_type_pcnt := AVE(GROUP,IF(h.orig_dwelling_type = (TYPEOF(h.orig_dwelling_type))'',0,100));
    maxlength_orig_dwelling_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dwelling_type)));
    avelength_orig_dwelling_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_dwelling_type)),h.orig_dwelling_type<>(typeof(h.orig_dwelling_type))'');
    populated_orig_married_cnt := COUNT(GROUP,h.orig_married <> (TYPEOF(h.orig_married))'');
    populated_orig_married_pcnt := AVE(GROUP,IF(h.orig_married = (TYPEOF(h.orig_married))'',0,100));
    maxlength_orig_married := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_married)));
    avelength_orig_married := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_married)),h.orig_married<>(typeof(h.orig_married))'');
    populated_orig_child_cnt := COUNT(GROUP,h.orig_child <> (TYPEOF(h.orig_child))'');
    populated_orig_child_pcnt := AVE(GROUP,IF(h.orig_child = (TYPEOF(h.orig_child))'',0,100));
    maxlength_orig_child := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_child)));
    avelength_orig_child := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_child)),h.orig_child<>(typeof(h.orig_child))'');
    populated_orig_nbrchild_cnt := COUNT(GROUP,h.orig_nbrchild <> (TYPEOF(h.orig_nbrchild))'');
    populated_orig_nbrchild_pcnt := AVE(GROUP,IF(h.orig_nbrchild = (TYPEOF(h.orig_nbrchild))'',0,100));
    maxlength_orig_nbrchild := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_nbrchild)));
    avelength_orig_nbrchild := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_nbrchild)),h.orig_nbrchild<>(typeof(h.orig_nbrchild))'');
    populated_orig_teencd_cnt := COUNT(GROUP,h.orig_teencd <> (TYPEOF(h.orig_teencd))'');
    populated_orig_teencd_pcnt := AVE(GROUP,IF(h.orig_teencd = (TYPEOF(h.orig_teencd))'',0,100));
    maxlength_orig_teencd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_teencd)));
    avelength_orig_teencd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_teencd)),h.orig_teencd<>(typeof(h.orig_teencd))'');
    populated_orig_percent_range_black_cnt := COUNT(GROUP,h.orig_percent_range_black <> (TYPEOF(h.orig_percent_range_black))'');
    populated_orig_percent_range_black_pcnt := AVE(GROUP,IF(h.orig_percent_range_black = (TYPEOF(h.orig_percent_range_black))'',0,100));
    maxlength_orig_percent_range_black := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_black)));
    avelength_orig_percent_range_black := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_black)),h.orig_percent_range_black<>(typeof(h.orig_percent_range_black))'');
    populated_orig_percent_range_white_cnt := COUNT(GROUP,h.orig_percent_range_white <> (TYPEOF(h.orig_percent_range_white))'');
    populated_orig_percent_range_white_pcnt := AVE(GROUP,IF(h.orig_percent_range_white = (TYPEOF(h.orig_percent_range_white))'',0,100));
    maxlength_orig_percent_range_white := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_white)));
    avelength_orig_percent_range_white := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_white)),h.orig_percent_range_white<>(typeof(h.orig_percent_range_white))'');
    populated_orig_percent_range_hispanic_cnt := COUNT(GROUP,h.orig_percent_range_hispanic <> (TYPEOF(h.orig_percent_range_hispanic))'');
    populated_orig_percent_range_hispanic_pcnt := AVE(GROUP,IF(h.orig_percent_range_hispanic = (TYPEOF(h.orig_percent_range_hispanic))'',0,100));
    maxlength_orig_percent_range_hispanic := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_hispanic)));
    avelength_orig_percent_range_hispanic := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_hispanic)),h.orig_percent_range_hispanic<>(typeof(h.orig_percent_range_hispanic))'');
    populated_orig_percent_range_asian_cnt := COUNT(GROUP,h.orig_percent_range_asian <> (TYPEOF(h.orig_percent_range_asian))'');
    populated_orig_percent_range_asian_pcnt := AVE(GROUP,IF(h.orig_percent_range_asian = (TYPEOF(h.orig_percent_range_asian))'',0,100));
    maxlength_orig_percent_range_asian := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_asian)));
    avelength_orig_percent_range_asian := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_asian)),h.orig_percent_range_asian<>(typeof(h.orig_percent_range_asian))'');
    populated_orig_percent_range_english_speaking_cnt := COUNT(GROUP,h.orig_percent_range_english_speaking <> (TYPEOF(h.orig_percent_range_english_speaking))'');
    populated_orig_percent_range_english_speaking_pcnt := AVE(GROUP,IF(h.orig_percent_range_english_speaking = (TYPEOF(h.orig_percent_range_english_speaking))'',0,100));
    maxlength_orig_percent_range_english_speaking := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_english_speaking)));
    avelength_orig_percent_range_english_speaking := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_english_speaking)),h.orig_percent_range_english_speaking<>(typeof(h.orig_percent_range_english_speaking))'');
    populated_orig_percnt_range_spanish_speaking_cnt := COUNT(GROUP,h.orig_percnt_range_spanish_speaking <> (TYPEOF(h.orig_percnt_range_spanish_speaking))'');
    populated_orig_percnt_range_spanish_speaking_pcnt := AVE(GROUP,IF(h.orig_percnt_range_spanish_speaking = (TYPEOF(h.orig_percnt_range_spanish_speaking))'',0,100));
    maxlength_orig_percnt_range_spanish_speaking := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percnt_range_spanish_speaking)));
    avelength_orig_percnt_range_spanish_speaking := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percnt_range_spanish_speaking)),h.orig_percnt_range_spanish_speaking<>(typeof(h.orig_percnt_range_spanish_speaking))'');
    populated_orig_percent_range_asian_speaking_cnt := COUNT(GROUP,h.orig_percent_range_asian_speaking <> (TYPEOF(h.orig_percent_range_asian_speaking))'');
    populated_orig_percent_range_asian_speaking_pcnt := AVE(GROUP,IF(h.orig_percent_range_asian_speaking = (TYPEOF(h.orig_percent_range_asian_speaking))'',0,100));
    maxlength_orig_percent_range_asian_speaking := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_asian_speaking)));
    avelength_orig_percent_range_asian_speaking := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_asian_speaking)),h.orig_percent_range_asian_speaking<>(typeof(h.orig_percent_range_asian_speaking))'');
    populated_orig_percent_range_sfdu_cnt := COUNT(GROUP,h.orig_percent_range_sfdu <> (TYPEOF(h.orig_percent_range_sfdu))'');
    populated_orig_percent_range_sfdu_pcnt := AVE(GROUP,IF(h.orig_percent_range_sfdu = (TYPEOF(h.orig_percent_range_sfdu))'',0,100));
    maxlength_orig_percent_range_sfdu := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_sfdu)));
    avelength_orig_percent_range_sfdu := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_sfdu)),h.orig_percent_range_sfdu<>(typeof(h.orig_percent_range_sfdu))'');
    populated_orig_percent_range_mfdu_cnt := COUNT(GROUP,h.orig_percent_range_mfdu <> (TYPEOF(h.orig_percent_range_mfdu))'');
    populated_orig_percent_range_mfdu_pcnt := AVE(GROUP,IF(h.orig_percent_range_mfdu = (TYPEOF(h.orig_percent_range_mfdu))'',0,100));
    maxlength_orig_percent_range_mfdu := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_mfdu)));
    avelength_orig_percent_range_mfdu := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_percent_range_mfdu)),h.orig_percent_range_mfdu<>(typeof(h.orig_percent_range_mfdu))'');
    populated_orig_mhv_cnt := COUNT(GROUP,h.orig_mhv <> (TYPEOF(h.orig_mhv))'');
    populated_orig_mhv_pcnt := AVE(GROUP,IF(h.orig_mhv = (TYPEOF(h.orig_mhv))'',0,100));
    maxlength_orig_mhv := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mhv)));
    avelength_orig_mhv := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mhv)),h.orig_mhv<>(typeof(h.orig_mhv))'');
    populated_orig_mor_cnt := COUNT(GROUP,h.orig_mor <> (TYPEOF(h.orig_mor))'');
    populated_orig_mor_pcnt := AVE(GROUP,IF(h.orig_mor = (TYPEOF(h.orig_mor))'',0,100));
    maxlength_orig_mor := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mor)));
    avelength_orig_mor := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mor)),h.orig_mor<>(typeof(h.orig_mor))'');
    populated_orig_car_cnt := COUNT(GROUP,h.orig_car <> (TYPEOF(h.orig_car))'');
    populated_orig_car_pcnt := AVE(GROUP,IF(h.orig_car = (TYPEOF(h.orig_car))'',0,100));
    maxlength_orig_car := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_car)));
    avelength_orig_car := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_car)),h.orig_car<>(typeof(h.orig_car))'');
    populated_orig_medschl_cnt := COUNT(GROUP,h.orig_medschl <> (TYPEOF(h.orig_medschl))'');
    populated_orig_medschl_pcnt := AVE(GROUP,IF(h.orig_medschl = (TYPEOF(h.orig_medschl))'',0,100));
    maxlength_orig_medschl := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_medschl)));
    avelength_orig_medschl := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_medschl)),h.orig_medschl<>(typeof(h.orig_medschl))'');
    populated_orig_penetration_range_whitecollar_cnt := COUNT(GROUP,h.orig_penetration_range_whitecollar <> (TYPEOF(h.orig_penetration_range_whitecollar))'');
    populated_orig_penetration_range_whitecollar_pcnt := AVE(GROUP,IF(h.orig_penetration_range_whitecollar = (TYPEOF(h.orig_penetration_range_whitecollar))'',0,100));
    maxlength_orig_penetration_range_whitecollar := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_penetration_range_whitecollar)));
    avelength_orig_penetration_range_whitecollar := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_penetration_range_whitecollar)),h.orig_penetration_range_whitecollar<>(typeof(h.orig_penetration_range_whitecollar))'');
    populated_orig_penetration_range_bluecollar_cnt := COUNT(GROUP,h.orig_penetration_range_bluecollar <> (TYPEOF(h.orig_penetration_range_bluecollar))'');
    populated_orig_penetration_range_bluecollar_pcnt := AVE(GROUP,IF(h.orig_penetration_range_bluecollar = (TYPEOF(h.orig_penetration_range_bluecollar))'',0,100));
    maxlength_orig_penetration_range_bluecollar := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_penetration_range_bluecollar)));
    avelength_orig_penetration_range_bluecollar := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_penetration_range_bluecollar)),h.orig_penetration_range_bluecollar<>(typeof(h.orig_penetration_range_bluecollar))'');
    populated_orig_penetration_range_otheroccupation_cnt := COUNT(GROUP,h.orig_penetration_range_otheroccupation <> (TYPEOF(h.orig_penetration_range_otheroccupation))'');
    populated_orig_penetration_range_otheroccupation_pcnt := AVE(GROUP,IF(h.orig_penetration_range_otheroccupation = (TYPEOF(h.orig_penetration_range_otheroccupation))'',0,100));
    maxlength_orig_penetration_range_otheroccupation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_penetration_range_otheroccupation)));
    avelength_orig_penetration_range_otheroccupation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_penetration_range_otheroccupation)),h.orig_penetration_range_otheroccupation<>(typeof(h.orig_penetration_range_otheroccupation))'');
    populated_orig_demolevel_cnt := COUNT(GROUP,h.orig_demolevel <> (TYPEOF(h.orig_demolevel))'');
    populated_orig_demolevel_pcnt := AVE(GROUP,IF(h.orig_demolevel = (TYPEOF(h.orig_demolevel))'',0,100));
    maxlength_orig_demolevel := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_demolevel)));
    avelength_orig_demolevel := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_demolevel)),h.orig_demolevel<>(typeof(h.orig_demolevel))'');
    populated_orig_recdate_cnt := COUNT(GROUP,h.orig_recdate <> (TYPEOF(h.orig_recdate))'');
    populated_orig_recdate_pcnt := AVE(GROUP,IF(h.orig_recdate = (TYPEOF(h.orig_recdate))'',0,100));
    maxlength_orig_recdate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_recdate)));
    avelength_orig_recdate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_recdate)),h.orig_recdate<>(typeof(h.orig_recdate))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_st_cnt := COUNT(GROUP,h.fips_st <> (TYPEOF(h.fips_st))'');
    populated_fips_st_pcnt := AVE(GROUP,IF(h.fips_st = (TYPEOF(h.fips_st))'',0,100));
    maxlength_fips_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_st)));
    avelength_fips_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_st)),h.fips_st<>(typeof(h.fips_st))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_dob_cnt := COUNT(GROUP,h.clean_dob <> (TYPEOF(h.clean_dob))'');
    populated_clean_dob_pcnt := AVE(GROUP,IF(h.clean_dob = (TYPEOF(h.clean_dob))'',0,100));
    maxlength_clean_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_dob)));
    avelength_clean_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.clean_dob)),h.clean_dob<>(typeof(h.clean_dob))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_cnt := COUNT(GROUP,h.date_vendor_first_reported <> (TYPEOF(h.date_vendor_first_reported))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_cnt := COUNT(GROUP,h.date_vendor_last_reported <> (TYPEOF(h.date_vendor_last_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_src_cnt := COUNT(GROUP,h.src <> (TYPEOF(h.src))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_Lexhhid_cnt := COUNT(GROUP,h.Lexhhid <> (TYPEOF(h.Lexhhid))'');
    populated_Lexhhid_pcnt := AVE(GROUP,IF(h.Lexhhid = (TYPEOF(h.Lexhhid))'',0,100));
    maxlength_Lexhhid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.Lexhhid)));
    avelength_Lexhhid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.Lexhhid)),h.Lexhhid<>(typeof(h.Lexhhid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_hhid_pcnt *   0.00 / 100 + T.Populated_orig_pid_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_orig_gender_pcnt *   0.00 / 100 + T.Populated_orig_age_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_hhnbr_pcnt *   0.00 / 100 + T.Populated_orig_tot_males_pcnt *   0.00 / 100 + T.Populated_orig_tot_females_pcnt *   0.00 / 100 + T.Populated_orig_addrid_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_house_pcnt *   0.00 / 100 + T.Populated_orig_predir_pcnt *   0.00 / 100 + T.Populated_orig_street_pcnt *   0.00 / 100 + T.Populated_orig_strtype_pcnt *   0.00 / 100 + T.Populated_orig_postdir_pcnt *   0.00 / 100 + T.Populated_orig_apttype_pcnt *   0.00 / 100 + T.Populated_orig_aptnbr_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_z4_pcnt *   0.00 / 100 + T.Populated_orig_dpc_pcnt *   0.00 / 100 + T.Populated_orig_z4type_pcnt *   0.00 / 100 + T.Populated_orig_crte_pcnt *   0.00 / 100 + T.Populated_orig_dpv_pcnt *   0.00 / 100 + T.Populated_orig_vacant_pcnt *   0.00 / 100 + T.Populated_orig_msa_pcnt *   0.00 / 100 + T.Populated_orig_cbsa_pcnt *   0.00 / 100 + T.Populated_orig_county_code_pcnt *   0.00 / 100 + T.Populated_orig_time_zone_pcnt *   0.00 / 100 + T.Populated_orig_daylight_savings_pcnt *   0.00 / 100 + T.Populated_orig_lat_long_assignment_level_pcnt *   0.00 / 100 + T.Populated_orig_latitude_pcnt *   0.00 / 100 + T.Populated_orig_longitude_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_1_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_1_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_1_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_1_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_2_pcnt *   0.00 / 100 + T.Populated_orig_validation_flag_2_pcnt *   0.00 / 100 + T.Populated_orig_validation_date_2_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_2_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_3_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_3_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_3_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_3_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_4_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_4_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_4_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_4_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_5_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_5_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_5_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_5_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_6_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_6_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_6_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_6_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_7_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_7_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_7_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_7_pcnt *   0.00 / 100 + T.Populated_orig_tot_phones_pcnt *   0.00 / 100 + T.Populated_orig_length_of_residence_pcnt *   0.00 / 100 + T.Populated_orig_homeowner_pcnt *   0.00 / 100 + T.Populated_orig_estimatedincome_pcnt *   0.00 / 100 + T.Populated_orig_dwelling_type_pcnt *   0.00 / 100 + T.Populated_orig_married_pcnt *   0.00 / 100 + T.Populated_orig_child_pcnt *   0.00 / 100 + T.Populated_orig_nbrchild_pcnt *   0.00 / 100 + T.Populated_orig_teencd_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_black_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_white_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_hispanic_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_asian_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_english_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percnt_range_spanish_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_asian_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_sfdu_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_mfdu_pcnt *   0.00 / 100 + T.Populated_orig_mhv_pcnt *   0.00 / 100 + T.Populated_orig_mor_pcnt *   0.00 / 100 + T.Populated_orig_car_pcnt *   0.00 / 100 + T.Populated_orig_medschl_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_whitecollar_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_bluecollar_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_otheroccupation_pcnt *   0.00 / 100 + T.Populated_orig_demolevel_pcnt *   0.00 / 100 + T.Populated_orig_recdate_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_st_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_dob_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_Lexhhid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'orig_hhid','orig_pid','orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_tot_males','orig_tot_females','orig_addrid','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_dpc','orig_z4type','orig_crte','orig_dpv','orig_vacant','orig_msa','orig_cbsa','orig_county_code','orig_time_zone','orig_daylight_savings','orig_lat_long_assignment_level','orig_latitude','orig_longitude','orig_telephonenumber_1','orig_validationflag_1','orig_validationdate_1','orig_dma_tps_dnc_flag_1','orig_telephonenumber_2','orig_validation_flag_2','orig_validation_date_2','orig_dma_tps_dnc_flag_2','orig_telephonenumber_3','orig_validationflag_3','orig_validationdate_3','orig_dma_tps_dnc_flag_3','orig_telephonenumber_4','orig_validationflag_4','orig_validationdate_4','orig_dma_tps_dnc_flag_4','orig_telephonenumber_5','orig_validationflag_5','orig_validationdate_5','orig_dma_tps_dnc_flag_5','orig_telephonenumber_6','orig_validationflag_6','orig_validationdate_6','orig_dma_tps_dnc_flag_6','orig_telephonenumber_7','orig_validationflag_7','orig_validationdate_7','orig_dma_tps_dnc_flag_7','orig_tot_phones','orig_length_of_residence','orig_homeowner','orig_estimatedincome','orig_dwelling_type','orig_married','orig_child','orig_nbrchild','orig_teencd','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_whitecollar','orig_penetration_range_bluecollar','orig_penetration_range_otheroccupation','orig_demolevel','orig_recdate','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','did','did_score','clean_phone','clean_dob','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','record_type','src','rawaid','Lexhhid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_hhid_pcnt,le.populated_orig_pid_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_suffix_pcnt,le.populated_orig_gender_pcnt,le.populated_orig_age_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_hhnbr_pcnt,le.populated_orig_tot_males_pcnt,le.populated_orig_tot_females_pcnt,le.populated_orig_addrid_pcnt,le.populated_orig_address_pcnt,le.populated_orig_house_pcnt,le.populated_orig_predir_pcnt,le.populated_orig_street_pcnt,le.populated_orig_strtype_pcnt,le.populated_orig_postdir_pcnt,le.populated_orig_apttype_pcnt,le.populated_orig_aptnbr_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_z4_pcnt,le.populated_orig_dpc_pcnt,le.populated_orig_z4type_pcnt,le.populated_orig_crte_pcnt,le.populated_orig_dpv_pcnt,le.populated_orig_vacant_pcnt,le.populated_orig_msa_pcnt,le.populated_orig_cbsa_pcnt,le.populated_orig_county_code_pcnt,le.populated_orig_time_zone_pcnt,le.populated_orig_daylight_savings_pcnt,le.populated_orig_lat_long_assignment_level_pcnt,le.populated_orig_latitude_pcnt,le.populated_orig_longitude_pcnt,le.populated_orig_telephonenumber_1_pcnt,le.populated_orig_validationflag_1_pcnt,le.populated_orig_validationdate_1_pcnt,le.populated_orig_dma_tps_dnc_flag_1_pcnt,le.populated_orig_telephonenumber_2_pcnt,le.populated_orig_validation_flag_2_pcnt,le.populated_orig_validation_date_2_pcnt,le.populated_orig_dma_tps_dnc_flag_2_pcnt,le.populated_orig_telephonenumber_3_pcnt,le.populated_orig_validationflag_3_pcnt,le.populated_orig_validationdate_3_pcnt,le.populated_orig_dma_tps_dnc_flag_3_pcnt,le.populated_orig_telephonenumber_4_pcnt,le.populated_orig_validationflag_4_pcnt,le.populated_orig_validationdate_4_pcnt,le.populated_orig_dma_tps_dnc_flag_4_pcnt,le.populated_orig_telephonenumber_5_pcnt,le.populated_orig_validationflag_5_pcnt,le.populated_orig_validationdate_5_pcnt,le.populated_orig_dma_tps_dnc_flag_5_pcnt,le.populated_orig_telephonenumber_6_pcnt,le.populated_orig_validationflag_6_pcnt,le.populated_orig_validationdate_6_pcnt,le.populated_orig_dma_tps_dnc_flag_6_pcnt,le.populated_orig_telephonenumber_7_pcnt,le.populated_orig_validationflag_7_pcnt,le.populated_orig_validationdate_7_pcnt,le.populated_orig_dma_tps_dnc_flag_7_pcnt,le.populated_orig_tot_phones_pcnt,le.populated_orig_length_of_residence_pcnt,le.populated_orig_homeowner_pcnt,le.populated_orig_estimatedincome_pcnt,le.populated_orig_dwelling_type_pcnt,le.populated_orig_married_pcnt,le.populated_orig_child_pcnt,le.populated_orig_nbrchild_pcnt,le.populated_orig_teencd_pcnt,le.populated_orig_percent_range_black_pcnt,le.populated_orig_percent_range_white_pcnt,le.populated_orig_percent_range_hispanic_pcnt,le.populated_orig_percent_range_asian_pcnt,le.populated_orig_percent_range_english_speaking_pcnt,le.populated_orig_percnt_range_spanish_speaking_pcnt,le.populated_orig_percent_range_asian_speaking_pcnt,le.populated_orig_percent_range_sfdu_pcnt,le.populated_orig_percent_range_mfdu_pcnt,le.populated_orig_mhv_pcnt,le.populated_orig_mor_pcnt,le.populated_orig_car_pcnt,le.populated_orig_medschl_pcnt,le.populated_orig_penetration_range_whitecollar_pcnt,le.populated_orig_penetration_range_bluecollar_pcnt,le.populated_orig_penetration_range_otheroccupation_pcnt,le.populated_orig_demolevel_pcnt,le.populated_orig_recdate_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_dob_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_src_pcnt,le.populated_rawaid_pcnt,le.populated_Lexhhid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_hhid,le.maxlength_orig_pid,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_suffix,le.maxlength_orig_gender,le.maxlength_orig_age,le.maxlength_orig_dob,le.maxlength_orig_hhnbr,le.maxlength_orig_tot_males,le.maxlength_orig_tot_females,le.maxlength_orig_addrid,le.maxlength_orig_address,le.maxlength_orig_house,le.maxlength_orig_predir,le.maxlength_orig_street,le.maxlength_orig_strtype,le.maxlength_orig_postdir,le.maxlength_orig_apttype,le.maxlength_orig_aptnbr,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_z4,le.maxlength_orig_dpc,le.maxlength_orig_z4type,le.maxlength_orig_crte,le.maxlength_orig_dpv,le.maxlength_orig_vacant,le.maxlength_orig_msa,le.maxlength_orig_cbsa,le.maxlength_orig_county_code,le.maxlength_orig_time_zone,le.maxlength_orig_daylight_savings,le.maxlength_orig_lat_long_assignment_level,le.maxlength_orig_latitude,le.maxlength_orig_longitude,le.maxlength_orig_telephonenumber_1,le.maxlength_orig_validationflag_1,le.maxlength_orig_validationdate_1,le.maxlength_orig_dma_tps_dnc_flag_1,le.maxlength_orig_telephonenumber_2,le.maxlength_orig_validation_flag_2,le.maxlength_orig_validation_date_2,le.maxlength_orig_dma_tps_dnc_flag_2,le.maxlength_orig_telephonenumber_3,le.maxlength_orig_validationflag_3,le.maxlength_orig_validationdate_3,le.maxlength_orig_dma_tps_dnc_flag_3,le.maxlength_orig_telephonenumber_4,le.maxlength_orig_validationflag_4,le.maxlength_orig_validationdate_4,le.maxlength_orig_dma_tps_dnc_flag_4,le.maxlength_orig_telephonenumber_5,le.maxlength_orig_validationflag_5,le.maxlength_orig_validationdate_5,le.maxlength_orig_dma_tps_dnc_flag_5,le.maxlength_orig_telephonenumber_6,le.maxlength_orig_validationflag_6,le.maxlength_orig_validationdate_6,le.maxlength_orig_dma_tps_dnc_flag_6,le.maxlength_orig_telephonenumber_7,le.maxlength_orig_validationflag_7,le.maxlength_orig_validationdate_7,le.maxlength_orig_dma_tps_dnc_flag_7,le.maxlength_orig_tot_phones,le.maxlength_orig_length_of_residence,le.maxlength_orig_homeowner,le.maxlength_orig_estimatedincome,le.maxlength_orig_dwelling_type,le.maxlength_orig_married,le.maxlength_orig_child,le.maxlength_orig_nbrchild,le.maxlength_orig_teencd,le.maxlength_orig_percent_range_black,le.maxlength_orig_percent_range_white,le.maxlength_orig_percent_range_hispanic,le.maxlength_orig_percent_range_asian,le.maxlength_orig_percent_range_english_speaking,le.maxlength_orig_percnt_range_spanish_speaking,le.maxlength_orig_percent_range_asian_speaking,le.maxlength_orig_percent_range_sfdu,le.maxlength_orig_percent_range_mfdu,le.maxlength_orig_mhv,le.maxlength_orig_mor,le.maxlength_orig_car,le.maxlength_orig_medschl,le.maxlength_orig_penetration_range_whitecollar,le.maxlength_orig_penetration_range_bluecollar,le.maxlength_orig_penetration_range_otheroccupation,le.maxlength_orig_demolevel,le.maxlength_orig_recdate,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_did,le.maxlength_did_score,le.maxlength_clean_phone,le.maxlength_clean_dob,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_record_type,le.maxlength_src,le.maxlength_rawaid,le.maxlength_Lexhhid);
  SELF.avelength := CHOOSE(C,le.avelength_orig_hhid,le.avelength_orig_pid,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_suffix,le.avelength_orig_gender,le.avelength_orig_age,le.avelength_orig_dob,le.avelength_orig_hhnbr,le.avelength_orig_tot_males,le.avelength_orig_tot_females,le.avelength_orig_addrid,le.avelength_orig_address,le.avelength_orig_house,le.avelength_orig_predir,le.avelength_orig_street,le.avelength_orig_strtype,le.avelength_orig_postdir,le.avelength_orig_apttype,le.avelength_orig_aptnbr,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_z4,le.avelength_orig_dpc,le.avelength_orig_z4type,le.avelength_orig_crte,le.avelength_orig_dpv,le.avelength_orig_vacant,le.avelength_orig_msa,le.avelength_orig_cbsa,le.avelength_orig_county_code,le.avelength_orig_time_zone,le.avelength_orig_daylight_savings,le.avelength_orig_lat_long_assignment_level,le.avelength_orig_latitude,le.avelength_orig_longitude,le.avelength_orig_telephonenumber_1,le.avelength_orig_validationflag_1,le.avelength_orig_validationdate_1,le.avelength_orig_dma_tps_dnc_flag_1,le.avelength_orig_telephonenumber_2,le.avelength_orig_validation_flag_2,le.avelength_orig_validation_date_2,le.avelength_orig_dma_tps_dnc_flag_2,le.avelength_orig_telephonenumber_3,le.avelength_orig_validationflag_3,le.avelength_orig_validationdate_3,le.avelength_orig_dma_tps_dnc_flag_3,le.avelength_orig_telephonenumber_4,le.avelength_orig_validationflag_4,le.avelength_orig_validationdate_4,le.avelength_orig_dma_tps_dnc_flag_4,le.avelength_orig_telephonenumber_5,le.avelength_orig_validationflag_5,le.avelength_orig_validationdate_5,le.avelength_orig_dma_tps_dnc_flag_5,le.avelength_orig_telephonenumber_6,le.avelength_orig_validationflag_6,le.avelength_orig_validationdate_6,le.avelength_orig_dma_tps_dnc_flag_6,le.avelength_orig_telephonenumber_7,le.avelength_orig_validationflag_7,le.avelength_orig_validationdate_7,le.avelength_orig_dma_tps_dnc_flag_7,le.avelength_orig_tot_phones,le.avelength_orig_length_of_residence,le.avelength_orig_homeowner,le.avelength_orig_estimatedincome,le.avelength_orig_dwelling_type,le.avelength_orig_married,le.avelength_orig_child,le.avelength_orig_nbrchild,le.avelength_orig_teencd,le.avelength_orig_percent_range_black,le.avelength_orig_percent_range_white,le.avelength_orig_percent_range_hispanic,le.avelength_orig_percent_range_asian,le.avelength_orig_percent_range_english_speaking,le.avelength_orig_percnt_range_spanish_speaking,le.avelength_orig_percent_range_asian_speaking,le.avelength_orig_percent_range_sfdu,le.avelength_orig_percent_range_mfdu,le.avelength_orig_mhv,le.avelength_orig_mor,le.avelength_orig_car,le.avelength_orig_medschl,le.avelength_orig_penetration_range_whitecollar,le.avelength_orig_penetration_range_bluecollar,le.avelength_orig_penetration_range_otheroccupation,le.avelength_orig_demolevel,le.avelength_orig_recdate,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_did,le.avelength_did_score,le.avelength_clean_phone,le.avelength_clean_dob,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_record_type,le.avelength_src,le.avelength_rawaid,le.avelength_Lexhhid);
END;
EXPORT invSummary := NORMALIZE(summary0, 137, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.orig_hhid),TRIM((SALT38.StrType)le.orig_pid),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_mname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_suffix),TRIM((SALT38.StrType)le.orig_gender),TRIM((SALT38.StrType)le.orig_age),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_hhnbr),TRIM((SALT38.StrType)le.orig_tot_males),TRIM((SALT38.StrType)le.orig_tot_females),TRIM((SALT38.StrType)le.orig_addrid),TRIM((SALT38.StrType)le.orig_address),TRIM((SALT38.StrType)le.orig_house),TRIM((SALT38.StrType)le.orig_predir),TRIM((SALT38.StrType)le.orig_street),TRIM((SALT38.StrType)le.orig_strtype),TRIM((SALT38.StrType)le.orig_postdir),TRIM((SALT38.StrType)le.orig_apttype),TRIM((SALT38.StrType)le.orig_aptnbr),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_z4),TRIM((SALT38.StrType)le.orig_dpc),TRIM((SALT38.StrType)le.orig_z4type),TRIM((SALT38.StrType)le.orig_crte),TRIM((SALT38.StrType)le.orig_dpv),TRIM((SALT38.StrType)le.orig_vacant),TRIM((SALT38.StrType)le.orig_msa),TRIM((SALT38.StrType)le.orig_cbsa),TRIM((SALT38.StrType)le.orig_county_code),TRIM((SALT38.StrType)le.orig_time_zone),TRIM((SALT38.StrType)le.orig_daylight_savings),TRIM((SALT38.StrType)le.orig_lat_long_assignment_level),TRIM((SALT38.StrType)le.orig_latitude),TRIM((SALT38.StrType)le.orig_longitude),TRIM((SALT38.StrType)le.orig_telephonenumber_1),TRIM((SALT38.StrType)le.orig_validationflag_1),TRIM((SALT38.StrType)le.orig_validationdate_1),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT38.StrType)le.orig_telephonenumber_2),TRIM((SALT38.StrType)le.orig_validation_flag_2),TRIM((SALT38.StrType)le.orig_validation_date_2),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT38.StrType)le.orig_telephonenumber_3),TRIM((SALT38.StrType)le.orig_validationflag_3),TRIM((SALT38.StrType)le.orig_validationdate_3),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT38.StrType)le.orig_telephonenumber_4),TRIM((SALT38.StrType)le.orig_validationflag_4),TRIM((SALT38.StrType)le.orig_validationdate_4),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_4),TRIM((SALT38.StrType)le.orig_telephonenumber_5),TRIM((SALT38.StrType)le.orig_validationflag_5),TRIM((SALT38.StrType)le.orig_validationdate_5),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_5),TRIM((SALT38.StrType)le.orig_telephonenumber_6),TRIM((SALT38.StrType)le.orig_validationflag_6),TRIM((SALT38.StrType)le.orig_validationdate_6),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_6),TRIM((SALT38.StrType)le.orig_telephonenumber_7),TRIM((SALT38.StrType)le.orig_validationflag_7),TRIM((SALT38.StrType)le.orig_validationdate_7),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_7),TRIM((SALT38.StrType)le.orig_tot_phones),TRIM((SALT38.StrType)le.orig_length_of_residence),TRIM((SALT38.StrType)le.orig_homeowner),TRIM((SALT38.StrType)le.orig_estimatedincome),TRIM((SALT38.StrType)le.orig_dwelling_type),TRIM((SALT38.StrType)le.orig_married),TRIM((SALT38.StrType)le.orig_child),TRIM((SALT38.StrType)le.orig_nbrchild),TRIM((SALT38.StrType)le.orig_teencd),TRIM((SALT38.StrType)le.orig_percent_range_black),TRIM((SALT38.StrType)le.orig_percent_range_white),TRIM((SALT38.StrType)le.orig_percent_range_hispanic),TRIM((SALT38.StrType)le.orig_percent_range_asian),TRIM((SALT38.StrType)le.orig_percent_range_english_speaking),TRIM((SALT38.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT38.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT38.StrType)le.orig_percent_range_sfdu),TRIM((SALT38.StrType)le.orig_percent_range_mfdu),TRIM((SALT38.StrType)le.orig_mhv),TRIM((SALT38.StrType)le.orig_mor),TRIM((SALT38.StrType)le.orig_car),TRIM((SALT38.StrType)le.orig_medschl),TRIM((SALT38.StrType)le.orig_penetration_range_whitecollar),TRIM((SALT38.StrType)le.orig_penetration_range_bluecollar),TRIM((SALT38.StrType)le.orig_penetration_range_otheroccupation),TRIM((SALT38.StrType)le.orig_demolevel),TRIM((SALT38.StrType)le.orig_recdate),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_st),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.clean_dob),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),IF (le.date_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.date_vendor_last_reported), ''),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.src),IF (le.rawaid <> 0,TRIM((SALT38.StrType)le.rawaid), ''),IF (le.Lexhhid <> 0,TRIM((SALT38.StrType)le.Lexhhid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,137,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 137);
  SELF.FldNo2 := 1 + (C % 137);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.orig_hhid),TRIM((SALT38.StrType)le.orig_pid),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_mname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_suffix),TRIM((SALT38.StrType)le.orig_gender),TRIM((SALT38.StrType)le.orig_age),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_hhnbr),TRIM((SALT38.StrType)le.orig_tot_males),TRIM((SALT38.StrType)le.orig_tot_females),TRIM((SALT38.StrType)le.orig_addrid),TRIM((SALT38.StrType)le.orig_address),TRIM((SALT38.StrType)le.orig_house),TRIM((SALT38.StrType)le.orig_predir),TRIM((SALT38.StrType)le.orig_street),TRIM((SALT38.StrType)le.orig_strtype),TRIM((SALT38.StrType)le.orig_postdir),TRIM((SALT38.StrType)le.orig_apttype),TRIM((SALT38.StrType)le.orig_aptnbr),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_z4),TRIM((SALT38.StrType)le.orig_dpc),TRIM((SALT38.StrType)le.orig_z4type),TRIM((SALT38.StrType)le.orig_crte),TRIM((SALT38.StrType)le.orig_dpv),TRIM((SALT38.StrType)le.orig_vacant),TRIM((SALT38.StrType)le.orig_msa),TRIM((SALT38.StrType)le.orig_cbsa),TRIM((SALT38.StrType)le.orig_county_code),TRIM((SALT38.StrType)le.orig_time_zone),TRIM((SALT38.StrType)le.orig_daylight_savings),TRIM((SALT38.StrType)le.orig_lat_long_assignment_level),TRIM((SALT38.StrType)le.orig_latitude),TRIM((SALT38.StrType)le.orig_longitude),TRIM((SALT38.StrType)le.orig_telephonenumber_1),TRIM((SALT38.StrType)le.orig_validationflag_1),TRIM((SALT38.StrType)le.orig_validationdate_1),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT38.StrType)le.orig_telephonenumber_2),TRIM((SALT38.StrType)le.orig_validation_flag_2),TRIM((SALT38.StrType)le.orig_validation_date_2),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT38.StrType)le.orig_telephonenumber_3),TRIM((SALT38.StrType)le.orig_validationflag_3),TRIM((SALT38.StrType)le.orig_validationdate_3),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT38.StrType)le.orig_telephonenumber_4),TRIM((SALT38.StrType)le.orig_validationflag_4),TRIM((SALT38.StrType)le.orig_validationdate_4),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_4),TRIM((SALT38.StrType)le.orig_telephonenumber_5),TRIM((SALT38.StrType)le.orig_validationflag_5),TRIM((SALT38.StrType)le.orig_validationdate_5),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_5),TRIM((SALT38.StrType)le.orig_telephonenumber_6),TRIM((SALT38.StrType)le.orig_validationflag_6),TRIM((SALT38.StrType)le.orig_validationdate_6),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_6),TRIM((SALT38.StrType)le.orig_telephonenumber_7),TRIM((SALT38.StrType)le.orig_validationflag_7),TRIM((SALT38.StrType)le.orig_validationdate_7),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_7),TRIM((SALT38.StrType)le.orig_tot_phones),TRIM((SALT38.StrType)le.orig_length_of_residence),TRIM((SALT38.StrType)le.orig_homeowner),TRIM((SALT38.StrType)le.orig_estimatedincome),TRIM((SALT38.StrType)le.orig_dwelling_type),TRIM((SALT38.StrType)le.orig_married),TRIM((SALT38.StrType)le.orig_child),TRIM((SALT38.StrType)le.orig_nbrchild),TRIM((SALT38.StrType)le.orig_teencd),TRIM((SALT38.StrType)le.orig_percent_range_black),TRIM((SALT38.StrType)le.orig_percent_range_white),TRIM((SALT38.StrType)le.orig_percent_range_hispanic),TRIM((SALT38.StrType)le.orig_percent_range_asian),TRIM((SALT38.StrType)le.orig_percent_range_english_speaking),TRIM((SALT38.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT38.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT38.StrType)le.orig_percent_range_sfdu),TRIM((SALT38.StrType)le.orig_percent_range_mfdu),TRIM((SALT38.StrType)le.orig_mhv),TRIM((SALT38.StrType)le.orig_mor),TRIM((SALT38.StrType)le.orig_car),TRIM((SALT38.StrType)le.orig_medschl),TRIM((SALT38.StrType)le.orig_penetration_range_whitecollar),TRIM((SALT38.StrType)le.orig_penetration_range_bluecollar),TRIM((SALT38.StrType)le.orig_penetration_range_otheroccupation),TRIM((SALT38.StrType)le.orig_demolevel),TRIM((SALT38.StrType)le.orig_recdate),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_st),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.clean_dob),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),IF (le.date_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.date_vendor_last_reported), ''),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.src),IF (le.rawaid <> 0,TRIM((SALT38.StrType)le.rawaid), ''),IF (le.Lexhhid <> 0,TRIM((SALT38.StrType)le.Lexhhid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.orig_hhid),TRIM((SALT38.StrType)le.orig_pid),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_mname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_suffix),TRIM((SALT38.StrType)le.orig_gender),TRIM((SALT38.StrType)le.orig_age),TRIM((SALT38.StrType)le.orig_dob),TRIM((SALT38.StrType)le.orig_hhnbr),TRIM((SALT38.StrType)le.orig_tot_males),TRIM((SALT38.StrType)le.orig_tot_females),TRIM((SALT38.StrType)le.orig_addrid),TRIM((SALT38.StrType)le.orig_address),TRIM((SALT38.StrType)le.orig_house),TRIM((SALT38.StrType)le.orig_predir),TRIM((SALT38.StrType)le.orig_street),TRIM((SALT38.StrType)le.orig_strtype),TRIM((SALT38.StrType)le.orig_postdir),TRIM((SALT38.StrType)le.orig_apttype),TRIM((SALT38.StrType)le.orig_aptnbr),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_state),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_z4),TRIM((SALT38.StrType)le.orig_dpc),TRIM((SALT38.StrType)le.orig_z4type),TRIM((SALT38.StrType)le.orig_crte),TRIM((SALT38.StrType)le.orig_dpv),TRIM((SALT38.StrType)le.orig_vacant),TRIM((SALT38.StrType)le.orig_msa),TRIM((SALT38.StrType)le.orig_cbsa),TRIM((SALT38.StrType)le.orig_county_code),TRIM((SALT38.StrType)le.orig_time_zone),TRIM((SALT38.StrType)le.orig_daylight_savings),TRIM((SALT38.StrType)le.orig_lat_long_assignment_level),TRIM((SALT38.StrType)le.orig_latitude),TRIM((SALT38.StrType)le.orig_longitude),TRIM((SALT38.StrType)le.orig_telephonenumber_1),TRIM((SALT38.StrType)le.orig_validationflag_1),TRIM((SALT38.StrType)le.orig_validationdate_1),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT38.StrType)le.orig_telephonenumber_2),TRIM((SALT38.StrType)le.orig_validation_flag_2),TRIM((SALT38.StrType)le.orig_validation_date_2),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT38.StrType)le.orig_telephonenumber_3),TRIM((SALT38.StrType)le.orig_validationflag_3),TRIM((SALT38.StrType)le.orig_validationdate_3),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT38.StrType)le.orig_telephonenumber_4),TRIM((SALT38.StrType)le.orig_validationflag_4),TRIM((SALT38.StrType)le.orig_validationdate_4),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_4),TRIM((SALT38.StrType)le.orig_telephonenumber_5),TRIM((SALT38.StrType)le.orig_validationflag_5),TRIM((SALT38.StrType)le.orig_validationdate_5),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_5),TRIM((SALT38.StrType)le.orig_telephonenumber_6),TRIM((SALT38.StrType)le.orig_validationflag_6),TRIM((SALT38.StrType)le.orig_validationdate_6),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_6),TRIM((SALT38.StrType)le.orig_telephonenumber_7),TRIM((SALT38.StrType)le.orig_validationflag_7),TRIM((SALT38.StrType)le.orig_validationdate_7),TRIM((SALT38.StrType)le.orig_dma_tps_dnc_flag_7),TRIM((SALT38.StrType)le.orig_tot_phones),TRIM((SALT38.StrType)le.orig_length_of_residence),TRIM((SALT38.StrType)le.orig_homeowner),TRIM((SALT38.StrType)le.orig_estimatedincome),TRIM((SALT38.StrType)le.orig_dwelling_type),TRIM((SALT38.StrType)le.orig_married),TRIM((SALT38.StrType)le.orig_child),TRIM((SALT38.StrType)le.orig_nbrchild),TRIM((SALT38.StrType)le.orig_teencd),TRIM((SALT38.StrType)le.orig_percent_range_black),TRIM((SALT38.StrType)le.orig_percent_range_white),TRIM((SALT38.StrType)le.orig_percent_range_hispanic),TRIM((SALT38.StrType)le.orig_percent_range_asian),TRIM((SALT38.StrType)le.orig_percent_range_english_speaking),TRIM((SALT38.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT38.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT38.StrType)le.orig_percent_range_sfdu),TRIM((SALT38.StrType)le.orig_percent_range_mfdu),TRIM((SALT38.StrType)le.orig_mhv),TRIM((SALT38.StrType)le.orig_mor),TRIM((SALT38.StrType)le.orig_car),TRIM((SALT38.StrType)le.orig_medschl),TRIM((SALT38.StrType)le.orig_penetration_range_whitecollar),TRIM((SALT38.StrType)le.orig_penetration_range_bluecollar),TRIM((SALT38.StrType)le.orig_penetration_range_otheroccupation),TRIM((SALT38.StrType)le.orig_demolevel),TRIM((SALT38.StrType)le.orig_recdate),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.fips_st),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),TRIM((SALT38.StrType)le.clean_phone),TRIM((SALT38.StrType)le.clean_dob),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),IF (le.date_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.date_vendor_last_reported), ''),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.src),IF (le.rawaid <> 0,TRIM((SALT38.StrType)le.rawaid), ''),IF (le.Lexhhid <> 0,TRIM((SALT38.StrType)le.Lexhhid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),137*137,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_hhid'}
      ,{2,'orig_pid'}
      ,{3,'orig_fname'}
      ,{4,'orig_mname'}
      ,{5,'orig_lname'}
      ,{6,'orig_suffix'}
      ,{7,'orig_gender'}
      ,{8,'orig_age'}
      ,{9,'orig_dob'}
      ,{10,'orig_hhnbr'}
      ,{11,'orig_tot_males'}
      ,{12,'orig_tot_females'}
      ,{13,'orig_addrid'}
      ,{14,'orig_address'}
      ,{15,'orig_house'}
      ,{16,'orig_predir'}
      ,{17,'orig_street'}
      ,{18,'orig_strtype'}
      ,{19,'orig_postdir'}
      ,{20,'orig_apttype'}
      ,{21,'orig_aptnbr'}
      ,{22,'orig_city'}
      ,{23,'orig_state'}
      ,{24,'orig_zip'}
      ,{25,'orig_z4'}
      ,{26,'orig_dpc'}
      ,{27,'orig_z4type'}
      ,{28,'orig_crte'}
      ,{29,'orig_dpv'}
      ,{30,'orig_vacant'}
      ,{31,'orig_msa'}
      ,{32,'orig_cbsa'}
      ,{33,'orig_county_code'}
      ,{34,'orig_time_zone'}
      ,{35,'orig_daylight_savings'}
      ,{36,'orig_lat_long_assignment_level'}
      ,{37,'orig_latitude'}
      ,{38,'orig_longitude'}
      ,{39,'orig_telephonenumber_1'}
      ,{40,'orig_validationflag_1'}
      ,{41,'orig_validationdate_1'}
      ,{42,'orig_dma_tps_dnc_flag_1'}
      ,{43,'orig_telephonenumber_2'}
      ,{44,'orig_validation_flag_2'}
      ,{45,'orig_validation_date_2'}
      ,{46,'orig_dma_tps_dnc_flag_2'}
      ,{47,'orig_telephonenumber_3'}
      ,{48,'orig_validationflag_3'}
      ,{49,'orig_validationdate_3'}
      ,{50,'orig_dma_tps_dnc_flag_3'}
      ,{51,'orig_telephonenumber_4'}
      ,{52,'orig_validationflag_4'}
      ,{53,'orig_validationdate_4'}
      ,{54,'orig_dma_tps_dnc_flag_4'}
      ,{55,'orig_telephonenumber_5'}
      ,{56,'orig_validationflag_5'}
      ,{57,'orig_validationdate_5'}
      ,{58,'orig_dma_tps_dnc_flag_5'}
      ,{59,'orig_telephonenumber_6'}
      ,{60,'orig_validationflag_6'}
      ,{61,'orig_validationdate_6'}
      ,{62,'orig_dma_tps_dnc_flag_6'}
      ,{63,'orig_telephonenumber_7'}
      ,{64,'orig_validationflag_7'}
      ,{65,'orig_validationdate_7'}
      ,{66,'orig_dma_tps_dnc_flag_7'}
      ,{67,'orig_tot_phones'}
      ,{68,'orig_length_of_residence'}
      ,{69,'orig_homeowner'}
      ,{70,'orig_estimatedincome'}
      ,{71,'orig_dwelling_type'}
      ,{72,'orig_married'}
      ,{73,'orig_child'}
      ,{74,'orig_nbrchild'}
      ,{75,'orig_teencd'}
      ,{76,'orig_percent_range_black'}
      ,{77,'orig_percent_range_white'}
      ,{78,'orig_percent_range_hispanic'}
      ,{79,'orig_percent_range_asian'}
      ,{80,'orig_percent_range_english_speaking'}
      ,{81,'orig_percnt_range_spanish_speaking'}
      ,{82,'orig_percent_range_asian_speaking'}
      ,{83,'orig_percent_range_sfdu'}
      ,{84,'orig_percent_range_mfdu'}
      ,{85,'orig_mhv'}
      ,{86,'orig_mor'}
      ,{87,'orig_car'}
      ,{88,'orig_medschl'}
      ,{89,'orig_penetration_range_whitecollar'}
      ,{90,'orig_penetration_range_bluecollar'}
      ,{91,'orig_penetration_range_otheroccupation'}
      ,{92,'orig_demolevel'}
      ,{93,'orig_recdate'}
      ,{94,'title'}
      ,{95,'fname'}
      ,{96,'mname'}
      ,{97,'lname'}
      ,{98,'name_suffix'}
      ,{99,'prim_range'}
      ,{100,'predir'}
      ,{101,'prim_name'}
      ,{102,'addr_suffix'}
      ,{103,'postdir'}
      ,{104,'unit_desig'}
      ,{105,'sec_range'}
      ,{106,'p_city_name'}
      ,{107,'v_city_name'}
      ,{108,'st'}
      ,{109,'zip'}
      ,{110,'zip4'}
      ,{111,'cart'}
      ,{112,'cr_sort_sz'}
      ,{113,'lot'}
      ,{114,'lot_order'}
      ,{115,'dbpc'}
      ,{116,'chk_digit'}
      ,{117,'rec_type'}
      ,{118,'fips_st'}
      ,{119,'fips_county'}
      ,{120,'geo_lat'}
      ,{121,'geo_long'}
      ,{122,'msa'}
      ,{123,'geo_blk'}
      ,{124,'geo_match'}
      ,{125,'err_stat'}
      ,{126,'did'}
      ,{127,'did_score'}
      ,{128,'clean_phone'}
      ,{129,'clean_dob'}
      ,{130,'date_first_seen'}
      ,{131,'date_last_seen'}
      ,{132,'date_vendor_first_reported'}
      ,{133,'date_vendor_last_reported'}
      ,{134,'record_type'}
      ,{135,'src'}
      ,{136,'rawaid'}
      ,{137,'Lexhhid'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_orig_hhid((SALT38.StrType)le.orig_hhid),
    Base_Fields.InValid_orig_pid((SALT38.StrType)le.orig_pid),
    Base_Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname),
    Base_Fields.InValid_orig_mname((SALT38.StrType)le.orig_mname),
    Base_Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname),
    Base_Fields.InValid_orig_suffix((SALT38.StrType)le.orig_suffix),
    Base_Fields.InValid_orig_gender((SALT38.StrType)le.orig_gender),
    Base_Fields.InValid_orig_age((SALT38.StrType)le.orig_age),
    Base_Fields.InValid_orig_dob((SALT38.StrType)le.orig_dob),
    Base_Fields.InValid_orig_hhnbr((SALT38.StrType)le.orig_hhnbr),
    Base_Fields.InValid_orig_tot_males((SALT38.StrType)le.orig_tot_males),
    Base_Fields.InValid_orig_tot_females((SALT38.StrType)le.orig_tot_females),
    Base_Fields.InValid_orig_addrid((SALT38.StrType)le.orig_addrid),
    Base_Fields.InValid_orig_address((SALT38.StrType)le.orig_address),
    Base_Fields.InValid_orig_house((SALT38.StrType)le.orig_house),
    Base_Fields.InValid_orig_predir((SALT38.StrType)le.orig_predir),
    Base_Fields.InValid_orig_street((SALT38.StrType)le.orig_street),
    Base_Fields.InValid_orig_strtype((SALT38.StrType)le.orig_strtype),
    Base_Fields.InValid_orig_postdir((SALT38.StrType)le.orig_postdir),
    Base_Fields.InValid_orig_apttype((SALT38.StrType)le.orig_apttype),
    Base_Fields.InValid_orig_aptnbr((SALT38.StrType)le.orig_aptnbr),
    Base_Fields.InValid_orig_city((SALT38.StrType)le.orig_city),
    Base_Fields.InValid_orig_state((SALT38.StrType)le.orig_state),
    Base_Fields.InValid_orig_zip((SALT38.StrType)le.orig_zip),
    Base_Fields.InValid_orig_z4((SALT38.StrType)le.orig_z4),
    Base_Fields.InValid_orig_dpc((SALT38.StrType)le.orig_dpc),
    Base_Fields.InValid_orig_z4type((SALT38.StrType)le.orig_z4type),
    Base_Fields.InValid_orig_crte((SALT38.StrType)le.orig_crte),
    Base_Fields.InValid_orig_dpv((SALT38.StrType)le.orig_dpv),
    Base_Fields.InValid_orig_vacant((SALT38.StrType)le.orig_vacant),
    Base_Fields.InValid_orig_msa((SALT38.StrType)le.orig_msa),
    Base_Fields.InValid_orig_cbsa((SALT38.StrType)le.orig_cbsa),
    Base_Fields.InValid_orig_county_code((SALT38.StrType)le.orig_county_code),
    Base_Fields.InValid_orig_time_zone((SALT38.StrType)le.orig_time_zone),
    Base_Fields.InValid_orig_daylight_savings((SALT38.StrType)le.orig_daylight_savings),
    Base_Fields.InValid_orig_lat_long_assignment_level((SALT38.StrType)le.orig_lat_long_assignment_level),
    Base_Fields.InValid_orig_latitude((SALT38.StrType)le.orig_latitude),
    Base_Fields.InValid_orig_longitude((SALT38.StrType)le.orig_longitude),
    Base_Fields.InValid_orig_telephonenumber_1((SALT38.StrType)le.orig_telephonenumber_1),
    Base_Fields.InValid_orig_validationflag_1((SALT38.StrType)le.orig_validationflag_1),
    Base_Fields.InValid_orig_validationdate_1((SALT38.StrType)le.orig_validationdate_1),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_1((SALT38.StrType)le.orig_dma_tps_dnc_flag_1),
    Base_Fields.InValid_orig_telephonenumber_2((SALT38.StrType)le.orig_telephonenumber_2),
    Base_Fields.InValid_orig_validation_flag_2((SALT38.StrType)le.orig_validation_flag_2),
    Base_Fields.InValid_orig_validation_date_2((SALT38.StrType)le.orig_validation_date_2),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_2((SALT38.StrType)le.orig_dma_tps_dnc_flag_2),
    Base_Fields.InValid_orig_telephonenumber_3((SALT38.StrType)le.orig_telephonenumber_3),
    Base_Fields.InValid_orig_validationflag_3((SALT38.StrType)le.orig_validationflag_3),
    Base_Fields.InValid_orig_validationdate_3((SALT38.StrType)le.orig_validationdate_3),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_3((SALT38.StrType)le.orig_dma_tps_dnc_flag_3),
    Base_Fields.InValid_orig_telephonenumber_4((SALT38.StrType)le.orig_telephonenumber_4),
    Base_Fields.InValid_orig_validationflag_4((SALT38.StrType)le.orig_validationflag_4),
    Base_Fields.InValid_orig_validationdate_4((SALT38.StrType)le.orig_validationdate_4),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_4((SALT38.StrType)le.orig_dma_tps_dnc_flag_4),
    Base_Fields.InValid_orig_telephonenumber_5((SALT38.StrType)le.orig_telephonenumber_5),
    Base_Fields.InValid_orig_validationflag_5((SALT38.StrType)le.orig_validationflag_5),
    Base_Fields.InValid_orig_validationdate_5((SALT38.StrType)le.orig_validationdate_5),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_5((SALT38.StrType)le.orig_dma_tps_dnc_flag_5),
    Base_Fields.InValid_orig_telephonenumber_6((SALT38.StrType)le.orig_telephonenumber_6),
    Base_Fields.InValid_orig_validationflag_6((SALT38.StrType)le.orig_validationflag_6),
    Base_Fields.InValid_orig_validationdate_6((SALT38.StrType)le.orig_validationdate_6),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_6((SALT38.StrType)le.orig_dma_tps_dnc_flag_6),
    Base_Fields.InValid_orig_telephonenumber_7((SALT38.StrType)le.orig_telephonenumber_7),
    Base_Fields.InValid_orig_validationflag_7((SALT38.StrType)le.orig_validationflag_7),
    Base_Fields.InValid_orig_validationdate_7((SALT38.StrType)le.orig_validationdate_7),
    Base_Fields.InValid_orig_dma_tps_dnc_flag_7((SALT38.StrType)le.orig_dma_tps_dnc_flag_7),
    Base_Fields.InValid_orig_tot_phones((SALT38.StrType)le.orig_tot_phones),
    Base_Fields.InValid_orig_length_of_residence((SALT38.StrType)le.orig_length_of_residence),
    Base_Fields.InValid_orig_homeowner((SALT38.StrType)le.orig_homeowner),
    Base_Fields.InValid_orig_estimatedincome((SALT38.StrType)le.orig_estimatedincome),
    Base_Fields.InValid_orig_dwelling_type((SALT38.StrType)le.orig_dwelling_type),
    Base_Fields.InValid_orig_married((SALT38.StrType)le.orig_married),
    Base_Fields.InValid_orig_child((SALT38.StrType)le.orig_child),
    Base_Fields.InValid_orig_nbrchild((SALT38.StrType)le.orig_nbrchild),
    Base_Fields.InValid_orig_teencd((SALT38.StrType)le.orig_teencd),
    Base_Fields.InValid_orig_percent_range_black((SALT38.StrType)le.orig_percent_range_black),
    Base_Fields.InValid_orig_percent_range_white((SALT38.StrType)le.orig_percent_range_white),
    Base_Fields.InValid_orig_percent_range_hispanic((SALT38.StrType)le.orig_percent_range_hispanic),
    Base_Fields.InValid_orig_percent_range_asian((SALT38.StrType)le.orig_percent_range_asian),
    Base_Fields.InValid_orig_percent_range_english_speaking((SALT38.StrType)le.orig_percent_range_english_speaking),
    Base_Fields.InValid_orig_percnt_range_spanish_speaking((SALT38.StrType)le.orig_percnt_range_spanish_speaking),
    Base_Fields.InValid_orig_percent_range_asian_speaking((SALT38.StrType)le.orig_percent_range_asian_speaking),
    Base_Fields.InValid_orig_percent_range_sfdu((SALT38.StrType)le.orig_percent_range_sfdu),
    Base_Fields.InValid_orig_percent_range_mfdu((SALT38.StrType)le.orig_percent_range_mfdu),
    Base_Fields.InValid_orig_mhv((SALT38.StrType)le.orig_mhv),
    Base_Fields.InValid_orig_mor((SALT38.StrType)le.orig_mor),
    Base_Fields.InValid_orig_car((SALT38.StrType)le.orig_car),
    Base_Fields.InValid_orig_medschl((SALT38.StrType)le.orig_medschl),
    Base_Fields.InValid_orig_penetration_range_whitecollar((SALT38.StrType)le.orig_penetration_range_whitecollar),
    Base_Fields.InValid_orig_penetration_range_bluecollar((SALT38.StrType)le.orig_penetration_range_bluecollar),
    Base_Fields.InValid_orig_penetration_range_otheroccupation((SALT38.StrType)le.orig_penetration_range_otheroccupation),
    Base_Fields.InValid_orig_demolevel((SALT38.StrType)le.orig_demolevel),
    Base_Fields.InValid_orig_recdate((SALT38.StrType)le.orig_recdate),
    Base_Fields.InValid_title((SALT38.StrType)le.title),
    Base_Fields.InValid_fname((SALT38.StrType)le.fname),
    Base_Fields.InValid_mname((SALT38.StrType)le.mname),
    Base_Fields.InValid_lname((SALT38.StrType)le.lname),
    Base_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Base_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT38.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT38.StrType)le.st),
    Base_Fields.InValid_zip((SALT38.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT38.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT38.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT38.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Base_Fields.InValid_fips_st((SALT38.StrType)le.fips_st),
    Base_Fields.InValid_fips_county((SALT38.StrType)le.fips_county),
    Base_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT38.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Base_Fields.InValid_did((SALT38.StrType)le.did),
    Base_Fields.InValid_did_score((SALT38.StrType)le.did_score),
    Base_Fields.InValid_clean_phone((SALT38.StrType)le.clean_phone),
    Base_Fields.InValid_clean_dob((SALT38.StrType)le.clean_dob),
    Base_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen),
    Base_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen),
    Base_Fields.InValid_date_vendor_first_reported((SALT38.StrType)le.date_vendor_first_reported),
    Base_Fields.InValid_date_vendor_last_reported((SALT38.StrType)le.date_vendor_last_reported),
    Base_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    Base_Fields.InValid_src((SALT38.StrType)le.src),
    Base_Fields.InValid_rawaid((SALT38.StrType)le.rawaid),
    Base_Fields.InValid_Lexhhid((SALT38.StrType)le.Lexhhid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,137,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_alpha','invalid_suffix','invalid_gender','invalid_total_nbr','invalid_date','Unknown','invalid_total_nbr','invalid_total_nbr','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_county_name','invalid_state_abbr','invalid_zip','invalid_zip4','Unknown','Unknown','Unknown','Unknown','invalid_indicator','Unknown','Unknown','Unknown','invalid_time_zone','Unknown','invalid_assignment_lvl','Unknown','Unknown','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_residence_len','invalid_homeowner','invalid_mhv','invalid_dwelling_type','invalid_indicator','invalid_indicator','invalid_child_num','invalid_indicator','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_mhv','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_residence_len','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','invalid_suffix','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_csz','invalid_csz','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_nums','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_orig_hhid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_pid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_gender(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_age(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_hhnbr(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_tot_males(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_tot_females(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_addrid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_house(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_street(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_strtype(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_apttype(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_aptnbr(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_z4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_z4type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_crte(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dpv(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_vacant(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_cbsa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_county_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_time_zone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_daylight_savings(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_lat_long_assignment_level(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_latitude(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_longitude(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationflag_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationdate_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validation_flag_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validation_date_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationflag_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationdate_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationflag_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationdate_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationflag_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationdate_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationflag_6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationdate_6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_telephonenumber_7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationflag_7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_validationdate_7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dma_tps_dnc_flag_7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_tot_phones(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_length_of_residence(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_homeowner(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_estimatedincome(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dwelling_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_married(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_child(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_nbrchild(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_teencd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_black(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_white(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_hispanic(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_asian(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_english_speaking(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percnt_range_spanish_speaking(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_asian_speaking(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_sfdu(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_percent_range_mfdu(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_mhv(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_mor(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_car(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_medschl(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_penetration_range_whitecollar(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_penetration_range_bluecollar(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_penetration_range_otheroccupation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_demolevel(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_recdate(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_dob(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_src(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_Lexhhid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Infutor_NARC, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
