 
EXPORT Input_LT_MAC_PopulationStatistics(infile,Ref='',Input_orig_fname = '',Input_orig_lname = '',Input_orig_addr = '',Input_orig_city = '',Input_orig_zip4 = '',Input_orig_state = '',Input_orig_zip5 = '',Input_email = '',Input_phone = '',Input_employer = '',Input_dt = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Thrive;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
 
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
 
+    #IF( #TEXT(Input_orig_addr)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr = (TYPEOF(le.Input_orig_addr))'','',':orig_addr')
    #END
 
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
 
+    #IF( #TEXT(Input_orig_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4 = (TYPEOF(le.Input_orig_zip4))'','',':orig_zip4')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_orig_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip5 = (TYPEOF(le.Input_orig_zip5))'','',':orig_zip5')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_employer)='' )
      '' 
    #ELSE
        IF( le.Input_employer = (TYPEOF(le.Input_employer))'','',':employer')
    #END
 
+    #IF( #TEXT(Input_dt)='' )
      '' 
    #ELSE
        IF( le.Input_dt = (TYPEOF(le.Input_dt))'','',':dt')
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
