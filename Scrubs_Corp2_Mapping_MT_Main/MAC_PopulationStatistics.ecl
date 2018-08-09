 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_corp_ra_dt_first_seen = '',Input_corp_ra_dt_last_seen = '',Input_corp_process_date = '',Input_corp_key = '',Input_corp_orig_sos_charter_nbr = '',Input_corp_vendor = '',Input_corp_state_origin = '',Input_corp_inc_state = '',Input_corp_legal_name = '',Input_corp_ln_name_type_cd = '',Input_corp_filing_date = '',Input_corp_inc_date = '',Input_corp_forgn_date = '',Input_corp_foreign_domestic_ind = '',Input_corp_forgn_state_desc = '',Input_corp_trademark_class_desc1 = '',Input_corp_trademark_class_desc2 = '',Input_corp_trademark_class_desc3 = '',Input_corp_trademark_class_desc4 = '',Input_corp_trademark_class_desc5 = '',Input_corp_trademark_class_desc6 = '',Input_corp_term_exist_cd = '',Input_corp_term_exist_exp = '',Input_corp_status_desc = '',Input_corp_status_comment = '',Input_corp_trademark_first_use_date = '',Input_corp_trademark_first_use_date_in_state = '',Input_corp_trademark_renewal_date = '',Input_cont_title1_desc = '',Input_recordorigin = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Corp2_Mapping_MT_Main;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_first_reported = 0,'', ':dt_vendor_first_reported(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_first_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_last_reported = 0,'', ':dt_vendor_last_reported(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_last_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_first_seen = 0,'', ':dt_first_seen(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_dt_first_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_last_seen = 0,'', ':dt_last_seen(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_dt_last_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_first_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_dt_first_seen = 0,'', ':corp_ra_dt_first_seen(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_ra_dt_first_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_ra_dt_last_seen)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_ra_dt_last_seen = 0,'', ':corp_ra_dt_last_seen(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_ra_dt_last_seen) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_process_date = 0,'', ':corp_process_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_process_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_orig_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_orig_sos_charter_nbr = (TYPEOF(le.Input_corp_orig_sos_charter_nbr))'','',':corp_orig_sos_charter_nbr')
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
 
+    #IF( #TEXT(Input_corp_filing_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_filing_date = 0,'', ':corp_filing_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_filing_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_inc_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_inc_date = 0,'', ':corp_inc_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_inc_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_forgn_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_forgn_date = 0,'', ':corp_forgn_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_forgn_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_foreign_domestic_ind)='' )
      '' 
    #ELSE
        IF( le.Input_corp_foreign_domestic_ind = (TYPEOF(le.Input_corp_foreign_domestic_ind))'','',':corp_foreign_domestic_ind')
    #END
 
+    #IF( #TEXT(Input_corp_forgn_state_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_forgn_state_desc = (TYPEOF(le.Input_corp_forgn_state_desc))'','',':corp_forgn_state_desc')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc1)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc1 = (TYPEOF(le.Input_corp_trademark_class_desc1))'','',':corp_trademark_class_desc1')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc2)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc2 = (TYPEOF(le.Input_corp_trademark_class_desc2))'','',':corp_trademark_class_desc2')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc3)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc3 = (TYPEOF(le.Input_corp_trademark_class_desc3))'','',':corp_trademark_class_desc3')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc4)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc4 = (TYPEOF(le.Input_corp_trademark_class_desc4))'','',':corp_trademark_class_desc4')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc5)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc5 = (TYPEOF(le.Input_corp_trademark_class_desc5))'','',':corp_trademark_class_desc5')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_class_desc6)='' )
      '' 
    #ELSE
        IF( le.Input_corp_trademark_class_desc6 = (TYPEOF(le.Input_corp_trademark_class_desc6))'','',':corp_trademark_class_desc6')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_cd)='' )
      '' 
    #ELSE
        IF( le.Input_corp_term_exist_cd = (TYPEOF(le.Input_corp_term_exist_cd))'','',':corp_term_exist_cd')
    #END
 
+    #IF( #TEXT(Input_corp_term_exist_exp)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_term_exist_exp = 0,'', ':corp_term_exist_exp(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_term_exist_exp) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_desc = (TYPEOF(le.Input_corp_status_desc))'','',':corp_status_desc')
    #END
 
+    #IF( #TEXT(Input_corp_status_comment)='' )
      '' 
    #ELSE
        IF( le.Input_corp_status_comment = (TYPEOF(le.Input_corp_status_comment))'','',':corp_status_comment')
    #END
 
+    #IF( #TEXT(Input_corp_trademark_first_use_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_trademark_first_use_date = 0,'', ':corp_trademark_first_use_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_trademark_first_use_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_trademark_first_use_date_in_state)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_trademark_first_use_date_in_state = 0,'', ':corp_trademark_first_use_date_in_state(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_trademark_first_use_date_in_state) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_trademark_renewal_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_trademark_renewal_date = 0,'', ':corp_trademark_renewal_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_trademark_renewal_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_cont_title1_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cont_title1_desc = (TYPEOF(le.Input_cont_title1_desc))'','',':cont_title1_desc')
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
