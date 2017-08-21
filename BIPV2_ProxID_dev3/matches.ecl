// Begin code to perform the matching itself
 
IMPORT SALT26,ut;
EXPORT matches(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 21) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT26.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT26.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT26.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 MN_foreign_corp_key_score_temp := MAP( le.MN_foreign_corp_key_isnull OR ri.MN_foreign_corp_key_isnull => 0,
                        le.MN_foreign_corp_key = ri.MN_foreign_corp_key  => le.MN_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MN_foreign_corp_key_weight100,s.MN_foreign_corp_key_switch));
  INTEGER2 NJ_foreign_corp_key_score_temp := MAP( le.NJ_foreign_corp_key_isnull OR ri.NJ_foreign_corp_key_isnull => 0,
                        le.NJ_foreign_corp_key = ri.NJ_foreign_corp_key  => le.NJ_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NJ_foreign_corp_key_weight100,s.NJ_foreign_corp_key_switch));
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT26.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  INTEGER2 hist_enterprise_number_score := MAP( le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => 0,
                        le.hist_enterprise_number = ri.hist_enterprise_number  => le.hist_enterprise_number_weight100,
                        0 /* switch0 */);
  INTEGER2 hist_duns_number_score := MAP( le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => 0,
                        le.hist_duns_number = ri.hist_duns_number  => le.hist_duns_number_weight100,
                        0 /* switch0 */);
  INTEGER2 ebr_file_number_score := MAP( le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => 0,
                        le.ebr_file_number = ri.ebr_file_number  => le.ebr_file_number_weight100,
                        0 /* switch0 */);
  INTEGER2 AR_foreign_corp_key_score_temp := MAP( le.AR_foreign_corp_key_isnull OR ri.AR_foreign_corp_key_isnull => 0,
                        le.AR_foreign_corp_key = ri.AR_foreign_corp_key  => le.AR_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AR_foreign_corp_key_weight100,s.AR_foreign_corp_key_switch));
  INTEGER2 CA_foreign_corp_key_score_temp := MAP( le.CA_foreign_corp_key_isnull OR ri.CA_foreign_corp_key_isnull => 0,
                        le.CA_foreign_corp_key = ri.CA_foreign_corp_key  => le.CA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.CA_foreign_corp_key_weight100,s.CA_foreign_corp_key_switch));
  INTEGER2 CO_foreign_corp_key_score_temp := MAP( le.CO_foreign_corp_key_isnull OR ri.CO_foreign_corp_key_isnull => 0,
                        le.CO_foreign_corp_key = ri.CO_foreign_corp_key  => le.CO_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.CO_foreign_corp_key_weight100,s.CO_foreign_corp_key_switch));
  INTEGER2 DC_foreign_corp_key_score_temp := MAP( le.DC_foreign_corp_key_isnull OR ri.DC_foreign_corp_key_isnull => 0,
                        le.DC_foreign_corp_key = ri.DC_foreign_corp_key  => le.DC_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.DC_foreign_corp_key_weight100,s.DC_foreign_corp_key_switch));
  INTEGER2 KS_foreign_corp_key_score_temp := MAP( le.KS_foreign_corp_key_isnull OR ri.KS_foreign_corp_key_isnull => 0,
                        le.KS_foreign_corp_key = ri.KS_foreign_corp_key  => le.KS_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.KS_foreign_corp_key_weight100,s.KS_foreign_corp_key_switch));
  INTEGER2 KY_foreign_corp_key_score_temp := MAP( le.KY_foreign_corp_key_isnull OR ri.KY_foreign_corp_key_isnull => 0,
                        le.KY_foreign_corp_key = ri.KY_foreign_corp_key  => le.KY_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.KY_foreign_corp_key_weight100,s.KY_foreign_corp_key_switch));
  INTEGER2 MA_foreign_corp_key_score_temp := MAP( le.MA_foreign_corp_key_isnull OR ri.MA_foreign_corp_key_isnull => 0,
                        le.MA_foreign_corp_key = ri.MA_foreign_corp_key  => le.MA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MA_foreign_corp_key_weight100,s.MA_foreign_corp_key_switch));
  INTEGER2 MD_foreign_corp_key_score_temp := MAP( le.MD_foreign_corp_key_isnull OR ri.MD_foreign_corp_key_isnull => 0,
                        le.MD_foreign_corp_key = ri.MD_foreign_corp_key  => le.MD_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MD_foreign_corp_key_weight100,s.MD_foreign_corp_key_switch));
  INTEGER2 ME_foreign_corp_key_score_temp := MAP( le.ME_foreign_corp_key_isnull OR ri.ME_foreign_corp_key_isnull => 0,
                        le.ME_foreign_corp_key = ri.ME_foreign_corp_key  => le.ME_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.ME_foreign_corp_key_weight100,s.ME_foreign_corp_key_switch));
  INTEGER2 MI_foreign_corp_key_score_temp := MAP( le.MI_foreign_corp_key_isnull OR ri.MI_foreign_corp_key_isnull => 0,
                        le.MI_foreign_corp_key = ri.MI_foreign_corp_key  => le.MI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MI_foreign_corp_key_weight100,s.MI_foreign_corp_key_switch));
  INTEGER2 MO_foreign_corp_key_score_temp := MAP( le.MO_foreign_corp_key_isnull OR ri.MO_foreign_corp_key_isnull => 0,
                        le.MO_foreign_corp_key = ri.MO_foreign_corp_key  => le.MO_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MO_foreign_corp_key_weight100,s.MO_foreign_corp_key_switch));
  INTEGER2 NC_foreign_corp_key_score_temp := MAP( le.NC_foreign_corp_key_isnull OR ri.NC_foreign_corp_key_isnull => 0,
                        le.NC_foreign_corp_key = ri.NC_foreign_corp_key  => le.NC_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NC_foreign_corp_key_weight100,s.NC_foreign_corp_key_switch));
  INTEGER2 ND_foreign_corp_key_score_temp := MAP( le.ND_foreign_corp_key_isnull OR ri.ND_foreign_corp_key_isnull => 0,
                        le.ND_foreign_corp_key = ri.ND_foreign_corp_key  => le.ND_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.ND_foreign_corp_key_weight100,s.ND_foreign_corp_key_switch));
  INTEGER2 NM_foreign_corp_key_score_temp := MAP( le.NM_foreign_corp_key_isnull OR ri.NM_foreign_corp_key_isnull => 0,
                        le.NM_foreign_corp_key = ri.NM_foreign_corp_key  => le.NM_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NM_foreign_corp_key_weight100,s.NM_foreign_corp_key_switch));
  INTEGER2 OK_foreign_corp_key_score_temp := MAP( le.OK_foreign_corp_key_isnull OR ri.OK_foreign_corp_key_isnull => 0,
                        le.OK_foreign_corp_key = ri.OK_foreign_corp_key  => le.OK_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.OK_foreign_corp_key_weight100,s.OK_foreign_corp_key_switch));
  INTEGER2 PA_foreign_corp_key_score_temp := MAP( le.PA_foreign_corp_key_isnull OR ri.PA_foreign_corp_key_isnull => 0,
                        le.PA_foreign_corp_key = ri.PA_foreign_corp_key  => le.PA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.PA_foreign_corp_key_weight100,s.PA_foreign_corp_key_switch));
  INTEGER2 SC_foreign_corp_key_score_temp := MAP( le.SC_foreign_corp_key_isnull OR ri.SC_foreign_corp_key_isnull => 0,
                        le.SC_foreign_corp_key = ri.SC_foreign_corp_key  => le.SC_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.SC_foreign_corp_key_weight100,s.SC_foreign_corp_key_switch));
  INTEGER2 SD_foreign_corp_key_score_temp := MAP( le.SD_foreign_corp_key_isnull OR ri.SD_foreign_corp_key_isnull => 0,
                        le.SD_foreign_corp_key = ri.SD_foreign_corp_key  => le.SD_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.SD_foreign_corp_key_weight100,s.SD_foreign_corp_key_switch));
  INTEGER2 TN_foreign_corp_key_score_temp := MAP( le.TN_foreign_corp_key_isnull OR ri.TN_foreign_corp_key_isnull => 0,
                        le.TN_foreign_corp_key = ri.TN_foreign_corp_key  => le.TN_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.TN_foreign_corp_key_weight100,s.TN_foreign_corp_key_switch));
  INTEGER2 VT_foreign_corp_key_score_temp := MAP( le.VT_foreign_corp_key_isnull OR ri.VT_foreign_corp_key_isnull => 0,
                        le.VT_foreign_corp_key = ri.VT_foreign_corp_key  => le.VT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.VT_foreign_corp_key_weight100,s.VT_foreign_corp_key_switch));
  INTEGER2 company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        0 /* switch0 */);
  INTEGER2 domestic_corp_key_score_temp := MAP( le.domestic_corp_key_isnull OR ri.domestic_corp_key_isnull => 0,
                        le.domestic_corp_key = ri.domestic_corp_key  => le.domestic_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.domestic_corp_key_weight100,s.domestic_corp_key_switch));
  INTEGER2 AL_foreign_corp_key_score_temp := MAP( le.AL_foreign_corp_key_isnull OR ri.AL_foreign_corp_key_isnull => 0,
                        le.AL_foreign_corp_key = ri.AL_foreign_corp_key  => le.AL_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AL_foreign_corp_key_weight100,s.AL_foreign_corp_key_switch));
  INTEGER2 FL_foreign_corp_key_score_temp := MAP( le.FL_foreign_corp_key_isnull OR ri.FL_foreign_corp_key_isnull => 0,
                        le.FL_foreign_corp_key = ri.FL_foreign_corp_key  => le.FL_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.FL_foreign_corp_key_weight100,s.FL_foreign_corp_key_switch));
  INTEGER2 GA_foreign_corp_key_score_temp := MAP( le.GA_foreign_corp_key_isnull OR ri.GA_foreign_corp_key_isnull => 0,
                        le.GA_foreign_corp_key = ri.GA_foreign_corp_key  => le.GA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.GA_foreign_corp_key_weight100,s.GA_foreign_corp_key_switch));
  INTEGER2 IL_foreign_corp_key_score_temp := MAP( le.IL_foreign_corp_key_isnull OR ri.IL_foreign_corp_key_isnull => 0,
                        le.IL_foreign_corp_key = ri.IL_foreign_corp_key  => le.IL_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.IL_foreign_corp_key_weight100,s.IL_foreign_corp_key_switch));
  INTEGER2 IN_foreign_corp_key_score_temp := MAP( le.IN_foreign_corp_key_isnull OR ri.IN_foreign_corp_key_isnull => 0,
                        le.IN_foreign_corp_key = ri.IN_foreign_corp_key  => le.IN_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.IN_foreign_corp_key_weight100,s.IN_foreign_corp_key_switch));
  INTEGER2 MS_foreign_corp_key_score_temp := MAP( le.MS_foreign_corp_key_isnull OR ri.MS_foreign_corp_key_isnull => 0,
                        le.MS_foreign_corp_key = ri.MS_foreign_corp_key  => le.MS_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MS_foreign_corp_key_weight100,s.MS_foreign_corp_key_switch));
  INTEGER2 NH_foreign_corp_key_score_temp := MAP( le.NH_foreign_corp_key_isnull OR ri.NH_foreign_corp_key_isnull => 0,
                        le.NH_foreign_corp_key = ri.NH_foreign_corp_key  => le.NH_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NH_foreign_corp_key_weight100,s.NH_foreign_corp_key_switch));
  INTEGER2 NV_foreign_corp_key_score_temp := MAP( le.NV_foreign_corp_key_isnull OR ri.NV_foreign_corp_key_isnull => 0,
                        le.NV_foreign_corp_key = ri.NV_foreign_corp_key  => le.NV_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NV_foreign_corp_key_weight100,s.NV_foreign_corp_key_switch));
  INTEGER2 NY_foreign_corp_key_score_temp := MAP( le.NY_foreign_corp_key_isnull OR ri.NY_foreign_corp_key_isnull => 0,
                        le.NY_foreign_corp_key = ri.NY_foreign_corp_key  => le.NY_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NY_foreign_corp_key_weight100,s.NY_foreign_corp_key_switch));
  INTEGER2 OR_foreign_corp_key_score_temp := MAP( le.OR_foreign_corp_key_isnull OR ri.OR_foreign_corp_key_isnull => 0,
                        le.OR_foreign_corp_key = ri.OR_foreign_corp_key  => le.OR_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.OR_foreign_corp_key_weight100,s.OR_foreign_corp_key_switch));
  INTEGER2 RI_foreign_corp_key_score_temp := MAP( le.RI_foreign_corp_key_isnull OR ri.RI_foreign_corp_key_isnull => 0,
                        le.RI_foreign_corp_key = ri.RI_foreign_corp_key  => le.RI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.RI_foreign_corp_key_weight100,s.RI_foreign_corp_key_switch));
  INTEGER2 UT_foreign_corp_key_score_temp := MAP( le.UT_foreign_corp_key_isnull OR ri.UT_foreign_corp_key_isnull => 0,
                        le.UT_foreign_corp_key = ri.UT_foreign_corp_key  => le.UT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.UT_foreign_corp_key_weight100,s.UT_foreign_corp_key_switch));
  INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT26.WithinEditN(le.company_fein,ri.company_fein,1) => SALT26.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT26.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT26.WithinEditN(le.cnp_name,ri.cnp_name,1) => SALT26.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT26.MatchBagOfWords(le.cnp_name,ri.cnp_name,0,1,1,1,0));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  INTEGER2 AK_foreign_corp_key_score_temp := MAP( le.AK_foreign_corp_key_isnull OR ri.AK_foreign_corp_key_isnull => 0,
                        le.AK_foreign_corp_key = ri.AK_foreign_corp_key  => le.AK_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AK_foreign_corp_key_weight100,s.AK_foreign_corp_key_switch));
  INTEGER2 CT_foreign_corp_key_score_temp := MAP( le.CT_foreign_corp_key_isnull OR ri.CT_foreign_corp_key_isnull => 0,
                        le.CT_foreign_corp_key = ri.CT_foreign_corp_key  => le.CT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.CT_foreign_corp_key_weight100,s.CT_foreign_corp_key_switch));
  INTEGER2 HI_foreign_corp_key_score_temp := MAP( le.HI_foreign_corp_key_isnull OR ri.HI_foreign_corp_key_isnull => 0,
                        le.HI_foreign_corp_key = ri.HI_foreign_corp_key  => le.HI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.HI_foreign_corp_key_weight100,s.HI_foreign_corp_key_switch));
  INTEGER2 IA_foreign_corp_key_score_temp := MAP( le.IA_foreign_corp_key_isnull OR ri.IA_foreign_corp_key_isnull => 0,
                        le.IA_foreign_corp_key = ri.IA_foreign_corp_key  => le.IA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.IA_foreign_corp_key_weight100,s.IA_foreign_corp_key_switch));
  INTEGER2 LA_foreign_corp_key_score_temp := MAP( le.LA_foreign_corp_key_isnull OR ri.LA_foreign_corp_key_isnull => 0,
                        le.LA_foreign_corp_key = ri.LA_foreign_corp_key  => le.LA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.LA_foreign_corp_key_weight100,s.LA_foreign_corp_key_switch));
  INTEGER2 MT_foreign_corp_key_score_temp := MAP( le.MT_foreign_corp_key_isnull OR ri.MT_foreign_corp_key_isnull => 0,
                        le.MT_foreign_corp_key = ri.MT_foreign_corp_key  => le.MT_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.MT_foreign_corp_key_weight100,s.MT_foreign_corp_key_switch));
  INTEGER2 NE_foreign_corp_key_score_temp := MAP( le.NE_foreign_corp_key_isnull OR ri.NE_foreign_corp_key_isnull => 0,
                        le.NE_foreign_corp_key = ri.NE_foreign_corp_key  => le.NE_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.NE_foreign_corp_key_weight100,s.NE_foreign_corp_key_switch));
  INTEGER2 VA_foreign_corp_key_score_temp := MAP( le.VA_foreign_corp_key_isnull OR ri.VA_foreign_corp_key_isnull => 0,
                        le.VA_foreign_corp_key = ri.VA_foreign_corp_key  => le.VA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.VA_foreign_corp_key_weight100,s.VA_foreign_corp_key_switch));
  INTEGER2 AZ_foreign_corp_key_score_temp := MAP( le.AZ_foreign_corp_key_isnull OR ri.AZ_foreign_corp_key_isnull => 0,
                        le.AZ_foreign_corp_key = ri.AZ_foreign_corp_key  => le.AZ_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.AZ_foreign_corp_key_weight100,s.AZ_foreign_corp_key_switch));
  INTEGER2 TX_foreign_corp_key_score_temp := MAP( le.TX_foreign_corp_key_isnull OR ri.TX_foreign_corp_key_isnull => 0,
                        le.TX_foreign_corp_key = ri.TX_foreign_corp_key  => le.TX_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.TX_foreign_corp_key_weight100,s.TX_foreign_corp_key_switch));
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)* company_address_score_scale;
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)* company_address_score_scale;
  INTEGER2 sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        0 /* switch0 */)* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT26.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 cnp_btype_score := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT26.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 iscorp_score := MAP( le.iscorp_isnull OR ri.iscorp_isnull => 0,
                        le.iscorp = ri.iscorp  => le.iscorp_weight100,
                        0 /* switch0 */);
  INTEGER2 DE_foreign_corp_key_score_temp := MAP( le.DE_foreign_corp_key_isnull OR ri.DE_foreign_corp_key_isnull => 0,
                        le.DE_foreign_corp_key = ri.DE_foreign_corp_key  => le.DE_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.DE_foreign_corp_key_weight100,s.DE_foreign_corp_key_switch));
  INTEGER2 ID_foreign_corp_key_score_temp := MAP( le.ID_foreign_corp_key_isnull OR ri.ID_foreign_corp_key_isnull => 0,
                        le.ID_foreign_corp_key = ri.ID_foreign_corp_key  => le.ID_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.ID_foreign_corp_key_weight100,s.ID_foreign_corp_key_switch));
  INTEGER2 OH_foreign_corp_key_score_temp := MAP( le.OH_foreign_corp_key_isnull OR ri.OH_foreign_corp_key_isnull => 0,
                        le.OH_foreign_corp_key = ri.OH_foreign_corp_key  => le.OH_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.OH_foreign_corp_key_weight100,s.OH_foreign_corp_key_switch));
  INTEGER2 PR_foreign_corp_key_score_temp := MAP( le.PR_foreign_corp_key_isnull OR ri.PR_foreign_corp_key_isnull => 0,
                        le.PR_foreign_corp_key = ri.PR_foreign_corp_key  => le.PR_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.PR_foreign_corp_key_weight100,s.PR_foreign_corp_key_switch));
  INTEGER2 VI_foreign_corp_key_score_temp := MAP( le.VI_foreign_corp_key_isnull OR ri.VI_foreign_corp_key_isnull => 0,
                        le.VI_foreign_corp_key = ri.VI_foreign_corp_key  => le.VI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.VI_foreign_corp_key_weight100,s.VI_foreign_corp_key_switch));
  INTEGER2 WA_foreign_corp_key_score_temp := MAP( le.WA_foreign_corp_key_isnull OR ri.WA_foreign_corp_key_isnull => 0,
                        le.WA_foreign_corp_key = ri.WA_foreign_corp_key  => le.WA_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WA_foreign_corp_key_weight100,s.WA_foreign_corp_key_switch));
  INTEGER2 WI_foreign_corp_key_score_temp := MAP( le.WI_foreign_corp_key_isnull OR ri.WI_foreign_corp_key_isnull => 0,
                        le.WI_foreign_corp_key = ri.WI_foreign_corp_key  => le.WI_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WI_foreign_corp_key_weight100,s.WI_foreign_corp_key_switch));
  INTEGER2 WV_foreign_corp_key_score_temp := MAP( le.WV_foreign_corp_key_isnull OR ri.WV_foreign_corp_key_isnull => 0,
                        le.WV_foreign_corp_key = ri.WV_foreign_corp_key  => le.WV_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WV_foreign_corp_key_weight100,s.WV_foreign_corp_key_switch));
  INTEGER2 WY_foreign_corp_key_score_temp := MAP( le.WY_foreign_corp_key_isnull OR ri.WY_foreign_corp_key_isnull => 0,
                        le.WY_foreign_corp_key = ri.WY_foreign_corp_key  => le.WY_foreign_corp_key_weight100,
                        SALT26.Fn_Fail_Scale(le.WY_foreign_corp_key_weight100,s.WY_foreign_corp_key_switch));
  INTEGER2 cnp_number_score := IF ( le.cnp_number = ri.cnp_number or cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 prim_range_score_temp := MAP(                         company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT26.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 prim_name_score_temp := MAP( le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT26.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* company_addr1_score_scale* company_address_score_scale;
  INTEGER2 st_score_temp := MAP( le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT26.Fn_Fail_Scale(le.st_weight100,s.st_switch))* company_csz_score_scale* company_address_score_scale;
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MN_foreign_corp_key_score := IF ( MN_foreign_corp_key_score_temp >= 0, MN_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NJ_foreign_corp_key_score := IF ( NJ_foreign_corp_key_score_temp >= 0, NJ_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter
 
 
  INTEGER2 AR_foreign_corp_key_score := IF ( AR_foreign_corp_key_score_temp >= 0, AR_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 CA_foreign_corp_key_score := IF ( CA_foreign_corp_key_score_temp >= 0, CA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 CO_foreign_corp_key_score := IF ( CO_foreign_corp_key_score_temp >= 0, CO_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 DC_foreign_corp_key_score := IF ( DC_foreign_corp_key_score_temp >= 0, DC_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 KS_foreign_corp_key_score := IF ( KS_foreign_corp_key_score_temp >= 0, KS_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 KY_foreign_corp_key_score := IF ( KY_foreign_corp_key_score_temp >= 0, KY_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MA_foreign_corp_key_score := IF ( MA_foreign_corp_key_score_temp >= 0, MA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MD_foreign_corp_key_score := IF ( MD_foreign_corp_key_score_temp >= 0, MD_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 ME_foreign_corp_key_score := IF ( ME_foreign_corp_key_score_temp >= 0, ME_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MI_foreign_corp_key_score := IF ( MI_foreign_corp_key_score_temp >= 0, MI_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MO_foreign_corp_key_score := IF ( MO_foreign_corp_key_score_temp >= 0, MO_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NC_foreign_corp_key_score := IF ( NC_foreign_corp_key_score_temp >= 0, NC_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 ND_foreign_corp_key_score := IF ( ND_foreign_corp_key_score_temp >= 0, ND_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NM_foreign_corp_key_score := IF ( NM_foreign_corp_key_score_temp >= 0, NM_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 OK_foreign_corp_key_score := IF ( OK_foreign_corp_key_score_temp >= 0, OK_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 PA_foreign_corp_key_score := IF ( PA_foreign_corp_key_score_temp >= 0, PA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 SC_foreign_corp_key_score := IF ( SC_foreign_corp_key_score_temp >= 0, SC_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 SD_foreign_corp_key_score := IF ( SD_foreign_corp_key_score_temp >= 0, SD_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 TN_foreign_corp_key_score := IF ( TN_foreign_corp_key_score_temp >= 0, TN_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 VT_foreign_corp_key_score := IF ( VT_foreign_corp_key_score_temp >= 0, VT_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 domestic_corp_key_score := IF ( domestic_corp_key_score_temp >= 0, domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 AL_foreign_corp_key_score := IF ( AL_foreign_corp_key_score_temp >= 0, AL_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 FL_foreign_corp_key_score := IF ( FL_foreign_corp_key_score_temp >= 0, FL_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 GA_foreign_corp_key_score := IF ( GA_foreign_corp_key_score_temp >= 0, GA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 IL_foreign_corp_key_score := IF ( IL_foreign_corp_key_score_temp >= 0, IL_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 IN_foreign_corp_key_score := IF ( IN_foreign_corp_key_score_temp >= 0, IN_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MS_foreign_corp_key_score := IF ( MS_foreign_corp_key_score_temp >= 0, MS_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NH_foreign_corp_key_score := IF ( NH_foreign_corp_key_score_temp >= 0, NH_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NV_foreign_corp_key_score := IF ( NV_foreign_corp_key_score_temp >= 0, NV_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NY_foreign_corp_key_score := IF ( NY_foreign_corp_key_score_temp >= 0, NY_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 OR_foreign_corp_key_score := IF ( OR_foreign_corp_key_score_temp >= 0, OR_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 RI_foreign_corp_key_score := IF ( RI_foreign_corp_key_score_temp >= 0, RI_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 UT_foreign_corp_key_score := IF ( UT_foreign_corp_key_score_temp >= 0, UT_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= 1300, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 AK_foreign_corp_key_score := IF ( AK_foreign_corp_key_score_temp >= 0, AK_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 CT_foreign_corp_key_score := IF ( CT_foreign_corp_key_score_temp >= 0, CT_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 HI_foreign_corp_key_score := IF ( HI_foreign_corp_key_score_temp >= 0, HI_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 IA_foreign_corp_key_score := IF ( IA_foreign_corp_key_score_temp >= 0, IA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 LA_foreign_corp_key_score := IF ( LA_foreign_corp_key_score_temp >= 0, LA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 MT_foreign_corp_key_score := IF ( MT_foreign_corp_key_score_temp >= 0, MT_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 NE_foreign_corp_key_score := IF ( NE_foreign_corp_key_score_temp >= 0, NE_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 VA_foreign_corp_key_score := IF ( VA_foreign_corp_key_score_temp >= 0, VA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 AZ_foreign_corp_key_score := IF ( AZ_foreign_corp_key_score_temp >= 0, AZ_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 TX_foreign_corp_key_score := IF ( TX_foreign_corp_key_score_temp >= 0, TX_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT26.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* company_csz_score_scale* company_address_score_scale;
 
 
  INTEGER2 DE_foreign_corp_key_score := IF ( DE_foreign_corp_key_score_temp >= 0, DE_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 ID_foreign_corp_key_score := IF ( ID_foreign_corp_key_score_temp >= 0, ID_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 OH_foreign_corp_key_score := IF ( OH_foreign_corp_key_score_temp >= 0, OH_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 PR_foreign_corp_key_score := IF ( PR_foreign_corp_key_score_temp >= 0, PR_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 VI_foreign_corp_key_score := IF ( VI_foreign_corp_key_score_temp >= 0, VI_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 WA_foreign_corp_key_score := IF ( WA_foreign_corp_key_score_temp >= 0, WA_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 WI_foreign_corp_key_score := IF ( WI_foreign_corp_key_score_temp >= 0, WI_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 WV_foreign_corp_key_score := IF ( WV_foreign_corp_key_score_temp >= 0, WV_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 WY_foreign_corp_key_score := IF ( WY_foreign_corp_key_score_temp >= 0, WY_foreign_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 prim_range_score := IF ( le.prim_range = ri.prim_range or prim_range_score_temp >= 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
 
  INTEGER2 st_score := IF ( st_score_temp > 0 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
 
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := MAX(company_addr1_score_pre,0) + prim_range_score + prim_name_score + sec_range_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  INTEGER2 company_addr1_score := company_addr1_score_res;
 
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := MAX(company_csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(company_address_score_pre,0);// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  INTEGER2 company_csz_score := IF ( company_csz_score_ext > -200,company_csz_score_res,SKIP);
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := MAX(company_address_score_pre,0)+ company_addr1_score + prim_range_score + prim_name_score + sec_range_score+ company_csz_score + v_city_name_score + st_score + zip_score;// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  INTEGER2 company_address_score := IF ( company_address_score_ext > 0,company_address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.cnp_number_prop,ri.cnp_number_prop)*cnp_number_score // Score if either field propogated
    +MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*active_enterprise_number_score // Score if either field propogated
    +MAX(le.MN_foreign_corp_key_prop,ri.MN_foreign_corp_key_prop)*MN_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NJ_foreign_corp_key_prop,ri.NJ_foreign_corp_key_prop)*NJ_foreign_corp_key_score // Score if either field propogated
    +MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score // Score if either field propogated
    +MAX(le.hist_enterprise_number_prop,ri.hist_enterprise_number_prop)*hist_enterprise_number_score // Score if either field propogated
    +MAX(le.hist_duns_number_prop,ri.hist_duns_number_prop)*hist_duns_number_score // Score if either field propogated
    +MAX(le.ebr_file_number_prop,ri.ebr_file_number_prop)*ebr_file_number_score // Score if either field propogated
    +MAX(le.AR_foreign_corp_key_prop,ri.AR_foreign_corp_key_prop)*AR_foreign_corp_key_score // Score if either field propogated
    +MAX(le.CA_foreign_corp_key_prop,ri.CA_foreign_corp_key_prop)*CA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.CO_foreign_corp_key_prop,ri.CO_foreign_corp_key_prop)*CO_foreign_corp_key_score // Score if either field propogated
    +MAX(le.DC_foreign_corp_key_prop,ri.DC_foreign_corp_key_prop)*DC_foreign_corp_key_score // Score if either field propogated
    +MAX(le.KS_foreign_corp_key_prop,ri.KS_foreign_corp_key_prop)*KS_foreign_corp_key_score // Score if either field propogated
    +MAX(le.KY_foreign_corp_key_prop,ri.KY_foreign_corp_key_prop)*KY_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MA_foreign_corp_key_prop,ri.MA_foreign_corp_key_prop)*MA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MD_foreign_corp_key_prop,ri.MD_foreign_corp_key_prop)*MD_foreign_corp_key_score // Score if either field propogated
    +MAX(le.ME_foreign_corp_key_prop,ri.ME_foreign_corp_key_prop)*ME_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MI_foreign_corp_key_prop,ri.MI_foreign_corp_key_prop)*MI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MO_foreign_corp_key_prop,ri.MO_foreign_corp_key_prop)*MO_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NC_foreign_corp_key_prop,ri.NC_foreign_corp_key_prop)*NC_foreign_corp_key_score // Score if either field propogated
    +MAX(le.ND_foreign_corp_key_prop,ri.ND_foreign_corp_key_prop)*ND_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NM_foreign_corp_key_prop,ri.NM_foreign_corp_key_prop)*NM_foreign_corp_key_score // Score if either field propogated
    +MAX(le.OK_foreign_corp_key_prop,ri.OK_foreign_corp_key_prop)*OK_foreign_corp_key_score // Score if either field propogated
    +MAX(le.PA_foreign_corp_key_prop,ri.PA_foreign_corp_key_prop)*PA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.SC_foreign_corp_key_prop,ri.SC_foreign_corp_key_prop)*SC_foreign_corp_key_score // Score if either field propogated
    +MAX(le.SD_foreign_corp_key_prop,ri.SD_foreign_corp_key_prop)*SD_foreign_corp_key_score // Score if either field propogated
    +MAX(le.TN_foreign_corp_key_prop,ri.TN_foreign_corp_key_prop)*TN_foreign_corp_key_score // Score if either field propogated
    +MAX(le.VT_foreign_corp_key_prop,ri.VT_foreign_corp_key_prop)*VT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score // Score if either field propogated
    +MAX(le.domestic_corp_key_prop,ri.domestic_corp_key_prop)*domestic_corp_key_score // Score if either field propogated
    +MAX(le.AL_foreign_corp_key_prop,ri.AL_foreign_corp_key_prop)*AL_foreign_corp_key_score // Score if either field propogated
    +MAX(le.FL_foreign_corp_key_prop,ri.FL_foreign_corp_key_prop)*FL_foreign_corp_key_score // Score if either field propogated
    +MAX(le.GA_foreign_corp_key_prop,ri.GA_foreign_corp_key_prop)*GA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.IL_foreign_corp_key_prop,ri.IL_foreign_corp_key_prop)*IL_foreign_corp_key_score // Score if either field propogated
    +MAX(le.IN_foreign_corp_key_prop,ri.IN_foreign_corp_key_prop)*IN_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MS_foreign_corp_key_prop,ri.MS_foreign_corp_key_prop)*MS_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NH_foreign_corp_key_prop,ri.NH_foreign_corp_key_prop)*NH_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NV_foreign_corp_key_prop,ri.NV_foreign_corp_key_prop)*NV_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NY_foreign_corp_key_prop,ri.NY_foreign_corp_key_prop)*NY_foreign_corp_key_score // Score if either field propogated
    +MAX(le.OR_foreign_corp_key_prop,ri.OR_foreign_corp_key_prop)*OR_foreign_corp_key_score // Score if either field propogated
    +MAX(le.RI_foreign_corp_key_prop,ri.RI_foreign_corp_key_prop)*RI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.UT_foreign_corp_key_prop,ri.UT_foreign_corp_key_prop)*UT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
    +if(le.company_address_prop+ri.company_address_prop>0,company_address_score*(0+if(le.company_addr1_prop+ri.company_addr1_prop>0,1,0))/2,0)
    +MAX(le.AK_foreign_corp_key_prop,ri.AK_foreign_corp_key_prop)*AK_foreign_corp_key_score // Score if either field propogated
    +MAX(le.CT_foreign_corp_key_prop,ri.CT_foreign_corp_key_prop)*CT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.HI_foreign_corp_key_prop,ri.HI_foreign_corp_key_prop)*HI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.IA_foreign_corp_key_prop,ri.IA_foreign_corp_key_prop)*IA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.LA_foreign_corp_key_prop,ri.LA_foreign_corp_key_prop)*LA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.MT_foreign_corp_key_prop,ri.MT_foreign_corp_key_prop)*MT_foreign_corp_key_score // Score if either field propogated
    +MAX(le.NE_foreign_corp_key_prop,ri.NE_foreign_corp_key_prop)*NE_foreign_corp_key_score // Score if either field propogated
    +MAX(le.VA_foreign_corp_key_prop,ri.VA_foreign_corp_key_prop)*VA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.AZ_foreign_corp_key_prop,ri.AZ_foreign_corp_key_prop)*AZ_foreign_corp_key_score // Score if either field propogated
    +MAX(le.TX_foreign_corp_key_prop,ri.TX_foreign_corp_key_prop)*TX_foreign_corp_key_score // Score if either field propogated
    +if(le.company_addr1_prop+ri.company_addr1_prop>0,company_addr1_score*(0+if(le.sec_range_prop+ri.sec_range_prop>0,1,0))/3,0)
    +MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score // Score if either field propogated
    +MAX(le.iscorp_prop,ri.iscorp_prop)*iscorp_score // Score if either field propogated
    +MAX(le.DE_foreign_corp_key_prop,ri.DE_foreign_corp_key_prop)*DE_foreign_corp_key_score // Score if either field propogated
    +MAX(le.ID_foreign_corp_key_prop,ri.ID_foreign_corp_key_prop)*ID_foreign_corp_key_score // Score if either field propogated
    +MAX(le.OH_foreign_corp_key_prop,ri.OH_foreign_corp_key_prop)*OH_foreign_corp_key_score // Score if either field propogated
    +MAX(le.PR_foreign_corp_key_prop,ri.PR_foreign_corp_key_prop)*PR_foreign_corp_key_score // Score if either field propogated
    +MAX(le.VI_foreign_corp_key_prop,ri.VI_foreign_corp_key_prop)*VI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WA_foreign_corp_key_prop,ri.WA_foreign_corp_key_prop)*WA_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WI_foreign_corp_key_prop,ri.WI_foreign_corp_key_prop)*WI_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WV_foreign_corp_key_prop,ri.WV_foreign_corp_key_prop)*WV_foreign_corp_key_score // Score if either field propogated
    +MAX(le.WY_foreign_corp_key_prop,ri.WY_foreign_corp_key_prop)*WY_foreign_corp_key_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (cnp_number_score + prim_range_score + prim_name_score + st_score + active_enterprise_number_score + MN_foreign_corp_key_score + NJ_foreign_corp_key_score + active_duns_number_score + hist_enterprise_number_score + hist_duns_number_score + ebr_file_number_score + AR_foreign_corp_key_score + CA_foreign_corp_key_score + CO_foreign_corp_key_score + DC_foreign_corp_key_score + KS_foreign_corp_key_score + KY_foreign_corp_key_score + MA_foreign_corp_key_score + MD_foreign_corp_key_score + ME_foreign_corp_key_score + MI_foreign_corp_key_score + MO_foreign_corp_key_score + NC_foreign_corp_key_score + ND_foreign_corp_key_score + NM_foreign_corp_key_score + OK_foreign_corp_key_score + PA_foreign_corp_key_score + SC_foreign_corp_key_score + SD_foreign_corp_key_score + TN_foreign_corp_key_score + VT_foreign_corp_key_score + company_phone_score + domestic_corp_key_score + AL_foreign_corp_key_score + FL_foreign_corp_key_score + GA_foreign_corp_key_score + IL_foreign_corp_key_score + IN_foreign_corp_key_score + MS_foreign_corp_key_score + NH_foreign_corp_key_score + NV_foreign_corp_key_score + NY_foreign_corp_key_score + OR_foreign_corp_key_score + RI_foreign_corp_key_score + UT_foreign_corp_key_score + company_fein_score + cnp_name_score + company_address_score + AK_foreign_corp_key_score + CT_foreign_corp_key_score + HI_foreign_corp_key_score + IA_foreign_corp_key_score + LA_foreign_corp_key_score + MT_foreign_corp_key_score + NE_foreign_corp_key_score + VA_foreign_corp_key_score + AZ_foreign_corp_key_score + TX_foreign_corp_key_score + company_addr1_score + zip_score + company_csz_score + sec_range_score + v_city_name_score + cnp_btype_score + iscorp_score + DE_foreign_corp_key_score + ID_foreign_corp_key_score + OH_foreign_corp_key_score + PR_foreign_corp_key_score + VI_foreign_corp_key_score + WA_foreign_corp_key_score + WI_foreign_corp_key_score + WV_foreign_corp_key_score + WY_foreign_corp_key_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':cnp_number:prim_range:prim_name:st','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
 
//Fixed fields ->:cnp_number(12):prim_range(13):prim_name(15):st(5)
 
dn0 := h(~prim_name_isnull AND ~st_isnull);
dn0_deduped := dn0(cnp_number_weight100 + prim_range_weight100 + prim_name_weight100 + st_weight100>=500); // Use specificity to flag high-dup counts
dn0_srange := dn0_deduped(sec_range != '');

mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st  AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.MN_foreign_corp_key = right.MN_foreign_corp_key OR left.MN_foreign_corp_key_isnull OR right.MN_foreign_corp_key_isnull ) AND ( left.NJ_foreign_corp_key = right.NJ_foreign_corp_key OR left.NJ_foreign_corp_key_isnull OR right.NJ_foreign_corp_key_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.AR_foreign_corp_key = right.AR_foreign_corp_key OR left.AR_foreign_corp_key_isnull OR right.AR_foreign_corp_key_isnull ) AND ( left.CA_foreign_corp_key = right.CA_foreign_corp_key OR left.CA_foreign_corp_key_isnull OR right.CA_foreign_corp_key_isnull ) AND ( left.CO_foreign_corp_key = right.CO_foreign_corp_key OR left.CO_foreign_corp_key_isnull OR right.CO_foreign_corp_key_isnull ) AND ( left.DC_foreign_corp_key = right.DC_foreign_corp_key OR left.DC_foreign_corp_key_isnull OR right.DC_foreign_corp_key_isnull ) AND ( left.KS_foreign_corp_key = right.KS_foreign_corp_key OR left.KS_foreign_corp_key_isnull OR right.KS_foreign_corp_key_isnull ) AND ( left.KY_foreign_corp_key = right.KY_foreign_corp_key OR left.KY_foreign_corp_key_isnull OR right.KY_foreign_corp_key_isnull ) AND ( left.MA_foreign_corp_key = right.MA_foreign_corp_key OR left.MA_foreign_corp_key_isnull OR right.MA_foreign_corp_key_isnull ) AND ( left.MD_foreign_corp_key = right.MD_foreign_corp_key OR left.MD_foreign_corp_key_isnull OR right.MD_foreign_corp_key_isnull ) AND ( left.ME_foreign_corp_key = right.ME_foreign_corp_key OR left.ME_foreign_corp_key_isnull OR right.ME_foreign_corp_key_isnull ) AND ( left.MI_foreign_corp_key = right.MI_foreign_corp_key OR left.MI_foreign_corp_key_isnull OR right.MI_foreign_corp_key_isnull ) AND ( left.MO_foreign_corp_key = right.MO_foreign_corp_key OR left.MO_foreign_corp_key_isnull OR right.MO_foreign_corp_key_isnull ) AND ( left.NC_foreign_corp_key = right.NC_foreign_corp_key OR left.NC_foreign_corp_key_isnull OR right.NC_foreign_corp_key_isnull ) AND ( left.ND_foreign_corp_key = right.ND_foreign_corp_key OR left.ND_foreign_corp_key_isnull OR right.ND_foreign_corp_key_isnull ) AND ( left.NM_foreign_corp_key = right.NM_foreign_corp_key OR left.NM_foreign_corp_key_isnull OR right.NM_foreign_corp_key_isnull ) AND ( left.OK_foreign_corp_key = right.OK_foreign_corp_key OR left.OK_foreign_corp_key_isnull OR right.OK_foreign_corp_key_isnull ) AND ( left.PA_foreign_corp_key = right.PA_foreign_corp_key OR left.PA_foreign_corp_key_isnull OR right.PA_foreign_corp_key_isnull ) AND ( left.SC_foreign_corp_key = right.SC_foreign_corp_key OR left.SC_foreign_corp_key_isnull OR right.SC_foreign_corp_key_isnull ) AND ( left.SD_foreign_corp_key = right.SD_foreign_corp_key OR left.SD_foreign_corp_key_isnull OR right.SD_foreign_corp_key_isnull ) AND ( left.TN_foreign_corp_key = right.TN_foreign_corp_key OR left.TN_foreign_corp_key_isnull OR right.TN_foreign_corp_key_isnull ) AND ( left.VT_foreign_corp_key = right.VT_foreign_corp_key OR left.VT_foreign_corp_key_isnull OR right.VT_foreign_corp_key_isnull ) AND ( left.domestic_corp_key = right.domestic_corp_key OR left.domestic_corp_key_isnull OR right.domestic_corp_key_isnull ) AND ( left.AL_foreign_corp_key = right.AL_foreign_corp_key OR left.AL_foreign_corp_key_isnull OR right.AL_foreign_corp_key_isnull ) AND ( left.FL_foreign_corp_key = right.FL_foreign_corp_key OR left.FL_foreign_corp_key_isnull OR right.FL_foreign_corp_key_isnull ) AND ( left.GA_foreign_corp_key = right.GA_foreign_corp_key OR left.GA_foreign_corp_key_isnull OR right.GA_foreign_corp_key_isnull ) AND ( left.IL_foreign_corp_key = right.IL_foreign_corp_key OR left.IL_foreign_corp_key_isnull OR right.IL_foreign_corp_key_isnull ) AND ( left.IN_foreign_corp_key = right.IN_foreign_corp_key OR left.IN_foreign_corp_key_isnull OR right.IN_foreign_corp_key_isnull ) AND ( left.MS_foreign_corp_key = right.MS_foreign_corp_key OR left.MS_foreign_corp_key_isnull OR right.MS_foreign_corp_key_isnull ) AND ( left.NH_foreign_corp_key = right.NH_foreign_corp_key OR left.NH_foreign_corp_key_isnull OR right.NH_foreign_corp_key_isnull ) AND ( left.NV_foreign_corp_key = right.NV_foreign_corp_key OR left.NV_foreign_corp_key_isnull OR right.NV_foreign_corp_key_isnull ) AND ( left.NY_foreign_corp_key = right.NY_foreign_corp_key OR left.NY_foreign_corp_key_isnull OR right.NY_foreign_corp_key_isnull ) AND ( left.OR_foreign_corp_key = right.OR_foreign_corp_key OR left.OR_foreign_corp_key_isnull OR right.OR_foreign_corp_key_isnull ) AND ( left.RI_foreign_corp_key = right.RI_foreign_corp_key OR left.RI_foreign_corp_key_isnull OR right.RI_foreign_corp_key_isnull ) AND ( left.UT_foreign_corp_key = right.UT_foreign_corp_key OR left.UT_foreign_corp_key_isnull OR right.UT_foreign_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ( left.AK_foreign_corp_key = right.AK_foreign_corp_key OR left.AK_foreign_corp_key_isnull OR right.AK_foreign_corp_key_isnull ) AND ( left.CT_foreign_corp_key = right.CT_foreign_corp_key OR left.CT_foreign_corp_key_isnull OR right.CT_foreign_corp_key_isnull ) AND ( left.HI_foreign_corp_key = right.HI_foreign_corp_key OR left.HI_foreign_corp_key_isnull OR right.HI_foreign_corp_key_isnull ) AND ( left.IA_foreign_corp_key = right.IA_foreign_corp_key OR left.IA_foreign_corp_key_isnull OR right.IA_foreign_corp_key_isnull ) AND ( left.LA_foreign_corp_key = right.LA_foreign_corp_key OR left.LA_foreign_corp_key_isnull OR right.LA_foreign_corp_key_isnull ) AND ( left.MT_foreign_corp_key = right.MT_foreign_corp_key OR left.MT_foreign_corp_key_isnull OR right.MT_foreign_corp_key_isnull ) AND ( left.NE_foreign_corp_key = right.NE_foreign_corp_key OR left.NE_foreign_corp_key_isnull OR right.NE_foreign_corp_key_isnull ) AND ( left.VA_foreign_corp_key = right.VA_foreign_corp_key OR left.VA_foreign_corp_key_isnull OR right.VA_foreign_corp_key_isnull ) AND ( left.AZ_foreign_corp_key = right.AZ_foreign_corp_key OR left.AZ_foreign_corp_key_isnull OR right.AZ_foreign_corp_key_isnull ) AND ( left.TX_foreign_corp_key = right.TX_foreign_corp_key OR left.TX_foreign_corp_key_isnull OR right.TX_foreign_corp_key_isnull ) AND ( left.DE_foreign_corp_key = right.DE_foreign_corp_key OR left.DE_foreign_corp_key_isnull OR right.DE_foreign_corp_key_isnull ) AND ( left.ID_foreign_corp_key = right.ID_foreign_corp_key OR left.ID_foreign_corp_key_isnull OR right.ID_foreign_corp_key_isnull ) AND ( left.OH_foreign_corp_key = right.OH_foreign_corp_key OR left.OH_foreign_corp_key_isnull OR right.OH_foreign_corp_key_isnull ) AND ( left.PR_foreign_corp_key = right.PR_foreign_corp_key OR left.PR_foreign_corp_key_isnull OR right.PR_foreign_corp_key_isnull ) AND ( left.VI_foreign_corp_key = right.VI_foreign_corp_key OR left.VI_foreign_corp_key_isnull OR right.VI_foreign_corp_key_isnull ) AND ( left.WA_foreign_corp_key = right.WA_foreign_corp_key OR left.WA_foreign_corp_key_isnull OR right.WA_foreign_corp_key_isnull ) AND ( left.WI_foreign_corp_key = right.WI_foreign_corp_key OR left.WI_foreign_corp_key_isnull OR right.WI_foreign_corp_key_isnull ) AND ( left.WV_foreign_corp_key = right.WV_foreign_corp_key OR left.WV_foreign_corp_key_isnull OR right.WV_foreign_corp_key_isnull ) AND ( left.WY_foreign_corp_key = right.WY_foreign_corp_key OR left.WY_foreign_corp_key_isnull OR right.WY_foreign_corp_key_isnull ),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st,20000),SKEW(1));
mj1 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4] AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.MN_foreign_corp_key = right.MN_foreign_corp_key OR left.MN_foreign_corp_key_isnull OR right.MN_foreign_corp_key_isnull ) AND ( left.NJ_foreign_corp_key = right.NJ_foreign_corp_key OR left.NJ_foreign_corp_key_isnull OR right.NJ_foreign_corp_key_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.AR_foreign_corp_key = right.AR_foreign_corp_key OR left.AR_foreign_corp_key_isnull OR right.AR_foreign_corp_key_isnull ) AND ( left.CA_foreign_corp_key = right.CA_foreign_corp_key OR left.CA_foreign_corp_key_isnull OR right.CA_foreign_corp_key_isnull ) AND ( left.CO_foreign_corp_key = right.CO_foreign_corp_key OR left.CO_foreign_corp_key_isnull OR right.CO_foreign_corp_key_isnull ) AND ( left.DC_foreign_corp_key = right.DC_foreign_corp_key OR left.DC_foreign_corp_key_isnull OR right.DC_foreign_corp_key_isnull ) AND ( left.KS_foreign_corp_key = right.KS_foreign_corp_key OR left.KS_foreign_corp_key_isnull OR right.KS_foreign_corp_key_isnull ) AND ( left.KY_foreign_corp_key = right.KY_foreign_corp_key OR left.KY_foreign_corp_key_isnull OR right.KY_foreign_corp_key_isnull ) AND ( left.MA_foreign_corp_key = right.MA_foreign_corp_key OR left.MA_foreign_corp_key_isnull OR right.MA_foreign_corp_key_isnull ) AND ( left.MD_foreign_corp_key = right.MD_foreign_corp_key OR left.MD_foreign_corp_key_isnull OR right.MD_foreign_corp_key_isnull ) AND ( left.ME_foreign_corp_key = right.ME_foreign_corp_key OR left.ME_foreign_corp_key_isnull OR right.ME_foreign_corp_key_isnull ) AND ( left.MI_foreign_corp_key = right.MI_foreign_corp_key OR left.MI_foreign_corp_key_isnull OR right.MI_foreign_corp_key_isnull ) AND ( left.MO_foreign_corp_key = right.MO_foreign_corp_key OR left.MO_foreign_corp_key_isnull OR right.MO_foreign_corp_key_isnull ) AND ( left.NC_foreign_corp_key = right.NC_foreign_corp_key OR left.NC_foreign_corp_key_isnull OR right.NC_foreign_corp_key_isnull ) AND ( left.ND_foreign_corp_key = right.ND_foreign_corp_key OR left.ND_foreign_corp_key_isnull OR right.ND_foreign_corp_key_isnull ) AND ( left.NM_foreign_corp_key = right.NM_foreign_corp_key OR left.NM_foreign_corp_key_isnull OR right.NM_foreign_corp_key_isnull ) AND ( left.OK_foreign_corp_key = right.OK_foreign_corp_key OR left.OK_foreign_corp_key_isnull OR right.OK_foreign_corp_key_isnull ) AND ( left.PA_foreign_corp_key = right.PA_foreign_corp_key OR left.PA_foreign_corp_key_isnull OR right.PA_foreign_corp_key_isnull ) AND ( left.SC_foreign_corp_key = right.SC_foreign_corp_key OR left.SC_foreign_corp_key_isnull OR right.SC_foreign_corp_key_isnull ) AND ( left.SD_foreign_corp_key = right.SD_foreign_corp_key OR left.SD_foreign_corp_key_isnull OR right.SD_foreign_corp_key_isnull ) AND ( left.TN_foreign_corp_key = right.TN_foreign_corp_key OR left.TN_foreign_corp_key_isnull OR right.TN_foreign_corp_key_isnull ) AND ( left.VT_foreign_corp_key = right.VT_foreign_corp_key OR left.VT_foreign_corp_key_isnull OR right.VT_foreign_corp_key_isnull ) AND ( left.domestic_corp_key = right.domestic_corp_key OR left.domestic_corp_key_isnull OR right.domestic_corp_key_isnull ) AND ( left.AL_foreign_corp_key = right.AL_foreign_corp_key OR left.AL_foreign_corp_key_isnull OR right.AL_foreign_corp_key_isnull ) AND ( left.FL_foreign_corp_key = right.FL_foreign_corp_key OR left.FL_foreign_corp_key_isnull OR right.FL_foreign_corp_key_isnull ) AND ( left.GA_foreign_corp_key = right.GA_foreign_corp_key OR left.GA_foreign_corp_key_isnull OR right.GA_foreign_corp_key_isnull ) AND ( left.IL_foreign_corp_key = right.IL_foreign_corp_key OR left.IL_foreign_corp_key_isnull OR right.IL_foreign_corp_key_isnull ) AND ( left.IN_foreign_corp_key = right.IN_foreign_corp_key OR left.IN_foreign_corp_key_isnull OR right.IN_foreign_corp_key_isnull ) AND ( left.MS_foreign_corp_key = right.MS_foreign_corp_key OR left.MS_foreign_corp_key_isnull OR right.MS_foreign_corp_key_isnull ) AND ( left.NH_foreign_corp_key = right.NH_foreign_corp_key OR left.NH_foreign_corp_key_isnull OR right.NH_foreign_corp_key_isnull ) AND ( left.NV_foreign_corp_key = right.NV_foreign_corp_key OR left.NV_foreign_corp_key_isnull OR right.NV_foreign_corp_key_isnull ) AND ( left.NY_foreign_corp_key = right.NY_foreign_corp_key OR left.NY_foreign_corp_key_isnull OR right.NY_foreign_corp_key_isnull ) AND ( left.OR_foreign_corp_key = right.OR_foreign_corp_key OR left.OR_foreign_corp_key_isnull OR right.OR_foreign_corp_key_isnull ) AND ( left.RI_foreign_corp_key = right.RI_foreign_corp_key OR left.RI_foreign_corp_key_isnull OR right.RI_foreign_corp_key_isnull ) AND ( left.UT_foreign_corp_key = right.UT_foreign_corp_key OR left.UT_foreign_corp_key_isnull OR right.UT_foreign_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ( left.AK_foreign_corp_key = right.AK_foreign_corp_key OR left.AK_foreign_corp_key_isnull OR right.AK_foreign_corp_key_isnull ) AND ( left.CT_foreign_corp_key = right.CT_foreign_corp_key OR left.CT_foreign_corp_key_isnull OR right.CT_foreign_corp_key_isnull ) AND ( left.HI_foreign_corp_key = right.HI_foreign_corp_key OR left.HI_foreign_corp_key_isnull OR right.HI_foreign_corp_key_isnull ) AND ( left.IA_foreign_corp_key = right.IA_foreign_corp_key OR left.IA_foreign_corp_key_isnull OR right.IA_foreign_corp_key_isnull ) AND ( left.LA_foreign_corp_key = right.LA_foreign_corp_key OR left.LA_foreign_corp_key_isnull OR right.LA_foreign_corp_key_isnull ) AND ( left.MT_foreign_corp_key = right.MT_foreign_corp_key OR left.MT_foreign_corp_key_isnull OR right.MT_foreign_corp_key_isnull ) AND ( left.NE_foreign_corp_key = right.NE_foreign_corp_key OR left.NE_foreign_corp_key_isnull OR right.NE_foreign_corp_key_isnull ) AND ( left.VA_foreign_corp_key = right.VA_foreign_corp_key OR left.VA_foreign_corp_key_isnull OR right.VA_foreign_corp_key_isnull ) AND ( left.AZ_foreign_corp_key = right.AZ_foreign_corp_key OR left.AZ_foreign_corp_key_isnull OR right.AZ_foreign_corp_key_isnull ) AND ( left.TX_foreign_corp_key = right.TX_foreign_corp_key OR left.TX_foreign_corp_key_isnull OR right.TX_foreign_corp_key_isnull ) AND ( left.DE_foreign_corp_key = right.DE_foreign_corp_key OR left.DE_foreign_corp_key_isnull OR right.DE_foreign_corp_key_isnull ) AND ( left.ID_foreign_corp_key = right.ID_foreign_corp_key OR left.ID_foreign_corp_key_isnull OR right.ID_foreign_corp_key_isnull ) AND ( left.OH_foreign_corp_key = right.OH_foreign_corp_key OR left.OH_foreign_corp_key_isnull OR right.OH_foreign_corp_key_isnull ) AND ( left.PR_foreign_corp_key = right.PR_foreign_corp_key OR left.PR_foreign_corp_key_isnull OR right.PR_foreign_corp_key_isnull ) AND ( left.VI_foreign_corp_key = right.VI_foreign_corp_key OR left.VI_foreign_corp_key_isnull OR right.VI_foreign_corp_key_isnull ) AND ( left.WA_foreign_corp_key = right.WA_foreign_corp_key OR left.WA_foreign_corp_key_isnull OR right.WA_foreign_corp_key_isnull ) AND ( left.WI_foreign_corp_key = right.WI_foreign_corp_key OR left.WI_foreign_corp_key_isnull OR right.WI_foreign_corp_key_isnull ) AND ( left.WV_foreign_corp_key = right.WV_foreign_corp_key OR left.WV_foreign_corp_key_isnull OR right.WV_foreign_corp_key_isnull ) AND ( left.WY_foreign_corp_key = right.WY_foreign_corp_key OR left.WY_foreign_corp_key_isnull OR right.WY_foreign_corp_key_isnull ),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4],20000),SKEW(1));
mj2 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.sec_range = RIGHT.sec_range AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.MN_foreign_corp_key = right.MN_foreign_corp_key OR left.MN_foreign_corp_key_isnull OR right.MN_foreign_corp_key_isnull ) AND ( left.NJ_foreign_corp_key = right.NJ_foreign_corp_key OR left.NJ_foreign_corp_key_isnull OR right.NJ_foreign_corp_key_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.AR_foreign_corp_key = right.AR_foreign_corp_key OR left.AR_foreign_corp_key_isnull OR right.AR_foreign_corp_key_isnull ) AND ( left.CA_foreign_corp_key = right.CA_foreign_corp_key OR left.CA_foreign_corp_key_isnull OR right.CA_foreign_corp_key_isnull ) AND ( left.CO_foreign_corp_key = right.CO_foreign_corp_key OR left.CO_foreign_corp_key_isnull OR right.CO_foreign_corp_key_isnull ) AND ( left.DC_foreign_corp_key = right.DC_foreign_corp_key OR left.DC_foreign_corp_key_isnull OR right.DC_foreign_corp_key_isnull ) AND ( left.KS_foreign_corp_key = right.KS_foreign_corp_key OR left.KS_foreign_corp_key_isnull OR right.KS_foreign_corp_key_isnull ) AND ( left.KY_foreign_corp_key = right.KY_foreign_corp_key OR left.KY_foreign_corp_key_isnull OR right.KY_foreign_corp_key_isnull ) AND ( left.MA_foreign_corp_key = right.MA_foreign_corp_key OR left.MA_foreign_corp_key_isnull OR right.MA_foreign_corp_key_isnull ) AND ( left.MD_foreign_corp_key = right.MD_foreign_corp_key OR left.MD_foreign_corp_key_isnull OR right.MD_foreign_corp_key_isnull ) AND ( left.ME_foreign_corp_key = right.ME_foreign_corp_key OR left.ME_foreign_corp_key_isnull OR right.ME_foreign_corp_key_isnull ) AND ( left.MI_foreign_corp_key = right.MI_foreign_corp_key OR left.MI_foreign_corp_key_isnull OR right.MI_foreign_corp_key_isnull ) AND ( left.MO_foreign_corp_key = right.MO_foreign_corp_key OR left.MO_foreign_corp_key_isnull OR right.MO_foreign_corp_key_isnull ) AND ( left.NC_foreign_corp_key = right.NC_foreign_corp_key OR left.NC_foreign_corp_key_isnull OR right.NC_foreign_corp_key_isnull ) AND ( left.ND_foreign_corp_key = right.ND_foreign_corp_key OR left.ND_foreign_corp_key_isnull OR right.ND_foreign_corp_key_isnull ) AND ( left.NM_foreign_corp_key = right.NM_foreign_corp_key OR left.NM_foreign_corp_key_isnull OR right.NM_foreign_corp_key_isnull ) AND ( left.OK_foreign_corp_key = right.OK_foreign_corp_key OR left.OK_foreign_corp_key_isnull OR right.OK_foreign_corp_key_isnull ) AND ( left.PA_foreign_corp_key = right.PA_foreign_corp_key OR left.PA_foreign_corp_key_isnull OR right.PA_foreign_corp_key_isnull ) AND ( left.SC_foreign_corp_key = right.SC_foreign_corp_key OR left.SC_foreign_corp_key_isnull OR right.SC_foreign_corp_key_isnull ) AND ( left.SD_foreign_corp_key = right.SD_foreign_corp_key OR left.SD_foreign_corp_key_isnull OR right.SD_foreign_corp_key_isnull ) AND ( left.TN_foreign_corp_key = right.TN_foreign_corp_key OR left.TN_foreign_corp_key_isnull OR right.TN_foreign_corp_key_isnull ) AND ( left.VT_foreign_corp_key = right.VT_foreign_corp_key OR left.VT_foreign_corp_key_isnull OR right.VT_foreign_corp_key_isnull ) AND ( left.domestic_corp_key = right.domestic_corp_key OR left.domestic_corp_key_isnull OR right.domestic_corp_key_isnull ) AND ( left.AL_foreign_corp_key = right.AL_foreign_corp_key OR left.AL_foreign_corp_key_isnull OR right.AL_foreign_corp_key_isnull ) AND ( left.FL_foreign_corp_key = right.FL_foreign_corp_key OR left.FL_foreign_corp_key_isnull OR right.FL_foreign_corp_key_isnull ) AND ( left.GA_foreign_corp_key = right.GA_foreign_corp_key OR left.GA_foreign_corp_key_isnull OR right.GA_foreign_corp_key_isnull ) AND ( left.IL_foreign_corp_key = right.IL_foreign_corp_key OR left.IL_foreign_corp_key_isnull OR right.IL_foreign_corp_key_isnull ) AND ( left.IN_foreign_corp_key = right.IN_foreign_corp_key OR left.IN_foreign_corp_key_isnull OR right.IN_foreign_corp_key_isnull ) AND ( left.MS_foreign_corp_key = right.MS_foreign_corp_key OR left.MS_foreign_corp_key_isnull OR right.MS_foreign_corp_key_isnull ) AND ( left.NH_foreign_corp_key = right.NH_foreign_corp_key OR left.NH_foreign_corp_key_isnull OR right.NH_foreign_corp_key_isnull ) AND ( left.NV_foreign_corp_key = right.NV_foreign_corp_key OR left.NV_foreign_corp_key_isnull OR right.NV_foreign_corp_key_isnull ) AND ( left.NY_foreign_corp_key = right.NY_foreign_corp_key OR left.NY_foreign_corp_key_isnull OR right.NY_foreign_corp_key_isnull ) AND ( left.OR_foreign_corp_key = right.OR_foreign_corp_key OR left.OR_foreign_corp_key_isnull OR right.OR_foreign_corp_key_isnull ) AND ( left.RI_foreign_corp_key = right.RI_foreign_corp_key OR left.RI_foreign_corp_key_isnull OR right.RI_foreign_corp_key_isnull ) AND ( left.UT_foreign_corp_key = right.UT_foreign_corp_key OR left.UT_foreign_corp_key_isnull OR right.UT_foreign_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ( left.AK_foreign_corp_key = right.AK_foreign_corp_key OR left.AK_foreign_corp_key_isnull OR right.AK_foreign_corp_key_isnull ) AND ( left.CT_foreign_corp_key = right.CT_foreign_corp_key OR left.CT_foreign_corp_key_isnull OR right.CT_foreign_corp_key_isnull ) AND ( left.HI_foreign_corp_key = right.HI_foreign_corp_key OR left.HI_foreign_corp_key_isnull OR right.HI_foreign_corp_key_isnull ) AND ( left.IA_foreign_corp_key = right.IA_foreign_corp_key OR left.IA_foreign_corp_key_isnull OR right.IA_foreign_corp_key_isnull ) AND ( left.LA_foreign_corp_key = right.LA_foreign_corp_key OR left.LA_foreign_corp_key_isnull OR right.LA_foreign_corp_key_isnull ) AND ( left.MT_foreign_corp_key = right.MT_foreign_corp_key OR left.MT_foreign_corp_key_isnull OR right.MT_foreign_corp_key_isnull ) AND ( left.NE_foreign_corp_key = right.NE_foreign_corp_key OR left.NE_foreign_corp_key_isnull OR right.NE_foreign_corp_key_isnull ) AND ( left.VA_foreign_corp_key = right.VA_foreign_corp_key OR left.VA_foreign_corp_key_isnull OR right.VA_foreign_corp_key_isnull ) AND ( left.AZ_foreign_corp_key = right.AZ_foreign_corp_key OR left.AZ_foreign_corp_key_isnull OR right.AZ_foreign_corp_key_isnull ) AND ( left.TX_foreign_corp_key = right.TX_foreign_corp_key OR left.TX_foreign_corp_key_isnull OR right.TX_foreign_corp_key_isnull ) AND ( left.DE_foreign_corp_key = right.DE_foreign_corp_key OR left.DE_foreign_corp_key_isnull OR right.DE_foreign_corp_key_isnull ) AND ( left.ID_foreign_corp_key = right.ID_foreign_corp_key OR left.ID_foreign_corp_key_isnull OR right.ID_foreign_corp_key_isnull ) AND ( left.OH_foreign_corp_key = right.OH_foreign_corp_key OR left.OH_foreign_corp_key_isnull OR right.OH_foreign_corp_key_isnull ) AND ( left.PR_foreign_corp_key = right.PR_foreign_corp_key OR left.PR_foreign_corp_key_isnull OR right.PR_foreign_corp_key_isnull ) AND ( left.VI_foreign_corp_key = right.VI_foreign_corp_key OR left.VI_foreign_corp_key_isnull OR right.VI_foreign_corp_key_isnull ) AND ( left.WA_foreign_corp_key = right.WA_foreign_corp_key OR left.WA_foreign_corp_key_isnull OR right.WA_foreign_corp_key_isnull ) AND ( left.WI_foreign_corp_key = right.WI_foreign_corp_key OR left.WI_foreign_corp_key_isnull OR right.WI_foreign_corp_key_isnull ) AND ( left.WV_foreign_corp_key = right.WV_foreign_corp_key OR left.WV_foreign_corp_key_isnull OR right.WV_foreign_corp_key_isnull ) AND ( left.WY_foreign_corp_key = right.WY_foreign_corp_key OR left.WY_foreign_corp_key_isnull OR right.WY_foreign_corp_key_isnull ),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.sec_range = RIGHT.sec_range,20000),SKEW(1));

last_mjs_t :=mj0 + mj1 + mj2;

SALT26.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs := o;
export All_Matches := all_mjs : persist('temp::BIPV2_ProxID_dev3_Proxid_DOT_Base_all_m'); // To by used by rcid and Proxid
SALT26.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::BIPV2_ProxID_dev3_Proxid_DOT_Base_mt');
SALT26.mac_get_BestPerRecord( All_Matches,rcid1,Proxid1,rcid2,Proxid2,o );
EXPORT BestPerRecord := o : PERSIST('temp::BIPV2_ProxID_dev3_Proxid_DOT_Base_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // Proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.Proxid=RIGHT.Proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL);
SALT26.mac_cluster_breadth(in_matches,rcid1,rcid2,Proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.Proxid1=RIGHT.Proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('temp::BIPV2_ProxID_dev3_Proxid_DOT_Base_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT26.UIDType rcid;  //Outcast
  SALT26.UIDType Proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT26.UIDType Pref_rcid; // Prefers this record
  SALT26.UIDType Pref_Proxid; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rcid := le.rcid1;
  self.Proxid := le.Proxid1;
  self.Closest := le.Closest;
  self.Pref_rcid := ri.rcid2;
  self.Pref_Proxid := ri.Proxid2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.Proxid=RIGHT.Proxid1 AND LEFT.Pref_Proxid=RIGHT.Proxid2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.Proxid=RIGHT.Proxid2 AND LEFT.Pref_Proxid=RIGHT.Proxid1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(Proxid)),Proxid,-Pref_Margin,LOCAL),Proxid,LOCAL); // 1024x better in new place
SALT26.MAC_Avoid_SliceOuts(PossibleMatches,Proxid1,Proxid2,Proxid,Pref_Proxid,ToSlice,m); // If Proxid is slice target - don't use in match
EXPORT Matches := m(Conf>=MatchThreshold);
 
//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SALT26.MAC_SliceOut_ByRID(ih,rcid,Proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
EXPORT Patched_Infile := o;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,Proxid,Matches,Proxid1,Proxid2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreClusters := hygiene(ih).ClusterCounts;
EXPORT PostClusters := hygiene(Patched_Infile).ClusterCounts;
EXPORT PrePatchIdCount := SUM( PreClusters, NumberOfClusters );
EXPORT PostPatchIdCount := SUM( PostClusters, NumberOfClusters );
EXPORT PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,rcid,ALL)); // Should be zero
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(Proxid=rcid)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(Proxid>rcid)); // Should be zero
END;
