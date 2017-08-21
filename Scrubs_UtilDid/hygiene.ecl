import ut,SALT30;
export hygiene(dataset(layout_UtilDid) h) := MODULE
//A simple summary record
export Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_id_pcnt := AVE(GROUP,IF(h.id = (TYPEOF(h.id))'',0,100));
    maxlength_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.id)));
    avelength_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.id)),h.id<>(typeof(h.id))'');
    populated_exchange_serial_number_pcnt := AVE(GROUP,IF(h.exchange_serial_number = (TYPEOF(h.exchange_serial_number))'',0,100));
    maxlength_exchange_serial_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.exchange_serial_number)));
    avelength_exchange_serial_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.exchange_serial_number)),h.exchange_serial_number<>(typeof(h.exchange_serial_number))'');
    populated_date_added_to_exchange_pcnt := AVE(GROUP,IF(h.date_added_to_exchange = (TYPEOF(h.date_added_to_exchange))'',0,100));
    maxlength_date_added_to_exchange := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_added_to_exchange)));
    avelength_date_added_to_exchange := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_added_to_exchange)),h.date_added_to_exchange<>(typeof(h.date_added_to_exchange))'');
    populated_connect_date_pcnt := AVE(GROUP,IF(h.connect_date = (TYPEOF(h.connect_date))'',0,100));
    maxlength_connect_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.connect_date)));
    avelength_connect_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.connect_date)),h.connect_date<>(typeof(h.connect_date))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_record_date_pcnt := AVE(GROUP,IF(h.record_date = (TYPEOF(h.record_date))'',0,100));
    maxlength_record_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_date)));
    avelength_record_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_date)),h.record_date<>(typeof(h.record_date))'');
    populated_util_type_pcnt := AVE(GROUP,IF(h.util_type = (TYPEOF(h.util_type))'',0,100));
    maxlength_util_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.util_type)));
    avelength_util_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.util_type)),h.util_type<>(typeof(h.util_type))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_addr_type_pcnt := AVE(GROUP,IF(h.addr_type = (TYPEOF(h.addr_type))'',0,100));
    maxlength_addr_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_type)));
    avelength_addr_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_type)),h.addr_type<>(typeof(h.addr_type))'');
    populated_addr_dual_pcnt := AVE(GROUP,IF(h.addr_dual = (TYPEOF(h.addr_dual))'',0,100));
    maxlength_addr_dual := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_dual)));
    avelength_addr_dual := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_dual)),h.addr_dual<>(typeof(h.addr_dual))'');
    populated_address_street_pcnt := AVE(GROUP,IF(h.address_street = (TYPEOF(h.address_street))'',0,100));
    maxlength_address_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street)));
    avelength_address_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street)),h.address_street<>(typeof(h.address_street))'');
    populated_address_street_Name_pcnt := AVE(GROUP,IF(h.address_street_Name = (TYPEOF(h.address_street_Name))'',0,100));
    maxlength_address_street_Name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street_Name)));
    avelength_address_street_Name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street_Name)),h.address_street_Name<>(typeof(h.address_street_Name))'');
    populated_address_street_type_pcnt := AVE(GROUP,IF(h.address_street_type = (TYPEOF(h.address_street_type))'',0,100));
    maxlength_address_street_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street_type)));
    avelength_address_street_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street_type)),h.address_street_type<>(typeof(h.address_street_type))'');
    populated_address_street_direction_pcnt := AVE(GROUP,IF(h.address_street_direction = (TYPEOF(h.address_street_direction))'',0,100));
    maxlength_address_street_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street_direction)));
    avelength_address_street_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_street_direction)),h.address_street_direction<>(typeof(h.address_street_direction))'');
    populated_address_apartment_pcnt := AVE(GROUP,IF(h.address_apartment = (TYPEOF(h.address_apartment))'',0,100));
    maxlength_address_apartment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_apartment)));
    avelength_address_apartment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_apartment)),h.address_apartment<>(typeof(h.address_apartment))'');
    populated_address_city_pcnt := AVE(GROUP,IF(h.address_city = (TYPEOF(h.address_city))'',0,100));
    maxlength_address_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_city)));
    avelength_address_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_city)),h.address_city<>(typeof(h.address_city))'');
    populated_address_state_pcnt := AVE(GROUP,IF(h.address_state = (TYPEOF(h.address_state))'',0,100));
    maxlength_address_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_state)));
    avelength_address_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_state)),h.address_state<>(typeof(h.address_state))'');
    populated_address_zip_pcnt := AVE(GROUP,IF(h.address_zip = (TYPEOF(h.address_zip))'',0,100));
    maxlength_address_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_zip)));
    avelength_address_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_zip)),h.address_zip<>(typeof(h.address_zip))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_work_phone_pcnt := AVE(GROUP,IF(h.work_phone = (TYPEOF(h.work_phone))'',0,100));
    maxlength_work_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_phone)));
    avelength_work_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_phone)),h.work_phone<>(typeof(h.work_phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_drivers_license_state_code_pcnt := AVE(GROUP,IF(h.drivers_license_state_code = (TYPEOF(h.drivers_license_state_code))'',0,100));
    maxlength_drivers_license_state_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_state_code)));
    avelength_drivers_license_state_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_state_code)),h.drivers_license_state_code<>(typeof(h.drivers_license_state_code))'');
    populated_drivers_license_pcnt := AVE(GROUP,IF(h.drivers_license = (TYPEOF(h.drivers_license))'',0,100));
    maxlength_drivers_license := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license)));
    avelength_drivers_license := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license)),h.drivers_license<>(typeof(h.drivers_license))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_fdid_pcnt := AVE(GROUP,IF(h.fdid = (TYPEOF(h.fdid))'',0,100));
    maxlength_fdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fdid)));
    avelength_fdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fdid)),h.fdid<>(typeof(h.fdid))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
  END;
  RETURN table(h,SummaryLayout);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'id','exchange_serial_number','date_added_to_exchange','connect_date','date_first_seen','record_date','util_type','orig_lname','orig_fname','orig_mname','orig_name_suffix','addr_type','addr_dual','address_street','address_street_Name','address_street_type','address_street_direction','address_apartment','address_city','address_state','address_zip','ssn','work_phone','phone','dob','drivers_license_state_code','drivers_license','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','did','title','fname','mname','lname','name_suffix','name_score','fdid','hhid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_id_pcnt,le.populated_exchange_serial_number_pcnt,le.populated_date_added_to_exchange_pcnt,le.populated_connect_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_record_date_pcnt,le.populated_util_type_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_addr_type_pcnt,le.populated_addr_dual_pcnt,le.populated_address_street_pcnt,le.populated_address_street_Name_pcnt,le.populated_address_street_type_pcnt,le.populated_address_street_direction_pcnt,le.populated_address_apartment_pcnt,le.populated_address_city_pcnt,le.populated_address_state_pcnt,le.populated_address_zip_pcnt,le.populated_ssn_pcnt,le.populated_work_phone_pcnt,le.populated_phone_pcnt,le.populated_dob_pcnt,le.populated_drivers_license_state_code_pcnt,le.populated_drivers_license_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_did_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_fdid_pcnt,le.populated_hhid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_id,le.maxlength_exchange_serial_number,le.maxlength_date_added_to_exchange,le.maxlength_connect_date,le.maxlength_date_first_seen,le.maxlength_record_date,le.maxlength_util_type,le.maxlength_orig_lname,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_name_suffix,le.maxlength_addr_type,le.maxlength_addr_dual,le.maxlength_address_street,le.maxlength_address_street_Name,le.maxlength_address_street_type,le.maxlength_address_street_direction,le.maxlength_address_apartment,le.maxlength_address_city,le.maxlength_address_state,le.maxlength_address_zip,le.maxlength_ssn,le.maxlength_work_phone,le.maxlength_phone,le.maxlength_dob,le.maxlength_drivers_license_state_code,le.maxlength_drivers_license,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_did,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_fdid,le.maxlength_hhid);
  SELF.avelength := CHOOSE(C,le.avelength_id,le.avelength_exchange_serial_number,le.avelength_date_added_to_exchange,le.avelength_connect_date,le.avelength_date_first_seen,le.avelength_record_date,le.avelength_util_type,le.avelength_orig_lname,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_name_suffix,le.avelength_addr_type,le.avelength_addr_dual,le.avelength_address_street,le.avelength_address_street_Name,le.avelength_address_street_type,le.avelength_address_street_direction,le.avelength_address_apartment,le.avelength_address_city,le.avelength_address_state,le.avelength_address_zip,le.avelength_ssn,le.avelength_work_phone,le.avelength_phone,le.avelength_dob,le.avelength_drivers_license_state_code,le.avelength_drivers_license,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_did,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_fdid,le.avelength_hhid);
