IMPORT SALT311,STD;
EXPORT Base_Verified_hygiene(dataset(Base_Verified_layout_SKA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_id_ska_cnt := COUNT(GROUP,h.id_ska <> (TYPEOF(h.id_ska))'');
    populated_id_ska_pcnt := AVE(GROUP,IF(h.id_ska = (TYPEOF(h.id_ska))'',0,100));
    maxlength_id_ska := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.id_ska)));
    avelength_id_ska := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.id_ska)),h.id_ska<>(typeof(h.id_ska))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_ttl_cnt := COUNT(GROUP,h.ttl <> (TYPEOF(h.ttl))'');
    populated_ttl_pcnt := AVE(GROUP,IF(h.ttl = (TYPEOF(h.ttl))'',0,100));
    maxlength_ttl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ttl)));
    avelength_ttl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ttl)),h.ttl<>(typeof(h.ttl))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_cnt := COUNT(GROUP,h.middle <> (TYPEOF(h.middle))'');
    populated_middle_pcnt := AVE(GROUP,IF(h.middle = (TYPEOF(h.middle))'',0,100));
    maxlength_middle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle)));
    avelength_middle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle)),h.middle<>(typeof(h.middle))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_t1_cnt := COUNT(GROUP,h.t1 <> (TYPEOF(h.t1))'');
    populated_t1_pcnt := AVE(GROUP,IF(h.t1 = (TYPEOF(h.t1))'',0,100));
    maxlength_t1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.t1)));
    avelength_t1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.t1)),h.t1<>(typeof(h.t1))'');
    populated_do_cnt := COUNT(GROUP,h.do <> (TYPEOF(h.do))'');
    populated_do_pcnt := AVE(GROUP,IF(h.do = (TYPEOF(h.do))'',0,100));
    maxlength_do := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.do)));
    avelength_do := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.do)),h.do<>(typeof(h.do))'');
    populated_deptcode_cnt := COUNT(GROUP,h.deptcode <> (TYPEOF(h.deptcode))'');
    populated_deptcode_pcnt := AVE(GROUP,IF(h.deptcode = (TYPEOF(h.deptcode))'',0,100));
    maxlength_deptcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deptcode)));
    avelength_deptcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deptcode)),h.deptcode<>(typeof(h.deptcode))'');
    populated_dept_expl_cnt := COUNT(GROUP,h.dept_expl <> (TYPEOF(h.dept_expl))'');
    populated_dept_expl_pcnt := AVE(GROUP,IF(h.dept_expl = (TYPEOF(h.dept_expl))'',0,100));
    maxlength_dept_expl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dept_expl)));
    avelength_dept_expl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dept_expl)),h.dept_expl<>(typeof(h.dept_expl))'');
    populated_key_file_cnt := COUNT(GROUP,h.key_file <> (TYPEOF(h.key_file))'');
    populated_key_file_pcnt := AVE(GROUP,IF(h.key_file = (TYPEOF(h.key_file))'',0,100));
    maxlength_key_file := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.key_file)));
    avelength_key_file := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.key_file)),h.key_file<>(typeof(h.key_file))'');
    populated_company1_cnt := COUNT(GROUP,h.company1 <> (TYPEOF(h.company1))'');
    populated_company1_pcnt := AVE(GROUP,IF(h.company1 = (TYPEOF(h.company1))'',0,100));
    maxlength_company1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company1)));
    avelength_company1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company1)),h.company1<>(typeof(h.company1))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city2_cnt := COUNT(GROUP,h.city2 <> (TYPEOF(h.city2))'');
    populated_city2_pcnt := AVE(GROUP,IF(h.city2 = (TYPEOF(h.city2))'',0,100));
    maxlength_city2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city2)));
    avelength_city2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city2)),h.city2<>(typeof(h.city2))'');
    populated_state2_cnt := COUNT(GROUP,h.state2 <> (TYPEOF(h.state2))'');
    populated_state2_pcnt := AVE(GROUP,IF(h.state2 = (TYPEOF(h.state2))'',0,100));
    maxlength_state2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state2)));
    avelength_state2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state2)),h.state2<>(typeof(h.state2))'');
    populated_zip2_cnt := COUNT(GROUP,h.zip2 <> (TYPEOF(h.zip2))'');
    populated_zip2_pcnt := AVE(GROUP,IF(h.zip2 = (TYPEOF(h.zip2))'',0,100));
    maxlength_zip2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip2)));
    avelength_zip2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip2)),h.zip2<>(typeof(h.zip2))'');
    populated_fips_cnt := COUNT(GROUP,h.fips <> (TYPEOF(h.fips))'');
    populated_fips_pcnt := AVE(GROUP,IF(h.fips = (TYPEOF(h.fips))'',0,100));
    maxlength_fips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips)));
    avelength_fips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips)),h.fips<>(typeof(h.fips))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_spec_cnt := COUNT(GROUP,h.spec <> (TYPEOF(h.spec))'');
    populated_spec_pcnt := AVE(GROUP,IF(h.spec = (TYPEOF(h.spec))'',0,100));
    maxlength_spec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec)));
    avelength_spec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec)),h.spec<>(typeof(h.spec))'');
    populated_spec_expl_cnt := COUNT(GROUP,h.spec_expl <> (TYPEOF(h.spec_expl))'');
    populated_spec_expl_pcnt := AVE(GROUP,IF(h.spec_expl = (TYPEOF(h.spec_expl))'',0,100));
    maxlength_spec_expl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec_expl)));
    avelength_spec_expl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec_expl)),h.spec_expl<>(typeof(h.spec_expl))'');
    populated_spec2_cnt := COUNT(GROUP,h.spec2 <> (TYPEOF(h.spec2))'');
    populated_spec2_pcnt := AVE(GROUP,IF(h.spec2 = (TYPEOF(h.spec2))'',0,100));
    maxlength_spec2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec2)));
    avelength_spec2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec2)),h.spec2<>(typeof(h.spec2))'');
    populated_spec2_expl_cnt := COUNT(GROUP,h.spec2_expl <> (TYPEOF(h.spec2_expl))'');
    populated_spec2_expl_pcnt := AVE(GROUP,IF(h.spec2_expl = (TYPEOF(h.spec2_expl))'',0,100));
    maxlength_spec2_expl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec2_expl)));
    avelength_spec2_expl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec2_expl)),h.spec2_expl<>(typeof(h.spec2_expl))'');
    populated_spec3_cnt := COUNT(GROUP,h.spec3 <> (TYPEOF(h.spec3))'');
    populated_spec3_pcnt := AVE(GROUP,IF(h.spec3 = (TYPEOF(h.spec3))'',0,100));
    maxlength_spec3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec3)));
    avelength_spec3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec3)),h.spec3<>(typeof(h.spec3))'');
    populated_spec3_expl_cnt := COUNT(GROUP,h.spec3_expl <> (TYPEOF(h.spec3_expl))'');
    populated_spec3_expl_pcnt := AVE(GROUP,IF(h.spec3_expl = (TYPEOF(h.spec3_expl))'',0,100));
    maxlength_spec3_expl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec3_expl)));
    avelength_spec3_expl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec3_expl)),h.spec3_expl<>(typeof(h.spec3_expl))'');
    populated_persid_cnt := COUNT(GROUP,h.persid <> (TYPEOF(h.persid))'');
    populated_persid_pcnt := AVE(GROUP,IF(h.persid = (TYPEOF(h.persid))'',0,100));
    maxlength_persid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persid)));
    avelength_persid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persid)),h.persid<>(typeof(h.persid))'');
    populated_owner_cnt := COUNT(GROUP,h.owner <> (TYPEOF(h.owner))'');
    populated_owner_pcnt := AVE(GROUP,IF(h.owner = (TYPEOF(h.owner))'',0,100));
    maxlength_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner)));
    avelength_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner)),h.owner<>(typeof(h.owner))'');
    populated_emailavail_cnt := COUNT(GROUP,h.emailavail <> (TYPEOF(h.emailavail))'');
    populated_emailavail_pcnt := AVE(GROUP,IF(h.emailavail = (TYPEOF(h.emailavail))'',0,100));
    maxlength_emailavail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailavail)));
    avelength_emailavail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailavail)),h.emailavail<>(typeof(h.emailavail))'');
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
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_mail_prim_range_cnt := COUNT(GROUP,h.mail_prim_range <> (TYPEOF(h.mail_prim_range))'');
    populated_mail_prim_range_pcnt := AVE(GROUP,IF(h.mail_prim_range = (TYPEOF(h.mail_prim_range))'',0,100));
    maxlength_mail_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_range)));
    avelength_mail_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_range)),h.mail_prim_range<>(typeof(h.mail_prim_range))'');
    populated_mail_predir_cnt := COUNT(GROUP,h.mail_predir <> (TYPEOF(h.mail_predir))'');
    populated_mail_predir_pcnt := AVE(GROUP,IF(h.mail_predir = (TYPEOF(h.mail_predir))'',0,100));
    maxlength_mail_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_predir)));
    avelength_mail_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_predir)),h.mail_predir<>(typeof(h.mail_predir))'');
    populated_mail_prim_name_cnt := COUNT(GROUP,h.mail_prim_name <> (TYPEOF(h.mail_prim_name))'');
    populated_mail_prim_name_pcnt := AVE(GROUP,IF(h.mail_prim_name = (TYPEOF(h.mail_prim_name))'',0,100));
    maxlength_mail_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_name)));
    avelength_mail_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_name)),h.mail_prim_name<>(typeof(h.mail_prim_name))'');
    populated_mail_addr_suffix_cnt := COUNT(GROUP,h.mail_addr_suffix <> (TYPEOF(h.mail_addr_suffix))'');
    populated_mail_addr_suffix_pcnt := AVE(GROUP,IF(h.mail_addr_suffix = (TYPEOF(h.mail_addr_suffix))'',0,100));
    maxlength_mail_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_suffix)));
    avelength_mail_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_suffix)),h.mail_addr_suffix<>(typeof(h.mail_addr_suffix))'');
    populated_mail_postdir_cnt := COUNT(GROUP,h.mail_postdir <> (TYPEOF(h.mail_postdir))'');
    populated_mail_postdir_pcnt := AVE(GROUP,IF(h.mail_postdir = (TYPEOF(h.mail_postdir))'',0,100));
    maxlength_mail_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_postdir)));
    avelength_mail_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_postdir)),h.mail_postdir<>(typeof(h.mail_postdir))'');
    populated_mail_unit_desig_cnt := COUNT(GROUP,h.mail_unit_desig <> (TYPEOF(h.mail_unit_desig))'');
    populated_mail_unit_desig_pcnt := AVE(GROUP,IF(h.mail_unit_desig = (TYPEOF(h.mail_unit_desig))'',0,100));
    maxlength_mail_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_unit_desig)));
    avelength_mail_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_unit_desig)),h.mail_unit_desig<>(typeof(h.mail_unit_desig))'');
    populated_mail_sec_range_cnt := COUNT(GROUP,h.mail_sec_range <> (TYPEOF(h.mail_sec_range))'');
    populated_mail_sec_range_pcnt := AVE(GROUP,IF(h.mail_sec_range = (TYPEOF(h.mail_sec_range))'',0,100));
    maxlength_mail_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_sec_range)));
    avelength_mail_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_sec_range)),h.mail_sec_range<>(typeof(h.mail_sec_range))'');
    populated_mail_p_city_name_cnt := COUNT(GROUP,h.mail_p_city_name <> (TYPEOF(h.mail_p_city_name))'');
    populated_mail_p_city_name_pcnt := AVE(GROUP,IF(h.mail_p_city_name = (TYPEOF(h.mail_p_city_name))'',0,100));
    maxlength_mail_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_p_city_name)));
    avelength_mail_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_p_city_name)),h.mail_p_city_name<>(typeof(h.mail_p_city_name))'');
    populated_mail_v_city_name_cnt := COUNT(GROUP,h.mail_v_city_name <> (TYPEOF(h.mail_v_city_name))'');
    populated_mail_v_city_name_pcnt := AVE(GROUP,IF(h.mail_v_city_name = (TYPEOF(h.mail_v_city_name))'',0,100));
    maxlength_mail_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_v_city_name)));
    avelength_mail_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_v_city_name)),h.mail_v_city_name<>(typeof(h.mail_v_city_name))'');
    populated_mail_st_cnt := COUNT(GROUP,h.mail_st <> (TYPEOF(h.mail_st))'');
    populated_mail_st_pcnt := AVE(GROUP,IF(h.mail_st = (TYPEOF(h.mail_st))'',0,100));
    maxlength_mail_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_st)));
    avelength_mail_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_st)),h.mail_st<>(typeof(h.mail_st))'');
    populated_mail_zip_cnt := COUNT(GROUP,h.mail_zip <> (TYPEOF(h.mail_zip))'');
    populated_mail_zip_pcnt := AVE(GROUP,IF(h.mail_zip = (TYPEOF(h.mail_zip))'',0,100));
    maxlength_mail_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip)));
    avelength_mail_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip)),h.mail_zip<>(typeof(h.mail_zip))'');
    populated_mail_zip4_cnt := COUNT(GROUP,h.mail_zip4 <> (TYPEOF(h.mail_zip4))'');
    populated_mail_zip4_pcnt := AVE(GROUP,IF(h.mail_zip4 = (TYPEOF(h.mail_zip4))'',0,100));
    maxlength_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip4)));
    avelength_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip4)),h.mail_zip4<>(typeof(h.mail_zip4))'');
    populated_mail_cart_cnt := COUNT(GROUP,h.mail_cart <> (TYPEOF(h.mail_cart))'');
    populated_mail_cart_pcnt := AVE(GROUP,IF(h.mail_cart = (TYPEOF(h.mail_cart))'',0,100));
    maxlength_mail_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cart)));
    avelength_mail_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cart)),h.mail_cart<>(typeof(h.mail_cart))'');
    populated_mail_cr_sort_sz_cnt := COUNT(GROUP,h.mail_cr_sort_sz <> (TYPEOF(h.mail_cr_sort_sz))'');
    populated_mail_cr_sort_sz_pcnt := AVE(GROUP,IF(h.mail_cr_sort_sz = (TYPEOF(h.mail_cr_sort_sz))'',0,100));
    maxlength_mail_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cr_sort_sz)));
    avelength_mail_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cr_sort_sz)),h.mail_cr_sort_sz<>(typeof(h.mail_cr_sort_sz))'');
    populated_mail_lot_cnt := COUNT(GROUP,h.mail_lot <> (TYPEOF(h.mail_lot))'');
    populated_mail_lot_pcnt := AVE(GROUP,IF(h.mail_lot = (TYPEOF(h.mail_lot))'',0,100));
    maxlength_mail_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot)));
    avelength_mail_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot)),h.mail_lot<>(typeof(h.mail_lot))'');
    populated_mail_lot_order_cnt := COUNT(GROUP,h.mail_lot_order <> (TYPEOF(h.mail_lot_order))'');
    populated_mail_lot_order_pcnt := AVE(GROUP,IF(h.mail_lot_order = (TYPEOF(h.mail_lot_order))'',0,100));
    maxlength_mail_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot_order)));
    avelength_mail_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot_order)),h.mail_lot_order<>(typeof(h.mail_lot_order))'');
    populated_mail_dbpc_cnt := COUNT(GROUP,h.mail_dbpc <> (TYPEOF(h.mail_dbpc))'');
    populated_mail_dbpc_pcnt := AVE(GROUP,IF(h.mail_dbpc = (TYPEOF(h.mail_dbpc))'',0,100));
    maxlength_mail_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_dbpc)));
    avelength_mail_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_dbpc)),h.mail_dbpc<>(typeof(h.mail_dbpc))'');
    populated_mail_chk_digit_cnt := COUNT(GROUP,h.mail_chk_digit <> (TYPEOF(h.mail_chk_digit))'');
    populated_mail_chk_digit_pcnt := AVE(GROUP,IF(h.mail_chk_digit = (TYPEOF(h.mail_chk_digit))'',0,100));
    maxlength_mail_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_chk_digit)));
    avelength_mail_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_chk_digit)),h.mail_chk_digit<>(typeof(h.mail_chk_digit))'');
    populated_mail_rec_type_cnt := COUNT(GROUP,h.mail_rec_type <> (TYPEOF(h.mail_rec_type))'');
    populated_mail_rec_type_pcnt := AVE(GROUP,IF(h.mail_rec_type = (TYPEOF(h.mail_rec_type))'',0,100));
    maxlength_mail_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_rec_type)));
    avelength_mail_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_rec_type)),h.mail_rec_type<>(typeof(h.mail_rec_type))'');
    populated_mail_ace_fips_state_cnt := COUNT(GROUP,h.mail_ace_fips_state <> (TYPEOF(h.mail_ace_fips_state))'');
    populated_mail_ace_fips_state_pcnt := AVE(GROUP,IF(h.mail_ace_fips_state = (TYPEOF(h.mail_ace_fips_state))'',0,100));
    maxlength_mail_ace_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_ace_fips_state)));
    avelength_mail_ace_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_ace_fips_state)),h.mail_ace_fips_state<>(typeof(h.mail_ace_fips_state))'');
    populated_mail_county_cnt := COUNT(GROUP,h.mail_county <> (TYPEOF(h.mail_county))'');
    populated_mail_county_pcnt := AVE(GROUP,IF(h.mail_county = (TYPEOF(h.mail_county))'',0,100));
    maxlength_mail_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_county)));
    avelength_mail_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_county)),h.mail_county<>(typeof(h.mail_county))'');
    populated_mail_geo_lat_cnt := COUNT(GROUP,h.mail_geo_lat <> (TYPEOF(h.mail_geo_lat))'');
    populated_mail_geo_lat_pcnt := AVE(GROUP,IF(h.mail_geo_lat = (TYPEOF(h.mail_geo_lat))'',0,100));
    maxlength_mail_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_lat)));
    avelength_mail_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_lat)),h.mail_geo_lat<>(typeof(h.mail_geo_lat))'');
    populated_mail_geo_long_cnt := COUNT(GROUP,h.mail_geo_long <> (TYPEOF(h.mail_geo_long))'');
    populated_mail_geo_long_pcnt := AVE(GROUP,IF(h.mail_geo_long = (TYPEOF(h.mail_geo_long))'',0,100));
    maxlength_mail_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_long)));
    avelength_mail_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_long)),h.mail_geo_long<>(typeof(h.mail_geo_long))'');
    populated_mail_msa_cnt := COUNT(GROUP,h.mail_msa <> (TYPEOF(h.mail_msa))'');
    populated_mail_msa_pcnt := AVE(GROUP,IF(h.mail_msa = (TYPEOF(h.mail_msa))'',0,100));
    maxlength_mail_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_msa)));
    avelength_mail_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_msa)),h.mail_msa<>(typeof(h.mail_msa))'');
    populated_mail_geo_blk_cnt := COUNT(GROUP,h.mail_geo_blk <> (TYPEOF(h.mail_geo_blk))'');
    populated_mail_geo_blk_pcnt := AVE(GROUP,IF(h.mail_geo_blk = (TYPEOF(h.mail_geo_blk))'',0,100));
    maxlength_mail_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_blk)));
    avelength_mail_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_blk)),h.mail_geo_blk<>(typeof(h.mail_geo_blk))'');
    populated_mail_geo_match_cnt := COUNT(GROUP,h.mail_geo_match <> (TYPEOF(h.mail_geo_match))'');
    populated_mail_geo_match_pcnt := AVE(GROUP,IF(h.mail_geo_match = (TYPEOF(h.mail_geo_match))'',0,100));
    maxlength_mail_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_match)));
    avelength_mail_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_match)),h.mail_geo_match<>(typeof(h.mail_geo_match))'');
    populated_mail_err_stat_cnt := COUNT(GROUP,h.mail_err_stat <> (TYPEOF(h.mail_err_stat))'');
    populated_mail_err_stat_pcnt := AVE(GROUP,IF(h.mail_err_stat = (TYPEOF(h.mail_err_stat))'',0,100));
    maxlength_mail_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_err_stat)));
    avelength_mail_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_err_stat)),h.mail_err_stat<>(typeof(h.mail_err_stat))'');
    populated_alt_prim_range_cnt := COUNT(GROUP,h.alt_prim_range <> (TYPEOF(h.alt_prim_range))'');
    populated_alt_prim_range_pcnt := AVE(GROUP,IF(h.alt_prim_range = (TYPEOF(h.alt_prim_range))'',0,100));
    maxlength_alt_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_prim_range)));
    avelength_alt_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_prim_range)),h.alt_prim_range<>(typeof(h.alt_prim_range))'');
    populated_alt_predir_cnt := COUNT(GROUP,h.alt_predir <> (TYPEOF(h.alt_predir))'');
    populated_alt_predir_pcnt := AVE(GROUP,IF(h.alt_predir = (TYPEOF(h.alt_predir))'',0,100));
    maxlength_alt_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_predir)));
    avelength_alt_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_predir)),h.alt_predir<>(typeof(h.alt_predir))'');
    populated_alt_prim_name_cnt := COUNT(GROUP,h.alt_prim_name <> (TYPEOF(h.alt_prim_name))'');
    populated_alt_prim_name_pcnt := AVE(GROUP,IF(h.alt_prim_name = (TYPEOF(h.alt_prim_name))'',0,100));
    maxlength_alt_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_prim_name)));
    avelength_alt_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_prim_name)),h.alt_prim_name<>(typeof(h.alt_prim_name))'');
    populated_alt_addr_suffix_cnt := COUNT(GROUP,h.alt_addr_suffix <> (TYPEOF(h.alt_addr_suffix))'');
    populated_alt_addr_suffix_pcnt := AVE(GROUP,IF(h.alt_addr_suffix = (TYPEOF(h.alt_addr_suffix))'',0,100));
    maxlength_alt_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_addr_suffix)));
    avelength_alt_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_addr_suffix)),h.alt_addr_suffix<>(typeof(h.alt_addr_suffix))'');
    populated_alt_postdir_cnt := COUNT(GROUP,h.alt_postdir <> (TYPEOF(h.alt_postdir))'');
    populated_alt_postdir_pcnt := AVE(GROUP,IF(h.alt_postdir = (TYPEOF(h.alt_postdir))'',0,100));
    maxlength_alt_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_postdir)));
    avelength_alt_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_postdir)),h.alt_postdir<>(typeof(h.alt_postdir))'');
    populated_alt_unit_desig_cnt := COUNT(GROUP,h.alt_unit_desig <> (TYPEOF(h.alt_unit_desig))'');
    populated_alt_unit_desig_pcnt := AVE(GROUP,IF(h.alt_unit_desig = (TYPEOF(h.alt_unit_desig))'',0,100));
    maxlength_alt_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_unit_desig)));
    avelength_alt_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_unit_desig)),h.alt_unit_desig<>(typeof(h.alt_unit_desig))'');
    populated_alt_sec_range_cnt := COUNT(GROUP,h.alt_sec_range <> (TYPEOF(h.alt_sec_range))'');
    populated_alt_sec_range_pcnt := AVE(GROUP,IF(h.alt_sec_range = (TYPEOF(h.alt_sec_range))'',0,100));
    maxlength_alt_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_sec_range)));
    avelength_alt_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_sec_range)),h.alt_sec_range<>(typeof(h.alt_sec_range))'');
    populated_alt_p_city_name_cnt := COUNT(GROUP,h.alt_p_city_name <> (TYPEOF(h.alt_p_city_name))'');
    populated_alt_p_city_name_pcnt := AVE(GROUP,IF(h.alt_p_city_name = (TYPEOF(h.alt_p_city_name))'',0,100));
    maxlength_alt_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_p_city_name)));
    avelength_alt_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_p_city_name)),h.alt_p_city_name<>(typeof(h.alt_p_city_name))'');
    populated_alt_v_city_name_cnt := COUNT(GROUP,h.alt_v_city_name <> (TYPEOF(h.alt_v_city_name))'');
    populated_alt_v_city_name_pcnt := AVE(GROUP,IF(h.alt_v_city_name = (TYPEOF(h.alt_v_city_name))'',0,100));
    maxlength_alt_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_v_city_name)));
    avelength_alt_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_v_city_name)),h.alt_v_city_name<>(typeof(h.alt_v_city_name))'');
    populated_alt_st_cnt := COUNT(GROUP,h.alt_st <> (TYPEOF(h.alt_st))'');
    populated_alt_st_pcnt := AVE(GROUP,IF(h.alt_st = (TYPEOF(h.alt_st))'',0,100));
    maxlength_alt_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_st)));
    avelength_alt_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_st)),h.alt_st<>(typeof(h.alt_st))'');
    populated_alt_zip_cnt := COUNT(GROUP,h.alt_zip <> (TYPEOF(h.alt_zip))'');
    populated_alt_zip_pcnt := AVE(GROUP,IF(h.alt_zip = (TYPEOF(h.alt_zip))'',0,100));
    maxlength_alt_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_zip)));
    avelength_alt_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_zip)),h.alt_zip<>(typeof(h.alt_zip))'');
    populated_alt_zip4_cnt := COUNT(GROUP,h.alt_zip4 <> (TYPEOF(h.alt_zip4))'');
    populated_alt_zip4_pcnt := AVE(GROUP,IF(h.alt_zip4 = (TYPEOF(h.alt_zip4))'',0,100));
    maxlength_alt_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_zip4)));
    avelength_alt_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_zip4)),h.alt_zip4<>(typeof(h.alt_zip4))'');
    populated_alt_cart_cnt := COUNT(GROUP,h.alt_cart <> (TYPEOF(h.alt_cart))'');
    populated_alt_cart_pcnt := AVE(GROUP,IF(h.alt_cart = (TYPEOF(h.alt_cart))'',0,100));
    maxlength_alt_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_cart)));
    avelength_alt_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_cart)),h.alt_cart<>(typeof(h.alt_cart))'');
    populated_alt_cr_sort_sz_cnt := COUNT(GROUP,h.alt_cr_sort_sz <> (TYPEOF(h.alt_cr_sort_sz))'');
    populated_alt_cr_sort_sz_pcnt := AVE(GROUP,IF(h.alt_cr_sort_sz = (TYPEOF(h.alt_cr_sort_sz))'',0,100));
    maxlength_alt_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_cr_sort_sz)));
    avelength_alt_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_cr_sort_sz)),h.alt_cr_sort_sz<>(typeof(h.alt_cr_sort_sz))'');
    populated_alt_lot_cnt := COUNT(GROUP,h.alt_lot <> (TYPEOF(h.alt_lot))'');
    populated_alt_lot_pcnt := AVE(GROUP,IF(h.alt_lot = (TYPEOF(h.alt_lot))'',0,100));
    maxlength_alt_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_lot)));
    avelength_alt_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_lot)),h.alt_lot<>(typeof(h.alt_lot))'');
    populated_alt_lot_order_cnt := COUNT(GROUP,h.alt_lot_order <> (TYPEOF(h.alt_lot_order))'');
    populated_alt_lot_order_pcnt := AVE(GROUP,IF(h.alt_lot_order = (TYPEOF(h.alt_lot_order))'',0,100));
    maxlength_alt_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_lot_order)));
    avelength_alt_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_lot_order)),h.alt_lot_order<>(typeof(h.alt_lot_order))'');
    populated_alt_dbpc_cnt := COUNT(GROUP,h.alt_dbpc <> (TYPEOF(h.alt_dbpc))'');
    populated_alt_dbpc_pcnt := AVE(GROUP,IF(h.alt_dbpc = (TYPEOF(h.alt_dbpc))'',0,100));
    maxlength_alt_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_dbpc)));
    avelength_alt_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_dbpc)),h.alt_dbpc<>(typeof(h.alt_dbpc))'');
    populated_alt_chk_digit_cnt := COUNT(GROUP,h.alt_chk_digit <> (TYPEOF(h.alt_chk_digit))'');
    populated_alt_chk_digit_pcnt := AVE(GROUP,IF(h.alt_chk_digit = (TYPEOF(h.alt_chk_digit))'',0,100));
    maxlength_alt_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_chk_digit)));
    avelength_alt_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_chk_digit)),h.alt_chk_digit<>(typeof(h.alt_chk_digit))'');
    populated_alt_rec_type_cnt := COUNT(GROUP,h.alt_rec_type <> (TYPEOF(h.alt_rec_type))'');
    populated_alt_rec_type_pcnt := AVE(GROUP,IF(h.alt_rec_type = (TYPEOF(h.alt_rec_type))'',0,100));
    maxlength_alt_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_rec_type)));
    avelength_alt_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_rec_type)),h.alt_rec_type<>(typeof(h.alt_rec_type))'');
    populated_alt_ace_fips_state_cnt := COUNT(GROUP,h.alt_ace_fips_state <> (TYPEOF(h.alt_ace_fips_state))'');
    populated_alt_ace_fips_state_pcnt := AVE(GROUP,IF(h.alt_ace_fips_state = (TYPEOF(h.alt_ace_fips_state))'',0,100));
    maxlength_alt_ace_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_ace_fips_state)));
    avelength_alt_ace_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_ace_fips_state)),h.alt_ace_fips_state<>(typeof(h.alt_ace_fips_state))'');
    populated_alt_county_cnt := COUNT(GROUP,h.alt_county <> (TYPEOF(h.alt_county))'');
    populated_alt_county_pcnt := AVE(GROUP,IF(h.alt_county = (TYPEOF(h.alt_county))'',0,100));
    maxlength_alt_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_county)));
    avelength_alt_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_county)),h.alt_county<>(typeof(h.alt_county))'');
    populated_alt_geo_lat_cnt := COUNT(GROUP,h.alt_geo_lat <> (TYPEOF(h.alt_geo_lat))'');
    populated_alt_geo_lat_pcnt := AVE(GROUP,IF(h.alt_geo_lat = (TYPEOF(h.alt_geo_lat))'',0,100));
    maxlength_alt_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_lat)));
    avelength_alt_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_lat)),h.alt_geo_lat<>(typeof(h.alt_geo_lat))'');
    populated_alt_geo_long_cnt := COUNT(GROUP,h.alt_geo_long <> (TYPEOF(h.alt_geo_long))'');
    populated_alt_geo_long_pcnt := AVE(GROUP,IF(h.alt_geo_long = (TYPEOF(h.alt_geo_long))'',0,100));
    maxlength_alt_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_long)));
    avelength_alt_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_long)),h.alt_geo_long<>(typeof(h.alt_geo_long))'');
    populated_alt_msa_cnt := COUNT(GROUP,h.alt_msa <> (TYPEOF(h.alt_msa))'');
    populated_alt_msa_pcnt := AVE(GROUP,IF(h.alt_msa = (TYPEOF(h.alt_msa))'',0,100));
    maxlength_alt_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_msa)));
    avelength_alt_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_msa)),h.alt_msa<>(typeof(h.alt_msa))'');
    populated_alt_geo_blk_cnt := COUNT(GROUP,h.alt_geo_blk <> (TYPEOF(h.alt_geo_blk))'');
    populated_alt_geo_blk_pcnt := AVE(GROUP,IF(h.alt_geo_blk = (TYPEOF(h.alt_geo_blk))'',0,100));
    maxlength_alt_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_blk)));
    avelength_alt_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_blk)),h.alt_geo_blk<>(typeof(h.alt_geo_blk))'');
    populated_alt_geo_match_cnt := COUNT(GROUP,h.alt_geo_match <> (TYPEOF(h.alt_geo_match))'');
    populated_alt_geo_match_pcnt := AVE(GROUP,IF(h.alt_geo_match = (TYPEOF(h.alt_geo_match))'',0,100));
    maxlength_alt_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_match)));
    avelength_alt_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_geo_match)),h.alt_geo_match<>(typeof(h.alt_geo_match))'');
    populated_alt_err_stat_cnt := COUNT(GROUP,h.alt_err_stat <> (TYPEOF(h.alt_err_stat))'');
    populated_alt_err_stat_pcnt := AVE(GROUP,IF(h.alt_err_stat = (TYPEOF(h.alt_err_stat))'',0,100));
    maxlength_alt_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_err_stat)));
    avelength_alt_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_err_stat)),h.alt_err_stat<>(typeof(h.alt_err_stat))'');
    populated_lf_cnt := COUNT(GROUP,h.lf <> (TYPEOF(h.lf))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_id_ska_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_ttl_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_t1_pcnt *   0.00 / 100 + T.Populated_do_pcnt *   0.00 / 100 + T.Populated_deptcode_pcnt *   0.00 / 100 + T.Populated_dept_expl_pcnt *   0.00 / 100 + T.Populated_key_file_pcnt *   0.00 / 100 + T.Populated_company1_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city2_pcnt *   0.00 / 100 + T.Populated_state2_pcnt *   0.00 / 100 + T.Populated_zip2_pcnt *   0.00 / 100 + T.Populated_fips_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_spec_pcnt *   0.00 / 100 + T.Populated_spec_expl_pcnt *   0.00 / 100 + T.Populated_spec2_pcnt *   0.00 / 100 + T.Populated_spec2_expl_pcnt *   0.00 / 100 + T.Populated_spec3_pcnt *   0.00 / 100 + T.Populated_spec3_expl_pcnt *   0.00 / 100 + T.Populated_persid_pcnt *   0.00 / 100 + T.Populated_owner_pcnt *   0.00 / 100 + T.Populated_emailavail_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_mail_prim_range_pcnt *   0.00 / 100 + T.Populated_mail_predir_pcnt *   0.00 / 100 + T.Populated_mail_prim_name_pcnt *   0.00 / 100 + T.Populated_mail_addr_suffix_pcnt *   0.00 / 100 + T.Populated_mail_postdir_pcnt *   0.00 / 100 + T.Populated_mail_unit_desig_pcnt *   0.00 / 100 + T.Populated_mail_sec_range_pcnt *   0.00 / 100 + T.Populated_mail_p_city_name_pcnt *   0.00 / 100 + T.Populated_mail_v_city_name_pcnt *   0.00 / 100 + T.Populated_mail_st_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_mail_cart_pcnt *   0.00 / 100 + T.Populated_mail_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_mail_lot_pcnt *   0.00 / 100 + T.Populated_mail_lot_order_pcnt *   0.00 / 100 + T.Populated_mail_dbpc_pcnt *   0.00 / 100 + T.Populated_mail_chk_digit_pcnt *   0.00 / 100 + T.Populated_mail_rec_type_pcnt *   0.00 / 100 + T.Populated_mail_ace_fips_state_pcnt *   0.00 / 100 + T.Populated_mail_county_pcnt *   0.00 / 100 + T.Populated_mail_geo_lat_pcnt *   0.00 / 100 + T.Populated_mail_geo_long_pcnt *   0.00 / 100 + T.Populated_mail_msa_pcnt *   0.00 / 100 + T.Populated_mail_geo_blk_pcnt *   0.00 / 100 + T.Populated_mail_geo_match_pcnt *   0.00 / 100 + T.Populated_mail_err_stat_pcnt *   0.00 / 100 + T.Populated_alt_prim_range_pcnt *   0.00 / 100 + T.Populated_alt_predir_pcnt *   0.00 / 100 + T.Populated_alt_prim_name_pcnt *   0.00 / 100 + T.Populated_alt_addr_suffix_pcnt *   0.00 / 100 + T.Populated_alt_postdir_pcnt *   0.00 / 100 + T.Populated_alt_unit_desig_pcnt *   0.00 / 100 + T.Populated_alt_sec_range_pcnt *   0.00 / 100 + T.Populated_alt_p_city_name_pcnt *   0.00 / 100 + T.Populated_alt_v_city_name_pcnt *   0.00 / 100 + T.Populated_alt_st_pcnt *   0.00 / 100 + T.Populated_alt_zip_pcnt *   0.00 / 100 + T.Populated_alt_zip4_pcnt *   0.00 / 100 + T.Populated_alt_cart_pcnt *   0.00 / 100 + T.Populated_alt_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_alt_lot_pcnt *   0.00 / 100 + T.Populated_alt_lot_order_pcnt *   0.00 / 100 + T.Populated_alt_dbpc_pcnt *   0.00 / 100 + T.Populated_alt_chk_digit_pcnt *   0.00 / 100 + T.Populated_alt_rec_type_pcnt *   0.00 / 100 + T.Populated_alt_ace_fips_state_pcnt *   0.00 / 100 + T.Populated_alt_county_pcnt *   0.00 / 100 + T.Populated_alt_geo_lat_pcnt *   0.00 / 100 + T.Populated_alt_geo_long_pcnt *   0.00 / 100 + T.Populated_alt_msa_pcnt *   0.00 / 100 + T.Populated_alt_geo_blk_pcnt *   0.00 / 100 + T.Populated_alt_geo_match_pcnt *   0.00 / 100 + T.Populated_alt_err_stat_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'id_ska','bdid','ttl','first_name','middle','last_name','t1','do','deptcode','dept_expl','key_file','company1','address1','city','state','zip','address2','city2','state2','zip2','fips','phone','spec','spec_expl','spec2','spec2_expl','spec3','spec3_expl','persid','owner','emailavail','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','alt_prim_range','alt_predir','alt_prim_name','alt_addr_suffix','alt_postdir','alt_unit_desig','alt_sec_range','alt_p_city_name','alt_v_city_name','alt_st','alt_zip','alt_zip4','alt_cart','alt_cr_sort_sz','alt_lot','alt_lot_order','alt_dbpc','alt_chk_digit','alt_rec_type','alt_ace_fips_state','alt_county','alt_geo_lat','alt_geo_long','alt_msa','alt_geo_blk','alt_geo_match','alt_err_stat','lf','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_id_ska_pcnt,le.populated_bdid_pcnt,le.populated_ttl_pcnt,le.populated_first_name_pcnt,le.populated_middle_pcnt,le.populated_last_name_pcnt,le.populated_t1_pcnt,le.populated_do_pcnt,le.populated_deptcode_pcnt,le.populated_dept_expl_pcnt,le.populated_key_file_pcnt,le.populated_company1_pcnt,le.populated_address1_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_address2_pcnt,le.populated_city2_pcnt,le.populated_state2_pcnt,le.populated_zip2_pcnt,le.populated_fips_pcnt,le.populated_phone_pcnt,le.populated_spec_pcnt,le.populated_spec_expl_pcnt,le.populated_spec2_pcnt,le.populated_spec2_expl_pcnt,le.populated_spec3_pcnt,le.populated_spec3_expl_pcnt,le.populated_persid_pcnt,le.populated_owner_pcnt,le.populated_emailavail_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_mail_prim_range_pcnt,le.populated_mail_predir_pcnt,le.populated_mail_prim_name_pcnt,le.populated_mail_addr_suffix_pcnt,le.populated_mail_postdir_pcnt,le.populated_mail_unit_desig_pcnt,le.populated_mail_sec_range_pcnt,le.populated_mail_p_city_name_pcnt,le.populated_mail_v_city_name_pcnt,le.populated_mail_st_pcnt,le.populated_mail_zip_pcnt,le.populated_mail_zip4_pcnt,le.populated_mail_cart_pcnt,le.populated_mail_cr_sort_sz_pcnt,le.populated_mail_lot_pcnt,le.populated_mail_lot_order_pcnt,le.populated_mail_dbpc_pcnt,le.populated_mail_chk_digit_pcnt,le.populated_mail_rec_type_pcnt,le.populated_mail_ace_fips_state_pcnt,le.populated_mail_county_pcnt,le.populated_mail_geo_lat_pcnt,le.populated_mail_geo_long_pcnt,le.populated_mail_msa_pcnt,le.populated_mail_geo_blk_pcnt,le.populated_mail_geo_match_pcnt,le.populated_mail_err_stat_pcnt,le.populated_alt_prim_range_pcnt,le.populated_alt_predir_pcnt,le.populated_alt_prim_name_pcnt,le.populated_alt_addr_suffix_pcnt,le.populated_alt_postdir_pcnt,le.populated_alt_unit_desig_pcnt,le.populated_alt_sec_range_pcnt,le.populated_alt_p_city_name_pcnt,le.populated_alt_v_city_name_pcnt,le.populated_alt_st_pcnt,le.populated_alt_zip_pcnt,le.populated_alt_zip4_pcnt,le.populated_alt_cart_pcnt,le.populated_alt_cr_sort_sz_pcnt,le.populated_alt_lot_pcnt,le.populated_alt_lot_order_pcnt,le.populated_alt_dbpc_pcnt,le.populated_alt_chk_digit_pcnt,le.populated_alt_rec_type_pcnt,le.populated_alt_ace_fips_state_pcnt,le.populated_alt_county_pcnt,le.populated_alt_geo_lat_pcnt,le.populated_alt_geo_long_pcnt,le.populated_alt_msa_pcnt,le.populated_alt_geo_blk_pcnt,le.populated_alt_geo_match_pcnt,le.populated_alt_err_stat_pcnt,le.populated_lf_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_id_ska,le.maxlength_bdid,le.maxlength_ttl,le.maxlength_first_name,le.maxlength_middle,le.maxlength_last_name,le.maxlength_t1,le.maxlength_do,le.maxlength_deptcode,le.maxlength_dept_expl,le.maxlength_key_file,le.maxlength_company1,le.maxlength_address1,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_address2,le.maxlength_city2,le.maxlength_state2,le.maxlength_zip2,le.maxlength_fips,le.maxlength_phone,le.maxlength_spec,le.maxlength_spec_expl,le.maxlength_spec2,le.maxlength_spec2_expl,le.maxlength_spec3,le.maxlength_spec3_expl,le.maxlength_persid,le.maxlength_owner,le.maxlength_emailavail,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_mail_prim_range,le.maxlength_mail_predir,le.maxlength_mail_prim_name,le.maxlength_mail_addr_suffix,le.maxlength_mail_postdir,le.maxlength_mail_unit_desig,le.maxlength_mail_sec_range,le.maxlength_mail_p_city_name,le.maxlength_mail_v_city_name,le.maxlength_mail_st,le.maxlength_mail_zip,le.maxlength_mail_zip4,le.maxlength_mail_cart,le.maxlength_mail_cr_sort_sz,le.maxlength_mail_lot,le.maxlength_mail_lot_order,le.maxlength_mail_dbpc,le.maxlength_mail_chk_digit,le.maxlength_mail_rec_type,le.maxlength_mail_ace_fips_state,le.maxlength_mail_county,le.maxlength_mail_geo_lat,le.maxlength_mail_geo_long,le.maxlength_mail_msa,le.maxlength_mail_geo_blk,le.maxlength_mail_geo_match,le.maxlength_mail_err_stat,le.maxlength_alt_prim_range,le.maxlength_alt_predir,le.maxlength_alt_prim_name,le.maxlength_alt_addr_suffix,le.maxlength_alt_postdir,le.maxlength_alt_unit_desig,le.maxlength_alt_sec_range,le.maxlength_alt_p_city_name,le.maxlength_alt_v_city_name,le.maxlength_alt_st,le.maxlength_alt_zip,le.maxlength_alt_zip4,le.maxlength_alt_cart,le.maxlength_alt_cr_sort_sz,le.maxlength_alt_lot,le.maxlength_alt_lot_order,le.maxlength_alt_dbpc,le.maxlength_alt_chk_digit,le.maxlength_alt_rec_type,le.maxlength_alt_ace_fips_state,le.maxlength_alt_county,le.maxlength_alt_geo_lat,le.maxlength_alt_geo_long,le.maxlength_alt_msa,le.maxlength_alt_geo_blk,le.maxlength_alt_geo_match,le.maxlength_alt_err_stat,le.maxlength_lf,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id);
  SELF.avelength := CHOOSE(C,le.avelength_id_ska,le.avelength_bdid,le.avelength_ttl,le.avelength_first_name,le.avelength_middle,le.avelength_last_name,le.avelength_t1,le.avelength_do,le.avelength_deptcode,le.avelength_dept_expl,le.avelength_key_file,le.avelength_company1,le.avelength_address1,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_address2,le.avelength_city2,le.avelength_state2,le.avelength_zip2,le.avelength_fips,le.avelength_phone,le.avelength_spec,le.avelength_spec_expl,le.avelength_spec2,le.avelength_spec2_expl,le.avelength_spec3,le.avelength_spec3_expl,le.avelength_persid,le.avelength_owner,le.avelength_emailavail,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_mail_prim_range,le.avelength_mail_predir,le.avelength_mail_prim_name,le.avelength_mail_addr_suffix,le.avelength_mail_postdir,le.avelength_mail_unit_desig,le.avelength_mail_sec_range,le.avelength_mail_p_city_name,le.avelength_mail_v_city_name,le.avelength_mail_st,le.avelength_mail_zip,le.avelength_mail_zip4,le.avelength_mail_cart,le.avelength_mail_cr_sort_sz,le.avelength_mail_lot,le.avelength_mail_lot_order,le.avelength_mail_dbpc,le.avelength_mail_chk_digit,le.avelength_mail_rec_type,le.avelength_mail_ace_fips_state,le.avelength_mail_county,le.avelength_mail_geo_lat,le.avelength_mail_geo_long,le.avelength_mail_msa,le.avelength_mail_geo_blk,le.avelength_mail_geo_match,le.avelength_mail_err_stat,le.avelength_alt_prim_range,le.avelength_alt_predir,le.avelength_alt_prim_name,le.avelength_alt_addr_suffix,le.avelength_alt_postdir,le.avelength_alt_unit_desig,le.avelength_alt_sec_range,le.avelength_alt_p_city_name,le.avelength_alt_v_city_name,le.avelength_alt_st,le.avelength_alt_zip,le.avelength_alt_zip4,le.avelength_alt_cart,le.avelength_alt_cr_sort_sz,le.avelength_alt_lot,le.avelength_alt_lot_order,le.avelength_alt_dbpc,le.avelength_alt_chk_digit,le.avelength_alt_rec_type,le.avelength_alt_ace_fips_state,le.avelength_alt_county,le.avelength_alt_geo_lat,le.avelength_alt_geo_long,le.avelength_alt_msa,le.avelength_alt_geo_blk,le.avelength_alt_geo_match,le.avelength_alt_err_stat,le.avelength_lf,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 114, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.id_ska),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.ttl),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.t1),TRIM((SALT311.StrType)le.do),TRIM((SALT311.StrType)le.deptcode),TRIM((SALT311.StrType)le.dept_expl),TRIM((SALT311.StrType)le.key_file),TRIM((SALT311.StrType)le.company1),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city2),TRIM((SALT311.StrType)le.state2),TRIM((SALT311.StrType)le.zip2),TRIM((SALT311.StrType)le.fips),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.spec),TRIM((SALT311.StrType)le.spec_expl),TRIM((SALT311.StrType)le.spec2),TRIM((SALT311.StrType)le.spec2_expl),TRIM((SALT311.StrType)le.spec3),TRIM((SALT311.StrType)le.spec3_expl),TRIM((SALT311.StrType)le.persid),TRIM((SALT311.StrType)le.owner),TRIM((SALT311.StrType)le.emailavail),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dbpc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_rec_type),TRIM((SALT311.StrType)le.mail_ace_fips_state),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat),TRIM((SALT311.StrType)le.alt_prim_range),TRIM((SALT311.StrType)le.alt_predir),TRIM((SALT311.StrType)le.alt_prim_name),TRIM((SALT311.StrType)le.alt_addr_suffix),TRIM((SALT311.StrType)le.alt_postdir),TRIM((SALT311.StrType)le.alt_unit_desig),TRIM((SALT311.StrType)le.alt_sec_range),TRIM((SALT311.StrType)le.alt_p_city_name),TRIM((SALT311.StrType)le.alt_v_city_name),TRIM((SALT311.StrType)le.alt_st),TRIM((SALT311.StrType)le.alt_zip),TRIM((SALT311.StrType)le.alt_zip4),TRIM((SALT311.StrType)le.alt_cart),TRIM((SALT311.StrType)le.alt_cr_sort_sz),TRIM((SALT311.StrType)le.alt_lot),TRIM((SALT311.StrType)le.alt_lot_order),TRIM((SALT311.StrType)le.alt_dbpc),TRIM((SALT311.StrType)le.alt_chk_digit),TRIM((SALT311.StrType)le.alt_rec_type),TRIM((SALT311.StrType)le.alt_ace_fips_state),TRIM((SALT311.StrType)le.alt_county),TRIM((SALT311.StrType)le.alt_geo_lat),TRIM((SALT311.StrType)le.alt_geo_long),TRIM((SALT311.StrType)le.alt_msa),TRIM((SALT311.StrType)le.alt_geo_blk),TRIM((SALT311.StrType)le.alt_geo_match),TRIM((SALT311.StrType)le.alt_err_stat),TRIM((SALT311.StrType)le.lf),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,114,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 114);
  SELF.FldNo2 := 1 + (C % 114);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.id_ska),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.ttl),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.t1),TRIM((SALT311.StrType)le.do),TRIM((SALT311.StrType)le.deptcode),TRIM((SALT311.StrType)le.dept_expl),TRIM((SALT311.StrType)le.key_file),TRIM((SALT311.StrType)le.company1),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city2),TRIM((SALT311.StrType)le.state2),TRIM((SALT311.StrType)le.zip2),TRIM((SALT311.StrType)le.fips),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.spec),TRIM((SALT311.StrType)le.spec_expl),TRIM((SALT311.StrType)le.spec2),TRIM((SALT311.StrType)le.spec2_expl),TRIM((SALT311.StrType)le.spec3),TRIM((SALT311.StrType)le.spec3_expl),TRIM((SALT311.StrType)le.persid),TRIM((SALT311.StrType)le.owner),TRIM((SALT311.StrType)le.emailavail),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dbpc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_rec_type),TRIM((SALT311.StrType)le.mail_ace_fips_state),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat),TRIM((SALT311.StrType)le.alt_prim_range),TRIM((SALT311.StrType)le.alt_predir),TRIM((SALT311.StrType)le.alt_prim_name),TRIM((SALT311.StrType)le.alt_addr_suffix),TRIM((SALT311.StrType)le.alt_postdir),TRIM((SALT311.StrType)le.alt_unit_desig),TRIM((SALT311.StrType)le.alt_sec_range),TRIM((SALT311.StrType)le.alt_p_city_name),TRIM((SALT311.StrType)le.alt_v_city_name),TRIM((SALT311.StrType)le.alt_st),TRIM((SALT311.StrType)le.alt_zip),TRIM((SALT311.StrType)le.alt_zip4),TRIM((SALT311.StrType)le.alt_cart),TRIM((SALT311.StrType)le.alt_cr_sort_sz),TRIM((SALT311.StrType)le.alt_lot),TRIM((SALT311.StrType)le.alt_lot_order),TRIM((SALT311.StrType)le.alt_dbpc),TRIM((SALT311.StrType)le.alt_chk_digit),TRIM((SALT311.StrType)le.alt_rec_type),TRIM((SALT311.StrType)le.alt_ace_fips_state),TRIM((SALT311.StrType)le.alt_county),TRIM((SALT311.StrType)le.alt_geo_lat),TRIM((SALT311.StrType)le.alt_geo_long),TRIM((SALT311.StrType)le.alt_msa),TRIM((SALT311.StrType)le.alt_geo_blk),TRIM((SALT311.StrType)le.alt_geo_match),TRIM((SALT311.StrType)le.alt_err_stat),TRIM((SALT311.StrType)le.lf),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.id_ska),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.ttl),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.t1),TRIM((SALT311.StrType)le.do),TRIM((SALT311.StrType)le.deptcode),TRIM((SALT311.StrType)le.dept_expl),TRIM((SALT311.StrType)le.key_file),TRIM((SALT311.StrType)le.company1),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city2),TRIM((SALT311.StrType)le.state2),TRIM((SALT311.StrType)le.zip2),TRIM((SALT311.StrType)le.fips),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.spec),TRIM((SALT311.StrType)le.spec_expl),TRIM((SALT311.StrType)le.spec2),TRIM((SALT311.StrType)le.spec2_expl),TRIM((SALT311.StrType)le.spec3),TRIM((SALT311.StrType)le.spec3_expl),TRIM((SALT311.StrType)le.persid),TRIM((SALT311.StrType)le.owner),TRIM((SALT311.StrType)le.emailavail),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dbpc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_rec_type),TRIM((SALT311.StrType)le.mail_ace_fips_state),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat),TRIM((SALT311.StrType)le.alt_prim_range),TRIM((SALT311.StrType)le.alt_predir),TRIM((SALT311.StrType)le.alt_prim_name),TRIM((SALT311.StrType)le.alt_addr_suffix),TRIM((SALT311.StrType)le.alt_postdir),TRIM((SALT311.StrType)le.alt_unit_desig),TRIM((SALT311.StrType)le.alt_sec_range),TRIM((SALT311.StrType)le.alt_p_city_name),TRIM((SALT311.StrType)le.alt_v_city_name),TRIM((SALT311.StrType)le.alt_st),TRIM((SALT311.StrType)le.alt_zip),TRIM((SALT311.StrType)le.alt_zip4),TRIM((SALT311.StrType)le.alt_cart),TRIM((SALT311.StrType)le.alt_cr_sort_sz),TRIM((SALT311.StrType)le.alt_lot),TRIM((SALT311.StrType)le.alt_lot_order),TRIM((SALT311.StrType)le.alt_dbpc),TRIM((SALT311.StrType)le.alt_chk_digit),TRIM((SALT311.StrType)le.alt_rec_type),TRIM((SALT311.StrType)le.alt_ace_fips_state),TRIM((SALT311.StrType)le.alt_county),TRIM((SALT311.StrType)le.alt_geo_lat),TRIM((SALT311.StrType)le.alt_geo_long),TRIM((SALT311.StrType)le.alt_msa),TRIM((SALT311.StrType)le.alt_geo_blk),TRIM((SALT311.StrType)le.alt_geo_match),TRIM((SALT311.StrType)le.alt_err_stat),TRIM((SALT311.StrType)le.lf),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),114*114,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'id_ska'}
      ,{2,'bdid'}
      ,{3,'ttl'}
      ,{4,'first_name'}
      ,{5,'middle'}
      ,{6,'last_name'}
      ,{7,'t1'}
      ,{8,'do'}
      ,{9,'deptcode'}
      ,{10,'dept_expl'}
      ,{11,'key_file'}
      ,{12,'company1'}
      ,{13,'address1'}
      ,{14,'city'}
      ,{15,'state'}
      ,{16,'zip'}
      ,{17,'address2'}
      ,{18,'city2'}
      ,{19,'state2'}
      ,{20,'zip2'}
      ,{21,'fips'}
      ,{22,'phone'}
      ,{23,'spec'}
      ,{24,'spec_expl'}
      ,{25,'spec2'}
      ,{26,'spec2_expl'}
      ,{27,'spec3'}
      ,{28,'spec3_expl'}
      ,{29,'persid'}
      ,{30,'owner'}
      ,{31,'emailavail'}
      ,{32,'title'}
      ,{33,'fname'}
      ,{34,'mname'}
      ,{35,'lname'}
      ,{36,'name_suffix'}
      ,{37,'name_score'}
      ,{38,'mail_prim_range'}
      ,{39,'mail_predir'}
      ,{40,'mail_prim_name'}
      ,{41,'mail_addr_suffix'}
      ,{42,'mail_postdir'}
      ,{43,'mail_unit_desig'}
      ,{44,'mail_sec_range'}
      ,{45,'mail_p_city_name'}
      ,{46,'mail_v_city_name'}
      ,{47,'mail_st'}
      ,{48,'mail_zip'}
      ,{49,'mail_zip4'}
      ,{50,'mail_cart'}
      ,{51,'mail_cr_sort_sz'}
      ,{52,'mail_lot'}
      ,{53,'mail_lot_order'}
      ,{54,'mail_dbpc'}
      ,{55,'mail_chk_digit'}
      ,{56,'mail_rec_type'}
      ,{57,'mail_ace_fips_state'}
      ,{58,'mail_county'}
      ,{59,'mail_geo_lat'}
      ,{60,'mail_geo_long'}
      ,{61,'mail_msa'}
      ,{62,'mail_geo_blk'}
      ,{63,'mail_geo_match'}
      ,{64,'mail_err_stat'}
      ,{65,'alt_prim_range'}
      ,{66,'alt_predir'}
      ,{67,'alt_prim_name'}
      ,{68,'alt_addr_suffix'}
      ,{69,'alt_postdir'}
      ,{70,'alt_unit_desig'}
      ,{71,'alt_sec_range'}
      ,{72,'alt_p_city_name'}
      ,{73,'alt_v_city_name'}
      ,{74,'alt_st'}
      ,{75,'alt_zip'}
      ,{76,'alt_zip4'}
      ,{77,'alt_cart'}
      ,{78,'alt_cr_sort_sz'}
      ,{79,'alt_lot'}
      ,{80,'alt_lot_order'}
      ,{81,'alt_dbpc'}
      ,{82,'alt_chk_digit'}
      ,{83,'alt_rec_type'}
      ,{84,'alt_ace_fips_state'}
      ,{85,'alt_county'}
      ,{86,'alt_geo_lat'}
      ,{87,'alt_geo_long'}
      ,{88,'alt_msa'}
      ,{89,'alt_geo_blk'}
      ,{90,'alt_geo_match'}
      ,{91,'alt_err_stat'}
      ,{92,'lf'}
      ,{93,'dotid'}
      ,{94,'dotscore'}
      ,{95,'dotweight'}
      ,{96,'empid'}
      ,{97,'empscore'}
      ,{98,'empweight'}
      ,{99,'powid'}
      ,{100,'powscore'}
      ,{101,'powweight'}
      ,{102,'proxid'}
      ,{103,'proxscore'}
      ,{104,'proxweight'}
      ,{105,'seleid'}
      ,{106,'selescore'}
      ,{107,'seleweight'}
      ,{108,'orgid'}
      ,{109,'orgscore'}
      ,{110,'orgweight'}
      ,{111,'ultid'}
      ,{112,'ultscore'}
      ,{113,'ultweight'}
      ,{114,'source_rec_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Verified_Fields.InValid_id_ska((SALT311.StrType)le.id_ska),
    Base_Verified_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_Verified_Fields.InValid_ttl((SALT311.StrType)le.ttl),
    Base_Verified_Fields.InValid_first_name((SALT311.StrType)le.first_name),
    Base_Verified_Fields.InValid_middle((SALT311.StrType)le.middle),
    Base_Verified_Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Base_Verified_Fields.InValid_t1((SALT311.StrType)le.t1),
    Base_Verified_Fields.InValid_do((SALT311.StrType)le.do),
    Base_Verified_Fields.InValid_deptcode((SALT311.StrType)le.deptcode),
    Base_Verified_Fields.InValid_dept_expl((SALT311.StrType)le.dept_expl,(SALT311.StrType)le.deptcode),
    Base_Verified_Fields.InValid_key_file((SALT311.StrType)le.key_file),
    Base_Verified_Fields.InValid_company1((SALT311.StrType)le.company1),
    Base_Verified_Fields.InValid_address1((SALT311.StrType)le.address1),
    Base_Verified_Fields.InValid_city((SALT311.StrType)le.city),
    Base_Verified_Fields.InValid_state((SALT311.StrType)le.state),
    Base_Verified_Fields.InValid_zip((SALT311.StrType)le.zip),
    Base_Verified_Fields.InValid_address2((SALT311.StrType)le.address2,(SALT311.StrType)le.address1),
    Base_Verified_Fields.InValid_city2((SALT311.StrType)le.city2,(SALT311.StrType)le.address2),
    Base_Verified_Fields.InValid_state2((SALT311.StrType)le.state2,(SALT311.StrType)le.address2),
    Base_Verified_Fields.InValid_zip2((SALT311.StrType)le.zip2,(SALT311.StrType)le.address2),
    Base_Verified_Fields.InValid_fips((SALT311.StrType)le.fips),
    Base_Verified_Fields.InValid_phone((SALT311.StrType)le.phone),
    Base_Verified_Fields.InValid_spec((SALT311.StrType)le.spec),
    Base_Verified_Fields.InValid_spec_expl((SALT311.StrType)le.spec_expl,(SALT311.StrType)le.spec),
    Base_Verified_Fields.InValid_spec2((SALT311.StrType)le.spec2),
    Base_Verified_Fields.InValid_spec2_expl((SALT311.StrType)le.spec2_expl,(SALT311.StrType)le.spec2),
    Base_Verified_Fields.InValid_spec3((SALT311.StrType)le.spec3),
    Base_Verified_Fields.InValid_spec3_expl((SALT311.StrType)le.spec3_expl,(SALT311.StrType)le.spec3),
    Base_Verified_Fields.InValid_persid((SALT311.StrType)le.persid),
    Base_Verified_Fields.InValid_owner((SALT311.StrType)le.owner),
    Base_Verified_Fields.InValid_emailavail((SALT311.StrType)le.emailavail),
    Base_Verified_Fields.InValid_title((SALT311.StrType)le.title),
    Base_Verified_Fields.InValid_fname((SALT311.StrType)le.fname),
    Base_Verified_Fields.InValid_mname((SALT311.StrType)le.mname),
    Base_Verified_Fields.InValid_lname((SALT311.StrType)le.lname),
    Base_Verified_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Base_Verified_Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Base_Verified_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range),
    Base_Verified_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir),
    Base_Verified_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name),
    Base_Verified_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix),
    Base_Verified_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir),
    Base_Verified_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig),
    Base_Verified_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range),
    Base_Verified_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name,(SALT311.StrType)le.mail_v_city_name),
    Base_Verified_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name,(SALT311.StrType)le.mail_p_city_name),
    Base_Verified_Fields.InValid_mail_st((SALT311.StrType)le.mail_st),
    Base_Verified_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip),
    Base_Verified_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4),
    Base_Verified_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart),
    Base_Verified_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz),
    Base_Verified_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot),
    Base_Verified_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order),
    Base_Verified_Fields.InValid_mail_dbpc((SALT311.StrType)le.mail_dbpc),
    Base_Verified_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit),
    Base_Verified_Fields.InValid_mail_rec_type((SALT311.StrType)le.mail_rec_type),
    Base_Verified_Fields.InValid_mail_ace_fips_state((SALT311.StrType)le.mail_ace_fips_state),
    Base_Verified_Fields.InValid_mail_county((SALT311.StrType)le.mail_county),
    Base_Verified_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat),
    Base_Verified_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long),
    Base_Verified_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa),
    Base_Verified_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk),
    Base_Verified_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match),
    Base_Verified_Fields.InValid_mail_err_stat((SALT311.StrType)le.mail_err_stat),
    Base_Verified_Fields.InValid_alt_prim_range((SALT311.StrType)le.alt_prim_range),
    Base_Verified_Fields.InValid_alt_predir((SALT311.StrType)le.alt_predir),
    Base_Verified_Fields.InValid_alt_prim_name((SALT311.StrType)le.alt_prim_name,(SALT311.StrType)le.address2),
    Base_Verified_Fields.InValid_alt_addr_suffix((SALT311.StrType)le.alt_addr_suffix),
    Base_Verified_Fields.InValid_alt_postdir((SALT311.StrType)le.alt_postdir),
    Base_Verified_Fields.InValid_alt_unit_desig((SALT311.StrType)le.alt_unit_desig),
    Base_Verified_Fields.InValid_alt_sec_range((SALT311.StrType)le.alt_sec_range),
    Base_Verified_Fields.InValid_alt_p_city_name((SALT311.StrType)le.alt_p_city_name,(SALT311.StrType)le.alt_st,(SALT311.StrType)le.alt_zip),
    Base_Verified_Fields.InValid_alt_v_city_name((SALT311.StrType)le.alt_v_city_name,(SALT311.StrType)le.alt_st,(SALT311.StrType)le.alt_zip),
    Base_Verified_Fields.InValid_alt_st((SALT311.StrType)le.alt_st,(SALT311.StrType)le.alt_p_city_name,(SALT311.StrType)le.alt_zip),
    Base_Verified_Fields.InValid_alt_zip((SALT311.StrType)le.alt_zip,(SALT311.StrType)le.alt_v_city_name,(SALT311.StrType)le.alt_st),
    Base_Verified_Fields.InValid_alt_zip4((SALT311.StrType)le.alt_zip4),
    Base_Verified_Fields.InValid_alt_cart((SALT311.StrType)le.alt_cart),
    Base_Verified_Fields.InValid_alt_cr_sort_sz((SALT311.StrType)le.alt_cr_sort_sz),
    Base_Verified_Fields.InValid_alt_lot((SALT311.StrType)le.alt_lot),
    Base_Verified_Fields.InValid_alt_lot_order((SALT311.StrType)le.alt_lot_order),
    Base_Verified_Fields.InValid_alt_dbpc((SALT311.StrType)le.alt_dbpc),
    Base_Verified_Fields.InValid_alt_chk_digit((SALT311.StrType)le.alt_chk_digit),
    Base_Verified_Fields.InValid_alt_rec_type((SALT311.StrType)le.alt_rec_type),
    Base_Verified_Fields.InValid_alt_ace_fips_state((SALT311.StrType)le.alt_ace_fips_state),
    Base_Verified_Fields.InValid_alt_county((SALT311.StrType)le.alt_county),
    Base_Verified_Fields.InValid_alt_geo_lat((SALT311.StrType)le.alt_geo_lat),
    Base_Verified_Fields.InValid_alt_geo_long((SALT311.StrType)le.alt_geo_long),
    Base_Verified_Fields.InValid_alt_msa((SALT311.StrType)le.alt_msa),
    Base_Verified_Fields.InValid_alt_geo_blk((SALT311.StrType)le.alt_geo_blk),
    Base_Verified_Fields.InValid_alt_geo_match((SALT311.StrType)le.alt_geo_match),
    Base_Verified_Fields.InValid_alt_err_stat((SALT311.StrType)le.alt_err_stat),
    Base_Verified_Fields.InValid_lf((SALT311.StrType)le.lf),
    Base_Verified_Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Base_Verified_Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Base_Verified_Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Base_Verified_Fields.InValid_empid((SALT311.StrType)le.empid),
    Base_Verified_Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Base_Verified_Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Base_Verified_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_Verified_Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Base_Verified_Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Base_Verified_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_Verified_Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Base_Verified_Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Base_Verified_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_Verified_Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Base_Verified_Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Base_Verified_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_Verified_Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Base_Verified_Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Base_Verified_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_Verified_Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Base_Verified_Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    Base_Verified_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,114,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Verified_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','Unknown','invalid_mandatory','Unknown','invalid_mandatory','invalid_mandatory','invalid_boolean','invalid_deptcode','invalid_dept_expl','Unknown','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_address2','invalid_city2','invalid_state2','invalid_zip2','invalid_fips','invalid_phone','invalid_spec','invalid_spec_expl','invalid_spec2','invalid_spec2_expl','invalid_spec3','invalid_spec3_expl','invalid_numeric','invalid_owner','invalid_boolean','Unknown','invalid_mandatory','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mail_p_city_name','invalid_mail_v_city_name','invalid_mail_st','invalid_mail_zip','invalid_mail_zip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_mail_ace_fips_state','Unknown','invalid_geo_coord','invalid_geo_coord','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_direction','invalid_alt_prim_name','Unknown','invalid_direction','Unknown','Unknown','invalid_alt_p_city_name','invalid_alt_v_city_name','invalid_alt_st','invalid_alt_zip','invalid_alt_zip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alt_ace_fips_state','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Verified_Fields.InValidMessage_id_ska(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_ttl(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_middle(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_t1(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_do(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_deptcode(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_dept_expl(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_key_file(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_company1(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_city2(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_state2(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_zip2(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_fips(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_spec(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_spec_expl(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_spec2(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_spec2_expl(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_spec3(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_spec3_expl(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_persid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_owner(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_emailavail(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_prim_range(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_predir(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_prim_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_addr_suffix(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_postdir(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_unit_desig(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_sec_range(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_p_city_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_v_city_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_st(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_cart(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_cr_sort_sz(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_lot(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_lot_order(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_dbpc(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_chk_digit(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_rec_type(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_ace_fips_state(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_county(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_geo_lat(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_geo_long(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_msa(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_geo_blk(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_geo_match(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_mail_err_stat(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_prim_range(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_predir(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_prim_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_addr_suffix(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_postdir(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_unit_desig(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_sec_range(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_p_city_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_v_city_name(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_st(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_zip(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_zip4(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_cart(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_cr_sort_sz(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_lot(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_lot_order(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_dbpc(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_chk_digit(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_rec_type(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_ace_fips_state(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_county(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_geo_lat(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_geo_long(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_msa(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_geo_blk(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_geo_match(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_alt_err_stat(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_lf(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Base_Verified_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SKA, Base_Verified_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
