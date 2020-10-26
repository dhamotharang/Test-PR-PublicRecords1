﻿IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_datetime_stamp_cnt := COUNT(GROUP,h.orig_datetime_stamp <> (TYPEOF(h.orig_datetime_stamp))'');
    populated_orig_datetime_stamp_pcnt := AVE(GROUP,IF(h.orig_datetime_stamp = (TYPEOF(h.orig_datetime_stamp))'',0,100));
    maxlength_orig_datetime_stamp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_datetime_stamp)));
    avelength_orig_datetime_stamp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_datetime_stamp)),h.orig_datetime_stamp<>(typeof(h.orig_datetime_stamp))'');
    populated_orig_global_company_id_cnt := COUNT(GROUP,h.orig_global_company_id <> (TYPEOF(h.orig_global_company_id))'');
    populated_orig_global_company_id_pcnt := AVE(GROUP,IF(h.orig_global_company_id = (TYPEOF(h.orig_global_company_id))'',0,100));
    maxlength_orig_global_company_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_global_company_id)));
    avelength_orig_global_company_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_global_company_id)),h.orig_global_company_id<>(typeof(h.orig_global_company_id))'');
    populated_orig_company_id_cnt := COUNT(GROUP,h.orig_company_id <> (TYPEOF(h.orig_company_id))'');
    populated_orig_company_id_pcnt := AVE(GROUP,IF(h.orig_company_id = (TYPEOF(h.orig_company_id))'',0,100));
    maxlength_orig_company_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_id)));
    avelength_orig_company_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_id)),h.orig_company_id<>(typeof(h.orig_company_id))'');
    populated_orig_product_cd_cnt := COUNT(GROUP,h.orig_product_cd <> (TYPEOF(h.orig_product_cd))'');
    populated_orig_product_cd_pcnt := AVE(GROUP,IF(h.orig_product_cd = (TYPEOF(h.orig_product_cd))'',0,100));
    maxlength_orig_product_cd := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_product_cd)));
    avelength_orig_product_cd := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_product_cd)),h.orig_product_cd<>(typeof(h.orig_product_cd))'');
    populated_orig_method_cnt := COUNT(GROUP,h.orig_method <> (TYPEOF(h.orig_method))'');
    populated_orig_method_pcnt := AVE(GROUP,IF(h.orig_method = (TYPEOF(h.orig_method))'',0,100));
    maxlength_orig_method := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_method)));
    avelength_orig_method := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_method)),h.orig_method<>(typeof(h.orig_method))'');
    populated_orig_vertical_cnt := COUNT(GROUP,h.orig_vertical <> (TYPEOF(h.orig_vertical))'');
    populated_orig_vertical_pcnt := AVE(GROUP,IF(h.orig_vertical = (TYPEOF(h.orig_vertical))'',0,100));
    maxlength_orig_vertical := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_vertical)));
    avelength_orig_vertical := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_vertical)),h.orig_vertical<>(typeof(h.orig_vertical))'');
    populated_orig_function_name_cnt := COUNT(GROUP,h.orig_function_name <> (TYPEOF(h.orig_function_name))'');
    populated_orig_function_name_pcnt := AVE(GROUP,IF(h.orig_function_name = (TYPEOF(h.orig_function_name))'',0,100));
    maxlength_orig_function_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)));
    avelength_orig_function_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)),h.orig_function_name<>(typeof(h.orig_function_name))'');
    populated_orig_transaction_type_cnt := COUNT(GROUP,h.orig_transaction_type <> (TYPEOF(h.orig_transaction_type))'');
    populated_orig_transaction_type_pcnt := AVE(GROUP,IF(h.orig_transaction_type = (TYPEOF(h.orig_transaction_type))'',0,100));
    maxlength_orig_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_type)));
    avelength_orig_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_type)),h.orig_transaction_type<>(typeof(h.orig_transaction_type))'');
    populated_orig_login_history_id_cnt := COUNT(GROUP,h.orig_login_history_id <> (TYPEOF(h.orig_login_history_id))'');
    populated_orig_login_history_id_pcnt := AVE(GROUP,IF(h.orig_login_history_id = (TYPEOF(h.orig_login_history_id))'',0,100));
    maxlength_orig_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)));
    avelength_orig_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)),h.orig_login_history_id<>(typeof(h.orig_login_history_id))'');
    populated_orig_job_id_cnt := COUNT(GROUP,h.orig_job_id <> (TYPEOF(h.orig_job_id))'');
    populated_orig_job_id_pcnt := AVE(GROUP,IF(h.orig_job_id = (TYPEOF(h.orig_job_id))'',0,100));
    maxlength_orig_job_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_job_id)));
    avelength_orig_job_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_job_id)),h.orig_job_id<>(typeof(h.orig_job_id))'');
    populated_orig_sequence_number_cnt := COUNT(GROUP,h.orig_sequence_number <> (TYPEOF(h.orig_sequence_number))'');
    populated_orig_sequence_number_pcnt := AVE(GROUP,IF(h.orig_sequence_number = (TYPEOF(h.orig_sequence_number))'',0,100));
    maxlength_orig_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_sequence_number)));
    avelength_orig_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_sequence_number)),h.orig_sequence_number<>(typeof(h.orig_sequence_number))'');
    populated_orig_first_name_cnt := COUNT(GROUP,h.orig_first_name <> (TYPEOF(h.orig_first_name))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_middle_name_cnt := COUNT(GROUP,h.orig_middle_name <> (TYPEOF(h.orig_middle_name))'');
    populated_orig_middle_name_pcnt := AVE(GROUP,IF(h.orig_middle_name = (TYPEOF(h.orig_middle_name))'',0,100));
    maxlength_orig_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_middle_name)));
    avelength_orig_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_middle_name)),h.orig_middle_name<>(typeof(h.orig_middle_name))'');
    populated_orig_last_name_cnt := COUNT(GROUP,h.orig_last_name <> (TYPEOF(h.orig_last_name))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_dl_num_cnt := COUNT(GROUP,h.orig_dl_num <> (TYPEOF(h.orig_dl_num))'');
    populated_orig_dl_num_pcnt := AVE(GROUP,IF(h.orig_dl_num = (TYPEOF(h.orig_dl_num))'',0,100));
    maxlength_orig_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_num)));
    avelength_orig_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_num)),h.orig_dl_num<>(typeof(h.orig_dl_num))'');
    populated_orig_dl_state_cnt := COUNT(GROUP,h.orig_dl_state <> (TYPEOF(h.orig_dl_state))'');
    populated_orig_dl_state_pcnt := AVE(GROUP,IF(h.orig_dl_state = (TYPEOF(h.orig_dl_state))'',0,100));
    maxlength_orig_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_state)));
    avelength_orig_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_state)),h.orig_dl_state<>(typeof(h.orig_dl_state))'');
    populated_orig_address1_addressline1_cnt := COUNT(GROUP,h.orig_address1_addressline1 <> (TYPEOF(h.orig_address1_addressline1))'');
    populated_orig_address1_addressline1_pcnt := AVE(GROUP,IF(h.orig_address1_addressline1 = (TYPEOF(h.orig_address1_addressline1))'',0,100));
    maxlength_orig_address1_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_addressline1)));
    avelength_orig_address1_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_addressline1)),h.orig_address1_addressline1<>(typeof(h.orig_address1_addressline1))'');
    populated_orig_address1_addressline2_cnt := COUNT(GROUP,h.orig_address1_addressline2 <> (TYPEOF(h.orig_address1_addressline2))'');
    populated_orig_address1_addressline2_pcnt := AVE(GROUP,IF(h.orig_address1_addressline2 = (TYPEOF(h.orig_address1_addressline2))'',0,100));
    maxlength_orig_address1_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_addressline2)));
    avelength_orig_address1_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_addressline2)),h.orig_address1_addressline2<>(typeof(h.orig_address1_addressline2))'');
    populated_orig_address1_prim_range_cnt := COUNT(GROUP,h.orig_address1_prim_range <> (TYPEOF(h.orig_address1_prim_range))'');
    populated_orig_address1_prim_range_pcnt := AVE(GROUP,IF(h.orig_address1_prim_range = (TYPEOF(h.orig_address1_prim_range))'',0,100));
    maxlength_orig_address1_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_prim_range)));
    avelength_orig_address1_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_prim_range)),h.orig_address1_prim_range<>(typeof(h.orig_address1_prim_range))'');
    populated_orig_address1_predir_cnt := COUNT(GROUP,h.orig_address1_predir <> (TYPEOF(h.orig_address1_predir))'');
    populated_orig_address1_predir_pcnt := AVE(GROUP,IF(h.orig_address1_predir = (TYPEOF(h.orig_address1_predir))'',0,100));
    maxlength_orig_address1_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_predir)));
    avelength_orig_address1_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_predir)),h.orig_address1_predir<>(typeof(h.orig_address1_predir))'');
    populated_orig_address1_prim_name_cnt := COUNT(GROUP,h.orig_address1_prim_name <> (TYPEOF(h.orig_address1_prim_name))'');
    populated_orig_address1_prim_name_pcnt := AVE(GROUP,IF(h.orig_address1_prim_name = (TYPEOF(h.orig_address1_prim_name))'',0,100));
    maxlength_orig_address1_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_prim_name)));
    avelength_orig_address1_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_prim_name)),h.orig_address1_prim_name<>(typeof(h.orig_address1_prim_name))'');
    populated_orig_address1_suffix_cnt := COUNT(GROUP,h.orig_address1_suffix <> (TYPEOF(h.orig_address1_suffix))'');
    populated_orig_address1_suffix_pcnt := AVE(GROUP,IF(h.orig_address1_suffix = (TYPEOF(h.orig_address1_suffix))'',0,100));
    maxlength_orig_address1_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_suffix)));
    avelength_orig_address1_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_suffix)),h.orig_address1_suffix<>(typeof(h.orig_address1_suffix))'');
    populated_orig_address1_postdir_cnt := COUNT(GROUP,h.orig_address1_postdir <> (TYPEOF(h.orig_address1_postdir))'');
    populated_orig_address1_postdir_pcnt := AVE(GROUP,IF(h.orig_address1_postdir = (TYPEOF(h.orig_address1_postdir))'',0,100));
    maxlength_orig_address1_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_postdir)));
    avelength_orig_address1_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_postdir)),h.orig_address1_postdir<>(typeof(h.orig_address1_postdir))'');
    populated_orig_address1_unit_desig_cnt := COUNT(GROUP,h.orig_address1_unit_desig <> (TYPEOF(h.orig_address1_unit_desig))'');
    populated_orig_address1_unit_desig_pcnt := AVE(GROUP,IF(h.orig_address1_unit_desig = (TYPEOF(h.orig_address1_unit_desig))'',0,100));
    maxlength_orig_address1_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_unit_desig)));
    avelength_orig_address1_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_unit_desig)),h.orig_address1_unit_desig<>(typeof(h.orig_address1_unit_desig))'');
    populated_orig_address1_sec_range_cnt := COUNT(GROUP,h.orig_address1_sec_range <> (TYPEOF(h.orig_address1_sec_range))'');
    populated_orig_address1_sec_range_pcnt := AVE(GROUP,IF(h.orig_address1_sec_range = (TYPEOF(h.orig_address1_sec_range))'',0,100));
    maxlength_orig_address1_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_sec_range)));
    avelength_orig_address1_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_sec_range)),h.orig_address1_sec_range<>(typeof(h.orig_address1_sec_range))'');
    populated_orig_address1_city_cnt := COUNT(GROUP,h.orig_address1_city <> (TYPEOF(h.orig_address1_city))'');
    populated_orig_address1_city_pcnt := AVE(GROUP,IF(h.orig_address1_city = (TYPEOF(h.orig_address1_city))'',0,100));
    maxlength_orig_address1_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_city)));
    avelength_orig_address1_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_city)),h.orig_address1_city<>(typeof(h.orig_address1_city))'');
    populated_orig_address1_st_cnt := COUNT(GROUP,h.orig_address1_st <> (TYPEOF(h.orig_address1_st))'');
    populated_orig_address1_st_pcnt := AVE(GROUP,IF(h.orig_address1_st = (TYPEOF(h.orig_address1_st))'',0,100));
    maxlength_orig_address1_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_st)));
    avelength_orig_address1_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_st)),h.orig_address1_st<>(typeof(h.orig_address1_st))'');
    populated_orig_address1_z5_cnt := COUNT(GROUP,h.orig_address1_z5 <> (TYPEOF(h.orig_address1_z5))'');
    populated_orig_address1_z5_pcnt := AVE(GROUP,IF(h.orig_address1_z5 = (TYPEOF(h.orig_address1_z5))'',0,100));
    maxlength_orig_address1_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_z5)));
    avelength_orig_address1_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_z5)),h.orig_address1_z5<>(typeof(h.orig_address1_z5))'');
    populated_orig_address1_z4_cnt := COUNT(GROUP,h.orig_address1_z4 <> (TYPEOF(h.orig_address1_z4))'');
    populated_orig_address1_z4_pcnt := AVE(GROUP,IF(h.orig_address1_z4 = (TYPEOF(h.orig_address1_z4))'',0,100));
    maxlength_orig_address1_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_z4)));
    avelength_orig_address1_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address1_z4)),h.orig_address1_z4<>(typeof(h.orig_address1_z4))'');
    populated_orig_address2_addressline1_cnt := COUNT(GROUP,h.orig_address2_addressline1 <> (TYPEOF(h.orig_address2_addressline1))'');
    populated_orig_address2_addressline1_pcnt := AVE(GROUP,IF(h.orig_address2_addressline1 = (TYPEOF(h.orig_address2_addressline1))'',0,100));
    maxlength_orig_address2_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_addressline1)));
    avelength_orig_address2_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_addressline1)),h.orig_address2_addressline1<>(typeof(h.orig_address2_addressline1))'');
    populated_orig_address2_addressline2_cnt := COUNT(GROUP,h.orig_address2_addressline2 <> (TYPEOF(h.orig_address2_addressline2))'');
    populated_orig_address2_addressline2_pcnt := AVE(GROUP,IF(h.orig_address2_addressline2 = (TYPEOF(h.orig_address2_addressline2))'',0,100));
    maxlength_orig_address2_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_addressline2)));
    avelength_orig_address2_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_addressline2)),h.orig_address2_addressline2<>(typeof(h.orig_address2_addressline2))'');
    populated_orig_address2_prim_range_cnt := COUNT(GROUP,h.orig_address2_prim_range <> (TYPEOF(h.orig_address2_prim_range))'');
    populated_orig_address2_prim_range_pcnt := AVE(GROUP,IF(h.orig_address2_prim_range = (TYPEOF(h.orig_address2_prim_range))'',0,100));
    maxlength_orig_address2_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_prim_range)));
    avelength_orig_address2_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_prim_range)),h.orig_address2_prim_range<>(typeof(h.orig_address2_prim_range))'');
    populated_orig_address2_predir_cnt := COUNT(GROUP,h.orig_address2_predir <> (TYPEOF(h.orig_address2_predir))'');
    populated_orig_address2_predir_pcnt := AVE(GROUP,IF(h.orig_address2_predir = (TYPEOF(h.orig_address2_predir))'',0,100));
    maxlength_orig_address2_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_predir)));
    avelength_orig_address2_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_predir)),h.orig_address2_predir<>(typeof(h.orig_address2_predir))'');
    populated_orig_address2_prim_name_cnt := COUNT(GROUP,h.orig_address2_prim_name <> (TYPEOF(h.orig_address2_prim_name))'');
    populated_orig_address2_prim_name_pcnt := AVE(GROUP,IF(h.orig_address2_prim_name = (TYPEOF(h.orig_address2_prim_name))'',0,100));
    maxlength_orig_address2_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_prim_name)));
    avelength_orig_address2_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_prim_name)),h.orig_address2_prim_name<>(typeof(h.orig_address2_prim_name))'');
    populated_orig_address2_suffix_cnt := COUNT(GROUP,h.orig_address2_suffix <> (TYPEOF(h.orig_address2_suffix))'');
    populated_orig_address2_suffix_pcnt := AVE(GROUP,IF(h.orig_address2_suffix = (TYPEOF(h.orig_address2_suffix))'',0,100));
    maxlength_orig_address2_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_suffix)));
    avelength_orig_address2_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_suffix)),h.orig_address2_suffix<>(typeof(h.orig_address2_suffix))'');
    populated_orig_address2_postdir_cnt := COUNT(GROUP,h.orig_address2_postdir <> (TYPEOF(h.orig_address2_postdir))'');
    populated_orig_address2_postdir_pcnt := AVE(GROUP,IF(h.orig_address2_postdir = (TYPEOF(h.orig_address2_postdir))'',0,100));
    maxlength_orig_address2_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_postdir)));
    avelength_orig_address2_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_postdir)),h.orig_address2_postdir<>(typeof(h.orig_address2_postdir))'');
    populated_orig_address2_unit_desig_cnt := COUNT(GROUP,h.orig_address2_unit_desig <> (TYPEOF(h.orig_address2_unit_desig))'');
    populated_orig_address2_unit_desig_pcnt := AVE(GROUP,IF(h.orig_address2_unit_desig = (TYPEOF(h.orig_address2_unit_desig))'',0,100));
    maxlength_orig_address2_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_unit_desig)));
    avelength_orig_address2_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_unit_desig)),h.orig_address2_unit_desig<>(typeof(h.orig_address2_unit_desig))'');
    populated_orig_address2_sec_range_cnt := COUNT(GROUP,h.orig_address2_sec_range <> (TYPEOF(h.orig_address2_sec_range))'');
    populated_orig_address2_sec_range_pcnt := AVE(GROUP,IF(h.orig_address2_sec_range = (TYPEOF(h.orig_address2_sec_range))'',0,100));
    maxlength_orig_address2_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_sec_range)));
    avelength_orig_address2_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_sec_range)),h.orig_address2_sec_range<>(typeof(h.orig_address2_sec_range))'');
    populated_orig_address2_city_cnt := COUNT(GROUP,h.orig_address2_city <> (TYPEOF(h.orig_address2_city))'');
    populated_orig_address2_city_pcnt := AVE(GROUP,IF(h.orig_address2_city = (TYPEOF(h.orig_address2_city))'',0,100));
    maxlength_orig_address2_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_city)));
    avelength_orig_address2_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_city)),h.orig_address2_city<>(typeof(h.orig_address2_city))'');
    populated_orig_address2_st_cnt := COUNT(GROUP,h.orig_address2_st <> (TYPEOF(h.orig_address2_st))'');
    populated_orig_address2_st_pcnt := AVE(GROUP,IF(h.orig_address2_st = (TYPEOF(h.orig_address2_st))'',0,100));
    maxlength_orig_address2_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_st)));
    avelength_orig_address2_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_st)),h.orig_address2_st<>(typeof(h.orig_address2_st))'');
    populated_orig_address2_z5_cnt := COUNT(GROUP,h.orig_address2_z5 <> (TYPEOF(h.orig_address2_z5))'');
    populated_orig_address2_z5_pcnt := AVE(GROUP,IF(h.orig_address2_z5 = (TYPEOF(h.orig_address2_z5))'',0,100));
    maxlength_orig_address2_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_z5)));
    avelength_orig_address2_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_z5)),h.orig_address2_z5<>(typeof(h.orig_address2_z5))'');
    populated_orig_address2_z4_cnt := COUNT(GROUP,h.orig_address2_z4 <> (TYPEOF(h.orig_address2_z4))'');
    populated_orig_address2_z4_pcnt := AVE(GROUP,IF(h.orig_address2_z4 = (TYPEOF(h.orig_address2_z4))'',0,100));
    maxlength_orig_address2_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_z4)));
    avelength_orig_address2_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address2_z4)),h.orig_address2_z4<>(typeof(h.orig_address2_z4))'');
    populated_orig_bdid_cnt := COUNT(GROUP,h.orig_bdid <> (TYPEOF(h.orig_bdid))'');
    populated_orig_bdid_pcnt := AVE(GROUP,IF(h.orig_bdid = (TYPEOF(h.orig_bdid))'',0,100));
    maxlength_orig_bdid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bdid)));
    avelength_orig_bdid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bdid)),h.orig_bdid<>(typeof(h.orig_bdid))'');
    populated_orig_bdl_cnt := COUNT(GROUP,h.orig_bdl <> (TYPEOF(h.orig_bdl))'');
    populated_orig_bdl_pcnt := AVE(GROUP,IF(h.orig_bdl = (TYPEOF(h.orig_bdl))'',0,100));
    maxlength_orig_bdl := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bdl)));
    avelength_orig_bdl := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bdl)),h.orig_bdl<>(typeof(h.orig_bdl))'');
    populated_orig_did_cnt := COUNT(GROUP,h.orig_did <> (TYPEOF(h.orig_did))'');
    populated_orig_did_pcnt := AVE(GROUP,IF(h.orig_did = (TYPEOF(h.orig_did))'',0,100));
    maxlength_orig_did := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_did)));
    avelength_orig_did := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_did)),h.orig_did<>(typeof(h.orig_did))'');
    populated_orig_company_name_cnt := COUNT(GROUP,h.orig_company_name <> (TYPEOF(h.orig_company_name))'');
    populated_orig_company_name_pcnt := AVE(GROUP,IF(h.orig_company_name = (TYPEOF(h.orig_company_name))'',0,100));
    maxlength_orig_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_name)));
    avelength_orig_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_name)),h.orig_company_name<>(typeof(h.orig_company_name))'');
    populated_orig_fein_cnt := COUNT(GROUP,h.orig_fein <> (TYPEOF(h.orig_fein))'');
    populated_orig_fein_pcnt := AVE(GROUP,IF(h.orig_fein = (TYPEOF(h.orig_fein))'',0,100));
    maxlength_orig_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fein)));
    avelength_orig_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fein)),h.orig_fein<>(typeof(h.orig_fein))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_work_phone_cnt := COUNT(GROUP,h.orig_work_phone <> (TYPEOF(h.orig_work_phone))'');
    populated_orig_work_phone_pcnt := AVE(GROUP,IF(h.orig_work_phone = (TYPEOF(h.orig_work_phone))'',0,100));
    maxlength_orig_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_work_phone)));
    avelength_orig_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_work_phone)),h.orig_work_phone<>(typeof(h.orig_work_phone))'');
    populated_orig_company_phone_cnt := COUNT(GROUP,h.orig_company_phone <> (TYPEOF(h.orig_company_phone))'');
    populated_orig_company_phone_pcnt := AVE(GROUP,IF(h.orig_company_phone = (TYPEOF(h.orig_company_phone))'',0,100));
    maxlength_orig_company_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_phone)));
    avelength_orig_company_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_phone)),h.orig_company_phone<>(typeof(h.orig_company_phone))'');
    populated_orig_reference_code_cnt := COUNT(GROUP,h.orig_reference_code <> (TYPEOF(h.orig_reference_code))'');
    populated_orig_reference_code_pcnt := AVE(GROUP,IF(h.orig_reference_code = (TYPEOF(h.orig_reference_code))'',0,100));
    maxlength_orig_reference_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_reference_code)));
    avelength_orig_reference_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_reference_code)),h.orig_reference_code<>(typeof(h.orig_reference_code))'');
    populated_orig_ip_address_initiated_cnt := COUNT(GROUP,h.orig_ip_address_initiated <> (TYPEOF(h.orig_ip_address_initiated))'');
    populated_orig_ip_address_initiated_pcnt := AVE(GROUP,IF(h.orig_ip_address_initiated = (TYPEOF(h.orig_ip_address_initiated))'',0,100));
    maxlength_orig_ip_address_initiated := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address_initiated)));
    avelength_orig_ip_address_initiated := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address_initiated)),h.orig_ip_address_initiated<>(typeof(h.orig_ip_address_initiated))'');
    populated_orig_ip_address_executed_cnt := COUNT(GROUP,h.orig_ip_address_executed <> (TYPEOF(h.orig_ip_address_executed))'');
    populated_orig_ip_address_executed_pcnt := AVE(GROUP,IF(h.orig_ip_address_executed = (TYPEOF(h.orig_ip_address_executed))'',0,100));
    maxlength_orig_ip_address_executed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address_executed)));
    avelength_orig_ip_address_executed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address_executed)),h.orig_ip_address_executed<>(typeof(h.orig_ip_address_executed))'');
    populated_orig_charter_number_cnt := COUNT(GROUP,h.orig_charter_number <> (TYPEOF(h.orig_charter_number))'');
    populated_orig_charter_number_pcnt := AVE(GROUP,IF(h.orig_charter_number = (TYPEOF(h.orig_charter_number))'',0,100));
    maxlength_orig_charter_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_charter_number)));
    avelength_orig_charter_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_charter_number)),h.orig_charter_number<>(typeof(h.orig_charter_number))'');
    populated_orig_ucc_original_filing_number_cnt := COUNT(GROUP,h.orig_ucc_original_filing_number <> (TYPEOF(h.orig_ucc_original_filing_number))'');
    populated_orig_ucc_original_filing_number_pcnt := AVE(GROUP,IF(h.orig_ucc_original_filing_number = (TYPEOF(h.orig_ucc_original_filing_number))'',0,100));
    maxlength_orig_ucc_original_filing_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ucc_original_filing_number)));
    avelength_orig_ucc_original_filing_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ucc_original_filing_number)),h.orig_ucc_original_filing_number<>(typeof(h.orig_ucc_original_filing_number))'');
    populated_orig_email_address_cnt := COUNT(GROUP,h.orig_email_address <> (TYPEOF(h.orig_email_address))'');
    populated_orig_email_address_pcnt := AVE(GROUP,IF(h.orig_email_address = (TYPEOF(h.orig_email_address))'',0,100));
    maxlength_orig_email_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email_address)));
    avelength_orig_email_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email_address)),h.orig_email_address<>(typeof(h.orig_email_address))'');
    populated_orig_domain_name_cnt := COUNT(GROUP,h.orig_domain_name <> (TYPEOF(h.orig_domain_name))'');
    populated_orig_domain_name_pcnt := AVE(GROUP,IF(h.orig_domain_name = (TYPEOF(h.orig_domain_name))'',0,100));
    maxlength_orig_domain_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_domain_name)));
    avelength_orig_domain_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_domain_name)),h.orig_domain_name<>(typeof(h.orig_domain_name))'');
    populated_orig_full_name_cnt := COUNT(GROUP,h.orig_full_name <> (TYPEOF(h.orig_full_name))'');
    populated_orig_full_name_pcnt := AVE(GROUP,IF(h.orig_full_name = (TYPEOF(h.orig_full_name))'',0,100));
    maxlength_orig_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_full_name)));
    avelength_orig_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_full_name)),h.orig_full_name<>(typeof(h.orig_full_name))'');
    populated_orig_dl_purpose_cnt := COUNT(GROUP,h.orig_dl_purpose <> (TYPEOF(h.orig_dl_purpose))'');
    populated_orig_dl_purpose_pcnt := AVE(GROUP,IF(h.orig_dl_purpose = (TYPEOF(h.orig_dl_purpose))'',0,100));
    maxlength_orig_dl_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_purpose)));
    avelength_orig_dl_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_purpose)),h.orig_dl_purpose<>(typeof(h.orig_dl_purpose))'');
    populated_orig_glb_purpose_cnt := COUNT(GROUP,h.orig_glb_purpose <> (TYPEOF(h.orig_glb_purpose))'');
    populated_orig_glb_purpose_pcnt := AVE(GROUP,IF(h.orig_glb_purpose = (TYPEOF(h.orig_glb_purpose))'',0,100));
    maxlength_orig_glb_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb_purpose)));
    avelength_orig_glb_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb_purpose)),h.orig_glb_purpose<>(typeof(h.orig_glb_purpose))'');
    populated_orig_fcra_purpose_cnt := COUNT(GROUP,h.orig_fcra_purpose <> (TYPEOF(h.orig_fcra_purpose))'');
    populated_orig_fcra_purpose_pcnt := AVE(GROUP,IF(h.orig_fcra_purpose = (TYPEOF(h.orig_fcra_purpose))'',0,100));
    maxlength_orig_fcra_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra_purpose)));
    avelength_orig_fcra_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra_purpose)),h.orig_fcra_purpose<>(typeof(h.orig_fcra_purpose))'');
    populated_orig_process_id_cnt := COUNT(GROUP,h.orig_process_id <> (TYPEOF(h.orig_process_id))'');
    populated_orig_process_id_pcnt := AVE(GROUP,IF(h.orig_process_id = (TYPEOF(h.orig_process_id))'',0,100));
    maxlength_orig_process_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_process_id)));
    avelength_orig_process_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_process_id)),h.orig_process_id<>(typeof(h.orig_process_id))'');
    populated_orig_suffix_name_cnt := COUNT(GROUP,h.orig_suffix_name <> (TYPEOF(h.orig_suffix_name))'');
    populated_orig_suffix_name_pcnt := AVE(GROUP,IF(h.orig_suffix_name = (TYPEOF(h.orig_suffix_name))'',0,100));
    maxlength_orig_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_suffix_name)));
    avelength_orig_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_suffix_name)),h.orig_suffix_name<>(typeof(h.orig_suffix_name))'');
    populated_orig_former_last_name_cnt := COUNT(GROUP,h.orig_former_last_name <> (TYPEOF(h.orig_former_last_name))'');
    populated_orig_former_last_name_pcnt := AVE(GROUP,IF(h.orig_former_last_name = (TYPEOF(h.orig_former_last_name))'',0,100));
    maxlength_orig_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_former_last_name)));
    avelength_orig_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_former_last_name)),h.orig_former_last_name<>(typeof(h.orig_former_last_name))'');
    populated_orig_business_title_cnt := COUNT(GROUP,h.orig_business_title <> (TYPEOF(h.orig_business_title))'');
    populated_orig_business_title_pcnt := AVE(GROUP,IF(h.orig_business_title = (TYPEOF(h.orig_business_title))'',0,100));
    maxlength_orig_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_title)));
    avelength_orig_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_title)),h.orig_business_title<>(typeof(h.orig_business_title))'');
    populated_orig_company_addressline1_cnt := COUNT(GROUP,h.orig_company_addressline1 <> (TYPEOF(h.orig_company_addressline1))'');
    populated_orig_company_addressline1_pcnt := AVE(GROUP,IF(h.orig_company_addressline1 = (TYPEOF(h.orig_company_addressline1))'',0,100));
    maxlength_orig_company_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_addressline1)));
    avelength_orig_company_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_addressline1)),h.orig_company_addressline1<>(typeof(h.orig_company_addressline1))'');
    populated_orig_company_addressline2_cnt := COUNT(GROUP,h.orig_company_addressline2 <> (TYPEOF(h.orig_company_addressline2))'');
    populated_orig_company_addressline2_pcnt := AVE(GROUP,IF(h.orig_company_addressline2 = (TYPEOF(h.orig_company_addressline2))'',0,100));
    maxlength_orig_company_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_addressline2)));
    avelength_orig_company_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_addressline2)),h.orig_company_addressline2<>(typeof(h.orig_company_addressline2))'');
    populated_orig_company_address_prim_range_cnt := COUNT(GROUP,h.orig_company_address_prim_range <> (TYPEOF(h.orig_company_address_prim_range))'');
    populated_orig_company_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_company_address_prim_range = (TYPEOF(h.orig_company_address_prim_range))'',0,100));
    maxlength_orig_company_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_prim_range)));
    avelength_orig_company_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_prim_range)),h.orig_company_address_prim_range<>(typeof(h.orig_company_address_prim_range))'');
    populated_orig_company_address_predir_cnt := COUNT(GROUP,h.orig_company_address_predir <> (TYPEOF(h.orig_company_address_predir))'');
    populated_orig_company_address_predir_pcnt := AVE(GROUP,IF(h.orig_company_address_predir = (TYPEOF(h.orig_company_address_predir))'',0,100));
    maxlength_orig_company_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_predir)));
    avelength_orig_company_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_predir)),h.orig_company_address_predir<>(typeof(h.orig_company_address_predir))'');
    populated_orig_company_address_prim_name_cnt := COUNT(GROUP,h.orig_company_address_prim_name <> (TYPEOF(h.orig_company_address_prim_name))'');
    populated_orig_company_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_company_address_prim_name = (TYPEOF(h.orig_company_address_prim_name))'',0,100));
    maxlength_orig_company_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_prim_name)));
    avelength_orig_company_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_prim_name)),h.orig_company_address_prim_name<>(typeof(h.orig_company_address_prim_name))'');
    populated_orig_company_address_suffix_cnt := COUNT(GROUP,h.orig_company_address_suffix <> (TYPEOF(h.orig_company_address_suffix))'');
    populated_orig_company_address_suffix_pcnt := AVE(GROUP,IF(h.orig_company_address_suffix = (TYPEOF(h.orig_company_address_suffix))'',0,100));
    maxlength_orig_company_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_suffix)));
    avelength_orig_company_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_suffix)),h.orig_company_address_suffix<>(typeof(h.orig_company_address_suffix))'');
    populated_orig_company_address_postdir_cnt := COUNT(GROUP,h.orig_company_address_postdir <> (TYPEOF(h.orig_company_address_postdir))'');
    populated_orig_company_address_postdir_pcnt := AVE(GROUP,IF(h.orig_company_address_postdir = (TYPEOF(h.orig_company_address_postdir))'',0,100));
    maxlength_orig_company_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_postdir)));
    avelength_orig_company_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_postdir)),h.orig_company_address_postdir<>(typeof(h.orig_company_address_postdir))'');
    populated_orig_company_address_unit_desig_cnt := COUNT(GROUP,h.orig_company_address_unit_desig <> (TYPEOF(h.orig_company_address_unit_desig))'');
    populated_orig_company_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_company_address_unit_desig = (TYPEOF(h.orig_company_address_unit_desig))'',0,100));
    maxlength_orig_company_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_unit_desig)));
    avelength_orig_company_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_unit_desig)),h.orig_company_address_unit_desig<>(typeof(h.orig_company_address_unit_desig))'');
    populated_orig_company_address_sec_range_cnt := COUNT(GROUP,h.orig_company_address_sec_range <> (TYPEOF(h.orig_company_address_sec_range))'');
    populated_orig_company_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_company_address_sec_range = (TYPEOF(h.orig_company_address_sec_range))'',0,100));
    maxlength_orig_company_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_sec_range)));
    avelength_orig_company_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_sec_range)),h.orig_company_address_sec_range<>(typeof(h.orig_company_address_sec_range))'');
    populated_orig_company_address_city_cnt := COUNT(GROUP,h.orig_company_address_city <> (TYPEOF(h.orig_company_address_city))'');
    populated_orig_company_address_city_pcnt := AVE(GROUP,IF(h.orig_company_address_city = (TYPEOF(h.orig_company_address_city))'',0,100));
    maxlength_orig_company_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_city)));
    avelength_orig_company_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_city)),h.orig_company_address_city<>(typeof(h.orig_company_address_city))'');
    populated_orig_company_address_st_cnt := COUNT(GROUP,h.orig_company_address_st <> (TYPEOF(h.orig_company_address_st))'');
    populated_orig_company_address_st_pcnt := AVE(GROUP,IF(h.orig_company_address_st = (TYPEOF(h.orig_company_address_st))'',0,100));
    maxlength_orig_company_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_st)));
    avelength_orig_company_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_st)),h.orig_company_address_st<>(typeof(h.orig_company_address_st))'');
    populated_orig_company_address_zip5_cnt := COUNT(GROUP,h.orig_company_address_zip5 <> (TYPEOF(h.orig_company_address_zip5))'');
    populated_orig_company_address_zip5_pcnt := AVE(GROUP,IF(h.orig_company_address_zip5 = (TYPEOF(h.orig_company_address_zip5))'',0,100));
    maxlength_orig_company_address_zip5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_zip5)));
    avelength_orig_company_address_zip5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_zip5)),h.orig_company_address_zip5<>(typeof(h.orig_company_address_zip5))'');
    populated_orig_company_address_zip4_cnt := COUNT(GROUP,h.orig_company_address_zip4 <> (TYPEOF(h.orig_company_address_zip4))'');
    populated_orig_company_address_zip4_pcnt := AVE(GROUP,IF(h.orig_company_address_zip4 = (TYPEOF(h.orig_company_address_zip4))'',0,100));
    maxlength_orig_company_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_zip4)));
    avelength_orig_company_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_address_zip4)),h.orig_company_address_zip4<>(typeof(h.orig_company_address_zip4))'');
    populated_orig_company_fax_number_cnt := COUNT(GROUP,h.orig_company_fax_number <> (TYPEOF(h.orig_company_fax_number))'');
    populated_orig_company_fax_number_pcnt := AVE(GROUP,IF(h.orig_company_fax_number = (TYPEOF(h.orig_company_fax_number))'',0,100));
    maxlength_orig_company_fax_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_fax_number)));
    avelength_orig_company_fax_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_fax_number)),h.orig_company_fax_number<>(typeof(h.orig_company_fax_number))'');
    populated_orig_company_start_date_cnt := COUNT(GROUP,h.orig_company_start_date <> (TYPEOF(h.orig_company_start_date))'');
    populated_orig_company_start_date_pcnt := AVE(GROUP,IF(h.orig_company_start_date = (TYPEOF(h.orig_company_start_date))'',0,100));
    maxlength_orig_company_start_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_start_date)));
    avelength_orig_company_start_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_start_date)),h.orig_company_start_date<>(typeof(h.orig_company_start_date))'');
    populated_orig_company_years_in_business_cnt := COUNT(GROUP,h.orig_company_years_in_business <> (TYPEOF(h.orig_company_years_in_business))'');
    populated_orig_company_years_in_business_pcnt := AVE(GROUP,IF(h.orig_company_years_in_business = (TYPEOF(h.orig_company_years_in_business))'',0,100));
    maxlength_orig_company_years_in_business := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_years_in_business)));
    avelength_orig_company_years_in_business := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_years_in_business)),h.orig_company_years_in_business<>(typeof(h.orig_company_years_in_business))'');
    populated_orig_company_sic_code_cnt := COUNT(GROUP,h.orig_company_sic_code <> (TYPEOF(h.orig_company_sic_code))'');
    populated_orig_company_sic_code_pcnt := AVE(GROUP,IF(h.orig_company_sic_code = (TYPEOF(h.orig_company_sic_code))'',0,100));
    maxlength_orig_company_sic_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_sic_code)));
    avelength_orig_company_sic_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_sic_code)),h.orig_company_sic_code<>(typeof(h.orig_company_sic_code))'');
    populated_orig_company_naic_code_cnt := COUNT(GROUP,h.orig_company_naic_code <> (TYPEOF(h.orig_company_naic_code))'');
    populated_orig_company_naic_code_pcnt := AVE(GROUP,IF(h.orig_company_naic_code = (TYPEOF(h.orig_company_naic_code))'',0,100));
    maxlength_orig_company_naic_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_naic_code)));
    avelength_orig_company_naic_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_naic_code)),h.orig_company_naic_code<>(typeof(h.orig_company_naic_code))'');
    populated_orig_company_structure_cnt := COUNT(GROUP,h.orig_company_structure <> (TYPEOF(h.orig_company_structure))'');
    populated_orig_company_structure_pcnt := AVE(GROUP,IF(h.orig_company_structure = (TYPEOF(h.orig_company_structure))'',0,100));
    maxlength_orig_company_structure := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_structure)));
    avelength_orig_company_structure := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_structure)),h.orig_company_structure<>(typeof(h.orig_company_structure))'');
    populated_orig_company_yearly_revenue_cnt := COUNT(GROUP,h.orig_company_yearly_revenue <> (TYPEOF(h.orig_company_yearly_revenue))'');
    populated_orig_company_yearly_revenue_pcnt := AVE(GROUP,IF(h.orig_company_yearly_revenue = (TYPEOF(h.orig_company_yearly_revenue))'',0,100));
    maxlength_orig_company_yearly_revenue := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_yearly_revenue)));
    avelength_orig_company_yearly_revenue := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_yearly_revenue)),h.orig_company_yearly_revenue<>(typeof(h.orig_company_yearly_revenue))'');
    populated_orig_subj2_first_name_cnt := COUNT(GROUP,h.orig_subj2_first_name <> (TYPEOF(h.orig_subj2_first_name))'');
    populated_orig_subj2_first_name_pcnt := AVE(GROUP,IF(h.orig_subj2_first_name = (TYPEOF(h.orig_subj2_first_name))'',0,100));
    maxlength_orig_subj2_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_first_name)));
    avelength_orig_subj2_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_first_name)),h.orig_subj2_first_name<>(typeof(h.orig_subj2_first_name))'');
    populated_orig_subj2_middle_name_cnt := COUNT(GROUP,h.orig_subj2_middle_name <> (TYPEOF(h.orig_subj2_middle_name))'');
    populated_orig_subj2_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj2_middle_name = (TYPEOF(h.orig_subj2_middle_name))'',0,100));
    maxlength_orig_subj2_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_middle_name)));
    avelength_orig_subj2_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_middle_name)),h.orig_subj2_middle_name<>(typeof(h.orig_subj2_middle_name))'');
    populated_orig_subj2_last_name_cnt := COUNT(GROUP,h.orig_subj2_last_name <> (TYPEOF(h.orig_subj2_last_name))'');
    populated_orig_subj2_last_name_pcnt := AVE(GROUP,IF(h.orig_subj2_last_name = (TYPEOF(h.orig_subj2_last_name))'',0,100));
    maxlength_orig_subj2_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_last_name)));
    avelength_orig_subj2_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_last_name)),h.orig_subj2_last_name<>(typeof(h.orig_subj2_last_name))'');
    populated_orig_subj2_suffix_name_cnt := COUNT(GROUP,h.orig_subj2_suffix_name <> (TYPEOF(h.orig_subj2_suffix_name))'');
    populated_orig_subj2_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj2_suffix_name = (TYPEOF(h.orig_subj2_suffix_name))'',0,100));
    maxlength_orig_subj2_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_suffix_name)));
    avelength_orig_subj2_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_suffix_name)),h.orig_subj2_suffix_name<>(typeof(h.orig_subj2_suffix_name))'');
    populated_orig_subj2_full_name_cnt := COUNT(GROUP,h.orig_subj2_full_name <> (TYPEOF(h.orig_subj2_full_name))'');
    populated_orig_subj2_full_name_pcnt := AVE(GROUP,IF(h.orig_subj2_full_name = (TYPEOF(h.orig_subj2_full_name))'',0,100));
    maxlength_orig_subj2_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_full_name)));
    avelength_orig_subj2_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_full_name)),h.orig_subj2_full_name<>(typeof(h.orig_subj2_full_name))'');
    populated_orig_subj2_ssn_cnt := COUNT(GROUP,h.orig_subj2_ssn <> (TYPEOF(h.orig_subj2_ssn))'');
    populated_orig_subj2_ssn_pcnt := AVE(GROUP,IF(h.orig_subj2_ssn = (TYPEOF(h.orig_subj2_ssn))'',0,100));
    maxlength_orig_subj2_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_ssn)));
    avelength_orig_subj2_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_ssn)),h.orig_subj2_ssn<>(typeof(h.orig_subj2_ssn))'');
    populated_orig_subj2_dob_cnt := COUNT(GROUP,h.orig_subj2_dob <> (TYPEOF(h.orig_subj2_dob))'');
    populated_orig_subj2_dob_pcnt := AVE(GROUP,IF(h.orig_subj2_dob = (TYPEOF(h.orig_subj2_dob))'',0,100));
    maxlength_orig_subj2_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_dob)));
    avelength_orig_subj2_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_dob)),h.orig_subj2_dob<>(typeof(h.orig_subj2_dob))'');
    populated_orig_subj2_dl_num_cnt := COUNT(GROUP,h.orig_subj2_dl_num <> (TYPEOF(h.orig_subj2_dl_num))'');
    populated_orig_subj2_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj2_dl_num = (TYPEOF(h.orig_subj2_dl_num))'',0,100));
    maxlength_orig_subj2_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_dl_num)));
    avelength_orig_subj2_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_dl_num)),h.orig_subj2_dl_num<>(typeof(h.orig_subj2_dl_num))'');
    populated_orig_subj2_dl_state_cnt := COUNT(GROUP,h.orig_subj2_dl_state <> (TYPEOF(h.orig_subj2_dl_state))'');
    populated_orig_subj2_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj2_dl_state = (TYPEOF(h.orig_subj2_dl_state))'',0,100));
    maxlength_orig_subj2_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_dl_state)));
    avelength_orig_subj2_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_dl_state)),h.orig_subj2_dl_state<>(typeof(h.orig_subj2_dl_state))'');
    populated_orig_subj2_former_last_name_cnt := COUNT(GROUP,h.orig_subj2_former_last_name <> (TYPEOF(h.orig_subj2_former_last_name))'');
    populated_orig_subj2_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj2_former_last_name = (TYPEOF(h.orig_subj2_former_last_name))'',0,100));
    maxlength_orig_subj2_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_former_last_name)));
    avelength_orig_subj2_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_former_last_name)),h.orig_subj2_former_last_name<>(typeof(h.orig_subj2_former_last_name))'');
    populated_orig_subj2_address_addressline1_cnt := COUNT(GROUP,h.orig_subj2_address_addressline1 <> (TYPEOF(h.orig_subj2_address_addressline1))'');
    populated_orig_subj2_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj2_address_addressline1 = (TYPEOF(h.orig_subj2_address_addressline1))'',0,100));
    maxlength_orig_subj2_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_addressline1)));
    avelength_orig_subj2_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_addressline1)),h.orig_subj2_address_addressline1<>(typeof(h.orig_subj2_address_addressline1))'');
    populated_orig_subj2_address_addressline2_cnt := COUNT(GROUP,h.orig_subj2_address_addressline2 <> (TYPEOF(h.orig_subj2_address_addressline2))'');
    populated_orig_subj2_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj2_address_addressline2 = (TYPEOF(h.orig_subj2_address_addressline2))'',0,100));
    maxlength_orig_subj2_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_addressline2)));
    avelength_orig_subj2_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_addressline2)),h.orig_subj2_address_addressline2<>(typeof(h.orig_subj2_address_addressline2))'');
    populated_orig_subj2_address_prim_range_cnt := COUNT(GROUP,h.orig_subj2_address_prim_range <> (TYPEOF(h.orig_subj2_address_prim_range))'');
    populated_orig_subj2_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj2_address_prim_range = (TYPEOF(h.orig_subj2_address_prim_range))'',0,100));
    maxlength_orig_subj2_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_prim_range)));
    avelength_orig_subj2_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_prim_range)),h.orig_subj2_address_prim_range<>(typeof(h.orig_subj2_address_prim_range))'');
    populated_orig_subj2_address_predir_cnt := COUNT(GROUP,h.orig_subj2_address_predir <> (TYPEOF(h.orig_subj2_address_predir))'');
    populated_orig_subj2_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj2_address_predir = (TYPEOF(h.orig_subj2_address_predir))'',0,100));
    maxlength_orig_subj2_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_predir)));
    avelength_orig_subj2_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_predir)),h.orig_subj2_address_predir<>(typeof(h.orig_subj2_address_predir))'');
    populated_orig_subj2_address_prim_name_cnt := COUNT(GROUP,h.orig_subj2_address_prim_name <> (TYPEOF(h.orig_subj2_address_prim_name))'');
    populated_orig_subj2_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj2_address_prim_name = (TYPEOF(h.orig_subj2_address_prim_name))'',0,100));
    maxlength_orig_subj2_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_prim_name)));
    avelength_orig_subj2_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_prim_name)),h.orig_subj2_address_prim_name<>(typeof(h.orig_subj2_address_prim_name))'');
    populated_orig_subj2_address_suffix_cnt := COUNT(GROUP,h.orig_subj2_address_suffix <> (TYPEOF(h.orig_subj2_address_suffix))'');
    populated_orig_subj2_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj2_address_suffix = (TYPEOF(h.orig_subj2_address_suffix))'',0,100));
    maxlength_orig_subj2_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_suffix)));
    avelength_orig_subj2_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_suffix)),h.orig_subj2_address_suffix<>(typeof(h.orig_subj2_address_suffix))'');
    populated_orig_subj2_address_postdir_cnt := COUNT(GROUP,h.orig_subj2_address_postdir <> (TYPEOF(h.orig_subj2_address_postdir))'');
    populated_orig_subj2_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj2_address_postdir = (TYPEOF(h.orig_subj2_address_postdir))'',0,100));
    maxlength_orig_subj2_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_postdir)));
    avelength_orig_subj2_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_postdir)),h.orig_subj2_address_postdir<>(typeof(h.orig_subj2_address_postdir))'');
    populated_orig_subj2_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj2_address_unit_desig <> (TYPEOF(h.orig_subj2_address_unit_desig))'');
    populated_orig_subj2_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj2_address_unit_desig = (TYPEOF(h.orig_subj2_address_unit_desig))'',0,100));
    maxlength_orig_subj2_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_unit_desig)));
    avelength_orig_subj2_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_unit_desig)),h.orig_subj2_address_unit_desig<>(typeof(h.orig_subj2_address_unit_desig))'');
    populated_orig_subj2_address_sec_range_cnt := COUNT(GROUP,h.orig_subj2_address_sec_range <> (TYPEOF(h.orig_subj2_address_sec_range))'');
    populated_orig_subj2_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj2_address_sec_range = (TYPEOF(h.orig_subj2_address_sec_range))'',0,100));
    maxlength_orig_subj2_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_sec_range)));
    avelength_orig_subj2_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_sec_range)),h.orig_subj2_address_sec_range<>(typeof(h.orig_subj2_address_sec_range))'');
    populated_orig_subj2_address_city_cnt := COUNT(GROUP,h.orig_subj2_address_city <> (TYPEOF(h.orig_subj2_address_city))'');
    populated_orig_subj2_address_city_pcnt := AVE(GROUP,IF(h.orig_subj2_address_city = (TYPEOF(h.orig_subj2_address_city))'',0,100));
    maxlength_orig_subj2_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_city)));
    avelength_orig_subj2_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_city)),h.orig_subj2_address_city<>(typeof(h.orig_subj2_address_city))'');
    populated_orig_subj2_address_st_cnt := COUNT(GROUP,h.orig_subj2_address_st <> (TYPEOF(h.orig_subj2_address_st))'');
    populated_orig_subj2_address_st_pcnt := AVE(GROUP,IF(h.orig_subj2_address_st = (TYPEOF(h.orig_subj2_address_st))'',0,100));
    maxlength_orig_subj2_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_st)));
    avelength_orig_subj2_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_st)),h.orig_subj2_address_st<>(typeof(h.orig_subj2_address_st))'');
    populated_orig_subj2_address_z5_cnt := COUNT(GROUP,h.orig_subj2_address_z5 <> (TYPEOF(h.orig_subj2_address_z5))'');
    populated_orig_subj2_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj2_address_z5 = (TYPEOF(h.orig_subj2_address_z5))'',0,100));
    maxlength_orig_subj2_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_z5)));
    avelength_orig_subj2_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_z5)),h.orig_subj2_address_z5<>(typeof(h.orig_subj2_address_z5))'');
    populated_orig_subj2_address_z4_cnt := COUNT(GROUP,h.orig_subj2_address_z4 <> (TYPEOF(h.orig_subj2_address_z4))'');
    populated_orig_subj2_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj2_address_z4 = (TYPEOF(h.orig_subj2_address_z4))'',0,100));
    maxlength_orig_subj2_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_z4)));
    avelength_orig_subj2_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_address_z4)),h.orig_subj2_address_z4<>(typeof(h.orig_subj2_address_z4))'');
    populated_orig_subj2_phone_cnt := COUNT(GROUP,h.orig_subj2_phone <> (TYPEOF(h.orig_subj2_phone))'');
    populated_orig_subj2_phone_pcnt := AVE(GROUP,IF(h.orig_subj2_phone = (TYPEOF(h.orig_subj2_phone))'',0,100));
    maxlength_orig_subj2_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_phone)));
    avelength_orig_subj2_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_phone)),h.orig_subj2_phone<>(typeof(h.orig_subj2_phone))'');
    populated_orig_subj2_work_phone_cnt := COUNT(GROUP,h.orig_subj2_work_phone <> (TYPEOF(h.orig_subj2_work_phone))'');
    populated_orig_subj2_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj2_work_phone = (TYPEOF(h.orig_subj2_work_phone))'',0,100));
    maxlength_orig_subj2_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_work_phone)));
    avelength_orig_subj2_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_work_phone)),h.orig_subj2_work_phone<>(typeof(h.orig_subj2_work_phone))'');
    populated_orig_subj2_business_title_cnt := COUNT(GROUP,h.orig_subj2_business_title <> (TYPEOF(h.orig_subj2_business_title))'');
    populated_orig_subj2_business_title_pcnt := AVE(GROUP,IF(h.orig_subj2_business_title = (TYPEOF(h.orig_subj2_business_title))'',0,100));
    maxlength_orig_subj2_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_business_title)));
    avelength_orig_subj2_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_business_title)),h.orig_subj2_business_title<>(typeof(h.orig_subj2_business_title))'');
    populated_orig_subj3_first_name_cnt := COUNT(GROUP,h.orig_subj3_first_name <> (TYPEOF(h.orig_subj3_first_name))'');
    populated_orig_subj3_first_name_pcnt := AVE(GROUP,IF(h.orig_subj3_first_name = (TYPEOF(h.orig_subj3_first_name))'',0,100));
    maxlength_orig_subj3_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_first_name)));
    avelength_orig_subj3_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_first_name)),h.orig_subj3_first_name<>(typeof(h.orig_subj3_first_name))'');
    populated_orig_subj3_middle_name_cnt := COUNT(GROUP,h.orig_subj3_middle_name <> (TYPEOF(h.orig_subj3_middle_name))'');
    populated_orig_subj3_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj3_middle_name = (TYPEOF(h.orig_subj3_middle_name))'',0,100));
    maxlength_orig_subj3_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_middle_name)));
    avelength_orig_subj3_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_middle_name)),h.orig_subj3_middle_name<>(typeof(h.orig_subj3_middle_name))'');
    populated_orig_subj3_last_name_cnt := COUNT(GROUP,h.orig_subj3_last_name <> (TYPEOF(h.orig_subj3_last_name))'');
    populated_orig_subj3_last_name_pcnt := AVE(GROUP,IF(h.orig_subj3_last_name = (TYPEOF(h.orig_subj3_last_name))'',0,100));
    maxlength_orig_subj3_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_last_name)));
    avelength_orig_subj3_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_last_name)),h.orig_subj3_last_name<>(typeof(h.orig_subj3_last_name))'');
    populated_orig_subj3_suffix_name_cnt := COUNT(GROUP,h.orig_subj3_suffix_name <> (TYPEOF(h.orig_subj3_suffix_name))'');
    populated_orig_subj3_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj3_suffix_name = (TYPEOF(h.orig_subj3_suffix_name))'',0,100));
    maxlength_orig_subj3_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_suffix_name)));
    avelength_orig_subj3_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_suffix_name)),h.orig_subj3_suffix_name<>(typeof(h.orig_subj3_suffix_name))'');
    populated_orig_subj3_full_name_cnt := COUNT(GROUP,h.orig_subj3_full_name <> (TYPEOF(h.orig_subj3_full_name))'');
    populated_orig_subj3_full_name_pcnt := AVE(GROUP,IF(h.orig_subj3_full_name = (TYPEOF(h.orig_subj3_full_name))'',0,100));
    maxlength_orig_subj3_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_full_name)));
    avelength_orig_subj3_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_full_name)),h.orig_subj3_full_name<>(typeof(h.orig_subj3_full_name))'');
    populated_orig_subj3_ssn_cnt := COUNT(GROUP,h.orig_subj3_ssn <> (TYPEOF(h.orig_subj3_ssn))'');
    populated_orig_subj3_ssn_pcnt := AVE(GROUP,IF(h.orig_subj3_ssn = (TYPEOF(h.orig_subj3_ssn))'',0,100));
    maxlength_orig_subj3_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_ssn)));
    avelength_orig_subj3_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_ssn)),h.orig_subj3_ssn<>(typeof(h.orig_subj3_ssn))'');
    populated_orig_subj3_dob_cnt := COUNT(GROUP,h.orig_subj3_dob <> (TYPEOF(h.orig_subj3_dob))'');
    populated_orig_subj3_dob_pcnt := AVE(GROUP,IF(h.orig_subj3_dob = (TYPEOF(h.orig_subj3_dob))'',0,100));
    maxlength_orig_subj3_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_dob)));
    avelength_orig_subj3_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_dob)),h.orig_subj3_dob<>(typeof(h.orig_subj3_dob))'');
    populated_orig_subj3_dl_num_cnt := COUNT(GROUP,h.orig_subj3_dl_num <> (TYPEOF(h.orig_subj3_dl_num))'');
    populated_orig_subj3_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj3_dl_num = (TYPEOF(h.orig_subj3_dl_num))'',0,100));
    maxlength_orig_subj3_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_dl_num)));
    avelength_orig_subj3_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_dl_num)),h.orig_subj3_dl_num<>(typeof(h.orig_subj3_dl_num))'');
    populated_orig_subj3_dl_state_cnt := COUNT(GROUP,h.orig_subj3_dl_state <> (TYPEOF(h.orig_subj3_dl_state))'');
    populated_orig_subj3_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj3_dl_state = (TYPEOF(h.orig_subj3_dl_state))'',0,100));
    maxlength_orig_subj3_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_dl_state)));
    avelength_orig_subj3_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_dl_state)),h.orig_subj3_dl_state<>(typeof(h.orig_subj3_dl_state))'');
    populated_orig_subj3_former_last_name_cnt := COUNT(GROUP,h.orig_subj3_former_last_name <> (TYPEOF(h.orig_subj3_former_last_name))'');
    populated_orig_subj3_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj3_former_last_name = (TYPEOF(h.orig_subj3_former_last_name))'',0,100));
    maxlength_orig_subj3_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_former_last_name)));
    avelength_orig_subj3_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_former_last_name)),h.orig_subj3_former_last_name<>(typeof(h.orig_subj3_former_last_name))'');
    populated_orig_subj3_address_addressline1_cnt := COUNT(GROUP,h.orig_subj3_address_addressline1 <> (TYPEOF(h.orig_subj3_address_addressline1))'');
    populated_orig_subj3_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj3_address_addressline1 = (TYPEOF(h.orig_subj3_address_addressline1))'',0,100));
    maxlength_orig_subj3_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_addressline1)));
    avelength_orig_subj3_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_addressline1)),h.orig_subj3_address_addressline1<>(typeof(h.orig_subj3_address_addressline1))'');
    populated_orig_subj3_address_addressline2_cnt := COUNT(GROUP,h.orig_subj3_address_addressline2 <> (TYPEOF(h.orig_subj3_address_addressline2))'');
    populated_orig_subj3_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj3_address_addressline2 = (TYPEOF(h.orig_subj3_address_addressline2))'',0,100));
    maxlength_orig_subj3_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_addressline2)));
    avelength_orig_subj3_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_addressline2)),h.orig_subj3_address_addressline2<>(typeof(h.orig_subj3_address_addressline2))'');
    populated_orig_subj3_address_prim_range_cnt := COUNT(GROUP,h.orig_subj3_address_prim_range <> (TYPEOF(h.orig_subj3_address_prim_range))'');
    populated_orig_subj3_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj3_address_prim_range = (TYPEOF(h.orig_subj3_address_prim_range))'',0,100));
    maxlength_orig_subj3_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_prim_range)));
    avelength_orig_subj3_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_prim_range)),h.orig_subj3_address_prim_range<>(typeof(h.orig_subj3_address_prim_range))'');
    populated_orig_subj3_address_predir_cnt := COUNT(GROUP,h.orig_subj3_address_predir <> (TYPEOF(h.orig_subj3_address_predir))'');
    populated_orig_subj3_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj3_address_predir = (TYPEOF(h.orig_subj3_address_predir))'',0,100));
    maxlength_orig_subj3_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_predir)));
    avelength_orig_subj3_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_predir)),h.orig_subj3_address_predir<>(typeof(h.orig_subj3_address_predir))'');
    populated_orig_subj3_address_prim_name_cnt := COUNT(GROUP,h.orig_subj3_address_prim_name <> (TYPEOF(h.orig_subj3_address_prim_name))'');
    populated_orig_subj3_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj3_address_prim_name = (TYPEOF(h.orig_subj3_address_prim_name))'',0,100));
    maxlength_orig_subj3_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_prim_name)));
    avelength_orig_subj3_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_prim_name)),h.orig_subj3_address_prim_name<>(typeof(h.orig_subj3_address_prim_name))'');
    populated_orig_subj3_address_suffix_cnt := COUNT(GROUP,h.orig_subj3_address_suffix <> (TYPEOF(h.orig_subj3_address_suffix))'');
    populated_orig_subj3_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj3_address_suffix = (TYPEOF(h.orig_subj3_address_suffix))'',0,100));
    maxlength_orig_subj3_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_suffix)));
    avelength_orig_subj3_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_suffix)),h.orig_subj3_address_suffix<>(typeof(h.orig_subj3_address_suffix))'');
    populated_orig_subj3_address_postdir_cnt := COUNT(GROUP,h.orig_subj3_address_postdir <> (TYPEOF(h.orig_subj3_address_postdir))'');
    populated_orig_subj3_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj3_address_postdir = (TYPEOF(h.orig_subj3_address_postdir))'',0,100));
    maxlength_orig_subj3_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_postdir)));
    avelength_orig_subj3_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_postdir)),h.orig_subj3_address_postdir<>(typeof(h.orig_subj3_address_postdir))'');
    populated_orig_subj3_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj3_address_unit_desig <> (TYPEOF(h.orig_subj3_address_unit_desig))'');
    populated_orig_subj3_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj3_address_unit_desig = (TYPEOF(h.orig_subj3_address_unit_desig))'',0,100));
    maxlength_orig_subj3_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_unit_desig)));
    avelength_orig_subj3_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_unit_desig)),h.orig_subj3_address_unit_desig<>(typeof(h.orig_subj3_address_unit_desig))'');
    populated_orig_subj3_address_sec_range_cnt := COUNT(GROUP,h.orig_subj3_address_sec_range <> (TYPEOF(h.orig_subj3_address_sec_range))'');
    populated_orig_subj3_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj3_address_sec_range = (TYPEOF(h.orig_subj3_address_sec_range))'',0,100));
    maxlength_orig_subj3_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_sec_range)));
    avelength_orig_subj3_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_sec_range)),h.orig_subj3_address_sec_range<>(typeof(h.orig_subj3_address_sec_range))'');
    populated_orig_subj3_address_city_cnt := COUNT(GROUP,h.orig_subj3_address_city <> (TYPEOF(h.orig_subj3_address_city))'');
    populated_orig_subj3_address_city_pcnt := AVE(GROUP,IF(h.orig_subj3_address_city = (TYPEOF(h.orig_subj3_address_city))'',0,100));
    maxlength_orig_subj3_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_city)));
    avelength_orig_subj3_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_city)),h.orig_subj3_address_city<>(typeof(h.orig_subj3_address_city))'');
    populated_orig_subj3_address_st_cnt := COUNT(GROUP,h.orig_subj3_address_st <> (TYPEOF(h.orig_subj3_address_st))'');
    populated_orig_subj3_address_st_pcnt := AVE(GROUP,IF(h.orig_subj3_address_st = (TYPEOF(h.orig_subj3_address_st))'',0,100));
    maxlength_orig_subj3_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_st)));
    avelength_orig_subj3_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_st)),h.orig_subj3_address_st<>(typeof(h.orig_subj3_address_st))'');
    populated_orig_subj3_address_z5_cnt := COUNT(GROUP,h.orig_subj3_address_z5 <> (TYPEOF(h.orig_subj3_address_z5))'');
    populated_orig_subj3_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj3_address_z5 = (TYPEOF(h.orig_subj3_address_z5))'',0,100));
    maxlength_orig_subj3_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_z5)));
    avelength_orig_subj3_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_z5)),h.orig_subj3_address_z5<>(typeof(h.orig_subj3_address_z5))'');
    populated_orig_subj3_address_z4_cnt := COUNT(GROUP,h.orig_subj3_address_z4 <> (TYPEOF(h.orig_subj3_address_z4))'');
    populated_orig_subj3_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj3_address_z4 = (TYPEOF(h.orig_subj3_address_z4))'',0,100));
    maxlength_orig_subj3_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_z4)));
    avelength_orig_subj3_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_address_z4)),h.orig_subj3_address_z4<>(typeof(h.orig_subj3_address_z4))'');
    populated_orig_subj3_phone_cnt := COUNT(GROUP,h.orig_subj3_phone <> (TYPEOF(h.orig_subj3_phone))'');
    populated_orig_subj3_phone_pcnt := AVE(GROUP,IF(h.orig_subj3_phone = (TYPEOF(h.orig_subj3_phone))'',0,100));
    maxlength_orig_subj3_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_phone)));
    avelength_orig_subj3_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_phone)),h.orig_subj3_phone<>(typeof(h.orig_subj3_phone))'');
    populated_orig_subj3_work_phone_cnt := COUNT(GROUP,h.orig_subj3_work_phone <> (TYPEOF(h.orig_subj3_work_phone))'');
    populated_orig_subj3_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj3_work_phone = (TYPEOF(h.orig_subj3_work_phone))'',0,100));
    maxlength_orig_subj3_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_work_phone)));
    avelength_orig_subj3_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_work_phone)),h.orig_subj3_work_phone<>(typeof(h.orig_subj3_work_phone))'');
    populated_orig_subj3_business_title_cnt := COUNT(GROUP,h.orig_subj3_business_title <> (TYPEOF(h.orig_subj3_business_title))'');
    populated_orig_subj3_business_title_pcnt := AVE(GROUP,IF(h.orig_subj3_business_title = (TYPEOF(h.orig_subj3_business_title))'',0,100));
    maxlength_orig_subj3_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_business_title)));
    avelength_orig_subj3_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_business_title)),h.orig_subj3_business_title<>(typeof(h.orig_subj3_business_title))'');
    populated_orig_email_cnt := COUNT(GROUP,h.orig_email <> (TYPEOF(h.orig_email))'');
    populated_orig_email_pcnt := AVE(GROUP,IF(h.orig_email = (TYPEOF(h.orig_email))'',0,100));
    maxlength_orig_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email)));
    avelength_orig_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email)),h.orig_email<>(typeof(h.orig_email))'');
    populated_orig_subj2_email_cnt := COUNT(GROUP,h.orig_subj2_email <> (TYPEOF(h.orig_subj2_email))'');
    populated_orig_subj2_email_pcnt := AVE(GROUP,IF(h.orig_subj2_email = (TYPEOF(h.orig_subj2_email))'',0,100));
    maxlength_orig_subj2_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_email)));
    avelength_orig_subj2_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_email)),h.orig_subj2_email<>(typeof(h.orig_subj2_email))'');
    populated_orig_subj2_company_name_cnt := COUNT(GROUP,h.orig_subj2_company_name <> (TYPEOF(h.orig_subj2_company_name))'');
    populated_orig_subj2_company_name_pcnt := AVE(GROUP,IF(h.orig_subj2_company_name = (TYPEOF(h.orig_subj2_company_name))'',0,100));
    maxlength_orig_subj2_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_company_name)));
    avelength_orig_subj2_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_company_name)),h.orig_subj2_company_name<>(typeof(h.orig_subj2_company_name))'');
    populated_orig_subj2_fein_cnt := COUNT(GROUP,h.orig_subj2_fein <> (TYPEOF(h.orig_subj2_fein))'');
    populated_orig_subj2_fein_pcnt := AVE(GROUP,IF(h.orig_subj2_fein = (TYPEOF(h.orig_subj2_fein))'',0,100));
    maxlength_orig_subj2_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_fein)));
    avelength_orig_subj2_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj2_fein)),h.orig_subj2_fein<>(typeof(h.orig_subj2_fein))'');
    populated_orig_subj3_email_cnt := COUNT(GROUP,h.orig_subj3_email <> (TYPEOF(h.orig_subj3_email))'');
    populated_orig_subj3_email_pcnt := AVE(GROUP,IF(h.orig_subj3_email = (TYPEOF(h.orig_subj3_email))'',0,100));
    maxlength_orig_subj3_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_email)));
    avelength_orig_subj3_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_email)),h.orig_subj3_email<>(typeof(h.orig_subj3_email))'');
    populated_orig_subj3_company_name_cnt := COUNT(GROUP,h.orig_subj3_company_name <> (TYPEOF(h.orig_subj3_company_name))'');
    populated_orig_subj3_company_name_pcnt := AVE(GROUP,IF(h.orig_subj3_company_name = (TYPEOF(h.orig_subj3_company_name))'',0,100));
    maxlength_orig_subj3_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_company_name)));
    avelength_orig_subj3_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_company_name)),h.orig_subj3_company_name<>(typeof(h.orig_subj3_company_name))'');
    populated_orig_subj3_fein_cnt := COUNT(GROUP,h.orig_subj3_fein <> (TYPEOF(h.orig_subj3_fein))'');
    populated_orig_subj3_fein_pcnt := AVE(GROUP,IF(h.orig_subj3_fein = (TYPEOF(h.orig_subj3_fein))'',0,100));
    maxlength_orig_subj3_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_fein)));
    avelength_orig_subj3_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj3_fein)),h.orig_subj3_fein<>(typeof(h.orig_subj3_fein))'');
    populated_orig_subj4_first_name_cnt := COUNT(GROUP,h.orig_subj4_first_name <> (TYPEOF(h.orig_subj4_first_name))'');
    populated_orig_subj4_first_name_pcnt := AVE(GROUP,IF(h.orig_subj4_first_name = (TYPEOF(h.orig_subj4_first_name))'',0,100));
    maxlength_orig_subj4_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_first_name)));
    avelength_orig_subj4_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_first_name)),h.orig_subj4_first_name<>(typeof(h.orig_subj4_first_name))'');
    populated_orig_subj4_middle_name_cnt := COUNT(GROUP,h.orig_subj4_middle_name <> (TYPEOF(h.orig_subj4_middle_name))'');
    populated_orig_subj4_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj4_middle_name = (TYPEOF(h.orig_subj4_middle_name))'',0,100));
    maxlength_orig_subj4_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_middle_name)));
    avelength_orig_subj4_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_middle_name)),h.orig_subj4_middle_name<>(typeof(h.orig_subj4_middle_name))'');
    populated_orig_subj4_last_name_cnt := COUNT(GROUP,h.orig_subj4_last_name <> (TYPEOF(h.orig_subj4_last_name))'');
    populated_orig_subj4_last_name_pcnt := AVE(GROUP,IF(h.orig_subj4_last_name = (TYPEOF(h.orig_subj4_last_name))'',0,100));
    maxlength_orig_subj4_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_last_name)));
    avelength_orig_subj4_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_last_name)),h.orig_subj4_last_name<>(typeof(h.orig_subj4_last_name))'');
    populated_orig_subj4_suffix_name_cnt := COUNT(GROUP,h.orig_subj4_suffix_name <> (TYPEOF(h.orig_subj4_suffix_name))'');
    populated_orig_subj4_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj4_suffix_name = (TYPEOF(h.orig_subj4_suffix_name))'',0,100));
    maxlength_orig_subj4_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_suffix_name)));
    avelength_orig_subj4_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_suffix_name)),h.orig_subj4_suffix_name<>(typeof(h.orig_subj4_suffix_name))'');
    populated_orig_subj4_full_name_cnt := COUNT(GROUP,h.orig_subj4_full_name <> (TYPEOF(h.orig_subj4_full_name))'');
    populated_orig_subj4_full_name_pcnt := AVE(GROUP,IF(h.orig_subj4_full_name = (TYPEOF(h.orig_subj4_full_name))'',0,100));
    maxlength_orig_subj4_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_full_name)));
    avelength_orig_subj4_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_full_name)),h.orig_subj4_full_name<>(typeof(h.orig_subj4_full_name))'');
    populated_orig_subj4_ssn_cnt := COUNT(GROUP,h.orig_subj4_ssn <> (TYPEOF(h.orig_subj4_ssn))'');
    populated_orig_subj4_ssn_pcnt := AVE(GROUP,IF(h.orig_subj4_ssn = (TYPEOF(h.orig_subj4_ssn))'',0,100));
    maxlength_orig_subj4_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_ssn)));
    avelength_orig_subj4_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_ssn)),h.orig_subj4_ssn<>(typeof(h.orig_subj4_ssn))'');
    populated_orig_subj4_dob_cnt := COUNT(GROUP,h.orig_subj4_dob <> (TYPEOF(h.orig_subj4_dob))'');
    populated_orig_subj4_dob_pcnt := AVE(GROUP,IF(h.orig_subj4_dob = (TYPEOF(h.orig_subj4_dob))'',0,100));
    maxlength_orig_subj4_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_dob)));
    avelength_orig_subj4_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_dob)),h.orig_subj4_dob<>(typeof(h.orig_subj4_dob))'');
    populated_orig_subj4_dl_num_cnt := COUNT(GROUP,h.orig_subj4_dl_num <> (TYPEOF(h.orig_subj4_dl_num))'');
    populated_orig_subj4_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj4_dl_num = (TYPEOF(h.orig_subj4_dl_num))'',0,100));
    maxlength_orig_subj4_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_dl_num)));
    avelength_orig_subj4_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_dl_num)),h.orig_subj4_dl_num<>(typeof(h.orig_subj4_dl_num))'');
    populated_orig_subj4_dl_state_cnt := COUNT(GROUP,h.orig_subj4_dl_state <> (TYPEOF(h.orig_subj4_dl_state))'');
    populated_orig_subj4_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj4_dl_state = (TYPEOF(h.orig_subj4_dl_state))'',0,100));
    maxlength_orig_subj4_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_dl_state)));
    avelength_orig_subj4_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_dl_state)),h.orig_subj4_dl_state<>(typeof(h.orig_subj4_dl_state))'');
    populated_orig_subj4_former_last_name_cnt := COUNT(GROUP,h.orig_subj4_former_last_name <> (TYPEOF(h.orig_subj4_former_last_name))'');
    populated_orig_subj4_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj4_former_last_name = (TYPEOF(h.orig_subj4_former_last_name))'',0,100));
    maxlength_orig_subj4_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_former_last_name)));
    avelength_orig_subj4_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_former_last_name)),h.orig_subj4_former_last_name<>(typeof(h.orig_subj4_former_last_name))'');
    populated_orig_subj4_address_addressline1_cnt := COUNT(GROUP,h.orig_subj4_address_addressline1 <> (TYPEOF(h.orig_subj4_address_addressline1))'');
    populated_orig_subj4_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj4_address_addressline1 = (TYPEOF(h.orig_subj4_address_addressline1))'',0,100));
    maxlength_orig_subj4_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_addressline1)));
    avelength_orig_subj4_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_addressline1)),h.orig_subj4_address_addressline1<>(typeof(h.orig_subj4_address_addressline1))'');
    populated_orig_subj4_address_addressline2_cnt := COUNT(GROUP,h.orig_subj4_address_addressline2 <> (TYPEOF(h.orig_subj4_address_addressline2))'');
    populated_orig_subj4_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj4_address_addressline2 = (TYPEOF(h.orig_subj4_address_addressline2))'',0,100));
    maxlength_orig_subj4_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_addressline2)));
    avelength_orig_subj4_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_addressline2)),h.orig_subj4_address_addressline2<>(typeof(h.orig_subj4_address_addressline2))'');
    populated_orig_subj4_address_prim_range_cnt := COUNT(GROUP,h.orig_subj4_address_prim_range <> (TYPEOF(h.orig_subj4_address_prim_range))'');
    populated_orig_subj4_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj4_address_prim_range = (TYPEOF(h.orig_subj4_address_prim_range))'',0,100));
    maxlength_orig_subj4_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_prim_range)));
    avelength_orig_subj4_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_prim_range)),h.orig_subj4_address_prim_range<>(typeof(h.orig_subj4_address_prim_range))'');
    populated_orig_subj4_address_predir_cnt := COUNT(GROUP,h.orig_subj4_address_predir <> (TYPEOF(h.orig_subj4_address_predir))'');
    populated_orig_subj4_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj4_address_predir = (TYPEOF(h.orig_subj4_address_predir))'',0,100));
    maxlength_orig_subj4_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_predir)));
    avelength_orig_subj4_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_predir)),h.orig_subj4_address_predir<>(typeof(h.orig_subj4_address_predir))'');
    populated_orig_subj4_address_prim_name_cnt := COUNT(GROUP,h.orig_subj4_address_prim_name <> (TYPEOF(h.orig_subj4_address_prim_name))'');
    populated_orig_subj4_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj4_address_prim_name = (TYPEOF(h.orig_subj4_address_prim_name))'',0,100));
    maxlength_orig_subj4_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_prim_name)));
    avelength_orig_subj4_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_prim_name)),h.orig_subj4_address_prim_name<>(typeof(h.orig_subj4_address_prim_name))'');
    populated_orig_subj4_address_suffix_cnt := COUNT(GROUP,h.orig_subj4_address_suffix <> (TYPEOF(h.orig_subj4_address_suffix))'');
    populated_orig_subj4_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj4_address_suffix = (TYPEOF(h.orig_subj4_address_suffix))'',0,100));
    maxlength_orig_subj4_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_suffix)));
    avelength_orig_subj4_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_suffix)),h.orig_subj4_address_suffix<>(typeof(h.orig_subj4_address_suffix))'');
    populated_orig_subj4_address_postdir_cnt := COUNT(GROUP,h.orig_subj4_address_postdir <> (TYPEOF(h.orig_subj4_address_postdir))'');
    populated_orig_subj4_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj4_address_postdir = (TYPEOF(h.orig_subj4_address_postdir))'',0,100));
    maxlength_orig_subj4_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_postdir)));
    avelength_orig_subj4_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_postdir)),h.orig_subj4_address_postdir<>(typeof(h.orig_subj4_address_postdir))'');
    populated_orig_subj4_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj4_address_unit_desig <> (TYPEOF(h.orig_subj4_address_unit_desig))'');
    populated_orig_subj4_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj4_address_unit_desig = (TYPEOF(h.orig_subj4_address_unit_desig))'',0,100));
    maxlength_orig_subj4_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_unit_desig)));
    avelength_orig_subj4_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_unit_desig)),h.orig_subj4_address_unit_desig<>(typeof(h.orig_subj4_address_unit_desig))'');
    populated_orig_subj4_address_sec_range_cnt := COUNT(GROUP,h.orig_subj4_address_sec_range <> (TYPEOF(h.orig_subj4_address_sec_range))'');
    populated_orig_subj4_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj4_address_sec_range = (TYPEOF(h.orig_subj4_address_sec_range))'',0,100));
    maxlength_orig_subj4_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_sec_range)));
    avelength_orig_subj4_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_sec_range)),h.orig_subj4_address_sec_range<>(typeof(h.orig_subj4_address_sec_range))'');
    populated_orig_subj4_address_city_cnt := COUNT(GROUP,h.orig_subj4_address_city <> (TYPEOF(h.orig_subj4_address_city))'');
    populated_orig_subj4_address_city_pcnt := AVE(GROUP,IF(h.orig_subj4_address_city = (TYPEOF(h.orig_subj4_address_city))'',0,100));
    maxlength_orig_subj4_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_city)));
    avelength_orig_subj4_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_city)),h.orig_subj4_address_city<>(typeof(h.orig_subj4_address_city))'');
    populated_orig_subj4_address_st_cnt := COUNT(GROUP,h.orig_subj4_address_st <> (TYPEOF(h.orig_subj4_address_st))'');
    populated_orig_subj4_address_st_pcnt := AVE(GROUP,IF(h.orig_subj4_address_st = (TYPEOF(h.orig_subj4_address_st))'',0,100));
    maxlength_orig_subj4_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_st)));
    avelength_orig_subj4_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_st)),h.orig_subj4_address_st<>(typeof(h.orig_subj4_address_st))'');
    populated_orig_subj4_address_z5_cnt := COUNT(GROUP,h.orig_subj4_address_z5 <> (TYPEOF(h.orig_subj4_address_z5))'');
    populated_orig_subj4_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj4_address_z5 = (TYPEOF(h.orig_subj4_address_z5))'',0,100));
    maxlength_orig_subj4_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_z5)));
    avelength_orig_subj4_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_z5)),h.orig_subj4_address_z5<>(typeof(h.orig_subj4_address_z5))'');
    populated_orig_subj4_address_z4_cnt := COUNT(GROUP,h.orig_subj4_address_z4 <> (TYPEOF(h.orig_subj4_address_z4))'');
    populated_orig_subj4_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj4_address_z4 = (TYPEOF(h.orig_subj4_address_z4))'',0,100));
    maxlength_orig_subj4_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_z4)));
    avelength_orig_subj4_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_address_z4)),h.orig_subj4_address_z4<>(typeof(h.orig_subj4_address_z4))'');
    populated_orig_subj4_phone_cnt := COUNT(GROUP,h.orig_subj4_phone <> (TYPEOF(h.orig_subj4_phone))'');
    populated_orig_subj4_phone_pcnt := AVE(GROUP,IF(h.orig_subj4_phone = (TYPEOF(h.orig_subj4_phone))'',0,100));
    maxlength_orig_subj4_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_phone)));
    avelength_orig_subj4_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_phone)),h.orig_subj4_phone<>(typeof(h.orig_subj4_phone))'');
    populated_orig_subj4_work_phone_cnt := COUNT(GROUP,h.orig_subj4_work_phone <> (TYPEOF(h.orig_subj4_work_phone))'');
    populated_orig_subj4_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj4_work_phone = (TYPEOF(h.orig_subj4_work_phone))'',0,100));
    maxlength_orig_subj4_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_work_phone)));
    avelength_orig_subj4_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_work_phone)),h.orig_subj4_work_phone<>(typeof(h.orig_subj4_work_phone))'');
    populated_orig_subj4_business_title_cnt := COUNT(GROUP,h.orig_subj4_business_title <> (TYPEOF(h.orig_subj4_business_title))'');
    populated_orig_subj4_business_title_pcnt := AVE(GROUP,IF(h.orig_subj4_business_title = (TYPEOF(h.orig_subj4_business_title))'',0,100));
    maxlength_orig_subj4_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_business_title)));
    avelength_orig_subj4_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_business_title)),h.orig_subj4_business_title<>(typeof(h.orig_subj4_business_title))'');
    populated_orig_subj4_email_cnt := COUNT(GROUP,h.orig_subj4_email <> (TYPEOF(h.orig_subj4_email))'');
    populated_orig_subj4_email_pcnt := AVE(GROUP,IF(h.orig_subj4_email = (TYPEOF(h.orig_subj4_email))'',0,100));
    maxlength_orig_subj4_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_email)));
    avelength_orig_subj4_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_email)),h.orig_subj4_email<>(typeof(h.orig_subj4_email))'');
    populated_orig_subj4_company_name_cnt := COUNT(GROUP,h.orig_subj4_company_name <> (TYPEOF(h.orig_subj4_company_name))'');
    populated_orig_subj4_company_name_pcnt := AVE(GROUP,IF(h.orig_subj4_company_name = (TYPEOF(h.orig_subj4_company_name))'',0,100));
    maxlength_orig_subj4_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_company_name)));
    avelength_orig_subj4_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_company_name)),h.orig_subj4_company_name<>(typeof(h.orig_subj4_company_name))'');
    populated_orig_subj4_fein_cnt := COUNT(GROUP,h.orig_subj4_fein <> (TYPEOF(h.orig_subj4_fein))'');
    populated_orig_subj4_fein_pcnt := AVE(GROUP,IF(h.orig_subj4_fein = (TYPEOF(h.orig_subj4_fein))'',0,100));
    maxlength_orig_subj4_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_fein)));
    avelength_orig_subj4_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj4_fein)),h.orig_subj4_fein<>(typeof(h.orig_subj4_fein))'');
    populated_orig_subj5_first_name_cnt := COUNT(GROUP,h.orig_subj5_first_name <> (TYPEOF(h.orig_subj5_first_name))'');
    populated_orig_subj5_first_name_pcnt := AVE(GROUP,IF(h.orig_subj5_first_name = (TYPEOF(h.orig_subj5_first_name))'',0,100));
    maxlength_orig_subj5_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_first_name)));
    avelength_orig_subj5_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_first_name)),h.orig_subj5_first_name<>(typeof(h.orig_subj5_first_name))'');
    populated_orig_subj5_middle_name_cnt := COUNT(GROUP,h.orig_subj5_middle_name <> (TYPEOF(h.orig_subj5_middle_name))'');
    populated_orig_subj5_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj5_middle_name = (TYPEOF(h.orig_subj5_middle_name))'',0,100));
    maxlength_orig_subj5_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_middle_name)));
    avelength_orig_subj5_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_middle_name)),h.orig_subj5_middle_name<>(typeof(h.orig_subj5_middle_name))'');
    populated_orig_subj5_last_name_cnt := COUNT(GROUP,h.orig_subj5_last_name <> (TYPEOF(h.orig_subj5_last_name))'');
    populated_orig_subj5_last_name_pcnt := AVE(GROUP,IF(h.orig_subj5_last_name = (TYPEOF(h.orig_subj5_last_name))'',0,100));
    maxlength_orig_subj5_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_last_name)));
    avelength_orig_subj5_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_last_name)),h.orig_subj5_last_name<>(typeof(h.orig_subj5_last_name))'');
    populated_orig_subj5_suffix_name_cnt := COUNT(GROUP,h.orig_subj5_suffix_name <> (TYPEOF(h.orig_subj5_suffix_name))'');
    populated_orig_subj5_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj5_suffix_name = (TYPEOF(h.orig_subj5_suffix_name))'',0,100));
    maxlength_orig_subj5_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_suffix_name)));
    avelength_orig_subj5_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_suffix_name)),h.orig_subj5_suffix_name<>(typeof(h.orig_subj5_suffix_name))'');
    populated_orig_subj5_full_name_cnt := COUNT(GROUP,h.orig_subj5_full_name <> (TYPEOF(h.orig_subj5_full_name))'');
    populated_orig_subj5_full_name_pcnt := AVE(GROUP,IF(h.orig_subj5_full_name = (TYPEOF(h.orig_subj5_full_name))'',0,100));
    maxlength_orig_subj5_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_full_name)));
    avelength_orig_subj5_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_full_name)),h.orig_subj5_full_name<>(typeof(h.orig_subj5_full_name))'');
    populated_orig_subj5_ssn_cnt := COUNT(GROUP,h.orig_subj5_ssn <> (TYPEOF(h.orig_subj5_ssn))'');
    populated_orig_subj5_ssn_pcnt := AVE(GROUP,IF(h.orig_subj5_ssn = (TYPEOF(h.orig_subj5_ssn))'',0,100));
    maxlength_orig_subj5_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_ssn)));
    avelength_orig_subj5_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_ssn)),h.orig_subj5_ssn<>(typeof(h.orig_subj5_ssn))'');
    populated_orig_subj5_dob_cnt := COUNT(GROUP,h.orig_subj5_dob <> (TYPEOF(h.orig_subj5_dob))'');
    populated_orig_subj5_dob_pcnt := AVE(GROUP,IF(h.orig_subj5_dob = (TYPEOF(h.orig_subj5_dob))'',0,100));
    maxlength_orig_subj5_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_dob)));
    avelength_orig_subj5_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_dob)),h.orig_subj5_dob<>(typeof(h.orig_subj5_dob))'');
    populated_orig_subj5_dl_num_cnt := COUNT(GROUP,h.orig_subj5_dl_num <> (TYPEOF(h.orig_subj5_dl_num))'');
    populated_orig_subj5_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj5_dl_num = (TYPEOF(h.orig_subj5_dl_num))'',0,100));
    maxlength_orig_subj5_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_dl_num)));
    avelength_orig_subj5_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_dl_num)),h.orig_subj5_dl_num<>(typeof(h.orig_subj5_dl_num))'');
    populated_orig_subj5_dl_state_cnt := COUNT(GROUP,h.orig_subj5_dl_state <> (TYPEOF(h.orig_subj5_dl_state))'');
    populated_orig_subj5_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj5_dl_state = (TYPEOF(h.orig_subj5_dl_state))'',0,100));
    maxlength_orig_subj5_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_dl_state)));
    avelength_orig_subj5_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_dl_state)),h.orig_subj5_dl_state<>(typeof(h.orig_subj5_dl_state))'');
    populated_orig_subj5_former_last_name_cnt := COUNT(GROUP,h.orig_subj5_former_last_name <> (TYPEOF(h.orig_subj5_former_last_name))'');
    populated_orig_subj5_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj5_former_last_name = (TYPEOF(h.orig_subj5_former_last_name))'',0,100));
    maxlength_orig_subj5_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_former_last_name)));
    avelength_orig_subj5_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_former_last_name)),h.orig_subj5_former_last_name<>(typeof(h.orig_subj5_former_last_name))'');
    populated_orig_subj5_address_addressline1_cnt := COUNT(GROUP,h.orig_subj5_address_addressline1 <> (TYPEOF(h.orig_subj5_address_addressline1))'');
    populated_orig_subj5_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj5_address_addressline1 = (TYPEOF(h.orig_subj5_address_addressline1))'',0,100));
    maxlength_orig_subj5_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_addressline1)));
    avelength_orig_subj5_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_addressline1)),h.orig_subj5_address_addressline1<>(typeof(h.orig_subj5_address_addressline1))'');
    populated_orig_subj5_address_addressline2_cnt := COUNT(GROUP,h.orig_subj5_address_addressline2 <> (TYPEOF(h.orig_subj5_address_addressline2))'');
    populated_orig_subj5_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj5_address_addressline2 = (TYPEOF(h.orig_subj5_address_addressline2))'',0,100));
    maxlength_orig_subj5_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_addressline2)));
    avelength_orig_subj5_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_addressline2)),h.orig_subj5_address_addressline2<>(typeof(h.orig_subj5_address_addressline2))'');
    populated_orig_subj5_address_prim_range_cnt := COUNT(GROUP,h.orig_subj5_address_prim_range <> (TYPEOF(h.orig_subj5_address_prim_range))'');
    populated_orig_subj5_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj5_address_prim_range = (TYPEOF(h.orig_subj5_address_prim_range))'',0,100));
    maxlength_orig_subj5_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_prim_range)));
    avelength_orig_subj5_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_prim_range)),h.orig_subj5_address_prim_range<>(typeof(h.orig_subj5_address_prim_range))'');
    populated_orig_subj5_address_predir_cnt := COUNT(GROUP,h.orig_subj5_address_predir <> (TYPEOF(h.orig_subj5_address_predir))'');
    populated_orig_subj5_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj5_address_predir = (TYPEOF(h.orig_subj5_address_predir))'',0,100));
    maxlength_orig_subj5_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_predir)));
    avelength_orig_subj5_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_predir)),h.orig_subj5_address_predir<>(typeof(h.orig_subj5_address_predir))'');
    populated_orig_subj5_address_prim_name_cnt := COUNT(GROUP,h.orig_subj5_address_prim_name <> (TYPEOF(h.orig_subj5_address_prim_name))'');
    populated_orig_subj5_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj5_address_prim_name = (TYPEOF(h.orig_subj5_address_prim_name))'',0,100));
    maxlength_orig_subj5_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_prim_name)));
    avelength_orig_subj5_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_prim_name)),h.orig_subj5_address_prim_name<>(typeof(h.orig_subj5_address_prim_name))'');
    populated_orig_subj5_address_suffix_cnt := COUNT(GROUP,h.orig_subj5_address_suffix <> (TYPEOF(h.orig_subj5_address_suffix))'');
    populated_orig_subj5_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj5_address_suffix = (TYPEOF(h.orig_subj5_address_suffix))'',0,100));
    maxlength_orig_subj5_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_suffix)));
    avelength_orig_subj5_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_suffix)),h.orig_subj5_address_suffix<>(typeof(h.orig_subj5_address_suffix))'');
    populated_orig_subj5_address_postdir_cnt := COUNT(GROUP,h.orig_subj5_address_postdir <> (TYPEOF(h.orig_subj5_address_postdir))'');
    populated_orig_subj5_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj5_address_postdir = (TYPEOF(h.orig_subj5_address_postdir))'',0,100));
    maxlength_orig_subj5_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_postdir)));
    avelength_orig_subj5_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_postdir)),h.orig_subj5_address_postdir<>(typeof(h.orig_subj5_address_postdir))'');
    populated_orig_subj5_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj5_address_unit_desig <> (TYPEOF(h.orig_subj5_address_unit_desig))'');
    populated_orig_subj5_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj5_address_unit_desig = (TYPEOF(h.orig_subj5_address_unit_desig))'',0,100));
    maxlength_orig_subj5_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_unit_desig)));
    avelength_orig_subj5_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_unit_desig)),h.orig_subj5_address_unit_desig<>(typeof(h.orig_subj5_address_unit_desig))'');
    populated_orig_subj5_address_sec_range_cnt := COUNT(GROUP,h.orig_subj5_address_sec_range <> (TYPEOF(h.orig_subj5_address_sec_range))'');
    populated_orig_subj5_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj5_address_sec_range = (TYPEOF(h.orig_subj5_address_sec_range))'',0,100));
    maxlength_orig_subj5_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_sec_range)));
    avelength_orig_subj5_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_sec_range)),h.orig_subj5_address_sec_range<>(typeof(h.orig_subj5_address_sec_range))'');
    populated_orig_subj5_address_city_cnt := COUNT(GROUP,h.orig_subj5_address_city <> (TYPEOF(h.orig_subj5_address_city))'');
    populated_orig_subj5_address_city_pcnt := AVE(GROUP,IF(h.orig_subj5_address_city = (TYPEOF(h.orig_subj5_address_city))'',0,100));
    maxlength_orig_subj5_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_city)));
    avelength_orig_subj5_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_city)),h.orig_subj5_address_city<>(typeof(h.orig_subj5_address_city))'');
    populated_orig_subj5_address_st_cnt := COUNT(GROUP,h.orig_subj5_address_st <> (TYPEOF(h.orig_subj5_address_st))'');
    populated_orig_subj5_address_st_pcnt := AVE(GROUP,IF(h.orig_subj5_address_st = (TYPEOF(h.orig_subj5_address_st))'',0,100));
    maxlength_orig_subj5_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_st)));
    avelength_orig_subj5_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_st)),h.orig_subj5_address_st<>(typeof(h.orig_subj5_address_st))'');
    populated_orig_subj5_address_z5_cnt := COUNT(GROUP,h.orig_subj5_address_z5 <> (TYPEOF(h.orig_subj5_address_z5))'');
    populated_orig_subj5_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj5_address_z5 = (TYPEOF(h.orig_subj5_address_z5))'',0,100));
    maxlength_orig_subj5_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_z5)));
    avelength_orig_subj5_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_z5)),h.orig_subj5_address_z5<>(typeof(h.orig_subj5_address_z5))'');
    populated_orig_subj5_address_z4_cnt := COUNT(GROUP,h.orig_subj5_address_z4 <> (TYPEOF(h.orig_subj5_address_z4))'');
    populated_orig_subj5_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj5_address_z4 = (TYPEOF(h.orig_subj5_address_z4))'',0,100));
    maxlength_orig_subj5_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_z4)));
    avelength_orig_subj5_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_address_z4)),h.orig_subj5_address_z4<>(typeof(h.orig_subj5_address_z4))'');
    populated_orig_subj5_phone_cnt := COUNT(GROUP,h.orig_subj5_phone <> (TYPEOF(h.orig_subj5_phone))'');
    populated_orig_subj5_phone_pcnt := AVE(GROUP,IF(h.orig_subj5_phone = (TYPEOF(h.orig_subj5_phone))'',0,100));
    maxlength_orig_subj5_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_phone)));
    avelength_orig_subj5_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_phone)),h.orig_subj5_phone<>(typeof(h.orig_subj5_phone))'');
    populated_orig_subj5_work_phone_cnt := COUNT(GROUP,h.orig_subj5_work_phone <> (TYPEOF(h.orig_subj5_work_phone))'');
    populated_orig_subj5_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj5_work_phone = (TYPEOF(h.orig_subj5_work_phone))'',0,100));
    maxlength_orig_subj5_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_work_phone)));
    avelength_orig_subj5_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_work_phone)),h.orig_subj5_work_phone<>(typeof(h.orig_subj5_work_phone))'');
    populated_orig_subj5_business_title_cnt := COUNT(GROUP,h.orig_subj5_business_title <> (TYPEOF(h.orig_subj5_business_title))'');
    populated_orig_subj5_business_title_pcnt := AVE(GROUP,IF(h.orig_subj5_business_title = (TYPEOF(h.orig_subj5_business_title))'',0,100));
    maxlength_orig_subj5_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_business_title)));
    avelength_orig_subj5_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_business_title)),h.orig_subj5_business_title<>(typeof(h.orig_subj5_business_title))'');
    populated_orig_subj5_email_cnt := COUNT(GROUP,h.orig_subj5_email <> (TYPEOF(h.orig_subj5_email))'');
    populated_orig_subj5_email_pcnt := AVE(GROUP,IF(h.orig_subj5_email = (TYPEOF(h.orig_subj5_email))'',0,100));
    maxlength_orig_subj5_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_email)));
    avelength_orig_subj5_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_email)),h.orig_subj5_email<>(typeof(h.orig_subj5_email))'');
    populated_orig_subj5_company_name_cnt := COUNT(GROUP,h.orig_subj5_company_name <> (TYPEOF(h.orig_subj5_company_name))'');
    populated_orig_subj5_company_name_pcnt := AVE(GROUP,IF(h.orig_subj5_company_name = (TYPEOF(h.orig_subj5_company_name))'',0,100));
    maxlength_orig_subj5_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_company_name)));
    avelength_orig_subj5_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_company_name)),h.orig_subj5_company_name<>(typeof(h.orig_subj5_company_name))'');
    populated_orig_subj5_fein_cnt := COUNT(GROUP,h.orig_subj5_fein <> (TYPEOF(h.orig_subj5_fein))'');
    populated_orig_subj5_fein_pcnt := AVE(GROUP,IF(h.orig_subj5_fein = (TYPEOF(h.orig_subj5_fein))'',0,100));
    maxlength_orig_subj5_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_fein)));
    avelength_orig_subj5_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj5_fein)),h.orig_subj5_fein<>(typeof(h.orig_subj5_fein))'');
    populated_orig_subj6_first_name_cnt := COUNT(GROUP,h.orig_subj6_first_name <> (TYPEOF(h.orig_subj6_first_name))'');
    populated_orig_subj6_first_name_pcnt := AVE(GROUP,IF(h.orig_subj6_first_name = (TYPEOF(h.orig_subj6_first_name))'',0,100));
    maxlength_orig_subj6_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_first_name)));
    avelength_orig_subj6_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_first_name)),h.orig_subj6_first_name<>(typeof(h.orig_subj6_first_name))'');
    populated_orig_subj6_middle_name_cnt := COUNT(GROUP,h.orig_subj6_middle_name <> (TYPEOF(h.orig_subj6_middle_name))'');
    populated_orig_subj6_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj6_middle_name = (TYPEOF(h.orig_subj6_middle_name))'',0,100));
    maxlength_orig_subj6_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_middle_name)));
    avelength_orig_subj6_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_middle_name)),h.orig_subj6_middle_name<>(typeof(h.orig_subj6_middle_name))'');
    populated_orig_subj6_last_name_cnt := COUNT(GROUP,h.orig_subj6_last_name <> (TYPEOF(h.orig_subj6_last_name))'');
    populated_orig_subj6_last_name_pcnt := AVE(GROUP,IF(h.orig_subj6_last_name = (TYPEOF(h.orig_subj6_last_name))'',0,100));
    maxlength_orig_subj6_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_last_name)));
    avelength_orig_subj6_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_last_name)),h.orig_subj6_last_name<>(typeof(h.orig_subj6_last_name))'');
    populated_orig_subj6_suffix_name_cnt := COUNT(GROUP,h.orig_subj6_suffix_name <> (TYPEOF(h.orig_subj6_suffix_name))'');
    populated_orig_subj6_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj6_suffix_name = (TYPEOF(h.orig_subj6_suffix_name))'',0,100));
    maxlength_orig_subj6_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_suffix_name)));
    avelength_orig_subj6_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_suffix_name)),h.orig_subj6_suffix_name<>(typeof(h.orig_subj6_suffix_name))'');
    populated_orig_subj6_full_name_cnt := COUNT(GROUP,h.orig_subj6_full_name <> (TYPEOF(h.orig_subj6_full_name))'');
    populated_orig_subj6_full_name_pcnt := AVE(GROUP,IF(h.orig_subj6_full_name = (TYPEOF(h.orig_subj6_full_name))'',0,100));
    maxlength_orig_subj6_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_full_name)));
    avelength_orig_subj6_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_full_name)),h.orig_subj6_full_name<>(typeof(h.orig_subj6_full_name))'');
    populated_orig_subj6_ssn_cnt := COUNT(GROUP,h.orig_subj6_ssn <> (TYPEOF(h.orig_subj6_ssn))'');
    populated_orig_subj6_ssn_pcnt := AVE(GROUP,IF(h.orig_subj6_ssn = (TYPEOF(h.orig_subj6_ssn))'',0,100));
    maxlength_orig_subj6_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_ssn)));
    avelength_orig_subj6_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_ssn)),h.orig_subj6_ssn<>(typeof(h.orig_subj6_ssn))'');
    populated_orig_subj6_dob_cnt := COUNT(GROUP,h.orig_subj6_dob <> (TYPEOF(h.orig_subj6_dob))'');
    populated_orig_subj6_dob_pcnt := AVE(GROUP,IF(h.orig_subj6_dob = (TYPEOF(h.orig_subj6_dob))'',0,100));
    maxlength_orig_subj6_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_dob)));
    avelength_orig_subj6_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_dob)),h.orig_subj6_dob<>(typeof(h.orig_subj6_dob))'');
    populated_orig_subj6_dl_num_cnt := COUNT(GROUP,h.orig_subj6_dl_num <> (TYPEOF(h.orig_subj6_dl_num))'');
    populated_orig_subj6_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj6_dl_num = (TYPEOF(h.orig_subj6_dl_num))'',0,100));
    maxlength_orig_subj6_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_dl_num)));
    avelength_orig_subj6_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_dl_num)),h.orig_subj6_dl_num<>(typeof(h.orig_subj6_dl_num))'');
    populated_orig_subj6_dl_state_cnt := COUNT(GROUP,h.orig_subj6_dl_state <> (TYPEOF(h.orig_subj6_dl_state))'');
    populated_orig_subj6_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj6_dl_state = (TYPEOF(h.orig_subj6_dl_state))'',0,100));
    maxlength_orig_subj6_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_dl_state)));
    avelength_orig_subj6_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_dl_state)),h.orig_subj6_dl_state<>(typeof(h.orig_subj6_dl_state))'');
    populated_orig_subj6_former_last_name_cnt := COUNT(GROUP,h.orig_subj6_former_last_name <> (TYPEOF(h.orig_subj6_former_last_name))'');
    populated_orig_subj6_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj6_former_last_name = (TYPEOF(h.orig_subj6_former_last_name))'',0,100));
    maxlength_orig_subj6_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_former_last_name)));
    avelength_orig_subj6_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_former_last_name)),h.orig_subj6_former_last_name<>(typeof(h.orig_subj6_former_last_name))'');
    populated_orig_subj6_address_addressline1_cnt := COUNT(GROUP,h.orig_subj6_address_addressline1 <> (TYPEOF(h.orig_subj6_address_addressline1))'');
    populated_orig_subj6_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj6_address_addressline1 = (TYPEOF(h.orig_subj6_address_addressline1))'',0,100));
    maxlength_orig_subj6_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_addressline1)));
    avelength_orig_subj6_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_addressline1)),h.orig_subj6_address_addressline1<>(typeof(h.orig_subj6_address_addressline1))'');
    populated_orig_subj6_address_addressline2_cnt := COUNT(GROUP,h.orig_subj6_address_addressline2 <> (TYPEOF(h.orig_subj6_address_addressline2))'');
    populated_orig_subj6_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj6_address_addressline2 = (TYPEOF(h.orig_subj6_address_addressline2))'',0,100));
    maxlength_orig_subj6_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_addressline2)));
    avelength_orig_subj6_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_addressline2)),h.orig_subj6_address_addressline2<>(typeof(h.orig_subj6_address_addressline2))'');
    populated_orig_subj6_address_prim_range_cnt := COUNT(GROUP,h.orig_subj6_address_prim_range <> (TYPEOF(h.orig_subj6_address_prim_range))'');
    populated_orig_subj6_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj6_address_prim_range = (TYPEOF(h.orig_subj6_address_prim_range))'',0,100));
    maxlength_orig_subj6_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_prim_range)));
    avelength_orig_subj6_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_prim_range)),h.orig_subj6_address_prim_range<>(typeof(h.orig_subj6_address_prim_range))'');
    populated_orig_subj6_address_predir_cnt := COUNT(GROUP,h.orig_subj6_address_predir <> (TYPEOF(h.orig_subj6_address_predir))'');
    populated_orig_subj6_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj6_address_predir = (TYPEOF(h.orig_subj6_address_predir))'',0,100));
    maxlength_orig_subj6_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_predir)));
    avelength_orig_subj6_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_predir)),h.orig_subj6_address_predir<>(typeof(h.orig_subj6_address_predir))'');
    populated_orig_subj6_address_prim_name_cnt := COUNT(GROUP,h.orig_subj6_address_prim_name <> (TYPEOF(h.orig_subj6_address_prim_name))'');
    populated_orig_subj6_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj6_address_prim_name = (TYPEOF(h.orig_subj6_address_prim_name))'',0,100));
    maxlength_orig_subj6_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_prim_name)));
    avelength_orig_subj6_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_prim_name)),h.orig_subj6_address_prim_name<>(typeof(h.orig_subj6_address_prim_name))'');
    populated_orig_subj6_address_suffix_cnt := COUNT(GROUP,h.orig_subj6_address_suffix <> (TYPEOF(h.orig_subj6_address_suffix))'');
    populated_orig_subj6_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj6_address_suffix = (TYPEOF(h.orig_subj6_address_suffix))'',0,100));
    maxlength_orig_subj6_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_suffix)));
    avelength_orig_subj6_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_suffix)),h.orig_subj6_address_suffix<>(typeof(h.orig_subj6_address_suffix))'');
    populated_orig_subj6_address_postdir_cnt := COUNT(GROUP,h.orig_subj6_address_postdir <> (TYPEOF(h.orig_subj6_address_postdir))'');
    populated_orig_subj6_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj6_address_postdir = (TYPEOF(h.orig_subj6_address_postdir))'',0,100));
    maxlength_orig_subj6_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_postdir)));
    avelength_orig_subj6_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_postdir)),h.orig_subj6_address_postdir<>(typeof(h.orig_subj6_address_postdir))'');
    populated_orig_subj6_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj6_address_unit_desig <> (TYPEOF(h.orig_subj6_address_unit_desig))'');
    populated_orig_subj6_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj6_address_unit_desig = (TYPEOF(h.orig_subj6_address_unit_desig))'',0,100));
    maxlength_orig_subj6_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_unit_desig)));
    avelength_orig_subj6_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_unit_desig)),h.orig_subj6_address_unit_desig<>(typeof(h.orig_subj6_address_unit_desig))'');
    populated_orig_subj6_address_sec_range_cnt := COUNT(GROUP,h.orig_subj6_address_sec_range <> (TYPEOF(h.orig_subj6_address_sec_range))'');
    populated_orig_subj6_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj6_address_sec_range = (TYPEOF(h.orig_subj6_address_sec_range))'',0,100));
    maxlength_orig_subj6_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_sec_range)));
    avelength_orig_subj6_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_sec_range)),h.orig_subj6_address_sec_range<>(typeof(h.orig_subj6_address_sec_range))'');
    populated_orig_subj6_address_city_cnt := COUNT(GROUP,h.orig_subj6_address_city <> (TYPEOF(h.orig_subj6_address_city))'');
    populated_orig_subj6_address_city_pcnt := AVE(GROUP,IF(h.orig_subj6_address_city = (TYPEOF(h.orig_subj6_address_city))'',0,100));
    maxlength_orig_subj6_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_city)));
    avelength_orig_subj6_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_city)),h.orig_subj6_address_city<>(typeof(h.orig_subj6_address_city))'');
    populated_orig_subj6_address_st_cnt := COUNT(GROUP,h.orig_subj6_address_st <> (TYPEOF(h.orig_subj6_address_st))'');
    populated_orig_subj6_address_st_pcnt := AVE(GROUP,IF(h.orig_subj6_address_st = (TYPEOF(h.orig_subj6_address_st))'',0,100));
    maxlength_orig_subj6_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_st)));
    avelength_orig_subj6_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_st)),h.orig_subj6_address_st<>(typeof(h.orig_subj6_address_st))'');
    populated_orig_subj6_address_z5_cnt := COUNT(GROUP,h.orig_subj6_address_z5 <> (TYPEOF(h.orig_subj6_address_z5))'');
    populated_orig_subj6_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj6_address_z5 = (TYPEOF(h.orig_subj6_address_z5))'',0,100));
    maxlength_orig_subj6_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_z5)));
    avelength_orig_subj6_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_z5)),h.orig_subj6_address_z5<>(typeof(h.orig_subj6_address_z5))'');
    populated_orig_subj6_address_z4_cnt := COUNT(GROUP,h.orig_subj6_address_z4 <> (TYPEOF(h.orig_subj6_address_z4))'');
    populated_orig_subj6_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj6_address_z4 = (TYPEOF(h.orig_subj6_address_z4))'',0,100));
    maxlength_orig_subj6_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_z4)));
    avelength_orig_subj6_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_address_z4)),h.orig_subj6_address_z4<>(typeof(h.orig_subj6_address_z4))'');
    populated_orig_subj6_phone_cnt := COUNT(GROUP,h.orig_subj6_phone <> (TYPEOF(h.orig_subj6_phone))'');
    populated_orig_subj6_phone_pcnt := AVE(GROUP,IF(h.orig_subj6_phone = (TYPEOF(h.orig_subj6_phone))'',0,100));
    maxlength_orig_subj6_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_phone)));
    avelength_orig_subj6_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_phone)),h.orig_subj6_phone<>(typeof(h.orig_subj6_phone))'');
    populated_orig_subj6_work_phone_cnt := COUNT(GROUP,h.orig_subj6_work_phone <> (TYPEOF(h.orig_subj6_work_phone))'');
    populated_orig_subj6_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj6_work_phone = (TYPEOF(h.orig_subj6_work_phone))'',0,100));
    maxlength_orig_subj6_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_work_phone)));
    avelength_orig_subj6_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_work_phone)),h.orig_subj6_work_phone<>(typeof(h.orig_subj6_work_phone))'');
    populated_orig_subj6_business_title_cnt := COUNT(GROUP,h.orig_subj6_business_title <> (TYPEOF(h.orig_subj6_business_title))'');
    populated_orig_subj6_business_title_pcnt := AVE(GROUP,IF(h.orig_subj6_business_title = (TYPEOF(h.orig_subj6_business_title))'',0,100));
    maxlength_orig_subj6_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_business_title)));
    avelength_orig_subj6_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_business_title)),h.orig_subj6_business_title<>(typeof(h.orig_subj6_business_title))'');
    populated_orig_subj6_email_cnt := COUNT(GROUP,h.orig_subj6_email <> (TYPEOF(h.orig_subj6_email))'');
    populated_orig_subj6_email_pcnt := AVE(GROUP,IF(h.orig_subj6_email = (TYPEOF(h.orig_subj6_email))'',0,100));
    maxlength_orig_subj6_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_email)));
    avelength_orig_subj6_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_email)),h.orig_subj6_email<>(typeof(h.orig_subj6_email))'');
    populated_orig_subj6_company_name_cnt := COUNT(GROUP,h.orig_subj6_company_name <> (TYPEOF(h.orig_subj6_company_name))'');
    populated_orig_subj6_company_name_pcnt := AVE(GROUP,IF(h.orig_subj6_company_name = (TYPEOF(h.orig_subj6_company_name))'',0,100));
    maxlength_orig_subj6_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_company_name)));
    avelength_orig_subj6_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_company_name)),h.orig_subj6_company_name<>(typeof(h.orig_subj6_company_name))'');
    populated_orig_subj6_fein_cnt := COUNT(GROUP,h.orig_subj6_fein <> (TYPEOF(h.orig_subj6_fein))'');
    populated_orig_subj6_fein_pcnt := AVE(GROUP,IF(h.orig_subj6_fein = (TYPEOF(h.orig_subj6_fein))'',0,100));
    maxlength_orig_subj6_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_fein)));
    avelength_orig_subj6_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj6_fein)),h.orig_subj6_fein<>(typeof(h.orig_subj6_fein))'');
    populated_orig_subj7_first_name_cnt := COUNT(GROUP,h.orig_subj7_first_name <> (TYPEOF(h.orig_subj7_first_name))'');
    populated_orig_subj7_first_name_pcnt := AVE(GROUP,IF(h.orig_subj7_first_name = (TYPEOF(h.orig_subj7_first_name))'',0,100));
    maxlength_orig_subj7_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_first_name)));
    avelength_orig_subj7_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_first_name)),h.orig_subj7_first_name<>(typeof(h.orig_subj7_first_name))'');
    populated_orig_subj7_middle_name_cnt := COUNT(GROUP,h.orig_subj7_middle_name <> (TYPEOF(h.orig_subj7_middle_name))'');
    populated_orig_subj7_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj7_middle_name = (TYPEOF(h.orig_subj7_middle_name))'',0,100));
    maxlength_orig_subj7_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_middle_name)));
    avelength_orig_subj7_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_middle_name)),h.orig_subj7_middle_name<>(typeof(h.orig_subj7_middle_name))'');
    populated_orig_subj7_last_name_cnt := COUNT(GROUP,h.orig_subj7_last_name <> (TYPEOF(h.orig_subj7_last_name))'');
    populated_orig_subj7_last_name_pcnt := AVE(GROUP,IF(h.orig_subj7_last_name = (TYPEOF(h.orig_subj7_last_name))'',0,100));
    maxlength_orig_subj7_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_last_name)));
    avelength_orig_subj7_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_last_name)),h.orig_subj7_last_name<>(typeof(h.orig_subj7_last_name))'');
    populated_orig_subj7_suffix_name_cnt := COUNT(GROUP,h.orig_subj7_suffix_name <> (TYPEOF(h.orig_subj7_suffix_name))'');
    populated_orig_subj7_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj7_suffix_name = (TYPEOF(h.orig_subj7_suffix_name))'',0,100));
    maxlength_orig_subj7_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_suffix_name)));
    avelength_orig_subj7_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_suffix_name)),h.orig_subj7_suffix_name<>(typeof(h.orig_subj7_suffix_name))'');
    populated_orig_subj7_full_name_cnt := COUNT(GROUP,h.orig_subj7_full_name <> (TYPEOF(h.orig_subj7_full_name))'');
    populated_orig_subj7_full_name_pcnt := AVE(GROUP,IF(h.orig_subj7_full_name = (TYPEOF(h.orig_subj7_full_name))'',0,100));
    maxlength_orig_subj7_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_full_name)));
    avelength_orig_subj7_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_full_name)),h.orig_subj7_full_name<>(typeof(h.orig_subj7_full_name))'');
    populated_orig_subj7_ssn_cnt := COUNT(GROUP,h.orig_subj7_ssn <> (TYPEOF(h.orig_subj7_ssn))'');
    populated_orig_subj7_ssn_pcnt := AVE(GROUP,IF(h.orig_subj7_ssn = (TYPEOF(h.orig_subj7_ssn))'',0,100));
    maxlength_orig_subj7_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_ssn)));
    avelength_orig_subj7_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_ssn)),h.orig_subj7_ssn<>(typeof(h.orig_subj7_ssn))'');
    populated_orig_subj7_dob_cnt := COUNT(GROUP,h.orig_subj7_dob <> (TYPEOF(h.orig_subj7_dob))'');
    populated_orig_subj7_dob_pcnt := AVE(GROUP,IF(h.orig_subj7_dob = (TYPEOF(h.orig_subj7_dob))'',0,100));
    maxlength_orig_subj7_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_dob)));
    avelength_orig_subj7_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_dob)),h.orig_subj7_dob<>(typeof(h.orig_subj7_dob))'');
    populated_orig_subj7_dl_num_cnt := COUNT(GROUP,h.orig_subj7_dl_num <> (TYPEOF(h.orig_subj7_dl_num))'');
    populated_orig_subj7_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj7_dl_num = (TYPEOF(h.orig_subj7_dl_num))'',0,100));
    maxlength_orig_subj7_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_dl_num)));
    avelength_orig_subj7_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_dl_num)),h.orig_subj7_dl_num<>(typeof(h.orig_subj7_dl_num))'');
    populated_orig_subj7_dl_state_cnt := COUNT(GROUP,h.orig_subj7_dl_state <> (TYPEOF(h.orig_subj7_dl_state))'');
    populated_orig_subj7_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj7_dl_state = (TYPEOF(h.orig_subj7_dl_state))'',0,100));
    maxlength_orig_subj7_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_dl_state)));
    avelength_orig_subj7_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_dl_state)),h.orig_subj7_dl_state<>(typeof(h.orig_subj7_dl_state))'');
    populated_orig_subj7_former_last_name_cnt := COUNT(GROUP,h.orig_subj7_former_last_name <> (TYPEOF(h.orig_subj7_former_last_name))'');
    populated_orig_subj7_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj7_former_last_name = (TYPEOF(h.orig_subj7_former_last_name))'',0,100));
    maxlength_orig_subj7_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_former_last_name)));
    avelength_orig_subj7_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_former_last_name)),h.orig_subj7_former_last_name<>(typeof(h.orig_subj7_former_last_name))'');
    populated_orig_subj7_address_addressline1_cnt := COUNT(GROUP,h.orig_subj7_address_addressline1 <> (TYPEOF(h.orig_subj7_address_addressline1))'');
    populated_orig_subj7_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj7_address_addressline1 = (TYPEOF(h.orig_subj7_address_addressline1))'',0,100));
    maxlength_orig_subj7_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_addressline1)));
    avelength_orig_subj7_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_addressline1)),h.orig_subj7_address_addressline1<>(typeof(h.orig_subj7_address_addressline1))'');
    populated_orig_subj7_address_addressline2_cnt := COUNT(GROUP,h.orig_subj7_address_addressline2 <> (TYPEOF(h.orig_subj7_address_addressline2))'');
    populated_orig_subj7_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj7_address_addressline2 = (TYPEOF(h.orig_subj7_address_addressline2))'',0,100));
    maxlength_orig_subj7_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_addressline2)));
    avelength_orig_subj7_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_addressline2)),h.orig_subj7_address_addressline2<>(typeof(h.orig_subj7_address_addressline2))'');
    populated_orig_subj7_address_prim_range_cnt := COUNT(GROUP,h.orig_subj7_address_prim_range <> (TYPEOF(h.orig_subj7_address_prim_range))'');
    populated_orig_subj7_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj7_address_prim_range = (TYPEOF(h.orig_subj7_address_prim_range))'',0,100));
    maxlength_orig_subj7_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_prim_range)));
    avelength_orig_subj7_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_prim_range)),h.orig_subj7_address_prim_range<>(typeof(h.orig_subj7_address_prim_range))'');
    populated_orig_subj7_address_predir_cnt := COUNT(GROUP,h.orig_subj7_address_predir <> (TYPEOF(h.orig_subj7_address_predir))'');
    populated_orig_subj7_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj7_address_predir = (TYPEOF(h.orig_subj7_address_predir))'',0,100));
    maxlength_orig_subj7_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_predir)));
    avelength_orig_subj7_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_predir)),h.orig_subj7_address_predir<>(typeof(h.orig_subj7_address_predir))'');
    populated_orig_subj7_address_prim_name_cnt := COUNT(GROUP,h.orig_subj7_address_prim_name <> (TYPEOF(h.orig_subj7_address_prim_name))'');
    populated_orig_subj7_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj7_address_prim_name = (TYPEOF(h.orig_subj7_address_prim_name))'',0,100));
    maxlength_orig_subj7_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_prim_name)));
    avelength_orig_subj7_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_prim_name)),h.orig_subj7_address_prim_name<>(typeof(h.orig_subj7_address_prim_name))'');
    populated_orig_subj7_address_suffix_cnt := COUNT(GROUP,h.orig_subj7_address_suffix <> (TYPEOF(h.orig_subj7_address_suffix))'');
    populated_orig_subj7_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj7_address_suffix = (TYPEOF(h.orig_subj7_address_suffix))'',0,100));
    maxlength_orig_subj7_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_suffix)));
    avelength_orig_subj7_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_suffix)),h.orig_subj7_address_suffix<>(typeof(h.orig_subj7_address_suffix))'');
    populated_orig_subj7_address_postdir_cnt := COUNT(GROUP,h.orig_subj7_address_postdir <> (TYPEOF(h.orig_subj7_address_postdir))'');
    populated_orig_subj7_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj7_address_postdir = (TYPEOF(h.orig_subj7_address_postdir))'',0,100));
    maxlength_orig_subj7_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_postdir)));
    avelength_orig_subj7_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_postdir)),h.orig_subj7_address_postdir<>(typeof(h.orig_subj7_address_postdir))'');
    populated_orig_subj7_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj7_address_unit_desig <> (TYPEOF(h.orig_subj7_address_unit_desig))'');
    populated_orig_subj7_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj7_address_unit_desig = (TYPEOF(h.orig_subj7_address_unit_desig))'',0,100));
    maxlength_orig_subj7_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_unit_desig)));
    avelength_orig_subj7_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_unit_desig)),h.orig_subj7_address_unit_desig<>(typeof(h.orig_subj7_address_unit_desig))'');
    populated_orig_subj7_address_sec_range_cnt := COUNT(GROUP,h.orig_subj7_address_sec_range <> (TYPEOF(h.orig_subj7_address_sec_range))'');
    populated_orig_subj7_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj7_address_sec_range = (TYPEOF(h.orig_subj7_address_sec_range))'',0,100));
    maxlength_orig_subj7_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_sec_range)));
    avelength_orig_subj7_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_sec_range)),h.orig_subj7_address_sec_range<>(typeof(h.orig_subj7_address_sec_range))'');
    populated_orig_subj7_address_city_cnt := COUNT(GROUP,h.orig_subj7_address_city <> (TYPEOF(h.orig_subj7_address_city))'');
    populated_orig_subj7_address_city_pcnt := AVE(GROUP,IF(h.orig_subj7_address_city = (TYPEOF(h.orig_subj7_address_city))'',0,100));
    maxlength_orig_subj7_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_city)));
    avelength_orig_subj7_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_city)),h.orig_subj7_address_city<>(typeof(h.orig_subj7_address_city))'');
    populated_orig_subj7_address_st_cnt := COUNT(GROUP,h.orig_subj7_address_st <> (TYPEOF(h.orig_subj7_address_st))'');
    populated_orig_subj7_address_st_pcnt := AVE(GROUP,IF(h.orig_subj7_address_st = (TYPEOF(h.orig_subj7_address_st))'',0,100));
    maxlength_orig_subj7_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_st)));
    avelength_orig_subj7_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_st)),h.orig_subj7_address_st<>(typeof(h.orig_subj7_address_st))'');
    populated_orig_subj7_address_z5_cnt := COUNT(GROUP,h.orig_subj7_address_z5 <> (TYPEOF(h.orig_subj7_address_z5))'');
    populated_orig_subj7_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj7_address_z5 = (TYPEOF(h.orig_subj7_address_z5))'',0,100));
    maxlength_orig_subj7_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_z5)));
    avelength_orig_subj7_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_z5)),h.orig_subj7_address_z5<>(typeof(h.orig_subj7_address_z5))'');
    populated_orig_subj7_address_z4_cnt := COUNT(GROUP,h.orig_subj7_address_z4 <> (TYPEOF(h.orig_subj7_address_z4))'');
    populated_orig_subj7_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj7_address_z4 = (TYPEOF(h.orig_subj7_address_z4))'',0,100));
    maxlength_orig_subj7_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_z4)));
    avelength_orig_subj7_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_address_z4)),h.orig_subj7_address_z4<>(typeof(h.orig_subj7_address_z4))'');
    populated_orig_subj7_phone_cnt := COUNT(GROUP,h.orig_subj7_phone <> (TYPEOF(h.orig_subj7_phone))'');
    populated_orig_subj7_phone_pcnt := AVE(GROUP,IF(h.orig_subj7_phone = (TYPEOF(h.orig_subj7_phone))'',0,100));
    maxlength_orig_subj7_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_phone)));
    avelength_orig_subj7_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_phone)),h.orig_subj7_phone<>(typeof(h.orig_subj7_phone))'');
    populated_orig_subj7_work_phone_cnt := COUNT(GROUP,h.orig_subj7_work_phone <> (TYPEOF(h.orig_subj7_work_phone))'');
    populated_orig_subj7_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj7_work_phone = (TYPEOF(h.orig_subj7_work_phone))'',0,100));
    maxlength_orig_subj7_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_work_phone)));
    avelength_orig_subj7_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_work_phone)),h.orig_subj7_work_phone<>(typeof(h.orig_subj7_work_phone))'');
    populated_orig_subj7_business_title_cnt := COUNT(GROUP,h.orig_subj7_business_title <> (TYPEOF(h.orig_subj7_business_title))'');
    populated_orig_subj7_business_title_pcnt := AVE(GROUP,IF(h.orig_subj7_business_title = (TYPEOF(h.orig_subj7_business_title))'',0,100));
    maxlength_orig_subj7_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_business_title)));
    avelength_orig_subj7_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_business_title)),h.orig_subj7_business_title<>(typeof(h.orig_subj7_business_title))'');
    populated_orig_subj7_email_cnt := COUNT(GROUP,h.orig_subj7_email <> (TYPEOF(h.orig_subj7_email))'');
    populated_orig_subj7_email_pcnt := AVE(GROUP,IF(h.orig_subj7_email = (TYPEOF(h.orig_subj7_email))'',0,100));
    maxlength_orig_subj7_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_email)));
    avelength_orig_subj7_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_email)),h.orig_subj7_email<>(typeof(h.orig_subj7_email))'');
    populated_orig_subj7_company_name_cnt := COUNT(GROUP,h.orig_subj7_company_name <> (TYPEOF(h.orig_subj7_company_name))'');
    populated_orig_subj7_company_name_pcnt := AVE(GROUP,IF(h.orig_subj7_company_name = (TYPEOF(h.orig_subj7_company_name))'',0,100));
    maxlength_orig_subj7_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_company_name)));
    avelength_orig_subj7_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_company_name)),h.orig_subj7_company_name<>(typeof(h.orig_subj7_company_name))'');
    populated_orig_subj7_fein_cnt := COUNT(GROUP,h.orig_subj7_fein <> (TYPEOF(h.orig_subj7_fein))'');
    populated_orig_subj7_fein_pcnt := AVE(GROUP,IF(h.orig_subj7_fein = (TYPEOF(h.orig_subj7_fein))'',0,100));
    maxlength_orig_subj7_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_fein)));
    avelength_orig_subj7_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj7_fein)),h.orig_subj7_fein<>(typeof(h.orig_subj7_fein))'');
    populated_orig_subj8_first_name_cnt := COUNT(GROUP,h.orig_subj8_first_name <> (TYPEOF(h.orig_subj8_first_name))'');
    populated_orig_subj8_first_name_pcnt := AVE(GROUP,IF(h.orig_subj8_first_name = (TYPEOF(h.orig_subj8_first_name))'',0,100));
    maxlength_orig_subj8_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_first_name)));
    avelength_orig_subj8_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_first_name)),h.orig_subj8_first_name<>(typeof(h.orig_subj8_first_name))'');
    populated_orig_subj8_middle_name_cnt := COUNT(GROUP,h.orig_subj8_middle_name <> (TYPEOF(h.orig_subj8_middle_name))'');
    populated_orig_subj8_middle_name_pcnt := AVE(GROUP,IF(h.orig_subj8_middle_name = (TYPEOF(h.orig_subj8_middle_name))'',0,100));
    maxlength_orig_subj8_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_middle_name)));
    avelength_orig_subj8_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_middle_name)),h.orig_subj8_middle_name<>(typeof(h.orig_subj8_middle_name))'');
    populated_orig_subj8_last_name_cnt := COUNT(GROUP,h.orig_subj8_last_name <> (TYPEOF(h.orig_subj8_last_name))'');
    populated_orig_subj8_last_name_pcnt := AVE(GROUP,IF(h.orig_subj8_last_name = (TYPEOF(h.orig_subj8_last_name))'',0,100));
    maxlength_orig_subj8_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_last_name)));
    avelength_orig_subj8_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_last_name)),h.orig_subj8_last_name<>(typeof(h.orig_subj8_last_name))'');
    populated_orig_subj8_suffix_name_cnt := COUNT(GROUP,h.orig_subj8_suffix_name <> (TYPEOF(h.orig_subj8_suffix_name))'');
    populated_orig_subj8_suffix_name_pcnt := AVE(GROUP,IF(h.orig_subj8_suffix_name = (TYPEOF(h.orig_subj8_suffix_name))'',0,100));
    maxlength_orig_subj8_suffix_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_suffix_name)));
    avelength_orig_subj8_suffix_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_suffix_name)),h.orig_subj8_suffix_name<>(typeof(h.orig_subj8_suffix_name))'');
    populated_orig_subj8_full_name_cnt := COUNT(GROUP,h.orig_subj8_full_name <> (TYPEOF(h.orig_subj8_full_name))'');
    populated_orig_subj8_full_name_pcnt := AVE(GROUP,IF(h.orig_subj8_full_name = (TYPEOF(h.orig_subj8_full_name))'',0,100));
    maxlength_orig_subj8_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_full_name)));
    avelength_orig_subj8_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_full_name)),h.orig_subj8_full_name<>(typeof(h.orig_subj8_full_name))'');
    populated_orig_subj8_ssn_cnt := COUNT(GROUP,h.orig_subj8_ssn <> (TYPEOF(h.orig_subj8_ssn))'');
    populated_orig_subj8_ssn_pcnt := AVE(GROUP,IF(h.orig_subj8_ssn = (TYPEOF(h.orig_subj8_ssn))'',0,100));
    maxlength_orig_subj8_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_ssn)));
    avelength_orig_subj8_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_ssn)),h.orig_subj8_ssn<>(typeof(h.orig_subj8_ssn))'');
    populated_orig_subj8_dob_cnt := COUNT(GROUP,h.orig_subj8_dob <> (TYPEOF(h.orig_subj8_dob))'');
    populated_orig_subj8_dob_pcnt := AVE(GROUP,IF(h.orig_subj8_dob = (TYPEOF(h.orig_subj8_dob))'',0,100));
    maxlength_orig_subj8_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_dob)));
    avelength_orig_subj8_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_dob)),h.orig_subj8_dob<>(typeof(h.orig_subj8_dob))'');
    populated_orig_subj8_dl_num_cnt := COUNT(GROUP,h.orig_subj8_dl_num <> (TYPEOF(h.orig_subj8_dl_num))'');
    populated_orig_subj8_dl_num_pcnt := AVE(GROUP,IF(h.orig_subj8_dl_num = (TYPEOF(h.orig_subj8_dl_num))'',0,100));
    maxlength_orig_subj8_dl_num := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_dl_num)));
    avelength_orig_subj8_dl_num := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_dl_num)),h.orig_subj8_dl_num<>(typeof(h.orig_subj8_dl_num))'');
    populated_orig_subj8_dl_state_cnt := COUNT(GROUP,h.orig_subj8_dl_state <> (TYPEOF(h.orig_subj8_dl_state))'');
    populated_orig_subj8_dl_state_pcnt := AVE(GROUP,IF(h.orig_subj8_dl_state = (TYPEOF(h.orig_subj8_dl_state))'',0,100));
    maxlength_orig_subj8_dl_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_dl_state)));
    avelength_orig_subj8_dl_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_dl_state)),h.orig_subj8_dl_state<>(typeof(h.orig_subj8_dl_state))'');
    populated_orig_subj8_former_last_name_cnt := COUNT(GROUP,h.orig_subj8_former_last_name <> (TYPEOF(h.orig_subj8_former_last_name))'');
    populated_orig_subj8_former_last_name_pcnt := AVE(GROUP,IF(h.orig_subj8_former_last_name = (TYPEOF(h.orig_subj8_former_last_name))'',0,100));
    maxlength_orig_subj8_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_former_last_name)));
    avelength_orig_subj8_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_former_last_name)),h.orig_subj8_former_last_name<>(typeof(h.orig_subj8_former_last_name))'');
    populated_orig_subj8_address_addressline1_cnt := COUNT(GROUP,h.orig_subj8_address_addressline1 <> (TYPEOF(h.orig_subj8_address_addressline1))'');
    populated_orig_subj8_address_addressline1_pcnt := AVE(GROUP,IF(h.orig_subj8_address_addressline1 = (TYPEOF(h.orig_subj8_address_addressline1))'',0,100));
    maxlength_orig_subj8_address_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_addressline1)));
    avelength_orig_subj8_address_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_addressline1)),h.orig_subj8_address_addressline1<>(typeof(h.orig_subj8_address_addressline1))'');
    populated_orig_subj8_address_addressline2_cnt := COUNT(GROUP,h.orig_subj8_address_addressline2 <> (TYPEOF(h.orig_subj8_address_addressline2))'');
    populated_orig_subj8_address_addressline2_pcnt := AVE(GROUP,IF(h.orig_subj8_address_addressline2 = (TYPEOF(h.orig_subj8_address_addressline2))'',0,100));
    maxlength_orig_subj8_address_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_addressline2)));
    avelength_orig_subj8_address_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_addressline2)),h.orig_subj8_address_addressline2<>(typeof(h.orig_subj8_address_addressline2))'');
    populated_orig_subj8_address_prim_range_cnt := COUNT(GROUP,h.orig_subj8_address_prim_range <> (TYPEOF(h.orig_subj8_address_prim_range))'');
    populated_orig_subj8_address_prim_range_pcnt := AVE(GROUP,IF(h.orig_subj8_address_prim_range = (TYPEOF(h.orig_subj8_address_prim_range))'',0,100));
    maxlength_orig_subj8_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_prim_range)));
    avelength_orig_subj8_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_prim_range)),h.orig_subj8_address_prim_range<>(typeof(h.orig_subj8_address_prim_range))'');
    populated_orig_subj8_address_predir_cnt := COUNT(GROUP,h.orig_subj8_address_predir <> (TYPEOF(h.orig_subj8_address_predir))'');
    populated_orig_subj8_address_predir_pcnt := AVE(GROUP,IF(h.orig_subj8_address_predir = (TYPEOF(h.orig_subj8_address_predir))'',0,100));
    maxlength_orig_subj8_address_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_predir)));
    avelength_orig_subj8_address_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_predir)),h.orig_subj8_address_predir<>(typeof(h.orig_subj8_address_predir))'');
    populated_orig_subj8_address_prim_name_cnt := COUNT(GROUP,h.orig_subj8_address_prim_name <> (TYPEOF(h.orig_subj8_address_prim_name))'');
    populated_orig_subj8_address_prim_name_pcnt := AVE(GROUP,IF(h.orig_subj8_address_prim_name = (TYPEOF(h.orig_subj8_address_prim_name))'',0,100));
    maxlength_orig_subj8_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_prim_name)));
    avelength_orig_subj8_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_prim_name)),h.orig_subj8_address_prim_name<>(typeof(h.orig_subj8_address_prim_name))'');
    populated_orig_subj8_address_suffix_cnt := COUNT(GROUP,h.orig_subj8_address_suffix <> (TYPEOF(h.orig_subj8_address_suffix))'');
    populated_orig_subj8_address_suffix_pcnt := AVE(GROUP,IF(h.orig_subj8_address_suffix = (TYPEOF(h.orig_subj8_address_suffix))'',0,100));
    maxlength_orig_subj8_address_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_suffix)));
    avelength_orig_subj8_address_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_suffix)),h.orig_subj8_address_suffix<>(typeof(h.orig_subj8_address_suffix))'');
    populated_orig_subj8_address_postdir_cnt := COUNT(GROUP,h.orig_subj8_address_postdir <> (TYPEOF(h.orig_subj8_address_postdir))'');
    populated_orig_subj8_address_postdir_pcnt := AVE(GROUP,IF(h.orig_subj8_address_postdir = (TYPEOF(h.orig_subj8_address_postdir))'',0,100));
    maxlength_orig_subj8_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_postdir)));
    avelength_orig_subj8_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_postdir)),h.orig_subj8_address_postdir<>(typeof(h.orig_subj8_address_postdir))'');
    populated_orig_subj8_address_unit_desig_cnt := COUNT(GROUP,h.orig_subj8_address_unit_desig <> (TYPEOF(h.orig_subj8_address_unit_desig))'');
    populated_orig_subj8_address_unit_desig_pcnt := AVE(GROUP,IF(h.orig_subj8_address_unit_desig = (TYPEOF(h.orig_subj8_address_unit_desig))'',0,100));
    maxlength_orig_subj8_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_unit_desig)));
    avelength_orig_subj8_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_unit_desig)),h.orig_subj8_address_unit_desig<>(typeof(h.orig_subj8_address_unit_desig))'');
    populated_orig_subj8_address_sec_range_cnt := COUNT(GROUP,h.orig_subj8_address_sec_range <> (TYPEOF(h.orig_subj8_address_sec_range))'');
    populated_orig_subj8_address_sec_range_pcnt := AVE(GROUP,IF(h.orig_subj8_address_sec_range = (TYPEOF(h.orig_subj8_address_sec_range))'',0,100));
    maxlength_orig_subj8_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_sec_range)));
    avelength_orig_subj8_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_sec_range)),h.orig_subj8_address_sec_range<>(typeof(h.orig_subj8_address_sec_range))'');
    populated_orig_subj8_address_city_cnt := COUNT(GROUP,h.orig_subj8_address_city <> (TYPEOF(h.orig_subj8_address_city))'');
    populated_orig_subj8_address_city_pcnt := AVE(GROUP,IF(h.orig_subj8_address_city = (TYPEOF(h.orig_subj8_address_city))'',0,100));
    maxlength_orig_subj8_address_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_city)));
    avelength_orig_subj8_address_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_city)),h.orig_subj8_address_city<>(typeof(h.orig_subj8_address_city))'');
    populated_orig_subj8_address_st_cnt := COUNT(GROUP,h.orig_subj8_address_st <> (TYPEOF(h.orig_subj8_address_st))'');
    populated_orig_subj8_address_st_pcnt := AVE(GROUP,IF(h.orig_subj8_address_st = (TYPEOF(h.orig_subj8_address_st))'',0,100));
    maxlength_orig_subj8_address_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_st)));
    avelength_orig_subj8_address_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_st)),h.orig_subj8_address_st<>(typeof(h.orig_subj8_address_st))'');
    populated_orig_subj8_address_z5_cnt := COUNT(GROUP,h.orig_subj8_address_z5 <> (TYPEOF(h.orig_subj8_address_z5))'');
    populated_orig_subj8_address_z5_pcnt := AVE(GROUP,IF(h.orig_subj8_address_z5 = (TYPEOF(h.orig_subj8_address_z5))'',0,100));
    maxlength_orig_subj8_address_z5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_z5)));
    avelength_orig_subj8_address_z5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_z5)),h.orig_subj8_address_z5<>(typeof(h.orig_subj8_address_z5))'');
    populated_orig_subj8_address_z4_cnt := COUNT(GROUP,h.orig_subj8_address_z4 <> (TYPEOF(h.orig_subj8_address_z4))'');
    populated_orig_subj8_address_z4_pcnt := AVE(GROUP,IF(h.orig_subj8_address_z4 = (TYPEOF(h.orig_subj8_address_z4))'',0,100));
    maxlength_orig_subj8_address_z4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_z4)));
    avelength_orig_subj8_address_z4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_address_z4)),h.orig_subj8_address_z4<>(typeof(h.orig_subj8_address_z4))'');
    populated_orig_subj8_phone_cnt := COUNT(GROUP,h.orig_subj8_phone <> (TYPEOF(h.orig_subj8_phone))'');
    populated_orig_subj8_phone_pcnt := AVE(GROUP,IF(h.orig_subj8_phone = (TYPEOF(h.orig_subj8_phone))'',0,100));
    maxlength_orig_subj8_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_phone)));
    avelength_orig_subj8_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_phone)),h.orig_subj8_phone<>(typeof(h.orig_subj8_phone))'');
    populated_orig_subj8_work_phone_cnt := COUNT(GROUP,h.orig_subj8_work_phone <> (TYPEOF(h.orig_subj8_work_phone))'');
    populated_orig_subj8_work_phone_pcnt := AVE(GROUP,IF(h.orig_subj8_work_phone = (TYPEOF(h.orig_subj8_work_phone))'',0,100));
    maxlength_orig_subj8_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_work_phone)));
    avelength_orig_subj8_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_work_phone)),h.orig_subj8_work_phone<>(typeof(h.orig_subj8_work_phone))'');
    populated_orig_subj8_business_title_cnt := COUNT(GROUP,h.orig_subj8_business_title <> (TYPEOF(h.orig_subj8_business_title))'');
    populated_orig_subj8_business_title_pcnt := AVE(GROUP,IF(h.orig_subj8_business_title = (TYPEOF(h.orig_subj8_business_title))'',0,100));
    maxlength_orig_subj8_business_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_business_title)));
    avelength_orig_subj8_business_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_business_title)),h.orig_subj8_business_title<>(typeof(h.orig_subj8_business_title))'');
    populated_orig_subj8_email_cnt := COUNT(GROUP,h.orig_subj8_email <> (TYPEOF(h.orig_subj8_email))'');
    populated_orig_subj8_email_pcnt := AVE(GROUP,IF(h.orig_subj8_email = (TYPEOF(h.orig_subj8_email))'',0,100));
    maxlength_orig_subj8_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_email)));
    avelength_orig_subj8_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_email)),h.orig_subj8_email<>(typeof(h.orig_subj8_email))'');
    populated_orig_subj8_company_name_cnt := COUNT(GROUP,h.orig_subj8_company_name <> (TYPEOF(h.orig_subj8_company_name))'');
    populated_orig_subj8_company_name_pcnt := AVE(GROUP,IF(h.orig_subj8_company_name = (TYPEOF(h.orig_subj8_company_name))'',0,100));
    maxlength_orig_subj8_company_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_company_name)));
    avelength_orig_subj8_company_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_company_name)),h.orig_subj8_company_name<>(typeof(h.orig_subj8_company_name))'');
    populated_orig_subj8_fein_cnt := COUNT(GROUP,h.orig_subj8_fein <> (TYPEOF(h.orig_subj8_fein))'');
    populated_orig_subj8_fein_pcnt := AVE(GROUP,IF(h.orig_subj8_fein = (TYPEOF(h.orig_subj8_fein))'',0,100));
    maxlength_orig_subj8_fein := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_fein)));
    avelength_orig_subj8_fein := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_subj8_fein)),h.orig_subj8_fein<>(typeof(h.orig_subj8_fein))'');
    populated_orig_company_alternate_name_cnt := COUNT(GROUP,h.orig_company_alternate_name <> (TYPEOF(h.orig_company_alternate_name))'');
    populated_orig_company_alternate_name_pcnt := AVE(GROUP,IF(h.orig_company_alternate_name = (TYPEOF(h.orig_company_alternate_name))'',0,100));
    maxlength_orig_company_alternate_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_alternate_name)));
    avelength_orig_company_alternate_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_alternate_name)),h.orig_company_alternate_name<>(typeof(h.orig_company_alternate_name))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_datetime_stamp_pcnt *   0.00 / 100 + T.Populated_orig_global_company_id_pcnt *   0.00 / 100 + T.Populated_orig_company_id_pcnt *   0.00 / 100 + T.Populated_orig_product_cd_pcnt *   0.00 / 100 + T.Populated_orig_method_pcnt *   0.00 / 100 + T.Populated_orig_vertical_pcnt *   0.00 / 100 + T.Populated_orig_function_name_pcnt *   0.00 / 100 + T.Populated_orig_transaction_type_pcnt *   0.00 / 100 + T.Populated_orig_login_history_id_pcnt *   0.00 / 100 + T.Populated_orig_job_id_pcnt *   0.00 / 100 + T.Populated_orig_sequence_number_pcnt *   0.00 / 100 + T.Populated_orig_first_name_pcnt *   0.00 / 100 + T.Populated_orig_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_last_name_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_address1_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_address1_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_address1_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_address1_predir_pcnt *   0.00 / 100 + T.Populated_orig_address1_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_address1_suffix_pcnt *   0.00 / 100 + T.Populated_orig_address1_postdir_pcnt *   0.00 / 100 + T.Populated_orig_address1_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_address1_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_address1_city_pcnt *   0.00 / 100 + T.Populated_orig_address1_st_pcnt *   0.00 / 100 + T.Populated_orig_address1_z5_pcnt *   0.00 / 100 + T.Populated_orig_address1_z4_pcnt *   0.00 / 100 + T.Populated_orig_address2_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_address2_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_address2_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_address2_predir_pcnt *   0.00 / 100 + T.Populated_orig_address2_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_address2_suffix_pcnt *   0.00 / 100 + T.Populated_orig_address2_postdir_pcnt *   0.00 / 100 + T.Populated_orig_address2_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_address2_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_address2_city_pcnt *   0.00 / 100 + T.Populated_orig_address2_st_pcnt *   0.00 / 100 + T.Populated_orig_address2_z5_pcnt *   0.00 / 100 + T.Populated_orig_address2_z4_pcnt *   0.00 / 100 + T.Populated_orig_bdid_pcnt *   0.00 / 100 + T.Populated_orig_bdl_pcnt *   0.00 / 100 + T.Populated_orig_did_pcnt *   0.00 / 100 + T.Populated_orig_company_name_pcnt *   0.00 / 100 + T.Populated_orig_fein_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_company_phone_pcnt *   0.00 / 100 + T.Populated_orig_reference_code_pcnt *   0.00 / 100 + T.Populated_orig_ip_address_initiated_pcnt *   0.00 / 100 + T.Populated_orig_ip_address_executed_pcnt *   0.00 / 100 + T.Populated_orig_charter_number_pcnt *   0.00 / 100 + T.Populated_orig_ucc_original_filing_number_pcnt *   0.00 / 100 + T.Populated_orig_email_address_pcnt *   0.00 / 100 + T.Populated_orig_domain_name_pcnt *   0.00 / 100 + T.Populated_orig_full_name_pcnt *   0.00 / 100 + T.Populated_orig_dl_purpose_pcnt *   0.00 / 100 + T.Populated_orig_glb_purpose_pcnt *   0.00 / 100 + T.Populated_orig_fcra_purpose_pcnt *   0.00 / 100 + T.Populated_orig_process_id_pcnt *   0.00 / 100 + T.Populated_orig_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_business_title_pcnt *   0.00 / 100 + T.Populated_orig_company_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_company_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_company_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_company_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_company_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_company_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_company_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_company_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_company_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_company_address_city_pcnt *   0.00 / 100 + T.Populated_orig_company_address_st_pcnt *   0.00 / 100 + T.Populated_orig_company_address_zip5_pcnt *   0.00 / 100 + T.Populated_orig_company_address_zip4_pcnt *   0.00 / 100 + T.Populated_orig_company_fax_number_pcnt *   0.00 / 100 + T.Populated_orig_company_start_date_pcnt *   0.00 / 100 + T.Populated_orig_company_years_in_business_pcnt *   0.00 / 100 + T.Populated_orig_company_sic_code_pcnt *   0.00 / 100 + T.Populated_orig_company_naic_code_pcnt *   0.00 / 100 + T.Populated_orig_company_structure_pcnt *   0.00 / 100 + T.Populated_orig_company_yearly_revenue_pcnt *   0.00 / 100 + T.Populated_orig_subj2_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj2_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj2_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj2_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj2_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj2_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj2_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj2_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj2_business_title_pcnt *   0.00 / 100 + T.Populated_orig_subj3_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj3_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj3_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj3_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj3_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj3_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj3_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj3_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj3_business_title_pcnt *   0.00 / 100 + T.Populated_orig_email_pcnt *   0.00 / 100 + T.Populated_orig_subj2_email_pcnt *   0.00 / 100 + T.Populated_orig_subj2_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj2_fein_pcnt *   0.00 / 100 + T.Populated_orig_subj3_email_pcnt *   0.00 / 100 + T.Populated_orig_subj3_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj3_fein_pcnt *   0.00 / 100 + T.Populated_orig_subj4_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj4_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj4_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj4_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj4_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj4_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj4_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj4_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj4_business_title_pcnt *   0.00 / 100 + T.Populated_orig_subj4_email_pcnt *   0.00 / 100 + T.Populated_orig_subj4_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj4_fein_pcnt *   0.00 / 100 + T.Populated_orig_subj5_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj5_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj5_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj5_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj5_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj5_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj5_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj5_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj5_business_title_pcnt *   0.00 / 100 + T.Populated_orig_subj5_email_pcnt *   0.00 / 100 + T.Populated_orig_subj5_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj5_fein_pcnt *   0.00 / 100 + T.Populated_orig_subj6_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj6_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj6_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj6_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj6_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj6_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj6_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj6_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj6_business_title_pcnt *   0.00 / 100 + T.Populated_orig_subj6_email_pcnt *   0.00 / 100 + T.Populated_orig_subj6_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj6_fein_pcnt *   0.00 / 100 + T.Populated_orig_subj7_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj7_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj7_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj7_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj7_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj7_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj7_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj7_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj7_business_title_pcnt *   0.00 / 100 + T.Populated_orig_subj7_email_pcnt *   0.00 / 100 + T.Populated_orig_subj7_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj7_fein_pcnt *   0.00 / 100 + T.Populated_orig_subj8_first_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_suffix_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_full_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_ssn_pcnt *   0.00 / 100 + T.Populated_orig_subj8_dob_pcnt *   0.00 / 100 + T.Populated_orig_subj8_dl_num_pcnt *   0.00 / 100 + T.Populated_orig_subj8_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_subj8_former_last_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_addressline1_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_addressline2_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_predir_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_suffix_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_postdir_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_city_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_st_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_z5_pcnt *   0.00 / 100 + T.Populated_orig_subj8_address_z4_pcnt *   0.00 / 100 + T.Populated_orig_subj8_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj8_work_phone_pcnt *   0.00 / 100 + T.Populated_orig_subj8_business_title_pcnt *   0.00 / 100 + T.Populated_orig_subj8_email_pcnt *   0.00 / 100 + T.Populated_orig_subj8_company_name_pcnt *   0.00 / 100 + T.Populated_orig_subj8_fein_pcnt *   0.00 / 100 + T.Populated_orig_company_alternate_name_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','orig_suffix_name','orig_former_last_name','orig_business_title','orig_company_addressline1','orig_company_addressline2','orig_company_address_prim_range','orig_company_address_predir','orig_company_address_prim_name','orig_company_address_suffix','orig_company_address_postdir','orig_company_address_unit_desig','orig_company_address_sec_range','orig_company_address_city','orig_company_address_st','orig_company_address_zip5','orig_company_address_zip4','orig_company_fax_number','orig_company_start_date','orig_company_years_in_business','orig_company_sic_code','orig_company_naic_code','orig_company_structure','orig_company_yearly_revenue','orig_subj2_first_name','orig_subj2_middle_name','orig_subj2_last_name','orig_subj2_suffix_name','orig_subj2_full_name','orig_subj2_ssn','orig_subj2_dob','orig_subj2_dl_num','orig_subj2_dl_state','orig_subj2_former_last_name','orig_subj2_address_addressline1','orig_subj2_address_addressline2','orig_subj2_address_prim_range','orig_subj2_address_predir','orig_subj2_address_prim_name','orig_subj2_address_suffix','orig_subj2_address_postdir','orig_subj2_address_unit_desig','orig_subj2_address_sec_range','orig_subj2_address_city','orig_subj2_address_st','orig_subj2_address_z5','orig_subj2_address_z4','orig_subj2_phone','orig_subj2_work_phone','orig_subj2_business_title','orig_subj3_first_name','orig_subj3_middle_name','orig_subj3_last_name','orig_subj3_suffix_name','orig_subj3_full_name','orig_subj3_ssn','orig_subj3_dob','orig_subj3_dl_num','orig_subj3_dl_state','orig_subj3_former_last_name','orig_subj3_address_addressline1','orig_subj3_address_addressline2','orig_subj3_address_prim_range','orig_subj3_address_predir','orig_subj3_address_prim_name','orig_subj3_address_suffix','orig_subj3_address_postdir','orig_subj3_address_unit_desig','orig_subj3_address_sec_range','orig_subj3_address_city','orig_subj3_address_st','orig_subj3_address_z5','orig_subj3_address_z4','orig_subj3_phone','orig_subj3_work_phone','orig_subj3_business_title','orig_email','orig_subj2_email','orig_subj2_company_name','orig_subj2_fein','orig_subj3_email','orig_subj3_company_name','orig_subj3_fein','orig_subj4_first_name','orig_subj4_middle_name','orig_subj4_last_name','orig_subj4_suffix_name','orig_subj4_full_name','orig_subj4_ssn','orig_subj4_dob','orig_subj4_dl_num','orig_subj4_dl_state','orig_subj4_former_last_name','orig_subj4_address_addressline1','orig_subj4_address_addressline2','orig_subj4_address_prim_range','orig_subj4_address_predir','orig_subj4_address_prim_name','orig_subj4_address_suffix','orig_subj4_address_postdir','orig_subj4_address_unit_desig','orig_subj4_address_sec_range','orig_subj4_address_city','orig_subj4_address_st','orig_subj4_address_z5','orig_subj4_address_z4','orig_subj4_phone','orig_subj4_work_phone','orig_subj4_business_title','orig_subj4_email','orig_subj4_company_name','orig_subj4_fein','orig_subj5_first_name','orig_subj5_middle_name','orig_subj5_last_name','orig_subj5_suffix_name','orig_subj5_full_name','orig_subj5_ssn','orig_subj5_dob','orig_subj5_dl_num','orig_subj5_dl_state','orig_subj5_former_last_name','orig_subj5_address_addressline1','orig_subj5_address_addressline2','orig_subj5_address_prim_range','orig_subj5_address_predir','orig_subj5_address_prim_name','orig_subj5_address_suffix','orig_subj5_address_postdir','orig_subj5_address_unit_desig','orig_subj5_address_sec_range','orig_subj5_address_city','orig_subj5_address_st','orig_subj5_address_z5','orig_subj5_address_z4','orig_subj5_phone','orig_subj5_work_phone','orig_subj5_business_title','orig_subj5_email','orig_subj5_company_name','orig_subj5_fein','orig_subj6_first_name','orig_subj6_middle_name','orig_subj6_last_name','orig_subj6_suffix_name','orig_subj6_full_name','orig_subj6_ssn','orig_subj6_dob','orig_subj6_dl_num','orig_subj6_dl_state','orig_subj6_former_last_name','orig_subj6_address_addressline1','orig_subj6_address_addressline2','orig_subj6_address_prim_range','orig_subj6_address_predir','orig_subj6_address_prim_name','orig_subj6_address_suffix','orig_subj6_address_postdir','orig_subj6_address_unit_desig','orig_subj6_address_sec_range','orig_subj6_address_city','orig_subj6_address_st','orig_subj6_address_z5','orig_subj6_address_z4','orig_subj6_phone','orig_subj6_work_phone','orig_subj6_business_title','orig_subj6_email','orig_subj6_company_name','orig_subj6_fein','orig_subj7_first_name','orig_subj7_middle_name','orig_subj7_last_name','orig_subj7_suffix_name','orig_subj7_full_name','orig_subj7_ssn','orig_subj7_dob','orig_subj7_dl_num','orig_subj7_dl_state','orig_subj7_former_last_name','orig_subj7_address_addressline1','orig_subj7_address_addressline2','orig_subj7_address_prim_range','orig_subj7_address_predir','orig_subj7_address_prim_name','orig_subj7_address_suffix','orig_subj7_address_postdir','orig_subj7_address_unit_desig','orig_subj7_address_sec_range','orig_subj7_address_city','orig_subj7_address_st','orig_subj7_address_z5','orig_subj7_address_z4','orig_subj7_phone','orig_subj7_work_phone','orig_subj7_business_title','orig_subj7_email','orig_subj7_company_name','orig_subj7_fein','orig_subj8_first_name','orig_subj8_middle_name','orig_subj8_last_name','orig_subj8_suffix_name','orig_subj8_full_name','orig_subj8_ssn','orig_subj8_dob','orig_subj8_dl_num','orig_subj8_dl_state','orig_subj8_former_last_name','orig_subj8_address_addressline1','orig_subj8_address_addressline2','orig_subj8_address_prim_range','orig_subj8_address_predir','orig_subj8_address_prim_name','orig_subj8_address_suffix','orig_subj8_address_postdir','orig_subj8_address_unit_desig','orig_subj8_address_sec_range','orig_subj8_address_city','orig_subj8_address_st','orig_subj8_address_z5','orig_subj8_address_z4','orig_subj8_phone','orig_subj8_work_phone','orig_subj8_business_title','orig_subj8_email','orig_subj8_company_name','orig_subj8_fein','orig_company_alternate_name');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_datetime_stamp_pcnt,le.populated_orig_global_company_id_pcnt,le.populated_orig_company_id_pcnt,le.populated_orig_product_cd_pcnt,le.populated_orig_method_pcnt,le.populated_orig_vertical_pcnt,le.populated_orig_function_name_pcnt,le.populated_orig_transaction_type_pcnt,le.populated_orig_login_history_id_pcnt,le.populated_orig_job_id_pcnt,le.populated_orig_sequence_number_pcnt,le.populated_orig_first_name_pcnt,le.populated_orig_middle_name_pcnt,le.populated_orig_last_name_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_dl_num_pcnt,le.populated_orig_dl_state_pcnt,le.populated_orig_address1_addressline1_pcnt,le.populated_orig_address1_addressline2_pcnt,le.populated_orig_address1_prim_range_pcnt,le.populated_orig_address1_predir_pcnt,le.populated_orig_address1_prim_name_pcnt,le.populated_orig_address1_suffix_pcnt,le.populated_orig_address1_postdir_pcnt,le.populated_orig_address1_unit_desig_pcnt,le.populated_orig_address1_sec_range_pcnt,le.populated_orig_address1_city_pcnt,le.populated_orig_address1_st_pcnt,le.populated_orig_address1_z5_pcnt,le.populated_orig_address1_z4_pcnt,le.populated_orig_address2_addressline1_pcnt,le.populated_orig_address2_addressline2_pcnt,le.populated_orig_address2_prim_range_pcnt,le.populated_orig_address2_predir_pcnt,le.populated_orig_address2_prim_name_pcnt,le.populated_orig_address2_suffix_pcnt,le.populated_orig_address2_postdir_pcnt,le.populated_orig_address2_unit_desig_pcnt,le.populated_orig_address2_sec_range_pcnt,le.populated_orig_address2_city_pcnt,le.populated_orig_address2_st_pcnt,le.populated_orig_address2_z5_pcnt,le.populated_orig_address2_z4_pcnt,le.populated_orig_bdid_pcnt,le.populated_orig_bdl_pcnt,le.populated_orig_did_pcnt,le.populated_orig_company_name_pcnt,le.populated_orig_fein_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_work_phone_pcnt,le.populated_orig_company_phone_pcnt,le.populated_orig_reference_code_pcnt,le.populated_orig_ip_address_initiated_pcnt,le.populated_orig_ip_address_executed_pcnt,le.populated_orig_charter_number_pcnt,le.populated_orig_ucc_original_filing_number_pcnt,le.populated_orig_email_address_pcnt,le.populated_orig_domain_name_pcnt,le.populated_orig_full_name_pcnt,le.populated_orig_dl_purpose_pcnt,le.populated_orig_glb_purpose_pcnt,le.populated_orig_fcra_purpose_pcnt,le.populated_orig_process_id_pcnt,le.populated_orig_suffix_name_pcnt,le.populated_orig_former_last_name_pcnt,le.populated_orig_business_title_pcnt,le.populated_orig_company_addressline1_pcnt,le.populated_orig_company_addressline2_pcnt,le.populated_orig_company_address_prim_range_pcnt,le.populated_orig_company_address_predir_pcnt,le.populated_orig_company_address_prim_name_pcnt,le.populated_orig_company_address_suffix_pcnt,le.populated_orig_company_address_postdir_pcnt,le.populated_orig_company_address_unit_desig_pcnt,le.populated_orig_company_address_sec_range_pcnt,le.populated_orig_company_address_city_pcnt,le.populated_orig_company_address_st_pcnt,le.populated_orig_company_address_zip5_pcnt,le.populated_orig_company_address_zip4_pcnt,le.populated_orig_company_fax_number_pcnt,le.populated_orig_company_start_date_pcnt,le.populated_orig_company_years_in_business_pcnt,le.populated_orig_company_sic_code_pcnt,le.populated_orig_company_naic_code_pcnt,le.populated_orig_company_structure_pcnt,le.populated_orig_company_yearly_revenue_pcnt,le.populated_orig_subj2_first_name_pcnt,le.populated_orig_subj2_middle_name_pcnt,le.populated_orig_subj2_last_name_pcnt,le.populated_orig_subj2_suffix_name_pcnt,le.populated_orig_subj2_full_name_pcnt,le.populated_orig_subj2_ssn_pcnt,le.populated_orig_subj2_dob_pcnt,le.populated_orig_subj2_dl_num_pcnt,le.populated_orig_subj2_dl_state_pcnt,le.populated_orig_subj2_former_last_name_pcnt,le.populated_orig_subj2_address_addressline1_pcnt,le.populated_orig_subj2_address_addressline2_pcnt,le.populated_orig_subj2_address_prim_range_pcnt,le.populated_orig_subj2_address_predir_pcnt,le.populated_orig_subj2_address_prim_name_pcnt,le.populated_orig_subj2_address_suffix_pcnt,le.populated_orig_subj2_address_postdir_pcnt,le.populated_orig_subj2_address_unit_desig_pcnt,le.populated_orig_subj2_address_sec_range_pcnt,le.populated_orig_subj2_address_city_pcnt,le.populated_orig_subj2_address_st_pcnt,le.populated_orig_subj2_address_z5_pcnt,le.populated_orig_subj2_address_z4_pcnt,le.populated_orig_subj2_phone_pcnt,le.populated_orig_subj2_work_phone_pcnt,le.populated_orig_subj2_business_title_pcnt,le.populated_orig_subj3_first_name_pcnt,le.populated_orig_subj3_middle_name_pcnt,le.populated_orig_subj3_last_name_pcnt,le.populated_orig_subj3_suffix_name_pcnt,le.populated_orig_subj3_full_name_pcnt,le.populated_orig_subj3_ssn_pcnt,le.populated_orig_subj3_dob_pcnt,le.populated_orig_subj3_dl_num_pcnt,le.populated_orig_subj3_dl_state_pcnt,le.populated_orig_subj3_former_last_name_pcnt,le.populated_orig_subj3_address_addressline1_pcnt,le.populated_orig_subj3_address_addressline2_pcnt,le.populated_orig_subj3_address_prim_range_pcnt,le.populated_orig_subj3_address_predir_pcnt,le.populated_orig_subj3_address_prim_name_pcnt,le.populated_orig_subj3_address_suffix_pcnt,le.populated_orig_subj3_address_postdir_pcnt,le.populated_orig_subj3_address_unit_desig_pcnt,le.populated_orig_subj3_address_sec_range_pcnt,le.populated_orig_subj3_address_city_pcnt,le.populated_orig_subj3_address_st_pcnt,le.populated_orig_subj3_address_z5_pcnt,le.populated_orig_subj3_address_z4_pcnt,le.populated_orig_subj3_phone_pcnt,le.populated_orig_subj3_work_phone_pcnt,le.populated_orig_subj3_business_title_pcnt,le.populated_orig_email_pcnt,le.populated_orig_subj2_email_pcnt,le.populated_orig_subj2_company_name_pcnt,le.populated_orig_subj2_fein_pcnt,le.populated_orig_subj3_email_pcnt,le.populated_orig_subj3_company_name_pcnt,le.populated_orig_subj3_fein_pcnt,le.populated_orig_subj4_first_name_pcnt,le.populated_orig_subj4_middle_name_pcnt,le.populated_orig_subj4_last_name_pcnt,le.populated_orig_subj4_suffix_name_pcnt,le.populated_orig_subj4_full_name_pcnt,le.populated_orig_subj4_ssn_pcnt,le.populated_orig_subj4_dob_pcnt,le.populated_orig_subj4_dl_num_pcnt,le.populated_orig_subj4_dl_state_pcnt,le.populated_orig_subj4_former_last_name_pcnt,le.populated_orig_subj4_address_addressline1_pcnt,le.populated_orig_subj4_address_addressline2_pcnt,le.populated_orig_subj4_address_prim_range_pcnt,le.populated_orig_subj4_address_predir_pcnt,le.populated_orig_subj4_address_prim_name_pcnt,le.populated_orig_subj4_address_suffix_pcnt,le.populated_orig_subj4_address_postdir_pcnt,le.populated_orig_subj4_address_unit_desig_pcnt,le.populated_orig_subj4_address_sec_range_pcnt,le.populated_orig_subj4_address_city_pcnt,le.populated_orig_subj4_address_st_pcnt,le.populated_orig_subj4_address_z5_pcnt,le.populated_orig_subj4_address_z4_pcnt,le.populated_orig_subj4_phone_pcnt,le.populated_orig_subj4_work_phone_pcnt,le.populated_orig_subj4_business_title_pcnt,le.populated_orig_subj4_email_pcnt,le.populated_orig_subj4_company_name_pcnt,le.populated_orig_subj4_fein_pcnt,le.populated_orig_subj5_first_name_pcnt,le.populated_orig_subj5_middle_name_pcnt,le.populated_orig_subj5_last_name_pcnt,le.populated_orig_subj5_suffix_name_pcnt,le.populated_orig_subj5_full_name_pcnt,le.populated_orig_subj5_ssn_pcnt,le.populated_orig_subj5_dob_pcnt,le.populated_orig_subj5_dl_num_pcnt,le.populated_orig_subj5_dl_state_pcnt,le.populated_orig_subj5_former_last_name_pcnt,le.populated_orig_subj5_address_addressline1_pcnt,le.populated_orig_subj5_address_addressline2_pcnt,le.populated_orig_subj5_address_prim_range_pcnt,le.populated_orig_subj5_address_predir_pcnt,le.populated_orig_subj5_address_prim_name_pcnt,le.populated_orig_subj5_address_suffix_pcnt,le.populated_orig_subj5_address_postdir_pcnt,le.populated_orig_subj5_address_unit_desig_pcnt,le.populated_orig_subj5_address_sec_range_pcnt,le.populated_orig_subj5_address_city_pcnt,le.populated_orig_subj5_address_st_pcnt,le.populated_orig_subj5_address_z5_pcnt,le.populated_orig_subj5_address_z4_pcnt,le.populated_orig_subj5_phone_pcnt,le.populated_orig_subj5_work_phone_pcnt,le.populated_orig_subj5_business_title_pcnt,le.populated_orig_subj5_email_pcnt,le.populated_orig_subj5_company_name_pcnt,le.populated_orig_subj5_fein_pcnt,le.populated_orig_subj6_first_name_pcnt,le.populated_orig_subj6_middle_name_pcnt,le.populated_orig_subj6_last_name_pcnt,le.populated_orig_subj6_suffix_name_pcnt,le.populated_orig_subj6_full_name_pcnt,le.populated_orig_subj6_ssn_pcnt,le.populated_orig_subj6_dob_pcnt,le.populated_orig_subj6_dl_num_pcnt,le.populated_orig_subj6_dl_state_pcnt,le.populated_orig_subj6_former_last_name_pcnt,le.populated_orig_subj6_address_addressline1_pcnt,le.populated_orig_subj6_address_addressline2_pcnt,le.populated_orig_subj6_address_prim_range_pcnt,le.populated_orig_subj6_address_predir_pcnt,le.populated_orig_subj6_address_prim_name_pcnt,le.populated_orig_subj6_address_suffix_pcnt,le.populated_orig_subj6_address_postdir_pcnt,le.populated_orig_subj6_address_unit_desig_pcnt,le.populated_orig_subj6_address_sec_range_pcnt,le.populated_orig_subj6_address_city_pcnt,le.populated_orig_subj6_address_st_pcnt,le.populated_orig_subj6_address_z5_pcnt,le.populated_orig_subj6_address_z4_pcnt,le.populated_orig_subj6_phone_pcnt,le.populated_orig_subj6_work_phone_pcnt,le.populated_orig_subj6_business_title_pcnt,le.populated_orig_subj6_email_pcnt,le.populated_orig_subj6_company_name_pcnt,le.populated_orig_subj6_fein_pcnt,le.populated_orig_subj7_first_name_pcnt,le.populated_orig_subj7_middle_name_pcnt,le.populated_orig_subj7_last_name_pcnt,le.populated_orig_subj7_suffix_name_pcnt,le.populated_orig_subj7_full_name_pcnt,le.populated_orig_subj7_ssn_pcnt,le.populated_orig_subj7_dob_pcnt,le.populated_orig_subj7_dl_num_pcnt,le.populated_orig_subj7_dl_state_pcnt,le.populated_orig_subj7_former_last_name_pcnt,le.populated_orig_subj7_address_addressline1_pcnt,le.populated_orig_subj7_address_addressline2_pcnt,le.populated_orig_subj7_address_prim_range_pcnt,le.populated_orig_subj7_address_predir_pcnt,le.populated_orig_subj7_address_prim_name_pcnt,le.populated_orig_subj7_address_suffix_pcnt,le.populated_orig_subj7_address_postdir_pcnt,le.populated_orig_subj7_address_unit_desig_pcnt,le.populated_orig_subj7_address_sec_range_pcnt,le.populated_orig_subj7_address_city_pcnt,le.populated_orig_subj7_address_st_pcnt,le.populated_orig_subj7_address_z5_pcnt,le.populated_orig_subj7_address_z4_pcnt,le.populated_orig_subj7_phone_pcnt,le.populated_orig_subj7_work_phone_pcnt,le.populated_orig_subj7_business_title_pcnt,le.populated_orig_subj7_email_pcnt,le.populated_orig_subj7_company_name_pcnt,le.populated_orig_subj7_fein_pcnt,le.populated_orig_subj8_first_name_pcnt,le.populated_orig_subj8_middle_name_pcnt,le.populated_orig_subj8_last_name_pcnt,le.populated_orig_subj8_suffix_name_pcnt,le.populated_orig_subj8_full_name_pcnt,le.populated_orig_subj8_ssn_pcnt,le.populated_orig_subj8_dob_pcnt,le.populated_orig_subj8_dl_num_pcnt,le.populated_orig_subj8_dl_state_pcnt,le.populated_orig_subj8_former_last_name_pcnt,le.populated_orig_subj8_address_addressline1_pcnt,le.populated_orig_subj8_address_addressline2_pcnt,le.populated_orig_subj8_address_prim_range_pcnt,le.populated_orig_subj8_address_predir_pcnt,le.populated_orig_subj8_address_prim_name_pcnt,le.populated_orig_subj8_address_suffix_pcnt,le.populated_orig_subj8_address_postdir_pcnt,le.populated_orig_subj8_address_unit_desig_pcnt,le.populated_orig_subj8_address_sec_range_pcnt,le.populated_orig_subj8_address_city_pcnt,le.populated_orig_subj8_address_st_pcnt,le.populated_orig_subj8_address_z5_pcnt,le.populated_orig_subj8_address_z4_pcnt,le.populated_orig_subj8_phone_pcnt,le.populated_orig_subj8_work_phone_pcnt,le.populated_orig_subj8_business_title_pcnt,le.populated_orig_subj8_email_pcnt,le.populated_orig_subj8_company_name_pcnt,le.populated_orig_subj8_fein_pcnt,le.populated_orig_company_alternate_name_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_datetime_stamp,le.maxlength_orig_global_company_id,le.maxlength_orig_company_id,le.maxlength_orig_product_cd,le.maxlength_orig_method,le.maxlength_orig_vertical,le.maxlength_orig_function_name,le.maxlength_orig_transaction_type,le.maxlength_orig_login_history_id,le.maxlength_orig_job_id,le.maxlength_orig_sequence_number,le.maxlength_orig_first_name,le.maxlength_orig_middle_name,le.maxlength_orig_last_name,le.maxlength_orig_ssn,le.maxlength_orig_dob,le.maxlength_orig_dl_num,le.maxlength_orig_dl_state,le.maxlength_orig_address1_addressline1,le.maxlength_orig_address1_addressline2,le.maxlength_orig_address1_prim_range,le.maxlength_orig_address1_predir,le.maxlength_orig_address1_prim_name,le.maxlength_orig_address1_suffix,le.maxlength_orig_address1_postdir,le.maxlength_orig_address1_unit_desig,le.maxlength_orig_address1_sec_range,le.maxlength_orig_address1_city,le.maxlength_orig_address1_st,le.maxlength_orig_address1_z5,le.maxlength_orig_address1_z4,le.maxlength_orig_address2_addressline1,le.maxlength_orig_address2_addressline2,le.maxlength_orig_address2_prim_range,le.maxlength_orig_address2_predir,le.maxlength_orig_address2_prim_name,le.maxlength_orig_address2_suffix,le.maxlength_orig_address2_postdir,le.maxlength_orig_address2_unit_desig,le.maxlength_orig_address2_sec_range,le.maxlength_orig_address2_city,le.maxlength_orig_address2_st,le.maxlength_orig_address2_z5,le.maxlength_orig_address2_z4,le.maxlength_orig_bdid,le.maxlength_orig_bdl,le.maxlength_orig_did,le.maxlength_orig_company_name,le.maxlength_orig_fein,le.maxlength_orig_phone,le.maxlength_orig_work_phone,le.maxlength_orig_company_phone,le.maxlength_orig_reference_code,le.maxlength_orig_ip_address_initiated,le.maxlength_orig_ip_address_executed,le.maxlength_orig_charter_number,le.maxlength_orig_ucc_original_filing_number,le.maxlength_orig_email_address,le.maxlength_orig_domain_name,le.maxlength_orig_full_name,le.maxlength_orig_dl_purpose,le.maxlength_orig_glb_purpose,le.maxlength_orig_fcra_purpose,le.maxlength_orig_process_id,le.maxlength_orig_suffix_name,le.maxlength_orig_former_last_name,le.maxlength_orig_business_title,le.maxlength_orig_company_addressline1,le.maxlength_orig_company_addressline2,le.maxlength_orig_company_address_prim_range,le.maxlength_orig_company_address_predir,le.maxlength_orig_company_address_prim_name,le.maxlength_orig_company_address_suffix,le.maxlength_orig_company_address_postdir,le.maxlength_orig_company_address_unit_desig,le.maxlength_orig_company_address_sec_range,le.maxlength_orig_company_address_city,le.maxlength_orig_company_address_st,le.maxlength_orig_company_address_zip5,le.maxlength_orig_company_address_zip4,le.maxlength_orig_company_fax_number,le.maxlength_orig_company_start_date,le.maxlength_orig_company_years_in_business,le.maxlength_orig_company_sic_code,le.maxlength_orig_company_naic_code,le.maxlength_orig_company_structure,le.maxlength_orig_company_yearly_revenue,le.maxlength_orig_subj2_first_name,le.maxlength_orig_subj2_middle_name,le.maxlength_orig_subj2_last_name,le.maxlength_orig_subj2_suffix_name,le.maxlength_orig_subj2_full_name,le.maxlength_orig_subj2_ssn,le.maxlength_orig_subj2_dob,le.maxlength_orig_subj2_dl_num,le.maxlength_orig_subj2_dl_state,le.maxlength_orig_subj2_former_last_name,le.maxlength_orig_subj2_address_addressline1,le.maxlength_orig_subj2_address_addressline2,le.maxlength_orig_subj2_address_prim_range,le.maxlength_orig_subj2_address_predir,le.maxlength_orig_subj2_address_prim_name,le.maxlength_orig_subj2_address_suffix,le.maxlength_orig_subj2_address_postdir,le.maxlength_orig_subj2_address_unit_desig,le.maxlength_orig_subj2_address_sec_range,le.maxlength_orig_subj2_address_city,le.maxlength_orig_subj2_address_st,le.maxlength_orig_subj2_address_z5,le.maxlength_orig_subj2_address_z4,le.maxlength_orig_subj2_phone,le.maxlength_orig_subj2_work_phone,le.maxlength_orig_subj2_business_title,le.maxlength_orig_subj3_first_name,le.maxlength_orig_subj3_middle_name,le.maxlength_orig_subj3_last_name,le.maxlength_orig_subj3_suffix_name,le.maxlength_orig_subj3_full_name,le.maxlength_orig_subj3_ssn,le.maxlength_orig_subj3_dob,le.maxlength_orig_subj3_dl_num,le.maxlength_orig_subj3_dl_state,le.maxlength_orig_subj3_former_last_name,le.maxlength_orig_subj3_address_addressline1,le.maxlength_orig_subj3_address_addressline2,le.maxlength_orig_subj3_address_prim_range,le.maxlength_orig_subj3_address_predir,le.maxlength_orig_subj3_address_prim_name,le.maxlength_orig_subj3_address_suffix,le.maxlength_orig_subj3_address_postdir,le.maxlength_orig_subj3_address_unit_desig,le.maxlength_orig_subj3_address_sec_range,le.maxlength_orig_subj3_address_city,le.maxlength_orig_subj3_address_st,le.maxlength_orig_subj3_address_z5,le.maxlength_orig_subj3_address_z4,le.maxlength_orig_subj3_phone,le.maxlength_orig_subj3_work_phone,le.maxlength_orig_subj3_business_title,le.maxlength_orig_email,le.maxlength_orig_subj2_email,le.maxlength_orig_subj2_company_name,le.maxlength_orig_subj2_fein,le.maxlength_orig_subj3_email,le.maxlength_orig_subj3_company_name,le.maxlength_orig_subj3_fein,le.maxlength_orig_subj4_first_name,le.maxlength_orig_subj4_middle_name,le.maxlength_orig_subj4_last_name,le.maxlength_orig_subj4_suffix_name,le.maxlength_orig_subj4_full_name,le.maxlength_orig_subj4_ssn,le.maxlength_orig_subj4_dob,le.maxlength_orig_subj4_dl_num,le.maxlength_orig_subj4_dl_state,le.maxlength_orig_subj4_former_last_name,le.maxlength_orig_subj4_address_addressline1,le.maxlength_orig_subj4_address_addressline2,le.maxlength_orig_subj4_address_prim_range,le.maxlength_orig_subj4_address_predir,le.maxlength_orig_subj4_address_prim_name,le.maxlength_orig_subj4_address_suffix,le.maxlength_orig_subj4_address_postdir,le.maxlength_orig_subj4_address_unit_desig,le.maxlength_orig_subj4_address_sec_range,le.maxlength_orig_subj4_address_city,le.maxlength_orig_subj4_address_st,le.maxlength_orig_subj4_address_z5,le.maxlength_orig_subj4_address_z4,le.maxlength_orig_subj4_phone,le.maxlength_orig_subj4_work_phone,le.maxlength_orig_subj4_business_title,le.maxlength_orig_subj4_email,le.maxlength_orig_subj4_company_name,le.maxlength_orig_subj4_fein,le.maxlength_orig_subj5_first_name,le.maxlength_orig_subj5_middle_name,le.maxlength_orig_subj5_last_name,le.maxlength_orig_subj5_suffix_name,le.maxlength_orig_subj5_full_name,le.maxlength_orig_subj5_ssn,le.maxlength_orig_subj5_dob,le.maxlength_orig_subj5_dl_num,le.maxlength_orig_subj5_dl_state,le.maxlength_orig_subj5_former_last_name,le.maxlength_orig_subj5_address_addressline1,le.maxlength_orig_subj5_address_addressline2,le.maxlength_orig_subj5_address_prim_range,le.maxlength_orig_subj5_address_predir,le.maxlength_orig_subj5_address_prim_name,le.maxlength_orig_subj5_address_suffix,le.maxlength_orig_subj5_address_postdir,le.maxlength_orig_subj5_address_unit_desig,le.maxlength_orig_subj5_address_sec_range,le.maxlength_orig_subj5_address_city,le.maxlength_orig_subj5_address_st,le.maxlength_orig_subj5_address_z5,le.maxlength_orig_subj5_address_z4,le.maxlength_orig_subj5_phone,le.maxlength_orig_subj5_work_phone,le.maxlength_orig_subj5_business_title,le.maxlength_orig_subj5_email,le.maxlength_orig_subj5_company_name,le.maxlength_orig_subj5_fein,le.maxlength_orig_subj6_first_name,le.maxlength_orig_subj6_middle_name,le.maxlength_orig_subj6_last_name,le.maxlength_orig_subj6_suffix_name,le.maxlength_orig_subj6_full_name,le.maxlength_orig_subj6_ssn,le.maxlength_orig_subj6_dob,le.maxlength_orig_subj6_dl_num,le.maxlength_orig_subj6_dl_state,le.maxlength_orig_subj6_former_last_name,le.maxlength_orig_subj6_address_addressline1,le.maxlength_orig_subj6_address_addressline2,le.maxlength_orig_subj6_address_prim_range,le.maxlength_orig_subj6_address_predir,le.maxlength_orig_subj6_address_prim_name,le.maxlength_orig_subj6_address_suffix,le.maxlength_orig_subj6_address_postdir,le.maxlength_orig_subj6_address_unit_desig,le.maxlength_orig_subj6_address_sec_range,le.maxlength_orig_subj6_address_city,le.maxlength_orig_subj6_address_st,le.maxlength_orig_subj6_address_z5,le.maxlength_orig_subj6_address_z4,le.maxlength_orig_subj6_phone,le.maxlength_orig_subj6_work_phone,le.maxlength_orig_subj6_business_title,le.maxlength_orig_subj6_email,le.maxlength_orig_subj6_company_name,le.maxlength_orig_subj6_fein,le.maxlength_orig_subj7_first_name,le.maxlength_orig_subj7_middle_name,le.maxlength_orig_subj7_last_name,le.maxlength_orig_subj7_suffix_name,le.maxlength_orig_subj7_full_name,le.maxlength_orig_subj7_ssn,le.maxlength_orig_subj7_dob,le.maxlength_orig_subj7_dl_num,le.maxlength_orig_subj7_dl_state,le.maxlength_orig_subj7_former_last_name,le.maxlength_orig_subj7_address_addressline1,le.maxlength_orig_subj7_address_addressline2,le.maxlength_orig_subj7_address_prim_range,le.maxlength_orig_subj7_address_predir,le.maxlength_orig_subj7_address_prim_name,le.maxlength_orig_subj7_address_suffix,le.maxlength_orig_subj7_address_postdir,le.maxlength_orig_subj7_address_unit_desig,le.maxlength_orig_subj7_address_sec_range,le.maxlength_orig_subj7_address_city,le.maxlength_orig_subj7_address_st,le.maxlength_orig_subj7_address_z5,le.maxlength_orig_subj7_address_z4,le.maxlength_orig_subj7_phone,le.maxlength_orig_subj7_work_phone,le.maxlength_orig_subj7_business_title,le.maxlength_orig_subj7_email,le.maxlength_orig_subj7_company_name,le.maxlength_orig_subj7_fein,le.maxlength_orig_subj8_first_name,le.maxlength_orig_subj8_middle_name,le.maxlength_orig_subj8_last_name,le.maxlength_orig_subj8_suffix_name,le.maxlength_orig_subj8_full_name,le.maxlength_orig_subj8_ssn,le.maxlength_orig_subj8_dob,le.maxlength_orig_subj8_dl_num,le.maxlength_orig_subj8_dl_state,le.maxlength_orig_subj8_former_last_name,le.maxlength_orig_subj8_address_addressline1,le.maxlength_orig_subj8_address_addressline2,le.maxlength_orig_subj8_address_prim_range,le.maxlength_orig_subj8_address_predir,le.maxlength_orig_subj8_address_prim_name,le.maxlength_orig_subj8_address_suffix,le.maxlength_orig_subj8_address_postdir,le.maxlength_orig_subj8_address_unit_desig,le.maxlength_orig_subj8_address_sec_range,le.maxlength_orig_subj8_address_city,le.maxlength_orig_subj8_address_st,le.maxlength_orig_subj8_address_z5,le.maxlength_orig_subj8_address_z4,le.maxlength_orig_subj8_phone,le.maxlength_orig_subj8_work_phone,le.maxlength_orig_subj8_business_title,le.maxlength_orig_subj8_email,le.maxlength_orig_subj8_company_name,le.maxlength_orig_subj8_fein,le.maxlength_orig_company_alternate_name);
  SELF.avelength := CHOOSE(C,le.avelength_orig_datetime_stamp,le.avelength_orig_global_company_id,le.avelength_orig_company_id,le.avelength_orig_product_cd,le.avelength_orig_method,le.avelength_orig_vertical,le.avelength_orig_function_name,le.avelength_orig_transaction_type,le.avelength_orig_login_history_id,le.avelength_orig_job_id,le.avelength_orig_sequence_number,le.avelength_orig_first_name,le.avelength_orig_middle_name,le.avelength_orig_last_name,le.avelength_orig_ssn,le.avelength_orig_dob,le.avelength_orig_dl_num,le.avelength_orig_dl_state,le.avelength_orig_address1_addressline1,le.avelength_orig_address1_addressline2,le.avelength_orig_address1_prim_range,le.avelength_orig_address1_predir,le.avelength_orig_address1_prim_name,le.avelength_orig_address1_suffix,le.avelength_orig_address1_postdir,le.avelength_orig_address1_unit_desig,le.avelength_orig_address1_sec_range,le.avelength_orig_address1_city,le.avelength_orig_address1_st,le.avelength_orig_address1_z5,le.avelength_orig_address1_z4,le.avelength_orig_address2_addressline1,le.avelength_orig_address2_addressline2,le.avelength_orig_address2_prim_range,le.avelength_orig_address2_predir,le.avelength_orig_address2_prim_name,le.avelength_orig_address2_suffix,le.avelength_orig_address2_postdir,le.avelength_orig_address2_unit_desig,le.avelength_orig_address2_sec_range,le.avelength_orig_address2_city,le.avelength_orig_address2_st,le.avelength_orig_address2_z5,le.avelength_orig_address2_z4,le.avelength_orig_bdid,le.avelength_orig_bdl,le.avelength_orig_did,le.avelength_orig_company_name,le.avelength_orig_fein,le.avelength_orig_phone,le.avelength_orig_work_phone,le.avelength_orig_company_phone,le.avelength_orig_reference_code,le.avelength_orig_ip_address_initiated,le.avelength_orig_ip_address_executed,le.avelength_orig_charter_number,le.avelength_orig_ucc_original_filing_number,le.avelength_orig_email_address,le.avelength_orig_domain_name,le.avelength_orig_full_name,le.avelength_orig_dl_purpose,le.avelength_orig_glb_purpose,le.avelength_orig_fcra_purpose,le.avelength_orig_process_id,le.avelength_orig_suffix_name,le.avelength_orig_former_last_name,le.avelength_orig_business_title,le.avelength_orig_company_addressline1,le.avelength_orig_company_addressline2,le.avelength_orig_company_address_prim_range,le.avelength_orig_company_address_predir,le.avelength_orig_company_address_prim_name,le.avelength_orig_company_address_suffix,le.avelength_orig_company_address_postdir,le.avelength_orig_company_address_unit_desig,le.avelength_orig_company_address_sec_range,le.avelength_orig_company_address_city,le.avelength_orig_company_address_st,le.avelength_orig_company_address_zip5,le.avelength_orig_company_address_zip4,le.avelength_orig_company_fax_number,le.avelength_orig_company_start_date,le.avelength_orig_company_years_in_business,le.avelength_orig_company_sic_code,le.avelength_orig_company_naic_code,le.avelength_orig_company_structure,le.avelength_orig_company_yearly_revenue,le.avelength_orig_subj2_first_name,le.avelength_orig_subj2_middle_name,le.avelength_orig_subj2_last_name,le.avelength_orig_subj2_suffix_name,le.avelength_orig_subj2_full_name,le.avelength_orig_subj2_ssn,le.avelength_orig_subj2_dob,le.avelength_orig_subj2_dl_num,le.avelength_orig_subj2_dl_state,le.avelength_orig_subj2_former_last_name,le.avelength_orig_subj2_address_addressline1,le.avelength_orig_subj2_address_addressline2,le.avelength_orig_subj2_address_prim_range,le.avelength_orig_subj2_address_predir,le.avelength_orig_subj2_address_prim_name,le.avelength_orig_subj2_address_suffix,le.avelength_orig_subj2_address_postdir,le.avelength_orig_subj2_address_unit_desig,le.avelength_orig_subj2_address_sec_range,le.avelength_orig_subj2_address_city,le.avelength_orig_subj2_address_st,le.avelength_orig_subj2_address_z5,le.avelength_orig_subj2_address_z4,le.avelength_orig_subj2_phone,le.avelength_orig_subj2_work_phone,le.avelength_orig_subj2_business_title,le.avelength_orig_subj3_first_name,le.avelength_orig_subj3_middle_name,le.avelength_orig_subj3_last_name,le.avelength_orig_subj3_suffix_name,le.avelength_orig_subj3_full_name,le.avelength_orig_subj3_ssn,le.avelength_orig_subj3_dob,le.avelength_orig_subj3_dl_num,le.avelength_orig_subj3_dl_state,le.avelength_orig_subj3_former_last_name,le.avelength_orig_subj3_address_addressline1,le.avelength_orig_subj3_address_addressline2,le.avelength_orig_subj3_address_prim_range,le.avelength_orig_subj3_address_predir,le.avelength_orig_subj3_address_prim_name,le.avelength_orig_subj3_address_suffix,le.avelength_orig_subj3_address_postdir,le.avelength_orig_subj3_address_unit_desig,le.avelength_orig_subj3_address_sec_range,le.avelength_orig_subj3_address_city,le.avelength_orig_subj3_address_st,le.avelength_orig_subj3_address_z5,le.avelength_orig_subj3_address_z4,le.avelength_orig_subj3_phone,le.avelength_orig_subj3_work_phone,le.avelength_orig_subj3_business_title,le.avelength_orig_email,le.avelength_orig_subj2_email,le.avelength_orig_subj2_company_name,le.avelength_orig_subj2_fein,le.avelength_orig_subj3_email,le.avelength_orig_subj3_company_name,le.avelength_orig_subj3_fein,le.avelength_orig_subj4_first_name,le.avelength_orig_subj4_middle_name,le.avelength_orig_subj4_last_name,le.avelength_orig_subj4_suffix_name,le.avelength_orig_subj4_full_name,le.avelength_orig_subj4_ssn,le.avelength_orig_subj4_dob,le.avelength_orig_subj4_dl_num,le.avelength_orig_subj4_dl_state,le.avelength_orig_subj4_former_last_name,le.avelength_orig_subj4_address_addressline1,le.avelength_orig_subj4_address_addressline2,le.avelength_orig_subj4_address_prim_range,le.avelength_orig_subj4_address_predir,le.avelength_orig_subj4_address_prim_name,le.avelength_orig_subj4_address_suffix,le.avelength_orig_subj4_address_postdir,le.avelength_orig_subj4_address_unit_desig,le.avelength_orig_subj4_address_sec_range,le.avelength_orig_subj4_address_city,le.avelength_orig_subj4_address_st,le.avelength_orig_subj4_address_z5,le.avelength_orig_subj4_address_z4,le.avelength_orig_subj4_phone,le.avelength_orig_subj4_work_phone,le.avelength_orig_subj4_business_title,le.avelength_orig_subj4_email,le.avelength_orig_subj4_company_name,le.avelength_orig_subj4_fein,le.avelength_orig_subj5_first_name,le.avelength_orig_subj5_middle_name,le.avelength_orig_subj5_last_name,le.avelength_orig_subj5_suffix_name,le.avelength_orig_subj5_full_name,le.avelength_orig_subj5_ssn,le.avelength_orig_subj5_dob,le.avelength_orig_subj5_dl_num,le.avelength_orig_subj5_dl_state,le.avelength_orig_subj5_former_last_name,le.avelength_orig_subj5_address_addressline1,le.avelength_orig_subj5_address_addressline2,le.avelength_orig_subj5_address_prim_range,le.avelength_orig_subj5_address_predir,le.avelength_orig_subj5_address_prim_name,le.avelength_orig_subj5_address_suffix,le.avelength_orig_subj5_address_postdir,le.avelength_orig_subj5_address_unit_desig,le.avelength_orig_subj5_address_sec_range,le.avelength_orig_subj5_address_city,le.avelength_orig_subj5_address_st,le.avelength_orig_subj5_address_z5,le.avelength_orig_subj5_address_z4,le.avelength_orig_subj5_phone,le.avelength_orig_subj5_work_phone,le.avelength_orig_subj5_business_title,le.avelength_orig_subj5_email,le.avelength_orig_subj5_company_name,le.avelength_orig_subj5_fein,le.avelength_orig_subj6_first_name,le.avelength_orig_subj6_middle_name,le.avelength_orig_subj6_last_name,le.avelength_orig_subj6_suffix_name,le.avelength_orig_subj6_full_name,le.avelength_orig_subj6_ssn,le.avelength_orig_subj6_dob,le.avelength_orig_subj6_dl_num,le.avelength_orig_subj6_dl_state,le.avelength_orig_subj6_former_last_name,le.avelength_orig_subj6_address_addressline1,le.avelength_orig_subj6_address_addressline2,le.avelength_orig_subj6_address_prim_range,le.avelength_orig_subj6_address_predir,le.avelength_orig_subj6_address_prim_name,le.avelength_orig_subj6_address_suffix,le.avelength_orig_subj6_address_postdir,le.avelength_orig_subj6_address_unit_desig,le.avelength_orig_subj6_address_sec_range,le.avelength_orig_subj6_address_city,le.avelength_orig_subj6_address_st,le.avelength_orig_subj6_address_z5,le.avelength_orig_subj6_address_z4,le.avelength_orig_subj6_phone,le.avelength_orig_subj6_work_phone,le.avelength_orig_subj6_business_title,le.avelength_orig_subj6_email,le.avelength_orig_subj6_company_name,le.avelength_orig_subj6_fein,le.avelength_orig_subj7_first_name,le.avelength_orig_subj7_middle_name,le.avelength_orig_subj7_last_name,le.avelength_orig_subj7_suffix_name,le.avelength_orig_subj7_full_name,le.avelength_orig_subj7_ssn,le.avelength_orig_subj7_dob,le.avelength_orig_subj7_dl_num,le.avelength_orig_subj7_dl_state,le.avelength_orig_subj7_former_last_name,le.avelength_orig_subj7_address_addressline1,le.avelength_orig_subj7_address_addressline2,le.avelength_orig_subj7_address_prim_range,le.avelength_orig_subj7_address_predir,le.avelength_orig_subj7_address_prim_name,le.avelength_orig_subj7_address_suffix,le.avelength_orig_subj7_address_postdir,le.avelength_orig_subj7_address_unit_desig,le.avelength_orig_subj7_address_sec_range,le.avelength_orig_subj7_address_city,le.avelength_orig_subj7_address_st,le.avelength_orig_subj7_address_z5,le.avelength_orig_subj7_address_z4,le.avelength_orig_subj7_phone,le.avelength_orig_subj7_work_phone,le.avelength_orig_subj7_business_title,le.avelength_orig_subj7_email,le.avelength_orig_subj7_company_name,le.avelength_orig_subj7_fein,le.avelength_orig_subj8_first_name,le.avelength_orig_subj8_middle_name,le.avelength_orig_subj8_last_name,le.avelength_orig_subj8_suffix_name,le.avelength_orig_subj8_full_name,le.avelength_orig_subj8_ssn,le.avelength_orig_subj8_dob,le.avelength_orig_subj8_dl_num,le.avelength_orig_subj8_dl_state,le.avelength_orig_subj8_former_last_name,le.avelength_orig_subj8_address_addressline1,le.avelength_orig_subj8_address_addressline2,le.avelength_orig_subj8_address_prim_range,le.avelength_orig_subj8_address_predir,le.avelength_orig_subj8_address_prim_name,le.avelength_orig_subj8_address_suffix,le.avelength_orig_subj8_address_postdir,le.avelength_orig_subj8_address_unit_desig,le.avelength_orig_subj8_address_sec_range,le.avelength_orig_subj8_address_city,le.avelength_orig_subj8_address_st,le.avelength_orig_subj8_address_z5,le.avelength_orig_subj8_address_z4,le.avelength_orig_subj8_phone,le.avelength_orig_subj8_work_phone,le.avelength_orig_subj8_business_title,le.avelength_orig_subj8_email,le.avelength_orig_subj8_company_name,le.avelength_orig_subj8_fein,le.avelength_orig_company_alternate_name);
