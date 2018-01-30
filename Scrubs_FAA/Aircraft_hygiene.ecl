IMPORT SALT38,STD;
EXPORT Aircraft_hygiene(dataset(Aircraft_layout_FAA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_d_score_cnt := COUNT(GROUP,h.d_score <> (TYPEOF(h.d_score))'');
    populated_d_score_pcnt := AVE(GROUP,IF(h.d_score = (TYPEOF(h.d_score))'',0,100));
    maxlength_d_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.d_score)));
    avelength_d_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.d_score)),h.d_score<>(typeof(h.d_score))'');
    populated_best_ssn_cnt := COUNT(GROUP,h.best_ssn <> (TYPEOF(h.best_ssn))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_did_out_cnt := COUNT(GROUP,h.did_out <> (TYPEOF(h.did_out))'');
    populated_did_out_pcnt := AVE(GROUP,IF(h.did_out = (TYPEOF(h.did_out))'',0,100));
    maxlength_did_out := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_out)));
    avelength_did_out := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_out)),h.did_out<>(typeof(h.did_out))'');
    populated_bdid_out_cnt := COUNT(GROUP,h.bdid_out <> (TYPEOF(h.bdid_out))'');
    populated_bdid_out_pcnt := AVE(GROUP,IF(h.bdid_out = (TYPEOF(h.bdid_out))'',0,100));
    maxlength_bdid_out := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid_out)));
    avelength_bdid_out := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid_out)),h.bdid_out<>(typeof(h.bdid_out))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_current_flag_cnt := COUNT(GROUP,h.current_flag <> (TYPEOF(h.current_flag))'');
    populated_current_flag_pcnt := AVE(GROUP,IF(h.current_flag = (TYPEOF(h.current_flag))'',0,100));
    maxlength_current_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.current_flag)));
    avelength_current_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.current_flag)),h.current_flag<>(typeof(h.current_flag))'');
    populated_n_number_cnt := COUNT(GROUP,h.n_number <> (TYPEOF(h.n_number))'');
    populated_n_number_pcnt := AVE(GROUP,IF(h.n_number = (TYPEOF(h.n_number))'',0,100));
    maxlength_n_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.n_number)));
    avelength_n_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.n_number)),h.n_number<>(typeof(h.n_number))'');
    populated_serial_number_cnt := COUNT(GROUP,h.serial_number <> (TYPEOF(h.serial_number))'');
    populated_serial_number_pcnt := AVE(GROUP,IF(h.serial_number = (TYPEOF(h.serial_number))'',0,100));
    maxlength_serial_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.serial_number)));
    avelength_serial_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.serial_number)),h.serial_number<>(typeof(h.serial_number))'');
    populated_mfr_mdl_code_cnt := COUNT(GROUP,h.mfr_mdl_code <> (TYPEOF(h.mfr_mdl_code))'');
    populated_mfr_mdl_code_pcnt := AVE(GROUP,IF(h.mfr_mdl_code = (TYPEOF(h.mfr_mdl_code))'',0,100));
    maxlength_mfr_mdl_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mfr_mdl_code)));
    avelength_mfr_mdl_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mfr_mdl_code)),h.mfr_mdl_code<>(typeof(h.mfr_mdl_code))'');
    populated_eng_mfr_mdl_cnt := COUNT(GROUP,h.eng_mfr_mdl <> (TYPEOF(h.eng_mfr_mdl))'');
    populated_eng_mfr_mdl_pcnt := AVE(GROUP,IF(h.eng_mfr_mdl = (TYPEOF(h.eng_mfr_mdl))'',0,100));
    maxlength_eng_mfr_mdl := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.eng_mfr_mdl)));
    avelength_eng_mfr_mdl := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.eng_mfr_mdl)),h.eng_mfr_mdl<>(typeof(h.eng_mfr_mdl))'');
    populated_year_mfr_cnt := COUNT(GROUP,h.year_mfr <> (TYPEOF(h.year_mfr))'');
    populated_year_mfr_pcnt := AVE(GROUP,IF(h.year_mfr = (TYPEOF(h.year_mfr))'',0,100));
    maxlength_year_mfr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_mfr)));
    avelength_year_mfr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_mfr)),h.year_mfr<>(typeof(h.year_mfr))'');
    populated_type_registrant_cnt := COUNT(GROUP,h.type_registrant <> (TYPEOF(h.type_registrant))'');
    populated_type_registrant_pcnt := AVE(GROUP,IF(h.type_registrant = (TYPEOF(h.type_registrant))'',0,100));
    maxlength_type_registrant := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_registrant)));
    avelength_type_registrant := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_registrant)),h.type_registrant<>(typeof(h.type_registrant))'');
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_street_cnt := COUNT(GROUP,h.street <> (TYPEOF(h.street))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_street2_cnt := COUNT(GROUP,h.street2 <> (TYPEOF(h.street2))'');
    populated_street2_pcnt := AVE(GROUP,IF(h.street2 = (TYPEOF(h.street2))'',0,100));
    maxlength_street2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street2)));
    avelength_street2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street2)),h.street2<>(typeof(h.street2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_region_cnt := COUNT(GROUP,h.region <> (TYPEOF(h.region))'');
    populated_region_pcnt := AVE(GROUP,IF(h.region = (TYPEOF(h.region))'',0,100));
    maxlength_region := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.region)));
    avelength_region := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.region)),h.region<>(typeof(h.region))'');
    populated_orig_county_cnt := COUNT(GROUP,h.orig_county <> (TYPEOF(h.orig_county))'');
    populated_orig_county_pcnt := AVE(GROUP,IF(h.orig_county = (TYPEOF(h.orig_county))'',0,100));
    maxlength_orig_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_county)));
    avelength_orig_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_county)),h.orig_county<>(typeof(h.orig_county))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_last_action_date_cnt := COUNT(GROUP,h.last_action_date <> (TYPEOF(h.last_action_date))'');
    populated_last_action_date_pcnt := AVE(GROUP,IF(h.last_action_date = (TYPEOF(h.last_action_date))'',0,100));
    maxlength_last_action_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_action_date)));
    avelength_last_action_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_action_date)),h.last_action_date<>(typeof(h.last_action_date))'');
    populated_cert_issue_date_cnt := COUNT(GROUP,h.cert_issue_date <> (TYPEOF(h.cert_issue_date))'');
    populated_cert_issue_date_pcnt := AVE(GROUP,IF(h.cert_issue_date = (TYPEOF(h.cert_issue_date))'',0,100));
    maxlength_cert_issue_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cert_issue_date)));
    avelength_cert_issue_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cert_issue_date)),h.cert_issue_date<>(typeof(h.cert_issue_date))'');
    populated_certification_cnt := COUNT(GROUP,h.certification <> (TYPEOF(h.certification))'');
    populated_certification_pcnt := AVE(GROUP,IF(h.certification = (TYPEOF(h.certification))'',0,100));
    maxlength_certification := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.certification)));
    avelength_certification := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.certification)),h.certification<>(typeof(h.certification))'');
    populated_type_aircraft_cnt := COUNT(GROUP,h.type_aircraft <> (TYPEOF(h.type_aircraft))'');
    populated_type_aircraft_pcnt := AVE(GROUP,IF(h.type_aircraft = (TYPEOF(h.type_aircraft))'',0,100));
    maxlength_type_aircraft := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_aircraft)));
    avelength_type_aircraft := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_aircraft)),h.type_aircraft<>(typeof(h.type_aircraft))'');
    populated_type_engine_cnt := COUNT(GROUP,h.type_engine <> (TYPEOF(h.type_engine))'');
    populated_type_engine_pcnt := AVE(GROUP,IF(h.type_engine = (TYPEOF(h.type_engine))'',0,100));
    maxlength_type_engine := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_engine)));
    avelength_type_engine := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.type_engine)),h.type_engine<>(typeof(h.type_engine))'');
    populated_status_code_cnt := COUNT(GROUP,h.status_code <> (TYPEOF(h.status_code))'');
    populated_status_code_pcnt := AVE(GROUP,IF(h.status_code = (TYPEOF(h.status_code))'',0,100));
    maxlength_status_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.status_code)));
    avelength_status_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.status_code)),h.status_code<>(typeof(h.status_code))'');
    populated_mode_s_code_cnt := COUNT(GROUP,h.mode_s_code <> (TYPEOF(h.mode_s_code))'');
    populated_mode_s_code_pcnt := AVE(GROUP,IF(h.mode_s_code = (TYPEOF(h.mode_s_code))'',0,100));
    maxlength_mode_s_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mode_s_code)));
    avelength_mode_s_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mode_s_code)),h.mode_s_code<>(typeof(h.mode_s_code))'');
    populated_fract_owner_cnt := COUNT(GROUP,h.fract_owner <> (TYPEOF(h.fract_owner))'');
    populated_fract_owner_pcnt := AVE(GROUP,IF(h.fract_owner = (TYPEOF(h.fract_owner))'',0,100));
    maxlength_fract_owner := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fract_owner)));
    avelength_fract_owner := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fract_owner)),h.fract_owner<>(typeof(h.fract_owner))'');
    populated_aircraft_mfr_name_cnt := COUNT(GROUP,h.aircraft_mfr_name <> (TYPEOF(h.aircraft_mfr_name))'');
    populated_aircraft_mfr_name_pcnt := AVE(GROUP,IF(h.aircraft_mfr_name = (TYPEOF(h.aircraft_mfr_name))'',0,100));
    maxlength_aircraft_mfr_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.aircraft_mfr_name)));
    avelength_aircraft_mfr_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.aircraft_mfr_name)),h.aircraft_mfr_name<>(typeof(h.aircraft_mfr_name))'');
    populated_model_name_cnt := COUNT(GROUP,h.model_name <> (TYPEOF(h.model_name))'');
    populated_model_name_pcnt := AVE(GROUP,IF(h.model_name = (TYPEOF(h.model_name))'',0,100));
    maxlength_model_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_name)));
    avelength_model_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.model_name)),h.model_name<>(typeof(h.model_name))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_z4_cnt := COUNT(GROUP,h.z4 <> (TYPEOF(h.z4))'');
    populated_z4_pcnt := AVE(GROUP,IF(h.z4 = (TYPEOF(h.z4))'',0,100));
    maxlength_z4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.z4)));
    avelength_z4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.z4)),h.z4<>(typeof(h.z4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_compname_cnt := COUNT(GROUP,h.compname <> (TYPEOF(h.compname))'');
    populated_compname_pcnt := AVE(GROUP,IF(h.compname = (TYPEOF(h.compname))'',0,100));
    maxlength_compname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.compname)));
    avelength_compname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.compname)),h.compname<>(typeof(h.compname))'');
    populated_lf_cnt := COUNT(GROUP,h.lf <> (TYPEOF(h.lf))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_d_score_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_did_out_pcnt *   0.00 / 100 + T.Populated_bdid_out_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_current_flag_pcnt *   0.00 / 100 + T.Populated_n_number_pcnt *   0.00 / 100 + T.Populated_serial_number_pcnt *   0.00 / 100 + T.Populated_mfr_mdl_code_pcnt *   0.00 / 100 + T.Populated_eng_mfr_mdl_pcnt *   0.00 / 100 + T.Populated_year_mfr_pcnt *   0.00 / 100 + T.Populated_type_registrant_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_street2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_region_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_last_action_date_pcnt *   0.00 / 100 + T.Populated_cert_issue_date_pcnt *   0.00 / 100 + T.Populated_certification_pcnt *   0.00 / 100 + T.Populated_type_aircraft_pcnt *   0.00 / 100 + T.Populated_type_engine_pcnt *   0.00 / 100 + T.Populated_status_code_pcnt *   0.00 / 100 + T.Populated_mode_s_code_pcnt *   0.00 / 100 + T.Populated_fract_owner_pcnt *   0.00 / 100 + T.Populated_aircraft_mfr_name_pcnt *   0.00 / 100 + T.Populated_model_name_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_z4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_compname_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'d_score','best_ssn','did_out','bdid_out','date_first_seen','date_last_seen','current_flag','n_number','serial_number','mfr_mdl_code','eng_mfr_mdl','year_mfr','type_registrant','name','street','street2','city','state','zip_code','region','orig_county','country','last_action_date','cert_issue_date','certification','type_aircraft','type_engine','status_code','mode_s_code','fract_owner','aircraft_mfr_name','model_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','z4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','compname','lf','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_d_score_pcnt,le.populated_best_ssn_pcnt,le.populated_did_out_pcnt,le.populated_bdid_out_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_current_flag_pcnt,le.populated_n_number_pcnt,le.populated_serial_number_pcnt,le.populated_mfr_mdl_code_pcnt,le.populated_eng_mfr_mdl_pcnt,le.populated_year_mfr_pcnt,le.populated_type_registrant_pcnt,le.populated_name_pcnt,le.populated_street_pcnt,le.populated_street2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_region_pcnt,le.populated_orig_county_pcnt,le.populated_country_pcnt,le.populated_last_action_date_pcnt,le.populated_cert_issue_date_pcnt,le.populated_certification_pcnt,le.populated_type_aircraft_pcnt,le.populated_type_engine_pcnt,le.populated_status_code_pcnt,le.populated_mode_s_code_pcnt,le.populated_fract_owner_pcnt,le.populated_aircraft_mfr_name_pcnt,le.populated_model_name_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_z4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_compname_pcnt,le.populated_lf_pcnt,le.populated_source_rec_id_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_d_score,le.maxlength_best_ssn,le.maxlength_did_out,le.maxlength_bdid_out,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_current_flag,le.maxlength_n_number,le.maxlength_serial_number,le.maxlength_mfr_mdl_code,le.maxlength_eng_mfr_mdl,le.maxlength_year_mfr,le.maxlength_type_registrant,le.maxlength_name,le.maxlength_street,le.maxlength_street2,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_region,le.maxlength_orig_county,le.maxlength_country,le.maxlength_last_action_date,le.maxlength_cert_issue_date,le.maxlength_certification,le.maxlength_type_aircraft,le.maxlength_type_engine,le.maxlength_status_code,le.maxlength_mode_s_code,le.maxlength_fract_owner,le.maxlength_aircraft_mfr_name,le.maxlength_model_name,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_z4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_compname,le.maxlength_lf,le.maxlength_source_rec_id,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_d_score,le.avelength_best_ssn,le.avelength_did_out,le.avelength_bdid_out,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_current_flag,le.avelength_n_number,le.avelength_serial_number,le.avelength_mfr_mdl_code,le.avelength_eng_mfr_mdl,le.avelength_year_mfr,le.avelength_type_registrant,le.avelength_name,le.avelength_street,le.avelength_street2,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_region,le.avelength_orig_county,le.avelength_country,le.avelength_last_action_date,le.avelength_cert_issue_date,le.avelength_certification,le.avelength_type_aircraft,le.avelength_type_engine,le.avelength_status_code,le.avelength_mode_s_code,le.avelength_fract_owner,le.avelength_aircraft_mfr_name,le.avelength_model_name,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_z4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_compname,le.avelength_lf,le.avelength_source_rec_id,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 88, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.d_score),TRIM((SALT38.StrType)le.best_ssn),TRIM((SALT38.StrType)le.did_out),TRIM((SALT38.StrType)le.bdid_out),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.n_number),TRIM((SALT38.StrType)le.serial_number),TRIM((SALT38.StrType)le.mfr_mdl_code),TRIM((SALT38.StrType)le.eng_mfr_mdl),TRIM((SALT38.StrType)le.year_mfr),TRIM((SALT38.StrType)le.type_registrant),TRIM((SALT38.StrType)le.name),TRIM((SALT38.StrType)le.street),TRIM((SALT38.StrType)le.street2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.region),TRIM((SALT38.StrType)le.orig_county),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.last_action_date),TRIM((SALT38.StrType)le.cert_issue_date),TRIM((SALT38.StrType)le.certification),TRIM((SALT38.StrType)le.type_aircraft),TRIM((SALT38.StrType)le.type_engine),TRIM((SALT38.StrType)le.status_code),TRIM((SALT38.StrType)le.mode_s_code),TRIM((SALT38.StrType)le.fract_owner),TRIM((SALT38.StrType)le.aircraft_mfr_name),TRIM((SALT38.StrType)le.model_name),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.z4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.compname),TRIM((SALT38.StrType)le.lf),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,88,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 88);
  SELF.FldNo2 := 1 + (C % 88);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.d_score),TRIM((SALT38.StrType)le.best_ssn),TRIM((SALT38.StrType)le.did_out),TRIM((SALT38.StrType)le.bdid_out),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.n_number),TRIM((SALT38.StrType)le.serial_number),TRIM((SALT38.StrType)le.mfr_mdl_code),TRIM((SALT38.StrType)le.eng_mfr_mdl),TRIM((SALT38.StrType)le.year_mfr),TRIM((SALT38.StrType)le.type_registrant),TRIM((SALT38.StrType)le.name),TRIM((SALT38.StrType)le.street),TRIM((SALT38.StrType)le.street2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.region),TRIM((SALT38.StrType)le.orig_county),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.last_action_date),TRIM((SALT38.StrType)le.cert_issue_date),TRIM((SALT38.StrType)le.certification),TRIM((SALT38.StrType)le.type_aircraft),TRIM((SALT38.StrType)le.type_engine),TRIM((SALT38.StrType)le.status_code),TRIM((SALT38.StrType)le.mode_s_code),TRIM((SALT38.StrType)le.fract_owner),TRIM((SALT38.StrType)le.aircraft_mfr_name),TRIM((SALT38.StrType)le.model_name),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.z4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.compname),TRIM((SALT38.StrType)le.lf),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.d_score),TRIM((SALT38.StrType)le.best_ssn),TRIM((SALT38.StrType)le.did_out),TRIM((SALT38.StrType)le.bdid_out),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.n_number),TRIM((SALT38.StrType)le.serial_number),TRIM((SALT38.StrType)le.mfr_mdl_code),TRIM((SALT38.StrType)le.eng_mfr_mdl),TRIM((SALT38.StrType)le.year_mfr),TRIM((SALT38.StrType)le.type_registrant),TRIM((SALT38.StrType)le.name),TRIM((SALT38.StrType)le.street),TRIM((SALT38.StrType)le.street2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.region),TRIM((SALT38.StrType)le.orig_county),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.last_action_date),TRIM((SALT38.StrType)le.cert_issue_date),TRIM((SALT38.StrType)le.certification),TRIM((SALT38.StrType)le.type_aircraft),TRIM((SALT38.StrType)le.type_engine),TRIM((SALT38.StrType)le.status_code),TRIM((SALT38.StrType)le.mode_s_code),TRIM((SALT38.StrType)le.fract_owner),TRIM((SALT38.StrType)le.aircraft_mfr_name),TRIM((SALT38.StrType)le.model_name),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.z4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.compname),TRIM((SALT38.StrType)le.lf),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),88*88,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'d_score'}
      ,{2,'best_ssn'}
      ,{3,'did_out'}
      ,{4,'bdid_out'}
      ,{5,'date_first_seen'}
      ,{6,'date_last_seen'}
      ,{7,'current_flag'}
      ,{8,'n_number'}
      ,{9,'serial_number'}
      ,{10,'mfr_mdl_code'}
      ,{11,'eng_mfr_mdl'}
      ,{12,'year_mfr'}
      ,{13,'type_registrant'}
      ,{14,'name'}
      ,{15,'street'}
      ,{16,'street2'}
      ,{17,'city'}
      ,{18,'state'}
      ,{19,'zip_code'}
      ,{20,'region'}
      ,{21,'orig_county'}
      ,{22,'country'}
      ,{23,'last_action_date'}
      ,{24,'cert_issue_date'}
      ,{25,'certification'}
      ,{26,'type_aircraft'}
      ,{27,'type_engine'}
      ,{28,'status_code'}
      ,{29,'mode_s_code'}
      ,{30,'fract_owner'}
      ,{31,'aircraft_mfr_name'}
      ,{32,'model_name'}
      ,{33,'prim_range'}
      ,{34,'predir'}
      ,{35,'prim_name'}
      ,{36,'addr_suffix'}
      ,{37,'postdir'}
      ,{38,'unit_desig'}
      ,{39,'sec_range'}
      ,{40,'p_city_name'}
      ,{41,'v_city_name'}
      ,{42,'st'}
      ,{43,'zip'}
      ,{44,'z4'}
      ,{45,'cart'}
      ,{46,'cr_sort_sz'}
      ,{47,'lot'}
      ,{48,'lot_order'}
      ,{49,'dpbc'}
      ,{50,'chk_digit'}
      ,{51,'rec_type'}
      ,{52,'ace_fips_st'}
      ,{53,'county'}
      ,{54,'geo_lat'}
      ,{55,'geo_long'}
      ,{56,'msa'}
      ,{57,'geo_blk'}
      ,{58,'geo_match'}
      ,{59,'err_stat'}
      ,{60,'title'}
      ,{61,'fname'}
      ,{62,'mname'}
      ,{63,'lname'}
      ,{64,'name_suffix'}
      ,{65,'compname'}
      ,{66,'lf'}
      ,{67,'source_rec_id'}
      ,{68,'dotid'}
      ,{69,'dotscore'}
      ,{70,'dotweight'}
      ,{71,'empid'}
      ,{72,'empscore'}
      ,{73,'empweight'}
      ,{74,'powid'}
      ,{75,'powscore'}
      ,{76,'powweight'}
      ,{77,'proxid'}
      ,{78,'proxscore'}
      ,{79,'proxweight'}
      ,{80,'seleid'}
      ,{81,'selescore'}
      ,{82,'seleweight'}
      ,{83,'orgid'}
      ,{84,'orgscore'}
      ,{85,'orgweight'}
      ,{86,'ultid'}
      ,{87,'ultscore'}
      ,{88,'ultweight'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Aircraft_Fields.InValid_d_score((SALT38.StrType)le.d_score),
    Aircraft_Fields.InValid_best_ssn((SALT38.StrType)le.best_ssn),
    Aircraft_Fields.InValid_did_out((SALT38.StrType)le.did_out),
    Aircraft_Fields.InValid_bdid_out((SALT38.StrType)le.bdid_out),
    Aircraft_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen),
    Aircraft_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen),
    Aircraft_Fields.InValid_current_flag((SALT38.StrType)le.current_flag),
    Aircraft_Fields.InValid_n_number((SALT38.StrType)le.n_number),
    Aircraft_Fields.InValid_serial_number((SALT38.StrType)le.serial_number),
    Aircraft_Fields.InValid_mfr_mdl_code((SALT38.StrType)le.mfr_mdl_code),
    Aircraft_Fields.InValid_eng_mfr_mdl((SALT38.StrType)le.eng_mfr_mdl),
    Aircraft_Fields.InValid_year_mfr((SALT38.StrType)le.year_mfr),
    Aircraft_Fields.InValid_type_registrant((SALT38.StrType)le.type_registrant),
    Aircraft_Fields.InValid_name((SALT38.StrType)le.name),
    Aircraft_Fields.InValid_street((SALT38.StrType)le.street),
    Aircraft_Fields.InValid_street2((SALT38.StrType)le.street2),
    Aircraft_Fields.InValid_city((SALT38.StrType)le.city),
    Aircraft_Fields.InValid_state((SALT38.StrType)le.state),
    Aircraft_Fields.InValid_zip_code((SALT38.StrType)le.zip_code),
    Aircraft_Fields.InValid_region((SALT38.StrType)le.region),
    Aircraft_Fields.InValid_orig_county((SALT38.StrType)le.orig_county),
    Aircraft_Fields.InValid_country((SALT38.StrType)le.country),
    Aircraft_Fields.InValid_last_action_date((SALT38.StrType)le.last_action_date),
    Aircraft_Fields.InValid_cert_issue_date((SALT38.StrType)le.cert_issue_date),
    Aircraft_Fields.InValid_certification((SALT38.StrType)le.certification),
    Aircraft_Fields.InValid_type_aircraft((SALT38.StrType)le.type_aircraft),
    Aircraft_Fields.InValid_type_engine((SALT38.StrType)le.type_engine),
    Aircraft_Fields.InValid_status_code((SALT38.StrType)le.status_code),
    Aircraft_Fields.InValid_mode_s_code((SALT38.StrType)le.mode_s_code),
    Aircraft_Fields.InValid_fract_owner((SALT38.StrType)le.fract_owner),
    Aircraft_Fields.InValid_aircraft_mfr_name((SALT38.StrType)le.aircraft_mfr_name),
    Aircraft_Fields.InValid_model_name((SALT38.StrType)le.model_name),
    Aircraft_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Aircraft_Fields.InValid_predir((SALT38.StrType)le.predir),
    Aircraft_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Aircraft_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    Aircraft_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Aircraft_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Aircraft_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Aircraft_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Aircraft_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Aircraft_Fields.InValid_st((SALT38.StrType)le.st),
    Aircraft_Fields.InValid_zip((SALT38.StrType)le.zip),
    Aircraft_Fields.InValid_z4((SALT38.StrType)le.z4),
    Aircraft_Fields.InValid_cart((SALT38.StrType)le.cart),
    Aircraft_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Aircraft_Fields.InValid_lot((SALT38.StrType)le.lot),
    Aircraft_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Aircraft_Fields.InValid_dpbc((SALT38.StrType)le.dpbc),
    Aircraft_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Aircraft_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Aircraft_Fields.InValid_ace_fips_st((SALT38.StrType)le.ace_fips_st),
    Aircraft_Fields.InValid_county((SALT38.StrType)le.county),
    Aircraft_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Aircraft_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Aircraft_Fields.InValid_msa((SALT38.StrType)le.msa),
    Aircraft_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Aircraft_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Aircraft_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Aircraft_Fields.InValid_title((SALT38.StrType)le.title),
    Aircraft_Fields.InValid_fname((SALT38.StrType)le.fname),
    Aircraft_Fields.InValid_mname((SALT38.StrType)le.mname),
    Aircraft_Fields.InValid_lname((SALT38.StrType)le.lname),
    Aircraft_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Aircraft_Fields.InValid_compname((SALT38.StrType)le.compname),
    Aircraft_Fields.InValid_lf((SALT38.StrType)le.lf),
    Aircraft_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id),
    Aircraft_Fields.InValid_dotid((SALT38.StrType)le.dotid),
    Aircraft_Fields.InValid_dotscore((SALT38.StrType)le.dotscore),
    Aircraft_Fields.InValid_dotweight((SALT38.StrType)le.dotweight),
    Aircraft_Fields.InValid_empid((SALT38.StrType)le.empid),
    Aircraft_Fields.InValid_empscore((SALT38.StrType)le.empscore),
    Aircraft_Fields.InValid_empweight((SALT38.StrType)le.empweight),
    Aircraft_Fields.InValid_powid((SALT38.StrType)le.powid),
    Aircraft_Fields.InValid_powscore((SALT38.StrType)le.powscore),
    Aircraft_Fields.InValid_powweight((SALT38.StrType)le.powweight),
    Aircraft_Fields.InValid_proxid((SALT38.StrType)le.proxid),
    Aircraft_Fields.InValid_proxscore((SALT38.StrType)le.proxscore),
    Aircraft_Fields.InValid_proxweight((SALT38.StrType)le.proxweight),
    Aircraft_Fields.InValid_seleid((SALT38.StrType)le.seleid),
    Aircraft_Fields.InValid_selescore((SALT38.StrType)le.selescore),
    Aircraft_Fields.InValid_seleweight((SALT38.StrType)le.seleweight),
    Aircraft_Fields.InValid_orgid((SALT38.StrType)le.orgid),
    Aircraft_Fields.InValid_orgscore((SALT38.StrType)le.orgscore),
    Aircraft_Fields.InValid_orgweight((SALT38.StrType)le.orgweight),
    Aircraft_Fields.InValid_ultid((SALT38.StrType)le.ultid),
    Aircraft_Fields.InValid_ultscore((SALT38.StrType)le.ultscore),
    Aircraft_Fields.InValid_ultweight((SALT38.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,88,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Aircraft_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_SSN','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Flag','Invalid_AlphaNum','Invalid_AlphaNumPunct','Invalid_AlphaNum','Invalid_Num','Invalid_Year','Invalid_Type','Unknown','Unknown','Unknown','Unknown','Invalid_Letter','Unknown','Invalid_AlphaNum','Invalid_Num','Invalid_Letter','Invalid_Date','Invalid_Date','Invalid_AlphaNum','Invalid_Type','Invalid_Type','Invalid_AlphaNum','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Aircraft_Fields.InValidMessage_d_score(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_did_out(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_bdid_out(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_current_flag(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_n_number(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_serial_number(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_mfr_mdl_code(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_eng_mfr_mdl(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_year_mfr(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_type_registrant(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_name(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_street(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_street2(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_city(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_state(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_region(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_country(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_last_action_date(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_cert_issue_date(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_certification(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_type_aircraft(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_type_engine(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_status_code(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_mode_s_code(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_fract_owner(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_aircraft_mfr_name(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_model_name(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_st(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_z4(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_county(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_title(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_compname(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_lf(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Aircraft_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FAA, Aircraft_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
