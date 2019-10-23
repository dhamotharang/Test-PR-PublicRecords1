IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_POWID) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_RID_If_Big_Biz_pcnt := AVE(GROUP,IF(h.RID_If_Big_Biz = (TYPEOF(h.RID_If_Big_Biz))'',0,100));
    maxlength_RID_If_Big_Biz := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.RID_If_Big_Biz)));
    avelength_RID_If_Big_Biz := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.RID_If_Big_Biz)),h.RID_If_Big_Biz<>(typeof(h.RID_If_Big_Biz))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_num_legal_names_pcnt := AVE(GROUP,IF(h.num_legal_names = (TYPEOF(h.num_legal_names))'',0,100));
    maxlength_num_legal_names := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.num_legal_names)));
    avelength_num_legal_names := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.num_legal_names)),h.num_legal_names<>(typeof(h.num_legal_names))'');
    populated_num_incs_pcnt := AVE(GROUP,IF(h.num_incs = (TYPEOF(h.num_incs))'',0,100));
    maxlength_num_incs := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.num_incs)));
    avelength_num_incs := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.num_incs)),h.num_incs<>(typeof(h.num_incs))'');
    populated_nodes_total_pcnt := AVE(GROUP,IF(h.nodes_total = (TYPEOF(h.nodes_total))'',0,100));
    maxlength_nodes_total := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.nodes_total)));
    avelength_nodes_total := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.nodes_total)),h.nodes_total<>(typeof(h.nodes_total))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_prim_name_pcnt *  15.00 / 100 + T.Populated_RID_If_Big_Biz_pcnt *  26.00 / 100 + T.Populated_cnp_name_pcnt *  26.00 / 100 + T.Populated_company_name_pcnt *  25.00 / 100 + T.Populated_cnp_number_pcnt *  14.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_num_legal_names_pcnt *   0.00 / 100 + T.Populated_num_incs_pcnt *   0.00 / 100 + T.Populated_nodes_total_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_company_inc_state_pcnt *   0.00 / 100 + T.Populated_company_charter_number_pcnt *   0.00 / 100 + T.Populated_active_duns_number_pcnt *   0.00 / 100 + T.Populated_hist_duns_number_pcnt *   0.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_foreign_corp_key_pcnt *   0.00 / 100 + T.Populated_unk_corp_key_pcnt *   0.00 / 100 + T.Populated_company_fein_pcnt *   0.00 / 100 + T.Populated_cnp_btype_pcnt *   0.00 / 100 + T.Populated_company_name_type_derived_pcnt *   0.00 / 100 + T.Populated_company_bdid_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *  13.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *  15.00 / 10000 + le.Populated_RID_If_Big_Biz_pcnt*ri.Populated_RID_If_Big_Biz_pcnt *  26.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *  26.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *  25.00 / 10000 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *  14.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  14.00 / 10000 + le.Populated_num_legal_names_pcnt*ri.Populated_num_legal_names_pcnt *   0.00 / 10000 + le.Populated_num_incs_pcnt*ri.Populated_num_incs_pcnt *   0.00 / 10000 + le.Populated_nodes_total_pcnt*ri.Populated_nodes_total_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_company_inc_state_pcnt*ri.Populated_company_inc_state_pcnt *   0.00 / 10000 + le.Populated_company_charter_number_pcnt*ri.Populated_company_charter_number_pcnt *   0.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *   0.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *   0.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *   0.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *   0.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *   0.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   0.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   0.00 / 10000 + le.Populated_company_bdid_pcnt*ri.Populated_company_bdid_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'prim_range','prim_name','RID_If_Big_Biz','cnp_name','company_name','cnp_number','zip','num_legal_names','num_incs','nodes_total','zip4','sec_range','v_city_name','st','company_inc_state','company_charter_number','active_duns_number','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','company_fein','cnp_btype','company_name_type_derived','company_bdid','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_RID_If_Big_Biz_pcnt,le.populated_cnp_name_pcnt,le.populated_company_name_pcnt,le.populated_cnp_number_pcnt,le.populated_zip_pcnt,le.populated_num_legal_names_pcnt,le.populated_num_incs_pcnt,le.populated_nodes_total_pcnt,le.populated_zip4_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_company_inc_state_pcnt,le.populated_company_charter_number_pcnt,le.populated_active_duns_number_pcnt,le.populated_hist_duns_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_company_fein_pcnt,le.populated_cnp_btype_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_company_bdid_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_RID_If_Big_Biz,le.maxlength_cnp_name,le.maxlength_company_name,le.maxlength_cnp_number,le.maxlength_zip,le.maxlength_num_legal_names,le.maxlength_num_incs,le.maxlength_nodes_total,le.maxlength_zip4,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_company_inc_state,le.maxlength_company_charter_number,le.maxlength_active_duns_number,le.maxlength_hist_duns_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_company_fein,le.maxlength_cnp_btype,le.maxlength_company_name_type_derived,le.maxlength_company_bdid,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_prim_range,le.avelength_prim_name,le.avelength_RID_If_Big_Biz,le.avelength_cnp_name,le.avelength_company_name,le.avelength_cnp_number,le.avelength_zip,le.avelength_num_legal_names,le.avelength_num_incs,le.avelength_nodes_total,le.avelength_zip4,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_company_inc_state,le.avelength_company_charter_number,le.avelength_active_duns_number,le.avelength_hist_duns_number,le.avelength_active_domestic_corp_key,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_company_fein,le.avelength_cnp_btype,le.avelength_company_name_type_derived,le.avelength_company_bdid,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.POWID;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.RID_If_Big_Biz),TRIM((SALT32.StrType)le.cnp_name),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.cnp_number),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.num_legal_names),TRIM((SALT32.StrType)le.num_incs),TRIM((SALT32.StrType)le.nodes_total),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.company_inc_state),TRIM((SALT32.StrType)le.company_charter_number),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.hist_duns_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.hist_domestic_corp_key),TRIM((SALT32.StrType)le.foreign_corp_key),TRIM((SALT32.StrType)le.unk_corp_key),TRIM((SALT32.StrType)le.company_fein),TRIM((SALT32.StrType)le.cnp_btype),TRIM((SALT32.StrType)le.company_name_type_derived),TRIM((SALT32.StrType)le.company_bdid),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.RID_If_Big_Biz),TRIM((SALT32.StrType)le.cnp_name),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.cnp_number),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.num_legal_names),TRIM((SALT32.StrType)le.num_incs),TRIM((SALT32.StrType)le.nodes_total),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.company_inc_state),TRIM((SALT32.StrType)le.company_charter_number),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.hist_duns_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.hist_domestic_corp_key),TRIM((SALT32.StrType)le.foreign_corp_key),TRIM((SALT32.StrType)le.unk_corp_key),TRIM((SALT32.StrType)le.company_fein),TRIM((SALT32.StrType)le.cnp_btype),TRIM((SALT32.StrType)le.company_name_type_derived),TRIM((SALT32.StrType)le.company_bdid),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.RID_If_Big_Biz),TRIM((SALT32.StrType)le.cnp_name),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.cnp_number),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.num_legal_names),TRIM((SALT32.StrType)le.num_incs),TRIM((SALT32.StrType)le.nodes_total),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.company_inc_state),TRIM((SALT32.StrType)le.company_charter_number),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.hist_duns_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.hist_domestic_corp_key),TRIM((SALT32.StrType)le.foreign_corp_key),TRIM((SALT32.StrType)le.unk_corp_key),TRIM((SALT32.StrType)le.company_fein),TRIM((SALT32.StrType)le.cnp_btype),TRIM((SALT32.StrType)le.company_name_type_derived),TRIM((SALT32.StrType)le.company_bdid),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'prim_range'}
      ,{2,'prim_name'}
      ,{3,'RID_If_Big_Biz'}
      ,{4,'cnp_name'}
      ,{5,'company_name'}
      ,{6,'cnp_number'}
      ,{7,'zip'}
      ,{8,'num_legal_names'}
      ,{9,'num_incs'}
      ,{10,'nodes_total'}
      ,{11,'zip4'}
      ,{12,'sec_range'}
      ,{13,'v_city_name'}
      ,{14,'st'}
      ,{15,'company_inc_state'}
      ,{16,'company_charter_number'}
      ,{17,'active_duns_number'}
      ,{18,'hist_duns_number'}
      ,{19,'active_domestic_corp_key'}
      ,{20,'hist_domestic_corp_key'}
      ,{21,'foreign_corp_key'}
      ,{22,'unk_corp_key'}
      ,{23,'company_fein'}
      ,{24,'cnp_btype'}
      ,{25,'company_name_type_derived'}
      ,{26,'company_bdid'}
      ,{27,'dt_first_seen'}
      ,{28,'dt_last_seen'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_prim_range((SALT32.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT32.StrType)le.prim_name),
    Fields.InValid_RID_If_Big_Biz((SALT32.StrType)le.RID_If_Big_Biz),
    Fields.InValid_cnp_name((SALT32.StrType)le.cnp_name),
    Fields.InValid_company_name((SALT32.StrType)le.company_name),
    Fields.InValid_cnp_number((SALT32.StrType)le.cnp_number),
    Fields.InValid_zip((SALT32.StrType)le.zip),
    Fields.InValid_num_legal_names((SALT32.StrType)le.num_legal_names),
    Fields.InValid_num_incs((SALT32.StrType)le.num_incs),
    Fields.InValid_nodes_total((SALT32.StrType)le.nodes_total),
    Fields.InValid_zip4((SALT32.StrType)le.zip4),
    Fields.InValid_sec_range((SALT32.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT32.StrType)le.v_city_name),
    Fields.InValid_st((SALT32.StrType)le.st),
    Fields.InValid_company_inc_state((SALT32.StrType)le.company_inc_state),
    Fields.InValid_company_charter_number((SALT32.StrType)le.company_charter_number),
    Fields.InValid_active_duns_number((SALT32.StrType)le.active_duns_number),
    Fields.InValid_hist_duns_number((SALT32.StrType)le.hist_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT32.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_domestic_corp_key((SALT32.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT32.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT32.StrType)le.unk_corp_key),
    Fields.InValid_company_fein((SALT32.StrType)le.company_fein),
    Fields.InValid_cnp_btype((SALT32.StrType)le.cnp_btype),
    Fields.InValid_company_name_type_derived((SALT32.StrType)le.company_name_type_derived),
    Fields.InValid_company_bdid((SALT32.StrType)le.company_bdid),
    Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,28,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','multiword','multiword','Unknown','number','namesPerAddress','RejectIfOverOne','RejectIfOverOne','hasZip4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_RID_If_Big_Biz(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_num_legal_names(TotalErrors.ErrorNum),Fields.InValidMessage_num_incs(TotalErrors.ErrorNum),Fields.InValidMessage_nodes_total(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT32.mac_srcfrequency_outliers(h,company_name,source,company_name_outliers)
  SALT32.mac_srcfrequency_outliers(h,cnp_number,source,cnp_number_outliers)
  SALT32.mac_srcfrequency_outliers(h,prim_range,source,prim_range_outliers)
  SALT32.mac_srcfrequency_outliers(h,prim_name,source,prim_name_outliers)
  SALT32.mac_srcfrequency_outliers(h,zip,source,zip_outliers)
EXPORT AllOutliers := company_name_outliers + cnp_number_outliers + prim_range_outliers + prim_name_outliers + zip_outliers;
//We have POWID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT32.MOD_ClusterStats.Counts(h,POWID);
EXPORT ClusterSrc := SALT32.MOD_ClusterStats.Sources(h,POWID,source);
END;
