 
EXPORT InputA_MAC_PopulationStatistics(infile,Ref='',Input_hcp_hce_id = '',Input_ok_indv_id = '',Input_ska_uid = '',Input_frst_nm = '',Input_mid_nm = '',Input_last_nm = '',Input_sfx_cd = '',Input_gender_cd = '',Input_prim_prfsn_cd = '',Input_prim_prfsn_desc = '',Input_prim_spcl_cd = '',Input_prim_spcl_desc = '',Input_sec_spcl_cd = '',Input_sec_spcl_desc = '',Input_tert_spcl_cd = '',Input_tert_spcl_desc = '',Input_sub_spcl_cd = '',Input_sub_spcl_desc = '',Input_titl_typ_id = '',Input_titl_typ_desc = '',Input_hco_hce_id = '',Input_ok_wkp_id = '',Input_ska_id = '',Input_bus_nm = '',Input_dba_nm = '',Input_addr_id = '',Input_str_front_id = '',Input_addr_ln_1_txt = '',Input_addr_ln_2_txt = '',Input_city_nm = '',Input_st_cd = '',Input_zip5_cd = '',Input_zip4_cd = '',Input_fips_cnty_cd = '',Input_fips_cnty_desc = '',Input_telephn_nbr = '',Input_cot_id = '',Input_cot_clas_id = '',Input_cot_clas_desc = '',Input_cot_fclt_typ_id = '',Input_cot_fclt_typ_desc = '',Input_cot_spcl_id = '',Input_cot_spcl_desc = '',Input_email_ind_flag = '',Input_hcp_affil_xid = '',Input_delta_cd = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OneKey;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_hcp_hce_id)='' )
      '' 
    #ELSE
        IF( le.Input_hcp_hce_id = (TYPEOF(le.Input_hcp_hce_id))'','',':hcp_hce_id')
    #END
 
+    #IF( #TEXT(Input_ok_indv_id)='' )
      '' 
    #ELSE
        IF( le.Input_ok_indv_id = (TYPEOF(le.Input_ok_indv_id))'','',':ok_indv_id')
    #END
 
+    #IF( #TEXT(Input_ska_uid)='' )
      '' 
    #ELSE
        IF( le.Input_ska_uid = (TYPEOF(le.Input_ska_uid))'','',':ska_uid')
    #END
 
+    #IF( #TEXT(Input_frst_nm)='' )
      '' 
    #ELSE
        IF( le.Input_frst_nm = (TYPEOF(le.Input_frst_nm))'','',':frst_nm')
    #END
 
+    #IF( #TEXT(Input_mid_nm)='' )
      '' 
    #ELSE
        IF( le.Input_mid_nm = (TYPEOF(le.Input_mid_nm))'','',':mid_nm')
    #END
 
+    #IF( #TEXT(Input_last_nm)='' )
      '' 
    #ELSE
        IF( le.Input_last_nm = (TYPEOF(le.Input_last_nm))'','',':last_nm')
    #END
 
+    #IF( #TEXT(Input_sfx_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sfx_cd = (TYPEOF(le.Input_sfx_cd))'','',':sfx_cd')
    #END
 
+    #IF( #TEXT(Input_gender_cd)='' )
      '' 
    #ELSE
        IF( le.Input_gender_cd = (TYPEOF(le.Input_gender_cd))'','',':gender_cd')
    #END
 
+    #IF( #TEXT(Input_prim_prfsn_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prim_prfsn_cd = (TYPEOF(le.Input_prim_prfsn_cd))'','',':prim_prfsn_cd')
    #END
 
+    #IF( #TEXT(Input_prim_prfsn_desc)='' )
      '' 
    #ELSE
        IF( le.Input_prim_prfsn_desc = (TYPEOF(le.Input_prim_prfsn_desc))'','',':prim_prfsn_desc')
    #END
 
+    #IF( #TEXT(Input_prim_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prim_spcl_cd = (TYPEOF(le.Input_prim_spcl_cd))'','',':prim_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_prim_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_prim_spcl_desc = (TYPEOF(le.Input_prim_spcl_desc))'','',':prim_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_sec_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sec_spcl_cd = (TYPEOF(le.Input_sec_spcl_cd))'','',':sec_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_sec_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sec_spcl_desc = (TYPEOF(le.Input_sec_spcl_desc))'','',':sec_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_tert_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_tert_spcl_cd = (TYPEOF(le.Input_tert_spcl_cd))'','',':tert_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_tert_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_tert_spcl_desc = (TYPEOF(le.Input_tert_spcl_desc))'','',':tert_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_sub_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sub_spcl_cd = (TYPEOF(le.Input_sub_spcl_cd))'','',':sub_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_sub_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sub_spcl_desc = (TYPEOF(le.Input_sub_spcl_desc))'','',':sub_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_titl_typ_id)='' )
      '' 
    #ELSE
        IF( le.Input_titl_typ_id = (TYPEOF(le.Input_titl_typ_id))'','',':titl_typ_id')
    #END
 
+    #IF( #TEXT(Input_titl_typ_desc)='' )
      '' 
    #ELSE
        IF( le.Input_titl_typ_desc = (TYPEOF(le.Input_titl_typ_desc))'','',':titl_typ_desc')
    #END
 
+    #IF( #TEXT(Input_hco_hce_id)='' )
      '' 
    #ELSE
        IF( le.Input_hco_hce_id = (TYPEOF(le.Input_hco_hce_id))'','',':hco_hce_id')
    #END
 
