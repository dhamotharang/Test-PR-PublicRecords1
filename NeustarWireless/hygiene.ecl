IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_MAIN) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_salutation_cnt := COUNT(GROUP,h.salutation <> (TYPEOF(h.salutation))'');
    populated_salutation_pcnt := AVE(GROUP,IF(h.salutation = (TYPEOF(h.salutation))'',0,100));
    maxlength_salutation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.salutation)));
    avelength_salutation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.salutation)),h.salutation<>(typeof(h.salutation))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_house_cnt := COUNT(GROUP,h.house <> (TYPEOF(h.house))'');
    populated_house_pcnt := AVE(GROUP,IF(h.house = (TYPEOF(h.house))'',0,100));
    maxlength_house := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.house)));
    avelength_house := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.house)),h.house<>(typeof(h.house))'');
    populated_pre_dir_cnt := COUNT(GROUP,h.pre_dir <> (TYPEOF(h.pre_dir))'');
    populated_pre_dir_pcnt := AVE(GROUP,IF(h.pre_dir = (TYPEOF(h.pre_dir))'',0,100));
    maxlength_pre_dir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pre_dir)));
    avelength_pre_dir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pre_dir)),h.pre_dir<>(typeof(h.pre_dir))'');
    populated_street_cnt := COUNT(GROUP,h.street <> (TYPEOF(h.street))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_street_type_cnt := COUNT(GROUP,h.street_type <> (TYPEOF(h.street_type))'');
    populated_street_type_pcnt := AVE(GROUP,IF(h.street_type = (TYPEOF(h.street_type))'',0,100));
    maxlength_street_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_type)));
    avelength_street_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_type)),h.street_type<>(typeof(h.street_type))'');
    populated_post_dir_cnt := COUNT(GROUP,h.post_dir <> (TYPEOF(h.post_dir))'');
    populated_post_dir_pcnt := AVE(GROUP,IF(h.post_dir = (TYPEOF(h.post_dir))'',0,100));
    maxlength_post_dir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.post_dir)));
    avelength_post_dir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.post_dir)),h.post_dir<>(typeof(h.post_dir))'');
    populated_apt_type_cnt := COUNT(GROUP,h.apt_type <> (TYPEOF(h.apt_type))'');
    populated_apt_type_pcnt := AVE(GROUP,IF(h.apt_type = (TYPEOF(h.apt_type))'',0,100));
    maxlength_apt_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apt_type)));
    avelength_apt_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apt_type)),h.apt_type<>(typeof(h.apt_type))'');
    populated_apt_nbr_cnt := COUNT(GROUP,h.apt_nbr <> (TYPEOF(h.apt_nbr))'');
    populated_apt_nbr_pcnt := AVE(GROUP,IF(h.apt_nbr = (TYPEOF(h.apt_nbr))'',0,100));
    maxlength_apt_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apt_nbr)));
    avelength_apt_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apt_nbr)),h.apt_nbr<>(typeof(h.apt_nbr))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_plus4_cnt := COUNT(GROUP,h.plus4 <> (TYPEOF(h.plus4))'');
    populated_plus4_pcnt := AVE(GROUP,IF(h.plus4 = (TYPEOF(h.plus4))'',0,100));
    maxlength_plus4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plus4)));
    avelength_plus4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plus4)),h.plus4<>(typeof(h.plus4))'');
    populated_dpc_cnt := COUNT(GROUP,h.dpc <> (TYPEOF(h.dpc))'');
    populated_dpc_pcnt := AVE(GROUP,IF(h.dpc = (TYPEOF(h.dpc))'',0,100));
    maxlength_dpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpc)));
    avelength_dpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpc)),h.dpc<>(typeof(h.dpc))'');
    populated_z4_type_cnt := COUNT(GROUP,h.z4_type <> (TYPEOF(h.z4_type))'');
    populated_z4_type_pcnt := AVE(GROUP,IF(h.z4_type = (TYPEOF(h.z4_type))'',0,100));
    maxlength_z4_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4_type)));
    avelength_z4_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4_type)),h.z4_type<>(typeof(h.z4_type))'');
    populated_crte_cnt := COUNT(GROUP,h.crte <> (TYPEOF(h.crte))'');
    populated_crte_pcnt := AVE(GROUP,IF(h.crte = (TYPEOF(h.crte))'',0,100));
    maxlength_crte := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crte)));
    avelength_crte := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crte)),h.crte<>(typeof(h.crte))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_dpvcmra_cnt := COUNT(GROUP,h.dpvcmra <> (TYPEOF(h.dpvcmra))'');
    populated_dpvcmra_pcnt := AVE(GROUP,IF(h.dpvcmra = (TYPEOF(h.dpvcmra))'',0,100));
    maxlength_dpvcmra := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpvcmra)));
    avelength_dpvcmra := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpvcmra)),h.dpvcmra<>(typeof(h.dpvcmra))'');
    populated_dpvconf_cnt := COUNT(GROUP,h.dpvconf <> (TYPEOF(h.dpvconf))'');
    populated_dpvconf_pcnt := AVE(GROUP,IF(h.dpvconf = (TYPEOF(h.dpvconf))'',0,100));
    maxlength_dpvconf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpvconf)));
    avelength_dpvconf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpvconf)),h.dpvconf<>(typeof(h.dpvconf))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_census_tract_cnt := COUNT(GROUP,h.census_tract <> (TYPEOF(h.census_tract))'');
    populated_census_tract_pcnt := AVE(GROUP,IF(h.census_tract = (TYPEOF(h.census_tract))'',0,100));
    maxlength_census_tract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_tract)));
    avelength_census_tract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_tract)),h.census_tract<>(typeof(h.census_tract))'');
    populated_census_block_group_cnt := COUNT(GROUP,h.census_block_group <> (TYPEOF(h.census_block_group))'');
    populated_census_block_group_pcnt := AVE(GROUP,IF(h.census_block_group = (TYPEOF(h.census_block_group))'',0,100));
    maxlength_census_block_group := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_block_group)));
    avelength_census_block_group := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_block_group)),h.census_block_group<>(typeof(h.census_block_group))'');
    populated_cbsa_cnt := COUNT(GROUP,h.cbsa <> (TYPEOF(h.cbsa))'');
    populated_cbsa_pcnt := AVE(GROUP,IF(h.cbsa = (TYPEOF(h.cbsa))'',0,100));
    maxlength_cbsa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa)));
    avelength_cbsa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa)),h.cbsa<>(typeof(h.cbsa))'');
    populated_match_code_cnt := COUNT(GROUP,h.match_code <> (TYPEOF(h.match_code))'');
    populated_match_code_pcnt := AVE(GROUP,IF(h.match_code = (TYPEOF(h.match_code))'',0,100));
    maxlength_match_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_code)));
    avelength_match_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_code)),h.match_code<>(typeof(h.match_code))'');
    populated_latitude_cnt := COUNT(GROUP,h.latitude <> (TYPEOF(h.latitude))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_verified_cnt := COUNT(GROUP,h.verified <> (TYPEOF(h.verified))'');
    populated_verified_pcnt := AVE(GROUP,IF(h.verified = (TYPEOF(h.verified))'',0,100));
    maxlength_verified := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified)));
    avelength_verified := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified)),h.verified<>(typeof(h.verified))'');
    populated_activity_status_cnt := COUNT(GROUP,h.activity_status <> (TYPEOF(h.activity_status))'');
    populated_activity_status_pcnt := AVE(GROUP,IF(h.activity_status = (TYPEOF(h.activity_status))'',0,100));
    maxlength_activity_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_status)));
    avelength_activity_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_status)),h.activity_status<>(typeof(h.activity_status))'');
    populated_prepaid_cnt := COUNT(GROUP,h.prepaid <> (TYPEOF(h.prepaid))'');
    populated_prepaid_pcnt := AVE(GROUP,IF(h.prepaid = (TYPEOF(h.prepaid))'',0,100));
    maxlength_prepaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)));
    avelength_prepaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)),h.prepaid<>(typeof(h.prepaid))'');
    populated_cord_cutter_cnt := COUNT(GROUP,h.cord_cutter <> (TYPEOF(h.cord_cutter))'');
    populated_cord_cutter_pcnt := AVE(GROUP,IF(h.cord_cutter = (TYPEOF(h.cord_cutter))'',0,100));
    maxlength_cord_cutter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cord_cutter)));
    avelength_cord_cutter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cord_cutter)),h.cord_cutter<>(typeof(h.cord_cutter))'');
    populated_raw_file_name_cnt := COUNT(GROUP,h.raw_file_name <> (TYPEOF(h.raw_file_name))'');
    populated_raw_file_name_pcnt := AVE(GROUP,IF(h.raw_file_name = (TYPEOF(h.raw_file_name))'',0,100));
    maxlength_raw_file_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_file_name)));
    avelength_raw_file_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_file_name)),h.raw_file_name<>(typeof(h.raw_file_name))'');
    populated_rcid_cnt := COUNT(GROUP,h.rcid <> (TYPEOF(h.rcid))'');
    populated_rcid_pcnt := AVE(GROUP,IF(h.rcid = (TYPEOF(h.rcid))'',0,100));
    maxlength_rcid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rcid)));
    avelength_rcid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rcid)),h.rcid<>(typeof(h.rcid))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_xadl2_weight_cnt := COUNT(GROUP,h.xadl2_weight <> (TYPEOF(h.xadl2_weight))'');
    populated_xadl2_weight_pcnt := AVE(GROUP,IF(h.xadl2_weight = (TYPEOF(h.xadl2_weight))'',0,100));
    maxlength_xadl2_weight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_weight)));
    avelength_xadl2_weight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_weight)),h.xadl2_weight<>(typeof(h.xadl2_weight))'');
    populated_xadl2_score_cnt := COUNT(GROUP,h.xadl2_score <> (TYPEOF(h.xadl2_score))'');
    populated_xadl2_score_pcnt := AVE(GROUP,IF(h.xadl2_score = (TYPEOF(h.xadl2_score))'',0,100));
    maxlength_xadl2_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_score)));
    avelength_xadl2_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_score)),h.xadl2_score<>(typeof(h.xadl2_score))'');
    populated_xadl2_keys_used_cnt := COUNT(GROUP,h.xadl2_keys_used <> (TYPEOF(h.xadl2_keys_used))'');
    populated_xadl2_keys_used_pcnt := AVE(GROUP,IF(h.xadl2_keys_used = (TYPEOF(h.xadl2_keys_used))'',0,100));
    maxlength_xadl2_keys_used := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_keys_used)));
    avelength_xadl2_keys_used := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_keys_used)),h.xadl2_keys_used<>(typeof(h.xadl2_keys_used))'');
    populated_xadl2_distance_cnt := COUNT(GROUP,h.xadl2_distance <> (TYPEOF(h.xadl2_distance))'');
    populated_xadl2_distance_pcnt := AVE(GROUP,IF(h.xadl2_distance = (TYPEOF(h.xadl2_distance))'',0,100));
    maxlength_xadl2_distance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_distance)));
    avelength_xadl2_distance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_distance)),h.xadl2_distance<>(typeof(h.xadl2_distance))'');
    populated_xadl2_matches_cnt := COUNT(GROUP,h.xadl2_matches <> (TYPEOF(h.xadl2_matches))'');
    populated_xadl2_matches_pcnt := AVE(GROUP,IF(h.xadl2_matches = (TYPEOF(h.xadl2_matches))'',0,100));
    maxlength_xadl2_matches := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_matches)));
    avelength_xadl2_matches := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_matches)),h.xadl2_matches<>(typeof(h.xadl2_matches))'');
    populated_append_prep_address_1_cnt := COUNT(GROUP,h.append_prep_address_1 <> (TYPEOF(h.append_prep_address_1))'');
    populated_append_prep_address_1_pcnt := AVE(GROUP,IF(h.append_prep_address_1 = (TYPEOF(h.append_prep_address_1))'',0,100));
    maxlength_append_prep_address_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_1)));
    avelength_append_prep_address_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_1)),h.append_prep_address_1<>(typeof(h.append_prep_address_1))'');
    populated_append_prep_address_2_cnt := COUNT(GROUP,h.append_prep_address_2 <> (TYPEOF(h.append_prep_address_2))'');
    populated_append_prep_address_2_pcnt := AVE(GROUP,IF(h.append_prep_address_2 = (TYPEOF(h.append_prep_address_2))'',0,100));
    maxlength_append_prep_address_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_2)));
    avelength_append_prep_address_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_address_2)),h.append_prep_address_2<>(typeof(h.append_prep_address_2))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_cnt := COUNT(GROUP,h.aceaid <> (TYPEOF(h.aceaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_clean_address_prim_range_cnt := COUNT(GROUP,h.clean_address.prim_range <> (TYPEOF(h.clean_address.prim_range))'');
    populated_clean_address_prim_range_pcnt := AVE(GROUP,IF(h.clean_address.prim_range = (TYPEOF(h.clean_address.prim_range))'',0,100));
    maxlength_clean_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.prim_range)));
    avelength_clean_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.prim_range)),h.clean_address.prim_range<>(typeof(h.clean_address.prim_range))'');
    populated_clean_address_predir_cnt := COUNT(GROUP,h.clean_address.predir <> (TYPEOF(h.clean_address.predir))'');
    populated_clean_address_predir_pcnt := AVE(GROUP,IF(h.clean_address.predir = (TYPEOF(h.clean_address.predir))'',0,100));
    maxlength_clean_address_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.predir)));
    avelength_clean_address_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.predir)),h.clean_address.predir<>(typeof(h.clean_address.predir))'');
    populated_clean_address_prim_name_cnt := COUNT(GROUP,h.clean_address.prim_name <> (TYPEOF(h.clean_address.prim_name))'');
    populated_clean_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_address.prim_name = (TYPEOF(h.clean_address.prim_name))'',0,100));
    maxlength_clean_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.prim_name)));
    avelength_clean_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.prim_name)),h.clean_address.prim_name<>(typeof(h.clean_address.prim_name))'');
    populated_clean_address_addr_suffix_cnt := COUNT(GROUP,h.clean_address.addr_suffix <> (TYPEOF(h.clean_address.addr_suffix))'');
    populated_clean_address_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_address.addr_suffix = (TYPEOF(h.clean_address.addr_suffix))'',0,100));
    maxlength_clean_address_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.addr_suffix)));
    avelength_clean_address_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.addr_suffix)),h.clean_address.addr_suffix<>(typeof(h.clean_address.addr_suffix))'');
    populated_clean_address_postdir_cnt := COUNT(GROUP,h.clean_address.postdir <> (TYPEOF(h.clean_address.postdir))'');
    populated_clean_address_postdir_pcnt := AVE(GROUP,IF(h.clean_address.postdir = (TYPEOF(h.clean_address.postdir))'',0,100));
    maxlength_clean_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.postdir)));
    avelength_clean_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.postdir)),h.clean_address.postdir<>(typeof(h.clean_address.postdir))'');
    populated_clean_address_unit_desig_cnt := COUNT(GROUP,h.clean_address.unit_desig <> (TYPEOF(h.clean_address.unit_desig))'');
    populated_clean_address_unit_desig_pcnt := AVE(GROUP,IF(h.clean_address.unit_desig = (TYPEOF(h.clean_address.unit_desig))'',0,100));
    maxlength_clean_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.unit_desig)));
    avelength_clean_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.unit_desig)),h.clean_address.unit_desig<>(typeof(h.clean_address.unit_desig))'');
    populated_clean_address_sec_range_cnt := COUNT(GROUP,h.clean_address.sec_range <> (TYPEOF(h.clean_address.sec_range))'');
    populated_clean_address_sec_range_pcnt := AVE(GROUP,IF(h.clean_address.sec_range = (TYPEOF(h.clean_address.sec_range))'',0,100));
    maxlength_clean_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.sec_range)));
    avelength_clean_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.sec_range)),h.clean_address.sec_range<>(typeof(h.clean_address.sec_range))'');
    populated_clean_address_p_city_name_cnt := COUNT(GROUP,h.clean_address.p_city_name <> (TYPEOF(h.clean_address.p_city_name))'');
    populated_clean_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_address.p_city_name = (TYPEOF(h.clean_address.p_city_name))'',0,100));
    maxlength_clean_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.p_city_name)));
    avelength_clean_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.p_city_name)),h.clean_address.p_city_name<>(typeof(h.clean_address.p_city_name))'');
    populated_clean_address_v_city_name_cnt := COUNT(GROUP,h.clean_address.v_city_name <> (TYPEOF(h.clean_address.v_city_name))'');
    populated_clean_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_address.v_city_name = (TYPEOF(h.clean_address.v_city_name))'',0,100));
    maxlength_clean_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.v_city_name)));
    avelength_clean_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.v_city_name)),h.clean_address.v_city_name<>(typeof(h.clean_address.v_city_name))'');
    populated_clean_address_st_cnt := COUNT(GROUP,h.clean_address.st <> (TYPEOF(h.clean_address.st))'');
    populated_clean_address_st_pcnt := AVE(GROUP,IF(h.clean_address.st = (TYPEOF(h.clean_address.st))'',0,100));
    maxlength_clean_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.st)));
    avelength_clean_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.st)),h.clean_address.st<>(typeof(h.clean_address.st))'');
    populated_clean_address_zip_cnt := COUNT(GROUP,h.clean_address.zip <> (TYPEOF(h.clean_address.zip))'');
    populated_clean_address_zip_pcnt := AVE(GROUP,IF(h.clean_address.zip = (TYPEOF(h.clean_address.zip))'',0,100));
    maxlength_clean_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.zip)));
    avelength_clean_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.zip)),h.clean_address.zip<>(typeof(h.clean_address.zip))'');
    populated_clean_address_zip4_cnt := COUNT(GROUP,h.clean_address.zip4 <> (TYPEOF(h.clean_address.zip4))'');
    populated_clean_address_zip4_pcnt := AVE(GROUP,IF(h.clean_address.zip4 = (TYPEOF(h.clean_address.zip4))'',0,100));
    maxlength_clean_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.zip4)));
    avelength_clean_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.zip4)),h.clean_address.zip4<>(typeof(h.clean_address.zip4))'');
    populated_clean_address_cart_cnt := COUNT(GROUP,h.clean_address.cart <> (TYPEOF(h.clean_address.cart))'');
    populated_clean_address_cart_pcnt := AVE(GROUP,IF(h.clean_address.cart = (TYPEOF(h.clean_address.cart))'',0,100));
    maxlength_clean_address_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.cart)));
    avelength_clean_address_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.cart)),h.clean_address.cart<>(typeof(h.clean_address.cart))'');
    populated_clean_address_cr_sort_sz_cnt := COUNT(GROUP,h.clean_address.cr_sort_sz <> (TYPEOF(h.clean_address.cr_sort_sz))'');
    populated_clean_address_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_address.cr_sort_sz = (TYPEOF(h.clean_address.cr_sort_sz))'',0,100));
    maxlength_clean_address_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.cr_sort_sz)));
    avelength_clean_address_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.cr_sort_sz)),h.clean_address.cr_sort_sz<>(typeof(h.clean_address.cr_sort_sz))'');
    populated_clean_address_lot_cnt := COUNT(GROUP,h.clean_address.lot <> (TYPEOF(h.clean_address.lot))'');
    populated_clean_address_lot_pcnt := AVE(GROUP,IF(h.clean_address.lot = (TYPEOF(h.clean_address.lot))'',0,100));
    maxlength_clean_address_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.lot)));
    avelength_clean_address_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.lot)),h.clean_address.lot<>(typeof(h.clean_address.lot))'');
    populated_clean_address_lot_order_cnt := COUNT(GROUP,h.clean_address.lot_order <> (TYPEOF(h.clean_address.lot_order))'');
    populated_clean_address_lot_order_pcnt := AVE(GROUP,IF(h.clean_address.lot_order = (TYPEOF(h.clean_address.lot_order))'',0,100));
    maxlength_clean_address_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.lot_order)));
    avelength_clean_address_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.lot_order)),h.clean_address.lot_order<>(typeof(h.clean_address.lot_order))'');
    populated_clean_address_dbpc_cnt := COUNT(GROUP,h.clean_address.dbpc <> (TYPEOF(h.clean_address.dbpc))'');
    populated_clean_address_dbpc_pcnt := AVE(GROUP,IF(h.clean_address.dbpc = (TYPEOF(h.clean_address.dbpc))'',0,100));
    maxlength_clean_address_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.dbpc)));
    avelength_clean_address_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.dbpc)),h.clean_address.dbpc<>(typeof(h.clean_address.dbpc))'');
    populated_clean_address_chk_digit_cnt := COUNT(GROUP,h.clean_address.chk_digit <> (TYPEOF(h.clean_address.chk_digit))'');
    populated_clean_address_chk_digit_pcnt := AVE(GROUP,IF(h.clean_address.chk_digit = (TYPEOF(h.clean_address.chk_digit))'',0,100));
    maxlength_clean_address_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.chk_digit)));
    avelength_clean_address_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.chk_digit)),h.clean_address.chk_digit<>(typeof(h.clean_address.chk_digit))'');
    populated_clean_address_rec_type_cnt := COUNT(GROUP,h.clean_address.rec_type <> (TYPEOF(h.clean_address.rec_type))'');
    populated_clean_address_rec_type_pcnt := AVE(GROUP,IF(h.clean_address.rec_type = (TYPEOF(h.clean_address.rec_type))'',0,100));
    maxlength_clean_address_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.rec_type)));
    avelength_clean_address_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.rec_type)),h.clean_address.rec_type<>(typeof(h.clean_address.rec_type))'');
    populated_clean_address_county_cnt := COUNT(GROUP,h.clean_address.county <> (TYPEOF(h.clean_address.county))'');
    populated_clean_address_county_pcnt := AVE(GROUP,IF(h.clean_address.county = (TYPEOF(h.clean_address.county))'',0,100));
    maxlength_clean_address_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.county)));
    avelength_clean_address_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.county)),h.clean_address.county<>(typeof(h.clean_address.county))'');
    populated_clean_address_geo_lat_cnt := COUNT(GROUP,h.clean_address.geo_lat <> (TYPEOF(h.clean_address.geo_lat))'');
    populated_clean_address_geo_lat_pcnt := AVE(GROUP,IF(h.clean_address.geo_lat = (TYPEOF(h.clean_address.geo_lat))'',0,100));
    maxlength_clean_address_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_lat)));
    avelength_clean_address_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_lat)),h.clean_address.geo_lat<>(typeof(h.clean_address.geo_lat))'');
    populated_clean_address_geo_long_cnt := COUNT(GROUP,h.clean_address.geo_long <> (TYPEOF(h.clean_address.geo_long))'');
    populated_clean_address_geo_long_pcnt := AVE(GROUP,IF(h.clean_address.geo_long = (TYPEOF(h.clean_address.geo_long))'',0,100));
    maxlength_clean_address_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_long)));
    avelength_clean_address_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_long)),h.clean_address.geo_long<>(typeof(h.clean_address.geo_long))'');
    populated_clean_address_msa_cnt := COUNT(GROUP,h.clean_address.msa <> (TYPEOF(h.clean_address.msa))'');
    populated_clean_address_msa_pcnt := AVE(GROUP,IF(h.clean_address.msa = (TYPEOF(h.clean_address.msa))'',0,100));
    maxlength_clean_address_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.msa)));
    avelength_clean_address_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.msa)),h.clean_address.msa<>(typeof(h.clean_address.msa))'');
    populated_clean_address_geo_blk_cnt := COUNT(GROUP,h.clean_address.geo_blk <> (TYPEOF(h.clean_address.geo_blk))'');
    populated_clean_address_geo_blk_pcnt := AVE(GROUP,IF(h.clean_address.geo_blk = (TYPEOF(h.clean_address.geo_blk))'',0,100));
    maxlength_clean_address_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_blk)));
    avelength_clean_address_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_blk)),h.clean_address.geo_blk<>(typeof(h.clean_address.geo_blk))'');
    populated_clean_address_geo_match_cnt := COUNT(GROUP,h.clean_address.geo_match <> (TYPEOF(h.clean_address.geo_match))'');
    populated_clean_address_geo_match_pcnt := AVE(GROUP,IF(h.clean_address.geo_match = (TYPEOF(h.clean_address.geo_match))'',0,100));
    maxlength_clean_address_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_match)));
    avelength_clean_address_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.geo_match)),h.clean_address.geo_match<>(typeof(h.clean_address.geo_match))'');
    populated_clean_address_err_stat_cnt := COUNT(GROUP,h.clean_address.err_stat <> (TYPEOF(h.clean_address.err_stat))'');
    populated_clean_address_err_stat_pcnt := AVE(GROUP,IF(h.clean_address.err_stat = (TYPEOF(h.clean_address.err_stat))'',0,100));
    maxlength_clean_address_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.err_stat)));
    avelength_clean_address_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address.err_stat)),h.clean_address.err_stat<>(typeof(h.clean_address.err_stat))'');
    populated_append_prep_name_cnt := COUNT(GROUP,h.append_prep_name <> (TYPEOF(h.append_prep_name))'');
    populated_append_prep_name_pcnt := AVE(GROUP,IF(h.append_prep_name = (TYPEOF(h.append_prep_name))'',0,100));
    maxlength_append_prep_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_name)));
    avelength_append_prep_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_name)),h.append_prep_name<>(typeof(h.append_prep_name))'');
    populated_nid_cnt := COUNT(GROUP,h.nid <> (TYPEOF(h.nid))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_name_ind_cnt := COUNT(GROUP,h.name_ind <> (TYPEOF(h.name_ind))'');
    populated_name_ind_pcnt := AVE(GROUP,IF(h.name_ind = (TYPEOF(h.name_ind))'',0,100));
    maxlength_name_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_ind)));
    avelength_name_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_ind)),h.name_ind<>(typeof(h.name_ind))'');
    populated_nametype_cnt := COUNT(GROUP,h.nametype <> (TYPEOF(h.nametype))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_cln_title_cnt := COUNT(GROUP,h.cln_title <> (TYPEOF(h.cln_title))'');
    populated_cln_title_pcnt := AVE(GROUP,IF(h.cln_title = (TYPEOF(h.cln_title))'',0,100));
    maxlength_cln_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_title)));
    avelength_cln_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_title)),h.cln_title<>(typeof(h.cln_title))'');
    populated_cln_fname_cnt := COUNT(GROUP,h.cln_fname <> (TYPEOF(h.cln_fname))'');
    populated_cln_fname_pcnt := AVE(GROUP,IF(h.cln_fname = (TYPEOF(h.cln_fname))'',0,100));
    maxlength_cln_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_fname)));
    avelength_cln_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_fname)),h.cln_fname<>(typeof(h.cln_fname))'');
    populated_cln_mname_cnt := COUNT(GROUP,h.cln_mname <> (TYPEOF(h.cln_mname))'');
    populated_cln_mname_pcnt := AVE(GROUP,IF(h.cln_mname = (TYPEOF(h.cln_mname))'',0,100));
    maxlength_cln_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_mname)));
    avelength_cln_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_mname)),h.cln_mname<>(typeof(h.cln_mname))'');
    populated_cln_lname_cnt := COUNT(GROUP,h.cln_lname <> (TYPEOF(h.cln_lname))'');
    populated_cln_lname_pcnt := AVE(GROUP,IF(h.cln_lname = (TYPEOF(h.cln_lname))'',0,100));
    maxlength_cln_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_lname)));
    avelength_cln_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_lname)),h.cln_lname<>(typeof(h.cln_lname))'');
    populated_cln_suffix_cnt := COUNT(GROUP,h.cln_suffix <> (TYPEOF(h.cln_suffix))'');
    populated_cln_suffix_pcnt := AVE(GROUP,IF(h.cln_suffix = (TYPEOF(h.cln_suffix))'',0,100));
    maxlength_cln_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_suffix)));
    avelength_cln_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_suffix)),h.cln_suffix<>(typeof(h.cln_suffix))'');
    populated_cln_fullname_cnt := COUNT(GROUP,h.cln_fullname <> (TYPEOF(h.cln_fullname))'');
    populated_cln_fullname_pcnt := AVE(GROUP,IF(h.cln_fullname = (TYPEOF(h.cln_fullname))'',0,100));
    maxlength_cln_fullname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_fullname)));
    avelength_cln_fullname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cln_fullname)),h.cln_fullname<>(typeof(h.cln_fullname))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_process_time_cnt := COUNT(GROUP,h.process_time <> (TYPEOF(h.process_time))'');
    populated_process_time_pcnt := AVE(GROUP,IF(h.process_time = (TYPEOF(h.process_time))'',0,100));
    maxlength_process_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_time)));
    avelength_process_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_time)),h.process_time<>(typeof(h.process_time))'');
    populated_date_vendor_first_reported_cnt := COUNT(GROUP,h.date_vendor_first_reported <> (TYPEOF(h.date_vendor_first_reported))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_cnt := COUNT(GROUP,h.date_vendor_last_reported <> (TYPEOF(h.date_vendor_last_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_current_rec_cnt := COUNT(GROUP,h.current_rec <> (TYPEOF(h.current_rec))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
    populated_ingest_tpe_cnt := COUNT(GROUP,h.ingest_tpe <> (TYPEOF(h.ingest_tpe))'');
    populated_ingest_tpe_pcnt := AVE(GROUP,IF(h.ingest_tpe = (TYPEOF(h.ingest_tpe))'',0,100));
    maxlength_ingest_tpe := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ingest_tpe)));
    avelength_ingest_tpe := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ingest_tpe)),h.ingest_tpe<>(typeof(h.ingest_tpe))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_salutation_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_house_pcnt *   0.00 / 100 + T.Populated_pre_dir_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_street_type_pcnt *   0.00 / 100 + T.Populated_post_dir_pcnt *   0.00 / 100 + T.Populated_apt_type_pcnt *   0.00 / 100 + T.Populated_apt_nbr_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_plus4_pcnt *   0.00 / 100 + T.Populated_dpc_pcnt *   0.00 / 100 + T.Populated_z4_type_pcnt *   0.00 / 100 + T.Populated_crte_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_dpvcmra_pcnt *   0.00 / 100 + T.Populated_dpvconf_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_census_tract_pcnt *   0.00 / 100 + T.Populated_census_block_group_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_match_code_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_verified_pcnt *   0.00 / 100 + T.Populated_activity_status_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100 + T.Populated_cord_cutter_pcnt *   0.00 / 100 + T.Populated_raw_file_name_pcnt *   0.00 / 100 + T.Populated_rcid_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_xadl2_weight_pcnt *   0.00 / 100 + T.Populated_xadl2_score_pcnt *   0.00 / 100 + T.Populated_xadl2_keys_used_pcnt *   0.00 / 100 + T.Populated_xadl2_distance_pcnt *   0.00 / 100 + T.Populated_xadl2_matches_pcnt *   0.00 / 100 + T.Populated_append_prep_address_1_pcnt *   0.00 / 100 + T.Populated_append_prep_address_2_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_aceaid_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_address_predir_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_address_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_address_postdir_pcnt *   0.00 / 100 + T.Populated_clean_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_address_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_st_pcnt *   0.00 / 100 + T.Populated_clean_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_address_zip4_pcnt *   0.00 / 100 + T.Populated_clean_address_cart_pcnt *   0.00 / 100 + T.Populated_clean_address_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_address_dbpc_pcnt *   0.00 / 100 + T.Populated_clean_address_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_address_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_address_county_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_address_msa_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_address_err_stat_pcnt *   0.00 / 100 + T.Populated_append_prep_name_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_name_ind_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_cln_title_pcnt *   0.00 / 100 + T.Populated_cln_fname_pcnt *   0.00 / 100 + T.Populated_cln_mname_pcnt *   0.00 / 100 + T.Populated_cln_lname_pcnt *   0.00 / 100 + T.Populated_cln_suffix_pcnt *   0.00 / 100 + T.Populated_cln_fullname_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_process_time_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_current_rec_pcnt *   0.00 / 100 + T.Populated_ingest_tpe_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'phone','fname','mname','lname','salutation','suffix','gender','dob','house','pre_dir','street','street_type','post_dir','apt_type','apt_nbr','zip','plus4','dpc','z4_type','crte','city','state','dpvcmra','dpvconf','fips_state','fips_county','census_tract','census_block_group','cbsa','match_code','latitude','longitude','email','verified','activity_status','prepaid','cord_cutter','raw_file_name','rcid','source','persistent_record_id','did','did_score','xadl2_weight','xadl2_score','xadl2_keys_used','xadl2_distance','xadl2_matches','append_prep_address_1','append_prep_address_2','rawaid','aceaid','clean_address.prim_range','clean_address.predir','clean_address.prim_name','clean_address.addr_suffix','clean_address.postdir','clean_address.unit_desig','clean_address.sec_range','clean_address.p_city_name','clean_address.v_city_name','clean_address.st','clean_address.zip','clean_address.zip4','clean_address.cart','clean_address.cr_sort_sz','clean_address.lot','clean_address.lot_order','clean_address.dbpc','clean_address.chk_digit','clean_address.rec_type','clean_address.county','clean_address.geo_lat','clean_address.geo_long','clean_address.msa','clean_address.geo_blk','clean_address.geo_match','clean_address.err_stat','append_prep_name','nid','name_ind','nametype','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_fullname','process_date','process_time','date_vendor_first_reported','date_vendor_last_reported','current_rec','ingest_tpe');
  SELF.populated_pcnt := CHOOSE(C,le.populated_phone_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_salutation_pcnt,le.populated_suffix_pcnt,le.populated_gender_pcnt,le.populated_dob_pcnt,le.populated_house_pcnt,le.populated_pre_dir_pcnt,le.populated_street_pcnt,le.populated_street_type_pcnt,le.populated_post_dir_pcnt,le.populated_apt_type_pcnt,le.populated_apt_nbr_pcnt,le.populated_zip_pcnt,le.populated_plus4_pcnt,le.populated_dpc_pcnt,le.populated_z4_type_pcnt,le.populated_crte_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_dpvcmra_pcnt,le.populated_dpvconf_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_census_tract_pcnt,le.populated_census_block_group_pcnt,le.populated_cbsa_pcnt,le.populated_match_code_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_email_pcnt,le.populated_verified_pcnt,le.populated_activity_status_pcnt,le.populated_prepaid_pcnt,le.populated_cord_cutter_pcnt,le.populated_raw_file_name_pcnt,le.populated_rcid_pcnt,le.populated_source_pcnt,le.populated_persistent_record_id_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_xadl2_weight_pcnt,le.populated_xadl2_score_pcnt,le.populated_xadl2_keys_used_pcnt,le.populated_xadl2_distance_pcnt,le.populated_xadl2_matches_pcnt,le.populated_append_prep_address_1_pcnt,le.populated_append_prep_address_2_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_clean_address_prim_range_pcnt,le.populated_clean_address_predir_pcnt,le.populated_clean_address_prim_name_pcnt,le.populated_clean_address_addr_suffix_pcnt,le.populated_clean_address_postdir_pcnt,le.populated_clean_address_unit_desig_pcnt,le.populated_clean_address_sec_range_pcnt,le.populated_clean_address_p_city_name_pcnt,le.populated_clean_address_v_city_name_pcnt,le.populated_clean_address_st_pcnt,le.populated_clean_address_zip_pcnt,le.populated_clean_address_zip4_pcnt,le.populated_clean_address_cart_pcnt,le.populated_clean_address_cr_sort_sz_pcnt,le.populated_clean_address_lot_pcnt,le.populated_clean_address_lot_order_pcnt,le.populated_clean_address_dbpc_pcnt,le.populated_clean_address_chk_digit_pcnt,le.populated_clean_address_rec_type_pcnt,le.populated_clean_address_county_pcnt,le.populated_clean_address_geo_lat_pcnt,le.populated_clean_address_geo_long_pcnt,le.populated_clean_address_msa_pcnt,le.populated_clean_address_geo_blk_pcnt,le.populated_clean_address_geo_match_pcnt,le.populated_clean_address_err_stat_pcnt,le.populated_append_prep_name_pcnt,le.populated_nid_pcnt,le.populated_name_ind_pcnt,le.populated_nametype_pcnt,le.populated_cln_title_pcnt,le.populated_cln_fname_pcnt,le.populated_cln_mname_pcnt,le.populated_cln_lname_pcnt,le.populated_cln_suffix_pcnt,le.populated_cln_fullname_pcnt,le.populated_process_date_pcnt,le.populated_process_time_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_current_rec_pcnt,le.populated_ingest_tpe_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_phone,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_salutation,le.maxlength_suffix,le.maxlength_gender,le.maxlength_dob,le.maxlength_house,le.maxlength_pre_dir,le.maxlength_street,le.maxlength_street_type,le.maxlength_post_dir,le.maxlength_apt_type,le.maxlength_apt_nbr,le.maxlength_zip,le.maxlength_plus4,le.maxlength_dpc,le.maxlength_z4_type,le.maxlength_crte,le.maxlength_city,le.maxlength_state,le.maxlength_dpvcmra,le.maxlength_dpvconf,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_census_tract,le.maxlength_census_block_group,le.maxlength_cbsa,le.maxlength_match_code,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_email,le.maxlength_verified,le.maxlength_activity_status,le.maxlength_prepaid,le.maxlength_cord_cutter,le.maxlength_raw_file_name,le.maxlength_rcid,le.maxlength_source,le.maxlength_persistent_record_id,le.maxlength_did,le.maxlength_did_score,le.maxlength_xadl2_weight,le.maxlength_xadl2_score,le.maxlength_xadl2_keys_used,le.maxlength_xadl2_distance,le.maxlength_xadl2_matches,le.maxlength_append_prep_address_1,le.maxlength_append_prep_address_2,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_clean_address_prim_range,le.maxlength_clean_address_predir,le.maxlength_clean_address_prim_name,le.maxlength_clean_address_addr_suffix,le.maxlength_clean_address_postdir,le.maxlength_clean_address_unit_desig,le.maxlength_clean_address_sec_range,le.maxlength_clean_address_p_city_name,le.maxlength_clean_address_v_city_name,le.maxlength_clean_address_st,le.maxlength_clean_address_zip,le.maxlength_clean_address_zip4,le.maxlength_clean_address_cart,le.maxlength_clean_address_cr_sort_sz,le.maxlength_clean_address_lot,le.maxlength_clean_address_lot_order,le.maxlength_clean_address_dbpc,le.maxlength_clean_address_chk_digit,le.maxlength_clean_address_rec_type,le.maxlength_clean_address_county,le.maxlength_clean_address_geo_lat,le.maxlength_clean_address_geo_long,le.maxlength_clean_address_msa,le.maxlength_clean_address_geo_blk,le.maxlength_clean_address_geo_match,le.maxlength_clean_address_err_stat,le.maxlength_append_prep_name,le.maxlength_nid,le.maxlength_name_ind,le.maxlength_nametype,le.maxlength_cln_title,le.maxlength_cln_fname,le.maxlength_cln_mname,le.maxlength_cln_lname,le.maxlength_cln_suffix,le.maxlength_cln_fullname,le.maxlength_process_date,le.maxlength_process_time,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_current_rec,le.maxlength_ingest_tpe);
  SELF.avelength := CHOOSE(C,le.avelength_phone,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_salutation,le.avelength_suffix,le.avelength_gender,le.avelength_dob,le.avelength_house,le.avelength_pre_dir,le.avelength_street,le.avelength_street_type,le.avelength_post_dir,le.avelength_apt_type,le.avelength_apt_nbr,le.avelength_zip,le.avelength_plus4,le.avelength_dpc,le.avelength_z4_type,le.avelength_crte,le.avelength_city,le.avelength_state,le.avelength_dpvcmra,le.avelength_dpvconf,le.avelength_fips_state,le.avelength_fips_county,le.avelength_census_tract,le.avelength_census_block_group,le.avelength_cbsa,le.avelength_match_code,le.avelength_latitude,le.avelength_longitude,le.avelength_email,le.avelength_verified,le.avelength_activity_status,le.avelength_prepaid,le.avelength_cord_cutter,le.avelength_raw_file_name,le.avelength_rcid,le.avelength_source,le.avelength_persistent_record_id,le.avelength_did,le.avelength_did_score,le.avelength_xadl2_weight,le.avelength_xadl2_score,le.avelength_xadl2_keys_used,le.avelength_xadl2_distance,le.avelength_xadl2_matches,le.avelength_append_prep_address_1,le.avelength_append_prep_address_2,le.avelength_rawaid,le.avelength_aceaid,le.avelength_clean_address_prim_range,le.avelength_clean_address_predir,le.avelength_clean_address_prim_name,le.avelength_clean_address_addr_suffix,le.avelength_clean_address_postdir,le.avelength_clean_address_unit_desig,le.avelength_clean_address_sec_range,le.avelength_clean_address_p_city_name,le.avelength_clean_address_v_city_name,le.avelength_clean_address_st,le.avelength_clean_address_zip,le.avelength_clean_address_zip4,le.avelength_clean_address_cart,le.avelength_clean_address_cr_sort_sz,le.avelength_clean_address_lot,le.avelength_clean_address_lot_order,le.avelength_clean_address_dbpc,le.avelength_clean_address_chk_digit,le.avelength_clean_address_rec_type,le.avelength_clean_address_county,le.avelength_clean_address_geo_lat,le.avelength_clean_address_geo_long,le.avelength_clean_address_msa,le.avelength_clean_address_geo_blk,le.avelength_clean_address_geo_match,le.avelength_clean_address_err_stat,le.avelength_append_prep_name,le.avelength_nid,le.avelength_name_ind,le.avelength_nametype,le.avelength_cln_title,le.avelength_cln_fname,le.avelength_cln_mname,le.avelength_cln_lname,le.avelength_cln_suffix,le.avelength_cln_fullname,le.avelength_process_date,le.avelength_process_time,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_current_rec,le.avelength_ingest_tpe);
