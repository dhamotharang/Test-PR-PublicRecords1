 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_cnp_number = '',Input_prim_range = '',Input_prim_name = '',Input_st = '',Input_active_enterprise_number = '',Input_MN_foreign_corp_key = '',Input_NJ_foreign_corp_key = '',Input_active_duns_number = '',Input_hist_enterprise_number = '',Input_hist_duns_number = '',Input_ebr_file_number = '',Input_AR_foreign_corp_key = '',Input_CA_foreign_corp_key = '',Input_CO_foreign_corp_key = '',Input_DC_foreign_corp_key = '',Input_KS_foreign_corp_key = '',Input_KY_foreign_corp_key = '',Input_MA_foreign_corp_key = '',Input_MD_foreign_corp_key = '',Input_ME_foreign_corp_key = '',Input_MI_foreign_corp_key = '',Input_MO_foreign_corp_key = '',Input_NC_foreign_corp_key = '',Input_ND_foreign_corp_key = '',Input_NM_foreign_corp_key = '',Input_OK_foreign_corp_key = '',Input_PA_foreign_corp_key = '',Input_SC_foreign_corp_key = '',Input_SD_foreign_corp_key = '',Input_TN_foreign_corp_key = '',Input_VT_foreign_corp_key = '',Input_company_phone = '',Input_domestic_corp_key = '',Input_AL_foreign_corp_key = '',Input_FL_foreign_corp_key = '',Input_GA_foreign_corp_key = '',Input_IL_foreign_corp_key = '',Input_IN_foreign_corp_key = '',Input_MS_foreign_corp_key = '',Input_NH_foreign_corp_key = '',Input_NV_foreign_corp_key = '',Input_NY_foreign_corp_key = '',Input_OR_foreign_corp_key = '',Input_RI_foreign_corp_key = '',Input_UT_foreign_corp_key = '',Input_company_fein = '',Input_cnp_name = '',Input_company_address = '',Input_AK_foreign_corp_key = '',Input_CT_foreign_corp_key = '',Input_HI_foreign_corp_key = '',Input_IA_foreign_corp_key = '',Input_LA_foreign_corp_key = '',Input_MT_foreign_corp_key = '',Input_NE_foreign_corp_key = '',Input_VA_foreign_corp_key = '',Input_AZ_foreign_corp_key = '',Input_TX_foreign_corp_key = '',Input_company_addr1 = '',Input_zip = '',Input_company_csz = '',Input_sec_range = '',Input_v_city_name = '',Input_cnp_btype = '',Input_iscorp = '',Input_cnp_lowv = '',Input_cnp_translated = '',Input_cnp_classid = '',Input_company_foreign_domestic = '',Input_company_bdid = '',Input_cnp_hasnumber = '',Input_company_name = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_DE_foreign_corp_key = '',Input_ID_foreign_corp_key = '',Input_OH_foreign_corp_key = '',Input_PR_foreign_corp_key = '',Input_VI_foreign_corp_key = '',Input_WA_foreign_corp_key = '',Input_WI_foreign_corp_key = '',Input_WV_foreign_corp_key = '',Input_WY_foreign_corp_key = '',OutFile) := MACRO
  IMPORT SALT26,BIPV2_ProxID_dev3;
  #uniquename(of)
  %of% := RECORD
    SALT26.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cnp_number)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_number = (TYPEOF(le.Input_cnp_number))'','',':cnp_number')
    #END
+
    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
+
    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
+
    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+
    #IF( #TEXT(Input_active_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_enterprise_number = (TYPEOF(le.Input_active_enterprise_number))'','',':active_enterprise_number')
    #END
+
    #IF( #TEXT(Input_MN_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MN_foreign_corp_key = (TYPEOF(le.Input_MN_foreign_corp_key))'','',':MN_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NJ_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NJ_foreign_corp_key = (TYPEOF(le.Input_NJ_foreign_corp_key))'','',':NJ_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_active_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
    #END
+
    #IF( #TEXT(Input_hist_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_enterprise_number = (TYPEOF(le.Input_hist_enterprise_number))'','',':hist_enterprise_number')
    #END
+
    #IF( #TEXT(Input_hist_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_duns_number = (TYPEOF(le.Input_hist_duns_number))'','',':hist_duns_number')
    #END
+
    #IF( #TEXT(Input_ebr_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_ebr_file_number = (TYPEOF(le.Input_ebr_file_number))'','',':ebr_file_number')
    #END