+    #IF( #TEXT(Input_ok_wkp_id)='' )
      '' 
    #ELSE
        IF( le.Input_ok_wkp_id = (TYPEOF(le.Input_ok_wkp_id))'','',':ok_wkp_id')
    #END
 
+    #IF( #TEXT(Input_ska_id)='' )
      '' 
    #ELSE
        IF( le.Input_ska_id = (TYPEOF(le.Input_ska_id))'','',':ska_id')
    #END
 
+    #IF( #TEXT(Input_bus_nm)='' )
      '' 
    #ELSE
        IF( le.Input_bus_nm = (TYPEOF(le.Input_bus_nm))'','',':bus_nm')
    #END
 
+    #IF( #TEXT(Input_dba_nm)='' )
      '' 
    #ELSE
        IF( le.Input_dba_nm = (TYPEOF(le.Input_dba_nm))'','',':dba_nm')
    #END
 
+    #IF( #TEXT(Input_addr_id)='' )
      '' 
    #ELSE
        IF( le.Input_addr_id = (TYPEOF(le.Input_addr_id))'','',':addr_id')
    #END
 
+    #IF( #TEXT(Input_str_front_id)='' )
      '' 
    #ELSE
        IF( le.Input_str_front_id = (TYPEOF(le.Input_str_front_id))'','',':str_front_id')
    #END
 
+    #IF( #TEXT(Input_addr_ln_1_txt)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ln_1_txt = (TYPEOF(le.Input_addr_ln_1_txt))'','',':addr_ln_1_txt')
    #END
 
+    #IF( #TEXT(Input_addr_ln_2_txt)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ln_2_txt = (TYPEOF(le.Input_addr_ln_2_txt))'','',':addr_ln_2_txt')
    #END
 
+    #IF( #TEXT(Input_city_nm)='' )
      '' 
    #ELSE
        IF( le.Input_city_nm = (TYPEOF(le.Input_city_nm))'','',':city_nm')
    #END
 
+    #IF( #TEXT(Input_st_cd)='' )
      '' 
    #ELSE
        IF( le.Input_st_cd = (TYPEOF(le.Input_st_cd))'','',':st_cd')
    #END
 
+    #IF( #TEXT(Input_zip5_cd)='' )
      '' 
    #ELSE
        IF( le.Input_zip5_cd = (TYPEOF(le.Input_zip5_cd))'','',':zip5_cd')
    #END
 
+    #IF( #TEXT(Input_zip4_cd)='' )
      '' 
    #ELSE
        IF( le.Input_zip4_cd = (TYPEOF(le.Input_zip4_cd))'','',':zip4_cd')
    #END
 
+    #IF( #TEXT(Input_fips_cnty_cd)='' )
      '' 
    #ELSE
        IF( le.Input_fips_cnty_cd = (TYPEOF(le.Input_fips_cnty_cd))'','',':fips_cnty_cd')
    #END
 
+    #IF( #TEXT(Input_fips_cnty_desc)='' )
      '' 
    #ELSE
        IF( le.Input_fips_cnty_desc = (TYPEOF(le.Input_fips_cnty_desc))'','',':fips_cnty_desc')
    #END
 
+    #IF( #TEXT(Input_telephn_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_telephn_nbr = (TYPEOF(le.Input_telephn_nbr))'','',':telephn_nbr')
    #END
 
+    #IF( #TEXT(Input_cot_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_id = (TYPEOF(le.Input_cot_id))'','',':cot_id')
    #END
 
+    #IF( #TEXT(Input_cot_clas_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_clas_id = (TYPEOF(le.Input_cot_clas_id))'','',':cot_clas_id')
    #END
 
+    #IF( #TEXT(Input_cot_clas_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cot_clas_desc = (TYPEOF(le.Input_cot_clas_desc))'','',':cot_clas_desc')
    #END
 
+    #IF( #TEXT(Input_cot_fclt_typ_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_fclt_typ_id = (TYPEOF(le.Input_cot_fclt_typ_id))'','',':cot_fclt_typ_id')
    #END
 
+    #IF( #TEXT(Input_cot_fclt_typ_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cot_fclt_typ_desc = (TYPEOF(le.Input_cot_fclt_typ_desc))'','',':cot_fclt_typ_desc')
    #END
 
+    #IF( #TEXT(Input_cot_spcl_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_spcl_id = (TYPEOF(le.Input_cot_spcl_id))'','',':cot_spcl_id')
    #END
 
+    #IF( #TEXT(Input_cot_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cot_spcl_desc = (TYPEOF(le.Input_cot_spcl_desc))'','',':cot_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_email_ind_flag)='' )
      '' 
    #ELSE
        IF( le.Input_email_ind_flag = (TYPEOF(le.Input_email_ind_flag))'','',':email_ind_flag')
    #END
 
+    #IF( #TEXT(Input_hcp_affil_xid)='' )
      '' 
    #ELSE
        IF( le.Input_hcp_affil_xid = (TYPEOF(le.Input_hcp_affil_xid))'','',':hcp_affil_xid')
    #END
 
+    #IF( #TEXT(Input_delta_cd)='' )
      '' 
    #ELSE
        IF( le.Input_delta_cd = (TYPEOF(le.Input_delta_cd))'','',':delta_cd')
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
