
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_cnp_name = '',Input_cnp_number = '',Input_prim_range = '',Input_prim_name_derived = '',Input_st = '',Input_zip = '',Input_hist_duns_number = '',Input_hist_domestic_corp_key = '',Input_foreign_corp_key = '',Input_unk_corp_key = '',Input_ebr_file_number = '',Input_active_duns_number = '',Input_active_enterprise_number = '',Input_active_domestic_corp_key = '',Input_company_fein = '',Input_company_phone = '',Input_sec_range = '',Input_v_city_name = '',Input_hist_enterprise_number = '',Input_company_csz = '',Input_company_addr1 = '',Input_company_address = '',Input_dt_first_seen = '',Input_dt_last_seen = '',OutFile) := MACRO
  IMPORT SALT30,BIPV2_ProxID_mj6;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
 
+    #IF( #TEXT(Input_cnp_number)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_number = (TYPEOF(le.Input_cnp_number))'','',':cnp_number')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_prim_name_derived)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name_derived = (TYPEOF(le.Input_prim_name_derived))'','',':prim_name_derived')
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
 
+    #IF( #TEXT(Input_hist_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_duns_number = (TYPEOF(le.Input_hist_duns_number))'','',':hist_duns_number')
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
 
+    #IF( #TEXT(Input_ebr_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_ebr_file_number = (TYPEOF(le.Input_ebr_file_number))'','',':ebr_file_number')
    #END
 
+    #IF( #TEXT(Input_active_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
    #END
 
+    #IF( #TEXT(Input_active_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_enterprise_number = (TYPEOF(le.Input_active_enterprise_number))'','',':active_enterprise_number')
    #END
 
+    #IF( #TEXT(Input_active_domestic_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_active_domestic_corp_key = (TYPEOF(le.Input_active_domestic_corp_key))'','',':active_domestic_corp_key')
    #END
 
+    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
 
+    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
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
 
+    #IF( #TEXT(Input_hist_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_hist_enterprise_number = (TYPEOF(le.Input_hist_enterprise_number))'','',':hist_enterprise_number')
    #END
 
+    #IF( #TEXT(Input_company_csz)='' )
      '' 
    #ELSE
        IF( le.Input_company_csz = (TYPEOF(le.Input_company_csz))'','',':company_csz')
    #END
 
+    #IF( #TEXT(Input_company_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_company_addr1 = (TYPEOF(le.Input_company_addr1))'','',':company_addr1')
    #END
 
+    #IF( #TEXT(Input_company_address)='' )
      '' 
    #ELSE
        IF( le.Input_company_address = (TYPEOF(le.Input_company_address))'','',':company_address')
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
