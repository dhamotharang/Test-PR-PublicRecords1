IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_In_FL) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_issuance_pcnt := AVE(GROUP,IF(h.issuance = (TYPEOF(h.issuance))'',0,100));
    maxlength_issuance := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.issuance)));
    avelength_issuance := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.issuance)),h.issuance<>(typeof(h.issuance))'');
    populated_address_change_pcnt := AVE(GROUP,IF(h.address_change = (TYPEOF(h.address_change))'',0,100));
    maxlength_address_change := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_change)));
    avelength_address_change := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_change)),h.address_change<>(typeof(h.address_change))'');
    populated_name_change_pcnt := AVE(GROUP,IF(h.name_change = (TYPEOF(h.name_change))'',0,100));
    maxlength_name_change := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_change)));
    avelength_name_change := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_change)),h.name_change<>(typeof(h.name_change))'');
    populated_dob_change_pcnt := AVE(GROUP,IF(h.dob_change = (TYPEOF(h.dob_change))'',0,100));
    maxlength_dob_change := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_change)));
    avelength_dob_change := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob_change)),h.dob_change<>(typeof(h.dob_change))'');
    populated_sex_change_pcnt := AVE(GROUP,IF(h.sex_change = (TYPEOF(h.sex_change))'',0,100));
    maxlength_sex_change := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sex_change)));
    avelength_sex_change := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sex_change)),h.sex_change<>(typeof(h.sex_change))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_addr1_pcnt := AVE(GROUP,IF(h.addr1 = (TYPEOF(h.addr1))'',0,100));
    maxlength_addr1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr1)));
    avelength_addr1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr1)),h.addr1<>(typeof(h.addr1))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_sex_flag_pcnt := AVE(GROUP,IF(h.sex_flag = (TYPEOF(h.sex_flag))'',0,100));
    maxlength_sex_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sex_flag)));
    avelength_sex_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sex_flag)),h.sex_flag<>(typeof(h.sex_flag))'');
    populated_license_type_pcnt := AVE(GROUP,IF(h.license_type = (TYPEOF(h.license_type))'',0,100));
    maxlength_license_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.license_type)));
    avelength_license_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.license_type)),h.license_type<>(typeof(h.license_type))'');
    populated_attention_flag_pcnt := AVE(GROUP,IF(h.attention_flag = (TYPEOF(h.attention_flag))'',0,100));
    maxlength_attention_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.attention_flag)));
    avelength_attention_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.attention_flag)),h.attention_flag<>(typeof(h.attention_flag))'');
    populated_dod_pcnt := AVE(GROUP,IF(h.dod = (TYPEOF(h.dod))'',0,100));
    maxlength_dod := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dod)));
    avelength_dod := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dod)),h.dod<>(typeof(h.dod))'');
    populated_restrictions_pcnt := AVE(GROUP,IF(h.restrictions = (TYPEOF(h.restrictions))'',0,100));
    maxlength_restrictions := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.restrictions)));
    avelength_restrictions := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.restrictions)),h.restrictions<>(typeof(h.restrictions))'');
    populated_orig_expiration_date_pcnt := AVE(GROUP,IF(h.orig_expiration_date = (TYPEOF(h.orig_expiration_date))'',0,100));
    maxlength_orig_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_expiration_date)));
    avelength_orig_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_expiration_date)),h.orig_expiration_date<>(typeof(h.orig_expiration_date))'');
    populated_lic_issue_date_pcnt := AVE(GROUP,IF(h.lic_issue_date = (TYPEOF(h.lic_issue_date))'',0,100));
    maxlength_lic_issue_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lic_issue_date)));
    avelength_lic_issue_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lic_issue_date)),h.lic_issue_date<>(typeof(h.lic_issue_date))'');
    populated_lic_endorsement_pcnt := AVE(GROUP,IF(h.lic_endorsement = (TYPEOF(h.lic_endorsement))'',0,100));
    maxlength_lic_endorsement := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lic_endorsement)));
    avelength_lic_endorsement := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lic_endorsement)),h.lic_endorsement<>(typeof(h.lic_endorsement))'');
    populated_dl_number_pcnt := AVE(GROUP,IF(h.dl_number = (TYPEOF(h.dl_number))'',0,100));
    maxlength_dl_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dl_number)));
    avelength_dl_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dl_number)),h.dl_number<>(typeof(h.dl_number))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_new_dl_number_pcnt := AVE(GROUP,IF(h.new_dl_number = (TYPEOF(h.new_dl_number))'',0,100));
    maxlength_new_dl_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.new_dl_number)));
    avelength_new_dl_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.new_dl_number)),h.new_dl_number<>(typeof(h.new_dl_number))'');
    populated_personal_info_flag_pcnt := AVE(GROUP,IF(h.personal_info_flag = (TYPEOF(h.personal_info_flag))'',0,100));
    maxlength_personal_info_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.personal_info_flag)));
    avelength_personal_info_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.personal_info_flag)),h.personal_info_flag<>(typeof(h.personal_info_flag))'');
    populated_dl_orig_issue_date_pcnt := AVE(GROUP,IF(h.dl_orig_issue_date = (TYPEOF(h.dl_orig_issue_date))'',0,100));
    maxlength_dl_orig_issue_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dl_orig_issue_date)));
    avelength_dl_orig_issue_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dl_orig_issue_date)),h.dl_orig_issue_date<>(typeof(h.dl_orig_issue_date))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_oos_previous_dl_number_pcnt := AVE(GROUP,IF(h.oos_previous_dl_number = (TYPEOF(h.oos_previous_dl_number))'',0,100));
    maxlength_oos_previous_dl_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.oos_previous_dl_number)));
    avelength_oos_previous_dl_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.oos_previous_dl_number)),h.oos_previous_dl_number<>(typeof(h.oos_previous_dl_number))'');
    populated_oos_previous_st_pcnt := AVE(GROUP,IF(h.oos_previous_st = (TYPEOF(h.oos_previous_st))'',0,100));
    maxlength_oos_previous_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.oos_previous_st)));
    avelength_oos_previous_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.oos_previous_st)),h.oos_previous_st<>(typeof(h.oos_previous_st))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_cleaning_score_pcnt := AVE(GROUP,IF(h.cleaning_score = (TYPEOF(h.cleaning_score))'',0,100));
    maxlength_cleaning_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaning_score)));
    avelength_cleaning_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaning_score)),h.cleaning_score<>(typeof(h.cleaning_score))'');
    populated_addr_fix_flag_pcnt := AVE(GROUP,IF(h.addr_fix_flag = (TYPEOF(h.addr_fix_flag))'',0,100));
    maxlength_addr_fix_flag := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_fix_flag)));
    avelength_addr_fix_flag := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.addr_fix_flag)),h.addr_fix_flag<>(typeof(h.addr_fix_flag))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_issuance_pcnt *   0.00 / 100 + T.Populated_address_change_pcnt *   0.00 / 100 + T.Populated_name_change_pcnt *   0.00 / 100 + T.Populated_dob_change_pcnt *   0.00 / 100 + T.Populated_sex_change_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_addr1_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_sex_flag_pcnt *   0.00 / 100 + T.Populated_license_type_pcnt *   0.00 / 100 + T.Populated_attention_flag_pcnt *   0.00 / 100 + T.Populated_dod_pcnt *   0.00 / 100 + T.Populated_restrictions_pcnt *   0.00 / 100 + T.Populated_orig_expiration_date_pcnt *   0.00 / 100 + T.Populated_lic_issue_date_pcnt *   0.00 / 100 + T.Populated_lic_endorsement_pcnt *   0.00 / 100 + T.Populated_dl_number_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_new_dl_number_pcnt *   0.00 / 100 + T.Populated_personal_info_flag_pcnt *   0.00 / 100 + T.Populated_dl_orig_issue_date_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_oos_previous_dl_number_pcnt *   0.00 / 100 + T.Populated_oos_previous_st_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_cleaning_score_pcnt *   0.00 / 100 + T.Populated_addr_fix_flag_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','issuance','address_change','name_change','dob_change','sex_change','name','addr1','city','state','zip','dob','race','sex_flag','license_type','attention_flag','dod','restrictions','orig_expiration_date','lic_issue_date','lic_endorsement','dl_number','ssn','age','new_dl_number','personal_info_flag','dl_orig_issue_date','height','oos_previous_dl_number','oos_previous_st','filler2','title','fname','mname','lname','name_suffix','cleaning_score','addr_fix_flag','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_issuance_pcnt,le.populated_address_change_pcnt,le.populated_name_change_pcnt,le.populated_dob_change_pcnt,le.populated_sex_change_pcnt,le.populated_name_pcnt,le.populated_addr1_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_dob_pcnt,le.populated_race_pcnt,le.populated_sex_flag_pcnt,le.populated_license_type_pcnt,le.populated_attention_flag_pcnt,le.populated_dod_pcnt,le.populated_restrictions_pcnt,le.populated_orig_expiration_date_pcnt,le.populated_lic_issue_date_pcnt,le.populated_lic_endorsement_pcnt,le.populated_dl_number_pcnt,le.populated_ssn_pcnt,le.populated_age_pcnt,le.populated_new_dl_number_pcnt,le.populated_personal_info_flag_pcnt,le.populated_dl_orig_issue_date_pcnt,le.populated_height_pcnt,le.populated_oos_previous_dl_number_pcnt,le.populated_oos_previous_st_pcnt,le.populated_filler2_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_cleaning_score_pcnt,le.populated_addr_fix_flag_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_issuance,le.maxlength_address_change,le.maxlength_name_change,le.maxlength_dob_change,le.maxlength_sex_change,le.maxlength_name,le.maxlength_addr1,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_dob,le.maxlength_race,le.maxlength_sex_flag,le.maxlength_license_type,le.maxlength_attention_flag,le.maxlength_dod,le.maxlength_restrictions,le.maxlength_orig_expiration_date,le.maxlength_lic_issue_date,le.maxlength_lic_endorsement,le.maxlength_dl_number,le.maxlength_ssn,le.maxlength_age,le.maxlength_new_dl_number,le.maxlength_personal_info_flag,le.maxlength_dl_orig_issue_date,le.maxlength_height,le.maxlength_oos_previous_dl_number,le.maxlength_oos_previous_st,le.maxlength_filler2,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_cleaning_score,le.maxlength_addr_fix_flag,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_issuance,le.avelength_address_change,le.avelength_name_change,le.avelength_dob_change,le.avelength_sex_change,le.avelength_name,le.avelength_addr1,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_dob,le.avelength_race,le.avelength_sex_flag,le.avelength_license_type,le.avelength_attention_flag,le.avelength_dod,le.avelength_restrictions,le.avelength_orig_expiration_date,le.avelength_lic_issue_date,le.avelength_lic_endorsement,le.avelength_dl_number,le.avelength_ssn,le.avelength_age,le.avelength_new_dl_number,le.avelength_personal_info_flag,le.avelength_dl_orig_issue_date,le.avelength_height,le.avelength_oos_previous_dl_number,le.avelength_oos_previous_st,le.avelength_filler2,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_cleaning_score,le.avelength_addr_fix_flag,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 65, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.process_date),TRIM((SALT34.StrType)le.issuance),TRIM((SALT34.StrType)le.address_change),TRIM((SALT34.StrType)le.name_change),TRIM((SALT34.StrType)le.dob_change),TRIM((SALT34.StrType)le.sex_change),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.addr1),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.dob),TRIM((SALT34.StrType)le.race),TRIM((SALT34.StrType)le.sex_flag),TRIM((SALT34.StrType)le.license_type),TRIM((SALT34.StrType)le.attention_flag),TRIM((SALT34.StrType)le.dod),TRIM((SALT34.StrType)le.restrictions),TRIM((SALT34.StrType)le.orig_expiration_date),TRIM((SALT34.StrType)le.lic_issue_date),TRIM((SALT34.StrType)le.lic_endorsement),TRIM((SALT34.StrType)le.dl_number),TRIM((SALT34.StrType)le.ssn),TRIM((SALT34.StrType)le.age),TRIM((SALT34.StrType)le.new_dl_number),TRIM((SALT34.StrType)le.personal_info_flag),TRIM((SALT34.StrType)le.dl_orig_issue_date),TRIM((SALT34.StrType)le.height),TRIM((SALT34.StrType)le.oos_previous_dl_number),TRIM((SALT34.StrType)le.oos_previous_st),TRIM((SALT34.StrType)le.filler2),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.cleaning_score),TRIM((SALT34.StrType)le.addr_fix_flag),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip5),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dpbc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.ace_fips_st),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,65,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 65);
  SELF.FldNo2 := 1 + (C % 65);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.process_date),TRIM((SALT34.StrType)le.issuance),TRIM((SALT34.StrType)le.address_change),TRIM((SALT34.StrType)le.name_change),TRIM((SALT34.StrType)le.dob_change),TRIM((SALT34.StrType)le.sex_change),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.addr1),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.dob),TRIM((SALT34.StrType)le.race),TRIM((SALT34.StrType)le.sex_flag),TRIM((SALT34.StrType)le.license_type),TRIM((SALT34.StrType)le.attention_flag),TRIM((SALT34.StrType)le.dod),TRIM((SALT34.StrType)le.restrictions),TRIM((SALT34.StrType)le.orig_expiration_date),TRIM((SALT34.StrType)le.lic_issue_date),TRIM((SALT34.StrType)le.lic_endorsement),TRIM((SALT34.StrType)le.dl_number),TRIM((SALT34.StrType)le.ssn),TRIM((SALT34.StrType)le.age),TRIM((SALT34.StrType)le.new_dl_number),TRIM((SALT34.StrType)le.personal_info_flag),TRIM((SALT34.StrType)le.dl_orig_issue_date),TRIM((SALT34.StrType)le.height),TRIM((SALT34.StrType)le.oos_previous_dl_number),TRIM((SALT34.StrType)le.oos_previous_st),TRIM((SALT34.StrType)le.filler2),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.cleaning_score),TRIM((SALT34.StrType)le.addr_fix_flag),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip5),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dpbc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.ace_fips_st),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.process_date),TRIM((SALT34.StrType)le.issuance),TRIM((SALT34.StrType)le.address_change),TRIM((SALT34.StrType)le.name_change),TRIM((SALT34.StrType)le.dob_change),TRIM((SALT34.StrType)le.sex_change),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.addr1),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.dob),TRIM((SALT34.StrType)le.race),TRIM((SALT34.StrType)le.sex_flag),TRIM((SALT34.StrType)le.license_type),TRIM((SALT34.StrType)le.attention_flag),TRIM((SALT34.StrType)le.dod),TRIM((SALT34.StrType)le.restrictions),TRIM((SALT34.StrType)le.orig_expiration_date),TRIM((SALT34.StrType)le.lic_issue_date),TRIM((SALT34.StrType)le.lic_endorsement),TRIM((SALT34.StrType)le.dl_number),TRIM((SALT34.StrType)le.ssn),TRIM((SALT34.StrType)le.age),TRIM((SALT34.StrType)le.new_dl_number),TRIM((SALT34.StrType)le.personal_info_flag),TRIM((SALT34.StrType)le.dl_orig_issue_date),TRIM((SALT34.StrType)le.height),TRIM((SALT34.StrType)le.oos_previous_dl_number),TRIM((SALT34.StrType)le.oos_previous_st),TRIM((SALT34.StrType)le.filler2),TRIM((SALT34.StrType)le.title),TRIM((SALT34.StrType)le.fname),TRIM((SALT34.StrType)le.mname),TRIM((SALT34.StrType)le.lname),TRIM((SALT34.StrType)le.name_suffix),TRIM((SALT34.StrType)le.cleaning_score),TRIM((SALT34.StrType)le.addr_fix_flag),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.predir),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.suffix),TRIM((SALT34.StrType)le.postdir),TRIM((SALT34.StrType)le.unit_desig),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.p_city_name),TRIM((SALT34.StrType)le.v_city_name),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.zip5),TRIM((SALT34.StrType)le.zip4),TRIM((SALT34.StrType)le.cart),TRIM((SALT34.StrType)le.cr_sort_sz),TRIM((SALT34.StrType)le.lot),TRIM((SALT34.StrType)le.lot_order),TRIM((SALT34.StrType)le.dpbc),TRIM((SALT34.StrType)le.chk_digit),TRIM((SALT34.StrType)le.rec_type),TRIM((SALT34.StrType)le.ace_fips_st),TRIM((SALT34.StrType)le.county),TRIM((SALT34.StrType)le.geo_lat),TRIM((SALT34.StrType)le.geo_long),TRIM((SALT34.StrType)le.msa),TRIM((SALT34.StrType)le.geo_blk),TRIM((SALT34.StrType)le.geo_match),TRIM((SALT34.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),65*65,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'issuance'}
      ,{3,'address_change'}
      ,{4,'name_change'}
      ,{5,'dob_change'}
      ,{6,'sex_change'}
      ,{7,'name'}
      ,{8,'addr1'}
      ,{9,'city'}
      ,{10,'state'}
      ,{11,'zip'}
      ,{12,'dob'}
      ,{13,'race'}
      ,{14,'sex_flag'}
      ,{15,'license_type'}
      ,{16,'attention_flag'}
      ,{17,'dod'}
      ,{18,'restrictions'}
      ,{19,'orig_expiration_date'}
      ,{20,'lic_issue_date'}
      ,{21,'lic_endorsement'}
      ,{22,'dl_number'}
      ,{23,'ssn'}
      ,{24,'age'}
      ,{25,'new_dl_number'}
      ,{26,'personal_info_flag'}
      ,{27,'dl_orig_issue_date'}
      ,{28,'height'}
      ,{29,'oos_previous_dl_number'}
      ,{30,'oos_previous_st'}
      ,{31,'filler2'}
      ,{32,'title'}
      ,{33,'fname'}
      ,{34,'mname'}
      ,{35,'lname'}
      ,{36,'name_suffix'}
      ,{37,'cleaning_score'}
      ,{38,'addr_fix_flag'}
      ,{39,'prim_range'}
      ,{40,'predir'}
      ,{41,'prim_name'}
      ,{42,'suffix'}
      ,{43,'postdir'}
      ,{44,'unit_desig'}
      ,{45,'sec_range'}
      ,{46,'p_city_name'}
      ,{47,'v_city_name'}
      ,{48,'st'}
      ,{49,'zip5'}
      ,{50,'zip4'}
      ,{51,'cart'}
      ,{52,'cr_sort_sz'}
      ,{53,'lot'}
      ,{54,'lot_order'}
      ,{55,'dpbc'}
      ,{56,'chk_digit'}
      ,{57,'rec_type'}
      ,{58,'ace_fips_st'}
      ,{59,'county'}
      ,{60,'geo_lat'}
      ,{61,'geo_long'}
      ,{62,'msa'}
      ,{63,'geo_blk'}
      ,{64,'geo_match'}
      ,{65,'err_stat'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT34.StrType)le.process_date),
    Fields.InValid_issuance((SALT34.StrType)le.issuance),
    Fields.InValid_address_change((SALT34.StrType)le.address_change),
    Fields.InValid_name_change((SALT34.StrType)le.name_change),
    Fields.InValid_dob_change((SALT34.StrType)le.dob_change),
    Fields.InValid_sex_change((SALT34.StrType)le.sex_change),
    Fields.InValid_name((SALT34.StrType)le.name),
    Fields.InValid_addr1((SALT34.StrType)le.addr1),
    Fields.InValid_city((SALT34.StrType)le.city),
    Fields.InValid_state((SALT34.StrType)le.state),
    Fields.InValid_zip((SALT34.StrType)le.zip),
    Fields.InValid_dob((SALT34.StrType)le.dob),
    Fields.InValid_race((SALT34.StrType)le.race),
    Fields.InValid_sex_flag((SALT34.StrType)le.sex_flag),
    Fields.InValid_license_type((SALT34.StrType)le.license_type),
    Fields.InValid_attention_flag((SALT34.StrType)le.attention_flag),
    Fields.InValid_dod((SALT34.StrType)le.dod),
    Fields.InValid_restrictions((SALT34.StrType)le.restrictions),
    Fields.InValid_orig_expiration_date((SALT34.StrType)le.orig_expiration_date),
    Fields.InValid_lic_issue_date((SALT34.StrType)le.lic_issue_date),
    Fields.InValid_lic_endorsement((SALT34.StrType)le.lic_endorsement),
    Fields.InValid_dl_number((SALT34.StrType)le.dl_number),
    Fields.InValid_ssn((SALT34.StrType)le.ssn),
    Fields.InValid_age((SALT34.StrType)le.age),
    Fields.InValid_new_dl_number((SALT34.StrType)le.new_dl_number),
    Fields.InValid_personal_info_flag((SALT34.StrType)le.personal_info_flag),
    Fields.InValid_dl_orig_issue_date((SALT34.StrType)le.dl_orig_issue_date),
    Fields.InValid_height((SALT34.StrType)le.height),
    Fields.InValid_oos_previous_dl_number((SALT34.StrType)le.oos_previous_dl_number),
    Fields.InValid_oos_previous_st((SALT34.StrType)le.oos_previous_st),
    Fields.InValid_filler2((SALT34.StrType)le.filler2),
    Fields.InValid_title((SALT34.StrType)le.title),
    Fields.InValid_fname((SALT34.StrType)le.fname,(SALT34.StrType)le.mname,(SALT34.StrType)le.lname),
    Fields.InValid_mname((SALT34.StrType)le.mname),
    Fields.InValid_lname((SALT34.StrType)le.lname),
    Fields.InValid_name_suffix((SALT34.StrType)le.name_suffix),
    Fields.InValid_cleaning_score((SALT34.StrType)le.cleaning_score),
    Fields.InValid_addr_fix_flag((SALT34.StrType)le.addr_fix_flag),
    Fields.InValid_prim_range((SALT34.StrType)le.prim_range),
    Fields.InValid_predir((SALT34.StrType)le.predir),
    Fields.InValid_prim_name((SALT34.StrType)le.prim_name),
    Fields.InValid_suffix((SALT34.StrType)le.suffix),
    Fields.InValid_postdir((SALT34.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT34.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT34.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT34.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT34.StrType)le.v_city_name),
    Fields.InValid_st((SALT34.StrType)le.st),
    Fields.InValid_zip5((SALT34.StrType)le.zip5),
    Fields.InValid_zip4((SALT34.StrType)le.zip4),
    Fields.InValid_cart((SALT34.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT34.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT34.StrType)le.lot),
    Fields.InValid_lot_order((SALT34.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT34.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT34.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT34.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT34.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT34.StrType)le.county),
    Fields.InValid_geo_lat((SALT34.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT34.StrType)le.geo_long),
    Fields.InValid_msa((SALT34.StrType)le.msa),
    Fields.InValid_geo_blk((SALT34.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT34.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT34.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,65,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_process_date','invalid_issuance','invalid_boolean_yes_no','invalid_boolean_yes_no','invalid_boolean_yes_no','invalid_boolean_yes_no','invalid_mandatory','Unknown','invalid_specials','invalid_state','invalid_zip','invalid_8pastdate','invalid_race','invalid_sex_flag','invalid_license_type','invalid_attention_flag','invalid_dod','invalid_restrictions','invalid_08date','invalid_8pastdate','invalid_lic_endorsement','invalid_dl_number','invalid_empty','invalid_age','invalid_new_dl_number','invalid_empty','invalid_8pastdate','invalid_height','Unknown','invalid_oos_previous_st','Unknown','Unknown','invalid_name','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_issuance(TotalErrors.ErrorNum),Fields.InValidMessage_address_change(TotalErrors.ErrorNum),Fields.InValidMessage_name_change(TotalErrors.ErrorNum),Fields.InValidMessage_dob_change(TotalErrors.ErrorNum),Fields.InValidMessage_sex_change(TotalErrors.ErrorNum),Fields.InValidMessage_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_race(TotalErrors.ErrorNum),Fields.InValidMessage_sex_flag(TotalErrors.ErrorNum),Fields.InValidMessage_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_attention_flag(TotalErrors.ErrorNum),Fields.InValidMessage_dod(TotalErrors.ErrorNum),Fields.InValidMessage_restrictions(TotalErrors.ErrorNum),Fields.InValidMessage_orig_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_lic_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_lic_endorsement(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_new_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_personal_info_flag(TotalErrors.ErrorNum),Fields.InValidMessage_dl_orig_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_oos_previous_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_oos_previous_st(TotalErrors.ErrorNum),Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cleaning_score(TotalErrors.ErrorNum),Fields.InValidMessage_addr_fix_flag(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
