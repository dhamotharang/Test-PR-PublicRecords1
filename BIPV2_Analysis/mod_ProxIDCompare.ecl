IMPORT BIPV2, BIPV2_ProxID, SALT311;
 
// See also: BIPV2_ProxID._fun_CompareService
// You can override the defaults for these if you have a saved copy:
//   '~thor_data400::key::proxid::bipv2_proxid::20191002::specificities_debug';    // (small)
//   '~thor_data400::key::proxid::bipv2_proxid::20191002::match_candidates_debug'; // (large)
//   '~thor_data400::key::proxid::bipv2_proxid::20191002::attribute_matches';      // (med)  
 
EXPORT mod_ProxIDCompare(STRING in_version = 'built', STRING in_spec_key_fn = '', STRING in_cand_key_fn = '', STRING in_attr_key_fn = '',
                                                      STRING in_base_fn     = '', STRING in_all_m_fn    = '', STRING in_mt_fn       = '') := MODULE
  
  EXPORT conf_th             := BIPV2_ProxID.Config.MatchThreshold;
 
  EXPORT base_lo             := BIPV2_ProxID.Layout_DOT_Base; //BIPV2.CommonBase_mod.Layout;
  //EXPORT base                := DISTRIBUTE(BIPV2.CommonBase.DS_Built,HASH32(rcid)); // Pre-dist made sense when multi-use below, but takes time
  EXPORT default_base_fn     := IF(TRIM(in_version)='qa', BIPV2.CommonBase.FILE_BASE, BIPV2.CommonBase.FILE_BUILT);
  EXPORT base_fn             := IF(TRIM(in_base_fn)>'', IF(in_base_fn[1]='~', in_base_fn, '~'+in_base_fn), default_base_fn);
  EXPORT base                := DATASET(base_fn, base_lo, THOR);
  //EXPORT base_pub            := DISTRIBUTE(HealthCare_Provider_Header.Files.BasePublish_Current_DS,HASH32(rid));
  EXPORT base_empty          := DATASET([], base_lo);
  EXPORT base_init           := base_empty;
  //EXPORT base_init           := base_empty : INDEPENDENT;
 
  //EXPORT segs_lo             := HealthCare_Provider_Header_PostProc.Layout_Segmentation_General;
  //EXPORT segs                := DISTRIBUTE(HealthCare_Provider_Header_PostProc.Files.Segmentation_General_Current_DS,HASH32(ProxID));
 
  //EXPORT linkblock           := HealthCare_Provider_Header_Ingest.Files.RIDLinkBlock_Current_DS;
  //EXPORT dsSaltInput         := Healthcare_Provider_Header_InternalLinking.Files.SALT_INPUT_Father_DS; // Current is a copy of the last SALT_OUTPUT
  //EXPORT dsSaltOutput        := Healthcare_Provider_Header_InternalLinking.Files.SALT_OUTPUT_Current_DS;
 
  EXPORT matchcodes          := SALT311.MatchCode;
 
  //SHARED linkblock1          := JOIN(DISTRIBUTE(linkblock ,HASH32(left_rid)) , base, LEFT.left_rid =RIGHT.rid, TRANSFORM(RECORDOF(LEFT), SELF.left_ProxID :=RIGHT.ProxID, SELF:=LEFT), LOCAL);
  //SHARED linkblock2          := JOIN(DISTRIBUTE(linkblock1,HASH32(right_rid)), base, LEFT.right_rid=RIGHT.rid, TRANSFORM(RECORDOF(LEFT), SELF.right_ProxID:=RIGHT.ProxID, SELF:=LEFT), LOCAL);
  //SHARED linkblock_xf        := PROJECT(linkblock2(left_ProxID<>right_ProxID), TRANSFORM(RECORDOF(LEFT),
                                  //SELF.left_ProxID :=MAX(LEFT.left_ProxID,LEFT.right_ProxID), SELF.right_ProxID:=MIN(LEFT.left_ProxID,LEFT.right_ProxID), SELF:=LEFT), LOCAL);
  //EXPORT linkblock_curr      := ROLLUP(GROUP(SORT(DISTRIBUTE(linkblock_xf,HASH32(left_ProxID)),left_ProxID,right_ProxID,LOCAL),left_ProxID,right_ProxID), GROUP,
                                  //TRANSFORM(RECORDOF(LEFT), SELF.auditsource:=IF(COUNT(ROWS(LEFT)(auditsource[..3]='MAS'))>0,
                                    //IF(COUNT(ROWS(LEFT)(auditsource[..3]='HCP'))>0,'BOTH','MAS'),IF(COUNT(ROWS(LEFT)(auditsource[..3]='HCP'))>0,'HCP','OTHER')), SELF:=LEFT))
                                  //: PERSIST(HealthCare_Provider_Header_Ingest.Filenames.Prefix_RIDLinkBlock+'_current_persist', EXPIRE(3), SINGLE);
 
  //EXPORT keys_init           := BIPV2_ProxID.Keys(base_init);
  EXPORT keynames            := BIPV2_ProxID.keynames(in_version,FALSE);
  EXPORT specs_init          := BIPV2_ProxID.Specificities(base_init);
  //EXPORT spec_key_init       := specs_init.specificities;
  EXPORT spec_key_init       := DATASET([],BIPV2_ProxID._Old_layouts.specs);
  EXPORT default_spec_key_fn := keynames.specificities_debug.logical;
  EXPORT spec_key_fn         := IF(TRIM(in_spec_key_fn)>'', IF(in_spec_key_fn[1]='~', in_spec_key_fn, '~'+in_spec_key_fn), default_spec_key_fn);
  EXPORT spec_key            := INDEX(spec_key_init, {1}, {spec_key_init}, spec_key_fn);
  //EXPORT spec_key_r          := PROJECT(spec_key, BIPV2_ProxID.Layout_Specificities.R)[1];
  EXPORT spec_key_r          := PROJECT(spec_key, TRANSFORM(BIPV2_ProxID.Layout_Specificities.R, SELF:=LEFT, SELF:=[]))[1];
  //EXPORT spec_key_r          := PROJECT(spec_key, BIPV2_ProxID.Layout_Specificities.R)[1] : INDEPENDENT;
 
  EXPORT cands_init          := BIPV2_ProxID.match_candidates(base_init);
  EXPORT mats_lo             := cands_init.layout_matches;
  EXPORT attr_lo             := cands_init.layout_attribute_matches;
  EXPORT cand_lo             := cands_init.layout_candidates;
  //EXPORT cand_key_init       := cands_init.candidates;
  EXPORT cand_key_init       := DATASET([],BIPV2_ProxID._Old_layouts.mc);
  EXPORT default_cand_key_fn := keynames.match_candidates_debug.logical;
  EXPORT cand_key_fn         := IF(TRIM(in_cand_key_fn)>'', IF(in_cand_key_fn[1]='~', in_cand_key_fn, '~'+in_cand_key_fn), default_cand_key_fn);
  EXPORT cand_key            := INDEX(cand_key_init, {ProxID}, {cand_key_init}, cand_key_fn);
  //EXPORT cand_key            := PULL(INDEX(cand_key_init, {ProxID}, {cand_key_init}, cand_key_fn));
  //EXPORT cand_key            := PULL(BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base,'built').Candidates);
  //EXPORT cand_key            := INDEX(cand_key_init, {ProxID}, {cand_key_init}, cand_key_fn) : INDEPENDENT;
  //EXPORT cand_key            := DISTRIBUTE(INDEX(cand_key_init, {ProxID}, {cand_key_init}, cand_key_fn),HASH32(proxid));
 
  EXPORT match_init          := BIPV2_ProxID.matches(base_init,conf_th);
  EXPORT attr_key_init       := match_init.All_Attribute_Matches;
  EXPORT default_attr_key_fn := keynames.attribute_matches.logical;
  EXPORT attr_key_fn         := IF(TRIM(in_attr_key_fn)>'', IF(in_attr_key_fn[1]='~', in_attr_key_fn, '~'+in_attr_key_fn), default_attr_key_fn);
  EXPORT attr_key            := INDEX(attr_key_init, {ProxID1,ProxID2}, {attr_key_init}, attr_key_fn);
  //EXPORT attr_key            := PULL(INDEX(attr_key_init, {ProxID1,ProxID2}, {attr_key_init}, attr_key_fn));
  //EXPORT attr_key            := INDEX(attr_key_init, {ProxID1,ProxID2}, {attr_key_init}, attr_key_fn) : INDEPENDENT;
  //EXPORT attr_key            := DISTRIBUTE(INDEX(attr_key_init, {ProxID1,ProxID2}, {attr_key_init}, attr_key_fn),HASH32(proxid));
 
  EXPORT default_all_m_fn    := '~temp::proxid::bipv2_proxid::all_m';
  EXPORT all_m_fn            := IF(TRIM(in_all_m_fn)>'', IF(in_all_m_fn[1]='~', in_all_m_fn, '~'+in_all_m_fn), default_all_m_fn);
  EXPORT all_m               := DATASET(all_m_fn, mats_lo, THOR);
 
  EXPORT default_mt_fn       := '~temp::proxid::bipv2_proxid::mt';
  EXPORT mt_fn               := IF(TRIM(in_mt_fn)>'', IF(in_mt_fn[1]='~', in_mt_fn, '~'+in_mt_fn), default_mt_fn);
  EXPORT mt                  := DATASET(mt_fn, mats_lo, THOR);

  EXPORT debug_init          := BIPV2_ProxID.Debug(base_init,spec_key_r);
 
  EXPORT ProxIDPair_lo        := {
    UNSIGNED8 ProxID1 := 0;      UNSIGNED8 ProxID2 := 0;
  };
 
  EXPORT ProxIDPairDtl_lo     := {
    UNSIGNED8 from_ProxID;       UNSIGNED8 to_ProxID;
    UNSIGNED6 from_rcid;         UNSIGNED6 to_rcid;
    INTEGER2  conf_allm;         UNSIGNED2 rule;
    INTEGER2  conf_prop;         STRING1   in_mt  := '';
    STRING30  from_seg := '';    STRING30  to_seg := '';
    STRING15  from_source := ''; STRING15  to_source := '';
  };
 
  // Derived from BIPV2_ProxID.Debug.Layout_Sample_Matches
  EXPORT comparison_lo       := {
    UNSIGNED8 from_ProxID;
    UNSIGNED8 to_ProxID;
    STRING1   will_link;        // Y, N, 'U'nknown, 'A'lready together
    STRING10  scored;           // UNDER_NEG, UNDER_LOW, UNDER, OVER, OVER_HIGH
    STRING10  forced;           // MIX, CNAME, CNUM, ENT_A, DCORP_A, ADDR, CSZ, PRIMR, PRIMN, ST
    STRING5   blocked;          // TBD
    INTEGER2  conf_comp;
    STRING20  from_seg := '';
    STRING20  to_seg := '';
    UNSIGNED8 from_rcid;
    UNSIGNED8 to_rcid;
    //STRING15  from_source;
    //STRING15  to_source;
    INTEGER2  conf_allm;
    //STRING1   in_mt;
    //STRING1   reverse_comp;

    STRING2   left_salt_partition;
    STRING2   right_salt_partition;
    INTEGER2  salt_partition_score;

    // Force-related fields (has *_skipped) -------------------------------------------------------
    STRING    cnp_name_match_info := '';
    UNSIGNED2 support_cnp_name := 0; // Add support (either external of field) for cnp_name
    INTEGER1  cnp_name_match_code;
    INTEGER2  cnp_name_score;
    BOOLEAN   cnp_name_skipped := FALSE; // True if FORCE blocks match
    STRING1   cnp_name_stopped := '';
    TYPEOF(cand_lo.cnp_name) left_cnp_name;
    TYPEOF(cand_lo.cnp_name) right_cnp_name;
    //TYPEOF(cand_lo.company_name) left_company_name;
    //TYPEOF(cand_lo.company_name) right_company_name;
    //TYPEOF(cand_lo.cnp_translated) left_cnp_translated;
    //TYPEOF(cand_lo.cnp_translated) right_cnp_translated;

    //TYPEOF(cand_lo.cnp_hasnumber) left_cnp_hasnumber;
    //TYPEOF(cand_lo.cnp_hasnumber) right_cnp_hasnumber;
    INTEGER1  cnp_number_match_code;
    INTEGER2  cnp_number_score;
    INTEGER2  cnp_number_score_prop;
    BOOLEAN   cnp_number_skipped := FALSE; // True if FORCE blocks match
    STRING1   cnp_number_stopped := '';
    TYPEOF(cand_lo.cnp_number) left_cnp_number;
    TYPEOF(cand_lo.cnp_number) right_cnp_number;

    INTEGER1  active_enterprise_number_match_code;
    INTEGER2  active_enterprise_number_score;
    INTEGER2  active_enterprise_number_score_prop;
    BOOLEAN   active_enterprise_number_skipped := FALSE; // True if FORCE blocks match
    STRING1   active_enterprise_number_stopped := '';
    TYPEOF(cand_lo.active_enterprise_number) left_active_enterprise_number;
    TYPEOF(cand_lo.active_enterprise_number) right_active_enterprise_number;

    // No longer a force condition as of 2020-08-10 update
    //INTEGER1 active_domestic_corp_key_match_code;
    //INTEGER2 active_domestic_corp_key_score;
    //INTEGER2 active_domestic_corp_key_score_prop;
    //BOOLEAN active_domestic_corp_key_skipped := FALSE; // True if FORCE blocks match
    //STRING1 active_domestic_corp_key_stopped := '';
    //TYPEOF(cand_lo.active_domestic_corp_key) left_active_domestic_corp_key;
    //TYPEOF(cand_lo.active_domestic_corp_key) right_active_domestic_corp_key;

    INTEGER1  company_address_match_code;
    INTEGER2  company_address_score;
    INTEGER2  company_address_score_prop;
    BOOLEAN   company_address_skipped := FALSE; // True if FORCE blocks match
    STRING1   company_address_stopped := '';
    TYPEOF(cand_lo.company_address) left_company_address;
    TYPEOF(cand_lo.company_address) right_company_address;

    INTEGER1  company_csz_match_code;
    INTEGER2  company_csz_score;
    BOOLEAN   company_csz_skipped := FALSE; // True if FORCE blocks match
    STRING1   company_csz_stopped := '';
    TYPEOF(cand_lo.company_csz) left_company_csz;
    TYPEOF(cand_lo.company_csz) right_company_csz;

    INTEGER1  prim_range_derived_match_code;
    INTEGER2  prim_range_derived_score;
    INTEGER2  prim_range_derived_score_prop;
    BOOLEAN   prim_range_derived_skipped := FALSE; // True if FORCE blocks match
    STRING1   prim_range_derived_stopped := '';
    TYPEOF(cand_lo.prim_range_derived) left_prim_range_derived;
    TYPEOF(cand_lo.prim_range_derived) right_prim_range_derived;
    //TYPEOF(cand_lo.prim_range) left_prim_range;
    //TYPEOF(cand_lo.prim_range) right_prim_range;

    INTEGER1  prim_name_derived_match_code;
    INTEGER2  prim_name_derived_score;
    BOOLEAN   prim_name_derived_skipped := FALSE; // True if FORCE blocks match
    STRING1   prim_name_derived_stopped := '';
    TYPEOF(cand_lo.prim_name_derived) left_prim_name_derived;
    TYPEOF(cand_lo.prim_name_derived) right_prim_name_derived;
    //TYPEOF(cand_lo.prim_name) left_prim_name;
    //TYPEOF(cand_lo.prim_name) right_prim_name;

    INTEGER1  st_match_code;
    INTEGER2  st_score;
    BOOLEAN   st_skipped := FALSE; // True if FORCE blocks match
    STRING1   st_stopped := '';
    TYPEOF(cand_lo.st) left_st;
    TYPEOF(cand_lo.st) right_st;

    // Other fields -------------------------------------------------------------------------------
    INTEGER1  cnp_name_phonetic_match_code;
    INTEGER2  cnp_name_phonetic_score;
    STRING1   cnp_name_phonetic_stopped := '';
    TYPEOF(cand_lo.cnp_name_phonetic) left_cnp_name_phonetic;
    TYPEOF(cand_lo.cnp_name_phonetic) right_cnp_name_phonetic;

    INTEGER1  company_name_type_derived_match_code;
    INTEGER2  company_name_type_derived_score;
    INTEGER2  company_name_type_derived_score_prop;
    STRING1   company_name_type_derived_stopped := '';
    TYPEOF(cand_lo.company_name_type_derived) left_company_name_type_derived;
    TYPEOF(cand_lo.company_name_type_derived) right_company_name_type_derived;
    //TYPEOF(cand_lo.company_name_type_raw) left_company_name_type_raw;
    //TYPEOF(cand_lo.company_name_type_raw) right_company_name_type_raw;

    INTEGER1  company_addr1_match_code;
    INTEGER2  company_addr1_score;
    INTEGER2  company_addr1_score_prop;
    STRING1   company_addr1_stopped := '';
    TYPEOF(cand_lo.company_addr1) left_company_addr1;
    TYPEOF(cand_lo.company_addr1) right_company_addr1;

    INTEGER1  sec_range_match_code;
    INTEGER2  sec_range_score;
    INTEGER2  sec_range_score_prop;
    STRING1   sec_range_stopped := '';
    TYPEOF(cand_lo.sec_range) left_sec_range;
    TYPEOF(cand_lo.sec_range) right_sec_range;

    INTEGER1  v_city_name_match_code;
    INTEGER2  v_city_name_score;
    STRING1   v_city_name_stopped := '';
    TYPEOF(cand_lo.v_city_name) left_v_city_name;
    TYPEOF(cand_lo.v_city_name) right_v_city_name;

    INTEGER1  zip_match_code;
    INTEGER2  zip_score;
    STRING1   zip_stopped := '';
    TYPEOF(cand_lo.zip) left_zip;
    TYPEOF(cand_lo.zip) right_zip;

    INTEGER1  hist_enterprise_number_match_code;
    INTEGER2  hist_enterprise_number_score;
    INTEGER2  hist_enterprise_number_score_prop;
    STRING1   hist_enterprise_number_stopped := '';
    TYPEOF(cand_lo.hist_enterprise_number) left_hist_enterprise_number;
    TYPEOF(cand_lo.hist_enterprise_number) right_hist_enterprise_number;

    // INTEGER2 company_inc_state_weight100 := 0; // Contains 100x the specificity
    // BOOLEAN company_inc_state_isnull := (h0.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR h0.company_inc_state = (TYPEOF(h0.company_inc_state))''); // Simplify later processing 
    INTEGER1  company_inc_state_match_code;                              // Added 2020-08-10
    INTEGER2  company_inc_state_score;                                   // Added 2020-08-10
    STRING1   company_inc_state_stopped := '';                           // Added 2020-08-10
    TYPEOF(cand_lo.company_inc_state) left_company_inc_state;            // Added 2020-08-10
    TYPEOF(cand_lo.company_inc_state) right_company_inc_state;           // Added 2020-08-10

    // INTEGER2 company_charter_number_weight100 := 0; // Contains 100x the specificity
    // BOOLEAN company_charter_number_isnull := (h0.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR h0.company_charter_number = (TYPEOF(h0.company_charter_number))''); // Simplify later processing 
    INTEGER1  company_charter_number_match_code;                         // Added 2020-08-10
    INTEGER2  company_charter_number_score;                              // Added 2020-08-10
    STRING1   company_charter_number_stopped := '';                      // Added 2020-08-10
    TYPEOF(cand_lo.company_charter_number) left_company_charter_number;  // Added 2020-08-10
    TYPEOF(cand_lo.company_charter_number) right_company_charter_number; // Added 2020-08-10

    // Informational now (was force prior to 2020-08-10 update)
    TYPEOF(cand_lo.active_corp_key) left_active_corp_key;                // Added 2020-08-10
    TYPEOF(cand_lo.active_corp_key) right_active_corp_key;               // Added 2020-08-10

    //INTEGER1 hist_domestic_corp_key_match_code;
    //INTEGER2 hist_domestic_corp_key_score;
    //INTEGER2 hist_domestic_corp_key_score_prop;
    //STRING1 hist_domestic_corp_key_stopped := '';
    //TYPEOF(cand_lo.hist_domestic_corp_key) left_hist_domestic_corp_key;
    //TYPEOF(cand_lo.hist_domestic_corp_key) right_hist_domestic_corp_key;
    INTEGER1  hist_corp_key_match_code;                                  // Added 2020-08-10
    INTEGER2  hist_corp_key_score;                                       // Added 2020-08-10
    INTEGER2  hist_corp_key_score_prop;                                  // Added 2020-08-10
    STRING1   hist_corp_key_stopped := '';                               // Added 2020-08-10
    TYPEOF(cand_lo.hist_corp_key) left_hist_corp_key;                    // Added 2020-08-10
    TYPEOF(cand_lo.hist_corp_key) right_hist_corp_key;                   // Added 2020-08-10

    INTEGER1  active_duns_number_match_code;
    INTEGER2  active_duns_number_score;
    INTEGER2  active_duns_number_score_prop;
    STRING1   active_duns_number_stopped := '';
    TYPEOF(cand_lo.active_duns_number) left_active_duns_number;
    TYPEOF(cand_lo.active_duns_number) right_active_duns_number;

    INTEGER1  hist_duns_number_match_code;
    INTEGER2  hist_duns_number_score;
    INTEGER2  hist_duns_number_score_prop;
    STRING1   hist_duns_number_stopped := '';
    TYPEOF(cand_lo.hist_duns_number) left_hist_duns_number;
    TYPEOF(cand_lo.hist_duns_number) right_hist_duns_number;

    // Not in layout after 2020-08-10 update
    //INTEGER1  foreign_corp_key_match_code;
    //INTEGER2  foreign_corp_key_score;
    //INTEGER2  foreign_corp_key_score_prop;
    //STRING1   foreign_corp_key_stopped := '';
    //TYPEOF(cand_lo.foreign_corp_key) left_foreign_corp_key;
    //TYPEOF(cand_lo.foreign_corp_key) right_foreign_corp_key;

    // Not in layout after 2020-08-10 update
    //INTEGER1  unk_corp_key_match_code;
    //INTEGER2  unk_corp_key_score;
    //INTEGER2  unk_corp_key_score_prop;
    //STRING1   unk_corp_key_stopped := '';
    //TYPEOF(cand_lo.unk_corp_key) left_unk_corp_key;
    //TYPEOF(cand_lo.unk_corp_key) right_unk_corp_key;

    INTEGER1  ebr_file_number_match_code;
    INTEGER2  ebr_file_number_score;
    INTEGER2  ebr_file_number_score_prop;
    STRING1   ebr_file_number_stopped := '';
    TYPEOF(cand_lo.ebr_file_number) left_ebr_file_number;
    TYPEOF(cand_lo.ebr_file_number) right_ebr_file_number;

    INTEGER1  company_fein_match_code;
    INTEGER2  company_fein_score;
    INTEGER2  company_fein_score_prop;
    STRING1   company_fein_stopped := '';
    TYPEOF(cand_lo.company_fein) left_company_fein;
    TYPEOF(cand_lo.company_fein) right_company_fein;

    INTEGER1  sbfe_id_match_code;                                        // Added 2020-08-10
    INTEGER2  sbfe_id_score;                                             // Added 2020-08-10
    STRING1   sbfe_id_stopped := '';                                     // Added 2020-08-10
    TYPEOF(cand_lo.sbfe_id) left_sbfe_id;                                // Added 2020-08-10
    TYPEOF(cand_lo.sbfe_id) right_sbfe_id;                               // Added 2020-08-10

    INTEGER1  company_phone_match_code;
    INTEGER2  company_phone_score;
    INTEGER2  company_phone_score_prop;
    STRING1   company_phone_stopped := '';
    TYPEOF(cand_lo.company_phone) left_company_phone;
    TYPEOF(cand_lo.company_phone) right_company_phone;

    INTEGER1  cnp_btype_match_code;
    INTEGER2  cnp_btype_score;
    STRING1   cnp_btype_stopped := '';
    TYPEOF(cand_lo.cnp_btype) left_cnp_btype;
    TYPEOF(cand_lo.cnp_btype) right_cnp_btype;

    TYPEOF(cand_lo.cnp_lowv) left_cnp_lowv;
    TYPEOF(cand_lo.cnp_lowv) right_cnp_lowv;

    TYPEOF(cand_lo.cnp_classid) left_cnp_classid;
    TYPEOF(cand_lo.cnp_classid) right_cnp_classid;

    //TYPEOF(cand_lo.company_foreign_domestic) left_company_foreign_domestic;
    //TYPEOF(cand_lo.company_foreign_domestic) right_company_foreign_domestic;

    TYPEOF(cand_lo.company_bdid) left_company_bdid;
    TYPEOF(cand_lo.company_bdid) right_company_bdid;

    TYPEOF(cand_lo.dt_first_seen) left_dt_first_seen;
    TYPEOF(cand_lo.dt_first_seen) right_dt_first_seen;

    TYPEOF(cand_lo.dt_last_seen) left_dt_last_seen;
    TYPEOF(cand_lo.dt_last_seen) right_dt_last_seen;

    INTEGER2        Attribute_Conf      :=  0; // Score provided by attribute files
    SALT311.StrType Matching_Attributes := ''; // Keys from attribute files which match
  };
 
 
  EXPORT comparisonStats_lo  := {
    STRING25   field;       REAL avgval;      INTEGER    minval;       INTEGER    maxval;
    UNSIGNED8  cnt_pop;     REAL pct_pop;     UNSIGNED8  cnt_neg;      REAL       pct_neg;
    UNSIGNED8  cnt_stopped; REAL pct_stopped; UNSIGNED8  cnt_leftonly; UNSIGNED8  cnt_rightonly;
  };
 
 
  EXPORT comparison_lo compareXform(debug_init.Layout_Sample_Matches L, UNSIGNED8 ProxID1_in =0, UNSIGNED8 ProxID2_in =0):= TRANSFORM
    not_found                              := L.ProxID1=0 AND L.ProxID2=0;
    SELF.from_ProxID                       := IF(not_found AND ProxID1_in>0, ProxID1_in, L.ProxID1);
    SELF.to_ProxID                         := IF(not_found AND ProxID2_in>0, ProxID2_in, L.ProxID2);
    SELF.scored                            := MAP(not_found                                   => 'N/A',
                                                  L.conf >= conf_th+10                        => 'OVER_HIGH',
                                                  L.conf >= conf_th                           => 'OVER',
                                                  L.conf >= conf_th-10                        => 'UNDER',
                                                  L.conf >= 0                                 => 'UNDER_LOW',
                                                                                                 'UNDER_NEG');
    SELF.forced                            := MAP(not_found                                   => 'N/A',
                                                  (UNSIGNED1)L.cnp_name_skipped                 + (UNSIGNED1)L.cnp_number_skipped +
                                                  (UNSIGNED1)L.active_enterprise_number_skipped + //(UNSIGNED1)L.active_domestic_corp_key_skipped + // Not after 2020-08-10
                                                  (UNSIGNED1)L.company_address_skipped          //+ (UNSIGNED1)L.company_csz_skipped +
                                                  //(UNSIGNED1)L.prim_range_derived_skipped       + (UNSIGNED1)L.prim_name_derived_skipped +
                                                  //(UNSIGNED1)L.st_skipped                 > 1 => 'MIX',
                                                                                          > 1 => 'MIX',
                                                  L.cnp_name_skipped                          => 'CNAME',
                                                  L.cnp_number_skipped                        => 'CNUM',
                                                  L.active_enterprise_number_skipped          => 'ENT_A',
                                                  //L.active_domestic_corp_key_skipped          => 'DCORP_A', // Not after 2020-08-10
                                                  L.prim_range_derived_skipped AND
                                                  L.prim_name_derived_skipped                 => 'ADDRP',
                                                  L.prim_range_derived_skipped                => 'ADDRPR',
                                                  L.prim_name_derived_skipped                 => 'ADDRPN',
                                                  L.company_csz_skipped                       => 'ADDRCSZ',
                                                  L.st_skipped                                => 'ADDRST',
                                                  L.company_address_skipped                   => 'ADDRX',
                                                  '');
    SELF.will_link                         := MAP(not_found                                   => 'U',
                                                  SELF.scored[1]='O' AND TRIM(SELF.forced)='' => 'Y','N');
    SELF.blocked                           := 'N/A'; // Default in case linkblock not checked later
    SELF.conf_comp                         := L.conf;
    SELF.from_rcid                         := L.rcid1;
    SELF.to_rcid                           := L.rcid2;

    SELF.cnp_name_stopped                  := IF(L.conf<conf_th AND L.conf-(L.cnp_name_score/100)>=conf_th,'Y','');
    SELF.cnp_number_stopped                := IF(L.conf<conf_th AND L.conf-(L.cnp_number_score/100)>=conf_th,'Y','');
    SELF.active_enterprise_number_stopped  := IF(L.conf<conf_th AND L.conf-(L.active_enterprise_number_score/100)>=conf_th,'Y','');
    //SELF.active_domestic_corp_key_stopped  := IF(L.conf<conf_th AND L.conf-(L.active_domestic_corp_key_score/100)>=conf_th,'Y',''); // Not after 2020-08-10
    SELF.company_address_stopped           := IF(L.conf<conf_th AND L.conf-(L.company_address_score/100)>=conf_th,'Y','');
    SELF.company_csz_stopped               := IF(L.conf<conf_th AND L.conf-(L.company_csz_score/100)>=conf_th,'Y','');
    SELF.prim_range_derived_stopped        := IF(L.conf<conf_th AND L.conf-(L.prim_range_derived_score/100)>=conf_th,'Y','');
    SELF.prim_name_derived_stopped         := IF(L.conf<conf_th AND L.conf-(L.prim_name_derived_score/100)>=conf_th,'Y','');
    SELF.st_stopped                        := IF(L.conf<conf_th AND L.conf-(L.st_score/100)>=conf_th,'Y','');
    SELF.cnp_name_phonetic_stopped         := IF(L.conf<conf_th AND L.conf-(L.cnp_name_phonetic_score/100)>=conf_th,'Y','');
    SELF.company_name_type_derived_stopped := IF(L.conf<conf_th AND L.conf-(L.company_name_type_derived_score/100)>=conf_th,'Y','');
    SELF.company_addr1_stopped             := IF(L.conf<conf_th AND L.conf-(L.company_addr1_score/100)>=conf_th,'Y','');
    SELF.sec_range_stopped                 := IF(L.conf<conf_th AND L.conf-(L.sec_range_score/100)>=conf_th,'Y','');
    SELF.v_city_name_stopped               := IF(L.conf<conf_th AND L.conf-(L.v_city_name_score/100)>=conf_th,'Y','');
    SELF.zip_stopped                       := IF(L.conf<conf_th AND L.conf-(L.zip_score/100)>=conf_th,'Y','');
    SELF.hist_enterprise_number_stopped    := IF(L.conf<conf_th AND L.conf-(L.hist_enterprise_number_score/100)>=conf_th,'Y','');
    SELF.company_inc_state_stopped         := IF(L.conf<conf_th AND L.conf-(L.company_inc_state_score/100)>=conf_th,'Y','');          // Added 2020-08-10
    SELF.company_charter_number_stopped    := IF(L.conf<conf_th AND L.conf-(L.company_charter_number_score/100)>=conf_th,'Y','');     // Added 2020-08-10
    //SELF.hist_domestic_corp_key_stopped    := IF(L.conf<conf_th AND L.conf-(L.hist_domestic_corp_key_score/100)>=conf_th,'Y','');   // Not after 2020-08-10
    SELF.hist_corp_key_stopped             := IF(L.conf<conf_th AND L.conf-(L.hist_corp_key_score/100)>=conf_th,'Y','');              // Added 2020-08-10
    SELF.active_duns_number_stopped        := IF(L.conf<conf_th AND L.conf-(L.active_duns_number_score/100)>=conf_th,'Y','');
    SELF.hist_duns_number_stopped          := IF(L.conf<conf_th AND L.conf-(L.hist_duns_number_score/100)>=conf_th,'Y','');
    //SELF.foreign_corp_key_stopped          := IF(L.conf<conf_th AND L.conf-(L.foreign_corp_key_score/100)>=conf_th,'Y','');         // Not after 2020-08-10
    //SELF.unk_corp_key_stopped              := IF(L.conf<conf_th AND L.conf-(L.unk_corp_key_score/100)>=conf_th,'Y','');             // Not after 2020-08-10
    SELF.ebr_file_number_stopped           := IF(L.conf<conf_th AND L.conf-(L.ebr_file_number_score/100)>=conf_th,'Y','');
    SELF.company_fein_stopped              := IF(L.conf<conf_th AND L.conf-(L.company_fein_score/100)>=conf_th,'Y','');
    SELF.sbfe_id_stopped                   := IF(L.conf<conf_th AND L.conf-(L.sbfe_id_score/100)>=conf_th,'Y','');
    SELF.company_phone_stopped             := IF(L.conf<conf_th AND L.conf-(L.company_phone_score/100)>=conf_th,'Y','');
    SELF.cnp_btype_stopped                 := IF(L.conf<conf_th AND L.conf-(L.cnp_btype_score/100)>=conf_th,'Y','');
    SELF := L;
    SELF := [];
  END;
 
 
