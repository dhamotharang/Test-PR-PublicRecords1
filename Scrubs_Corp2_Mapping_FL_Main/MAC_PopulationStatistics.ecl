 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_corp_key = '',Input_corp_orig_sos_charter_nbr = '',Input_corp_legal_name = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_corp_process_date = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_corp_forgn_date = '',Input_corp_inc_date = '',Input_corp_merger_date = '',Input_corp_merger_effective_date = '',Input_corp_ra_dt_first_seen = '',Input_corp_ra_dt_last_seen = '',Input_corp_ra_resign_date = '',Input_corp_status_date = '',Input_corp_vendor = '',Input_corp_state_origin = '',Input_corp_inc_state = '',Input_corp_for_profit_ind = '',Input_corp_foreign_domestic_ind = '',Input_corp_status_cd = '',Input_corp_orig_org_structure_cd = '',Input_corp_fed_tax_id = '',Input_corp_forgn_state_desc = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_Corp2_Mapping_FL_Main;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
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
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_first_seen = 0,'', ':dt_first_seen(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_dt_first_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_last_seen = 0,'', ':dt_last_seen(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_dt_last_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_process_date = 0,'', ':corp_process_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_process_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_first_reported = 0,'', ':dt_vendor_first_reported(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_first_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_last_reported = 0,'', ':dt_vendor_last_reported(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_last_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_forgn_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_forgn_date = 0,'', ':corp_forgn_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_forgn_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_inc_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_inc_date = 0,'', ':corp_inc_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_inc_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_merger_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_merger_date = 0,'', ':corp_merger_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_merger_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_merger_effective_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_merger_effective_date = 0,'', ':corp_merger_effective_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_merger_effective_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_first_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_dt_first_seen = 0,'', ':corp_ra_dt_first_seen(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_ra_dt_first_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_last_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_dt_last_seen = 0,'', ':corp_ra_dt_last_seen(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_ra_dt_last_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_resign_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_resign_date = 0,'', ':corp_ra_resign_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_ra_resign_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_status_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_status_date = 0,'', ':corp_status_date(' + SALT32.fn_date_valid_as_text((unsigned)le.Input_corp_status_date) + ')' )
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
 
+    #IF( #TEXT(Input_corp_inc_state)='' )
      '' 
    #ELSE
        IF( le.Input_corp_inc_state = (TYPEOF(le.Input_corp_inc_state))'','',':corp_inc_state')
    #END
 
+    #IF( #TEXT(Input_corp_for_profit_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_for_profit_ind = (TYPEOF(le.Input_corp_for_profit_ind))'','',':corp_for_profit_ind')
    #END
 
+    #IF( #TEXT(Input_corp_foreign_domestic_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_foreign_domestic_ind = (TYPEOF(le.Input_corp_foreign_domestic_ind))'','',':corp_foreign_domestic_ind')
    #END
 
+    #IF( #TEXT(Input_corp_status_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_cd = (TYPEOF(le.Input_corp_status_cd))'','',':corp_status_cd')
    #END
 
+    #IF( #TEXT(Input_corp_orig_org_structure_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_org_structure_cd = (TYPEOF(le.Input_corp_orig_org_structure_cd))'','',':corp_orig_org_structure_cd')
    #END
 
+    #IF( #TEXT(Input_corp_fed_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_corp_fed_tax_id = (TYPEOF(le.Input_corp_fed_tax_id))'','',':corp_fed_tax_id')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_desc = (TYPEOF(le.Input_corp_forgn_state_desc))'','',':corp_forgn_state_desc')
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