END;
EXPORT invSummary := NORMALIZE(summary0, 94, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.salutation),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.pre_dir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.street_type),TRIM((SALT311.StrType)le.post_dir),TRIM((SALT311.StrType)le.apt_type),TRIM((SALT311.StrType)le.apt_nbr),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.plus4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.z4_type),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.dpvcmra),TRIM((SALT311.StrType)le.dpvconf),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.census_block_group),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.match_code),IF (le.latitude <> 0,TRIM((SALT311.StrType)le.latitude), ''),IF (le.longitude <> 0,TRIM((SALT311.StrType)le.longitude), ''),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.cord_cutter),TRIM((SALT311.StrType)le.raw_file_name),IF (le.rcid <> 0,TRIM((SALT311.StrType)le.rcid), ''),TRIM((SALT311.StrType)le.source),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.xadl2_weight <> 0,TRIM((SALT311.StrType)le.xadl2_weight), ''),IF (le.xadl2_score <> 0,TRIM((SALT311.StrType)le.xadl2_score), ''),IF (le.xadl2_keys_used <> 0,TRIM((SALT311.StrType)le.xadl2_keys_used), ''),IF (le.xadl2_distance <> 0,TRIM((SALT311.StrType)le.xadl2_distance), ''),TRIM((SALT311.StrType)le.xadl2_matches),TRIM((SALT311.StrType)le.append_prep_address_1),TRIM((SALT311.StrType)le.append_prep_address_2),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),TRIM((SALT311.StrType)le.clean_address.prim_range),TRIM((SALT311.StrType)le.clean_address.predir),TRIM((SALT311.StrType)le.clean_address.prim_name),TRIM((SALT311.StrType)le.clean_address.addr_suffix),TRIM((SALT311.StrType)le.clean_address.postdir),TRIM((SALT311.StrType)le.clean_address.unit_desig),TRIM((SALT311.StrType)le.clean_address.sec_range),TRIM((SALT311.StrType)le.clean_address.p_city_name),TRIM((SALT311.StrType)le.clean_address.v_city_name),TRIM((SALT311.StrType)le.clean_address.st),TRIM((SALT311.StrType)le.clean_address.zip),TRIM((SALT311.StrType)le.clean_address.zip4),TRIM((SALT311.StrType)le.clean_address.cart),TRIM((SALT311.StrType)le.clean_address.cr_sort_sz),TRIM((SALT311.StrType)le.clean_address.lot),TRIM((SALT311.StrType)le.clean_address.lot_order),TRIM((SALT311.StrType)le.clean_address.dbpc),TRIM((SALT311.StrType)le.clean_address.chk_digit),TRIM((SALT311.StrType)le.clean_address.rec_type),TRIM((SALT311.StrType)le.clean_address.county),TRIM((SALT311.StrType)le.clean_address.geo_lat),TRIM((SALT311.StrType)le.clean_address.geo_long),TRIM((SALT311.StrType)le.clean_address.msa),TRIM((SALT311.StrType)le.clean_address.geo_blk),TRIM((SALT311.StrType)le.clean_address.geo_match),TRIM((SALT311.StrType)le.clean_address.err_stat),TRIM((SALT311.StrType)le.append_prep_name),IF (le.nid <> 0,TRIM((SALT311.StrType)le.nid), ''),IF (le.name_ind <> 0,TRIM((SALT311.StrType)le.name_ind), ''),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.cln_title),TRIM((SALT311.StrType)le.cln_fname),TRIM((SALT311.StrType)le.cln_mname),TRIM((SALT311.StrType)le.cln_lname),TRIM((SALT311.StrType)le.cln_suffix),TRIM((SALT311.StrType)le.cln_fullname),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),IF (le.process_time <> 0,TRIM((SALT311.StrType)le.process_time), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),TRIM((SALT311.StrType)le.current_rec),IF (le.ingest_tpe <> 0,TRIM((SALT311.StrType)le.ingest_tpe), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,94,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 94);
  SELF.FldNo2 := 1 + (C % 94);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.salutation),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.pre_dir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.street_type),TRIM((SALT311.StrType)le.post_dir),TRIM((SALT311.StrType)le.apt_type),TRIM((SALT311.StrType)le.apt_nbr),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.plus4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.z4_type),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.dpvcmra),TRIM((SALT311.StrType)le.dpvconf),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.census_block_group),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.match_code),IF (le.latitude <> 0,TRIM((SALT311.StrType)le.latitude), ''),IF (le.longitude <> 0,TRIM((SALT311.StrType)le.longitude), ''),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.cord_cutter),TRIM((SALT311.StrType)le.raw_file_name),IF (le.rcid <> 0,TRIM((SALT311.StrType)le.rcid), ''),TRIM((SALT311.StrType)le.source),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.xadl2_weight <> 0,TRIM((SALT311.StrType)le.xadl2_weight), ''),IF (le.xadl2_score <> 0,TRIM((SALT311.StrType)le.xadl2_score), ''),IF (le.xadl2_keys_used <> 0,TRIM((SALT311.StrType)le.xadl2_keys_used), ''),IF (le.xadl2_distance <> 0,TRIM((SALT311.StrType)le.xadl2_distance), ''),TRIM((SALT311.StrType)le.xadl2_matches),TRIM((SALT311.StrType)le.append_prep_address_1),TRIM((SALT311.StrType)le.append_prep_address_2),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),TRIM((SALT311.StrType)le.clean_address.prim_range),TRIM((SALT311.StrType)le.clean_address.predir),TRIM((SALT311.StrType)le.clean_address.prim_name),TRIM((SALT311.StrType)le.clean_address.addr_suffix),TRIM((SALT311.StrType)le.clean_address.postdir),TRIM((SALT311.StrType)le.clean_address.unit_desig),TRIM((SALT311.StrType)le.clean_address.sec_range),TRIM((SALT311.StrType)le.clean_address.p_city_name),TRIM((SALT311.StrType)le.clean_address.v_city_name),TRIM((SALT311.StrType)le.clean_address.st),TRIM((SALT311.StrType)le.clean_address.zip),TRIM((SALT311.StrType)le.clean_address.zip4),TRIM((SALT311.StrType)le.clean_address.cart),TRIM((SALT311.StrType)le.clean_address.cr_sort_sz),TRIM((SALT311.StrType)le.clean_address.lot),TRIM((SALT311.StrType)le.clean_address.lot_order),TRIM((SALT311.StrType)le.clean_address.dbpc),TRIM((SALT311.StrType)le.clean_address.chk_digit),TRIM((SALT311.StrType)le.clean_address.rec_type),TRIM((SALT311.StrType)le.clean_address.county),TRIM((SALT311.StrType)le.clean_address.geo_lat),TRIM((SALT311.StrType)le.clean_address.geo_long),TRIM((SALT311.StrType)le.clean_address.msa),TRIM((SALT311.StrType)le.clean_address.geo_blk),TRIM((SALT311.StrType)le.clean_address.geo_match),TRIM((SALT311.StrType)le.clean_address.err_stat),TRIM((SALT311.StrType)le.append_prep_name),IF (le.nid <> 0,TRIM((SALT311.StrType)le.nid), ''),IF (le.name_ind <> 0,TRIM((SALT311.StrType)le.name_ind), ''),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.cln_title),TRIM((SALT311.StrType)le.cln_fname),TRIM((SALT311.StrType)le.cln_mname),TRIM((SALT311.StrType)le.cln_lname),TRIM((SALT311.StrType)le.cln_suffix),TRIM((SALT311.StrType)le.cln_fullname),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),IF (le.process_time <> 0,TRIM((SALT311.StrType)le.process_time), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),TRIM((SALT311.StrType)le.current_rec),IF (le.ingest_tpe <> 0,TRIM((SALT311.StrType)le.ingest_tpe), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.salutation),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.pre_dir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.street_type),TRIM((SALT311.StrType)le.post_dir),TRIM((SALT311.StrType)le.apt_type),TRIM((SALT311.StrType)le.apt_nbr),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.plus4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.z4_type),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.dpvcmra),TRIM((SALT311.StrType)le.dpvconf),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.census_block_group),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.match_code),IF (le.latitude <> 0,TRIM((SALT311.StrType)le.latitude), ''),IF (le.longitude <> 0,TRIM((SALT311.StrType)le.longitude), ''),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.cord_cutter),TRIM((SALT311.StrType)le.raw_file_name),IF (le.rcid <> 0,TRIM((SALT311.StrType)le.rcid), ''),TRIM((SALT311.StrType)le.source),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),IF (le.xadl2_weight <> 0,TRIM((SALT311.StrType)le.xadl2_weight), ''),IF (le.xadl2_score <> 0,TRIM((SALT311.StrType)le.xadl2_score), ''),IF (le.xadl2_keys_used <> 0,TRIM((SALT311.StrType)le.xadl2_keys_used), ''),IF (le.xadl2_distance <> 0,TRIM((SALT311.StrType)le.xadl2_distance), ''),TRIM((SALT311.StrType)le.xadl2_matches),TRIM((SALT311.StrType)le.append_prep_address_1),TRIM((SALT311.StrType)le.append_prep_address_2),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),TRIM((SALT311.StrType)le.clean_address.prim_range),TRIM((SALT311.StrType)le.clean_address.predir),TRIM((SALT311.StrType)le.clean_address.prim_name),TRIM((SALT311.StrType)le.clean_address.addr_suffix),TRIM((SALT311.StrType)le.clean_address.postdir),TRIM((SALT311.StrType)le.clean_address.unit_desig),TRIM((SALT311.StrType)le.clean_address.sec_range),TRIM((SALT311.StrType)le.clean_address.p_city_name),TRIM((SALT311.StrType)le.clean_address.v_city_name),TRIM((SALT311.StrType)le.clean_address.st),TRIM((SALT311.StrType)le.clean_address.zip),TRIM((SALT311.StrType)le.clean_address.zip4),TRIM((SALT311.StrType)le.clean_address.cart),TRIM((SALT311.StrType)le.clean_address.cr_sort_sz),TRIM((SALT311.StrType)le.clean_address.lot),TRIM((SALT311.StrType)le.clean_address.lot_order),TRIM((SALT311.StrType)le.clean_address.dbpc),TRIM((SALT311.StrType)le.clean_address.chk_digit),TRIM((SALT311.StrType)le.clean_address.rec_type),TRIM((SALT311.StrType)le.clean_address.county),TRIM((SALT311.StrType)le.clean_address.geo_lat),TRIM((SALT311.StrType)le.clean_address.geo_long),TRIM((SALT311.StrType)le.clean_address.msa),TRIM((SALT311.StrType)le.clean_address.geo_blk),TRIM((SALT311.StrType)le.clean_address.geo_match),TRIM((SALT311.StrType)le.clean_address.err_stat),TRIM((SALT311.StrType)le.append_prep_name),IF (le.nid <> 0,TRIM((SALT311.StrType)le.nid), ''),IF (le.name_ind <> 0,TRIM((SALT311.StrType)le.name_ind), ''),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.cln_title),TRIM((SALT311.StrType)le.cln_fname),TRIM((SALT311.StrType)le.cln_mname),TRIM((SALT311.StrType)le.cln_lname),TRIM((SALT311.StrType)le.cln_suffix),TRIM((SALT311.StrType)le.cln_fullname),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),IF (le.process_time <> 0,TRIM((SALT311.StrType)le.process_time), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),TRIM((SALT311.StrType)le.current_rec),IF (le.ingest_tpe <> 0,TRIM((SALT311.StrType)le.ingest_tpe), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),94*94,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'phone'}
      ,{2,'fname'}
      ,{3,'mname'}
      ,{4,'lname'}
      ,{5,'salutation'}
      ,{6,'suffix'}
      ,{7,'gender'}
      ,{8,'dob'}
      ,{9,'house'}
      ,{10,'pre_dir'}
      ,{11,'street'}
      ,{12,'street_type'}
      ,{13,'post_dir'}
      ,{14,'apt_type'}
      ,{15,'apt_nbr'}
      ,{16,'zip'}
      ,{17,'plus4'}
      ,{18,'dpc'}
      ,{19,'z4_type'}
      ,{20,'crte'}
      ,{21,'city'}
      ,{22,'state'}
      ,{23,'dpvcmra'}
      ,{24,'dpvconf'}
      ,{25,'fips_state'}
      ,{26,'fips_county'}
      ,{27,'census_tract'}
      ,{28,'census_block_group'}
      ,{29,'cbsa'}
      ,{30,'match_code'}
      ,{31,'latitude'}
      ,{32,'longitude'}
      ,{33,'email'}
      ,{34,'verified'}
      ,{35,'activity_status'}
      ,{36,'prepaid'}
      ,{37,'cord_cutter'}
      ,{38,'raw_file_name'}
      ,{39,'rcid'}
      ,{40,'source'}
      ,{41,'persistent_record_id'}
      ,{42,'did'}
      ,{43,'did_score'}
      ,{44,'xadl2_weight'}
      ,{45,'xadl2_score'}
      ,{46,'xadl2_keys_used'}
      ,{47,'xadl2_distance'}
      ,{48,'xadl2_matches'}
      ,{49,'append_prep_address_1'}
      ,{50,'append_prep_address_2'}
      ,{51,'rawaid'}
      ,{52,'aceaid'}
      ,{53,'clean_address.prim_range'}
      ,{54,'clean_address.predir'}
      ,{55,'clean_address.prim_name'}
      ,{56,'clean_address.addr_suffix'}
      ,{57,'clean_address.postdir'}
      ,{58,'clean_address.unit_desig'}
      ,{59,'clean_address.sec_range'}
      ,{60,'clean_address.p_city_name'}
      ,{61,'clean_address.v_city_name'}
      ,{62,'clean_address.st'}
      ,{63,'clean_address.zip'}
      ,{64,'clean_address.zip4'}
      ,{65,'clean_address.cart'}
      ,{66,'clean_address.cr_sort_sz'}
      ,{67,'clean_address.lot'}
      ,{68,'clean_address.lot_order'}
      ,{69,'clean_address.dbpc'}
      ,{70,'clean_address.chk_digit'}
      ,{71,'clean_address.rec_type'}
      ,{72,'clean_address.county'}
      ,{73,'clean_address.geo_lat'}
      ,{74,'clean_address.geo_long'}
      ,{75,'clean_address.msa'}
      ,{76,'clean_address.geo_blk'}
      ,{77,'clean_address.geo_match'}
      ,{78,'clean_address.err_stat'}
      ,{79,'append_prep_name'}
      ,{80,'nid'}
      ,{81,'name_ind'}
      ,{82,'nametype'}
      ,{83,'cln_title'}
      ,{84,'cln_fname'}
      ,{85,'cln_mname'}
      ,{86,'cln_lname'}
      ,{87,'cln_suffix'}
      ,{88,'cln_fullname'}
      ,{89,'process_date'}
      ,{90,'process_time'}
      ,{91,'date_vendor_first_reported'}
      ,{92,'date_vendor_last_reported'}
      ,{93,'current_rec'}
      ,{94,'ingest_tpe'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_phone((SALT311.StrType)le.phone),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_salutation((SALT311.StrType)le.salutation),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_house((SALT311.StrType)le.house),
    Fields.InValid_pre_dir((SALT311.StrType)le.pre_dir),
    Fields.InValid_street((SALT311.StrType)le.street),
    Fields.InValid_street_type((SALT311.StrType)le.street_type),
    Fields.InValid_post_dir((SALT311.StrType)le.post_dir),
    Fields.InValid_apt_type((SALT311.StrType)le.apt_type),
    Fields.InValid_apt_nbr((SALT311.StrType)le.apt_nbr),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_plus4((SALT311.StrType)le.plus4),
    Fields.InValid_dpc((SALT311.StrType)le.dpc),
    Fields.InValid_z4_type((SALT311.StrType)le.z4_type),
    Fields.InValid_crte((SALT311.StrType)le.crte),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_dpvcmra((SALT311.StrType)le.dpvcmra),
    Fields.InValid_dpvconf((SALT311.StrType)le.dpvconf),
    Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Fields.InValid_census_tract((SALT311.StrType)le.census_tract),
    Fields.InValid_census_block_group((SALT311.StrType)le.census_block_group),
    Fields.InValid_cbsa((SALT311.StrType)le.cbsa),
    Fields.InValid_match_code((SALT311.StrType)le.match_code),
    Fields.InValid_latitude((SALT311.StrType)le.latitude),
    Fields.InValid_longitude((SALT311.StrType)le.longitude),
    Fields.InValid_email((SALT311.StrType)le.email),
    Fields.InValid_verified((SALT311.StrType)le.verified),
    Fields.InValid_activity_status((SALT311.StrType)le.activity_status),
    Fields.InValid_prepaid((SALT311.StrType)le.prepaid),
    Fields.InValid_cord_cutter((SALT311.StrType)le.cord_cutter),
    Fields.InValid_raw_file_name((SALT311.StrType)le.raw_file_name),
    Fields.InValid_rcid((SALT311.StrType)le.rcid),
    Fields.InValid_source((SALT311.StrType)le.source),
    Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_xadl2_weight((SALT311.StrType)le.xadl2_weight),
    Fields.InValid_xadl2_score((SALT311.StrType)le.xadl2_score),
    Fields.InValid_xadl2_keys_used((SALT311.StrType)le.xadl2_keys_used),
    Fields.InValid_xadl2_distance((SALT311.StrType)le.xadl2_distance),
    Fields.InValid_xadl2_matches((SALT311.StrType)le.xadl2_matches),
    Fields.InValid_append_prep_address_1((SALT311.StrType)le.append_prep_address_1),
    Fields.InValid_append_prep_address_2((SALT311.StrType)le.append_prep_address_2),
    Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Fields.InValid_aceaid((SALT311.StrType)le.aceaid),
    Fields.InValid_clean_address_prim_range((SALT311.StrType)le.clean_address.prim_range),
    Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address.predir),
    Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address.prim_name),
    Fields.InValid_clean_address_addr_suffix((SALT311.StrType)le.clean_address.addr_suffix),
    Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address.postdir),
    Fields.InValid_clean_address_unit_desig((SALT311.StrType)le.clean_address.unit_desig),
    Fields.InValid_clean_address_sec_range((SALT311.StrType)le.clean_address.sec_range),
    Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address.p_city_name),
    Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address.v_city_name),
    Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address.st),
    Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address.zip),
    Fields.InValid_clean_address_zip4((SALT311.StrType)le.clean_address.zip4),
    Fields.InValid_clean_address_cart((SALT311.StrType)le.clean_address.cart),
    Fields.InValid_clean_address_cr_sort_sz((SALT311.StrType)le.clean_address.cr_sort_sz),
    Fields.InValid_clean_address_lot((SALT311.StrType)le.clean_address.lot),
    Fields.InValid_clean_address_lot_order((SALT311.StrType)le.clean_address.lot_order),
    Fields.InValid_clean_address_dbpc((SALT311.StrType)le.clean_address.dbpc),
    Fields.InValid_clean_address_chk_digit((SALT311.StrType)le.clean_address.chk_digit),
    Fields.InValid_clean_address_rec_type((SALT311.StrType)le.clean_address.rec_type),
    Fields.InValid_clean_address_county((SALT311.StrType)le.clean_address.county),
    Fields.InValid_clean_address_geo_lat((SALT311.StrType)le.clean_address.geo_lat),
    Fields.InValid_clean_address_geo_long((SALT311.StrType)le.clean_address.geo_long),
    Fields.InValid_clean_address_msa((SALT311.StrType)le.clean_address.msa),
    Fields.InValid_clean_address_geo_blk((SALT311.StrType)le.clean_address.geo_blk),
    Fields.InValid_clean_address_geo_match((SALT311.StrType)le.clean_address.geo_match),
    Fields.InValid_clean_address_err_stat((SALT311.StrType)le.clean_address.err_stat),
    Fields.InValid_append_prep_name((SALT311.StrType)le.append_prep_name),
    Fields.InValid_nid((SALT311.StrType)le.nid),
    Fields.InValid_name_ind((SALT311.StrType)le.name_ind),
    Fields.InValid_nametype((SALT311.StrType)le.nametype),
    Fields.InValid_cln_title((SALT311.StrType)le.cln_title),
    Fields.InValid_cln_fname((SALT311.StrType)le.cln_fname),
    Fields.InValid_cln_mname((SALT311.StrType)le.cln_mname),
    Fields.InValid_cln_lname((SALT311.StrType)le.cln_lname),
    Fields.InValid_cln_suffix((SALT311.StrType)le.cln_suffix),
    Fields.InValid_cln_fullname((SALT311.StrType)le.cln_fullname),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_process_time((SALT311.StrType)le.process_time),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_current_rec((SALT311.StrType)le.current_rec),
    Fields.InValid_ingest_tpe((SALT311.StrType)le.ingest_tpe),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_salutation(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_house(TotalErrors.ErrorNum),Fields.InValidMessage_pre_dir(TotalErrors.ErrorNum),Fields.InValidMessage_street(TotalErrors.ErrorNum),Fields.InValidMessage_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_post_dir(TotalErrors.ErrorNum),Fields.InValidMessage_apt_type(TotalErrors.ErrorNum),Fields.InValidMessage_apt_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_plus4(TotalErrors.ErrorNum),Fields.InValidMessage_dpc(TotalErrors.ErrorNum),Fields.InValidMessage_z4_type(TotalErrors.ErrorNum),Fields.InValidMessage_crte(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_dpvcmra(TotalErrors.ErrorNum),Fields.InValidMessage_dpvconf(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_census_block_group(TotalErrors.ErrorNum),Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_match_code(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_verified(TotalErrors.ErrorNum),Fields.InValidMessage_activity_status(TotalErrors.ErrorNum),Fields.InValidMessage_prepaid(TotalErrors.ErrorNum),Fields.InValidMessage_cord_cutter(TotalErrors.ErrorNum),Fields.InValidMessage_raw_file_name(TotalErrors.ErrorNum),Fields.InValidMessage_rcid(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_xadl2_weight(TotalErrors.ErrorNum),Fields.InValidMessage_xadl2_score(TotalErrors.ErrorNum),Fields.InValidMessage_xadl2_keys_used(TotalErrors.ErrorNum),Fields.InValidMessage_xadl2_distance(TotalErrors.ErrorNum),Fields.InValidMessage_xadl2_matches(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_county(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_append_prep_name(TotalErrors.ErrorNum),Fields.InValidMessage_nid(TotalErrors.ErrorNum),Fields.InValidMessage_name_ind(TotalErrors.ErrorNum),Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Fields.InValidMessage_cln_title(TotalErrors.ErrorNum),Fields.InValidMessage_cln_fname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_mname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_lname(TotalErrors.ErrorNum),Fields.InValidMessage_cln_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cln_fullname(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_process_time(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec(TotalErrors.ErrorNum),Fields.InValidMessage_ingest_tpe(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(NeustarWireless, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
