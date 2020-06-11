 
EXPORT InputB_MAC_PopulationStatistics(infile,Ref='',Input_hcp_hce_id = '',Input_ok_indv_id = '',Input_ska_uid = '',Input_ims_id = '',Input_frst_nm = '',Input_mid_nm = '',Input_last_nm = '',Input_sfx_cd = '',Input_gender_cd = '',Input_prim_prfsn_cd = '',Input_prim_prfsn_desc = '',Input_prim_spcl_cd = '',Input_prim_spcl_desc = '',Input_hce_prfsnl_stat_cd = '',Input_hce_prfsnl_stat_desc = '',Input_excld_rsn_desc = '',Input_npi = '',Input_deactv_dt = '',Input_xref_hce_id = '',Input_city_nm = '',Input_st_cd = '',Input_zip5_cd = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_ims_id)='' )
      '' 
    #ELSE
        IF( le.Input_ims_id = (TYPEOF(le.Input_ims_id))'','',':ims_id')
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
 
+    #IF( #TEXT(Input_hce_prfsnl_stat_cd)='' )
      '' 
    #ELSE
        IF( le.Input_hce_prfsnl_stat_cd = (TYPEOF(le.Input_hce_prfsnl_stat_cd))'','',':hce_prfsnl_stat_cd')
    #END
 
+    #IF( #TEXT(Input_hce_prfsnl_stat_desc)='' )
      '' 
    #ELSE
        IF( le.Input_hce_prfsnl_stat_desc = (TYPEOF(le.Input_hce_prfsnl_stat_desc))'','',':hce_prfsnl_stat_desc')
    #END
 
+    #IF( #TEXT(Input_excld_rsn_desc)='' )
      '' 
    #ELSE
        IF( le.Input_excld_rsn_desc = (TYPEOF(le.Input_excld_rsn_desc))'','',':excld_rsn_desc')
    #END
 
+    #IF( #TEXT(Input_npi)='' )
      '' 
    #ELSE
        IF( le.Input_npi = (TYPEOF(le.Input_npi))'','',':npi')
    #END
 
+    #IF( #TEXT(Input_deactv_dt)='' )
      '' 
    #ELSE
        IF( le.Input_deactv_dt = (TYPEOF(le.Input_deactv_dt))'','',':deactv_dt')
    #END
 
+    #IF( #TEXT(Input_xref_hce_id)='' )
      '' 
    #ELSE
        IF( le.Input_xref_hce_id = (TYPEOF(le.Input_xref_hce_id))'','',':xref_hce_id')
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
