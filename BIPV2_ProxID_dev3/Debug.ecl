// Various routines to assist in debugging
 
IMPORT SALT26,ut;
EXPORT Debug(DATASET(layout_DOT_Base) ih, Layout_Specificities.R s, MatchThreshold = 21) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
  INTEGER2 Conf;
  INTEGER2 Conf_Prop;
  INTEGER2 DateOverlap := 0;
  SALT26.UIDType Proxid1;
  SALT26.UIDType Proxid2;
  SALT26.UIDType rcid1;
  SALT26.UIDType rcid2;
  typeof(h.cnp_number) left_cnp_number;
  INTEGER2 cnp_number_score;
  BOOLEAN cnp_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_number) right_cnp_number;
  typeof(h.prim_range) left_prim_range;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.prim_name) left_prim_name;
  INTEGER2 prim_name_score;
  BOOLEAN prim_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_name) right_prim_name;
  typeof(h.st) left_st;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  typeof(h.st) right_st;
  typeof(h.active_enterprise_number) left_active_enterprise_number;
  INTEGER2 active_enterprise_number_score;
  BOOLEAN active_enterprise_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_enterprise_number) right_active_enterprise_number;
  typeof(h.MN_foreign_corp_key) left_MN_foreign_corp_key;
  INTEGER2 MN_foreign_corp_key_score;
  BOOLEAN MN_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MN_foreign_corp_key) right_MN_foreign_corp_key;
  typeof(h.NJ_foreign_corp_key) left_NJ_foreign_corp_key;
  INTEGER2 NJ_foreign_corp_key_score;
  BOOLEAN NJ_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NJ_foreign_corp_key) right_NJ_foreign_corp_key;
  typeof(h.active_duns_number) left_active_duns_number;
  INTEGER2 active_duns_number_score;
  BOOLEAN active_duns_number_skipped := FALSE; // True if FORCE blocks match
  typeof(h.active_duns_number) right_active_duns_number;
  typeof(h.hist_enterprise_number) left_hist_enterprise_number;
  INTEGER2 hist_enterprise_number_score;
  typeof(h.hist_enterprise_number) right_hist_enterprise_number;
  typeof(h.hist_duns_number) left_hist_duns_number;
  INTEGER2 hist_duns_number_score;
  typeof(h.hist_duns_number) right_hist_duns_number;
  typeof(h.ebr_file_number) left_ebr_file_number;
  INTEGER2 ebr_file_number_score;
  typeof(h.ebr_file_number) right_ebr_file_number;
  typeof(h.AR_foreign_corp_key) left_AR_foreign_corp_key;
  INTEGER2 AR_foreign_corp_key_score;
  BOOLEAN AR_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.AR_foreign_corp_key) right_AR_foreign_corp_key;
  typeof(h.CA_foreign_corp_key) left_CA_foreign_corp_key;
  INTEGER2 CA_foreign_corp_key_score;
  BOOLEAN CA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CA_foreign_corp_key) right_CA_foreign_corp_key;
  typeof(h.CO_foreign_corp_key) left_CO_foreign_corp_key;
  INTEGER2 CO_foreign_corp_key_score;
  BOOLEAN CO_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CO_foreign_corp_key) right_CO_foreign_corp_key;
  typeof(h.DC_foreign_corp_key) left_DC_foreign_corp_key;
  INTEGER2 DC_foreign_corp_key_score;
  BOOLEAN DC_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.DC_foreign_corp_key) right_DC_foreign_corp_key;
  typeof(h.KS_foreign_corp_key) left_KS_foreign_corp_key;
  INTEGER2 KS_foreign_corp_key_score;
  BOOLEAN KS_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.KS_foreign_corp_key) right_KS_foreign_corp_key;
  typeof(h.KY_foreign_corp_key) left_KY_foreign_corp_key;
  INTEGER2 KY_foreign_corp_key_score;
  BOOLEAN KY_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.KY_foreign_corp_key) right_KY_foreign_corp_key;
  typeof(h.MA_foreign_corp_key) left_MA_foreign_corp_key;
  INTEGER2 MA_foreign_corp_key_score;
  BOOLEAN MA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MA_foreign_corp_key) right_MA_foreign_corp_key;
  typeof(h.MD_foreign_corp_key) left_MD_foreign_corp_key;
  INTEGER2 MD_foreign_corp_key_score;
  BOOLEAN MD_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MD_foreign_corp_key) right_MD_foreign_corp_key;
  typeof(h.ME_foreign_corp_key) left_ME_foreign_corp_key;
  INTEGER2 ME_foreign_corp_key_score;
  BOOLEAN ME_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.ME_foreign_corp_key) right_ME_foreign_corp_key;
  typeof(h.MI_foreign_corp_key) left_MI_foreign_corp_key;
  INTEGER2 MI_foreign_corp_key_score;
  BOOLEAN MI_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MI_foreign_corp_key) right_MI_foreign_corp_key;
  typeof(h.MO_foreign_corp_key) left_MO_foreign_corp_key;
  INTEGER2 MO_foreign_corp_key_score;
  BOOLEAN MO_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MO_foreign_corp_key) right_MO_foreign_corp_key;
  typeof(h.NC_foreign_corp_key) left_NC_foreign_corp_key;
  INTEGER2 NC_foreign_corp_key_score;
  BOOLEAN NC_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NC_foreign_corp_key) right_NC_foreign_corp_key;
  typeof(h.ND_foreign_corp_key) left_ND_foreign_corp_key;
  INTEGER2 ND_foreign_corp_key_score;
  BOOLEAN ND_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.ND_foreign_corp_key) right_ND_foreign_corp_key;
  typeof(h.NM_foreign_corp_key) left_NM_foreign_corp_key;
  INTEGER2 NM_foreign_corp_key_score;
  BOOLEAN NM_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NM_foreign_corp_key) right_NM_foreign_corp_key;
  typeof(h.OK_foreign_corp_key) left_OK_foreign_corp_key;
  INTEGER2 OK_foreign_corp_key_score;
  BOOLEAN OK_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.OK_foreign_corp_key) right_OK_foreign_corp_key;
  typeof(h.PA_foreign_corp_key) left_PA_foreign_corp_key;
  INTEGER2 PA_foreign_corp_key_score;
  BOOLEAN PA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.PA_foreign_corp_key) right_PA_foreign_corp_key;
  typeof(h.SC_foreign_corp_key) left_SC_foreign_corp_key;
  INTEGER2 SC_foreign_corp_key_score;
  BOOLEAN SC_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.SC_foreign_corp_key) right_SC_foreign_corp_key;
  typeof(h.SD_foreign_corp_key) left_SD_foreign_corp_key;
  INTEGER2 SD_foreign_corp_key_score;
  BOOLEAN SD_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.SD_foreign_corp_key) right_SD_foreign_corp_key;
  typeof(h.TN_foreign_corp_key) left_TN_foreign_corp_key;
  INTEGER2 TN_foreign_corp_key_score;
  BOOLEAN TN_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.TN_foreign_corp_key) right_TN_foreign_corp_key;
  typeof(h.VT_foreign_corp_key) left_VT_foreign_corp_key;
  INTEGER2 VT_foreign_corp_key_score;
  BOOLEAN VT_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.VT_foreign_corp_key) right_VT_foreign_corp_key;
  typeof(h.company_phone) left_company_phone;
  INTEGER2 company_phone_score;
  typeof(h.company_phone) right_company_phone;
  typeof(h.domestic_corp_key) left_domestic_corp_key;
  INTEGER2 domestic_corp_key_score;
  BOOLEAN domestic_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.domestic_corp_key) right_domestic_corp_key;
  typeof(h.AL_foreign_corp_key) left_AL_foreign_corp_key;
  INTEGER2 AL_foreign_corp_key_score;
  BOOLEAN AL_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.AL_foreign_corp_key) right_AL_foreign_corp_key;
  typeof(h.FL_foreign_corp_key) left_FL_foreign_corp_key;
  INTEGER2 FL_foreign_corp_key_score;
  BOOLEAN FL_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.FL_foreign_corp_key) right_FL_foreign_corp_key;
  typeof(h.GA_foreign_corp_key) left_GA_foreign_corp_key;
  INTEGER2 GA_foreign_corp_key_score;
  BOOLEAN GA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.GA_foreign_corp_key) right_GA_foreign_corp_key;
  typeof(h.IL_foreign_corp_key) left_IL_foreign_corp_key;
  INTEGER2 IL_foreign_corp_key_score;
  BOOLEAN IL_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.IL_foreign_corp_key) right_IL_foreign_corp_key;
  typeof(h.IN_foreign_corp_key) left_IN_foreign_corp_key;
  INTEGER2 IN_foreign_corp_key_score;
  BOOLEAN IN_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.IN_foreign_corp_key) right_IN_foreign_corp_key;
  typeof(h.MS_foreign_corp_key) left_MS_foreign_corp_key;
  INTEGER2 MS_foreign_corp_key_score;
  BOOLEAN MS_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MS_foreign_corp_key) right_MS_foreign_corp_key;
  typeof(h.NH_foreign_corp_key) left_NH_foreign_corp_key;
  INTEGER2 NH_foreign_corp_key_score;
  BOOLEAN NH_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NH_foreign_corp_key) right_NH_foreign_corp_key;
  typeof(h.NV_foreign_corp_key) left_NV_foreign_corp_key;
  INTEGER2 NV_foreign_corp_key_score;
  BOOLEAN NV_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NV_foreign_corp_key) right_NV_foreign_corp_key;
  typeof(h.NY_foreign_corp_key) left_NY_foreign_corp_key;
  INTEGER2 NY_foreign_corp_key_score;
  BOOLEAN NY_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NY_foreign_corp_key) right_NY_foreign_corp_key;
  typeof(h.OR_foreign_corp_key) left_OR_foreign_corp_key;
  INTEGER2 OR_foreign_corp_key_score;
  BOOLEAN OR_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.OR_foreign_corp_key) right_OR_foreign_corp_key;
  typeof(h.RI_foreign_corp_key) left_RI_foreign_corp_key;
  INTEGER2 RI_foreign_corp_key_score;
  BOOLEAN RI_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.RI_foreign_corp_key) right_RI_foreign_corp_key;
  typeof(h.UT_foreign_corp_key) left_UT_foreign_corp_key;
  INTEGER2 UT_foreign_corp_key_score;
  BOOLEAN UT_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.UT_foreign_corp_key) right_UT_foreign_corp_key;
  typeof(h.company_fein) left_company_fein;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.cnp_name) left_cnp_name;
  INTEGER2 cnp_name_score;
  BOOLEAN cnp_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.cnp_name) right_cnp_name;
  typeof(h.company_address) left_company_address;
  INTEGER2 company_address_score;
  BOOLEAN company_address_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_address) right_company_address;
  typeof(h.AK_foreign_corp_key) left_AK_foreign_corp_key;
  INTEGER2 AK_foreign_corp_key_score;
  BOOLEAN AK_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.AK_foreign_corp_key) right_AK_foreign_corp_key;
  typeof(h.CT_foreign_corp_key) left_CT_foreign_corp_key;
  INTEGER2 CT_foreign_corp_key_score;
  BOOLEAN CT_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.CT_foreign_corp_key) right_CT_foreign_corp_key;
  typeof(h.HI_foreign_corp_key) left_HI_foreign_corp_key;
  INTEGER2 HI_foreign_corp_key_score;
  BOOLEAN HI_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.HI_foreign_corp_key) right_HI_foreign_corp_key;
  typeof(h.IA_foreign_corp_key) left_IA_foreign_corp_key;
  INTEGER2 IA_foreign_corp_key_score;
  BOOLEAN IA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.IA_foreign_corp_key) right_IA_foreign_corp_key;
  typeof(h.LA_foreign_corp_key) left_LA_foreign_corp_key;
  INTEGER2 LA_foreign_corp_key_score;
  BOOLEAN LA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.LA_foreign_corp_key) right_LA_foreign_corp_key;
  typeof(h.MT_foreign_corp_key) left_MT_foreign_corp_key;
  INTEGER2 MT_foreign_corp_key_score;
  BOOLEAN MT_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.MT_foreign_corp_key) right_MT_foreign_corp_key;
  typeof(h.NE_foreign_corp_key) left_NE_foreign_corp_key;
  INTEGER2 NE_foreign_corp_key_score;
  BOOLEAN NE_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.NE_foreign_corp_key) right_NE_foreign_corp_key;
  typeof(h.VA_foreign_corp_key) left_VA_foreign_corp_key;
  INTEGER2 VA_foreign_corp_key_score;
  BOOLEAN VA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.VA_foreign_corp_key) right_VA_foreign_corp_key;
  typeof(h.AZ_foreign_corp_key) left_AZ_foreign_corp_key;
  INTEGER2 AZ_foreign_corp_key_score;
  BOOLEAN AZ_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.AZ_foreign_corp_key) right_AZ_foreign_corp_key;
  typeof(h.TX_foreign_corp_key) left_TX_foreign_corp_key;
  INTEGER2 TX_foreign_corp_key_score;
  BOOLEAN TX_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.TX_foreign_corp_key) right_TX_foreign_corp_key;
  typeof(h.company_addr1) left_company_addr1;
  INTEGER2 company_addr1_score;
  typeof(h.company_addr1) right_company_addr1;
  typeof(h.zip) left_zip;
  INTEGER2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.company_csz) left_company_csz;
  INTEGER2 company_csz_score;
  BOOLEAN company_csz_skipped := FALSE; // True if FORCE blocks match
  typeof(h.company_csz) right_company_csz;
  typeof(h.sec_range) left_sec_range;
  INTEGER2 sec_range_score;
  typeof(h.sec_range) right_sec_range;
  typeof(h.v_city_name) left_v_city_name;
  INTEGER2 v_city_name_score;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.cnp_btype) left_cnp_btype;
  INTEGER2 cnp_btype_score;
  typeof(h.cnp_btype) right_cnp_btype;
  typeof(h.iscorp) left_iscorp;
  INTEGER2 iscorp_score;
  typeof(h.iscorp) right_iscorp;
  typeof(h.cnp_lowv) left_cnp_lowv;
  typeof(h.cnp_lowv) right_cnp_lowv;
  typeof(h.cnp_translated) left_cnp_translated;
  typeof(h.cnp_translated) right_cnp_translated;
  typeof(h.cnp_classid) left_cnp_classid;
  typeof(h.cnp_classid) right_cnp_classid;
  typeof(h.company_foreign_domestic) left_company_foreign_domestic;
  typeof(h.company_foreign_domestic) right_company_foreign_domestic;
  typeof(h.company_bdid) left_company_bdid;
  typeof(h.company_bdid) right_company_bdid;
  typeof(h.cnp_hasnumber) left_cnp_hasnumber;
  typeof(h.cnp_hasnumber) right_cnp_hasnumber;
  typeof(h.company_name) left_company_name;
  typeof(h.company_name) right_company_name;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
  typeof(h.DE_foreign_corp_key) left_DE_foreign_corp_key;
  INTEGER2 DE_foreign_corp_key_score;
  BOOLEAN DE_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.DE_foreign_corp_key) right_DE_foreign_corp_key;
  typeof(h.ID_foreign_corp_key) left_ID_foreign_corp_key;
  INTEGER2 ID_foreign_corp_key_score;
  BOOLEAN ID_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.ID_foreign_corp_key) right_ID_foreign_corp_key;
  typeof(h.OH_foreign_corp_key) left_OH_foreign_corp_key;
  INTEGER2 OH_foreign_corp_key_score;
  BOOLEAN OH_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.OH_foreign_corp_key) right_OH_foreign_corp_key;
  typeof(h.PR_foreign_corp_key) left_PR_foreign_corp_key;
  INTEGER2 PR_foreign_corp_key_score;
  BOOLEAN PR_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.PR_foreign_corp_key) right_PR_foreign_corp_key;
  typeof(h.VI_foreign_corp_key) left_VI_foreign_corp_key;
  INTEGER2 VI_foreign_corp_key_score;
  BOOLEAN VI_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.VI_foreign_corp_key) right_VI_foreign_corp_key;
  typeof(h.WA_foreign_corp_key) left_WA_foreign_corp_key;
  INTEGER2 WA_foreign_corp_key_score;
  BOOLEAN WA_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.WA_foreign_corp_key) right_WA_foreign_corp_key;
  typeof(h.WI_foreign_corp_key) left_WI_foreign_corp_key;
  INTEGER2 WI_foreign_corp_key_score;
  BOOLEAN WI_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.WI_foreign_corp_key) right_WI_foreign_corp_key;
  typeof(h.WV_foreign_corp_key) left_WV_foreign_corp_key;
  INTEGER2 WV_foreign_corp_key_score;
  BOOLEAN WV_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.WV_foreign_corp_key) right_WV_foreign_corp_key;
  typeof(h.WY_foreign_corp_key) left_WY_foreign_corp_key;
  INTEGER2 WY_foreign_corp_key_score;
  BOOLEAN WY_foreign_corp_key_skipped := FALSE; // True if FORCE blocks match
  typeof(h.WY_foreign_corp_key) right_WY_foreign_corp_key;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT26.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_cnp_number := le.cnp_number;
  SELF.right_cnp_number := ri.cnp_number;
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT26.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  SELF.left_active_enterprise_number := le.active_enterprise_number;
  SELF.right_active_enterprise_number := ri.active_enterprise_number;
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT26.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  SELF.left_MN_foreign_corp_key := le.MN_foreign_corp_key;
  SELF.right_MN_foreign_corp_key := ri.MN_foreign_corp_key;
  INTEGER2 MN_foreign_corp_key_score_temp := MAP( le.MN_foreign_corp_key_isnull OR ri.MN_foreign_corp_key_isnull => 0,
                        le.MN_foreign_corp_key = ri.MN_foreign_corp_key  => le.MN_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MN_foreign_corp_key_weight100,s.MN_foreign_corp_key_switch));
  SELF.left_NJ_foreign_corp_key := le.NJ_foreign_corp_key;
  SELF.right_NJ_foreign_corp_key := ri.NJ_foreign_corp_key;
  INTEGER2 NJ_foreign_corp_key_score_temp := MAP( le.NJ_foreign_corp_key_isnull OR ri.NJ_foreign_corp_key_isnull => 0,
                        le.NJ_foreign_corp_key = ri.NJ_foreign_corp_key  => le.NJ_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NJ_foreign_corp_key_weight100,s.NJ_foreign_corp_key_switch));
  SELF.left_active_duns_number := le.active_duns_number;
  SELF.right_active_duns_number := ri.active_duns_number;
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT26.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  SELF.left_hist_enterprise_number := le.hist_enterprise_number;
  SELF.right_hist_enterprise_number := ri.hist_enterprise_number;
  SELF.hist_enterprise_number_score := MAP( le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => 0,
                        le.hist_enterprise_number = ri.hist_enterprise_number  => le.hist_enterprise_number_weight100,
                        0 /* switch0 */);
  SELF.left_hist_duns_number := le.hist_duns_number;
  SELF.right_hist_duns_number := ri.hist_duns_number;
  SELF.hist_duns_number_score := MAP( le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => 0,
                        le.hist_duns_number = ri.hist_duns_number  => le.hist_duns_number_weight100,
                        0 /* switch0 */);
  SELF.left_ebr_file_number := le.ebr_file_number;
  SELF.right_ebr_file_number := ri.ebr_file_number;
  SELF.ebr_file_number_score := MAP( le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => 0,
                        le.ebr_file_number = ri.ebr_file_number  => le.ebr_file_number_weight100,
                        0 /* switch0 */);
  SELF.left_AR_foreign_corp_key := le.AR_foreign_corp_key;
  SELF.right_AR_foreign_corp_key := ri.AR_foreign_corp_key;
  INTEGER2 AR_foreign_corp_key_score_temp := MAP( le.AR_foreign_corp_key_isnull OR ri.AR_foreign_corp_key_isnull => 0,
                        le.AR_foreign_corp_key = ri.AR_foreign_corp_key  => le.AR_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AR_foreign_corp_key_weight100,s.AR_foreign_corp_key_switch));
  SELF.left_CA_foreign_corp_key := le.CA_foreign_corp_key;
  SELF.right_CA_foreign_corp_key := ri.CA_foreign_corp_key;
  INTEGER2 CA_foreign_corp_key_score_temp := MAP( le.CA_foreign_corp_key_isnull OR ri.CA_foreign_corp_key_isnull => 0,
                        le.CA_foreign_corp_key = ri.CA_foreign_corp_key  => le.CA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.CA_foreign_corp_key_weight100,s.CA_foreign_corp_key_switch));
  SELF.left_CO_foreign_corp_key := le.CO_foreign_corp_key;
  SELF.right_CO_foreign_corp_key := ri.CO_foreign_corp_key;
  INTEGER2 CO_foreign_corp_key_score_temp := MAP( le.CO_foreign_corp_key_isnull OR ri.CO_foreign_corp_key_isnull => 0,
                        le.CO_foreign_corp_key = ri.CO_foreign_corp_key  => le.CO_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.CO_foreign_corp_key_weight100,s.CO_foreign_corp_key_switch));
  SELF.left_DC_foreign_corp_key := le.DC_foreign_corp_key;
  SELF.right_DC_foreign_corp_key := ri.DC_foreign_corp_key;
  INTEGER2 DC_foreign_corp_key_score_temp := MAP( le.DC_foreign_corp_key_isnull OR ri.DC_foreign_corp_key_isnull => 0,
                        le.DC_foreign_corp_key = ri.DC_foreign_corp_key  => le.DC_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.DC_foreign_corp_key_weight100,s.DC_foreign_corp_key_switch));
  SELF.left_KS_foreign_corp_key := le.KS_foreign_corp_key;
  SELF.right_KS_foreign_corp_key := ri.KS_foreign_corp_key;
  INTEGER2 KS_foreign_corp_key_score_temp := MAP( le.KS_foreign_corp_key_isnull OR ri.KS_foreign_corp_key_isnull => 0,
                        le.KS_foreign_corp_key = ri.KS_foreign_corp_key  => le.KS_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.KS_foreign_corp_key_weight100,s.KS_foreign_corp_key_switch));
  SELF.left_KY_foreign_corp_key := le.KY_foreign_corp_key;
  SELF.right_KY_foreign_corp_key := ri.KY_foreign_corp_key;
  INTEGER2 KY_foreign_corp_key_score_temp := MAP( le.KY_foreign_corp_key_isnull OR ri.KY_foreign_corp_key_isnull => 0,
                        le.KY_foreign_corp_key = ri.KY_foreign_corp_key  => le.KY_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.KY_foreign_corp_key_weight100,s.KY_foreign_corp_key_switch));
  SELF.left_MA_foreign_corp_key := le.MA_foreign_corp_key;
  SELF.right_MA_foreign_corp_key := ri.MA_foreign_corp_key;
  INTEGER2 MA_foreign_corp_key_score_temp := MAP( le.MA_foreign_corp_key_isnull OR ri.MA_foreign_corp_key_isnull => 0,
                        le.MA_foreign_corp_key = ri.MA_foreign_corp_key  => le.MA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MA_foreign_corp_key_weight100,s.MA_foreign_corp_key_switch));
  SELF.left_MD_foreign_corp_key := le.MD_foreign_corp_key;
  SELF.right_MD_foreign_corp_key := ri.MD_foreign_corp_key;
  INTEGER2 MD_foreign_corp_key_score_temp := MAP( le.MD_foreign_corp_key_isnull OR ri.MD_foreign_corp_key_isnull => 0,
                        le.MD_foreign_corp_key = ri.MD_foreign_corp_key  => le.MD_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MD_foreign_corp_key_weight100,s.MD_foreign_corp_key_switch));
  SELF.left_ME_foreign_corp_key := le.ME_foreign_corp_key;
  SELF.right_ME_foreign_corp_key := ri.ME_foreign_corp_key;
  INTEGER2 ME_foreign_corp_key_score_temp := MAP( le.ME_foreign_corp_key_isnull OR ri.ME_foreign_corp_key_isnull => 0,
                        le.ME_foreign_corp_key = ri.ME_foreign_corp_key  => le.ME_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.ME_foreign_corp_key_weight100,s.ME_foreign_corp_key_switch));
  SELF.left_MI_foreign_corp_key := le.MI_foreign_corp_key;
  SELF.right_MI_foreign_corp_key := ri.MI_foreign_corp_key;
  INTEGER2 MI_foreign_corp_key_score_temp := MAP( le.MI_foreign_corp_key_isnull OR ri.MI_foreign_corp_key_isnull => 0,
                        le.MI_foreign_corp_key = ri.MI_foreign_corp_key  => le.MI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MI_foreign_corp_key_weight100,s.MI_foreign_corp_key_switch));
  SELF.left_MO_foreign_corp_key := le.MO_foreign_corp_key;
  SELF.right_MO_foreign_corp_key := ri.MO_foreign_corp_key;
  INTEGER2 MO_foreign_corp_key_score_temp := MAP( le.MO_foreign_corp_key_isnull OR ri.MO_foreign_corp_key_isnull => 0,
                        le.MO_foreign_corp_key = ri.MO_foreign_corp_key  => le.MO_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MO_foreign_corp_key_weight100,s.MO_foreign_corp_key_switch));
  SELF.left_NC_foreign_corp_key := le.NC_foreign_corp_key;
  SELF.right_NC_foreign_corp_key := ri.NC_foreign_corp_key;
  INTEGER2 NC_foreign_corp_key_score_temp := MAP( le.NC_foreign_corp_key_isnull OR ri.NC_foreign_corp_key_isnull => 0,
                        le.NC_foreign_corp_key = ri.NC_foreign_corp_key  => le.NC_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NC_foreign_corp_key_weight100,s.NC_foreign_corp_key_switch));
  SELF.left_ND_foreign_corp_key := le.ND_foreign_corp_key;
  SELF.right_ND_foreign_corp_key := ri.ND_foreign_corp_key;
  INTEGER2 ND_foreign_corp_key_score_temp := MAP( le.ND_foreign_corp_key_isnull OR ri.ND_foreign_corp_key_isnull => 0,
                        le.ND_foreign_corp_key = ri.ND_foreign_corp_key  => le.ND_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.ND_foreign_corp_key_weight100,s.ND_foreign_corp_key_switch));
  SELF.left_NM_foreign_corp_key := le.NM_foreign_corp_key;
  SELF.right_NM_foreign_corp_key := ri.NM_foreign_corp_key;
  INTEGER2 NM_foreign_corp_key_score_temp := MAP( le.NM_foreign_corp_key_isnull OR ri.NM_foreign_corp_key_isnull => 0,
                        le.NM_foreign_corp_key = ri.NM_foreign_corp_key  => le.NM_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NM_foreign_corp_key_weight100,s.NM_foreign_corp_key_switch));
  SELF.left_OK_foreign_corp_key := le.OK_foreign_corp_key;
  SELF.right_OK_foreign_corp_key := ri.OK_foreign_corp_key;
  INTEGER2 OK_foreign_corp_key_score_temp := MAP( le.OK_foreign_corp_key_isnull OR ri.OK_foreign_corp_key_isnull => 0,
                        le.OK_foreign_corp_key = ri.OK_foreign_corp_key  => le.OK_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.OK_foreign_corp_key_weight100,s.OK_foreign_corp_key_switch));
  SELF.left_PA_foreign_corp_key := le.PA_foreign_corp_key;
  SELF.right_PA_foreign_corp_key := ri.PA_foreign_corp_key;
  INTEGER2 PA_foreign_corp_key_score_temp := MAP( le.PA_foreign_corp_key_isnull OR ri.PA_foreign_corp_key_isnull => 0,
                        le.PA_foreign_corp_key = ri.PA_foreign_corp_key  => le.PA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.PA_foreign_corp_key_weight100,s.PA_foreign_corp_key_switch));
  SELF.left_SC_foreign_corp_key := le.SC_foreign_corp_key;
  SELF.right_SC_foreign_corp_key := ri.SC_foreign_corp_key;
  INTEGER2 SC_foreign_corp_key_score_temp := MAP( le.SC_foreign_corp_key_isnull OR ri.SC_foreign_corp_key_isnull => 0,
                        le.SC_foreign_corp_key = ri.SC_foreign_corp_key  => le.SC_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.SC_foreign_corp_key_weight100,s.SC_foreign_corp_key_switch));
  SELF.left_SD_foreign_corp_key := le.SD_foreign_corp_key;
  SELF.right_SD_foreign_corp_key := ri.SD_foreign_corp_key;
  INTEGER2 SD_foreign_corp_key_score_temp := MAP( le.SD_foreign_corp_key_isnull OR ri.SD_foreign_corp_key_isnull => 0,
                        le.SD_foreign_corp_key = ri.SD_foreign_corp_key  => le.SD_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.SD_foreign_corp_key_weight100,s.SD_foreign_corp_key_switch));
  SELF.left_TN_foreign_corp_key := le.TN_foreign_corp_key;
  SELF.right_TN_foreign_corp_key := ri.TN_foreign_corp_key;
  INTEGER2 TN_foreign_corp_key_score_temp := MAP( le.TN_foreign_corp_key_isnull OR ri.TN_foreign_corp_key_isnull => 0,
                        le.TN_foreign_corp_key = ri.TN_foreign_corp_key  => le.TN_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.TN_foreign_corp_key_weight100,s.TN_foreign_corp_key_switch));
  SELF.left_VT_foreign_corp_key := le.VT_foreign_corp_key;
  SELF.right_VT_foreign_corp_key := ri.VT_foreign_corp_key;
  INTEGER2 VT_foreign_corp_key_score_temp := MAP( le.VT_foreign_corp_key_isnull OR ri.VT_foreign_corp_key_isnull => 0,
                        le.VT_foreign_corp_key = ri.VT_foreign_corp_key  => le.VT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.VT_foreign_corp_key_weight100,s.VT_foreign_corp_key_switch));
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  SELF.company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        0 /* switch0 */);
  SELF.left_domestic_corp_key := le.domestic_corp_key;
  SELF.right_domestic_corp_key := ri.domestic_corp_key;
  INTEGER2 domestic_corp_key_score_temp := MAP( le.domestic_corp_key_isnull OR ri.domestic_corp_key_isnull => 0,
                        le.domestic_corp_key = ri.domestic_corp_key  => le.domestic_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.domestic_corp_key_weight100,s.domestic_corp_key_switch));
  SELF.left_AL_foreign_corp_key := le.AL_foreign_corp_key;
  SELF.right_AL_foreign_corp_key := ri.AL_foreign_corp_key;
  INTEGER2 AL_foreign_corp_key_score_temp := MAP( le.AL_foreign_corp_key_isnull OR ri.AL_foreign_corp_key_isnull => 0,
                        le.AL_foreign_corp_key = ri.AL_foreign_corp_key  => le.AL_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AL_foreign_corp_key_weight100,s.AL_foreign_corp_key_switch));
  SELF.left_FL_foreign_corp_key := le.FL_foreign_corp_key;
  SELF.right_FL_foreign_corp_key := ri.FL_foreign_corp_key;
  INTEGER2 FL_foreign_corp_key_score_temp := MAP( le.FL_foreign_corp_key_isnull OR ri.FL_foreign_corp_key_isnull => 0,
                        le.FL_foreign_corp_key = ri.FL_foreign_corp_key  => le.FL_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.FL_foreign_corp_key_weight100,s.FL_foreign_corp_key_switch));
  SELF.left_GA_foreign_corp_key := le.GA_foreign_corp_key;
  SELF.right_GA_foreign_corp_key := ri.GA_foreign_corp_key;
  INTEGER2 GA_foreign_corp_key_score_temp := MAP( le.GA_foreign_corp_key_isnull OR ri.GA_foreign_corp_key_isnull => 0,
                        le.GA_foreign_corp_key = ri.GA_foreign_corp_key  => le.GA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.GA_foreign_corp_key_weight100,s.GA_foreign_corp_key_switch));
  SELF.left_IL_foreign_corp_key := le.IL_foreign_corp_key;
  SELF.right_IL_foreign_corp_key := ri.IL_foreign_corp_key;
  INTEGER2 IL_foreign_corp_key_score_temp := MAP( le.IL_foreign_corp_key_isnull OR ri.IL_foreign_corp_key_isnull => 0,
                        le.IL_foreign_corp_key = ri.IL_foreign_corp_key  => le.IL_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.IL_foreign_corp_key_weight100,s.IL_foreign_corp_key_switch));
  SELF.left_IN_foreign_corp_key := le.IN_foreign_corp_key;
  SELF.right_IN_foreign_corp_key := ri.IN_foreign_corp_key;
  INTEGER2 IN_foreign_corp_key_score_temp := MAP( le.IN_foreign_corp_key_isnull OR ri.IN_foreign_corp_key_isnull => 0,
                        le.IN_foreign_corp_key = ri.IN_foreign_corp_key  => le.IN_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.IN_foreign_corp_key_weight100,s.IN_foreign_corp_key_switch));
  SELF.left_MS_foreign_corp_key := le.MS_foreign_corp_key;
  SELF.right_MS_foreign_corp_key := ri.MS_foreign_corp_key;
  INTEGER2 MS_foreign_corp_key_score_temp := MAP( le.MS_foreign_corp_key_isnull OR ri.MS_foreign_corp_key_isnull => 0,
                        le.MS_foreign_corp_key = ri.MS_foreign_corp_key  => le.MS_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MS_foreign_corp_key_weight100,s.MS_foreign_corp_key_switch));
  SELF.left_NH_foreign_corp_key := le.NH_foreign_corp_key;
  SELF.right_NH_foreign_corp_key := ri.NH_foreign_corp_key;
  INTEGER2 NH_foreign_corp_key_score_temp := MAP( le.NH_foreign_corp_key_isnull OR ri.NH_foreign_corp_key_isnull => 0,
                        le.NH_foreign_corp_key = ri.NH_foreign_corp_key  => le.NH_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NH_foreign_corp_key_weight100,s.NH_foreign_corp_key_switch));
  SELF.left_NV_foreign_corp_key := le.NV_foreign_corp_key;
  SELF.right_NV_foreign_corp_key := ri.NV_foreign_corp_key;
  INTEGER2 NV_foreign_corp_key_score_temp := MAP( le.NV_foreign_corp_key_isnull OR ri.NV_foreign_corp_key_isnull => 0,
                        le.NV_foreign_corp_key = ri.NV_foreign_corp_key  => le.NV_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NV_foreign_corp_key_weight100,s.NV_foreign_corp_key_switch));
  SELF.left_NY_foreign_corp_key := le.NY_foreign_corp_key;
  SELF.right_NY_foreign_corp_key := ri.NY_foreign_corp_key;
  INTEGER2 NY_foreign_corp_key_score_temp := MAP( le.NY_foreign_corp_key_isnull OR ri.NY_foreign_corp_key_isnull => 0,
                        le.NY_foreign_corp_key = ri.NY_foreign_corp_key  => le.NY_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NY_foreign_corp_key_weight100,s.NY_foreign_corp_key_switch));
  SELF.left_OR_foreign_corp_key := le.OR_foreign_corp_key;
  SELF.right_OR_foreign_corp_key := ri.OR_foreign_corp_key;
  INTEGER2 OR_foreign_corp_key_score_temp := MAP( le.OR_foreign_corp_key_isnull OR ri.OR_foreign_corp_key_isnull => 0,
                        le.OR_foreign_corp_key = ri.OR_foreign_corp_key  => le.OR_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.OR_foreign_corp_key_weight100,s.OR_foreign_corp_key_switch));
  SELF.left_RI_foreign_corp_key := le.RI_foreign_corp_key;
  SELF.right_RI_foreign_corp_key := ri.RI_foreign_corp_key;
  INTEGER2 RI_foreign_corp_key_score_temp := MAP( le.RI_foreign_corp_key_isnull OR ri.RI_foreign_corp_key_isnull => 0,
                        le.RI_foreign_corp_key = ri.RI_foreign_corp_key  => le.RI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.RI_foreign_corp_key_weight100,s.RI_foreign_corp_key_switch));
  SELF.left_UT_foreign_corp_key := le.UT_foreign_corp_key;
  SELF.right_UT_foreign_corp_key := ri.UT_foreign_corp_key;
  INTEGER2 UT_foreign_corp_key_score_temp := MAP( le.UT_foreign_corp_key_isnull OR ri.UT_foreign_corp_key_isnull => 0,
                        le.UT_foreign_corp_key = ri.UT_foreign_corp_key  => le.UT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.UT_foreign_corp_key_weight100,s.UT_foreign_corp_key_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT26.WithinEditN(le.company_fein,ri.company_fein,1) => SALT26.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT26.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_cnp_name := le.cnp_name;
  SELF.right_cnp_name := ri.cnp_name;
  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT26.WithinEditN(le.cnp_name,ri.cnp_name,1) => SALT26.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT26.MatchBagOfWords(le.cnp_name,ri.cnp_name,0,1,1,1,0));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  SELF.left_company_address := le.company_address;
  SELF.right_company_address := ri.company_address;
  SELF.left_AK_foreign_corp_key := le.AK_foreign_corp_key;
  SELF.right_AK_foreign_corp_key := ri.AK_foreign_corp_key;
  INTEGER2 AK_foreign_corp_key_score_temp := MAP( le.AK_foreign_corp_key_isnull OR ri.AK_foreign_corp_key_isnull => 0,
                        le.AK_foreign_corp_key = ri.AK_foreign_corp_key  => le.AK_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AK_foreign_corp_key_weight100,s.AK_foreign_corp_key_switch));
  SELF.left_CT_foreign_corp_key := le.CT_foreign_corp_key;
  SELF.right_CT_foreign_corp_key := ri.CT_foreign_corp_key;
  INTEGER2 CT_foreign_corp_key_score_temp := MAP( le.CT_foreign_corp_key_isnull OR ri.CT_foreign_corp_key_isnull => 0,
                        le.CT_foreign_corp_key = ri.CT_foreign_corp_key  => le.CT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.CT_foreign_corp_key_weight100,s.CT_foreign_corp_key_switch));
  SELF.left_HI_foreign_corp_key := le.HI_foreign_corp_key;
  SELF.right_HI_foreign_corp_key := ri.HI_foreign_corp_key;
  INTEGER2 HI_foreign_corp_key_score_temp := MAP( le.HI_foreign_corp_key_isnull OR ri.HI_foreign_corp_key_isnull => 0,
                        le.HI_foreign_corp_key = ri.HI_foreign_corp_key  => le.HI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.HI_foreign_corp_key_weight100,s.HI_foreign_corp_key_switch));
  SELF.left_IA_foreign_corp_key := le.IA_foreign_corp_key;
  SELF.right_IA_foreign_corp_key := ri.IA_foreign_corp_key;
  INTEGER2 IA_foreign_corp_key_score_temp := MAP( le.IA_foreign_corp_key_isnull OR ri.IA_foreign_corp_key_isnull => 0,
                        le.IA_foreign_corp_key = ri.IA_foreign_corp_key  => le.IA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.IA_foreign_corp_key_weight100,s.IA_foreign_corp_key_switch));
  SELF.left_LA_foreign_corp_key := le.LA_foreign_corp_key;
  SELF.right_LA_foreign_corp_key := ri.LA_foreign_corp_key;
  INTEGER2 LA_foreign_corp_key_score_temp := MAP( le.LA_foreign_corp_key_isnull OR ri.LA_foreign_corp_key_isnull => 0,
                        le.LA_foreign_corp_key = ri.LA_foreign_corp_key  => le.LA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.LA_foreign_corp_key_weight100,s.LA_foreign_corp_key_switch));
  SELF.left_MT_foreign_corp_key := le.MT_foreign_corp_key;
  SELF.right_MT_foreign_corp_key := ri.MT_foreign_corp_key;
  INTEGER2 MT_foreign_corp_key_score_temp := MAP( le.MT_foreign_corp_key_isnull OR ri.MT_foreign_corp_key_isnull => 0,
                        le.MT_foreign_corp_key = ri.MT_foreign_corp_key  => le.MT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MT_foreign_corp_key_weight100,s.MT_foreign_corp_key_switch));
  SELF.left_NE_foreign_corp_key := le.NE_foreign_corp_key;
  SELF.right_NE_foreign_corp_key := ri.NE_foreign_corp_key;
  INTEGER2 NE_foreign_corp_key_score_temp := MAP( le.NE_foreign_corp_key_isnull OR ri.NE_foreign_corp_key_isnull => 0,
                        le.NE_foreign_corp_key = ri.NE_foreign_corp_key  => le.NE_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NE_foreign_corp_key_weight100,s.NE_foreign_corp_key_switch));
  SELF.left_VA_foreign_corp_key := le.VA_foreign_corp_key;
  SELF.right_VA_foreign_corp_key := ri.VA_foreign_corp_key;
  INTEGER2 VA_foreign_corp_key_score_temp := MAP( le.VA_foreign_corp_key_isnull OR ri.VA_foreign_corp_key_isnull => 0,
                        le.VA_foreign_corp_key = ri.VA_foreign_corp_key  => le.VA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.VA_foreign_corp_key_weight100,s.VA_foreign_corp_key_switch));
  SELF.left_AZ_foreign_corp_key := le.AZ_foreign_corp_key;
  SELF.right_AZ_foreign_corp_key := ri.AZ_foreign_corp_key;
  INTEGER2 AZ_foreign_corp_key_score_temp := MAP( le.AZ_foreign_corp_key_isnull OR ri.AZ_foreign_corp_key_isnull => 0,
                        le.AZ_foreign_corp_key = ri.AZ_foreign_corp_key  => le.AZ_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AZ_foreign_corp_key_weight100,s.AZ_foreign_corp_key_switch));
  SELF.left_TX_foreign_corp_key := le.TX_foreign_corp_key;
  SELF.right_TX_foreign_corp_key := ri.TX_foreign_corp_key;
  INTEGER2 TX_foreign_corp_key_score_temp := MAP( le.TX_foreign_corp_key_isnull OR ri.TX_foreign_corp_key_isnull => 0,
                        le.TX_foreign_corp_key = ri.TX_foreign_corp_key  => le.TX_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.TX_foreign_corp_key_weight100,s.TX_foreign_corp_key_switch));
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  SELF.left_company_addr1 := le.company_addr1;
  SELF.right_company_addr1 := ri.company_addr1;
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  SELF.left_company_csz := le.company_csz;
  SELF.right_company_csz := ri.company_csz;
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        0 /* switch0 */)* company_addr1_score_scale* company_address_score_scale;
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT26.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.left_cnp_btype := le.cnp_btype;
  SELF.right_cnp_btype := ri.cnp_btype;
  SELF.cnp_btype_score := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT26.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  SELF.left_iscorp := le.iscorp;
  SELF.right_iscorp := ri.iscorp;
  SELF.iscorp_score := MAP( le.iscorp_isnull OR ri.iscorp_isnull => 0,
                        le.iscorp = ri.iscorp  => le.iscorp_weight100,
                        0 /* switch0 */);
  SELF.left_cnp_lowv := le.cnp_lowv;
  SELF.right_cnp_lowv := ri.cnp_lowv;
  SELF.left_cnp_translated := le.cnp_translated;
  SELF.right_cnp_translated := ri.cnp_translated;
  SELF.left_cnp_classid := le.cnp_classid;
  SELF.right_cnp_classid := ri.cnp_classid;
  SELF.left_company_foreign_domestic := le.company_foreign_domestic;
  SELF.right_company_foreign_domestic := ri.company_foreign_domestic;
  SELF.left_company_bdid := le.company_bdid;
  SELF.right_company_bdid := ri.company_bdid;
  SELF.left_cnp_hasnumber := le.cnp_hasnumber;
  SELF.right_cnp_hasnumber := ri.cnp_hasnumber;
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_DE_foreign_corp_key := le.DE_foreign_corp_key;
  SELF.right_DE_foreign_corp_key := ri.DE_foreign_corp_key;
  INTEGER2 DE_foreign_corp_key_score_temp := MAP( le.DE_foreign_corp_key_isnull OR ri.DE_foreign_corp_key_isnull => 0,
                        le.DE_foreign_corp_key = ri.DE_foreign_corp_key  => le.DE_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.DE_foreign_corp_key_weight100,s.DE_foreign_corp_key_switch));
  SELF.left_ID_foreign_corp_key := le.ID_foreign_corp_key;
  SELF.right_ID_foreign_corp_key := ri.ID_foreign_corp_key;
  INTEGER2 ID_foreign_corp_key_score_temp := MAP( le.ID_foreign_corp_key_isnull OR ri.ID_foreign_corp_key_isnull => 0,
                        le.ID_foreign_corp_key = ri.ID_foreign_corp_key  => le.ID_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.ID_foreign_corp_key_weight100,s.ID_foreign_corp_key_switch));
  SELF.left_OH_foreign_corp_key := le.OH_foreign_corp_key;
  SELF.right_OH_foreign_corp_key := ri.OH_foreign_corp_key;
  INTEGER2 OH_foreign_corp_key_score_temp := MAP( le.OH_foreign_corp_key_isnull OR ri.OH_foreign_corp_key_isnull => 0,
                        le.OH_foreign_corp_key = ri.OH_foreign_corp_key  => le.OH_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.OH_foreign_corp_key_weight100,s.OH_foreign_corp_key_switch));
  SELF.left_PR_foreign_corp_key := le.PR_foreign_corp_key;
  SELF.right_PR_foreign_corp_key := ri.PR_foreign_corp_key;
  INTEGER2 PR_foreign_corp_key_score_temp := MAP( le.PR_foreign_corp_key_isnull OR ri.PR_foreign_corp_key_isnull => 0,
                        le.PR_foreign_corp_key = ri.PR_foreign_corp_key  => le.PR_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.PR_foreign_corp_key_weight100,s.PR_foreign_corp_key_switch));
  SELF.left_VI_foreign_corp_key := le.VI_foreign_corp_key;
  SELF.right_VI_foreign_corp_key := ri.VI_foreign_corp_key;
  INTEGER2 VI_foreign_corp_key_score_temp := MAP( le.VI_foreign_corp_key_isnull OR ri.VI_foreign_corp_key_isnull => 0,
                        le.VI_foreign_corp_key = ri.VI_foreign_corp_key  => le.VI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.VI_foreign_corp_key_weight100,s.VI_foreign_corp_key_switch));
  SELF.left_WA_foreign_corp_key := le.WA_foreign_corp_key;
  SELF.right_WA_foreign_corp_key := ri.WA_foreign_corp_key;
  INTEGER2 WA_foreign_corp_key_score_temp := MAP( le.WA_foreign_corp_key_isnull OR ri.WA_foreign_corp_key_isnull => 0,
                        le.WA_foreign_corp_key = ri.WA_foreign_corp_key  => le.WA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WA_foreign_corp_key_weight100,s.WA_foreign_corp_key_switch));
  SELF.left_WI_foreign_corp_key := le.WI_foreign_corp_key;
  SELF.right_WI_foreign_corp_key := ri.WI_foreign_corp_key;
  INTEGER2 WI_foreign_corp_key_score_temp := MAP( le.WI_foreign_corp_key_isnull OR ri.WI_foreign_corp_key_isnull => 0,
                        le.WI_foreign_corp_key = ri.WI_foreign_corp_key  => le.WI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WI_foreign_corp_key_weight100,s.WI_foreign_corp_key_switch));
  SELF.left_WV_foreign_corp_key := le.WV_foreign_corp_key;
  SELF.right_WV_foreign_corp_key := ri.WV_foreign_corp_key;
  INTEGER2 WV_foreign_corp_key_score_temp := MAP( le.WV_foreign_corp_key_isnull OR ri.WV_foreign_corp_key_isnull => 0,
                        le.WV_foreign_corp_key = ri.WV_foreign_corp_key  => le.WV_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WV_foreign_corp_key_weight100,s.WV_foreign_corp_key_switch));
  SELF.left_WY_foreign_corp_key := le.WY_foreign_corp_key;
  SELF.right_WY_foreign_corp_key := ri.WY_foreign_corp_key;
  INTEGER2 WY_foreign_corp_key_score_temp := MAP( le.WY_foreign_corp_key_isnull OR ri.WY_foreign_corp_key_isnull => 0,
                        le.WY_foreign_corp_key = ri.WY_foreign_corp_key  => le.WY_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WY_foreign_corp_key_weight100,s.WY_foreign_corp_key_switch));
  SELF.cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_number_skipped := SELF.cnp_number_score < -5000;// Enforce FORCE parameter
 
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  INTEGER2 prim_range_score_temp := MAP(                         company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT26.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  INTEGER2 prim_name_score_temp := MAP( le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT26.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  INTEGER2 st_score_temp := MAP( le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT26.Fn_Fail_Scale(le.st_weight100,s.st_switch))* company_csz_score_scale* company_address_score_scale;
  SELF.active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_enterprise_number_skipped := SELF.active_enterprise_number_score < -5000;// Enforce FORCE parameter
 
  SELF.MN_foreign_corp_key_score := IF ( MN_foreign_corp_key_score_temp >= 0, MN_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MN_foreign_corp_key_skipped := SELF.MN_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NJ_foreign_corp_key_score := IF ( NJ_foreign_corp_key_score_temp >= 0, NJ_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NJ_foreign_corp_key_skipped := SELF.NJ_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.active_duns_number_skipped := SELF.active_duns_number_score < -5000;// Enforce FORCE parameter
 
 
  SELF.AR_foreign_corp_key_score := IF ( AR_foreign_corp_key_score_temp >= 0, AR_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.AR_foreign_corp_key_skipped := SELF.AR_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.CA_foreign_corp_key_score := IF ( CA_foreign_corp_key_score_temp >= 0, CA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CA_foreign_corp_key_skipped := SELF.CA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.CO_foreign_corp_key_score := IF ( CO_foreign_corp_key_score_temp >= 0, CO_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CO_foreign_corp_key_skipped := SELF.CO_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.DC_foreign_corp_key_score := IF ( DC_foreign_corp_key_score_temp >= 0, DC_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.DC_foreign_corp_key_skipped := SELF.DC_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.KS_foreign_corp_key_score := IF ( KS_foreign_corp_key_score_temp >= 0, KS_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.KS_foreign_corp_key_skipped := SELF.KS_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.KY_foreign_corp_key_score := IF ( KY_foreign_corp_key_score_temp >= 0, KY_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.KY_foreign_corp_key_skipped := SELF.KY_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.MA_foreign_corp_key_score := IF ( MA_foreign_corp_key_score_temp >= 0, MA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MA_foreign_corp_key_skipped := SELF.MA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.MD_foreign_corp_key_score := IF ( MD_foreign_corp_key_score_temp >= 0, MD_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MD_foreign_corp_key_skipped := SELF.MD_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.ME_foreign_corp_key_score := IF ( ME_foreign_corp_key_score_temp >= 0, ME_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.ME_foreign_corp_key_skipped := SELF.ME_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.MI_foreign_corp_key_score := IF ( MI_foreign_corp_key_score_temp >= 0, MI_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MI_foreign_corp_key_skipped := SELF.MI_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.MO_foreign_corp_key_score := IF ( MO_foreign_corp_key_score_temp >= 0, MO_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MO_foreign_corp_key_skipped := SELF.MO_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NC_foreign_corp_key_score := IF ( NC_foreign_corp_key_score_temp >= 0, NC_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NC_foreign_corp_key_skipped := SELF.NC_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.ND_foreign_corp_key_score := IF ( ND_foreign_corp_key_score_temp >= 0, ND_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.ND_foreign_corp_key_skipped := SELF.ND_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NM_foreign_corp_key_score := IF ( NM_foreign_corp_key_score_temp >= 0, NM_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NM_foreign_corp_key_skipped := SELF.NM_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.OK_foreign_corp_key_score := IF ( OK_foreign_corp_key_score_temp >= 0, OK_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.OK_foreign_corp_key_skipped := SELF.OK_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.PA_foreign_corp_key_score := IF ( PA_foreign_corp_key_score_temp >= 0, PA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.PA_foreign_corp_key_skipped := SELF.PA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.SC_foreign_corp_key_score := IF ( SC_foreign_corp_key_score_temp >= 0, SC_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.SC_foreign_corp_key_skipped := SELF.SC_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.SD_foreign_corp_key_score := IF ( SD_foreign_corp_key_score_temp >= 0, SD_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.SD_foreign_corp_key_skipped := SELF.SD_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.TN_foreign_corp_key_score := IF ( TN_foreign_corp_key_score_temp >= 0, TN_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.TN_foreign_corp_key_skipped := SELF.TN_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.VT_foreign_corp_key_score := IF ( VT_foreign_corp_key_score_temp >= 0, VT_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.VT_foreign_corp_key_skipped := SELF.VT_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.domestic_corp_key_score := IF ( domestic_corp_key_score_temp >= 0, domestic_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.domestic_corp_key_skipped := SELF.domestic_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.AL_foreign_corp_key_score := IF ( AL_foreign_corp_key_score_temp >= 0, AL_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.AL_foreign_corp_key_skipped := SELF.AL_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.FL_foreign_corp_key_score := IF ( FL_foreign_corp_key_score_temp >= 0, FL_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.FL_foreign_corp_key_skipped := SELF.FL_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.GA_foreign_corp_key_score := IF ( GA_foreign_corp_key_score_temp >= 0, GA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.GA_foreign_corp_key_skipped := SELF.GA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.IL_foreign_corp_key_score := IF ( IL_foreign_corp_key_score_temp >= 0, IL_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.IL_foreign_corp_key_skipped := SELF.IL_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.IN_foreign_corp_key_score := IF ( IN_foreign_corp_key_score_temp >= 0, IN_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.IN_foreign_corp_key_skipped := SELF.IN_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.MS_foreign_corp_key_score := IF ( MS_foreign_corp_key_score_temp >= 0, MS_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MS_foreign_corp_key_skipped := SELF.MS_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NH_foreign_corp_key_score := IF ( NH_foreign_corp_key_score_temp >= 0, NH_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NH_foreign_corp_key_skipped := SELF.NH_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NV_foreign_corp_key_score := IF ( NV_foreign_corp_key_score_temp >= 0, NV_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NV_foreign_corp_key_skipped := SELF.NV_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NY_foreign_corp_key_score := IF ( NY_foreign_corp_key_score_temp >= 0, NY_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NY_foreign_corp_key_skipped := SELF.NY_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.OR_foreign_corp_key_score := IF ( OR_foreign_corp_key_score_temp >= 0, OR_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.OR_foreign_corp_key_skipped := SELF.OR_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.RI_foreign_corp_key_score := IF ( RI_foreign_corp_key_score_temp >= 0, RI_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.RI_foreign_corp_key_skipped := SELF.RI_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.UT_foreign_corp_key_score := IF ( UT_foreign_corp_key_score_temp >= 0, UT_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.UT_foreign_corp_key_skipped := SELF.UT_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.cnp_name_score := IF ( cnp_name_score_temp >= 1300, cnp_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cnp_name_skipped := SELF.cnp_name_score < -5000;// Enforce FORCE parameter
 
  SELF.AK_foreign_corp_key_score := IF ( AK_foreign_corp_key_score_temp >= 0, AK_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.AK_foreign_corp_key_skipped := SELF.AK_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.CT_foreign_corp_key_score := IF ( CT_foreign_corp_key_score_temp >= 0, CT_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.CT_foreign_corp_key_skipped := SELF.CT_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.HI_foreign_corp_key_score := IF ( HI_foreign_corp_key_score_temp >= 0, HI_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.HI_foreign_corp_key_skipped := SELF.HI_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.IA_foreign_corp_key_score := IF ( IA_foreign_corp_key_score_temp >= 0, IA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.IA_foreign_corp_key_skipped := SELF.IA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.LA_foreign_corp_key_score := IF ( LA_foreign_corp_key_score_temp >= 0, LA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.LA_foreign_corp_key_skipped := SELF.LA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.MT_foreign_corp_key_score := IF ( MT_foreign_corp_key_score_temp >= 0, MT_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.MT_foreign_corp_key_skipped := SELF.MT_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.NE_foreign_corp_key_score := IF ( NE_foreign_corp_key_score_temp >= 0, NE_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.NE_foreign_corp_key_skipped := SELF.NE_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.VA_foreign_corp_key_score := IF ( VA_foreign_corp_key_score_temp >= 0, VA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.VA_foreign_corp_key_skipped := SELF.VA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.AZ_foreign_corp_key_score := IF ( AZ_foreign_corp_key_score_temp >= 0, AZ_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.AZ_foreign_corp_key_skipped := SELF.AZ_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.TX_foreign_corp_key_score := IF ( TX_foreign_corp_key_score_temp >= 0, TX_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.TX_foreign_corp_key_skipped := SELF.TX_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT26.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* company_csz_score_scale* company_address_score_scale;
 
 
  SELF.DE_foreign_corp_key_score := IF ( DE_foreign_corp_key_score_temp >= 0, DE_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.DE_foreign_corp_key_skipped := SELF.DE_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.ID_foreign_corp_key_score := IF ( ID_foreign_corp_key_score_temp >= 0, ID_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.ID_foreign_corp_key_skipped := SELF.ID_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.OH_foreign_corp_key_score := IF ( OH_foreign_corp_key_score_temp >= 0, OH_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.OH_foreign_corp_key_skipped := SELF.OH_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.PR_foreign_corp_key_score := IF ( PR_foreign_corp_key_score_temp >= 0, PR_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.PR_foreign_corp_key_skipped := SELF.PR_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.VI_foreign_corp_key_score := IF ( VI_foreign_corp_key_score_temp >= 0, VI_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.VI_foreign_corp_key_skipped := SELF.VI_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.WA_foreign_corp_key_score := IF ( WA_foreign_corp_key_score_temp >= 0, WA_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.WA_foreign_corp_key_skipped := SELF.WA_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.WI_foreign_corp_key_score := IF ( WI_foreign_corp_key_score_temp >= 0, WI_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.WI_foreign_corp_key_skipped := SELF.WI_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.WV_foreign_corp_key_score := IF ( WV_foreign_corp_key_score_temp >= 0, WV_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.WV_foreign_corp_key_skipped := SELF.WV_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.WY_foreign_corp_key_score := IF ( WY_foreign_corp_key_score_temp >= 0, WY_foreign_corp_key_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.WY_foreign_corp_key_skipped := SELF.WY_foreign_corp_key_score < -5000;// Enforce FORCE parameter
 
  SELF.prim_range_score := IF ( prim_range_score_temp >= 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
 
  SELF.prim_name_score := IF ( prim_name_score_temp > 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_skipped := SELF.prim_name_score < -5000;// Enforce FORCE parameter
 
  SELF.st_score := IF ( st_score_temp > 0 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
 
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + self.prim_range_score + self.prim_name_score + self.sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  SELF.company_addr1_score := company_addr1_score_res;
 
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + self.v_city_name_score + self.st_score + self.zip_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  SELF.company_csz_score := IF ( company_csz_score_ext > -200,company_csz_score_res,-9999);
  SELF.company_csz_skipped := SELF.company_csz_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ SELF.company_addr1_score + self.prim_range_score + self.prim_name_score + self.sec_range_score+ SELF.company_csz_score + self.v_city_name_score + self.st_score + self.zip_score;// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  SELF.company_address_score := IF ( company_address_score_ext > 0,company_address_score_res,-9999);
  SELF.company_address_skipped := SELF.company_address_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*SELF.cnp_number_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*SELF.active_enterprise_number_score // Score if either field propogated
    +MAX(le.MN_foreign_corp_key_prop,ri.MN_foreign_corp_key_prop)*SELF.MN_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NJ_foreign_corp_key_prop,ri.NJ_foreign_corp_key_prop)*SELF.NJ_foreign_corp_key_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*SELF.active_duns_number_score // Score if either field propogated
    +MAX(le.hist_enterprise_number_prop,ri.hist_enterprise_number_prop)*SELF.hist_enterprise_number_score // Score if either field propogated
    +MAX(le.hist_duns_number_prop,ri.hist_duns_number_prop)*SELF.hist_duns_number_score // Score if either field propogated
    +MAX(le.ebr_file_number_prop,ri.ebr_file_number_prop)*SELF.ebr_file_number_score // Score if either field propogated
    +MAX(le.AR_foreign_corp_key_prop,ri.AR_foreign_corp_key_prop)*SELF.AR_foreign_corp_key_score // Score if either field propogated
    +MAX(le.CA_foreign_corp_key_prop,ri.CA_foreign_corp_key_prop)*SELF.CA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.CO_foreign_corp_key_prop,ri.CO_foreign_corp_key_prop)*SELF.CO_foreign_corp_key_score // Score if either field propogated
    +MAX(le.DC_foreign_corp_key_prop,ri.DC_foreign_corp_key_prop)*SELF.DC_foreign_corp_key_score // Score if either field propogated
    +MAX(le.KS_foreign_corp_key_prop,ri.KS_foreign_corp_key_prop)*SELF.KS_foreign_corp_key_score // Score if either field propogated
    +MAX(le.KY_foreign_corp_key_prop,ri.KY_foreign_corp_key_prop)*SELF.KY_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MA_foreign_corp_key_prop,ri.MA_foreign_corp_key_prop)*SELF.MA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MD_foreign_corp_key_prop,ri.MD_foreign_corp_key_prop)*SELF.MD_foreign_corp_key_score // Score if either field propogated
    +MAX(le.ME_foreign_corp_key_prop,ri.ME_foreign_corp_key_prop)*SELF.ME_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MI_foreign_corp_key_prop,ri.MI_foreign_corp_key_prop)*SELF.MI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MO_foreign_corp_key_prop,ri.MO_foreign_corp_key_prop)*SELF.MO_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NC_foreign_corp_key_prop,ri.NC_foreign_corp_key_prop)*SELF.NC_foreign_corp_key_score // Score if either field propogated
    +MAX(le.ND_foreign_corp_key_prop,ri.ND_foreign_corp_key_prop)*SELF.ND_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NM_foreign_corp_key_prop,ri.NM_foreign_corp_key_prop)*SELF.NM_foreign_corp_key_score // Score if either field propogated
    +MAX(le.OK_foreign_corp_key_prop,ri.OK_foreign_corp_key_prop)*SELF.OK_foreign_corp_key_score // Score if either field propogated
    +MAX(le.PA_foreign_corp_key_prop,ri.PA_foreign_corp_key_prop)*SELF.PA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.SC_foreign_corp_key_prop,ri.SC_foreign_corp_key_prop)*SELF.SC_foreign_corp_key_score // Score if either field propogated
    +MAX(le.SD_foreign_corp_key_prop,ri.SD_foreign_corp_key_prop)*SELF.SD_foreign_corp_key_score // Score if either field propogated
    +MAX(le.TN_foreign_corp_key_prop,ri.TN_foreign_corp_key_prop)*SELF.TN_foreign_corp_key_score // Score if either field propogated
    +MAX(le.VT_foreign_corp_key_prop,ri.VT_foreign_corp_key_prop)*SELF.VT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*SELF.company_phone_score // Score if either field propogated
    +MAX(le.domestic_corp_key_prop,ri.domestic_corp_key_prop)*SELF.domestic_corp_key_score // Score if either field propogated
    +MAX(le.AL_foreign_corp_key_prop,ri.AL_foreign_corp_key_prop)*SELF.AL_foreign_corp_key_score // Score if either field propogated
    +MAX(le.FL_foreign_corp_key_prop,ri.FL_foreign_corp_key_prop)*SELF.FL_foreign_corp_key_score // Score if either field propogated
    +MAX(le.GA_foreign_corp_key_prop,ri.GA_foreign_corp_key_prop)*SELF.GA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.IL_foreign_corp_key_prop,ri.IL_foreign_corp_key_prop)*SELF.IL_foreign_corp_key_score // Score if either field propogated
    +MAX(le.IN_foreign_corp_key_prop,ri.IN_foreign_corp_key_prop)*SELF.IN_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MS_foreign_corp_key_prop,ri.MS_foreign_corp_key_prop)*SELF.MS_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NH_foreign_corp_key_prop,ri.NH_foreign_corp_key_prop)*SELF.NH_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NV_foreign_corp_key_prop,ri.NV_foreign_corp_key_prop)*SELF.NV_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NY_foreign_corp_key_prop,ri.NY_foreign_corp_key_prop)*SELF.NY_foreign_corp_key_score // Score if either field propogated
    +MAX(le.OR_foreign_corp_key_prop,ri.OR_foreign_corp_key_prop)*SELF.OR_foreign_corp_key_score // Score if either field propogated
    +MAX(le.RI_foreign_corp_key_prop,ri.RI_foreign_corp_key_prop)*SELF.RI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.UT_foreign_corp_key_prop,ri.UT_foreign_corp_key_prop)*SELF.UT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +if(le.company_address_prop+ri.company_address_prop>0,self.company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
    +MAX(le.AK_foreign_corp_key_prop,ri.AK_foreign_corp_key_prop)*SELF.AK_foreign_corp_key_score // Score if either field propogated
    +MAX(le.CT_foreign_corp_key_prop,ri.CT_foreign_corp_key_prop)*SELF.CT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.HI_foreign_corp_key_prop,ri.HI_foreign_corp_key_prop)*SELF.HI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.IA_foreign_corp_key_prop,ri.IA_foreign_corp_key_prop)*SELF.IA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.LA_foreign_corp_key_prop,ri.LA_foreign_corp_key_prop)*SELF.LA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MT_foreign_corp_key_prop,ri.MT_foreign_corp_key_prop)*SELF.MT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NE_foreign_corp_key_prop,ri.NE_foreign_corp_key_prop)*SELF.NE_foreign_corp_key_score // Score if either field propogated
    +MAX(le.VA_foreign_corp_key_prop,ri.VA_foreign_corp_key_prop)*SELF.VA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.AZ_foreign_corp_key_prop,ri.AZ_foreign_corp_key_prop)*SELF.AZ_foreign_corp_key_score // Score if either field propogated
    +MAX(le.TX_foreign_corp_key_prop,ri.TX_foreign_corp_key_prop)*SELF.TX_foreign_corp_key_score // Score if either field propogated
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,self.company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*SELF.sec_range_score // Score if either field propogated
    +MAX(le.iscorp_prop,ri.iscorp_prop)*SELF.iscorp_score // Score if either field propogated
    +MAX(le.DE_foreign_corp_key_prop,ri.DE_foreign_corp_key_prop)*SELF.DE_foreign_corp_key_score // Score if either field propogated
    +MAX(le.ID_foreign_corp_key_prop,ri.ID_foreign_corp_key_prop)*SELF.ID_foreign_corp_key_score // Score if either field propogated
    +MAX(le.OH_foreign_corp_key_prop,ri.OH_foreign_corp_key_prop)*SELF.OH_foreign_corp_key_score // Score if either field propogated
    +MAX(le.PR_foreign_corp_key_prop,ri.PR_foreign_corp_key_prop)*SELF.PR_foreign_corp_key_score // Score if either field propogated
    +MAX(le.VI_foreign_corp_key_prop,ri.VI_foreign_corp_key_prop)*SELF.VI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WA_foreign_corp_key_prop,ri.WA_foreign_corp_key_prop)*SELF.WA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WI_foreign_corp_key_prop,ri.WI_foreign_corp_key_prop)*SELF.WI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WV_foreign_corp_key_prop,ri.WV_foreign_corp_key_prop)*SELF.WV_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WY_foreign_corp_key_prop,ri.WY_foreign_corp_key_prop)*SELF.WY_foreign_corp_key_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.cnp_number_score + SELF.prim_range_score + SELF.prim_name_score + SELF.st_score + SELF.active_enterprise_number_score + SELF.MN_foreign_corp_key_score + SELF.NJ_foreign_corp_key_score + SELF.active_duns_number_score + SELF.hist_enterprise_number_score + SELF.hist_duns_number_score + SELF.ebr_file_number_score + SELF.AR_foreign_corp_key_score + SELF.CA_foreign_corp_key_score + SELF.CO_foreign_corp_key_score + SELF.DC_foreign_corp_key_score + SELF.KS_foreign_corp_key_score + SELF.KY_foreign_corp_key_score + SELF.MA_foreign_corp_key_score + SELF.MD_foreign_corp_key_score + SELF.ME_foreign_corp_key_score + SELF.MI_foreign_corp_key_score + SELF.MO_foreign_corp_key_score + SELF.NC_foreign_corp_key_score + SELF.ND_foreign_corp_key_score + SELF.NM_foreign_corp_key_score + SELF.OK_foreign_corp_key_score + SELF.PA_foreign_corp_key_score + SELF.SC_foreign_corp_key_score + SELF.SD_foreign_corp_key_score + SELF.TN_foreign_corp_key_score + SELF.VT_foreign_corp_key_score + SELF.company_phone_score + SELF.domestic_corp_key_score + SELF.AL_foreign_corp_key_score + SELF.FL_foreign_corp_key_score + SELF.GA_foreign_corp_key_score + SELF.IL_foreign_corp_key_score + SELF.IN_foreign_corp_key_score + SELF.MS_foreign_corp_key_score + SELF.NH_foreign_corp_key_score + SELF.NV_foreign_corp_key_score + SELF.NY_foreign_corp_key_score + SELF.OR_foreign_corp_key_score + SELF.RI_foreign_corp_key_score + SELF.UT_foreign_corp_key_score + SELF.company_fein_score + SELF.cnp_name_score + SELF.company_address_score + SELF.AK_foreign_corp_key_score + SELF.CT_foreign_corp_key_score + SELF.HI_foreign_corp_key_score + SELF.IA_foreign_corp_key_score + SELF.LA_foreign_corp_key_score + SELF.MT_foreign_corp_key_score + SELF.NE_foreign_corp_key_score + SELF.VA_foreign_corp_key_score + SELF.AZ_foreign_corp_key_score + SELF.TX_foreign_corp_key_score + SELF.company_addr1_score + SELF.zip_score + SELF.company_csz_score + SELF.sec_range_score + SELF.v_city_name_score + SELF.cnp_btype_score + SELF.iscorp_score + SELF.DE_foreign_corp_key_score + SELF.ID_foreign_corp_key_score + SELF.OH_foreign_corp_key_score + SELF.PR_foreign_corp_key_score + SELF.VI_foreign_corp_key_score + SELF.WA_foreign_corp_key_score + SELF.WI_foreign_corp_key_score + SELF.WV_foreign_corp_key_score + SELF.WY_foreign_corp_key_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.Proxid = RIGHT.Proxid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.Proxid2 = RIGHT.Proxid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT26.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  RETURN AnnotateMatchesFromRecordData(h,im);
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT26.UIDType Proxid;
  DATASET(SALT26.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) active_enterprise_number_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MN_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NJ_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) hist_enterprise_number_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) hist_duns_number_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) ebr_file_number_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) AR_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) CA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) CO_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) DC_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) KS_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) KY_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MD_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) ME_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MI_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MO_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NC_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) ND_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NM_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) OK_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) PA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) SC_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) SD_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) TN_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) VT_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) company_phone_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) domestic_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) AL_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) FL_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) GA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) IL_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) IN_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MS_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NH_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NV_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NY_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) OR_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) RI_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) UT_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) company_fein_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) company_address_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) AK_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) CT_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) HI_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) IA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) LA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) MT_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) NE_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) VA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) AZ_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) TX_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) iscorp_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) cnp_translated_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) cnp_classid_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) company_foreign_domestic_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) company_bdid_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) cnp_hasnumber_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) company_name_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) DE_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) ID_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) OH_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) PR_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) VI_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) WA_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) WI_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) WV_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
  DATASET(SALT26.Layout_FieldValueList) WY_foreign_corp_key_Values := DATASET([],SALT26.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
 
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_number_values := SALT26.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
  SELF.active_enterprise_number_values := SALT26.fn_combine_fieldvaluelist(le.active_enterprise_number_values,ri.active_enterprise_number_values);
  SELF.MN_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MN_foreign_corp_key_values,ri.MN_foreign_corp_key_values);
  SELF.NJ_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NJ_foreign_corp_key_values,ri.NJ_foreign_corp_key_values);
  SELF.active_duns_number_values := SALT26.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
  SELF.hist_enterprise_number_values := SALT26.fn_combine_fieldvaluelist(le.hist_enterprise_number_values,ri.hist_enterprise_number_values);
  SELF.hist_duns_number_values := SALT26.fn_combine_fieldvaluelist(le.hist_duns_number_values,ri.hist_duns_number_values);
  SELF.ebr_file_number_values := SALT26.fn_combine_fieldvaluelist(le.ebr_file_number_values,ri.ebr_file_number_values);
  SELF.AR_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.AR_foreign_corp_key_values,ri.AR_foreign_corp_key_values);
  SELF.CA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.CA_foreign_corp_key_values,ri.CA_foreign_corp_key_values);
  SELF.CO_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.CO_foreign_corp_key_values,ri.CO_foreign_corp_key_values);
  SELF.DC_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.DC_foreign_corp_key_values,ri.DC_foreign_corp_key_values);
  SELF.KS_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.KS_foreign_corp_key_values,ri.KS_foreign_corp_key_values);
  SELF.KY_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.KY_foreign_corp_key_values,ri.KY_foreign_corp_key_values);
  SELF.MA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MA_foreign_corp_key_values,ri.MA_foreign_corp_key_values);
  SELF.MD_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MD_foreign_corp_key_values,ri.MD_foreign_corp_key_values);
  SELF.ME_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.ME_foreign_corp_key_values,ri.ME_foreign_corp_key_values);
  SELF.MI_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MI_foreign_corp_key_values,ri.MI_foreign_corp_key_values);
  SELF.MO_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MO_foreign_corp_key_values,ri.MO_foreign_corp_key_values);
  SELF.NC_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NC_foreign_corp_key_values,ri.NC_foreign_corp_key_values);
  SELF.ND_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.ND_foreign_corp_key_values,ri.ND_foreign_corp_key_values);
  SELF.NM_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NM_foreign_corp_key_values,ri.NM_foreign_corp_key_values);
  SELF.OK_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.OK_foreign_corp_key_values,ri.OK_foreign_corp_key_values);
  SELF.PA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.PA_foreign_corp_key_values,ri.PA_foreign_corp_key_values);
  SELF.SC_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.SC_foreign_corp_key_values,ri.SC_foreign_corp_key_values);
  SELF.SD_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.SD_foreign_corp_key_values,ri.SD_foreign_corp_key_values);
  SELF.TN_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.TN_foreign_corp_key_values,ri.TN_foreign_corp_key_values);
  SELF.VT_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.VT_foreign_corp_key_values,ri.VT_foreign_corp_key_values);
  SELF.company_phone_values := SALT26.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.domestic_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.domestic_corp_key_values,ri.domestic_corp_key_values);
  SELF.AL_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.AL_foreign_corp_key_values,ri.AL_foreign_corp_key_values);
  SELF.FL_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.FL_foreign_corp_key_values,ri.FL_foreign_corp_key_values);
  SELF.GA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.GA_foreign_corp_key_values,ri.GA_foreign_corp_key_values);
  SELF.IL_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.IL_foreign_corp_key_values,ri.IL_foreign_corp_key_values);
  SELF.IN_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.IN_foreign_corp_key_values,ri.IN_foreign_corp_key_values);
  SELF.MS_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MS_foreign_corp_key_values,ri.MS_foreign_corp_key_values);
  SELF.NH_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NH_foreign_corp_key_values,ri.NH_foreign_corp_key_values);
  SELF.NV_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NV_foreign_corp_key_values,ri.NV_foreign_corp_key_values);
  SELF.NY_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NY_foreign_corp_key_values,ri.NY_foreign_corp_key_values);
  SELF.OR_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.OR_foreign_corp_key_values,ri.OR_foreign_corp_key_values);
  SELF.RI_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.RI_foreign_corp_key_values,ri.RI_foreign_corp_key_values);
  SELF.UT_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.UT_foreign_corp_key_values,ri.UT_foreign_corp_key_values);
  SELF.company_fein_values := SALT26.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.cnp_name_values := SALT26.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.company_address_values := SALT26.fn_combine_fieldvaluelist(le.company_address_values,ri.company_address_values);
  SELF.AK_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.AK_foreign_corp_key_values,ri.AK_foreign_corp_key_values);
  SELF.CT_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.CT_foreign_corp_key_values,ri.CT_foreign_corp_key_values);
  SELF.HI_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.HI_foreign_corp_key_values,ri.HI_foreign_corp_key_values);
  SELF.IA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.IA_foreign_corp_key_values,ri.IA_foreign_corp_key_values);
  SELF.LA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.LA_foreign_corp_key_values,ri.LA_foreign_corp_key_values);
  SELF.MT_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.MT_foreign_corp_key_values,ri.MT_foreign_corp_key_values);
  SELF.NE_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.NE_foreign_corp_key_values,ri.NE_foreign_corp_key_values);
  SELF.VA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.VA_foreign_corp_key_values,ri.VA_foreign_corp_key_values);
  SELF.AZ_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.AZ_foreign_corp_key_values,ri.AZ_foreign_corp_key_values);
  SELF.TX_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.TX_foreign_corp_key_values,ri.TX_foreign_corp_key_values);
  SELF.cnp_btype_values := SALT26.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
  SELF.iscorp_values := SALT26.fn_combine_fieldvaluelist(le.iscorp_values,ri.iscorp_values);
  SELF.cnp_lowv_values := SALT26.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
  SELF.cnp_translated_values := SALT26.fn_combine_fieldvaluelist(le.cnp_translated_values,ri.cnp_translated_values);
  SELF.cnp_classid_values := SALT26.fn_combine_fieldvaluelist(le.cnp_classid_values,ri.cnp_classid_values);
  SELF.company_foreign_domestic_values := SALT26.fn_combine_fieldvaluelist(le.company_foreign_domestic_values,ri.company_foreign_domestic_values);
  SELF.company_bdid_values := SALT26.fn_combine_fieldvaluelist(le.company_bdid_values,ri.company_bdid_values);
  SELF.cnp_hasnumber_values := SALT26.fn_combine_fieldvaluelist(le.cnp_hasnumber_values,ri.cnp_hasnumber_values);
  SELF.company_name_values := SALT26.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.dt_first_seen_values := SALT26.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT26.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  SELF.DE_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.DE_foreign_corp_key_values,ri.DE_foreign_corp_key_values);
  SELF.ID_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.ID_foreign_corp_key_values,ri.ID_foreign_corp_key_values);
  SELF.OH_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.OH_foreign_corp_key_values,ri.OH_foreign_corp_key_values);
  SELF.PR_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.PR_foreign_corp_key_values,ri.PR_foreign_corp_key_values);
  SELF.VI_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.VI_foreign_corp_key_values,ri.VI_foreign_corp_key_values);
  SELF.WA_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.WA_foreign_corp_key_values,ri.WA_foreign_corp_key_values);
  SELF.WI_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.WI_foreign_corp_key_values,ri.WI_foreign_corp_key_values);
  SELF.WV_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.WV_foreign_corp_key_values,ri.WV_foreign_corp_key_values);
  SELF.WY_foreign_corp_key_values := SALT26.fn_combine_fieldvaluelist(le.WY_foreign_corp_key_values,ri.WY_foreign_corp_key_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(Proxid) ), Proxid, LOCAL ), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),LOCAL);
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.cnp_number)}],SALT26.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.active_enterprise_number)}],SALT26.Layout_FieldValueList));
  SELF.MN_foreign_corp_key_Values := IF ( le.MN_foreign_corp_key  IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MN_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NJ_foreign_corp_key_Values := IF ( le.NJ_foreign_corp_key  IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NJ_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.active_duns_number)}],SALT26.Layout_FieldValueList));
  SELF.hist_enterprise_number_Values := IF ( le.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.hist_enterprise_number)}],SALT26.Layout_FieldValueList));
  SELF.hist_duns_number_Values := IF ( le.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.hist_duns_number)}],SALT26.Layout_FieldValueList));
  SELF.ebr_file_number_Values := IF ( le.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ebr_file_number)}],SALT26.Layout_FieldValueList));
  SELF.AR_foreign_corp_key_Values := IF ( le.AR_foreign_corp_key  IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AR_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.CA_foreign_corp_key_Values := IF ( le.CA_foreign_corp_key  IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.CA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.CO_foreign_corp_key_Values := IF ( le.CO_foreign_corp_key  IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.CO_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.DC_foreign_corp_key_Values := IF ( le.DC_foreign_corp_key  IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.DC_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.KS_foreign_corp_key_Values := IF ( le.KS_foreign_corp_key  IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.KS_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.KY_foreign_corp_key_Values := IF ( le.KY_foreign_corp_key  IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.KY_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MA_foreign_corp_key_Values := IF ( le.MA_foreign_corp_key  IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MD_foreign_corp_key_Values := IF ( le.MD_foreign_corp_key  IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MD_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.ME_foreign_corp_key_Values := IF ( le.ME_foreign_corp_key  IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ME_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MI_foreign_corp_key_Values := IF ( le.MI_foreign_corp_key  IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MO_foreign_corp_key_Values := IF ( le.MO_foreign_corp_key  IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MO_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NC_foreign_corp_key_Values := IF ( le.NC_foreign_corp_key  IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NC_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.ND_foreign_corp_key_Values := IF ( le.ND_foreign_corp_key  IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ND_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NM_foreign_corp_key_Values := IF ( le.NM_foreign_corp_key  IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NM_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.OK_foreign_corp_key_Values := IF ( le.OK_foreign_corp_key  IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.OK_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.PA_foreign_corp_key_Values := IF ( le.PA_foreign_corp_key  IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.PA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.SC_foreign_corp_key_Values := IF ( le.SC_foreign_corp_key  IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.SC_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.SD_foreign_corp_key_Values := IF ( le.SD_foreign_corp_key  IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.SD_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.TN_foreign_corp_key_Values := IF ( le.TN_foreign_corp_key  IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.TN_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.VT_foreign_corp_key_Values := IF ( le.VT_foreign_corp_key  IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.VT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.company_phone)}],SALT26.Layout_FieldValueList));
  SELF.domestic_corp_key_Values := IF ( le.domestic_corp_key  IN SET(s.nulls_domestic_corp_key,domestic_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.domestic_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.AL_foreign_corp_key_Values := IF ( le.AL_foreign_corp_key  IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AL_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.FL_foreign_corp_key_Values := IF ( le.FL_foreign_corp_key  IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.FL_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.GA_foreign_corp_key_Values := IF ( le.GA_foreign_corp_key  IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.GA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.IL_foreign_corp_key_Values := IF ( le.IL_foreign_corp_key  IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.IL_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.IN_foreign_corp_key_Values := IF ( le.IN_foreign_corp_key  IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.IN_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MS_foreign_corp_key_Values := IF ( le.MS_foreign_corp_key  IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MS_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NH_foreign_corp_key_Values := IF ( le.NH_foreign_corp_key  IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NH_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NV_foreign_corp_key_Values := IF ( le.NV_foreign_corp_key  IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NV_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NY_foreign_corp_key_Values := IF ( le.NY_foreign_corp_key  IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NY_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.OR_foreign_corp_key_Values := IF ( le.OR_foreign_corp_key  IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.OR_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.RI_foreign_corp_key_Values := IF ( le.RI_foreign_corp_key  IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.RI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.UT_foreign_corp_key_Values := IF ( le.UT_foreign_corp_key  IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.UT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.company_fein)}],SALT26.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.cnp_name)}],SALT26.Layout_FieldValueList));
  self.company_address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT26.Layout_FieldValueList),dataset([{TRIM((SALT26.StrType)le.prim_range) + ' ' + TRIM((SALT26.StrType)le.prim_name) + ' ' + TRIM((SALT26.StrType)le.sec_range) + ' ' + TRIM((SALT26.StrType)le.v_city_name) + ' ' + TRIM((SALT26.StrType)le.st) + ' ' + TRIM((SALT26.StrType)le.zip)}],SALT26.Layout_FieldValueList));
  SELF.AK_foreign_corp_key_Values := IF ( le.AK_foreign_corp_key  IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AK_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.CT_foreign_corp_key_Values := IF ( le.CT_foreign_corp_key  IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.CT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.HI_foreign_corp_key_Values := IF ( le.HI_foreign_corp_key  IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.HI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.IA_foreign_corp_key_Values := IF ( le.IA_foreign_corp_key  IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.IA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.LA_foreign_corp_key_Values := IF ( le.LA_foreign_corp_key  IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.LA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MT_foreign_corp_key_Values := IF ( le.MT_foreign_corp_key  IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NE_foreign_corp_key_Values := IF ( le.NE_foreign_corp_key  IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NE_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.VA_foreign_corp_key_Values := IF ( le.VA_foreign_corp_key  IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.VA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.AZ_foreign_corp_key_Values := IF ( le.AZ_foreign_corp_key  IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AZ_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.TX_foreign_corp_key_Values := IF ( le.TX_foreign_corp_key  IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.TX_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.cnp_btype)}],SALT26.Layout_FieldValueList));
  SELF.iscorp_Values := IF ( le.iscorp  IN SET(s.nulls_iscorp,iscorp),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.iscorp)}],SALT26.Layout_FieldValueList));
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_lowv)}],SALT26.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_translated)}],SALT26.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_classid)}],SALT26.Layout_FieldValueList);
  SELF.company_foreign_domestic_Values := DATASET([{TRIM((SALT26.StrType)le.company_foreign_domestic)}],SALT26.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT26.StrType)le.company_bdid)}],SALT26.Layout_FieldValueList);
  SELF.cnp_hasnumber_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_hasnumber)}],SALT26.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT26.StrType)le.company_name)}],SALT26.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT26.StrType)le.dt_first_seen)}],SALT26.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT26.StrType)le.dt_last_seen)}],SALT26.Layout_FieldValueList);
  SELF.DE_foreign_corp_key_Values := IF ( le.DE_foreign_corp_key  IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.DE_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.ID_foreign_corp_key_Values := IF ( le.ID_foreign_corp_key  IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ID_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.OH_foreign_corp_key_Values := IF ( le.OH_foreign_corp_key  IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.OH_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.PR_foreign_corp_key_Values := IF ( le.PR_foreign_corp_key  IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.PR_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.VI_foreign_corp_key_Values := IF ( le.VI_foreign_corp_key  IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.VI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WA_foreign_corp_key_Values := IF ( le.WA_foreign_corp_key  IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WI_foreign_corp_key_Values := IF ( le.WI_foreign_corp_key  IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WV_foreign_corp_key_Values := IF ( le.WV_foreign_corp_key  IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WV_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WY_foreign_corp_key_Values := IF ( le.WY_foreign_corp_key  IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WY_foreign_corp_key)}],SALT26.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.cnp_number_Values := IF ( le.cnp_number  IN SET(s.nulls_cnp_number,cnp_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.cnp_number)}],SALT26.Layout_FieldValueList));
  SELF.active_enterprise_number_Values := IF ( le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.active_enterprise_number)}],SALT26.Layout_FieldValueList));
  SELF.MN_foreign_corp_key_Values := IF ( le.MN_foreign_corp_key  IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MN_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NJ_foreign_corp_key_Values := IF ( le.NJ_foreign_corp_key  IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NJ_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.active_duns_number_Values := IF ( le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.active_duns_number)}],SALT26.Layout_FieldValueList));
  SELF.hist_enterprise_number_Values := IF ( le.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.hist_enterprise_number)}],SALT26.Layout_FieldValueList));
  SELF.hist_duns_number_Values := IF ( le.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.hist_duns_number)}],SALT26.Layout_FieldValueList));
  SELF.ebr_file_number_Values := IF ( le.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ebr_file_number)}],SALT26.Layout_FieldValueList));
  SELF.AR_foreign_corp_key_Values := IF ( le.AR_foreign_corp_key  IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AR_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.CA_foreign_corp_key_Values := IF ( le.CA_foreign_corp_key  IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.CA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.CO_foreign_corp_key_Values := IF ( le.CO_foreign_corp_key  IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.CO_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.DC_foreign_corp_key_Values := IF ( le.DC_foreign_corp_key  IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.DC_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.KS_foreign_corp_key_Values := IF ( le.KS_foreign_corp_key  IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.KS_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.KY_foreign_corp_key_Values := IF ( le.KY_foreign_corp_key  IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.KY_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MA_foreign_corp_key_Values := IF ( le.MA_foreign_corp_key  IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MD_foreign_corp_key_Values := IF ( le.MD_foreign_corp_key  IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MD_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.ME_foreign_corp_key_Values := IF ( le.ME_foreign_corp_key  IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ME_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MI_foreign_corp_key_Values := IF ( le.MI_foreign_corp_key  IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MO_foreign_corp_key_Values := IF ( le.MO_foreign_corp_key  IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MO_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NC_foreign_corp_key_Values := IF ( le.NC_foreign_corp_key  IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NC_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.ND_foreign_corp_key_Values := IF ( le.ND_foreign_corp_key  IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ND_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NM_foreign_corp_key_Values := IF ( le.NM_foreign_corp_key  IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NM_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.OK_foreign_corp_key_Values := IF ( le.OK_foreign_corp_key  IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.OK_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.PA_foreign_corp_key_Values := IF ( le.PA_foreign_corp_key  IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.PA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.SC_foreign_corp_key_Values := IF ( le.SC_foreign_corp_key  IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.SC_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.SD_foreign_corp_key_Values := IF ( le.SD_foreign_corp_key  IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.SD_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.TN_foreign_corp_key_Values := IF ( le.TN_foreign_corp_key  IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.TN_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.VT_foreign_corp_key_Values := IF ( le.VT_foreign_corp_key  IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.VT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.company_phone)}],SALT26.Layout_FieldValueList));
  SELF.domestic_corp_key_Values := IF ( le.domestic_corp_key  IN SET(s.nulls_domestic_corp_key,domestic_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.domestic_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.AL_foreign_corp_key_Values := IF ( le.AL_foreign_corp_key  IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AL_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.FL_foreign_corp_key_Values := IF ( le.FL_foreign_corp_key  IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.FL_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.GA_foreign_corp_key_Values := IF ( le.GA_foreign_corp_key  IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.GA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.IL_foreign_corp_key_Values := IF ( le.IL_foreign_corp_key  IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.IL_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.IN_foreign_corp_key_Values := IF ( le.IN_foreign_corp_key  IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.IN_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MS_foreign_corp_key_Values := IF ( le.MS_foreign_corp_key  IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MS_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NH_foreign_corp_key_Values := IF ( le.NH_foreign_corp_key  IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NH_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NV_foreign_corp_key_Values := IF ( le.NV_foreign_corp_key  IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NV_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NY_foreign_corp_key_Values := IF ( le.NY_foreign_corp_key  IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NY_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.OR_foreign_corp_key_Values := IF ( le.OR_foreign_corp_key  IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.OR_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.RI_foreign_corp_key_Values := IF ( le.RI_foreign_corp_key  IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.RI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.UT_foreign_corp_key_Values := IF ( le.UT_foreign_corp_key  IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.UT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.company_fein)}],SALT26.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( le.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.cnp_name)}],SALT26.Layout_FieldValueList));
  self.company_address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT26.Layout_FieldValueList),dataset([{TRIM((SALT26.StrType)le.prim_range) + ' ' + TRIM((SALT26.StrType)le.prim_name) + ' ' + TRIM((SALT26.StrType)le.sec_range) + ' ' + TRIM((SALT26.StrType)le.v_city_name) + ' ' + TRIM((SALT26.StrType)le.st) + ' ' + TRIM((SALT26.StrType)le.zip)}],SALT26.Layout_FieldValueList));
  SELF.AK_foreign_corp_key_Values := IF ( le.AK_foreign_corp_key  IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AK_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.CT_foreign_corp_key_Values := IF ( le.CT_foreign_corp_key  IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.CT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.HI_foreign_corp_key_Values := IF ( le.HI_foreign_corp_key  IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.HI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.IA_foreign_corp_key_Values := IF ( le.IA_foreign_corp_key  IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.IA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.LA_foreign_corp_key_Values := IF ( le.LA_foreign_corp_key  IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.LA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.MT_foreign_corp_key_Values := IF ( le.MT_foreign_corp_key  IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.MT_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.NE_foreign_corp_key_Values := IF ( le.NE_foreign_corp_key  IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.NE_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.VA_foreign_corp_key_Values := IF ( le.VA_foreign_corp_key  IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.VA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.AZ_foreign_corp_key_Values := IF ( le.AZ_foreign_corp_key  IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.AZ_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.TX_foreign_corp_key_Values := IF ( le.TX_foreign_corp_key  IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.TX_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( le.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.cnp_btype)}],SALT26.Layout_FieldValueList));
  SELF.iscorp_Values := IF ( le.iscorp  IN SET(s.nulls_iscorp,iscorp),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.iscorp)}],SALT26.Layout_FieldValueList));
  SELF.cnp_lowv_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_lowv)}],SALT26.Layout_FieldValueList);
  SELF.cnp_translated_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_translated)}],SALT26.Layout_FieldValueList);
  SELF.cnp_classid_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_classid)}],SALT26.Layout_FieldValueList);
  SELF.company_foreign_domestic_Values := DATASET([{TRIM((SALT26.StrType)le.company_foreign_domestic)}],SALT26.Layout_FieldValueList);
  SELF.company_bdid_Values := DATASET([{TRIM((SALT26.StrType)le.company_bdid)}],SALT26.Layout_FieldValueList);
  SELF.cnp_hasnumber_Values := DATASET([{TRIM((SALT26.StrType)le.cnp_hasnumber)}],SALT26.Layout_FieldValueList);
  SELF.company_name_Values := DATASET([{TRIM((SALT26.StrType)le.company_name)}],SALT26.Layout_FieldValueList);
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT26.StrType)le.dt_first_seen)}],SALT26.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT26.StrType)le.dt_last_seen)}],SALT26.Layout_FieldValueList);
  SELF.DE_foreign_corp_key_Values := IF ( le.DE_foreign_corp_key  IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.DE_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.ID_foreign_corp_key_Values := IF ( le.ID_foreign_corp_key  IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.ID_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.OH_foreign_corp_key_Values := IF ( le.OH_foreign_corp_key  IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.OH_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.PR_foreign_corp_key_Values := IF ( le.PR_foreign_corp_key  IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.PR_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.VI_foreign_corp_key_Values := IF ( le.VI_foreign_corp_key  IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.VI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WA_foreign_corp_key_Values := IF ( le.WA_foreign_corp_key  IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WA_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WI_foreign_corp_key_Values := IF ( le.WI_foreign_corp_key  IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WI_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WV_foreign_corp_key_Values := IF ( le.WV_foreign_corp_key  IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WV_foreign_corp_key)}],SALT26.Layout_FieldValueList));
  SELF.WY_foreign_corp_key_Values := IF ( le.WY_foreign_corp_key  IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key),DATASET([],SALT26.Layout_FieldValueList),DATASET([{TRIM((SALT26.StrType)le.WY_foreign_corp_key)}],SALT26.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.cnp_number := if ( le.cnp_number_prop>0, (TYPEOF(le.cnp_number))'', le.cnp_number ); // Blank if propogated
    self.cnp_number_isnull := le.cnp_number_prop>0 OR le.cnp_number_isnull;
    self.cnp_number_prop := 0; // Avoid reducing score later
    self.active_enterprise_number := if ( le.active_enterprise_number_prop>0, (TYPEOF(le.active_enterprise_number))'', le.active_enterprise_number ); // Blank if propogated
    self.active_enterprise_number_isnull := le.active_enterprise_number_prop>0 OR le.active_enterprise_number_isnull;
    self.active_enterprise_number_prop := 0; // Avoid reducing score later
    self.MN_foreign_corp_key := if ( le.MN_foreign_corp_key_prop>0, (TYPEOF(le.MN_foreign_corp_key))'', le.MN_foreign_corp_key ); // Blank if propogated
    self.MN_foreign_corp_key_isnull := le.MN_foreign_corp_key_prop>0 OR le.MN_foreign_corp_key_isnull;
    self.MN_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NJ_foreign_corp_key := if ( le.NJ_foreign_corp_key_prop>0, (TYPEOF(le.NJ_foreign_corp_key))'', le.NJ_foreign_corp_key ); // Blank if propogated
    self.NJ_foreign_corp_key_isnull := le.NJ_foreign_corp_key_prop>0 OR le.NJ_foreign_corp_key_isnull;
    self.NJ_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.active_duns_number := if ( le.active_duns_number_prop>0, (TYPEOF(le.active_duns_number))'', le.active_duns_number ); // Blank if propogated
    self.active_duns_number_isnull := le.active_duns_number_prop>0 OR le.active_duns_number_isnull;
    self.active_duns_number_prop := 0; // Avoid reducing score later
    self.hist_enterprise_number := if ( le.hist_enterprise_number_prop>0, (TYPEOF(le.hist_enterprise_number))'', le.hist_enterprise_number ); // Blank if propogated
    self.hist_enterprise_number_isnull := le.hist_enterprise_number_prop>0 OR le.hist_enterprise_number_isnull;
    self.hist_enterprise_number_prop := 0; // Avoid reducing score later
    self.hist_duns_number := if ( le.hist_duns_number_prop>0, (TYPEOF(le.hist_duns_number))'', le.hist_duns_number ); // Blank if propogated
    self.hist_duns_number_isnull := le.hist_duns_number_prop>0 OR le.hist_duns_number_isnull;
    self.hist_duns_number_prop := 0; // Avoid reducing score later
    self.ebr_file_number := if ( le.ebr_file_number_prop>0, (TYPEOF(le.ebr_file_number))'', le.ebr_file_number ); // Blank if propogated
    self.ebr_file_number_isnull := le.ebr_file_number_prop>0 OR le.ebr_file_number_isnull;
    self.ebr_file_number_prop := 0; // Avoid reducing score later
    self.AR_foreign_corp_key := if ( le.AR_foreign_corp_key_prop>0, (TYPEOF(le.AR_foreign_corp_key))'', le.AR_foreign_corp_key ); // Blank if propogated
    self.AR_foreign_corp_key_isnull := le.AR_foreign_corp_key_prop>0 OR le.AR_foreign_corp_key_isnull;
    self.AR_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.CA_foreign_corp_key := if ( le.CA_foreign_corp_key_prop>0, (TYPEOF(le.CA_foreign_corp_key))'', le.CA_foreign_corp_key ); // Blank if propogated
    self.CA_foreign_corp_key_isnull := le.CA_foreign_corp_key_prop>0 OR le.CA_foreign_corp_key_isnull;
    self.CA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.CO_foreign_corp_key := if ( le.CO_foreign_corp_key_prop>0, (TYPEOF(le.CO_foreign_corp_key))'', le.CO_foreign_corp_key ); // Blank if propogated
    self.CO_foreign_corp_key_isnull := le.CO_foreign_corp_key_prop>0 OR le.CO_foreign_corp_key_isnull;
    self.CO_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.DC_foreign_corp_key := if ( le.DC_foreign_corp_key_prop>0, (TYPEOF(le.DC_foreign_corp_key))'', le.DC_foreign_corp_key ); // Blank if propogated
    self.DC_foreign_corp_key_isnull := le.DC_foreign_corp_key_prop>0 OR le.DC_foreign_corp_key_isnull;
    self.DC_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.KS_foreign_corp_key := if ( le.KS_foreign_corp_key_prop>0, (TYPEOF(le.KS_foreign_corp_key))'', le.KS_foreign_corp_key ); // Blank if propogated
    self.KS_foreign_corp_key_isnull := le.KS_foreign_corp_key_prop>0 OR le.KS_foreign_corp_key_isnull;
    self.KS_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.KY_foreign_corp_key := if ( le.KY_foreign_corp_key_prop>0, (TYPEOF(le.KY_foreign_corp_key))'', le.KY_foreign_corp_key ); // Blank if propogated
    self.KY_foreign_corp_key_isnull := le.KY_foreign_corp_key_prop>0 OR le.KY_foreign_corp_key_isnull;
    self.KY_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.MA_foreign_corp_key := if ( le.MA_foreign_corp_key_prop>0, (TYPEOF(le.MA_foreign_corp_key))'', le.MA_foreign_corp_key ); // Blank if propogated
    self.MA_foreign_corp_key_isnull := le.MA_foreign_corp_key_prop>0 OR le.MA_foreign_corp_key_isnull;
    self.MA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.MD_foreign_corp_key := if ( le.MD_foreign_corp_key_prop>0, (TYPEOF(le.MD_foreign_corp_key))'', le.MD_foreign_corp_key ); // Blank if propogated
    self.MD_foreign_corp_key_isnull := le.MD_foreign_corp_key_prop>0 OR le.MD_foreign_corp_key_isnull;
    self.MD_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.ME_foreign_corp_key := if ( le.ME_foreign_corp_key_prop>0, (TYPEOF(le.ME_foreign_corp_key))'', le.ME_foreign_corp_key ); // Blank if propogated
    self.ME_foreign_corp_key_isnull := le.ME_foreign_corp_key_prop>0 OR le.ME_foreign_corp_key_isnull;
    self.ME_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.MI_foreign_corp_key := if ( le.MI_foreign_corp_key_prop>0, (TYPEOF(le.MI_foreign_corp_key))'', le.MI_foreign_corp_key ); // Blank if propogated
    self.MI_foreign_corp_key_isnull := le.MI_foreign_corp_key_prop>0 OR le.MI_foreign_corp_key_isnull;
    self.MI_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.MO_foreign_corp_key := if ( le.MO_foreign_corp_key_prop>0, (TYPEOF(le.MO_foreign_corp_key))'', le.MO_foreign_corp_key ); // Blank if propogated
    self.MO_foreign_corp_key_isnull := le.MO_foreign_corp_key_prop>0 OR le.MO_foreign_corp_key_isnull;
    self.MO_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NC_foreign_corp_key := if ( le.NC_foreign_corp_key_prop>0, (TYPEOF(le.NC_foreign_corp_key))'', le.NC_foreign_corp_key ); // Blank if propogated
    self.NC_foreign_corp_key_isnull := le.NC_foreign_corp_key_prop>0 OR le.NC_foreign_corp_key_isnull;
    self.NC_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.ND_foreign_corp_key := if ( le.ND_foreign_corp_key_prop>0, (TYPEOF(le.ND_foreign_corp_key))'', le.ND_foreign_corp_key ); // Blank if propogated
    self.ND_foreign_corp_key_isnull := le.ND_foreign_corp_key_prop>0 OR le.ND_foreign_corp_key_isnull;
    self.ND_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NM_foreign_corp_key := if ( le.NM_foreign_corp_key_prop>0, (TYPEOF(le.NM_foreign_corp_key))'', le.NM_foreign_corp_key ); // Blank if propogated
    self.NM_foreign_corp_key_isnull := le.NM_foreign_corp_key_prop>0 OR le.NM_foreign_corp_key_isnull;
    self.NM_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.OK_foreign_corp_key := if ( le.OK_foreign_corp_key_prop>0, (TYPEOF(le.OK_foreign_corp_key))'', le.OK_foreign_corp_key ); // Blank if propogated
    self.OK_foreign_corp_key_isnull := le.OK_foreign_corp_key_prop>0 OR le.OK_foreign_corp_key_isnull;
    self.OK_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.PA_foreign_corp_key := if ( le.PA_foreign_corp_key_prop>0, (TYPEOF(le.PA_foreign_corp_key))'', le.PA_foreign_corp_key ); // Blank if propogated
    self.PA_foreign_corp_key_isnull := le.PA_foreign_corp_key_prop>0 OR le.PA_foreign_corp_key_isnull;
    self.PA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.SC_foreign_corp_key := if ( le.SC_foreign_corp_key_prop>0, (TYPEOF(le.SC_foreign_corp_key))'', le.SC_foreign_corp_key ); // Blank if propogated
    self.SC_foreign_corp_key_isnull := le.SC_foreign_corp_key_prop>0 OR le.SC_foreign_corp_key_isnull;
    self.SC_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.SD_foreign_corp_key := if ( le.SD_foreign_corp_key_prop>0, (TYPEOF(le.SD_foreign_corp_key))'', le.SD_foreign_corp_key ); // Blank if propogated
    self.SD_foreign_corp_key_isnull := le.SD_foreign_corp_key_prop>0 OR le.SD_foreign_corp_key_isnull;
    self.SD_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.TN_foreign_corp_key := if ( le.TN_foreign_corp_key_prop>0, (TYPEOF(le.TN_foreign_corp_key))'', le.TN_foreign_corp_key ); // Blank if propogated
    self.TN_foreign_corp_key_isnull := le.TN_foreign_corp_key_prop>0 OR le.TN_foreign_corp_key_isnull;
    self.TN_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.VT_foreign_corp_key := if ( le.VT_foreign_corp_key_prop>0, (TYPEOF(le.VT_foreign_corp_key))'', le.VT_foreign_corp_key ); // Blank if propogated
    self.VT_foreign_corp_key_isnull := le.VT_foreign_corp_key_prop>0 OR le.VT_foreign_corp_key_isnull;
    self.VT_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.company_phone := if ( le.company_phone_prop>0, (TYPEOF(le.company_phone))'', le.company_phone ); // Blank if propogated
    self.company_phone_isnull := le.company_phone_prop>0 OR le.company_phone_isnull;
    self.company_phone_prop := 0; // Avoid reducing score later
    self.domestic_corp_key := if ( le.domestic_corp_key_prop>0, (TYPEOF(le.domestic_corp_key))'', le.domestic_corp_key ); // Blank if propogated
    self.domestic_corp_key_isnull := le.domestic_corp_key_prop>0 OR le.domestic_corp_key_isnull;
    self.domestic_corp_key_prop := 0; // Avoid reducing score later
    self.AL_foreign_corp_key := if ( le.AL_foreign_corp_key_prop>0, (TYPEOF(le.AL_foreign_corp_key))'', le.AL_foreign_corp_key ); // Blank if propogated
    self.AL_foreign_corp_key_isnull := le.AL_foreign_corp_key_prop>0 OR le.AL_foreign_corp_key_isnull;
    self.AL_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.FL_foreign_corp_key := if ( le.FL_foreign_corp_key_prop>0, (TYPEOF(le.FL_foreign_corp_key))'', le.FL_foreign_corp_key ); // Blank if propogated
    self.FL_foreign_corp_key_isnull := le.FL_foreign_corp_key_prop>0 OR le.FL_foreign_corp_key_isnull;
    self.FL_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.GA_foreign_corp_key := if ( le.GA_foreign_corp_key_prop>0, (TYPEOF(le.GA_foreign_corp_key))'', le.GA_foreign_corp_key ); // Blank if propogated
    self.GA_foreign_corp_key_isnull := le.GA_foreign_corp_key_prop>0 OR le.GA_foreign_corp_key_isnull;
    self.GA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.IL_foreign_corp_key := if ( le.IL_foreign_corp_key_prop>0, (TYPEOF(le.IL_foreign_corp_key))'', le.IL_foreign_corp_key ); // Blank if propogated
    self.IL_foreign_corp_key_isnull := le.IL_foreign_corp_key_prop>0 OR le.IL_foreign_corp_key_isnull;
    self.IL_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.IN_foreign_corp_key := if ( le.IN_foreign_corp_key_prop>0, (TYPEOF(le.IN_foreign_corp_key))'', le.IN_foreign_corp_key ); // Blank if propogated
    self.IN_foreign_corp_key_isnull := le.IN_foreign_corp_key_prop>0 OR le.IN_foreign_corp_key_isnull;
    self.IN_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.MS_foreign_corp_key := if ( le.MS_foreign_corp_key_prop>0, (TYPEOF(le.MS_foreign_corp_key))'', le.MS_foreign_corp_key ); // Blank if propogated
    self.MS_foreign_corp_key_isnull := le.MS_foreign_corp_key_prop>0 OR le.MS_foreign_corp_key_isnull;
    self.MS_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NH_foreign_corp_key := if ( le.NH_foreign_corp_key_prop>0, (TYPEOF(le.NH_foreign_corp_key))'', le.NH_foreign_corp_key ); // Blank if propogated
    self.NH_foreign_corp_key_isnull := le.NH_foreign_corp_key_prop>0 OR le.NH_foreign_corp_key_isnull;
    self.NH_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NV_foreign_corp_key := if ( le.NV_foreign_corp_key_prop>0, (TYPEOF(le.NV_foreign_corp_key))'', le.NV_foreign_corp_key ); // Blank if propogated
    self.NV_foreign_corp_key_isnull := le.NV_foreign_corp_key_prop>0 OR le.NV_foreign_corp_key_isnull;
    self.NV_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NY_foreign_corp_key := if ( le.NY_foreign_corp_key_prop>0, (TYPEOF(le.NY_foreign_corp_key))'', le.NY_foreign_corp_key ); // Blank if propogated
    self.NY_foreign_corp_key_isnull := le.NY_foreign_corp_key_prop>0 OR le.NY_foreign_corp_key_isnull;
    self.NY_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.OR_foreign_corp_key := if ( le.OR_foreign_corp_key_prop>0, (TYPEOF(le.OR_foreign_corp_key))'', le.OR_foreign_corp_key ); // Blank if propogated
    self.OR_foreign_corp_key_isnull := le.OR_foreign_corp_key_prop>0 OR le.OR_foreign_corp_key_isnull;
    self.OR_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.RI_foreign_corp_key := if ( le.RI_foreign_corp_key_prop>0, (TYPEOF(le.RI_foreign_corp_key))'', le.RI_foreign_corp_key ); // Blank if propogated
    self.RI_foreign_corp_key_isnull := le.RI_foreign_corp_key_prop>0 OR le.RI_foreign_corp_key_isnull;
    self.RI_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.UT_foreign_corp_key := if ( le.UT_foreign_corp_key_prop>0, (TYPEOF(le.UT_foreign_corp_key))'', le.UT_foreign_corp_key ); // Blank if propogated
    self.UT_foreign_corp_key_isnull := le.UT_foreign_corp_key_prop>0 OR le.UT_foreign_corp_key_isnull;
    self.UT_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.company_address := if ( le.company_address_prop>0, 0, le.company_address ); // Blank if propogated
    self.company_address_isnull := true; // Flag as null to scoring
    self.company_address_prop := 0; // Avoid reducing score later
    self.AK_foreign_corp_key := if ( le.AK_foreign_corp_key_prop>0, (TYPEOF(le.AK_foreign_corp_key))'', le.AK_foreign_corp_key ); // Blank if propogated
    self.AK_foreign_corp_key_isnull := le.AK_foreign_corp_key_prop>0 OR le.AK_foreign_corp_key_isnull;
    self.AK_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.CT_foreign_corp_key := if ( le.CT_foreign_corp_key_prop>0, (TYPEOF(le.CT_foreign_corp_key))'', le.CT_foreign_corp_key ); // Blank if propogated
    self.CT_foreign_corp_key_isnull := le.CT_foreign_corp_key_prop>0 OR le.CT_foreign_corp_key_isnull;
    self.CT_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.HI_foreign_corp_key := if ( le.HI_foreign_corp_key_prop>0, (TYPEOF(le.HI_foreign_corp_key))'', le.HI_foreign_corp_key ); // Blank if propogated
    self.HI_foreign_corp_key_isnull := le.HI_foreign_corp_key_prop>0 OR le.HI_foreign_corp_key_isnull;
    self.HI_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.IA_foreign_corp_key := if ( le.IA_foreign_corp_key_prop>0, (TYPEOF(le.IA_foreign_corp_key))'', le.IA_foreign_corp_key ); // Blank if propogated
    self.IA_foreign_corp_key_isnull := le.IA_foreign_corp_key_prop>0 OR le.IA_foreign_corp_key_isnull;
    self.IA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.LA_foreign_corp_key := if ( le.LA_foreign_corp_key_prop>0, (TYPEOF(le.LA_foreign_corp_key))'', le.LA_foreign_corp_key ); // Blank if propogated
    self.LA_foreign_corp_key_isnull := le.LA_foreign_corp_key_prop>0 OR le.LA_foreign_corp_key_isnull;
    self.LA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.MT_foreign_corp_key := if ( le.MT_foreign_corp_key_prop>0, (TYPEOF(le.MT_foreign_corp_key))'', le.MT_foreign_corp_key ); // Blank if propogated
    self.MT_foreign_corp_key_isnull := le.MT_foreign_corp_key_prop>0 OR le.MT_foreign_corp_key_isnull;
    self.MT_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.NE_foreign_corp_key := if ( le.NE_foreign_corp_key_prop>0, (TYPEOF(le.NE_foreign_corp_key))'', le.NE_foreign_corp_key ); // Blank if propogated
    self.NE_foreign_corp_key_isnull := le.NE_foreign_corp_key_prop>0 OR le.NE_foreign_corp_key_isnull;
    self.NE_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.VA_foreign_corp_key := if ( le.VA_foreign_corp_key_prop>0, (TYPEOF(le.VA_foreign_corp_key))'', le.VA_foreign_corp_key ); // Blank if propogated
    self.VA_foreign_corp_key_isnull := le.VA_foreign_corp_key_prop>0 OR le.VA_foreign_corp_key_isnull;
    self.VA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.AZ_foreign_corp_key := if ( le.AZ_foreign_corp_key_prop>0, (TYPEOF(le.AZ_foreign_corp_key))'', le.AZ_foreign_corp_key ); // Blank if propogated
    self.AZ_foreign_corp_key_isnull := le.AZ_foreign_corp_key_prop>0 OR le.AZ_foreign_corp_key_isnull;
    self.AZ_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.TX_foreign_corp_key := if ( le.TX_foreign_corp_key_prop>0, (TYPEOF(le.TX_foreign_corp_key))'', le.TX_foreign_corp_key ); // Blank if propogated
    self.TX_foreign_corp_key_isnull := le.TX_foreign_corp_key_prop>0 OR le.TX_foreign_corp_key_isnull;
    self.TX_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.company_addr1 := if ( le.company_addr1_prop>0, 0, le.company_addr1 ); // Blank if propogated
    self.company_addr1_isnull := true; // Flag as null to scoring
    self.company_addr1_prop := 0; // Avoid reducing score later
    self.sec_range := if ( le.sec_range_prop>0, (TYPEOF(le.sec_range))'', le.sec_range ); // Blank if propogated
    self.sec_range_isnull := le.sec_range_prop>0 OR le.sec_range_isnull;
    self.sec_range_prop := 0; // Avoid reducing score later
    self.iscorp := if ( le.iscorp_prop>0, (TYPEOF(le.iscorp))'', le.iscorp ); // Blank if propogated
    self.iscorp_isnull := le.iscorp_prop>0 OR le.iscorp_isnull;
    self.iscorp_prop := 0; // Avoid reducing score later
    self.DE_foreign_corp_key := if ( le.DE_foreign_corp_key_prop>0, (TYPEOF(le.DE_foreign_corp_key))'', le.DE_foreign_corp_key ); // Blank if propogated
    self.DE_foreign_corp_key_isnull := le.DE_foreign_corp_key_prop>0 OR le.DE_foreign_corp_key_isnull;
    self.DE_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.ID_foreign_corp_key := if ( le.ID_foreign_corp_key_prop>0, (TYPEOF(le.ID_foreign_corp_key))'', le.ID_foreign_corp_key ); // Blank if propogated
    self.ID_foreign_corp_key_isnull := le.ID_foreign_corp_key_prop>0 OR le.ID_foreign_corp_key_isnull;
    self.ID_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.OH_foreign_corp_key := if ( le.OH_foreign_corp_key_prop>0, (TYPEOF(le.OH_foreign_corp_key))'', le.OH_foreign_corp_key ); // Blank if propogated
    self.OH_foreign_corp_key_isnull := le.OH_foreign_corp_key_prop>0 OR le.OH_foreign_corp_key_isnull;
    self.OH_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.PR_foreign_corp_key := if ( le.PR_foreign_corp_key_prop>0, (TYPEOF(le.PR_foreign_corp_key))'', le.PR_foreign_corp_key ); // Blank if propogated
    self.PR_foreign_corp_key_isnull := le.PR_foreign_corp_key_prop>0 OR le.PR_foreign_corp_key_isnull;
    self.PR_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.VI_foreign_corp_key := if ( le.VI_foreign_corp_key_prop>0, (TYPEOF(le.VI_foreign_corp_key))'', le.VI_foreign_corp_key ); // Blank if propogated
    self.VI_foreign_corp_key_isnull := le.VI_foreign_corp_key_prop>0 OR le.VI_foreign_corp_key_isnull;
    self.VI_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.WA_foreign_corp_key := if ( le.WA_foreign_corp_key_prop>0, (TYPEOF(le.WA_foreign_corp_key))'', le.WA_foreign_corp_key ); // Blank if propogated
    self.WA_foreign_corp_key_isnull := le.WA_foreign_corp_key_prop>0 OR le.WA_foreign_corp_key_isnull;
    self.WA_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.WI_foreign_corp_key := if ( le.WI_foreign_corp_key_prop>0, (TYPEOF(le.WI_foreign_corp_key))'', le.WI_foreign_corp_key ); // Blank if propogated
    self.WI_foreign_corp_key_isnull := le.WI_foreign_corp_key_prop>0 OR le.WI_foreign_corp_key_isnull;
    self.WI_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.WV_foreign_corp_key := if ( le.WV_foreign_corp_key_prop>0, (TYPEOF(le.WV_foreign_corp_key))'', le.WV_foreign_corp_key ); // Blank if propogated
    self.WV_foreign_corp_key_isnull := le.WV_foreign_corp_key_prop>0 OR le.WV_foreign_corp_key_isnull;
    self.WV_foreign_corp_key_prop := 0; // Avoid reducing score later
    self.WY_foreign_corp_key := if ( le.WY_foreign_corp_key_prop>0, (TYPEOF(le.WY_foreign_corp_key))'', le.WY_foreign_corp_key ); // Blank if propogated
    self.WY_foreign_corp_key_isnull := le.WY_foreign_corp_key_prop>0 OR le.WY_foreign_corp_key_isnull;
    self.WY_foreign_corp_key_prop := 0; // Avoid reducing score later
    SELF := le;
  END;
  RETURN PROJECT(im,rem(LEFT));
END;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 cnp_number_size := 0;
  UNSIGNED1 active_enterprise_number_size := 0;
  UNSIGNED1 MN_foreign_corp_key_size := 0;
  UNSIGNED1 NJ_foreign_corp_key_size := 0;
  UNSIGNED1 active_duns_number_size := 0;
  UNSIGNED1 hist_enterprise_number_size := 0;
  UNSIGNED1 hist_duns_number_size := 0;
  UNSIGNED1 ebr_file_number_size := 0;
  UNSIGNED1 AR_foreign_corp_key_size := 0;
  UNSIGNED1 CA_foreign_corp_key_size := 0;
  UNSIGNED1 CO_foreign_corp_key_size := 0;
  UNSIGNED1 DC_foreign_corp_key_size := 0;
  UNSIGNED1 KS_foreign_corp_key_size := 0;
  UNSIGNED1 KY_foreign_corp_key_size := 0;
  UNSIGNED1 MA_foreign_corp_key_size := 0;
  UNSIGNED1 MD_foreign_corp_key_size := 0;
  UNSIGNED1 ME_foreign_corp_key_size := 0;
  UNSIGNED1 MI_foreign_corp_key_size := 0;
  UNSIGNED1 MO_foreign_corp_key_size := 0;
  UNSIGNED1 NC_foreign_corp_key_size := 0;
  UNSIGNED1 ND_foreign_corp_key_size := 0;
  UNSIGNED1 NM_foreign_corp_key_size := 0;
  UNSIGNED1 OK_foreign_corp_key_size := 0;
  UNSIGNED1 PA_foreign_corp_key_size := 0;
  UNSIGNED1 SC_foreign_corp_key_size := 0;
  UNSIGNED1 SD_foreign_corp_key_size := 0;
  UNSIGNED1 TN_foreign_corp_key_size := 0;
  UNSIGNED1 VT_foreign_corp_key_size := 0;
  UNSIGNED1 company_phone_size := 0;
  UNSIGNED1 domestic_corp_key_size := 0;
  UNSIGNED1 AL_foreign_corp_key_size := 0;
  UNSIGNED1 FL_foreign_corp_key_size := 0;
  UNSIGNED1 GA_foreign_corp_key_size := 0;
  UNSIGNED1 IL_foreign_corp_key_size := 0;
  UNSIGNED1 IN_foreign_corp_key_size := 0;
  UNSIGNED1 MS_foreign_corp_key_size := 0;
  UNSIGNED1 NH_foreign_corp_key_size := 0;
  UNSIGNED1 NV_foreign_corp_key_size := 0;
  UNSIGNED1 NY_foreign_corp_key_size := 0;
  UNSIGNED1 OR_foreign_corp_key_size := 0;
  UNSIGNED1 RI_foreign_corp_key_size := 0;
  UNSIGNED1 UT_foreign_corp_key_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 cnp_name_size := 0;
  UNSIGNED1 company_address_size := 0;
  UNSIGNED1 AK_foreign_corp_key_size := 0;
  UNSIGNED1 CT_foreign_corp_key_size := 0;
  UNSIGNED1 HI_foreign_corp_key_size := 0;
  UNSIGNED1 IA_foreign_corp_key_size := 0;
  UNSIGNED1 LA_foreign_corp_key_size := 0;
  UNSIGNED1 MT_foreign_corp_key_size := 0;
  UNSIGNED1 NE_foreign_corp_key_size := 0;
  UNSIGNED1 VA_foreign_corp_key_size := 0;
  UNSIGNED1 AZ_foreign_corp_key_size := 0;
  UNSIGNED1 TX_foreign_corp_key_size := 0;
  UNSIGNED1 cnp_btype_size := 0;
  UNSIGNED1 iscorp_size := 0;
  UNSIGNED1 DE_foreign_corp_key_size := 0;
  UNSIGNED1 ID_foreign_corp_key_size := 0;
  UNSIGNED1 OH_foreign_corp_key_size := 0;
  UNSIGNED1 PR_foreign_corp_key_size := 0;
  UNSIGNED1 VI_foreign_corp_key_size := 0;
  UNSIGNED1 WA_foreign_corp_key_size := 0;
  UNSIGNED1 WI_foreign_corp_key_size := 0;
  UNSIGNED1 WV_foreign_corp_key_size := 0;
  UNSIGNED1 WY_foreign_corp_key_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.cnp_number_size := SALT26.Fn_SwitchSpec(s.cnp_number_switch,count(le.cnp_number_values));
  SELF.active_enterprise_number_size := SALT26.Fn_SwitchSpec(s.active_enterprise_number_switch,count(le.active_enterprise_number_values));
  SELF.MN_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MN_foreign_corp_key_switch,count(le.MN_foreign_corp_key_values));
  SELF.NJ_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NJ_foreign_corp_key_switch,count(le.NJ_foreign_corp_key_values));
  SELF.active_duns_number_size := SALT26.Fn_SwitchSpec(s.active_duns_number_switch,count(le.active_duns_number_values));
  SELF.hist_enterprise_number_size := SALT26.Fn_SwitchSpec(s.hist_enterprise_number_switch,count(le.hist_enterprise_number_values));
  SELF.hist_duns_number_size := SALT26.Fn_SwitchSpec(s.hist_duns_number_switch,count(le.hist_duns_number_values));
  SELF.ebr_file_number_size := SALT26.Fn_SwitchSpec(s.ebr_file_number_switch,count(le.ebr_file_number_values));
  SELF.AR_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.AR_foreign_corp_key_switch,count(le.AR_foreign_corp_key_values));
  SELF.CA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.CA_foreign_corp_key_switch,count(le.CA_foreign_corp_key_values));
  SELF.CO_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.CO_foreign_corp_key_switch,count(le.CO_foreign_corp_key_values));
  SELF.DC_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.DC_foreign_corp_key_switch,count(le.DC_foreign_corp_key_values));
  SELF.KS_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.KS_foreign_corp_key_switch,count(le.KS_foreign_corp_key_values));
  SELF.KY_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.KY_foreign_corp_key_switch,count(le.KY_foreign_corp_key_values));
  SELF.MA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MA_foreign_corp_key_switch,count(le.MA_foreign_corp_key_values));
  SELF.MD_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MD_foreign_corp_key_switch,count(le.MD_foreign_corp_key_values));
  SELF.ME_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.ME_foreign_corp_key_switch,count(le.ME_foreign_corp_key_values));
  SELF.MI_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MI_foreign_corp_key_switch,count(le.MI_foreign_corp_key_values));
  SELF.MO_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MO_foreign_corp_key_switch,count(le.MO_foreign_corp_key_values));
  SELF.NC_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NC_foreign_corp_key_switch,count(le.NC_foreign_corp_key_values));
  SELF.ND_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.ND_foreign_corp_key_switch,count(le.ND_foreign_corp_key_values));
  SELF.NM_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NM_foreign_corp_key_switch,count(le.NM_foreign_corp_key_values));
  SELF.OK_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.OK_foreign_corp_key_switch,count(le.OK_foreign_corp_key_values));
  SELF.PA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.PA_foreign_corp_key_switch,count(le.PA_foreign_corp_key_values));
  SELF.SC_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.SC_foreign_corp_key_switch,count(le.SC_foreign_corp_key_values));
  SELF.SD_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.SD_foreign_corp_key_switch,count(le.SD_foreign_corp_key_values));
  SELF.TN_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.TN_foreign_corp_key_switch,count(le.TN_foreign_corp_key_values));
  SELF.VT_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.VT_foreign_corp_key_switch,count(le.VT_foreign_corp_key_values));
  SELF.company_phone_size := SALT26.Fn_SwitchSpec(s.company_phone_switch,count(le.company_phone_values));
  SELF.domestic_corp_key_size := SALT26.Fn_SwitchSpec(s.domestic_corp_key_switch,count(le.domestic_corp_key_values));
  SELF.AL_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.AL_foreign_corp_key_switch,count(le.AL_foreign_corp_key_values));
  SELF.FL_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.FL_foreign_corp_key_switch,count(le.FL_foreign_corp_key_values));
  SELF.GA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.GA_foreign_corp_key_switch,count(le.GA_foreign_corp_key_values));
  SELF.IL_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.IL_foreign_corp_key_switch,count(le.IL_foreign_corp_key_values));
  SELF.IN_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.IN_foreign_corp_key_switch,count(le.IN_foreign_corp_key_values));
  SELF.MS_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MS_foreign_corp_key_switch,count(le.MS_foreign_corp_key_values));
  SELF.NH_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NH_foreign_corp_key_switch,count(le.NH_foreign_corp_key_values));
  SELF.NV_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NV_foreign_corp_key_switch,count(le.NV_foreign_corp_key_values));
  SELF.NY_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NY_foreign_corp_key_switch,count(le.NY_foreign_corp_key_values));
  SELF.OR_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.OR_foreign_corp_key_switch,count(le.OR_foreign_corp_key_values));
  SELF.RI_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.RI_foreign_corp_key_switch,count(le.RI_foreign_corp_key_values));
  SELF.UT_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.UT_foreign_corp_key_switch,count(le.UT_foreign_corp_key_values));
  SELF.company_fein_size := SALT26.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.cnp_name_size := SALT26.Fn_SwitchSpec(s.cnp_name_switch,count(le.cnp_name_values));
  SELF.company_address_size := SALT26.Fn_SwitchSpec(s.company_address_switch,count(le.company_address_values));
  SELF.AK_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.AK_foreign_corp_key_switch,count(le.AK_foreign_corp_key_values));
  SELF.CT_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.CT_foreign_corp_key_switch,count(le.CT_foreign_corp_key_values));
  SELF.HI_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.HI_foreign_corp_key_switch,count(le.HI_foreign_corp_key_values));
  SELF.IA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.IA_foreign_corp_key_switch,count(le.IA_foreign_corp_key_values));
  SELF.LA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.LA_foreign_corp_key_switch,count(le.LA_foreign_corp_key_values));
  SELF.MT_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.MT_foreign_corp_key_switch,count(le.MT_foreign_corp_key_values));
  SELF.NE_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.NE_foreign_corp_key_switch,count(le.NE_foreign_corp_key_values));
  SELF.VA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.VA_foreign_corp_key_switch,count(le.VA_foreign_corp_key_values));
  SELF.AZ_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.AZ_foreign_corp_key_switch,count(le.AZ_foreign_corp_key_values));
  SELF.TX_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.TX_foreign_corp_key_switch,count(le.TX_foreign_corp_key_values));
  SELF.cnp_btype_size := SALT26.Fn_SwitchSpec(s.cnp_btype_switch,count(le.cnp_btype_values));
  SELF.iscorp_size := SALT26.Fn_SwitchSpec(s.iscorp_switch,count(le.iscorp_values));
  SELF.DE_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.DE_foreign_corp_key_switch,count(le.DE_foreign_corp_key_values));
  SELF.ID_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.ID_foreign_corp_key_switch,count(le.ID_foreign_corp_key_values));
  SELF.OH_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.OH_foreign_corp_key_switch,count(le.OH_foreign_corp_key_values));
  SELF.PR_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.PR_foreign_corp_key_switch,count(le.PR_foreign_corp_key_values));
  SELF.VI_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.VI_foreign_corp_key_switch,count(le.VI_foreign_corp_key_values));
  SELF.WA_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.WA_foreign_corp_key_switch,count(le.WA_foreign_corp_key_values));
  SELF.WI_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.WI_foreign_corp_key_switch,count(le.WI_foreign_corp_key_values));
  SELF.WV_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.WV_foreign_corp_key_switch,count(le.WV_foreign_corp_key_values));
  SELF.WY_foreign_corp_key_size := SALT26.Fn_SwitchSpec(s.WY_foreign_corp_key_switch,count(le.WY_foreign_corp_key_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.cnp_number_size+t.active_enterprise_number_size+t.MN_foreign_corp_key_size+t.NJ_foreign_corp_key_size+t.active_duns_number_size+t.hist_enterprise_number_size+t.hist_duns_number_size+t.ebr_file_number_size+t.AR_foreign_corp_key_size+t.CA_foreign_corp_key_size+t.CO_foreign_corp_key_size+t.DC_foreign_corp_key_size+t.KS_foreign_corp_key_size+t.KY_foreign_corp_key_size+t.MA_foreign_corp_key_size+t.MD_foreign_corp_key_size+t.ME_foreign_corp_key_size+t.MI_foreign_corp_key_size+t.MO_foreign_corp_key_size+t.NC_foreign_corp_key_size+t.ND_foreign_corp_key_size+t.NM_foreign_corp_key_size+t.OK_foreign_corp_key_size+t.PA_foreign_corp_key_size+t.SC_foreign_corp_key_size+t.SD_foreign_corp_key_size+t.TN_foreign_corp_key_size+t.VT_foreign_corp_key_size+t.company_phone_size+t.domestic_corp_key_size+t.AL_foreign_corp_key_size+t.FL_foreign_corp_key_size+t.GA_foreign_corp_key_size+t.IL_foreign_corp_key_size+t.IN_foreign_corp_key_size+t.MS_foreign_corp_key_size+t.NH_foreign_corp_key_size+t.NV_foreign_corp_key_size+t.NY_foreign_corp_key_size+t.OR_foreign_corp_key_size+t.RI_foreign_corp_key_size+t.UT_foreign_corp_key_size+t.company_fein_size+t.cnp_name_size+t.company_address_size+t.AK_foreign_corp_key_size+t.CT_foreign_corp_key_size+t.HI_foreign_corp_key_size+t.IA_foreign_corp_key_size+t.LA_foreign_corp_key_size+t.MT_foreign_corp_key_size+t.NE_foreign_corp_key_size+t.VA_foreign_corp_key_size+t.AZ_foreign_corp_key_size+t.TX_foreign_corp_key_size+t.cnp_btype_size+t.iscorp_size+t.DE_foreign_corp_key_size+t.ID_foreign_corp_key_size+t.OH_foreign_corp_key_size+t.PR_foreign_corp_key_size+t.VI_foreign_corp_key_size+t.WA_foreign_corp_key_size+t.WI_foreign_corp_key_size+t.WV_foreign_corp_key_size+t.WY_foreign_corp_key_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
