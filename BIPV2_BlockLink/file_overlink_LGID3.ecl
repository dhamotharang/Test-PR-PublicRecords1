RecV1 := RECORD
  integer8 id;
  unsigned6 rcid;
  string2 source;
  unsigned6 dotid;
  unsigned6 proxid;
  unsigned6 lgid3;
  unsigned6 seleid;
  unsigned6 orgid;
  unsigned6 ultid;
  unsigned3 nodes_total;
  string120 company_name;
  string30 cnp_number;
  string9 active_duns_number;
  string9 duns_number;
  string9 company_fein;
  string2 company_inc_state;
  string32 company_charter_number;
  string10 cnp_btype;
  string50 company_name_type_derived;
  string9 hist_duns_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  string250 cnp_name;
  string1 cnp_hasnumber;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string34 sbfe_id;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  string10 nodes_below_st;
  string20 lgid3ifhrchy;
  unsigned6 originalseleid;
  unsigned6 originalorgid;
  boolean good;
 END;

EXPORT file_overlink_LGID3 :=  project(
                                       DATASET('~thor_data400::BIPV2_BlockLink::LGID3::overlink::qa',RecV1,THOR),
					              transform(BIPV2_BlockLink.ManualOverlinksLGID3.recLayout, 
							              self            := left,
									    self.cortera_id := ''));