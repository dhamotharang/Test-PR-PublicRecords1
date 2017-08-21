IMPORT ut,SALT31;
EXPORT Individuals_hygiene(dataset(Individuals_layout_Individuals) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_hms_piid_pcnt := AVE(GROUP,IF(h.hms_piid = (TYPEOF(h.hms_piid))'',0,100));
    maxlength_hms_piid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hms_piid)));
    avelength_hms_piid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hms_piid)),h.hms_piid<>(typeof(h.hms_piid))'');
    populated_first_pcnt := AVE(GROUP,IF(h.first = (TYPEOF(h.first))'',0,100));
    maxlength_first := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.first)));
    avelength_first := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.first)),h.first<>(typeof(h.first))'');
    populated_middle_pcnt := AVE(GROUP,IF(h.middle = (TYPEOF(h.middle))'',0,100));
    maxlength_middle := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.middle)));
    avelength_middle := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.middle)),h.middle<>(typeof(h.middle))'');
    populated_last_pcnt := AVE(GROUP,IF(h.last = (TYPEOF(h.last))'',0,100));
    maxlength_last := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.last)));
    avelength_last := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.last)),h.last<>(typeof(h.last))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_cred_pcnt := AVE(GROUP,IF(h.cred = (TYPEOF(h.cred))'',0,100));
    maxlength_cred := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cred)));
    avelength_cred := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cred)),h.cred<>(typeof(h.cred))'');
    populated_practitioner_type_pcnt := AVE(GROUP,IF(h.practitioner_type = (TYPEOF(h.practitioner_type))'',0,100));
    maxlength_practitioner_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.practitioner_type)));
    avelength_practitioner_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.practitioner_type)),h.practitioner_type<>(typeof(h.practitioner_type))'');
    populated_active_pcnt := AVE(GROUP,IF(h.active = (TYPEOF(h.active))'',0,100));
    maxlength_active := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.active)));
    avelength_active := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.active)),h.active<>(typeof(h.active))'');
    populated_vendible_pcnt := AVE(GROUP,IF(h.vendible = (TYPEOF(h.vendible))'',0,100));
    maxlength_vendible := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.vendible)));
    avelength_vendible := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.vendible)),h.vendible<>(typeof(h.vendible))'');
    populated_npi_num_pcnt := AVE(GROUP,IF(h.npi_num = (TYPEOF(h.npi_num))'',0,100));
    maxlength_npi_num := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_num)));
    avelength_npi_num := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_num)),h.npi_num<>(typeof(h.npi_num))'');
    populated_npi_enumeration_date_pcnt := AVE(GROUP,IF(h.npi_enumeration_date = (TYPEOF(h.npi_enumeration_date))'',0,100));
    maxlength_npi_enumeration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_enumeration_date)));
    avelength_npi_enumeration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_enumeration_date)),h.npi_enumeration_date<>(typeof(h.npi_enumeration_date))'');
    populated_npi_deactivation_date_pcnt := AVE(GROUP,IF(h.npi_deactivation_date = (TYPEOF(h.npi_deactivation_date))'',0,100));
    maxlength_npi_deactivation_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_deactivation_date)));
    avelength_npi_deactivation_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_deactivation_date)),h.npi_deactivation_date<>(typeof(h.npi_deactivation_date))'');
    populated_npi_reactivation_date_pcnt := AVE(GROUP,IF(h.npi_reactivation_date = (TYPEOF(h.npi_reactivation_date))'',0,100));
    maxlength_npi_reactivation_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_reactivation_date)));
    avelength_npi_reactivation_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_reactivation_date)),h.npi_reactivation_date<>(typeof(h.npi_reactivation_date))'');
    populated_npi_taxonomy_code_pcnt := AVE(GROUP,IF(h.npi_taxonomy_code = (TYPEOF(h.npi_taxonomy_code))'',0,100));
    maxlength_npi_taxonomy_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_taxonomy_code)));
    avelength_npi_taxonomy_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.npi_taxonomy_code)),h.npi_taxonomy_code<>(typeof(h.npi_taxonomy_code))'');
    populated_upin_pcnt := AVE(GROUP,IF(h.upin = (TYPEOF(h.upin))'',0,100));
    maxlength_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.upin)));
    avelength_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.upin)),h.upin<>(typeof(h.upin))'');
    populated_medicare_participation_flag_pcnt := AVE(GROUP,IF(h.medicare_participation_flag = (TYPEOF(h.medicare_participation_flag))'',0,100));
    maxlength_medicare_participation_flag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicare_participation_flag)));
    avelength_medicare_participation_flag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.medicare_participation_flag)),h.medicare_participation_flag<>(typeof(h.medicare_participation_flag))'');
    populated_date_born_pcnt := AVE(GROUP,IF(h.date_born = (TYPEOF(h.date_born))'',0,100));
    maxlength_date_born := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_born)));
    avelength_date_born := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_born)),h.date_born<>(typeof(h.date_born))'');
    populated_date_died_pcnt := AVE(GROUP,IF(h.date_died = (TYPEOF(h.date_died))'',0,100));
    maxlength_date_died := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_died)));
    avelength_date_died := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_died)),h.date_died<>(typeof(h.date_died))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_source_rid_pcnt := AVE(GROUP,IF(h.source_rid = (TYPEOF(h.source_rid))'',0,100));
    maxlength_source_rid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_rid)));
    avelength_source_rid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.source_rid)),h.source_rid<>(typeof(h.source_rid))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
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
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_clean_npi_enumeration_date_pcnt := AVE(GROUP,IF(h.clean_npi_enumeration_date = (TYPEOF(h.clean_npi_enumeration_date))'',0,100));
    maxlength_clean_npi_enumeration_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_npi_enumeration_date)));
    avelength_clean_npi_enumeration_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_npi_enumeration_date)),h.clean_npi_enumeration_date<>(typeof(h.clean_npi_enumeration_date))'');
    populated_clean_npi_deactivation_date_pcnt := AVE(GROUP,IF(h.clean_npi_deactivation_date = (TYPEOF(h.clean_npi_deactivation_date))'',0,100));
    maxlength_clean_npi_deactivation_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_npi_deactivation_date)));
    avelength_clean_npi_deactivation_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_npi_deactivation_date)),h.clean_npi_deactivation_date<>(typeof(h.clean_npi_deactivation_date))'');
    populated_clean_npi_reactivation_date_pcnt := AVE(GROUP,IF(h.clean_npi_reactivation_date = (TYPEOF(h.clean_npi_reactivation_date))'',0,100));
    maxlength_clean_npi_reactivation_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_npi_reactivation_date)));
    avelength_clean_npi_reactivation_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_npi_reactivation_date)),h.clean_npi_reactivation_date<>(typeof(h.clean_npi_reactivation_date))'');
    populated_clean_date_born_pcnt := AVE(GROUP,IF(h.clean_date_born = (TYPEOF(h.clean_date_born))'',0,100));
    maxlength_clean_date_born := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_date_born)));
    avelength_clean_date_born := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_date_born)),h.clean_date_born<>(typeof(h.clean_date_born))'');
    populated_clean_date_died_pcnt := AVE(GROUP,IF(h.clean_date_died = (TYPEOF(h.clean_date_died))'',0,100));
    maxlength_clean_date_died := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_date_died)));
    avelength_clean_date_died := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_date_died)),h.clean_date_died<>(typeof(h.clean_date_died))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
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
    populated_firm_name_pcnt := AVE(GROUP,IF(h.firm_name = (TYPEOF(h.firm_name))'',0,100));
    maxlength_firm_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.firm_name)));
    avelength_firm_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.firm_name)),h.firm_name<>(typeof(h.firm_name))'');
    populated_lid_pcnt := AVE(GROUP,IF(h.lid = (TYPEOF(h.lid))'',0,100));
    maxlength_lid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lid)));
    avelength_lid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lid)),h.lid<>(typeof(h.lid))'');
    populated_agid_pcnt := AVE(GROUP,IF(h.agid = (TYPEOF(h.agid))'',0,100));
    maxlength_agid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.agid)));
    avelength_agid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.agid)),h.agid<>(typeof(h.agid))'');
    populated_address_std_code_pcnt := AVE(GROUP,IF(h.address_std_code = (TYPEOF(h.address_std_code))'',0,100));
    maxlength_address_std_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_std_code)));
    avelength_address_std_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.address_std_code)),h.address_std_code<>(typeof(h.address_std_code))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_addr_type_pcnt := AVE(GROUP,IF(h.addr_type = (TYPEOF(h.addr_type))'',0,100));
    maxlength_addr_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_type)));
    avelength_addr_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.addr_type)),h.addr_type<>(typeof(h.addr_type))'');
    populated_state_license_state_pcnt := AVE(GROUP,IF(h.state_license_state = (TYPEOF(h.state_license_state))'',0,100));
    maxlength_state_license_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_state)));
    avelength_state_license_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_state)),h.state_license_state<>(typeof(h.state_license_state))'');
    populated_state_license_number_pcnt := AVE(GROUP,IF(h.state_license_number = (TYPEOF(h.state_license_number))'',0,100));
    maxlength_state_license_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_number)));
    avelength_state_license_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_number)),h.state_license_number<>(typeof(h.state_license_number))'');
    populated_state_license_type_pcnt := AVE(GROUP,IF(h.state_license_type = (TYPEOF(h.state_license_type))'',0,100));
    maxlength_state_license_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_type)));
    avelength_state_license_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_type)),h.state_license_type<>(typeof(h.state_license_type))'');
    populated_state_license_active_pcnt := AVE(GROUP,IF(h.state_license_active = (TYPEOF(h.state_license_active))'',0,100));
    maxlength_state_license_active := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_active)));
    avelength_state_license_active := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_active)),h.state_license_active<>(typeof(h.state_license_active))'');
    populated_state_license_expire_pcnt := AVE(GROUP,IF(h.state_license_expire = (TYPEOF(h.state_license_expire))'',0,100));
    maxlength_state_license_expire := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_expire)));
    avelength_state_license_expire := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_expire)),h.state_license_expire<>(typeof(h.state_license_expire))'');
    populated_state_license_qualifier_pcnt := AVE(GROUP,IF(h.state_license_qualifier = (TYPEOF(h.state_license_qualifier))'',0,100));
    maxlength_state_license_qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_qualifier)));
    avelength_state_license_qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_qualifier)),h.state_license_qualifier<>(typeof(h.state_license_qualifier))'');
    populated_state_license_sub_qualifier_pcnt := AVE(GROUP,IF(h.state_license_sub_qualifier = (TYPEOF(h.state_license_sub_qualifier))'',0,100));
    maxlength_state_license_sub_qualifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_sub_qualifier)));
    avelength_state_license_sub_qualifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_sub_qualifier)),h.state_license_sub_qualifier<>(typeof(h.state_license_sub_qualifier))'');
    populated_state_license_issued_pcnt := AVE(GROUP,IF(h.state_license_issued = (TYPEOF(h.state_license_issued))'',0,100));
    maxlength_state_license_issued := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_issued)));
    avelength_state_license_issued := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.state_license_issued)),h.state_license_issued<>(typeof(h.state_license_issued))'');
    populated_clean_state_license_expire_pcnt := AVE(GROUP,IF(h.clean_state_license_expire = (TYPEOF(h.clean_state_license_expire))'',0,100));
    maxlength_clean_state_license_expire := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_state_license_expire)));
    avelength_clean_state_license_expire := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_state_license_expire)),h.clean_state_license_expire<>(typeof(h.clean_state_license_expire))'');
    populated_clean_state_license_issued_pcnt := AVE(GROUP,IF(h.clean_state_license_issued = (TYPEOF(h.clean_state_license_issued))'',0,100));
    maxlength_clean_state_license_issued := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_state_license_issued)));
    avelength_clean_state_license_issued := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_state_license_issued)),h.clean_state_license_issued<>(typeof(h.clean_state_license_issued))'');
    populated_dea_num_pcnt := AVE(GROUP,IF(h.dea_num = (TYPEOF(h.dea_num))'',0,100));
    maxlength_dea_num := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_num)));
    avelength_dea_num := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_num)),h.dea_num<>(typeof(h.dea_num))'');
    populated_dea_bac_pcnt := AVE(GROUP,IF(h.dea_bac = (TYPEOF(h.dea_bac))'',0,100));
    maxlength_dea_bac := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_bac)));
    avelength_dea_bac := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_bac)),h.dea_bac<>(typeof(h.dea_bac))'');
    populated_dea_sub_bac_pcnt := AVE(GROUP,IF(h.dea_sub_bac = (TYPEOF(h.dea_sub_bac))'',0,100));
    maxlength_dea_sub_bac := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_sub_bac)));
    avelength_dea_sub_bac := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_sub_bac)),h.dea_sub_bac<>(typeof(h.dea_sub_bac))'');
    populated_dea_schedule_pcnt := AVE(GROUP,IF(h.dea_schedule = (TYPEOF(h.dea_schedule))'',0,100));
    maxlength_dea_schedule := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_schedule)));
    avelength_dea_schedule := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_schedule)),h.dea_schedule<>(typeof(h.dea_schedule))'');
    populated_dea_expire_pcnt := AVE(GROUP,IF(h.dea_expire = (TYPEOF(h.dea_expire))'',0,100));
    maxlength_dea_expire := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_expire)));
    avelength_dea_expire := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_expire)),h.dea_expire<>(typeof(h.dea_expire))'');
    populated_dea_active_pcnt := AVE(GROUP,IF(h.dea_active = (TYPEOF(h.dea_active))'',0,100));
    maxlength_dea_active := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_active)));
    avelength_dea_active := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dea_active)),h.dea_active<>(typeof(h.dea_active))'');
    populated_clean_dea_expire_pcnt := AVE(GROUP,IF(h.clean_dea_expire = (TYPEOF(h.clean_dea_expire))'',0,100));
    maxlength_clean_dea_expire := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dea_expire)));
    avelength_clean_dea_expire := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dea_expire)),h.clean_dea_expire<>(typeof(h.clean_dea_expire))'');
    populated_csr_number_pcnt := AVE(GROUP,IF(h.csr_number = (TYPEOF(h.csr_number))'',0,100));
    maxlength_csr_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_number)));
    avelength_csr_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_number)),h.csr_number<>(typeof(h.csr_number))'');
    populated_csr_state_pcnt := AVE(GROUP,IF(h.csr_state = (TYPEOF(h.csr_state))'',0,100));
    maxlength_csr_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_state)));
    avelength_csr_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_state)),h.csr_state<>(typeof(h.csr_state))'');
    populated_csr_expire_date_pcnt := AVE(GROUP,IF(h.csr_expire_date = (TYPEOF(h.csr_expire_date))'',0,100));
    maxlength_csr_expire_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_expire_date)));
    avelength_csr_expire_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_expire_date)),h.csr_expire_date<>(typeof(h.csr_expire_date))'');
    populated_csr_issue_date_pcnt := AVE(GROUP,IF(h.csr_issue_date = (TYPEOF(h.csr_issue_date))'',0,100));
    maxlength_csr_issue_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_issue_date)));
    avelength_csr_issue_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_issue_date)),h.csr_issue_date<>(typeof(h.csr_issue_date))'');
    populated_dsa_lvl_2_pcnt := AVE(GROUP,IF(h.dsa_lvl_2 = (TYPEOF(h.dsa_lvl_2))'',0,100));
    maxlength_dsa_lvl_2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_2)));
    avelength_dsa_lvl_2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_2)),h.dsa_lvl_2<>(typeof(h.dsa_lvl_2))'');
    populated_dsa_lvl_2n_pcnt := AVE(GROUP,IF(h.dsa_lvl_2n = (TYPEOF(h.dsa_lvl_2n))'',0,100));
    maxlength_dsa_lvl_2n := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_2n)));
    avelength_dsa_lvl_2n := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_2n)),h.dsa_lvl_2n<>(typeof(h.dsa_lvl_2n))'');
    populated_dsa_lvl_3_pcnt := AVE(GROUP,IF(h.dsa_lvl_3 = (TYPEOF(h.dsa_lvl_3))'',0,100));
    maxlength_dsa_lvl_3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_3)));
    avelength_dsa_lvl_3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_3)),h.dsa_lvl_3<>(typeof(h.dsa_lvl_3))'');
    populated_dsa_lvl_3n_pcnt := AVE(GROUP,IF(h.dsa_lvl_3n = (TYPEOF(h.dsa_lvl_3n))'',0,100));
    maxlength_dsa_lvl_3n := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_3n)));
    avelength_dsa_lvl_3n := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_3n)),h.dsa_lvl_3n<>(typeof(h.dsa_lvl_3n))'');
    populated_dsa_lvl_4_pcnt := AVE(GROUP,IF(h.dsa_lvl_4 = (TYPEOF(h.dsa_lvl_4))'',0,100));
    maxlength_dsa_lvl_4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_4)));
    avelength_dsa_lvl_4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_4)),h.dsa_lvl_4<>(typeof(h.dsa_lvl_4))'');
    populated_dsa_lvl_5_pcnt := AVE(GROUP,IF(h.dsa_lvl_5 = (TYPEOF(h.dsa_lvl_5))'',0,100));
    maxlength_dsa_lvl_5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_5)));
    avelength_dsa_lvl_5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dsa_lvl_5)),h.dsa_lvl_5<>(typeof(h.dsa_lvl_5))'');
    populated_csr_raw1_pcnt := AVE(GROUP,IF(h.csr_raw1 = (TYPEOF(h.csr_raw1))'',0,100));
    maxlength_csr_raw1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw1)));
    avelength_csr_raw1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw1)),h.csr_raw1<>(typeof(h.csr_raw1))'');
    populated_csr_raw2_pcnt := AVE(GROUP,IF(h.csr_raw2 = (TYPEOF(h.csr_raw2))'',0,100));
    maxlength_csr_raw2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw2)));
    avelength_csr_raw2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw2)),h.csr_raw2<>(typeof(h.csr_raw2))'');
    populated_csr_raw3_pcnt := AVE(GROUP,IF(h.csr_raw3 = (TYPEOF(h.csr_raw3))'',0,100));
    maxlength_csr_raw3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw3)));
    avelength_csr_raw3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw3)),h.csr_raw3<>(typeof(h.csr_raw3))'');
    populated_csr_raw4_pcnt := AVE(GROUP,IF(h.csr_raw4 = (TYPEOF(h.csr_raw4))'',0,100));
    maxlength_csr_raw4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw4)));
    avelength_csr_raw4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.csr_raw4)),h.csr_raw4<>(typeof(h.csr_raw4))'');
    populated_clean_csr_expire_date_pcnt := AVE(GROUP,IF(h.clean_csr_expire_date = (TYPEOF(h.clean_csr_expire_date))'',0,100));
    maxlength_clean_csr_expire_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_csr_expire_date)));
    avelength_clean_csr_expire_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_csr_expire_date)),h.clean_csr_expire_date<>(typeof(h.clean_csr_expire_date))'');
    populated_clean_csr_issue_date_pcnt := AVE(GROUP,IF(h.clean_csr_issue_date = (TYPEOF(h.clean_csr_issue_date))'',0,100));
    maxlength_clean_csr_issue_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_csr_issue_date)));
    avelength_clean_csr_issue_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_csr_issue_date)),h.clean_csr_issue_date<>(typeof(h.clean_csr_issue_date))'');
    populated_sanction_id_pcnt := AVE(GROUP,IF(h.sanction_id = (TYPEOF(h.sanction_id))'',0,100));
    maxlength_sanction_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_id)));
    avelength_sanction_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_id)),h.sanction_id<>(typeof(h.sanction_id))'');
    populated_sanction_action_code_pcnt := AVE(GROUP,IF(h.sanction_action_code = (TYPEOF(h.sanction_action_code))'',0,100));
    maxlength_sanction_action_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_action_code)));
    avelength_sanction_action_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_action_code)),h.sanction_action_code<>(typeof(h.sanction_action_code))'');
    populated_sanction_action_description_pcnt := AVE(GROUP,IF(h.sanction_action_description = (TYPEOF(h.sanction_action_description))'',0,100));
    maxlength_sanction_action_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_action_description)));
    avelength_sanction_action_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_action_description)),h.sanction_action_description<>(typeof(h.sanction_action_description))'');
    populated_sanction_board_code_pcnt := AVE(GROUP,IF(h.sanction_board_code = (TYPEOF(h.sanction_board_code))'',0,100));
    maxlength_sanction_board_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_board_code)));
    avelength_sanction_board_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_board_code)),h.sanction_board_code<>(typeof(h.sanction_board_code))'');
    populated_sanction_board_description_pcnt := AVE(GROUP,IF(h.sanction_board_description = (TYPEOF(h.sanction_board_description))'',0,100));
    maxlength_sanction_board_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_board_description)));
    avelength_sanction_board_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_board_description)),h.sanction_board_description<>(typeof(h.sanction_board_description))'');
    populated_action_date_pcnt := AVE(GROUP,IF(h.action_date = (TYPEOF(h.action_date))'',0,100));
    maxlength_action_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_date)));
    avelength_action_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.action_date)),h.action_date<>(typeof(h.action_date))'');
    populated_sanction_period_start_date_pcnt := AVE(GROUP,IF(h.sanction_period_start_date = (TYPEOF(h.sanction_period_start_date))'',0,100));
    maxlength_sanction_period_start_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_period_start_date)));
    avelength_sanction_period_start_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_period_start_date)),h.sanction_period_start_date<>(typeof(h.sanction_period_start_date))'');
    populated_sanction_period_end_date_pcnt := AVE(GROUP,IF(h.sanction_period_end_date = (TYPEOF(h.sanction_period_end_date))'',0,100));
    maxlength_sanction_period_end_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_period_end_date)));
    avelength_sanction_period_end_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sanction_period_end_date)),h.sanction_period_end_date<>(typeof(h.sanction_period_end_date))'');
    populated_month_duration_pcnt := AVE(GROUP,IF(h.month_duration = (TYPEOF(h.month_duration))'',0,100));
    maxlength_month_duration := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.month_duration)));
    avelength_month_duration := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.month_duration)),h.month_duration<>(typeof(h.month_duration))'');
    populated_fine_amount_pcnt := AVE(GROUP,IF(h.fine_amount = (TYPEOF(h.fine_amount))'',0,100));
    maxlength_fine_amount := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fine_amount)));
    avelength_fine_amount := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fine_amount)),h.fine_amount<>(typeof(h.fine_amount))'');
    populated_offense_code_pcnt := AVE(GROUP,IF(h.offense_code = (TYPEOF(h.offense_code))'',0,100));
    maxlength_offense_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_code)));
    avelength_offense_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_code)),h.offense_code<>(typeof(h.offense_code))'');
    populated_offense_description_pcnt := AVE(GROUP,IF(h.offense_description = (TYPEOF(h.offense_description))'',0,100));
    maxlength_offense_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_description)));
    avelength_offense_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_description)),h.offense_description<>(typeof(h.offense_description))'');
    populated_offense_date_pcnt := AVE(GROUP,IF(h.offense_date = (TYPEOF(h.offense_date))'',0,100));
    maxlength_offense_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_date)));
    avelength_offense_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.offense_date)),h.offense_date<>(typeof(h.offense_date))'');
    populated_clean_offense_date_pcnt := AVE(GROUP,IF(h.clean_offense_date = (TYPEOF(h.clean_offense_date))'',0,100));
    maxlength_clean_offense_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_offense_date)));
    avelength_clean_offense_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_offense_date)),h.clean_offense_date<>(typeof(h.clean_offense_date))'');
    populated_clean_action_date_pcnt := AVE(GROUP,IF(h.clean_action_date = (TYPEOF(h.clean_action_date))'',0,100));
    maxlength_clean_action_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_action_date)));
    avelength_clean_action_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_action_date)),h.clean_action_date<>(typeof(h.clean_action_date))'');
    populated_clean_sanction_period_start_date_pcnt := AVE(GROUP,IF(h.clean_sanction_period_start_date = (TYPEOF(h.clean_sanction_period_start_date))'',0,100));
    maxlength_clean_sanction_period_start_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_sanction_period_start_date)));
    avelength_clean_sanction_period_start_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_sanction_period_start_date)),h.clean_sanction_period_start_date<>(typeof(h.clean_sanction_period_start_date))'');
    populated_clean_sanction_period_end_date_pcnt := AVE(GROUP,IF(h.clean_sanction_period_end_date = (TYPEOF(h.clean_sanction_period_end_date))'',0,100));
    maxlength_clean_sanction_period_end_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_sanction_period_end_date)));
    avelength_clean_sanction_period_end_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_sanction_period_end_date)),h.clean_sanction_period_end_date<>(typeof(h.clean_sanction_period_end_date))'');
    populated_gsa_sanction_id_pcnt := AVE(GROUP,IF(h.gsa_sanction_id = (TYPEOF(h.gsa_sanction_id))'',0,100));
    maxlength_gsa_sanction_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_sanction_id)));
    avelength_gsa_sanction_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_sanction_id)),h.gsa_sanction_id<>(typeof(h.gsa_sanction_id))'');
    populated_gsa_first_pcnt := AVE(GROUP,IF(h.gsa_first = (TYPEOF(h.gsa_first))'',0,100));
    maxlength_gsa_first := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_first)));
    avelength_gsa_first := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_first)),h.gsa_first<>(typeof(h.gsa_first))'');
    populated_gsa_middle_pcnt := AVE(GROUP,IF(h.gsa_middle = (TYPEOF(h.gsa_middle))'',0,100));
    maxlength_gsa_middle := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_middle)));
    avelength_gsa_middle := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_middle)),h.gsa_middle<>(typeof(h.gsa_middle))'');
    populated_gsa_last_pcnt := AVE(GROUP,IF(h.gsa_last = (TYPEOF(h.gsa_last))'',0,100));
    maxlength_gsa_last := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_last)));
    avelength_gsa_last := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_last)),h.gsa_last<>(typeof(h.gsa_last))'');
    populated_gsa_suffix_pcnt := AVE(GROUP,IF(h.gsa_suffix = (TYPEOF(h.gsa_suffix))'',0,100));
    maxlength_gsa_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_suffix)));
    avelength_gsa_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_suffix)),h.gsa_suffix<>(typeof(h.gsa_suffix))'');
    populated_gsa_city_pcnt := AVE(GROUP,IF(h.gsa_city = (TYPEOF(h.gsa_city))'',0,100));
    maxlength_gsa_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_city)));
    avelength_gsa_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_city)),h.gsa_city<>(typeof(h.gsa_city))'');
    populated_gsa_state_pcnt := AVE(GROUP,IF(h.gsa_state = (TYPEOF(h.gsa_state))'',0,100));
    maxlength_gsa_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_state)));
    avelength_gsa_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_state)),h.gsa_state<>(typeof(h.gsa_state))'');
    populated_gsa_zip_pcnt := AVE(GROUP,IF(h.gsa_zip = (TYPEOF(h.gsa_zip))'',0,100));
    maxlength_gsa_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_zip)));
    avelength_gsa_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.gsa_zip)),h.gsa_zip<>(typeof(h.gsa_zip))'');
    populated_date_pcnt := AVE(GROUP,IF(h.date = (TYPEOF(h.date))'',0,100));
    maxlength_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.date)));
    avelength_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.date)),h.date<>(typeof(h.date))'');
    populated_agency_pcnt := AVE(GROUP,IF(h.agency = (TYPEOF(h.agency))'',0,100));
    maxlength_agency := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.agency)));
    avelength_agency := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.agency)),h.agency<>(typeof(h.agency))'');
    populated_confidence_pcnt := AVE(GROUP,IF(h.confidence = (TYPEOF(h.confidence))'',0,100));
    maxlength_confidence := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.confidence)));
    avelength_confidence := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.confidence)),h.confidence<>(typeof(h.confidence))'');
    populated_clean_gsa_first_pcnt := AVE(GROUP,IF(h.clean_gsa_first = (TYPEOF(h.clean_gsa_first))'',0,100));
    maxlength_clean_gsa_first := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_first)));
    avelength_clean_gsa_first := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_first)),h.clean_gsa_first<>(typeof(h.clean_gsa_first))'');
    populated_clean_gsa_middle_pcnt := AVE(GROUP,IF(h.clean_gsa_middle = (TYPEOF(h.clean_gsa_middle))'',0,100));
    maxlength_clean_gsa_middle := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_middle)));
    avelength_clean_gsa_middle := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_middle)),h.clean_gsa_middle<>(typeof(h.clean_gsa_middle))'');
    populated_clean_gsa_last_pcnt := AVE(GROUP,IF(h.clean_gsa_last = (TYPEOF(h.clean_gsa_last))'',0,100));
    maxlength_clean_gsa_last := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_last)));
    avelength_clean_gsa_last := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_last)),h.clean_gsa_last<>(typeof(h.clean_gsa_last))'');
    populated_clean_gsa_suffix_pcnt := AVE(GROUP,IF(h.clean_gsa_suffix = (TYPEOF(h.clean_gsa_suffix))'',0,100));
    maxlength_clean_gsa_suffix := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_suffix)));
    avelength_clean_gsa_suffix := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_suffix)),h.clean_gsa_suffix<>(typeof(h.clean_gsa_suffix))'');
    populated_clean_gsa_city_pcnt := AVE(GROUP,IF(h.clean_gsa_city = (TYPEOF(h.clean_gsa_city))'',0,100));
    maxlength_clean_gsa_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_city)));
    avelength_clean_gsa_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_city)),h.clean_gsa_city<>(typeof(h.clean_gsa_city))'');
    populated_clean_gsa_state_pcnt := AVE(GROUP,IF(h.clean_gsa_state = (TYPEOF(h.clean_gsa_state))'',0,100));
    maxlength_clean_gsa_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_state)));
    avelength_clean_gsa_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_state)),h.clean_gsa_state<>(typeof(h.clean_gsa_state))'');
    populated_clean_gsa_zip_pcnt := AVE(GROUP,IF(h.clean_gsa_zip = (TYPEOF(h.clean_gsa_zip))'',0,100));
    maxlength_clean_gsa_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_zip)));
    avelength_clean_gsa_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_zip)),h.clean_gsa_zip<>(typeof(h.clean_gsa_zip))'');
    populated_clean_gsa_action_date_pcnt := AVE(GROUP,IF(h.clean_gsa_action_date = (TYPEOF(h.clean_gsa_action_date))'',0,100));
    maxlength_clean_gsa_action_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_action_date)));
    avelength_clean_gsa_action_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_action_date)),h.clean_gsa_action_date<>(typeof(h.clean_gsa_action_date))'');
    populated_clean_gsa_date_pcnt := AVE(GROUP,IF(h.clean_gsa_date = (TYPEOF(h.clean_gsa_date))'',0,100));
    maxlength_clean_gsa_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_date)));
    avelength_clean_gsa_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_gsa_date)),h.clean_gsa_date<>(typeof(h.clean_gsa_date))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_certification_code_pcnt := AVE(GROUP,IF(h.certification_code = (TYPEOF(h.certification_code))'',0,100));
    maxlength_certification_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.certification_code)));
    avelength_certification_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.certification_code)),h.certification_code<>(typeof(h.certification_code))'');
    populated_certification_description_pcnt := AVE(GROUP,IF(h.certification_description = (TYPEOF(h.certification_description))'',0,100));
    maxlength_certification_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.certification_description)));
    avelength_certification_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.certification_description)),h.certification_description<>(typeof(h.certification_description))'');
    populated_board_code_pcnt := AVE(GROUP,IF(h.board_code = (TYPEOF(h.board_code))'',0,100));
    maxlength_board_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.board_code)));
    avelength_board_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.board_code)),h.board_code<>(typeof(h.board_code))'');
    populated_board_description_pcnt := AVE(GROUP,IF(h.board_description = (TYPEOF(h.board_description))'',0,100));
    maxlength_board_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.board_description)));
    avelength_board_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.board_description)),h.board_description<>(typeof(h.board_description))'');
    populated_expiration_year_pcnt := AVE(GROUP,IF(h.expiration_year = (TYPEOF(h.expiration_year))'',0,100));
    maxlength_expiration_year := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.expiration_year)));
    avelength_expiration_year := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.expiration_year)),h.expiration_year<>(typeof(h.expiration_year))'');
    populated_issue_year_pcnt := AVE(GROUP,IF(h.issue_year = (TYPEOF(h.issue_year))'',0,100));
    maxlength_issue_year := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.issue_year)));
    avelength_issue_year := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.issue_year)),h.issue_year<>(typeof(h.issue_year))'');
    populated_renewal_year_pcnt := AVE(GROUP,IF(h.renewal_year = (TYPEOF(h.renewal_year))'',0,100));
    maxlength_renewal_year := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.renewal_year)));
    avelength_renewal_year := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.renewal_year)),h.renewal_year<>(typeof(h.renewal_year))'');
    populated_lifetime_flag_pcnt := AVE(GROUP,IF(h.lifetime_flag = (TYPEOF(h.lifetime_flag))'',0,100));
    maxlength_lifetime_flag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lifetime_flag)));
    avelength_lifetime_flag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lifetime_flag)),h.lifetime_flag<>(typeof(h.lifetime_flag))'');
    populated_covered_recipient_id_pcnt := AVE(GROUP,IF(h.covered_recipient_id = (TYPEOF(h.covered_recipient_id))'',0,100));
    maxlength_covered_recipient_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.covered_recipient_id)));
    avelength_covered_recipient_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.covered_recipient_id)),h.covered_recipient_id<>(typeof(h.covered_recipient_id))'');
    populated_cov_rcp_raw_state_code_pcnt := AVE(GROUP,IF(h.cov_rcp_raw_state_code = (TYPEOF(h.cov_rcp_raw_state_code))'',0,100));
    maxlength_cov_rcp_raw_state_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_state_code)));
    avelength_cov_rcp_raw_state_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_state_code)),h.cov_rcp_raw_state_code<>(typeof(h.cov_rcp_raw_state_code))'');
    populated_cov_rcp_raw_full_name_pcnt := AVE(GROUP,IF(h.cov_rcp_raw_full_name = (TYPEOF(h.cov_rcp_raw_full_name))'',0,100));
    maxlength_cov_rcp_raw_full_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_full_name)));
    avelength_cov_rcp_raw_full_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_full_name)),h.cov_rcp_raw_full_name<>(typeof(h.cov_rcp_raw_full_name))'');
    populated_cov_rcp_raw_attribute1_pcnt := AVE(GROUP,IF(h.cov_rcp_raw_attribute1 = (TYPEOF(h.cov_rcp_raw_attribute1))'',0,100));
    maxlength_cov_rcp_raw_attribute1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute1)));
    avelength_cov_rcp_raw_attribute1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute1)),h.cov_rcp_raw_attribute1<>(typeof(h.cov_rcp_raw_attribute1))'');
    populated_cov_rcp_raw_attribute2_pcnt := AVE(GROUP,IF(h.cov_rcp_raw_attribute2 = (TYPEOF(h.cov_rcp_raw_attribute2))'',0,100));
    maxlength_cov_rcp_raw_attribute2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute2)));
    avelength_cov_rcp_raw_attribute2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute2)),h.cov_rcp_raw_attribute2<>(typeof(h.cov_rcp_raw_attribute2))'');
    populated_cov_rcp_raw_attribute3_pcnt := AVE(GROUP,IF(h.cov_rcp_raw_attribute3 = (TYPEOF(h.cov_rcp_raw_attribute3))'',0,100));
    maxlength_cov_rcp_raw_attribute3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute3)));
    avelength_cov_rcp_raw_attribute3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute3)),h.cov_rcp_raw_attribute3<>(typeof(h.cov_rcp_raw_attribute3))'');
    populated_cov_rcp_raw_attribute4_pcnt := AVE(GROUP,IF(h.cov_rcp_raw_attribute4 = (TYPEOF(h.cov_rcp_raw_attribute4))'',0,100));
    maxlength_cov_rcp_raw_attribute4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute4)));
    avelength_cov_rcp_raw_attribute4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cov_rcp_raw_attribute4)),h.cov_rcp_raw_attribute4<>(typeof(h.cov_rcp_raw_attribute4))'');
    populated_hms_scid_pcnt := AVE(GROUP,IF(h.hms_scid = (TYPEOF(h.hms_scid))'',0,100));
    maxlength_hms_scid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hms_scid)));
    avelength_hms_scid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hms_scid)),h.hms_scid<>(typeof(h.hms_scid))'');
    populated_school_name_pcnt := AVE(GROUP,IF(h.school_name = (TYPEOF(h.school_name))'',0,100));
    maxlength_school_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.school_name)));
    avelength_school_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.school_name)),h.school_name<>(typeof(h.school_name))'');
    populated_grad_year_pcnt := AVE(GROUP,IF(h.grad_year = (TYPEOF(h.grad_year))'',0,100));
    maxlength_grad_year := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.grad_year)));
    avelength_grad_year := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.grad_year)),h.grad_year<>(typeof(h.grad_year))'');
    populated_lang_code_pcnt := AVE(GROUP,IF(h.lang_code = (TYPEOF(h.lang_code))'',0,100));
    maxlength_lang_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.lang_code)));
    avelength_lang_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.lang_code)),h.lang_code<>(typeof(h.lang_code))'');
    populated_language_pcnt := AVE(GROUP,IF(h.language = (TYPEOF(h.language))'',0,100));
    maxlength_language := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.language)));
    avelength_language := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.language)),h.language<>(typeof(h.language))'');
    populated_specialty_description_pcnt := AVE(GROUP,IF(h.specialty_description = (TYPEOF(h.specialty_description))'',0,100));
    maxlength_specialty_description := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialty_description)));
    avelength_specialty_description := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.specialty_description)),h.specialty_description<>(typeof(h.specialty_description))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_clean_dob_pcnt := AVE(GROUP,IF(h.clean_dob = (TYPEOF(h.clean_dob))'',0,100));
    maxlength_clean_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dob)));
    avelength_clean_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_dob)),h.clean_dob<>(typeof(h.clean_dob))'');
    populated_best_dob_pcnt := AVE(GROUP,IF(h.best_dob = (TYPEOF(h.best_dob))'',0,100));
    maxlength_best_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)));
    avelength_best_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_dob)),h.best_dob<>(typeof(h.best_dob))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_rec_deactivated_date_pcnt := AVE(GROUP,IF(h.rec_deactivated_date = (TYPEOF(h.rec_deactivated_date))'',0,100));
    maxlength_rec_deactivated_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.rec_deactivated_date)));
    avelength_rec_deactivated_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.rec_deactivated_date)),h.rec_deactivated_date<>(typeof(h.rec_deactivated_date))'');
    populated_superceeding_piid_pcnt := AVE(GROUP,IF(h.superceeding_piid = (TYPEOF(h.superceeding_piid))'',0,100));
    maxlength_superceeding_piid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.superceeding_piid)));
    avelength_superceeding_piid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.superceeding_piid)),h.superceeding_piid<>(typeof(h.superceeding_piid))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_hms_piid_pcnt *   5.00 / 100 + T.Populated_first_pcnt *   5.00 / 100 + T.Populated_middle_pcnt *   5.00 / 100 + T.Populated_last_pcnt *   5.00 / 100 + T.Populated_suffix_pcnt *   5.00 / 100 + T.Populated_cred_pcnt *   5.00 / 100 + T.Populated_practitioner_type_pcnt *   5.00 / 100 + T.Populated_active_pcnt *   5.00 / 100 + T.Populated_vendible_pcnt *   5.00 / 100 + T.Populated_npi_num_pcnt *   5.00 / 100 + T.Populated_npi_enumeration_date_pcnt *   5.00 / 100 + T.Populated_npi_deactivation_date_pcnt *   5.00 / 100 + T.Populated_npi_reactivation_date_pcnt *   5.00 / 100 + T.Populated_npi_taxonomy_code_pcnt *   5.00 / 100 + T.Populated_upin_pcnt *   5.00 / 100 + T.Populated_medicare_participation_flag_pcnt *   5.00 / 100 + T.Populated_date_born_pcnt *   5.00 / 100 + T.Populated_date_died_pcnt *   5.00 / 100 + T.Populated_pid_pcnt *   5.00 / 100 + T.Populated_src_pcnt *   5.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   5.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   5.00 / 100 + T.Populated_date_first_seen_pcnt *   5.00 / 100 + T.Populated_date_last_seen_pcnt *   5.00 / 100 + T.Populated_record_type_pcnt *   5.00 / 100 + T.Populated_source_rid_pcnt *   5.00 / 100 + T.Populated_lnpid_pcnt *   5.00 / 100 + T.Populated_fname_pcnt *   5.00 / 100 + T.Populated_mname_pcnt *   5.00 / 100 + T.Populated_lname_pcnt *   5.00 / 100 + T.Populated_name_suffix_pcnt *   5.00 / 100 + T.Populated_nametype_pcnt *   5.00 / 100 + T.Populated_nid_pcnt *   5.00 / 100 + T.Populated_clean_npi_enumeration_date_pcnt *   5.00 / 100 + T.Populated_clean_npi_deactivation_date_pcnt *   5.00 / 100 + T.Populated_clean_npi_reactivation_date_pcnt *   5.00 / 100 + T.Populated_clean_date_born_pcnt *   5.00 / 100 + T.Populated_clean_date_died_pcnt *   5.00 / 100 + T.Populated_clean_company_name_pcnt *   5.00 / 100 + T.Populated_prim_range_pcnt *   5.00 / 100 + T.Populated_predir_pcnt *   5.00 / 100 + T.Populated_prim_name_pcnt *   5.00 / 100 + T.Populated_addr_suffix_pcnt *   5.00 / 100 + T.Populated_postdir_pcnt *   5.00 / 100 + T.Populated_unit_desig_pcnt *   5.00 / 100 + T.Populated_sec_range_pcnt *   5.00 / 100 + T.Populated_p_city_name_pcnt *   5.00 / 100 + T.Populated_v_city_name_pcnt *   5.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *   5.00 / 100 + T.Populated_zip4_pcnt *   5.00 / 100 + T.Populated_cart_pcnt *   5.00 / 100 + T.Populated_cr_sort_sz_pcnt *   5.00 / 100 + T.Populated_lot_pcnt *   5.00 / 100 + T.Populated_lot_order_pcnt *   5.00 / 100 + T.Populated_dbpc_pcnt *   5.00 / 100 + T.Populated_chk_digit_pcnt *   5.00 / 100 + T.Populated_rec_type_pcnt *   5.00 / 100 + T.Populated_fips_st_pcnt *   5.00 / 100 + T.Populated_fips_county_pcnt *   5.00 / 100 + T.Populated_geo_lat_pcnt *   5.00 / 100 + T.Populated_geo_long_pcnt *   5.00 / 100 + T.Populated_msa_pcnt *   5.00 / 100 + T.Populated_geo_blk_pcnt *   5.00 / 100 + T.Populated_geo_match_pcnt *   5.00 / 100 + T.Populated_err_stat_pcnt *   5.00 / 100 + T.Populated_rawaid_pcnt *   5.00 / 100 + T.Populated_aceaid_pcnt *   5.00 / 100 + T.Populated_firm_name_pcnt *   5.00 / 100 + T.Populated_lid_pcnt *   5.00 / 100 + T.Populated_agid_pcnt *   5.00 / 100 + T.Populated_address_std_code_pcnt *   5.00 / 100 + T.Populated_latitude_pcnt *   5.00 / 100 + T.Populated_longitude_pcnt *   5.00 / 100 + T.Populated_prepped_addr1_pcnt *   5.00 / 100 + T.Populated_prepped_addr2_pcnt *   5.00 / 100 + T.Populated_addr_type_pcnt *   5.00 / 100 + T.Populated_state_license_state_pcnt *   5.00 / 100 + T.Populated_state_license_number_pcnt *   5.00 / 100 + T.Populated_state_license_type_pcnt *   5.00 / 100 + T.Populated_state_license_active_pcnt *   5.00 / 100 + T.Populated_state_license_expire_pcnt *   5.00 / 100 + T.Populated_state_license_qualifier_pcnt *   5.00 / 100 + T.Populated_state_license_sub_qualifier_pcnt *   5.00 / 100 + T.Populated_state_license_issued_pcnt *   5.00 / 100 + T.Populated_clean_state_license_expire_pcnt *   5.00 / 100 + T.Populated_clean_state_license_issued_pcnt *   5.00 / 100 + T.Populated_dea_num_pcnt *   5.00 / 100 + T.Populated_dea_bac_pcnt *   5.00 / 100 + T.Populated_dea_sub_bac_pcnt *   5.00 / 100 + T.Populated_dea_schedule_pcnt *   5.00 / 100 + T.Populated_dea_expire_pcnt *   5.00 / 100 + T.Populated_dea_active_pcnt *   5.00 / 100 + T.Populated_clean_dea_expire_pcnt *   5.00 / 100 + T.Populated_csr_number_pcnt *   5.00 / 100 + T.Populated_csr_state_pcnt *   5.00 / 100 + T.Populated_csr_expire_date_pcnt *   5.00 / 100 + T.Populated_csr_issue_date_pcnt *   5.00 / 100 + T.Populated_dsa_lvl_2_pcnt *   5.00 / 100 + T.Populated_dsa_lvl_2n_pcnt *   5.00 / 100 + T.Populated_dsa_lvl_3_pcnt *   5.00 / 100 + T.Populated_dsa_lvl_3n_pcnt *   5.00 / 100 + T.Populated_dsa_lvl_4_pcnt *   5.00 / 100 + T.Populated_dsa_lvl_5_pcnt *   5.00 / 100 + T.Populated_csr_raw1_pcnt *   5.00 / 100 + T.Populated_csr_raw2_pcnt *   5.00 / 100 + T.Populated_csr_raw3_pcnt *   5.00 / 100 + T.Populated_csr_raw4_pcnt *   5.00 / 100 + T.Populated_clean_csr_expire_date_pcnt *   5.00 / 100 + T.Populated_clean_csr_issue_date_pcnt *   5.00 / 100 + T.Populated_sanction_id_pcnt *   5.00 / 100 + T.Populated_sanction_action_code_pcnt *   5.00 / 100 + T.Populated_sanction_action_description_pcnt *   5.00 / 100 + T.Populated_sanction_board_code_pcnt *   5.00 / 100 + T.Populated_sanction_board_description_pcnt *   5.00 / 100 + T.Populated_action_date_pcnt *   5.00 / 100 + T.Populated_sanction_period_start_date_pcnt *   5.00 / 100 + T.Populated_sanction_period_end_date_pcnt *   5.00 / 100 + T.Populated_month_duration_pcnt *   5.00 / 100 + T.Populated_fine_amount_pcnt *   5.00 / 100 + T.Populated_offense_code_pcnt *   5.00 / 100 + T.Populated_offense_description_pcnt *   5.00 / 100 + T.Populated_offense_date_pcnt *   5.00 / 100 + T.Populated_clean_offense_date_pcnt *   5.00 / 100 + T.Populated_clean_action_date_pcnt *   5.00 / 100 + T.Populated_clean_sanction_period_start_date_pcnt *   5.00 / 100 + T.Populated_clean_sanction_period_end_date_pcnt *   5.00 / 100 + T.Populated_gsa_sanction_id_pcnt *   5.00 / 100 + T.Populated_gsa_first_pcnt *   5.00 / 100 + T.Populated_gsa_middle_pcnt *   5.00 / 100 + T.Populated_gsa_last_pcnt *   5.00 / 100 + T.Populated_gsa_suffix_pcnt *   5.00 / 100 + T.Populated_gsa_city_pcnt *   5.00 / 100 + T.Populated_gsa_state_pcnt *   5.00 / 100 + T.Populated_gsa_zip_pcnt *   5.00 / 100 + T.Populated_date_pcnt *   5.00 / 100 + T.Populated_agency_pcnt *   5.00 / 100 + T.Populated_confidence_pcnt *   5.00 / 100 + T.Populated_clean_gsa_first_pcnt *   5.00 / 100 + T.Populated_clean_gsa_middle_pcnt *   5.00 / 100 + T.Populated_clean_gsa_last_pcnt *   5.00 / 100 + T.Populated_clean_gsa_suffix_pcnt *   5.00 / 100 + T.Populated_clean_gsa_city_pcnt *   5.00 / 100 + T.Populated_clean_gsa_state_pcnt *   5.00 / 100 + T.Populated_clean_gsa_zip_pcnt *   5.00 / 100 + T.Populated_clean_gsa_action_date_pcnt *   5.00 / 100 + T.Populated_clean_gsa_date_pcnt *   5.00 / 100 + T.Populated_fax_pcnt *   5.00 / 100 + T.Populated_phone_pcnt *   5.00 / 100 + T.Populated_certification_code_pcnt *   5.00 / 100 + T.Populated_certification_description_pcnt *   5.00 / 100 + T.Populated_board_code_pcnt *   5.00 / 100 + T.Populated_board_description_pcnt *   5.00 / 100 + T.Populated_expiration_year_pcnt *   5.00 / 100 + T.Populated_issue_year_pcnt *   5.00 / 100 + T.Populated_renewal_year_pcnt *   5.00 / 100 + T.Populated_lifetime_flag_pcnt *   5.00 / 100 + T.Populated_covered_recipient_id_pcnt *   5.00 / 100 + T.Populated_cov_rcp_raw_state_code_pcnt *   5.00 / 100 + T.Populated_cov_rcp_raw_full_name_pcnt *   5.00 / 100 + T.Populated_cov_rcp_raw_attribute1_pcnt *   5.00 / 100 + T.Populated_cov_rcp_raw_attribute2_pcnt *   5.00 / 100 + T.Populated_cov_rcp_raw_attribute3_pcnt *   5.00 / 100 + T.Populated_cov_rcp_raw_attribute4_pcnt *   5.00 / 100 + T.Populated_hms_scid_pcnt *   5.00 / 100 + T.Populated_school_name_pcnt *   5.00 / 100 + T.Populated_grad_year_pcnt *   5.00 / 100 + T.Populated_lang_code_pcnt *   5.00 / 100 + T.Populated_language_pcnt *   5.00 / 100 + T.Populated_specialty_description_pcnt *   5.00 / 100 + T.Populated_clean_phone_pcnt *   5.00 / 100 + T.Populated_bdid_pcnt *   5.00 / 100 + T.Populated_bdid_score_pcnt *   5.00 / 100 + T.Populated_did_pcnt *   5.00 / 100 + T.Populated_did_score_pcnt *   5.00 / 100 + T.Populated_clean_dob_pcnt *   5.00 / 100 + T.Populated_best_dob_pcnt *   5.00 / 100 + T.Populated_best_ssn_pcnt *   5.00 / 100 + T.Populated_rec_deactivated_date_pcnt *   5.00 / 100 + T.Populated_superceeding_piid_pcnt *   5.00 / 100 + T.Populated_dotid_pcnt *   5.00 / 100 + T.Populated_dotscore_pcnt *   5.00 / 100 + T.Populated_dotweight_pcnt *   5.00 / 100 + T.Populated_empid_pcnt *   5.00 / 100 + T.Populated_empscore_pcnt *   5.00 / 100 + T.Populated_empweight_pcnt *   5.00 / 100 + T.Populated_powid_pcnt *   5.00 / 100 + T.Populated_powscore_pcnt *   5.00 / 100 + T.Populated_powweight_pcnt *   5.00 / 100 + T.Populated_proxid_pcnt *   5.00 / 100 + T.Populated_proxscore_pcnt *   5.00 / 100 + T.Populated_proxweight_pcnt *   5.00 / 100 + T.Populated_seleid_pcnt *   5.00 / 100 + T.Populated_selescore_pcnt *   5.00 / 100 + T.Populated_seleweight_pcnt *   5.00 / 100 + T.Populated_orgid_pcnt *   5.00 / 100 + T.Populated_orgscore_pcnt *   5.00 / 100 + T.Populated_orgweight_pcnt *   5.00 / 100 + T.Populated_ultid_pcnt *   5.00 / 100 + T.Populated_ultscore_pcnt *   5.00 / 100 + T.Populated_ultweight_pcnt *   5.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'hms_piid','first','middle','last','suffix','cred','practitioner_type','active','vendible','npi_num','npi_enumeration_date','npi_deactivation_date','npi_reactivation_date','npi_taxonomy_code','upin','medicare_participation_flag','date_born','date_died','pid','src','date_vendor_first_reported','date_vendor_last_reported','date_first_seen','date_last_seen','record_type','source_rid','lnpid','fname','mname','lname','name_suffix','nametype','nid','clean_npi_enumeration_date','clean_npi_deactivation_date','clean_npi_reactivation_date','clean_date_born','clean_date_died','clean_company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','firm_name','lid','agid','address_std_code','latitude','longitude','prepped_addr1','prepped_addr2','addr_type','state_license_state','state_license_number','state_license_type','state_license_active','state_license_expire','state_license_qualifier','state_license_sub_qualifier','state_license_issued','clean_state_license_expire','clean_state_license_issued','dea_num','dea_bac','dea_sub_bac','dea_schedule','dea_expire','dea_active','clean_dea_expire','csr_number','csr_state','csr_expire_date','csr_issue_date','dsa_lvl_2','dsa_lvl_2n','dsa_lvl_3','dsa_lvl_3n','dsa_lvl_4','dsa_lvl_5','csr_raw1','csr_raw2','csr_raw3','csr_raw4','clean_csr_expire_date','clean_csr_issue_date','sanction_id','sanction_action_code','sanction_action_description','sanction_board_code','sanction_board_description','action_date','sanction_period_start_date','sanction_period_end_date','month_duration','fine_amount','offense_code','offense_description','offense_date','clean_offense_date','clean_action_date','clean_sanction_period_start_date','clean_sanction_period_end_date','gsa_sanction_id','gsa_first','gsa_middle','gsa_last','gsa_suffix','gsa_city','gsa_state','gsa_zip','date','agency','confidence','clean_gsa_first','clean_gsa_middle','clean_gsa_last','clean_gsa_suffix','clean_gsa_city','clean_gsa_state','clean_gsa_zip','clean_gsa_action_date','clean_gsa_date','fax','phone','certification_code','certification_description','board_code','board_description','expiration_year','issue_year','renewal_year','lifetime_flag','covered_recipient_id','cov_rcp_raw_state_code','cov_rcp_raw_full_name','cov_rcp_raw_attribute1','cov_rcp_raw_attribute2','cov_rcp_raw_attribute3','cov_rcp_raw_attribute4','hms_scid','school_name','grad_year','lang_code','language','specialty_description','clean_phone','bdid','bdid_score','did','did_score','clean_dob','best_dob','best_ssn','rec_deactivated_date','superceeding_piid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_hms_piid_pcnt,le.populated_first_pcnt,le.populated_middle_pcnt,le.populated_last_pcnt,le.populated_suffix_pcnt,le.populated_cred_pcnt,le.populated_practitioner_type_pcnt,le.populated_active_pcnt,le.populated_vendible_pcnt,le.populated_npi_num_pcnt,le.populated_npi_enumeration_date_pcnt,le.populated_npi_deactivation_date_pcnt,le.populated_npi_reactivation_date_pcnt,le.populated_npi_taxonomy_code_pcnt,le.populated_upin_pcnt,le.populated_medicare_participation_flag_pcnt,le.populated_date_born_pcnt,le.populated_date_died_pcnt,le.populated_pid_pcnt,le.populated_src_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_source_rid_pcnt,le.populated_lnpid_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_nametype_pcnt,le.populated_nid_pcnt,le.populated_clean_npi_enumeration_date_pcnt,le.populated_clean_npi_deactivation_date_pcnt,le.populated_clean_npi_reactivation_date_pcnt,le.populated_clean_date_born_pcnt,le.populated_clean_date_died_pcnt,le.populated_clean_company_name_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_firm_name_pcnt,le.populated_lid_pcnt,le.populated_agid_pcnt,le.populated_address_std_code_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prepped_addr2_pcnt,le.populated_addr_type_pcnt,le.populated_state_license_state_pcnt,le.populated_state_license_number_pcnt,le.populated_state_license_type_pcnt,le.populated_state_license_active_pcnt,le.populated_state_license_expire_pcnt,le.populated_state_license_qualifier_pcnt,le.populated_state_license_sub_qualifier_pcnt,le.populated_state_license_issued_pcnt,le.populated_clean_state_license_expire_pcnt,le.populated_clean_state_license_issued_pcnt,le.populated_dea_num_pcnt,le.populated_dea_bac_pcnt,le.populated_dea_sub_bac_pcnt,le.populated_dea_schedule_pcnt,le.populated_dea_expire_pcnt,le.populated_dea_active_pcnt,le.populated_clean_dea_expire_pcnt,le.populated_csr_number_pcnt,le.populated_csr_state_pcnt,le.populated_csr_expire_date_pcnt,le.populated_csr_issue_date_pcnt,le.populated_dsa_lvl_2_pcnt,le.populated_dsa_lvl_2n_pcnt,le.populated_dsa_lvl_3_pcnt,le.populated_dsa_lvl_3n_pcnt,le.populated_dsa_lvl_4_pcnt,le.populated_dsa_lvl_5_pcnt,le.populated_csr_raw1_pcnt,le.populated_csr_raw2_pcnt,le.populated_csr_raw3_pcnt,le.populated_csr_raw4_pcnt,le.populated_clean_csr_expire_date_pcnt,le.populated_clean_csr_issue_date_pcnt,le.populated_sanction_id_pcnt,le.populated_sanction_action_code_pcnt,le.populated_sanction_action_description_pcnt,le.populated_sanction_board_code_pcnt,le.populated_sanction_board_description_pcnt,le.populated_action_date_pcnt,le.populated_sanction_period_start_date_pcnt,le.populated_sanction_period_end_date_pcnt,le.populated_month_duration_pcnt,le.populated_fine_amount_pcnt,le.populated_offense_code_pcnt,le.populated_offense_description_pcnt,le.populated_offense_date_pcnt,le.populated_clean_offense_date_pcnt,le.populated_clean_action_date_pcnt,le.populated_clean_sanction_period_start_date_pcnt,le.populated_clean_sanction_period_end_date_pcnt,le.populated_gsa_sanction_id_pcnt,le.populated_gsa_first_pcnt,le.populated_gsa_middle_pcnt,le.populated_gsa_last_pcnt,le.populated_gsa_suffix_pcnt,le.populated_gsa_city_pcnt,le.populated_gsa_state_pcnt,le.populated_gsa_zip_pcnt,le.populated_date_pcnt,le.populated_agency_pcnt,le.populated_confidence_pcnt,le.populated_clean_gsa_first_pcnt,le.populated_clean_gsa_middle_pcnt,le.populated_clean_gsa_last_pcnt,le.populated_clean_gsa_suffix_pcnt,le.populated_clean_gsa_city_pcnt,le.populated_clean_gsa_state_pcnt,le.populated_clean_gsa_zip_pcnt,le.populated_clean_gsa_action_date_pcnt,le.populated_clean_gsa_date_pcnt,le.populated_fax_pcnt,le.populated_phone_pcnt,le.populated_certification_code_pcnt,le.populated_certification_description_pcnt,le.populated_board_code_pcnt,le.populated_board_description_pcnt,le.populated_expiration_year_pcnt,le.populated_issue_year_pcnt,le.populated_renewal_year_pcnt,le.populated_lifetime_flag_pcnt,le.populated_covered_recipient_id_pcnt,le.populated_cov_rcp_raw_state_code_pcnt,le.populated_cov_rcp_raw_full_name_pcnt,le.populated_cov_rcp_raw_attribute1_pcnt,le.populated_cov_rcp_raw_attribute2_pcnt,le.populated_cov_rcp_raw_attribute3_pcnt,le.populated_cov_rcp_raw_attribute4_pcnt,le.populated_hms_scid_pcnt,le.populated_school_name_pcnt,le.populated_grad_year_pcnt,le.populated_lang_code_pcnt,le.populated_language_pcnt,le.populated_specialty_description_pcnt,le.populated_clean_phone_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_clean_dob_pcnt,le.populated_best_dob_pcnt,le.populated_best_ssn_pcnt,le.populated_rec_deactivated_date_pcnt,le.populated_superceeding_piid_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_hms_piid,le.maxlength_first,le.maxlength_middle,le.maxlength_last,le.maxlength_suffix,le.maxlength_cred,le.maxlength_practitioner_type,le.maxlength_active,le.maxlength_vendible,le.maxlength_npi_num,le.maxlength_npi_enumeration_date,le.maxlength_npi_deactivation_date,le.maxlength_npi_reactivation_date,le.maxlength_npi_taxonomy_code,le.maxlength_upin,le.maxlength_medicare_participation_flag,le.maxlength_date_born,le.maxlength_date_died,le.maxlength_pid,le.maxlength_src,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_record_type,le.maxlength_source_rid,le.maxlength_lnpid,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_nametype,le.maxlength_nid,le.maxlength_clean_npi_enumeration_date,le.maxlength_clean_npi_deactivation_date,le.maxlength_clean_npi_reactivation_date,le.maxlength_clean_date_born,le.maxlength_clean_date_died,le.maxlength_clean_company_name,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_firm_name,le.maxlength_lid,le.maxlength_agid,le.maxlength_address_std_code,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_prepped_addr1,le.maxlength_prepped_addr2,le.maxlength_addr_type,le.maxlength_state_license_state,le.maxlength_state_license_number,le.maxlength_state_license_type,le.maxlength_state_license_active,le.maxlength_state_license_expire,le.maxlength_state_license_qualifier,le.maxlength_state_license_sub_qualifier,le.maxlength_state_license_issued,le.maxlength_clean_state_license_expire,le.maxlength_clean_state_license_issued,le.maxlength_dea_num,le.maxlength_dea_bac,le.maxlength_dea_sub_bac,le.maxlength_dea_schedule,le.maxlength_dea_expire,le.maxlength_dea_active,le.maxlength_clean_dea_expire,le.maxlength_csr_number,le.maxlength_csr_state,le.maxlength_csr_expire_date,le.maxlength_csr_issue_date,le.maxlength_dsa_lvl_2,le.maxlength_dsa_lvl_2n,le.maxlength_dsa_lvl_3,le.maxlength_dsa_lvl_3n,le.maxlength_dsa_lvl_4,le.maxlength_dsa_lvl_5,le.maxlength_csr_raw1,le.maxlength_csr_raw2,le.maxlength_csr_raw3,le.maxlength_csr_raw4,le.maxlength_clean_csr_expire_date,le.maxlength_clean_csr_issue_date,le.maxlength_sanction_id,le.maxlength_sanction_action_code,le.maxlength_sanction_action_description,le.maxlength_sanction_board_code,le.maxlength_sanction_board_description,le.maxlength_action_date,le.maxlength_sanction_period_start_date,le.maxlength_sanction_period_end_date,le.maxlength_month_duration,le.maxlength_fine_amount,le.maxlength_offense_code,le.maxlength_offense_description,le.maxlength_offense_date,le.maxlength_clean_offense_date,le.maxlength_clean_action_date,le.maxlength_clean_sanction_period_start_date,le.maxlength_clean_sanction_period_end_date,le.maxlength_gsa_sanction_id,le.maxlength_gsa_first,le.maxlength_gsa_middle,le.maxlength_gsa_last,le.maxlength_gsa_suffix,le.maxlength_gsa_city,le.maxlength_gsa_state,le.maxlength_gsa_zip,le.maxlength_date,le.maxlength_agency,le.maxlength_confidence,le.maxlength_clean_gsa_first,le.maxlength_clean_gsa_middle,le.maxlength_clean_gsa_last,le.maxlength_clean_gsa_suffix,le.maxlength_clean_gsa_city,le.maxlength_clean_gsa_state,le.maxlength_clean_gsa_zip,le.maxlength_clean_gsa_action_date,le.maxlength_clean_gsa_date,le.maxlength_fax,le.maxlength_phone,le.maxlength_certification_code,le.maxlength_certification_description,le.maxlength_board_code,le.maxlength_board_description,le.maxlength_expiration_year,le.maxlength_issue_year,le.maxlength_renewal_year,le.maxlength_lifetime_flag,le.maxlength_covered_recipient_id,le.maxlength_cov_rcp_raw_state_code,le.maxlength_cov_rcp_raw_full_name,le.maxlength_cov_rcp_raw_attribute1,le.maxlength_cov_rcp_raw_attribute2,le.maxlength_cov_rcp_raw_attribute3,le.maxlength_cov_rcp_raw_attribute4,le.maxlength_hms_scid,le.maxlength_school_name,le.maxlength_grad_year,le.maxlength_lang_code,le.maxlength_language,le.maxlength_specialty_description,le.maxlength_clean_phone,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_did,le.maxlength_did_score,le.maxlength_clean_dob,le.maxlength_best_dob,le.maxlength_best_ssn,le.maxlength_rec_deactivated_date,le.maxlength_superceeding_piid,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_hms_piid,le.avelength_first,le.avelength_middle,le.avelength_last,le.avelength_suffix,le.avelength_cred,le.avelength_practitioner_type,le.avelength_active,le.avelength_vendible,le.avelength_npi_num,le.avelength_npi_enumeration_date,le.avelength_npi_deactivation_date,le.avelength_npi_reactivation_date,le.avelength_npi_taxonomy_code,le.avelength_upin,le.avelength_medicare_participation_flag,le.avelength_date_born,le.avelength_date_died,le.avelength_pid,le.avelength_src,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_record_type,le.avelength_source_rid,le.avelength_lnpid,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_nametype,le.avelength_nid,le.avelength_clean_npi_enumeration_date,le.avelength_clean_npi_deactivation_date,le.avelength_clean_npi_reactivation_date,le.avelength_clean_date_born,le.avelength_clean_date_died,le.avelength_clean_company_name,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_aceaid,le.avelength_firm_name,le.avelength_lid,le.avelength_agid,le.avelength_address_std_code,le.avelength_latitude,le.avelength_longitude,le.avelength_prepped_addr1,le.avelength_prepped_addr2,le.avelength_addr_type,le.avelength_state_license_state,le.avelength_state_license_number,le.avelength_state_license_type,le.avelength_state_license_active,le.avelength_state_license_expire,le.avelength_state_license_qualifier,le.avelength_state_license_sub_qualifier,le.avelength_state_license_issued,le.avelength_clean_state_license_expire,le.avelength_clean_state_license_issued,le.avelength_dea_num,le.avelength_dea_bac,le.avelength_dea_sub_bac,le.avelength_dea_schedule,le.avelength_dea_expire,le.avelength_dea_active,le.avelength_clean_dea_expire,le.avelength_csr_number,le.avelength_csr_state,le.avelength_csr_expire_date,le.avelength_csr_issue_date,le.avelength_dsa_lvl_2,le.avelength_dsa_lvl_2n,le.avelength_dsa_lvl_3,le.avelength_dsa_lvl_3n,le.avelength_dsa_lvl_4,le.avelength_dsa_lvl_5,le.avelength_csr_raw1,le.avelength_csr_raw2,le.avelength_csr_raw3,le.avelength_csr_raw4,le.avelength_clean_csr_expire_date,le.avelength_clean_csr_issue_date,le.avelength_sanction_id,le.avelength_sanction_action_code,le.avelength_sanction_action_description,le.avelength_sanction_board_code,le.avelength_sanction_board_description,le.avelength_action_date,le.avelength_sanction_period_start_date,le.avelength_sanction_period_end_date,le.avelength_month_duration,le.avelength_fine_amount,le.avelength_offense_code,le.avelength_offense_description,le.avelength_offense_date,le.avelength_clean_offense_date,le.avelength_clean_action_date,le.avelength_clean_sanction_period_start_date,le.avelength_clean_sanction_period_end_date,le.avelength_gsa_sanction_id,le.avelength_gsa_first,le.avelength_gsa_middle,le.avelength_gsa_last,le.avelength_gsa_suffix,le.avelength_gsa_city,le.avelength_gsa_state,le.avelength_gsa_zip,le.avelength_date,le.avelength_agency,le.avelength_confidence,le.avelength_clean_gsa_first,le.avelength_clean_gsa_middle,le.avelength_clean_gsa_last,le.avelength_clean_gsa_suffix,le.avelength_clean_gsa_city,le.avelength_clean_gsa_state,le.avelength_clean_gsa_zip,le.avelength_clean_gsa_action_date,le.avelength_clean_gsa_date,le.avelength_fax,le.avelength_phone,le.avelength_certification_code,le.avelength_certification_description,le.avelength_board_code,le.avelength_board_description,le.avelength_expiration_year,le.avelength_issue_year,le.avelength_renewal_year,le.avelength_lifetime_flag,le.avelength_covered_recipient_id,le.avelength_cov_rcp_raw_state_code,le.avelength_cov_rcp_raw_full_name,le.avelength_cov_rcp_raw_attribute1,le.avelength_cov_rcp_raw_attribute2,le.avelength_cov_rcp_raw_attribute3,le.avelength_cov_rcp_raw_attribute4,le.avelength_hms_scid,le.avelength_school_name,le.avelength_grad_year,le.avelength_lang_code,le.avelength_language,le.avelength_specialty_description,le.avelength_clean_phone,le.avelength_bdid,le.avelength_bdid_score,le.avelength_did,le.avelength_did_score,le.avelength_clean_dob,le.avelength_best_dob,le.avelength_best_ssn,le.avelength_rec_deactivated_date,le.avelength_superceeding_piid,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 201, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.hms_piid),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.practitioner_type),TRIM((SALT31.StrType)le.active),TRIM((SALT31.StrType)le.vendible),TRIM((SALT31.StrType)le.npi_num),TRIM((SALT31.StrType)le.npi_enumeration_date),TRIM((SALT31.StrType)le.npi_deactivation_date),TRIM((SALT31.StrType)le.npi_reactivation_date),TRIM((SALT31.StrType)le.npi_taxonomy_code),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.medicare_participation_flag),TRIM((SALT31.StrType)le.date_born),TRIM((SALT31.StrType)le.date_died),TRIM((SALT31.StrType)le.pid),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.date_vendor_first_reported),TRIM((SALT31.StrType)le.date_vendor_last_reported),TRIM((SALT31.StrType)le.date_first_seen),TRIM((SALT31.StrType)le.date_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.nametype),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_npi_enumeration_date),TRIM((SALT31.StrType)le.clean_npi_deactivation_date),TRIM((SALT31.StrType)le.clean_npi_reactivation_date),TRIM((SALT31.StrType)le.clean_date_born),TRIM((SALT31.StrType)le.clean_date_died),TRIM((SALT31.StrType)le.clean_company_name),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.firm_name),TRIM((SALT31.StrType)le.lid),TRIM((SALT31.StrType)le.agid),TRIM((SALT31.StrType)le.address_std_code),TRIM((SALT31.StrType)le.latitude),TRIM((SALT31.StrType)le.longitude),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.addr_type),TRIM((SALT31.StrType)le.state_license_state),TRIM((SALT31.StrType)le.state_license_number),TRIM((SALT31.StrType)le.state_license_type),TRIM((SALT31.StrType)le.state_license_active),TRIM((SALT31.StrType)le.state_license_expire),TRIM((SALT31.StrType)le.state_license_qualifier),TRIM((SALT31.StrType)le.state_license_sub_qualifier),TRIM((SALT31.StrType)le.state_license_issued),TRIM((SALT31.StrType)le.clean_state_license_expire),TRIM((SALT31.StrType)le.clean_state_license_issued),TRIM((SALT31.StrType)le.dea_num),TRIM((SALT31.StrType)le.dea_bac),TRIM((SALT31.StrType)le.dea_sub_bac),TRIM((SALT31.StrType)le.dea_schedule),TRIM((SALT31.StrType)le.dea_expire),TRIM((SALT31.StrType)le.dea_active),TRIM((SALT31.StrType)le.clean_dea_expire),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.csr_state),TRIM((SALT31.StrType)le.csr_expire_date),TRIM((SALT31.StrType)le.csr_issue_date),TRIM((SALT31.StrType)le.dsa_lvl_2),TRIM((SALT31.StrType)le.dsa_lvl_2n),TRIM((SALT31.StrType)le.dsa_lvl_3),TRIM((SALT31.StrType)le.dsa_lvl_3n),TRIM((SALT31.StrType)le.dsa_lvl_4),TRIM((SALT31.StrType)le.dsa_lvl_5),TRIM((SALT31.StrType)le.csr_raw1),TRIM((SALT31.StrType)le.csr_raw2),TRIM((SALT31.StrType)le.csr_raw3),TRIM((SALT31.StrType)le.csr_raw4),TRIM((SALT31.StrType)le.clean_csr_expire_date),TRIM((SALT31.StrType)le.clean_csr_issue_date),TRIM((SALT31.StrType)le.sanction_id),TRIM((SALT31.StrType)le.sanction_action_code),TRIM((SALT31.StrType)le.sanction_action_description),TRIM((SALT31.StrType)le.sanction_board_code),TRIM((SALT31.StrType)le.sanction_board_description),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.sanction_period_start_date),TRIM((SALT31.StrType)le.sanction_period_end_date),TRIM((SALT31.StrType)le.month_duration),TRIM((SALT31.StrType)le.fine_amount),TRIM((SALT31.StrType)le.offense_code),TRIM((SALT31.StrType)le.offense_description),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.clean_offense_date),TRIM((SALT31.StrType)le.clean_action_date),TRIM((SALT31.StrType)le.clean_sanction_period_start_date),TRIM((SALT31.StrType)le.clean_sanction_period_end_date),TRIM((SALT31.StrType)le.gsa_sanction_id),TRIM((SALT31.StrType)le.gsa_first),TRIM((SALT31.StrType)le.gsa_middle),TRIM((SALT31.StrType)le.gsa_last),TRIM((SALT31.StrType)le.gsa_suffix),TRIM((SALT31.StrType)le.gsa_city),TRIM((SALT31.StrType)le.gsa_state),TRIM((SALT31.StrType)le.gsa_zip),TRIM((SALT31.StrType)le.date),TRIM((SALT31.StrType)le.agency),TRIM((SALT31.StrType)le.confidence),TRIM((SALT31.StrType)le.clean_gsa_first),TRIM((SALT31.StrType)le.clean_gsa_middle),TRIM((SALT31.StrType)le.clean_gsa_last),TRIM((SALT31.StrType)le.clean_gsa_suffix),TRIM((SALT31.StrType)le.clean_gsa_city),TRIM((SALT31.StrType)le.clean_gsa_state),TRIM((SALT31.StrType)le.clean_gsa_zip),TRIM((SALT31.StrType)le.clean_gsa_action_date),TRIM((SALT31.StrType)le.clean_gsa_date),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.phone),TRIM((SALT31.StrType)le.certification_code),TRIM((SALT31.StrType)le.certification_description),TRIM((SALT31.StrType)le.board_code),TRIM((SALT31.StrType)le.board_description),TRIM((SALT31.StrType)le.expiration_year),TRIM((SALT31.StrType)le.issue_year),TRIM((SALT31.StrType)le.renewal_year),TRIM((SALT31.StrType)le.lifetime_flag),TRIM((SALT31.StrType)le.covered_recipient_id),TRIM((SALT31.StrType)le.cov_rcp_raw_state_code),TRIM((SALT31.StrType)le.cov_rcp_raw_full_name),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute1),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute2),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute3),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute4),TRIM((SALT31.StrType)le.hms_scid),TRIM((SALT31.StrType)le.school_name),TRIM((SALT31.StrType)le.grad_year),TRIM((SALT31.StrType)le.lang_code),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.specialty_description),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.clean_dob),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.rec_deactivated_date),TRIM((SALT31.StrType)le.superceeding_piid),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,201,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 201);
  SELF.FldNo2 := 1 + (C % 201);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.hms_piid),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.practitioner_type),TRIM((SALT31.StrType)le.active),TRIM((SALT31.StrType)le.vendible),TRIM((SALT31.StrType)le.npi_num),TRIM((SALT31.StrType)le.npi_enumeration_date),TRIM((SALT31.StrType)le.npi_deactivation_date),TRIM((SALT31.StrType)le.npi_reactivation_date),TRIM((SALT31.StrType)le.npi_taxonomy_code),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.medicare_participation_flag),TRIM((SALT31.StrType)le.date_born),TRIM((SALT31.StrType)le.date_died),TRIM((SALT31.StrType)le.pid),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.date_vendor_first_reported),TRIM((SALT31.StrType)le.date_vendor_last_reported),TRIM((SALT31.StrType)le.date_first_seen),TRIM((SALT31.StrType)le.date_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.nametype),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_npi_enumeration_date),TRIM((SALT31.StrType)le.clean_npi_deactivation_date),TRIM((SALT31.StrType)le.clean_npi_reactivation_date),TRIM((SALT31.StrType)le.clean_date_born),TRIM((SALT31.StrType)le.clean_date_died),TRIM((SALT31.StrType)le.clean_company_name),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.firm_name),TRIM((SALT31.StrType)le.lid),TRIM((SALT31.StrType)le.agid),TRIM((SALT31.StrType)le.address_std_code),TRIM((SALT31.StrType)le.latitude),TRIM((SALT31.StrType)le.longitude),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.addr_type),TRIM((SALT31.StrType)le.state_license_state),TRIM((SALT31.StrType)le.state_license_number),TRIM((SALT31.StrType)le.state_license_type),TRIM((SALT31.StrType)le.state_license_active),TRIM((SALT31.StrType)le.state_license_expire),TRIM((SALT31.StrType)le.state_license_qualifier),TRIM((SALT31.StrType)le.state_license_sub_qualifier),TRIM((SALT31.StrType)le.state_license_issued),TRIM((SALT31.StrType)le.clean_state_license_expire),TRIM((SALT31.StrType)le.clean_state_license_issued),TRIM((SALT31.StrType)le.dea_num),TRIM((SALT31.StrType)le.dea_bac),TRIM((SALT31.StrType)le.dea_sub_bac),TRIM((SALT31.StrType)le.dea_schedule),TRIM((SALT31.StrType)le.dea_expire),TRIM((SALT31.StrType)le.dea_active),TRIM((SALT31.StrType)le.clean_dea_expire),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.csr_state),TRIM((SALT31.StrType)le.csr_expire_date),TRIM((SALT31.StrType)le.csr_issue_date),TRIM((SALT31.StrType)le.dsa_lvl_2),TRIM((SALT31.StrType)le.dsa_lvl_2n),TRIM((SALT31.StrType)le.dsa_lvl_3),TRIM((SALT31.StrType)le.dsa_lvl_3n),TRIM((SALT31.StrType)le.dsa_lvl_4),TRIM((SALT31.StrType)le.dsa_lvl_5),TRIM((SALT31.StrType)le.csr_raw1),TRIM((SALT31.StrType)le.csr_raw2),TRIM((SALT31.StrType)le.csr_raw3),TRIM((SALT31.StrType)le.csr_raw4),TRIM((SALT31.StrType)le.clean_csr_expire_date),TRIM((SALT31.StrType)le.clean_csr_issue_date),TRIM((SALT31.StrType)le.sanction_id),TRIM((SALT31.StrType)le.sanction_action_code),TRIM((SALT31.StrType)le.sanction_action_description),TRIM((SALT31.StrType)le.sanction_board_code),TRIM((SALT31.StrType)le.sanction_board_description),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.sanction_period_start_date),TRIM((SALT31.StrType)le.sanction_period_end_date),TRIM((SALT31.StrType)le.month_duration),TRIM((SALT31.StrType)le.fine_amount),TRIM((SALT31.StrType)le.offense_code),TRIM((SALT31.StrType)le.offense_description),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.clean_offense_date),TRIM((SALT31.StrType)le.clean_action_date),TRIM((SALT31.StrType)le.clean_sanction_period_start_date),TRIM((SALT31.StrType)le.clean_sanction_period_end_date),TRIM((SALT31.StrType)le.gsa_sanction_id),TRIM((SALT31.StrType)le.gsa_first),TRIM((SALT31.StrType)le.gsa_middle),TRIM((SALT31.StrType)le.gsa_last),TRIM((SALT31.StrType)le.gsa_suffix),TRIM((SALT31.StrType)le.gsa_city),TRIM((SALT31.StrType)le.gsa_state),TRIM((SALT31.StrType)le.gsa_zip),TRIM((SALT31.StrType)le.date),TRIM((SALT31.StrType)le.agency),TRIM((SALT31.StrType)le.confidence),TRIM((SALT31.StrType)le.clean_gsa_first),TRIM((SALT31.StrType)le.clean_gsa_middle),TRIM((SALT31.StrType)le.clean_gsa_last),TRIM((SALT31.StrType)le.clean_gsa_suffix),TRIM((SALT31.StrType)le.clean_gsa_city),TRIM((SALT31.StrType)le.clean_gsa_state),TRIM((SALT31.StrType)le.clean_gsa_zip),TRIM((SALT31.StrType)le.clean_gsa_action_date),TRIM((SALT31.StrType)le.clean_gsa_date),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.phone),TRIM((SALT31.StrType)le.certification_code),TRIM((SALT31.StrType)le.certification_description),TRIM((SALT31.StrType)le.board_code),TRIM((SALT31.StrType)le.board_description),TRIM((SALT31.StrType)le.expiration_year),TRIM((SALT31.StrType)le.issue_year),TRIM((SALT31.StrType)le.renewal_year),TRIM((SALT31.StrType)le.lifetime_flag),TRIM((SALT31.StrType)le.covered_recipient_id),TRIM((SALT31.StrType)le.cov_rcp_raw_state_code),TRIM((SALT31.StrType)le.cov_rcp_raw_full_name),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute1),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute2),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute3),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute4),TRIM((SALT31.StrType)le.hms_scid),TRIM((SALT31.StrType)le.school_name),TRIM((SALT31.StrType)le.grad_year),TRIM((SALT31.StrType)le.lang_code),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.specialty_description),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.clean_dob),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.rec_deactivated_date),TRIM((SALT31.StrType)le.superceeding_piid),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.hms_piid),TRIM((SALT31.StrType)le.first),TRIM((SALT31.StrType)le.middle),TRIM((SALT31.StrType)le.last),TRIM((SALT31.StrType)le.suffix),TRIM((SALT31.StrType)le.cred),TRIM((SALT31.StrType)le.practitioner_type),TRIM((SALT31.StrType)le.active),TRIM((SALT31.StrType)le.vendible),TRIM((SALT31.StrType)le.npi_num),TRIM((SALT31.StrType)le.npi_enumeration_date),TRIM((SALT31.StrType)le.npi_deactivation_date),TRIM((SALT31.StrType)le.npi_reactivation_date),TRIM((SALT31.StrType)le.npi_taxonomy_code),TRIM((SALT31.StrType)le.upin),TRIM((SALT31.StrType)le.medicare_participation_flag),TRIM((SALT31.StrType)le.date_born),TRIM((SALT31.StrType)le.date_died),TRIM((SALT31.StrType)le.pid),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.date_vendor_first_reported),TRIM((SALT31.StrType)le.date_vendor_last_reported),TRIM((SALT31.StrType)le.date_first_seen),TRIM((SALT31.StrType)le.date_last_seen),TRIM((SALT31.StrType)le.record_type),TRIM((SALT31.StrType)le.source_rid),TRIM((SALT31.StrType)le.lnpid),TRIM((SALT31.StrType)le.fname),TRIM((SALT31.StrType)le.mname),TRIM((SALT31.StrType)le.lname),TRIM((SALT31.StrType)le.name_suffix),TRIM((SALT31.StrType)le.nametype),TRIM((SALT31.StrType)le.nid),TRIM((SALT31.StrType)le.clean_npi_enumeration_date),TRIM((SALT31.StrType)le.clean_npi_deactivation_date),TRIM((SALT31.StrType)le.clean_npi_reactivation_date),TRIM((SALT31.StrType)le.clean_date_born),TRIM((SALT31.StrType)le.clean_date_died),TRIM((SALT31.StrType)le.clean_company_name),TRIM((SALT31.StrType)le.prim_range),TRIM((SALT31.StrType)le.predir),TRIM((SALT31.StrType)le.prim_name),TRIM((SALT31.StrType)le.addr_suffix),TRIM((SALT31.StrType)le.postdir),TRIM((SALT31.StrType)le.unit_desig),TRIM((SALT31.StrType)le.sec_range),TRIM((SALT31.StrType)le.p_city_name),TRIM((SALT31.StrType)le.v_city_name),TRIM((SALT31.StrType)le.st),TRIM((SALT31.StrType)le.zip),TRIM((SALT31.StrType)le.zip4),TRIM((SALT31.StrType)le.cart),TRIM((SALT31.StrType)le.cr_sort_sz),TRIM((SALT31.StrType)le.lot),TRIM((SALT31.StrType)le.lot_order),TRIM((SALT31.StrType)le.dbpc),TRIM((SALT31.StrType)le.chk_digit),TRIM((SALT31.StrType)le.rec_type),TRIM((SALT31.StrType)le.fips_st),TRIM((SALT31.StrType)le.fips_county),TRIM((SALT31.StrType)le.geo_lat),TRIM((SALT31.StrType)le.geo_long),TRIM((SALT31.StrType)le.msa),TRIM((SALT31.StrType)le.geo_blk),TRIM((SALT31.StrType)le.geo_match),TRIM((SALT31.StrType)le.err_stat),TRIM((SALT31.StrType)le.rawaid),TRIM((SALT31.StrType)le.aceaid),TRIM((SALT31.StrType)le.firm_name),TRIM((SALT31.StrType)le.lid),TRIM((SALT31.StrType)le.agid),TRIM((SALT31.StrType)le.address_std_code),TRIM((SALT31.StrType)le.latitude),TRIM((SALT31.StrType)le.longitude),TRIM((SALT31.StrType)le.prepped_addr1),TRIM((SALT31.StrType)le.prepped_addr2),TRIM((SALT31.StrType)le.addr_type),TRIM((SALT31.StrType)le.state_license_state),TRIM((SALT31.StrType)le.state_license_number),TRIM((SALT31.StrType)le.state_license_type),TRIM((SALT31.StrType)le.state_license_active),TRIM((SALT31.StrType)le.state_license_expire),TRIM((SALT31.StrType)le.state_license_qualifier),TRIM((SALT31.StrType)le.state_license_sub_qualifier),TRIM((SALT31.StrType)le.state_license_issued),TRIM((SALT31.StrType)le.clean_state_license_expire),TRIM((SALT31.StrType)le.clean_state_license_issued),TRIM((SALT31.StrType)le.dea_num),TRIM((SALT31.StrType)le.dea_bac),TRIM((SALT31.StrType)le.dea_sub_bac),TRIM((SALT31.StrType)le.dea_schedule),TRIM((SALT31.StrType)le.dea_expire),TRIM((SALT31.StrType)le.dea_active),TRIM((SALT31.StrType)le.clean_dea_expire),TRIM((SALT31.StrType)le.csr_number),TRIM((SALT31.StrType)le.csr_state),TRIM((SALT31.StrType)le.csr_expire_date),TRIM((SALT31.StrType)le.csr_issue_date),TRIM((SALT31.StrType)le.dsa_lvl_2),TRIM((SALT31.StrType)le.dsa_lvl_2n),TRIM((SALT31.StrType)le.dsa_lvl_3),TRIM((SALT31.StrType)le.dsa_lvl_3n),TRIM((SALT31.StrType)le.dsa_lvl_4),TRIM((SALT31.StrType)le.dsa_lvl_5),TRIM((SALT31.StrType)le.csr_raw1),TRIM((SALT31.StrType)le.csr_raw2),TRIM((SALT31.StrType)le.csr_raw3),TRIM((SALT31.StrType)le.csr_raw4),TRIM((SALT31.StrType)le.clean_csr_expire_date),TRIM((SALT31.StrType)le.clean_csr_issue_date),TRIM((SALT31.StrType)le.sanction_id),TRIM((SALT31.StrType)le.sanction_action_code),TRIM((SALT31.StrType)le.sanction_action_description),TRIM((SALT31.StrType)le.sanction_board_code),TRIM((SALT31.StrType)le.sanction_board_description),TRIM((SALT31.StrType)le.action_date),TRIM((SALT31.StrType)le.sanction_period_start_date),TRIM((SALT31.StrType)le.sanction_period_end_date),TRIM((SALT31.StrType)le.month_duration),TRIM((SALT31.StrType)le.fine_amount),TRIM((SALT31.StrType)le.offense_code),TRIM((SALT31.StrType)le.offense_description),TRIM((SALT31.StrType)le.offense_date),TRIM((SALT31.StrType)le.clean_offense_date),TRIM((SALT31.StrType)le.clean_action_date),TRIM((SALT31.StrType)le.clean_sanction_period_start_date),TRIM((SALT31.StrType)le.clean_sanction_period_end_date),TRIM((SALT31.StrType)le.gsa_sanction_id),TRIM((SALT31.StrType)le.gsa_first),TRIM((SALT31.StrType)le.gsa_middle),TRIM((SALT31.StrType)le.gsa_last),TRIM((SALT31.StrType)le.gsa_suffix),TRIM((SALT31.StrType)le.gsa_city),TRIM((SALT31.StrType)le.gsa_state),TRIM((SALT31.StrType)le.gsa_zip),TRIM((SALT31.StrType)le.date),TRIM((SALT31.StrType)le.agency),TRIM((SALT31.StrType)le.confidence),TRIM((SALT31.StrType)le.clean_gsa_first),TRIM((SALT31.StrType)le.clean_gsa_middle),TRIM((SALT31.StrType)le.clean_gsa_last),TRIM((SALT31.StrType)le.clean_gsa_suffix),TRIM((SALT31.StrType)le.clean_gsa_city),TRIM((SALT31.StrType)le.clean_gsa_state),TRIM((SALT31.StrType)le.clean_gsa_zip),TRIM((SALT31.StrType)le.clean_gsa_action_date),TRIM((SALT31.StrType)le.clean_gsa_date),TRIM((SALT31.StrType)le.fax),TRIM((SALT31.StrType)le.phone),TRIM((SALT31.StrType)le.certification_code),TRIM((SALT31.StrType)le.certification_description),TRIM((SALT31.StrType)le.board_code),TRIM((SALT31.StrType)le.board_description),TRIM((SALT31.StrType)le.expiration_year),TRIM((SALT31.StrType)le.issue_year),TRIM((SALT31.StrType)le.renewal_year),TRIM((SALT31.StrType)le.lifetime_flag),TRIM((SALT31.StrType)le.covered_recipient_id),TRIM((SALT31.StrType)le.cov_rcp_raw_state_code),TRIM((SALT31.StrType)le.cov_rcp_raw_full_name),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute1),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute2),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute3),TRIM((SALT31.StrType)le.cov_rcp_raw_attribute4),TRIM((SALT31.StrType)le.hms_scid),TRIM((SALT31.StrType)le.school_name),TRIM((SALT31.StrType)le.grad_year),TRIM((SALT31.StrType)le.lang_code),TRIM((SALT31.StrType)le.language),TRIM((SALT31.StrType)le.specialty_description),TRIM((SALT31.StrType)le.clean_phone),TRIM((SALT31.StrType)le.bdid),TRIM((SALT31.StrType)le.bdid_score),TRIM((SALT31.StrType)le.did),TRIM((SALT31.StrType)le.did_score),TRIM((SALT31.StrType)le.clean_dob),TRIM((SALT31.StrType)le.best_dob),TRIM((SALT31.StrType)le.best_ssn),TRIM((SALT31.StrType)le.rec_deactivated_date),TRIM((SALT31.StrType)le.superceeding_piid),TRIM((SALT31.StrType)le.dotid),TRIM((SALT31.StrType)le.dotscore),TRIM((SALT31.StrType)le.dotweight),TRIM((SALT31.StrType)le.empid),TRIM((SALT31.StrType)le.empscore),TRIM((SALT31.StrType)le.empweight),TRIM((SALT31.StrType)le.powid),TRIM((SALT31.StrType)le.powscore),TRIM((SALT31.StrType)le.powweight),TRIM((SALT31.StrType)le.proxid),TRIM((SALT31.StrType)le.proxscore),TRIM((SALT31.StrType)le.proxweight),TRIM((SALT31.StrType)le.seleid),TRIM((SALT31.StrType)le.selescore),TRIM((SALT31.StrType)le.seleweight),TRIM((SALT31.StrType)le.orgid),TRIM((SALT31.StrType)le.orgscore),TRIM((SALT31.StrType)le.orgweight),TRIM((SALT31.StrType)le.ultid),TRIM((SALT31.StrType)le.ultscore),TRIM((SALT31.StrType)le.ultweight)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),201*201,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'hms_piid'}
      ,{2,'first'}
      ,{3,'middle'}
      ,{4,'last'}
      ,{5,'suffix'}
      ,{6,'cred'}
      ,{7,'practitioner_type'}
      ,{8,'active'}
      ,{9,'vendible'}
      ,{10,'npi_num'}
      ,{11,'npi_enumeration_date'}
      ,{12,'npi_deactivation_date'}
      ,{13,'npi_reactivation_date'}
      ,{14,'npi_taxonomy_code'}
      ,{15,'upin'}
      ,{16,'medicare_participation_flag'}
      ,{17,'date_born'}
      ,{18,'date_died'}
      ,{19,'pid'}
      ,{20,'src'}
      ,{21,'date_vendor_first_reported'}
      ,{22,'date_vendor_last_reported'}
      ,{23,'date_first_seen'}
      ,{24,'date_last_seen'}
      ,{25,'record_type'}
      ,{26,'source_rid'}
      ,{27,'lnpid'}
      ,{28,'fname'}
      ,{29,'mname'}
      ,{30,'lname'}
      ,{31,'name_suffix'}
      ,{32,'nametype'}
      ,{33,'nid'}
      ,{34,'clean_npi_enumeration_date'}
      ,{35,'clean_npi_deactivation_date'}
      ,{36,'clean_npi_reactivation_date'}
      ,{37,'clean_date_born'}
      ,{38,'clean_date_died'}
      ,{39,'clean_company_name'}
      ,{40,'prim_range'}
      ,{41,'predir'}
      ,{42,'prim_name'}
      ,{43,'addr_suffix'}
      ,{44,'postdir'}
      ,{45,'unit_desig'}
      ,{46,'sec_range'}
      ,{47,'p_city_name'}
      ,{48,'v_city_name'}
      ,{49,'st'}
      ,{50,'zip'}
      ,{51,'zip4'}
      ,{52,'cart'}
      ,{53,'cr_sort_sz'}
      ,{54,'lot'}
      ,{55,'lot_order'}
      ,{56,'dbpc'}
      ,{57,'chk_digit'}
      ,{58,'rec_type'}
      ,{59,'fips_st'}
      ,{60,'fips_county'}
      ,{61,'geo_lat'}
      ,{62,'geo_long'}
      ,{63,'msa'}
      ,{64,'geo_blk'}
      ,{65,'geo_match'}
      ,{66,'err_stat'}
      ,{67,'rawaid'}
      ,{68,'aceaid'}
      ,{69,'firm_name'}
      ,{70,'lid'}
      ,{71,'agid'}
      ,{72,'address_std_code'}
      ,{73,'latitude'}
      ,{74,'longitude'}
      ,{75,'prepped_addr1'}
      ,{76,'prepped_addr2'}
      ,{77,'addr_type'}
      ,{78,'state_license_state'}
      ,{79,'state_license_number'}
      ,{80,'state_license_type'}
      ,{81,'state_license_active'}
      ,{82,'state_license_expire'}
      ,{83,'state_license_qualifier'}
      ,{84,'state_license_sub_qualifier'}
      ,{85,'state_license_issued'}
      ,{86,'clean_state_license_expire'}
      ,{87,'clean_state_license_issued'}
      ,{88,'dea_num'}
      ,{89,'dea_bac'}
      ,{90,'dea_sub_bac'}
      ,{91,'dea_schedule'}
      ,{92,'dea_expire'}
      ,{93,'dea_active'}
      ,{94,'clean_dea_expire'}
      ,{95,'csr_number'}
      ,{96,'csr_state'}
      ,{97,'csr_expire_date'}
      ,{98,'csr_issue_date'}
      ,{99,'dsa_lvl_2'}
      ,{100,'dsa_lvl_2n'}
      ,{101,'dsa_lvl_3'}
      ,{102,'dsa_lvl_3n'}
      ,{103,'dsa_lvl_4'}
      ,{104,'dsa_lvl_5'}
      ,{105,'csr_raw1'}
      ,{106,'csr_raw2'}
      ,{107,'csr_raw3'}
      ,{108,'csr_raw4'}
      ,{109,'clean_csr_expire_date'}
      ,{110,'clean_csr_issue_date'}
      ,{111,'sanction_id'}
      ,{112,'sanction_action_code'}
      ,{113,'sanction_action_description'}
      ,{114,'sanction_board_code'}
      ,{115,'sanction_board_description'}
      ,{116,'action_date'}
      ,{117,'sanction_period_start_date'}
      ,{118,'sanction_period_end_date'}
      ,{119,'month_duration'}
      ,{120,'fine_amount'}
      ,{121,'offense_code'}
      ,{122,'offense_description'}
      ,{123,'offense_date'}
      ,{124,'clean_offense_date'}
      ,{125,'clean_action_date'}
      ,{126,'clean_sanction_period_start_date'}
      ,{127,'clean_sanction_period_end_date'}
      ,{128,'gsa_sanction_id'}
      ,{129,'gsa_first'}
      ,{130,'gsa_middle'}
      ,{131,'gsa_last'}
      ,{132,'gsa_suffix'}
      ,{133,'gsa_city'}
      ,{134,'gsa_state'}
      ,{135,'gsa_zip'}
      ,{136,'date'}
      ,{137,'agency'}
      ,{138,'confidence'}
      ,{139,'clean_gsa_first'}
      ,{140,'clean_gsa_middle'}
      ,{141,'clean_gsa_last'}
      ,{142,'clean_gsa_suffix'}
      ,{143,'clean_gsa_city'}
      ,{144,'clean_gsa_state'}
      ,{145,'clean_gsa_zip'}
      ,{146,'clean_gsa_action_date'}
      ,{147,'clean_gsa_date'}
      ,{148,'fax'}
      ,{149,'phone'}
      ,{150,'certification_code'}
      ,{151,'certification_description'}
      ,{152,'board_code'}
      ,{153,'board_description'}
      ,{154,'expiration_year'}
      ,{155,'issue_year'}
      ,{156,'renewal_year'}
      ,{157,'lifetime_flag'}
      ,{158,'covered_recipient_id'}
      ,{159,'cov_rcp_raw_state_code'}
      ,{160,'cov_rcp_raw_full_name'}
      ,{161,'cov_rcp_raw_attribute1'}
      ,{162,'cov_rcp_raw_attribute2'}
      ,{163,'cov_rcp_raw_attribute3'}
      ,{164,'cov_rcp_raw_attribute4'}
      ,{165,'hms_scid'}
      ,{166,'school_name'}
      ,{167,'grad_year'}
      ,{168,'lang_code'}
      ,{169,'language'}
      ,{170,'specialty_description'}
      ,{171,'clean_phone'}
      ,{172,'bdid'}
      ,{173,'bdid_score'}
      ,{174,'did'}
      ,{175,'did_score'}
      ,{176,'clean_dob'}
      ,{177,'best_dob'}
      ,{178,'best_ssn'}
      ,{179,'rec_deactivated_date'}
      ,{180,'superceeding_piid'}
      ,{181,'dotid'}
      ,{182,'dotscore'}
      ,{183,'dotweight'}
      ,{184,'empid'}
      ,{185,'empscore'}
      ,{186,'empweight'}
      ,{187,'powid'}
      ,{188,'powscore'}
      ,{189,'powweight'}
      ,{190,'proxid'}
      ,{191,'proxscore'}
      ,{192,'proxweight'}
      ,{193,'seleid'}
      ,{194,'selescore'}
      ,{195,'seleweight'}
      ,{196,'orgid'}
      ,{197,'orgscore'}
      ,{198,'orgweight'}
      ,{199,'ultid'}
      ,{200,'ultscore'}
      ,{201,'ultweight'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Individuals_Fields.InValid_hms_piid((SALT31.StrType)le.hms_piid),
    Individuals_Fields.InValid_first((SALT31.StrType)le.first),
    Individuals_Fields.InValid_middle((SALT31.StrType)le.middle),
    Individuals_Fields.InValid_last((SALT31.StrType)le.last),
    Individuals_Fields.InValid_suffix((SALT31.StrType)le.suffix),
    Individuals_Fields.InValid_cred((SALT31.StrType)le.cred),
    Individuals_Fields.InValid_practitioner_type((SALT31.StrType)le.practitioner_type),
    Individuals_Fields.InValid_active((SALT31.StrType)le.active),
    Individuals_Fields.InValid_vendible((SALT31.StrType)le.vendible),
    Individuals_Fields.InValid_npi_num((SALT31.StrType)le.npi_num),
    Individuals_Fields.InValid_npi_enumeration_date((SALT31.StrType)le.npi_enumeration_date),
    Individuals_Fields.InValid_npi_deactivation_date((SALT31.StrType)le.npi_deactivation_date),
    Individuals_Fields.InValid_npi_reactivation_date((SALT31.StrType)le.npi_reactivation_date),
    Individuals_Fields.InValid_npi_taxonomy_code((SALT31.StrType)le.npi_taxonomy_code),
    Individuals_Fields.InValid_upin((SALT31.StrType)le.upin),
    Individuals_Fields.InValid_medicare_participation_flag((SALT31.StrType)le.medicare_participation_flag),
    Individuals_Fields.InValid_date_born((SALT31.StrType)le.date_born),
    Individuals_Fields.InValid_date_died((SALT31.StrType)le.date_died),
    Individuals_Fields.InValid_pid((SALT31.StrType)le.pid),
    Individuals_Fields.InValid_src((SALT31.StrType)le.src),
    Individuals_Fields.InValid_date_vendor_first_reported((SALT31.StrType)le.date_vendor_first_reported),
    Individuals_Fields.InValid_date_vendor_last_reported((SALT31.StrType)le.date_vendor_last_reported),
    Individuals_Fields.InValid_date_first_seen((SALT31.StrType)le.date_first_seen),
    Individuals_Fields.InValid_date_last_seen((SALT31.StrType)le.date_last_seen),
    Individuals_Fields.InValid_record_type((SALT31.StrType)le.record_type),
    Individuals_Fields.InValid_source_rid((SALT31.StrType)le.source_rid),
    Individuals_Fields.InValid_lnpid((SALT31.StrType)le.lnpid),
    Individuals_Fields.InValid_fname((SALT31.StrType)le.fname),
    Individuals_Fields.InValid_mname((SALT31.StrType)le.mname),
    Individuals_Fields.InValid_lname((SALT31.StrType)le.lname),
    Individuals_Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix),
    Individuals_Fields.InValid_nametype((SALT31.StrType)le.nametype),
    Individuals_Fields.InValid_nid((SALT31.StrType)le.nid),
    Individuals_Fields.InValid_clean_npi_enumeration_date((SALT31.StrType)le.clean_npi_enumeration_date),
    Individuals_Fields.InValid_clean_npi_deactivation_date((SALT31.StrType)le.clean_npi_deactivation_date),
    Individuals_Fields.InValid_clean_npi_reactivation_date((SALT31.StrType)le.clean_npi_reactivation_date),
    Individuals_Fields.InValid_clean_date_born((SALT31.StrType)le.clean_date_born),
    Individuals_Fields.InValid_clean_date_died((SALT31.StrType)le.clean_date_died),
    Individuals_Fields.InValid_clean_company_name((SALT31.StrType)le.clean_company_name),
    Individuals_Fields.InValid_prim_range((SALT31.StrType)le.prim_range),
    Individuals_Fields.InValid_predir((SALT31.StrType)le.predir),
    Individuals_Fields.InValid_prim_name((SALT31.StrType)le.prim_name),
    Individuals_Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix),
    Individuals_Fields.InValid_postdir((SALT31.StrType)le.postdir),
    Individuals_Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig),
    Individuals_Fields.InValid_sec_range((SALT31.StrType)le.sec_range),
    Individuals_Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name),
    Individuals_Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name),
    Individuals_Fields.InValid_st((SALT31.StrType)le.st),
    Individuals_Fields.InValid_zip((SALT31.StrType)le.zip),
    Individuals_Fields.InValid_zip4((SALT31.StrType)le.zip4),
    Individuals_Fields.InValid_cart((SALT31.StrType)le.cart),
    Individuals_Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz),
    Individuals_Fields.InValid_lot((SALT31.StrType)le.lot),
    Individuals_Fields.InValid_lot_order((SALT31.StrType)le.lot_order),
    Individuals_Fields.InValid_dbpc((SALT31.StrType)le.dbpc),
    Individuals_Fields.InValid_chk_digit((SALT31.StrType)le.chk_digit),
    Individuals_Fields.InValid_rec_type((SALT31.StrType)le.rec_type),
    Individuals_Fields.InValid_fips_st((SALT31.StrType)le.fips_st),
    Individuals_Fields.InValid_fips_county((SALT31.StrType)le.fips_county),
    Individuals_Fields.InValid_geo_lat((SALT31.StrType)le.geo_lat),
    Individuals_Fields.InValid_geo_long((SALT31.StrType)le.geo_long),
    Individuals_Fields.InValid_msa((SALT31.StrType)le.msa),
    Individuals_Fields.InValid_geo_blk((SALT31.StrType)le.geo_blk),
    Individuals_Fields.InValid_geo_match((SALT31.StrType)le.geo_match),
    Individuals_Fields.InValid_err_stat((SALT31.StrType)le.err_stat),
    Individuals_Fields.InValid_rawaid((SALT31.StrType)le.rawaid),
    Individuals_Fields.InValid_aceaid((SALT31.StrType)le.aceaid),
    Individuals_Fields.InValid_firm_name((SALT31.StrType)le.firm_name),
    Individuals_Fields.InValid_lid((SALT31.StrType)le.lid),
    Individuals_Fields.InValid_agid((SALT31.StrType)le.agid),
    Individuals_Fields.InValid_address_std_code((SALT31.StrType)le.address_std_code),
    Individuals_Fields.InValid_latitude((SALT31.StrType)le.latitude),
    Individuals_Fields.InValid_longitude((SALT31.StrType)le.longitude),
    Individuals_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1),
    Individuals_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2),
    Individuals_Fields.InValid_addr_type((SALT31.StrType)le.addr_type),
    Individuals_Fields.InValid_state_license_state((SALT31.StrType)le.state_license_state),
    Individuals_Fields.InValid_state_license_number((SALT31.StrType)le.state_license_number),
    Individuals_Fields.InValid_state_license_type((SALT31.StrType)le.state_license_type),
    Individuals_Fields.InValid_state_license_active((SALT31.StrType)le.state_license_active),
    Individuals_Fields.InValid_state_license_expire((SALT31.StrType)le.state_license_expire),
    Individuals_Fields.InValid_state_license_qualifier((SALT31.StrType)le.state_license_qualifier),
    Individuals_Fields.InValid_state_license_sub_qualifier((SALT31.StrType)le.state_license_sub_qualifier),
    Individuals_Fields.InValid_state_license_issued((SALT31.StrType)le.state_license_issued),
    Individuals_Fields.InValid_clean_state_license_expire((SALT31.StrType)le.clean_state_license_expire),
    Individuals_Fields.InValid_clean_state_license_issued((SALT31.StrType)le.clean_state_license_issued),
    Individuals_Fields.InValid_dea_num((SALT31.StrType)le.dea_num),
    Individuals_Fields.InValid_dea_bac((SALT31.StrType)le.dea_bac),
    Individuals_Fields.InValid_dea_sub_bac((SALT31.StrType)le.dea_sub_bac),
    Individuals_Fields.InValid_dea_schedule((SALT31.StrType)le.dea_schedule),
    Individuals_Fields.InValid_dea_expire((SALT31.StrType)le.dea_expire),
    Individuals_Fields.InValid_dea_active((SALT31.StrType)le.dea_active),
    Individuals_Fields.InValid_clean_dea_expire((SALT31.StrType)le.clean_dea_expire),
    Individuals_Fields.InValid_csr_number((SALT31.StrType)le.csr_number),
    Individuals_Fields.InValid_csr_state((SALT31.StrType)le.csr_state),
    Individuals_Fields.InValid_csr_expire_date((SALT31.StrType)le.csr_expire_date),
    Individuals_Fields.InValid_csr_issue_date((SALT31.StrType)le.csr_issue_date),
    Individuals_Fields.InValid_dsa_lvl_2((SALT31.StrType)le.dsa_lvl_2),
    Individuals_Fields.InValid_dsa_lvl_2n((SALT31.StrType)le.dsa_lvl_2n),
    Individuals_Fields.InValid_dsa_lvl_3((SALT31.StrType)le.dsa_lvl_3),
    Individuals_Fields.InValid_dsa_lvl_3n((SALT31.StrType)le.dsa_lvl_3n),
    Individuals_Fields.InValid_dsa_lvl_4((SALT31.StrType)le.dsa_lvl_4),
    Individuals_Fields.InValid_dsa_lvl_5((SALT31.StrType)le.dsa_lvl_5),
    Individuals_Fields.InValid_csr_raw1((SALT31.StrType)le.csr_raw1),
    Individuals_Fields.InValid_csr_raw2((SALT31.StrType)le.csr_raw2),
    Individuals_Fields.InValid_csr_raw3((SALT31.StrType)le.csr_raw3),
    Individuals_Fields.InValid_csr_raw4((SALT31.StrType)le.csr_raw4),
    Individuals_Fields.InValid_clean_csr_expire_date((SALT31.StrType)le.clean_csr_expire_date),
    Individuals_Fields.InValid_clean_csr_issue_date((SALT31.StrType)le.clean_csr_issue_date),
    Individuals_Fields.InValid_sanction_id((SALT31.StrType)le.sanction_id),
    Individuals_Fields.InValid_sanction_action_code((SALT31.StrType)le.sanction_action_code),
    Individuals_Fields.InValid_sanction_action_description((SALT31.StrType)le.sanction_action_description),
    Individuals_Fields.InValid_sanction_board_code((SALT31.StrType)le.sanction_board_code),
    Individuals_Fields.InValid_sanction_board_description((SALT31.StrType)le.sanction_board_description),
    Individuals_Fields.InValid_action_date((SALT31.StrType)le.action_date),
    Individuals_Fields.InValid_sanction_period_start_date((SALT31.StrType)le.sanction_period_start_date),
    Individuals_Fields.InValid_sanction_period_end_date((SALT31.StrType)le.sanction_period_end_date),
    Individuals_Fields.InValid_month_duration((SALT31.StrType)le.month_duration),
    Individuals_Fields.InValid_fine_amount((SALT31.StrType)le.fine_amount),
    Individuals_Fields.InValid_offense_code((SALT31.StrType)le.offense_code),
    Individuals_Fields.InValid_offense_description((SALT31.StrType)le.offense_description),
    Individuals_Fields.InValid_offense_date((SALT31.StrType)le.offense_date),
    Individuals_Fields.InValid_clean_offense_date((SALT31.StrType)le.clean_offense_date),
    Individuals_Fields.InValid_clean_action_date((SALT31.StrType)le.clean_action_date),
    Individuals_Fields.InValid_clean_sanction_period_start_date((SALT31.StrType)le.clean_sanction_period_start_date),
    Individuals_Fields.InValid_clean_sanction_period_end_date((SALT31.StrType)le.clean_sanction_period_end_date),
    Individuals_Fields.InValid_gsa_sanction_id((SALT31.StrType)le.gsa_sanction_id),
    Individuals_Fields.InValid_gsa_first((SALT31.StrType)le.gsa_first),
    Individuals_Fields.InValid_gsa_middle((SALT31.StrType)le.gsa_middle),
    Individuals_Fields.InValid_gsa_last((SALT31.StrType)le.gsa_last),
    Individuals_Fields.InValid_gsa_suffix((SALT31.StrType)le.gsa_suffix),
    Individuals_Fields.InValid_gsa_city((SALT31.StrType)le.gsa_city),
    Individuals_Fields.InValid_gsa_state((SALT31.StrType)le.gsa_state),
    Individuals_Fields.InValid_gsa_zip((SALT31.StrType)le.gsa_zip),
    Individuals_Fields.InValid_date((SALT31.StrType)le.date),
    Individuals_Fields.InValid_agency((SALT31.StrType)le.agency),
    Individuals_Fields.InValid_confidence((SALT31.StrType)le.confidence),
    Individuals_Fields.InValid_clean_gsa_first((SALT31.StrType)le.clean_gsa_first),
    Individuals_Fields.InValid_clean_gsa_middle((SALT31.StrType)le.clean_gsa_middle),
    Individuals_Fields.InValid_clean_gsa_last((SALT31.StrType)le.clean_gsa_last),
    Individuals_Fields.InValid_clean_gsa_suffix((SALT31.StrType)le.clean_gsa_suffix),
    Individuals_Fields.InValid_clean_gsa_city((SALT31.StrType)le.clean_gsa_city),
    Individuals_Fields.InValid_clean_gsa_state((SALT31.StrType)le.clean_gsa_state),
    Individuals_Fields.InValid_clean_gsa_zip((SALT31.StrType)le.clean_gsa_zip),
    Individuals_Fields.InValid_clean_gsa_action_date((SALT31.StrType)le.clean_gsa_action_date),
    Individuals_Fields.InValid_clean_gsa_date((SALT31.StrType)le.clean_gsa_date),
    Individuals_Fields.InValid_fax((SALT31.StrType)le.fax),
    Individuals_Fields.InValid_phone((SALT31.StrType)le.phone),
    Individuals_Fields.InValid_certification_code((SALT31.StrType)le.certification_code),
    Individuals_Fields.InValid_certification_description((SALT31.StrType)le.certification_description),
    Individuals_Fields.InValid_board_code((SALT31.StrType)le.board_code),
    Individuals_Fields.InValid_board_description((SALT31.StrType)le.board_description),
    Individuals_Fields.InValid_expiration_year((SALT31.StrType)le.expiration_year),
    Individuals_Fields.InValid_issue_year((SALT31.StrType)le.issue_year),
    Individuals_Fields.InValid_renewal_year((SALT31.StrType)le.renewal_year),
    Individuals_Fields.InValid_lifetime_flag((SALT31.StrType)le.lifetime_flag),
    Individuals_Fields.InValid_covered_recipient_id((SALT31.StrType)le.covered_recipient_id),
    Individuals_Fields.InValid_cov_rcp_raw_state_code((SALT31.StrType)le.cov_rcp_raw_state_code),
    Individuals_Fields.InValid_cov_rcp_raw_full_name((SALT31.StrType)le.cov_rcp_raw_full_name),
    Individuals_Fields.InValid_cov_rcp_raw_attribute1((SALT31.StrType)le.cov_rcp_raw_attribute1),
    Individuals_Fields.InValid_cov_rcp_raw_attribute2((SALT31.StrType)le.cov_rcp_raw_attribute2),
    Individuals_Fields.InValid_cov_rcp_raw_attribute3((SALT31.StrType)le.cov_rcp_raw_attribute3),
    Individuals_Fields.InValid_cov_rcp_raw_attribute4((SALT31.StrType)le.cov_rcp_raw_attribute4),
    Individuals_Fields.InValid_hms_scid((SALT31.StrType)le.hms_scid),
    Individuals_Fields.InValid_school_name((SALT31.StrType)le.school_name),
    Individuals_Fields.InValid_grad_year((SALT31.StrType)le.grad_year),
    Individuals_Fields.InValid_lang_code((SALT31.StrType)le.lang_code),
    Individuals_Fields.InValid_language((SALT31.StrType)le.language),
    Individuals_Fields.InValid_specialty_description((SALT31.StrType)le.specialty_description),
    Individuals_Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone),
    Individuals_Fields.InValid_bdid((SALT31.StrType)le.bdid),
    Individuals_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score),
    Individuals_Fields.InValid_did((SALT31.StrType)le.did),
    Individuals_Fields.InValid_did_score((SALT31.StrType)le.did_score),
    Individuals_Fields.InValid_clean_dob((SALT31.StrType)le.clean_dob),
    Individuals_Fields.InValid_best_dob((SALT31.StrType)le.best_dob),
    Individuals_Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn),
    Individuals_Fields.InValid_rec_deactivated_date((SALT31.StrType)le.rec_deactivated_date),
    Individuals_Fields.InValid_superceeding_piid((SALT31.StrType)le.superceeding_piid),
    Individuals_Fields.InValid_dotid((SALT31.StrType)le.dotid),
    Individuals_Fields.InValid_dotscore((SALT31.StrType)le.dotscore),
    Individuals_Fields.InValid_dotweight((SALT31.StrType)le.dotweight),
    Individuals_Fields.InValid_empid((SALT31.StrType)le.empid),
    Individuals_Fields.InValid_empscore((SALT31.StrType)le.empscore),
    Individuals_Fields.InValid_empweight((SALT31.StrType)le.empweight),
    Individuals_Fields.InValid_powid((SALT31.StrType)le.powid),
    Individuals_Fields.InValid_powscore((SALT31.StrType)le.powscore),
    Individuals_Fields.InValid_powweight((SALT31.StrType)le.powweight),
    Individuals_Fields.InValid_proxid((SALT31.StrType)le.proxid),
    Individuals_Fields.InValid_proxscore((SALT31.StrType)le.proxscore),
    Individuals_Fields.InValid_proxweight((SALT31.StrType)le.proxweight),
    Individuals_Fields.InValid_seleid((SALT31.StrType)le.seleid),
    Individuals_Fields.InValid_selescore((SALT31.StrType)le.selescore),
    Individuals_Fields.InValid_seleweight((SALT31.StrType)le.seleweight),
    Individuals_Fields.InValid_orgid((SALT31.StrType)le.orgid),
    Individuals_Fields.InValid_orgscore((SALT31.StrType)le.orgscore),
    Individuals_Fields.InValid_orgweight((SALT31.StrType)le.orgweight),
    Individuals_Fields.InValid_ultid((SALT31.StrType)le.ultid),
    Individuals_Fields.InValid_ultscore((SALT31.StrType)le.ultscore),
    Individuals_Fields.InValid_ultweight((SALT31.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,201,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Individuals_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'hms_piid','first','middle','last','suffix','cred','practitioner_type','active','vendible','npi_num','npi_enumeration_date','npi_deactivation_date','npi_reactivation_date','npi_taxonomy_code','upin','medicare_participation_flag','date_born','date_died','pid','src','date_vendor_first_reported','date_vendor_last_reported','date_first_seen','date_last_seen','record_type','source_rid','lnpid','fname','mname','lname','name_suffix','nametype','nid','clean_npi_enumeration_date','clean_npi_deactivation_date','clean_npi_reactivation_date','clean_date_born','clean_date_died','clean_company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','firm_name','lid','agid','address_std_code','latitude','longitude','prepped_addr1','prepped_addr2','addr_type','state_license_state','state_license_number','state_license_type','state_license_active','state_license_expire','state_license_qualifier','state_license_sub_qualifier','state_license_issued','clean_state_license_expire','clean_state_license_issued','dea_num','dea_bac','dea_sub_bac','dea_schedule','dea_expire','dea_active','clean_dea_expire','csr_number','csr_state','csr_expire_date','csr_issue_date','dsa_lvl_2','dsa_lvl_2n','dsa_lvl_3','dsa_lvl_3n','dsa_lvl_4','dsa_lvl_5','csr_raw1','csr_raw2','csr_raw3','csr_raw4','clean_csr_expire_date','clean_csr_issue_date','sanction_id','sanction_action_code','sanction_action_description','sanction_board_code','sanction_board_description','action_date','sanction_period_start_date','sanction_period_end_date','month_duration','fine_amount','offense_code','offense_description','offense_date','clean_offense_date','clean_action_date','clean_sanction_period_start_date','clean_sanction_period_end_date','gsa_sanction_id','gsa_first','gsa_middle','gsa_last','gsa_suffix','gsa_city','gsa_state','gsa_zip','date','agency','confidence','clean_gsa_first','clean_gsa_middle','clean_gsa_last','clean_gsa_suffix','clean_gsa_city','clean_gsa_state','clean_gsa_zip','clean_gsa_action_date','clean_gsa_date','fax','phone','certification_code','certification_description','board_code','board_description','expiration_year','issue_year','renewal_year','lifetime_flag','covered_recipient_id','cov_rcp_raw_state_code','cov_rcp_raw_full_name','cov_rcp_raw_attribute1','cov_rcp_raw_attribute2','cov_rcp_raw_attribute3','cov_rcp_raw_attribute4','hms_scid','school_name','grad_year','lang_code','language','specialty_description','clean_phone','bdid','bdid_score','did','did_score','clean_dob','best_dob','best_ssn','rec_deactivated_date','superceeding_piid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Individuals_Fields.InValidMessage_hms_piid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_first(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_middle(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_last(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cred(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_practitioner_type(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_active(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_vendible(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_npi_num(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_npi_enumeration_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_npi_deactivation_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_npi_reactivation_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_npi_taxonomy_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_upin(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_medicare_participation_flag(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date_born(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date_died(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_pid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_src(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_source_rid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_nid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_npi_enumeration_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_npi_deactivation_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_npi_reactivation_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_date_born(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_date_died(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_st(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_fips_st(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_firm_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_agid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_address_std_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_addr_type(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_state(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_number(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_type(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_active(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_expire(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_qualifier(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_sub_qualifier(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_state_license_issued(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_state_license_expire(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_state_license_issued(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dea_num(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dea_bac(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dea_sub_bac(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dea_schedule(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dea_expire(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dea_active(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_dea_expire(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_number(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_state(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_expire_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_issue_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dsa_lvl_2(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dsa_lvl_2n(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dsa_lvl_3(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dsa_lvl_3n(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dsa_lvl_4(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dsa_lvl_5(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_raw1(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_raw2(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_raw3(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_csr_raw4(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_csr_expire_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_csr_issue_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_id(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_action_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_action_description(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_board_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_board_description(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_action_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_period_start_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_sanction_period_end_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_month_duration(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_fine_amount(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_offense_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_offense_description(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_offense_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_offense_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_action_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_sanction_period_start_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_sanction_period_end_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_sanction_id(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_first(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_middle(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_last(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_suffix(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_city(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_state(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_gsa_zip(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_agency(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_confidence(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_first(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_middle(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_last(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_suffix(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_city(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_state(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_zip(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_action_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_gsa_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_fax(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_certification_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_certification_description(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_board_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_board_description(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_expiration_year(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_issue_year(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_renewal_year(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lifetime_flag(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_covered_recipient_id(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cov_rcp_raw_state_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cov_rcp_raw_full_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cov_rcp_raw_attribute1(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cov_rcp_raw_attribute2(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cov_rcp_raw_attribute3(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_cov_rcp_raw_attribute4(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_hms_scid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_school_name(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_grad_year(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_lang_code(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_language(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_specialty_description(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_did(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_clean_dob(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_best_dob(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_rec_deactivated_date(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_superceeding_piid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Individuals_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
