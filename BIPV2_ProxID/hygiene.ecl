IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_DOT_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source))'', MAX(GROUP,h.source));
    NumberOfRecords := COUNT(GROUP);
    populated_active_duns_number_cnt := COUNT(GROUP,h.active_duns_number <> (TYPEOF(h.active_duns_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_active_enterprise_number_cnt := COUNT(GROUP,h.active_enterprise_number <> (TYPEOF(h.active_enterprise_number))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_active_domestic_corp_key_cnt := COUNT(GROUP,h.active_domestic_corp_key <> (TYPEOF(h.active_domestic_corp_key))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_enterprise_number_cnt := COUNT(GROUP,h.hist_enterprise_number <> (TYPEOF(h.hist_enterprise_number))'');
    populated_hist_enterprise_number_pcnt := AVE(GROUP,IF(h.hist_enterprise_number = (TYPEOF(h.hist_enterprise_number))'',0,100));
    maxlength_hist_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_enterprise_number)));
    avelength_hist_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_enterprise_number)),h.hist_enterprise_number<>(typeof(h.hist_enterprise_number))'');
    populated_hist_duns_number_cnt := COUNT(GROUP,h.hist_duns_number <> (TYPEOF(h.hist_duns_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_hist_domestic_corp_key_cnt := COUNT(GROUP,h.hist_domestic_corp_key <> (TYPEOF(h.hist_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_cnt := COUNT(GROUP,h.foreign_corp_key <> (TYPEOF(h.foreign_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_cnt := COUNT(GROUP,h.unk_corp_key <> (TYPEOF(h.unk_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_ebr_file_number_cnt := COUNT(GROUP,h.ebr_file_number <> (TYPEOF(h.ebr_file_number))'');
    populated_ebr_file_number_pcnt := AVE(GROUP,IF(h.ebr_file_number = (TYPEOF(h.ebr_file_number))'',0,100));
    maxlength_ebr_file_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ebr_file_number)));
    avelength_ebr_file_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ebr_file_number)),h.ebr_file_number<>(typeof(h.ebr_file_number))'');
    populated_company_fein_cnt := COUNT(GROUP,h.company_fein <> (TYPEOF(h.company_fein))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_cnp_name_cnt := COUNT(GROUP,h.cnp_name <> (TYPEOF(h.cnp_name))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_company_name_type_raw_cnt := COUNT(GROUP,h.company_name_type_raw <> (TYPEOF(h.company_name_type_raw))'');
    populated_company_name_type_raw_pcnt := AVE(GROUP,IF(h.company_name_type_raw = (TYPEOF(h.company_name_type_raw))'',0,100));
    maxlength_company_name_type_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_raw)));
    avelength_company_name_type_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_raw)),h.company_name_type_raw<>(typeof(h.company_name_type_raw))'');
    populated_company_name_type_derived_cnt := COUNT(GROUP,h.company_name_type_derived <> (TYPEOF(h.company_name_type_derived))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_cnp_hasnumber_cnt := COUNT(GROUP,h.cnp_hasnumber <> (TYPEOF(h.cnp_hasnumber))'');
    populated_cnp_hasnumber_pcnt := AVE(GROUP,IF(h.cnp_hasnumber = (TYPEOF(h.cnp_hasnumber))'',0,100));
    maxlength_cnp_hasnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_hasnumber)));
    avelength_cnp_hasnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_hasnumber)),h.cnp_hasnumber<>(typeof(h.cnp_hasnumber))'');
    populated_cnp_number_cnt := COUNT(GROUP,h.cnp_number <> (TYPEOF(h.cnp_number))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_cnp_btype_cnt := COUNT(GROUP,h.cnp_btype <> (TYPEOF(h.cnp_btype))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_cnp_lowv_cnt := COUNT(GROUP,h.cnp_lowv <> (TYPEOF(h.cnp_lowv))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_cnt := COUNT(GROUP,h.cnp_translated <> (TYPEOF(h.cnp_translated))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_cnt := COUNT(GROUP,h.cnp_classid <> (TYPEOF(h.cnp_classid))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_company_foreign_domestic_cnt := COUNT(GROUP,h.company_foreign_domestic <> (TYPEOF(h.company_foreign_domestic))'');
    populated_company_foreign_domestic_pcnt := AVE(GROUP,IF(h.company_foreign_domestic = (TYPEOF(h.company_foreign_domestic))'',0,100));
    maxlength_company_foreign_domestic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_foreign_domestic)));
    avelength_company_foreign_domestic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_foreign_domestic)),h.company_foreign_domestic<>(typeof(h.company_foreign_domestic))'');
    populated_company_bdid_cnt := COUNT(GROUP,h.company_bdid <> (TYPEOF(h.company_bdid))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_company_phone_cnt := COUNT(GROUP,h.company_phone <> (TYPEOF(h.company_phone))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_prim_name_derived_cnt := COUNT(GROUP,h.prim_name_derived <> (TYPEOF(h.prim_name_derived))'');
    populated_prim_name_derived_pcnt := AVE(GROUP,IF(h.prim_name_derived = (TYPEOF(h.prim_name_derived))'',0,100));
    maxlength_prim_name_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name_derived)));
    avelength_prim_name_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name_derived)),h.prim_name_derived<>(typeof(h.prim_name_derived))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
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
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_range_derived_cnt := COUNT(GROUP,h.prim_range_derived <> (TYPEOF(h.prim_range_derived))'');
    populated_prim_range_derived_pcnt := AVE(GROUP,IF(h.prim_range_derived = (TYPEOF(h.prim_range_derived))'',0,100));
    maxlength_prim_range_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_derived)));
    avelength_prim_range_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_derived)),h.prim_range_derived<>(typeof(h.prim_range_derived))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_active_duns_number_pcnt *  18.00 / 100 + T.Populated_active_enterprise_number_pcnt *  20.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *  19.00 / 100 + T.Populated_hist_enterprise_number_pcnt *  20.00 / 100 + T.Populated_hist_duns_number_pcnt *  18.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *  19.00 / 100 + T.Populated_foreign_corp_key_pcnt *  19.00 / 100 + T.Populated_unk_corp_key_pcnt *  19.00 / 100 + T.Populated_ebr_file_number_pcnt *  20.00 / 100 + T.Populated_company_fein_pcnt *  17.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_cnp_name_pcnt *  12.00 / 100 + T.Populated_company_name_type_raw_pcnt *   0.00 / 100 + T.Populated_company_name_type_derived_pcnt *   1.00 / 100 + T.Populated_cnp_hasnumber_pcnt *   0.00 / 100 + T.Populated_cnp_number_pcnt *  13.00 / 100 + T.Populated_cnp_btype_pcnt *   3.00 / 100 + T.Populated_cnp_lowv_pcnt *   0.00 / 100 + T.Populated_cnp_translated_pcnt *   0.00 / 100 + T.Populated_cnp_classid_pcnt *   0.00 / 100 + T.Populated_company_foreign_domestic_pcnt *   0.00 / 100 + T.Populated_company_bdid_pcnt *   0.00 / 100 + T.Populated_company_phone_pcnt *  18.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_prim_name_derived_pcnt *  11.00 / 100 + T.Populated_sec_range_pcnt *  11.00 / 100 + T.Populated_v_city_name_pcnt *  10.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *  13.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_range_derived_pcnt *  12.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *  18.00 / 10000 + le.Populated_active_enterprise_number_pcnt*ri.Populated_active_enterprise_number_pcnt *  20.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *  19.00 / 10000 + le.Populated_hist_enterprise_number_pcnt*ri.Populated_hist_enterprise_number_pcnt *  20.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *  18.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *  19.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *  19.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *  19.00 / 10000 + le.Populated_ebr_file_number_pcnt*ri.Populated_ebr_file_number_pcnt *  20.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *  17.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *  12.00 / 10000 + le.Populated_company_name_type_raw_pcnt*ri.Populated_company_name_type_raw_pcnt *   0.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   1.00 / 10000 + le.Populated_cnp_hasnumber_pcnt*ri.Populated_cnp_hasnumber_pcnt *   0.00 / 10000 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *  13.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   3.00 / 10000 + le.Populated_cnp_lowv_pcnt*ri.Populated_cnp_lowv_pcnt *   0.00 / 10000 + le.Populated_cnp_translated_pcnt*ri.Populated_cnp_translated_pcnt *   0.00 / 10000 + le.Populated_cnp_classid_pcnt*ri.Populated_cnp_classid_pcnt *   0.00 / 10000 + le.Populated_company_foreign_domestic_pcnt*ri.Populated_company_foreign_domestic_pcnt *   0.00 / 10000 + le.Populated_company_bdid_pcnt*ri.Populated_company_bdid_pcnt *   0.00 / 10000 + le.Populated_company_phone_pcnt*ri.Populated_company_phone_pcnt *  18.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_prim_name_derived_pcnt*ri.Populated_prim_name_derived_pcnt *  11.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *  11.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *  10.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   5.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  13.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_prim_range_derived_pcnt*ri.Populated_prim_range_derived_pcnt *  12.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'active_duns_number','active_enterprise_number','active_domestic_corp_key','hist_enterprise_number','hist_duns_number','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','ebr_file_number','company_fein','company_name','cnp_name','company_name_type_raw','company_name_type_derived','cnp_hasnumber','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_foreign_domestic','company_bdid','company_phone','prim_name','prim_name_derived','sec_range','v_city_name','st','zip','prim_range','prim_range_derived','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_active_duns_number_pcnt,le.populated_active_enterprise_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_enterprise_number_pcnt,le.populated_hist_duns_number_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_ebr_file_number_pcnt,le.populated_company_fein_pcnt,le.populated_company_name_pcnt,le.populated_cnp_name_pcnt,le.populated_company_name_type_raw_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_cnp_hasnumber_pcnt,le.populated_cnp_number_pcnt,le.populated_cnp_btype_pcnt,le.populated_cnp_lowv_pcnt,le.populated_cnp_translated_pcnt,le.populated_cnp_classid_pcnt,le.populated_company_foreign_domestic_pcnt,le.populated_company_bdid_pcnt,le.populated_company_phone_pcnt,le.populated_prim_name_pcnt,le.populated_prim_name_derived_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_prim_range_pcnt,le.populated_prim_range_derived_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_active_duns_number,le.maxlength_active_enterprise_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_enterprise_number,le.maxlength_hist_duns_number,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_ebr_file_number,le.maxlength_company_fein,le.maxlength_company_name,le.maxlength_cnp_name,le.maxlength_company_name_type_raw,le.maxlength_company_name_type_derived,le.maxlength_cnp_hasnumber,le.maxlength_cnp_number,le.maxlength_cnp_btype,le.maxlength_cnp_lowv,le.maxlength_cnp_translated,le.maxlength_cnp_classid,le.maxlength_company_foreign_domestic,le.maxlength_company_bdid,le.maxlength_company_phone,le.maxlength_prim_name,le.maxlength_prim_name_derived,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_prim_range,le.maxlength_prim_range_derived,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_active_duns_number,le.avelength_active_enterprise_number,le.avelength_active_domestic_corp_key,le.avelength_hist_enterprise_number,le.avelength_hist_duns_number,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_ebr_file_number,le.avelength_company_fein,le.avelength_company_name,le.avelength_cnp_name,le.avelength_company_name_type_raw,le.avelength_company_name_type_derived,le.avelength_cnp_hasnumber,le.avelength_cnp_number,le.avelength_cnp_btype,le.avelength_cnp_lowv,le.avelength_cnp_translated,le.avelength_cnp_classid,le.avelength_company_foreign_domestic,le.avelength_company_bdid,le.avelength_company_phone,le.avelength_prim_name,le.avelength_prim_name_derived,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_prim_range,le.avelength_prim_range_derived,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 33, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.active_duns_number),TRIM((SALT311.StrType)le.active_enterprise_number),TRIM((SALT311.StrType)le.active_domestic_corp_key),TRIM((SALT311.StrType)le.hist_enterprise_number),TRIM((SALT311.StrType)le.hist_duns_number),TRIM((SALT311.StrType)le.hist_domestic_corp_key),TRIM((SALT311.StrType)le.foreign_corp_key),TRIM((SALT311.StrType)le.unk_corp_key),TRIM((SALT311.StrType)le.ebr_file_number),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.cnp_name),TRIM((SALT311.StrType)le.company_name_type_raw),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.cnp_hasnumber),TRIM((SALT311.StrType)le.cnp_number),TRIM((SALT311.StrType)le.cnp_btype),TRIM((SALT311.StrType)le.cnp_lowv),TRIM((SALT311.StrType)le.cnp_translated),TRIM((SALT311.StrType)le.cnp_classid),TRIM((SALT311.StrType)le.company_foreign_domestic),TRIM((SALT311.StrType)le.company_bdid),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_name_derived),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_range_derived),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,33,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 33);
  SELF.FldNo2 := 1 + (C % 33);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.active_duns_number),TRIM((SALT311.StrType)le.active_enterprise_number),TRIM((SALT311.StrType)le.active_domestic_corp_key),TRIM((SALT311.StrType)le.hist_enterprise_number),TRIM((SALT311.StrType)le.hist_duns_number),TRIM((SALT311.StrType)le.hist_domestic_corp_key),TRIM((SALT311.StrType)le.foreign_corp_key),TRIM((SALT311.StrType)le.unk_corp_key),TRIM((SALT311.StrType)le.ebr_file_number),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.cnp_name),TRIM((SALT311.StrType)le.company_name_type_raw),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.cnp_hasnumber),TRIM((SALT311.StrType)le.cnp_number),TRIM((SALT311.StrType)le.cnp_btype),TRIM((SALT311.StrType)le.cnp_lowv),TRIM((SALT311.StrType)le.cnp_translated),TRIM((SALT311.StrType)le.cnp_classid),TRIM((SALT311.StrType)le.company_foreign_domestic),TRIM((SALT311.StrType)le.company_bdid),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_name_derived),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_range_derived),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.active_duns_number),TRIM((SALT311.StrType)le.active_enterprise_number),TRIM((SALT311.StrType)le.active_domestic_corp_key),TRIM((SALT311.StrType)le.hist_enterprise_number),TRIM((SALT311.StrType)le.hist_duns_number),TRIM((SALT311.StrType)le.hist_domestic_corp_key),TRIM((SALT311.StrType)le.foreign_corp_key),TRIM((SALT311.StrType)le.unk_corp_key),TRIM((SALT311.StrType)le.ebr_file_number),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.cnp_name),TRIM((SALT311.StrType)le.company_name_type_raw),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.cnp_hasnumber),TRIM((SALT311.StrType)le.cnp_number),TRIM((SALT311.StrType)le.cnp_btype),TRIM((SALT311.StrType)le.cnp_lowv),TRIM((SALT311.StrType)le.cnp_translated),TRIM((SALT311.StrType)le.cnp_classid),TRIM((SALT311.StrType)le.company_foreign_domestic),TRIM((SALT311.StrType)le.company_bdid),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_name_derived),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_range_derived),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),33*33,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'active_duns_number'}
      ,{2,'active_enterprise_number'}
      ,{3,'active_domestic_corp_key'}
      ,{4,'hist_enterprise_number'}
      ,{5,'hist_duns_number'}
      ,{6,'hist_domestic_corp_key'}
      ,{7,'foreign_corp_key'}
      ,{8,'unk_corp_key'}
      ,{9,'ebr_file_number'}
      ,{10,'company_fein'}
      ,{11,'company_name'}
      ,{12,'cnp_name'}
      ,{13,'company_name_type_raw'}
      ,{14,'company_name_type_derived'}
      ,{15,'cnp_hasnumber'}
      ,{16,'cnp_number'}
      ,{17,'cnp_btype'}
      ,{18,'cnp_lowv'}
      ,{19,'cnp_translated'}
      ,{20,'cnp_classid'}
      ,{21,'company_foreign_domestic'}
      ,{22,'company_bdid'}
      ,{23,'company_phone'}
      ,{24,'prim_name'}
      ,{25,'prim_name_derived'}
      ,{26,'sec_range'}
      ,{27,'v_city_name'}
      ,{28,'st'}
      ,{29,'zip'}
      ,{30,'prim_range'}
      ,{31,'prim_range_derived'}
      ,{32,'dt_first_seen'}
      ,{33,'dt_last_seen'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_active_duns_number((SALT311.StrType)le.active_duns_number),
    Fields.InValid_active_enterprise_number((SALT311.StrType)le.active_enterprise_number),
    Fields.InValid_active_domestic_corp_key((SALT311.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_enterprise_number((SALT311.StrType)le.hist_enterprise_number),
    Fields.InValid_hist_duns_number((SALT311.StrType)le.hist_duns_number),
    Fields.InValid_hist_domestic_corp_key((SALT311.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT311.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT311.StrType)le.unk_corp_key),
    Fields.InValid_ebr_file_number((SALT311.StrType)le.ebr_file_number),
    Fields.InValid_company_fein((SALT311.StrType)le.company_fein),
    Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Fields.InValid_cnp_name((SALT311.StrType)le.cnp_name),
    Fields.InValid_company_name_type_raw((SALT311.StrType)le.company_name_type_raw),
    Fields.InValid_company_name_type_derived((SALT311.StrType)le.company_name_type_derived),
    Fields.InValid_cnp_hasnumber((SALT311.StrType)le.cnp_hasnumber),
    Fields.InValid_cnp_number((SALT311.StrType)le.cnp_number),
    Fields.InValid_cnp_btype((SALT311.StrType)le.cnp_btype),
    Fields.InValid_cnp_lowv((SALT311.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT311.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT311.StrType)le.cnp_classid),
    Fields.InValid_company_foreign_domestic((SALT311.StrType)le.company_foreign_domestic),
    Fields.InValid_company_bdid((SALT311.StrType)le.company_bdid),
    Fields.InValid_company_phone((SALT311.StrType)le.company_phone),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_prim_name_derived((SALT311.StrType)le.prim_name_derived),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_prim_range_derived((SALT311.StrType)le.prim_range_derived),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,36,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Noblanks','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Noblanks','Unknown','Unknown','alpha','number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_ebr_file_number(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_hasnumber(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_company_foreign_domestic(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name_derived(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range_derived(TotalErrors.ErrorNum),'','','',Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,Proxid);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,Proxid,source);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(BIPV2_ProxID, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
