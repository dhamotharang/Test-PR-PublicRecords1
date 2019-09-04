
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_isCorpEnhanced = '',Input_contact_job_title_derived = '',Input_cname_devanitize = '',Input_prim_range = '',Input_prim_name = '',Input_zip = '',Input_zip4 = '',Input_fname = '',Input_lname = '',Input_contact_phone = '',Input_contact_did = '',Input_contact_ssn = '',Input_company_name = '',Input_sec_range = '',Input_v_city_name = '',Input_st = '',Input_company_inc_state = '',Input_company_charter_number = '',Input_active_duns_number = '',Input_hist_duns_number = '',Input_active_domestic_corp_key = '',Input_hist_domestic_corp_key = '',Input_foreign_corp_key = '',Input_unk_corp_key = '',Input_company_fein = '',Input_cnp_btype = '',Input_cnp_name = '',Input_company_name_type_derived = '',Input_company_bdid = '',Input_nodes_total = '',Input_dt_first_seen = '',Input_dt_last_seen = '',OutFile) := MACRO
  IMPORT SALT30,BIPV2_EMPID_Platform;
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
    #IF( #TEXT(Input_isCorpEnhanced)='' )
      '' 
    #ELSE
        IF( le.Input_isCorpEnhanced = (TYPEOF(le.Input_isCorpEnhanced))'','',':isCorpEnhanced')
    #END
 
+    #IF( #TEXT(Input_contact_job_title_derived)='' )
      '' 
    #ELSE
        IF( le.Input_contact_job_title_derived = (TYPEOF(le.Input_contact_job_title_derived))'','',':contact_job_title_derived')
    #END
 
+    #IF( #TEXT(Input_cname_devanitize)='' )
      '' 
    #ELSE
        IF( le.Input_cname_devanitize = (TYPEOF(le.Input_cname_devanitize))'','',':cname_devanitize')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_contact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_contact_phone = (TYPEOF(le.Input_contact_phone))'','',':contact_phone')
    #END
 
+    #IF( #TEXT(Input_contact_did)='' )
      '' 
    #ELSE
        IF( le.Input_contact_did = (TYPEOF(le.Input_contact_did))'','',':contact_did')
    #END
 
+    #IF( #TEXT(Input_contact_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_contact_ssn = (TYPEOF(le.Input_contact_ssn))'','',':contact_ssn')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
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
 
+    #IF( #TEXT(Input_active_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_active_duns_number = (TYPEOF(le.Input_active_duns_number))'','',':active_duns_number')
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
 
+    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
 
+    #IF( #TEXT(Input_cnp_btype)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_btype = (TYPEOF(le.Input_cnp_btype))'','',':cnp_btype')
    #END
 
+    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
 
+    #IF( #TEXT(Input_company_name_type_derived)='' )
      '' 
    #ELSE
        IF( le.Input_company_name_type_derived = (TYPEOF(le.Input_company_name_type_derived))'','',':company_name_type_derived')
    #END
 
+    #IF( #TEXT(Input_company_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_company_bdid = (TYPEOF(le.Input_company_bdid))'','',':company_bdid')
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