// Original single-pair-at-a-time
//*
  // Batch ProxID compare using specified keys
  // ---------------------------------------------------------------------------------------------------------
  EXPORT comparison_lo compareProxIDs_Old(UNSIGNED8 ProxID1_in, UNSIGNED8 ProxID2_in) := FUNCTION
//  EXPORT debug_init.Layout_Sample_Matches compareProxIDs(UNSIGNED8 ProxID1_in, UNSIGNED8 ProxID2_in, STRING1 in_mt = '') := FUNCTION

    // Match Candidates  - BIPV2_ProxID.Keys().Candidates
    odl     := PROJECT(CHOOSEN(cand_key(ProxID=ProxID1_in),100000), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]));
    odr     := PROJECT(CHOOSEN(cand_key(ProxID=ProxID2_in),100000), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]));
    //odl     := PROJECT(cand_key(ProxID=ProxID1_in), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]));
    //odr     := PROJECT(cand_key(ProxID=ProxID2_in), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]));
    //odl     := PROJECT(cand_key(KEYED(ProxID=ProxID1_in)), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]));
    //odr     := PROJECT(cand_key(KEYED(ProxID=ProxID2_in)), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]));
    //odl     := JOIN(cand_key, DATASET([{ProxID1_in}],{UNSIGNED8 proxid}), LEFT.proxid=RIGHT.proxid, TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]), LOOKUP);
    //odr     := JOIN(cand_key, DATASET([{ProxID2_in}],{UNSIGNED8 proxid}), LEFT.proxid=RIGHT.proxid, TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[]), LOOKUP);
 
    // Attribute Matches - BIPV2_ProxID.Keys().Attribute_Matches
    am      := PROJECT(attr_key(ProxID1=ProxID1_in,ProxID2=ProxID2_in)
                     + attr_key(ProxID1=ProxID2_in,ProxID2=ProxID1_in), TRANSFORM(attr_lo, SELF:=LEFT, SELF:=[]));
 
    // Annotated Results
    matches := debug_init.AnnotateMatchesFromData(odl+odr, DATASET([{0,0,0,0,ProxID1_in,ProxID2_in,0,0}], mats_lo), am);
    //matches := SORT(debug_init.AnnotateMatchesFromData(odl+odr, DATASET([{0,0,0,0,ProxID1_in,ProxID2_in,0,0}], mats_lo), am),-conf);
    //topconf := DEDUP(SORT(DISTRIBUTE(matches,HASH32(proxid1)),proxid1,proxid2,-conf,LOCAL),proxid1,proxid2,LOCAL);
 
    comp    := PROJECT(matches, compareXform(LEFT, proxID1_in, proxID2_in));

    topcomp := DEDUP(SORT(DISTRIBUTE(comp,HASH32(from_proxid,to_proxid)),from_proxid,to_proxid,
                 //-conf_comp,MAP(TRIM(forced)='MIX'=>1, TRIM(forced) NOT IN ['N/A','']=>2, 3),LOCAL),from_proxid,to_proxid,LOCAL); // Best conf, then forces
                 MAP(TRIM(forced)='MIX'=>1, TRIM(forced) NOT IN ['N/A','']=>2, 3),-conf_comp,LOCAL),from_proxid,to_proxid,LOCAL); // Forces, then best conf - care more if any force applies
    result  := IF(COUNT(topcomp)>0, topcomp, PROJECT(DATASET([{1}],{UNSIGNED1 dummy}), TRANSFORM(comparison_lo, SELF.from_proxid:=ProxID1_in, SELF.to_proxid:=ProxID2_in,
                   SELF.will_link:='U', SELF.scored:='N/A', SELF.forced:='N/A', SELF.blocked:='N/A', SELF:=[])));
    //result  := PROJECT(matches[1], compareXform(LEFT, proxID1_in, proxID2_in));

    RETURN result[1];