+
    #IF( #TEXT(Input_AR_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_AR_foreign_corp_key = (TYPEOF(le.Input_AR_foreign_corp_key))'','',':AR_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_CA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_CA_foreign_corp_key = (TYPEOF(le.Input_CA_foreign_corp_key))'','',':CA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_CO_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_CO_foreign_corp_key = (TYPEOF(le.Input_CO_foreign_corp_key))'','',':CO_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_DC_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_DC_foreign_corp_key = (TYPEOF(le.Input_DC_foreign_corp_key))'','',':DC_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_KS_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_KS_foreign_corp_key = (TYPEOF(le.Input_KS_foreign_corp_key))'','',':KS_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_KY_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_KY_foreign_corp_key = (TYPEOF(le.Input_KY_foreign_corp_key))'','',':KY_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_MA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MA_foreign_corp_key = (TYPEOF(le.Input_MA_foreign_corp_key))'','',':MA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_MD_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MD_foreign_corp_key = (TYPEOF(le.Input_MD_foreign_corp_key))'','',':MD_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_ME_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_ME_foreign_corp_key = (TYPEOF(le.Input_ME_foreign_corp_key))'','',':ME_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_MI_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MI_foreign_corp_key = (TYPEOF(le.Input_MI_foreign_corp_key))'','',':MI_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_MO_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MO_foreign_corp_key = (TYPEOF(le.Input_MO_foreign_corp_key))'','',':MO_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NC_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NC_foreign_corp_key = (TYPEOF(le.Input_NC_foreign_corp_key))'','',':NC_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_ND_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_ND_foreign_corp_key = (TYPEOF(le.Input_ND_foreign_corp_key))'','',':ND_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NM_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NM_foreign_corp_key = (TYPEOF(le.Input_NM_foreign_corp_key))'','',':NM_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_OK_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_OK_foreign_corp_key = (TYPEOF(le.Input_OK_foreign_corp_key))'','',':OK_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_PA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_PA_foreign_corp_key = (TYPEOF(le.Input_PA_foreign_corp_key))'','',':PA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_SC_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_SC_foreign_corp_key = (TYPEOF(le.Input_SC_foreign_corp_key))'','',':SC_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_SD_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_SD_foreign_corp_key = (TYPEOF(le.Input_SD_foreign_corp_key))'','',':SD_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_TN_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_TN_foreign_corp_key = (TYPEOF(le.Input_TN_foreign_corp_key))'','',':TN_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_VT_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_VT_foreign_corp_key = (TYPEOF(le.Input_VT_foreign_corp_key))'','',':VT_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
    #END
+
    #IF( #TEXT(Input_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_domestic_corp_key = (TYPEOF(le.Input_domestic_corp_key))'','',':domestic_corp_key')
    #END
+
    #IF( #TEXT(Input_AL_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_AL_foreign_corp_key = (TYPEOF(le.Input_AL_foreign_corp_key))'','',':AL_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_FL_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_FL_foreign_corp_key = (TYPEOF(le.Input_FL_foreign_corp_key))'','',':FL_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_GA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_GA_foreign_corp_key = (TYPEOF(le.Input_GA_foreign_corp_key))'','',':GA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_IL_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_IL_foreign_corp_key = (TYPEOF(le.Input_IL_foreign_corp_key))'','',':IL_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_IN_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_IN_foreign_corp_key = (TYPEOF(le.Input_IN_foreign_corp_key))'','',':IN_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_MS_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MS_foreign_corp_key = (TYPEOF(le.Input_MS_foreign_corp_key))'','',':MS_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NH_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NH_foreign_corp_key = (TYPEOF(le.Input_NH_foreign_corp_key))'','',':NH_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NV_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NV_foreign_corp_key = (TYPEOF(le.Input_NV_foreign_corp_key))'','',':NV_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NY_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NY_foreign_corp_key = (TYPEOF(le.Input_NY_foreign_corp_key))'','',':NY_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_OR_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_OR_foreign_corp_key = (TYPEOF(le.Input_OR_foreign_corp_key))'','',':OR_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_RI_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_RI_foreign_corp_key = (TYPEOF(le.Input_RI_foreign_corp_key))'','',':RI_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_UT_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_UT_foreign_corp_key = (TYPEOF(le.Input_UT_foreign_corp_key))'','',':UT_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
+
    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
+
    #IF( #TEXT(Input_company_address)='' )
      '' 
    #ELSE
        IF( le.Input_company_address = (TYPEOF(le.Input_company_address))'','',':company_address')
    #END
