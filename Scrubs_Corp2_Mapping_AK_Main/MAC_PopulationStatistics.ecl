 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_corp_ra_dt_first_seen = '',Input_corp_ra_dt_last_seen = '',Input_corp_key = '',Input_corp_vendor = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_orig_sos_charter_nbr = '',Input_corp_legal_name = '',Input_corp_ln_name_type_cd = '',Input_corp_status_desc = '',Input_corp_standing = '',Input_corp_inc_state = '',Input_corp_inc_date = '',Input_corp_term_exist_cd = '',Input_corp_term_exist_exp = '',Input_corp_term_exist_desc = '',Input_corp_foreign_domestic_ind = '',Input_corp_forgn_date = '',Input_corp_orig_org_structure_desc = '',Input_corp_for_profit_ind = '',Input_corp_country_of_formation = '',Input_Corp_Name_Status_Desc = '',Input_corp_forgn_state_cd = '',Input_recordorigin = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_AK_Main;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_first_reported = 0,'', ':dt_vendor_first_reported(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_first_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_last_reported = 0,'', ':dt_vendor_last_reported(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_last_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_first_seen = 0,'', ':dt_first_seen(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_dt_first_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_last_seen = 0,'', ':dt_last_seen(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_dt_last_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_first_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_dt_first_seen = 0,'', ':corp_ra_dt_first_seen(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_corp_ra_dt_first_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_last_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_dt_last_seen = 0,'', ':corp_ra_dt_last_seen(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_corp_ra_dt_last_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor = (TYPEOF(le.Input_corp_vendor))'','',':corp_vendor')
    #END
 
+    #IF( #TEXT(Input_corp_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_origin = (TYPEOF(le.Input_corp_state_origin))'','',':corp_state_origin')
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_process_date = (TYPEOF(le.Input_corp_process_date))'','',':corp_process_date')
    #END
 
+    #IF( #TEXT(Input_corp_orig_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_sos_charter_nbr = (TYPEOF(le.Input_corp_orig_sos_charter_nbr))'','',':corp_orig_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_corp_legal_name)='' )
      '' 
    #ELSE
        IF( le.Input_corp_legal_name = (TYPEOF(le.Input_corp_legal_name))'','',':corp_legal_name')
    #END
 
+    #IF( #TEXT(Input_corp_ln_name_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_ln_name_type_cd = (TYPEOF(le.Input_corp_ln_name_type_cd))'','',':corp_ln_name_type_cd')
    #END
 
+    #IF( #TEXT(Input_corp_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_desc = (TYPEOF(le.Input_corp_status_desc))'','',':corp_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_standing)='' )
      '' 
    #ELSE
        IF( le.Input_corp_standing = (TYPEOF(le.Input_corp_standing))'','',':corp_standing')
    #END
 
+    #IF( #TEXT(Input_corp_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_state = (TYPEOF(le.Input_corp_inc_state))'','',':corp_inc_state')
    #END
 
+    #IF( #TEXT(Input_corp_inc_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_inc_date = 0,'', ':corp_inc_date(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_corp_inc_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_cd = (TYPEOF(le.Input_corp_term_exist_cd))'','',':corp_term_exist_cd')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_exp)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_term_exist_exp = 0,'', ':corp_term_exist_exp(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_corp_term_exist_exp) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_desc = (TYPEOF(le.Input_corp_term_exist_desc))'','',':corp_term_exist_desc')
    #END
 
+    #IF( #TEXT(Input_corp_foreign_domestic_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_foreign_domestic_ind = (TYPEOF(le.Input_corp_foreign_domestic_ind))'','',':corp_foreign_domestic_ind')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_forgn_date = 0,'', ':corp_forgn_date(' + SALT34.fn_date_valid_as_text((unsigned)le.Input_corp_forgn_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_orig_org_structure_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_org_structure_desc = (TYPEOF(le.Input_corp_orig_org_structure_desc))'','',':corp_orig_org_structure_desc')
    #END
 
+    #IF( #TEXT(Input_corp_for_profit_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_for_profit_ind = (TYPEOF(le.Input_corp_for_profit_ind))'','',':corp_for_profit_ind')
    #END
 
+    #IF( #TEXT(Input_corp_country_of_formation)='' )
      '' 
    #ELSE
        IF( le.Input_corp_country_of_formation = (TYPEOF(le.Input_corp_country_of_formation))'','',':corp_country_of_formation')
    #END
 
+    #IF( #TEXT(Input_Corp_Name_Status_Desc)='' )
      '' 
    #ELSE
        IF( le.Input_Corp_Name_Status_Desc = (TYPEOF(le.Input_Corp_Name_Status_Desc))'','',':Corp_Name_Status_Desc')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_cd = (TYPEOF(le.Input_corp_forgn_state_cd))'','',':corp_forgn_state_cd')
    #END
 
+    #IF( #TEXT(Input_recordorigin)='' )
      '' 
    #ELSE
        IF( le.Input_recordorigin = (TYPEOF(le.Input_recordorigin))'','',':recordorigin')
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
