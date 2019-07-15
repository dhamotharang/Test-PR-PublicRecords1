IMPORT SALT311,STD;
EXPORT raw_hygiene(dataset(raw_layout_infutor_narc3) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_hhid_cnt := COUNT(GROUP,h.orig_hhid <> (TYPEOF(h.orig_hhid))'');
    populated_orig_hhid_pcnt := AVE(GROUP,IF(h.orig_hhid = (TYPEOF(h.orig_hhid))'',0,100));
    maxlength_orig_hhid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hhid)));
    avelength_orig_hhid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hhid)),h.orig_hhid<>(typeof(h.orig_hhid))'');
    populated_orig_pid_cnt := COUNT(GROUP,h.orig_pid <> (TYPEOF(h.orig_pid))'');
    populated_orig_pid_pcnt := AVE(GROUP,IF(h.orig_pid = (TYPEOF(h.orig_pid))'',0,100));
    maxlength_orig_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pid)));
    avelength_orig_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pid)),h.orig_pid<>(typeof(h.orig_pid))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_suffix_cnt := COUNT(GROUP,h.orig_suffix <> (TYPEOF(h.orig_suffix))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
    populated_orig_gender_cnt := COUNT(GROUP,h.orig_gender <> (TYPEOF(h.orig_gender))'');
    populated_orig_gender_pcnt := AVE(GROUP,IF(h.orig_gender = (TYPEOF(h.orig_gender))'',0,100));
    maxlength_orig_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_gender)));
    avelength_orig_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_gender)),h.orig_gender<>(typeof(h.orig_gender))'');
    populated_orig_age_cnt := COUNT(GROUP,h.orig_age <> (TYPEOF(h.orig_age))'');
    populated_orig_age_pcnt := AVE(GROUP,IF(h.orig_age = (TYPEOF(h.orig_age))'',0,100));
    maxlength_orig_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_age)));
    avelength_orig_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_age)),h.orig_age<>(typeof(h.orig_age))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_hhnbr_cnt := COUNT(GROUP,h.orig_hhnbr <> (TYPEOF(h.orig_hhnbr))'');
    populated_orig_hhnbr_pcnt := AVE(GROUP,IF(h.orig_hhnbr = (TYPEOF(h.orig_hhnbr))'',0,100));
    maxlength_orig_hhnbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hhnbr)));
    avelength_orig_hhnbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hhnbr)),h.orig_hhnbr<>(typeof(h.orig_hhnbr))'');
    populated_orig_addrid_cnt := COUNT(GROUP,h.orig_addrid <> (TYPEOF(h.orig_addrid))'');
    populated_orig_addrid_pcnt := AVE(GROUP,IF(h.orig_addrid = (TYPEOF(h.orig_addrid))'',0,100));
    maxlength_orig_addrid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_addrid)));
    avelength_orig_addrid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_addrid)),h.orig_addrid<>(typeof(h.orig_addrid))'');
    populated_orig_address_cnt := COUNT(GROUP,h.orig_address <> (TYPEOF(h.orig_address))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_house_cnt := COUNT(GROUP,h.orig_house <> (TYPEOF(h.orig_house))'');
    populated_orig_house_pcnt := AVE(GROUP,IF(h.orig_house = (TYPEOF(h.orig_house))'',0,100));
    maxlength_orig_house := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_house)));
    avelength_orig_house := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_house)),h.orig_house<>(typeof(h.orig_house))'');
    populated_orig_predir_cnt := COUNT(GROUP,h.orig_predir <> (TYPEOF(h.orig_predir))'');
    populated_orig_predir_pcnt := AVE(GROUP,IF(h.orig_predir = (TYPEOF(h.orig_predir))'',0,100));
    maxlength_orig_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_predir)));
    avelength_orig_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_predir)),h.orig_predir<>(typeof(h.orig_predir))'');
    populated_orig_street_cnt := COUNT(GROUP,h.orig_street <> (TYPEOF(h.orig_street))'');
    populated_orig_street_pcnt := AVE(GROUP,IF(h.orig_street = (TYPEOF(h.orig_street))'',0,100));
    maxlength_orig_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_street)));
    avelength_orig_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_street)),h.orig_street<>(typeof(h.orig_street))'');
    populated_orig_strtype_cnt := COUNT(GROUP,h.orig_strtype <> (TYPEOF(h.orig_strtype))'');
    populated_orig_strtype_pcnt := AVE(GROUP,IF(h.orig_strtype = (TYPEOF(h.orig_strtype))'',0,100));
    maxlength_orig_strtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_strtype)));
    avelength_orig_strtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_strtype)),h.orig_strtype<>(typeof(h.orig_strtype))'');
    populated_orig_postdir_cnt := COUNT(GROUP,h.orig_postdir <> (TYPEOF(h.orig_postdir))'');
    populated_orig_postdir_pcnt := AVE(GROUP,IF(h.orig_postdir = (TYPEOF(h.orig_postdir))'',0,100));
    maxlength_orig_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_postdir)));
    avelength_orig_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_postdir)),h.orig_postdir<>(typeof(h.orig_postdir))'');
    populated_orig_apttype_cnt := COUNT(GROUP,h.orig_apttype <> (TYPEOF(h.orig_apttype))'');
    populated_orig_apttype_pcnt := AVE(GROUP,IF(h.orig_apttype = (TYPEOF(h.orig_apttype))'',0,100));
    maxlength_orig_apttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_apttype)));
    avelength_orig_apttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_apttype)),h.orig_apttype<>(typeof(h.orig_apttype))'');
    populated_orig_aptnbr_cnt := COUNT(GROUP,h.orig_aptnbr <> (TYPEOF(h.orig_aptnbr))'');
    populated_orig_aptnbr_pcnt := AVE(GROUP,IF(h.orig_aptnbr = (TYPEOF(h.orig_aptnbr))'',0,100));
    maxlength_orig_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_aptnbr)));
    avelength_orig_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_aptnbr)),h.orig_aptnbr<>(typeof(h.orig_aptnbr))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_z4_cnt := COUNT(GROUP,h.orig_z4 <> (TYPEOF(h.orig_z4))'');
    populated_orig_z4_pcnt := AVE(GROUP,IF(h.orig_z4 = (TYPEOF(h.orig_z4))'',0,100));
    maxlength_orig_z4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_z4)));
    avelength_orig_z4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_z4)),h.orig_z4<>(typeof(h.orig_z4))'');
    populated_orig_dpc_cnt := COUNT(GROUP,h.orig_dpc <> (TYPEOF(h.orig_dpc))'');
    populated_orig_dpc_pcnt := AVE(GROUP,IF(h.orig_dpc = (TYPEOF(h.orig_dpc))'',0,100));
    maxlength_orig_dpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dpc)));
    avelength_orig_dpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dpc)),h.orig_dpc<>(typeof(h.orig_dpc))'');
    populated_orig_z4type_cnt := COUNT(GROUP,h.orig_z4type <> (TYPEOF(h.orig_z4type))'');
    populated_orig_z4type_pcnt := AVE(GROUP,IF(h.orig_z4type = (TYPEOF(h.orig_z4type))'',0,100));
    maxlength_orig_z4type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_z4type)));
    avelength_orig_z4type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_z4type)),h.orig_z4type<>(typeof(h.orig_z4type))'');
    populated_orig_crte_cnt := COUNT(GROUP,h.orig_crte <> (TYPEOF(h.orig_crte))'');
    populated_orig_crte_pcnt := AVE(GROUP,IF(h.orig_crte = (TYPEOF(h.orig_crte))'',0,100));
    maxlength_orig_crte := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_crte)));
    avelength_orig_crte := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_crte)),h.orig_crte<>(typeof(h.orig_crte))'');
    populated_orig_dpv_cnt := COUNT(GROUP,h.orig_dpv <> (TYPEOF(h.orig_dpv))'');
    populated_orig_dpv_pcnt := AVE(GROUP,IF(h.orig_dpv = (TYPEOF(h.orig_dpv))'',0,100));
    maxlength_orig_dpv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dpv)));
    avelength_orig_dpv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dpv)),h.orig_dpv<>(typeof(h.orig_dpv))'');
    populated_orig_vacant_cnt := COUNT(GROUP,h.orig_vacant <> (TYPEOF(h.orig_vacant))'');
    populated_orig_vacant_pcnt := AVE(GROUP,IF(h.orig_vacant = (TYPEOF(h.orig_vacant))'',0,100));
    maxlength_orig_vacant := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_vacant)));
    avelength_orig_vacant := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_vacant)),h.orig_vacant<>(typeof(h.orig_vacant))'');
    populated_orig_msa_cnt := COUNT(GROUP,h.orig_msa <> (TYPEOF(h.orig_msa))'');
    populated_orig_msa_pcnt := AVE(GROUP,IF(h.orig_msa = (TYPEOF(h.orig_msa))'',0,100));
    maxlength_orig_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_msa)));
    avelength_orig_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_msa)),h.orig_msa<>(typeof(h.orig_msa))'');
    populated_orig_cbsa_cnt := COUNT(GROUP,h.orig_cbsa <> (TYPEOF(h.orig_cbsa))'');
    populated_orig_cbsa_pcnt := AVE(GROUP,IF(h.orig_cbsa = (TYPEOF(h.orig_cbsa))'',0,100));
    maxlength_orig_cbsa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_cbsa)));
    avelength_orig_cbsa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_cbsa)),h.orig_cbsa<>(typeof(h.orig_cbsa))'');
    populated_orig_dma_cnt := COUNT(GROUP,h.orig_dma <> (TYPEOF(h.orig_dma))'');
    populated_orig_dma_pcnt := AVE(GROUP,IF(h.orig_dma = (TYPEOF(h.orig_dma))'',0,100));
    maxlength_orig_dma := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma)));
    avelength_orig_dma := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma)),h.orig_dma<>(typeof(h.orig_dma))'');
    populated_orig_county_code_cnt := COUNT(GROUP,h.orig_county_code <> (TYPEOF(h.orig_county_code))'');
    populated_orig_county_code_pcnt := AVE(GROUP,IF(h.orig_county_code = (TYPEOF(h.orig_county_code))'',0,100));
    maxlength_orig_county_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_county_code)));
    avelength_orig_county_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_county_code)),h.orig_county_code<>(typeof(h.orig_county_code))'');
    populated_orig_time_zone_cnt := COUNT(GROUP,h.orig_time_zone <> (TYPEOF(h.orig_time_zone))'');
    populated_orig_time_zone_pcnt := AVE(GROUP,IF(h.orig_time_zone = (TYPEOF(h.orig_time_zone))'',0,100));
    maxlength_orig_time_zone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_time_zone)));
    avelength_orig_time_zone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_time_zone)),h.orig_time_zone<>(typeof(h.orig_time_zone))'');
    populated_orig_daylight_savings_cnt := COUNT(GROUP,h.orig_daylight_savings <> (TYPEOF(h.orig_daylight_savings))'');
    populated_orig_daylight_savings_pcnt := AVE(GROUP,IF(h.orig_daylight_savings = (TYPEOF(h.orig_daylight_savings))'',0,100));
    maxlength_orig_daylight_savings := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_daylight_savings)));
    avelength_orig_daylight_savings := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_daylight_savings)),h.orig_daylight_savings<>(typeof(h.orig_daylight_savings))'');
    populated_orig_latitude_cnt := COUNT(GROUP,h.orig_latitude <> (TYPEOF(h.orig_latitude))'');
    populated_orig_latitude_pcnt := AVE(GROUP,IF(h.orig_latitude = (TYPEOF(h.orig_latitude))'',0,100));
    maxlength_orig_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_latitude)));
    avelength_orig_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_latitude)),h.orig_latitude<>(typeof(h.orig_latitude))'');
    populated_orig_longitude_cnt := COUNT(GROUP,h.orig_longitude <> (TYPEOF(h.orig_longitude))'');
    populated_orig_longitude_pcnt := AVE(GROUP,IF(h.orig_longitude = (TYPEOF(h.orig_longitude))'',0,100));
    maxlength_orig_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_longitude)));
    avelength_orig_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_longitude)),h.orig_longitude<>(typeof(h.orig_longitude))'');
    populated_orig_telephone_number_1_cnt := COUNT(GROUP,h.orig_telephone_number_1 <> (TYPEOF(h.orig_telephone_number_1))'');
    populated_orig_telephone_number_1_pcnt := AVE(GROUP,IF(h.orig_telephone_number_1 = (TYPEOF(h.orig_telephone_number_1))'',0,100));
    maxlength_orig_telephone_number_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_telephone_number_1)));
    avelength_orig_telephone_number_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_telephone_number_1)),h.orig_telephone_number_1<>(typeof(h.orig_telephone_number_1))'');
    populated_orig_dma_tps_dnc_flag_1_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_1 <> (TYPEOF(h.orig_dma_tps_dnc_flag_1))'');
    populated_orig_dma_tps_dnc_flag_1_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_1 = (TYPEOF(h.orig_dma_tps_dnc_flag_1))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma_tps_dnc_flag_1)));
    avelength_orig_dma_tps_dnc_flag_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma_tps_dnc_flag_1)),h.orig_dma_tps_dnc_flag_1<>(typeof(h.orig_dma_tps_dnc_flag_1))'');
    populated_orig_telephone_number_2_cnt := COUNT(GROUP,h.orig_telephone_number_2 <> (TYPEOF(h.orig_telephone_number_2))'');
    populated_orig_telephone_number_2_pcnt := AVE(GROUP,IF(h.orig_telephone_number_2 = (TYPEOF(h.orig_telephone_number_2))'',0,100));
    maxlength_orig_telephone_number_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_telephone_number_2)));
    avelength_orig_telephone_number_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_telephone_number_2)),h.orig_telephone_number_2<>(typeof(h.orig_telephone_number_2))'');
    populated_orig_dma_tps_dnc_flag_2_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_2 <> (TYPEOF(h.orig_dma_tps_dnc_flag_2))'');
    populated_orig_dma_tps_dnc_flag_2_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_2 = (TYPEOF(h.orig_dma_tps_dnc_flag_2))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma_tps_dnc_flag_2)));
    avelength_orig_dma_tps_dnc_flag_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma_tps_dnc_flag_2)),h.orig_dma_tps_dnc_flag_2<>(typeof(h.orig_dma_tps_dnc_flag_2))'');
    populated_orig_telephone_number_3_cnt := COUNT(GROUP,h.orig_telephone_number_3 <> (TYPEOF(h.orig_telephone_number_3))'');
    populated_orig_telephone_number_3_pcnt := AVE(GROUP,IF(h.orig_telephone_number_3 = (TYPEOF(h.orig_telephone_number_3))'',0,100));
    maxlength_orig_telephone_number_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_telephone_number_3)));
    avelength_orig_telephone_number_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_telephone_number_3)),h.orig_telephone_number_3<>(typeof(h.orig_telephone_number_3))'');
    populated_orig_dma_tps_dnc_flag_3_cnt := COUNT(GROUP,h.orig_dma_tps_dnc_flag_3 <> (TYPEOF(h.orig_dma_tps_dnc_flag_3))'');
    populated_orig_dma_tps_dnc_flag_3_pcnt := AVE(GROUP,IF(h.orig_dma_tps_dnc_flag_3 = (TYPEOF(h.orig_dma_tps_dnc_flag_3))'',0,100));
    maxlength_orig_dma_tps_dnc_flag_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma_tps_dnc_flag_3)));
    avelength_orig_dma_tps_dnc_flag_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dma_tps_dnc_flag_3)),h.orig_dma_tps_dnc_flag_3<>(typeof(h.orig_dma_tps_dnc_flag_3))'');
    populated_orig_length_of_residence_cnt := COUNT(GROUP,h.orig_length_of_residence <> (TYPEOF(h.orig_length_of_residence))'');
    populated_orig_length_of_residence_pcnt := AVE(GROUP,IF(h.orig_length_of_residence = (TYPEOF(h.orig_length_of_residence))'',0,100));
    maxlength_orig_length_of_residence := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_length_of_residence)));
    avelength_orig_length_of_residence := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_length_of_residence)),h.orig_length_of_residence<>(typeof(h.orig_length_of_residence))'');
    populated_orig_homeowner_renter_cnt := COUNT(GROUP,h.orig_homeowner_renter <> (TYPEOF(h.orig_homeowner_renter))'');
    populated_orig_homeowner_renter_pcnt := AVE(GROUP,IF(h.orig_homeowner_renter = (TYPEOF(h.orig_homeowner_renter))'',0,100));
    maxlength_orig_homeowner_renter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_homeowner_renter)));
    avelength_orig_homeowner_renter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_homeowner_renter)),h.orig_homeowner_renter<>(typeof(h.orig_homeowner_renter))'');
    populated_orig_year_built_cnt := COUNT(GROUP,h.orig_year_built <> (TYPEOF(h.orig_year_built))'');
    populated_orig_year_built_pcnt := AVE(GROUP,IF(h.orig_year_built = (TYPEOF(h.orig_year_built))'',0,100));
    maxlength_orig_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_year_built)));
    avelength_orig_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_year_built)),h.orig_year_built<>(typeof(h.orig_year_built))'');
    populated_orig_mobile_home_indicator_cnt := COUNT(GROUP,h.orig_mobile_home_indicator <> (TYPEOF(h.orig_mobile_home_indicator))'');
    populated_orig_mobile_home_indicator_pcnt := AVE(GROUP,IF(h.orig_mobile_home_indicator = (TYPEOF(h.orig_mobile_home_indicator))'',0,100));
    maxlength_orig_mobile_home_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mobile_home_indicator)));
    avelength_orig_mobile_home_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mobile_home_indicator)),h.orig_mobile_home_indicator<>(typeof(h.orig_mobile_home_indicator))'');
    populated_orig_pool_owner_cnt := COUNT(GROUP,h.orig_pool_owner <> (TYPEOF(h.orig_pool_owner))'');
    populated_orig_pool_owner_pcnt := AVE(GROUP,IF(h.orig_pool_owner = (TYPEOF(h.orig_pool_owner))'',0,100));
    maxlength_orig_pool_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pool_owner)));
    avelength_orig_pool_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pool_owner)),h.orig_pool_owner<>(typeof(h.orig_pool_owner))'');
    populated_orig_fireplace_in_home_cnt := COUNT(GROUP,h.orig_fireplace_in_home <> (TYPEOF(h.orig_fireplace_in_home))'');
    populated_orig_fireplace_in_home_pcnt := AVE(GROUP,IF(h.orig_fireplace_in_home = (TYPEOF(h.orig_fireplace_in_home))'',0,100));
    maxlength_orig_fireplace_in_home := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fireplace_in_home)));
    avelength_orig_fireplace_in_home := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fireplace_in_home)),h.orig_fireplace_in_home<>(typeof(h.orig_fireplace_in_home))'');
    populated_orig_estimated_income_cnt := COUNT(GROUP,h.orig_estimated_income <> (TYPEOF(h.orig_estimated_income))'');
    populated_orig_estimated_income_pcnt := AVE(GROUP,IF(h.orig_estimated_income = (TYPEOF(h.orig_estimated_income))'',0,100));
    maxlength_orig_estimated_income := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_estimated_income)));
    avelength_orig_estimated_income := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_estimated_income)),h.orig_estimated_income<>(typeof(h.orig_estimated_income))'');
    populated_orig_marital_status_cnt := COUNT(GROUP,h.orig_marital_status <> (TYPEOF(h.orig_marital_status))'');
    populated_orig_marital_status_pcnt := AVE(GROUP,IF(h.orig_marital_status = (TYPEOF(h.orig_marital_status))'',0,100));
    maxlength_orig_marital_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_marital_status)));
    avelength_orig_marital_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_marital_status)),h.orig_marital_status<>(typeof(h.orig_marital_status))'');
    populated_orig_single_parent_cnt := COUNT(GROUP,h.orig_single_parent <> (TYPEOF(h.orig_single_parent))'');
    populated_orig_single_parent_pcnt := AVE(GROUP,IF(h.orig_single_parent = (TYPEOF(h.orig_single_parent))'',0,100));
    maxlength_orig_single_parent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_single_parent)));
    avelength_orig_single_parent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_single_parent)),h.orig_single_parent<>(typeof(h.orig_single_parent))'');
    populated_orig_senior_in_hh_cnt := COUNT(GROUP,h.orig_senior_in_hh <> (TYPEOF(h.orig_senior_in_hh))'');
    populated_orig_senior_in_hh_pcnt := AVE(GROUP,IF(h.orig_senior_in_hh = (TYPEOF(h.orig_senior_in_hh))'',0,100));
    maxlength_orig_senior_in_hh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_senior_in_hh)));
    avelength_orig_senior_in_hh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_senior_in_hh)),h.orig_senior_in_hh<>(typeof(h.orig_senior_in_hh))'');
    populated_orig_credit_card_user_cnt := COUNT(GROUP,h.orig_credit_card_user <> (TYPEOF(h.orig_credit_card_user))'');
    populated_orig_credit_card_user_pcnt := AVE(GROUP,IF(h.orig_credit_card_user = (TYPEOF(h.orig_credit_card_user))'',0,100));
    maxlength_orig_credit_card_user := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_credit_card_user)));
    avelength_orig_credit_card_user := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_credit_card_user)),h.orig_credit_card_user<>(typeof(h.orig_credit_card_user))'');
    populated_orig_wealth_score_estimated_net_worth_cnt := COUNT(GROUP,h.orig_wealth_score_estimated_net_worth <> (TYPEOF(h.orig_wealth_score_estimated_net_worth))'');
    populated_orig_wealth_score_estimated_net_worth_pcnt := AVE(GROUP,IF(h.orig_wealth_score_estimated_net_worth = (TYPEOF(h.orig_wealth_score_estimated_net_worth))'',0,100));
    maxlength_orig_wealth_score_estimated_net_worth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_wealth_score_estimated_net_worth)));
    avelength_orig_wealth_score_estimated_net_worth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_wealth_score_estimated_net_worth)),h.orig_wealth_score_estimated_net_worth<>(typeof(h.orig_wealth_score_estimated_net_worth))'');
    populated_orig_donator_to_charity_or_causes_cnt := COUNT(GROUP,h.orig_donator_to_charity_or_causes <> (TYPEOF(h.orig_donator_to_charity_or_causes))'');
    populated_orig_donator_to_charity_or_causes_pcnt := AVE(GROUP,IF(h.orig_donator_to_charity_or_causes = (TYPEOF(h.orig_donator_to_charity_or_causes))'',0,100));
    maxlength_orig_donator_to_charity_or_causes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_donator_to_charity_or_causes)));
    avelength_orig_donator_to_charity_or_causes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_donator_to_charity_or_causes)),h.orig_donator_to_charity_or_causes<>(typeof(h.orig_donator_to_charity_or_causes))'');
    populated_orig_dwelling_type_cnt := COUNT(GROUP,h.orig_dwelling_type <> (TYPEOF(h.orig_dwelling_type))'');
    populated_orig_dwelling_type_pcnt := AVE(GROUP,IF(h.orig_dwelling_type = (TYPEOF(h.orig_dwelling_type))'',0,100));
    maxlength_orig_dwelling_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dwelling_type)));
    avelength_orig_dwelling_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dwelling_type)),h.orig_dwelling_type<>(typeof(h.orig_dwelling_type))'');
    populated_orig_home_market_value_cnt := COUNT(GROUP,h.orig_home_market_value <> (TYPEOF(h.orig_home_market_value))'');
    populated_orig_home_market_value_pcnt := AVE(GROUP,IF(h.orig_home_market_value = (TYPEOF(h.orig_home_market_value))'',0,100));
    maxlength_orig_home_market_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_home_market_value)));
    avelength_orig_home_market_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_home_market_value)),h.orig_home_market_value<>(typeof(h.orig_home_market_value))'');
    populated_orig_education_cnt := COUNT(GROUP,h.orig_education <> (TYPEOF(h.orig_education))'');
    populated_orig_education_pcnt := AVE(GROUP,IF(h.orig_education = (TYPEOF(h.orig_education))'',0,100));
    maxlength_orig_education := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_education)));
    avelength_orig_education := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_education)),h.orig_education<>(typeof(h.orig_education))'');
    populated_orig_ethnicity_cnt := COUNT(GROUP,h.orig_ethnicity <> (TYPEOF(h.orig_ethnicity))'');
    populated_orig_ethnicity_pcnt := AVE(GROUP,IF(h.orig_ethnicity = (TYPEOF(h.orig_ethnicity))'',0,100));
    maxlength_orig_ethnicity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ethnicity)));
    avelength_orig_ethnicity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ethnicity)),h.orig_ethnicity<>(typeof(h.orig_ethnicity))'');
    populated_orig_child_cnt := COUNT(GROUP,h.orig_child <> (TYPEOF(h.orig_child))'');
    populated_orig_child_pcnt := AVE(GROUP,IF(h.orig_child = (TYPEOF(h.orig_child))'',0,100));
    maxlength_orig_child := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_child)));
    avelength_orig_child := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_child)),h.orig_child<>(typeof(h.orig_child))'');
    populated_orig_child_age_ranges_cnt := COUNT(GROUP,h.orig_child_age_ranges <> (TYPEOF(h.orig_child_age_ranges))'');
    populated_orig_child_age_ranges_pcnt := AVE(GROUP,IF(h.orig_child_age_ranges = (TYPEOF(h.orig_child_age_ranges))'',0,100));
    maxlength_orig_child_age_ranges := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_child_age_ranges)));
    avelength_orig_child_age_ranges := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_child_age_ranges)),h.orig_child_age_ranges<>(typeof(h.orig_child_age_ranges))'');
    populated_orig_number_of_children_in_hh_cnt := COUNT(GROUP,h.orig_number_of_children_in_hh <> (TYPEOF(h.orig_number_of_children_in_hh))'');
    populated_orig_number_of_children_in_hh_pcnt := AVE(GROUP,IF(h.orig_number_of_children_in_hh = (TYPEOF(h.orig_number_of_children_in_hh))'',0,100));
    maxlength_orig_number_of_children_in_hh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_number_of_children_in_hh)));
    avelength_orig_number_of_children_in_hh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_number_of_children_in_hh)),h.orig_number_of_children_in_hh<>(typeof(h.orig_number_of_children_in_hh))'');
    populated_orig_luxury_vehicle_owner_cnt := COUNT(GROUP,h.orig_luxury_vehicle_owner <> (TYPEOF(h.orig_luxury_vehicle_owner))'');
    populated_orig_luxury_vehicle_owner_pcnt := AVE(GROUP,IF(h.orig_luxury_vehicle_owner = (TYPEOF(h.orig_luxury_vehicle_owner))'',0,100));
    maxlength_orig_luxury_vehicle_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_luxury_vehicle_owner)));
    avelength_orig_luxury_vehicle_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_luxury_vehicle_owner)),h.orig_luxury_vehicle_owner<>(typeof(h.orig_luxury_vehicle_owner))'');
    populated_orig_suv_owner_cnt := COUNT(GROUP,h.orig_suv_owner <> (TYPEOF(h.orig_suv_owner))'');
    populated_orig_suv_owner_pcnt := AVE(GROUP,IF(h.orig_suv_owner = (TYPEOF(h.orig_suv_owner))'',0,100));
    maxlength_orig_suv_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suv_owner)));
    avelength_orig_suv_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suv_owner)),h.orig_suv_owner<>(typeof(h.orig_suv_owner))'');
    populated_orig_pickup_truck_owner_cnt := COUNT(GROUP,h.orig_pickup_truck_owner <> (TYPEOF(h.orig_pickup_truck_owner))'');
    populated_orig_pickup_truck_owner_pcnt := AVE(GROUP,IF(h.orig_pickup_truck_owner = (TYPEOF(h.orig_pickup_truck_owner))'',0,100));
    maxlength_orig_pickup_truck_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pickup_truck_owner)));
    avelength_orig_pickup_truck_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pickup_truck_owner)),h.orig_pickup_truck_owner<>(typeof(h.orig_pickup_truck_owner))'');
    populated_orig_price_club_and_value_purchasing_indicator_cnt := COUNT(GROUP,h.orig_price_club_and_value_purchasing_indicator <> (TYPEOF(h.orig_price_club_and_value_purchasing_indicator))'');
    populated_orig_price_club_and_value_purchasing_indicator_pcnt := AVE(GROUP,IF(h.orig_price_club_and_value_purchasing_indicator = (TYPEOF(h.orig_price_club_and_value_purchasing_indicator))'',0,100));
    maxlength_orig_price_club_and_value_purchasing_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_price_club_and_value_purchasing_indicator)));
    avelength_orig_price_club_and_value_purchasing_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_price_club_and_value_purchasing_indicator)),h.orig_price_club_and_value_purchasing_indicator<>(typeof(h.orig_price_club_and_value_purchasing_indicator))'');
    populated_orig_womens_apparel_purchasing_indicator_cnt := COUNT(GROUP,h.orig_womens_apparel_purchasing_indicator <> (TYPEOF(h.orig_womens_apparel_purchasing_indicator))'');
    populated_orig_womens_apparel_purchasing_indicator_pcnt := AVE(GROUP,IF(h.orig_womens_apparel_purchasing_indicator = (TYPEOF(h.orig_womens_apparel_purchasing_indicator))'',0,100));
    maxlength_orig_womens_apparel_purchasing_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_womens_apparel_purchasing_indicator)));
    avelength_orig_womens_apparel_purchasing_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_womens_apparel_purchasing_indicator)),h.orig_womens_apparel_purchasing_indicator<>(typeof(h.orig_womens_apparel_purchasing_indicator))'');
    populated_orig_mens_apparel_purchasing_indcator_cnt := COUNT(GROUP,h.orig_mens_apparel_purchasing_indcator <> (TYPEOF(h.orig_mens_apparel_purchasing_indcator))'');
    populated_orig_mens_apparel_purchasing_indcator_pcnt := AVE(GROUP,IF(h.orig_mens_apparel_purchasing_indcator = (TYPEOF(h.orig_mens_apparel_purchasing_indcator))'',0,100));
    maxlength_orig_mens_apparel_purchasing_indcator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mens_apparel_purchasing_indcator)));
    avelength_orig_mens_apparel_purchasing_indcator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mens_apparel_purchasing_indcator)),h.orig_mens_apparel_purchasing_indcator<>(typeof(h.orig_mens_apparel_purchasing_indcator))'');
    populated_orig_parenting_and_childrens_interest_bundle_cnt := COUNT(GROUP,h.orig_parenting_and_childrens_interest_bundle <> (TYPEOF(h.orig_parenting_and_childrens_interest_bundle))'');
    populated_orig_parenting_and_childrens_interest_bundle_pcnt := AVE(GROUP,IF(h.orig_parenting_and_childrens_interest_bundle = (TYPEOF(h.orig_parenting_and_childrens_interest_bundle))'',0,100));
    maxlength_orig_parenting_and_childrens_interest_bundle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_parenting_and_childrens_interest_bundle)));
    avelength_orig_parenting_and_childrens_interest_bundle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_parenting_and_childrens_interest_bundle)),h.orig_parenting_and_childrens_interest_bundle<>(typeof(h.orig_parenting_and_childrens_interest_bundle))'');
    populated_orig_pet_lovers_or_owners_cnt := COUNT(GROUP,h.orig_pet_lovers_or_owners <> (TYPEOF(h.orig_pet_lovers_or_owners))'');
    populated_orig_pet_lovers_or_owners_pcnt := AVE(GROUP,IF(h.orig_pet_lovers_or_owners = (TYPEOF(h.orig_pet_lovers_or_owners))'',0,100));
    maxlength_orig_pet_lovers_or_owners := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pet_lovers_or_owners)));
    avelength_orig_pet_lovers_or_owners := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_pet_lovers_or_owners)),h.orig_pet_lovers_or_owners<>(typeof(h.orig_pet_lovers_or_owners))'');
    populated_orig_book_buyers_cnt := COUNT(GROUP,h.orig_book_buyers <> (TYPEOF(h.orig_book_buyers))'');
    populated_orig_book_buyers_pcnt := AVE(GROUP,IF(h.orig_book_buyers = (TYPEOF(h.orig_book_buyers))'',0,100));
    maxlength_orig_book_buyers := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_book_buyers)));
    avelength_orig_book_buyers := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_book_buyers)),h.orig_book_buyers<>(typeof(h.orig_book_buyers))'');
    populated_orig_book_readers_cnt := COUNT(GROUP,h.orig_book_readers <> (TYPEOF(h.orig_book_readers))'');
    populated_orig_book_readers_pcnt := AVE(GROUP,IF(h.orig_book_readers = (TYPEOF(h.orig_book_readers))'',0,100));
    maxlength_orig_book_readers := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_book_readers)));
    avelength_orig_book_readers := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_book_readers)),h.orig_book_readers<>(typeof(h.orig_book_readers))'');
    populated_orig_hi_tech_enthusiasts_cnt := COUNT(GROUP,h.orig_hi_tech_enthusiasts <> (TYPEOF(h.orig_hi_tech_enthusiasts))'');
    populated_orig_hi_tech_enthusiasts_pcnt := AVE(GROUP,IF(h.orig_hi_tech_enthusiasts = (TYPEOF(h.orig_hi_tech_enthusiasts))'',0,100));
    maxlength_orig_hi_tech_enthusiasts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hi_tech_enthusiasts)));
    avelength_orig_hi_tech_enthusiasts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hi_tech_enthusiasts)),h.orig_hi_tech_enthusiasts<>(typeof(h.orig_hi_tech_enthusiasts))'');
    populated_orig_arts_bundle_cnt := COUNT(GROUP,h.orig_arts_bundle <> (TYPEOF(h.orig_arts_bundle))'');
    populated_orig_arts_bundle_pcnt := AVE(GROUP,IF(h.orig_arts_bundle = (TYPEOF(h.orig_arts_bundle))'',0,100));
    maxlength_orig_arts_bundle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_arts_bundle)));
    avelength_orig_arts_bundle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_arts_bundle)),h.orig_arts_bundle<>(typeof(h.orig_arts_bundle))'');
    populated_orig_collectibles_bundle_cnt := COUNT(GROUP,h.orig_collectibles_bundle <> (TYPEOF(h.orig_collectibles_bundle))'');
    populated_orig_collectibles_bundle_pcnt := AVE(GROUP,IF(h.orig_collectibles_bundle = (TYPEOF(h.orig_collectibles_bundle))'',0,100));
    maxlength_orig_collectibles_bundle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_collectibles_bundle)));
    avelength_orig_collectibles_bundle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_collectibles_bundle)),h.orig_collectibles_bundle<>(typeof(h.orig_collectibles_bundle))'');
    populated_orig_hobbies_home_and_garden_bundle_cnt := COUNT(GROUP,h.orig_hobbies_home_and_garden_bundle <> (TYPEOF(h.orig_hobbies_home_and_garden_bundle))'');
    populated_orig_hobbies_home_and_garden_bundle_pcnt := AVE(GROUP,IF(h.orig_hobbies_home_and_garden_bundle = (TYPEOF(h.orig_hobbies_home_and_garden_bundle))'',0,100));
    maxlength_orig_hobbies_home_and_garden_bundle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hobbies_home_and_garden_bundle)));
    avelength_orig_hobbies_home_and_garden_bundle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_hobbies_home_and_garden_bundle)),h.orig_hobbies_home_and_garden_bundle<>(typeof(h.orig_hobbies_home_and_garden_bundle))'');
    populated_orig_home_improvement_cnt := COUNT(GROUP,h.orig_home_improvement <> (TYPEOF(h.orig_home_improvement))'');
    populated_orig_home_improvement_pcnt := AVE(GROUP,IF(h.orig_home_improvement = (TYPEOF(h.orig_home_improvement))'',0,100));
    maxlength_orig_home_improvement := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_home_improvement)));
    avelength_orig_home_improvement := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_home_improvement)),h.orig_home_improvement<>(typeof(h.orig_home_improvement))'');
    populated_orig_cooking_and_wine_cnt := COUNT(GROUP,h.orig_cooking_and_wine <> (TYPEOF(h.orig_cooking_and_wine))'');
    populated_orig_cooking_and_wine_pcnt := AVE(GROUP,IF(h.orig_cooking_and_wine = (TYPEOF(h.orig_cooking_and_wine))'',0,100));
    maxlength_orig_cooking_and_wine := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_cooking_and_wine)));
    avelength_orig_cooking_and_wine := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_cooking_and_wine)),h.orig_cooking_and_wine<>(typeof(h.orig_cooking_and_wine))'');
    populated_orig_gaming_and_gambling_enthusiast_cnt := COUNT(GROUP,h.orig_gaming_and_gambling_enthusiast <> (TYPEOF(h.orig_gaming_and_gambling_enthusiast))'');
    populated_orig_gaming_and_gambling_enthusiast_pcnt := AVE(GROUP,IF(h.orig_gaming_and_gambling_enthusiast = (TYPEOF(h.orig_gaming_and_gambling_enthusiast))'',0,100));
    maxlength_orig_gaming_and_gambling_enthusiast := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_gaming_and_gambling_enthusiast)));
    avelength_orig_gaming_and_gambling_enthusiast := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_gaming_and_gambling_enthusiast)),h.orig_gaming_and_gambling_enthusiast<>(typeof(h.orig_gaming_and_gambling_enthusiast))'');
    populated_orig_travel_enthusiasts_cnt := COUNT(GROUP,h.orig_travel_enthusiasts <> (TYPEOF(h.orig_travel_enthusiasts))'');
    populated_orig_travel_enthusiasts_pcnt := AVE(GROUP,IF(h.orig_travel_enthusiasts = (TYPEOF(h.orig_travel_enthusiasts))'',0,100));
    maxlength_orig_travel_enthusiasts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_travel_enthusiasts)));
    avelength_orig_travel_enthusiasts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_travel_enthusiasts)),h.orig_travel_enthusiasts<>(typeof(h.orig_travel_enthusiasts))'');
    populated_orig_physical_fitness_cnt := COUNT(GROUP,h.orig_physical_fitness <> (TYPEOF(h.orig_physical_fitness))'');
    populated_orig_physical_fitness_pcnt := AVE(GROUP,IF(h.orig_physical_fitness = (TYPEOF(h.orig_physical_fitness))'',0,100));
    maxlength_orig_physical_fitness := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_physical_fitness)));
    avelength_orig_physical_fitness := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_physical_fitness)),h.orig_physical_fitness<>(typeof(h.orig_physical_fitness))'');
    populated_orig_self_improvement_cnt := COUNT(GROUP,h.orig_self_improvement <> (TYPEOF(h.orig_self_improvement))'');
    populated_orig_self_improvement_pcnt := AVE(GROUP,IF(h.orig_self_improvement = (TYPEOF(h.orig_self_improvement))'',0,100));
    maxlength_orig_self_improvement := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_self_improvement)));
    avelength_orig_self_improvement := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_self_improvement)),h.orig_self_improvement<>(typeof(h.orig_self_improvement))'');
    populated_orig_automotive_diy_cnt := COUNT(GROUP,h.orig_automotive_diy <> (TYPEOF(h.orig_automotive_diy))'');
    populated_orig_automotive_diy_pcnt := AVE(GROUP,IF(h.orig_automotive_diy = (TYPEOF(h.orig_automotive_diy))'',0,100));
    maxlength_orig_automotive_diy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_automotive_diy)));
    avelength_orig_automotive_diy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_automotive_diy)),h.orig_automotive_diy<>(typeof(h.orig_automotive_diy))'');
    populated_orig_spectator_sports_interest_cnt := COUNT(GROUP,h.orig_spectator_sports_interest <> (TYPEOF(h.orig_spectator_sports_interest))'');
    populated_orig_spectator_sports_interest_pcnt := AVE(GROUP,IF(h.orig_spectator_sports_interest = (TYPEOF(h.orig_spectator_sports_interest))'',0,100));
    maxlength_orig_spectator_sports_interest := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_spectator_sports_interest)));
    avelength_orig_spectator_sports_interest := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_spectator_sports_interest)),h.orig_spectator_sports_interest<>(typeof(h.orig_spectator_sports_interest))'');
    populated_orig_outdoors_cnt := COUNT(GROUP,h.orig_outdoors <> (TYPEOF(h.orig_outdoors))'');
    populated_orig_outdoors_pcnt := AVE(GROUP,IF(h.orig_outdoors = (TYPEOF(h.orig_outdoors))'',0,100));
    maxlength_orig_outdoors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_outdoors)));
    avelength_orig_outdoors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_outdoors)),h.orig_outdoors<>(typeof(h.orig_outdoors))'');
    populated_orig_avid_investors_cnt := COUNT(GROUP,h.orig_avid_investors <> (TYPEOF(h.orig_avid_investors))'');
    populated_orig_avid_investors_pcnt := AVE(GROUP,IF(h.orig_avid_investors = (TYPEOF(h.orig_avid_investors))'',0,100));
    maxlength_orig_avid_investors := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_avid_investors)));
    avelength_orig_avid_investors := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_avid_investors)),h.orig_avid_investors<>(typeof(h.orig_avid_investors))'');
    populated_orig_avid_interest_in_boating_cnt := COUNT(GROUP,h.orig_avid_interest_in_boating <> (TYPEOF(h.orig_avid_interest_in_boating))'');
    populated_orig_avid_interest_in_boating_pcnt := AVE(GROUP,IF(h.orig_avid_interest_in_boating = (TYPEOF(h.orig_avid_interest_in_boating))'',0,100));
    maxlength_orig_avid_interest_in_boating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_avid_interest_in_boating)));
    avelength_orig_avid_interest_in_boating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_avid_interest_in_boating)),h.orig_avid_interest_in_boating<>(typeof(h.orig_avid_interest_in_boating))'');
    populated_orig_avid_interest_in_motorcycling_cnt := COUNT(GROUP,h.orig_avid_interest_in_motorcycling <> (TYPEOF(h.orig_avid_interest_in_motorcycling))'');
    populated_orig_avid_interest_in_motorcycling_pcnt := AVE(GROUP,IF(h.orig_avid_interest_in_motorcycling = (TYPEOF(h.orig_avid_interest_in_motorcycling))'',0,100));
    maxlength_orig_avid_interest_in_motorcycling := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_avid_interest_in_motorcycling)));
    avelength_orig_avid_interest_in_motorcycling := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_avid_interest_in_motorcycling)),h.orig_avid_interest_in_motorcycling<>(typeof(h.orig_avid_interest_in_motorcycling))'');
    populated_orig_percent_range_black_cnt := COUNT(GROUP,h.orig_percent_range_black <> (TYPEOF(h.orig_percent_range_black))'');
    populated_orig_percent_range_black_pcnt := AVE(GROUP,IF(h.orig_percent_range_black = (TYPEOF(h.orig_percent_range_black))'',0,100));
    maxlength_orig_percent_range_black := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_black)));
    avelength_orig_percent_range_black := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_black)),h.orig_percent_range_black<>(typeof(h.orig_percent_range_black))'');
    populated_orig_percent_range_white_cnt := COUNT(GROUP,h.orig_percent_range_white <> (TYPEOF(h.orig_percent_range_white))'');
    populated_orig_percent_range_white_pcnt := AVE(GROUP,IF(h.orig_percent_range_white = (TYPEOF(h.orig_percent_range_white))'',0,100));
    maxlength_orig_percent_range_white := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_white)));
    avelength_orig_percent_range_white := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_white)),h.orig_percent_range_white<>(typeof(h.orig_percent_range_white))'');
    populated_orig_percent_range_hispanic_cnt := COUNT(GROUP,h.orig_percent_range_hispanic <> (TYPEOF(h.orig_percent_range_hispanic))'');
    populated_orig_percent_range_hispanic_pcnt := AVE(GROUP,IF(h.orig_percent_range_hispanic = (TYPEOF(h.orig_percent_range_hispanic))'',0,100));
    maxlength_orig_percent_range_hispanic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_hispanic)));
    avelength_orig_percent_range_hispanic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_hispanic)),h.orig_percent_range_hispanic<>(typeof(h.orig_percent_range_hispanic))'');
    populated_orig_percent_range_asian_cnt := COUNT(GROUP,h.orig_percent_range_asian <> (TYPEOF(h.orig_percent_range_asian))'');
    populated_orig_percent_range_asian_pcnt := AVE(GROUP,IF(h.orig_percent_range_asian = (TYPEOF(h.orig_percent_range_asian))'',0,100));
    maxlength_orig_percent_range_asian := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_asian)));
    avelength_orig_percent_range_asian := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_asian)),h.orig_percent_range_asian<>(typeof(h.orig_percent_range_asian))'');
    populated_orig_percent_range_english_speaking_cnt := COUNT(GROUP,h.orig_percent_range_english_speaking <> (TYPEOF(h.orig_percent_range_english_speaking))'');
    populated_orig_percent_range_english_speaking_pcnt := AVE(GROUP,IF(h.orig_percent_range_english_speaking = (TYPEOF(h.orig_percent_range_english_speaking))'',0,100));
    maxlength_orig_percent_range_english_speaking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_english_speaking)));
    avelength_orig_percent_range_english_speaking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_english_speaking)),h.orig_percent_range_english_speaking<>(typeof(h.orig_percent_range_english_speaking))'');
    populated_orig_percnt_range_spanish_speaking_cnt := COUNT(GROUP,h.orig_percnt_range_spanish_speaking <> (TYPEOF(h.orig_percnt_range_spanish_speaking))'');
    populated_orig_percnt_range_spanish_speaking_pcnt := AVE(GROUP,IF(h.orig_percnt_range_spanish_speaking = (TYPEOF(h.orig_percnt_range_spanish_speaking))'',0,100));
    maxlength_orig_percnt_range_spanish_speaking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percnt_range_spanish_speaking)));
    avelength_orig_percnt_range_spanish_speaking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percnt_range_spanish_speaking)),h.orig_percnt_range_spanish_speaking<>(typeof(h.orig_percnt_range_spanish_speaking))'');
    populated_orig_percent_range_asian_speaking_cnt := COUNT(GROUP,h.orig_percent_range_asian_speaking <> (TYPEOF(h.orig_percent_range_asian_speaking))'');
    populated_orig_percent_range_asian_speaking_pcnt := AVE(GROUP,IF(h.orig_percent_range_asian_speaking = (TYPEOF(h.orig_percent_range_asian_speaking))'',0,100));
    maxlength_orig_percent_range_asian_speaking := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_asian_speaking)));
    avelength_orig_percent_range_asian_speaking := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_asian_speaking)),h.orig_percent_range_asian_speaking<>(typeof(h.orig_percent_range_asian_speaking))'');
    populated_orig_percent_range_sfdu_cnt := COUNT(GROUP,h.orig_percent_range_sfdu <> (TYPEOF(h.orig_percent_range_sfdu))'');
    populated_orig_percent_range_sfdu_pcnt := AVE(GROUP,IF(h.orig_percent_range_sfdu = (TYPEOF(h.orig_percent_range_sfdu))'',0,100));
    maxlength_orig_percent_range_sfdu := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_sfdu)));
    avelength_orig_percent_range_sfdu := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_sfdu)),h.orig_percent_range_sfdu<>(typeof(h.orig_percent_range_sfdu))'');
    populated_orig_percent_range_mfdu_cnt := COUNT(GROUP,h.orig_percent_range_mfdu <> (TYPEOF(h.orig_percent_range_mfdu))'');
    populated_orig_percent_range_mfdu_pcnt := AVE(GROUP,IF(h.orig_percent_range_mfdu = (TYPEOF(h.orig_percent_range_mfdu))'',0,100));
    maxlength_orig_percent_range_mfdu := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_mfdu)));
    avelength_orig_percent_range_mfdu := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_percent_range_mfdu)),h.orig_percent_range_mfdu<>(typeof(h.orig_percent_range_mfdu))'');
    populated_orig_mhv_cnt := COUNT(GROUP,h.orig_mhv <> (TYPEOF(h.orig_mhv))'');
    populated_orig_mhv_pcnt := AVE(GROUP,IF(h.orig_mhv = (TYPEOF(h.orig_mhv))'',0,100));
    maxlength_orig_mhv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mhv)));
    avelength_orig_mhv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mhv)),h.orig_mhv<>(typeof(h.orig_mhv))'');
    populated_orig_mor_cnt := COUNT(GROUP,h.orig_mor <> (TYPEOF(h.orig_mor))'');
    populated_orig_mor_pcnt := AVE(GROUP,IF(h.orig_mor = (TYPEOF(h.orig_mor))'',0,100));
    maxlength_orig_mor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mor)));
    avelength_orig_mor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mor)),h.orig_mor<>(typeof(h.orig_mor))'');
    populated_orig_car_cnt := COUNT(GROUP,h.orig_car <> (TYPEOF(h.orig_car))'');
    populated_orig_car_pcnt := AVE(GROUP,IF(h.orig_car = (TYPEOF(h.orig_car))'',0,100));
    maxlength_orig_car := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_car)));
    avelength_orig_car := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_car)),h.orig_car<>(typeof(h.orig_car))'');
    populated_orig_medschl_cnt := COUNT(GROUP,h.orig_medschl <> (TYPEOF(h.orig_medschl))'');
    populated_orig_medschl_pcnt := AVE(GROUP,IF(h.orig_medschl = (TYPEOF(h.orig_medschl))'',0,100));
    maxlength_orig_medschl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_medschl)));
    avelength_orig_medschl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_medschl)),h.orig_medschl<>(typeof(h.orig_medschl))'');
    populated_orig_penetration_range_white_collar_cnt := COUNT(GROUP,h.orig_penetration_range_white_collar <> (TYPEOF(h.orig_penetration_range_white_collar))'');
    populated_orig_penetration_range_white_collar_pcnt := AVE(GROUP,IF(h.orig_penetration_range_white_collar = (TYPEOF(h.orig_penetration_range_white_collar))'',0,100));
    maxlength_orig_penetration_range_white_collar := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_penetration_range_white_collar)));
    avelength_orig_penetration_range_white_collar := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_penetration_range_white_collar)),h.orig_penetration_range_white_collar<>(typeof(h.orig_penetration_range_white_collar))'');
    populated_orig_penetration_range_blue_collar_cnt := COUNT(GROUP,h.orig_penetration_range_blue_collar <> (TYPEOF(h.orig_penetration_range_blue_collar))'');
    populated_orig_penetration_range_blue_collar_pcnt := AVE(GROUP,IF(h.orig_penetration_range_blue_collar = (TYPEOF(h.orig_penetration_range_blue_collar))'',0,100));
    maxlength_orig_penetration_range_blue_collar := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_penetration_range_blue_collar)));
    avelength_orig_penetration_range_blue_collar := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_penetration_range_blue_collar)),h.orig_penetration_range_blue_collar<>(typeof(h.orig_penetration_range_blue_collar))'');
    populated_orig_penetration_range_other_occupation_cnt := COUNT(GROUP,h.orig_penetration_range_other_occupation <> (TYPEOF(h.orig_penetration_range_other_occupation))'');
    populated_orig_penetration_range_other_occupation_pcnt := AVE(GROUP,IF(h.orig_penetration_range_other_occupation = (TYPEOF(h.orig_penetration_range_other_occupation))'',0,100));
    maxlength_orig_penetration_range_other_occupation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_penetration_range_other_occupation)));
    avelength_orig_penetration_range_other_occupation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_penetration_range_other_occupation)),h.orig_penetration_range_other_occupation<>(typeof(h.orig_penetration_range_other_occupation))'');
    populated_orig_demolevel_cnt := COUNT(GROUP,h.orig_demolevel <> (TYPEOF(h.orig_demolevel))'');
    populated_orig_demolevel_pcnt := AVE(GROUP,IF(h.orig_demolevel = (TYPEOF(h.orig_demolevel))'',0,100));
    maxlength_orig_demolevel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_demolevel)));
    avelength_orig_demolevel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_demolevel)),h.orig_demolevel<>(typeof(h.orig_demolevel))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_hhid_pcnt *   0.00 / 100 + T.Populated_orig_pid_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_orig_gender_pcnt *   0.00 / 100 + T.Populated_orig_age_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_hhnbr_pcnt *   0.00 / 100 + T.Populated_orig_addrid_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_house_pcnt *   0.00 / 100 + T.Populated_orig_predir_pcnt *   0.00 / 100 + T.Populated_orig_street_pcnt *   0.00 / 100 + T.Populated_orig_strtype_pcnt *   0.00 / 100 + T.Populated_orig_postdir_pcnt *   0.00 / 100 + T.Populated_orig_apttype_pcnt *   0.00 / 100 + T.Populated_orig_aptnbr_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_z4_pcnt *   0.00 / 100 + T.Populated_orig_dpc_pcnt *   0.00 / 100 + T.Populated_orig_z4type_pcnt *   0.00 / 100 + T.Populated_orig_crte_pcnt *   0.00 / 100 + T.Populated_orig_dpv_pcnt *   0.00 / 100 + T.Populated_orig_vacant_pcnt *   0.00 / 100 + T.Populated_orig_msa_pcnt *   0.00 / 100 + T.Populated_orig_cbsa_pcnt *   0.00 / 100 + T.Populated_orig_dma_pcnt *   0.00 / 100 + T.Populated_orig_county_code_pcnt *   0.00 / 100 + T.Populated_orig_time_zone_pcnt *   0.00 / 100 + T.Populated_orig_daylight_savings_pcnt *   0.00 / 100 + T.Populated_orig_latitude_pcnt *   0.00 / 100 + T.Populated_orig_longitude_pcnt *   0.00 / 100 + T.Populated_orig_telephone_number_1_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_1_pcnt *   0.00 / 100 + T.Populated_orig_telephone_number_2_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_2_pcnt *   0.00 / 100 + T.Populated_orig_telephone_number_3_pcnt *   0.00 / 100 + T.Populated_orig_dma_tps_dnc_flag_3_pcnt *   0.00 / 100 + T.Populated_orig_length_of_residence_pcnt *   0.00 / 100 + T.Populated_orig_homeowner_renter_pcnt *   0.00 / 100 + T.Populated_orig_year_built_pcnt *   0.00 / 100 + T.Populated_orig_mobile_home_indicator_pcnt *   0.00 / 100 + T.Populated_orig_pool_owner_pcnt *   0.00 / 100 + T.Populated_orig_fireplace_in_home_pcnt *   0.00 / 100 + T.Populated_orig_estimated_income_pcnt *   0.00 / 100 + T.Populated_orig_marital_status_pcnt *   0.00 / 100 + T.Populated_orig_single_parent_pcnt *   0.00 / 100 + T.Populated_orig_senior_in_hh_pcnt *   0.00 / 100 + T.Populated_orig_credit_card_user_pcnt *   0.00 / 100 + T.Populated_orig_wealth_score_estimated_net_worth_pcnt *   0.00 / 100 + T.Populated_orig_donator_to_charity_or_causes_pcnt *   0.00 / 100 + T.Populated_orig_dwelling_type_pcnt *   0.00 / 100 + T.Populated_orig_home_market_value_pcnt *   0.00 / 100 + T.Populated_orig_education_pcnt *   0.00 / 100 + T.Populated_orig_ethnicity_pcnt *   0.00 / 100 + T.Populated_orig_child_pcnt *   0.00 / 100 + T.Populated_orig_child_age_ranges_pcnt *   0.00 / 100 + T.Populated_orig_number_of_children_in_hh_pcnt *   0.00 / 100 + T.Populated_orig_luxury_vehicle_owner_pcnt *   0.00 / 100 + T.Populated_orig_suv_owner_pcnt *   0.00 / 100 + T.Populated_orig_pickup_truck_owner_pcnt *   0.00 / 100 + T.Populated_orig_price_club_and_value_purchasing_indicator_pcnt *   0.00 / 100 + T.Populated_orig_womens_apparel_purchasing_indicator_pcnt *   0.00 / 100 + T.Populated_orig_mens_apparel_purchasing_indcator_pcnt *   0.00 / 100 + T.Populated_orig_parenting_and_childrens_interest_bundle_pcnt *   0.00 / 100 + T.Populated_orig_pet_lovers_or_owners_pcnt *   0.00 / 100 + T.Populated_orig_book_buyers_pcnt *   0.00 / 100 + T.Populated_orig_book_readers_pcnt *   0.00 / 100 + T.Populated_orig_hi_tech_enthusiasts_pcnt *   0.00 / 100 + T.Populated_orig_arts_bundle_pcnt *   0.00 / 100 + T.Populated_orig_collectibles_bundle_pcnt *   0.00 / 100 + T.Populated_orig_hobbies_home_and_garden_bundle_pcnt *   0.00 / 100 + T.Populated_orig_home_improvement_pcnt *   0.00 / 100 + T.Populated_orig_cooking_and_wine_pcnt *   0.00 / 100 + T.Populated_orig_gaming_and_gambling_enthusiast_pcnt *   0.00 / 100 + T.Populated_orig_travel_enthusiasts_pcnt *   0.00 / 100 + T.Populated_orig_physical_fitness_pcnt *   0.00 / 100 + T.Populated_orig_self_improvement_pcnt *   0.00 / 100 + T.Populated_orig_automotive_diy_pcnt *   0.00 / 100 + T.Populated_orig_spectator_sports_interest_pcnt *   0.00 / 100 + T.Populated_orig_outdoors_pcnt *   0.00 / 100 + T.Populated_orig_avid_investors_pcnt *   0.00 / 100 + T.Populated_orig_avid_interest_in_boating_pcnt *   0.00 / 100 + T.Populated_orig_avid_interest_in_motorcycling_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_black_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_white_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_hispanic_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_asian_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_english_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percnt_range_spanish_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_asian_speaking_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_sfdu_pcnt *   0.00 / 100 + T.Populated_orig_percent_range_mfdu_pcnt *   0.00 / 100 + T.Populated_orig_mhv_pcnt *   0.00 / 100 + T.Populated_orig_mor_pcnt *   0.00 / 100 + T.Populated_orig_car_pcnt *   0.00 / 100 + T.Populated_orig_medschl_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_white_collar_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_blue_collar_pcnt *   0.00 / 100 + T.Populated_orig_penetration_range_other_occupation_pcnt *   0.00 / 100 + T.Populated_orig_demolevel_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'orig_hhid','orig_pid','orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_addrid','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_dpc','orig_z4type','orig_crte','orig_dpv','orig_vacant','orig_msa','orig_cbsa','orig_dma','orig_county_code','orig_time_zone','orig_daylight_savings','orig_latitude','orig_longitude','orig_telephone_number_1','orig_dma_tps_dnc_flag_1','orig_telephone_number_2','orig_dma_tps_dnc_flag_2','orig_telephone_number_3','orig_dma_tps_dnc_flag_3','orig_length_of_residence','orig_homeowner_renter','orig_year_built','orig_mobile_home_indicator','orig_pool_owner','orig_fireplace_in_home','orig_estimated_income','orig_marital_status','orig_single_parent','orig_senior_in_hh','orig_credit_card_user','orig_wealth_score_estimated_net_worth','orig_donator_to_charity_or_causes','orig_dwelling_type','orig_home_market_value','orig_education','orig_ethnicity','orig_child','orig_child_age_ranges','orig_number_of_children_in_hh','orig_luxury_vehicle_owner','orig_suv_owner','orig_pickup_truck_owner','orig_price_club_and_value_purchasing_indicator','orig_womens_apparel_purchasing_indicator','orig_mens_apparel_purchasing_indcator','orig_parenting_and_childrens_interest_bundle','orig_pet_lovers_or_owners','orig_book_buyers','orig_book_readers','orig_hi_tech_enthusiasts','orig_arts_bundle','orig_collectibles_bundle','orig_hobbies_home_and_garden_bundle','orig_home_improvement','orig_cooking_and_wine','orig_gaming_and_gambling_enthusiast','orig_travel_enthusiasts','orig_physical_fitness','orig_self_improvement','orig_automotive_diy','orig_spectator_sports_interest','orig_outdoors','orig_avid_investors','orig_avid_interest_in_boating','orig_avid_interest_in_motorcycling','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_white_collar','orig_penetration_range_blue_collar','orig_penetration_range_other_occupation','orig_demolevel');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_hhid_pcnt,le.populated_orig_pid_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_suffix_pcnt,le.populated_orig_gender_pcnt,le.populated_orig_age_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_hhnbr_pcnt,le.populated_orig_addrid_pcnt,le.populated_orig_address_pcnt,le.populated_orig_house_pcnt,le.populated_orig_predir_pcnt,le.populated_orig_street_pcnt,le.populated_orig_strtype_pcnt,le.populated_orig_postdir_pcnt,le.populated_orig_apttype_pcnt,le.populated_orig_aptnbr_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_z4_pcnt,le.populated_orig_dpc_pcnt,le.populated_orig_z4type_pcnt,le.populated_orig_crte_pcnt,le.populated_orig_dpv_pcnt,le.populated_orig_vacant_pcnt,le.populated_orig_msa_pcnt,le.populated_orig_cbsa_pcnt,le.populated_orig_dma_pcnt,le.populated_orig_county_code_pcnt,le.populated_orig_time_zone_pcnt,le.populated_orig_daylight_savings_pcnt,le.populated_orig_latitude_pcnt,le.populated_orig_longitude_pcnt,le.populated_orig_telephone_number_1_pcnt,le.populated_orig_dma_tps_dnc_flag_1_pcnt,le.populated_orig_telephone_number_2_pcnt,le.populated_orig_dma_tps_dnc_flag_2_pcnt,le.populated_orig_telephone_number_3_pcnt,le.populated_orig_dma_tps_dnc_flag_3_pcnt,le.populated_orig_length_of_residence_pcnt,le.populated_orig_homeowner_renter_pcnt,le.populated_orig_year_built_pcnt,le.populated_orig_mobile_home_indicator_pcnt,le.populated_orig_pool_owner_pcnt,le.populated_orig_fireplace_in_home_pcnt,le.populated_orig_estimated_income_pcnt,le.populated_orig_marital_status_pcnt,le.populated_orig_single_parent_pcnt,le.populated_orig_senior_in_hh_pcnt,le.populated_orig_credit_card_user_pcnt,le.populated_orig_wealth_score_estimated_net_worth_pcnt,le.populated_orig_donator_to_charity_or_causes_pcnt,le.populated_orig_dwelling_type_pcnt,le.populated_orig_home_market_value_pcnt,le.populated_orig_education_pcnt,le.populated_orig_ethnicity_pcnt,le.populated_orig_child_pcnt,le.populated_orig_child_age_ranges_pcnt,le.populated_orig_number_of_children_in_hh_pcnt,le.populated_orig_luxury_vehicle_owner_pcnt,le.populated_orig_suv_owner_pcnt,le.populated_orig_pickup_truck_owner_pcnt,le.populated_orig_price_club_and_value_purchasing_indicator_pcnt,le.populated_orig_womens_apparel_purchasing_indicator_pcnt,le.populated_orig_mens_apparel_purchasing_indcator_pcnt,le.populated_orig_parenting_and_childrens_interest_bundle_pcnt,le.populated_orig_pet_lovers_or_owners_pcnt,le.populated_orig_book_buyers_pcnt,le.populated_orig_book_readers_pcnt,le.populated_orig_hi_tech_enthusiasts_pcnt,le.populated_orig_arts_bundle_pcnt,le.populated_orig_collectibles_bundle_pcnt,le.populated_orig_hobbies_home_and_garden_bundle_pcnt,le.populated_orig_home_improvement_pcnt,le.populated_orig_cooking_and_wine_pcnt,le.populated_orig_gaming_and_gambling_enthusiast_pcnt,le.populated_orig_travel_enthusiasts_pcnt,le.populated_orig_physical_fitness_pcnt,le.populated_orig_self_improvement_pcnt,le.populated_orig_automotive_diy_pcnt,le.populated_orig_spectator_sports_interest_pcnt,le.populated_orig_outdoors_pcnt,le.populated_orig_avid_investors_pcnt,le.populated_orig_avid_interest_in_boating_pcnt,le.populated_orig_avid_interest_in_motorcycling_pcnt,le.populated_orig_percent_range_black_pcnt,le.populated_orig_percent_range_white_pcnt,le.populated_orig_percent_range_hispanic_pcnt,le.populated_orig_percent_range_asian_pcnt,le.populated_orig_percent_range_english_speaking_pcnt,le.populated_orig_percnt_range_spanish_speaking_pcnt,le.populated_orig_percent_range_asian_speaking_pcnt,le.populated_orig_percent_range_sfdu_pcnt,le.populated_orig_percent_range_mfdu_pcnt,le.populated_orig_mhv_pcnt,le.populated_orig_mor_pcnt,le.populated_orig_car_pcnt,le.populated_orig_medschl_pcnt,le.populated_orig_penetration_range_white_collar_pcnt,le.populated_orig_penetration_range_blue_collar_pcnt,le.populated_orig_penetration_range_other_occupation_pcnt,le.populated_orig_demolevel_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_hhid,le.maxlength_orig_pid,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_suffix,le.maxlength_orig_gender,le.maxlength_orig_age,le.maxlength_orig_dob,le.maxlength_orig_hhnbr,le.maxlength_orig_addrid,le.maxlength_orig_address,le.maxlength_orig_house,le.maxlength_orig_predir,le.maxlength_orig_street,le.maxlength_orig_strtype,le.maxlength_orig_postdir,le.maxlength_orig_apttype,le.maxlength_orig_aptnbr,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_z4,le.maxlength_orig_dpc,le.maxlength_orig_z4type,le.maxlength_orig_crte,le.maxlength_orig_dpv,le.maxlength_orig_vacant,le.maxlength_orig_msa,le.maxlength_orig_cbsa,le.maxlength_orig_dma,le.maxlength_orig_county_code,le.maxlength_orig_time_zone,le.maxlength_orig_daylight_savings,le.maxlength_orig_latitude,le.maxlength_orig_longitude,le.maxlength_orig_telephone_number_1,le.maxlength_orig_dma_tps_dnc_flag_1,le.maxlength_orig_telephone_number_2,le.maxlength_orig_dma_tps_dnc_flag_2,le.maxlength_orig_telephone_number_3,le.maxlength_orig_dma_tps_dnc_flag_3,le.maxlength_orig_length_of_residence,le.maxlength_orig_homeowner_renter,le.maxlength_orig_year_built,le.maxlength_orig_mobile_home_indicator,le.maxlength_orig_pool_owner,le.maxlength_orig_fireplace_in_home,le.maxlength_orig_estimated_income,le.maxlength_orig_marital_status,le.maxlength_orig_single_parent,le.maxlength_orig_senior_in_hh,le.maxlength_orig_credit_card_user,le.maxlength_orig_wealth_score_estimated_net_worth,le.maxlength_orig_donator_to_charity_or_causes,le.maxlength_orig_dwelling_type,le.maxlength_orig_home_market_value,le.maxlength_orig_education,le.maxlength_orig_ethnicity,le.maxlength_orig_child,le.maxlength_orig_child_age_ranges,le.maxlength_orig_number_of_children_in_hh,le.maxlength_orig_luxury_vehicle_owner,le.maxlength_orig_suv_owner,le.maxlength_orig_pickup_truck_owner,le.maxlength_orig_price_club_and_value_purchasing_indicator,le.maxlength_orig_womens_apparel_purchasing_indicator,le.maxlength_orig_mens_apparel_purchasing_indcator,le.maxlength_orig_parenting_and_childrens_interest_bundle,le.maxlength_orig_pet_lovers_or_owners,le.maxlength_orig_book_buyers,le.maxlength_orig_book_readers,le.maxlength_orig_hi_tech_enthusiasts,le.maxlength_orig_arts_bundle,le.maxlength_orig_collectibles_bundle,le.maxlength_orig_hobbies_home_and_garden_bundle,le.maxlength_orig_home_improvement,le.maxlength_orig_cooking_and_wine,le.maxlength_orig_gaming_and_gambling_enthusiast,le.maxlength_orig_travel_enthusiasts,le.maxlength_orig_physical_fitness,le.maxlength_orig_self_improvement,le.maxlength_orig_automotive_diy,le.maxlength_orig_spectator_sports_interest,le.maxlength_orig_outdoors,le.maxlength_orig_avid_investors,le.maxlength_orig_avid_interest_in_boating,le.maxlength_orig_avid_interest_in_motorcycling,le.maxlength_orig_percent_range_black,le.maxlength_orig_percent_range_white,le.maxlength_orig_percent_range_hispanic,le.maxlength_orig_percent_range_asian,le.maxlength_orig_percent_range_english_speaking,le.maxlength_orig_percnt_range_spanish_speaking,le.maxlength_orig_percent_range_asian_speaking,le.maxlength_orig_percent_range_sfdu,le.maxlength_orig_percent_range_mfdu,le.maxlength_orig_mhv,le.maxlength_orig_mor,le.maxlength_orig_car,le.maxlength_orig_medschl,le.maxlength_orig_penetration_range_white_collar,le.maxlength_orig_penetration_range_blue_collar,le.maxlength_orig_penetration_range_other_occupation,le.maxlength_orig_demolevel);
  SELF.avelength := CHOOSE(C,le.avelength_orig_hhid,le.avelength_orig_pid,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_suffix,le.avelength_orig_gender,le.avelength_orig_age,le.avelength_orig_dob,le.avelength_orig_hhnbr,le.avelength_orig_addrid,le.avelength_orig_address,le.avelength_orig_house,le.avelength_orig_predir,le.avelength_orig_street,le.avelength_orig_strtype,le.avelength_orig_postdir,le.avelength_orig_apttype,le.avelength_orig_aptnbr,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_z4,le.avelength_orig_dpc,le.avelength_orig_z4type,le.avelength_orig_crte,le.avelength_orig_dpv,le.avelength_orig_vacant,le.avelength_orig_msa,le.avelength_orig_cbsa,le.avelength_orig_dma,le.avelength_orig_county_code,le.avelength_orig_time_zone,le.avelength_orig_daylight_savings,le.avelength_orig_latitude,le.avelength_orig_longitude,le.avelength_orig_telephone_number_1,le.avelength_orig_dma_tps_dnc_flag_1,le.avelength_orig_telephone_number_2,le.avelength_orig_dma_tps_dnc_flag_2,le.avelength_orig_telephone_number_3,le.avelength_orig_dma_tps_dnc_flag_3,le.avelength_orig_length_of_residence,le.avelength_orig_homeowner_renter,le.avelength_orig_year_built,le.avelength_orig_mobile_home_indicator,le.avelength_orig_pool_owner,le.avelength_orig_fireplace_in_home,le.avelength_orig_estimated_income,le.avelength_orig_marital_status,le.avelength_orig_single_parent,le.avelength_orig_senior_in_hh,le.avelength_orig_credit_card_user,le.avelength_orig_wealth_score_estimated_net_worth,le.avelength_orig_donator_to_charity_or_causes,le.avelength_orig_dwelling_type,le.avelength_orig_home_market_value,le.avelength_orig_education,le.avelength_orig_ethnicity,le.avelength_orig_child,le.avelength_orig_child_age_ranges,le.avelength_orig_number_of_children_in_hh,le.avelength_orig_luxury_vehicle_owner,le.avelength_orig_suv_owner,le.avelength_orig_pickup_truck_owner,le.avelength_orig_price_club_and_value_purchasing_indicator,le.avelength_orig_womens_apparel_purchasing_indicator,le.avelength_orig_mens_apparel_purchasing_indcator,le.avelength_orig_parenting_and_childrens_interest_bundle,le.avelength_orig_pet_lovers_or_owners,le.avelength_orig_book_buyers,le.avelength_orig_book_readers,le.avelength_orig_hi_tech_enthusiasts,le.avelength_orig_arts_bundle,le.avelength_orig_collectibles_bundle,le.avelength_orig_hobbies_home_and_garden_bundle,le.avelength_orig_home_improvement,le.avelength_orig_cooking_and_wine,le.avelength_orig_gaming_and_gambling_enthusiast,le.avelength_orig_travel_enthusiasts,le.avelength_orig_physical_fitness,le.avelength_orig_self_improvement,le.avelength_orig_automotive_diy,le.avelength_orig_spectator_sports_interest,le.avelength_orig_outdoors,le.avelength_orig_avid_investors,le.avelength_orig_avid_interest_in_boating,le.avelength_orig_avid_interest_in_motorcycling,le.avelength_orig_percent_range_black,le.avelength_orig_percent_range_white,le.avelength_orig_percent_range_hispanic,le.avelength_orig_percent_range_asian,le.avelength_orig_percent_range_english_speaking,le.avelength_orig_percnt_range_spanish_speaking,le.avelength_orig_percent_range_asian_speaking,le.avelength_orig_percent_range_sfdu,le.avelength_orig_percent_range_mfdu,le.avelength_orig_mhv,le.avelength_orig_mor,le.avelength_orig_car,le.avelength_orig_medschl,le.avelength_orig_penetration_range_white_collar,le.avelength_orig_penetration_range_blue_collar,le.avelength_orig_penetration_range_other_occupation,le.avelength_orig_demolevel);
