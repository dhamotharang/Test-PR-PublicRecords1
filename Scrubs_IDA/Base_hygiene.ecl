IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Base_layout_IDA) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_src_cnt := COUNT(GROUP,h.src <> (TYPEOF(h.src))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_orig_first_name_cnt := COUNT(GROUP,h.orig_first_name <> (TYPEOF(h.orig_first_name))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_middle_name_cnt := COUNT(GROUP,h.orig_middle_name <> (TYPEOF(h.orig_middle_name))'');
    populated_orig_middle_name_pcnt := AVE(GROUP,IF(h.orig_middle_name = (TYPEOF(h.orig_middle_name))'',0,100));
    maxlength_orig_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_middle_name)));
    avelength_orig_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_middle_name)),h.orig_middle_name<>(typeof(h.orig_middle_name))'');
    populated_orig_last_name_cnt := COUNT(GROUP,h.orig_last_name <> (TYPEOF(h.orig_last_name))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_orig_suffix_cnt := COUNT(GROUP,h.orig_suffix <> (TYPEOF(h.orig_suffix))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
    populated_orig_address1_cnt := COUNT(GROUP,h.orig_address1 <> (TYPEOF(h.orig_address1))'');
    populated_orig_address1_pcnt := AVE(GROUP,IF(h.orig_address1 = (TYPEOF(h.orig_address1))'',0,100));
    maxlength_orig_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address1)));
    avelength_orig_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address1)),h.orig_address1<>(typeof(h.orig_address1))'');
    populated_orig_address2_cnt := COUNT(GROUP,h.orig_address2 <> (TYPEOF(h.orig_address2))'');
    populated_orig_address2_pcnt := AVE(GROUP,IF(h.orig_address2 = (TYPEOF(h.orig_address2))'',0,100));
    maxlength_orig_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address2)));
    avelength_orig_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address2)),h.orig_address2<>(typeof(h.orig_address2))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_province_cnt := COUNT(GROUP,h.orig_state_province <> (TYPEOF(h.orig_state_province))'');
    populated_orig_state_province_pcnt := AVE(GROUP,IF(h.orig_state_province = (TYPEOF(h.orig_state_province))'',0,100));
    maxlength_orig_state_province := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state_province)));
    avelength_orig_state_province := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state_province)),h.orig_state_province<>(typeof(h.orig_state_province))'');
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_zip5_cnt := COUNT(GROUP,h.orig_zip5 <> (TYPEOF(h.orig_zip5))'');
    populated_orig_zip5_pcnt := AVE(GROUP,IF(h.orig_zip5 = (TYPEOF(h.orig_zip5))'',0,100));
    maxlength_orig_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip5)));
    avelength_orig_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip5)),h.orig_zip5<>(typeof(h.orig_zip5))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_dl_cnt := COUNT(GROUP,h.orig_dl <> (TYPEOF(h.orig_dl))'');
    populated_orig_dl_pcnt := AVE(GROUP,IF(h.orig_dl = (TYPEOF(h.orig_dl))'',0,100));
    maxlength_orig_dl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dl)));
    avelength_orig_dl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dl)),h.orig_dl<>(typeof(h.orig_dl))'');
    populated_orig_dlstate_cnt := COUNT(GROUP,h.orig_dlstate <> (TYPEOF(h.orig_dlstate))'');
    populated_orig_dlstate_pcnt := AVE(GROUP,IF(h.orig_dlstate = (TYPEOF(h.orig_dlstate))'',0,100));
    maxlength_orig_dlstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dlstate)));
    avelength_orig_dlstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_dlstate)),h.orig_dlstate<>(typeof(h.orig_dlstate))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_clientassigneduniquerecordid_cnt := COUNT(GROUP,h.clientassigneduniquerecordid <> (TYPEOF(h.clientassigneduniquerecordid))'');
    populated_clientassigneduniquerecordid_pcnt := AVE(GROUP,IF(h.clientassigneduniquerecordid = (TYPEOF(h.clientassigneduniquerecordid))'',0,100));
    maxlength_clientassigneduniquerecordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clientassigneduniquerecordid)));
    avelength_clientassigneduniquerecordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clientassigneduniquerecordid)),h.clientassigneduniquerecordid<>(typeof(h.clientassigneduniquerecordid))'');
    populated_adl_ind_cnt := COUNT(GROUP,h.adl_ind <> (TYPEOF(h.adl_ind))'');
    populated_adl_ind_pcnt := AVE(GROUP,IF(h.adl_ind = (TYPEOF(h.adl_ind))'',0,100));
    maxlength_adl_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adl_ind)));
    avelength_adl_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adl_ind)),h.adl_ind<>(typeof(h.adl_ind))'');
    populated_orig_email_cnt := COUNT(GROUP,h.orig_email <> (TYPEOF(h.orig_email))'');
    populated_orig_email_pcnt := AVE(GROUP,IF(h.orig_email = (TYPEOF(h.orig_email))'',0,100));
    maxlength_orig_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_email)));
    avelength_orig_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_email)),h.orig_email<>(typeof(h.orig_email))'');
    populated_orig_ipaddress_cnt := COUNT(GROUP,h.orig_ipaddress <> (TYPEOF(h.orig_ipaddress))'');
    populated_orig_ipaddress_pcnt := AVE(GROUP,IF(h.orig_ipaddress = (TYPEOF(h.orig_ipaddress))'',0,100));
    maxlength_orig_ipaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ipaddress)));
    avelength_orig_ipaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ipaddress)),h.orig_ipaddress<>(typeof(h.orig_ipaddress))'');
    populated_orig_filecategory_cnt := COUNT(GROUP,h.orig_filecategory <> (TYPEOF(h.orig_filecategory))'');
    populated_orig_filecategory_pcnt := AVE(GROUP,IF(h.orig_filecategory = (TYPEOF(h.orig_filecategory))'',0,100));
    maxlength_orig_filecategory := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filecategory)));
    avelength_orig_filecategory := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filecategory)),h.orig_filecategory<>(typeof(h.orig_filecategory))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
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
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_nid_cnt := COUNT(GROUP,h.nid <> (TYPEOF(h.nid))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_st_cnt := COUNT(GROUP,h.fips_st <> (TYPEOF(h.fips_st))'');
    populated_fips_st_pcnt := AVE(GROUP,IF(h.fips_st = (TYPEOF(h.fips_st))'',0,100));
    maxlength_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_st)));
    avelength_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_st)),h.fips_st<>(typeof(h.fips_st))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_cnt := COUNT(GROUP,h.aceaid <> (TYPEOF(h.aceaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_dob_cnt := COUNT(GROUP,h.clean_dob <> (TYPEOF(h.clean_dob))'');
    populated_clean_dob_pcnt := AVE(GROUP,IF(h.clean_dob = (TYPEOF(h.clean_dob))'',0,100));
    maxlength_clean_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dob)));
    avelength_clean_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_dob)),h.clean_dob<>(typeof(h.clean_dob))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_orig_first_name_pcnt *   0.00 / 100 + T.Populated_orig_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_last_name_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_orig_address1_pcnt *   0.00 / 100 + T.Populated_orig_address2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_province_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_zip5_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_dl_pcnt *   0.00 / 100 + T.Populated_orig_dlstate_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_clientassigneduniquerecordid_pcnt *   0.00 / 100 + T.Populated_adl_ind_pcnt *   0.00 / 100 + T.Populated_orig_email_pcnt *   0.00 / 100 + T.Populated_orig_ipaddress_pcnt *   0.00 / 100 + T.Populated_orig_filecategory_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_st_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_aceaid_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_dob_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'persistent_record_id','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','did','did_score','orig_first_name','orig_middle_name','orig_last_name','orig_suffix','orig_address1','orig_address2','orig_city','orig_state_province','orig_zip4','orig_zip5','orig_dob','orig_ssn','orig_dl','orig_dlstate','orig_phone','clientassigneduniquerecordid','adl_ind','orig_email','orig_ipaddress','orig_filecategory','title','fname','mname','lname','name_suffix','nid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','clean_dob');
  SELF.populated_pcnt := CHOOSE(C,le.populated_persistent_record_id_pcnt,le.populated_src_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_orig_first_name_pcnt,le.populated_orig_middle_name_pcnt,le.populated_orig_last_name_pcnt,le.populated_orig_suffix_pcnt,le.populated_orig_address1_pcnt,le.populated_orig_address2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_province_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_zip5_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_dl_pcnt,le.populated_orig_dlstate_pcnt,le.populated_orig_phone_pcnt,le.populated_clientassigneduniquerecordid_pcnt,le.populated_adl_ind_pcnt,le.populated_orig_email_pcnt,le.populated_orig_ipaddress_pcnt,le.populated_orig_filecategory_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_nid_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_dob_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_persistent_record_id,le.maxlength_src,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_did,le.maxlength_did_score,le.maxlength_orig_first_name,le.maxlength_orig_middle_name,le.maxlength_orig_last_name,le.maxlength_orig_suffix,le.maxlength_orig_address1,le.maxlength_orig_address2,le.maxlength_orig_city,le.maxlength_orig_state_province,le.maxlength_orig_zip4,le.maxlength_orig_zip5,le.maxlength_orig_dob,le.maxlength_orig_ssn,le.maxlength_orig_dl,le.maxlength_orig_dlstate,le.maxlength_orig_phone,le.maxlength_clientassigneduniquerecordid,le.maxlength_adl_ind,le.maxlength_orig_email,le.maxlength_orig_ipaddress,le.maxlength_orig_filecategory,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_nid,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_clean_phone,le.maxlength_clean_dob);
  SELF.avelength := CHOOSE(C,le.avelength_persistent_record_id,le.avelength_src,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_did,le.avelength_did_score,le.avelength_orig_first_name,le.avelength_orig_middle_name,le.avelength_orig_last_name,le.avelength_orig_suffix,le.avelength_orig_address1,le.avelength_orig_address2,le.avelength_orig_city,le.avelength_orig_state_province,le.avelength_orig_zip4,le.avelength_orig_zip5,le.avelength_orig_dob,le.avelength_orig_ssn,le.avelength_orig_dl,le.avelength_orig_dlstate,le.avelength_orig_phone,le.avelength_clientassigneduniquerecordid,le.avelength_adl_ind,le.avelength_orig_email,le.avelength_orig_ipaddress,le.avelength_orig_filecategory,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_nid,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_aceaid,le.avelength_clean_phone,le.avelength_clean_dob);