//    RETURN matches[1];
  END;

  EXPORT comparison_lo compareProxIDBatch_Old(ProxIDPairDtl_lo l) := TRANSFORM
//  EXPORT debug_init.Layout_Sample_Matches compareProxIDBatch(ProxIDPairDtl_lo l) := TRANSFORM
    SELF.from_seg  := l.from_seg;
    SELF.to_seg    := l.to_seg;
    //SELF.conf_allm := l.conf_allm;
    SELF           := compareProxIDs_Old(l.from_ProxID, l.to_ProxID);
    //SELF := [];
  END;
//*/
 
 
// New batch-at-a-time
// Note: Explicit distro by proxid1/proxid2 to avoid redistro made it run noticeably slower, research more later to update other long processes
//   W20200423-114012 - Run successively smaller batches, but using PULL and redesigned mod_ProxIDCompare               (1.5h)
//   W20200423-145829 - Run successively smaller batches, PULL, redesigned mod_ProxIDCompare, added bug fixes, redistro (2.5h) <-- Why worse? Check later.
//   W20200423-230303 - Run successively smaller batches, PULL, redesigned mod_ProxIDCompare, bug fixes, revert distro  (1.5h)
//*
  // Batch ProxID compare using specified keys
  // ---------------------------------------------------------------------------------------------------------
  EXPORT comparison_lo compareProxIDBatch_New(DATASET(ProxIDPairDtl_lo) in_pairs, BOOLEAN roll_cand = TRUE, BOOLEAN use_allm = FALSE) := FUNCTION // Defaults to most complete, adjust for speed

    // Conditionally use all_m from latest iteration to get best-scoring rec pairs for found proxid pairs, then annotate only that rec pair instead of all possible pairs for performance gains
    allm    := DISTRIBUTE(all_m,HASH32(proxid1));
    allm_dd := DEDUP(SORT(allm,proxid1,proxid2,-conf,rcid1,rcid2,LOCAL),proxid1,proxid2,LOCAL); // Checking only best conf rec pair could miss another rec pair hitting a force... right?

    // Reformat in_pairs to Matches layout
    pairs   := DISTRIBUTE(PROJECT(in_pairs, TRANSFORM(mats_lo, SELF.proxid1:=LEFT.from_ProxID, SELF.proxid2:=LEFT.to_ProxID, SELF:=[])),HASH32(proxid1));
    p_am    := JOIN(pairs, allm_dd, LEFT.proxid1=RIGHT.proxid1 AND LEFT.proxid2=RIGHT.proxid2, TRANSFORM(mats_lo, SELF.rcid1:=RIGHT.rcid1, SELF.rcid2:=RIGHT.rcid2, SELF.conf:=RIGHT.conf, SELF:=LEFT), LOCAL);
    p_notam := JOIN(pairs, allm_dd, LEFT.proxid1=RIGHT.proxid1 AND LEFT.proxid2=RIGHT.proxid2, TRANSFORM(LEFT), LEFT ONLY, LOCAL);
    //pairs1  := DISTRIBUTE(pairs,HASH32(proxid1));
    //pairs2  := DISTRIBUTE(pairs,HASH32(proxid2));

    // Match Candidates recs  - BIPV2_ProxID.Keys().Candidates
    cand    := IF(roll_cand, // Rollup removes ~1/3 recs but should retain unique data combinations, better performance if output results are as reliable
                 ROLLUP(GROUP(SORT(DISTRIBUTE(PULL(cand_key),HASH32(proxid)),EXCEPT rcid,dt_first_seen,dt_last_seen,LOCAL),EXCEPT rcid,dt_first_seen,dt_last_seen,LOCAL), GROUP,
                   TRANSFORM(cand_lo, SELF.rcid:=MIN(ROWS(LEFT),rcid), SELF.dt_first_seen:=MIN(ROWS(LEFT),dt_first_seen), SELF.dt_last_seen:=MAX(ROWS(LEFT),dt_last_seen), SELF:=LEFT, SELF:=[])),
                 DISTRIBUTE(PROJECT(PULL(cand_key), TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[])),HASH32(proxid)));
 
    //cand    := DISTRIBUTE(PROJECT(cand_key, TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[])),HASH32(proxid));
    //odl     := JOIN(cand, DEDUP(SORT(pairs1,proxid1,LOCAL),proxid1,LOCAL), LEFT.proxid =RIGHT.proxid1, TRANSFORM(LEFT), LOCAL); // Everything for P1
    //odr     := JOIN(cand, DEDUP(SORT(pairs2,proxid2,LOCAL),proxid2,LOCAL), LEFT.proxid =RIGHT.proxid2, TRANSFORM(LEFT), LOCAL); // Everything for P2
    //od      := DEDUP(SORT(DISTRIBUTE(odl+odr,HASH32(proxid)),proxid,rcid,LOCAL),proxid,rcid,LOCAL);

    // Attribute Matches recs - BIPV2_ProxID.Keys().Attribute_Matches
    attr    := PROJECT(PULL(attr_key), TRANSFORM(attr_lo, SELF:=LEFT, SELF:=[]));
    //attr    := DISTRIBUTE(PROJECT(attr_key, TRANSFORM(attr_lo, SELF:=LEFT, SELF:=[])),HASH32(proxid1));
    //am1     := JOIN(attr, pairs1, LEFT.proxid1=RIGHT.proxid1 AND LEFT.proxid2=RIGHT.proxid2, TRANSFORM(LEFT), LOCAL);
    //am2     := JOIN(attr, pairs2, LEFT.proxid1=RIGHT.proxid2 AND LEFT.proxid2=RIGHT.proxid1, TRANSFORM(LEFT), LOCAL);
    //am      := DEDUP(SORT(DISTRIBUTE(am1+am2,HASH32(proxid1,proxid2)),proxid1,proxid2,LOCAL),proxid1,proxid2,LOCAL);
    //am      := DISTRIBUTE(PROJECT(am1+am2, TRANSFORM(attr_lo, SELF:=LEFT)),HASH32(proxid1,proxid2));

    // AnnotateMatchesFromData - Reusing attr names from Debug for easier functionality tracking between code
    //in_data := cand;
    //im      := pairs;
    //ia      := attr;

    // AnnotateMatchesFromData j1 joins
    j_am    := JOIN(cand, p_am,    LEFT.proxid=RIGHT.proxid1 AND LEFT.rcid=RIGHT.rcid1, LOCAL); // Shortcut to use only the best-scoring recs for pairs in all_m, cand rollup can cause misses
    j_notam := JOIN(cand, p_notam, LEFT.proxid=RIGHT.proxid1, LOCAL);                           // All recs for pairs not found in all_m
    j1      := JOIN(cand, pairs,   LEFT.proxid=RIGHT.proxid1, LOCAL);                           // All recs for all pairs if not using all_m

    // Use predicted r1 join counts to redistribute j1 & cand before executing the actual join (quick shuffling using thin data before heavy use of big data)
    c_cnt   := TABLE(           PROJECT(cand,    {UNSIGNED8 proxid }),                  { proxid,  UNSIGNED cnt:=COUNT(GROUP) }, proxid,  LOCAL);

    // ...if using all_m
    //jn_cnt  := TABLE(DISTRIBUTE(PROJECT(j_notam, {UNSIGNED8 proxid2}),HASH32(proxid2)), { proxid2, UNSIGNED cnt:=COUNT(GROUP) }, proxid2, LOCAL); // "Not AM" likely to have more recs, so use it
    //jnc_cnt := JOIN(jn_cnt, c_cnt, LEFT.proxid2=RIGHT.proxid, TRANSFORM({UNSIGNED8 proxid2, UNSIGNED8 j1_cnt, UNSIGNED8 c_cnt, UNSIGNED8 join_cnt},
                 //SELF.j1_cnt:=LEFT.cnt, SELF.c_cnt:=RIGHT.cnt, SELF.join_cnt:=LEFT.cnt*RIGHT.cnt, SELF:=LEFT), LOCAL);
    //rd_jnc  := DISTRIBUTE(pml.Redist(jnc_cnt,'proxid2','join_cnt').nodemap,dist_val); // Should be distributed by dist_val by default, just making sure...
    //rd_cn   := DISTRIBUTE(JOIN(cand,    rd_jnc,   HASH32(LEFT.proxid)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    //rd_ja   := DISTRIBUTE(JOIN(DISTRIBUTE(j_am,   HASH32(proxid2)), rd_jnc, HASH32(LEFT.proxid2)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    //rd_jn   := DISTRIBUTE(JOIN(DISTRIBUTE(j_notam,HASH32(proxid2)), rd_jnc, HASH32(LEFT.proxid2)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    //rd_an   := DISTRIBUTE(JOIN(DISTRIBUTE(attr,   HASH32(proxid2)), rd_jnc, HASH32(LEFT.proxid2)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    rd_cn   := cand;
    rd_ja   := DISTRIBUTE(j_am,   HASH32(proxid2));
    rd_jn   := DISTRIBUTE(j_notam,HASH32(proxid2));
    rd_an   := DISTRIBUTE(attr,   HASH32(proxid2));

    // ...if not using all_m
    //j1_cnt  := TABLE(DISTRIBUTE(PROJECT(j1,      {UNSIGNED8 proxid2}),HASH32(proxid2)), { proxid2, UNSIGNED cnt:=COUNT(GROUP) }, proxid2, LOCAL);
    //j1c_cnt := JOIN(j1_cnt, c_cnt, LEFT.proxid2=RIGHT.proxid, TRANSFORM({UNSIGNED8 proxid2, UNSIGNED8 j1_cnt, UNSIGNED8 c_cnt, UNSIGNED8 join_cnt},
                 //SELF.j1_cnt:=LEFT.cnt, SELF.c_cnt:=RIGHT.cnt, SELF.join_cnt:=LEFT.cnt*RIGHT.cnt, SELF:=LEFT), LOCAL);
    //rd_j1c  := DISTRIBUTE(pml.Redist(j1c_cnt,'proxid2','join_cnt').nodemap,dist_val); // Should be distributed by dist_val by default, just making sure...
    //rd_c1   := DISTRIBUTE(JOIN(cand,    rd_j1c,   HASH32(LEFT.proxid)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    //rd_j1   := DISTRIBUTE(JOIN(DISTRIBUTE(j1,     HASH32(proxid2)), rd_j1c, HASH32(LEFT.proxid2)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    //rd_a1   := DISTRIBUTE(JOIN(DISTRIBUTE(attr,   HASH32(proxid2)), rd_j1c, HASH32(LEFT.proxid2)=RIGHT.dist_val, TRANSFORM({RECORDOF(LEFT), UNSIGNED2 rd_node}, SELF.rd_node:=RIGHT.node, SELF:=LEFT), LOCAL),rd_node);
    rd_c1   := cand;
    rd_j1   := DISTRIBUTE(j1,     HASH32(proxid2));
    rd_a1   := DISTRIBUTE(attr,   HASH32(proxid2));

    // AnnotateMatchesFromData r1 joins
    r_am    := JOIN(rd_ja, rd_cn, LEFT.proxid2=RIGHT.proxid AND LEFT.rcid2=RIGHT.rcid,         // Shortcut to use only the best-scoring recs for pairs in all_m, cand rollup can cause misses
                 TRANSFORM({UNSIGNED6 proxid1, UNSIGNED6 proxid2, RECORDOF(LEFT) leftrec, RECORDOF(RIGHT) rightrec},
                   SELF.leftrec:=LEFT, SELF.rightrec:=RIGHT, SELF:=LEFT), LOCAL);
    r_notam := JOIN(rd_jn, rd_cn, LEFT.proxid2=RIGHT.proxid,                                   // All recs for pairs not found in all_m
                 TRANSFORM({UNSIGNED6 proxid1, UNSIGNED6 proxid2, RECORDOF(LEFT) leftrec, RECORDOF(RIGHT) rightrec},
                   SELF.leftrec:=LEFT, SELF.rightrec:=RIGHT, SELF:=LEFT), LOCAL);
    r1      := IF(use_allm, r_am+r_notam, JOIN(rd_j1, rd_c1, LEFT.proxid2=RIGHT.proxid,        // All recs for all pairs if not using all_m
                 TRANSFORM({UNSIGNED6 proxid1, UNSIGNED6 proxid2, RECORDOF(LEFT) leftrec, RECORDOF(RIGHT) rightrec},
                   SELF.leftrec:=LEFT, SELF.rightrec:=RIGHT, SELF:=LEFT), LOCAL));

    // AnnotateMatchesFromData remaining joins
    rd_attr := IF(use_allm, rd_an, rd_a1);
    r2      := JOIN(r1, rd_attr, LEFT.proxid2=RIGHT.proxid2 AND LEFT.proxid1=RIGHT.proxid1,
    //r2      := JOIN(r1, attr, LEFT.proxid1=RIGHT.proxid1 AND LEFT.proxid2=RIGHT.proxid2,             
    //r2      := JOIN(r1, ia,      LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.proxid2=RIGHT.proxid2,
                 TRANSFORM({RECORDOF(LEFT), UNSIGNED rule, UNSIGNED support_cnp_name},                 
                   SELF.rule             := IF(RIGHT.proxid1!=0, RIGHT.rule, LEFT.leftrec.rule),
                   SELF.support_cnp_name := RIGHT.support_cnp_name, SELF := LEFT), LEFT OUTER, LOCAL);
                   //SELF.support_cnp_name := RIGHT.support_cnp_name, SELF := LEFT), HASH, LEFT OUTER);
    //cand_lo    strim(j1 le) := TRANSFORM SELF := le; END;
    r       := PROJECT(DISTRIBUTE(r2), debug_init.sample_match_join(
                 PROJECT(LEFT.leftrec,  TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[])),
                 PROJECT(LEFT.rightrec, TRANSFORM(cand_lo, SELF:=LEFT, SELF:=[])),
                 LEFT.rule,,LEFT.support_cnp_name));
    d       := DEDUP(SORT(DISTRIBUTE(r,HASH32(proxid1,proxid2)),proxid1,proxid2,
                 -MAP(conf BETWEEN 30 AND 7000 => conf, conf > 7000 => 29, conf - 1),LOCAL),proxid1,proxid2,LOCAL);
    matches := debug_init.AppendAttribs(d, attr);
    //matches := SORT(debug_init.AnnotateMatchesFromData(odl+odr, DATASET([{0,0,0,0,ProxID1_in,ProxID2_in,0,0}], mats_lo), am),-conf);

    comp    := PROJECT(matches(proxid1>0 AND proxid2>0), compareXform(LEFT));
    topcomp := DEDUP(SORT(DISTRIBUTE(comp,HASH32(from_proxid,to_proxid)),from_proxid,to_proxid,
                 //-conf_comp,MAP(TRIM(forced)='MIX'=>1, TRIM(forced) NOT IN ['N/A','']=>2, 3),LOCAL),from_proxid,to_proxid,LOCAL); // Best conf, then forces
                 MAP(TRIM(forced)='MIX'=>1, TRIM(forced) NOT IN ['N/A','']=>2, 3),-conf_comp,LOCAL),from_proxid,to_proxid,LOCAL); // Forces, then best conf - care more if any force applies
    result1 := JOIN(DISTRIBUTE(in_pairs,HASH32(from_proxid,to_proxid)), topcomp, LEFT.from_proxid=RIGHT.from_proxid AND LEFT.to_proxid=RIGHT.to_proxid,
                 TRANSFORM(comparison_lo, not_found:=RIGHT.from_proxid=0 OR RIGHT.to_proxid=0;
                   SELF.will_link:=IF(not_found,'U'  ,RIGHT.will_link), SELF.scored :=IF(not_found,'N/A',RIGHT.scored), 
                   SELF.forced   :=IF(not_found,'N/A',RIGHT.forced),    SELF.blocked:=IF(not_found,'N/A',RIGHT.blocked), 
                   SELF:=LEFT, SELF:=RIGHT), LEFT OUTER, LOCAL);
    result2 := JOIN(result1, allm_dd, LEFT.from_proxid=RIGHT.proxid1 AND LEFT.to_proxid=RIGHT.proxid2, TRANSFORM(comparison_lo,
                   SELF.conf_allm:=RIGHT.conf, SELF:=LEFT), LEFT OUTER, LOCAL);
    result  := IF(use_allm, result2, result1);

    RETURN result;
  END;

 
  // Generate overall stats for fields
  // ---------------------------------------------------------------------------------------------------------
  /*
  EXPORT comparisonStats_lo calculateComparisonStats(DATASET(comparison_lo) l) := FUNCTION
    total := COUNT(l);
    stats :=  DATASET([
      //{'conf_allm', ROUND(AVE(l(conf_allm<>0),conf_allm),2), MIN(l(conf_allm<>0),conf_allm), MAX(l(conf_allm<>0),conf_allm), 0, 0, COUNT(l(conf_allm<0)), ROUND(COUNT(l(conf_allm<0))/total*100,2), 0, 0, 0, 0},
      {'conf_comp', ROUND(AVE(l(conf_comp<>0),conf_comp),2), MIN(l(conf_comp<>0),conf_comp), MAX(l(conf_comp<>0),conf_comp), 0, 0, COUNT(l(conf_comp<0)), ROUND(COUNT(l(conf_comp<0))/total*100,2), 0, 0, 0, 0},
      {'comp_name_score', ROUND(AVE(l(comp_name_score<>0),comp_name_score),2), MIN(l(comp_name_score<>0),comp_name_score), MAX(l(comp_name_score<>0),comp_name_score), COUNT(l(TRIM(left_name)>'')), ROUND(COUNT(l(TRIM(left_name)>''))/total*100,2), COUNT(l(comp_name_score<0)), ROUND(COUNT(l(comp_name_score<0))/total*100,2), COUNT(l(comp_name_stopped='Y')), ROUND(COUNT(l(comp_name_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_name)>'' AND TRIM(right_name)='')), COUNT(l(TRIM(left_name)='' AND TRIM(right_name)>''))},
      {'dob_score', ROUND(AVE(l(dob_score<>0),dob_score),2), MIN(l(dob_score<>0),dob_score), MAX(l(dob_score<>0),dob_score), COUNT(l(left_dob>0)), ROUND(COUNT(l(left_dob>0))/total*100,2), COUNT(l(dob_score<0)), ROUND(COUNT(l(dob_score<0))/total*100,2), COUNT(l(dob_stopped='Y')), ROUND(COUNT(l(dob_stopped='Y'))/total*100,2), COUNT(l(left_dob>0 AND right_dob=0)), COUNT(l(left_dob=0 AND right_dob>0))},
      {'ssn_score', ROUND(AVE(l(ssn_score<>0),ssn_score),2), MIN(l(ssn_score<>0),ssn_score), MAX(l(ssn_score<>0),ssn_score), COUNT(l(TRIM(left_ssn)>'')), ROUND(COUNT(l(TRIM(left_ssn)>''))/total*100,2), COUNT(l(ssn_score<0)), ROUND(COUNT(l(ssn_score<0))/total*100,2), COUNT(l(ssn_stopped='Y')), ROUND(COUNT(l(ssn_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_ssn)>'' AND TRIM(right_ssn)='')), COUNT(l(TRIM(left_ssn)='' AND TRIM(right_ssn)>''))},
      {'derived_gender_score', ROUND(AVE(l(derived_gender_score<>0),derived_gender_score),2), MIN(l(derived_gender_score<>0),derived_gender_score), MAX(l(derived_gender_score<>0),derived_gender_score), COUNT(l(TRIM(left_derived_gender)>'')), ROUND(COUNT(l(TRIM(left_derived_gender)>''))/total*100,2), COUNT(l(derived_gender_score<0)), ROUND(COUNT(l(derived_gender_score<0))/total*100,2), COUNT(l(derived_gender_stopped='Y')), ROUND(COUNT(l(derived_gender_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_derived_gender)>'' AND TRIM(right_derived_gender)='')), COUNT(l(TRIM(left_derived_gender)='' AND TRIM(right_derived_gender)>''))},
      {'comp_addr_score', ROUND(AVE(l(comp_addr_score<>0),comp_addr_score),2), MIN(l(comp_addr_score<>0),comp_addr_score), MAX(l(comp_addr_score<>0),comp_addr_score), COUNT(l(TRIM(left_address)>'')), ROUND(COUNT(l(TRIM(left_address)>''))/total*100,2), COUNT(l(comp_addr_score<0)), ROUND(COUNT(l(comp_addr_score<0))/total*100,2), COUNT(l(comp_addr_stopped='Y')), ROUND(COUNT(l(comp_addr_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_address)>'' AND TRIM(right_address)='')), COUNT(l(TRIM(left_address)='' AND TRIM(right_address)>''))},
      {'upin_score', ROUND(AVE(l(upin_score<>0),upin_score),2), MIN(l(upin_score<>0),upin_score), MAX(l(upin_score<>0),upin_score), COUNT(l(TRIM(left_upin)>'')), ROUND(COUNT(l(TRIM(left_upin)>''))/total*100,2), COUNT(l(upin_score<0)), ROUND(COUNT(l(upin_score<0))/total*100,2), COUNT(l(upin_stopped='Y')), ROUND(COUNT(l(upin_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_upin)>'' AND TRIM(right_upin)='')), COUNT(l(TRIM(left_upin)='' AND TRIM(right_upin)>''))},
      {'npi_number_score', ROUND(AVE(l(npi_number_score<>0),npi_number_score),2), MIN(l(npi_number_score<>0),npi_number_score), MAX(l(npi_number_score<>0),npi_number_score), COUNT(l(TRIM(left_npi_number)>'')), ROUND(COUNT(l(TRIM(left_npi_number)>''))/total*100,2), COUNT(l(npi_number_score<0)), ROUND(COUNT(l(npi_number_score<0))/total*100,2), COUNT(l(npi_number_stopped='Y')), ROUND(COUNT(l(npi_number_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_npi_number)>'' AND TRIM(right_npi_number)='')), COUNT(l(TRIM(left_npi_number)='' AND TRIM(right_npi_number)>''))},
      {'dea_number_score', ROUND(AVE(l(dea_number_score<>0),dea_number_score),2), MIN(l(dea_number_score<>0),dea_number_score), MAX(l(dea_number_score<>0),dea_number_score), COUNT(l(TRIM(left_dea_number)>'')), ROUND(COUNT(l(TRIM(left_dea_number)>''))/total*100,2), COUNT(l(dea_number_score<0)), ROUND(COUNT(l(dea_number_score<0))/total*100,2), COUNT(l(dea_number_stopped='Y')), ROUND(COUNT(l(dea_number_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_dea_number)>'' AND TRIM(right_dea_number)='')), COUNT(l(TRIM(left_dea_number)='' AND TRIM(right_dea_number)>''))},
      {'taxonomy_score', ROUND(AVE(l(taxonomy_score<>0),taxonomy_score),2), MIN(l(taxonomy_score<>0),taxonomy_score), MAX(l(taxonomy_score<>0),taxonomy_score), COUNT(l(TRIM(left_taxonomy)>'')), ROUND(COUNT(l(TRIM(left_taxonomy)>''))/total*100,2), COUNT(l(taxonomy_score<0)), ROUND(COUNT(l(taxonomy_score<0))/total*100,2), COUNT(l(taxonomy_stopped='Y')), ROUND(COUNT(l(taxonomy_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_taxonomy)>'' AND TRIM(right_taxonomy)='')), COUNT(l(TRIM(left_taxonomy)='' AND TRIM(right_taxonomy)>''))},
      {'comp_lic_nbr_score', ROUND(AVE(l(comp_lic_nbr_score<>0),comp_lic_nbr_score),2), MIN(l(comp_lic_nbr_score<>0),comp_lic_nbr_score), MAX(l(comp_lic_nbr_score<>0),comp_lic_nbr_score), COUNT(l(TRIM(left_lic_state)>'' AND TRIM(left_lic_nbr)>'')), ROUND(COUNT(l(TRIM(left_lic_state)>'' AND TRIM(left_lic_nbr)>''))/total*100,2), COUNT(l(comp_lic_nbr_score<0)), ROUND(COUNT(l(comp_lic_nbr_score<0))/total*100,2), COUNT(l(comp_lic_nbr_stopped='Y')), ROUND(COUNT(l(comp_lic_nbr_stopped='Y'))/total*100,2), COUNT(l((TRIM(left_lic_state)>'' AND TRIM(left_lic_nbr)>'') AND (TRIM(right_lic_state)='' OR TRIM(right_lic_nbr)=''))), COUNT(l((TRIM(left_lic_state)='' OR TRIM(left_lic_nbr)='') AND (TRIM(right_lic_state)>'' AND TRIM(right_lic_nbr)>'')))},
      {'comp_csr_nbr_score', ROUND(AVE(l(comp_csr_nbr_score<>0),comp_csr_nbr_score),2), MIN(l(comp_csr_nbr_score<>0),comp_csr_nbr_score), MAX(l(comp_csr_nbr_score<>0),comp_csr_nbr_score), COUNT(l(TRIM(left_csr_state)>'' AND TRIM(left_csr_nbr)>'')), ROUND(COUNT(l(TRIM(left_csr_state)>'' AND TRIM(left_csr_nbr)>''))/total*100,2), COUNT(l(comp_csr_nbr_score<0)), ROUND(COUNT(l(comp_csr_nbr_score<0))/total*100,2), COUNT(l(comp_csr_nbr_stopped='Y')), ROUND(COUNT(l(comp_csr_nbr_stopped='Y'))/total*100,2), COUNT(l((TRIM(left_csr_state)>'' AND TRIM(left_csr_nbr)>'') AND (TRIM(right_csr_state)='' OR TRIM(right_csr_nbr)=''))), COUNT(l((TRIM(left_csr_state)='' OR TRIM(left_csr_nbr)='') AND (TRIM(right_csr_state)>'' AND TRIM(right_csr_nbr)>'')))},
      {'cname_score', ROUND(AVE(l(cname_score<>0),cname_score),2), MIN(l(cname_score<>0),cname_score), MAX(l(cname_score<>0),cname_score), COUNT(l(TRIM(left_cname)>'')), ROUND(COUNT(l(TRIM(left_cname)>''))/total*100,2), COUNT(l(cname_score<0)), ROUND(COUNT(l(cname_score<0))/total*100,2), COUNT(l(cname_stopped='Y')), ROUND(COUNT(l(cname_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_cname)>'' AND TRIM(right_cname)='')), COUNT(l(TRIM(left_cname)='' AND TRIM(right_cname)>''))},
      //{'prac_phone_score', ROUND(AVE(l(prac_phone_score<>0),prac_phone_score),2), MIN(l(prac_phone_score<>0),prac_phone_score), MAX(l(prac_phone_score<>0),prac_phone_score), COUNT(l(TRIM(left_prac_phone)>'')), ROUND(COUNT(l(TRIM(left_prac_phone)>''))/total*100,2), COUNT(l(prac_phone_score<0)), ROUND(COUNT(l(prac_phone_score<0))/total*100,2), COUNT(l(prac_phone_stopped='Y')), ROUND(COUNT(l(prac_phone_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_prac_phone)>'' AND TRIM(right_prac_phone)='')), COUNT(l(TRIM(left_prac_phone)='' AND TRIM(right_prac_phone)>''))},
      {'medschool_score', ROUND(AVE(l(medschool_score<>0),medschool_score),2), MIN(l(medschool_score<>0),medschool_score), MAX(l(medschool_score<>0),medschool_score), COUNT(l(TRIM(left_medschool)>'')), ROUND(COUNT(l(TRIM(left_medschool)>''))/total*100,2), COUNT(l(medschool_score<0)), ROUND(COUNT(l(medschool_score<0))/total*100,2), COUNT(l(medschool_stopped='Y')), ROUND(COUNT(l(medschool_stopped='Y'))/total*100,2), COUNT(l(TRIM(left_medschool)>'' AND TRIM(right_medschool)='')), COUNT(l(TRIM(left_medschool)='' AND TRIM(right_medschool)>''))},
      {'medschool_year_score', ROUND(AVE(l(medschool_year_score<>0),medschool_year_score),2), MIN(l(medschool_year_score<>0),medschool_year_score), MAX(l(medschool_year_score<>0),medschool_year_score), COUNT(l(left_medschool_year>0)), ROUND(COUNT(l(left_medschool_year>0))/total*100,2), COUNT(l(medschool_year_score<0)), ROUND(COUNT(l(medschool_year_score<0))/total*100,2), COUNT(l(medschool_year_stopped='Y')), ROUND(COUNT(l(medschool_year_stopped='Y'))/total*100,2), COUNT(l(left_medschool_year>0 AND right_medschool_year=0)), COUNT(l(left_medschool_year=0 AND right_medschool_year>0))},
      {'source_forcematch_score', ROUND(AVE(l(source_forcematch_score<>0),source_forcematch_score),2), MIN(l(source_forcematch_score<>0),source_forcematch_score), MAX(l(source_forcematch_score<>0),source_forcematch_score), COUNT(l(source_forcematch_score<>0)), ROUND(COUNT(l(source_forcematch_score<>0))/total*100,2), COUNT(l(source_forcematch_score<0)), ROUND(COUNT(l(source_forcematch_score<0))/total*100,2), COUNT(l(source_forcematch_stopped='Y')), ROUND(COUNT(l(source_forcematch_stopped='Y'))/total*100,2), 0, 0},
      {'attribute_conf', ROUND(AVE(l(attribute_conf<>0),attribute_conf),2), MIN(l(attribute_conf<>0),attribute_conf), MAX(l(attribute_conf<>0),attribute_conf), COUNT(l(attribute_conf<>0)), ROUND(COUNT(l(attribute_conf<>0))/total*100,2), COUNT(l(attribute_conf<0)), ROUND(COUNT(l(attribute_conf<0))/total*100,2), COUNT(l(attribute_conf_stopped='Y')), ROUND(COUNT(l(attribute_conf_stopped='Y'))/total*100,2), 0, 0}
      ],comparisonStats_lo);
    RETURN stats;
  END;
  //*/
 
  EXPORT DATASET(comparison_lo) batchCompare_Detail(DATASET(ProxIDPairDtl_lo) pairs, BOOLEAN roll_cand = TRUE, BOOLEAN use_allm = FALSE, BOOLEAN check_already = FALSE, BOOLEAN check_linkblock = FALSE) := FUNCTION
