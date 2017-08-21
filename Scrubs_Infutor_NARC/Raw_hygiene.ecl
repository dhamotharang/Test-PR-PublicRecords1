IMPORT ut,SALT32;
EXPORT Raw_hygiene(dataset(Raw_layout_Infutor_NARC) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_hhid_pcnt := AVE(GROUP,IF(h.orig_hhid = (TYPEOF(h.orig_hhid))'',0,100));
    maxlength_orig_hhid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_hhid)));
    avelength_orig_hhid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_hhid)),h.orig_hhid<>(typeof(h.orig_hhid))'');
    populated_orig_pid_pcnt := AVE(GROUP,IF(h.orig_pid = (TYPEOF(h.orig_pid))'',0,100));
    maxlength_orig_pid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_pid)));
    avelength_orig_pid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_pid)),h.orig_pid<>(typeof(h.orig_pid))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
    populated_orig_gender_pcnt := AVE(GROUP,IF(h.orig_gender = (TYPEOF(h.orig_gender))'',0,100));
    maxlength_orig_gender := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_gender)));
    avelength_orig_gender := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_gender)),h.orig_gender<>(typeof(h.orig_gender))'');
    populated_orig_age_pcnt := AVE(GROUP,IF(h.orig_age = (TYPEOF(h.orig_age))'',0,100));
    maxlength_orig_age := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_age)));
    avelength_orig_age := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_age)),h.orig_age<>(typeof(h.orig_age))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_hhnbr_pcnt := AVE(GROUP,IF(h.orig_hhnbr = (TYPEOF(h.orig_hhnbr))'',0,100));
    maxlength_orig_hhnbr := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_hhnbr)));
    avelength_orig_hhnbr := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_hhnbr)),h.orig_hhnbr<>(typeof(h.orig_hhnbr))'');
    populated_orig_tot_males_pcnt := AVE(GROUP,IF(h.orig_tot_males = (TYPEOF(h.orig_tot_males))'',0,100));
    maxlength_orig_tot_males := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_tot_males)));
    avelength_orig_tot_males := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_tot_males)),h.orig_tot_males<>(typeof(h.orig_tot_males))'');
    populated_orig_tot_females_pcnt := AVE(GROUP,IF(h.orig_tot_females = (TYPEOF(h.orig_tot_females))'',0,100));
    maxlength_orig_tot_females := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_tot_females)));
    avelength_orig_tot_females := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_tot_females)),h.orig_tot_females<>(typeof(h.orig_tot_females))'');
    populated_orig_addrid_pcnt := AVE(GROUP,IF(h.orig_addrid = (TYPEOF(h.orig_addrid))'',0,100));
    maxlength_orig_addrid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_addrid)));
    avelength_orig_addrid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_addrid)),h.orig_addrid<>(typeof(h.orig_addrid))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_house_pcnt := AVE(GROUP,IF(h.orig_house = (TYPEOF(h.orig_house))'',0,100));
    maxlength_orig_house := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_house)));
    avelength_orig_house := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_house)),h.orig_house<>(typeof(h.orig_house))'');
    populated_orig_predir_pcnt := AVE(GROUP,IF(h.orig_predir = (TYPEOF(h.orig_predir))'',0,100));
    maxlength_orig_predir := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_predir)));
    avelength_orig_predir := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_predir)),h.orig_predir<>(typeof(h.orig_predir))'');
    populated_orig_street_pcnt := AVE(GROUP,IF(h.orig_street = (TYPEOF(h.orig_street))'',0,100));
    maxlength_orig_street := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_street)));
    avelength_orig_street := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_street)),h.orig_street<>(typeof(h.orig_street))'');
    populated_orig_strtype_pcnt := AVE(GROUP,IF(h.orig_strtype = (TYPEOF(h.orig_strtype))'',0,100));
    maxlength_orig_strtype := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_strtype)));
    avelength_orig_strtype := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_strtype)),h.orig_strtype<>(typeof(h.orig_strtype))'');
    populated_orig_postdir_pcnt := AVE(GROUP,IF(h.orig_postdir = (TYPEOF(h.orig_postdir))'',0,100));
    maxlength_orig_postdir := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_postdir)));
    avelength_orig_postdir := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_postdir)),h.orig_postdir<>(typeof(h.orig_postdir))'');
    populated_orig_apttype_pcnt := AVE(GROUP,IF(h.orig_apttype = (TYPEOF(h.orig_apttype))'',0,100));
    maxlength_orig_apttype := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_apttype)));
    avelength_orig_apttype := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_apttype)),h.orig_apttype<>(typeof(h.orig_apttype))'');
    populated_orig_aptnbr_pcnt := AVE(GROUP,IF(h.orig_aptnbr = (TYPEOF(h.orig_aptnbr))'',0,100));
    maxlength_orig_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_aptnbr)));
    avelength_orig_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_aptnbr)),h.orig_aptnbr<>(typeof(h.orig_aptnbr))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_z4_pcnt := AVE(GROUP,IF(h.orig_z4 = (TYPEOF(h.orig_z4))'',0,100));
    maxlength_orig_z4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_z4)));
    avelength_orig_z4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_z4)),h.orig_z4<>(typeof(h.orig_z4))'');
    populated_orig_dpc_pcnt := AVE(GROUP,IF(h.orig_dpc = (TYPEOF(h.orig_dpc))'',0,100));
    maxlength_orig_dpc := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dpc)));
    avelength_orig_dpc := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dpc)),h.orig_dpc<>(typeof(h.orig_dpc))'');
    populated_orig_z4type_pcnt := AVE(GROUP,IF(h.orig_z4type = (TYPEOF(h.orig_z4type))'',0,100));
    maxlength_orig_z4type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_z4type)));
    avelength_orig_z4type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_z4type)),h.orig_z4type<>(typeof(h.orig_z4type))'');
    populated_orig_crte_pcnt := AVE(GROUP,IF(h.orig_crte = (TYPEOF(h.orig_crte))'',0,100));
    maxlength_orig_crte := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_crte)));
    avelength_orig_crte := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_crte)),h.orig_crte<>(typeof(h.orig_crte))'');
    populated_orig_dpv_pcnt := AVE(GROUP,IF(h.orig_dpv = (TYPEOF(h.orig_dpv))'',0,100));
    maxlength_orig_dpv := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dpv)));
    avelength_orig_dpv := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dpv)),h.orig_dpv<>(typeof(h.orig_dpv))'');
    populated_orig_vacant_pcnt := AVE(GROUP,IF(h.orig_vacant = (TYPEOF(h.orig_vacant))'',0,100));
    maxlength_orig_vacant := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_vacant)));
    avelength_orig_vacant := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_vacant)),h.orig_vacant<>(typeof(h.orig_vacant))'');
    populated_orig_msa_pcnt := AVE(GROUP,IF(h.orig_msa = (TYPEOF(h.orig_msa))'',0,100));
    maxlength_orig_msa := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_msa)));
    avelength_orig_msa := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_msa)),h.orig_msa<>(typeof(h.orig_msa))'');
    populated_orig_cbsa_pcnt := AVE(GROUP,IF(h.orig_cbsa = (TYPEOF(h.orig_cbsa))'',0,100));
    maxlength_orig_cbsa := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_cbsa)));
    avelength_orig_cbsa := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_cbsa)),h.orig_cbsa<>(typeof(h.orig_cbsa))'');
    populated_orig_county_code_pcnt := AVE(GROUP,IF(h.orig_county_code = (TYPEOF(h.orig_county_code))'',0,100));
    maxlength_orig_county_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_county_code)));
    avelength_orig_county_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_county_code)),h.orig_county_code<>(typeof(h.orig_county_code))'');
    populated_orig_time_zone_pcnt := AVE(GROUP,IF(h.orig_time_zone = (TYPEOF(h.orig_time_zone))'',0,100));
    maxlength_orig_time_zone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_time_zone)));
    avelength_orig_time_zone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_time_zone)),h.orig_time_zone<>(typeof(h.orig_time_zone))'');
    populated_orig_daylight_savings_pcnt := AVE(GROUP,IF(h.orig_daylight_savings = (TYPEOF(h.orig_daylight_savings))'',0,100));
    maxlength_orig_daylight_savings := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_daylight_savings)));
    avelength_orig_daylight_savings := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_daylight_savings)),h.orig_daylight_savings<>(typeof(h.orig_daylight_savings))'');
    populated_orig_lat_long_assignment_level_pcnt := AVE(GROUP,IF(h.orig_lat_long_assignment_level = (TYPEOF(h.orig_lat_long_assignment_level))'',0,100));
    maxlength_orig_lat_long_assignment_level := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_lat_long_assignment_level)));
    avelength_orig_lat_long_assignment_level := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_lat_long_assignment_level)),h.orig_lat_long_assignment_level<>(typeof(h.orig_lat_long_assignment_level))'');
    populated_orig_latitude_pcnt := AVE(GROUP,IF(h.orig_latitude = (TYPEOF(h.orig_latitude))'',0,100));
    maxlength_orig_latitude := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_latitude)));
    avelength_orig_latitude := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_latitude)),h.orig_latitude<>(typeof(h.orig_latitude))'');
    populated_orig_longitude_pcnt := AVE(GROUP,IF(h.orig_longitude = (TYPEOF(h.orig_longitude))'',0,100));
    maxlength_orig_longitude := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_longitude)));
    avelength_orig_longitude := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_longitude)),h.orig_longitude<>(typeof(h.orig_longitude))'');
    populated_orig_telephonenumber_1_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_1 = (TYPEOF(h.orig_telephonenumber_1))'',0,100));
    maxlength_orig_telephonenumber_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_1)));
    avelength_orig_telephonenumber_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_1)),h.orig_telephonenumber_1<>(typeof(h.orig_telephonenumber_1))'');
    populated_orig_validationflag_1_pcnt := AVE(GROUP,IF(h.orig_validationflag_1 = (TYPEOF(h.orig_validationflag_1))'',0,100));
    maxlength_orig_validationflag_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_1)));
    avelength_orig_validationflag_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_1)),h.orig_validationflag_1<>(typeof(h.orig_validationflag_1))'');
    populated_orig_validationdate_1_pcnt := AVE(GROUP,IF(h.orig_validationdate_1 = (TYPEOF(h.orig_validationdate_1))'',0,100));
    maxlength_orig_validationdate_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_1)));
    avelength_orig_validationdate_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_1)),h.orig_validationdate_1<>(typeof(h.orig_validationdate_1))'');
    populated_orig_dma_tps_dnc_flag_1_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_1 = (TYPEOF(h.orig_dma_tps_dnc_flag_1))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_1)));
    avelength_orig_dma_tps_dnc_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_1)),h.orig_dma_tps_dnc_flag_1<>(typeof(h.orig_dma_tps_dnc_flag_1))'');
    populated_orig_telephonenumber_2_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_2 = (TYPEOF(h.orig_telephonenumber_2))'',0,100));
    maxlength_orig_telephonenumber_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_2)));
    avelength_orig_telephonenumber_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_2)),h.orig_telephonenumber_2<>(typeof(h.orig_telephonenumber_2))'');
    populated_orig_validation_flag_2_pcnt := AVE(GROUP,IF(h.orig_validation_flag_2 = (TYPEOF(h.orig_validation_flag_2))'',0,100));
    maxlength_orig_validation_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validation_flag_2)));
    avelength_orig_validation_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validation_flag_2)),h.orig_validation_flag_2<>(typeof(h.orig_validation_flag_2))'');
    populated_orig_validation_date_2_pcnt := AVE(GROUP,IF(h.orig_validation_date_2 = (TYPEOF(h.orig_validation_date_2))'',0,100));
    maxlength_orig_validation_date_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validation_date_2)));
    avelength_orig_validation_date_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validation_date_2)),h.orig_validation_date_2<>(typeof(h.orig_validation_date_2))'');
    populated_orig_dma_tps_dnc_flag_2_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_2 = (TYPEOF(h.orig_dma_tps_dnc_flag_2))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_2)));
    avelength_orig_dma_tps_dnc_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_2)),h.orig_dma_tps_dnc_flag_2<>(typeof(h.orig_dma_tps_dnc_flag_2))'');
    populated_orig_telephonenumber_3_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_3 = (TYPEOF(h.orig_telephonenumber_3))'',0,100));
    maxlength_orig_telephonenumber_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_3)));
    avelength_orig_telephonenumber_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_3)),h.orig_telephonenumber_3<>(typeof(h.orig_telephonenumber_3))'');
    populated_orig_validationflag_3_pcnt := AVE(GROUP,IF(h.orig_validationflag_3 = (TYPEOF(h.orig_validationflag_3))'',0,100));
    maxlength_orig_validationflag_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_3)));
    avelength_orig_validationflag_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_3)),h.orig_validationflag_3<>(typeof(h.orig_validationflag_3))'');
    populated_orig_validationdate_3_pcnt := AVE(GROUP,IF(h.orig_validationdate_3 = (TYPEOF(h.orig_validationdate_3))'',0,100));
    maxlength_orig_validationdate_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_3)));
    avelength_orig_validationdate_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_3)),h.orig_validationdate_3<>(typeof(h.orig_validationdate_3))'');
    populated_orig_dma_tps_dnc_flag_3_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_3 = (TYPEOF(h.orig_dma_tps_dnc_flag_3))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_3)));
    avelength_orig_dma_tps_dnc_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_3)),h.orig_dma_tps_dnc_flag_3<>(typeof(h.orig_dma_tps_dnc_flag_3))'');
    populated_orig_telephonenumber_4_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_4 = (TYPEOF(h.orig_telephonenumber_4))'',0,100));
    maxlength_orig_telephonenumber_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_4)));
    avelength_orig_telephonenumber_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_4)),h.orig_telephonenumber_4<>(typeof(h.orig_telephonenumber_4))'');
    populated_orig_validationflag_4_pcnt := AVE(GROUP,IF(h.orig_validationflag_4 = (TYPEOF(h.orig_validationflag_4))'',0,100));
    maxlength_orig_validationflag_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_4)));
    avelength_orig_validationflag_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_4)),h.orig_validationflag_4<>(typeof(h.orig_validationflag_4))'');
    populated_orig_validationdate_4_pcnt := AVE(GROUP,IF(h.orig_validationdate_4 = (TYPEOF(h.orig_validationdate_4))'',0,100));
    maxlength_orig_validationdate_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_4)));
    avelength_orig_validationdate_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_4)),h.orig_validationdate_4<>(typeof(h.orig_validationdate_4))'');
    populated_orig_dma_tps_dnc_flag_4_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_4 = (TYPEOF(h.orig_dma_tps_dnc_flag_4))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_4)));
    avelength_orig_dma_tps_dnc_flag_4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_4)),h.orig_dma_tps_dnc_flag_4<>(typeof(h.orig_dma_tps_dnc_flag_4))'');
    populated_orig_telephonenumber_5_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_5 = (TYPEOF(h.orig_telephonenumber_5))'',0,100));
    maxlength_orig_telephonenumber_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_5)));
    avelength_orig_telephonenumber_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_5)),h.orig_telephonenumber_5<>(typeof(h.orig_telephonenumber_5))'');
    populated_orig_validationflag_5_pcnt := AVE(GROUP,IF(h.orig_validationflag_5 = (TYPEOF(h.orig_validationflag_5))'',0,100));
    maxlength_orig_validationflag_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_5)));
    avelength_orig_validationflag_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_5)),h.orig_validationflag_5<>(typeof(h.orig_validationflag_5))'');
    populated_orig_validationdate_5_pcnt := AVE(GROUP,IF(h.orig_validationdate_5 = (TYPEOF(h.orig_validationdate_5))'',0,100));
    maxlength_orig_validationdate_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_5)));
    avelength_orig_validationdate_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_5)),h.orig_validationdate_5<>(typeof(h.orig_validationdate_5))'');
    populated_orig_dma_tps_dnc_flag_5_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_5 = (TYPEOF(h.orig_dma_tps_dnc_flag_5))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_5)));
    avelength_orig_dma_tps_dnc_flag_5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_5)),h.orig_dma_tps_dnc_flag_5<>(typeof(h.orig_dma_tps_dnc_flag_5))'');
    populated_orig_telephonenumber_6_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_6 = (TYPEOF(h.orig_telephonenumber_6))'',0,100));
    maxlength_orig_telephonenumber_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_6)));
    avelength_orig_telephonenumber_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_6)),h.orig_telephonenumber_6<>(typeof(h.orig_telephonenumber_6))'');
    populated_orig_validationflag_6_pcnt := AVE(GROUP,IF(h.orig_validationflag_6 = (TYPEOF(h.orig_validationflag_6))'',0,100));
    maxlength_orig_validationflag_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_6)));
    avelength_orig_validationflag_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_6)),h.orig_validationflag_6<>(typeof(h.orig_validationflag_6))'');
    populated_orig_validationdate_6_pcnt := AVE(GROUP,IF(h.orig_validationdate_6 = (TYPEOF(h.orig_validationdate_6))'',0,100));
    maxlength_orig_validationdate_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_6)));
    avelength_orig_validationdate_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_6)),h.orig_validationdate_6<>(typeof(h.orig_validationdate_6))'');
    populated_orig_dma_tps_dnc_flag_6_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_6 = (TYPEOF(h.orig_dma_tps_dnc_flag_6))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_6 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_6)));
    avelength_orig_dma_tps_dnc_flag_6 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_6)),h.orig_dma_tps_dnc_flag_6<>(typeof(h.orig_dma_tps_dnc_flag_6))'');
    populated_orig_telephonenumber_7_pcnt := AVE(GROUP,IF(h.orig_telephonenumber_7 = (TYPEOF(h.orig_telephonenumber_7))'',0,100));
    maxlength_orig_telephonenumber_7 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_7)));
    avelength_orig_telephonenumber_7 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_telephonenumber_7)),h.orig_telephonenumber_7<>(typeof(h.orig_telephonenumber_7))'');
    populated_orig_validationflag_7_pcnt := AVE(GROUP,IF(h.orig_validationflag_7 = (TYPEOF(h.orig_validationflag_7))'',0,100));
    maxlength_orig_validationflag_7 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_7)));
    avelength_orig_validationflag_7 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationflag_7)),h.orig_validationflag_7<>(typeof(h.orig_validationflag_7))'');
    populated_orig_validationdate_7_pcnt := AVE(GROUP,IF(h.orig_validationdate_7 = (TYPEOF(h.orig_validationdate_7))'',0,100));
    maxlength_orig_validationdate_7 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_7)));
    avelength_orig_validationdate_7 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_validationdate_7)),h.orig_validationdate_7<>(typeof(h.orig_validationdate_7))'');
    populated_orig_dma_tps_dnc_flag_7_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_7 = (TYPEOF(h.orig_dma_tps_dnc_flag_7))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_7 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_7)));
    avelength_orig_dma_tps_dnc_flag_7 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dma_tps_dnc_flag_7)),h.orig_dma_tps_dnc_flag_7<>(typeof(h.orig_dma_tps_dnc_flag_7))'');
    populated_orig_tot_phones_pcnt := AVE(GROUP,IF(h.orig_tot_phones = (TYPEOF(h.orig_tot_phones))'',0,100));
    maxlength_orig_tot_phones := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_tot_phones)));
    avelength_orig_tot_phones := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_tot_phones)),h.orig_tot_phones<>(typeof(h.orig_tot_phones))'');
    populated_orig_length_of_residence_pcnt := AVE(GROUP,IF(h.orig_length_of_residence = (TYPEOF(h.orig_length_of_residence))'',0,100));
    maxlength_orig_length_of_residence := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_length_of_residence)));
    avelength_orig_length_of_residence := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_length_of_residence)),h.orig_length_of_residence<>(typeof(h.orig_length_of_residence))'');
    populated_orig_homeowner_pcnt := AVE(GROUP,IF(h.orig_homeowner = (TYPEOF(h.orig_homeowner))'',0,100));
    maxlength_orig_homeowner := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_homeowner)));
    avelength_orig_homeowner := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_homeowner)),h.orig_homeowner<>(typeof(h.orig_homeowner))'');
    populated_orig_estimatedincome_pcnt := AVE(GROUP,IF(h.orig_estimatedincome = (TYPEOF(h.orig_estimatedincome))'',0,100));
    maxlength_orig_estimatedincome := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_estimatedincome)));
    avelength_orig_estimatedincome := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_estimatedincome)),h.orig_estimatedincome<>(typeof(h.orig_estimatedincome))'');
    populated_orig_dwelling_type_pcnt := AVE(GROUP,IF(h.orig_dwelling_type = (TYPEOF(h.orig_dwelling_type))'',0,100));
    maxlength_orig_dwelling_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dwelling_type)));
    avelength_orig_dwelling_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_dwelling_type)),h.orig_dwelling_type<>(typeof(h.orig_dwelling_type))'');
    populated_orig_married_pcnt := AVE(GROUP,IF(h.orig_married = (TYPEOF(h.orig_married))'',0,100));
    maxlength_orig_married := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_married)));
    avelength_orig_married := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_married)),h.orig_married<>(typeof(h.orig_married))'');
    populated_orig_child_pcnt := AVE(GROUP,IF(h.orig_child = (TYPEOF(h.orig_child))'',0,100));
    maxlength_orig_child := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_child)));
    avelength_orig_child := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_child)),h.orig_child<>(typeof(h.orig_child))'');
    populated_orig_nbrchild_pcnt := AVE(GROUP,IF(h.orig_nbrchild = (TYPEOF(h.orig_nbrchild))'',0,100));
    maxlength_orig_nbrchild := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_nbrchild)));
    avelength_orig_nbrchild := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_nbrchild)),h.orig_nbrchild<>(typeof(h.orig_nbrchild))'');
    populated_orig_teencd_pcnt := AVE(GROUP,IF(h.orig_teencd = (TYPEOF(h.orig_teencd))'',0,100));
    maxlength_orig_teencd := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_teencd)));
    avelength_orig_teencd := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_teencd)),h.orig_teencd<>(typeof(h.orig_teencd))'');
    populated_orig_percent_range_black_pcnt := AVE(GROUP,IF(h.orig_percent_range_black = (TYPEOF(h.orig_percent_range_black))'',0,100));
    maxlength_orig_percent_range_black := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_black)));
    avelength_orig_percent_range_black := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_black)),h.orig_percent_range_black<>(typeof(h.orig_percent_range_black))'');
    populated_orig_percent_range_white_pcnt := AVE(GROUP,IF(h.orig_percent_range_white = (TYPEOF(h.orig_percent_range_white))'',0,100));
    maxlength_orig_percent_range_white := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_white)));
    avelength_orig_percent_range_white := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_white)),h.orig_percent_range_white<>(typeof(h.orig_percent_range_white))'');
    populated_orig_percent_range_hispanic_pcnt := AVE(GROUP,IF(h.orig_percent_range_hispanic = (TYPEOF(h.orig_percent_range_hispanic))'',0,100));
    maxlength_orig_percent_range_hispanic := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_hispanic)));
    avelength_orig_percent_range_hispanic := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_hispanic)),h.orig_percent_range_hispanic<>(typeof(h.orig_percent_range_hispanic))'');
    populated_orig_percent_range_asian_pcnt := AVE(GROUP,IF(h.orig_percent_range_asian = (TYPEOF(h.orig_percent_range_asian))'',0,100));
    maxlength_orig_percent_range_asian := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_asian)));
    avelength_orig_percent_range_asian := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_asian)),h.orig_percent_range_asian<>(typeof(h.orig_percent_range_asian))'');
    populated_orig_percent_range_english_speaking_pcnt := AVE(GROUP,IF(h.orig_percent_range_english_speaking = (TYPEOF(h.orig_percent_range_english_speaking))'',0,100));
    maxlength_orig_percent_range_english_speaking := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_english_speaking)));
    avelength_orig_percent_range_english_speaking := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_english_speaking)),h.orig_percent_range_english_speaking<>(typeof(h.orig_percent_range_english_speaking))'');
    populated_orig_percnt_range_spanish_speaking_pcnt := AVE(GROUP,IF(h.orig_percnt_range_spanish_speaking = (TYPEOF(h.orig_percnt_range_spanish_speaking))'',0,100));
    maxlength_orig_percnt_range_spanish_speaking := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percnt_range_spanish_speaking)));
    avelength_orig_percnt_range_spanish_speaking := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percnt_range_spanish_speaking)),h.orig_percnt_range_spanish_speaking<>(typeof(h.orig_percnt_range_spanish_speaking))'');
    populated_orig_percent_range_asian_speaking_pcnt := AVE(GROUP,IF(h.orig_percent_range_asian_speaking = (TYPEOF(h.orig_percent_range_asian_speaking))'',0,100));
    maxlength_orig_percent_range_asian_speaking := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_asian_speaking)));
    avelength_orig_percent_range_asian_speaking := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_asian_speaking)),h.orig_percent_range_asian_speaking<>(typeof(h.orig_percent_range_asian_speaking))'');
    populated_orig_percent_range_sfdu_pcnt := AVE(GROUP,IF(h.orig_percent_range_sfdu = (TYPEOF(h.orig_percent_range_sfdu))'',0,100));
    maxlength_orig_percent_range_sfdu := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_sfdu)));
    avelength_orig_percent_range_sfdu := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_sfdu)),h.orig_percent_range_sfdu<>(typeof(h.orig_percent_range_sfdu))'');
    populated_orig_percent_range_mfdu_pcnt := AVE(GROUP,IF(h.orig_percent_range_mfdu = (TYPEOF(h.orig_percent_range_mfdu))'',0,100));
    maxlength_orig_percent_range_mfdu := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_mfdu)));
    avelength_orig_percent_range_mfdu := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_percent_range_mfdu)),h.orig_percent_range_mfdu<>(typeof(h.orig_percent_range_mfdu))'');
    populated_orig_mhv_pcnt := AVE(GROUP,IF(h.orig_mhv = (TYPEOF(h.orig_mhv))'',0,100));
    maxlength_orig_mhv := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_mhv)));
    avelength_orig_mhv := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_mhv)),h.orig_mhv<>(typeof(h.orig_mhv))'');
    populated_orig_mor_pcnt := AVE(GROUP,IF(h.orig_mor = (TYPEOF(h.orig_mor))'',0,100));
    maxlength_orig_mor := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_mor)));
    avelength_orig_mor := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_mor)),h.orig_mor<>(typeof(h.orig_mor))'');
    populated_orig_car_pcnt := AVE(GROUP,IF(h.orig_car = (TYPEOF(h.orig_car))'',0,100));
    maxlength_orig_car := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_car)));
    avelength_orig_car := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_car)),h.orig_car<>(typeof(h.orig_car))'');
    populated_orig_medschl_pcnt := AVE(GROUP,IF(h.orig_medschl = (TYPEOF(h.orig_medschl))'',0,100));
    maxlength_orig_medschl := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_medschl)));
    avelength_orig_medschl := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_medschl)),h.orig_medschl<>(typeof(h.orig_medschl))'');
    populated_orig_penetration_range_whitecollar_pcnt := AVE(GROUP,IF(h.orig_penetration_range_whitecollar = (TYPEOF(h.orig_penetration_range_whitecollar))'',0,100));
    maxlength_orig_penetration_range_whitecollar := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_penetration_range_whitecollar)));
    avelength_orig_penetration_range_whitecollar := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_penetration_range_whitecollar)),h.orig_penetration_range_whitecollar<>(typeof(h.orig_penetration_range_whitecollar))'');
    populated_orig_penetration_range_bluecollar_pcnt := AVE(GROUP,IF(h.orig_penetration_range_bluecollar = (TYPEOF(h.orig_penetration_range_bluecollar))'',0,100));
    maxlength_orig_penetration_range_bluecollar := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_penetration_range_bluecollar)));
    avelength_orig_penetration_range_bluecollar := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_penetration_range_bluecollar)),h.orig_penetration_range_bluecollar<>(typeof(h.orig_penetration_range_bluecollar))'');
    populated_orig_penetration_range_otheroccupation_pcnt := AVE(GROUP,IF(h.orig_penetration_range_otheroccupation = (TYPEOF(h.orig_penetration_range_otheroccupation))'',0,100));
    maxlength_orig_penetration_range_otheroccupation := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_penetration_range_otheroccupation)));
    avelength_orig_penetration_range_otheroccupation := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_penetration_range_otheroccupation)),h.orig_penetration_range_otheroccupation<>(typeof(h.orig_penetration_range_otheroccupation))'');
    populated_orig_demolevel_pcnt := AVE(GROUP,IF(h.orig_demolevel = (TYPEOF(h.orig_demolevel))'',0,100));
    maxlength_orig_demolevel := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_demolevel)));
    avelength_orig_demolevel := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_demolevel)),h.orig_demolevel<>(typeof(h.orig_demolevel))'');
    populated_orig_recdate_pcnt := AVE(GROUP,IF(h.orig_recdate = (TYPEOF(h.orig_recdate))'',0,100));
    maxlength_orig_recdate := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_recdate)));
    avelength_orig_recdate := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orig_recdate)),h.orig_recdate<>(typeof(h.orig_recdate))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_hhid_pcnt *   0.00 / 100 + T.Populated_orig_pid_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_orig_gender_pcnt *   0.00 / 100 + T.Populated_orig_age_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_hhnbr_pcnt *   0.00 / 100 + T.Populated_orig_tot_males_pcnt *   0.00 / 100 + T.Populated_orig_tot_females_pcnt *   0.00 / 100 + T.Populated_orig_addrid_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_house_pcnt *   0.00 / 100 + T.Populated_orig_predir_pcnt *   0.00 / 100 + T.Populated_orig_street_pcnt *   0.00 / 100 + T.Populated_orig_strtype_pcnt *   0.00 / 100 + T.Populated_orig_postdir_pcnt *   0.00 / 100 + T.Populated_orig_apttype_pcnt *   0.00 / 100 + T.Populated_orig_aptnbr_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_z4_pcnt *   0.00 / 100 + T.Populated_orig_dpc_pcnt *   0.00 / 100 + T.Populated_orig_z4type_pcnt *   0.00 / 100 + T.Populated_orig_crte_pcnt *   0.00 / 100 + T.Populated_orig_dpv_pcnt *   0.00 / 100 + T.Populated_orig_vacant_pcnt *   0.00 / 100 + T.Populated_orig_msa_pcnt *   0.00 / 100 + T.Populated_orig_cbsa_pcnt *   0.00 / 100 + T.Populated_orig_county_code_pcnt *   0.00 / 100 + T.Populated_orig_time_zone_pcnt *   0.00 / 100 + T.Populated_orig_daylight_savings_pcnt *   0.00 / 100 + T.Populated_orig_lat_long_assignment_level_pcnt *   0.00 / 100 + T.Populated_orig_latitude_pcnt *   0.00 / 100 + T.Populated_orig_longitude_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_1_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_1_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_1_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_1_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_2_pcnt *   0.00 / 100 + T.Populated_orig_validation_flag_2_pcnt *   0.00 / 100 + T.Populated_orig_validation_date_2_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_2_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_3_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_3_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_3_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_3_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_4_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_4_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_4_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_4_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_5_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_5_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_5_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_5_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_6_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_6_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_6_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_6_pcnt *   0.00 / 100 + T.Populated_orig_telephonenumber_7_pcnt *   0.00 / 100 + T.Populated_orig_validationflag_7_pcnt *   0.00 / 100 + T.Populated_orig_validationdate_7_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_7_pcnt *   0.00 / 100 + T.Populated_orig_tot_phones_pcnt *   0.00 / 100 + T.Populated_orig_length_of_residence_pcnt *   0.00 / 100 + T.Populated_orig_homeowner_pcnt *   0.00 / 100 + T.Populated_orig_estimatedincome_pcnt *   0.00 / 100 + T.Populated_orig_dwelling_type_pcnt *   0.00 / 100 + T.Populated_orig_married_pcnt *   0.00 / 100 + T.Populated_orig_child_pcnt *   0.00 / 100 + T.Populated_orig_nbrchild_pcnt *   0.00 / 100 + T.Populated_orig_teencd_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_black_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_white_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_hispanic_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_asian_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_english_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percnt_range_spanish_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_asian_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_sfdu_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_mfdu_pcnt *   0.00 / 100 + T.Populated_orig_mhv_pcnt *   0.00 / 100 + T.Populated_orig_mor_pcnt *   0.00 / 100 + T.Populated_orig_car_pcnt *   0.00 / 100 + T.Populated_orig_medschl_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_whitecollar_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_bluecollar_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_otheroccupation_pcnt *   0.00 / 100 + T.Populated_orig_demolevel_pcnt *   0.00 / 100 + T.Populated_orig_recdate_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orig_hhid','orig_pid','orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_tot_males','orig_tot_females','orig_addrid','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_dpc','orig_z4type','orig_crte','orig_dpv','orig_vacant','orig_msa','orig_cbsa','orig_county_code','orig_time_zone','orig_daylight_savings','orig_lat_long_assignment_level','orig_latitude','orig_longitude','orig_telephonenumber_1','orig_validationflag_1','orig_validationdate_1','orig_dma_tps_dnc_flag_1','orig_telephonenumber_2','orig_validation_flag_2','orig_validation_date_2','orig_dma_tps_dnc_flag_2','orig_telephonenumber_3','orig_validationflag_3','orig_validationdate_3','orig_dma_tps_dnc_flag_3','orig_telephonenumber_4','orig_validationflag_4','orig_validationdate_4','orig_dma_tps_dnc_flag_4','orig_telephonenumber_5','orig_validationflag_5','orig_validationdate_5','orig_dma_tps_dnc_flag_5','orig_telephonenumber_6','orig_validationflag_6','orig_validationdate_6','orig_dma_tps_dnc_flag_6','orig_telephonenumber_7','orig_validationflag_7','orig_validationdate_7','orig_dma_tps_dnc_flag_7','orig_tot_phones','orig_length_of_residence','orig_homeowner','orig_estimatedincome','orig_dwelling_type','orig_married','orig_child','orig_nbrchild','orig_teencd','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_whitecollar','orig_penetration_range_bluecollar','orig_penetration_range_otheroccupation','orig_demolevel','orig_recdate');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_hhid_pcnt,le.populated_orig_pid_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_suffix_pcnt,le.populated_orig_gender_pcnt,le.populated_orig_age_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_hhnbr_pcnt,le.populated_orig_tot_males_pcnt,le.populated_orig_tot_females_pcnt,le.populated_orig_addrid_pcnt,le.populated_orig_address_pcnt,le.populated_orig_house_pcnt,le.populated_orig_predir_pcnt,le.populated_orig_street_pcnt,le.populated_orig_strtype_pcnt,le.populated_orig_postdir_pcnt,le.populated_orig_apttype_pcnt,le.populated_orig_aptnbr_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_z4_pcnt,le.populated_orig_dpc_pcnt,le.populated_orig_z4type_pcnt,le.populated_orig_crte_pcnt,le.populated_orig_dpv_pcnt,le.populated_orig_vacant_pcnt,le.populated_orig_msa_pcnt,le.populated_orig_cbsa_pcnt,le.populated_orig_county_code_pcnt,le.populated_orig_time_zone_pcnt,le.populated_orig_daylight_savings_pcnt,le.populated_orig_lat_long_assignment_level_pcnt,le.populated_orig_latitude_pcnt,le.populated_orig_longitude_pcnt,le.populated_orig_telephonenumber_1_pcnt,le.populated_orig_validationflag_1_pcnt,le.populated_orig_validationdate_1_pcnt,le.populated_orig_dma_tps_dnc_flag_1_pcnt,le.populated_orig_telephonenumber_2_pcnt,le.populated_orig_validation_flag_2_pcnt,le.populated_orig_validation_date_2_pcnt,le.populated_orig_dma_tps_dnc_flag_2_pcnt,le.populated_orig_telephonenumber_3_pcnt,le.populated_orig_validationflag_3_pcnt,le.populated_orig_validationdate_3_pcnt,le.populated_orig_dma_tps_dnc_flag_3_pcnt,le.populated_orig_telephonenumber_4_pcnt,le.populated_orig_validationflag_4_pcnt,le.populated_orig_validationdate_4_pcnt,le.populated_orig_dma_tps_dnc_flag_4_pcnt,le.populated_orig_telephonenumber_5_pcnt,le.populated_orig_validationflag_5_pcnt,le.populated_orig_validationdate_5_pcnt,le.populated_orig_dma_tps_dnc_flag_5_pcnt,le.populated_orig_telephonenumber_6_pcnt,le.populated_orig_validationflag_6_pcnt,le.populated_orig_validationdate_6_pcnt,le.populated_orig_dma_tps_dnc_flag_6_pcnt,le.populated_orig_telephonenumber_7_pcnt,le.populated_orig_validationflag_7_pcnt,le.populated_orig_validationdate_7_pcnt,le.populated_orig_dma_tps_dnc_flag_7_pcnt,le.populated_orig_tot_phones_pcnt,le.populated_orig_length_of_residence_pcnt,le.populated_orig_homeowner_pcnt,le.populated_orig_estimatedincome_pcnt,le.populated_orig_dwelling_type_pcnt,le.populated_orig_married_pcnt,le.populated_orig_child_pcnt,le.populated_orig_nbrchild_pcnt,le.populated_orig_teencd_pcnt,le.populated_orig_percent_range_black_pcnt,le.populated_orig_percent_range_white_pcnt,le.populated_orig_percent_range_hispanic_pcnt,le.populated_orig_percent_range_asian_pcnt,le.populated_orig_percent_range_english_speaking_pcnt,le.populated_orig_percnt_range_spanish_speaking_pcnt,le.populated_orig_percent_range_asian_speaking_pcnt,le.populated_orig_percent_range_sfdu_pcnt,le.populated_orig_percent_range_mfdu_pcnt,le.populated_orig_mhv_pcnt,le.populated_orig_mor_pcnt,le.populated_orig_car_pcnt,le.populated_orig_medschl_pcnt,le.populated_orig_penetration_range_whitecollar_pcnt,le.populated_orig_penetration_range_bluecollar_pcnt,le.populated_orig_penetration_range_otheroccupation_pcnt,le.populated_orig_demolevel_pcnt,le.populated_orig_recdate_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_hhid,le.maxlength_orig_pid,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_suffix,le.maxlength_orig_gender,le.maxlength_orig_age,le.maxlength_orig_dob,le.maxlength_orig_hhnbr,le.maxlength_orig_tot_males,le.maxlength_orig_tot_females,le.maxlength_orig_addrid,le.maxlength_orig_address,le.maxlength_orig_house,le.maxlength_orig_predir,le.maxlength_orig_street,le.maxlength_orig_strtype,le.maxlength_orig_postdir,le.maxlength_orig_apttype,le.maxlength_orig_aptnbr,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_z4,le.maxlength_orig_dpc,le.maxlength_orig_z4type,le.maxlength_orig_crte,le.maxlength_orig_dpv,le.maxlength_orig_vacant,le.maxlength_orig_msa,le.maxlength_orig_cbsa,le.maxlength_orig_county_code,le.maxlength_orig_time_zone,le.maxlength_orig_daylight_savings,le.maxlength_orig_lat_long_assignment_level,le.maxlength_orig_latitude,le.maxlength_orig_longitude,le.maxlength_orig_telephonenumber_1,le.maxlength_orig_validationflag_1,le.maxlength_orig_validationdate_1,le.maxlength_orig_dma_tps_dnc_flag_1,le.maxlength_orig_telephonenumber_2,le.maxlength_orig_validation_flag_2,le.maxlength_orig_validation_date_2,le.maxlength_orig_dma_tps_dnc_flag_2,le.maxlength_orig_telephonenumber_3,le.maxlength_orig_validationflag_3,le.maxlength_orig_validationdate_3,le.maxlength_orig_dma_tps_dnc_flag_3,le.maxlength_orig_telephonenumber_4,le.maxlength_orig_validationflag_4,le.maxlength_orig_validationdate_4,le.maxlength_orig_dma_tps_dnc_flag_4,le.maxlength_orig_telephonenumber_5,le.maxlength_orig_validationflag_5,le.maxlength_orig_validationdate_5,le.maxlength_orig_dma_tps_dnc_flag_5,le.maxlength_orig_telephonenumber_6,le.maxlength_orig_validationflag_6,le.maxlength_orig_validationdate_6,le.maxlength_orig_dma_tps_dnc_flag_6,le.maxlength_orig_telephonenumber_7,le.maxlength_orig_validationflag_7,le.maxlength_orig_validationdate_7,le.maxlength_orig_dma_tps_dnc_flag_7,le.maxlength_orig_tot_phones,le.maxlength_orig_length_of_residence,le.maxlength_orig_homeowner,le.maxlength_orig_estimatedincome,le.maxlength_orig_dwelling_type,le.maxlength_orig_married,le.maxlength_orig_child,le.maxlength_orig_nbrchild,le.maxlength_orig_teencd,le.maxlength_orig_percent_range_black,le.maxlength_orig_percent_range_white,le.maxlength_orig_percent_range_hispanic,le.maxlength_orig_percent_range_asian,le.maxlength_orig_percent_range_english_speaking,le.maxlength_orig_percnt_range_spanish_speaking,le.maxlength_orig_percent_range_asian_speaking,le.maxlength_orig_percent_range_sfdu,le.maxlength_orig_percent_range_mfdu,le.maxlength_orig_mhv,le.maxlength_orig_mor,le.maxlength_orig_car,le.maxlength_orig_medschl,le.maxlength_orig_penetration_range_whitecollar,le.maxlength_orig_penetration_range_bluecollar,le.maxlength_orig_penetration_range_otheroccupation,le.maxlength_orig_demolevel,le.maxlength_orig_recdate);
  SELF.avelength := CHOOSE(C,le.avelength_orig_hhid,le.avelength_orig_pid,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_suffix,le.avelength_orig_gender,le.avelength_orig_age,le.avelength_orig_dob,le.avelength_orig_hhnbr,le.avelength_orig_tot_males,le.avelength_orig_tot_females,le.avelength_orig_addrid,le.avelength_orig_address,le.avelength_orig_house,le.avelength_orig_predir,le.avelength_orig_street,le.avelength_orig_strtype,le.avelength_orig_postdir,le.avelength_orig_apttype,le.avelength_orig_aptnbr,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_z4,le.avelength_orig_dpc,le.avelength_orig_z4type,le.avelength_orig_crte,le.avelength_orig_dpv,le.avelength_orig_vacant,le.avelength_orig_msa,le.avelength_orig_cbsa,le.avelength_orig_county_code,le.avelength_orig_time_zone,le.avelength_orig_daylight_savings,le.avelength_orig_lat_long_assignment_level,le.avelength_orig_latitude,le.avelength_orig_longitude,le.avelength_orig_telephonenumber_1,le.avelength_orig_validationflag_1,le.avelength_orig_validationdate_1,le.avelength_orig_dma_tps_dnc_flag_1,le.avelength_orig_telephonenumber_2,le.avelength_orig_validation_flag_2,le.avelength_orig_validation_date_2,le.avelength_orig_dma_tps_dnc_flag_2,le.avelength_orig_telephonenumber_3,le.avelength_orig_validationflag_3,le.avelength_orig_validationdate_3,le.avelength_orig_dma_tps_dnc_flag_3,le.avelength_orig_telephonenumber_4,le.avelength_orig_validationflag_4,le.avelength_orig_validationdate_4,le.avelength_orig_dma_tps_dnc_flag_4,le.avelength_orig_telephonenumber_5,le.avelength_orig_validationflag_5,le.avelength_orig_validationdate_5,le.avelength_orig_dma_tps_dnc_flag_5,le.avelength_orig_telephonenumber_6,le.avelength_orig_validationflag_6,le.avelength_orig_validationdate_6,le.avelength_orig_dma_tps_dnc_flag_6,le.avelength_orig_telephonenumber_7,le.avelength_orig_validationflag_7,le.avelength_orig_validationdate_7,le.avelength_orig_dma_tps_dnc_flag_7,le.avelength_orig_tot_phones,le.avelength_orig_length_of_residence,le.avelength_orig_homeowner,le.avelength_orig_estimatedincome,le.avelength_orig_dwelling_type,le.avelength_orig_married,le.avelength_orig_child,le.avelength_orig_nbrchild,le.avelength_orig_teencd,le.avelength_orig_percent_range_black,le.avelength_orig_percent_range_white,le.avelength_orig_percent_range_hispanic,le.avelength_orig_percent_range_asian,le.avelength_orig_percent_range_english_speaking,le.avelength_orig_percnt_range_spanish_speaking,le.avelength_orig_percent_range_asian_speaking,le.avelength_orig_percent_range_sfdu,le.avelength_orig_percent_range_mfdu,le.avelength_orig_mhv,le.avelength_orig_mor,le.avelength_orig_car,le.avelength_orig_medschl,le.avelength_orig_penetration_range_whitecollar,le.avelength_orig_penetration_range_bluecollar,le.avelength_orig_penetration_range_otheroccupation,le.avelength_orig_demolevel,le.avelength_orig_recdate);
