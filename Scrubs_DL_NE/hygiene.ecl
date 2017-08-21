IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_NE) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_dln_pcnt := AVE(GROUP,IF(h.dln = (TYPEOF(h.dln))'',0,100));
    maxlength_dln := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dln)));
    avelength_dln := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dln)),h.dln<>(typeof(h.dln))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_address_street_pcnt := AVE(GROUP,IF(h.address_street = (TYPEOF(h.address_street))'',0,100));
    maxlength_address_street := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_street)));
    avelength_address_street := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_street)),h.address_street<>(typeof(h.address_street))'');
    populated_address_city_pcnt := AVE(GROUP,IF(h.address_city = (TYPEOF(h.address_city))'',0,100));
    maxlength_address_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_city)));
    avelength_address_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_city)),h.address_city<>(typeof(h.address_city))'');
    populated_address_state_pcnt := AVE(GROUP,IF(h.address_state = (TYPEOF(h.address_state))'',0,100));
    maxlength_address_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_state)));
    avelength_address_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_state)),h.address_state<>(typeof(h.address_state))'');
    populated_address_zip5_pcnt := AVE(GROUP,IF(h.address_zip5 = (TYPEOF(h.address_zip5))'',0,100));
    maxlength_address_zip5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_zip5)));
    avelength_address_zip5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_zip5)),h.address_zip5<>(typeof(h.address_zip5))'');
    populated_address_zip4_pcnt := AVE(GROUP,IF(h.address_zip4 = (TYPEOF(h.address_zip4))'',0,100));
    maxlength_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_zip4)));
    avelength_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.address_zip4)),h.address_zip4<>(typeof(h.address_zip4))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_eye_color_pcnt := AVE(GROUP,IF(h.eye_color = (TYPEOF(h.eye_color))'',0,100));
    maxlength_eye_color := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.eye_color)));
    avelength_eye_color := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.eye_color)),h.eye_color<>(typeof(h.eye_color))'');
    populated_hair_color_pcnt := AVE(GROUP,IF(h.hair_color = (TYPEOF(h.hair_color))'',0,100));
    maxlength_hair_color := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.hair_color)));
    avelength_hair_color := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.hair_color)),h.hair_color<>(typeof(h.hair_color))'');
    populated_license_type_pcnt := AVE(GROUP,IF(h.license_type = (TYPEOF(h.license_type))'',0,100));
    maxlength_license_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.license_type)));
    avelength_license_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.license_type)),h.license_type<>(typeof(h.license_type))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_cleaning_score_pcnt := AVE(GROUP,IF(h.cleaning_score = (TYPEOF(h.cleaning_score))'',0,100));
    maxlength_cleaning_score := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cleaning_score)));
    avelength_cleaning_score := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cleaning_score)),h.cleaning_score<>(typeof(h.cleaning_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dln_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_address_street_pcnt *   0.00 / 100 + T.Populated_address_city_pcnt *   0.00 / 100 + T.Populated_address_state_pcnt *   0.00 / 100 + T.Populated_address_zip5_pcnt *   0.00 / 100 + T.Populated_address_zip4_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_eye_color_pcnt *   0.00 / 100 + T.Populated_hair_color_pcnt *   0.00 / 100 + T.Populated_license_type_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_cleaning_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT35.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','dln','name','dob','address_street','address_city','address_state','address_zip5','address_zip4','gender','height','weight','eye_color','hair_color','license_type','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_dln_pcnt,le.populated_name_pcnt,le.populated_dob_pcnt,le.populated_address_street_pcnt,le.populated_address_city_pcnt,le.populated_address_state_pcnt,le.populated_address_zip5_pcnt,le.populated_address_zip4_pcnt,le.populated_gender_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_eye_color_pcnt,le.populated_hair_color_pcnt,le.populated_license_type_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_cleaning_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_dln,le.maxlength_name,le.maxlength_dob,le.maxlength_address_street,le.maxlength_address_city,le.maxlength_address_state,le.maxlength_address_zip5,le.maxlength_address_zip4,le.maxlength_gender,le.maxlength_height,le.maxlength_weight,le.maxlength_eye_color,le.maxlength_hair_color,le.maxlength_license_type,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_cleaning_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_dln,le.avelength_name,le.avelength_dob,le.avelength_address_street,le.avelength_address_city,le.avelength_address_state,le.avelength_address_zip5,le.avelength_address_zip4,le.avelength_gender,le.avelength_height,le.avelength_weight,le.avelength_eye_color,le.avelength_hair_color,le.avelength_license_type,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_cleaning_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 48, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.dln),TRIM((SALT35.StrType)le.name),TRIM((SALT35.StrType)le.dob),TRIM((SALT35.StrType)le.address_street),TRIM((SALT35.StrType)le.address_city),TRIM((SALT35.StrType)le.address_state),TRIM((SALT35.StrType)le.address_zip5),TRIM((SALT35.StrType)le.address_zip4),TRIM((SALT35.StrType)le.gender),TRIM((SALT35.StrType)le.height),TRIM((SALT35.StrType)le.weight),TRIM((SALT35.StrType)le.eye_color),TRIM((SALT35.StrType)le.hair_color),TRIM((SALT35.StrType)le.license_type),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.cleaning_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,48,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 48);
  SELF.FldNo2 := 1 + (C % 48);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.dln),TRIM((SALT35.StrType)le.name),TRIM((SALT35.StrType)le.dob),TRIM((SALT35.StrType)le.address_street),TRIM((SALT35.StrType)le.address_city),TRIM((SALT35.StrType)le.address_state),TRIM((SALT35.StrType)le.address_zip5),TRIM((SALT35.StrType)le.address_zip4),TRIM((SALT35.StrType)le.gender),TRIM((SALT35.StrType)le.height),TRIM((SALT35.StrType)le.weight),TRIM((SALT35.StrType)le.eye_color),TRIM((SALT35.StrType)le.hair_color),TRIM((SALT35.StrType)le.license_type),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.cleaning_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.dln),TRIM((SALT35.StrType)le.name),TRIM((SALT35.StrType)le.dob),TRIM((SALT35.StrType)le.address_street),TRIM((SALT35.StrType)le.address_city),TRIM((SALT35.StrType)le.address_state),TRIM((SALT35.StrType)le.address_zip5),TRIM((SALT35.StrType)le.address_zip4),TRIM((SALT35.StrType)le.gender),TRIM((SALT35.StrType)le.height),TRIM((SALT35.StrType)le.weight),TRIM((SALT35.StrType)le.eye_color),TRIM((SALT35.StrType)le.hair_color),TRIM((SALT35.StrType)le.license_type),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.cleaning_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),48*48,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'dln'}
      ,{3,'name'}
      ,{4,'dob'}
      ,{5,'address_street'}
      ,{6,'address_city'}
      ,{7,'address_state'}
      ,{8,'address_zip5'}
      ,{9,'address_zip4'}
      ,{10,'gender'}
      ,{11,'height'}
      ,{12,'weight'}
      ,{13,'eye_color'}
      ,{14,'hair_color'}
      ,{15,'license_type'}
      ,{16,'title'}
      ,{17,'fname'}
      ,{18,'mname'}
      ,{19,'lname'}
      ,{20,'name_suffix'}
      ,{21,'cleaning_score'}
      ,{22,'prim_range'}
      ,{23,'predir'}
      ,{24,'prim_name'}
      ,{25,'suffix'}
      ,{26,'postdir'}
      ,{27,'unit_desig'}
      ,{28,'sec_range'}
      ,{29,'p_city_name'}
      ,{30,'v_city_name'}
      ,{31,'state'}
      ,{32,'zip'}
      ,{33,'zip4'}
      ,{34,'cart'}
      ,{35,'cr_sort_sz'}
      ,{36,'lot'}
      ,{37,'lot_order'}
      ,{38,'dpbc'}
      ,{39,'chk_digit'}
      ,{40,'rec_type'}
      ,{41,'ace_fips_st'}
      ,{42,'county'}
      ,{43,'geo_lat'}
      ,{44,'geo_long'}
      ,{45,'msa'}
      ,{46,'geo_blk'}
      ,{47,'geo_match'}
      ,{48,'err_stat'}],SALT35.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT35.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT35.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT35.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT35.StrType)le.process_date),
    Fields.InValid_dln((SALT35.StrType)le.dln),
    Fields.InValid_name((SALT35.StrType)le.name),
    Fields.InValid_dob((SALT35.StrType)le.dob),
    Fields.InValid_address_street((SALT35.StrType)le.address_street),
    Fields.InValid_address_city((SALT35.StrType)le.address_city),
    Fields.InValid_address_state((SALT35.StrType)le.address_state),
    Fields.InValid_address_zip5((SALT35.StrType)le.address_zip5),
    Fields.InValid_address_zip4((SALT35.StrType)le.address_zip4),
    Fields.InValid_gender((SALT35.StrType)le.gender),
    Fields.InValid_height((SALT35.StrType)le.height),
    Fields.InValid_weight((SALT35.StrType)le.weight),
    Fields.InValid_eye_color((SALT35.StrType)le.eye_color),
    Fields.InValid_hair_color((SALT35.StrType)le.hair_color),
    Fields.InValid_license_type((SALT35.StrType)le.license_type),
    Fields.InValid_title((SALT35.StrType)le.title),
    Fields.InValid_fname((SALT35.StrType)le.fname),
    Fields.InValid_mname((SALT35.StrType)le.mname),
    Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname),
    Fields.InValid_name_suffix((SALT35.StrType)le.name_suffix),
    Fields.InValid_cleaning_score((SALT35.StrType)le.cleaning_score),
    Fields.InValid_prim_range((SALT35.StrType)le.prim_range),
    Fields.InValid_predir((SALT35.StrType)le.predir),
    Fields.InValid_prim_name((SALT35.StrType)le.prim_name),
    Fields.InValid_suffix((SALT35.StrType)le.suffix),
    Fields.InValid_postdir((SALT35.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT35.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT35.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name),
    Fields.InValid_state((SALT35.StrType)le.state),
    Fields.InValid_zip((SALT35.StrType)le.zip),
    Fields.InValid_zip4((SALT35.StrType)le.zip4),
    Fields.InValid_cart((SALT35.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT35.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT35.StrType)le.lot),
    Fields.InValid_lot_order((SALT35.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT35.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT35.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT35.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT35.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT35.StrType)le.county),
    Fields.InValid_geo_lat((SALT35.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT35.StrType)le.geo_long),
    Fields.InValid_msa((SALT35.StrType)le.msa),
    Fields.InValid_geo_blk((SALT35.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT35.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT35.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,48,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_dln','invalid_mandatory','invalid_8pastdate','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_zip4','invalid_gender','invalid_height','invalid_weight','invalid_eye_color','invalid_hair_color','invalid_license_type','Unknown','Unknown','Unknown','invalid_name','Unknown','invalid_numeric','Unknown','invalid_direction','Unknown','invalid_alpha_specials','invalid_direction','Unknown','Unknown','invalid_alpha_specials','invalid_alpha_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dln(TotalErrors.ErrorNum),Fields.InValidMessage_name(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_address_street(TotalErrors.ErrorNum),Fields.InValidMessage_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_address_state(TotalErrors.ErrorNum),Fields.InValidMessage_address_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_address_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_weight(TotalErrors.ErrorNum),Fields.InValidMessage_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_hair_color(TotalErrors.ErrorNum),Fields.InValidMessage_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cleaning_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
