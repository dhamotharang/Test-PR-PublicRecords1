 
EXPORT Sources_MAC_PopulationStatistics(infile,Ref='',Input_auto_id = '',Input_transaction_id = '',Input_phonenumber = '',Input_lexid = '',Input_phone_id = '',Input_identity_id = '',Input_sequence_number = '',Input_totalsourcecount = '',Input_date_added = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhoneFinder;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_auto_id)='' )
      '' 
    #ELSE
        IF( le.Input_auto_id = (TYPEOF(le.Input_auto_id))'','',':auto_id')
    #END
 
+    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_phonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_phonenumber = (TYPEOF(le.Input_phonenumber))'','',':phonenumber')
    #END
 
+    #IF( #TEXT(Input_lexid)='' )
      '' 
    #ELSE
        IF( le.Input_lexid = (TYPEOF(le.Input_lexid))'','',':lexid')
    #END
 
+    #IF( #TEXT(Input_phone_id)='' )
      '' 
    #ELSE
        IF( le.Input_phone_id = (TYPEOF(le.Input_phone_id))'','',':phone_id')
    #END
 
+    #IF( #TEXT(Input_identity_id)='' )
      '' 
    #ELSE
        IF( le.Input_identity_id = (TYPEOF(le.Input_identity_id))'','',':identity_id')
    #END
 
+    #IF( #TEXT(Input_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_number = (TYPEOF(le.Input_sequence_number))'','',':sequence_number')
    #END
 
+    #IF( #TEXT(Input_totalsourcecount)='' )
      '' 
    #ELSE
        IF( le.Input_totalsourcecount = (TYPEOF(le.Input_totalsourcecount))'','',':totalsourcecount')
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