END;
EXPORT invSummary := NORMALIZE(summary0, 93, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.orig_hhid),TRIM((SALT32.StrType)le.orig_pid),TRIM((SALT32.StrType)le.orig_fname),TRIM((SALT32.StrType)le.orig_mname),TRIM((SALT32.StrType)le.orig_lname),TRIM((SALT32.StrType)le.orig_suffix),TRIM((SALT32.StrType)le.orig_gender),TRIM((SALT32.StrType)le.orig_age),TRIM((SALT32.StrType)le.orig_dob),TRIM((SALT32.StrType)le.orig_hhnbr),TRIM((SALT32.StrType)le.orig_tot_males),TRIM((SALT32.StrType)le.orig_tot_females),TRIM((SALT32.StrType)le.orig_addrid),TRIM((SALT32.StrType)le.orig_address),TRIM((SALT32.StrType)le.orig_house),TRIM((SALT32.StrType)le.orig_predir),TRIM((SALT32.StrType)le.orig_street),TRIM((SALT32.StrType)le.orig_strtype),TRIM((SALT32.StrType)le.orig_postdir),TRIM((SALT32.StrType)le.orig_apttype),TRIM((SALT32.StrType)le.orig_aptnbr),TRIM((SALT32.StrType)le.orig_city),TRIM((SALT32.StrType)le.orig_state),TRIM((SALT32.StrType)le.orig_zip),TRIM((SALT32.StrType)le.orig_z4),TRIM((SALT32.StrType)le.orig_dpc),TRIM((SALT32.StrType)le.orig_z4type),TRIM((SALT32.StrType)le.orig_crte),TRIM((SALT32.StrType)le.orig_dpv),TRIM((SALT32.StrType)le.orig_vacant),TRIM((SALT32.StrType)le.orig_msa),TRIM((SALT32.StrType)le.orig_cbsa),TRIM((SALT32.StrType)le.orig_county_code),TRIM((SALT32.StrType)le.orig_time_zone),TRIM((SALT32.StrType)le.orig_daylight_savings),TRIM((SALT32.StrType)le.orig_lat_long_assignment_level),TRIM((SALT32.StrType)le.orig_latitude),TRIM((SALT32.StrType)le.orig_longitude),TRIM((SALT32.StrType)le.orig_telephonenumber_1),TRIM((SALT32.StrType)le.orig_validationflag_1),TRIM((SALT32.StrType)le.orig_validationdate_1),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT32.StrType)le.orig_telephonenumber_2),TRIM((SALT32.StrType)le.orig_validation_flag_2),TRIM((SALT32.StrType)le.orig_validation_date_2),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT32.StrType)le.orig_telephonenumber_3),TRIM((SALT32.StrType)le.orig_validationflag_3),TRIM((SALT32.StrType)le.orig_validationdate_3),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT32.StrType)le.orig_telephonenumber_4),TRIM((SALT32.StrType)le.orig_validationflag_4),TRIM((SALT32.StrType)le.orig_validationdate_4),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_4),TRIM((SALT32.StrType)le.orig_telephonenumber_5),TRIM((SALT32.StrType)le.orig_validationflag_5),TRIM((SALT32.StrType)le.orig_validationdate_5),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_5),TRIM((SALT32.StrType)le.orig_telephonenumber_6),TRIM((SALT32.StrType)le.orig_validationflag_6),TRIM((SALT32.StrType)le.orig_validationdate_6),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_6),TRIM((SALT32.StrType)le.orig_telephonenumber_7),TRIM((SALT32.StrType)le.orig_validationflag_7),TRIM((SALT32.StrType)le.orig_validationdate_7),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_7),TRIM((SALT32.StrType)le.orig_tot_phones),TRIM((SALT32.StrType)le.orig_length_of_residence),TRIM((SALT32.StrType)le.orig_homeowner),TRIM((SALT32.StrType)le.orig_estimatedincome),TRIM((SALT32.StrType)le.orig_dwelling_type),TRIM((SALT32.StrType)le.orig_married),TRIM((SALT32.StrType)le.orig_child),TRIM((SALT32.StrType)le.orig_nbrchild),TRIM((SALT32.StrType)le.orig_teencd),TRIM((SALT32.StrType)le.orig_percent_range_black),TRIM((SALT32.StrType)le.orig_percent_range_white),TRIM((SALT32.StrType)le.orig_percent_range_hispanic),TRIM((SALT32.StrType)le.orig_percent_range_asian),TRIM((SALT32.StrType)le.orig_percent_range_english_speaking),TRIM((SALT32.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT32.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT32.StrType)le.orig_percent_range_sfdu),TRIM((SALT32.StrType)le.orig_percent_range_mfdu),TRIM((SALT32.StrType)le.orig_mhv),TRIM((SALT32.StrType)le.orig_mor),TRIM((SALT32.StrType)le.orig_car),TRIM((SALT32.StrType)le.orig_medschl),TRIM((SALT32.StrType)le.orig_penetration_range_whitecollar),TRIM((SALT32.StrType)le.orig_penetration_range_bluecollar),TRIM((SALT32.StrType)le.orig_penetration_range_otheroccupation),TRIM((SALT32.StrType)le.orig_demolevel),TRIM((SALT32.StrType)le.orig_recdate)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,93,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 93);
  SELF.FldNo2 := 1 + (C % 93);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.orig_hhid),TRIM((SALT32.StrType)le.orig_pid),TRIM((SALT32.StrType)le.orig_fname),TRIM((SALT32.StrType)le.orig_mname),TRIM((SALT32.StrType)le.orig_lname),TRIM((SALT32.StrType)le.orig_suffix),TRIM((SALT32.StrType)le.orig_gender),TRIM((SALT32.StrType)le.orig_age),TRIM((SALT32.StrType)le.orig_dob),TRIM((SALT32.StrType)le.orig_hhnbr),TRIM((SALT32.StrType)le.orig_tot_males),TRIM((SALT32.StrType)le.orig_tot_females),TRIM((SALT32.StrType)le.orig_addrid),TRIM((SALT32.StrType)le.orig_address),TRIM((SALT32.StrType)le.orig_house),TRIM((SALT32.StrType)le.orig_predir),TRIM((SALT32.StrType)le.orig_street),TRIM((SALT32.StrType)le.orig_strtype),TRIM((SALT32.StrType)le.orig_postdir),TRIM((SALT32.StrType)le.orig_apttype),TRIM((SALT32.StrType)le.orig_aptnbr),TRIM((SALT32.StrType)le.orig_city),TRIM((SALT32.StrType)le.orig_state),TRIM((SALT32.StrType)le.orig_zip),TRIM((SALT32.StrType)le.orig_z4),TRIM((SALT32.StrType)le.orig_dpc),TRIM((SALT32.StrType)le.orig_z4type),TRIM((SALT32.StrType)le.orig_crte),TRIM((SALT32.StrType)le.orig_dpv),TRIM((SALT32.StrType)le.orig_vacant),TRIM((SALT32.StrType)le.orig_msa),TRIM((SALT32.StrType)le.orig_cbsa),TRIM((SALT32.StrType)le.orig_county_code),TRIM((SALT32.StrType)le.orig_time_zone),TRIM((SALT32.StrType)le.orig_daylight_savings),TRIM((SALT32.StrType)le.orig_lat_long_assignment_level),TRIM((SALT32.StrType)le.orig_latitude),TRIM((SALT32.StrType)le.orig_longitude),TRIM((SALT32.StrType)le.orig_telephonenumber_1),TRIM((SALT32.StrType)le.orig_validationflag_1),TRIM((SALT32.StrType)le.orig_validationdate_1),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT32.StrType)le.orig_telephonenumber_2),TRIM((SALT32.StrType)le.orig_validation_flag_2),TRIM((SALT32.StrType)le.orig_validation_date_2),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT32.StrType)le.orig_telephonenumber_3),TRIM((SALT32.StrType)le.orig_validationflag_3),TRIM((SALT32.StrType)le.orig_validationdate_3),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT32.StrType)le.orig_telephonenumber_4),TRIM((SALT32.StrType)le.orig_validationflag_4),TRIM((SALT32.StrType)le.orig_validationdate_4),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_4),TRIM((SALT32.StrType)le.orig_telephonenumber_5),TRIM((SALT32.StrType)le.orig_validationflag_5),TRIM((SALT32.StrType)le.orig_validationdate_5),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_5),TRIM((SALT32.StrType)le.orig_telephonenumber_6),TRIM((SALT32.StrType)le.orig_validationflag_6),TRIM((SALT32.StrType)le.orig_validationdate_6),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_6),TRIM((SALT32.StrType)le.orig_telephonenumber_7),TRIM((SALT32.StrType)le.orig_validationflag_7),TRIM((SALT32.StrType)le.orig_validationdate_7),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_7),TRIM((SALT32.StrType)le.orig_tot_phones),TRIM((SALT32.StrType)le.orig_length_of_residence),TRIM((SALT32.StrType)le.orig_homeowner),TRIM((SALT32.StrType)le.orig_estimatedincome),TRIM((SALT32.StrType)le.orig_dwelling_type),TRIM((SALT32.StrType)le.orig_married),TRIM((SALT32.StrType)le.orig_child),TRIM((SALT32.StrType)le.orig_nbrchild),TRIM((SALT32.StrType)le.orig_teencd),TRIM((SALT32.StrType)le.orig_percent_range_black),TRIM((SALT32.StrType)le.orig_percent_range_white),TRIM((SALT32.StrType)le.orig_percent_range_hispanic),TRIM((SALT32.StrType)le.orig_percent_range_asian),TRIM((SALT32.StrType)le.orig_percent_range_english_speaking),TRIM((SALT32.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT32.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT32.StrType)le.orig_percent_range_sfdu),TRIM((SALT32.StrType)le.orig_percent_range_mfdu),TRIM((SALT32.StrType)le.orig_mhv),TRIM((SALT32.StrType)le.orig_mor),TRIM((SALT32.StrType)le.orig_car),TRIM((SALT32.StrType)le.orig_medschl),TRIM((SALT32.StrType)le.orig_penetration_range_whitecollar),TRIM((SALT32.StrType)le.orig_penetration_range_bluecollar),TRIM((SALT32.StrType)le.orig_penetration_range_otheroccupation),TRIM((SALT32.StrType)le.orig_demolevel),TRIM((SALT32.StrType)le.orig_recdate)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.orig_hhid),TRIM((SALT32.StrType)le.orig_pid),TRIM((SALT32.StrType)le.orig_fname),TRIM((SALT32.StrType)le.orig_mname),TRIM((SALT32.StrType)le.orig_lname),TRIM((SALT32.StrType)le.orig_suffix),TRIM((SALT32.StrType)le.orig_gender),TRIM((SALT32.StrType)le.orig_age),TRIM((SALT32.StrType)le.orig_dob),TRIM((SALT32.StrType)le.orig_hhnbr),TRIM((SALT32.StrType)le.orig_tot_males),TRIM((SALT32.StrType)le.orig_tot_females),TRIM((SALT32.StrType)le.orig_addrid),TRIM((SALT32.StrType)le.orig_address),TRIM((SALT32.StrType)le.orig_house),TRIM((SALT32.StrType)le.orig_predir),TRIM((SALT32.StrType)le.orig_street),TRIM((SALT32.StrType)le.orig_strtype),TRIM((SALT32.StrType)le.orig_postdir),TRIM((SALT32.StrType)le.orig_apttype),TRIM((SALT32.StrType)le.orig_aptnbr),TRIM((SALT32.StrType)le.orig_city),TRIM((SALT32.StrType)le.orig_state),TRIM((SALT32.StrType)le.orig_zip),TRIM((SALT32.StrType)le.orig_z4),TRIM((SALT32.StrType)le.orig_dpc),TRIM((SALT32.StrType)le.orig_z4type),TRIM((SALT32.StrType)le.orig_crte),TRIM((SALT32.StrType)le.orig_dpv),TRIM((SALT32.StrType)le.orig_vacant),TRIM((SALT32.StrType)le.orig_msa),TRIM((SALT32.StrType)le.orig_cbsa),TRIM((SALT32.StrType)le.orig_county_code),TRIM((SALT32.StrType)le.orig_time_zone),TRIM((SALT32.StrType)le.orig_daylight_savings),TRIM((SALT32.StrType)le.orig_lat_long_assignment_level),TRIM((SALT32.StrType)le.orig_latitude),TRIM((SALT32.StrType)le.orig_longitude),TRIM((SALT32.StrType)le.orig_telephonenumber_1),TRIM((SALT32.StrType)le.orig_validationflag_1),TRIM((SALT32.StrType)le.orig_validationdate_1),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT32.StrType)le.orig_telephonenumber_2),TRIM((SALT32.StrType)le.orig_validation_flag_2),TRIM((SALT32.StrType)le.orig_validation_date_2),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT32.StrType)le.orig_telephonenumber_3),TRIM((SALT32.StrType)le.orig_validationflag_3),TRIM((SALT32.StrType)le.orig_validationdate_3),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT32.StrType)le.orig_telephonenumber_4),TRIM((SALT32.StrType)le.orig_validationflag_4),TRIM((SALT32.StrType)le.orig_validationdate_4),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_4),TRIM((SALT32.StrType)le.orig_telephonenumber_5),TRIM((SALT32.StrType)le.orig_validationflag_5),TRIM((SALT32.StrType)le.orig_validationdate_5),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_5),TRIM((SALT32.StrType)le.orig_telephonenumber_6),TRIM((SALT32.StrType)le.orig_validationflag_6),TRIM((SALT32.StrType)le.orig_validationdate_6),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_6),TRIM((SALT32.StrType)le.orig_telephonenumber_7),TRIM((SALT32.StrType)le.orig_validationflag_7),TRIM((SALT32.StrType)le.orig_validationdate_7),TRIM((SALT32.StrType)le.orig_dma_tps_dnc_flag_7),TRIM((SALT32.StrType)le.orig_tot_phones),TRIM((SALT32.StrType)le.orig_length_of_residence),TRIM((SALT32.StrType)le.orig_homeowner),TRIM((SALT32.StrType)le.orig_estimatedincome),TRIM((SALT32.StrType)le.orig_dwelling_type),TRIM((SALT32.StrType)le.orig_married),TRIM((SALT32.StrType)le.orig_child),TRIM((SALT32.StrType)le.orig_nbrchild),TRIM((SALT32.StrType)le.orig_teencd),TRIM((SALT32.StrType)le.orig_percent_range_black),TRIM((SALT32.StrType)le.orig_percent_range_white),TRIM((SALT32.StrType)le.orig_percent_range_hispanic),TRIM((SALT32.StrType)le.orig_percent_range_asian),TRIM((SALT32.StrType)le.orig_percent_range_english_speaking),TRIM((SALT32.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT32.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT32.StrType)le.orig_percent_range_sfdu),TRIM((SALT32.StrType)le.orig_percent_range_mfdu),TRIM((SALT32.StrType)le.orig_mhv),TRIM((SALT32.StrType)le.orig_mor),TRIM((SALT32.StrType)le.orig_car),TRIM((SALT32.StrType)le.orig_medschl),TRIM((SALT32.StrType)le.orig_penetration_range_whitecollar),TRIM((SALT32.StrType)le.orig_penetration_range_bluecollar),TRIM((SALT32.StrType)le.orig_penetration_range_otheroccupation),TRIM((SALT32.StrType)le.orig_demolevel),TRIM((SALT32.StrType)le.orig_recdate)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),93*93,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{93,'orig_recdate'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Raw_Fields.InValid_orig_hhid((SALT32.StrType)le.orig_hhid),
    Raw_Fields.InValid_orig_pid((SALT32.StrType)le.orig_pid),
    Raw_Fields.InValid_orig_fname((SALT32.StrType)le.orig_fname),
    Raw_Fields.InValid_orig_mname((SALT32.StrType)le.orig_mname),
    Raw_Fields.InValid_orig_lname((SALT32.StrType)le.orig_lname),
    Raw_Fields.InValid_orig_suffix((SALT32.StrType)le.orig_suffix),
    Raw_Fields.InValid_orig_gender((SALT32.StrType)le.orig_gender),
    Raw_Fields.InValid_orig_age((SALT32.StrType)le.orig_age),
    Raw_Fields.InValid_orig_dob((SALT32.StrType)le.orig_dob),
    Raw_Fields.InValid_orig_hhnbr((SALT32.StrType)le.orig_hhnbr),
    Raw_Fields.InValid_orig_tot_males((SALT32.StrType)le.orig_tot_males),
    Raw_Fields.InValid_orig_tot_females((SALT32.StrType)le.orig_tot_females),
    Raw_Fields.InValid_orig_addrid((SALT32.StrType)le.orig_addrid),
    Raw_Fields.InValid_orig_address((SALT32.StrType)le.orig_address),
    Raw_Fields.InValid_orig_house((SALT32.StrType)le.orig_house),
    Raw_Fields.InValid_orig_predir((SALT32.StrType)le.orig_predir),
    Raw_Fields.InValid_orig_street((SALT32.StrType)le.orig_street),
    Raw_Fields.InValid_orig_strtype((SALT32.StrType)le.orig_strtype),
    Raw_Fields.InValid_orig_postdir((SALT32.StrType)le.orig_postdir),
    Raw_Fields.InValid_orig_apttype((SALT32.StrType)le.orig_apttype),
    Raw_Fields.InValid_orig_aptnbr((SALT32.StrType)le.orig_aptnbr),
    Raw_Fields.InValid_orig_city((SALT32.StrType)le.orig_city),
    Raw_Fields.InValid_orig_state((SALT32.StrType)le.orig_state),
    Raw_Fields.InValid_orig_zip((SALT32.StrType)le.orig_zip),
    Raw_Fields.InValid_orig_z4((SALT32.StrType)le.orig_z4),
    Raw_Fields.InValid_orig_dpc((SALT32.StrType)le.orig_dpc),
    Raw_Fields.InValid_orig_z4type((SALT32.StrType)le.orig_z4type),
    Raw_Fields.InValid_orig_crte((SALT32.StrType)le.orig_crte),
    Raw_Fields.InValid_orig_dpv((SALT32.StrType)le.orig_dpv),
    Raw_Fields.InValid_orig_vacant((SALT32.StrType)le.orig_vacant),
    Raw_Fields.InValid_orig_msa((SALT32.StrType)le.orig_msa),
    Raw_Fields.InValid_orig_cbsa((SALT32.StrType)le.orig_cbsa),
    Raw_Fields.InValid_orig_county_code((SALT32.StrType)le.orig_county_code),
    Raw_Fields.InValid_orig_time_zone((SALT32.StrType)le.orig_time_zone),
    Raw_Fields.InValid_orig_daylight_savings((SALT32.StrType)le.orig_daylight_savings),
    Raw_Fields.InValid_orig_lat_long_assignment_level((SALT32.StrType)le.orig_lat_long_assignment_level),
    Raw_Fields.InValid_orig_latitude((SALT32.StrType)le.orig_latitude),
    Raw_Fields.InValid_orig_longitude((SALT32.StrType)le.orig_longitude),
    Raw_Fields.InValid_orig_telephonenumber_1((SALT32.StrType)le.orig_telephonenumber_1),
    Raw_Fields.InValid_orig_validationflag_1((SALT32.StrType)le.orig_validationflag_1),
    Raw_Fields.InValid_orig_validationdate_1((SALT32.StrType)le.orig_validationdate_1),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_1((SALT32.StrType)le.orig_dma_tps_dnc_flag_1),
    Raw_Fields.InValid_orig_telephonenumber_2((SALT32.StrType)le.orig_telephonenumber_2),
    Raw_Fields.InValid_orig_validation_flag_2((SALT32.StrType)le.orig_validation_flag_2),
    Raw_Fields.InValid_orig_validation_date_2((SALT32.StrType)le.orig_validation_date_2),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_2((SALT32.StrType)le.orig_dma_tps_dnc_flag_2),
    Raw_Fields.InValid_orig_telephonenumber_3((SALT32.StrType)le.orig_telephonenumber_3),
    Raw_Fields.InValid_orig_validationflag_3((SALT32.StrType)le.orig_validationflag_3),
    Raw_Fields.InValid_orig_validationdate_3((SALT32.StrType)le.orig_validationdate_3),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_3((SALT32.StrType)le.orig_dma_tps_dnc_flag_3),
    Raw_Fields.InValid_orig_telephonenumber_4((SALT32.StrType)le.orig_telephonenumber_4),
    Raw_Fields.InValid_orig_validationflag_4((SALT32.StrType)le.orig_validationflag_4),
    Raw_Fields.InValid_orig_validationdate_4((SALT32.StrType)le.orig_validationdate_4),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_4((SALT32.StrType)le.orig_dma_tps_dnc_flag_4),
    Raw_Fields.InValid_orig_telephonenumber_5((SALT32.StrType)le.orig_telephonenumber_5),
    Raw_Fields.InValid_orig_validationflag_5((SALT32.StrType)le.orig_validationflag_5),
    Raw_Fields.InValid_orig_validationdate_5((SALT32.StrType)le.orig_validationdate_5),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_5((SALT32.StrType)le.orig_dma_tps_dnc_flag_5),
    Raw_Fields.InValid_orig_telephonenumber_6((SALT32.StrType)le.orig_telephonenumber_6),
    Raw_Fields.InValid_orig_validationflag_6((SALT32.StrType)le.orig_validationflag_6),
    Raw_Fields.InValid_orig_validationdate_6((SALT32.StrType)le.orig_validationdate_6),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_6((SALT32.StrType)le.orig_dma_tps_dnc_flag_6),
    Raw_Fields.InValid_orig_telephonenumber_7((SALT32.StrType)le.orig_telephonenumber_7),
    Raw_Fields.InValid_orig_validationflag_7((SALT32.StrType)le.orig_validationflag_7),
    Raw_Fields.InValid_orig_validationdate_7((SALT32.StrType)le.orig_validationdate_7),
    Raw_Fields.InValid_orig_dma_tps_dnc_flag_7((SALT32.StrType)le.orig_dma_tps_dnc_flag_7),
    Raw_Fields.InValid_orig_tot_phones((SALT32.StrType)le.orig_tot_phones),
    Raw_Fields.InValid_orig_length_of_residence((SALT32.StrType)le.orig_length_of_residence),
    Raw_Fields.InValid_orig_homeowner((SALT32.StrType)le.orig_homeowner),
    Raw_Fields.InValid_orig_estimatedincome((SALT32.StrType)le.orig_estimatedincome),
    Raw_Fields.InValid_orig_dwelling_type((SALT32.StrType)le.orig_dwelling_type),
    Raw_Fields.InValid_orig_married((SALT32.StrType)le.orig_married),
    Raw_Fields.InValid_orig_child((SALT32.StrType)le.orig_child),
    Raw_Fields.InValid_orig_nbrchild((SALT32.StrType)le.orig_nbrchild),
    Raw_Fields.InValid_orig_teencd((SALT32.StrType)le.orig_teencd),
    Raw_Fields.InValid_orig_percent_range_black((SALT32.StrType)le.orig_percent_range_black),
    Raw_Fields.InValid_orig_percent_range_white((SALT32.StrType)le.orig_percent_range_white),
    Raw_Fields.InValid_orig_percent_range_hispanic((SALT32.StrType)le.orig_percent_range_hispanic),
    Raw_Fields.InValid_orig_percent_range_asian((SALT32.StrType)le.orig_percent_range_asian),
    Raw_Fields.InValid_orig_percent_range_english_speaking((SALT32.StrType)le.orig_percent_range_english_speaking),
    Raw_Fields.InValid_orig_percnt_range_spanish_speaking((SALT32.StrType)le.orig_percnt_range_spanish_speaking),
    Raw_Fields.InValid_orig_percent_range_asian_speaking((SALT32.StrType)le.orig_percent_range_asian_speaking),
    Raw_Fields.InValid_orig_percent_range_sfdu((SALT32.StrType)le.orig_percent_range_sfdu),
    Raw_Fields.InValid_orig_percent_range_mfdu((SALT32.StrType)le.orig_percent_range_mfdu),
    Raw_Fields.InValid_orig_mhv((SALT32.StrType)le.orig_mhv),
    Raw_Fields.InValid_orig_mor((SALT32.StrType)le.orig_mor),
    Raw_Fields.InValid_orig_car((SALT32.StrType)le.orig_car),
    Raw_Fields.InValid_orig_medschl((SALT32.StrType)le.orig_medschl),
    Raw_Fields.InValid_orig_penetration_range_whitecollar((SALT32.StrType)le.orig_penetration_range_whitecollar),
    Raw_Fields.InValid_orig_penetration_range_bluecollar((SALT32.StrType)le.orig_penetration_range_bluecollar),
    Raw_Fields.InValid_orig_penetration_range_otheroccupation((SALT32.StrType)le.orig_penetration_range_otheroccupation),
    Raw_Fields.InValid_orig_demolevel((SALT32.StrType)le.orig_demolevel),
    Raw_Fields.InValid_orig_recdate((SALT32.StrType)le.orig_recdate),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,93,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_alpha','invalid_suffix','invalid_gender','invalid_nums','invalid_date','invalid_nums','invalid_nums','invalid_nums','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_county_name','Unknown','invalid_zip','invalid_zip4','Unknown','Unknown','Unknown','Unknown','invalid_indicator','Unknown','Unknown','Unknown','invalid_time_zone','Unknown','Unknown','Unknown','Unknown','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_residence_len','invalid_homeowner','invalid_mhv','invalid_dwelling_type','invalid_indicator','invalid_indicator','invalid_child_num','invalid_indicator','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_mhv','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','Unknown','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','Unknown','invalid_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Raw_Fields.InValidMessage_orig_hhid(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_pid(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_gender(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_age(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_hhnbr(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_tot_males(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_tot_females(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_addrid(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_house(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_predir(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_street(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_strtype(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_postdir(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_apttype(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_aptnbr(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_z4(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dpc(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_z4type(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_crte(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dpv(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_vacant(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_msa(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_cbsa(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_county_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_time_zone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_daylight_savings(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_lat_long_assignment_level(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_latitude(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_longitude(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationflag_1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationdate_1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validation_flag_2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validation_date_2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_3(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationflag_3(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationdate_3(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_3(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_4(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationflag_4(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationdate_4(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_4(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_5(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationflag_5(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationdate_5(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_5(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_6(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationflag_6(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationdate_6(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_6(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_telephonenumber_7(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationflag_7(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_validationdate_7(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_7(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_tot_phones(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_length_of_residence(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_homeowner(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_estimatedincome(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_dwelling_type(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_married(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_child(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_nbrchild(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_teencd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_black(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_white(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_hispanic(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_asian(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_english_speaking(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percnt_range_spanish_speaking(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_asian_speaking(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_sfdu(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_percent_range_mfdu(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_mhv(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_mor(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_car(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_medschl(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_penetration_range_whitecollar(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_penetration_range_bluecollar(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_penetration_range_otheroccupation(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_demolevel(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_orig_recdate(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
