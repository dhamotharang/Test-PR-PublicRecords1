IMPORT SALT37;
EXPORT Base_hygiene(dataset(Base_layout_Equifax_Business_Data) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_normcompany_type_pcnt := AVE(GROUP,IF(h.normcompany_type = (TYPEOF(h.normcompany_type))'',0,100));
    maxlength_normcompany_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.normcompany_type)));
    avelength_normcompany_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.normcompany_type)),h.normcompany_type<>(typeof(h.normcompany_type))'');
    populated_normaddress_type_pcnt := AVE(GROUP,IF(h.normaddress_type = (TYPEOF(h.normaddress_type))'',0,100));
    maxlength_normaddress_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.normaddress_type)));
    avelength_normaddress_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.normaddress_type)),h.normaddress_type<>(typeof(h.normaddress_type))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_EFX_BUSSTATCD_pcnt := AVE(GROUP,IF(h.EFX_BUSSTATCD = (TYPEOF(h.EFX_BUSSTATCD))'',0,100));
    maxlength_EFX_BUSSTATCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTATCD)));
    avelength_EFX_BUSSTATCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTATCD)),h.EFX_BUSSTATCD<>(typeof(h.EFX_BUSSTATCD))'');
    populated_EFX_CMSA_pcnt := AVE(GROUP,IF(h.EFX_CMSA = (TYPEOF(h.EFX_CMSA))'',0,100));
    maxlength_EFX_CMSA := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSA)));
    avelength_EFX_CMSA := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSA)),h.EFX_CMSA<>(typeof(h.EFX_CMSA))'');
    populated_EFX_CORPAMOUNTCD_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNTCD = (TYPEOF(h.EFX_CORPAMOUNTCD))'',0,100));
    maxlength_EFX_CORPAMOUNTCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTCD)));
    avelength_EFX_CORPAMOUNTCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTCD)),h.EFX_CORPAMOUNTCD<>(typeof(h.EFX_CORPAMOUNTCD))'');
    populated_EFX_CORPAMOUNTPREC_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNTPREC = (TYPEOF(h.EFX_CORPAMOUNTPREC))'',0,100));
    maxlength_EFX_CORPAMOUNTPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTPREC)));
    avelength_EFX_CORPAMOUNTPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTPREC)),h.EFX_CORPAMOUNTPREC<>(typeof(h.EFX_CORPAMOUNTPREC))'');
    populated_EFX_CORPAMOUNTTP_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNTTP = (TYPEOF(h.EFX_CORPAMOUNTTP))'',0,100));
    maxlength_EFX_CORPAMOUNTTP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTTP)));
    avelength_EFX_CORPAMOUNTTP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNTTP)),h.EFX_CORPAMOUNTTP<>(typeof(h.EFX_CORPAMOUNTTP))'');
    populated_EFX_CORPEMPCD_pcnt := AVE(GROUP,IF(h.EFX_CORPEMPCD = (TYPEOF(h.EFX_CORPEMPCD))'',0,100));
    maxlength_EFX_CORPEMPCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCD)));
    avelength_EFX_CORPEMPCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCD)),h.EFX_CORPEMPCD<>(typeof(h.EFX_CORPEMPCD))'');
    populated_EFX_WEB_pcnt := AVE(GROUP,IF(h.EFX_WEB = (TYPEOF(h.EFX_WEB))'',0,100));
    maxlength_EFX_WEB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WEB)));
    avelength_EFX_WEB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WEB)),h.EFX_WEB<>(typeof(h.EFX_WEB))'');
    populated_EFX_CTRYISOCD_pcnt := AVE(GROUP,IF(h.EFX_CTRYISOCD = (TYPEOF(h.EFX_CTRYISOCD))'',0,100));
    maxlength_EFX_CTRYISOCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYISOCD)));
    avelength_EFX_CTRYISOCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYISOCD)),h.EFX_CTRYISOCD<>(typeof(h.EFX_CTRYISOCD))'');
    populated_EFX_CTRYNUM_pcnt := AVE(GROUP,IF(h.EFX_CTRYNUM = (TYPEOF(h.EFX_CTRYNUM))'',0,100));
    maxlength_EFX_CTRYNUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNUM)));
    avelength_EFX_CTRYNUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNUM)),h.EFX_CTRYNUM<>(typeof(h.EFX_CTRYNUM))'');
    populated_EFX_CTRYTELCD_pcnt := AVE(GROUP,IF(h.EFX_CTRYTELCD = (TYPEOF(h.EFX_CTRYTELCD))'',0,100));
    maxlength_EFX_CTRYTELCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYTELCD)));
    avelength_EFX_CTRYTELCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYTELCD)),h.EFX_CTRYTELCD<>(typeof(h.EFX_CTRYTELCD))'');
    populated_EFX_GEOPREC_pcnt := AVE(GROUP,IF(h.EFX_GEOPREC = (TYPEOF(h.EFX_GEOPREC))'',0,100));
    maxlength_EFX_GEOPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GEOPREC)));
    avelength_EFX_GEOPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GEOPREC)),h.EFX_GEOPREC<>(typeof(h.EFX_GEOPREC))'');
    populated_EFX_MERCTYPE_pcnt := AVE(GROUP,IF(h.EFX_MERCTYPE = (TYPEOF(h.EFX_MERCTYPE))'',0,100));
    maxlength_EFX_MERCTYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCTYPE)));
    avelength_EFX_MERCTYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCTYPE)),h.EFX_MERCTYPE<>(typeof(h.EFX_MERCTYPE))'');
    populated_EFX_MRKT_TELESCORE_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TELESCORE = (TYPEOF(h.EFX_MRKT_TELESCORE))'',0,100));
    maxlength_EFX_MRKT_TELESCORE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELESCORE)));
    avelength_EFX_MRKT_TELESCORE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELESCORE)),h.EFX_MRKT_TELESCORE<>(typeof(h.EFX_MRKT_TELESCORE))'');
    populated_EFX_MRKT_TOTALIND_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TOTALIND = (TYPEOF(h.EFX_MRKT_TOTALIND))'',0,100));
    maxlength_EFX_MRKT_TOTALIND := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALIND)));
    avelength_EFX_MRKT_TOTALIND := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALIND)),h.EFX_MRKT_TOTALIND<>(typeof(h.EFX_MRKT_TOTALIND))'');
    populated_EFX_MRKT_TOTALSCORE_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TOTALSCORE = (TYPEOF(h.EFX_MRKT_TOTALSCORE))'',0,100));
    maxlength_EFX_MRKT_TOTALSCORE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALSCORE)));
    avelength_EFX_MRKT_TOTALSCORE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TOTALSCORE)),h.EFX_MRKT_TOTALSCORE<>(typeof(h.EFX_MRKT_TOTALSCORE))'');
    populated_EFX_PUBLIC_pcnt := AVE(GROUP,IF(h.EFX_PUBLIC = (TYPEOF(h.EFX_PUBLIC))'',0,100));
    maxlength_EFX_PUBLIC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PUBLIC)));
    avelength_EFX_PUBLIC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PUBLIC)),h.EFX_PUBLIC<>(typeof(h.EFX_PUBLIC))'');
    populated_EFX_STATEC_pcnt := AVE(GROUP,IF(h.EFX_STATEC = (TYPEOF(h.EFX_STATEC))'',0,100));
    maxlength_EFX_STATEC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC)));
    avelength_EFX_STATEC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC)),h.EFX_STATEC<>(typeof(h.EFX_STATEC))'');
    populated_EFX_STKEXC_pcnt := AVE(GROUP,IF(h.EFX_STKEXC = (TYPEOF(h.EFX_STKEXC))'',0,100));
    maxlength_EFX_STKEXC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STKEXC)));
    avelength_EFX_STKEXC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STKEXC)),h.EFX_STKEXC<>(typeof(h.EFX_STKEXC))'');
    populated_EFX_PRIMSIC_pcnt := AVE(GROUP,IF(h.EFX_PRIMSIC = (TYPEOF(h.EFX_PRIMSIC))'',0,100));
    maxlength_EFX_PRIMSIC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSIC)));
    avelength_EFX_PRIMSIC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSIC)),h.EFX_PRIMSIC<>(typeof(h.EFX_PRIMSIC))'');
    populated_EFX_SECSIC1_pcnt := AVE(GROUP,IF(h.EFX_SECSIC1 = (TYPEOF(h.EFX_SECSIC1))'',0,100));
    maxlength_EFX_SECSIC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC1)));
    avelength_EFX_SECSIC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC1)),h.EFX_SECSIC1<>(typeof(h.EFX_SECSIC1))'');
    populated_EFX_SECSIC2_pcnt := AVE(GROUP,IF(h.EFX_SECSIC2 = (TYPEOF(h.EFX_SECSIC2))'',0,100));
    maxlength_EFX_SECSIC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC2)));
    avelength_EFX_SECSIC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC2)),h.EFX_SECSIC2<>(typeof(h.EFX_SECSIC2))'');
    populated_EFX_SECSIC3_pcnt := AVE(GROUP,IF(h.EFX_SECSIC3 = (TYPEOF(h.EFX_SECSIC3))'',0,100));
    maxlength_EFX_SECSIC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC3)));
    avelength_EFX_SECSIC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC3)),h.EFX_SECSIC3<>(typeof(h.EFX_SECSIC3))'');
    populated_EFX_SECSIC4_pcnt := AVE(GROUP,IF(h.EFX_SECSIC4 = (TYPEOF(h.EFX_SECSIC4))'',0,100));
    maxlength_EFX_SECSIC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC4)));
    avelength_EFX_SECSIC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSIC4)),h.EFX_SECSIC4<>(typeof(h.EFX_SECSIC4))'');
    populated_EFX_STATE_pcnt := AVE(GROUP,IF(h.EFX_STATE = (TYPEOF(h.EFX_STATE))'',0,100));
    maxlength_EFX_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATE)));
    avelength_EFX_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATE)),h.EFX_STATE<>(typeof(h.EFX_STATE))'');
    populated_EFX_ID_pcnt := AVE(GROUP,IF(h.EFX_ID = (TYPEOF(h.EFX_ID))'',0,100));
    maxlength_EFX_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ID)));
    avelength_EFX_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ID)),h.EFX_ID<>(typeof(h.EFX_ID))'');
    populated_EFX_NAME_pcnt := AVE(GROUP,IF(h.EFX_NAME = (TYPEOF(h.EFX_NAME))'',0,100));
    maxlength_EFX_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NAME)));
    avelength_EFX_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NAME)),h.EFX_NAME<>(typeof(h.EFX_NAME))'');
    populated_EFX_LEGAL_NAME_pcnt := AVE(GROUP,IF(h.EFX_LEGAL_NAME = (TYPEOF(h.EFX_LEGAL_NAME))'',0,100));
    maxlength_EFX_LEGAL_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LEGAL_NAME)));
    avelength_EFX_LEGAL_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LEGAL_NAME)),h.EFX_LEGAL_NAME<>(typeof(h.EFX_LEGAL_NAME))'');
    populated_EFX_ADDRESS_pcnt := AVE(GROUP,IF(h.EFX_ADDRESS = (TYPEOF(h.EFX_ADDRESS))'',0,100));
    maxlength_EFX_ADDRESS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ADDRESS)));
    avelength_EFX_ADDRESS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ADDRESS)),h.EFX_ADDRESS<>(typeof(h.EFX_ADDRESS))'');
    populated_EFX_CITY_pcnt := AVE(GROUP,IF(h.EFX_CITY = (TYPEOF(h.EFX_CITY))'',0,100));
    maxlength_EFX_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CITY)));
    avelength_EFX_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CITY)),h.EFX_CITY<>(typeof(h.EFX_CITY))'');
    populated_EFX_REGION_pcnt := AVE(GROUP,IF(h.EFX_REGION = (TYPEOF(h.EFX_REGION))'',0,100));
    maxlength_EFX_REGION := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_REGION)));
    avelength_EFX_REGION := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_REGION)),h.EFX_REGION<>(typeof(h.EFX_REGION))'');
    populated_EFX_CTRYNAME_pcnt := AVE(GROUP,IF(h.EFX_CTRYNAME = (TYPEOF(h.EFX_CTRYNAME))'',0,100));
    maxlength_EFX_CTRYNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNAME)));
    avelength_EFX_CTRYNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CTRYNAME)),h.EFX_CTRYNAME<>(typeof(h.EFX_CTRYNAME))'');
    populated_EFX_COUNTYNM_pcnt := AVE(GROUP,IF(h.EFX_COUNTYNM = (TYPEOF(h.EFX_COUNTYNM))'',0,100));
    maxlength_EFX_COUNTYNM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_COUNTYNM)));
    avelength_EFX_COUNTYNM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_COUNTYNM)),h.EFX_COUNTYNM<>(typeof(h.EFX_COUNTYNM))'');
    populated_EFX_CMSADESC_pcnt := AVE(GROUP,IF(h.EFX_CMSADESC = (TYPEOF(h.EFX_CMSADESC))'',0,100));
    maxlength_EFX_CMSADESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSADESC)));
    avelength_EFX_CMSADESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMSADESC)),h.EFX_CMSADESC<>(typeof(h.EFX_CMSADESC))'');
    populated_EFX_SOHO_pcnt := AVE(GROUP,IF(h.EFX_SOHO = (TYPEOF(h.EFX_SOHO))'',0,100));
    maxlength_EFX_SOHO := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SOHO)));
    avelength_EFX_SOHO := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SOHO)),h.EFX_SOHO<>(typeof(h.EFX_SOHO))'');
    populated_EFX_BIZ_pcnt := AVE(GROUP,IF(h.EFX_BIZ = (TYPEOF(h.EFX_BIZ))'',0,100));
    maxlength_EFX_BIZ := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BIZ)));
    avelength_EFX_BIZ := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BIZ)),h.EFX_BIZ<>(typeof(h.EFX_BIZ))'');
    populated_EFX_RES_pcnt := AVE(GROUP,IF(h.EFX_RES = (TYPEOF(h.EFX_RES))'',0,100));
    maxlength_EFX_RES := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_RES)));
    avelength_EFX_RES := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_RES)),h.EFX_RES<>(typeof(h.EFX_RES))'');
    populated_EFX_CMRA_pcnt := AVE(GROUP,IF(h.EFX_CMRA = (TYPEOF(h.EFX_CMRA))'',0,100));
    maxlength_EFX_CMRA := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMRA)));
    avelength_EFX_CMRA := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CMRA)),h.EFX_CMRA<>(typeof(h.EFX_CMRA))'');
    populated_EFX_SECADR_pcnt := AVE(GROUP,IF(h.EFX_SECADR = (TYPEOF(h.EFX_SECADR))'',0,100));
    maxlength_EFX_SECADR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECADR)));
    avelength_EFX_SECADR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECADR)),h.EFX_SECADR<>(typeof(h.EFX_SECADR))'');
    populated_EFX_SECCTY_pcnt := AVE(GROUP,IF(h.EFX_SECCTY = (TYPEOF(h.EFX_SECCTY))'',0,100));
    maxlength_EFX_SECCTY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTY)));
    avelength_EFX_SECCTY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTY)),h.EFX_SECCTY<>(typeof(h.EFX_SECCTY))'');
    populated_EFX_SECSTAT_pcnt := AVE(GROUP,IF(h.EFX_SECSTAT = (TYPEOF(h.EFX_SECSTAT))'',0,100));
    maxlength_EFX_SECSTAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSTAT)));
    avelength_EFX_SECSTAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSTAT)),h.EFX_SECSTAT<>(typeof(h.EFX_SECSTAT))'');
    populated_EFX_STATEC2_pcnt := AVE(GROUP,IF(h.EFX_STATEC2 = (TYPEOF(h.EFX_STATEC2))'',0,100));
    maxlength_EFX_STATEC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC2)));
    avelength_EFX_STATEC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_STATEC2)),h.EFX_STATEC2<>(typeof(h.EFX_STATEC2))'');
    populated_EFX_SECGEOPREC_pcnt := AVE(GROUP,IF(h.EFX_SECGEOPREC = (TYPEOF(h.EFX_SECGEOPREC))'',0,100));
    maxlength_EFX_SECGEOPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECGEOPREC)));
    avelength_EFX_SECGEOPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECGEOPREC)),h.EFX_SECGEOPREC<>(typeof(h.EFX_SECGEOPREC))'');
    populated_EFX_SECREGION_pcnt := AVE(GROUP,IF(h.EFX_SECREGION = (TYPEOF(h.EFX_SECREGION))'',0,100));
    maxlength_EFX_SECREGION := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECREGION)));
    avelength_EFX_SECREGION := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECREGION)),h.EFX_SECREGION<>(typeof(h.EFX_SECREGION))'');
    populated_EFX_SECCTRYISOCD_pcnt := AVE(GROUP,IF(h.EFX_SECCTRYISOCD = (TYPEOF(h.EFX_SECCTRYISOCD))'',0,100));
    maxlength_EFX_SECCTRYISOCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYISOCD)));
    avelength_EFX_SECCTRYISOCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYISOCD)),h.EFX_SECCTRYISOCD<>(typeof(h.EFX_SECCTRYISOCD))'');
    populated_EFX_SECCTRYNUM_pcnt := AVE(GROUP,IF(h.EFX_SECCTRYNUM = (TYPEOF(h.EFX_SECCTRYNUM))'',0,100));
    maxlength_EFX_SECCTRYNUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNUM)));
    avelength_EFX_SECCTRYNUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNUM)),h.EFX_SECCTRYNUM<>(typeof(h.EFX_SECCTRYNUM))'');
    populated_EFX_SECCTRYNAME_pcnt := AVE(GROUP,IF(h.EFX_SECCTRYNAME = (TYPEOF(h.EFX_SECCTRYNAME))'',0,100));
    maxlength_EFX_SECCTRYNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNAME)));
    avelength_EFX_SECCTRYNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECCTRYNAME)),h.EFX_SECCTRYNAME<>(typeof(h.EFX_SECCTRYNAME))'');
    populated_EFX_PHONE_pcnt := AVE(GROUP,IF(h.EFX_PHONE = (TYPEOF(h.EFX_PHONE))'',0,100));
    maxlength_EFX_PHONE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PHONE)));
    avelength_EFX_PHONE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PHONE)),h.EFX_PHONE<>(typeof(h.EFX_PHONE))'');
    populated_EFX_FAXPHONE_pcnt := AVE(GROUP,IF(h.EFX_FAXPHONE = (TYPEOF(h.EFX_FAXPHONE))'',0,100));
    maxlength_EFX_FAXPHONE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FAXPHONE)));
    avelength_EFX_FAXPHONE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FAXPHONE)),h.EFX_FAXPHONE<>(typeof(h.EFX_FAXPHONE))'');
    populated_EFX_BUSSTAT_pcnt := AVE(GROUP,IF(h.EFX_BUSSTAT = (TYPEOF(h.EFX_BUSSTAT))'',0,100));
    maxlength_EFX_BUSSTAT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTAT)));
    avelength_EFX_BUSSTAT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSTAT)),h.EFX_BUSSTAT<>(typeof(h.EFX_BUSSTAT))'');
    populated_EFX_YREST_pcnt := AVE(GROUP,IF(h.EFX_YREST = (TYPEOF(h.EFX_YREST))'',0,100));
    maxlength_EFX_YREST := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_YREST)));
    avelength_EFX_YREST := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_YREST)),h.EFX_YREST<>(typeof(h.EFX_YREST))'');
    populated_EFX_CORPEMPCNT_pcnt := AVE(GROUP,IF(h.EFX_CORPEMPCNT = (TYPEOF(h.EFX_CORPEMPCNT))'',0,100));
    maxlength_EFX_CORPEMPCNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCNT)));
    avelength_EFX_CORPEMPCNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPEMPCNT)),h.EFX_CORPEMPCNT<>(typeof(h.EFX_CORPEMPCNT))'');
    populated_EFX_LOCEMPCNT_pcnt := AVE(GROUP,IF(h.EFX_LOCEMPCNT = (TYPEOF(h.EFX_LOCEMPCNT))'',0,100));
    maxlength_EFX_LOCEMPCNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCNT)));
    avelength_EFX_LOCEMPCNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCNT)),h.EFX_LOCEMPCNT<>(typeof(h.EFX_LOCEMPCNT))'');
    populated_EFX_LOCEMPCD_pcnt := AVE(GROUP,IF(h.EFX_LOCEMPCD = (TYPEOF(h.EFX_LOCEMPCD))'',0,100));
    maxlength_EFX_LOCEMPCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCD)));
    avelength_EFX_LOCEMPCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCEMPCD)),h.EFX_LOCEMPCD<>(typeof(h.EFX_LOCEMPCD))'');
    populated_EFX_CORPAMOUNT_pcnt := AVE(GROUP,IF(h.EFX_CORPAMOUNT = (TYPEOF(h.EFX_CORPAMOUNT))'',0,100));
    maxlength_EFX_CORPAMOUNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNT)));
    avelength_EFX_CORPAMOUNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CORPAMOUNT)),h.EFX_CORPAMOUNT<>(typeof(h.EFX_CORPAMOUNT))'');
    populated_EFX_LOCAMOUNT_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNT = (TYPEOF(h.EFX_LOCAMOUNT))'',0,100));
    maxlength_EFX_LOCAMOUNT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNT)));
    avelength_EFX_LOCAMOUNT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNT)),h.EFX_LOCAMOUNT<>(typeof(h.EFX_LOCAMOUNT))'');
    populated_EFX_LOCAMOUNTCD_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNTCD = (TYPEOF(h.EFX_LOCAMOUNTCD))'',0,100));
    maxlength_EFX_LOCAMOUNTCD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTCD)));
    avelength_EFX_LOCAMOUNTCD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTCD)),h.EFX_LOCAMOUNTCD<>(typeof(h.EFX_LOCAMOUNTCD))'');
    populated_EFX_LOCAMOUNTTP_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNTTP = (TYPEOF(h.EFX_LOCAMOUNTTP))'',0,100));
    maxlength_EFX_LOCAMOUNTTP := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTTP)));
    avelength_EFX_LOCAMOUNTTP := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTTP)),h.EFX_LOCAMOUNTTP<>(typeof(h.EFX_LOCAMOUNTTP))'');
    populated_EFX_LOCAMOUNTPREC_pcnt := AVE(GROUP,IF(h.EFX_LOCAMOUNTPREC = (TYPEOF(h.EFX_LOCAMOUNTPREC))'',0,100));
    maxlength_EFX_LOCAMOUNTPREC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTPREC)));
    avelength_EFX_LOCAMOUNTPREC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LOCAMOUNTPREC)),h.EFX_LOCAMOUNTPREC<>(typeof(h.EFX_LOCAMOUNTPREC))'');
    populated_EFX_TCKSYM_pcnt := AVE(GROUP,IF(h.EFX_TCKSYM = (TYPEOF(h.EFX_TCKSYM))'',0,100));
    maxlength_EFX_TCKSYM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TCKSYM)));
    avelength_EFX_TCKSYM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TCKSYM)),h.EFX_TCKSYM<>(typeof(h.EFX_TCKSYM))'');
    populated_EFX_PRIMSICDESC_pcnt := AVE(GROUP,IF(h.EFX_PRIMSICDESC = (TYPEOF(h.EFX_PRIMSICDESC))'',0,100));
    maxlength_EFX_PRIMSICDESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSICDESC)));
    avelength_EFX_PRIMSICDESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMSICDESC)),h.EFX_PRIMSICDESC<>(typeof(h.EFX_PRIMSICDESC))'');
    populated_EFX_SECSICDESC1_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC1 = (TYPEOF(h.EFX_SECSICDESC1))'',0,100));
    maxlength_EFX_SECSICDESC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC1)));
    avelength_EFX_SECSICDESC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC1)),h.EFX_SECSICDESC1<>(typeof(h.EFX_SECSICDESC1))'');
    populated_EFX_SECSICDESC2_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC2 = (TYPEOF(h.EFX_SECSICDESC2))'',0,100));
    maxlength_EFX_SECSICDESC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC2)));
    avelength_EFX_SECSICDESC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC2)),h.EFX_SECSICDESC2<>(typeof(h.EFX_SECSICDESC2))'');
    populated_EFX_SECSICDESC3_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC3 = (TYPEOF(h.EFX_SECSICDESC3))'',0,100));
    maxlength_EFX_SECSICDESC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC3)));
    avelength_EFX_SECSICDESC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC3)),h.EFX_SECSICDESC3<>(typeof(h.EFX_SECSICDESC3))'');
    populated_EFX_SECSICDESC4_pcnt := AVE(GROUP,IF(h.EFX_SECSICDESC4 = (TYPEOF(h.EFX_SECSICDESC4))'',0,100));
    maxlength_EFX_SECSICDESC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC4)));
    avelength_EFX_SECSICDESC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECSICDESC4)),h.EFX_SECSICDESC4<>(typeof(h.EFX_SECSICDESC4))'');
    populated_EFX_PRIMNAICSCODE_pcnt := AVE(GROUP,IF(h.EFX_PRIMNAICSCODE = (TYPEOF(h.EFX_PRIMNAICSCODE))'',0,100));
    maxlength_EFX_PRIMNAICSCODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSCODE)));
    avelength_EFX_PRIMNAICSCODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSCODE)),h.EFX_PRIMNAICSCODE<>(typeof(h.EFX_PRIMNAICSCODE))'');
    populated_EFX_SECNAICS1_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS1 = (TYPEOF(h.EFX_SECNAICS1))'',0,100));
    maxlength_EFX_SECNAICS1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS1)));
    avelength_EFX_SECNAICS1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS1)),h.EFX_SECNAICS1<>(typeof(h.EFX_SECNAICS1))'');
    populated_EFX_SECNAICS2_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS2 = (TYPEOF(h.EFX_SECNAICS2))'',0,100));
    maxlength_EFX_SECNAICS2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS2)));
    avelength_EFX_SECNAICS2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS2)),h.EFX_SECNAICS2<>(typeof(h.EFX_SECNAICS2))'');
    populated_EFX_SECNAICS3_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS3 = (TYPEOF(h.EFX_SECNAICS3))'',0,100));
    maxlength_EFX_SECNAICS3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS3)));
    avelength_EFX_SECNAICS3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS3)),h.EFX_SECNAICS3<>(typeof(h.EFX_SECNAICS3))'');
    populated_EFX_SECNAICS4_pcnt := AVE(GROUP,IF(h.EFX_SECNAICS4 = (TYPEOF(h.EFX_SECNAICS4))'',0,100));
    maxlength_EFX_SECNAICS4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS4)));
    avelength_EFX_SECNAICS4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICS4)),h.EFX_SECNAICS4<>(typeof(h.EFX_SECNAICS4))'');
    populated_EFX_PRIMNAICSDESC_pcnt := AVE(GROUP,IF(h.EFX_PRIMNAICSDESC = (TYPEOF(h.EFX_PRIMNAICSDESC))'',0,100));
    maxlength_EFX_PRIMNAICSDESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSDESC)));
    avelength_EFX_PRIMNAICSDESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PRIMNAICSDESC)),h.EFX_PRIMNAICSDESC<>(typeof(h.EFX_PRIMNAICSDESC))'');
    populated_EFX_SECNAICSDESC1_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC1 = (TYPEOF(h.EFX_SECNAICSDESC1))'',0,100));
    maxlength_EFX_SECNAICSDESC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC1)));
    avelength_EFX_SECNAICSDESC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC1)),h.EFX_SECNAICSDESC1<>(typeof(h.EFX_SECNAICSDESC1))'');
    populated_EFX_SECNAICSDESC2_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC2 = (TYPEOF(h.EFX_SECNAICSDESC2))'',0,100));
    maxlength_EFX_SECNAICSDESC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC2)));
    avelength_EFX_SECNAICSDESC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC2)),h.EFX_SECNAICSDESC2<>(typeof(h.EFX_SECNAICSDESC2))'');
    populated_EFX_SECNAICSDESC3_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC3 = (TYPEOF(h.EFX_SECNAICSDESC3))'',0,100));
    maxlength_EFX_SECNAICSDESC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC3)));
    avelength_EFX_SECNAICSDESC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC3)),h.EFX_SECNAICSDESC3<>(typeof(h.EFX_SECNAICSDESC3))'');
    populated_EFX_SECNAICSDESC4_pcnt := AVE(GROUP,IF(h.EFX_SECNAICSDESC4 = (TYPEOF(h.EFX_SECNAICSDESC4))'',0,100));
    maxlength_EFX_SECNAICSDESC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC4)));
    avelength_EFX_SECNAICSDESC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SECNAICSDESC4)),h.EFX_SECNAICSDESC4<>(typeof(h.EFX_SECNAICSDESC4))'');
    populated_EFX_DEAD_pcnt := AVE(GROUP,IF(h.EFX_DEAD = (TYPEOF(h.EFX_DEAD))'',0,100));
    maxlength_EFX_DEAD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEAD)));
    avelength_EFX_DEAD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEAD)),h.EFX_DEAD<>(typeof(h.EFX_DEAD))'');
    populated_EFX_DEADDT_pcnt := AVE(GROUP,IF(h.EFX_DEADDT = (TYPEOF(h.EFX_DEADDT))'',0,100));
    maxlength_EFX_DEADDT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEADDT)));
    avelength_EFX_DEADDT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DEADDT)),h.EFX_DEADDT<>(typeof(h.EFX_DEADDT))'');
    populated_EFX_MRKT_TELEVER_pcnt := AVE(GROUP,IF(h.EFX_MRKT_TELEVER = (TYPEOF(h.EFX_MRKT_TELEVER))'',0,100));
    maxlength_EFX_MRKT_TELEVER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELEVER)));
    avelength_EFX_MRKT_TELEVER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_TELEVER)),h.EFX_MRKT_TELEVER<>(typeof(h.EFX_MRKT_TELEVER))'');
    populated_EFX_MRKT_VACANT_pcnt := AVE(GROUP,IF(h.EFX_MRKT_VACANT = (TYPEOF(h.EFX_MRKT_VACANT))'',0,100));
    maxlength_EFX_MRKT_VACANT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_VACANT)));
    avelength_EFX_MRKT_VACANT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_VACANT)),h.EFX_MRKT_VACANT<>(typeof(h.EFX_MRKT_VACANT))'');
    populated_EFX_MRKT_SEASONAL_pcnt := AVE(GROUP,IF(h.EFX_MRKT_SEASONAL = (TYPEOF(h.EFX_MRKT_SEASONAL))'',0,100));
    maxlength_EFX_MRKT_SEASONAL := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_SEASONAL)));
    avelength_EFX_MRKT_SEASONAL := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MRKT_SEASONAL)),h.EFX_MRKT_SEASONAL<>(typeof(h.EFX_MRKT_SEASONAL))'');
    populated_EFX_MBE_pcnt := AVE(GROUP,IF(h.EFX_MBE = (TYPEOF(h.EFX_MBE))'',0,100));
    maxlength_EFX_MBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MBE)));
    avelength_EFX_MBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MBE)),h.EFX_MBE<>(typeof(h.EFX_MBE))'');
    populated_EFX_WBE_pcnt := AVE(GROUP,IF(h.EFX_WBE = (TYPEOF(h.EFX_WBE))'',0,100));
    maxlength_EFX_WBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBE)));
    avelength_EFX_WBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBE)),h.EFX_WBE<>(typeof(h.EFX_WBE))'');
    populated_EFX_MWBE_pcnt := AVE(GROUP,IF(h.EFX_MWBE = (TYPEOF(h.EFX_MWBE))'',0,100));
    maxlength_EFX_MWBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBE)));
    avelength_EFX_MWBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBE)),h.EFX_MWBE<>(typeof(h.EFX_MWBE))'');
    populated_EFX_SDB_pcnt := AVE(GROUP,IF(h.EFX_SDB = (TYPEOF(h.EFX_SDB))'',0,100));
    maxlength_EFX_SDB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SDB)));
    avelength_EFX_SDB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SDB)),h.EFX_SDB<>(typeof(h.EFX_SDB))'');
    populated_EFX_HUBZONE_pcnt := AVE(GROUP,IF(h.EFX_HUBZONE = (TYPEOF(h.EFX_HUBZONE))'',0,100));
    maxlength_EFX_HUBZONE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HUBZONE)));
    avelength_EFX_HUBZONE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HUBZONE)),h.EFX_HUBZONE<>(typeof(h.EFX_HUBZONE))'');
    populated_EFX_DBE_pcnt := AVE(GROUP,IF(h.EFX_DBE = (TYPEOF(h.EFX_DBE))'',0,100));
    maxlength_EFX_DBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DBE)));
    avelength_EFX_DBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DBE)),h.EFX_DBE<>(typeof(h.EFX_DBE))'');
    populated_EFX_VET_pcnt := AVE(GROUP,IF(h.EFX_VET = (TYPEOF(h.EFX_VET))'',0,100));
    maxlength_EFX_VET := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VET)));
    avelength_EFX_VET := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VET)),h.EFX_VET<>(typeof(h.EFX_VET))'');
    populated_EFX_DVET_pcnt := AVE(GROUP,IF(h.EFX_DVET = (TYPEOF(h.EFX_DVET))'',0,100));
    maxlength_EFX_DVET := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVET)));
    avelength_EFX_DVET := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVET)),h.EFX_DVET<>(typeof(h.EFX_DVET))'');
    populated_EFX_8a_pcnt := AVE(GROUP,IF(h.EFX_8a = (TYPEOF(h.EFX_8a))'',0,100));
    maxlength_EFX_8a := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8a)));
    avelength_EFX_8a := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8a)),h.EFX_8a<>(typeof(h.EFX_8a))'');
    populated_EFX_8aEXPDT_pcnt := AVE(GROUP,IF(h.EFX_8aEXPDT = (TYPEOF(h.EFX_8aEXPDT))'',0,100));
    maxlength_EFX_8aEXPDT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8aEXPDT)));
    avelength_EFX_8aEXPDT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_8aEXPDT)),h.EFX_8aEXPDT<>(typeof(h.EFX_8aEXPDT))'');
    populated_EFX_DIS_pcnt := AVE(GROUP,IF(h.EFX_DIS = (TYPEOF(h.EFX_DIS))'',0,100));
    maxlength_EFX_DIS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DIS)));
    avelength_EFX_DIS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DIS)),h.EFX_DIS<>(typeof(h.EFX_DIS))'');
    populated_EFX_SBE_pcnt := AVE(GROUP,IF(h.EFX_SBE = (TYPEOF(h.EFX_SBE))'',0,100));
    maxlength_EFX_SBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SBE)));
    avelength_EFX_SBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_SBE)),h.EFX_SBE<>(typeof(h.EFX_SBE))'');
    populated_EFX_BUSSIZE_pcnt := AVE(GROUP,IF(h.EFX_BUSSIZE = (TYPEOF(h.EFX_BUSSIZE))'',0,100));
    maxlength_EFX_BUSSIZE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSIZE)));
    avelength_EFX_BUSSIZE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_BUSSIZE)),h.EFX_BUSSIZE<>(typeof(h.EFX_BUSSIZE))'');
    populated_EFX_LBE_pcnt := AVE(GROUP,IF(h.EFX_LBE = (TYPEOF(h.EFX_LBE))'',0,100));
    maxlength_EFX_LBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LBE)));
    avelength_EFX_LBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_LBE)),h.EFX_LBE<>(typeof(h.EFX_LBE))'');
    populated_EFX_GOV_pcnt := AVE(GROUP,IF(h.EFX_GOV = (TYPEOF(h.EFX_GOV))'',0,100));
    maxlength_EFX_GOV := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GOV)));
    avelength_EFX_GOV := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GOV)),h.EFX_GOV<>(typeof(h.EFX_GOV))'');
    populated_EFX_FGOV_pcnt := AVE(GROUP,IF(h.EFX_FGOV = (TYPEOF(h.EFX_FGOV))'',0,100));
    maxlength_EFX_FGOV := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FGOV)));
    avelength_EFX_FGOV := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FGOV)),h.EFX_FGOV<>(typeof(h.EFX_FGOV))'');
    populated_EFX_NONPROFIT_pcnt := AVE(GROUP,IF(h.EFX_NONPROFIT = (TYPEOF(h.EFX_NONPROFIT))'',0,100));
    maxlength_EFX_NONPROFIT := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NONPROFIT)));
    avelength_EFX_NONPROFIT := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NONPROFIT)),h.EFX_NONPROFIT<>(typeof(h.EFX_NONPROFIT))'');
    populated_EFX_HBCU_pcnt := AVE(GROUP,IF(h.EFX_HBCU = (TYPEOF(h.EFX_HBCU))'',0,100));
    maxlength_EFX_HBCU := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HBCU)));
    avelength_EFX_HBCU := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_HBCU)),h.EFX_HBCU<>(typeof(h.EFX_HBCU))'');
    populated_EFX_GAYLESBIAN_pcnt := AVE(GROUP,IF(h.EFX_GAYLESBIAN = (TYPEOF(h.EFX_GAYLESBIAN))'',0,100));
    maxlength_EFX_GAYLESBIAN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GAYLESBIAN)));
    avelength_EFX_GAYLESBIAN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GAYLESBIAN)),h.EFX_GAYLESBIAN<>(typeof(h.EFX_GAYLESBIAN))'');
    populated_EFX_WSBE_pcnt := AVE(GROUP,IF(h.EFX_WSBE = (TYPEOF(h.EFX_WSBE))'',0,100));
    maxlength_EFX_WSBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WSBE)));
    avelength_EFX_WSBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WSBE)),h.EFX_WSBE<>(typeof(h.EFX_WSBE))'');
    populated_EFX_VSBE_pcnt := AVE(GROUP,IF(h.EFX_VSBE = (TYPEOF(h.EFX_VSBE))'',0,100));
    maxlength_EFX_VSBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VSBE)));
    avelength_EFX_VSBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_VSBE)),h.EFX_VSBE<>(typeof(h.EFX_VSBE))'');
    populated_EFX_DVSBE_pcnt := AVE(GROUP,IF(h.EFX_DVSBE = (TYPEOF(h.EFX_DVSBE))'',0,100));
    maxlength_EFX_DVSBE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVSBE)));
    avelength_EFX_DVSBE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DVSBE)),h.EFX_DVSBE<>(typeof(h.EFX_DVSBE))'');
    populated_EFX_MWBESTATUS_pcnt := AVE(GROUP,IF(h.EFX_MWBESTATUS = (TYPEOF(h.EFX_MWBESTATUS))'',0,100));
    maxlength_EFX_MWBESTATUS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBESTATUS)));
    avelength_EFX_MWBESTATUS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MWBESTATUS)),h.EFX_MWBESTATUS<>(typeof(h.EFX_MWBESTATUS))'');
    populated_EFX_NMSDC_pcnt := AVE(GROUP,IF(h.EFX_NMSDC = (TYPEOF(h.EFX_NMSDC))'',0,100));
    maxlength_EFX_NMSDC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NMSDC)));
    avelength_EFX_NMSDC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_NMSDC)),h.EFX_NMSDC<>(typeof(h.EFX_NMSDC))'');
    populated_EFX_WBENC_pcnt := AVE(GROUP,IF(h.EFX_WBENC = (TYPEOF(h.EFX_WBENC))'',0,100));
    maxlength_EFX_WBENC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBENC)));
    avelength_EFX_WBENC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_WBENC)),h.EFX_WBENC<>(typeof(h.EFX_WBENC))'');
    populated_EFX_CA_PUC_pcnt := AVE(GROUP,IF(h.EFX_CA_PUC = (TYPEOF(h.EFX_CA_PUC))'',0,100));
    maxlength_EFX_CA_PUC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CA_PUC)));
    avelength_EFX_CA_PUC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CA_PUC)),h.EFX_CA_PUC<>(typeof(h.EFX_CA_PUC))'');
    populated_EFX_TX_HUB_pcnt := AVE(GROUP,IF(h.EFX_TX_HUB = (TYPEOF(h.EFX_TX_HUB))'',0,100));
    maxlength_EFX_TX_HUB := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TX_HUB)));
    avelength_EFX_TX_HUB := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_TX_HUB)),h.EFX_TX_HUB<>(typeof(h.EFX_TX_HUB))'');
    populated_EFX_GSAX_pcnt := AVE(GROUP,IF(h.EFX_GSAX = (TYPEOF(h.EFX_GSAX))'',0,100));
    maxlength_EFX_GSAX := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GSAX)));
    avelength_EFX_GSAX := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_GSAX)),h.EFX_GSAX<>(typeof(h.EFX_GSAX))'');
    populated_EFX_CALTRANS_pcnt := AVE(GROUP,IF(h.EFX_CALTRANS = (TYPEOF(h.EFX_CALTRANS))'',0,100));
    maxlength_EFX_CALTRANS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CALTRANS)));
    avelength_EFX_CALTRANS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_CALTRANS)),h.EFX_CALTRANS<>(typeof(h.EFX_CALTRANS))'');
    populated_EFX_EDU_pcnt := AVE(GROUP,IF(h.EFX_EDU = (TYPEOF(h.EFX_EDU))'',0,100));
    maxlength_EFX_EDU := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EDU)));
    avelength_EFX_EDU := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EDU)),h.EFX_EDU<>(typeof(h.EFX_EDU))'');
    populated_EFX_MI_pcnt := AVE(GROUP,IF(h.EFX_MI = (TYPEOF(h.EFX_MI))'',0,100));
    maxlength_EFX_MI := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MI)));
    avelength_EFX_MI := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MI)),h.EFX_MI<>(typeof(h.EFX_MI))'');
    populated_EFX_ANC_pcnt := AVE(GROUP,IF(h.EFX_ANC = (TYPEOF(h.EFX_ANC))'',0,100));
    maxlength_EFX_ANC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ANC)));
    avelength_EFX_ANC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_ANC)),h.EFX_ANC<>(typeof(h.EFX_ANC))'');
    populated_AT_CERT1_pcnt := AVE(GROUP,IF(h.AT_CERT1 = (TYPEOF(h.AT_CERT1))'',0,100));
    maxlength_AT_CERT1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT1)));
    avelength_AT_CERT1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT1)),h.AT_CERT1<>(typeof(h.AT_CERT1))'');
    populated_AT_CERT2_pcnt := AVE(GROUP,IF(h.AT_CERT2 = (TYPEOF(h.AT_CERT2))'',0,100));
    maxlength_AT_CERT2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT2)));
    avelength_AT_CERT2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT2)),h.AT_CERT2<>(typeof(h.AT_CERT2))'');
    populated_AT_CERT3_pcnt := AVE(GROUP,IF(h.AT_CERT3 = (TYPEOF(h.AT_CERT3))'',0,100));
    maxlength_AT_CERT3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT3)));
    avelength_AT_CERT3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT3)),h.AT_CERT3<>(typeof(h.AT_CERT3))'');
    populated_AT_CERT4_pcnt := AVE(GROUP,IF(h.AT_CERT4 = (TYPEOF(h.AT_CERT4))'',0,100));
    maxlength_AT_CERT4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT4)));
    avelength_AT_CERT4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT4)),h.AT_CERT4<>(typeof(h.AT_CERT4))'');
    populated_AT_CERT5_pcnt := AVE(GROUP,IF(h.AT_CERT5 = (TYPEOF(h.AT_CERT5))'',0,100));
    maxlength_AT_CERT5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT5)));
    avelength_AT_CERT5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT5)),h.AT_CERT5<>(typeof(h.AT_CERT5))'');
    populated_AT_CERT6_pcnt := AVE(GROUP,IF(h.AT_CERT6 = (TYPEOF(h.AT_CERT6))'',0,100));
    maxlength_AT_CERT6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT6)));
    avelength_AT_CERT6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT6)),h.AT_CERT6<>(typeof(h.AT_CERT6))'');
    populated_AT_CERT7_pcnt := AVE(GROUP,IF(h.AT_CERT7 = (TYPEOF(h.AT_CERT7))'',0,100));
    maxlength_AT_CERT7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT7)));
    avelength_AT_CERT7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT7)),h.AT_CERT7<>(typeof(h.AT_CERT7))'');
    populated_AT_CERT8_pcnt := AVE(GROUP,IF(h.AT_CERT8 = (TYPEOF(h.AT_CERT8))'',0,100));
    maxlength_AT_CERT8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT8)));
    avelength_AT_CERT8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT8)),h.AT_CERT8<>(typeof(h.AT_CERT8))'');
    populated_AT_CERT9_pcnt := AVE(GROUP,IF(h.AT_CERT9 = (TYPEOF(h.AT_CERT9))'',0,100));
    maxlength_AT_CERT9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT9)));
    avelength_AT_CERT9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT9)),h.AT_CERT9<>(typeof(h.AT_CERT9))'');
    populated_AT_CERT10_pcnt := AVE(GROUP,IF(h.AT_CERT10 = (TYPEOF(h.AT_CERT10))'',0,100));
    maxlength_AT_CERT10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT10)));
    avelength_AT_CERT10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERT10)),h.AT_CERT10<>(typeof(h.AT_CERT10))'');
    populated_AT_CERTDESC1_pcnt := AVE(GROUP,IF(h.AT_CERTDESC1 = (TYPEOF(h.AT_CERTDESC1))'',0,100));
    maxlength_AT_CERTDESC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC1)));
    avelength_AT_CERTDESC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC1)),h.AT_CERTDESC1<>(typeof(h.AT_CERTDESC1))'');
    populated_AT_CERTDESC2_pcnt := AVE(GROUP,IF(h.AT_CERTDESC2 = (TYPEOF(h.AT_CERTDESC2))'',0,100));
    maxlength_AT_CERTDESC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC2)));
    avelength_AT_CERTDESC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC2)),h.AT_CERTDESC2<>(typeof(h.AT_CERTDESC2))'');
    populated_AT_CERTDESC3_pcnt := AVE(GROUP,IF(h.AT_CERTDESC3 = (TYPEOF(h.AT_CERTDESC3))'',0,100));
    maxlength_AT_CERTDESC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC3)));
    avelength_AT_CERTDESC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC3)),h.AT_CERTDESC3<>(typeof(h.AT_CERTDESC3))'');
    populated_AT_CERTDESC4_pcnt := AVE(GROUP,IF(h.AT_CERTDESC4 = (TYPEOF(h.AT_CERTDESC4))'',0,100));
    maxlength_AT_CERTDESC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC4)));
    avelength_AT_CERTDESC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC4)),h.AT_CERTDESC4<>(typeof(h.AT_CERTDESC4))'');
    populated_AT_CERTDESC5_pcnt := AVE(GROUP,IF(h.AT_CERTDESC5 = (TYPEOF(h.AT_CERTDESC5))'',0,100));
    maxlength_AT_CERTDESC5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC5)));
    avelength_AT_CERTDESC5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC5)),h.AT_CERTDESC5<>(typeof(h.AT_CERTDESC5))'');
    populated_AT_CERTDESC6_pcnt := AVE(GROUP,IF(h.AT_CERTDESC6 = (TYPEOF(h.AT_CERTDESC6))'',0,100));
    maxlength_AT_CERTDESC6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC6)));
    avelength_AT_CERTDESC6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC6)),h.AT_CERTDESC6<>(typeof(h.AT_CERTDESC6))'');
    populated_AT_CERTDESC7_pcnt := AVE(GROUP,IF(h.AT_CERTDESC7 = (TYPEOF(h.AT_CERTDESC7))'',0,100));
    maxlength_AT_CERTDESC7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC7)));
    avelength_AT_CERTDESC7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC7)),h.AT_CERTDESC7<>(typeof(h.AT_CERTDESC7))'');
    populated_AT_CERTDESC8_pcnt := AVE(GROUP,IF(h.AT_CERTDESC8 = (TYPEOF(h.AT_CERTDESC8))'',0,100));
    maxlength_AT_CERTDESC8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC8)));
    avelength_AT_CERTDESC8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC8)),h.AT_CERTDESC8<>(typeof(h.AT_CERTDESC8))'');
    populated_AT_CERTDESC9_pcnt := AVE(GROUP,IF(h.AT_CERTDESC9 = (TYPEOF(h.AT_CERTDESC9))'',0,100));
    maxlength_AT_CERTDESC9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC9)));
    avelength_AT_CERTDESC9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC9)),h.AT_CERTDESC9<>(typeof(h.AT_CERTDESC9))'');
    populated_AT_CERTDESC10_pcnt := AVE(GROUP,IF(h.AT_CERTDESC10 = (TYPEOF(h.AT_CERTDESC10))'',0,100));
    maxlength_AT_CERTDESC10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC10)));
    avelength_AT_CERTDESC10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTDESC10)),h.AT_CERTDESC10<>(typeof(h.AT_CERTDESC10))'');
    populated_AT_CERTSRC1_pcnt := AVE(GROUP,IF(h.AT_CERTSRC1 = (TYPEOF(h.AT_CERTSRC1))'',0,100));
    maxlength_AT_CERTSRC1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC1)));
    avelength_AT_CERTSRC1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC1)),h.AT_CERTSRC1<>(typeof(h.AT_CERTSRC1))'');
    populated_AT_CERTSRC2_pcnt := AVE(GROUP,IF(h.AT_CERTSRC2 = (TYPEOF(h.AT_CERTSRC2))'',0,100));
    maxlength_AT_CERTSRC2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC2)));
    avelength_AT_CERTSRC2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC2)),h.AT_CERTSRC2<>(typeof(h.AT_CERTSRC2))'');
    populated_AT_CERTSRC3_pcnt := AVE(GROUP,IF(h.AT_CERTSRC3 = (TYPEOF(h.AT_CERTSRC3))'',0,100));
    maxlength_AT_CERTSRC3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC3)));
    avelength_AT_CERTSRC3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC3)),h.AT_CERTSRC3<>(typeof(h.AT_CERTSRC3))'');
    populated_AT_CERTSRC4_pcnt := AVE(GROUP,IF(h.AT_CERTSRC4 = (TYPEOF(h.AT_CERTSRC4))'',0,100));
    maxlength_AT_CERTSRC4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC4)));
    avelength_AT_CERTSRC4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC4)),h.AT_CERTSRC4<>(typeof(h.AT_CERTSRC4))'');
    populated_AT_CERTSRC5_pcnt := AVE(GROUP,IF(h.AT_CERTSRC5 = (TYPEOF(h.AT_CERTSRC5))'',0,100));
    maxlength_AT_CERTSRC5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC5)));
    avelength_AT_CERTSRC5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC5)),h.AT_CERTSRC5<>(typeof(h.AT_CERTSRC5))'');
    populated_AT_CERTSRC6_pcnt := AVE(GROUP,IF(h.AT_CERTSRC6 = (TYPEOF(h.AT_CERTSRC6))'',0,100));
    maxlength_AT_CERTSRC6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC6)));
    avelength_AT_CERTSRC6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC6)),h.AT_CERTSRC6<>(typeof(h.AT_CERTSRC6))'');
    populated_AT_CERTSRC7_pcnt := AVE(GROUP,IF(h.AT_CERTSRC7 = (TYPEOF(h.AT_CERTSRC7))'',0,100));
    maxlength_AT_CERTSRC7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC7)));
    avelength_AT_CERTSRC7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC7)),h.AT_CERTSRC7<>(typeof(h.AT_CERTSRC7))'');
    populated_AT_CERTSRC8_pcnt := AVE(GROUP,IF(h.AT_CERTSRC8 = (TYPEOF(h.AT_CERTSRC8))'',0,100));
    maxlength_AT_CERTSRC8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC8)));
    avelength_AT_CERTSRC8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC8)),h.AT_CERTSRC8<>(typeof(h.AT_CERTSRC8))'');
    populated_AT_CERTSRC9_pcnt := AVE(GROUP,IF(h.AT_CERTSRC9 = (TYPEOF(h.AT_CERTSRC9))'',0,100));
    maxlength_AT_CERTSRC9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC9)));
    avelength_AT_CERTSRC9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC9)),h.AT_CERTSRC9<>(typeof(h.AT_CERTSRC9))'');
    populated_AT_CERTSRC10_pcnt := AVE(GROUP,IF(h.AT_CERTSRC10 = (TYPEOF(h.AT_CERTSRC10))'',0,100));
    maxlength_AT_CERTSRC10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC10)));
    avelength_AT_CERTSRC10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTSRC10)),h.AT_CERTSRC10<>(typeof(h.AT_CERTSRC10))'');
    populated_AT_CERTNUM1_pcnt := AVE(GROUP,IF(h.AT_CERTNUM1 = (TYPEOF(h.AT_CERTNUM1))'',0,100));
    maxlength_AT_CERTNUM1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM1)));
    avelength_AT_CERTNUM1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM1)),h.AT_CERTNUM1<>(typeof(h.AT_CERTNUM1))'');
    populated_AT_CERTNUM2_pcnt := AVE(GROUP,IF(h.AT_CERTNUM2 = (TYPEOF(h.AT_CERTNUM2))'',0,100));
    maxlength_AT_CERTNUM2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM2)));
    avelength_AT_CERTNUM2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM2)),h.AT_CERTNUM2<>(typeof(h.AT_CERTNUM2))'');
    populated_AT_CERTNUM3_pcnt := AVE(GROUP,IF(h.AT_CERTNUM3 = (TYPEOF(h.AT_CERTNUM3))'',0,100));
    maxlength_AT_CERTNUM3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM3)));
    avelength_AT_CERTNUM3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM3)),h.AT_CERTNUM3<>(typeof(h.AT_CERTNUM3))'');
    populated_AT_CERTNUM4_pcnt := AVE(GROUP,IF(h.AT_CERTNUM4 = (TYPEOF(h.AT_CERTNUM4))'',0,100));
    maxlength_AT_CERTNUM4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM4)));
    avelength_AT_CERTNUM4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM4)),h.AT_CERTNUM4<>(typeof(h.AT_CERTNUM4))'');
    populated_AT_CERTNUM5_pcnt := AVE(GROUP,IF(h.AT_CERTNUM5 = (TYPEOF(h.AT_CERTNUM5))'',0,100));
    maxlength_AT_CERTNUM5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM5)));
    avelength_AT_CERTNUM5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM5)),h.AT_CERTNUM5<>(typeof(h.AT_CERTNUM5))'');
    populated_AT_CERTNUM6_pcnt := AVE(GROUP,IF(h.AT_CERTNUM6 = (TYPEOF(h.AT_CERTNUM6))'',0,100));
    maxlength_AT_CERTNUM6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM6)));
    avelength_AT_CERTNUM6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM6)),h.AT_CERTNUM6<>(typeof(h.AT_CERTNUM6))'');
    populated_AT_CERTNUM7_pcnt := AVE(GROUP,IF(h.AT_CERTNUM7 = (TYPEOF(h.AT_CERTNUM7))'',0,100));
    maxlength_AT_CERTNUM7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM7)));
    avelength_AT_CERTNUM7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM7)),h.AT_CERTNUM7<>(typeof(h.AT_CERTNUM7))'');
    populated_AT_CERTNUM8_pcnt := AVE(GROUP,IF(h.AT_CERTNUM8 = (TYPEOF(h.AT_CERTNUM8))'',0,100));
    maxlength_AT_CERTNUM8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM8)));
    avelength_AT_CERTNUM8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM8)),h.AT_CERTNUM8<>(typeof(h.AT_CERTNUM8))'');
    populated_AT_CERTNUM9_pcnt := AVE(GROUP,IF(h.AT_CERTNUM9 = (TYPEOF(h.AT_CERTNUM9))'',0,100));
    maxlength_AT_CERTNUM9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM9)));
    avelength_AT_CERTNUM9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM9)),h.AT_CERTNUM9<>(typeof(h.AT_CERTNUM9))'');
    populated_AT_CERTNUM10_pcnt := AVE(GROUP,IF(h.AT_CERTNUM10 = (TYPEOF(h.AT_CERTNUM10))'',0,100));
    maxlength_AT_CERTNUM10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM10)));
    avelength_AT_CERTNUM10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTNUM10)),h.AT_CERTNUM10<>(typeof(h.AT_CERTNUM10))'');
    populated_AT_CERTLEV1_pcnt := AVE(GROUP,IF(h.AT_CERTLEV1 = (TYPEOF(h.AT_CERTLEV1))'',0,100));
    maxlength_AT_CERTLEV1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV1)));
    avelength_AT_CERTLEV1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV1)),h.AT_CERTLEV1<>(typeof(h.AT_CERTLEV1))'');
    populated_AT_CERTLEV2_pcnt := AVE(GROUP,IF(h.AT_CERTLEV2 = (TYPEOF(h.AT_CERTLEV2))'',0,100));
    maxlength_AT_CERTLEV2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV2)));
    avelength_AT_CERTLEV2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV2)),h.AT_CERTLEV2<>(typeof(h.AT_CERTLEV2))'');
    populated_AT_CERTLEV3_pcnt := AVE(GROUP,IF(h.AT_CERTLEV3 = (TYPEOF(h.AT_CERTLEV3))'',0,100));
    maxlength_AT_CERTLEV3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV3)));
    avelength_AT_CERTLEV3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV3)),h.AT_CERTLEV3<>(typeof(h.AT_CERTLEV3))'');
    populated_AT_CERTLEV4_pcnt := AVE(GROUP,IF(h.AT_CERTLEV4 = (TYPEOF(h.AT_CERTLEV4))'',0,100));
    maxlength_AT_CERTLEV4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV4)));
    avelength_AT_CERTLEV4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV4)),h.AT_CERTLEV4<>(typeof(h.AT_CERTLEV4))'');
    populated_AT_CERTLEV5_pcnt := AVE(GROUP,IF(h.AT_CERTLEV5 = (TYPEOF(h.AT_CERTLEV5))'',0,100));
    maxlength_AT_CERTLEV5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV5)));
    avelength_AT_CERTLEV5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV5)),h.AT_CERTLEV5<>(typeof(h.AT_CERTLEV5))'');
    populated_AT_CERTLEV6_pcnt := AVE(GROUP,IF(h.AT_CERTLEV6 = (TYPEOF(h.AT_CERTLEV6))'',0,100));
    maxlength_AT_CERTLEV6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV6)));
    avelength_AT_CERTLEV6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV6)),h.AT_CERTLEV6<>(typeof(h.AT_CERTLEV6))'');
    populated_AT_CERTLEV7_pcnt := AVE(GROUP,IF(h.AT_CERTLEV7 = (TYPEOF(h.AT_CERTLEV7))'',0,100));
    maxlength_AT_CERTLEV7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV7)));
    avelength_AT_CERTLEV7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV7)),h.AT_CERTLEV7<>(typeof(h.AT_CERTLEV7))'');
    populated_AT_CERTLEV8_pcnt := AVE(GROUP,IF(h.AT_CERTLEV8 = (TYPEOF(h.AT_CERTLEV8))'',0,100));
    maxlength_AT_CERTLEV8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV8)));
    avelength_AT_CERTLEV8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV8)),h.AT_CERTLEV8<>(typeof(h.AT_CERTLEV8))'');
    populated_AT_CERTLEV9_pcnt := AVE(GROUP,IF(h.AT_CERTLEV9 = (TYPEOF(h.AT_CERTLEV9))'',0,100));
    maxlength_AT_CERTLEV9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV9)));
    avelength_AT_CERTLEV9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV9)),h.AT_CERTLEV9<>(typeof(h.AT_CERTLEV9))'');
    populated_AT_CERTLEV10_pcnt := AVE(GROUP,IF(h.AT_CERTLEV10 = (TYPEOF(h.AT_CERTLEV10))'',0,100));
    maxlength_AT_CERTLEV10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV10)));
    avelength_AT_CERTLEV10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTLEV10)),h.AT_CERTLEV10<>(typeof(h.AT_CERTLEV10))'');
    populated_AT_CERTEXP1_pcnt := AVE(GROUP,IF(h.AT_CERTEXP1 = (TYPEOF(h.AT_CERTEXP1))'',0,100));
    maxlength_AT_CERTEXP1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP1)));
    avelength_AT_CERTEXP1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP1)),h.AT_CERTEXP1<>(typeof(h.AT_CERTEXP1))'');
    populated_AT_CERTEXP2_pcnt := AVE(GROUP,IF(h.AT_CERTEXP2 = (TYPEOF(h.AT_CERTEXP2))'',0,100));
    maxlength_AT_CERTEXP2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP2)));
    avelength_AT_CERTEXP2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP2)),h.AT_CERTEXP2<>(typeof(h.AT_CERTEXP2))'');
    populated_AT_CERTEXP3_pcnt := AVE(GROUP,IF(h.AT_CERTEXP3 = (TYPEOF(h.AT_CERTEXP3))'',0,100));
    maxlength_AT_CERTEXP3 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP3)));
    avelength_AT_CERTEXP3 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP3)),h.AT_CERTEXP3<>(typeof(h.AT_CERTEXP3))'');
    populated_AT_CERTEXP4_pcnt := AVE(GROUP,IF(h.AT_CERTEXP4 = (TYPEOF(h.AT_CERTEXP4))'',0,100));
    maxlength_AT_CERTEXP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP4)));
    avelength_AT_CERTEXP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP4)),h.AT_CERTEXP4<>(typeof(h.AT_CERTEXP4))'');
    populated_AT_CERTEXP5_pcnt := AVE(GROUP,IF(h.AT_CERTEXP5 = (TYPEOF(h.AT_CERTEXP5))'',0,100));
    maxlength_AT_CERTEXP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP5)));
    avelength_AT_CERTEXP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP5)),h.AT_CERTEXP5<>(typeof(h.AT_CERTEXP5))'');
    populated_AT_CERTEXP6_pcnt := AVE(GROUP,IF(h.AT_CERTEXP6 = (TYPEOF(h.AT_CERTEXP6))'',0,100));
    maxlength_AT_CERTEXP6 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP6)));
    avelength_AT_CERTEXP6 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP6)),h.AT_CERTEXP6<>(typeof(h.AT_CERTEXP6))'');
    populated_AT_CERTEXP7_pcnt := AVE(GROUP,IF(h.AT_CERTEXP7 = (TYPEOF(h.AT_CERTEXP7))'',0,100));
    maxlength_AT_CERTEXP7 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP7)));
    avelength_AT_CERTEXP7 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP7)),h.AT_CERTEXP7<>(typeof(h.AT_CERTEXP7))'');
    populated_AT_CERTEXP8_pcnt := AVE(GROUP,IF(h.AT_CERTEXP8 = (TYPEOF(h.AT_CERTEXP8))'',0,100));
    maxlength_AT_CERTEXP8 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP8)));
    avelength_AT_CERTEXP8 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP8)),h.AT_CERTEXP8<>(typeof(h.AT_CERTEXP8))'');
    populated_AT_CERTEXP9_pcnt := AVE(GROUP,IF(h.AT_CERTEXP9 = (TYPEOF(h.AT_CERTEXP9))'',0,100));
    maxlength_AT_CERTEXP9 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP9)));
    avelength_AT_CERTEXP9 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP9)),h.AT_CERTEXP9<>(typeof(h.AT_CERTEXP9))'');
    populated_AT_CERTEXP10_pcnt := AVE(GROUP,IF(h.AT_CERTEXP10 = (TYPEOF(h.AT_CERTEXP10))'',0,100));
    maxlength_AT_CERTEXP10 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP10)));
    avelength_AT_CERTEXP10 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.AT_CERTEXP10)),h.AT_CERTEXP10<>(typeof(h.AT_CERTEXP10))'');
    populated_EFX_EXTRACT_DATE_pcnt := AVE(GROUP,IF(h.EFX_EXTRACT_DATE = (TYPEOF(h.EFX_EXTRACT_DATE))'',0,100));
    maxlength_EFX_EXTRACT_DATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EXTRACT_DATE)));
    avelength_EFX_EXTRACT_DATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_EXTRACT_DATE)),h.EFX_EXTRACT_DATE<>(typeof(h.EFX_EXTRACT_DATE))'');
    populated_EFX_MERCHANT_ID_pcnt := AVE(GROUP,IF(h.EFX_MERCHANT_ID = (TYPEOF(h.EFX_MERCHANT_ID))'',0,100));
    maxlength_EFX_MERCHANT_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCHANT_ID)));
    avelength_EFX_MERCHANT_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_MERCHANT_ID)),h.EFX_MERCHANT_ID<>(typeof(h.EFX_MERCHANT_ID))'');
    populated_EFX_PROJECT_ID_pcnt := AVE(GROUP,IF(h.EFX_PROJECT_ID = (TYPEOF(h.EFX_PROJECT_ID))'',0,100));
    maxlength_EFX_PROJECT_ID := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PROJECT_ID)));
    avelength_EFX_PROJECT_ID := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_PROJECT_ID)),h.EFX_PROJECT_ID<>(typeof(h.EFX_PROJECT_ID))'');
    populated_EFX_FOREIGN_pcnt := AVE(GROUP,IF(h.EFX_FOREIGN = (TYPEOF(h.EFX_FOREIGN))'',0,100));
    maxlength_EFX_FOREIGN := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FOREIGN)));
    avelength_EFX_FOREIGN := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_FOREIGN)),h.EFX_FOREIGN<>(typeof(h.EFX_FOREIGN))'');
    populated_Record_Update_Refresh_Date_pcnt := AVE(GROUP,IF(h.Record_Update_Refresh_Date = (TYPEOF(h.Record_Update_Refresh_Date))'',0,100));
    maxlength_Record_Update_Refresh_Date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Record_Update_Refresh_Date)));
    avelength_Record_Update_Refresh_Date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Record_Update_Refresh_Date)),h.Record_Update_Refresh_Date<>(typeof(h.Record_Update_Refresh_Date))'');
    populated_EFX_DATE_CREATED_pcnt := AVE(GROUP,IF(h.EFX_DATE_CREATED = (TYPEOF(h.EFX_DATE_CREATED))'',0,100));
    maxlength_EFX_DATE_CREATED := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DATE_CREATED)));
    avelength_EFX_DATE_CREATED := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EFX_DATE_CREATED)),h.EFX_DATE_CREATED<>(typeof(h.EFX_DATE_CREATED))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_normcompany_type_pcnt *   0.00 / 100 + T.Populated_normaddress_type_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_EFX_BUSSTATCD_pcnt *   0.00 / 100 + T.Populated_EFX_CMSA_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNTCD_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNTPREC_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNTTP_pcnt *   0.00 / 100 + T.Populated_EFX_CORPEMPCD_pcnt *   0.00 / 100 + T.Populated_EFX_WEB_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYISOCD_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYNUM_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYTELCD_pcnt *   0.00 / 100 + T.Populated_EFX_GEOPREC_pcnt *   0.00 / 100 + T.Populated_EFX_MERCTYPE_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TELESCORE_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TOTALIND_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TOTALSCORE_pcnt *   0.00 / 100 + T.Populated_EFX_PUBLIC_pcnt *   0.00 / 100 + T.Populated_EFX_STATEC_pcnt *   0.00 / 100 + T.Populated_EFX_STKEXC_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMSIC_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC1_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC3_pcnt *   0.00 / 100 + T.Populated_EFX_SECSIC4_pcnt *   0.00 / 100 + T.Populated_EFX_STATE_pcnt *   0.00 / 100 + T.Populated_EFX_ID_pcnt *   0.00 / 100 + T.Populated_EFX_NAME_pcnt *   0.00 / 100 + T.Populated_EFX_LEGAL_NAME_pcnt *   0.00 / 100 + T.Populated_EFX_ADDRESS_pcnt *   0.00 / 100 + T.Populated_EFX_CITY_pcnt *   0.00 / 100 + T.Populated_EFX_REGION_pcnt *   0.00 / 100 + T.Populated_EFX_CTRYNAME_pcnt *   0.00 / 100 + T.Populated_EFX_COUNTYNM_pcnt *   0.00 / 100 + T.Populated_EFX_CMSADESC_pcnt *   0.00 / 100 + T.Populated_EFX_SOHO_pcnt *   0.00 / 100 + T.Populated_EFX_BIZ_pcnt *   0.00 / 100 + T.Populated_EFX_RES_pcnt *   0.00 / 100 + T.Populated_EFX_CMRA_pcnt *   0.00 / 100 + T.Populated_EFX_SECADR_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTY_pcnt *   0.00 / 100 + T.Populated_EFX_SECSTAT_pcnt *   0.00 / 100 + T.Populated_EFX_STATEC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECGEOPREC_pcnt *   0.00 / 100 + T.Populated_EFX_SECREGION_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTRYISOCD_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTRYNUM_pcnt *   0.00 / 100 + T.Populated_EFX_SECCTRYNAME_pcnt *   0.00 / 100 + T.Populated_EFX_PHONE_pcnt *   0.00 / 100 + T.Populated_EFX_FAXPHONE_pcnt *   0.00 / 100 + T.Populated_EFX_BUSSTAT_pcnt *   0.00 / 100 + T.Populated_EFX_YREST_pcnt *   0.00 / 100 + T.Populated_EFX_CORPEMPCNT_pcnt *   0.00 / 100 + T.Populated_EFX_LOCEMPCNT_pcnt *   0.00 / 100 + T.Populated_EFX_LOCEMPCD_pcnt *   0.00 / 100 + T.Populated_EFX_CORPAMOUNT_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNT_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNTCD_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNTTP_pcnt *   0.00 / 100 + T.Populated_EFX_LOCAMOUNTPREC_pcnt *   0.00 / 100 + T.Populated_EFX_TCKSYM_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMSICDESC_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC1_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC3_pcnt *   0.00 / 100 + T.Populated_EFX_SECSICDESC4_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMNAICSCODE_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS1_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS2_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS3_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICS4_pcnt *   0.00 / 100 + T.Populated_EFX_PRIMNAICSDESC_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC1_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC2_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC3_pcnt *   0.00 / 100 + T.Populated_EFX_SECNAICSDESC4_pcnt *   0.00 / 100 + T.Populated_EFX_DEAD_pcnt *   0.00 / 100 + T.Populated_EFX_DEADDT_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_TELEVER_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_VACANT_pcnt *   0.00 / 100 + T.Populated_EFX_MRKT_SEASONAL_pcnt *   0.00 / 100 + T.Populated_EFX_MBE_pcnt *   0.00 / 100 + T.Populated_EFX_WBE_pcnt *   0.00 / 100 + T.Populated_EFX_MWBE_pcnt *   0.00 / 100 + T.Populated_EFX_SDB_pcnt *   0.00 / 100 + T.Populated_EFX_HUBZONE_pcnt *   0.00 / 100 + T.Populated_EFX_DBE_pcnt *   0.00 / 100 + T.Populated_EFX_VET_pcnt *   0.00 / 100 + T.Populated_EFX_DVET_pcnt *   0.00 / 100 + T.Populated_EFX_8a_pcnt *   0.00 / 100 + T.Populated_EFX_8aEXPDT_pcnt *   0.00 / 100 + T.Populated_EFX_DIS_pcnt *   0.00 / 100 + T.Populated_EFX_SBE_pcnt *   0.00 / 100 + T.Populated_EFX_BUSSIZE_pcnt *   0.00 / 100 + T.Populated_EFX_LBE_pcnt *   0.00 / 100 + T.Populated_EFX_GOV_pcnt *   0.00 / 100 + T.Populated_EFX_FGOV_pcnt *   0.00 / 100 + T.Populated_EFX_NONPROFIT_pcnt *   0.00 / 100 + T.Populated_EFX_HBCU_pcnt *   0.00 / 100 + T.Populated_EFX_GAYLESBIAN_pcnt *   0.00 / 100 + T.Populated_EFX_WSBE_pcnt *   0.00 / 100 + T.Populated_EFX_VSBE_pcnt *   0.00 / 100 + T.Populated_EFX_DVSBE_pcnt *   0.00 / 100 + T.Populated_EFX_MWBESTATUS_pcnt *   0.00 / 100 + T.Populated_EFX_NMSDC_pcnt *   0.00 / 100 + T.Populated_EFX_WBENC_pcnt *   0.00 / 100 + T.Populated_EFX_CA_PUC_pcnt *   0.00 / 100 + T.Populated_EFX_TX_HUB_pcnt *   0.00 / 100 + T.Populated_EFX_GSAX_pcnt *   0.00 / 100 + T.Populated_EFX_CALTRANS_pcnt *   0.00 / 100 + T.Populated_EFX_EDU_pcnt *   0.00 / 100 + T.Populated_EFX_MI_pcnt *   0.00 / 100 + T.Populated_EFX_ANC_pcnt *   0.00 / 100 + T.Populated_AT_CERT1_pcnt *   0.00 / 100 + T.Populated_AT_CERT2_pcnt *   0.00 / 100 + T.Populated_AT_CERT3_pcnt *   0.00 / 100 + T.Populated_AT_CERT4_pcnt *   0.00 / 100 + T.Populated_AT_CERT5_pcnt *   0.00 / 100 + T.Populated_AT_CERT6_pcnt *   0.00 / 100 + T.Populated_AT_CERT7_pcnt *   0.00 / 100 + T.Populated_AT_CERT8_pcnt *   0.00 / 100 + T.Populated_AT_CERT9_pcnt *   0.00 / 100 + T.Populated_AT_CERT10_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC1_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC2_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC3_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC4_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC5_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC6_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC7_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC8_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC9_pcnt *   0.00 / 100 + T.Populated_AT_CERTDESC10_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC1_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC2_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC3_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC4_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC5_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC6_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC7_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC8_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC9_pcnt *   0.00 / 100 + T.Populated_AT_CERTSRC10_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM1_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM2_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM3_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM4_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM5_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM6_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM7_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM8_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM9_pcnt *   0.00 / 100 + T.Populated_AT_CERTNUM10_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV1_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV2_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV3_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV4_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV5_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV6_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV7_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV8_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV9_pcnt *   0.00 / 100 + T.Populated_AT_CERTLEV10_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP1_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP2_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP3_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP4_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP5_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP6_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP7_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP8_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP9_pcnt *   0.00 / 100 + T.Populated_AT_CERTEXP10_pcnt *   0.00 / 100 + T.Populated_EFX_EXTRACT_DATE_pcnt *   0.00 / 100 + T.Populated_EFX_MERCHANT_ID_pcnt *   0.00 / 100 + T.Populated_EFX_PROJECT_ID_pcnt *   0.00 / 100 + T.Populated_EFX_FOREIGN_pcnt *   0.00 / 100 + T.Populated_Record_Update_Refresh_Date_pcnt *   0.00 / 100 + T.Populated_EFX_DATE_CREATED_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','normcompany_type','normaddress_type','clean_company_name','clean_phone','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','EFX_BUSSTATCD','EFX_CMSA','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTPREC','EFX_CORPAMOUNTTP','EFX_CORPEMPCD','EFX_WEB','EFX_CTRYISOCD','EFX_CTRYNUM','EFX_CTRYTELCD','EFX_GEOPREC','EFX_MERCTYPE','EFX_MRKT_TELESCORE','EFX_MRKT_TOTALIND','EFX_MRKT_TOTALSCORE','EFX_PUBLIC','EFX_STATEC','EFX_STKEXC','EFX_PRIMSIC','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_STATE','EFX_ID','EFX_NAME','EFX_LEGAL_NAME','EFX_ADDRESS','EFX_CITY','EFX_REGION','EFX_CTRYNAME','EFX_COUNTYNM','EFX_CMSADESC','EFX_SOHO','EFX_BIZ','EFX_RES','EFX_CMRA','EFX_SECADR','EFX_SECCTY','EFX_SECSTAT','EFX_STATEC2','EFX_SECGEOPREC','EFX_SECREGION','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_SECCTRYNAME','EFX_PHONE','EFX_FAXPHONE','EFX_BUSSTAT','EFX_YREST','EFX_CORPEMPCNT','EFX_LOCEMPCNT','EFX_LOCEMPCD','EFX_CORPAMOUNT','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_TCKSYM','EFX_PRIMSICDESC','EFX_SECSICDESC1','EFX_SECSICDESC2','EFX_SECSICDESC3','EFX_SECSICDESC4','EFX_PRIMNAICSCODE','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_PRIMNAICSDESC','EFX_SECNAICSDESC1','EFX_SECNAICSDESC2','EFX_SECNAICSDESC3','EFX_SECNAICSDESC4','EFX_DEAD','EFX_DEADDT','EFX_MRKT_TELEVER','EFX_MRKT_VACANT','EFX_MRKT_SEASONAL','EFX_MBE','EFX_WBE','EFX_MWBE','EFX_SDB','EFX_HUBZONE','EFX_DBE','EFX_VET','EFX_DVET','EFX_8a','EFX_8aEXPDT','EFX_DIS','EFX_SBE','EFX_BUSSIZE','EFX_LBE','EFX_GOV','EFX_FGOV','EFX_NONPROFIT','EFX_HBCU','EFX_GAYLESBIAN','EFX_WSBE','EFX_VSBE','EFX_DVSBE','EFX_MWBESTATUS','EFX_NMSDC','EFX_WBENC','EFX_CA_PUC','EFX_TX_HUB','EFX_GSAX','EFX_CALTRANS','EFX_EDU','EFX_MI','EFX_ANC','AT_CERT1','AT_CERT2','AT_CERT3','AT_CERT4','AT_CERT5','AT_CERT6','AT_CERT7','AT_CERT8','AT_CERT9','AT_CERT10','AT_CERTDESC1','AT_CERTDESC2','AT_CERTDESC3','AT_CERTDESC4','AT_CERTDESC5','AT_CERTDESC6','AT_CERTDESC7','AT_CERTDESC8','AT_CERTDESC9','AT_CERTDESC10','AT_CERTSRC1','AT_CERTSRC2','AT_CERTSRC3','AT_CERTSRC4','AT_CERTSRC5','AT_CERTSRC6','AT_CERTSRC7','AT_CERTSRC8','AT_CERTSRC9','AT_CERTSRC10','AT_CERTNUM1','AT_CERTNUM2','AT_CERTNUM3','AT_CERTNUM4','AT_CERTNUM5','AT_CERTNUM6','AT_CERTNUM7','AT_CERTNUM8','AT_CERTNUM9','AT_CERTNUM10','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','EFX_EXTRACT_DATE','EFX_MERCHANT_ID','EFX_PROJECT_ID','EFX_FOREIGN','Record_Update_Refresh_Date','EFX_DATE_CREATED');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_normcompany_type_pcnt,le.populated_normaddress_type_pcnt,le.populated_clean_company_name_pcnt,le.populated_clean_phone_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_EFX_BUSSTATCD_pcnt,le.populated_EFX_CMSA_pcnt,le.populated_EFX_CORPAMOUNTCD_pcnt,le.populated_EFX_CORPAMOUNTPREC_pcnt,le.populated_EFX_CORPAMOUNTTP_pcnt,le.populated_EFX_CORPEMPCD_pcnt,le.populated_EFX_WEB_pcnt,le.populated_EFX_CTRYISOCD_pcnt,le.populated_EFX_CTRYNUM_pcnt,le.populated_EFX_CTRYTELCD_pcnt,le.populated_EFX_GEOPREC_pcnt,le.populated_EFX_MERCTYPE_pcnt,le.populated_EFX_MRKT_TELESCORE_pcnt,le.populated_EFX_MRKT_TOTALIND_pcnt,le.populated_EFX_MRKT_TOTALSCORE_pcnt,le.populated_EFX_PUBLIC_pcnt,le.populated_EFX_STATEC_pcnt,le.populated_EFX_STKEXC_pcnt,le.populated_EFX_PRIMSIC_pcnt,le.populated_EFX_SECSIC1_pcnt,le.populated_EFX_SECSIC2_pcnt,le.populated_EFX_SECSIC3_pcnt,le.populated_EFX_SECSIC4_pcnt,le.populated_EFX_STATE_pcnt,le.populated_EFX_ID_pcnt,le.populated_EFX_NAME_pcnt,le.populated_EFX_LEGAL_NAME_pcnt,le.populated_EFX_ADDRESS_pcnt,le.populated_EFX_CITY_pcnt,le.populated_EFX_REGION_pcnt,le.populated_EFX_CTRYNAME_pcnt,le.populated_EFX_COUNTYNM_pcnt,le.populated_EFX_CMSADESC_pcnt,le.populated_EFX_SOHO_pcnt,le.populated_EFX_BIZ_pcnt,le.populated_EFX_RES_pcnt,le.populated_EFX_CMRA_pcnt,le.populated_EFX_SECADR_pcnt,le.populated_EFX_SECCTY_pcnt,le.populated_EFX_SECSTAT_pcnt,le.populated_EFX_STATEC2_pcnt,le.populated_EFX_SECGEOPREC_pcnt,le.populated_EFX_SECREGION_pcnt,le.populated_EFX_SECCTRYISOCD_pcnt,le.populated_EFX_SECCTRYNUM_pcnt,le.populated_EFX_SECCTRYNAME_pcnt,le.populated_EFX_PHONE_pcnt,le.populated_EFX_FAXPHONE_pcnt,le.populated_EFX_BUSSTAT_pcnt,le.populated_EFX_YREST_pcnt,le.populated_EFX_CORPEMPCNT_pcnt,le.populated_EFX_LOCEMPCNT_pcnt,le.populated_EFX_LOCEMPCD_pcnt,le.populated_EFX_CORPAMOUNT_pcnt,le.populated_EFX_LOCAMOUNT_pcnt,le.populated_EFX_LOCAMOUNTCD_pcnt,le.populated_EFX_LOCAMOUNTTP_pcnt,le.populated_EFX_LOCAMOUNTPREC_pcnt,le.populated_EFX_TCKSYM_pcnt,le.populated_EFX_PRIMSICDESC_pcnt,le.populated_EFX_SECSICDESC1_pcnt,le.populated_EFX_SECSICDESC2_pcnt,le.populated_EFX_SECSICDESC3_pcnt,le.populated_EFX_SECSICDESC4_pcnt,le.populated_EFX_PRIMNAICSCODE_pcnt,le.populated_EFX_SECNAICS1_pcnt,le.populated_EFX_SECNAICS2_pcnt,le.populated_EFX_SECNAICS3_pcnt,le.populated_EFX_SECNAICS4_pcnt,le.populated_EFX_PRIMNAICSDESC_pcnt,le.populated_EFX_SECNAICSDESC1_pcnt,le.populated_EFX_SECNAICSDESC2_pcnt,le.populated_EFX_SECNAICSDESC3_pcnt,le.populated_EFX_SECNAICSDESC4_pcnt,le.populated_EFX_DEAD_pcnt,le.populated_EFX_DEADDT_pcnt,le.populated_EFX_MRKT_TELEVER_pcnt,le.populated_EFX_MRKT_VACANT_pcnt,le.populated_EFX_MRKT_SEASONAL_pcnt,le.populated_EFX_MBE_pcnt,le.populated_EFX_WBE_pcnt,le.populated_EFX_MWBE_pcnt,le.populated_EFX_SDB_pcnt,le.populated_EFX_HUBZONE_pcnt,le.populated_EFX_DBE_pcnt,le.populated_EFX_VET_pcnt,le.populated_EFX_DVET_pcnt,le.populated_EFX_8a_pcnt,le.populated_EFX_8aEXPDT_pcnt,le.populated_EFX_DIS_pcnt,le.populated_EFX_SBE_pcnt,le.populated_EFX_BUSSIZE_pcnt,le.populated_EFX_LBE_pcnt,le.populated_EFX_GOV_pcnt,le.populated_EFX_FGOV_pcnt,le.populated_EFX_NONPROFIT_pcnt,le.populated_EFX_HBCU_pcnt,le.populated_EFX_GAYLESBIAN_pcnt,le.populated_EFX_WSBE_pcnt,le.populated_EFX_VSBE_pcnt,le.populated_EFX_DVSBE_pcnt,le.populated_EFX_MWBESTATUS_pcnt,le.populated_EFX_NMSDC_pcnt,le.populated_EFX_WBENC_pcnt,le.populated_EFX_CA_PUC_pcnt,le.populated_EFX_TX_HUB_pcnt,le.populated_EFX_GSAX_pcnt,le.populated_EFX_CALTRANS_pcnt,le.populated_EFX_EDU_pcnt,le.populated_EFX_MI_pcnt,le.populated_EFX_ANC_pcnt,le.populated_AT_CERT1_pcnt,le.populated_AT_CERT2_pcnt,le.populated_AT_CERT3_pcnt,le.populated_AT_CERT4_pcnt,le.populated_AT_CERT5_pcnt,le.populated_AT_CERT6_pcnt,le.populated_AT_CERT7_pcnt,le.populated_AT_CERT8_pcnt,le.populated_AT_CERT9_pcnt,le.populated_AT_CERT10_pcnt,le.populated_AT_CERTDESC1_pcnt,le.populated_AT_CERTDESC2_pcnt,le.populated_AT_CERTDESC3_pcnt,le.populated_AT_CERTDESC4_pcnt,le.populated_AT_CERTDESC5_pcnt,le.populated_AT_CERTDESC6_pcnt,le.populated_AT_CERTDESC7_pcnt,le.populated_AT_CERTDESC8_pcnt,le.populated_AT_CERTDESC9_pcnt,le.populated_AT_CERTDESC10_pcnt,le.populated_AT_CERTSRC1_pcnt,le.populated_AT_CERTSRC2_pcnt,le.populated_AT_CERTSRC3_pcnt,le.populated_AT_CERTSRC4_pcnt,le.populated_AT_CERTSRC5_pcnt,le.populated_AT_CERTSRC6_pcnt,le.populated_AT_CERTSRC7_pcnt,le.populated_AT_CERTSRC8_pcnt,le.populated_AT_CERTSRC9_pcnt,le.populated_AT_CERTSRC10_pcnt,le.populated_AT_CERTNUM1_pcnt,le.populated_AT_CERTNUM2_pcnt,le.populated_AT_CERTNUM3_pcnt,le.populated_AT_CERTNUM4_pcnt,le.populated_AT_CERTNUM5_pcnt,le.populated_AT_CERTNUM6_pcnt,le.populated_AT_CERTNUM7_pcnt,le.populated_AT_CERTNUM8_pcnt,le.populated_AT_CERTNUM9_pcnt,le.populated_AT_CERTNUM10_pcnt,le.populated_AT_CERTLEV1_pcnt,le.populated_AT_CERTLEV2_pcnt,le.populated_AT_CERTLEV3_pcnt,le.populated_AT_CERTLEV4_pcnt,le.populated_AT_CERTLEV5_pcnt,le.populated_AT_CERTLEV6_pcnt,le.populated_AT_CERTLEV7_pcnt,le.populated_AT_CERTLEV8_pcnt,le.populated_AT_CERTLEV9_pcnt,le.populated_AT_CERTLEV10_pcnt,le.populated_AT_CERTEXP1_pcnt,le.populated_AT_CERTEXP2_pcnt,le.populated_AT_CERTEXP3_pcnt,le.populated_AT_CERTEXP4_pcnt,le.populated_AT_CERTEXP5_pcnt,le.populated_AT_CERTEXP6_pcnt,le.populated_AT_CERTEXP7_pcnt,le.populated_AT_CERTEXP8_pcnt,le.populated_AT_CERTEXP9_pcnt,le.populated_AT_CERTEXP10_pcnt,le.populated_EFX_EXTRACT_DATE_pcnt,le.populated_EFX_MERCHANT_ID_pcnt,le.populated_EFX_PROJECT_ID_pcnt,le.populated_EFX_FOREIGN_pcnt,le.populated_Record_Update_Refresh_Date_pcnt,le.populated_EFX_DATE_CREATED_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_normcompany_type,le.maxlength_normaddress_type,le.maxlength_clean_company_name,le.maxlength_clean_phone,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_EFX_BUSSTATCD,le.maxlength_EFX_CMSA,le.maxlength_EFX_CORPAMOUNTCD,le.maxlength_EFX_CORPAMOUNTPREC,le.maxlength_EFX_CORPAMOUNTTP,le.maxlength_EFX_CORPEMPCD,le.maxlength_EFX_WEB,le.maxlength_EFX_CTRYISOCD,le.maxlength_EFX_CTRYNUM,le.maxlength_EFX_CTRYTELCD,le.maxlength_EFX_GEOPREC,le.maxlength_EFX_MERCTYPE,le.maxlength_EFX_MRKT_TELESCORE,le.maxlength_EFX_MRKT_TOTALIND,le.maxlength_EFX_MRKT_TOTALSCORE,le.maxlength_EFX_PUBLIC,le.maxlength_EFX_STATEC,le.maxlength_EFX_STKEXC,le.maxlength_EFX_PRIMSIC,le.maxlength_EFX_SECSIC1,le.maxlength_EFX_SECSIC2,le.maxlength_EFX_SECSIC3,le.maxlength_EFX_SECSIC4,le.maxlength_EFX_STATE,le.maxlength_EFX_ID,le.maxlength_EFX_NAME,le.maxlength_EFX_LEGAL_NAME,le.maxlength_EFX_ADDRESS,le.maxlength_EFX_CITY,le.maxlength_EFX_REGION,le.maxlength_EFX_CTRYNAME,le.maxlength_EFX_COUNTYNM,le.maxlength_EFX_CMSADESC,le.maxlength_EFX_SOHO,le.maxlength_EFX_BIZ,le.maxlength_EFX_RES,le.maxlength_EFX_CMRA,le.maxlength_EFX_SECADR,le.maxlength_EFX_SECCTY,le.maxlength_EFX_SECSTAT,le.maxlength_EFX_STATEC2,le.maxlength_EFX_SECGEOPREC,le.maxlength_EFX_SECREGION,le.maxlength_EFX_SECCTRYISOCD,le.maxlength_EFX_SECCTRYNUM,le.maxlength_EFX_SECCTRYNAME,le.maxlength_EFX_PHONE,le.maxlength_EFX_FAXPHONE,le.maxlength_EFX_BUSSTAT,le.maxlength_EFX_YREST,le.maxlength_EFX_CORPEMPCNT,le.maxlength_EFX_LOCEMPCNT,le.maxlength_EFX_LOCEMPCD,le.maxlength_EFX_CORPAMOUNT,le.maxlength_EFX_LOCAMOUNT,le.maxlength_EFX_LOCAMOUNTCD,le.maxlength_EFX_LOCAMOUNTTP,le.maxlength_EFX_LOCAMOUNTPREC,le.maxlength_EFX_TCKSYM,le.maxlength_EFX_PRIMSICDESC,le.maxlength_EFX_SECSICDESC1,le.maxlength_EFX_SECSICDESC2,le.maxlength_EFX_SECSICDESC3,le.maxlength_EFX_SECSICDESC4,le.maxlength_EFX_PRIMNAICSCODE,le.maxlength_EFX_SECNAICS1,le.maxlength_EFX_SECNAICS2,le.maxlength_EFX_SECNAICS3,le.maxlength_EFX_SECNAICS4,le.maxlength_EFX_PRIMNAICSDESC,le.maxlength_EFX_SECNAICSDESC1,le.maxlength_EFX_SECNAICSDESC2,le.maxlength_EFX_SECNAICSDESC3,le.maxlength_EFX_SECNAICSDESC4,le.maxlength_EFX_DEAD,le.maxlength_EFX_DEADDT,le.maxlength_EFX_MRKT_TELEVER,le.maxlength_EFX_MRKT_VACANT,le.maxlength_EFX_MRKT_SEASONAL,le.maxlength_EFX_MBE,le.maxlength_EFX_WBE,le.maxlength_EFX_MWBE,le.maxlength_EFX_SDB,le.maxlength_EFX_HUBZONE,le.maxlength_EFX_DBE,le.maxlength_EFX_VET,le.maxlength_EFX_DVET,le.maxlength_EFX_8a,le.maxlength_EFX_8aEXPDT,le.maxlength_EFX_DIS,le.maxlength_EFX_SBE,le.maxlength_EFX_BUSSIZE,le.maxlength_EFX_LBE,le.maxlength_EFX_GOV,le.maxlength_EFX_FGOV,le.maxlength_EFX_NONPROFIT,le.maxlength_EFX_HBCU,le.maxlength_EFX_GAYLESBIAN,le.maxlength_EFX_WSBE,le.maxlength_EFX_VSBE,le.maxlength_EFX_DVSBE,le.maxlength_EFX_MWBESTATUS,le.maxlength_EFX_NMSDC,le.maxlength_EFX_WBENC,le.maxlength_EFX_CA_PUC,le.maxlength_EFX_TX_HUB,le.maxlength_EFX_GSAX,le.maxlength_EFX_CALTRANS,le.maxlength_EFX_EDU,le.maxlength_EFX_MI,le.maxlength_EFX_ANC,le.maxlength_AT_CERT1,le.maxlength_AT_CERT2,le.maxlength_AT_CERT3,le.maxlength_AT_CERT4,le.maxlength_AT_CERT5,le.maxlength_AT_CERT6,le.maxlength_AT_CERT7,le.maxlength_AT_CERT8,le.maxlength_AT_CERT9,le.maxlength_AT_CERT10,le.maxlength_AT_CERTDESC1,le.maxlength_AT_CERTDESC2,le.maxlength_AT_CERTDESC3,le.maxlength_AT_CERTDESC4,le.maxlength_AT_CERTDESC5,le.maxlength_AT_CERTDESC6,le.maxlength_AT_CERTDESC7,le.maxlength_AT_CERTDESC8,le.maxlength_AT_CERTDESC9,le.maxlength_AT_CERTDESC10,le.maxlength_AT_CERTSRC1,le.maxlength_AT_CERTSRC2,le.maxlength_AT_CERTSRC3,le.maxlength_AT_CERTSRC4,le.maxlength_AT_CERTSRC5,le.maxlength_AT_CERTSRC6,le.maxlength_AT_CERTSRC7,le.maxlength_AT_CERTSRC8,le.maxlength_AT_CERTSRC9,le.maxlength_AT_CERTSRC10,le.maxlength_AT_CERTNUM1,le.maxlength_AT_CERTNUM2,le.maxlength_AT_CERTNUM3,le.maxlength_AT_CERTNUM4,le.maxlength_AT_CERTNUM5,le.maxlength_AT_CERTNUM6,le.maxlength_AT_CERTNUM7,le.maxlength_AT_CERTNUM8,le.maxlength_AT_CERTNUM9,le.maxlength_AT_CERTNUM10,le.maxlength_AT_CERTLEV1,le.maxlength_AT_CERTLEV2,le.maxlength_AT_CERTLEV3,le.maxlength_AT_CERTLEV4,le.maxlength_AT_CERTLEV5,le.maxlength_AT_CERTLEV6,le.maxlength_AT_CERTLEV7,le.maxlength_AT_CERTLEV8,le.maxlength_AT_CERTLEV9,le.maxlength_AT_CERTLEV10,le.maxlength_AT_CERTEXP1,le.maxlength_AT_CERTEXP2,le.maxlength_AT_CERTEXP3,le.maxlength_AT_CERTEXP4,le.maxlength_AT_CERTEXP5,le.maxlength_AT_CERTEXP6,le.maxlength_AT_CERTEXP7,le.maxlength_AT_CERTEXP8,le.maxlength_AT_CERTEXP9,le.maxlength_AT_CERTEXP10,le.maxlength_EFX_EXTRACT_DATE,le.maxlength_EFX_MERCHANT_ID,le.maxlength_EFX_PROJECT_ID,le.maxlength_EFX_FOREIGN,le.maxlength_Record_Update_Refresh_Date,le.maxlength_EFX_DATE_CREATED);
  SELF.avelength := CHOOSE(C,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_record_type,le.avelength_normcompany_type,le.avelength_normaddress_type,le.avelength_clean_company_name,le.avelength_clean_phone,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_EFX_BUSSTATCD,le.avelength_EFX_CMSA,le.avelength_EFX_CORPAMOUNTCD,le.avelength_EFX_CORPAMOUNTPREC,le.avelength_EFX_CORPAMOUNTTP,le.avelength_EFX_CORPEMPCD,le.avelength_EFX_WEB,le.avelength_EFX_CTRYISOCD,le.avelength_EFX_CTRYNUM,le.avelength_EFX_CTRYTELCD,le.avelength_EFX_GEOPREC,le.avelength_EFX_MERCTYPE,le.avelength_EFX_MRKT_TELESCORE,le.avelength_EFX_MRKT_TOTALIND,le.avelength_EFX_MRKT_TOTALSCORE,le.avelength_EFX_PUBLIC,le.avelength_EFX_STATEC,le.avelength_EFX_STKEXC,le.avelength_EFX_PRIMSIC,le.avelength_EFX_SECSIC1,le.avelength_EFX_SECSIC2,le.avelength_EFX_SECSIC3,le.avelength_EFX_SECSIC4,le.avelength_EFX_STATE,le.avelength_EFX_ID,le.avelength_EFX_NAME,le.avelength_EFX_LEGAL_NAME,le.avelength_EFX_ADDRESS,le.avelength_EFX_CITY,le.avelength_EFX_REGION,le.avelength_EFX_CTRYNAME,le.avelength_EFX_COUNTYNM,le.avelength_EFX_CMSADESC,le.avelength_EFX_SOHO,le.avelength_EFX_BIZ,le.avelength_EFX_RES,le.avelength_EFX_CMRA,le.avelength_EFX_SECADR,le.avelength_EFX_SECCTY,le.avelength_EFX_SECSTAT,le.avelength_EFX_STATEC2,le.avelength_EFX_SECGEOPREC,le.avelength_EFX_SECREGION,le.avelength_EFX_SECCTRYISOCD,le.avelength_EFX_SECCTRYNUM,le.avelength_EFX_SECCTRYNAME,le.avelength_EFX_PHONE,le.avelength_EFX_FAXPHONE,le.avelength_EFX_BUSSTAT,le.avelength_EFX_YREST,le.avelength_EFX_CORPEMPCNT,le.avelength_EFX_LOCEMPCNT,le.avelength_EFX_LOCEMPCD,le.avelength_EFX_CORPAMOUNT,le.avelength_EFX_LOCAMOUNT,le.avelength_EFX_LOCAMOUNTCD,le.avelength_EFX_LOCAMOUNTTP,le.avelength_EFX_LOCAMOUNTPREC,le.avelength_EFX_TCKSYM,le.avelength_EFX_PRIMSICDESC,le.avelength_EFX_SECSICDESC1,le.avelength_EFX_SECSICDESC2,le.avelength_EFX_SECSICDESC3,le.avelength_EFX_SECSICDESC4,le.avelength_EFX_PRIMNAICSCODE,le.avelength_EFX_SECNAICS1,le.avelength_EFX_SECNAICS2,le.avelength_EFX_SECNAICS3,le.avelength_EFX_SECNAICS4,le.avelength_EFX_PRIMNAICSDESC,le.avelength_EFX_SECNAICSDESC1,le.avelength_EFX_SECNAICSDESC2,le.avelength_EFX_SECNAICSDESC3,le.avelength_EFX_SECNAICSDESC4,le.avelength_EFX_DEAD,le.avelength_EFX_DEADDT,le.avelength_EFX_MRKT_TELEVER,le.avelength_EFX_MRKT_VACANT,le.avelength_EFX_MRKT_SEASONAL,le.avelength_EFX_MBE,le.avelength_EFX_WBE,le.avelength_EFX_MWBE,le.avelength_EFX_SDB,le.avelength_EFX_HUBZONE,le.avelength_EFX_DBE,le.avelength_EFX_VET,le.avelength_EFX_DVET,le.avelength_EFX_8a,le.avelength_EFX_8aEXPDT,le.avelength_EFX_DIS,le.avelength_EFX_SBE,le.avelength_EFX_BUSSIZE,le.avelength_EFX_LBE,le.avelength_EFX_GOV,le.avelength_EFX_FGOV,le.avelength_EFX_NONPROFIT,le.avelength_EFX_HBCU,le.avelength_EFX_GAYLESBIAN,le.avelength_EFX_WSBE,le.avelength_EFX_VSBE,le.avelength_EFX_DVSBE,le.avelength_EFX_MWBESTATUS,le.avelength_EFX_NMSDC,le.avelength_EFX_WBENC,le.avelength_EFX_CA_PUC,le.avelength_EFX_TX_HUB,le.avelength_EFX_GSAX,le.avelength_EFX_CALTRANS,le.avelength_EFX_EDU,le.avelength_EFX_MI,le.avelength_EFX_ANC,le.avelength_AT_CERT1,le.avelength_AT_CERT2,le.avelength_AT_CERT3,le.avelength_AT_CERT4,le.avelength_AT_CERT5,le.avelength_AT_CERT6,le.avelength_AT_CERT7,le.avelength_AT_CERT8,le.avelength_AT_CERT9,le.avelength_AT_CERT10,le.avelength_AT_CERTDESC1,le.avelength_AT_CERTDESC2,le.avelength_AT_CERTDESC3,le.avelength_AT_CERTDESC4,le.avelength_AT_CERTDESC5,le.avelength_AT_CERTDESC6,le.avelength_AT_CERTDESC7,le.avelength_AT_CERTDESC8,le.avelength_AT_CERTDESC9,le.avelength_AT_CERTDESC10,le.avelength_AT_CERTSRC1,le.avelength_AT_CERTSRC2,le.avelength_AT_CERTSRC3,le.avelength_AT_CERTSRC4,le.avelength_AT_CERTSRC5,le.avelength_AT_CERTSRC6,le.avelength_AT_CERTSRC7,le.avelength_AT_CERTSRC8,le.avelength_AT_CERTSRC9,le.avelength_AT_CERTSRC10,le.avelength_AT_CERTNUM1,le.avelength_AT_CERTNUM2,le.avelength_AT_CERTNUM3,le.avelength_AT_CERTNUM4,le.avelength_AT_CERTNUM5,le.avelength_AT_CERTNUM6,le.avelength_AT_CERTNUM7,le.avelength_AT_CERTNUM8,le.avelength_AT_CERTNUM9,le.avelength_AT_CERTNUM10,le.avelength_AT_CERTLEV1,le.avelength_AT_CERTLEV2,le.avelength_AT_CERTLEV3,le.avelength_AT_CERTLEV4,le.avelength_AT_CERTLEV5,le.avelength_AT_CERTLEV6,le.avelength_AT_CERTLEV7,le.avelength_AT_CERTLEV8,le.avelength_AT_CERTLEV9,le.avelength_AT_CERTLEV10,le.avelength_AT_CERTEXP1,le.avelength_AT_CERTEXP2,le.avelength_AT_CERTEXP3,le.avelength_AT_CERTEXP4,le.avelength_AT_CERTEXP5,le.avelength_AT_CERTEXP6,le.avelength_AT_CERTEXP7,le.avelength_AT_CERTEXP8,le.avelength_AT_CERTEXP9,le.avelength_AT_CERTEXP10,le.avelength_EFX_EXTRACT_DATE,le.avelength_EFX_MERCHANT_ID,le.avelength_EFX_PROJECT_ID,le.avelength_EFX_FOREIGN,le.avelength_Record_Update_Refresh_Date,le.avelength_EFX_DATE_CREATED);
