 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_orig_transaction_id = '',Input_orig_dateadded = '',Input_orig_billingid = '',Input_orig_function_name = '',Input_orig_adl = '',Input_orig_fname = '',Input_orig_lname = '',Input_orig_mname = '',Input_orig_ssn = '',Input_orig_address = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_phone = '',Input_orig_dob = '',Input_orig_dln = '',Input_orig_dln_st = '',Input_orig_glb = '',Input_orig_dppa = '',Input_orig_fcra = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_IDM;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_orig_transaction_id = (TYPEOF(le.Input_orig_transaction_id))'','',':orig_transaction_id')
    #END
 
+    #IF( #TEXT(Input_orig_dateadded)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dateadded = (TYPEOF(le.Input_orig_dateadded))'','',':orig_dateadded')
    #END
 
+    #IF( #TEXT(Input_orig_billingid)='' )
      '' 
    #ELSE
        IF( le.Input_orig_billingid = (TYPEOF(le.Input_orig_billingid))'','',':orig_billingid')
    #END
 
+    #IF( #TEXT(Input_orig_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_function_name = (TYPEOF(le.Input_orig_function_name))'','',':orig_function_name')
    #END
 
+    #IF( #TEXT(Input_orig_adl)='' )
      '' 
    #ELSE
        IF( le.Input_orig_adl = (TYPEOF(le.Input_orig_adl))'','',':orig_adl')
    #END
 
+    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
 
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
 
+    #IF( #TEXT(Input_orig_mname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mname = (TYPEOF(le.Input_orig_mname))'','',':orig_mname')
    #END
 
+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END
 
+    #IF( #TEXT(Input_orig_address)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address = (TYPEOF(le.Input_orig_address))'','',':orig_address')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_dln)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dln = (TYPEOF(le.Input_orig_dln))'','',':orig_dln')
    #END
 
+    #IF( #TEXT(Input_orig_dln_st)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dln_st = (TYPEOF(le.Input_orig_dln_st))'','',':orig_dln_st')
    #END
 
+    #IF( #TEXT(Input_orig_glb)='' )
      '' 
    #ELSE
        IF( le.Input_orig_glb = (TYPEOF(le.Input_orig_glb))'','',':orig_glb')
    #END
 
+    #IF( #TEXT(Input_orig_dppa)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dppa = (TYPEOF(le.Input_orig_dppa))'','',':orig_dppa')
    #END
 
+    #IF( #TEXT(Input_orig_fcra)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fcra = (TYPEOF(le.Input_orig_fcra))'','',':orig_fcra')
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
