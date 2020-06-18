 
EXPORT Identities_MAC_PopulationStatistics(infile,Ref='',Input_transaction_id = '',Input_sequence_number = '',Input_lexid = '',Input_full_name = '',Input_full_address = '',Input_city = '',Input_state = '',Input_zip = '',Input_verified_carrier = '',Input_date_added = '',Input_filename = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_lexid)='' )
      '' 
    #ELSE
        IF( le.Input_lexid = (TYPEOF(le.Input_lexid))'','',':lexid')
    #END
 
+    #IF( #TEXT(Input_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_full_name = (TYPEOF(le.Input_full_name))'','',':full_name')
    #END
 
+    #IF( #TEXT(Input_full_address)='' )
      '' 
    #ELSE
        IF( le.Input_full_address = (TYPEOF(le.Input_full_address))'','',':full_address')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
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