END;
EXPORT invSummary := NORMALIZE(summary0, 239, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dotid <> 0,TRIM((SALT37.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT37.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT37.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT37.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT37.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT37.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT37.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT37.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT37.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT37.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT37.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT37.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT37.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT37.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT37.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT37.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT37.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT37.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT37.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT37.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT37.StrType)le.ultweight), ''),TRIM((SALT37.StrType)le.dt_first_seen),TRIM((SALT37.StrType)le.dt_last_seen),TRIM((SALT37.StrType)le.dt_vendor_first_reported),TRIM((SALT37.StrType)le.dt_vendor_last_reported),TRIM((SALT37.StrType)le.process_date),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.normcompany_type),TRIM((SALT37.StrType)le.normaddress_type),TRIM((SALT37.StrType)le.clean_company_name),TRIM((SALT37.StrType)le.clean_phone),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz),TRIM((SALT37.StrType)le.lot),TRIM((SALT37.StrType)le.lot_order),TRIM((SALT37.StrType)le.dbpc),TRIM((SALT37.StrType)le.chk_digit),TRIM((SALT37.StrType)le.rec_type),TRIM((SALT37.StrType)le.fips_state),TRIM((SALT37.StrType)le.fips_county),TRIM((SALT37.StrType)le.geo_lat),TRIM((SALT37.StrType)le.geo_long),TRIM((SALT37.StrType)le.msa),TRIM((SALT37.StrType)le.geo_blk),TRIM((SALT37.StrType)le.geo_match),TRIM((SALT37.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT37.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT37.StrType)le.ace_aid), ''),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.EFX_BUSSTATCD),TRIM((SALT37.StrType)le.EFX_CMSA),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTTP),TRIM((SALT37.StrType)le.EFX_CORPEMPCD),TRIM((SALT37.StrType)le.EFX_WEB),TRIM((SALT37.StrType)le.EFX_CTRYISOCD),TRIM((SALT37.StrType)le.EFX_CTRYNUM),TRIM((SALT37.StrType)le.EFX_CTRYTELCD),TRIM((SALT37.StrType)le.EFX_GEOPREC),TRIM((SALT37.StrType)le.EFX_MERCTYPE),TRIM((SALT37.StrType)le.EFX_MRKT_TELESCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALIND),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),TRIM((SALT37.StrType)le.EFX_PUBLIC),TRIM((SALT37.StrType)le.EFX_STATEC),TRIM((SALT37.StrType)le.EFX_STKEXC),TRIM((SALT37.StrType)le.EFX_PRIMSIC),TRIM((SALT37.StrType)le.EFX_SECSIC1),TRIM((SALT37.StrType)le.EFX_SECSIC2),TRIM((SALT37.StrType)le.EFX_SECSIC3),TRIM((SALT37.StrType)le.EFX_SECSIC4),TRIM((SALT37.StrType)le.EFX_STATE),TRIM((SALT37.StrType)le.EFX_ID),TRIM((SALT37.StrType)le.EFX_NAME),TRIM((SALT37.StrType)le.EFX_LEGAL_NAME),TRIM((SALT37.StrType)le.EFX_ADDRESS),TRIM((SALT37.StrType)le.EFX_CITY),TRIM((SALT37.StrType)le.EFX_REGION),TRIM((SALT37.StrType)le.EFX_CTRYNAME),TRIM((SALT37.StrType)le.EFX_COUNTYNM),TRIM((SALT37.StrType)le.EFX_CMSADESC),TRIM((SALT37.StrType)le.EFX_SOHO),TRIM((SALT37.StrType)le.EFX_BIZ),TRIM((SALT37.StrType)le.EFX_RES),TRIM((SALT37.StrType)le.EFX_CMRA),TRIM((SALT37.StrType)le.EFX_SECADR),TRIM((SALT37.StrType)le.EFX_SECCTY),TRIM((SALT37.StrType)le.EFX_SECSTAT),TRIM((SALT37.StrType)le.EFX_STATEC2),TRIM((SALT37.StrType)le.EFX_SECGEOPREC),TRIM((SALT37.StrType)le.EFX_SECREGION),TRIM((SALT37.StrType)le.EFX_SECCTRYISOCD),TRIM((SALT37.StrType)le.EFX_SECCTRYNUM),TRIM((SALT37.StrType)le.EFX_SECCTRYNAME),TRIM((SALT37.StrType)le.EFX_PHONE),TRIM((SALT37.StrType)le.EFX_FAXPHONE),TRIM((SALT37.StrType)le.EFX_BUSSTAT),TRIM((SALT37.StrType)le.EFX_YREST),TRIM((SALT37.StrType)le.EFX_CORPEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTCD),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTTP),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_TCKSYM),TRIM((SALT37.StrType)le.EFX_PRIMSICDESC),TRIM((SALT37.StrType)le.EFX_SECSICDESC1),TRIM((SALT37.StrType)le.EFX_SECSICDESC2),TRIM((SALT37.StrType)le.EFX_SECSICDESC3),TRIM((SALT37.StrType)le.EFX_SECSICDESC4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSCODE),TRIM((SALT37.StrType)le.EFX_SECNAICS1),TRIM((SALT37.StrType)le.EFX_SECNAICS2),TRIM((SALT37.StrType)le.EFX_SECNAICS3),TRIM((SALT37.StrType)le.EFX_SECNAICS4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSDESC),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC1),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC2),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC3),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC4),TRIM((SALT37.StrType)le.EFX_DEAD),TRIM((SALT37.StrType)le.EFX_DEADDT),TRIM((SALT37.StrType)le.EFX_MRKT_TELEVER),TRIM((SALT37.StrType)le.EFX_MRKT_VACANT),TRIM((SALT37.StrType)le.EFX_MRKT_SEASONAL),TRIM((SALT37.StrType)le.EFX_MBE),TRIM((SALT37.StrType)le.EFX_WBE),TRIM((SALT37.StrType)le.EFX_MWBE),TRIM((SALT37.StrType)le.EFX_SDB),TRIM((SALT37.StrType)le.EFX_HUBZONE),TRIM((SALT37.StrType)le.EFX_DBE),TRIM((SALT37.StrType)le.EFX_VET),TRIM((SALT37.StrType)le.EFX_DVET),TRIM((SALT37.StrType)le.EFX_8a),TRIM((SALT37.StrType)le.EFX_8aEXPDT),TRIM((SALT37.StrType)le.EFX_DIS),TRIM((SALT37.StrType)le.EFX_SBE),TRIM((SALT37.StrType)le.EFX_BUSSIZE),TRIM((SALT37.StrType)le.EFX_LBE),TRIM((SALT37.StrType)le.EFX_GOV),TRIM((SALT37.StrType)le.EFX_FGOV),TRIM((SALT37.StrType)le.EFX_NONPROFIT),TRIM((SALT37.StrType)le.EFX_HBCU),TRIM((SALT37.StrType)le.EFX_GAYLESBIAN),TRIM((SALT37.StrType)le.EFX_WSBE),TRIM((SALT37.StrType)le.EFX_VSBE),TRIM((SALT37.StrType)le.EFX_DVSBE),TRIM((SALT37.StrType)le.EFX_MWBESTATUS),TRIM((SALT37.StrType)le.EFX_NMSDC),TRIM((SALT37.StrType)le.EFX_WBENC),TRIM((SALT37.StrType)le.EFX_CA_PUC),TRIM((SALT37.StrType)le.EFX_TX_HUB),TRIM((SALT37.StrType)le.EFX_GSAX),TRIM((SALT37.StrType)le.EFX_CALTRANS),TRIM((SALT37.StrType)le.EFX_EDU),TRIM((SALT37.StrType)le.EFX_MI),TRIM((SALT37.StrType)le.EFX_ANC),TRIM((SALT37.StrType)le.AT_CERT1),TRIM((SALT37.StrType)le.AT_CERT2),TRIM((SALT37.StrType)le.AT_CERT3),TRIM((SALT37.StrType)le.AT_CERT4),TRIM((SALT37.StrType)le.AT_CERT5),TRIM((SALT37.StrType)le.AT_CERT6),TRIM((SALT37.StrType)le.AT_CERT7),TRIM((SALT37.StrType)le.AT_CERT8),TRIM((SALT37.StrType)le.AT_CERT9),TRIM((SALT37.StrType)le.AT_CERT10),TRIM((SALT37.StrType)le.AT_CERTDESC1),TRIM((SALT37.StrType)le.AT_CERTDESC2),TRIM((SALT37.StrType)le.AT_CERTDESC3),TRIM((SALT37.StrType)le.AT_CERTDESC4),TRIM((SALT37.StrType)le.AT_CERTDESC5),TRIM((SALT37.StrType)le.AT_CERTDESC6),TRIM((SALT37.StrType)le.AT_CERTDESC7),TRIM((SALT37.StrType)le.AT_CERTDESC8),TRIM((SALT37.StrType)le.AT_CERTDESC9),TRIM((SALT37.StrType)le.AT_CERTDESC10),TRIM((SALT37.StrType)le.AT_CERTSRC1),TRIM((SALT37.StrType)le.AT_CERTSRC2),TRIM((SALT37.StrType)le.AT_CERTSRC3),TRIM((SALT37.StrType)le.AT_CERTSRC4),TRIM((SALT37.StrType)le.AT_CERTSRC5),TRIM((SALT37.StrType)le.AT_CERTSRC6),TRIM((SALT37.StrType)le.AT_CERTSRC7),TRIM((SALT37.StrType)le.AT_CERTSRC8),TRIM((SALT37.StrType)le.AT_CERTSRC9),TRIM((SALT37.StrType)le.AT_CERTSRC10),TRIM((SALT37.StrType)le.AT_CERTNUM1),TRIM((SALT37.StrType)le.AT_CERTNUM2),TRIM((SALT37.StrType)le.AT_CERTNUM3),TRIM((SALT37.StrType)le.AT_CERTNUM4),TRIM((SALT37.StrType)le.AT_CERTNUM5),TRIM((SALT37.StrType)le.AT_CERTNUM6),TRIM((SALT37.StrType)le.AT_CERTNUM7),TRIM((SALT37.StrType)le.AT_CERTNUM8),TRIM((SALT37.StrType)le.AT_CERTNUM9),TRIM((SALT37.StrType)le.AT_CERTNUM10),TRIM((SALT37.StrType)le.AT_CERTLEV1),TRIM((SALT37.StrType)le.AT_CERTLEV2),TRIM((SALT37.StrType)le.AT_CERTLEV3),TRIM((SALT37.StrType)le.AT_CERTLEV4),TRIM((SALT37.StrType)le.AT_CERTLEV5),TRIM((SALT37.StrType)le.AT_CERTLEV6),TRIM((SALT37.StrType)le.AT_CERTLEV7),TRIM((SALT37.StrType)le.AT_CERTLEV8),TRIM((SALT37.StrType)le.AT_CERTLEV9),TRIM((SALT37.StrType)le.AT_CERTLEV10),TRIM((SALT37.StrType)le.AT_CERTEXP1),TRIM((SALT37.StrType)le.AT_CERTEXP2),TRIM((SALT37.StrType)le.AT_CERTEXP3),TRIM((SALT37.StrType)le.AT_CERTEXP4),TRIM((SALT37.StrType)le.AT_CERTEXP5),TRIM((SALT37.StrType)le.AT_CERTEXP6),TRIM((SALT37.StrType)le.AT_CERTEXP7),TRIM((SALT37.StrType)le.AT_CERTEXP8),TRIM((SALT37.StrType)le.AT_CERTEXP9),TRIM((SALT37.StrType)le.AT_CERTEXP10),TRIM((SALT37.StrType)le.EFX_EXTRACT_DATE),TRIM((SALT37.StrType)le.EFX_MERCHANT_ID),TRIM((SALT37.StrType)le.EFX_PROJECT_ID),TRIM((SALT37.StrType)le.EFX_FOREIGN),TRIM((SALT37.StrType)le.Record_Update_Refresh_Date),TRIM((SALT37.StrType)le.EFX_DATE_CREATED)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,239,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 239);
  SELF.FldNo2 := 1 + (C % 239);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dotid <> 0,TRIM((SALT37.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT37.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT37.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT37.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT37.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT37.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT37.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT37.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT37.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT37.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT37.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT37.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT37.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT37.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT37.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT37.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT37.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT37.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT37.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT37.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT37.StrType)le.ultweight), ''),TRIM((SALT37.StrType)le.dt_first_seen),TRIM((SALT37.StrType)le.dt_last_seen),TRIM((SALT37.StrType)le.dt_vendor_first_reported),TRIM((SALT37.StrType)le.dt_vendor_last_reported),TRIM((SALT37.StrType)le.process_date),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.normcompany_type),TRIM((SALT37.StrType)le.normaddress_type),TRIM((SALT37.StrType)le.clean_company_name),TRIM((SALT37.StrType)le.clean_phone),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz),TRIM((SALT37.StrType)le.lot),TRIM((SALT37.StrType)le.lot_order),TRIM((SALT37.StrType)le.dbpc),TRIM((SALT37.StrType)le.chk_digit),TRIM((SALT37.StrType)le.rec_type),TRIM((SALT37.StrType)le.fips_state),TRIM((SALT37.StrType)le.fips_county),TRIM((SALT37.StrType)le.geo_lat),TRIM((SALT37.StrType)le.geo_long),TRIM((SALT37.StrType)le.msa),TRIM((SALT37.StrType)le.geo_blk),TRIM((SALT37.StrType)le.geo_match),TRIM((SALT37.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT37.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT37.StrType)le.ace_aid), ''),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.EFX_BUSSTATCD),TRIM((SALT37.StrType)le.EFX_CMSA),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTTP),TRIM((SALT37.StrType)le.EFX_CORPEMPCD),TRIM((SALT37.StrType)le.EFX_WEB),TRIM((SALT37.StrType)le.EFX_CTRYISOCD),TRIM((SALT37.StrType)le.EFX_CTRYNUM),TRIM((SALT37.StrType)le.EFX_CTRYTELCD),TRIM((SALT37.StrType)le.EFX_GEOPREC),TRIM((SALT37.StrType)le.EFX_MERCTYPE),TRIM((SALT37.StrType)le.EFX_MRKT_TELESCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALIND),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),TRIM((SALT37.StrType)le.EFX_PUBLIC),TRIM((SALT37.StrType)le.EFX_STATEC),TRIM((SALT37.StrType)le.EFX_STKEXC),TRIM((SALT37.StrType)le.EFX_PRIMSIC),TRIM((SALT37.StrType)le.EFX_SECSIC1),TRIM((SALT37.StrType)le.EFX_SECSIC2),TRIM((SALT37.StrType)le.EFX_SECSIC3),TRIM((SALT37.StrType)le.EFX_SECSIC4),TRIM((SALT37.StrType)le.EFX_STATE),TRIM((SALT37.StrType)le.EFX_ID),TRIM((SALT37.StrType)le.EFX_NAME),TRIM((SALT37.StrType)le.EFX_LEGAL_NAME),TRIM((SALT37.StrType)le.EFX_ADDRESS),TRIM((SALT37.StrType)le.EFX_CITY),TRIM((SALT37.StrType)le.EFX_REGION),TRIM((SALT37.StrType)le.EFX_CTRYNAME),TRIM((SALT37.StrType)le.EFX_COUNTYNM),TRIM((SALT37.StrType)le.EFX_CMSADESC),TRIM((SALT37.StrType)le.EFX_SOHO),TRIM((SALT37.StrType)le.EFX_BIZ),TRIM((SALT37.StrType)le.EFX_RES),TRIM((SALT37.StrType)le.EFX_CMRA),TRIM((SALT37.StrType)le.EFX_SECADR),TRIM((SALT37.StrType)le.EFX_SECCTY),TRIM((SALT37.StrType)le.EFX_SECSTAT),TRIM((SALT37.StrType)le.EFX_STATEC2),TRIM((SALT37.StrType)le.EFX_SECGEOPREC),TRIM((SALT37.StrType)le.EFX_SECREGION),TRIM((SALT37.StrType)le.EFX_SECCTRYISOCD),TRIM((SALT37.StrType)le.EFX_SECCTRYNUM),TRIM((SALT37.StrType)le.EFX_SECCTRYNAME),TRIM((SALT37.StrType)le.EFX_PHONE),TRIM((SALT37.StrType)le.EFX_FAXPHONE),TRIM((SALT37.StrType)le.EFX_BUSSTAT),TRIM((SALT37.StrType)le.EFX_YREST),TRIM((SALT37.StrType)le.EFX_CORPEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTCD),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTTP),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_TCKSYM),TRIM((SALT37.StrType)le.EFX_PRIMSICDESC),TRIM((SALT37.StrType)le.EFX_SECSICDESC1),TRIM((SALT37.StrType)le.EFX_SECSICDESC2),TRIM((SALT37.StrType)le.EFX_SECSICDESC3),TRIM((SALT37.StrType)le.EFX_SECSICDESC4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSCODE),TRIM((SALT37.StrType)le.EFX_SECNAICS1),TRIM((SALT37.StrType)le.EFX_SECNAICS2),TRIM((SALT37.StrType)le.EFX_SECNAICS3),TRIM((SALT37.StrType)le.EFX_SECNAICS4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSDESC),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC1),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC2),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC3),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC4),TRIM((SALT37.StrType)le.EFX_DEAD),TRIM((SALT37.StrType)le.EFX_DEADDT),TRIM((SALT37.StrType)le.EFX_MRKT_TELEVER),TRIM((SALT37.StrType)le.EFX_MRKT_VACANT),TRIM((SALT37.StrType)le.EFX_MRKT_SEASONAL),TRIM((SALT37.StrType)le.EFX_MBE),TRIM((SALT37.StrType)le.EFX_WBE),TRIM((SALT37.StrType)le.EFX_MWBE),TRIM((SALT37.StrType)le.EFX_SDB),TRIM((SALT37.StrType)le.EFX_HUBZONE),TRIM((SALT37.StrType)le.EFX_DBE),TRIM((SALT37.StrType)le.EFX_VET),TRIM((SALT37.StrType)le.EFX_DVET),TRIM((SALT37.StrType)le.EFX_8a),TRIM((SALT37.StrType)le.EFX_8aEXPDT),TRIM((SALT37.StrType)le.EFX_DIS),TRIM((SALT37.StrType)le.EFX_SBE),TRIM((SALT37.StrType)le.EFX_BUSSIZE),TRIM((SALT37.StrType)le.EFX_LBE),TRIM((SALT37.StrType)le.EFX_GOV),TRIM((SALT37.StrType)le.EFX_FGOV),TRIM((SALT37.StrType)le.EFX_NONPROFIT),TRIM((SALT37.StrType)le.EFX_HBCU),TRIM((SALT37.StrType)le.EFX_GAYLESBIAN),TRIM((SALT37.StrType)le.EFX_WSBE),TRIM((SALT37.StrType)le.EFX_VSBE),TRIM((SALT37.StrType)le.EFX_DVSBE),TRIM((SALT37.StrType)le.EFX_MWBESTATUS),TRIM((SALT37.StrType)le.EFX_NMSDC),TRIM((SALT37.StrType)le.EFX_WBENC),TRIM((SALT37.StrType)le.EFX_CA_PUC),TRIM((SALT37.StrType)le.EFX_TX_HUB),TRIM((SALT37.StrType)le.EFX_GSAX),TRIM((SALT37.StrType)le.EFX_CALTRANS),TRIM((SALT37.StrType)le.EFX_EDU),TRIM((SALT37.StrType)le.EFX_MI),TRIM((SALT37.StrType)le.EFX_ANC),TRIM((SALT37.StrType)le.AT_CERT1),TRIM((SALT37.StrType)le.AT_CERT2),TRIM((SALT37.StrType)le.AT_CERT3),TRIM((SALT37.StrType)le.AT_CERT4),TRIM((SALT37.StrType)le.AT_CERT5),TRIM((SALT37.StrType)le.AT_CERT6),TRIM((SALT37.StrType)le.AT_CERT7),TRIM((SALT37.StrType)le.AT_CERT8),TRIM((SALT37.StrType)le.AT_CERT9),TRIM((SALT37.StrType)le.AT_CERT10),TRIM((SALT37.StrType)le.AT_CERTDESC1),TRIM((SALT37.StrType)le.AT_CERTDESC2),TRIM((SALT37.StrType)le.AT_CERTDESC3),TRIM((SALT37.StrType)le.AT_CERTDESC4),TRIM((SALT37.StrType)le.AT_CERTDESC5),TRIM((SALT37.StrType)le.AT_CERTDESC6),TRIM((SALT37.StrType)le.AT_CERTDESC7),TRIM((SALT37.StrType)le.AT_CERTDESC8),TRIM((SALT37.StrType)le.AT_CERTDESC9),TRIM((SALT37.StrType)le.AT_CERTDESC10),TRIM((SALT37.StrType)le.AT_CERTSRC1),TRIM((SALT37.StrType)le.AT_CERTSRC2),TRIM((SALT37.StrType)le.AT_CERTSRC3),TRIM((SALT37.StrType)le.AT_CERTSRC4),TRIM((SALT37.StrType)le.AT_CERTSRC5),TRIM((SALT37.StrType)le.AT_CERTSRC6),TRIM((SALT37.StrType)le.AT_CERTSRC7),TRIM((SALT37.StrType)le.AT_CERTSRC8),TRIM((SALT37.StrType)le.AT_CERTSRC9),TRIM((SALT37.StrType)le.AT_CERTSRC10),TRIM((SALT37.StrType)le.AT_CERTNUM1),TRIM((SALT37.StrType)le.AT_CERTNUM2),TRIM((SALT37.StrType)le.AT_CERTNUM3),TRIM((SALT37.StrType)le.AT_CERTNUM4),TRIM((SALT37.StrType)le.AT_CERTNUM5),TRIM((SALT37.StrType)le.AT_CERTNUM6),TRIM((SALT37.StrType)le.AT_CERTNUM7),TRIM((SALT37.StrType)le.AT_CERTNUM8),TRIM((SALT37.StrType)le.AT_CERTNUM9),TRIM((SALT37.StrType)le.AT_CERTNUM10),TRIM((SALT37.StrType)le.AT_CERTLEV1),TRIM((SALT37.StrType)le.AT_CERTLEV2),TRIM((SALT37.StrType)le.AT_CERTLEV3),TRIM((SALT37.StrType)le.AT_CERTLEV4),TRIM((SALT37.StrType)le.AT_CERTLEV5),TRIM((SALT37.StrType)le.AT_CERTLEV6),TRIM((SALT37.StrType)le.AT_CERTLEV7),TRIM((SALT37.StrType)le.AT_CERTLEV8),TRIM((SALT37.StrType)le.AT_CERTLEV9),TRIM((SALT37.StrType)le.AT_CERTLEV10),TRIM((SALT37.StrType)le.AT_CERTEXP1),TRIM((SALT37.StrType)le.AT_CERTEXP2),TRIM((SALT37.StrType)le.AT_CERTEXP3),TRIM((SALT37.StrType)le.AT_CERTEXP4),TRIM((SALT37.StrType)le.AT_CERTEXP5),TRIM((SALT37.StrType)le.AT_CERTEXP6),TRIM((SALT37.StrType)le.AT_CERTEXP7),TRIM((SALT37.StrType)le.AT_CERTEXP8),TRIM((SALT37.StrType)le.AT_CERTEXP9),TRIM((SALT37.StrType)le.AT_CERTEXP10),TRIM((SALT37.StrType)le.EFX_EXTRACT_DATE),TRIM((SALT37.StrType)le.EFX_MERCHANT_ID),TRIM((SALT37.StrType)le.EFX_PROJECT_ID),TRIM((SALT37.StrType)le.EFX_FOREIGN),TRIM((SALT37.StrType)le.Record_Update_Refresh_Date),TRIM((SALT37.StrType)le.EFX_DATE_CREATED)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dotid <> 0,TRIM((SALT37.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT37.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT37.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT37.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT37.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT37.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT37.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT37.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT37.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT37.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT37.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT37.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT37.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT37.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT37.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT37.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT37.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT37.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT37.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT37.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT37.StrType)le.ultweight), ''),TRIM((SALT37.StrType)le.dt_first_seen),TRIM((SALT37.StrType)le.dt_last_seen),TRIM((SALT37.StrType)le.dt_vendor_first_reported),TRIM((SALT37.StrType)le.dt_vendor_last_reported),TRIM((SALT37.StrType)le.process_date),TRIM((SALT37.StrType)le.record_type),TRIM((SALT37.StrType)le.normcompany_type),TRIM((SALT37.StrType)le.normaddress_type),TRIM((SALT37.StrType)le.clean_company_name),TRIM((SALT37.StrType)le.clean_phone),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_desig),TRIM((SALT37.StrType)le.sec_range),TRIM((SALT37.StrType)le.p_city_name),TRIM((SALT37.StrType)le.v_city_name),TRIM((SALT37.StrType)le.st),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.cr_sort_sz),TRIM((SALT37.StrType)le.lot),TRIM((SALT37.StrType)le.lot_order),TRIM((SALT37.StrType)le.dbpc),TRIM((SALT37.StrType)le.chk_digit),TRIM((SALT37.StrType)le.rec_type),TRIM((SALT37.StrType)le.fips_state),TRIM((SALT37.StrType)le.fips_county),TRIM((SALT37.StrType)le.geo_lat),TRIM((SALT37.StrType)le.geo_long),TRIM((SALT37.StrType)le.msa),TRIM((SALT37.StrType)le.geo_blk),TRIM((SALT37.StrType)le.geo_match),TRIM((SALT37.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT37.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT37.StrType)le.ace_aid), ''),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.EFX_BUSSTATCD),TRIM((SALT37.StrType)le.EFX_CMSA),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_CORPAMOUNTTP),TRIM((SALT37.StrType)le.EFX_CORPEMPCD),TRIM((SALT37.StrType)le.EFX_WEB),TRIM((SALT37.StrType)le.EFX_CTRYISOCD),TRIM((SALT37.StrType)le.EFX_CTRYNUM),TRIM((SALT37.StrType)le.EFX_CTRYTELCD),TRIM((SALT37.StrType)le.EFX_GEOPREC),TRIM((SALT37.StrType)le.EFX_MERCTYPE),TRIM((SALT37.StrType)le.EFX_MRKT_TELESCORE),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALIND),TRIM((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),TRIM((SALT37.StrType)le.EFX_PUBLIC),TRIM((SALT37.StrType)le.EFX_STATEC),TRIM((SALT37.StrType)le.EFX_STKEXC),TRIM((SALT37.StrType)le.EFX_PRIMSIC),TRIM((SALT37.StrType)le.EFX_SECSIC1),TRIM((SALT37.StrType)le.EFX_SECSIC2),TRIM((SALT37.StrType)le.EFX_SECSIC3),TRIM((SALT37.StrType)le.EFX_SECSIC4),TRIM((SALT37.StrType)le.EFX_STATE),TRIM((SALT37.StrType)le.EFX_ID),TRIM((SALT37.StrType)le.EFX_NAME),TRIM((SALT37.StrType)le.EFX_LEGAL_NAME),TRIM((SALT37.StrType)le.EFX_ADDRESS),TRIM((SALT37.StrType)le.EFX_CITY),TRIM((SALT37.StrType)le.EFX_REGION),TRIM((SALT37.StrType)le.EFX_CTRYNAME),TRIM((SALT37.StrType)le.EFX_COUNTYNM),TRIM((SALT37.StrType)le.EFX_CMSADESC),TRIM((SALT37.StrType)le.EFX_SOHO),TRIM((SALT37.StrType)le.EFX_BIZ),TRIM((SALT37.StrType)le.EFX_RES),TRIM((SALT37.StrType)le.EFX_CMRA),TRIM((SALT37.StrType)le.EFX_SECADR),TRIM((SALT37.StrType)le.EFX_SECCTY),TRIM((SALT37.StrType)le.EFX_SECSTAT),TRIM((SALT37.StrType)le.EFX_STATEC2),TRIM((SALT37.StrType)le.EFX_SECGEOPREC),TRIM((SALT37.StrType)le.EFX_SECREGION),TRIM((SALT37.StrType)le.EFX_SECCTRYISOCD),TRIM((SALT37.StrType)le.EFX_SECCTRYNUM),TRIM((SALT37.StrType)le.EFX_SECCTRYNAME),TRIM((SALT37.StrType)le.EFX_PHONE),TRIM((SALT37.StrType)le.EFX_FAXPHONE),TRIM((SALT37.StrType)le.EFX_BUSSTAT),TRIM((SALT37.StrType)le.EFX_YREST),TRIM((SALT37.StrType)le.EFX_CORPEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCNT),TRIM((SALT37.StrType)le.EFX_LOCEMPCD),TRIM((SALT37.StrType)le.EFX_CORPAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNT),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTCD),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTTP),TRIM((SALT37.StrType)le.EFX_LOCAMOUNTPREC),TRIM((SALT37.StrType)le.EFX_TCKSYM),TRIM((SALT37.StrType)le.EFX_PRIMSICDESC),TRIM((SALT37.StrType)le.EFX_SECSICDESC1),TRIM((SALT37.StrType)le.EFX_SECSICDESC2),TRIM((SALT37.StrType)le.EFX_SECSICDESC3),TRIM((SALT37.StrType)le.EFX_SECSICDESC4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSCODE),TRIM((SALT37.StrType)le.EFX_SECNAICS1),TRIM((SALT37.StrType)le.EFX_SECNAICS2),TRIM((SALT37.StrType)le.EFX_SECNAICS3),TRIM((SALT37.StrType)le.EFX_SECNAICS4),TRIM((SALT37.StrType)le.EFX_PRIMNAICSDESC),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC1),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC2),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC3),TRIM((SALT37.StrType)le.EFX_SECNAICSDESC4),TRIM((SALT37.StrType)le.EFX_DEAD),TRIM((SALT37.StrType)le.EFX_DEADDT),TRIM((SALT37.StrType)le.EFX_MRKT_TELEVER),TRIM((SALT37.StrType)le.EFX_MRKT_VACANT),TRIM((SALT37.StrType)le.EFX_MRKT_SEASONAL),TRIM((SALT37.StrType)le.EFX_MBE),TRIM((SALT37.StrType)le.EFX_WBE),TRIM((SALT37.StrType)le.EFX_MWBE),TRIM((SALT37.StrType)le.EFX_SDB),TRIM((SALT37.StrType)le.EFX_HUBZONE),TRIM((SALT37.StrType)le.EFX_DBE),TRIM((SALT37.StrType)le.EFX_VET),TRIM((SALT37.StrType)le.EFX_DVET),TRIM((SALT37.StrType)le.EFX_8a),TRIM((SALT37.StrType)le.EFX_8aEXPDT),TRIM((SALT37.StrType)le.EFX_DIS),TRIM((SALT37.StrType)le.EFX_SBE),TRIM((SALT37.StrType)le.EFX_BUSSIZE),TRIM((SALT37.StrType)le.EFX_LBE),TRIM((SALT37.StrType)le.EFX_GOV),TRIM((SALT37.StrType)le.EFX_FGOV),TRIM((SALT37.StrType)le.EFX_NONPROFIT),TRIM((SALT37.StrType)le.EFX_HBCU),TRIM((SALT37.StrType)le.EFX_GAYLESBIAN),TRIM((SALT37.StrType)le.EFX_WSBE),TRIM((SALT37.StrType)le.EFX_VSBE),TRIM((SALT37.StrType)le.EFX_DVSBE),TRIM((SALT37.StrType)le.EFX_MWBESTATUS),TRIM((SALT37.StrType)le.EFX_NMSDC),TRIM((SALT37.StrType)le.EFX_WBENC),TRIM((SALT37.StrType)le.EFX_CA_PUC),TRIM((SALT37.StrType)le.EFX_TX_HUB),TRIM((SALT37.StrType)le.EFX_GSAX),TRIM((SALT37.StrType)le.EFX_CALTRANS),TRIM((SALT37.StrType)le.EFX_EDU),TRIM((SALT37.StrType)le.EFX_MI),TRIM((SALT37.StrType)le.EFX_ANC),TRIM((SALT37.StrType)le.AT_CERT1),TRIM((SALT37.StrType)le.AT_CERT2),TRIM((SALT37.StrType)le.AT_CERT3),TRIM((SALT37.StrType)le.AT_CERT4),TRIM((SALT37.StrType)le.AT_CERT5),TRIM((SALT37.StrType)le.AT_CERT6),TRIM((SALT37.StrType)le.AT_CERT7),TRIM((SALT37.StrType)le.AT_CERT8),TRIM((SALT37.StrType)le.AT_CERT9),TRIM((SALT37.StrType)le.AT_CERT10),TRIM((SALT37.StrType)le.AT_CERTDESC1),TRIM((SALT37.StrType)le.AT_CERTDESC2),TRIM((SALT37.StrType)le.AT_CERTDESC3),TRIM((SALT37.StrType)le.AT_CERTDESC4),TRIM((SALT37.StrType)le.AT_CERTDESC5),TRIM((SALT37.StrType)le.AT_CERTDESC6),TRIM((SALT37.StrType)le.AT_CERTDESC7),TRIM((SALT37.StrType)le.AT_CERTDESC8),TRIM((SALT37.StrType)le.AT_CERTDESC9),TRIM((SALT37.StrType)le.AT_CERTDESC10),TRIM((SALT37.StrType)le.AT_CERTSRC1),TRIM((SALT37.StrType)le.AT_CERTSRC2),TRIM((SALT37.StrType)le.AT_CERTSRC3),TRIM((SALT37.StrType)le.AT_CERTSRC4),TRIM((SALT37.StrType)le.AT_CERTSRC5),TRIM((SALT37.StrType)le.AT_CERTSRC6),TRIM((SALT37.StrType)le.AT_CERTSRC7),TRIM((SALT37.StrType)le.AT_CERTSRC8),TRIM((SALT37.StrType)le.AT_CERTSRC9),TRIM((SALT37.StrType)le.AT_CERTSRC10),TRIM((SALT37.StrType)le.AT_CERTNUM1),TRIM((SALT37.StrType)le.AT_CERTNUM2),TRIM((SALT37.StrType)le.AT_CERTNUM3),TRIM((SALT37.StrType)le.AT_CERTNUM4),TRIM((SALT37.StrType)le.AT_CERTNUM5),TRIM((SALT37.StrType)le.AT_CERTNUM6),TRIM((SALT37.StrType)le.AT_CERTNUM7),TRIM((SALT37.StrType)le.AT_CERTNUM8),TRIM((SALT37.StrType)le.AT_CERTNUM9),TRIM((SALT37.StrType)le.AT_CERTNUM10),TRIM((SALT37.StrType)le.AT_CERTLEV1),TRIM((SALT37.StrType)le.AT_CERTLEV2),TRIM((SALT37.StrType)le.AT_CERTLEV3),TRIM((SALT37.StrType)le.AT_CERTLEV4),TRIM((SALT37.StrType)le.AT_CERTLEV5),TRIM((SALT37.StrType)le.AT_CERTLEV6),TRIM((SALT37.StrType)le.AT_CERTLEV7),TRIM((SALT37.StrType)le.AT_CERTLEV8),TRIM((SALT37.StrType)le.AT_CERTLEV9),TRIM((SALT37.StrType)le.AT_CERTLEV10),TRIM((SALT37.StrType)le.AT_CERTEXP1),TRIM((SALT37.StrType)le.AT_CERTEXP2),TRIM((SALT37.StrType)le.AT_CERTEXP3),TRIM((SALT37.StrType)le.AT_CERTEXP4),TRIM((SALT37.StrType)le.AT_CERTEXP5),TRIM((SALT37.StrType)le.AT_CERTEXP6),TRIM((SALT37.StrType)le.AT_CERTEXP7),TRIM((SALT37.StrType)le.AT_CERTEXP8),TRIM((SALT37.StrType)le.AT_CERTEXP9),TRIM((SALT37.StrType)le.AT_CERTEXP10),TRIM((SALT37.StrType)le.EFX_EXTRACT_DATE),TRIM((SALT37.StrType)le.EFX_MERCHANT_ID),TRIM((SALT37.StrType)le.EFX_PROJECT_ID),TRIM((SALT37.StrType)le.EFX_FOREIGN),TRIM((SALT37.StrType)le.Record_Update_Refresh_Date),TRIM((SALT37.StrType)le.EFX_DATE_CREATED)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),239*239,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dotid'}
      ,{2,'dotscore'}
      ,{3,'dotweight'}
      ,{4,'empid'}
      ,{5,'empscore'}
      ,{6,'empweight'}
      ,{7,'powid'}
      ,{8,'powscore'}
      ,{9,'powweight'}
      ,{10,'proxid'}
      ,{11,'proxscore'}
      ,{12,'proxweight'}
      ,{13,'seleid'}
      ,{14,'selescore'}
      ,{15,'seleweight'}
      ,{16,'orgid'}
      ,{17,'orgscore'}
      ,{18,'orgweight'}
      ,{19,'ultid'}
      ,{20,'ultscore'}
      ,{21,'ultweight'}
      ,{22,'dt_first_seen'}
      ,{23,'dt_last_seen'}
      ,{24,'dt_vendor_first_reported'}
      ,{25,'dt_vendor_last_reported'}
      ,{26,'process_date'}
      ,{27,'record_type'}
      ,{28,'normcompany_type'}
      ,{29,'normaddress_type'}
      ,{30,'clean_company_name'}
      ,{31,'clean_phone'}
      ,{32,'prim_range'}
      ,{33,'predir'}
      ,{34,'prim_name'}
      ,{35,'addr_suffix'}
      ,{36,'postdir'}
      ,{37,'unit_desig'}
      ,{38,'sec_range'}
      ,{39,'p_city_name'}
      ,{40,'v_city_name'}
      ,{41,'st'}
      ,{42,'zip'}
      ,{43,'zip4'}
      ,{44,'cart'}
      ,{45,'cr_sort_sz'}
      ,{46,'lot'}
      ,{47,'lot_order'}
      ,{48,'dbpc'}
      ,{49,'chk_digit'}
      ,{50,'rec_type'}
      ,{51,'fips_state'}
      ,{52,'fips_county'}
      ,{53,'geo_lat'}
      ,{54,'geo_long'}
      ,{55,'msa'}
      ,{56,'geo_blk'}
      ,{57,'geo_match'}
      ,{58,'err_stat'}
      ,{59,'raw_aid'}
      ,{60,'ace_aid'}
      ,{61,'prep_addr_line1'}
      ,{62,'prep_addr_line_last'}
      ,{63,'EFX_BUSSTATCD'}
      ,{64,'EFX_CMSA'}
      ,{65,'EFX_CORPAMOUNTCD'}
      ,{66,'EFX_CORPAMOUNTPREC'}
      ,{67,'EFX_CORPAMOUNTTP'}
      ,{68,'EFX_CORPEMPCD'}
      ,{69,'EFX_WEB'}
      ,{70,'EFX_CTRYISOCD'}
      ,{71,'EFX_CTRYNUM'}
      ,{72,'EFX_CTRYTELCD'}
      ,{73,'EFX_GEOPREC'}
      ,{74,'EFX_MERCTYPE'}
      ,{75,'EFX_MRKT_TELESCORE'}
      ,{76,'EFX_MRKT_TOTALIND'}
      ,{77,'EFX_MRKT_TOTALSCORE'}
      ,{78,'EFX_PUBLIC'}
      ,{79,'EFX_STATEC'}
      ,{80,'EFX_STKEXC'}
      ,{81,'EFX_PRIMSIC'}
      ,{82,'EFX_SECSIC1'}
      ,{83,'EFX_SECSIC2'}
      ,{84,'EFX_SECSIC3'}
      ,{85,'EFX_SECSIC4'}
      ,{86,'EFX_STATE'}
      ,{87,'EFX_ID'}
      ,{88,'EFX_NAME'}
      ,{89,'EFX_LEGAL_NAME'}
      ,{90,'EFX_ADDRESS'}
      ,{91,'EFX_CITY'}
      ,{92,'EFX_REGION'}
      ,{93,'EFX_CTRYNAME'}
      ,{94,'EFX_COUNTYNM'}
      ,{95,'EFX_CMSADESC'}
      ,{96,'EFX_SOHO'}
      ,{97,'EFX_BIZ'}
      ,{98,'EFX_RES'}
      ,{99,'EFX_CMRA'}
      ,{100,'EFX_SECADR'}
      ,{101,'EFX_SECCTY'}
      ,{102,'EFX_SECSTAT'}
      ,{103,'EFX_STATEC2'}
      ,{104,'EFX_SECGEOPREC'}
      ,{105,'EFX_SECREGION'}
      ,{106,'EFX_SECCTRYISOCD'}
      ,{107,'EFX_SECCTRYNUM'}
      ,{108,'EFX_SECCTRYNAME'}
      ,{109,'EFX_PHONE'}
      ,{110,'EFX_FAXPHONE'}
      ,{111,'EFX_BUSSTAT'}
      ,{112,'EFX_YREST'}
      ,{113,'EFX_CORPEMPCNT'}
      ,{114,'EFX_LOCEMPCNT'}
      ,{115,'EFX_LOCEMPCD'}
      ,{116,'EFX_CORPAMOUNT'}
      ,{117,'EFX_LOCAMOUNT'}
      ,{118,'EFX_LOCAMOUNTCD'}
      ,{119,'EFX_LOCAMOUNTTP'}
      ,{120,'EFX_LOCAMOUNTPREC'}
      ,{121,'EFX_TCKSYM'}
      ,{122,'EFX_PRIMSICDESC'}
      ,{123,'EFX_SECSICDESC1'}
      ,{124,'EFX_SECSICDESC2'}
      ,{125,'EFX_SECSICDESC3'}
      ,{126,'EFX_SECSICDESC4'}
      ,{127,'EFX_PRIMNAICSCODE'}
      ,{128,'EFX_SECNAICS1'}
      ,{129,'EFX_SECNAICS2'}
      ,{130,'EFX_SECNAICS3'}
      ,{131,'EFX_SECNAICS4'}
      ,{132,'EFX_PRIMNAICSDESC'}
      ,{133,'EFX_SECNAICSDESC1'}
      ,{134,'EFX_SECNAICSDESC2'}
      ,{135,'EFX_SECNAICSDESC3'}
      ,{136,'EFX_SECNAICSDESC4'}
      ,{137,'EFX_DEAD'}
      ,{138,'EFX_DEADDT'}
      ,{139,'EFX_MRKT_TELEVER'}
      ,{140,'EFX_MRKT_VACANT'}
      ,{141,'EFX_MRKT_SEASONAL'}
      ,{142,'EFX_MBE'}
      ,{143,'EFX_WBE'}
      ,{144,'EFX_MWBE'}
      ,{145,'EFX_SDB'}
      ,{146,'EFX_HUBZONE'}
      ,{147,'EFX_DBE'}
      ,{148,'EFX_VET'}
      ,{149,'EFX_DVET'}
      ,{150,'EFX_8a'}
      ,{151,'EFX_8aEXPDT'}
      ,{152,'EFX_DIS'}
      ,{153,'EFX_SBE'}
      ,{154,'EFX_BUSSIZE'}
      ,{155,'EFX_LBE'}
      ,{156,'EFX_GOV'}
      ,{157,'EFX_FGOV'}
      ,{158,'EFX_NONPROFIT'}
      ,{159,'EFX_HBCU'}
      ,{160,'EFX_GAYLESBIAN'}
      ,{161,'EFX_WSBE'}
      ,{162,'EFX_VSBE'}
      ,{163,'EFX_DVSBE'}
      ,{164,'EFX_MWBESTATUS'}
      ,{165,'EFX_NMSDC'}
      ,{166,'EFX_WBENC'}
      ,{167,'EFX_CA_PUC'}
      ,{168,'EFX_TX_HUB'}
      ,{169,'EFX_GSAX'}
      ,{170,'EFX_CALTRANS'}
      ,{171,'EFX_EDU'}
      ,{172,'EFX_MI'}
      ,{173,'EFX_ANC'}
      ,{174,'AT_CERT1'}
      ,{175,'AT_CERT2'}
      ,{176,'AT_CERT3'}
      ,{177,'AT_CERT4'}
      ,{178,'AT_CERT5'}
      ,{179,'AT_CERT6'}
      ,{180,'AT_CERT7'}
      ,{181,'AT_CERT8'}
      ,{182,'AT_CERT9'}
      ,{183,'AT_CERT10'}
      ,{184,'AT_CERTDESC1'}
      ,{185,'AT_CERTDESC2'}
      ,{186,'AT_CERTDESC3'}
      ,{187,'AT_CERTDESC4'}
      ,{188,'AT_CERTDESC5'}
      ,{189,'AT_CERTDESC6'}
      ,{190,'AT_CERTDESC7'}
      ,{191,'AT_CERTDESC8'}
      ,{192,'AT_CERTDESC9'}
      ,{193,'AT_CERTDESC10'}
      ,{194,'AT_CERTSRC1'}
      ,{195,'AT_CERTSRC2'}
      ,{196,'AT_CERTSRC3'}
      ,{197,'AT_CERTSRC4'}
      ,{198,'AT_CERTSRC5'}
      ,{199,'AT_CERTSRC6'}
      ,{200,'AT_CERTSRC7'}
      ,{201,'AT_CERTSRC8'}
      ,{202,'AT_CERTSRC9'}
      ,{203,'AT_CERTSRC10'}
      ,{204,'AT_CERTNUM1'}
      ,{205,'AT_CERTNUM2'}
      ,{206,'AT_CERTNUM3'}
      ,{207,'AT_CERTNUM4'}
      ,{208,'AT_CERTNUM5'}
      ,{209,'AT_CERTNUM6'}
      ,{210,'AT_CERTNUM7'}
      ,{211,'AT_CERTNUM8'}
      ,{212,'AT_CERTNUM9'}
      ,{213,'AT_CERTNUM10'}
      ,{214,'AT_CERTLEV1'}
      ,{215,'AT_CERTLEV2'}
      ,{216,'AT_CERTLEV3'}
      ,{217,'AT_CERTLEV4'}
      ,{218,'AT_CERTLEV5'}
      ,{219,'AT_CERTLEV6'}
      ,{220,'AT_CERTLEV7'}
      ,{221,'AT_CERTLEV8'}
      ,{222,'AT_CERTLEV9'}
      ,{223,'AT_CERTLEV10'}
      ,{224,'AT_CERTEXP1'}
      ,{225,'AT_CERTEXP2'}
      ,{226,'AT_CERTEXP3'}
      ,{227,'AT_CERTEXP4'}
      ,{228,'AT_CERTEXP5'}
      ,{229,'AT_CERTEXP6'}
      ,{230,'AT_CERTEXP7'}
      ,{231,'AT_CERTEXP8'}
      ,{232,'AT_CERTEXP9'}
      ,{233,'AT_CERTEXP10'}
      ,{234,'EFX_EXTRACT_DATE'}
      ,{235,'EFX_MERCHANT_ID'}
      ,{236,'EFX_PROJECT_ID'}
      ,{237,'EFX_FOREIGN'}
      ,{238,'Record_Update_Refresh_Date'}
      ,{239,'EFX_DATE_CREATED'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_dotid((SALT37.StrType)le.dotid),
    Base_Fields.InValid_dotscore((SALT37.StrType)le.dotscore),
    Base_Fields.InValid_dotweight((SALT37.StrType)le.dotweight),
    Base_Fields.InValid_empid((SALT37.StrType)le.empid),
    Base_Fields.InValid_empscore((SALT37.StrType)le.empscore),
    Base_Fields.InValid_empweight((SALT37.StrType)le.empweight),
    Base_Fields.InValid_powid((SALT37.StrType)le.powid),
    Base_Fields.InValid_powscore((SALT37.StrType)le.powscore),
    Base_Fields.InValid_powweight((SALT37.StrType)le.powweight),
    Base_Fields.InValid_proxid((SALT37.StrType)le.proxid),
    Base_Fields.InValid_proxscore((SALT37.StrType)le.proxscore),
    Base_Fields.InValid_proxweight((SALT37.StrType)le.proxweight),
    Base_Fields.InValid_seleid((SALT37.StrType)le.seleid),
    Base_Fields.InValid_selescore((SALT37.StrType)le.selescore),
    Base_Fields.InValid_seleweight((SALT37.StrType)le.seleweight),
    Base_Fields.InValid_orgid((SALT37.StrType)le.orgid),
    Base_Fields.InValid_orgscore((SALT37.StrType)le.orgscore),
    Base_Fields.InValid_orgweight((SALT37.StrType)le.orgweight),
    Base_Fields.InValid_ultid((SALT37.StrType)le.ultid),
    Base_Fields.InValid_ultscore((SALT37.StrType)le.ultscore),
    Base_Fields.InValid_ultweight((SALT37.StrType)le.ultweight),
    Base_Fields.InValid_dt_first_seen((SALT37.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT37.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT37.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT37.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_process_date((SALT37.StrType)le.process_date),
    Base_Fields.InValid_record_type((SALT37.StrType)le.record_type),
    Base_Fields.InValid_normcompany_type((SALT37.StrType)le.normcompany_type),
    Base_Fields.InValid_normaddress_type((SALT37.StrType)le.normaddress_type),
    Base_Fields.InValid_clean_company_name((SALT37.StrType)le.clean_company_name),
    Base_Fields.InValid_clean_phone((SALT37.StrType)le.clean_phone),
    Base_Fields.InValid_prim_range((SALT37.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT37.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT37.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT37.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT37.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT37.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT37.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT37.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT37.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT37.StrType)le.st,(SALT37.StrType)le.EFX_CTRYNAME),
    Base_Fields.InValid_zip((SALT37.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT37.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT37.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT37.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT37.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT37.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT37.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT37.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT37.StrType)le.rec_type),
    Base_Fields.InValid_fips_state((SALT37.StrType)le.fips_state),
    Base_Fields.InValid_fips_county((SALT37.StrType)le.fips_county),
    Base_Fields.InValid_geo_lat((SALT37.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT37.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT37.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT37.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT37.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT37.StrType)le.err_stat),
    Base_Fields.InValid_raw_aid((SALT37.StrType)le.raw_aid),
    Base_Fields.InValid_ace_aid((SALT37.StrType)le.ace_aid),
    Base_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    Base_Fields.InValid_EFX_BUSSTATCD((SALT37.StrType)le.EFX_BUSSTATCD),
    Base_Fields.InValid_EFX_CMSA((SALT37.StrType)le.EFX_CMSA),
    Base_Fields.InValid_EFX_CORPAMOUNTCD((SALT37.StrType)le.EFX_CORPAMOUNTCD),
    Base_Fields.InValid_EFX_CORPAMOUNTPREC((SALT37.StrType)le.EFX_CORPAMOUNTPREC),
    Base_Fields.InValid_EFX_CORPAMOUNTTP((SALT37.StrType)le.EFX_CORPAMOUNTTP),
    Base_Fields.InValid_EFX_CORPEMPCD((SALT37.StrType)le.EFX_CORPEMPCD),
    Base_Fields.InValid_EFX_WEB((SALT37.StrType)le.EFX_WEB),
    Base_Fields.InValid_EFX_CTRYISOCD((SALT37.StrType)le.EFX_CTRYISOCD),
    Base_Fields.InValid_EFX_CTRYNUM((SALT37.StrType)le.EFX_CTRYNUM),
    Base_Fields.InValid_EFX_CTRYTELCD((SALT37.StrType)le.EFX_CTRYTELCD),
    Base_Fields.InValid_EFX_GEOPREC((SALT37.StrType)le.EFX_GEOPREC),
    Base_Fields.InValid_EFX_MERCTYPE((SALT37.StrType)le.EFX_MERCTYPE),
    Base_Fields.InValid_EFX_MRKT_TELESCORE((SALT37.StrType)le.EFX_MRKT_TELESCORE),
    Base_Fields.InValid_EFX_MRKT_TOTALIND((SALT37.StrType)le.EFX_MRKT_TOTALIND),
    Base_Fields.InValid_EFX_MRKT_TOTALSCORE((SALT37.StrType)le.EFX_MRKT_TOTALSCORE),
    Base_Fields.InValid_EFX_PUBLIC((SALT37.StrType)le.EFX_PUBLIC),
    Base_Fields.InValid_EFX_STATEC((SALT37.StrType)le.EFX_STATEC),
    Base_Fields.InValid_EFX_STKEXC((SALT37.StrType)le.EFX_STKEXC),
    Base_Fields.InValid_EFX_PRIMSIC((SALT37.StrType)le.EFX_PRIMSIC),
    Base_Fields.InValid_EFX_SECSIC1((SALT37.StrType)le.EFX_SECSIC1),
    Base_Fields.InValid_EFX_SECSIC2((SALT37.StrType)le.EFX_SECSIC2),
    Base_Fields.InValid_EFX_SECSIC3((SALT37.StrType)le.EFX_SECSIC3),
    Base_Fields.InValid_EFX_SECSIC4((SALT37.StrType)le.EFX_SECSIC4),
    Base_Fields.InValid_EFX_STATE((SALT37.StrType)le.EFX_STATE,(SALT37.StrType)le.EFX_CTRYNAME),
    Base_Fields.InValid_EFX_ID((SALT37.StrType)le.EFX_ID),
    Base_Fields.InValid_EFX_NAME((SALT37.StrType)le.EFX_NAME),
    Base_Fields.InValid_EFX_LEGAL_NAME((SALT37.StrType)le.EFX_LEGAL_NAME),
    Base_Fields.InValid_EFX_ADDRESS((SALT37.StrType)le.EFX_ADDRESS),
    Base_Fields.InValid_EFX_CITY((SALT37.StrType)le.EFX_CITY),
    Base_Fields.InValid_EFX_REGION((SALT37.StrType)le.EFX_REGION),
    Base_Fields.InValid_EFX_CTRYNAME((SALT37.StrType)le.EFX_CTRYNAME),
    Base_Fields.InValid_EFX_COUNTYNM((SALT37.StrType)le.EFX_COUNTYNM),
    Base_Fields.InValid_EFX_CMSADESC((SALT37.StrType)le.EFX_CMSADESC),
    Base_Fields.InValid_EFX_SOHO((SALT37.StrType)le.EFX_SOHO),
    Base_Fields.InValid_EFX_BIZ((SALT37.StrType)le.EFX_BIZ),
    Base_Fields.InValid_EFX_RES((SALT37.StrType)le.EFX_RES),
    Base_Fields.InValid_EFX_CMRA((SALT37.StrType)le.EFX_CMRA),
    Base_Fields.InValid_EFX_SECADR((SALT37.StrType)le.EFX_SECADR),
    Base_Fields.InValid_EFX_SECCTY((SALT37.StrType)le.EFX_SECCTY),
    Base_Fields.InValid_EFX_SECSTAT((SALT37.StrType)le.EFX_SECSTAT,(SALT37.StrType)le.EFX_CTRYNAME),
    Base_Fields.InValid_EFX_STATEC2((SALT37.StrType)le.EFX_STATEC2),
    Base_Fields.InValid_EFX_SECGEOPREC((SALT37.StrType)le.EFX_SECGEOPREC),
    Base_Fields.InValid_EFX_SECREGION((SALT37.StrType)le.EFX_SECREGION),
    Base_Fields.InValid_EFX_SECCTRYISOCD((SALT37.StrType)le.EFX_SECCTRYISOCD),
    Base_Fields.InValid_EFX_SECCTRYNUM((SALT37.StrType)le.EFX_SECCTRYNUM),
    Base_Fields.InValid_EFX_SECCTRYNAME((SALT37.StrType)le.EFX_SECCTRYNAME),
    Base_Fields.InValid_EFX_PHONE((SALT37.StrType)le.EFX_PHONE),
    Base_Fields.InValid_EFX_FAXPHONE((SALT37.StrType)le.EFX_FAXPHONE),
    Base_Fields.InValid_EFX_BUSSTAT((SALT37.StrType)le.EFX_BUSSTAT),
    Base_Fields.InValid_EFX_YREST((SALT37.StrType)le.EFX_YREST),
    Base_Fields.InValid_EFX_CORPEMPCNT((SALT37.StrType)le.EFX_CORPEMPCNT),
    Base_Fields.InValid_EFX_LOCEMPCNT((SALT37.StrType)le.EFX_LOCEMPCNT),
    Base_Fields.InValid_EFX_LOCEMPCD((SALT37.StrType)le.EFX_LOCEMPCD),
    Base_Fields.InValid_EFX_CORPAMOUNT((SALT37.StrType)le.EFX_CORPAMOUNT),
    Base_Fields.InValid_EFX_LOCAMOUNT((SALT37.StrType)le.EFX_LOCAMOUNT),
    Base_Fields.InValid_EFX_LOCAMOUNTCD((SALT37.StrType)le.EFX_LOCAMOUNTCD),
    Base_Fields.InValid_EFX_LOCAMOUNTTP((SALT37.StrType)le.EFX_LOCAMOUNTTP),
    Base_Fields.InValid_EFX_LOCAMOUNTPREC((SALT37.StrType)le.EFX_LOCAMOUNTPREC),
    Base_Fields.InValid_EFX_TCKSYM((SALT37.StrType)le.EFX_TCKSYM),
    Base_Fields.InValid_EFX_PRIMSICDESC((SALT37.StrType)le.EFX_PRIMSICDESC),
    Base_Fields.InValid_EFX_SECSICDESC1((SALT37.StrType)le.EFX_SECSICDESC1),
    Base_Fields.InValid_EFX_SECSICDESC2((SALT37.StrType)le.EFX_SECSICDESC2),
    Base_Fields.InValid_EFX_SECSICDESC3((SALT37.StrType)le.EFX_SECSICDESC3),
    Base_Fields.InValid_EFX_SECSICDESC4((SALT37.StrType)le.EFX_SECSICDESC4),
    Base_Fields.InValid_EFX_PRIMNAICSCODE((SALT37.StrType)le.EFX_PRIMNAICSCODE),
    Base_Fields.InValid_EFX_SECNAICS1((SALT37.StrType)le.EFX_SECNAICS1),
    Base_Fields.InValid_EFX_SECNAICS2((SALT37.StrType)le.EFX_SECNAICS2),
    Base_Fields.InValid_EFX_SECNAICS3((SALT37.StrType)le.EFX_SECNAICS3),
    Base_Fields.InValid_EFX_SECNAICS4((SALT37.StrType)le.EFX_SECNAICS4),
    Base_Fields.InValid_EFX_PRIMNAICSDESC((SALT37.StrType)le.EFX_PRIMNAICSDESC),
    Base_Fields.InValid_EFX_SECNAICSDESC1((SALT37.StrType)le.EFX_SECNAICSDESC1),
    Base_Fields.InValid_EFX_SECNAICSDESC2((SALT37.StrType)le.EFX_SECNAICSDESC2),
    Base_Fields.InValid_EFX_SECNAICSDESC3((SALT37.StrType)le.EFX_SECNAICSDESC3),
    Base_Fields.InValid_EFX_SECNAICSDESC4((SALT37.StrType)le.EFX_SECNAICSDESC4),
    Base_Fields.InValid_EFX_DEAD((SALT37.StrType)le.EFX_DEAD),
    Base_Fields.InValid_EFX_DEADDT((SALT37.StrType)le.EFX_DEADDT),
    Base_Fields.InValid_EFX_MRKT_TELEVER((SALT37.StrType)le.EFX_MRKT_TELEVER),
    Base_Fields.InValid_EFX_MRKT_VACANT((SALT37.StrType)le.EFX_MRKT_VACANT),
    Base_Fields.InValid_EFX_MRKT_SEASONAL((SALT37.StrType)le.EFX_MRKT_SEASONAL),
    Base_Fields.InValid_EFX_MBE((SALT37.StrType)le.EFX_MBE),
    Base_Fields.InValid_EFX_WBE((SALT37.StrType)le.EFX_WBE),
    Base_Fields.InValid_EFX_MWBE((SALT37.StrType)le.EFX_MWBE),
    Base_Fields.InValid_EFX_SDB((SALT37.StrType)le.EFX_SDB),
    Base_Fields.InValid_EFX_HUBZONE((SALT37.StrType)le.EFX_HUBZONE),
    Base_Fields.InValid_EFX_DBE((SALT37.StrType)le.EFX_DBE),
    Base_Fields.InValid_EFX_VET((SALT37.StrType)le.EFX_VET),
    Base_Fields.InValid_EFX_DVET((SALT37.StrType)le.EFX_DVET),
    Base_Fields.InValid_EFX_8a((SALT37.StrType)le.EFX_8a),
    Base_Fields.InValid_EFX_8aEXPDT((SALT37.StrType)le.EFX_8aEXPDT),
    Base_Fields.InValid_EFX_DIS((SALT37.StrType)le.EFX_DIS),
    Base_Fields.InValid_EFX_SBE((SALT37.StrType)le.EFX_SBE),
    Base_Fields.InValid_EFX_BUSSIZE((SALT37.StrType)le.EFX_BUSSIZE),
    Base_Fields.InValid_EFX_LBE((SALT37.StrType)le.EFX_LBE),
    Base_Fields.InValid_EFX_GOV((SALT37.StrType)le.EFX_GOV),
    Base_Fields.InValid_EFX_FGOV((SALT37.StrType)le.EFX_FGOV),
    Base_Fields.InValid_EFX_NONPROFIT((SALT37.StrType)le.EFX_NONPROFIT),
    Base_Fields.InValid_EFX_HBCU((SALT37.StrType)le.EFX_HBCU),
    Base_Fields.InValid_EFX_GAYLESBIAN((SALT37.StrType)le.EFX_GAYLESBIAN),
    Base_Fields.InValid_EFX_WSBE((SALT37.StrType)le.EFX_WSBE),
    Base_Fields.InValid_EFX_VSBE((SALT37.StrType)le.EFX_VSBE),
    Base_Fields.InValid_EFX_DVSBE((SALT37.StrType)le.EFX_DVSBE),
    Base_Fields.InValid_EFX_MWBESTATUS((SALT37.StrType)le.EFX_MWBESTATUS),
    Base_Fields.InValid_EFX_NMSDC((SALT37.StrType)le.EFX_NMSDC),
    Base_Fields.InValid_EFX_WBENC((SALT37.StrType)le.EFX_WBENC),
    Base_Fields.InValid_EFX_CA_PUC((SALT37.StrType)le.EFX_CA_PUC),
    Base_Fields.InValid_EFX_TX_HUB((SALT37.StrType)le.EFX_TX_HUB),
    Base_Fields.InValid_EFX_GSAX((SALT37.StrType)le.EFX_GSAX),
    Base_Fields.InValid_EFX_CALTRANS((SALT37.StrType)le.EFX_CALTRANS),
    Base_Fields.InValid_EFX_EDU((SALT37.StrType)le.EFX_EDU),
    Base_Fields.InValid_EFX_MI((SALT37.StrType)le.EFX_MI),
    Base_Fields.InValid_EFX_ANC((SALT37.StrType)le.EFX_ANC),
    Base_Fields.InValid_AT_CERT1((SALT37.StrType)le.AT_CERT1),
    Base_Fields.InValid_AT_CERT2((SALT37.StrType)le.AT_CERT2),
    Base_Fields.InValid_AT_CERT3((SALT37.StrType)le.AT_CERT3),
    Base_Fields.InValid_AT_CERT4((SALT37.StrType)le.AT_CERT4),
    Base_Fields.InValid_AT_CERT5((SALT37.StrType)le.AT_CERT5),
    Base_Fields.InValid_AT_CERT6((SALT37.StrType)le.AT_CERT6),
    Base_Fields.InValid_AT_CERT7((SALT37.StrType)le.AT_CERT7),
    Base_Fields.InValid_AT_CERT8((SALT37.StrType)le.AT_CERT8),
    Base_Fields.InValid_AT_CERT9((SALT37.StrType)le.AT_CERT9),
    Base_Fields.InValid_AT_CERT10((SALT37.StrType)le.AT_CERT10),
    Base_Fields.InValid_AT_CERTDESC1((SALT37.StrType)le.AT_CERTDESC1),
    Base_Fields.InValid_AT_CERTDESC2((SALT37.StrType)le.AT_CERTDESC2),
    Base_Fields.InValid_AT_CERTDESC3((SALT37.StrType)le.AT_CERTDESC3),
    Base_Fields.InValid_AT_CERTDESC4((SALT37.StrType)le.AT_CERTDESC4),
    Base_Fields.InValid_AT_CERTDESC5((SALT37.StrType)le.AT_CERTDESC5),
    Base_Fields.InValid_AT_CERTDESC6((SALT37.StrType)le.AT_CERTDESC6),
    Base_Fields.InValid_AT_CERTDESC7((SALT37.StrType)le.AT_CERTDESC7),
    Base_Fields.InValid_AT_CERTDESC8((SALT37.StrType)le.AT_CERTDESC8),
    Base_Fields.InValid_AT_CERTDESC9((SALT37.StrType)le.AT_CERTDESC9),
    Base_Fields.InValid_AT_CERTDESC10((SALT37.StrType)le.AT_CERTDESC10),
    Base_Fields.InValid_AT_CERTSRC1((SALT37.StrType)le.AT_CERTSRC1),
    Base_Fields.InValid_AT_CERTSRC2((SALT37.StrType)le.AT_CERTSRC2),
    Base_Fields.InValid_AT_CERTSRC3((SALT37.StrType)le.AT_CERTSRC3),
    Base_Fields.InValid_AT_CERTSRC4((SALT37.StrType)le.AT_CERTSRC4),
    Base_Fields.InValid_AT_CERTSRC5((SALT37.StrType)le.AT_CERTSRC5),
    Base_Fields.InValid_AT_CERTSRC6((SALT37.StrType)le.AT_CERTSRC6),
    Base_Fields.InValid_AT_CERTSRC7((SALT37.StrType)le.AT_CERTSRC7),
    Base_Fields.InValid_AT_CERTSRC8((SALT37.StrType)le.AT_CERTSRC8),
    Base_Fields.InValid_AT_CERTSRC9((SALT37.StrType)le.AT_CERTSRC9),
    Base_Fields.InValid_AT_CERTSRC10((SALT37.StrType)le.AT_CERTSRC10),
    Base_Fields.InValid_AT_CERTNUM1((SALT37.StrType)le.AT_CERTNUM1),
    Base_Fields.InValid_AT_CERTNUM2((SALT37.StrType)le.AT_CERTNUM2),
    Base_Fields.InValid_AT_CERTNUM3((SALT37.StrType)le.AT_CERTNUM3),
    Base_Fields.InValid_AT_CERTNUM4((SALT37.StrType)le.AT_CERTNUM4),
    Base_Fields.InValid_AT_CERTNUM5((SALT37.StrType)le.AT_CERTNUM5),
    Base_Fields.InValid_AT_CERTNUM6((SALT37.StrType)le.AT_CERTNUM6),
    Base_Fields.InValid_AT_CERTNUM7((SALT37.StrType)le.AT_CERTNUM7),
    Base_Fields.InValid_AT_CERTNUM8((SALT37.StrType)le.AT_CERTNUM8),
    Base_Fields.InValid_AT_CERTNUM9((SALT37.StrType)le.AT_CERTNUM9),
    Base_Fields.InValid_AT_CERTNUM10((SALT37.StrType)le.AT_CERTNUM10),
    Base_Fields.InValid_AT_CERTLEV1((SALT37.StrType)le.AT_CERTLEV1),
    Base_Fields.InValid_AT_CERTLEV2((SALT37.StrType)le.AT_CERTLEV2),
    Base_Fields.InValid_AT_CERTLEV3((SALT37.StrType)le.AT_CERTLEV3),
    Base_Fields.InValid_AT_CERTLEV4((SALT37.StrType)le.AT_CERTLEV4),
    Base_Fields.InValid_AT_CERTLEV5((SALT37.StrType)le.AT_CERTLEV5),
    Base_Fields.InValid_AT_CERTLEV6((SALT37.StrType)le.AT_CERTLEV6),
    Base_Fields.InValid_AT_CERTLEV7((SALT37.StrType)le.AT_CERTLEV7),
    Base_Fields.InValid_AT_CERTLEV8((SALT37.StrType)le.AT_CERTLEV8),
    Base_Fields.InValid_AT_CERTLEV9((SALT37.StrType)le.AT_CERTLEV9),
    Base_Fields.InValid_AT_CERTLEV10((SALT37.StrType)le.AT_CERTLEV10),
    Base_Fields.InValid_AT_CERTEXP1((SALT37.StrType)le.AT_CERTEXP1),
    Base_Fields.InValid_AT_CERTEXP2((SALT37.StrType)le.AT_CERTEXP2),
    Base_Fields.InValid_AT_CERTEXP3((SALT37.StrType)le.AT_CERTEXP3),
    Base_Fields.InValid_AT_CERTEXP4((SALT37.StrType)le.AT_CERTEXP4),
    Base_Fields.InValid_AT_CERTEXP5((SALT37.StrType)le.AT_CERTEXP5),
    Base_Fields.InValid_AT_CERTEXP6((SALT37.StrType)le.AT_CERTEXP6),
    Base_Fields.InValid_AT_CERTEXP7((SALT37.StrType)le.AT_CERTEXP7),
    Base_Fields.InValid_AT_CERTEXP8((SALT37.StrType)le.AT_CERTEXP8),
    Base_Fields.InValid_AT_CERTEXP9((SALT37.StrType)le.AT_CERTEXP9),
    Base_Fields.InValid_AT_CERTEXP10((SALT37.StrType)le.AT_CERTEXP10),
    Base_Fields.InValid_EFX_EXTRACT_DATE((SALT37.StrType)le.EFX_EXTRACT_DATE),
    Base_Fields.InValid_EFX_MERCHANT_ID((SALT37.StrType)le.EFX_MERCHANT_ID),
    Base_Fields.InValid_EFX_PROJECT_ID((SALT37.StrType)le.EFX_PROJECT_ID),
    Base_Fields.InValid_EFX_FOREIGN((SALT37.StrType)le.EFX_FOREIGN),
    Base_Fields.InValid_Record_Update_Refresh_Date((SALT37.StrType)le.Record_Update_Refresh_Date),
    Base_Fields.InValid_EFX_DATE_CREATED((SALT37.StrType)le.EFX_DATE_CREATED),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,239,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_record_type','invalid_norm_type','invalid_address_type_code','invalid_mandatory','invalid_phone','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dbpc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_mandatory','invalid_mandatory','invalid_busstatcd','invalid_cmsa','invalid_corpamountcd','invalid_corpamountprec','invalid_corpamounttp','invalid_corpempcd','Unknown','invalid_ctryisocd','invalid_ctrynum','invalid_ctrytelcd','invalid_geoprec','invalid_merctype','invalid_mrkt_telescore','invalid_mrkt_totalind','invalid_mrkt_totalscore','invalid_public','invalid_statec','invalid_stkexc','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_st','invalid_numeric','invalid_name','invalid_legal_name','invalid_mandatory','invalid_mandatory','Unknown','invalid_mandatory','Unknown','Unknown','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','Unknown','Unknown','invalid_st','invalid_statec','invalid_geoprec','Unknown','invalid_ctryisocd','invalid_ctrynum','Unknown','invalid_phone','invalid_phone','Unknown','invalid_year_established','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_corpempcd','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_corpamountcd','invalid_corpamounttp','invalid_corpamountprec','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_yes_blank','invalid_past_date','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_general_date','invalid_yes_blank','invalid_yes_blank','invalid_business_size','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_cert_or_class','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_past_date','invalid_numeric','invalid_numeric_or_blank','invalid_yes_blank','invalid_past_date','invalid_date_created');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_normcompany_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_normaddress_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_BUSSTATCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CMSA(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CORPAMOUNTCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CORPAMOUNTPREC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CORPAMOUNTTP(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CORPEMPCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_WEB(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CTRYISOCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CTRYNUM(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CTRYTELCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_GEOPREC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MERCTYPE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MRKT_TELESCORE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MRKT_TOTALIND(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MRKT_TOTALSCORE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PUBLIC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_STATEC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_STKEXC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PRIMSIC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSIC1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSIC2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSIC3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSIC4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_STATE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_ID(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_NAME(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LEGAL_NAME(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_ADDRESS(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CITY(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_REGION(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CTRYNAME(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_COUNTYNM(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CMSADESC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SOHO(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_BIZ(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_RES(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CMRA(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECADR(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECCTY(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSTAT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_STATEC2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECGEOPREC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECREGION(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECCTRYISOCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECCTRYNUM(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECCTRYNAME(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PHONE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_FAXPHONE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_BUSSTAT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_YREST(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CORPEMPCNT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LOCEMPCNT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LOCEMPCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CORPAMOUNT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LOCAMOUNT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LOCAMOUNTCD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LOCAMOUNTTP(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LOCAMOUNTPREC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_TCKSYM(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PRIMSICDESC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSICDESC1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSICDESC2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSICDESC3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECSICDESC4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PRIMNAICSCODE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICS1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICS2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICS3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICS4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PRIMNAICSDESC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICSDESC1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICSDESC2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICSDESC3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SECNAICSDESC4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DEAD(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DEADDT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MRKT_TELEVER(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MRKT_VACANT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MRKT_SEASONAL(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_WBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MWBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SDB(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_HUBZONE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_VET(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DVET(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_8a(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_8aEXPDT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DIS(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_SBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_BUSSIZE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_LBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_GOV(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_FGOV(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_NONPROFIT(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_HBCU(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_GAYLESBIAN(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_WSBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_VSBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DVSBE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MWBESTATUS(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_NMSDC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_WBENC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CA_PUC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_TX_HUB(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_GSAX(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_CALTRANS(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_EDU(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MI(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_ANC(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERT10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTDESC10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTSRC10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTNUM10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTLEV10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_AT_CERTEXP10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_EXTRACT_DATE(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_MERCHANT_ID(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_PROJECT_ID(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_FOREIGN(TotalErrors.ErrorNum),Base_Fields.InValidMessage_Record_Update_Refresh_Date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_EFX_DATE_CREATED(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