END;
EXPORT invSummary := NORMALIZE(summary0, 105, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.orig_hhid),TRIM((SALT311.StrType)le.orig_pid),TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.orig_gender),TRIM((SALT311.StrType)le.orig_age),TRIM((SALT311.StrType)le.orig_dob),TRIM((SALT311.StrType)le.orig_hhnbr),TRIM((SALT311.StrType)le.orig_addrid),TRIM((SALT311.StrType)le.orig_address),TRIM((SALT311.StrType)le.orig_house),TRIM((SALT311.StrType)le.orig_predir),TRIM((SALT311.StrType)le.orig_street),TRIM((SALT311.StrType)le.orig_strtype),TRIM((SALT311.StrType)le.orig_postdir),TRIM((SALT311.StrType)le.orig_apttype),TRIM((SALT311.StrType)le.orig_aptnbr),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_z4),TRIM((SALT311.StrType)le.orig_dpc),TRIM((SALT311.StrType)le.orig_z4type),TRIM((SALT311.StrType)le.orig_crte),TRIM((SALT311.StrType)le.orig_dpv),TRIM((SALT311.StrType)le.orig_vacant),TRIM((SALT311.StrType)le.orig_msa),TRIM((SALT311.StrType)le.orig_cbsa),TRIM((SALT311.StrType)le.orig_dma),TRIM((SALT311.StrType)le.orig_county_code),TRIM((SALT311.StrType)le.orig_time_zone),TRIM((SALT311.StrType)le.orig_daylight_savings),TRIM((SALT311.StrType)le.orig_latitude),TRIM((SALT311.StrType)le.orig_longitude),TRIM((SALT311.StrType)le.orig_telephone_number_1),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT311.StrType)le.orig_telephone_number_2),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT311.StrType)le.orig_telephone_number_3),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT311.StrType)le.orig_length_of_residence),TRIM((SALT311.StrType)le.orig_homeowner_renter),TRIM((SALT311.StrType)le.orig_year_built),TRIM((SALT311.StrType)le.orig_mobile_home_indicator),TRIM((SALT311.StrType)le.orig_pool_owner),TRIM((SALT311.StrType)le.orig_fireplace_in_home),TRIM((SALT311.StrType)le.orig_estimated_income),TRIM((SALT311.StrType)le.orig_marital_status),TRIM((SALT311.StrType)le.orig_single_parent),TRIM((SALT311.StrType)le.orig_senior_in_hh),TRIM((SALT311.StrType)le.orig_credit_card_user),TRIM((SALT311.StrType)le.orig_wealth_score_estimated_net_worth),TRIM((SALT311.StrType)le.orig_donator_to_charity_or_causes),TRIM((SALT311.StrType)le.orig_dwelling_type),TRIM((SALT311.StrType)le.orig_home_market_value),TRIM((SALT311.StrType)le.orig_education),TRIM((SALT311.StrType)le.orig_ethnicity),TRIM((SALT311.StrType)le.orig_child),TRIM((SALT311.StrType)le.orig_child_age_ranges),TRIM((SALT311.StrType)le.orig_number_of_children_in_hh),TRIM((SALT311.StrType)le.orig_luxury_vehicle_owner),TRIM((SALT311.StrType)le.orig_suv_owner),TRIM((SALT311.StrType)le.orig_pickup_truck_owner),TRIM((SALT311.StrType)le.orig_price_club_and_value_purchasing_indicator),TRIM((SALT311.StrType)le.orig_womens_apparel_purchasing_indicator),TRIM((SALT311.StrType)le.orig_mens_apparel_purchasing_indcator),TRIM((SALT311.StrType)le.orig_parenting_and_childrens_interest_bundle),TRIM((SALT311.StrType)le.orig_pet_lovers_or_owners),TRIM((SALT311.StrType)le.orig_book_buyers),TRIM((SALT311.StrType)le.orig_book_readers),TRIM((SALT311.StrType)le.orig_hi_tech_enthusiasts),TRIM((SALT311.StrType)le.orig_arts_bundle),TRIM((SALT311.StrType)le.orig_collectibles_bundle),TRIM((SALT311.StrType)le.orig_hobbies_home_and_garden_bundle),TRIM((SALT311.StrType)le.orig_home_improvement),TRIM((SALT311.StrType)le.orig_cooking_and_wine),TRIM((SALT311.StrType)le.orig_gaming_and_gambling_enthusiast),TRIM((SALT311.StrType)le.orig_travel_enthusiasts),TRIM((SALT311.StrType)le.orig_physical_fitness),TRIM((SALT311.StrType)le.orig_self_improvement),TRIM((SALT311.StrType)le.orig_automotive_diy),TRIM((SALT311.StrType)le.orig_spectator_sports_interest),TRIM((SALT311.StrType)le.orig_outdoors),TRIM((SALT311.StrType)le.orig_avid_investors),TRIM((SALT311.StrType)le.orig_avid_interest_in_boating),TRIM((SALT311.StrType)le.orig_avid_interest_in_motorcycling),TRIM((SALT311.StrType)le.orig_percent_range_black),TRIM((SALT311.StrType)le.orig_percent_range_white),TRIM((SALT311.StrType)le.orig_percent_range_hispanic),TRIM((SALT311.StrType)le.orig_percent_range_asian),TRIM((SALT311.StrType)le.orig_percent_range_english_speaking),TRIM((SALT311.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT311.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT311.StrType)le.orig_percent_range_sfdu),TRIM((SALT311.StrType)le.orig_percent_range_mfdu),TRIM((SALT311.StrType)le.orig_mhv),TRIM((SALT311.StrType)le.orig_mor),TRIM((SALT311.StrType)le.orig_car),TRIM((SALT311.StrType)le.orig_medschl),TRIM((SALT311.StrType)le.orig_penetration_range_white_collar),TRIM((SALT311.StrType)le.orig_penetration_range_blue_collar),TRIM((SALT311.StrType)le.orig_penetration_range_other_occupation),TRIM((SALT311.StrType)le.orig_demolevel)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,105,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 105);
  SELF.FldNo2 := 1 + (C % 105);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.orig_hhid),TRIM((SALT311.StrType)le.orig_pid),TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.orig_gender),TRIM((SALT311.StrType)le.orig_age),TRIM((SALT311.StrType)le.orig_dob),TRIM((SALT311.StrType)le.orig_hhnbr),TRIM((SALT311.StrType)le.orig_addrid),TRIM((SALT311.StrType)le.orig_address),TRIM((SALT311.StrType)le.orig_house),TRIM((SALT311.StrType)le.orig_predir),TRIM((SALT311.StrType)le.orig_street),TRIM((SALT311.StrType)le.orig_strtype),TRIM((SALT311.StrType)le.orig_postdir),TRIM((SALT311.StrType)le.orig_apttype),TRIM((SALT311.StrType)le.orig_aptnbr),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_z4),TRIM((SALT311.StrType)le.orig_dpc),TRIM((SALT311.StrType)le.orig_z4type),TRIM((SALT311.StrType)le.orig_crte),TRIM((SALT311.StrType)le.orig_dpv),TRIM((SALT311.StrType)le.orig_vacant),TRIM((SALT311.StrType)le.orig_msa),TRIM((SALT311.StrType)le.orig_cbsa),TRIM((SALT311.StrType)le.orig_dma),TRIM((SALT311.StrType)le.orig_county_code),TRIM((SALT311.StrType)le.orig_time_zone),TRIM((SALT311.StrType)le.orig_daylight_savings),TRIM((SALT311.StrType)le.orig_latitude),TRIM((SALT311.StrType)le.orig_longitude),TRIM((SALT311.StrType)le.orig_telephone_number_1),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT311.StrType)le.orig_telephone_number_2),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT311.StrType)le.orig_telephone_number_3),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT311.StrType)le.orig_length_of_residence),TRIM((SALT311.StrType)le.orig_homeowner_renter),TRIM((SALT311.StrType)le.orig_year_built),TRIM((SALT311.StrType)le.orig_mobile_home_indicator),TRIM((SALT311.StrType)le.orig_pool_owner),TRIM((SALT311.StrType)le.orig_fireplace_in_home),TRIM((SALT311.StrType)le.orig_estimated_income),TRIM((SALT311.StrType)le.orig_marital_status),TRIM((SALT311.StrType)le.orig_single_parent),TRIM((SALT311.StrType)le.orig_senior_in_hh),TRIM((SALT311.StrType)le.orig_credit_card_user),TRIM((SALT311.StrType)le.orig_wealth_score_estimated_net_worth),TRIM((SALT311.StrType)le.orig_donator_to_charity_or_causes),TRIM((SALT311.StrType)le.orig_dwelling_type),TRIM((SALT311.StrType)le.orig_home_market_value),TRIM((SALT311.StrType)le.orig_education),TRIM((SALT311.StrType)le.orig_ethnicity),TRIM((SALT311.StrType)le.orig_child),TRIM((SALT311.StrType)le.orig_child_age_ranges),TRIM((SALT311.StrType)le.orig_number_of_children_in_hh),TRIM((SALT311.StrType)le.orig_luxury_vehicle_owner),TRIM((SALT311.StrType)le.orig_suv_owner),TRIM((SALT311.StrType)le.orig_pickup_truck_owner),TRIM((SALT311.StrType)le.orig_price_club_and_value_purchasing_indicator),TRIM((SALT311.StrType)le.orig_womens_apparel_purchasing_indicator),TRIM((SALT311.StrType)le.orig_mens_apparel_purchasing_indcator),TRIM((SALT311.StrType)le.orig_parenting_and_childrens_interest_bundle),TRIM((SALT311.StrType)le.orig_pet_lovers_or_owners),TRIM((SALT311.StrType)le.orig_book_buyers),TRIM((SALT311.StrType)le.orig_book_readers),TRIM((SALT311.StrType)le.orig_hi_tech_enthusiasts),TRIM((SALT311.StrType)le.orig_arts_bundle),TRIM((SALT311.StrType)le.orig_collectibles_bundle),TRIM((SALT311.StrType)le.orig_hobbies_home_and_garden_bundle),TRIM((SALT311.StrType)le.orig_home_improvement),TRIM((SALT311.StrType)le.orig_cooking_and_wine),TRIM((SALT311.StrType)le.orig_gaming_and_gambling_enthusiast),TRIM((SALT311.StrType)le.orig_travel_enthusiasts),TRIM((SALT311.StrType)le.orig_physical_fitness),TRIM((SALT311.StrType)le.orig_self_improvement),TRIM((SALT311.StrType)le.orig_automotive_diy),TRIM((SALT311.StrType)le.orig_spectator_sports_interest),TRIM((SALT311.StrType)le.orig_outdoors),TRIM((SALT311.StrType)le.orig_avid_investors),TRIM((SALT311.StrType)le.orig_avid_interest_in_boating),TRIM((SALT311.StrType)le.orig_avid_interest_in_motorcycling),TRIM((SALT311.StrType)le.orig_percent_range_black),TRIM((SALT311.StrType)le.orig_percent_range_white),TRIM((SALT311.StrType)le.orig_percent_range_hispanic),TRIM((SALT311.StrType)le.orig_percent_range_asian),TRIM((SALT311.StrType)le.orig_percent_range_english_speaking),TRIM((SALT311.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT311.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT311.StrType)le.orig_percent_range_sfdu),TRIM((SALT311.StrType)le.orig_percent_range_mfdu),TRIM((SALT311.StrType)le.orig_mhv),TRIM((SALT311.StrType)le.orig_mor),TRIM((SALT311.StrType)le.orig_car),TRIM((SALT311.StrType)le.orig_medschl),TRIM((SALT311.StrType)le.orig_penetration_range_white_collar),TRIM((SALT311.StrType)le.orig_penetration_range_blue_collar),TRIM((SALT311.StrType)le.orig_penetration_range_other_occupation),TRIM((SALT311.StrType)le.orig_demolevel)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.orig_hhid),TRIM((SALT311.StrType)le.orig_pid),TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.orig_gender),TRIM((SALT311.StrType)le.orig_age),TRIM((SALT311.StrType)le.orig_dob),TRIM((SALT311.StrType)le.orig_hhnbr),TRIM((SALT311.StrType)le.orig_addrid),TRIM((SALT311.StrType)le.orig_address),TRIM((SALT311.StrType)le.orig_house),TRIM((SALT311.StrType)le.orig_predir),TRIM((SALT311.StrType)le.orig_street),TRIM((SALT311.StrType)le.orig_strtype),TRIM((SALT311.StrType)le.orig_postdir),TRIM((SALT311.StrType)le.orig_apttype),TRIM((SALT311.StrType)le.orig_aptnbr),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_z4),TRIM((SALT311.StrType)le.orig_dpc),TRIM((SALT311.StrType)le.orig_z4type),TRIM((SALT311.StrType)le.orig_crte),TRIM((SALT311.StrType)le.orig_dpv),TRIM((SALT311.StrType)le.orig_vacant),TRIM((SALT311.StrType)le.orig_msa),TRIM((SALT311.StrType)le.orig_cbsa),TRIM((SALT311.StrType)le.orig_dma),TRIM((SALT311.StrType)le.orig_county_code),TRIM((SALT311.StrType)le.orig_time_zone),TRIM((SALT311.StrType)le.orig_daylight_savings),TRIM((SALT311.StrType)le.orig_latitude),TRIM((SALT311.StrType)le.orig_longitude),TRIM((SALT311.StrType)le.orig_telephone_number_1),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_1),TRIM((SALT311.StrType)le.orig_telephone_number_2),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_2),TRIM((SALT311.StrType)le.orig_telephone_number_3),TRIM((SALT311.StrType)le.orig_dma_tps_dnc_flag_3),TRIM((SALT311.StrType)le.orig_length_of_residence),TRIM((SALT311.StrType)le.orig_homeowner_renter),TRIM((SALT311.StrType)le.orig_year_built),TRIM((SALT311.StrType)le.orig_mobile_home_indicator),TRIM((SALT311.StrType)le.orig_pool_owner),TRIM((SALT311.StrType)le.orig_fireplace_in_home),TRIM((SALT311.StrType)le.orig_estimated_income),TRIM((SALT311.StrType)le.orig_marital_status),TRIM((SALT311.StrType)le.orig_single_parent),TRIM((SALT311.StrType)le.orig_senior_in_hh),TRIM((SALT311.StrType)le.orig_credit_card_user),TRIM((SALT311.StrType)le.orig_wealth_score_estimated_net_worth),TRIM((SALT311.StrType)le.orig_donator_to_charity_or_causes),TRIM((SALT311.StrType)le.orig_dwelling_type),TRIM((SALT311.StrType)le.orig_home_market_value),TRIM((SALT311.StrType)le.orig_education),TRIM((SALT311.StrType)le.orig_ethnicity),TRIM((SALT311.StrType)le.orig_child),TRIM((SALT311.StrType)le.orig_child_age_ranges),TRIM((SALT311.StrType)le.orig_number_of_children_in_hh),TRIM((SALT311.StrType)le.orig_luxury_vehicle_owner),TRIM((SALT311.StrType)le.orig_suv_owner),TRIM((SALT311.StrType)le.orig_pickup_truck_owner),TRIM((SALT311.StrType)le.orig_price_club_and_value_purchasing_indicator),TRIM((SALT311.StrType)le.orig_womens_apparel_purchasing_indicator),TRIM((SALT311.StrType)le.orig_mens_apparel_purchasing_indcator),TRIM((SALT311.StrType)le.orig_parenting_and_childrens_interest_bundle),TRIM((SALT311.StrType)le.orig_pet_lovers_or_owners),TRIM((SALT311.StrType)le.orig_book_buyers),TRIM((SALT311.StrType)le.orig_book_readers),TRIM((SALT311.StrType)le.orig_hi_tech_enthusiasts),TRIM((SALT311.StrType)le.orig_arts_bundle),TRIM((SALT311.StrType)le.orig_collectibles_bundle),TRIM((SALT311.StrType)le.orig_hobbies_home_and_garden_bundle),TRIM((SALT311.StrType)le.orig_home_improvement),TRIM((SALT311.StrType)le.orig_cooking_and_wine),TRIM((SALT311.StrType)le.orig_gaming_and_gambling_enthusiast),TRIM((SALT311.StrType)le.orig_travel_enthusiasts),TRIM((SALT311.StrType)le.orig_physical_fitness),TRIM((SALT311.StrType)le.orig_self_improvement),TRIM((SALT311.StrType)le.orig_automotive_diy),TRIM((SALT311.StrType)le.orig_spectator_sports_interest),TRIM((SALT311.StrType)le.orig_outdoors),TRIM((SALT311.StrType)le.orig_avid_investors),TRIM((SALT311.StrType)le.orig_avid_interest_in_boating),TRIM((SALT311.StrType)le.orig_avid_interest_in_motorcycling),TRIM((SALT311.StrType)le.orig_percent_range_black),TRIM((SALT311.StrType)le.orig_percent_range_white),TRIM((SALT311.StrType)le.orig_percent_range_hispanic),TRIM((SALT311.StrType)le.orig_percent_range_asian),TRIM((SALT311.StrType)le.orig_percent_range_english_speaking),TRIM((SALT311.StrType)le.orig_percnt_range_spanish_speaking),TRIM((SALT311.StrType)le.orig_percent_range_asian_speaking),TRIM((SALT311.StrType)le.orig_percent_range_sfdu),TRIM((SALT311.StrType)le.orig_percent_range_mfdu),TRIM((SALT311.StrType)le.orig_mhv),TRIM((SALT311.StrType)le.orig_mor),TRIM((SALT311.StrType)le.orig_car),TRIM((SALT311.StrType)le.orig_medschl),TRIM((SALT311.StrType)le.orig_penetration_range_white_collar),TRIM((SALT311.StrType)le.orig_penetration_range_blue_collar),TRIM((SALT311.StrType)le.orig_penetration_range_other_occupation),TRIM((SALT311.StrType)le.orig_demolevel)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),105*105,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{11,'orig_addrid'}
      ,{12,'orig_address'}
      ,{13,'orig_house'}
      ,{14,'orig_predir'}
      ,{15,'orig_street'}
      ,{16,'orig_strtype'}
      ,{17,'orig_postdir'}
      ,{18,'orig_apttype'}
      ,{19,'orig_aptnbr'}
      ,{20,'orig_city'}
      ,{21,'orig_state'}
      ,{22,'orig_zip'}
      ,{23,'orig_z4'}
      ,{24,'orig_dpc'}
      ,{25,'orig_z4type'}
      ,{26,'orig_crte'}
      ,{27,'orig_dpv'}
      ,{28,'orig_vacant'}
      ,{29,'orig_msa'}
      ,{30,'orig_cbsa'}
      ,{31,'orig_dma'}
      ,{32,'orig_county_code'}
      ,{33,'orig_time_zone'}
      ,{34,'orig_daylight_savings'}
      ,{35,'orig_latitude'}
      ,{36,'orig_longitude'}
      ,{37,'orig_telephone_number_1'}
      ,{38,'orig_dma_tps_dnc_flag_1'}
      ,{39,'orig_telephone_number_2'}
      ,{40,'orig_dma_tps_dnc_flag_2'}
      ,{41,'orig_telephone_number_3'}
      ,{42,'orig_dma_tps_dnc_flag_3'}
      ,{43,'orig_length_of_residence'}
      ,{44,'orig_homeowner_renter'}
      ,{45,'orig_year_built'}
      ,{46,'orig_mobile_home_indicator'}
      ,{47,'orig_pool_owner'}
      ,{48,'orig_fireplace_in_home'}
      ,{49,'orig_estimated_income'}
      ,{50,'orig_marital_status'}
      ,{51,'orig_single_parent'}
      ,{52,'orig_senior_in_hh'}
      ,{53,'orig_credit_card_user'}
      ,{54,'orig_wealth_score_estimated_net_worth'}
      ,{55,'orig_donator_to_charity_or_causes'}
      ,{56,'orig_dwelling_type'}
      ,{57,'orig_home_market_value'}
      ,{58,'orig_education'}
      ,{59,'orig_ethnicity'}
      ,{60,'orig_child'}
      ,{61,'orig_child_age_ranges'}
      ,{62,'orig_number_of_children_in_hh'}
      ,{63,'orig_luxury_vehicle_owner'}
      ,{64,'orig_suv_owner'}
      ,{65,'orig_pickup_truck_owner'}
      ,{66,'orig_price_club_and_value_purchasing_indicator'}
      ,{67,'orig_womens_apparel_purchasing_indicator'}
      ,{68,'orig_mens_apparel_purchasing_indcator'}
      ,{69,'orig_parenting_and_childrens_interest_bundle'}
      ,{70,'orig_pet_lovers_or_owners'}
      ,{71,'orig_book_buyers'}
      ,{72,'orig_book_readers'}
      ,{73,'orig_hi_tech_enthusiasts'}
      ,{74,'orig_arts_bundle'}
      ,{75,'orig_collectibles_bundle'}
      ,{76,'orig_hobbies_home_and_garden_bundle'}
      ,{77,'orig_home_improvement'}
      ,{78,'orig_cooking_and_wine'}
      ,{79,'orig_gaming_and_gambling_enthusiast'}
      ,{80,'orig_travel_enthusiasts'}
      ,{81,'orig_physical_fitness'}
      ,{82,'orig_self_improvement'}
      ,{83,'orig_automotive_diy'}
      ,{84,'orig_spectator_sports_interest'}
      ,{85,'orig_outdoors'}
      ,{86,'orig_avid_investors'}
      ,{87,'orig_avid_interest_in_boating'}
      ,{88,'orig_avid_interest_in_motorcycling'}
      ,{89,'orig_percent_range_black'}
      ,{90,'orig_percent_range_white'}
      ,{91,'orig_percent_range_hispanic'}
      ,{92,'orig_percent_range_asian'}
      ,{93,'orig_percent_range_english_speaking'}
      ,{94,'orig_percnt_range_spanish_speaking'}
      ,{95,'orig_percent_range_asian_speaking'}
      ,{96,'orig_percent_range_sfdu'}
      ,{97,'orig_percent_range_mfdu'}
      ,{98,'orig_mhv'}
      ,{99,'orig_mor'}
      ,{100,'orig_car'}
      ,{101,'orig_medschl'}
      ,{102,'orig_penetration_range_white_collar'}
      ,{103,'orig_penetration_range_blue_collar'}
      ,{104,'orig_penetration_range_other_occupation'}
      ,{105,'orig_demolevel'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    raw_Fields.InValid_orig_hhid((SALT311.StrType)le.orig_hhid),
    raw_Fields.InValid_orig_pid((SALT311.StrType)le.orig_pid),
    raw_Fields.InValid_orig_fname((SALT311.StrType)le.orig_fname),
    raw_Fields.InValid_orig_mname((SALT311.StrType)le.orig_mname),
    raw_Fields.InValid_orig_lname((SALT311.StrType)le.orig_lname),
    raw_Fields.InValid_orig_suffix((SALT311.StrType)le.orig_suffix),
    raw_Fields.InValid_orig_gender((SALT311.StrType)le.orig_gender),
    raw_Fields.InValid_orig_age((SALT311.StrType)le.orig_age),
    raw_Fields.InValid_orig_dob((SALT311.StrType)le.orig_dob),
    raw_Fields.InValid_orig_hhnbr((SALT311.StrType)le.orig_hhnbr),
    raw_Fields.InValid_orig_addrid((SALT311.StrType)le.orig_addrid),
    raw_Fields.InValid_orig_address((SALT311.StrType)le.orig_address),
    raw_Fields.InValid_orig_house((SALT311.StrType)le.orig_house),
    raw_Fields.InValid_orig_predir((SALT311.StrType)le.orig_predir),
    raw_Fields.InValid_orig_street((SALT311.StrType)le.orig_street),
    raw_Fields.InValid_orig_strtype((SALT311.StrType)le.orig_strtype),
    raw_Fields.InValid_orig_postdir((SALT311.StrType)le.orig_postdir),
    raw_Fields.InValid_orig_apttype((SALT311.StrType)le.orig_apttype),
    raw_Fields.InValid_orig_aptnbr((SALT311.StrType)le.orig_aptnbr),
    raw_Fields.InValid_orig_city((SALT311.StrType)le.orig_city),
    raw_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    raw_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    raw_Fields.InValid_orig_z4((SALT311.StrType)le.orig_z4),
    raw_Fields.InValid_orig_dpc((SALT311.StrType)le.orig_dpc),
    raw_Fields.InValid_orig_z4type((SALT311.StrType)le.orig_z4type),
    raw_Fields.InValid_orig_crte((SALT311.StrType)le.orig_crte),
    raw_Fields.InValid_orig_dpv((SALT311.StrType)le.orig_dpv),
    raw_Fields.InValid_orig_vacant((SALT311.StrType)le.orig_vacant),
    raw_Fields.InValid_orig_msa((SALT311.StrType)le.orig_msa),
    raw_Fields.InValid_orig_cbsa((SALT311.StrType)le.orig_cbsa),
    raw_Fields.InValid_orig_dma((SALT311.StrType)le.orig_dma),
    raw_Fields.InValid_orig_county_code((SALT311.StrType)le.orig_county_code),
    raw_Fields.InValid_orig_time_zone((SALT311.StrType)le.orig_time_zone),
    raw_Fields.InValid_orig_daylight_savings((SALT311.StrType)le.orig_daylight_savings),
    raw_Fields.InValid_orig_latitude((SALT311.StrType)le.orig_latitude),
    raw_Fields.InValid_orig_longitude((SALT311.StrType)le.orig_longitude),
    raw_Fields.InValid_orig_telephone_number_1((SALT311.StrType)le.orig_telephone_number_1),
    raw_Fields.InValid_orig_dma_tps_dnc_flag_1((SALT311.StrType)le.orig_dma_tps_dnc_flag_1),
    raw_Fields.InValid_orig_telephone_number_2((SALT311.StrType)le.orig_telephone_number_2),
    raw_Fields.InValid_orig_dma_tps_dnc_flag_2((SALT311.StrType)le.orig_dma_tps_dnc_flag_2),
    raw_Fields.InValid_orig_telephone_number_3((SALT311.StrType)le.orig_telephone_number_3),
    raw_Fields.InValid_orig_dma_tps_dnc_flag_3((SALT311.StrType)le.orig_dma_tps_dnc_flag_3),
    raw_Fields.InValid_orig_length_of_residence((SALT311.StrType)le.orig_length_of_residence),
    raw_Fields.InValid_orig_homeowner_renter((SALT311.StrType)le.orig_homeowner_renter),
    raw_Fields.InValid_orig_year_built((SALT311.StrType)le.orig_year_built),
    raw_Fields.InValid_orig_mobile_home_indicator((SALT311.StrType)le.orig_mobile_home_indicator),
    raw_Fields.InValid_orig_pool_owner((SALT311.StrType)le.orig_pool_owner),
    raw_Fields.InValid_orig_fireplace_in_home((SALT311.StrType)le.orig_fireplace_in_home),
    raw_Fields.InValid_orig_estimated_income((SALT311.StrType)le.orig_estimated_income),
    raw_Fields.InValid_orig_marital_status((SALT311.StrType)le.orig_marital_status),
    raw_Fields.InValid_orig_single_parent((SALT311.StrType)le.orig_single_parent),
    raw_Fields.InValid_orig_senior_in_hh((SALT311.StrType)le.orig_senior_in_hh),
    raw_Fields.InValid_orig_credit_card_user((SALT311.StrType)le.orig_credit_card_user),
    raw_Fields.InValid_orig_wealth_score_estimated_net_worth((SALT311.StrType)le.orig_wealth_score_estimated_net_worth),
    raw_Fields.InValid_orig_donator_to_charity_or_causes((SALT311.StrType)le.orig_donator_to_charity_or_causes),
    raw_Fields.InValid_orig_dwelling_type((SALT311.StrType)le.orig_dwelling_type),
    raw_Fields.InValid_orig_home_market_value((SALT311.StrType)le.orig_home_market_value),
    raw_Fields.InValid_orig_education((SALT311.StrType)le.orig_education),
    raw_Fields.InValid_orig_ethnicity((SALT311.StrType)le.orig_ethnicity),
    raw_Fields.InValid_orig_child((SALT311.StrType)le.orig_child),
    raw_Fields.InValid_orig_child_age_ranges((SALT311.StrType)le.orig_child_age_ranges),
    raw_Fields.InValid_orig_number_of_children_in_hh((SALT311.StrType)le.orig_number_of_children_in_hh),
    raw_Fields.InValid_orig_luxury_vehicle_owner((SALT311.StrType)le.orig_luxury_vehicle_owner),
    raw_Fields.InValid_orig_suv_owner((SALT311.StrType)le.orig_suv_owner),
    raw_Fields.InValid_orig_pickup_truck_owner((SALT311.StrType)le.orig_pickup_truck_owner),
    raw_Fields.InValid_orig_price_club_and_value_purchasing_indicator((SALT311.StrType)le.orig_price_club_and_value_purchasing_indicator),
    raw_Fields.InValid_orig_womens_apparel_purchasing_indicator((SALT311.StrType)le.orig_womens_apparel_purchasing_indicator),
    raw_Fields.InValid_orig_mens_apparel_purchasing_indcator((SALT311.StrType)le.orig_mens_apparel_purchasing_indcator),
    raw_Fields.InValid_orig_parenting_and_childrens_interest_bundle((SALT311.StrType)le.orig_parenting_and_childrens_interest_bundle),
    raw_Fields.InValid_orig_pet_lovers_or_owners((SALT311.StrType)le.orig_pet_lovers_or_owners),
    raw_Fields.InValid_orig_book_buyers((SALT311.StrType)le.orig_book_buyers),
    raw_Fields.InValid_orig_book_readers((SALT311.StrType)le.orig_book_readers),
    raw_Fields.InValid_orig_hi_tech_enthusiasts((SALT311.StrType)le.orig_hi_tech_enthusiasts),
    raw_Fields.InValid_orig_arts_bundle((SALT311.StrType)le.orig_arts_bundle),
    raw_Fields.InValid_orig_collectibles_bundle((SALT311.StrType)le.orig_collectibles_bundle),
    raw_Fields.InValid_orig_hobbies_home_and_garden_bundle((SALT311.StrType)le.orig_hobbies_home_and_garden_bundle),
    raw_Fields.InValid_orig_home_improvement((SALT311.StrType)le.orig_home_improvement),
    raw_Fields.InValid_orig_cooking_and_wine((SALT311.StrType)le.orig_cooking_and_wine),
    raw_Fields.InValid_orig_gaming_and_gambling_enthusiast((SALT311.StrType)le.orig_gaming_and_gambling_enthusiast),
    raw_Fields.InValid_orig_travel_enthusiasts((SALT311.StrType)le.orig_travel_enthusiasts),
    raw_Fields.InValid_orig_physical_fitness((SALT311.StrType)le.orig_physical_fitness),
    raw_Fields.InValid_orig_self_improvement((SALT311.StrType)le.orig_self_improvement),
    raw_Fields.InValid_orig_automotive_diy((SALT311.StrType)le.orig_automotive_diy),
    raw_Fields.InValid_orig_spectator_sports_interest((SALT311.StrType)le.orig_spectator_sports_interest),
    raw_Fields.InValid_orig_outdoors((SALT311.StrType)le.orig_outdoors),
    raw_Fields.InValid_orig_avid_investors((SALT311.StrType)le.orig_avid_investors),
    raw_Fields.InValid_orig_avid_interest_in_boating((SALT311.StrType)le.orig_avid_interest_in_boating),
    raw_Fields.InValid_orig_avid_interest_in_motorcycling((SALT311.StrType)le.orig_avid_interest_in_motorcycling),
    raw_Fields.InValid_orig_percent_range_black((SALT311.StrType)le.orig_percent_range_black),
    raw_Fields.InValid_orig_percent_range_white((SALT311.StrType)le.orig_percent_range_white),
    raw_Fields.InValid_orig_percent_range_hispanic((SALT311.StrType)le.orig_percent_range_hispanic),
    raw_Fields.InValid_orig_percent_range_asian((SALT311.StrType)le.orig_percent_range_asian),
    raw_Fields.InValid_orig_percent_range_english_speaking((SALT311.StrType)le.orig_percent_range_english_speaking),
    raw_Fields.InValid_orig_percnt_range_spanish_speaking((SALT311.StrType)le.orig_percnt_range_spanish_speaking),
    raw_Fields.InValid_orig_percent_range_asian_speaking((SALT311.StrType)le.orig_percent_range_asian_speaking),
    raw_Fields.InValid_orig_percent_range_sfdu((SALT311.StrType)le.orig_percent_range_sfdu),
    raw_Fields.InValid_orig_percent_range_mfdu((SALT311.StrType)le.orig_percent_range_mfdu),
    raw_Fields.InValid_orig_mhv((SALT311.StrType)le.orig_mhv),
    raw_Fields.InValid_orig_mor((SALT311.StrType)le.orig_mor),
    raw_Fields.InValid_orig_car((SALT311.StrType)le.orig_car),
    raw_Fields.InValid_orig_medschl((SALT311.StrType)le.orig_medschl),
    raw_Fields.InValid_orig_penetration_range_white_collar((SALT311.StrType)le.orig_penetration_range_white_collar),
    raw_Fields.InValid_orig_penetration_range_blue_collar((SALT311.StrType)le.orig_penetration_range_blue_collar),
    raw_Fields.InValid_orig_penetration_range_other_occupation((SALT311.StrType)le.orig_penetration_range_other_occupation),
    raw_Fields.InValid_orig_demolevel((SALT311.StrType)le.orig_demolevel),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,105,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','invalid_gender','invalid_age','invalid_dob','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_city','invalid_state','invalid_zip','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,raw_Fields.InValidMessage_orig_hhid(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_pid(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_gender(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_age(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_hhnbr(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_addrid(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_house(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_predir(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_street(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_strtype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_postdir(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_apttype(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_aptnbr(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_z4(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dpc(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_z4type(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_crte(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dpv(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_vacant(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_msa(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_cbsa(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dma(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_county_code(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_time_zone(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_daylight_savings(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_latitude(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_longitude(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_telephone_number_1(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_1(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_telephone_number_2(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_2(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_telephone_number_3(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dma_tps_dnc_flag_3(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_length_of_residence(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_homeowner_renter(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_year_built(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_mobile_home_indicator(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_pool_owner(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_fireplace_in_home(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_estimated_income(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_marital_status(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_single_parent(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_senior_in_hh(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_credit_card_user(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_wealth_score_estimated_net_worth(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_donator_to_charity_or_causes(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_dwelling_type(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_home_market_value(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_education(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_ethnicity(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_child(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_child_age_ranges(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_number_of_children_in_hh(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_luxury_vehicle_owner(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_suv_owner(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_pickup_truck_owner(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_price_club_and_value_purchasing_indicator(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_womens_apparel_purchasing_indicator(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_mens_apparel_purchasing_indcator(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_parenting_and_childrens_interest_bundle(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_pet_lovers_or_owners(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_book_buyers(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_book_readers(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_hi_tech_enthusiasts(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_arts_bundle(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_collectibles_bundle(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_hobbies_home_and_garden_bundle(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_home_improvement(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_cooking_and_wine(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_gaming_and_gambling_enthusiast(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_travel_enthusiasts(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_physical_fitness(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_self_improvement(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_automotive_diy(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_spectator_sports_interest(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_outdoors(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_avid_investors(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_avid_interest_in_boating(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_avid_interest_in_motorcycling(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_black(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_white(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_hispanic(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_asian(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_english_speaking(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percnt_range_spanish_speaking(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_asian_speaking(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_sfdu(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_percent_range_mfdu(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_mhv(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_mor(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_car(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_medschl(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_penetration_range_white_collar(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_penetration_range_blue_collar(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_penetration_range_other_occupation(TotalErrors.ErrorNum),raw_Fields.InValidMessage_orig_demolevel(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(scrubs_infutor_narc3, raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
