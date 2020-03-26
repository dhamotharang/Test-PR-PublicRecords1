IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_NeustarWireless) h) := MODULE
 
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
    populated_filler1_cnt := COUNT(GROUP,h.filler1 <> (TYPEOF(h.filler1))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_filler2_cnt := COUNT(GROUP,h.filler2 <> (TYPEOF(h.filler2))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
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
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_salutation_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_house_pcnt *   0.00 / 100 + T.Populated_pre_dir_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_street_type_pcnt *   0.00 / 100 + T.Populated_post_dir_pcnt *   0.00 / 100 + T.Populated_apt_type_pcnt *   0.00 / 100 + T.Populated_apt_nbr_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_plus4_pcnt *   0.00 / 100 + T.Populated_dpc_pcnt *   0.00 / 100 + T.Populated_z4_type_pcnt *   0.00 / 100 + T.Populated_crte_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_dpvcmra_pcnt *   0.00 / 100 + T.Populated_dpvconf_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_census_tract_pcnt *   0.00 / 100 + T.Populated_census_block_group_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_match_code_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_verified_pcnt *   0.00 / 100 + T.Populated_activity_status_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100 + T.Populated_cord_cutter_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'phone','fname','mname','lname','salutation','suffix','gender','dob','house','pre_dir','street','street_type','post_dir','apt_type','apt_nbr','zip','plus4','dpc','z4_type','crte','city','state','dpvcmra','dpvconf','fips_state','fips_county','census_tract','census_block_group','cbsa','match_code','latitude','longitude','email','filler1','filler2','verified','activity_status','prepaid','cord_cutter');
  SELF.populated_pcnt := CHOOSE(C,le.populated_phone_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_salutation_pcnt,le.populated_suffix_pcnt,le.populated_gender_pcnt,le.populated_dob_pcnt,le.populated_house_pcnt,le.populated_pre_dir_pcnt,le.populated_street_pcnt,le.populated_street_type_pcnt,le.populated_post_dir_pcnt,le.populated_apt_type_pcnt,le.populated_apt_nbr_pcnt,le.populated_zip_pcnt,le.populated_plus4_pcnt,le.populated_dpc_pcnt,le.populated_z4_type_pcnt,le.populated_crte_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_dpvcmra_pcnt,le.populated_dpvconf_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_census_tract_pcnt,le.populated_census_block_group_pcnt,le.populated_cbsa_pcnt,le.populated_match_code_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_email_pcnt,le.populated_filler1_pcnt,le.populated_filler2_pcnt,le.populated_verified_pcnt,le.populated_activity_status_pcnt,le.populated_prepaid_pcnt,le.populated_cord_cutter_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_phone,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_salutation,le.maxlength_suffix,le.maxlength_gender,le.maxlength_dob,le.maxlength_house,le.maxlength_pre_dir,le.maxlength_street,le.maxlength_street_type,le.maxlength_post_dir,le.maxlength_apt_type,le.maxlength_apt_nbr,le.maxlength_zip,le.maxlength_plus4,le.maxlength_dpc,le.maxlength_z4_type,le.maxlength_crte,le.maxlength_city,le.maxlength_state,le.maxlength_dpvcmra,le.maxlength_dpvconf,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_census_tract,le.maxlength_census_block_group,le.maxlength_cbsa,le.maxlength_match_code,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_email,le.maxlength_filler1,le.maxlength_filler2,le.maxlength_verified,le.maxlength_activity_status,le.maxlength_prepaid,le.maxlength_cord_cutter);
  SELF.avelength := CHOOSE(C,le.avelength_phone,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_salutation,le.avelength_suffix,le.avelength_gender,le.avelength_dob,le.avelength_house,le.avelength_pre_dir,le.avelength_street,le.avelength_street_type,le.avelength_post_dir,le.avelength_apt_type,le.avelength_apt_nbr,le.avelength_zip,le.avelength_plus4,le.avelength_dpc,le.avelength_z4_type,le.avelength_crte,le.avelength_city,le.avelength_state,le.avelength_dpvcmra,le.avelength_dpvconf,le.avelength_fips_state,le.avelength_fips_county,le.avelength_census_tract,le.avelength_census_block_group,le.avelength_cbsa,le.avelength_match_code,le.avelength_latitude,le.avelength_longitude,le.avelength_email,le.avelength_filler1,le.avelength_filler2,le.avelength_verified,le.avelength_activity_status,le.avelength_prepaid,le.avelength_cord_cutter);
END;
EXPORT invSummary := NORMALIZE(summary0, 39, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.salutation),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.pre_dir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.street_type),TRIM((SALT311.StrType)le.post_dir),TRIM((SALT311.StrType)le.apt_type),TRIM((SALT311.StrType)le.apt_nbr),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.plus4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.z4_type),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.dpvcmra),TRIM((SALT311.StrType)le.dpvconf),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.census_block_group),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.match_code),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.cord_cutter)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,39,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 39);
  SELF.FldNo2 := 1 + (C % 39);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.salutation),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.pre_dir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.street_type),TRIM((SALT311.StrType)le.post_dir),TRIM((SALT311.StrType)le.apt_type),TRIM((SALT311.StrType)le.apt_nbr),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.plus4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.z4_type),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.dpvcmra),TRIM((SALT311.StrType)le.dpvconf),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.census_block_group),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.match_code),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.cord_cutter)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.salutation),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.pre_dir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.street_type),TRIM((SALT311.StrType)le.post_dir),TRIM((SALT311.StrType)le.apt_type),TRIM((SALT311.StrType)le.apt_nbr),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.plus4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.z4_type),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.dpvcmra),TRIM((SALT311.StrType)le.dpvconf),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.census_block_group),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.match_code),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.cord_cutter)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),39*39,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{34,'filler1'}
      ,{35,'filler2'}
      ,{36,'verified'}
      ,{37,'activity_status'}
      ,{38,'prepaid'}
      ,{39,'cord_cutter'}],SALT311.MAC_Character_Counts.Field_Identification);
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
    Fields.InValid_filler1((SALT311.StrType)le.filler1),
    Fields.InValid_filler2((SALT311.StrType)le.filler2),
    Fields.InValid_verified((SALT311.StrType)le.verified),
    Fields.InValid_activity_status((SALT311.StrType)le.activity_status),
    Fields.InValid_prepaid((SALT311.StrType)le.prepaid),
    Fields.InValid_cord_cutter((SALT311.StrType)le.cord_cutter),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,39,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_gender','invalid_dob','Unknown','invalid_predir_postdir','Unknown','invalid_street_type','invalid_predir_postdir','invalid_apt_type','Unknown','invalid_zip','invalid_plus4','invalid_dpc','invalid_z4_type','Unknown','invalid_city','invalid_state','Unknown','Unknown','invalid_fips_state','invalid_fips_county','Unknown','Unknown','invalid_cbsa','Unknown','invalid_lat_long','invalid_lat_long','invalid_email','Unknown','Unknown','invalid_verified','invalid_activity_status','invalid_Y_N','invalid_Y_N');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_salutation(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_house(TotalErrors.ErrorNum),Fields.InValidMessage_pre_dir(TotalErrors.ErrorNum),Fields.InValidMessage_street(TotalErrors.ErrorNum),Fields.InValidMessage_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_post_dir(TotalErrors.ErrorNum),Fields.InValidMessage_apt_type(TotalErrors.ErrorNum),Fields.InValidMessage_apt_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_plus4(TotalErrors.ErrorNum),Fields.InValidMessage_dpc(TotalErrors.ErrorNum),Fields.InValidMessage_z4_type(TotalErrors.ErrorNum),Fields.InValidMessage_crte(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_dpvcmra(TotalErrors.ErrorNum),Fields.InValidMessage_dpvconf(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_census_block_group(TotalErrors.ErrorNum),Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_match_code(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Fields.InValidMessage_verified(TotalErrors.ErrorNum),Fields.InValidMessage_activity_status(TotalErrors.ErrorNum),Fields.InValidMessage_prepaid(TotalErrors.ErrorNum),Fields.InValidMessage_cord_cutter(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_NeustarWireless, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