//  EXPORT DATASET(debug_init.Layout_Sample_Matches) batchCompare_Detail(DATASET(ProxIDPairDtl_lo) pairs, BOOLEAN check_already = FALSE, BOOLEAN check_linkblock = FALSE) := FUNCTION
    //comp    := compareProxIDBatch_New(pairs, roll_cand, use_allm);
    comp    := IF(COUNT(pairs)<=100, PROJECT(pairs, compareProxIDBatch_Old(LEFT)), compareProxIDBatch_New(pairs)); // Is this causing the split/spill dataset too large issues? W20200505-095248 g1sg46
    //already := JOIN(DISTRIBUTE(comp(will_link='U'),HASH32(from_ProxID)), base, LEFT.from_ProxID=RIGHT.rid, TRANSFORM(comparison_lo,
    //PML This join to check if IDs already linked can take a long time, as does base distro by RID.  Just use a filter for small result sets.
    already := IF(check_already, IF(COUNT(comp)<100,
                 JOIN(comp, base(rcid IN SET(comp,from_ProxID)), LEFT.from_ProxID=RIGHT.rcid, TRANSFORM(comparison_lo,
                   SELF.will_link := IF(LEFT.to_ProxID=RIGHT.ProxID,'A',LEFT.will_link), SELF:=LEFT), LEFT OUTER, FEW),
                 JOIN(DISTRIBUTE(comp,HASH32(from_ProxID)), DISTRIBUTE(base,HASH32(rcid)), LEFT.from_ProxID=RIGHT.rcid, TRANSFORM(comparison_lo,
                   SELF.will_link := IF(LEFT.to_ProxID=RIGHT.ProxID,'A',LEFT.will_link), SELF:=LEFT), LEFT OUTER, LOCAL)),
                 comp);
    //combo   := DISTRIBUTE(already+comp(will_link<>'U'),HASH32(to_ProxID));
    //w_lb    := JOIN(combo, linkblock_curr, LEFT.from_ProxID=RIGHT.left_ProxID AND LEFT.to_ProxID=RIGHT.right_ProxID, TRANSFORM(comparison_lo,