END;
EXPORT invSummary := NORMALIZE(summary0, 292, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.orig_datetime_stamp),TRIM((SALT39.StrType)le.orig_global_company_id),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_product_cd),TRIM((SALT39.StrType)le.orig_method),TRIM((SALT39.StrType)le.orig_vertical),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_transaction_type),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_job_id),TRIM((SALT39.StrType)le.orig_sequence_number),TRIM((SALT39.StrType)le.orig_first_name),TRIM((SALT39.StrType)le.orig_middle_name),TRIM((SALT39.StrType)le.orig_last_name),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dl_num),TRIM((SALT39.StrType)le.orig_dl_state),TRIM((SALT39.StrType)le.orig_address1_addressline1),TRIM((SALT39.StrType)le.orig_address1_addressline2),TRIM((SALT39.StrType)le.orig_address1_prim_range),TRIM((SALT39.StrType)le.orig_address1_predir),TRIM((SALT39.StrType)le.orig_address1_prim_name),TRIM((SALT39.StrType)le.orig_address1_suffix),TRIM((SALT39.StrType)le.orig_address1_postdir),TRIM((SALT39.StrType)le.orig_address1_unit_desig),TRIM((SALT39.StrType)le.orig_address1_sec_range),TRIM((SALT39.StrType)le.orig_address1_city),TRIM((SALT39.StrType)le.orig_address1_st),TRIM((SALT39.StrType)le.orig_address1_z5),TRIM((SALT39.StrType)le.orig_address1_z4),TRIM((SALT39.StrType)le.orig_address2_addressline1),TRIM((SALT39.StrType)le.orig_address2_addressline2),TRIM((SALT39.StrType)le.orig_address2_prim_range),TRIM((SALT39.StrType)le.orig_address2_predir),TRIM((SALT39.StrType)le.orig_address2_prim_name),TRIM((SALT39.StrType)le.orig_address2_suffix),TRIM((SALT39.StrType)le.orig_address2_postdir),TRIM((SALT39.StrType)le.orig_address2_unit_desig),TRIM((SALT39.StrType)le.orig_address2_sec_range),TRIM((SALT39.StrType)le.orig_address2_city),TRIM((SALT39.StrType)le.orig_address2_st),TRIM((SALT39.StrType)le.orig_address2_z5),TRIM((SALT39.StrType)le.orig_address2_z4),TRIM((SALT39.StrType)le.orig_bdid),TRIM((SALT39.StrType)le.orig_bdl),TRIM((SALT39.StrType)le.orig_did),TRIM((SALT39.StrType)le.orig_company_name),TRIM((SALT39.StrType)le.orig_fein),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_work_phone),TRIM((SALT39.StrType)le.orig_company_phone),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_ip_address_initiated),TRIM((SALT39.StrType)le.orig_ip_address_executed),TRIM((SALT39.StrType)le.orig_charter_number),TRIM((SALT39.StrType)le.orig_ucc_original_filing_number),TRIM((SALT39.StrType)le.orig_email_address),TRIM((SALT39.StrType)le.orig_domain_name),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_dl_purpose),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_process_id),TRIM((SALT39.StrType)le.orig_suffix_name),TRIM((SALT39.StrType)le.orig_former_last_name),TRIM((SALT39.StrType)le.orig_business_title),TRIM((SALT39.StrType)le.orig_company_addressline1),TRIM((SALT39.StrType)le.orig_company_addressline2),TRIM((SALT39.StrType)le.orig_company_address_prim_range),TRIM((SALT39.StrType)le.orig_company_address_predir),TRIM((SALT39.StrType)le.orig_company_address_prim_name),TRIM((SALT39.StrType)le.orig_company_address_suffix),TRIM((SALT39.StrType)le.orig_company_address_postdir),TRIM((SALT39.StrType)le.orig_company_address_unit_desig),TRIM((SALT39.StrType)le.orig_company_address_sec_range),TRIM((SALT39.StrType)le.orig_company_address_city),TRIM((SALT39.StrType)le.orig_company_address_st),TRIM((SALT39.StrType)le.orig_company_address_zip5),TRIM((SALT39.StrType)le.orig_company_address_zip4),TRIM((SALT39.StrType)le.orig_company_fax_number),TRIM((SALT39.StrType)le.orig_company_start_date),TRIM((SALT39.StrType)le.orig_company_years_in_business),TRIM((SALT39.StrType)le.orig_company_sic_code),TRIM((SALT39.StrType)le.orig_company_naic_code),TRIM((SALT39.StrType)le.orig_company_structure),TRIM((SALT39.StrType)le.orig_company_yearly_revenue),TRIM((SALT39.StrType)le.orig_subj2_first_name),TRIM((SALT39.StrType)le.orig_subj2_middle_name),TRIM((SALT39.StrType)le.orig_subj2_last_name),TRIM((SALT39.StrType)le.orig_subj2_suffix_name),TRIM((SALT39.StrType)le.orig_subj2_full_name),TRIM((SALT39.StrType)le.orig_subj2_ssn),TRIM((SALT39.StrType)le.orig_subj2_dob),TRIM((SALT39.StrType)le.orig_subj2_dl_num),TRIM((SALT39.StrType)le.orig_subj2_dl_state),TRIM((SALT39.StrType)le.orig_subj2_former_last_name),TRIM((SALT39.StrType)le.orig_subj2_address_addressline1),TRIM((SALT39.StrType)le.orig_subj2_address_addressline2),TRIM((SALT39.StrType)le.orig_subj2_address_prim_range),TRIM((SALT39.StrType)le.orig_subj2_address_predir),TRIM((SALT39.StrType)le.orig_subj2_address_prim_name),TRIM((SALT39.StrType)le.orig_subj2_address_suffix),TRIM((SALT39.StrType)le.orig_subj2_address_postdir),TRIM((SALT39.StrType)le.orig_subj2_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj2_address_sec_range),TRIM((SALT39.StrType)le.orig_subj2_address_city),TRIM((SALT39.StrType)le.orig_subj2_address_st),TRIM((SALT39.StrType)le.orig_subj2_address_z5),TRIM((SALT39.StrType)le.orig_subj2_address_z4),TRIM((SALT39.StrType)le.orig_subj2_phone),TRIM((SALT39.StrType)le.orig_subj2_work_phone),TRIM((SALT39.StrType)le.orig_subj2_business_title),TRIM((SALT39.StrType)le.orig_subj3_first_name),TRIM((SALT39.StrType)le.orig_subj3_middle_name),TRIM((SALT39.StrType)le.orig_subj3_last_name),TRIM((SALT39.StrType)le.orig_subj3_suffix_name),TRIM((SALT39.StrType)le.orig_subj3_full_name),TRIM((SALT39.StrType)le.orig_subj3_ssn),TRIM((SALT39.StrType)le.orig_subj3_dob),TRIM((SALT39.StrType)le.orig_subj3_dl_num),TRIM((SALT39.StrType)le.orig_subj3_dl_state),TRIM((SALT39.StrType)le.orig_subj3_former_last_name),TRIM((SALT39.StrType)le.orig_subj3_address_addressline1),TRIM((SALT39.StrType)le.orig_subj3_address_addressline2),TRIM((SALT39.StrType)le.orig_subj3_address_prim_range),TRIM((SALT39.StrType)le.orig_subj3_address_predir),TRIM((SALT39.StrType)le.orig_subj3_address_prim_name),TRIM((SALT39.StrType)le.orig_subj3_address_suffix),TRIM((SALT39.StrType)le.orig_subj3_address_postdir),TRIM((SALT39.StrType)le.orig_subj3_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj3_address_sec_range),TRIM((SALT39.StrType)le.orig_subj3_address_city),TRIM((SALT39.StrType)le.orig_subj3_address_st),TRIM((SALT39.StrType)le.orig_subj3_address_z5),TRIM((SALT39.StrType)le.orig_subj3_address_z4),TRIM((SALT39.StrType)le.orig_subj3_phone),TRIM((SALT39.StrType)le.orig_subj3_work_phone),TRIM((SALT39.StrType)le.orig_subj3_business_title),TRIM((SALT39.StrType)le.orig_email),TRIM((SALT39.StrType)le.orig_subj2_email),TRIM((SALT39.StrType)le.orig_subj2_company_name),TRIM((SALT39.StrType)le.orig_subj2_fein),TRIM((SALT39.StrType)le.orig_subj3_email),TRIM((SALT39.StrType)le.orig_subj3_company_name),TRIM((SALT39.StrType)le.orig_subj3_fein),TRIM((SALT39.StrType)le.orig_subj4_first_name),TRIM((SALT39.StrType)le.orig_subj4_middle_name),TRIM((SALT39.StrType)le.orig_subj4_last_name),TRIM((SALT39.StrType)le.orig_subj4_suffix_name),TRIM((SALT39.StrType)le.orig_subj4_full_name),TRIM((SALT39.StrType)le.orig_subj4_ssn),TRIM((SALT39.StrType)le.orig_subj4_dob),TRIM((SALT39.StrType)le.orig_subj4_dl_num),TRIM((SALT39.StrType)le.orig_subj4_dl_state),TRIM((SALT39.StrType)le.orig_subj4_former_last_name),TRIM((SALT39.StrType)le.orig_subj4_address_addressline1),TRIM((SALT39.StrType)le.orig_subj4_address_addressline2),TRIM((SALT39.StrType)le.orig_subj4_address_prim_range),TRIM((SALT39.StrType)le.orig_subj4_address_predir),TRIM((SALT39.StrType)le.orig_subj4_address_prim_name),TRIM((SALT39.StrType)le.orig_subj4_address_suffix),TRIM((SALT39.StrType)le.orig_subj4_address_postdir),TRIM((SALT39.StrType)le.orig_subj4_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj4_address_sec_range),TRIM((SALT39.StrType)le.orig_subj4_address_city),TRIM((SALT39.StrType)le.orig_subj4_address_st),TRIM((SALT39.StrType)le.orig_subj4_address_z5),TRIM((SALT39.StrType)le.orig_subj4_address_z4),TRIM((SALT39.StrType)le.orig_subj4_phone),TRIM((SALT39.StrType)le.orig_subj4_work_phone),TRIM((SALT39.StrType)le.orig_subj4_business_title),TRIM((SALT39.StrType)le.orig_subj4_email),TRIM((SALT39.StrType)le.orig_subj4_company_name),TRIM((SALT39.StrType)le.orig_subj4_fein),TRIM((SALT39.StrType)le.orig_subj5_first_name),TRIM((SALT39.StrType)le.orig_subj5_middle_name),TRIM((SALT39.StrType)le.orig_subj5_last_name),TRIM((SALT39.StrType)le.orig_subj5_suffix_name),TRIM((SALT39.StrType)le.orig_subj5_full_name),TRIM((SALT39.StrType)le.orig_subj5_ssn),TRIM((SALT39.StrType)le.orig_subj5_dob),TRIM((SALT39.StrType)le.orig_subj5_dl_num),TRIM((SALT39.StrType)le.orig_subj5_dl_state),TRIM((SALT39.StrType)le.orig_subj5_former_last_name),TRIM((SALT39.StrType)le.orig_subj5_address_addressline1),TRIM((SALT39.StrType)le.orig_subj5_address_addressline2),TRIM((SALT39.StrType)le.orig_subj5_address_prim_range),TRIM((SALT39.StrType)le.orig_subj5_address_predir),TRIM((SALT39.StrType)le.orig_subj5_address_prim_name),TRIM((SALT39.StrType)le.orig_subj5_address_suffix),TRIM((SALT39.StrType)le.orig_subj5_address_postdir),TRIM((SALT39.StrType)le.orig_subj5_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj5_address_sec_range),TRIM((SALT39.StrType)le.orig_subj5_address_city),TRIM((SALT39.StrType)le.orig_subj5_address_st),TRIM((SALT39.StrType)le.orig_subj5_address_z5),TRIM((SALT39.StrType)le.orig_subj5_address_z4),TRIM((SALT39.StrType)le.orig_subj5_phone),TRIM((SALT39.StrType)le.orig_subj5_work_phone),TRIM((SALT39.StrType)le.orig_subj5_business_title),TRIM((SALT39.StrType)le.orig_subj5_email),TRIM((SALT39.StrType)le.orig_subj5_company_name),TRIM((SALT39.StrType)le.orig_subj5_fein),TRIM((SALT39.StrType)le.orig_subj6_first_name),TRIM((SALT39.StrType)le.orig_subj6_middle_name),TRIM((SALT39.StrType)le.orig_subj6_last_name),TRIM((SALT39.StrType)le.orig_subj6_suffix_name),TRIM((SALT39.StrType)le.orig_subj6_full_name),TRIM((SALT39.StrType)le.orig_subj6_ssn),TRIM((SALT39.StrType)le.orig_subj6_dob),TRIM((SALT39.StrType)le.orig_subj6_dl_num),TRIM((SALT39.StrType)le.orig_subj6_dl_state),TRIM((SALT39.StrType)le.orig_subj6_former_last_name),TRIM((SALT39.StrType)le.orig_subj6_address_addressline1),TRIM((SALT39.StrType)le.orig_subj6_address_addressline2),TRIM((SALT39.StrType)le.orig_subj6_address_prim_range),TRIM((SALT39.StrType)le.orig_subj6_address_predir),TRIM((SALT39.StrType)le.orig_subj6_address_prim_name),TRIM((SALT39.StrType)le.orig_subj6_address_suffix),TRIM((SALT39.StrType)le.orig_subj6_address_postdir),TRIM((SALT39.StrType)le.orig_subj6_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj6_address_sec_range),TRIM((SALT39.StrType)le.orig_subj6_address_city),TRIM((SALT39.StrType)le.orig_subj6_address_st),TRIM((SALT39.StrType)le.orig_subj6_address_z5),TRIM((SALT39.StrType)le.orig_subj6_address_z4),TRIM((SALT39.StrType)le.orig_subj6_phone),TRIM((SALT39.StrType)le.orig_subj6_work_phone),TRIM((SALT39.StrType)le.orig_subj6_business_title),TRIM((SALT39.StrType)le.orig_subj6_email),TRIM((SALT39.StrType)le.orig_subj6_company_name),TRIM((SALT39.StrType)le.orig_subj6_fein),TRIM((SALT39.StrType)le.orig_subj7_first_name),TRIM((SALT39.StrType)le.orig_subj7_middle_name),TRIM((SALT39.StrType)le.orig_subj7_last_name),TRIM((SALT39.StrType)le.orig_subj7_suffix_name),TRIM((SALT39.StrType)le.orig_subj7_full_name),TRIM((SALT39.StrType)le.orig_subj7_ssn),TRIM((SALT39.StrType)le.orig_subj7_dob),TRIM((SALT39.StrType)le.orig_subj7_dl_num),TRIM((SALT39.StrType)le.orig_subj7_dl_state),TRIM((SALT39.StrType)le.orig_subj7_former_last_name),TRIM((SALT39.StrType)le.orig_subj7_address_addressline1),TRIM((SALT39.StrType)le.orig_subj7_address_addressline2),TRIM((SALT39.StrType)le.orig_subj7_address_prim_range),TRIM((SALT39.StrType)le.orig_subj7_address_predir),TRIM((SALT39.StrType)le.orig_subj7_address_prim_name),TRIM((SALT39.StrType)le.orig_subj7_address_suffix),TRIM((SALT39.StrType)le.orig_subj7_address_postdir),TRIM((SALT39.StrType)le.orig_subj7_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj7_address_sec_range),TRIM((SALT39.StrType)le.orig_subj7_address_city),TRIM((SALT39.StrType)le.orig_subj7_address_st),TRIM((SALT39.StrType)le.orig_subj7_address_z5),TRIM((SALT39.StrType)le.orig_subj7_address_z4),TRIM((SALT39.StrType)le.orig_subj7_phone),TRIM((SALT39.StrType)le.orig_subj7_work_phone),TRIM((SALT39.StrType)le.orig_subj7_business_title),TRIM((SALT39.StrType)le.orig_subj7_email),TRIM((SALT39.StrType)le.orig_subj7_company_name),TRIM((SALT39.StrType)le.orig_subj7_fein),TRIM((SALT39.StrType)le.orig_subj8_first_name),TRIM((SALT39.StrType)le.orig_subj8_middle_name),TRIM((SALT39.StrType)le.orig_subj8_last_name),TRIM((SALT39.StrType)le.orig_subj8_suffix_name),TRIM((SALT39.StrType)le.orig_subj8_full_name),TRIM((SALT39.StrType)le.orig_subj8_ssn),TRIM((SALT39.StrType)le.orig_subj8_dob),TRIM((SALT39.StrType)le.orig_subj8_dl_num),TRIM((SALT39.StrType)le.orig_subj8_dl_state),TRIM((SALT39.StrType)le.orig_subj8_former_last_name),TRIM((SALT39.StrType)le.orig_subj8_address_addressline1),TRIM((SALT39.StrType)le.orig_subj8_address_addressline2),TRIM((SALT39.StrType)le.orig_subj8_address_prim_range),TRIM((SALT39.StrType)le.orig_subj8_address_predir),TRIM((SALT39.StrType)le.orig_subj8_address_prim_name),TRIM((SALT39.StrType)le.orig_subj8_address_suffix),TRIM((SALT39.StrType)le.orig_subj8_address_postdir),TRIM((SALT39.StrType)le.orig_subj8_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj8_address_sec_range),TRIM((SALT39.StrType)le.orig_subj8_address_city),TRIM((SALT39.StrType)le.orig_subj8_address_st),TRIM((SALT39.StrType)le.orig_subj8_address_z5),TRIM((SALT39.StrType)le.orig_subj8_address_z4),TRIM((SALT39.StrType)le.orig_subj8_phone),TRIM((SALT39.StrType)le.orig_subj8_work_phone),TRIM((SALT39.StrType)le.orig_subj8_business_title),TRIM((SALT39.StrType)le.orig_subj8_email),TRIM((SALT39.StrType)le.orig_subj8_company_name),TRIM((SALT39.StrType)le.orig_subj8_fein),TRIM((SALT39.StrType)le.orig_company_alternate_name)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,292,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 292);
  SELF.FldNo2 := 1 + (C % 292);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.orig_datetime_stamp),TRIM((SALT39.StrType)le.orig_global_company_id),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_product_cd),TRIM((SALT39.StrType)le.orig_method),TRIM((SALT39.StrType)le.orig_vertical),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_transaction_type),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_job_id),TRIM((SALT39.StrType)le.orig_sequence_number),TRIM((SALT39.StrType)le.orig_first_name),TRIM((SALT39.StrType)le.orig_middle_name),TRIM((SALT39.StrType)le.orig_last_name),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dl_num),TRIM((SALT39.StrType)le.orig_dl_state),TRIM((SALT39.StrType)le.orig_address1_addressline1),TRIM((SALT39.StrType)le.orig_address1_addressline2),TRIM((SALT39.StrType)le.orig_address1_prim_range),TRIM((SALT39.StrType)le.orig_address1_predir),TRIM((SALT39.StrType)le.orig_address1_prim_name),TRIM((SALT39.StrType)le.orig_address1_suffix),TRIM((SALT39.StrType)le.orig_address1_postdir),TRIM((SALT39.StrType)le.orig_address1_unit_desig),TRIM((SALT39.StrType)le.orig_address1_sec_range),TRIM((SALT39.StrType)le.orig_address1_city),TRIM((SALT39.StrType)le.orig_address1_st),TRIM((SALT39.StrType)le.orig_address1_z5),TRIM((SALT39.StrType)le.orig_address1_z4),TRIM((SALT39.StrType)le.orig_address2_addressline1),TRIM((SALT39.StrType)le.orig_address2_addressline2),TRIM((SALT39.StrType)le.orig_address2_prim_range),TRIM((SALT39.StrType)le.orig_address2_predir),TRIM((SALT39.StrType)le.orig_address2_prim_name),TRIM((SALT39.StrType)le.orig_address2_suffix),TRIM((SALT39.StrType)le.orig_address2_postdir),TRIM((SALT39.StrType)le.orig_address2_unit_desig),TRIM((SALT39.StrType)le.orig_address2_sec_range),TRIM((SALT39.StrType)le.orig_address2_city),TRIM((SALT39.StrType)le.orig_address2_st),TRIM((SALT39.StrType)le.orig_address2_z5),TRIM((SALT39.StrType)le.orig_address2_z4),TRIM((SALT39.StrType)le.orig_bdid),TRIM((SALT39.StrType)le.orig_bdl),TRIM((SALT39.StrType)le.orig_did),TRIM((SALT39.StrType)le.orig_company_name),TRIM((SALT39.StrType)le.orig_fein),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_work_phone),TRIM((SALT39.StrType)le.orig_company_phone),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_ip_address_initiated),TRIM((SALT39.StrType)le.orig_ip_address_executed),TRIM((SALT39.StrType)le.orig_charter_number),TRIM((SALT39.StrType)le.orig_ucc_original_filing_number),TRIM((SALT39.StrType)le.orig_email_address),TRIM((SALT39.StrType)le.orig_domain_name),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_dl_purpose),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_process_id),TRIM((SALT39.StrType)le.orig_suffix_name),TRIM((SALT39.StrType)le.orig_former_last_name),TRIM((SALT39.StrType)le.orig_business_title),TRIM((SALT39.StrType)le.orig_company_addressline1),TRIM((SALT39.StrType)le.orig_company_addressline2),TRIM((SALT39.StrType)le.orig_company_address_prim_range),TRIM((SALT39.StrType)le.orig_company_address_predir),TRIM((SALT39.StrType)le.orig_company_address_prim_name),TRIM((SALT39.StrType)le.orig_company_address_suffix),TRIM((SALT39.StrType)le.orig_company_address_postdir),TRIM((SALT39.StrType)le.orig_company_address_unit_desig),TRIM((SALT39.StrType)le.orig_company_address_sec_range),TRIM((SALT39.StrType)le.orig_company_address_city),TRIM((SALT39.StrType)le.orig_company_address_st),TRIM((SALT39.StrType)le.orig_company_address_zip5),TRIM((SALT39.StrType)le.orig_company_address_zip4),TRIM((SALT39.StrType)le.orig_company_fax_number),TRIM((SALT39.StrType)le.orig_company_start_date),TRIM((SALT39.StrType)le.orig_company_years_in_business),TRIM((SALT39.StrType)le.orig_company_sic_code),TRIM((SALT39.StrType)le.orig_company_naic_code),TRIM((SALT39.StrType)le.orig_company_structure),TRIM((SALT39.StrType)le.orig_company_yearly_revenue),TRIM((SALT39.StrType)le.orig_subj2_first_name),TRIM((SALT39.StrType)le.orig_subj2_middle_name),TRIM((SALT39.StrType)le.orig_subj2_last_name),TRIM((SALT39.StrType)le.orig_subj2_suffix_name),TRIM((SALT39.StrType)le.orig_subj2_full_name),TRIM((SALT39.StrType)le.orig_subj2_ssn),TRIM((SALT39.StrType)le.orig_subj2_dob),TRIM((SALT39.StrType)le.orig_subj2_dl_num),TRIM((SALT39.StrType)le.orig_subj2_dl_state),TRIM((SALT39.StrType)le.orig_subj2_former_last_name),TRIM((SALT39.StrType)le.orig_subj2_address_addressline1),TRIM((SALT39.StrType)le.orig_subj2_address_addressline2),TRIM((SALT39.StrType)le.orig_subj2_address_prim_range),TRIM((SALT39.StrType)le.orig_subj2_address_predir),TRIM((SALT39.StrType)le.orig_subj2_address_prim_name),TRIM((SALT39.StrType)le.orig_subj2_address_suffix),TRIM((SALT39.StrType)le.orig_subj2_address_postdir),TRIM((SALT39.StrType)le.orig_subj2_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj2_address_sec_range),TRIM((SALT39.StrType)le.orig_subj2_address_city),TRIM((SALT39.StrType)le.orig_subj2_address_st),TRIM((SALT39.StrType)le.orig_subj2_address_z5),TRIM((SALT39.StrType)le.orig_subj2_address_z4),TRIM((SALT39.StrType)le.orig_subj2_phone),TRIM((SALT39.StrType)le.orig_subj2_work_phone),TRIM((SALT39.StrType)le.orig_subj2_business_title),TRIM((SALT39.StrType)le.orig_subj3_first_name),TRIM((SALT39.StrType)le.orig_subj3_middle_name),TRIM((SALT39.StrType)le.orig_subj3_last_name),TRIM((SALT39.StrType)le.orig_subj3_suffix_name),TRIM((SALT39.StrType)le.orig_subj3_full_name),TRIM((SALT39.StrType)le.orig_subj3_ssn),TRIM((SALT39.StrType)le.orig_subj3_dob),TRIM((SALT39.StrType)le.orig_subj3_dl_num),TRIM((SALT39.StrType)le.orig_subj3_dl_state),TRIM((SALT39.StrType)le.orig_subj3_former_last_name),TRIM((SALT39.StrType)le.orig_subj3_address_addressline1),TRIM((SALT39.StrType)le.orig_subj3_address_addressline2),TRIM((SALT39.StrType)le.orig_subj3_address_prim_range),TRIM((SALT39.StrType)le.orig_subj3_address_predir),TRIM((SALT39.StrType)le.orig_subj3_address_prim_name),TRIM((SALT39.StrType)le.orig_subj3_address_suffix),TRIM((SALT39.StrType)le.orig_subj3_address_postdir),TRIM((SALT39.StrType)le.orig_subj3_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj3_address_sec_range),TRIM((SALT39.StrType)le.orig_subj3_address_city),TRIM((SALT39.StrType)le.orig_subj3_address_st),TRIM((SALT39.StrType)le.orig_subj3_address_z5),TRIM((SALT39.StrType)le.orig_subj3_address_z4),TRIM((SALT39.StrType)le.orig_subj3_phone),TRIM((SALT39.StrType)le.orig_subj3_work_phone),TRIM((SALT39.StrType)le.orig_subj3_business_title),TRIM((SALT39.StrType)le.orig_email),TRIM((SALT39.StrType)le.orig_subj2_email),TRIM((SALT39.StrType)le.orig_subj2_company_name),TRIM((SALT39.StrType)le.orig_subj2_fein),TRIM((SALT39.StrType)le.orig_subj3_email),TRIM((SALT39.StrType)le.orig_subj3_company_name),TRIM((SALT39.StrType)le.orig_subj3_fein),TRIM((SALT39.StrType)le.orig_subj4_first_name),TRIM((SALT39.StrType)le.orig_subj4_middle_name),TRIM((SALT39.StrType)le.orig_subj4_last_name),TRIM((SALT39.StrType)le.orig_subj4_suffix_name),TRIM((SALT39.StrType)le.orig_subj4_full_name),TRIM((SALT39.StrType)le.orig_subj4_ssn),TRIM((SALT39.StrType)le.orig_subj4_dob),TRIM((SALT39.StrType)le.orig_subj4_dl_num),TRIM((SALT39.StrType)le.orig_subj4_dl_state),TRIM((SALT39.StrType)le.orig_subj4_former_last_name),TRIM((SALT39.StrType)le.orig_subj4_address_addressline1),TRIM((SALT39.StrType)le.orig_subj4_address_addressline2),TRIM((SALT39.StrType)le.orig_subj4_address_prim_range),TRIM((SALT39.StrType)le.orig_subj4_address_predir),TRIM((SALT39.StrType)le.orig_subj4_address_prim_name),TRIM((SALT39.StrType)le.orig_subj4_address_suffix),TRIM((SALT39.StrType)le.orig_subj4_address_postdir),TRIM((SALT39.StrType)le.orig_subj4_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj4_address_sec_range),TRIM((SALT39.StrType)le.orig_subj4_address_city),TRIM((SALT39.StrType)le.orig_subj4_address_st),TRIM((SALT39.StrType)le.orig_subj4_address_z5),TRIM((SALT39.StrType)le.orig_subj4_address_z4),TRIM((SALT39.StrType)le.orig_subj4_phone),TRIM((SALT39.StrType)le.orig_subj4_work_phone),TRIM((SALT39.StrType)le.orig_subj4_business_title),TRIM((SALT39.StrType)le.orig_subj4_email),TRIM((SALT39.StrType)le.orig_subj4_company_name),TRIM((SALT39.StrType)le.orig_subj4_fein),TRIM((SALT39.StrType)le.orig_subj5_first_name),TRIM((SALT39.StrType)le.orig_subj5_middle_name),TRIM((SALT39.StrType)le.orig_subj5_last_name),TRIM((SALT39.StrType)le.orig_subj5_suffix_name),TRIM((SALT39.StrType)le.orig_subj5_full_name),TRIM((SALT39.StrType)le.orig_subj5_ssn),TRIM((SALT39.StrType)le.orig_subj5_dob),TRIM((SALT39.StrType)le.orig_subj5_dl_num),TRIM((SALT39.StrType)le.orig_subj5_dl_state),TRIM((SALT39.StrType)le.orig_subj5_former_last_name),TRIM((SALT39.StrType)le.orig_subj5_address_addressline1),TRIM((SALT39.StrType)le.orig_subj5_address_addressline2),TRIM((SALT39.StrType)le.orig_subj5_address_prim_range),TRIM((SALT39.StrType)le.orig_subj5_address_predir),TRIM((SALT39.StrType)le.orig_subj5_address_prim_name),TRIM((SALT39.StrType)le.orig_subj5_address_suffix),TRIM((SALT39.StrType)le.orig_subj5_address_postdir),TRIM((SALT39.StrType)le.orig_subj5_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj5_address_sec_range),TRIM((SALT39.StrType)le.orig_subj5_address_city),TRIM((SALT39.StrType)le.orig_subj5_address_st),TRIM((SALT39.StrType)le.orig_subj5_address_z5),TRIM((SALT39.StrType)le.orig_subj5_address_z4),TRIM((SALT39.StrType)le.orig_subj5_phone),TRIM((SALT39.StrType)le.orig_subj5_work_phone),TRIM((SALT39.StrType)le.orig_subj5_business_title),TRIM((SALT39.StrType)le.orig_subj5_email),TRIM((SALT39.StrType)le.orig_subj5_company_name),TRIM((SALT39.StrType)le.orig_subj5_fein),TRIM((SALT39.StrType)le.orig_subj6_first_name),TRIM((SALT39.StrType)le.orig_subj6_middle_name),TRIM((SALT39.StrType)le.orig_subj6_last_name),TRIM((SALT39.StrType)le.orig_subj6_suffix_name),TRIM((SALT39.StrType)le.orig_subj6_full_name),TRIM((SALT39.StrType)le.orig_subj6_ssn),TRIM((SALT39.StrType)le.orig_subj6_dob),TRIM((SALT39.StrType)le.orig_subj6_dl_num),TRIM((SALT39.StrType)le.orig_subj6_dl_state),TRIM((SALT39.StrType)le.orig_subj6_former_last_name),TRIM((SALT39.StrType)le.orig_subj6_address_addressline1),TRIM((SALT39.StrType)le.orig_subj6_address_addressline2),TRIM((SALT39.StrType)le.orig_subj6_address_prim_range),TRIM((SALT39.StrType)le.orig_subj6_address_predir),TRIM((SALT39.StrType)le.orig_subj6_address_prim_name),TRIM((SALT39.StrType)le.orig_subj6_address_suffix),TRIM((SALT39.StrType)le.orig_subj6_address_postdir),TRIM((SALT39.StrType)le.orig_subj6_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj6_address_sec_range),TRIM((SALT39.StrType)le.orig_subj6_address_city),TRIM((SALT39.StrType)le.orig_subj6_address_st),TRIM((SALT39.StrType)le.orig_subj6_address_z5),TRIM((SALT39.StrType)le.orig_subj6_address_z4),TRIM((SALT39.StrType)le.orig_subj6_phone),TRIM((SALT39.StrType)le.orig_subj6_work_phone),TRIM((SALT39.StrType)le.orig_subj6_business_title),TRIM((SALT39.StrType)le.orig_subj6_email),TRIM((SALT39.StrType)le.orig_subj6_company_name),TRIM((SALT39.StrType)le.orig_subj6_fein),TRIM((SALT39.StrType)le.orig_subj7_first_name),TRIM((SALT39.StrType)le.orig_subj7_middle_name),TRIM((SALT39.StrType)le.orig_subj7_last_name),TRIM((SALT39.StrType)le.orig_subj7_suffix_name),TRIM((SALT39.StrType)le.orig_subj7_full_name),TRIM((SALT39.StrType)le.orig_subj7_ssn),TRIM((SALT39.StrType)le.orig_subj7_dob),TRIM((SALT39.StrType)le.orig_subj7_dl_num),TRIM((SALT39.StrType)le.orig_subj7_dl_state),TRIM((SALT39.StrType)le.orig_subj7_former_last_name),TRIM((SALT39.StrType)le.orig_subj7_address_addressline1),TRIM((SALT39.StrType)le.orig_subj7_address_addressline2),TRIM((SALT39.StrType)le.orig_subj7_address_prim_range),TRIM((SALT39.StrType)le.orig_subj7_address_predir),TRIM((SALT39.StrType)le.orig_subj7_address_prim_name),TRIM((SALT39.StrType)le.orig_subj7_address_suffix),TRIM((SALT39.StrType)le.orig_subj7_address_postdir),TRIM((SALT39.StrType)le.orig_subj7_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj7_address_sec_range),TRIM((SALT39.StrType)le.orig_subj7_address_city),TRIM((SALT39.StrType)le.orig_subj7_address_st),TRIM((SALT39.StrType)le.orig_subj7_address_z5),TRIM((SALT39.StrType)le.orig_subj7_address_z4),TRIM((SALT39.StrType)le.orig_subj7_phone),TRIM((SALT39.StrType)le.orig_subj7_work_phone),TRIM((SALT39.StrType)le.orig_subj7_business_title),TRIM((SALT39.StrType)le.orig_subj7_email),TRIM((SALT39.StrType)le.orig_subj7_company_name),TRIM((SALT39.StrType)le.orig_subj7_fein),TRIM((SALT39.StrType)le.orig_subj8_first_name),TRIM((SALT39.StrType)le.orig_subj8_middle_name),TRIM((SALT39.StrType)le.orig_subj8_last_name),TRIM((SALT39.StrType)le.orig_subj8_suffix_name),TRIM((SALT39.StrType)le.orig_subj8_full_name),TRIM((SALT39.StrType)le.orig_subj8_ssn),TRIM((SALT39.StrType)le.orig_subj8_dob),TRIM((SALT39.StrType)le.orig_subj8_dl_num),TRIM((SALT39.StrType)le.orig_subj8_dl_state),TRIM((SALT39.StrType)le.orig_subj8_former_last_name),TRIM((SALT39.StrType)le.orig_subj8_address_addressline1),TRIM((SALT39.StrType)le.orig_subj8_address_addressline2),TRIM((SALT39.StrType)le.orig_subj8_address_prim_range),TRIM((SALT39.StrType)le.orig_subj8_address_predir),TRIM((SALT39.StrType)le.orig_subj8_address_prim_name),TRIM((SALT39.StrType)le.orig_subj8_address_suffix),TRIM((SALT39.StrType)le.orig_subj8_address_postdir),TRIM((SALT39.StrType)le.orig_subj8_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj8_address_sec_range),TRIM((SALT39.StrType)le.orig_subj8_address_city),TRIM((SALT39.StrType)le.orig_subj8_address_st),TRIM((SALT39.StrType)le.orig_subj8_address_z5),TRIM((SALT39.StrType)le.orig_subj8_address_z4),TRIM((SALT39.StrType)le.orig_subj8_phone),TRIM((SALT39.StrType)le.orig_subj8_work_phone),TRIM((SALT39.StrType)le.orig_subj8_business_title),TRIM((SALT39.StrType)le.orig_subj8_email),TRIM((SALT39.StrType)le.orig_subj8_company_name),TRIM((SALT39.StrType)le.orig_subj8_fein),TRIM((SALT39.StrType)le.orig_company_alternate_name)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.orig_datetime_stamp),TRIM((SALT39.StrType)le.orig_global_company_id),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_product_cd),TRIM((SALT39.StrType)le.orig_method),TRIM((SALT39.StrType)le.orig_vertical),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_transaction_type),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_job_id),TRIM((SALT39.StrType)le.orig_sequence_number),TRIM((SALT39.StrType)le.orig_first_name),TRIM((SALT39.StrType)le.orig_middle_name),TRIM((SALT39.StrType)le.orig_last_name),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dl_num),TRIM((SALT39.StrType)le.orig_dl_state),TRIM((SALT39.StrType)le.orig_address1_addressline1),TRIM((SALT39.StrType)le.orig_address1_addressline2),TRIM((SALT39.StrType)le.orig_address1_prim_range),TRIM((SALT39.StrType)le.orig_address1_predir),TRIM((SALT39.StrType)le.orig_address1_prim_name),TRIM((SALT39.StrType)le.orig_address1_suffix),TRIM((SALT39.StrType)le.orig_address1_postdir),TRIM((SALT39.StrType)le.orig_address1_unit_desig),TRIM((SALT39.StrType)le.orig_address1_sec_range),TRIM((SALT39.StrType)le.orig_address1_city),TRIM((SALT39.StrType)le.orig_address1_st),TRIM((SALT39.StrType)le.orig_address1_z5),TRIM((SALT39.StrType)le.orig_address1_z4),TRIM((SALT39.StrType)le.orig_address2_addressline1),TRIM((SALT39.StrType)le.orig_address2_addressline2),TRIM((SALT39.StrType)le.orig_address2_prim_range),TRIM((SALT39.StrType)le.orig_address2_predir),TRIM((SALT39.StrType)le.orig_address2_prim_name),TRIM((SALT39.StrType)le.orig_address2_suffix),TRIM((SALT39.StrType)le.orig_address2_postdir),TRIM((SALT39.StrType)le.orig_address2_unit_desig),TRIM((SALT39.StrType)le.orig_address2_sec_range),TRIM((SALT39.StrType)le.orig_address2_city),TRIM((SALT39.StrType)le.orig_address2_st),TRIM((SALT39.StrType)le.orig_address2_z5),TRIM((SALT39.StrType)le.orig_address2_z4),TRIM((SALT39.StrType)le.orig_bdid),TRIM((SALT39.StrType)le.orig_bdl),TRIM((SALT39.StrType)le.orig_did),TRIM((SALT39.StrType)le.orig_company_name),TRIM((SALT39.StrType)le.orig_fein),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_work_phone),TRIM((SALT39.StrType)le.orig_company_phone),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_ip_address_initiated),TRIM((SALT39.StrType)le.orig_ip_address_executed),TRIM((SALT39.StrType)le.orig_charter_number),TRIM((SALT39.StrType)le.orig_ucc_original_filing_number),TRIM((SALT39.StrType)le.orig_email_address),TRIM((SALT39.StrType)le.orig_domain_name),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_dl_purpose),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_process_id),TRIM((SALT39.StrType)le.orig_suffix_name),TRIM((SALT39.StrType)le.orig_former_last_name),TRIM((SALT39.StrType)le.orig_business_title),TRIM((SALT39.StrType)le.orig_company_addressline1),TRIM((SALT39.StrType)le.orig_company_addressline2),TRIM((SALT39.StrType)le.orig_company_address_prim_range),TRIM((SALT39.StrType)le.orig_company_address_predir),TRIM((SALT39.StrType)le.orig_company_address_prim_name),TRIM((SALT39.StrType)le.orig_company_address_suffix),TRIM((SALT39.StrType)le.orig_company_address_postdir),TRIM((SALT39.StrType)le.orig_company_address_unit_desig),TRIM((SALT39.StrType)le.orig_company_address_sec_range),TRIM((SALT39.StrType)le.orig_company_address_city),TRIM((SALT39.StrType)le.orig_company_address_st),TRIM((SALT39.StrType)le.orig_company_address_zip5),TRIM((SALT39.StrType)le.orig_company_address_zip4),TRIM((SALT39.StrType)le.orig_company_fax_number),TRIM((SALT39.StrType)le.orig_company_start_date),TRIM((SALT39.StrType)le.orig_company_years_in_business),TRIM((SALT39.StrType)le.orig_company_sic_code),TRIM((SALT39.StrType)le.orig_company_naic_code),TRIM((SALT39.StrType)le.orig_company_structure),TRIM((SALT39.StrType)le.orig_company_yearly_revenue),TRIM((SALT39.StrType)le.orig_subj2_first_name),TRIM((SALT39.StrType)le.orig_subj2_middle_name),TRIM((SALT39.StrType)le.orig_subj2_last_name),TRIM((SALT39.StrType)le.orig_subj2_suffix_name),TRIM((SALT39.StrType)le.orig_subj2_full_name),TRIM((SALT39.StrType)le.orig_subj2_ssn),TRIM((SALT39.StrType)le.orig_subj2_dob),TRIM((SALT39.StrType)le.orig_subj2_dl_num),TRIM((SALT39.StrType)le.orig_subj2_dl_state),TRIM((SALT39.StrType)le.orig_subj2_former_last_name),TRIM((SALT39.StrType)le.orig_subj2_address_addressline1),TRIM((SALT39.StrType)le.orig_subj2_address_addressline2),TRIM((SALT39.StrType)le.orig_subj2_address_prim_range),TRIM((SALT39.StrType)le.orig_subj2_address_predir),TRIM((SALT39.StrType)le.orig_subj2_address_prim_name),TRIM((SALT39.StrType)le.orig_subj2_address_suffix),TRIM((SALT39.StrType)le.orig_subj2_address_postdir),TRIM((SALT39.StrType)le.orig_subj2_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj2_address_sec_range),TRIM((SALT39.StrType)le.orig_subj2_address_city),TRIM((SALT39.StrType)le.orig_subj2_address_st),TRIM((SALT39.StrType)le.orig_subj2_address_z5),TRIM((SALT39.StrType)le.orig_subj2_address_z4),TRIM((SALT39.StrType)le.orig_subj2_phone),TRIM((SALT39.StrType)le.orig_subj2_work_phone),TRIM((SALT39.StrType)le.orig_subj2_business_title),TRIM((SALT39.StrType)le.orig_subj3_first_name),TRIM((SALT39.StrType)le.orig_subj3_middle_name),TRIM((SALT39.StrType)le.orig_subj3_last_name),TRIM((SALT39.StrType)le.orig_subj3_suffix_name),TRIM((SALT39.StrType)le.orig_subj3_full_name),TRIM((SALT39.StrType)le.orig_subj3_ssn),TRIM((SALT39.StrType)le.orig_subj3_dob),TRIM((SALT39.StrType)le.orig_subj3_dl_num),TRIM((SALT39.StrType)le.orig_subj3_dl_state),TRIM((SALT39.StrType)le.orig_subj3_former_last_name),TRIM((SALT39.StrType)le.orig_subj3_address_addressline1),TRIM((SALT39.StrType)le.orig_subj3_address_addressline2),TRIM((SALT39.StrType)le.orig_subj3_address_prim_range),TRIM((SALT39.StrType)le.orig_subj3_address_predir),TRIM((SALT39.StrType)le.orig_subj3_address_prim_name),TRIM((SALT39.StrType)le.orig_subj3_address_suffix),TRIM((SALT39.StrType)le.orig_subj3_address_postdir),TRIM((SALT39.StrType)le.orig_subj3_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj3_address_sec_range),TRIM((SALT39.StrType)le.orig_subj3_address_city),TRIM((SALT39.StrType)le.orig_subj3_address_st),TRIM((SALT39.StrType)le.orig_subj3_address_z5),TRIM((SALT39.StrType)le.orig_subj3_address_z4),TRIM((SALT39.StrType)le.orig_subj3_phone),TRIM((SALT39.StrType)le.orig_subj3_work_phone),TRIM((SALT39.StrType)le.orig_subj3_business_title),TRIM((SALT39.StrType)le.orig_email),TRIM((SALT39.StrType)le.orig_subj2_email),TRIM((SALT39.StrType)le.orig_subj2_company_name),TRIM((SALT39.StrType)le.orig_subj2_fein),TRIM((SALT39.StrType)le.orig_subj3_email),TRIM((SALT39.StrType)le.orig_subj3_company_name),TRIM((SALT39.StrType)le.orig_subj3_fein),TRIM((SALT39.StrType)le.orig_subj4_first_name),TRIM((SALT39.StrType)le.orig_subj4_middle_name),TRIM((SALT39.StrType)le.orig_subj4_last_name),TRIM((SALT39.StrType)le.orig_subj4_suffix_name),TRIM((SALT39.StrType)le.orig_subj4_full_name),TRIM((SALT39.StrType)le.orig_subj4_ssn),TRIM((SALT39.StrType)le.orig_subj4_dob),TRIM((SALT39.StrType)le.orig_subj4_dl_num),TRIM((SALT39.StrType)le.orig_subj4_dl_state),TRIM((SALT39.StrType)le.orig_subj4_former_last_name),TRIM((SALT39.StrType)le.orig_subj4_address_addressline1),TRIM((SALT39.StrType)le.orig_subj4_address_addressline2),TRIM((SALT39.StrType)le.orig_subj4_address_prim_range),TRIM((SALT39.StrType)le.orig_subj4_address_predir),TRIM((SALT39.StrType)le.orig_subj4_address_prim_name),TRIM((SALT39.StrType)le.orig_subj4_address_suffix),TRIM((SALT39.StrType)le.orig_subj4_address_postdir),TRIM((SALT39.StrType)le.orig_subj4_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj4_address_sec_range),TRIM((SALT39.StrType)le.orig_subj4_address_city),TRIM((SALT39.StrType)le.orig_subj4_address_st),TRIM((SALT39.StrType)le.orig_subj4_address_z5),TRIM((SALT39.StrType)le.orig_subj4_address_z4),TRIM((SALT39.StrType)le.orig_subj4_phone),TRIM((SALT39.StrType)le.orig_subj4_work_phone),TRIM((SALT39.StrType)le.orig_subj4_business_title),TRIM((SALT39.StrType)le.orig_subj4_email),TRIM((SALT39.StrType)le.orig_subj4_company_name),TRIM((SALT39.StrType)le.orig_subj4_fein),TRIM((SALT39.StrType)le.orig_subj5_first_name),TRIM((SALT39.StrType)le.orig_subj5_middle_name),TRIM((SALT39.StrType)le.orig_subj5_last_name),TRIM((SALT39.StrType)le.orig_subj5_suffix_name),TRIM((SALT39.StrType)le.orig_subj5_full_name),TRIM((SALT39.StrType)le.orig_subj5_ssn),TRIM((SALT39.StrType)le.orig_subj5_dob),TRIM((SALT39.StrType)le.orig_subj5_dl_num),TRIM((SALT39.StrType)le.orig_subj5_dl_state),TRIM((SALT39.StrType)le.orig_subj5_former_last_name),TRIM((SALT39.StrType)le.orig_subj5_address_addressline1),TRIM((SALT39.StrType)le.orig_subj5_address_addressline2),TRIM((SALT39.StrType)le.orig_subj5_address_prim_range),TRIM((SALT39.StrType)le.orig_subj5_address_predir),TRIM((SALT39.StrType)le.orig_subj5_address_prim_name),TRIM((SALT39.StrType)le.orig_subj5_address_suffix),TRIM((SALT39.StrType)le.orig_subj5_address_postdir),TRIM((SALT39.StrType)le.orig_subj5_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj5_address_sec_range),TRIM((SALT39.StrType)le.orig_subj5_address_city),TRIM((SALT39.StrType)le.orig_subj5_address_st),TRIM((SALT39.StrType)le.orig_subj5_address_z5),TRIM((SALT39.StrType)le.orig_subj5_address_z4),TRIM((SALT39.StrType)le.orig_subj5_phone),TRIM((SALT39.StrType)le.orig_subj5_work_phone),TRIM((SALT39.StrType)le.orig_subj5_business_title),TRIM((SALT39.StrType)le.orig_subj5_email),TRIM((SALT39.StrType)le.orig_subj5_company_name),TRIM((SALT39.StrType)le.orig_subj5_fein),TRIM((SALT39.StrType)le.orig_subj6_first_name),TRIM((SALT39.StrType)le.orig_subj6_middle_name),TRIM((SALT39.StrType)le.orig_subj6_last_name),TRIM((SALT39.StrType)le.orig_subj6_suffix_name),TRIM((SALT39.StrType)le.orig_subj6_full_name),TRIM((SALT39.StrType)le.orig_subj6_ssn),TRIM((SALT39.StrType)le.orig_subj6_dob),TRIM((SALT39.StrType)le.orig_subj6_dl_num),TRIM((SALT39.StrType)le.orig_subj6_dl_state),TRIM((SALT39.StrType)le.orig_subj6_former_last_name),TRIM((SALT39.StrType)le.orig_subj6_address_addressline1),TRIM((SALT39.StrType)le.orig_subj6_address_addressline2),TRIM((SALT39.StrType)le.orig_subj6_address_prim_range),TRIM((SALT39.StrType)le.orig_subj6_address_predir),TRIM((SALT39.StrType)le.orig_subj6_address_prim_name),TRIM((SALT39.StrType)le.orig_subj6_address_suffix),TRIM((SALT39.StrType)le.orig_subj6_address_postdir),TRIM((SALT39.StrType)le.orig_subj6_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj6_address_sec_range),TRIM((SALT39.StrType)le.orig_subj6_address_city),TRIM((SALT39.StrType)le.orig_subj6_address_st),TRIM((SALT39.StrType)le.orig_subj6_address_z5),TRIM((SALT39.StrType)le.orig_subj6_address_z4),TRIM((SALT39.StrType)le.orig_subj6_phone),TRIM((SALT39.StrType)le.orig_subj6_work_phone),TRIM((SALT39.StrType)le.orig_subj6_business_title),TRIM((SALT39.StrType)le.orig_subj6_email),TRIM((SALT39.StrType)le.orig_subj6_company_name),TRIM((SALT39.StrType)le.orig_subj6_fein),TRIM((SALT39.StrType)le.orig_subj7_first_name),TRIM((SALT39.StrType)le.orig_subj7_middle_name),TRIM((SALT39.StrType)le.orig_subj7_last_name),TRIM((SALT39.StrType)le.orig_subj7_suffix_name),TRIM((SALT39.StrType)le.orig_subj7_full_name),TRIM((SALT39.StrType)le.orig_subj7_ssn),TRIM((SALT39.StrType)le.orig_subj7_dob),TRIM((SALT39.StrType)le.orig_subj7_dl_num),TRIM((SALT39.StrType)le.orig_subj7_dl_state),TRIM((SALT39.StrType)le.orig_subj7_former_last_name),TRIM((SALT39.StrType)le.orig_subj7_address_addressline1),TRIM((SALT39.StrType)le.orig_subj7_address_addressline2),TRIM((SALT39.StrType)le.orig_subj7_address_prim_range),TRIM((SALT39.StrType)le.orig_subj7_address_predir),TRIM((SALT39.StrType)le.orig_subj7_address_prim_name),TRIM((SALT39.StrType)le.orig_subj7_address_suffix),TRIM((SALT39.StrType)le.orig_subj7_address_postdir),TRIM((SALT39.StrType)le.orig_subj7_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj7_address_sec_range),TRIM((SALT39.StrType)le.orig_subj7_address_city),TRIM((SALT39.StrType)le.orig_subj7_address_st),TRIM((SALT39.StrType)le.orig_subj7_address_z5),TRIM((SALT39.StrType)le.orig_subj7_address_z4),TRIM((SALT39.StrType)le.orig_subj7_phone),TRIM((SALT39.StrType)le.orig_subj7_work_phone),TRIM((SALT39.StrType)le.orig_subj7_business_title),TRIM((SALT39.StrType)le.orig_subj7_email),TRIM((SALT39.StrType)le.orig_subj7_company_name),TRIM((SALT39.StrType)le.orig_subj7_fein),TRIM((SALT39.StrType)le.orig_subj8_first_name),TRIM((SALT39.StrType)le.orig_subj8_middle_name),TRIM((SALT39.StrType)le.orig_subj8_last_name),TRIM((SALT39.StrType)le.orig_subj8_suffix_name),TRIM((SALT39.StrType)le.orig_subj8_full_name),TRIM((SALT39.StrType)le.orig_subj8_ssn),TRIM((SALT39.StrType)le.orig_subj8_dob),TRIM((SALT39.StrType)le.orig_subj8_dl_num),TRIM((SALT39.StrType)le.orig_subj8_dl_state),TRIM((SALT39.StrType)le.orig_subj8_former_last_name),TRIM((SALT39.StrType)le.orig_subj8_address_addressline1),TRIM((SALT39.StrType)le.orig_subj8_address_addressline2),TRIM((SALT39.StrType)le.orig_subj8_address_prim_range),TRIM((SALT39.StrType)le.orig_subj8_address_predir),TRIM((SALT39.StrType)le.orig_subj8_address_prim_name),TRIM((SALT39.StrType)le.orig_subj8_address_suffix),TRIM((SALT39.StrType)le.orig_subj8_address_postdir),TRIM((SALT39.StrType)le.orig_subj8_address_unit_desig),TRIM((SALT39.StrType)le.orig_subj8_address_sec_range),TRIM((SALT39.StrType)le.orig_subj8_address_city),TRIM((SALT39.StrType)le.orig_subj8_address_st),TRIM((SALT39.StrType)le.orig_subj8_address_z5),TRIM((SALT39.StrType)le.orig_subj8_address_z4),TRIM((SALT39.StrType)le.orig_subj8_phone),TRIM((SALT39.StrType)le.orig_subj8_work_phone),TRIM((SALT39.StrType)le.orig_subj8_business_title),TRIM((SALT39.StrType)le.orig_subj8_email),TRIM((SALT39.StrType)le.orig_subj8_company_name),TRIM((SALT39.StrType)le.orig_subj8_fein),TRIM((SALT39.StrType)le.orig_company_alternate_name)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),292*292,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_datetime_stamp'}
      ,{2,'orig_global_company_id'}
      ,{3,'orig_company_id'}
      ,{4,'orig_product_cd'}
      ,{5,'orig_method'}
      ,{6,'orig_vertical'}
      ,{7,'orig_function_name'}
      ,{8,'orig_transaction_type'}
      ,{9,'orig_login_history_id'}
      ,{10,'orig_job_id'}
      ,{11,'orig_sequence_number'}
      ,{12,'orig_first_name'}
      ,{13,'orig_middle_name'}
      ,{14,'orig_last_name'}
      ,{15,'orig_ssn'}
      ,{16,'orig_dob'}
      ,{17,'orig_dl_num'}
      ,{18,'orig_dl_state'}
      ,{19,'orig_address1_addressline1'}
      ,{20,'orig_address1_addressline2'}
      ,{21,'orig_address1_prim_range'}
      ,{22,'orig_address1_predir'}
      ,{23,'orig_address1_prim_name'}
      ,{24,'orig_address1_suffix'}
      ,{25,'orig_address1_postdir'}
      ,{26,'orig_address1_unit_desig'}
      ,{27,'orig_address1_sec_range'}
      ,{28,'orig_address1_city'}
      ,{29,'orig_address1_st'}
      ,{30,'orig_address1_z5'}
      ,{31,'orig_address1_z4'}
      ,{32,'orig_address2_addressline1'}
      ,{33,'orig_address2_addressline2'}
      ,{34,'orig_address2_prim_range'}
      ,{35,'orig_address2_predir'}
      ,{36,'orig_address2_prim_name'}
      ,{37,'orig_address2_suffix'}
      ,{38,'orig_address2_postdir'}
      ,{39,'orig_address2_unit_desig'}
      ,{40,'orig_address2_sec_range'}
      ,{41,'orig_address2_city'}
      ,{42,'orig_address2_st'}
      ,{43,'orig_address2_z5'}
      ,{44,'orig_address2_z4'}
      ,{45,'orig_bdid'}
      ,{46,'orig_bdl'}
      ,{47,'orig_did'}
      ,{48,'orig_company_name'}
      ,{49,'orig_fein'}
      ,{50,'orig_phone'}
      ,{51,'orig_work_phone'}
      ,{52,'orig_company_phone'}
      ,{53,'orig_reference_code'}
      ,{54,'orig_ip_address_initiated'}
      ,{55,'orig_ip_address_executed'}
      ,{56,'orig_charter_number'}
      ,{57,'orig_ucc_original_filing_number'}
      ,{58,'orig_email_address'}
      ,{59,'orig_domain_name'}
      ,{60,'orig_full_name'}
      ,{61,'orig_dl_purpose'}
      ,{62,'orig_glb_purpose'}
      ,{63,'orig_fcra_purpose'}
      ,{64,'orig_process_id'}
      ,{65,'orig_suffix_name'}
      ,{66,'orig_former_last_name'}
      ,{67,'orig_business_title'}
      ,{68,'orig_company_addressline1'}
      ,{69,'orig_company_addressline2'}
      ,{70,'orig_company_address_prim_range'}
      ,{71,'orig_company_address_predir'}
      ,{72,'orig_company_address_prim_name'}
      ,{73,'orig_company_address_suffix'}
      ,{74,'orig_company_address_postdir'}
      ,{75,'orig_company_address_unit_desig'}
      ,{76,'orig_company_address_sec_range'}
      ,{77,'orig_company_address_city'}
      ,{78,'orig_company_address_st'}
      ,{79,'orig_company_address_zip5'}
      ,{80,'orig_company_address_zip4'}
      ,{81,'orig_company_fax_number'}
      ,{82,'orig_company_start_date'}
      ,{83,'orig_company_years_in_business'}
      ,{84,'orig_company_sic_code'}
      ,{85,'orig_company_naic_code'}
      ,{86,'orig_company_structure'}
      ,{87,'orig_company_yearly_revenue'}
      ,{88,'orig_subj2_first_name'}
      ,{89,'orig_subj2_middle_name'}
      ,{90,'orig_subj2_last_name'}
      ,{91,'orig_subj2_suffix_name'}
      ,{92,'orig_subj2_full_name'}
      ,{93,'orig_subj2_ssn'}
      ,{94,'orig_subj2_dob'}
      ,{95,'orig_subj2_dl_num'}
      ,{96,'orig_subj2_dl_state'}
      ,{97,'orig_subj2_former_last_name'}
      ,{98,'orig_subj2_address_addressline1'}
      ,{99,'orig_subj2_address_addressline2'}
      ,{100,'orig_subj2_address_prim_range'}
      ,{101,'orig_subj2_address_predir'}
      ,{102,'orig_subj2_address_prim_name'}
      ,{103,'orig_subj2_address_suffix'}
      ,{104,'orig_subj2_address_postdir'}
      ,{105,'orig_subj2_address_unit_desig'}
      ,{106,'orig_subj2_address_sec_range'}
      ,{107,'orig_subj2_address_city'}
      ,{108,'orig_subj2_address_st'}
      ,{109,'orig_subj2_address_z5'}
      ,{110,'orig_subj2_address_z4'}
      ,{111,'orig_subj2_phone'}
      ,{112,'orig_subj2_work_phone'}
      ,{113,'orig_subj2_business_title'}
      ,{114,'orig_subj3_first_name'}
      ,{115,'orig_subj3_middle_name'}
      ,{116,'orig_subj3_last_name'}
      ,{117,'orig_subj3_suffix_name'}
      ,{118,'orig_subj3_full_name'}
      ,{119,'orig_subj3_ssn'}
      ,{120,'orig_subj3_dob'}
      ,{121,'orig_subj3_dl_num'}
      ,{122,'orig_subj3_dl_state'}
      ,{123,'orig_subj3_former_last_name'}
      ,{124,'orig_subj3_address_addressline1'}
      ,{125,'orig_subj3_address_addressline2'}
      ,{126,'orig_subj3_address_prim_range'}
      ,{127,'orig_subj3_address_predir'}
      ,{128,'orig_subj3_address_prim_name'}
      ,{129,'orig_subj3_address_suffix'}
      ,{130,'orig_subj3_address_postdir'}
      ,{131,'orig_subj3_address_unit_desig'}
      ,{132,'orig_subj3_address_sec_range'}
      ,{133,'orig_subj3_address_city'}
      ,{134,'orig_subj3_address_st'}
      ,{135,'orig_subj3_address_z5'}
      ,{136,'orig_subj3_address_z4'}
      ,{137,'orig_subj3_phone'}
      ,{138,'orig_subj3_work_phone'}
      ,{139,'orig_subj3_business_title'}
      ,{140,'orig_email'}
      ,{141,'orig_subj2_email'}
      ,{142,'orig_subj2_company_name'}
      ,{143,'orig_subj2_fein'}
      ,{144,'orig_subj3_email'}
      ,{145,'orig_subj3_company_name'}
      ,{146,'orig_subj3_fein'}
      ,{147,'orig_subj4_first_name'}
      ,{148,'orig_subj4_middle_name'}
      ,{149,'orig_subj4_last_name'}
      ,{150,'orig_subj4_suffix_name'}
      ,{151,'orig_subj4_full_name'}
      ,{152,'orig_subj4_ssn'}
      ,{153,'orig_subj4_dob'}
      ,{154,'orig_subj4_dl_num'}
      ,{155,'orig_subj4_dl_state'}
      ,{156,'orig_subj4_former_last_name'}
      ,{157,'orig_subj4_address_addressline1'}
      ,{158,'orig_subj4_address_addressline2'}
      ,{159,'orig_subj4_address_prim_range'}
      ,{160,'orig_subj4_address_predir'}
      ,{161,'orig_subj4_address_prim_name'}
      ,{162,'orig_subj4_address_suffix'}
      ,{163,'orig_subj4_address_postdir'}
      ,{164,'orig_subj4_address_unit_desig'}
      ,{165,'orig_subj4_address_sec_range'}
      ,{166,'orig_subj4_address_city'}
      ,{167,'orig_subj4_address_st'}
      ,{168,'orig_subj4_address_z5'}
      ,{169,'orig_subj4_address_z4'}
      ,{170,'orig_subj4_phone'}
      ,{171,'orig_subj4_work_phone'}
      ,{172,'orig_subj4_business_title'}
      ,{173,'orig_subj4_email'}
      ,{174,'orig_subj4_company_name'}
      ,{175,'orig_subj4_fein'}
      ,{176,'orig_subj5_first_name'}
      ,{177,'orig_subj5_middle_name'}
      ,{178,'orig_subj5_last_name'}
      ,{179,'orig_subj5_suffix_name'}
      ,{180,'orig_subj5_full_name'}
      ,{181,'orig_subj5_ssn'}
      ,{182,'orig_subj5_dob'}
      ,{183,'orig_subj5_dl_num'}
      ,{184,'orig_subj5_dl_state'}
      ,{185,'orig_subj5_former_last_name'}
      ,{186,'orig_subj5_address_addressline1'}
      ,{187,'orig_subj5_address_addressline2'}
      ,{188,'orig_subj5_address_prim_range'}
      ,{189,'orig_subj5_address_predir'}
      ,{190,'orig_subj5_address_prim_name'}
      ,{191,'orig_subj5_address_suffix'}
      ,{192,'orig_subj5_address_postdir'}
      ,{193,'orig_subj5_address_unit_desig'}
      ,{194,'orig_subj5_address_sec_range'}
      ,{195,'orig_subj5_address_city'}
      ,{196,'orig_subj5_address_st'}
      ,{197,'orig_subj5_address_z5'}
      ,{198,'orig_subj5_address_z4'}
      ,{199,'orig_subj5_phone'}
      ,{200,'orig_subj5_work_phone'}
      ,{201,'orig_subj5_business_title'}
      ,{202,'orig_subj5_email'}
      ,{203,'orig_subj5_company_name'}
      ,{204,'orig_subj5_fein'}
      ,{205,'orig_subj6_first_name'}
      ,{206,'orig_subj6_middle_name'}
      ,{207,'orig_subj6_last_name'}
      ,{208,'orig_subj6_suffix_name'}
      ,{209,'orig_subj6_full_name'}
      ,{210,'orig_subj6_ssn'}
      ,{211,'orig_subj6_dob'}
      ,{212,'orig_subj6_dl_num'}
      ,{213,'orig_subj6_dl_state'}
      ,{214,'orig_subj6_former_last_name'}
      ,{215,'orig_subj6_address_addressline1'}
      ,{216,'orig_subj6_address_addressline2'}
      ,{217,'orig_subj6_address_prim_range'}
      ,{218,'orig_subj6_address_predir'}
      ,{219,'orig_subj6_address_prim_name'}
      ,{220,'orig_subj6_address_suffix'}
      ,{221,'orig_subj6_address_postdir'}
      ,{222,'orig_subj6_address_unit_desig'}
      ,{223,'orig_subj6_address_sec_range'}
      ,{224,'orig_subj6_address_city'}
      ,{225,'orig_subj6_address_st'}
      ,{226,'orig_subj6_address_z5'}
      ,{227,'orig_subj6_address_z4'}
      ,{228,'orig_subj6_phone'}
      ,{229,'orig_subj6_work_phone'}
      ,{230,'orig_subj6_business_title'}
      ,{231,'orig_subj6_email'}
      ,{232,'orig_subj6_company_name'}
      ,{233,'orig_subj6_fein'}
      ,{234,'orig_subj7_first_name'}
      ,{235,'orig_subj7_middle_name'}
      ,{236,'orig_subj7_last_name'}
      ,{237,'orig_subj7_suffix_name'}
      ,{238,'orig_subj7_full_name'}
      ,{239,'orig_subj7_ssn'}
      ,{240,'orig_subj7_dob'}
      ,{241,'orig_subj7_dl_num'}
      ,{242,'orig_subj7_dl_state'}
      ,{243,'orig_subj7_former_last_name'}
      ,{244,'orig_subj7_address_addressline1'}
      ,{245,'orig_subj7_address_addressline2'}
      ,{246,'orig_subj7_address_prim_range'}
      ,{247,'orig_subj7_address_predir'}
      ,{248,'orig_subj7_address_prim_name'}
      ,{249,'orig_subj7_address_suffix'}
      ,{250,'orig_subj7_address_postdir'}
      ,{251,'orig_subj7_address_unit_desig'}
      ,{252,'orig_subj7_address_sec_range'}
      ,{253,'orig_subj7_address_city'}
      ,{254,'orig_subj7_address_st'}
      ,{255,'orig_subj7_address_z5'}
      ,{256,'orig_subj7_address_z4'}
      ,{257,'orig_subj7_phone'}
      ,{258,'orig_subj7_work_phone'}
      ,{259,'orig_subj7_business_title'}
      ,{260,'orig_subj7_email'}
      ,{261,'orig_subj7_company_name'}
      ,{262,'orig_subj7_fein'}
      ,{263,'orig_subj8_first_name'}
      ,{264,'orig_subj8_middle_name'}
      ,{265,'orig_subj8_last_name'}
      ,{266,'orig_subj8_suffix_name'}
      ,{267,'orig_subj8_full_name'}
      ,{268,'orig_subj8_ssn'}
      ,{269,'orig_subj8_dob'}
      ,{270,'orig_subj8_dl_num'}
      ,{271,'orig_subj8_dl_state'}
      ,{272,'orig_subj8_former_last_name'}
      ,{273,'orig_subj8_address_addressline1'}
      ,{274,'orig_subj8_address_addressline2'}
      ,{275,'orig_subj8_address_prim_range'}
      ,{276,'orig_subj8_address_predir'}
      ,{277,'orig_subj8_address_prim_name'}
      ,{278,'orig_subj8_address_suffix'}
      ,{279,'orig_subj8_address_postdir'}
      ,{280,'orig_subj8_address_unit_desig'}
      ,{281,'orig_subj8_address_sec_range'}
      ,{282,'orig_subj8_address_city'}
      ,{283,'orig_subj8_address_st'}
      ,{284,'orig_subj8_address_z5'}
      ,{285,'orig_subj8_address_z4'}
      ,{286,'orig_subj8_phone'}
      ,{287,'orig_subj8_work_phone'}
      ,{288,'orig_subj8_business_title'}
      ,{289,'orig_subj8_email'}
      ,{290,'orig_subj8_company_name'}
      ,{291,'orig_subj8_fein'}
      ,{292,'orig_company_alternate_name'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_datetime_stamp((SALT39.StrType)le.orig_datetime_stamp),
    Fields.InValid_orig_global_company_id((SALT39.StrType)le.orig_global_company_id),
    Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id),
    Fields.InValid_orig_product_cd((SALT39.StrType)le.orig_product_cd),
    Fields.InValid_orig_method((SALT39.StrType)le.orig_method),
    Fields.InValid_orig_vertical((SALT39.StrType)le.orig_vertical),
    Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name),
    Fields.InValid_orig_transaction_type((SALT39.StrType)le.orig_transaction_type),
    Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id),
    Fields.InValid_orig_job_id((SALT39.StrType)le.orig_job_id),
    Fields.InValid_orig_sequence_number((SALT39.StrType)le.orig_sequence_number),
    Fields.InValid_orig_first_name((SALT39.StrType)le.orig_first_name),
    Fields.InValid_orig_middle_name((SALT39.StrType)le.orig_middle_name),
    Fields.InValid_orig_last_name((SALT39.StrType)le.orig_last_name),
    Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn),
    Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob),
    Fields.InValid_orig_dl_num((SALT39.StrType)le.orig_dl_num),
    Fields.InValid_orig_dl_state((SALT39.StrType)le.orig_dl_state),
    Fields.InValid_orig_address1_addressline1((SALT39.StrType)le.orig_address1_addressline1),
    Fields.InValid_orig_address1_addressline2((SALT39.StrType)le.orig_address1_addressline2),
    Fields.InValid_orig_address1_prim_range((SALT39.StrType)le.orig_address1_prim_range),
    Fields.InValid_orig_address1_predir((SALT39.StrType)le.orig_address1_predir),
    Fields.InValid_orig_address1_prim_name((SALT39.StrType)le.orig_address1_prim_name),
    Fields.InValid_orig_address1_suffix((SALT39.StrType)le.orig_address1_suffix),
    Fields.InValid_orig_address1_postdir((SALT39.StrType)le.orig_address1_postdir),
    Fields.InValid_orig_address1_unit_desig((SALT39.StrType)le.orig_address1_unit_desig),
    Fields.InValid_orig_address1_sec_range((SALT39.StrType)le.orig_address1_sec_range),
    Fields.InValid_orig_address1_city((SALT39.StrType)le.orig_address1_city),
    Fields.InValid_orig_address1_st((SALT39.StrType)le.orig_address1_st),
    Fields.InValid_orig_address1_z5((SALT39.StrType)le.orig_address1_z5),
    Fields.InValid_orig_address1_z4((SALT39.StrType)le.orig_address1_z4),
    Fields.InValid_orig_address2_addressline1((SALT39.StrType)le.orig_address2_addressline1),
    Fields.InValid_orig_address2_addressline2((SALT39.StrType)le.orig_address2_addressline2),
    Fields.InValid_orig_address2_prim_range((SALT39.StrType)le.orig_address2_prim_range),
    Fields.InValid_orig_address2_predir((SALT39.StrType)le.orig_address2_predir),
    Fields.InValid_orig_address2_prim_name((SALT39.StrType)le.orig_address2_prim_name),
    Fields.InValid_orig_address2_suffix((SALT39.StrType)le.orig_address2_suffix),
    Fields.InValid_orig_address2_postdir((SALT39.StrType)le.orig_address2_postdir),
    Fields.InValid_orig_address2_unit_desig((SALT39.StrType)le.orig_address2_unit_desig),
    Fields.InValid_orig_address2_sec_range((SALT39.StrType)le.orig_address2_sec_range),
    Fields.InValid_orig_address2_city((SALT39.StrType)le.orig_address2_city),
    Fields.InValid_orig_address2_st((SALT39.StrType)le.orig_address2_st),
    Fields.InValid_orig_address2_z5((SALT39.StrType)le.orig_address2_z5),
    Fields.InValid_orig_address2_z4((SALT39.StrType)le.orig_address2_z4),
    Fields.InValid_orig_bdid((SALT39.StrType)le.orig_bdid),
    Fields.InValid_orig_bdl((SALT39.StrType)le.orig_bdl),
    Fields.InValid_orig_did((SALT39.StrType)le.orig_did),
    Fields.InValid_orig_company_name((SALT39.StrType)le.orig_company_name),
    Fields.InValid_orig_fein((SALT39.StrType)le.orig_fein),
    Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone),
    Fields.InValid_orig_work_phone((SALT39.StrType)le.orig_work_phone),
    Fields.InValid_orig_company_phone((SALT39.StrType)le.orig_company_phone),
    Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code),
    Fields.InValid_orig_ip_address_initiated((SALT39.StrType)le.orig_ip_address_initiated),
    Fields.InValid_orig_ip_address_executed((SALT39.StrType)le.orig_ip_address_executed),
    Fields.InValid_orig_charter_number((SALT39.StrType)le.orig_charter_number),
    Fields.InValid_orig_ucc_original_filing_number((SALT39.StrType)le.orig_ucc_original_filing_number),
    Fields.InValid_orig_email_address((SALT39.StrType)le.orig_email_address),
    Fields.InValid_orig_domain_name((SALT39.StrType)le.orig_domain_name),
    Fields.InValid_orig_full_name((SALT39.StrType)le.orig_full_name),
    Fields.InValid_orig_dl_purpose((SALT39.StrType)le.orig_dl_purpose),
    Fields.InValid_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose),
    Fields.InValid_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose),
    Fields.InValid_orig_process_id((SALT39.StrType)le.orig_process_id),
    Fields.InValid_orig_suffix_name((SALT39.StrType)le.orig_suffix_name),
    Fields.InValid_orig_former_last_name((SALT39.StrType)le.orig_former_last_name),
    Fields.InValid_orig_business_title((SALT39.StrType)le.orig_business_title),
    Fields.InValid_orig_company_addressline1((SALT39.StrType)le.orig_company_addressline1),
    Fields.InValid_orig_company_addressline2((SALT39.StrType)le.orig_company_addressline2),
    Fields.InValid_orig_company_address_prim_range((SALT39.StrType)le.orig_company_address_prim_range),
    Fields.InValid_orig_company_address_predir((SALT39.StrType)le.orig_company_address_predir),
    Fields.InValid_orig_company_address_prim_name((SALT39.StrType)le.orig_company_address_prim_name),
    Fields.InValid_orig_company_address_suffix((SALT39.StrType)le.orig_company_address_suffix),
    Fields.InValid_orig_company_address_postdir((SALT39.StrType)le.orig_company_address_postdir),
    Fields.InValid_orig_company_address_unit_desig((SALT39.StrType)le.orig_company_address_unit_desig),
    Fields.InValid_orig_company_address_sec_range((SALT39.StrType)le.orig_company_address_sec_range),
    Fields.InValid_orig_company_address_city((SALT39.StrType)le.orig_company_address_city),
    Fields.InValid_orig_company_address_st((SALT39.StrType)le.orig_company_address_st),
    Fields.InValid_orig_company_address_zip5((SALT39.StrType)le.orig_company_address_zip5),
    Fields.InValid_orig_company_address_zip4((SALT39.StrType)le.orig_company_address_zip4),
    Fields.InValid_orig_company_fax_number((SALT39.StrType)le.orig_company_fax_number),
    Fields.InValid_orig_company_start_date((SALT39.StrType)le.orig_company_start_date),
    Fields.InValid_orig_company_years_in_business((SALT39.StrType)le.orig_company_years_in_business),
    Fields.InValid_orig_company_sic_code((SALT39.StrType)le.orig_company_sic_code),
    Fields.InValid_orig_company_naic_code((SALT39.StrType)le.orig_company_naic_code),
    Fields.InValid_orig_company_structure((SALT39.StrType)le.orig_company_structure),
    Fields.InValid_orig_company_yearly_revenue((SALT39.StrType)le.orig_company_yearly_revenue),
    Fields.InValid_orig_subj2_first_name((SALT39.StrType)le.orig_subj2_first_name),
    Fields.InValid_orig_subj2_middle_name((SALT39.StrType)le.orig_subj2_middle_name),
    Fields.InValid_orig_subj2_last_name((SALT39.StrType)le.orig_subj2_last_name),
    Fields.InValid_orig_subj2_suffix_name((SALT39.StrType)le.orig_subj2_suffix_name),
    Fields.InValid_orig_subj2_full_name((SALT39.StrType)le.orig_subj2_full_name),
    Fields.InValid_orig_subj2_ssn((SALT39.StrType)le.orig_subj2_ssn),
    Fields.InValid_orig_subj2_dob((SALT39.StrType)le.orig_subj2_dob),
    Fields.InValid_orig_subj2_dl_num((SALT39.StrType)le.orig_subj2_dl_num),
    Fields.InValid_orig_subj2_dl_state((SALT39.StrType)le.orig_subj2_dl_state),
    Fields.InValid_orig_subj2_former_last_name((SALT39.StrType)le.orig_subj2_former_last_name),
    Fields.InValid_orig_subj2_address_addressline1((SALT39.StrType)le.orig_subj2_address_addressline1),
    Fields.InValid_orig_subj2_address_addressline2((SALT39.StrType)le.orig_subj2_address_addressline2),
    Fields.InValid_orig_subj2_address_prim_range((SALT39.StrType)le.orig_subj2_address_prim_range),
    Fields.InValid_orig_subj2_address_predir((SALT39.StrType)le.orig_subj2_address_predir),
    Fields.InValid_orig_subj2_address_prim_name((SALT39.StrType)le.orig_subj2_address_prim_name),
    Fields.InValid_orig_subj2_address_suffix((SALT39.StrType)le.orig_subj2_address_suffix),
    Fields.InValid_orig_subj2_address_postdir((SALT39.StrType)le.orig_subj2_address_postdir),
    Fields.InValid_orig_subj2_address_unit_desig((SALT39.StrType)le.orig_subj2_address_unit_desig),
    Fields.InValid_orig_subj2_address_sec_range((SALT39.StrType)le.orig_subj2_address_sec_range),
    Fields.InValid_orig_subj2_address_city((SALT39.StrType)le.orig_subj2_address_city),
    Fields.InValid_orig_subj2_address_st((SALT39.StrType)le.orig_subj2_address_st),
    Fields.InValid_orig_subj2_address_z5((SALT39.StrType)le.orig_subj2_address_z5),
    Fields.InValid_orig_subj2_address_z4((SALT39.StrType)le.orig_subj2_address_z4),
    Fields.InValid_orig_subj2_phone((SALT39.StrType)le.orig_subj2_phone),
    Fields.InValid_orig_subj2_work_phone((SALT39.StrType)le.orig_subj2_work_phone),
    Fields.InValid_orig_subj2_business_title((SALT39.StrType)le.orig_subj2_business_title),
    Fields.InValid_orig_subj3_first_name((SALT39.StrType)le.orig_subj3_first_name),
    Fields.InValid_orig_subj3_middle_name((SALT39.StrType)le.orig_subj3_middle_name),
    Fields.InValid_orig_subj3_last_name((SALT39.StrType)le.orig_subj3_last_name),
    Fields.InValid_orig_subj3_suffix_name((SALT39.StrType)le.orig_subj3_suffix_name),
    Fields.InValid_orig_subj3_full_name((SALT39.StrType)le.orig_subj3_full_name),
    Fields.InValid_orig_subj3_ssn((SALT39.StrType)le.orig_subj3_ssn),
    Fields.InValid_orig_subj3_dob((SALT39.StrType)le.orig_subj3_dob),
    Fields.InValid_orig_subj3_dl_num((SALT39.StrType)le.orig_subj3_dl_num),
    Fields.InValid_orig_subj3_dl_state((SALT39.StrType)le.orig_subj3_dl_state),
    Fields.InValid_orig_subj3_former_last_name((SALT39.StrType)le.orig_subj3_former_last_name),
    Fields.InValid_orig_subj3_address_addressline1((SALT39.StrType)le.orig_subj3_address_addressline1),
    Fields.InValid_orig_subj3_address_addressline2((SALT39.StrType)le.orig_subj3_address_addressline2),
    Fields.InValid_orig_subj3_address_prim_range((SALT39.StrType)le.orig_subj3_address_prim_range),
    Fields.InValid_orig_subj3_address_predir((SALT39.StrType)le.orig_subj3_address_predir),
    Fields.InValid_orig_subj3_address_prim_name((SALT39.StrType)le.orig_subj3_address_prim_name),
    Fields.InValid_orig_subj3_address_suffix((SALT39.StrType)le.orig_subj3_address_suffix),
    Fields.InValid_orig_subj3_address_postdir((SALT39.StrType)le.orig_subj3_address_postdir),
    Fields.InValid_orig_subj3_address_unit_desig((SALT39.StrType)le.orig_subj3_address_unit_desig),
    Fields.InValid_orig_subj3_address_sec_range((SALT39.StrType)le.orig_subj3_address_sec_range),
    Fields.InValid_orig_subj3_address_city((SALT39.StrType)le.orig_subj3_address_city),
    Fields.InValid_orig_subj3_address_st((SALT39.StrType)le.orig_subj3_address_st),
    Fields.InValid_orig_subj3_address_z5((SALT39.StrType)le.orig_subj3_address_z5),
    Fields.InValid_orig_subj3_address_z4((SALT39.StrType)le.orig_subj3_address_z4),
    Fields.InValid_orig_subj3_phone((SALT39.StrType)le.orig_subj3_phone),
    Fields.InValid_orig_subj3_work_phone((SALT39.StrType)le.orig_subj3_work_phone),
    Fields.InValid_orig_subj3_business_title((SALT39.StrType)le.orig_subj3_business_title),
    Fields.InValid_orig_email((SALT39.StrType)le.orig_email),
    Fields.InValid_orig_subj2_email((SALT39.StrType)le.orig_subj2_email),
    Fields.InValid_orig_subj2_company_name((SALT39.StrType)le.orig_subj2_company_name),
    Fields.InValid_orig_subj2_fein((SALT39.StrType)le.orig_subj2_fein),
    Fields.InValid_orig_subj3_email((SALT39.StrType)le.orig_subj3_email),
    Fields.InValid_orig_subj3_company_name((SALT39.StrType)le.orig_subj3_company_name),
    Fields.InValid_orig_subj3_fein((SALT39.StrType)le.orig_subj3_fein),
    Fields.InValid_orig_subj4_first_name((SALT39.StrType)le.orig_subj4_first_name),
    Fields.InValid_orig_subj4_middle_name((SALT39.StrType)le.orig_subj4_middle_name),
    Fields.InValid_orig_subj4_last_name((SALT39.StrType)le.orig_subj4_last_name),
    Fields.InValid_orig_subj4_suffix_name((SALT39.StrType)le.orig_subj4_suffix_name),
    Fields.InValid_orig_subj4_full_name((SALT39.StrType)le.orig_subj4_full_name),
    Fields.InValid_orig_subj4_ssn((SALT39.StrType)le.orig_subj4_ssn),
    Fields.InValid_orig_subj4_dob((SALT39.StrType)le.orig_subj4_dob),
    Fields.InValid_orig_subj4_dl_num((SALT39.StrType)le.orig_subj4_dl_num),
    Fields.InValid_orig_subj4_dl_state((SALT39.StrType)le.orig_subj4_dl_state),
    Fields.InValid_orig_subj4_former_last_name((SALT39.StrType)le.orig_subj4_former_last_name),
    Fields.InValid_orig_subj4_address_addressline1((SALT39.StrType)le.orig_subj4_address_addressline1),
    Fields.InValid_orig_subj4_address_addressline2((SALT39.StrType)le.orig_subj4_address_addressline2),
    Fields.InValid_orig_subj4_address_prim_range((SALT39.StrType)le.orig_subj4_address_prim_range),
    Fields.InValid_orig_subj4_address_predir((SALT39.StrType)le.orig_subj4_address_predir),
    Fields.InValid_orig_subj4_address_prim_name((SALT39.StrType)le.orig_subj4_address_prim_name),
    Fields.InValid_orig_subj4_address_suffix((SALT39.StrType)le.orig_subj4_address_suffix),
    Fields.InValid_orig_subj4_address_postdir((SALT39.StrType)le.orig_subj4_address_postdir),
    Fields.InValid_orig_subj4_address_unit_desig((SALT39.StrType)le.orig_subj4_address_unit_desig),
    Fields.InValid_orig_subj4_address_sec_range((SALT39.StrType)le.orig_subj4_address_sec_range),
    Fields.InValid_orig_subj4_address_city((SALT39.StrType)le.orig_subj4_address_city),
    Fields.InValid_orig_subj4_address_st((SALT39.StrType)le.orig_subj4_address_st),
    Fields.InValid_orig_subj4_address_z5((SALT39.StrType)le.orig_subj4_address_z5),
    Fields.InValid_orig_subj4_address_z4((SALT39.StrType)le.orig_subj4_address_z4),
    Fields.InValid_orig_subj4_phone((SALT39.StrType)le.orig_subj4_phone),
    Fields.InValid_orig_subj4_work_phone((SALT39.StrType)le.orig_subj4_work_phone),
    Fields.InValid_orig_subj4_business_title((SALT39.StrType)le.orig_subj4_business_title),
    Fields.InValid_orig_subj4_email((SALT39.StrType)le.orig_subj4_email),
    Fields.InValid_orig_subj4_company_name((SALT39.StrType)le.orig_subj4_company_name),
    Fields.InValid_orig_subj4_fein((SALT39.StrType)le.orig_subj4_fein),
    Fields.InValid_orig_subj5_first_name((SALT39.StrType)le.orig_subj5_first_name),
    Fields.InValid_orig_subj5_middle_name((SALT39.StrType)le.orig_subj5_middle_name),
    Fields.InValid_orig_subj5_last_name((SALT39.StrType)le.orig_subj5_last_name),
    Fields.InValid_orig_subj5_suffix_name((SALT39.StrType)le.orig_subj5_suffix_name),
    Fields.InValid_orig_subj5_full_name((SALT39.StrType)le.orig_subj5_full_name),
    Fields.InValid_orig_subj5_ssn((SALT39.StrType)le.orig_subj5_ssn),
    Fields.InValid_orig_subj5_dob((SALT39.StrType)le.orig_subj5_dob),
    Fields.InValid_orig_subj5_dl_num((SALT39.StrType)le.orig_subj5_dl_num),
    Fields.InValid_orig_subj5_dl_state((SALT39.StrType)le.orig_subj5_dl_state),
    Fields.InValid_orig_subj5_former_last_name((SALT39.StrType)le.orig_subj5_former_last_name),
    Fields.InValid_orig_subj5_address_addressline1((SALT39.StrType)le.orig_subj5_address_addressline1),
    Fields.InValid_orig_subj5_address_addressline2((SALT39.StrType)le.orig_subj5_address_addressline2),
    Fields.InValid_orig_subj5_address_prim_range((SALT39.StrType)le.orig_subj5_address_prim_range),
    Fields.InValid_orig_subj5_address_predir((SALT39.StrType)le.orig_subj5_address_predir),
    Fields.InValid_orig_subj5_address_prim_name((SALT39.StrType)le.orig_subj5_address_prim_name),
    Fields.InValid_orig_subj5_address_suffix((SALT39.StrType)le.orig_subj5_address_suffix),
    Fields.InValid_orig_subj5_address_postdir((SALT39.StrType)le.orig_subj5_address_postdir),
    Fields.InValid_orig_subj5_address_unit_desig((SALT39.StrType)le.orig_subj5_address_unit_desig),
    Fields.InValid_orig_subj5_address_sec_range((SALT39.StrType)le.orig_subj5_address_sec_range),
    Fields.InValid_orig_subj5_address_city((SALT39.StrType)le.orig_subj5_address_city),
    Fields.InValid_orig_subj5_address_st((SALT39.StrType)le.orig_subj5_address_st),
    Fields.InValid_orig_subj5_address_z5((SALT39.StrType)le.orig_subj5_address_z5),
    Fields.InValid_orig_subj5_address_z4((SALT39.StrType)le.orig_subj5_address_z4),
    Fields.InValid_orig_subj5_phone((SALT39.StrType)le.orig_subj5_phone),
    Fields.InValid_orig_subj5_work_phone((SALT39.StrType)le.orig_subj5_work_phone),
    Fields.InValid_orig_subj5_business_title((SALT39.StrType)le.orig_subj5_business_title),
    Fields.InValid_orig_subj5_email((SALT39.StrType)le.orig_subj5_email),
    Fields.InValid_orig_subj5_company_name((SALT39.StrType)le.orig_subj5_company_name),
    Fields.InValid_orig_subj5_fein((SALT39.StrType)le.orig_subj5_fein),
    Fields.InValid_orig_subj6_first_name((SALT39.StrType)le.orig_subj6_first_name),
    Fields.InValid_orig_subj6_middle_name((SALT39.StrType)le.orig_subj6_middle_name),
    Fields.InValid_orig_subj6_last_name((SALT39.StrType)le.orig_subj6_last_name),
    Fields.InValid_orig_subj6_suffix_name((SALT39.StrType)le.orig_subj6_suffix_name),
    Fields.InValid_orig_subj6_full_name((SALT39.StrType)le.orig_subj6_full_name),
    Fields.InValid_orig_subj6_ssn((SALT39.StrType)le.orig_subj6_ssn),
    Fields.InValid_orig_subj6_dob((SALT39.StrType)le.orig_subj6_dob),
    Fields.InValid_orig_subj6_dl_num((SALT39.StrType)le.orig_subj6_dl_num),
    Fields.InValid_orig_subj6_dl_state((SALT39.StrType)le.orig_subj6_dl_state),
    Fields.InValid_orig_subj6_former_last_name((SALT39.StrType)le.orig_subj6_former_last_name),
    Fields.InValid_orig_subj6_address_addressline1((SALT39.StrType)le.orig_subj6_address_addressline1),
    Fields.InValid_orig_subj6_address_addressline2((SALT39.StrType)le.orig_subj6_address_addressline2),
    Fields.InValid_orig_subj6_address_prim_range((SALT39.StrType)le.orig_subj6_address_prim_range),
    Fields.InValid_orig_subj6_address_predir((SALT39.StrType)le.orig_subj6_address_predir),
    Fields.InValid_orig_subj6_address_prim_name((SALT39.StrType)le.orig_subj6_address_prim_name),
    Fields.InValid_orig_subj6_address_suffix((SALT39.StrType)le.orig_subj6_address_suffix),
    Fields.InValid_orig_subj6_address_postdir((SALT39.StrType)le.orig_subj6_address_postdir),
    Fields.InValid_orig_subj6_address_unit_desig((SALT39.StrType)le.orig_subj6_address_unit_desig),
    Fields.InValid_orig_subj6_address_sec_range((SALT39.StrType)le.orig_subj6_address_sec_range),
    Fields.InValid_orig_subj6_address_city((SALT39.StrType)le.orig_subj6_address_city),
    Fields.InValid_orig_subj6_address_st((SALT39.StrType)le.orig_subj6_address_st),
    Fields.InValid_orig_subj6_address_z5((SALT39.StrType)le.orig_subj6_address_z5),
    Fields.InValid_orig_subj6_address_z4((SALT39.StrType)le.orig_subj6_address_z4),
    Fields.InValid_orig_subj6_phone((SALT39.StrType)le.orig_subj6_phone),
    Fields.InValid_orig_subj6_work_phone((SALT39.StrType)le.orig_subj6_work_phone),
    Fields.InValid_orig_subj6_business_title((SALT39.StrType)le.orig_subj6_business_title),
    Fields.InValid_orig_subj6_email((SALT39.StrType)le.orig_subj6_email),
    Fields.InValid_orig_subj6_company_name((SALT39.StrType)le.orig_subj6_company_name),
    Fields.InValid_orig_subj6_fein((SALT39.StrType)le.orig_subj6_fein),
    Fields.InValid_orig_subj7_first_name((SALT39.StrType)le.orig_subj7_first_name),
    Fields.InValid_orig_subj7_middle_name((SALT39.StrType)le.orig_subj7_middle_name),
    Fields.InValid_orig_subj7_last_name((SALT39.StrType)le.orig_subj7_last_name),
    Fields.InValid_orig_subj7_suffix_name((SALT39.StrType)le.orig_subj7_suffix_name),
    Fields.InValid_orig_subj7_full_name((SALT39.StrType)le.orig_subj7_full_name),
    Fields.InValid_orig_subj7_ssn((SALT39.StrType)le.orig_subj7_ssn),
    Fields.InValid_orig_subj7_dob((SALT39.StrType)le.orig_subj7_dob),
    Fields.InValid_orig_subj7_dl_num((SALT39.StrType)le.orig_subj7_dl_num),
    Fields.InValid_orig_subj7_dl_state((SALT39.StrType)le.orig_subj7_dl_state),
    Fields.InValid_orig_subj7_former_last_name((SALT39.StrType)le.orig_subj7_former_last_name),
    Fields.InValid_orig_subj7_address_addressline1((SALT39.StrType)le.orig_subj7_address_addressline1),
    Fields.InValid_orig_subj7_address_addressline2((SALT39.StrType)le.orig_subj7_address_addressline2),
    Fields.InValid_orig_subj7_address_prim_range((SALT39.StrType)le.orig_subj7_address_prim_range),
    Fields.InValid_orig_subj7_address_predir((SALT39.StrType)le.orig_subj7_address_predir),
    Fields.InValid_orig_subj7_address_prim_name((SALT39.StrType)le.orig_subj7_address_prim_name),
    Fields.InValid_orig_subj7_address_suffix((SALT39.StrType)le.orig_subj7_address_suffix),
    Fields.InValid_orig_subj7_address_postdir((SALT39.StrType)le.orig_subj7_address_postdir),
    Fields.InValid_orig_subj7_address_unit_desig((SALT39.StrType)le.orig_subj7_address_unit_desig),
    Fields.InValid_orig_subj7_address_sec_range((SALT39.StrType)le.orig_subj7_address_sec_range),
    Fields.InValid_orig_subj7_address_city((SALT39.StrType)le.orig_subj7_address_city),
    Fields.InValid_orig_subj7_address_st((SALT39.StrType)le.orig_subj7_address_st),
    Fields.InValid_orig_subj7_address_z5((SALT39.StrType)le.orig_subj7_address_z5),
    Fields.InValid_orig_subj7_address_z4((SALT39.StrType)le.orig_subj7_address_z4),
    Fields.InValid_orig_subj7_phone((SALT39.StrType)le.orig_subj7_phone),
    Fields.InValid_orig_subj7_work_phone((SALT39.StrType)le.orig_subj7_work_phone),
    Fields.InValid_orig_subj7_business_title((SALT39.StrType)le.orig_subj7_business_title),
    Fields.InValid_orig_subj7_email((SALT39.StrType)le.orig_subj7_email),
    Fields.InValid_orig_subj7_company_name((SALT39.StrType)le.orig_subj7_company_name),
    Fields.InValid_orig_subj7_fein((SALT39.StrType)le.orig_subj7_fein),
    Fields.InValid_orig_subj8_first_name((SALT39.StrType)le.orig_subj8_first_name),
    Fields.InValid_orig_subj8_middle_name((SALT39.StrType)le.orig_subj8_middle_name),
    Fields.InValid_orig_subj8_last_name((SALT39.StrType)le.orig_subj8_last_name),
    Fields.InValid_orig_subj8_suffix_name((SALT39.StrType)le.orig_subj8_suffix_name),
    Fields.InValid_orig_subj8_full_name((SALT39.StrType)le.orig_subj8_full_name),
    Fields.InValid_orig_subj8_ssn((SALT39.StrType)le.orig_subj8_ssn),
    Fields.InValid_orig_subj8_dob((SALT39.StrType)le.orig_subj8_dob),
    Fields.InValid_orig_subj8_dl_num((SALT39.StrType)le.orig_subj8_dl_num),
    Fields.InValid_orig_subj8_dl_state((SALT39.StrType)le.orig_subj8_dl_state),
    Fields.InValid_orig_subj8_former_last_name((SALT39.StrType)le.orig_subj8_former_last_name),
    Fields.InValid_orig_subj8_address_addressline1((SALT39.StrType)le.orig_subj8_address_addressline1),
    Fields.InValid_orig_subj8_address_addressline2((SALT39.StrType)le.orig_subj8_address_addressline2),
    Fields.InValid_orig_subj8_address_prim_range((SALT39.StrType)le.orig_subj8_address_prim_range),
    Fields.InValid_orig_subj8_address_predir((SALT39.StrType)le.orig_subj8_address_predir),
    Fields.InValid_orig_subj8_address_prim_name((SALT39.StrType)le.orig_subj8_address_prim_name),
    Fields.InValid_orig_subj8_address_suffix((SALT39.StrType)le.orig_subj8_address_suffix),
    Fields.InValid_orig_subj8_address_postdir((SALT39.StrType)le.orig_subj8_address_postdir),
    Fields.InValid_orig_subj8_address_unit_desig((SALT39.StrType)le.orig_subj8_address_unit_desig),
    Fields.InValid_orig_subj8_address_sec_range((SALT39.StrType)le.orig_subj8_address_sec_range),
    Fields.InValid_orig_subj8_address_city((SALT39.StrType)le.orig_subj8_address_city),
    Fields.InValid_orig_subj8_address_st((SALT39.StrType)le.orig_subj8_address_st),
    Fields.InValid_orig_subj8_address_z5((SALT39.StrType)le.orig_subj8_address_z5),
    Fields.InValid_orig_subj8_address_z4((SALT39.StrType)le.orig_subj8_address_z4),
    Fields.InValid_orig_subj8_phone((SALT39.StrType)le.orig_subj8_phone),
    Fields.InValid_orig_subj8_work_phone((SALT39.StrType)le.orig_subj8_work_phone),
    Fields.InValid_orig_subj8_business_title((SALT39.StrType)le.orig_subj8_business_title),
    Fields.InValid_orig_subj8_email((SALT39.StrType)le.orig_subj8_email),
    Fields.InValid_orig_subj8_company_name((SALT39.StrType)le.orig_subj8_company_name),
    Fields.InValid_orig_subj8_fein((SALT39.StrType)le.orig_subj8_fein),
    Fields.InValid_orig_company_alternate_name((SALT39.StrType)le.orig_company_alternate_name),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,292,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','orig_suffix_name','orig_former_last_name','orig_business_title','orig_company_addressline1','orig_company_addressline2','orig_company_address_prim_range','orig_company_address_predir','orig_company_address_prim_name','orig_company_address_suffix','orig_company_address_postdir','orig_company_address_unit_desig','Unknown','orig_company_address_sec_range','orig_company_address_st','orig_company_address_zip5','orig_company_address_zip4','orig_company_fax_number','orig_company_start_date','orig_company_years_in_business','orig_company_sic_code','orig_company_naic_code','orig_company_structure','orig_company_yearly_revenue','orig_subj2_first_name','orig_subj2_middle_name','orig_subj2_last_name','orig_subj2_suffix_name','orig_subj2_full_name','orig_subj2_ssn','orig_subj2_dob','orig_subj2_dl_num','orig_subj2_dl_state','orig_subj2_former_last_name','orig_subj2_address_addressline1','orig_subj2_address_addressline2','orig_subj2_address_prim_range','orig_subj2_address_predir','orig_subj2_address_prim_name','orig_subj2_address_suffix','orig_subj2_address_postdir','orig_subj2_address_unit_desig','orig_subj2_address_sec_range','orig_subj2_address_city','orig_subj2_address_st','orig_subj2_address_z5','orig_subj2_address_z4','orig_subj2_phone','orig_subj2_work_phone','orig_subj2_business_title','orig_subj3_first_name','orig_subj3_middle_name','orig_subj3_last_name','orig_subj3_suffix_name','orig_subj3_full_name','orig_subj3_ssn','orig_subj3_dob','orig_subj3_dl_num','orig_subj3_dl_state','orig_subj3_former_last_name','orig_subj3_address_addressline1','orig_subj3_address_addressline2','orig_subj3_address_prim_range','orig_subj3_address_predir','orig_subj3_address_prim_name','orig_subj3_address_suffix','orig_subj3_address_postdir','orig_subj3_address_unit_desig','orig_subj3_address_sec_range','orig_subj3_address_city','orig_subj3_address_st','orig_subj3_address_z5','orig_subj3_address_z4','orig_subj3_phone','orig_subj3_work_phone','orig_subj3_business_title','orig_email','orig_subj2_email','orig_subj2_company_name','orig_subj2_fein','orig_subj3_email','orig_subj3_company_name','orig_subj3_fein','orig_subj4_first_name','orig_subj4_middle_name','orig_subj4_last_name','orig_subj4_suffix_name','orig_subj4_full_name','orig_subj4_ssn','orig_subj4_dob','orig_subj4_dl_num','orig_subj4_dl_state','orig_subj4_former_last_name','orig_subj4_address_addressline1','orig_subj4_address_addressline2','orig_subj4_address_prim_range','orig_subj4_address_predir','orig_subj4_address_prim_name','orig_subj4_address_suffix','orig_subj4_address_postdir','orig_subj4_address_unit_desig','orig_subj4_address_sec_range','orig_subj4_address_city','orig_subj4_address_st','orig_subj4_address_z5','orig_subj4_address_z4','orig_subj4_phone','orig_subj4_work_phone','orig_subj4_business_title','orig_subj4_email','orig_subj4_company_name','orig_subj4_fein','orig_subj5_first_name','orig_subj5_middle_name','orig_subj5_last_name','orig_subj5_suffix_name','orig_subj5_full_name','orig_subj5_ssn','orig_subj5_dob','orig_subj5_dl_num','orig_subj5_dl_state','orig_subj5_former_last_name','orig_subj5_address_addressline1','orig_subj5_address_addressline2','orig_subj5_address_prim_range','orig_subj5_address_predir','orig_subj5_address_prim_name','orig_subj5_address_suffix','orig_subj5_address_postdir','orig_subj5_address_unit_desig','orig_subj5_address_sec_range','orig_subj5_address_city','orig_subj5_address_st','orig_subj5_address_z5','orig_subj5_address_z4','orig_subj5_phone','orig_subj5_work_phone','orig_subj5_business_title','orig_subj5_email','orig_subj5_company_name','orig_subj5_fein','orig_subj6_first_name','orig_subj6_middle_name','orig_subj6_last_name','orig_subj6_suffix_name','orig_subj6_full_name','orig_subj6_ssn','orig_subj6_dob','orig_subj6_dl_num','orig_subj6_dl_state','orig_subj6_former_last_name','orig_subj6_address_addressline1','orig_subj6_address_addressline2','orig_subj6_address_prim_range','orig_subj6_address_predir','orig_subj6_address_prim_name','orig_subj6_address_suffix','orig_subj6_address_postdir','orig_subj6_address_unit_desig','orig_subj6_address_sec_range','orig_subj6_address_city','orig_subj6_address_st','orig_subj6_address_z5','orig_subj6_address_z4','orig_subj6_phone','orig_subj6_work_phone','orig_subj6_business_title','orig_subj6_email','orig_subj6_company_name','orig_subj6_fein','orig_subj7_first_name','orig_subj7_middle_name','orig_subj7_last_name','orig_subj7_suffix_name','orig_subj7_full_name','orig_subj7_ssn','orig_subj7_dob','orig_subj7_dl_num','orig_subj7_dl_state','orig_subj7_former_last_name','orig_subj7_address_addressline1','orig_subj7_address_addressline2','orig_subj7_address_prim_range','orig_subj7_address_predir','orig_subj7_address_prim_name','orig_subj7_address_suffix','orig_subj7_address_postdir','orig_subj7_address_unit_desig','orig_subj7_address_sec_range','orig_subj7_address_city','orig_subj7_address_st','orig_subj7_address_z5','orig_subj7_address_z4','orig_subj7_phone','orig_subj7_work_phone','orig_subj7_business_title','orig_subj7_email','orig_subj7_company_name','orig_subj7_fein','orig_subj8_first_name','orig_subj8_middle_name','orig_subj8_last_name','orig_subj8_suffix_name','orig_subj8_full_name','orig_subj8_ssn','orig_subj8_dob','orig_subj8_dl_num','orig_subj8_dl_state','orig_subj8_former_last_name','orig_subj8_address_addressline1','orig_subj8_address_addressline2','orig_subj8_address_prim_range','orig_subj8_address_predir','orig_subj8_address_prim_name','orig_subj8_address_suffix','orig_subj8_address_postdir','orig_subj8_address_unit_desig','orig_subj8_address_sec_range','orig_subj8_address_city','orig_subj8_address_st','orig_subj8_address_z5','orig_subj8_address_z4','orig_subj8_phone','orig_subj8_work_phone','orig_subj8_business_title','orig_subj8_email','orig_subj8_company_name','orig_subj8_fein','orig_company_alternate_name');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_datetime_stamp(TotalErrors.ErrorNum),Fields.InValidMessage_orig_global_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_product_cd(TotalErrors.ErrorNum),Fields.InValidMessage_orig_method(TotalErrors.ErrorNum),Fields.InValidMessage_orig_vertical(TotalErrors.ErrorNum),Fields.InValidMessage_orig_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_transaction_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_job_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sequence_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_bdl(TotalErrors.ErrorNum),Fields.InValidMessage_orig_did(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_reference_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip_address_initiated(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip_address_executed(TotalErrors.ErrorNum),Fields.InValidMessage_orig_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ucc_original_filing_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_domain_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_glb_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fcra_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_process_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_address_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_fax_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_start_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_years_in_business(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_sic_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_naic_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_structure(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_yearly_revenue(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj2_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj3_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj4_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj5_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj6_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj7_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_suffix_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_addressline1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_addressline2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_z5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_address_z4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_business_title(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_subj8_fein(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_alternate_name(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nonfcra_Batch, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
