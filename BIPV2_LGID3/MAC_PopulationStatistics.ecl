
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_sbfe_id = '',Input_nodes_below_st = '',Input_Lgid3IfHrchy = '',Input_OriginalSeleId = '',Input_OriginalOrgId = '',Input_company_name = '',Input_cnp_number = '',Input_active_duns_number = '',Input_duns_number = '',Input_duns_number_concept = '',Input_company_fein = '',Input_company_inc_state = '',Input_company_charter_number = '',Input_cnp_btype = '',Input_company_name_type_derived = '',Input_hist_duns_number = '',Input_active_domestic_corp_key = '',Input_hist_domestic_corp_key = '',Input_foreign_corp_key = '',Input_unk_corp_key = '',Input_cnp_name = '',Input_cnp_hasNumber = '',Input_cnp_lowv = '',Input_cnp_translated = '',Input_cnp_classid = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_has_lgid = '',Input_is_sele_level = '',Input_is_org_level = '',Input_is_ult_level = '',Input_parent_proxid = '',Input_sele_proxid = '',Input_org_proxid = '',Input_ultimate_proxid = '',Input_levels_from_top = '',Input_nodes_total = '',Input_dt_first_seen = '',Input_dt_last_seen = '',OutFile) := MACRO
  IMPORT SALT311,BIPV2_LGID3;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_sbfe_id)='' )
      '' 
    #ELSE
        IF( le.Input_sbfe_id = (TYPEOF(le.Input_sbfe_id))'','',':sbfe_id')
    #END
 
+    #IF( #TEXT(Input_nodes_below_st)='' )
      '' 
    #ELSE
        IF( le.Input_nodes_below_st = (TYPEOF(le.Input_nodes_below_st))'','',':nodes_below_st')
    #END
 
+    #IF( #TEXT(Input_Lgid3IfHrchy)='' )
      '' 
    #ELSE
        IF( le.Input_Lgid3IfHrchy = (TYPEOF(le.Input_Lgid3IfHrchy))'','',':Lgid3IfHrchy')
    #END
 
+    #IF( #TEXT(Input_OriginalSeleId)='' )
      '' 
    #ELSE
        IF( le.Input_OriginalSeleId = (TYPEOF(le.Input_OriginalSeleId))'','',':OriginalSeleId')
    #END
 
+    #IF( #TEXT(Input_OriginalOrgId)='' )
      '' 
    #ELSE
        IF( le.Input_OriginalOrgId = (TYPEOF(le.Input_OriginalOrgId))'','',':OriginalOrgId')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_cnp_number)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_number = (TYPEOF(le.Input_cnp_number))'','',':cnp_number')
    #END
 
+    #IF( #TEXT(Input_active_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
    #END
 
+    #IF( #TEXT(Input_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_duns_number = (TYPEOF(le.Input_duns_number))'','',':duns_number')
    #END
 
+    #IF( #TEXT(Input_duns_number_concept)='' )
      '' 
    #ELSE
        IF( le.Input_duns_number_concept = (TYPEOF(le.Input_duns_number_concept))'','',':duns_number_concept')
    #END
 
+    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
 
+    #IF( #TEXT(Input_company_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_company_inc_state = (TYPEOF(le.Input_company_inc_state))'','',':company_inc_state')
    #END
 
+    #IF( #TEXT(Input_company_charter_number)='' )
      '' 
    #ELSE
        IF( le.Input_company_charter_number = (TYPEOF(le.Input_company_charter_number))'','',':company_charter_number')
    #END
 
+    #IF( #TEXT(Input_cnp_btype)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_btype = (TYPEOF(le.Input_cnp_btype))'','',':cnp_btype')
    #END
 
+    #IF( #TEXT(Input_company_name_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_type_derived = (TYPEOF(le.Input_company_name_type_derived))'','',':company_name_type_derived')
    #END
 
+    #IF( #TEXT(Input_hist_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_duns_number = (TYPEOF(le.Input_hist_duns_number))'','',':hist_duns_number')
    #END
 
+    #IF( #TEXT(Input_active_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_active_domestic_corp_key = (TYPEOF(le.Input_active_domestic_corp_key))'','',':active_domestic_corp_key')
    #END
 
+    #IF( #TEXT(Input_hist_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_hist_domestic_corp_key = (TYPEOF(le.Input_hist_domestic_corp_key))'','',':hist_domestic_corp_key')
    #END
 
+    #IF( #TEXT(Input_foreign_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_corp_key = (TYPEOF(le.Input_foreign_corp_key))'','',':foreign_corp_key')
    #END
 
+    #IF( #TEXT(Input_unk_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_unk_corp_key = (TYPEOF(le.Input_unk_corp_key))'','',':unk_corp_key')
    #END
 
+    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
 
+    #IF( #TEXT(Input_cnp_hasNumber)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_hasNumber = (TYPEOF(le.Input_cnp_hasNumber))'','',':cnp_hasNumber')
    #END
 
+    #IF( #TEXT(Input_cnp_lowv)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_lowv = (TYPEOF(le.Input_cnp_lowv))'','',':cnp_lowv')
    #END
 
+    #IF( #TEXT(Input_cnp_translated)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_translated = (TYPEOF(le.Input_cnp_translated))'','',':cnp_translated')
    #END
 
+    #IF( #TEXT(Input_cnp_classid)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_classid = (TYPEOF(le.Input_cnp_classid))'','',':cnp_classid')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_has_lgid)='' )
      '' 
    #ELSE
        IF( le.Input_has_lgid = (TYPEOF(le.Input_has_lgid))'','',':has_lgid')
    #END
 
+    #IF( #TEXT(Input_is_sele_level)='' )
      '' 
    #ELSE
        IF( le.Input_is_sele_level = (TYPEOF(le.Input_is_sele_level))'','',':is_sele_level')
    #END
 
+    #IF( #TEXT(Input_is_org_level)='' )
      '' 
    #ELSE
        IF( le.Input_is_org_level = (TYPEOF(le.Input_is_org_level))'','',':is_org_level')
    #END
 
+    #IF( #TEXT(Input_is_ult_level)='' )
      '' 
    #ELSE
        IF( le.Input_is_ult_level = (TYPEOF(le.Input_is_ult_level))'','',':is_ult_level')
    #END
 
+    #IF( #TEXT(Input_parent_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_parent_proxid = (TYPEOF(le.Input_parent_proxid))'','',':parent_proxid')
    #END
 
+    #IF( #TEXT(Input_sele_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_sele_proxid = (TYPEOF(le.Input_sele_proxid))'','',':sele_proxid')
    #END
 
+    #IF( #TEXT(Input_org_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_org_proxid = (TYPEOF(le.Input_org_proxid))'','',':org_proxid')
    #END
 
+    #IF( #TEXT(Input_ultimate_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_ultimate_proxid = (TYPEOF(le.Input_ultimate_proxid))'','',':ultimate_proxid')
    #END
 
+    #IF( #TEXT(Input_levels_from_top)='' )
      '' 
    #ELSE
        IF( le.Input_levels_from_top = (TYPEOF(le.Input_levels_from_top))'','',':levels_from_top')
    #END
 
+    #IF( #TEXT(Input_nodes_total)='' )
      '' 
    #ELSE
        IF( le.Input_nodes_total = (TYPEOF(le.Input_nodes_total))'','',':nodes_total')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
;
    #IF (#TEXT(source)<>'')
    SELF.source := le.source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source)<>'' ) source, #END -cnt );
ENDMACRO;
