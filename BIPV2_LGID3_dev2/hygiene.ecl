IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_LGID3) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_nodes_total_pcnt := AVE(GROUP,IF(h.nodes_total = (TYPEOF(h.nodes_total))'',0,100));
    maxlength_nodes_total := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.nodes_total)));
    avelength_nodes_total := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.nodes_total)),h.nodes_total<>(typeof(h.nodes_total))'');
    populated_sbfe_id_pcnt := AVE(GROUP,IF(h.sbfe_id = (TYPEOF(h.sbfe_id))'',0,100));
    maxlength_sbfe_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sbfe_id)));
    avelength_sbfe_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sbfe_id)),h.sbfe_id<>(typeof(h.sbfe_id))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_cnp_hasNumber_pcnt := AVE(GROUP,IF(h.cnp_hasNumber = (TYPEOF(h.cnp_hasNumber))'',0,100));
    maxlength_cnp_hasNumber := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_hasNumber)));
    avelength_cnp_hasNumber := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_hasNumber)),h.cnp_hasNumber<>(typeof(h.cnp_hasNumber))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_nodes_total_pcnt *   0.00 / 100 + T.Populated_sbfe_id_pcnt *  26.00 / 100 + T.Populated_source_record_id_pcnt *  26.00 / 100 + T.Populated_company_name_pcnt *  26.00 / 100 + T.Populated_cnp_number_pcnt *  13.00 / 100 + T.Populated_active_duns_number_pcnt *  27.00 / 100 + T.Populated_duns_number_pcnt *  26.00 / 100 + T.Populated_company_fein_pcnt *  26.00 / 100 + T.Populated_company_inc_state_pcnt *   6.00 / 100 + T.Populated_company_charter_number_pcnt *  26.00 / 100 + T.Populated_cnp_btype_pcnt *   3.00 / 100 + T.Populated_company_name_type_derived_pcnt *   0.00 / 100 + T.Populated_hist_duns_number_pcnt *   0.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_foreign_corp_key_pcnt *   0.00 / 100 + T.Populated_unk_corp_key_pcnt *   0.00 / 100 + T.Populated_cnp_name_pcnt *   0.00 / 100 + T.Populated_cnp_hasNumber_pcnt *   0.00 / 100 + T.Populated_cnp_lowv_pcnt *   0.00 / 100 + T.Populated_cnp_translated_pcnt *   0.00 / 100 + T.Populated_cnp_classid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_nodes_total_pcnt*ri.Populated_nodes_total_pcnt *   0.00 / 10000 + le.Populated_sbfe_id_pcnt*ri.Populated_sbfe_id_pcnt *  26.00 / 10000 + le.Populated_source_record_id_pcnt*ri.Populated_source_record_id_pcnt *  26.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *  26.00 / 10000 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *  13.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *  27.00 / 10000 + le.Populated_duns_number_pcnt*ri.Populated_duns_number_pcnt *  26.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *  26.00 / 10000 + le.Populated_company_inc_state_pcnt*ri.Populated_company_inc_state_pcnt *   6.00 / 10000 + le.Populated_company_charter_number_pcnt*ri.Populated_company_charter_number_pcnt *  26.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   3.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   0.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *   0.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *   0.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *   0.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *   0.00 / 10000 + le.Populated_cnp_hasNumber_pcnt*ri.Populated_cnp_hasNumber_pcnt *   0.00 / 10000 + le.Populated_cnp_lowv_pcnt*ri.Populated_cnp_lowv_pcnt *   0.00 / 10000 + le.Populated_cnp_translated_pcnt*ri.Populated_cnp_translated_pcnt *   0.00 / 10000 + le.Populated_cnp_classid_pcnt*ri.Populated_cnp_classid_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'nodes_total','sbfe_id','source_record_id','company_name','cnp_number','active_duns_number','duns_number','company_fein','company_inc_state','company_charter_number','cnp_btype','company_name_type_derived','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','cnp_name','cnp_hasNumber','cnp_lowv','cnp_translated','cnp_classid','prim_range','prim_name','sec_range','v_city_name','st','zip','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_nodes_total_pcnt,le.populated_sbfe_id_pcnt,le.populated_source_record_id_pcnt,le.populated_company_name_pcnt,le.populated_cnp_number_pcnt,le.populated_active_duns_number_pcnt,le.populated_duns_number_pcnt,le.populated_company_fein_pcnt,le.populated_company_inc_state_pcnt,le.populated_company_charter_number_pcnt,le.populated_cnp_btype_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_hist_duns_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_cnp_name_pcnt,le.populated_cnp_hasNumber_pcnt,le.populated_cnp_lowv_pcnt,le.populated_cnp_translated_pcnt,le.populated_cnp_classid_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_nodes_total,le.maxlength_sbfe_id,le.maxlength_source_record_id,le.maxlength_company_name,le.maxlength_cnp_number,le.maxlength_active_duns_number,le.maxlength_duns_number,le.maxlength_company_fein,le.maxlength_company_inc_state,le.maxlength_company_charter_number,le.maxlength_cnp_btype,le.maxlength_company_name_type_derived,le.maxlength_hist_duns_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_cnp_name,le.maxlength_cnp_hasNumber,le.maxlength_cnp_lowv,le.maxlength_cnp_translated,le.maxlength_cnp_classid,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_nodes_total,le.avelength_sbfe_id,le.avelength_source_record_id,le.avelength_company_name,le.avelength_cnp_number,le.avelength_active_duns_number,le.avelength_duns_number,le.avelength_company_fein,le.avelength_company_inc_state,le.avelength_company_charter_number,le.avelength_cnp_btype,le.avelength_company_name_type_derived,le.avelength_hist_duns_number,le.avelength_active_domestic_corp_key,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_cnp_name,le.avelength_cnp_hasNumber,le.avelength_cnp_lowv,le.avelength_cnp_translated,le.avelength_cnp_classid,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 30, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LGID3;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.nodes_total),TRIM((SALT30.StrType)le.sbfe_id),TRIM((SALT30.StrType)le.source_record_id),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.cnp_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.duns_number),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_inc_state),TRIM((SALT30.StrType)le.company_charter_number),TRIM((SALT30.StrType)le.cnp_btype),TRIM((SALT30.StrType)le.company_name_type_derived),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.cnp_hasNumber),TRIM((SALT30.StrType)le.cnp_lowv),TRIM((SALT30.StrType)le.cnp_translated),TRIM((SALT30.StrType)le.cnp_classid),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.nodes_total),TRIM((SALT30.StrType)le.sbfe_id),TRIM((SALT30.StrType)le.source_record_id),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.cnp_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.duns_number),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_inc_state),TRIM((SALT30.StrType)le.company_charter_number),TRIM((SALT30.StrType)le.cnp_btype),TRIM((SALT30.StrType)le.company_name_type_derived),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.cnp_hasNumber),TRIM((SALT30.StrType)le.cnp_lowv),TRIM((SALT30.StrType)le.cnp_translated),TRIM((SALT30.StrType)le.cnp_classid),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.nodes_total),TRIM((SALT30.StrType)le.sbfe_id),TRIM((SALT30.StrType)le.source_record_id),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.cnp_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.duns_number),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_inc_state),TRIM((SALT30.StrType)le.company_charter_number),TRIM((SALT30.StrType)le.cnp_btype),TRIM((SALT30.StrType)le.company_name_type_derived),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.cnp_hasNumber),TRIM((SALT30.StrType)le.cnp_lowv),TRIM((SALT30.StrType)le.cnp_translated),TRIM((SALT30.StrType)le.cnp_classid),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'nodes_total'}
      ,{2,'sbfe_id'}
      ,{3,'source_record_id'}
      ,{4,'company_name'}
      ,{5,'cnp_number'}
      ,{6,'active_duns_number'}
      ,{7,'duns_number'}
      ,{8,'company_fein'}
      ,{9,'company_inc_state'}
      ,{10,'company_charter_number'}
      ,{11,'cnp_btype'}
      ,{12,'company_name_type_derived'}
      ,{13,'hist_duns_number'}
      ,{14,'active_domestic_corp_key'}
      ,{15,'hist_domestic_corp_key'}
      ,{16,'foreign_corp_key'}
      ,{17,'unk_corp_key'}
      ,{18,'cnp_name'}
      ,{19,'cnp_hasNumber'}
      ,{20,'cnp_lowv'}
      ,{21,'cnp_translated'}
      ,{22,'cnp_classid'}
      ,{23,'prim_range'}
      ,{24,'prim_name'}
      ,{25,'sec_range'}
      ,{26,'v_city_name'}
      ,{27,'st'}
      ,{28,'zip'}
      ,{29,'dt_first_seen'}
      ,{30,'dt_last_seen'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_nodes_total((SALT30.StrType)le.nodes_total),
    Fields.InValid_sbfe_id((SALT30.StrType)le.sbfe_id),
    Fields.InValid_source_record_id((SALT30.StrType)le.source_record_id),
    Fields.InValid_company_name((SALT30.StrType)le.company_name),
    Fields.InValid_cnp_number((SALT30.StrType)le.cnp_number),
    Fields.InValid_active_duns_number((SALT30.StrType)le.active_duns_number),
    Fields.InValid_duns_number((SALT30.StrType)le.duns_number),
    0, // Uncleanable field
    Fields.InValid_company_fein((SALT30.StrType)le.company_fein),
    Fields.InValid_company_inc_state((SALT30.StrType)le.company_inc_state),
    Fields.InValid_company_charter_number((SALT30.StrType)le.company_charter_number),
    Fields.InValid_cnp_btype((SALT30.StrType)le.cnp_btype),
    Fields.InValid_company_name_type_derived((SALT30.StrType)le.company_name_type_derived),
    Fields.InValid_hist_duns_number((SALT30.StrType)le.hist_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT30.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_domestic_corp_key((SALT30.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT30.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT30.StrType)le.unk_corp_key),
    Fields.InValid_cnp_name((SALT30.StrType)le.cnp_name),
    Fields.InValid_cnp_hasNumber((SALT30.StrType)le.cnp_hasNumber),
    Fields.InValid_cnp_lowv((SALT30.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT30.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT30.StrType)le.cnp_classid),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,31,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'not_hrchy','Unknown','Unknown','Noblanks','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_nodes_total(TotalErrors.ErrorNum),Fields.InValidMessage_sbfe_id(TotalErrors.ErrorNum),Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),'',Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_hasNumber(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT30.mac_srcfrequency_outliers(h,company_inc_state,source,company_inc_state_outliers)
  SALT30.mac_srcfrequency_outliers(h,company_charter_number,source,company_charter_number_outliers)
  SALT30.mac_srcfrequency_outliers(h,company_name,source,company_name_outliers)
  SALT30.mac_srcfrequency_outliers(h,cnp_btype,source,cnp_btype_outliers)
  SALT30.mac_srcfrequency_outliers(h,company_fein,source,company_fein_outliers)
EXPORT AllOutliers := company_inc_state_outliers + company_charter_number_outliers + company_name_outliers + cnp_btype_outliers + company_fein_outliers;
//We have LGID3 specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT30.MOD_ClusterStats.Counts(h,LGID3);
EXPORT ClusterSrc := SALT30.MOD_ClusterStats.Sources(h,LGID3,source);
END;
