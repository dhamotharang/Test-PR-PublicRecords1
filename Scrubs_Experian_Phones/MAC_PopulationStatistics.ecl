EXPORT MAC_PopulationStatistics(infile,Ref='',Input_score = '',Input_encrypted_experian_pin = '',Input_phone_pos = '',Input_phone_digits = '',Input_phone_type = '',Input_phone_source = '',Input_phone_last_updt = '',Input_did = '',Input_did_score = '',Input_pin_did = '',Input_pin_title = '',Input_pin_fname = '',Input_pin_mname = '',Input_pin_lname = '',Input_pin_name_suffix = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_rec_type = '',Input_is_current = '',OutFile) := MACRO
  IMPORT SALT33,Scrubs_Experian_Phones;
  #uniquename(of)
  %of% := RECORD
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_score)='' )
      '' 
    #ELSE
        IF( le.Input_score = (TYPEOF(le.Input_score))'','',':score')
    #END
+    #IF( #TEXT(Input_encrypted_experian_pin)='' )
      '' 
    #ELSE
        IF( le.Input_encrypted_experian_pin = (TYPEOF(le.Input_encrypted_experian_pin))'','',':encrypted_experian_pin')
    #END
+    #IF( #TEXT(Input_phone_pos)='' )
      '' 
    #ELSE
        IF( le.Input_phone_pos = (TYPEOF(le.Input_phone_pos))'','',':phone_pos')
    #END
+    #IF( #TEXT(Input_phone_digits)='' )
      '' 
    #ELSE
        IF( le.Input_phone_digits = (TYPEOF(le.Input_phone_digits))'','',':phone_digits')
    #END
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
+    #IF( #TEXT(Input_phone_source)='' )
      '' 
    #ELSE
        IF( le.Input_phone_source = (TYPEOF(le.Input_phone_source))'','',':phone_source')
    #END
+    #IF( #TEXT(Input_phone_last_updt)='' )
      '' 
    #ELSE
        IF( le.Input_phone_last_updt = (TYPEOF(le.Input_phone_last_updt))'','',':phone_last_updt')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
+    #IF( #TEXT(Input_pin_did)='' )
      '' 
    #ELSE
        IF( le.Input_pin_did = (TYPEOF(le.Input_pin_did))'','',':pin_did')
    #END
+    #IF( #TEXT(Input_pin_title)='' )
      '' 
    #ELSE
        IF( le.Input_pin_title = (TYPEOF(le.Input_pin_title))'','',':pin_title')
    #END
+    #IF( #TEXT(Input_pin_fname)='' )
      '' 
    #ELSE
        IF( le.Input_pin_fname = (TYPEOF(le.Input_pin_fname))'','',':pin_fname')
    #END
+    #IF( #TEXT(Input_pin_mname)='' )
      '' 
    #ELSE
        IF( le.Input_pin_mname = (TYPEOF(le.Input_pin_mname))'','',':pin_mname')
    #END
+    #IF( #TEXT(Input_pin_lname)='' )
      '' 
    #ELSE
        IF( le.Input_pin_lname = (TYPEOF(le.Input_pin_lname))'','',':pin_lname')
    #END
+    #IF( #TEXT(Input_pin_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_pin_name_suffix = (TYPEOF(le.Input_pin_name_suffix))'','',':pin_name_suffix')
    #END
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
+    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_is_current)='' )
      '' 
    #ELSE
        IF( le.Input_is_current = (TYPEOF(le.Input_is_current))'','',':is_current')
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
