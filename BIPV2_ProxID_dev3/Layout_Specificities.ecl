IMPORT SALT26;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_DOT_Base;
export cnp_name_ChildRec := record
  typeof(l.cnp_name) cnp_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_number_ChildRec := record
  typeof(l.cnp_number) cnp_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export cnp_btype_ChildRec := record
  typeof(l.cnp_btype) cnp_btype;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_fein_ChildRec := record
  typeof(l.company_fein) company_fein;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_phone_ChildRec := record
  typeof(l.company_phone) company_phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export iscorp_ChildRec := record
  typeof(l.iscorp) iscorp;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_range_ChildRec := record
  typeof(l.prim_range) prim_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export prim_name_ChildRec := record
  typeof(l.prim_name) prim_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export sec_range_ChildRec := record
  typeof(l.sec_range) sec_range;
  unsigned8 cnt;
  unsigned4 id;
end;
export v_city_name_ChildRec := record
  typeof(l.v_city_name) v_city_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export st_ChildRec := record
  typeof(l.st) st;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_csz_ChildRec := record
  UNSIGNED4 company_csz;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_addr1_ChildRec := record
  UNSIGNED4 company_addr1;
  unsigned8 cnt;
  unsigned4 id;
end;
export company_address_ChildRec := record
  UNSIGNED4 company_address;
  unsigned8 cnt;
  unsigned4 id;
