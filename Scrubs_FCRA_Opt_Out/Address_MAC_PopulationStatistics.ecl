 
EXPORT Address_MAC_PopulationStatistics(infile,Ref='',Input_z5 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_ssn = '',Input_did = '',Input_source_flag = '',Input_julian_date = '',Input_inname_first = '',Input_inname_last = '',Input_address = '',Input_city = '',Input_state = '',Input_zip5 = '',Input_did_score = '',Input_ssn_append = '',Input_permanent_flag = '',Input_opt_back_in = '',Input_date_yyyymmdd = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_FCRA_Opt_Out;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_source_flag)='' )
      '' 
    #ELSE
        IF( le.Input_source_flag = (TYPEOF(le.Input_source_flag))'','',':source_flag')
    #END
 
+    #IF( #TEXT(Input_julian_date)='' )
      '' 
    #ELSE
        IF( le.Input_julian_date = (TYPEOF(le.Input_julian_date))'','',':julian_date')
    #END
 
+    #IF( #TEXT(Input_inname_first)='' )
      '' 
    #ELSE
        IF( le.Input_inname_first = (TYPEOF(le.Input_inname_first))'','',':inname_first')
    #END
 
+    #IF( #TEXT(Input_inname_last)='' )
      '' 
    #ELSE
        IF( le.Input_inname_last = (TYPEOF(le.Input_inname_last))'','',':inname_last')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
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
 
+    #IF( #TEXT(Input_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_zip5 = (TYPEOF(le.Input_zip5))'','',':zip5')
    #END
 
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
 
+    #IF( #TEXT(Input_ssn_append)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_append = (TYPEOF(le.Input_ssn_append))'','',':ssn_append')
    #END
 
+    #IF( #TEXT(Input_permanent_flag)='' )
      '' 
    #ELSE
        IF( le.Input_permanent_flag = (TYPEOF(le.Input_permanent_flag))'','',':permanent_flag')
    #END
 
+    #IF( #TEXT(Input_opt_back_in)='' )
      '' 
    #ELSE
        IF( le.Input_opt_back_in = (TYPEOF(le.Input_opt_back_in))'','',':opt_back_in')
    #END
 
+    #IF( #TEXT(Input_date_yyyymmdd)='' )
      '' 
    #ELSE
        IF( le.Input_date_yyyymmdd = (TYPEOF(le.Input_date_yyyymmdd))'','',':date_yyyymmdd')
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
