 
EXPORT OtherPhones_MAC_PopulationStatistics(infile,Ref='',Input_transaction_id = '',Input_sequence_number = '',Input_phone_id = '',Input_phonenumber = '',Input_risk_indicator = '',Input_phone_type = '',Input_phone_status = '',Input_listing_name = '',Input_porting_code = '',Input_phone_forwarded = '',Input_verified_carrier = '',Input_date_added = '',Input_identity_count = '',Input_carrier = '',Input_phone_star_rating = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhoneFinder;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_number = (TYPEOF(le.Input_sequence_number))'','',':sequence_number')
    #END
 
+    #IF( #TEXT(Input_phone_id)='' )
      '' 
    #ELSE
        IF( le.Input_phone_id = (TYPEOF(le.Input_phone_id))'','',':phone_id')
    #END
 
+    #IF( #TEXT(Input_phonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_phonenumber = (TYPEOF(le.Input_phonenumber))'','',':phonenumber')
    #END
 
+    #IF( #TEXT(Input_risk_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_risk_indicator = (TYPEOF(le.Input_risk_indicator))'','',':risk_indicator')
    #END
 
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
 
+    #IF( #TEXT(Input_phone_status)='' )
      '' 
    #ELSE
        IF( le.Input_phone_status = (TYPEOF(le.Input_phone_status))'','',':phone_status')
    #END
 
+    #IF( #TEXT(Input_listing_name)='' )
      '' 
    #ELSE
        IF( le.Input_listing_name = (TYPEOF(le.Input_listing_name))'','',':listing_name')
    #END
 
+    #IF( #TEXT(Input_porting_code)='' )
      '' 
    #ELSE
        IF( le.Input_porting_code = (TYPEOF(le.Input_porting_code))'','',':porting_code')
    #END
 
+    #IF( #TEXT(Input_phone_forwarded)='' )
      '' 
    #ELSE
        IF( le.Input_phone_forwarded = (TYPEOF(le.Input_phone_forwarded))'','',':phone_forwarded')
    #END
 
+    #IF( #TEXT(Input_verified_carrier)='' )
      '' 
    #ELSE
        IF( le.Input_verified_carrier = (TYPEOF(le.Input_verified_carrier))'','',':verified_carrier')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_identity_count)='' )
      '' 
    #ELSE
        IF( le.Input_identity_count = (TYPEOF(le.Input_identity_count))'','',':identity_count')
    #END
 
+    #IF( #TEXT(Input_carrier)='' )
      '' 
    #ELSE
        IF( le.Input_carrier = (TYPEOF(le.Input_carrier))'','',':carrier')
    #END
 
+    #IF( #TEXT(Input_phone_star_rating)='' )
      '' 
    #ELSE
        IF( le.Input_phone_star_rating = (TYPEOF(le.Input_phone_star_rating))'','',':phone_star_rating')
    #END
 
+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
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