end;
export active_duns_number_ChildRec := record
  typeof(l.active_duns_number) active_duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export active_enterprise_number_ChildRec := record
  typeof(l.active_enterprise_number) active_enterprise_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export hist_enterprise_number_ChildRec := record
  typeof(l.hist_enterprise_number) hist_enterprise_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export hist_duns_number_ChildRec := record
  typeof(l.hist_duns_number) hist_duns_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export ebr_file_number_ChildRec := record
  typeof(l.ebr_file_number) ebr_file_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export domestic_corp_key_ChildRec := record
  typeof(l.domestic_corp_key) domestic_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export AK_foreign_corp_key_ChildRec := record
  typeof(l.AK_foreign_corp_key) AK_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export AL_foreign_corp_key_ChildRec := record
  typeof(l.AL_foreign_corp_key) AL_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export AR_foreign_corp_key_ChildRec := record
  typeof(l.AR_foreign_corp_key) AR_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export AZ_foreign_corp_key_ChildRec := record
  typeof(l.AZ_foreign_corp_key) AZ_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export CA_foreign_corp_key_ChildRec := record
  typeof(l.CA_foreign_corp_key) CA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export CO_foreign_corp_key_ChildRec := record
  typeof(l.CO_foreign_corp_key) CO_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export CT_foreign_corp_key_ChildRec := record
  typeof(l.CT_foreign_corp_key) CT_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export DC_foreign_corp_key_ChildRec := record
  typeof(l.DC_foreign_corp_key) DC_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export DE_foreign_corp_key_ChildRec := record
  typeof(l.DE_foreign_corp_key) DE_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export FL_foreign_corp_key_ChildRec := record
  typeof(l.FL_foreign_corp_key) FL_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export GA_foreign_corp_key_ChildRec := record
  typeof(l.GA_foreign_corp_key) GA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export HI_foreign_corp_key_ChildRec := record
  typeof(l.HI_foreign_corp_key) HI_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export IA_foreign_corp_key_ChildRec := record
  typeof(l.IA_foreign_corp_key) IA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export ID_foreign_corp_key_ChildRec := record
  typeof(l.ID_foreign_corp_key) ID_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export IL_foreign_corp_key_ChildRec := record
  typeof(l.IL_foreign_corp_key) IL_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export IN_foreign_corp_key_ChildRec := record
  typeof(l.IN_foreign_corp_key) IN_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export KS_foreign_corp_key_ChildRec := record
  typeof(l.KS_foreign_corp_key) KS_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export KY_foreign_corp_key_ChildRec := record
  typeof(l.KY_foreign_corp_key) KY_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export LA_foreign_corp_key_ChildRec := record
  typeof(l.LA_foreign_corp_key) LA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MA_foreign_corp_key_ChildRec := record
  typeof(l.MA_foreign_corp_key) MA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MD_foreign_corp_key_ChildRec := record
  typeof(l.MD_foreign_corp_key) MD_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export ME_foreign_corp_key_ChildRec := record
  typeof(l.ME_foreign_corp_key) ME_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MI_foreign_corp_key_ChildRec := record
  typeof(l.MI_foreign_corp_key) MI_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MN_foreign_corp_key_ChildRec := record
  typeof(l.MN_foreign_corp_key) MN_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MO_foreign_corp_key_ChildRec := record
  typeof(l.MO_foreign_corp_key) MO_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MS_foreign_corp_key_ChildRec := record
  typeof(l.MS_foreign_corp_key) MS_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export MT_foreign_corp_key_ChildRec := record
  typeof(l.MT_foreign_corp_key) MT_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NC_foreign_corp_key_ChildRec := record
  typeof(l.NC_foreign_corp_key) NC_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export ND_foreign_corp_key_ChildRec := record
  typeof(l.ND_foreign_corp_key) ND_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NE_foreign_corp_key_ChildRec := record
  typeof(l.NE_foreign_corp_key) NE_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NH_foreign_corp_key_ChildRec := record
  typeof(l.NH_foreign_corp_key) NH_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NJ_foreign_corp_key_ChildRec := record
  typeof(l.NJ_foreign_corp_key) NJ_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NM_foreign_corp_key_ChildRec := record
  typeof(l.NM_foreign_corp_key) NM_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NV_foreign_corp_key_ChildRec := record
  typeof(l.NV_foreign_corp_key) NV_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export NY_foreign_corp_key_ChildRec := record
  typeof(l.NY_foreign_corp_key) NY_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export OH_foreign_corp_key_ChildRec := record
  typeof(l.OH_foreign_corp_key) OH_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export OK_foreign_corp_key_ChildRec := record
  typeof(l.OK_foreign_corp_key) OK_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export OR_foreign_corp_key_ChildRec := record
  typeof(l.OR_foreign_corp_key) OR_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export PA_foreign_corp_key_ChildRec := record
  typeof(l.PA_foreign_corp_key) PA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export PR_foreign_corp_key_ChildRec := record
  typeof(l.PR_foreign_corp_key) PR_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export RI_foreign_corp_key_ChildRec := record
  typeof(l.RI_foreign_corp_key) RI_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export SC_foreign_corp_key_ChildRec := record
  typeof(l.SC_foreign_corp_key) SC_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export SD_foreign_corp_key_ChildRec := record
  typeof(l.SD_foreign_corp_key) SD_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export TN_foreign_corp_key_ChildRec := record
  typeof(l.TN_foreign_corp_key) TN_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export TX_foreign_corp_key_ChildRec := record
  typeof(l.TX_foreign_corp_key) TX_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export UT_foreign_corp_key_ChildRec := record
  typeof(l.UT_foreign_corp_key) UT_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export VA_foreign_corp_key_ChildRec := record
  typeof(l.VA_foreign_corp_key) VA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export VI_foreign_corp_key_ChildRec := record
  typeof(l.VI_foreign_corp_key) VI_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export VT_foreign_corp_key_ChildRec := record
  typeof(l.VT_foreign_corp_key) VT_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export WA_foreign_corp_key_ChildRec := record
  typeof(l.WA_foreign_corp_key) WA_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export WI_foreign_corp_key_ChildRec := record
  typeof(l.WI_foreign_corp_key) WI_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export WV_foreign_corp_key_ChildRec := record
  typeof(l.WV_foreign_corp_key) WV_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