END;
EXPORT invSummary := NORMALIZE(summary0, 65, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.persistent_record_id),TRIM((SALT311.StrType)le.src),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.orig_first_name),TRIM((SALT311.StrType)le.orig_middle_name),TRIM((SALT311.StrType)le.orig_last_name),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.orig_address1),TRIM((SALT311.StrType)le.orig_address2),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state_province),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.orig_zip5),IF (le.orig_dob <> 0,TRIM((SALT311.StrType)le.orig_dob), ''),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_dl),TRIM((SALT311.StrType)le.orig_dlstate),TRIM((SALT311.StrType)le.orig_phone),IF (le.clientassigneduniquerecordid <> 0,TRIM((SALT311.StrType)le.clientassigneduniquerecordid), ''),TRIM((SALT311.StrType)le.adl_ind),TRIM((SALT311.StrType)le.orig_email),TRIM((SALT311.StrType)le.orig_ipaddress),TRIM((SALT311.StrType)le.orig_filecategory),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),IF (le.nid <> 0,TRIM((SALT311.StrType)le.nid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_dob)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,65,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 65);
  SELF.FldNo2 := 1 + (C % 65);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.persistent_record_id),TRIM((SALT311.StrType)le.src),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.orig_first_name),TRIM((SALT311.StrType)le.orig_middle_name),TRIM((SALT311.StrType)le.orig_last_name),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.orig_address1),TRIM((SALT311.StrType)le.orig_address2),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state_province),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.orig_zip5),IF (le.orig_dob <> 0,TRIM((SALT311.StrType)le.orig_dob), ''),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_dl),TRIM((SALT311.StrType)le.orig_dlstate),TRIM((SALT311.StrType)le.orig_phone),IF (le.clientassigneduniquerecordid <> 0,TRIM((SALT311.StrType)le.clientassigneduniquerecordid), ''),TRIM((SALT311.StrType)le.adl_ind),TRIM((SALT311.StrType)le.orig_email),TRIM((SALT311.StrType)le.orig_ipaddress),TRIM((SALT311.StrType)le.orig_filecategory),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),IF (le.nid <> 0,TRIM((SALT311.StrType)le.nid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_dob)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.persistent_record_id),TRIM((SALT311.StrType)le.src),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.orig_first_name),TRIM((SALT311.StrType)le.orig_middle_name),TRIM((SALT311.StrType)le.orig_last_name),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.orig_address1),TRIM((SALT311.StrType)le.orig_address2),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state_province),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.orig_zip5),IF (le.orig_dob <> 0,TRIM((SALT311.StrType)le.orig_dob), ''),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_dl),TRIM((SALT311.StrType)le.orig_dlstate),TRIM((SALT311.StrType)le.orig_phone),IF (le.clientassigneduniquerecordid <> 0,TRIM((SALT311.StrType)le.clientassigneduniquerecordid), ''),TRIM((SALT311.StrType)le.adl_ind),TRIM((SALT311.StrType)le.orig_email),TRIM((SALT311.StrType)le.orig_ipaddress),TRIM((SALT311.StrType)le.orig_filecategory),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),IF (le.nid <> 0,TRIM((SALT311.StrType)le.nid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT311.StrType)le.aceaid), ''),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_dob)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),65*65,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'persistent_record_id'}
      ,{2,'src'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'did'}
      ,{8,'did_score'}
      ,{9,'orig_first_name'}
      ,{10,'orig_middle_name'}
      ,{11,'orig_last_name'}
      ,{12,'orig_suffix'}
      ,{13,'orig_address1'}
      ,{14,'orig_address2'}
      ,{15,'orig_city'}
      ,{16,'orig_state_province'}
      ,{17,'orig_zip4'}
      ,{18,'orig_zip5'}
      ,{19,'orig_dob'}
      ,{20,'orig_ssn'}
      ,{21,'orig_dl'}
      ,{22,'orig_dlstate'}
      ,{23,'orig_phone'}
      ,{24,'clientassigneduniquerecordid'}
      ,{25,'adl_ind'}
      ,{26,'orig_email'}
      ,{27,'orig_ipaddress'}
      ,{28,'orig_filecategory'}
      ,{29,'title'}
      ,{30,'fname'}
      ,{31,'mname'}
      ,{32,'lname'}
      ,{33,'name_suffix'}
      ,{34,'nid'}
      ,{35,'prim_range'}
      ,{36,'predir'}
      ,{37,'prim_name'}
      ,{38,'addr_suffix'}
      ,{39,'postdir'}
      ,{40,'unit_desig'}
      ,{41,'sec_range'}
      ,{42,'p_city_name'}
      ,{43,'v_city_name'}
      ,{44,'st'}
      ,{45,'zip'}
      ,{46,'zip4'}
      ,{47,'cart'}
      ,{48,'cr_sort_sz'}
      ,{49,'lot'}
      ,{50,'lot_order'}
      ,{51,'dbpc'}
      ,{52,'chk_digit'}
      ,{53,'rec_type'}
      ,{54,'fips_st'}
      ,{55,'fips_county'}
      ,{56,'geo_lat'}
      ,{57,'geo_long'}
      ,{58,'msa'}
      ,{59,'geo_blk'}
      ,{60,'geo_match'}
      ,{61,'err_stat'}
      ,{62,'rawaid'}
      ,{63,'aceaid'}
      ,{64,'clean_phone'}
      ,{65,'clean_dob'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    Base_Fields.InValid_src((SALT311.StrType)le.src),
    Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_did((SALT311.StrType)le.did),
    Base_Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Base_Fields.InValid_orig_first_name((SALT311.StrType)le.orig_first_name),
    Base_Fields.InValid_orig_middle_name((SALT311.StrType)le.orig_middle_name),
    Base_Fields.InValid_orig_last_name((SALT311.StrType)le.orig_last_name),
    Base_Fields.InValid_orig_suffix((SALT311.StrType)le.orig_suffix),
    Base_Fields.InValid_orig_address1((SALT311.StrType)le.orig_address1),
    Base_Fields.InValid_orig_address2((SALT311.StrType)le.orig_address2),
    Base_Fields.InValid_orig_city((SALT311.StrType)le.orig_city),
    Base_Fields.InValid_orig_state_province((SALT311.StrType)le.orig_state_province),
    Base_Fields.InValid_orig_zip4((SALT311.StrType)le.orig_zip4),
    Base_Fields.InValid_orig_zip5((SALT311.StrType)le.orig_zip5),
    Base_Fields.InValid_orig_dob((SALT311.StrType)le.orig_dob),
    Base_Fields.InValid_orig_ssn((SALT311.StrType)le.orig_ssn),
    Base_Fields.InValid_orig_dl((SALT311.StrType)le.orig_dl),
    Base_Fields.InValid_orig_dlstate((SALT311.StrType)le.orig_dlstate),
    Base_Fields.InValid_orig_phone((SALT311.StrType)le.orig_phone),
    Base_Fields.InValid_clientassigneduniquerecordid((SALT311.StrType)le.clientassigneduniquerecordid),
    Base_Fields.InValid_adl_ind((SALT311.StrType)le.adl_ind),
    Base_Fields.InValid_orig_email((SALT311.StrType)le.orig_email),
    Base_Fields.InValid_orig_ipaddress((SALT311.StrType)le.orig_ipaddress),
    Base_Fields.InValid_orig_filecategory((SALT311.StrType)le.orig_filecategory),
    Base_Fields.InValid_title((SALT311.StrType)le.title),
    Base_Fields.InValid_fname((SALT311.StrType)le.fname),
    Base_Fields.InValid_mname((SALT311.StrType)le.mname),
    Base_Fields.InValid_lname((SALT311.StrType)le.lname),
    Base_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Base_Fields.InValid_nid((SALT311.StrType)le.nid),
    Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT311.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT311.StrType)le.st),
    Base_Fields.InValid_zip((SALT311.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT311.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT311.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Base_Fields.InValid_fips_st((SALT311.StrType)le.fips_st),
    Base_Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT311.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Base_Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Base_Fields.InValid_aceaid((SALT311.StrType)le.aceaid),
    Base_Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone),
    Base_Fields.InValid_clean_dob((SALT311.StrType)le.clean_dob),
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
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Rec_ID','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_Address1','Invalid_Address2','Invalid_City','Invalid_State','Invalid_Zip','Invalid_Zip','Invalid_Date','Invalid_SSN','Invalid_DL','Invalid_State','Invalid_Phone','Invalid_Clientassigneduniquerecordid','Invalid_Alpha','Invalid_Emailaddress','Invalid_Ipaddress','Unknown','Invalid_Title','Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_NID','Invalid_Num','Invalid_Dir','Invalid_Add','Invalid_Add_Suff','Invalid_Dir','Invalid_Add_Suff','Invalid_Num','Invalid_City','Invalid_City','Invalid_State','Invalid_Zip','Invalid_Zip4','Invalid_AlphaNum','Invalid_Alpha','Invalid_Num','Invalid_Alpha','Invalid_Num','Invalid_Num','Invalid_Alpha','Invalid_Num','Invalid_Num','Invalid_Coor','Invalid_Coor','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Err','Invalid_AID','Invalid_AID','Invalid_Phone','Invalid_Date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_src(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_middle_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_address1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_address2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_state_province(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_zip5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dl(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_dlstate(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clientassigneduniquerecordid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_adl_ind(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_ipaddress(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orig_filecategory(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_dob(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IDA, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