+
    #IF( #TEXT(Input_AK_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_AK_foreign_corp_key = (TYPEOF(le.Input_AK_foreign_corp_key))'','',':AK_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_CT_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_CT_foreign_corp_key = (TYPEOF(le.Input_CT_foreign_corp_key))'','',':CT_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_HI_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_HI_foreign_corp_key = (TYPEOF(le.Input_HI_foreign_corp_key))'','',':HI_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_IA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_IA_foreign_corp_key = (TYPEOF(le.Input_IA_foreign_corp_key))'','',':IA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_LA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_LA_foreign_corp_key = (TYPEOF(le.Input_LA_foreign_corp_key))'','',':LA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_MT_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_MT_foreign_corp_key = (TYPEOF(le.Input_MT_foreign_corp_key))'','',':MT_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_NE_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_NE_foreign_corp_key = (TYPEOF(le.Input_NE_foreign_corp_key))'','',':NE_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_VA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_VA_foreign_corp_key = (TYPEOF(le.Input_VA_foreign_corp_key))'','',':VA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_AZ_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_AZ_foreign_corp_key = (TYPEOF(le.Input_AZ_foreign_corp_key))'','',':AZ_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_TX_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_TX_foreign_corp_key = (TYPEOF(le.Input_TX_foreign_corp_key))'','',':TX_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_company_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_company_addr1 = (TYPEOF(le.Input_company_addr1))'','',':company_addr1')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_company_csz)='' )
      '' 
    #ELSE
        IF( le.Input_company_csz = (TYPEOF(le.Input_company_csz))'','',':company_csz')
    #END
+
    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+
    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
+
    #IF( #TEXT(Input_cnp_btype)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_btype = (TYPEOF(le.Input_cnp_btype))'','',':cnp_btype')
    #END
+
    #IF( #TEXT(Input_iscorp)='' )
      '' 
    #ELSE
        IF( le.Input_iscorp = (TYPEOF(le.Input_iscorp))'','',':iscorp')
    #END
+
    #IF( #TEXT(Input_cnp_lowv)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_lowv = (TYPEOF(le.Input_cnp_lowv))'','',':cnp_lowv')
    #END
+
    #IF( #TEXT(Input_cnp_translated)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_translated = (TYPEOF(le.Input_cnp_translated))'','',':cnp_translated')
    #END
+
    #IF( #TEXT(Input_cnp_classid)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_classid = (TYPEOF(le.Input_cnp_classid))'','',':cnp_classid')
    #END
+
    #IF( #TEXT(Input_company_foreign_domestic)='' )
      '' 
    #ELSE
        IF( le.Input_company_foreign_domestic = (TYPEOF(le.Input_company_foreign_domestic))'','',':company_foreign_domestic')
    #END
+
    #IF( #TEXT(Input_company_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_company_bdid = (TYPEOF(le.Input_company_bdid))'','',':company_bdid')
    #END
+
    #IF( #TEXT(Input_cnp_hasnumber)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_hasnumber = (TYPEOF(le.Input_cnp_hasnumber))'','',':cnp_hasnumber')
    #END
+
    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
+
    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+
    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+
    #IF( #TEXT(Input_DE_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_DE_foreign_corp_key = (TYPEOF(le.Input_DE_foreign_corp_key))'','',':DE_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_ID_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_ID_foreign_corp_key = (TYPEOF(le.Input_ID_foreign_corp_key))'','',':ID_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_OH_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_OH_foreign_corp_key = (TYPEOF(le.Input_OH_foreign_corp_key))'','',':OH_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_PR_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_PR_foreign_corp_key = (TYPEOF(le.Input_PR_foreign_corp_key))'','',':PR_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_VI_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_VI_foreign_corp_key = (TYPEOF(le.Input_VI_foreign_corp_key))'','',':VI_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_WA_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_WA_foreign_corp_key = (TYPEOF(le.Input_WA_foreign_corp_key))'','',':WA_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_WI_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_WI_foreign_corp_key = (TYPEOF(le.Input_WI_foreign_corp_key))'','',':WI_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_WV_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_WV_foreign_corp_key = (TYPEOF(le.Input_WV_foreign_corp_key))'','',':WV_foreign_corp_key')
    #END
+
    #IF( #TEXT(Input_WY_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_WY_foreign_corp_key = (TYPEOF(le.Input_WY_foreign_corp_key))'','',':WY_foreign_corp_key')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