export WY_foreign_corp_key_ChildRec := record
  typeof(l.WY_foreign_corp_key) WY_foreign_corp_key;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 cnp_name_specificity;
  real4 cnp_name_switch;
  real4 cnp_name_max;
  dataset(cnp_name_ChildRec) nulls_cnp_name {MAXCOUNT(100)};
  real4 cnp_number_specificity;
  real4 cnp_number_switch;
  real4 cnp_number_max;
  dataset(cnp_number_ChildRec) nulls_cnp_number {MAXCOUNT(100)};
  real4 cnp_btype_specificity;
  real4 cnp_btype_switch;
  real4 cnp_btype_max;
  dataset(cnp_btype_ChildRec) nulls_cnp_btype {MAXCOUNT(100)};
  real4 company_fein_specificity;
  real4 company_fein_switch;
  real4 company_fein_max;
  dataset(company_fein_ChildRec) nulls_company_fein {MAXCOUNT(100)};
  real4 company_phone_specificity;
  real4 company_phone_switch;
  real4 company_phone_max;
  dataset(company_phone_ChildRec) nulls_company_phone {MAXCOUNT(100)};
  real4 iscorp_specificity;
  real4 iscorp_switch;
  real4 iscorp_max;
  dataset(iscorp_ChildRec) nulls_iscorp {MAXCOUNT(100)};
  real4 prim_range_specificity;
  real4 prim_range_switch;
  real4 prim_range_max;
  dataset(prim_range_ChildRec) nulls_prim_range {MAXCOUNT(100)};
  real4 prim_name_specificity;
  real4 prim_name_switch;
  real4 prim_name_max;
  dataset(prim_name_ChildRec) nulls_prim_name {MAXCOUNT(100)};
  real4 sec_range_specificity;
  real4 sec_range_switch;
  real4 sec_range_max;
  dataset(sec_range_ChildRec) nulls_sec_range {MAXCOUNT(100)};
  real4 v_city_name_specificity;
  real4 v_city_name_switch;
  real4 v_city_name_max;
  dataset(v_city_name_ChildRec) nulls_v_city_name {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 company_csz_specificity;
  real4 company_csz_switch;
  real4 company_csz_max;
  dataset(company_csz_ChildRec) nulls_company_csz {MAXCOUNT(100)};
  real4 company_addr1_specificity;
  real4 company_addr1_switch;
  real4 company_addr1_max;
  dataset(company_addr1_ChildRec) nulls_company_addr1 {MAXCOUNT(100)};
  real4 company_address_specificity;
  real4 company_address_switch;
  real4 company_address_max;
  dataset(company_address_ChildRec) nulls_company_address {MAXCOUNT(100)};
  real4 active_duns_number_specificity;
  real4 active_duns_number_switch;
  real4 active_duns_number_max;
  dataset(active_duns_number_ChildRec) nulls_active_duns_number {MAXCOUNT(100)};
  real4 active_enterprise_number_specificity;
  real4 active_enterprise_number_switch;
  real4 active_enterprise_number_max;
  dataset(active_enterprise_number_ChildRec) nulls_active_enterprise_number {MAXCOUNT(100)};
  real4 hist_enterprise_number_specificity;
  real4 hist_enterprise_number_switch;
  real4 hist_enterprise_number_max;
  dataset(hist_enterprise_number_ChildRec) nulls_hist_enterprise_number {MAXCOUNT(100)};
  real4 hist_duns_number_specificity;
  real4 hist_duns_number_switch;
  real4 hist_duns_number_max;
  dataset(hist_duns_number_ChildRec) nulls_hist_duns_number {MAXCOUNT(100)};
  real4 ebr_file_number_specificity;
  real4 ebr_file_number_switch;
  real4 ebr_file_number_max;
  dataset(ebr_file_number_ChildRec) nulls_ebr_file_number {MAXCOUNT(100)};
  real4 domestic_corp_key_specificity;
  real4 domestic_corp_key_switch;
  real4 domestic_corp_key_max;
  dataset(domestic_corp_key_ChildRec) nulls_domestic_corp_key {MAXCOUNT(100)};
  real4 AK_foreign_corp_key_specificity;
  real4 AK_foreign_corp_key_switch;
  real4 AK_foreign_corp_key_max;
  dataset(AK_foreign_corp_key_ChildRec) nulls_AK_foreign_corp_key {MAXCOUNT(100)};
  real4 AL_foreign_corp_key_specificity;
  real4 AL_foreign_corp_key_switch;
  real4 AL_foreign_corp_key_max;
  dataset(AL_foreign_corp_key_ChildRec) nulls_AL_foreign_corp_key {MAXCOUNT(100)};
  real4 AR_foreign_corp_key_specificity;
  real4 AR_foreign_corp_key_switch;
  real4 AR_foreign_corp_key_max;
  dataset(AR_foreign_corp_key_ChildRec) nulls_AR_foreign_corp_key {MAXCOUNT(100)};
  real4 AZ_foreign_corp_key_specificity;
  real4 AZ_foreign_corp_key_switch;
  real4 AZ_foreign_corp_key_max;
  dataset(AZ_foreign_corp_key_ChildRec) nulls_AZ_foreign_corp_key {MAXCOUNT(100)};
  real4 CA_foreign_corp_key_specificity;
  real4 CA_foreign_corp_key_switch;
  real4 CA_foreign_corp_key_max;
  dataset(CA_foreign_corp_key_ChildRec) nulls_CA_foreign_corp_key {MAXCOUNT(100)};
  real4 CO_foreign_corp_key_specificity;
  real4 CO_foreign_corp_key_switch;
  real4 CO_foreign_corp_key_max;
  dataset(CO_foreign_corp_key_ChildRec) nulls_CO_foreign_corp_key {MAXCOUNT(100)};
  real4 CT_foreign_corp_key_specificity;
  real4 CT_foreign_corp_key_switch;
  real4 CT_foreign_corp_key_max;
  dataset(CT_foreign_corp_key_ChildRec) nulls_CT_foreign_corp_key {MAXCOUNT(100)};
  real4 DC_foreign_corp_key_specificity;
  real4 DC_foreign_corp_key_switch;
  real4 DC_foreign_corp_key_max;
  dataset(DC_foreign_corp_key_ChildRec) nulls_DC_foreign_corp_key {MAXCOUNT(100)};
  real4 DE_foreign_corp_key_specificity;
  real4 DE_foreign_corp_key_switch;
  real4 DE_foreign_corp_key_max;
  dataset(DE_foreign_corp_key_ChildRec) nulls_DE_foreign_corp_key {MAXCOUNT(100)};
  real4 FL_foreign_corp_key_specificity;
  real4 FL_foreign_corp_key_switch;
  real4 FL_foreign_corp_key_max;
  dataset(FL_foreign_corp_key_ChildRec) nulls_FL_foreign_corp_key {MAXCOUNT(100)};
  real4 GA_foreign_corp_key_specificity;
  real4 GA_foreign_corp_key_switch;
  real4 GA_foreign_corp_key_max;
  dataset(GA_foreign_corp_key_ChildRec) nulls_GA_foreign_corp_key {MAXCOUNT(100)};
  real4 HI_foreign_corp_key_specificity;
  real4 HI_foreign_corp_key_switch;
  real4 HI_foreign_corp_key_max;
  dataset(HI_foreign_corp_key_ChildRec) nulls_HI_foreign_corp_key {MAXCOUNT(100)};
  real4 IA_foreign_corp_key_specificity;
  real4 IA_foreign_corp_key_switch;
  real4 IA_foreign_corp_key_max;
  dataset(IA_foreign_corp_key_ChildRec) nulls_IA_foreign_corp_key {MAXCOUNT(100)};
  real4 ID_foreign_corp_key_specificity;
  real4 ID_foreign_corp_key_switch;
  real4 ID_foreign_corp_key_max;
  dataset(ID_foreign_corp_key_ChildRec) nulls_ID_foreign_corp_key {MAXCOUNT(100)};
  real4 IL_foreign_corp_key_specificity;
  real4 IL_foreign_corp_key_switch;
  real4 IL_foreign_corp_key_max;
  dataset(IL_foreign_corp_key_ChildRec) nulls_IL_foreign_corp_key {MAXCOUNT(100)};
  real4 IN_foreign_corp_key_specificity;
  real4 IN_foreign_corp_key_switch;
  real4 IN_foreign_corp_key_max;
  dataset(IN_foreign_corp_key_ChildRec) nulls_IN_foreign_corp_key {MAXCOUNT(100)};
  real4 KS_foreign_corp_key_specificity;
  real4 KS_foreign_corp_key_switch;
  real4 KS_foreign_corp_key_max;
  dataset(KS_foreign_corp_key_ChildRec) nulls_KS_foreign_corp_key {MAXCOUNT(100)};
  real4 KY_foreign_corp_key_specificity;
  real4 KY_foreign_corp_key_switch;
  real4 KY_foreign_corp_key_max;
  dataset(KY_foreign_corp_key_ChildRec) nulls_KY_foreign_corp_key {MAXCOUNT(100)};
  real4 LA_foreign_corp_key_specificity;
  real4 LA_foreign_corp_key_switch;
  real4 LA_foreign_corp_key_max;
  dataset(LA_foreign_corp_key_ChildRec) nulls_LA_foreign_corp_key {MAXCOUNT(100)};
  real4 MA_foreign_corp_key_specificity;
  real4 MA_foreign_corp_key_switch;
  real4 MA_foreign_corp_key_max;
  dataset(MA_foreign_corp_key_ChildRec) nulls_MA_foreign_corp_key {MAXCOUNT(100)};
  real4 MD_foreign_corp_key_specificity;
  real4 MD_foreign_corp_key_switch;
  real4 MD_foreign_corp_key_max;
  dataset(MD_foreign_corp_key_ChildRec) nulls_MD_foreign_corp_key {MAXCOUNT(100)};
  real4 ME_foreign_corp_key_specificity;
  real4 ME_foreign_corp_key_switch;
  real4 ME_foreign_corp_key_max;
  dataset(ME_foreign_corp_key_ChildRec) nulls_ME_foreign_corp_key {MAXCOUNT(100)};
  real4 MI_foreign_corp_key_specificity;
  real4 MI_foreign_corp_key_switch;
  real4 MI_foreign_corp_key_max;
  dataset(MI_foreign_corp_key_ChildRec) nulls_MI_foreign_corp_key {MAXCOUNT(100)};
  real4 MN_foreign_corp_key_specificity;
  real4 MN_foreign_corp_key_switch;
  real4 MN_foreign_corp_key_max;
  dataset(MN_foreign_corp_key_ChildRec) nulls_MN_foreign_corp_key {MAXCOUNT(100)};
  real4 MO_foreign_corp_key_specificity;
  real4 MO_foreign_corp_key_switch;
  real4 MO_foreign_corp_key_max;
  dataset(MO_foreign_corp_key_ChildRec) nulls_MO_foreign_corp_key {MAXCOUNT(100)};
  real4 MS_foreign_corp_key_specificity;
  real4 MS_foreign_corp_key_switch;
  real4 MS_foreign_corp_key_max;
  dataset(MS_foreign_corp_key_ChildRec) nulls_MS_foreign_corp_key {MAXCOUNT(100)};
  real4 MT_foreign_corp_key_specificity;
  real4 MT_foreign_corp_key_switch;
  real4 MT_foreign_corp_key_max;
  dataset(MT_foreign_corp_key_ChildRec) nulls_MT_foreign_corp_key {MAXCOUNT(100)};
  real4 NC_foreign_corp_key_specificity;
  real4 NC_foreign_corp_key_switch;
  real4 NC_foreign_corp_key_max;
  dataset(NC_foreign_corp_key_ChildRec) nulls_NC_foreign_corp_key {MAXCOUNT(100)};
  real4 ND_foreign_corp_key_specificity;
  real4 ND_foreign_corp_key_switch;
  real4 ND_foreign_corp_key_max;
  dataset(ND_foreign_corp_key_ChildRec) nulls_ND_foreign_corp_key {MAXCOUNT(100)};
  real4 NE_foreign_corp_key_specificity;
  real4 NE_foreign_corp_key_switch;
  real4 NE_foreign_corp_key_max;
  dataset(NE_foreign_corp_key_ChildRec) nulls_NE_foreign_corp_key {MAXCOUNT(100)};
  real4 NH_foreign_corp_key_specificity;
  real4 NH_foreign_corp_key_switch;
  real4 NH_foreign_corp_key_max;
  dataset(NH_foreign_corp_key_ChildRec) nulls_NH_foreign_corp_key {MAXCOUNT(100)};
  real4 NJ_foreign_corp_key_specificity;
  real4 NJ_foreign_corp_key_switch;
  real4 NJ_foreign_corp_key_max;
  dataset(NJ_foreign_corp_key_ChildRec) nulls_NJ_foreign_corp_key {MAXCOUNT(100)};
  real4 NM_foreign_corp_key_specificity;
  real4 NM_foreign_corp_key_switch;
  real4 NM_foreign_corp_key_max;
  dataset(NM_foreign_corp_key_ChildRec) nulls_NM_foreign_corp_key {MAXCOUNT(100)};
  real4 NV_foreign_corp_key_specificity;
  real4 NV_foreign_corp_key_switch;
  real4 NV_foreign_corp_key_max;
  dataset(NV_foreign_corp_key_ChildRec) nulls_NV_foreign_corp_key {MAXCOUNT(100)};
  real4 NY_foreign_corp_key_specificity;
  real4 NY_foreign_corp_key_switch;
  real4 NY_foreign_corp_key_max;
  dataset(NY_foreign_corp_key_ChildRec) nulls_NY_foreign_corp_key {MAXCOUNT(100)};
  real4 OH_foreign_corp_key_specificity;
  real4 OH_foreign_corp_key_switch;
  real4 OH_foreign_corp_key_max;
  dataset(OH_foreign_corp_key_ChildRec) nulls_OH_foreign_corp_key {MAXCOUNT(100)};
  real4 OK_foreign_corp_key_specificity;
  real4 OK_foreign_corp_key_switch;
  real4 OK_foreign_corp_key_max;
  dataset(OK_foreign_corp_key_ChildRec) nulls_OK_foreign_corp_key {MAXCOUNT(100)};
  real4 OR_foreign_corp_key_specificity;
  real4 OR_foreign_corp_key_switch;
  real4 OR_foreign_corp_key_max;
  dataset(OR_foreign_corp_key_ChildRec) nulls_OR_foreign_corp_key {MAXCOUNT(100)};
  real4 PA_foreign_corp_key_specificity;
  real4 PA_foreign_corp_key_switch;
  real4 PA_foreign_corp_key_max;
  dataset(PA_foreign_corp_key_ChildRec) nulls_PA_foreign_corp_key {MAXCOUNT(100)};
  real4 PR_foreign_corp_key_specificity;
  real4 PR_foreign_corp_key_switch;
  real4 PR_foreign_corp_key_max;
  dataset(PR_foreign_corp_key_ChildRec) nulls_PR_foreign_corp_key {MAXCOUNT(100)};
  real4 RI_foreign_corp_key_specificity;
  real4 RI_foreign_corp_key_switch;
  real4 RI_foreign_corp_key_max;
  dataset(RI_foreign_corp_key_ChildRec) nulls_RI_foreign_corp_key {MAXCOUNT(100)};
  real4 SC_foreign_corp_key_specificity;
  real4 SC_foreign_corp_key_switch;
  real4 SC_foreign_corp_key_max;
  dataset(SC_foreign_corp_key_ChildRec) nulls_SC_foreign_corp_key {MAXCOUNT(100)};
  real4 SD_foreign_corp_key_specificity;
  real4 SD_foreign_corp_key_switch;
  real4 SD_foreign_corp_key_max;
  dataset(SD_foreign_corp_key_ChildRec) nulls_SD_foreign_corp_key {MAXCOUNT(100)};
  real4 TN_foreign_corp_key_specificity;
  real4 TN_foreign_corp_key_switch;
  real4 TN_foreign_corp_key_max;
  dataset(TN_foreign_corp_key_ChildRec) nulls_TN_foreign_corp_key {MAXCOUNT(100)};
  real4 TX_foreign_corp_key_specificity;
  real4 TX_foreign_corp_key_switch;
  real4 TX_foreign_corp_key_max;
  dataset(TX_foreign_corp_key_ChildRec) nulls_TX_foreign_corp_key {MAXCOUNT(100)};
  real4 UT_foreign_corp_key_specificity;
  real4 UT_foreign_corp_key_switch;
  real4 UT_foreign_corp_key_max;
  dataset(UT_foreign_corp_key_ChildRec) nulls_UT_foreign_corp_key {MAXCOUNT(100)};
  real4 VA_foreign_corp_key_specificity;
  real4 VA_foreign_corp_key_switch;
  real4 VA_foreign_corp_key_max;
  dataset(VA_foreign_corp_key_ChildRec) nulls_VA_foreign_corp_key {MAXCOUNT(100)};
  real4 VI_foreign_corp_key_specificity;
  real4 VI_foreign_corp_key_switch;
  real4 VI_foreign_corp_key_max;
  dataset(VI_foreign_corp_key_ChildRec) nulls_VI_foreign_corp_key {MAXCOUNT(100)};
  real4 VT_foreign_corp_key_specificity;
  real4 VT_foreign_corp_key_switch;
  real4 VT_foreign_corp_key_max;
  dataset(VT_foreign_corp_key_ChildRec) nulls_VT_foreign_corp_key {MAXCOUNT(100)};
  real4 WA_foreign_corp_key_specificity;
  real4 WA_foreign_corp_key_switch;
  real4 WA_foreign_corp_key_max;
  dataset(WA_foreign_corp_key_ChildRec) nulls_WA_foreign_corp_key {MAXCOUNT(100)};
  real4 WI_foreign_corp_key_specificity;
  real4 WI_foreign_corp_key_switch;
  real4 WI_foreign_corp_key_max;
  dataset(WI_foreign_corp_key_ChildRec) nulls_WI_foreign_corp_key {MAXCOUNT(100)};
  real4 WV_foreign_corp_key_specificity;
  real4 WV_foreign_corp_key_switch;
  real4 WV_foreign_corp_key_max;
  dataset(WV_foreign_corp_key_ChildRec) nulls_WV_foreign_corp_key {MAXCOUNT(100)};
  real4 WY_foreign_corp_key_specificity;
  real4 WY_foreign_corp_key_switch;
  real4 WY_foreign_corp_key_max;
  dataset(WY_foreign_corp_key_ChildRec) nulls_WY_foreign_corp_key {MAXCOUNT(100)};
END;
END;
