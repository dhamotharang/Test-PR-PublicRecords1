IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_NoMatchHeader) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_nomatch_id_cnt := COUNT(GROUP,h.nomatch_id <> (TYPEOF(h.nomatch_id))'');
    populated_nomatch_id_pcnt := AVE(GROUP,IF(h.nomatch_id = (TYPEOF(h.nomatch_id))'',0,100));
    maxlength_nomatch_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nomatch_id)));
    avelength_nomatch_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nomatch_id)),h.nomatch_id<>(typeof(h.nomatch_id))'');
    populated_rid_cnt := COUNT(GROUP,h.rid <> (TYPEOF(h.rid))'');
    populated_rid_pcnt := AVE(GROUP,IF(h.rid = (TYPEOF(h.rid))'',0,100));
    maxlength_rid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rid)));
    avelength_rid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rid)),h.rid<>(typeof(h.rid))'');
    populated_lexid_cnt := COUNT(GROUP,h.lexid <> (TYPEOF(h.lexid))'');
    populated_lexid_pcnt := AVE(GROUP,IF(h.lexid = (TYPEOF(h.lexid))'',0,100));
    maxlength_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)));
    avelength_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)),h.lexid<>(typeof(h.lexid))'');
    populated_lexid_score_cnt := COUNT(GROUP,h.lexid_score <> (TYPEOF(h.lexid_score))'');
    populated_lexid_score_pcnt := AVE(GROUP,IF(h.lexid_score = (TYPEOF(h.lexid_score))'',0,100));
    maxlength_lexid_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid_score)));
    avelength_lexid_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid_score)),h.lexid_score<>(typeof(h.lexid_score))'');
    populated_guardian_lexid_cnt := COUNT(GROUP,h.guardian_lexid <> (TYPEOF(h.guardian_lexid))'');
    populated_guardian_lexid_pcnt := AVE(GROUP,IF(h.guardian_lexid = (TYPEOF(h.guardian_lexid))'',0,100));
    maxlength_guardian_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_lexid)));
    avelength_guardian_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_lexid)),h.guardian_lexid<>(typeof(h.guardian_lexid))'');
    populated_guardian_lexid_score_cnt := COUNT(GROUP,h.guardian_lexid_score <> (TYPEOF(h.guardian_lexid_score))'');
    populated_guardian_lexid_score_pcnt := AVE(GROUP,IF(h.guardian_lexid_score = (TYPEOF(h.guardian_lexid_score))'',0,100));
    maxlength_guardian_lexid_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_lexid_score)));
    avelength_guardian_lexid_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_lexid_score)),h.guardian_lexid_score<>(typeof(h.guardian_lexid_score))'');
    populated_crk_cnt := COUNT(GROUP,h.crk <> (TYPEOF(h.crk))'');
    populated_crk_pcnt := AVE(GROUP,IF(h.crk = (TYPEOF(h.crk))'',0,100));
    maxlength_crk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crk)));
    avelength_crk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crk)),h.crk<>(typeof(h.crk))'');
    populated_src_cnt := COUNT(GROUP,h.src <> (TYPEOF(h.src))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_source_rid_cnt := COUNT(GROUP,h.source_rid <> (TYPEOF(h.source_rid))'');
    populated_source_rid_pcnt := AVE(GROUP,IF(h.source_rid = (TYPEOF(h.source_rid))'',0,100));
    maxlength_source_rid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rid)));
    avelength_source_rid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rid)),h.source_rid<>(typeof(h.source_rid))'');
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
    populated_member_id_cnt := COUNT(GROUP,h.member_id <> (TYPEOF(h.member_id))'');
    populated_member_id_pcnt := AVE(GROUP,IF(h.member_id = (TYPEOF(h.member_id))'',0,100));
    maxlength_member_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_id)));
    avelength_member_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.member_id)),h.member_id<>(typeof(h.member_id))'');
    populated_customer_id_cnt := COUNT(GROUP,h.customer_id <> (TYPEOF(h.customer_id))'');
    populated_customer_id_pcnt := AVE(GROUP,IF(h.customer_id = (TYPEOF(h.customer_id))'',0,100));
    maxlength_customer_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_id)));
    avelength_customer_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_id)),h.customer_id<>(typeof(h.customer_id))'');
    populated_account_id_cnt := COUNT(GROUP,h.account_id <> (TYPEOF(h.account_id))'');
    populated_account_id_pcnt := AVE(GROUP,IF(h.account_id = (TYPEOF(h.account_id))'',0,100));
    maxlength_account_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_id)));
    avelength_account_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_id)),h.account_id<>(typeof(h.account_id))'');
    populated_subscriber_id_cnt := COUNT(GROUP,h.subscriber_id <> (TYPEOF(h.subscriber_id))'');
    populated_subscriber_id_pcnt := AVE(GROUP,IF(h.subscriber_id = (TYPEOF(h.subscriber_id))'',0,100));
    maxlength_subscriber_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subscriber_id)));
    avelength_subscriber_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subscriber_id)),h.subscriber_id<>(typeof(h.subscriber_id))'');
    populated_group_id_cnt := COUNT(GROUP,h.group_id <> (TYPEOF(h.group_id))'');
    populated_group_id_pcnt := AVE(GROUP,IF(h.group_id = (TYPEOF(h.group_id))'',0,100));
    maxlength_group_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.group_id)));
    avelength_group_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.group_id)),h.group_id<>(typeof(h.group_id))'');
    populated_relationship_code_cnt := COUNT(GROUP,h.relationship_code <> (TYPEOF(h.relationship_code))'');
    populated_relationship_code_pcnt := AVE(GROUP,IF(h.relationship_code = (TYPEOF(h.relationship_code))'',0,100));
    maxlength_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)));
    avelength_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)),h.relationship_code<>(typeof(h.relationship_code))'');
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
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_input_full_name_cnt := COUNT(GROUP,h.input_full_name <> (TYPEOF(h.input_full_name))'');
    populated_input_full_name_pcnt := AVE(GROUP,IF(h.input_full_name = (TYPEOF(h.input_full_name))'',0,100));
    maxlength_input_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.input_full_name)));
    avelength_input_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.input_full_name)),h.input_full_name<>(typeof(h.input_full_name))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_home_phone_cnt := COUNT(GROUP,h.home_phone <> (TYPEOF(h.home_phone))'');
    populated_home_phone_pcnt := AVE(GROUP,IF(h.home_phone = (TYPEOF(h.home_phone))'',0,100));
    maxlength_home_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_phone)));
    avelength_home_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_phone)),h.home_phone<>(typeof(h.home_phone))'');
    populated_alt_phone_cnt := COUNT(GROUP,h.alt_phone <> (TYPEOF(h.alt_phone))'');
    populated_alt_phone_pcnt := AVE(GROUP,IF(h.alt_phone = (TYPEOF(h.alt_phone))'',0,100));
    maxlength_alt_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_phone)));
    avelength_alt_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_phone)),h.alt_phone<>(typeof(h.alt_phone))'');
    populated_primary_email_address_cnt := COUNT(GROUP,h.primary_email_address <> (TYPEOF(h.primary_email_address))'');
    populated_primary_email_address_pcnt := AVE(GROUP,IF(h.primary_email_address = (TYPEOF(h.primary_email_address))'',0,100));
    maxlength_primary_email_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_email_address)));
    avelength_primary_email_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_email_address)),h.primary_email_address<>(typeof(h.primary_email_address))'');
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
    populated_city_name_cnt := COUNT(GROUP,h.city_name <> (TYPEOF(h.city_name))'');
    populated_city_name_pcnt := AVE(GROUP,IF(h.city_name = (TYPEOF(h.city_name))'',0,100));
    maxlength_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)));
    avelength_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)),h.city_name<>(typeof(h.city_name))'');
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
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
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
    populated_guardian_fname_cnt := COUNT(GROUP,h.guardian_fname <> (TYPEOF(h.guardian_fname))'');
    populated_guardian_fname_pcnt := AVE(GROUP,IF(h.guardian_fname = (TYPEOF(h.guardian_fname))'',0,100));
    maxlength_guardian_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_fname)));
    avelength_guardian_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_fname)),h.guardian_fname<>(typeof(h.guardian_fname))'');
    populated_guardian_mname_cnt := COUNT(GROUP,h.guardian_mname <> (TYPEOF(h.guardian_mname))'');
    populated_guardian_mname_pcnt := AVE(GROUP,IF(h.guardian_mname = (TYPEOF(h.guardian_mname))'',0,100));
    maxlength_guardian_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_mname)));
    avelength_guardian_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_mname)),h.guardian_mname<>(typeof(h.guardian_mname))'');
    populated_guardian_lname_cnt := COUNT(GROUP,h.guardian_lname <> (TYPEOF(h.guardian_lname))'');
    populated_guardian_lname_pcnt := AVE(GROUP,IF(h.guardian_lname = (TYPEOF(h.guardian_lname))'',0,100));
    maxlength_guardian_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_lname)));
    avelength_guardian_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_lname)),h.guardian_lname<>(typeof(h.guardian_lname))'');
    populated_guardian_dob_cnt := COUNT(GROUP,h.guardian_dob <> (TYPEOF(h.guardian_dob))'');
    populated_guardian_dob_pcnt := AVE(GROUP,IF(h.guardian_dob = (TYPEOF(h.guardian_dob))'',0,100));
    maxlength_guardian_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_dob)));
    avelength_guardian_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_dob)),h.guardian_dob<>(typeof(h.guardian_dob))'');
    populated_guardian_ssn_cnt := COUNT(GROUP,h.guardian_ssn <> (TYPEOF(h.guardian_ssn))'');
    populated_guardian_ssn_pcnt := AVE(GROUP,IF(h.guardian_ssn = (TYPEOF(h.guardian_ssn))'',0,100));
    maxlength_guardian_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_ssn)));
    avelength_guardian_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.guardian_ssn)),h.guardian_ssn<>(typeof(h.guardian_ssn))'');
    populated_udf1_cnt := COUNT(GROUP,h.udf1 <> (TYPEOF(h.udf1))'');
    populated_udf1_pcnt := AVE(GROUP,IF(h.udf1 = (TYPEOF(h.udf1))'',0,100));
    maxlength_udf1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.udf1)));
    avelength_udf1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.udf1)),h.udf1<>(typeof(h.udf1))'');
    populated_udf2_cnt := COUNT(GROUP,h.udf2 <> (TYPEOF(h.udf2))'');
    populated_udf2_pcnt := AVE(GROUP,IF(h.udf2 = (TYPEOF(h.udf2))'',0,100));
    maxlength_udf2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.udf2)));
    avelength_udf2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.udf2)),h.udf2<>(typeof(h.udf2))'');
    populated_udf3_cnt := COUNT(GROUP,h.udf3 <> (TYPEOF(h.udf3))'');
    populated_udf3_pcnt := AVE(GROUP,IF(h.udf3 = (TYPEOF(h.udf3))'',0,100));
    maxlength_udf3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.udf3)));
    avelength_udf3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.udf3)),h.udf3<>(typeof(h.udf3))'');
    populated_persistent_rid_cnt := COUNT(GROUP,h.persistent_rid <> (TYPEOF(h.persistent_rid))'');
    populated_persistent_rid_pcnt := AVE(GROUP,IF(h.persistent_rid = (TYPEOF(h.persistent_rid))'',0,100));
    maxlength_persistent_rid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_rid)));
    avelength_persistent_rid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_rid)),h.persistent_rid<>(typeof(h.persistent_rid))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_nomatch_id_pcnt *   0.00 / 100 + T.Populated_rid_pcnt *   0.00 / 100 + T.Populated_lexid_pcnt *   0.00 / 100 + T.Populated_lexid_score_pcnt *   0.00 / 100 + T.Populated_guardian_lexid_pcnt *   0.00 / 100 + T.Populated_guardian_lexid_score_pcnt *   0.00 / 100 + T.Populated_crk_pcnt *   0.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_source_rid_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_member_id_pcnt *   0.00 / 100 + T.Populated_customer_id_pcnt *   0.00 / 100 + T.Populated_account_id_pcnt *   0.00 / 100 + T.Populated_subscriber_id_pcnt *   0.00 / 100 + T.Populated_group_id_pcnt *   0.00 / 100 + T.Populated_relationship_code_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_input_full_name_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_home_phone_pcnt *   0.00 / 100 + T.Populated_alt_phone_pcnt *   0.00 / 100 + T.Populated_primary_email_address_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_guardian_fname_pcnt *   0.00 / 100 + T.Populated_guardian_mname_pcnt *   0.00 / 100 + T.Populated_guardian_lname_pcnt *   0.00 / 100 + T.Populated_guardian_dob_pcnt *   0.00 / 100 + T.Populated_guardian_ssn_pcnt *   0.00 / 100 + T.Populated_udf1_pcnt *   0.00 / 100 + T.Populated_udf2_pcnt *   0.00 / 100 + T.Populated_udf3_pcnt *   0.00 / 100 + T.Populated_persistent_rid_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'nomatch_id','rid','lexid','lexid_score','guardian_lexid','guardian_lexid_score','crk','src','source_rid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','member_id','customer_id','account_id','subscriber_id','group_id','relationship_code','title','fname','mname','lname','suffix','input_full_name','dob','gender','ssn','home_phone','alt_phone','primary_email_address','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','guardian_fname','guardian_mname','guardian_lname','guardian_dob','guardian_ssn','udf1','udf2','udf3','persistent_rid','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_nomatch_id_pcnt,le.populated_rid_pcnt,le.populated_lexid_pcnt,le.populated_lexid_score_pcnt,le.populated_guardian_lexid_pcnt,le.populated_guardian_lexid_score_pcnt,le.populated_crk_pcnt,le.populated_src_pcnt,le.populated_source_rid_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_member_id_pcnt,le.populated_customer_id_pcnt,le.populated_account_id_pcnt,le.populated_subscriber_id_pcnt,le.populated_group_id_pcnt,le.populated_relationship_code_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_input_full_name_pcnt,le.populated_dob_pcnt,le.populated_gender_pcnt,le.populated_ssn_pcnt,le.populated_home_phone_pcnt,le.populated_alt_phone_pcnt,le.populated_primary_email_address_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_guardian_fname_pcnt,le.populated_guardian_mname_pcnt,le.populated_guardian_lname_pcnt,le.populated_guardian_dob_pcnt,le.populated_guardian_ssn_pcnt,le.populated_udf1_pcnt,le.populated_udf2_pcnt,le.populated_udf3_pcnt,le.populated_persistent_rid_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_nomatch_id,le.maxlength_rid,le.maxlength_lexid,le.maxlength_lexid_score,le.maxlength_guardian_lexid,le.maxlength_guardian_lexid_score,le.maxlength_crk,le.maxlength_src,le.maxlength_source_rid,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_member_id,le.maxlength_customer_id,le.maxlength_account_id,le.maxlength_subscriber_id,le.maxlength_group_id,le.maxlength_relationship_code,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_suffix,le.maxlength_input_full_name,le.maxlength_dob,le.maxlength_gender,le.maxlength_ssn,le.maxlength_home_phone,le.maxlength_alt_phone,le.maxlength_primary_email_address,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_guardian_fname,le.maxlength_guardian_mname,le.maxlength_guardian_lname,le.maxlength_guardian_dob,le.maxlength_guardian_ssn,le.maxlength_udf1,le.maxlength_udf2,le.maxlength_udf3,le.maxlength_persistent_rid,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_nomatch_id,le.avelength_rid,le.avelength_lexid,le.avelength_lexid_score,le.avelength_guardian_lexid,le.avelength_guardian_lexid_score,le.avelength_crk,le.avelength_src,le.avelength_source_rid,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_member_id,le.avelength_customer_id,le.avelength_account_id,le.avelength_subscriber_id,le.avelength_group_id,le.avelength_relationship_code,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_suffix,le.avelength_input_full_name,le.avelength_dob,le.avelength_gender,le.avelength_ssn,le.avelength_home_phone,le.avelength_alt_phone,le.avelength_primary_email_address,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_guardian_fname,le.avelength_guardian_mname,le.avelength_guardian_lname,le.avelength_guardian_dob,le.avelength_guardian_ssn,le.avelength_udf1,le.avelength_udf2,le.avelength_udf3,le.avelength_persistent_rid,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 61, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.nomatch_id <> 0,TRIM((SALT311.StrType)le.nomatch_id), ''),IF (le.rid <> 0,TRIM((SALT311.StrType)le.rid), ''),IF (le.lexid <> 0,TRIM((SALT311.StrType)le.lexid), ''),IF (le.lexid_score <> 0,TRIM((SALT311.StrType)le.lexid_score), ''),IF (le.guardian_lexid <> 0,TRIM((SALT311.StrType)le.guardian_lexid), ''),IF (le.guardian_lexid_score <> 0,TRIM((SALT311.StrType)le.guardian_lexid_score), ''),TRIM((SALT311.StrType)le.crk),TRIM((SALT311.StrType)le.src),IF (le.source_rid <> 0,TRIM((SALT311.StrType)le.source_rid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.member_id),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.account_id),TRIM((SALT311.StrType)le.subscriber_id),TRIM((SALT311.StrType)le.group_id),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.input_full_name),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.alt_phone),TRIM((SALT311.StrType)le.primary_email_address),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.guardian_fname),TRIM((SALT311.StrType)le.guardian_mname),TRIM((SALT311.StrType)le.guardian_lname),IF (le.guardian_dob <> 0,TRIM((SALT311.StrType)le.guardian_dob), ''),TRIM((SALT311.StrType)le.guardian_ssn),TRIM((SALT311.StrType)le.udf1),TRIM((SALT311.StrType)le.udf2),TRIM((SALT311.StrType)le.udf3),TRIM((SALT311.StrType)le.persistent_rid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,61,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 61);
  SELF.FldNo2 := 1 + (C % 61);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.nomatch_id <> 0,TRIM((SALT311.StrType)le.nomatch_id), ''),IF (le.rid <> 0,TRIM((SALT311.StrType)le.rid), ''),IF (le.lexid <> 0,TRIM((SALT311.StrType)le.lexid), ''),IF (le.lexid_score <> 0,TRIM((SALT311.StrType)le.lexid_score), ''),IF (le.guardian_lexid <> 0,TRIM((SALT311.StrType)le.guardian_lexid), ''),IF (le.guardian_lexid_score <> 0,TRIM((SALT311.StrType)le.guardian_lexid_score), ''),TRIM((SALT311.StrType)le.crk),TRIM((SALT311.StrType)le.src),IF (le.source_rid <> 0,TRIM((SALT311.StrType)le.source_rid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.member_id),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.account_id),TRIM((SALT311.StrType)le.subscriber_id),TRIM((SALT311.StrType)le.group_id),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.input_full_name),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.alt_phone),TRIM((SALT311.StrType)le.primary_email_address),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.guardian_fname),TRIM((SALT311.StrType)le.guardian_mname),TRIM((SALT311.StrType)le.guardian_lname),IF (le.guardian_dob <> 0,TRIM((SALT311.StrType)le.guardian_dob), ''),TRIM((SALT311.StrType)le.guardian_ssn),TRIM((SALT311.StrType)le.udf1),TRIM((SALT311.StrType)le.udf2),TRIM((SALT311.StrType)le.udf3),TRIM((SALT311.StrType)le.persistent_rid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.nomatch_id <> 0,TRIM((SALT311.StrType)le.nomatch_id), ''),IF (le.rid <> 0,TRIM((SALT311.StrType)le.rid), ''),IF (le.lexid <> 0,TRIM((SALT311.StrType)le.lexid), ''),IF (le.lexid_score <> 0,TRIM((SALT311.StrType)le.lexid_score), ''),IF (le.guardian_lexid <> 0,TRIM((SALT311.StrType)le.guardian_lexid), ''),IF (le.guardian_lexid_score <> 0,TRIM((SALT311.StrType)le.guardian_lexid_score), ''),TRIM((SALT311.StrType)le.crk),TRIM((SALT311.StrType)le.src),IF (le.source_rid <> 0,TRIM((SALT311.StrType)le.source_rid), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.member_id),TRIM((SALT311.StrType)le.customer_id),TRIM((SALT311.StrType)le.account_id),TRIM((SALT311.StrType)le.subscriber_id),TRIM((SALT311.StrType)le.group_id),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.input_full_name),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.alt_phone),TRIM((SALT311.StrType)le.primary_email_address),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.guardian_fname),TRIM((SALT311.StrType)le.guardian_mname),TRIM((SALT311.StrType)le.guardian_lname),IF (le.guardian_dob <> 0,TRIM((SALT311.StrType)le.guardian_dob), ''),TRIM((SALT311.StrType)le.guardian_ssn),TRIM((SALT311.StrType)le.udf1),TRIM((SALT311.StrType)le.udf2),TRIM((SALT311.StrType)le.udf3),TRIM((SALT311.StrType)le.persistent_rid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),61*61,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'nomatch_id'}
      ,{2,'rid'}
      ,{3,'lexid'}
      ,{4,'lexid_score'}
      ,{5,'guardian_lexid'}
      ,{6,'guardian_lexid_score'}
      ,{7,'crk'}
      ,{8,'src'}
      ,{9,'source_rid'}
      ,{10,'dt_first_seen'}
      ,{11,'dt_last_seen'}
      ,{12,'dt_vendor_first_reported'}
      ,{13,'dt_vendor_last_reported'}
      ,{14,'member_id'}
      ,{15,'customer_id'}
      ,{16,'account_id'}
      ,{17,'subscriber_id'}
      ,{18,'group_id'}
      ,{19,'relationship_code'}
      ,{20,'title'}
      ,{21,'fname'}
      ,{22,'mname'}
      ,{23,'lname'}
      ,{24,'suffix'}
      ,{25,'input_full_name'}
      ,{26,'dob'}
      ,{27,'gender'}
      ,{28,'ssn'}
      ,{29,'home_phone'}
      ,{30,'alt_phone'}
      ,{31,'primary_email_address'}
      ,{32,'prim_range'}
      ,{33,'predir'}
      ,{34,'prim_name'}
      ,{35,'addr_suffix'}
      ,{36,'postdir'}
      ,{37,'unit_desig'}
      ,{38,'sec_range'}
      ,{39,'city_name'}
      ,{40,'st'}
      ,{41,'zip'}
      ,{42,'zip4'}
      ,{43,'rec_type'}
      ,{44,'county'}
      ,{45,'geo_lat'}
      ,{46,'geo_long'}
      ,{47,'msa'}
      ,{48,'geo_blk'}
      ,{49,'geo_match'}
      ,{50,'err_stat'}
      ,{51,'guardian_fname'}
      ,{52,'guardian_mname'}
      ,{53,'guardian_lname'}
      ,{54,'guardian_dob'}
      ,{55,'guardian_ssn'}
      ,{56,'udf1'}
      ,{57,'udf2'}
      ,{58,'udf3'}
      ,{59,'persistent_rid'}
      ,{60,'global_sid'}
      ,{61,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_nomatch_id((SALT311.StrType)le.nomatch_id),
    Fields.InValid_rid((SALT311.StrType)le.rid),
    Fields.InValid_lexid((SALT311.StrType)le.lexid),
    Fields.InValid_lexid_score((SALT311.StrType)le.lexid_score),
    Fields.InValid_guardian_lexid((SALT311.StrType)le.guardian_lexid),
    Fields.InValid_guardian_lexid_score((SALT311.StrType)le.guardian_lexid_score),
    Fields.InValid_crk((SALT311.StrType)le.crk),
    Fields.InValid_src((SALT311.StrType)le.src),
    Fields.InValid_source_rid((SALT311.StrType)le.source_rid),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_member_id((SALT311.StrType)le.member_id),
    Fields.InValid_customer_id((SALT311.StrType)le.customer_id),
    Fields.InValid_account_id((SALT311.StrType)le.account_id),
    Fields.InValid_subscriber_id((SALT311.StrType)le.subscriber_id),
    Fields.InValid_group_id((SALT311.StrType)le.group_id),
    Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_input_full_name((SALT311.StrType)le.input_full_name),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Fields.InValid_home_phone((SALT311.StrType)le.home_phone),
    Fields.InValid_alt_phone((SALT311.StrType)le.alt_phone),
    Fields.InValid_primary_email_address((SALT311.StrType)le.primary_email_address),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_city_name((SALT311.StrType)le.city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_guardian_fname((SALT311.StrType)le.guardian_fname),
    Fields.InValid_guardian_mname((SALT311.StrType)le.guardian_mname),
    Fields.InValid_guardian_lname((SALT311.StrType)le.guardian_lname),
    Fields.InValid_guardian_dob((SALT311.StrType)le.guardian_dob),
    Fields.InValid_guardian_ssn((SALT311.StrType)le.guardian_ssn),
    Fields.InValid_udf1((SALT311.StrType)le.udf1),
    Fields.InValid_udf2((SALT311.StrType)le.udf2),
    Fields.InValid_udf3((SALT311.StrType)le.udf3),
    Fields.InValid_persistent_rid((SALT311.StrType)le.persistent_rid),
    Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,61,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_nomatch_id(TotalErrors.ErrorNum),Fields.InValidMessage_rid(TotalErrors.ErrorNum),Fields.InValidMessage_lexid(TotalErrors.ErrorNum),Fields.InValidMessage_lexid_score(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_lexid(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_lexid_score(TotalErrors.ErrorNum),Fields.InValidMessage_crk(TotalErrors.ErrorNum),Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_source_rid(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_member_id(TotalErrors.ErrorNum),Fields.InValidMessage_customer_id(TotalErrors.ErrorNum),Fields.InValidMessage_account_id(TotalErrors.ErrorNum),Fields.InValidMessage_subscriber_id(TotalErrors.ErrorNum),Fields.InValidMessage_group_id(TotalErrors.ErrorNum),Fields.InValidMessage_relationship_code(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_input_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_home_phone(TotalErrors.ErrorNum),Fields.InValidMessage_alt_phone(TotalErrors.ErrorNum),Fields.InValidMessage_primary_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_fname(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_mname(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_lname(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_dob(TotalErrors.ErrorNum),Fields.InValidMessage_guardian_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_udf1(TotalErrors.ErrorNum),Fields.InValidMessage_udf2(TotalErrors.ErrorNum),Fields.InValidMessage_udf3(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_rid(TotalErrors.ErrorNum),Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(HealthcareNoMatchHeader, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