//    w_lb    := JOIN(already, linkblock_curr, LEFT.from_ProxID=RIGHT.left_ProxID AND LEFT.to_ProxID=RIGHT.right_ProxID, TRANSFORM(comparison_lo,
//                 SELF.blocked   := IF(RIGHT.left_ProxID>0,RIGHT.auditsource,''),
//                 SELF.will_link := IF(LEFT.will_link<>'A' AND TRIM(SELF.blocked)>'','N',LEFT.will_link), SELF:=LEFT), LEFT OUTER, LOCAL);
//    out     := IF(check_linkblock, w_lb, already);
    out     := already;
    RETURN out;
  END;
 
  EXPORT DATASET(comparison_lo) batchCompare       (DATASET(ProxIDPair_lo)    pairs, BOOLEAN roll_cand = TRUE, BOOLEAN use_allm = FALSE, BOOLEAN check_already = FALSE, BOOLEAN check_linkblock = FALSE) := FUNCTION
//  EXPORT DATASET(debug_init.Layout_Sample_Matches) batchCompare       (DATASET(ProxIDPair_lo)    pairs, BOOLEAN check_already = FALSE, BOOLEAN check_linkblock = FALSE) := FUNCTION
    order   := PROJECT(pairs, TRANSFORM(ProxIDPairDtl_lo, SELF.from_ProxID:=MAX(LEFT.ProxID1,LEFT.ProxID2), SELF.to_ProxID:=MIN(LEFT.ProxID1,LEFT.ProxID2), SELF:=[]));
    //segs1   := JOIN(DISTRIBUTE(order,HASH32(from_ProxID)), segs, LEFT.from_ProxID=RIGHT.ProxID, TRANSFORM(ProxIDPairDtl_lo, SELF.from_seg:=IF(RIGHT.ProxID>0,RIGHT.segmentation_ind,'N/A'), SELF:=LEFT), LEFT OUTER, LOCAL);
    //segs2   := JOIN(DISTRIBUTE(segs1,HASH32(to_ProxID))  , segs, LEFT.to_ProxID  =RIGHT.ProxID, TRANSFORM(ProxIDPairDtl_lo, SELF.to_seg  :=IF(RIGHT.ProxID>0,RIGHT.segmentation_ind,'N/A'), SELF:=LEFT), LEFT OUTER, LOCAL);
    //results := batchCompare_Detail(segs2, check_linkblock);
    results := batchCompare_Detail(order, roll_cand, use_allm, check_already, check_linkblock);
    RETURN results;
  END;
 
  EXPORT samples(DATASET(comparison_lo) comp) := MODULE
    EXPORT already_linked   := comp(will_link='A');
    EXPORT will_link        := comp(will_link='Y');
    EXPORT over_no_link     := comp(will_link='N' AND scored[..4]='OVER');
    EXPORT under            := comp(scored='UNDER');
    EXPORT under_low        := comp(scored='UNDER_LOW');
    EXPORT under_neg        := comp(scored='UNDER_NEG');
    EXPORT forced_mix       := comp(forced='MIX');
    EXPORT forced_cname     := comp(forced='CNAME');
    EXPORT forced_cnum      := comp(forced='CNUM');
    EXPORT forced_ent_a     := comp(forced='ENT_A');
    EXPORT forced_dcorp_a   := comp(forced='DCORP_A');
    EXPORT forced_addrp     := comp(forced='ADDRP');
    EXPORT forced_addrpr    := comp(forced='ADDRPR');
    EXPORT forced_addrpn    := comp(forced='ADDRPN');
    EXPORT forced_addrcsz   := comp(forced='ADDRCSZ');
    EXPORT forced_addrst    := comp(forced='ADDRST');
    EXPORT forced_addrx     := comp(forced='ADDRX');
    //EXPORT blocked_hcp      := comp(blocked='HCP');
    //EXPORT blocked_mas      := comp(blocked='MAS');
    //EXPORT blocked_both     := comp(blocked='BOTH');
  END;

  EXPORT output_samples(DATASET(comparison_lo) comp, UNSIGNED8 cnt = 100) := FUNCTION
    samp := samples(comp);
 
    RETURN ORDERED(
      OUTPUT(CHOOSEN(samp.already_linked,cnt)  ,NAMED('samples_already_linked')  ,ALL),
      OUTPUT(CHOOSEN(samp.will_link,cnt)       ,NAMED('samples_will_link')       ,ALL),
      OUTPUT(CHOOSEN(samp.over_no_link,cnt)    ,NAMED('samples_over_no_link')    ,ALL),
      OUTPUT(CHOOSEN(samp.under,cnt)           ,NAMED('samples_under')           ,ALL),
      OUTPUT(CHOOSEN(samp.under_low,cnt)       ,NAMED('samples_under_low')       ,ALL),
      OUTPUT(CHOOSEN(samp.under_neg,cnt)       ,NAMED('samples_under_neg')       ,ALL),
      OUTPUT(CHOOSEN(samp.forced_mix,cnt)      ,NAMED('samples_forced_mix')      ,ALL),
      OUTPUT(CHOOSEN(samp.forced_cname,cnt)    ,NAMED('samples_forced_cname')    ,ALL),
      OUTPUT(CHOOSEN(samp.forced_cnum,cnt)     ,NAMED('samples_forced_cnum')     ,ALL),
      OUTPUT(CHOOSEN(samp.forced_ent_a,cnt)    ,NAMED('samples_forced_ent_a')    ,ALL),
      OUTPUT(CHOOSEN(samp.forced_dcorp_a,cnt)  ,NAMED('samples_forced_dcorp_a')  ,ALL),
      OUTPUT(CHOOSEN(samp.forced_addrp,cnt)    ,NAMED('samples_forced_addrp')    ,ALL),
      OUTPUT(CHOOSEN(samp.forced_addrpr,cnt)   ,NAMED('samples_forced_addrpr')   ,ALL),
      OUTPUT(CHOOSEN(samp.forced_addrpn,cnt)   ,NAMED('samples_forced_addrpn')   ,ALL),
      OUTPUT(CHOOSEN(samp.forced_addrcsz,cnt)  ,NAMED('samples_forced_addrcsz')  ,ALL),
      OUTPUT(CHOOSEN(samp.forced_addrst,cnt)   ,NAMED('samples_forced_addrst')   ,ALL),
      OUTPUT(CHOOSEN(samp.forced_addrx,cnt)    ,NAMED('samples_forced_addrx')    ,ALL),
      //OUTPUT(CHOOSEN(samp.blocked_hcp,cnt)     ,NAMED('samples_blocked_hcp')     ,ALL),
      //OUTPUT(CHOOSEN(samp.blocked_mas,cnt)     ,NAMED('samples_blocked_mas')     ,ALL),
      //OUTPUT(CHOOSEN(samp.blocked_both,cnt)    ,NAMED('samples_blocked_both')    ,ALL)
    );
  END;

  //EXPORT calculateStats(DATASET(comparison_lo) comp) := FUNCTION
    //RETURN calculateComparisonStats(comp(from_ProxID>0 AND to_ProxID>0));
  //END;
 
END;
