IMPORT ut,SALT31;
EXPORT hygiene(dataset(layout_InFile_) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_best_dob_pcnt := AVE(GROUP,IF(h.best_dob = (TYPEOF(h.best_dob))'',0,100));
    maxlength_best_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)));
    avelength_best_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)),h.best_dob<>(typeof(h.best_dob))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_data_state_pcnt := AVE(GROUP,IF(h.data_state = (TYPEOF(h.data_state))'',0,100));
    maxlength_data_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.data_state)));
    avelength_data_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.data_state)),h.data_state<>(typeof(h.data_state))'');
    populated_provider_id_pcnt := AVE(GROUP,IF(h.provider_id = (TYPEOF(h.provider_id))'',0,100));
    maxlength_provider_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.provider_id)));
    avelength_provider_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.provider_id)),h.provider_id<>(typeof(h.provider_id))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_taxonomy_pcnt := AVE(GROUP,IF(h.taxonomy = (TYPEOF(h.taxonomy))'',0,100));
    maxlength_taxonomy := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy)));
    avelength_taxonomy := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.taxonomy)),h.taxonomy<>(typeof(h.taxonomy))'');
    populated_provider_name_pcnt := AVE(GROUP,IF(h.provider_name = (TYPEOF(h.provider_name))'',0,100));
    maxlength_provider_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.provider_name)));
    avelength_provider_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.provider_name)),h.provider_name<>(typeof(h.provider_name))'');
    populated_provider_address_pcnt := AVE(GROUP,IF(h.provider_address = (TYPEOF(h.provider_address))'',0,100));
    maxlength_provider_address := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.provider_address)));
    avelength_provider_address := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.provider_address)),h.provider_address<>(typeof(h.provider_address))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_entity_type_code_pcnt := AVE(GROUP,IF(h.entity_type_code = (TYPEOF(h.entity_type_code))'',0,100));
    maxlength_entity_type_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.entity_type_code)));
    avelength_entity_type_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.entity_type_code)),h.entity_type_code<>(typeof(h.entity_type_code))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_companyname_pcnt := AVE(GROUP,IF(h.companyname = (TYPEOF(h.companyname))'',0,100));
    maxlength_companyname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.companyname)));
    avelength_companyname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.companyname)),h.companyname<>(typeof(h.companyname))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_source_rid_pcnt := AVE(GROUP,IF(h.source_rid = (TYPEOF(h.source_rid))'',0,100));
    maxlength_source_rid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_rid)));
    avelength_source_rid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_rid)),h.source_rid<>(typeof(h.source_rid))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_clean_clinic_name_pcnt := AVE(GROUP,IF(h.clean_clinic_name = (TYPEOF(h.clean_clinic_name))'',0,100));
    maxlength_clean_clinic_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_clinic_name)));
    avelength_clean_clinic_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_clinic_name)),h.clean_clinic_name<>(typeof(h.clean_clinic_name))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_st_pcnt := AVE(GROUP,IF(h.fips_st = (TYPEOF(h.fips_st))'',0,100));
    maxlength_fips_st := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_st)));
    avelength_fips_st := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_st)),h.fips_st<>(typeof(h.fips_st))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_did_pcnt *   5.00 / 100 + T.Populated_did_score_pcnt *   5.00 / 100 + T.Populated_bdid_pcnt *   5.00 / 100 + T.Populated_bdid_score_pcnt *   5.00 / 100 + T.Populated_best_dob_pcnt *   5.00 / 100 + T.Populated_best_ssn_pcnt *   5.00 / 100 + T.Populated_data_state_pcnt *   5.00 / 100 + T.Populated_provider_id_pcnt *   5.00 / 100 + T.Populated_npi_pcnt *   5.00 / 100 + T.Populated_taxonomy_pcnt *   5.00 / 100 + T.Populated_provider_name_pcnt *   5.00 / 100 + T.Populated_provider_address_pcnt *   5.00 / 100 + T.Populated_phone_pcnt *   5.00 / 100 + T.Populated_entity_type_code_pcnt *   5.00 / 100 + T.Populated_firstname_pcnt *   5.00 / 100 + T.Populated_lastname_pcnt *   5.00 / 100 + T.Populated_companyname_pcnt *   5.00 / 100 + T.Populated_src_pcnt *   5.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   5.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   5.00 / 100 + T.Populated_dt_first_seen_pcnt *   5.00 / 100 + T.Populated_dt_last_seen_pcnt *   5.00 / 100 + T.Populated_record_type_pcnt *   5.00 / 100 + T.Populated_source_rid_pcnt *   5.00 / 100 + T.Populated_lnpid_pcnt *   5.00 / 100 + T.Populated_title_pcnt *   5.00 / 100 + T.Populated_fname_pcnt *   5.00 / 100 + T.Populated_mname_pcnt *   5.00 / 100 + T.Populated_lname_pcnt *   5.00 / 100 + T.Populated_name_suffix_pcnt *   5.00 / 100 + T.Populated_name_type_pcnt *   5.00 / 100 + T.Populated_nid_pcnt *   5.00 / 100 + T.Populated_clean_clinic_name_pcnt *   5.00 / 100 + T.Populated_prepped_addr1_pcnt *   5.00 / 100 + T.Populated_prepped_addr2_pcnt *   5.00 / 100 + T.Populated_prim_range_pcnt *   5.00 / 100 + T.Populated_predir_pcnt *   5.00 / 100 + T.Populated_prim_name_pcnt *   5.00 / 100 + T.Populated_addr_suffix_pcnt *   5.00 / 100 + T.Populated_postdir_pcnt *   5.00 / 100 + T.Populated_unit_desig_pcnt *   5.00 / 100 + T.Populated_sec_range_pcnt *   5.00 / 100 + T.Populated_p_city_name_pcnt *   5.00 / 100 + T.Populated_v_city_name_pcnt *   5.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *   5.00 / 100 + T.Populated_zip4_pcnt *   5.00 / 100 + T.Populated_cart_pcnt *   5.00 / 100 + T.Populated_cr_sort_sz_pcnt *   5.00 / 100 + T.Populated_lot_pcnt *   5.00 / 100 + T.Populated_lot_order_pcnt *   5.00 / 100 + T.Populated_dbpc_pcnt *   5.00 / 100 + T.Populated_chk_digit_pcnt *   5.00 / 100 + T.Populated_rec_type_pcnt *   5.00 / 100 + T.Populated_fips_st_pcnt *   5.00 / 100 + T.Populated_fips_county_pcnt *   5.00 / 100 + T.Populated_geo_lat_pcnt *   5.00 / 100 + T.Populated_geo_long_pcnt *   5.00 / 100 + T.Populated_msa_pcnt *   5.00 / 100 + T.Populated_geo_blk_pcnt *   5.00 / 100 + T.Populated_geo_match_pcnt *   5.00 / 100 + T.Populated_err_stat_pcnt *   5.00 / 100 + T.Populated_rawaid_pcnt *   5.00 / 100 + T.Populated_aceaid_pcnt *   5.00 / 100 + T.Populated_clean_phone_pcnt *   5.00 / 100 + T.Populated_dotid_pcnt *   5.00 / 100 + T.Populated_dotscore_pcnt *   5.00 / 100 + T.Populated_dotweight_pcnt *   5.00 / 100 + T.Populated_empid_pcnt *   5.00 / 100 + T.Populated_empscore_pcnt *   5.00 / 100 + T.Populated_empweight_pcnt *   5.00 / 100 + T.Populated_powid_pcnt *   5.00 / 100 + T.Populated_powscore_pcnt *   5.00 / 100 + T.Populated_powweight_pcnt *   5.00 / 100 + T.Populated_proxid_pcnt *   5.00 / 100 + T.Populated_proxscore_pcnt *   5.00 / 100 + T.Populated_proxweight_pcnt *   5.00 / 100 + T.Populated_seleid_pcnt *   5.00 / 100 + T.Populated_selescore_pcnt *   5.00 / 100 + T.Populated_seleweight_pcnt *   5.00 / 100 + T.Populated_orgid_pcnt *   5.00 / 100 + T.Populated_orgscore_pcnt *   5.00 / 100 + T.Populated_orgweight_pcnt *   5.00 / 100 + T.Populated_ultid_pcnt *   5.00 / 100 + T.Populated_ultscore_pcnt *   5.00 / 100 + T.Populated_ultweight_pcnt *   5.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'did','did_score','bdid','bdid_score','best_dob','best_ssn','data_state','provider_id','npi','taxonomy','provider_name','provider_address','phone','entity_type_code','firstname','lastname','companyname','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_best_dob_pcnt,le.populated_best_ssn_pcnt,le.populated_data_state_pcnt,le.populated_provider_id_pcnt,le.populated_npi_pcnt,le.populated_taxonomy_pcnt,le.populated_provider_name_pcnt,le.populated_provider_address_pcnt,le.populated_phone_pcnt,le.populated_entity_type_code_pcnt,le.populated_firstname_pcnt,le.populated_lastname_pcnt,le.populated_companyname_pcnt,le.populated_src_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_source_rid_pcnt,le.populated_lnpid_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_type_pcnt,le.populated_nid_pcnt,le.populated_clean_clinic_name_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prepped_addr2_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_clean_phone_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_best_dob,le.maxlength_best_ssn,le.maxlength_data_state,le.maxlength_provider_id,le.maxlength_npi,le.maxlength_taxonomy,le.maxlength_provider_name,le.maxlength_provider_address,le.maxlength_phone,le.maxlength_entity_type_code,le.maxlength_firstname,le.maxlength_lastname,le.maxlength_companyname,le.maxlength_src,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_record_type,le.maxlength_source_rid,le.maxlength_lnpid,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_type,le.maxlength_nid,le.maxlength_clean_clinic_name,le.maxlength_prepped_addr1,le.maxlength_prepped_addr2,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_clean_phone,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_best_dob,le.avelength_best_ssn,le.avelength_data_state,le.avelength_provider_id,le.avelength_npi,le.avelength_taxonomy,le.avelength_provider_name,le.avelength_provider_address,le.avelength_phone,le.avelength_entity_type_code,le.avelength_firstname,le.avelength_lastname,le.avelength_companyname,le.avelength_src,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_record_type,le.avelength_source_rid,le.avelength_lnpid,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_type,le.avelength_nid,le.avelength_clean_clinic_name,le.avelength_prepped_addr1,le.avelength_prepped_addr2,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_aceaid,le.avelength_clean_phone,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 86, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.data_state),TRIM((SALT31.StrType)le.provider_id),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.taxonomy),TRIM((SALT31.StrType)le.provider_name),TRIM((SALT31.StrType)le.provider_address),TRIM((SALT31.StrType)le.phone),TRIM((SALT31.StrType)le.entity_type_code),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.companyname),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,86,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 86);
  SELF.FldNo2 := 1 + (C % 86);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.data_state),TRIM((SALT31.StrType)le.provider_id),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.taxonomy),TRIM((SALT31.StrType)le.provider_name),TRIM((SALT31.StrType)le.provider_address),TRIM((SALT31.StrType)le.phone),TRIM((SALT31.StrType)le.entity_type_code),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.companyname),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.data_state),TRIM((SALT31.StrType)le.provider_id),TRIM((SALT31.StrType)le.npi),TRIM((SALT31.StrType)le.taxonomy),TRIM((SALT31.StrType)le.provider_name),TRIM((SALT31.StrType)le.provider_address),TRIM((SALT31.StrType)le.phone),TRIM((SALT31.StrType)le.entity_type_code),TRIM((SALT31.StrType)le.firstname),TRIM((SALT31.StrType)le.lastname),TRIM((SALT31.StrType)le.companyname),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.title),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.name_type),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_clinic_name),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),86*86,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'did'}
      ,{2,'did_score'}
      ,{3,'bdid'}
      ,{4,'bdid_score'}
      ,{5,'best_dob'}
      ,{6,'best_ssn'}
      ,{7,'data_state'}
      ,{8,'provider_id'}
      ,{9,'npi'}
      ,{10,'taxonomy'}
      ,{11,'provider_name'}
      ,{12,'provider_address'}
      ,{13,'phone'}
      ,{14,'entity_type_code'}
      ,{15,'firstname'}
      ,{16,'lastname'}
      ,{17,'companyname'}
      ,{18,'src'}
      ,{19,'dt_vendor_first_reported'}
      ,{20,'dt_vendor_last_reported'}
      ,{21,'dt_first_seen'}
      ,{22,'dt_last_seen'}
      ,{23,'record_type'}
      ,{24,'source_rid'}
      ,{25,'lnpid'}
      ,{26,'title'}
      ,{27,'fname'}
      ,{28,'mname'}
      ,{29,'lname'}
      ,{30,'name_suffix'}
      ,{31,'name_type'}
      ,{32,'nid'}
      ,{33,'clean_clinic_name'}
      ,{34,'prepped_addr1'}
      ,{35,'prepped_addr2'}
      ,{36,'prim_range'}
      ,{37,'predir'}
      ,{38,'prim_name'}
      ,{39,'addr_suffix'}
      ,{40,'postdir'}
      ,{41,'unit_desig'}
      ,{42,'sec_range'}
      ,{43,'p_city_name'}
      ,{44,'v_city_name'}
      ,{45,'st'}
      ,{46,'zip'}
      ,{47,'zip4'}
      ,{48,'cart'}
      ,{49,'cr_sort_sz'}
      ,{50,'lot'}
      ,{51,'lot_order'}
      ,{52,'dbpc'}
      ,{53,'chk_digit'}
      ,{54,'rec_type'}
      ,{55,'fips_st'}
      ,{56,'fips_county'}
      ,{57,'geo_lat'}
      ,{58,'geo_long'}
      ,{59,'msa'}
      ,{60,'geo_blk'}
      ,{61,'geo_match'}
      ,{62,'err_stat'}
      ,{63,'rawaid'}
      ,{64,'aceaid'}
      ,{65,'clean_phone'}
      ,{66,'dotid'}
      ,{67,'dotscore'}
      ,{68,'dotweight'}
      ,{69,'empid'}
      ,{70,'empscore'}
      ,{71,'empweight'}
      ,{72,'powid'}
      ,{73,'powscore'}
      ,{74,'powweight'}
      ,{75,'proxid'}
      ,{76,'proxscore'}
      ,{77,'proxweight'}
      ,{78,'seleid'}
      ,{79,'selescore'}
      ,{80,'seleweight'}
      ,{81,'orgid'}
      ,{82,'orgscore'}
      ,{83,'orgweight'}
      ,{84,'ultid'}
      ,{85,'ultscore'}
      ,{86,'ultweight'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_did((SALT31.StrType)le.did),
    Fields.InValid_did_score((SALT31.StrType)le.did_score),
    Fields.InValid_bdid((SALT31.StrType)le.bdid),
    Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score),
    Fields.InValid_best_dob((SALT31.StrType)le.best_dob),
    Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn),
    Fields.InValid_data_state((SALT31.StrType)le.data_state),
    Fields.InValid_provider_id((SALT31.StrType)le.provider_id),
    Fields.InValid_npi((SALT31.StrType)le.npi),
    Fields.InValid_taxonomy((SALT31.StrType)le.taxonomy),
    Fields.InValid_provider_name((SALT31.StrType)le.provider_name),
    Fields.InValid_provider_address((SALT31.StrType)le.provider_address),
    Fields.InValid_phone((SALT31.StrType)le.phone),
    Fields.InValid_entity_type_code((SALT31.StrType)le.entity_type_code),
    Fields.InValid_firstname((SALT31.StrType)le.firstname),
    Fields.InValid_lastname((SALT31.StrType)le.lastname),
    Fields.InValid_companyname((SALT31.StrType)le.companyname),
    Fields.InValid_src((SALT31.StrType)le.src),
    Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen),
    Fields.InValid_record_type((SALT31.StrType)le.record_type),
    Fields.InValid_source_rid((SALT31.StrType)le.source_rid),
    Fields.InValid_lnpid((SALT31.StrType)le.lnpid),
    Fields.InValid_title((SALT31.StrType)le.title),
    Fields.InValid_fname((SALT31.StrType)le.fname),
    Fields.InValid_mname((SALT31.StrType)le.mname),
    Fields.InValid_lname((SALT31.StrType)le.lname),
    Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix),
    Fields.InValid_name_type((SALT31.StrType)le.name_type),
    Fields.InValid_nid((SALT31.StrType)le.nid),
    Fields.InValid_clean_clinic_name((SALT31.StrType)le.clean_clinic_name),
    Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1),
    Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2),
    Fields.InValid_prim_range((SALT31.StrType)le.prim_range),
    Fields.InValid_predir((SALT31.StrType)le.predir),
    Fields.InValid_prim_name((SALT31.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT31.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT31.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name),
    Fields.InValid_st((SALT31.StrType)le.st),
    Fields.InValid_zip((SALT31.StrType)le.zip),
    Fields.InValid_zip4((SALT31.StrType)le.zip4),
    Fields.InValid_cart((SALT31.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT31.StrType)le.lot),
    Fields.InValid_lot_order((SALT31.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT31.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT31.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT31.StrType)le.rec_type),
    Fields.InValid_fips_st((SALT31.StrType)le.fips_st),
    Fields.InValid_fips_county((SALT31.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT31.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT31.StrType)le.geo_long),
    Fields.InValid_msa((SALT31.StrType)le.msa),
    Fields.InValid_geo_blk((SALT31.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT31.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT31.StrType)le.err_stat),
    Fields.InValid_rawaid((SALT31.StrType)le.rawaid),
    Fields.InValid_aceaid((SALT31.StrType)le.aceaid),
    Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone),
    Fields.InValid_dotid((SALT31.StrType)le.dotid),
    Fields.InValid_dotscore((SALT31.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT31.StrType)le.dotweight),
    Fields.InValid_empid((SALT31.StrType)le.empid),
    Fields.InValid_empscore((SALT31.StrType)le.empscore),
    Fields.InValid_empweight((SALT31.StrType)le.empweight),
    Fields.InValid_powid((SALT31.StrType)le.powid),
    Fields.InValid_powscore((SALT31.StrType)le.powscore),
    Fields.InValid_powweight((SALT31.StrType)le.powweight),
    Fields.InValid_proxid((SALT31.StrType)le.proxid),
    Fields.InValid_proxscore((SALT31.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT31.StrType)le.proxweight),
    Fields.InValid_seleid((SALT31.StrType)le.seleid),
    Fields.InValid_selescore((SALT31.StrType)le.selescore),
    Fields.InValid_seleweight((SALT31.StrType)le.seleweight),
    Fields.InValid_orgid((SALT31.StrType)le.orgid),
    Fields.InValid_orgscore((SALT31.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT31.StrType)le.orgweight),
    Fields.InValid_ultid((SALT31.StrType)le.ultid),
    Fields.InValid_ultscore((SALT31.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT31.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,86,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'did','did_score','bdid','bdid_score','best_dob','best_ssn','data_state','provider_id','npi','taxonomy','provider_name','provider_address','phone','entity_type_code','firstname','lastname','companyname','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Fields.InValidMessage_best_dob(TotalErrors.ErrorNum),Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_data_state(TotalErrors.ErrorNum),Fields.InValidMessage_provider_id(TotalErrors.ErrorNum),Fields.InValidMessage_npi(TotalErrors.ErrorNum),Fields.InValidMessage_taxonomy(TotalErrors.ErrorNum),Fields.InValidMessage_provider_name(TotalErrors.ErrorNum),Fields.InValidMessage_provider_address(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_entity_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_companyname(TotalErrors.ErrorNum),Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_source_rid(TotalErrors.ErrorNum),Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_nid(TotalErrors.ErrorNum),Fields.InValidMessage_clean_clinic_name(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