END;
EXPORT invSummary := NORMALIZE(summary0, 62, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.id),TRIM((SALT30.StrType)le.exchange_serial_number),TRIM((SALT30.StrType)le.date_added_to_exchange),TRIM((SALT30.StrType)le.connect_date),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.record_date),TRIM((SALT30.StrType)le.util_type),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.orig_name_suffix),TRIM((SALT30.StrType)le.addr_type),TRIM((SALT30.StrType)le.addr_dual),TRIM((SALT30.StrType)le.address_street),TRIM((SALT30.StrType)le.address_street_Name),TRIM((SALT30.StrType)le.address_street_type),TRIM((SALT30.StrType)le.address_street_direction),TRIM((SALT30.StrType)le.address_apartment),TRIM((SALT30.StrType)le.address_city),TRIM((SALT30.StrType)le.address_state),TRIM((SALT30.StrType)le.address_zip),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.work_phone),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.drivers_license_state_code),TRIM((SALT30.StrType)le.drivers_license),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.fdid),TRIM((SALT30.StrType)le.hhid)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,62,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 62);
  SELF.FldNo2 := 1 + (C % 62);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.id),TRIM((SALT30.StrType)le.exchange_serial_number),TRIM((SALT30.StrType)le.date_added_to_exchange),TRIM((SALT30.StrType)le.connect_date),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.record_date),TRIM((SALT30.StrType)le.util_type),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.orig_name_suffix),TRIM((SALT30.StrType)le.addr_type),TRIM((SALT30.StrType)le.addr_dual),TRIM((SALT30.StrType)le.address_street),TRIM((SALT30.StrType)le.address_street_Name),TRIM((SALT30.StrType)le.address_street_type),TRIM((SALT30.StrType)le.address_street_direction),TRIM((SALT30.StrType)le.address_apartment),TRIM((SALT30.StrType)le.address_city),TRIM((SALT30.StrType)le.address_state),TRIM((SALT30.StrType)le.address_zip),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.work_phone),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.drivers_license_state_code),TRIM((SALT30.StrType)le.drivers_license),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.fdid),TRIM((SALT30.StrType)le.hhid)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.id),TRIM((SALT30.StrType)le.exchange_serial_number),TRIM((SALT30.StrType)le.date_added_to_exchange),TRIM((SALT30.StrType)le.connect_date),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.record_date),TRIM((SALT30.StrType)le.util_type),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.orig_name_suffix),TRIM((SALT30.StrType)le.addr_type),TRIM((SALT30.StrType)le.addr_dual),TRIM((SALT30.StrType)le.address_street),TRIM((SALT30.StrType)le.address_street_Name),TRIM((SALT30.StrType)le.address_street_type),TRIM((SALT30.StrType)le.address_street_direction),TRIM((SALT30.StrType)le.address_apartment),TRIM((SALT30.StrType)le.address_city),TRIM((SALT30.StrType)le.address_state),TRIM((SALT30.StrType)le.address_zip),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.work_phone),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.drivers_license_state_code),TRIM((SALT30.StrType)le.drivers_license),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.fdid),TRIM((SALT30.StrType)le.hhid)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),62*62,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'id'}
      ,{2,'exchange_serial_number'}
      ,{3,'date_added_to_exchange'}
      ,{4,'connect_date'}
      ,{5,'date_first_seen'}
      ,{6,'record_date'}
      ,{7,'util_type'}
      ,{8,'orig_lname'}
      ,{9,'orig_fname'}
      ,{10,'orig_mname'}
      ,{11,'orig_name_suffix'}
      ,{12,'addr_type'}
      ,{13,'addr_dual'}
      ,{14,'address_street'}
      ,{15,'address_street_Name'}
      ,{16,'address_street_type'}
      ,{17,'address_street_direction'}
      ,{18,'address_apartment'}
      ,{19,'address_city'}
      ,{20,'address_state'}
      ,{21,'address_zip'}
      ,{22,'ssn'}
      ,{23,'work_phone'}
      ,{24,'phone'}
      ,{25,'dob'}
      ,{26,'drivers_license_state_code'}
      ,{27,'drivers_license'}
      ,{28,'prim_range'}
      ,{29,'predir'}
      ,{30,'prim_name'}
      ,{31,'addr_suffix'}
      ,{32,'postdir'}
      ,{33,'unit_desig'}
      ,{34,'sec_range'}
      ,{35,'p_city_name'}
      ,{36,'v_city_name'}
      ,{37,'st'}
      ,{38,'zip'}
      ,{39,'zip4'}
      ,{40,'cart'}
      ,{41,'cr_sort_sz'}
      ,{42,'lot'}
      ,{43,'lot_order'}
      ,{44,'dbpc'}
      ,{45,'chk_digit'}
      ,{46,'rec_type'}
      ,{47,'county'}
      ,{48,'geo_lat'}
      ,{49,'geo_long'}
      ,{50,'msa'}
      ,{51,'geo_blk'}
      ,{52,'geo_match'}
      ,{53,'err_stat'}
      ,{54,'did'}
      ,{55,'title'}
      ,{56,'fname'}
      ,{57,'mname'}
      ,{58,'lname'}
      ,{59,'name_suffix'}
      ,{60,'name_score'}
      ,{61,'fdid'}
      ,{62,'hhid'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_id((SALT30.StrType)le.id),
    Fields.InValid_exchange_serial_number((SALT30.StrType)le.exchange_serial_number),
    Fields.InValid_date_added_to_exchange((SALT30.StrType)le.date_added_to_exchange),
    Fields.InValid_connect_date((SALT30.StrType)le.connect_date),
    Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen),
    Fields.InValid_record_date((SALT30.StrType)le.record_date),
    Fields.InValid_util_type((SALT30.StrType)le.util_type),
    Fields.InValid_orig_lname((SALT30.StrType)le.orig_lname),
    Fields.InValid_orig_fname((SALT30.StrType)le.orig_fname),
    Fields.InValid_orig_mname((SALT30.StrType)le.orig_mname),
    Fields.InValid_orig_name_suffix((SALT30.StrType)le.orig_name_suffix),
    Fields.InValid_addr_type((SALT30.StrType)le.addr_type),
    Fields.InValid_addr_dual((SALT30.StrType)le.addr_dual),
    Fields.InValid_address_street((SALT30.StrType)le.address_street),
    Fields.InValid_address_street_Name((SALT30.StrType)le.address_street_Name),
    Fields.InValid_address_street_type((SALT30.StrType)le.address_street_type),
    Fields.InValid_address_street_direction((SALT30.StrType)le.address_street_direction),
    Fields.InValid_address_apartment((SALT30.StrType)le.address_apartment),
    Fields.InValid_address_city((SALT30.StrType)le.address_city),
    Fields.InValid_address_state((SALT30.StrType)le.address_state),
    Fields.InValid_address_zip((SALT30.StrType)le.address_zip),
    Fields.InValid_ssn((SALT30.StrType)le.ssn),
    Fields.InValid_work_phone((SALT30.StrType)le.work_phone),
    Fields.InValid_phone((SALT30.StrType)le.phone),
    Fields.InValid_dob((SALT30.StrType)le.dob),
    Fields.InValid_drivers_license_state_code((SALT30.StrType)le.drivers_license_state_code),
    Fields.InValid_drivers_license((SALT30.StrType)le.drivers_license),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_cart((SALT30.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT30.StrType)le.lot),
    Fields.InValid_lot_order((SALT30.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT30.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_county((SALT30.StrType)le.county),
    Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT30.StrType)le.geo_long),
    Fields.InValid_msa((SALT30.StrType)le.msa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT30.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT30.StrType)le.err_stat),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT30.StrType)le.name_score),
    Fields.InValid_fdid((SALT30.StrType)le.fdid),
    Fields.InValid_hhid((SALT30.StrType)le.hhid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,62,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_num','invalid_num','invalid_date','invalid_date','invalid_date','invalid_date','invalid_utiltype','invalid_name','invalid_name','invalid_name','invalid_alphanum','invalid_addr_type','invalid_addrdual','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_zip','invalid_ssn','invalid_phone','invalid_phone','invalid_date','invalid_alpha','invalid_alphanum','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_id(TotalErrors.ErrorNum),Fields.InValidMessage_exchange_serial_number(TotalErrors.ErrorNum),Fields.InValidMessage_date_added_to_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_connect_date(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_record_date(TotalErrors.ErrorNum),Fields.InValidMessage_util_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_addr_type(TotalErrors.ErrorNum),Fields.InValidMessage_addr_dual(TotalErrors.ErrorNum),Fields.InValidMessage_address_street(TotalErrors.ErrorNum),Fields.InValidMessage_address_street_Name(TotalErrors.ErrorNum),Fields.InValidMessage_address_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_address_street_direction(TotalErrors.ErrorNum),Fields.InValidMessage_address_apartment(TotalErrors.ErrorNum),Fields.InValidMessage_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_address_state(TotalErrors.ErrorNum),Fields.InValidMessage_address_zip(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_state_code(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_fdid(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
