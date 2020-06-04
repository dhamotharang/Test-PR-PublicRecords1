 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_process_date = '',Input_record_type = '',Input_pid = '',Input_address_type_code = '',Input_url = '',Input_sic1 = '',Input_sic2 = '',Input_sic3 = '',Input_sic4 = '',Input_sic5 = '',Input_incorporation_state = '',Input_email = '',Input_contact_title = '',Input_normcompany_type = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Infutor_NARB;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
 
+    #IF( #TEXT(Input_address_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_type_code = (TYPEOF(le.Input_address_type_code))'','',':address_type_code')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_sic1)='' )
      '' 
    #ELSE
        IF( le.Input_sic1 = (TYPEOF(le.Input_sic1))'','',':sic1')
    #END
 
+    #IF( #TEXT(Input_sic2)='' )
      '' 
    #ELSE
        IF( le.Input_sic2 = (TYPEOF(le.Input_sic2))'','',':sic2')
    #END
 
+    #IF( #TEXT(Input_sic3)='' )
      '' 
    #ELSE
        IF( le.Input_sic3 = (TYPEOF(le.Input_sic3))'','',':sic3')
    #END
 
+    #IF( #TEXT(Input_sic4)='' )
      '' 
    #ELSE
        IF( le.Input_sic4 = (TYPEOF(le.Input_sic4))'','',':sic4')
    #END
 
+    #IF( #TEXT(Input_sic5)='' )
      '' 
    #ELSE
        IF( le.Input_sic5 = (TYPEOF(le.Input_sic5))'','',':sic5')
    #END
 
+    #IF( #TEXT(Input_incorporation_state)='' )
      '' 
    #ELSE
        IF( le.Input_incorporation_state = (TYPEOF(le.Input_incorporation_state))'','',':incorporation_state')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_contact_title)='' )
      '' 
    #ELSE
        IF( le.Input_contact_title = (TYPEOF(le.Input_contact_title))'','',':contact_title')
    #END
 
+    #IF( #TEXT(Input_normcompany_type)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_type = (TYPEOF(le.Input_normcompany_type))'','',':normcompany_type')
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
