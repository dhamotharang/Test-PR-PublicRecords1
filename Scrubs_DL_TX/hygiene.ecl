IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_TX) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_trans_indicator_pcnt := AVE(GROUP,IF(h.trans_indicator = (TYPEOF(h.trans_indicator))'',0,100));
    maxlength_trans_indicator := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.trans_indicator)));
    avelength_trans_indicator := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.trans_indicator)),h.trans_indicator<>(typeof(h.trans_indicator))'');
    populated_card_type_pcnt := AVE(GROUP,IF(h.card_type = (TYPEOF(h.card_type))'',0,100));
    maxlength_card_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.card_type)));
    avelength_card_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.card_type)),h.card_type<>(typeof(h.card_type))'');
    populated_dl_number_pcnt := AVE(GROUP,IF(h.dl_number = (TYPEOF(h.dl_number))'',0,100));
    maxlength_dl_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dl_number)));
    avelength_dl_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dl_number)),h.dl_number<>(typeof(h.dl_number))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_suffix_name_pcnt := AVE(GROUP,IF(h.suffix_name = (TYPEOF(h.suffix_name))'',0,100));
    maxlength_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix_name)));
    avelength_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix_name)),h.suffix_name<>(typeof(h.suffix_name))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_street_addr1_pcnt := AVE(GROUP,IF(h.street_addr1 = (TYPEOF(h.street_addr1))'',0,100));
    maxlength_street_addr1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.street_addr1)));
    avelength_street_addr1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.street_addr1)),h.street_addr1<>(typeof(h.street_addr1))'');
    populated_street_addr2_pcnt := AVE(GROUP,IF(h.street_addr2 = (TYPEOF(h.street_addr2))'',0,100));
    maxlength_street_addr2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.street_addr2)));
    avelength_street_addr2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.street_addr2)),h.street_addr2<>(typeof(h.street_addr2))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_in_state_pcnt := AVE(GROUP,IF(h.in_state = (TYPEOF(h.in_state))'',0,100));
    maxlength_in_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.in_state)));
    avelength_in_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.in_state)),h.in_state<>(typeof(h.in_state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_in_zip4_pcnt := AVE(GROUP,IF(h.in_zip4 = (TYPEOF(h.in_zip4))'',0,100));
    maxlength_in_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.in_zip4)));
    avelength_in_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.in_zip4)),h.in_zip4<>(typeof(h.in_zip4))'');
    populated_issue_date_pcnt := AVE(GROUP,IF(h.issue_date = (TYPEOF(h.issue_date))'',0,100));
    maxlength_issue_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.issue_date)));
    avelength_issue_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.issue_date)),h.issue_date<>(typeof(h.issue_date))'');
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
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
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
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_trans_indicator_pcnt *   0.00 / 100 + T.Populated_card_type_pcnt *   0.00 / 100 + T.Populated_dl_number_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_suffix_name_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_street_addr1_pcnt *   0.00 / 100 + T.Populated_street_addr2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_in_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_in_zip4_pcnt *   0.00 / 100 + T.Populated_issue_date_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','trans_indicator','card_type','dl_number','last_name','first_name','middle_name','suffix_name','date_of_birth','street_addr1','street_addr2','city','in_state','zip','in_zip4','issue_date','title','fname','mname','lname','suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_trans_indicator_pcnt,le.populated_card_type_pcnt,le.populated_dl_number_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_suffix_name_pcnt,le.populated_date_of_birth_pcnt,le.populated_street_addr1_pcnt,le.populated_street_addr2_pcnt,le.populated_city_pcnt,le.populated_in_state_pcnt,le.populated_zip_pcnt,le.populated_in_zip4_pcnt,le.populated_issue_date_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_trans_indicator,le.maxlength_card_type,le.maxlength_dl_number,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_suffix_name,le.maxlength_date_of_birth,le.maxlength_street_addr1,le.maxlength_street_addr2,le.maxlength_city,le.maxlength_in_state,le.maxlength_zip,le.maxlength_in_zip4,le.maxlength_issue_date,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_state,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_trans_indicator,le.avelength_card_type,le.avelength_dl_number,le.avelength_last_name,le.avelength_first_name,le.avelength_middle_name,le.avelength_suffix_name,le.avelength_date_of_birth,le.avelength_street_addr1,le.avelength_street_addr2,le.avelength_city,le.avelength_in_state,le.avelength_zip,le.avelength_in_zip4,le.avelength_issue_date,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_state,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 49, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.trans_indicator),TRIM((SALT35.StrType)le.card_type),TRIM((SALT35.StrType)le.dl_number),TRIM((SALT35.StrType)le.last_name),TRIM((SALT35.StrType)le.first_name),TRIM((SALT35.StrType)le.middle_name),TRIM((SALT35.StrType)le.suffix_name),TRIM((SALT35.StrType)le.date_of_birth),TRIM((SALT35.StrType)le.street_addr1),TRIM((SALT35.StrType)le.street_addr2),TRIM((SALT35.StrType)le.city),TRIM((SALT35.StrType)le.in_state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.in_zip4),TRIM((SALT35.StrType)le.issue_date),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.name_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip5),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,49,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 49);
  SELF.FldNo2 := 1 + (C % 49);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.trans_indicator),TRIM((SALT35.StrType)le.card_type),TRIM((SALT35.StrType)le.dl_number),TRIM((SALT35.StrType)le.last_name),TRIM((SALT35.StrType)le.first_name),TRIM((SALT35.StrType)le.middle_name),TRIM((SALT35.StrType)le.suffix_name),TRIM((SALT35.StrType)le.date_of_birth),TRIM((SALT35.StrType)le.street_addr1),TRIM((SALT35.StrType)le.street_addr2),TRIM((SALT35.StrType)le.city),TRIM((SALT35.StrType)le.in_state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.in_zip4),TRIM((SALT35.StrType)le.issue_date),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.name_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip5),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.trans_indicator),TRIM((SALT35.StrType)le.card_type),TRIM((SALT35.StrType)le.dl_number),TRIM((SALT35.StrType)le.last_name),TRIM((SALT35.StrType)le.first_name),TRIM((SALT35.StrType)le.middle_name),TRIM((SALT35.StrType)le.suffix_name),TRIM((SALT35.StrType)le.date_of_birth),TRIM((SALT35.StrType)le.street_addr1),TRIM((SALT35.StrType)le.street_addr2),TRIM((SALT35.StrType)le.city),TRIM((SALT35.StrType)le.in_state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.in_zip4),TRIM((SALT35.StrType)le.issue_date),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.name_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip5),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),49*49,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'trans_indicator'}
      ,{3,'card_type'}
      ,{4,'dl_number'}
      ,{5,'last_name'}
      ,{6,'first_name'}
      ,{7,'middle_name'}
      ,{8,'suffix_name'}
      ,{9,'date_of_birth'}
      ,{10,'street_addr1'}
      ,{11,'street_addr2'}
      ,{12,'city'}
      ,{13,'in_state'}
      ,{14,'zip'}
      ,{15,'in_zip4'}
      ,{16,'issue_date'}
      ,{17,'title'}
      ,{18,'fname'}
      ,{19,'mname'}
      ,{20,'lname'}
      ,{21,'suffix'}
      ,{22,'name_score'}
      ,{23,'prim_range'}
      ,{24,'predir'}
      ,{25,'prim_name'}
      ,{26,'addr_suffix'}
      ,{27,'postdir'}
      ,{28,'unit_desig'}
      ,{29,'sec_range'}
      ,{30,'p_city_name'}
      ,{31,'v_city_name'}
      ,{32,'state'}
      ,{33,'zip5'}
      ,{34,'zip4'}
      ,{35,'cart'}
      ,{36,'cr_sort_sz'}
      ,{37,'lot'}
      ,{38,'lot_order'}
      ,{39,'dpbc'}
      ,{40,'chk_digit'}
      ,{41,'rec_type'}
      ,{42,'ace_fips_st'}
      ,{43,'county'}
      ,{44,'geo_lat'}
      ,{45,'geo_long'}
      ,{46,'msa'}
      ,{47,'geo_blk'}
      ,{48,'geo_match'}
      ,{49,'err_stat'}],SALT35.MAC_Character_Counts.Field_Identification);
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
    Fields.InValid_trans_indicator((SALT35.StrType)le.trans_indicator),
    Fields.InValid_card_type((SALT35.StrType)le.card_type),
    Fields.InValid_dl_number((SALT35.StrType)le.dl_number),
    Fields.InValid_last_name((SALT35.StrType)le.last_name,(SALT35.StrType)le.first_name,(SALT35.StrType)le.middle_name),
    Fields.InValid_first_name((SALT35.StrType)le.first_name),
    Fields.InValid_middle_name((SALT35.StrType)le.middle_name),
    Fields.InValid_suffix_name((SALT35.StrType)le.suffix_name),
    Fields.InValid_date_of_birth((SALT35.StrType)le.date_of_birth),
    Fields.InValid_street_addr1((SALT35.StrType)le.street_addr1),
    Fields.InValid_street_addr2((SALT35.StrType)le.street_addr2),
    Fields.InValid_city((SALT35.StrType)le.city),
    Fields.InValid_in_state((SALT35.StrType)le.in_state),
    Fields.InValid_zip((SALT35.StrType)le.zip),
    Fields.InValid_in_zip4((SALT35.StrType)le.in_zip4),
    Fields.InValid_issue_date((SALT35.StrType)le.issue_date),
    Fields.InValid_title((SALT35.StrType)le.title),
    Fields.InValid_fname((SALT35.StrType)le.fname),
    Fields.InValid_mname((SALT35.StrType)le.mname),
    Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname),
    Fields.InValid_suffix((SALT35.StrType)le.suffix),
    Fields.InValid_name_score((SALT35.StrType)le.name_score),
    Fields.InValid_prim_range((SALT35.StrType)le.prim_range),
    Fields.InValid_predir((SALT35.StrType)le.predir),
    Fields.InValid_prim_name((SALT35.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT35.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT35.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT35.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT35.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name),
    Fields.InValid_state((SALT35.StrType)le.state),
    Fields.InValid_zip5((SALT35.StrType)le.zip5),
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
Errors := NORMALIZE(h,49,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_trans_indicator','invalid_card_type','invalid_dl_number','invalid_name','Unknown','Unknown','Unknown','invalid_past_date','invalid_mandatory','Unknown','invalid_alpha_num','invalid_state','invalid_zip','invalid_zip4','invalid_date','Unknown','Unknown','Unknown','invalid_name2','Unknown','invalid_numeric','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_trans_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_card_type(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_street_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_street_addr2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_in_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_in_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
