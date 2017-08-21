 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_first_name = '',Input_middle_initial = '',Input_last_name = '',Input_suffix = '',Input_former_first_name = '',Input_former_middle_initial = '',Input_former_last_name = '',Input_former_suffix = '',Input_former_first_name2 = '',Input_former_middle_initial2 = '',Input_former_last_name2 = '',Input_former_suffix2 = '',Input_aka_first_name = '',Input_aka_middle_initial = '',Input_aka_last_name = '',Input_aka_suffix = '',Input_current_address = '',Input_current_city = '',Input_current_state = '',Input_current_zip = '',Input_current_address_date_reported = '',Input_former1_address = '',Input_former1_city = '',Input_former1_state = '',Input_former1_zip = '',Input_former1_address_date_reported = '',Input_former2_address = '',Input_former2_city = '',Input_former2_state = '',Input_former2_zip = '',Input_former2_address_date_reported = '',Input_blank1 = '',Input_ssn = '',Input_cid = '',Input_ssn_confirmed = '',Input_blank2 = '',Input_blank3 = '',OutFile) := MACRO
  IMPORT SALT36,Scrubs_Equifax_Monthly;
  #uniquename(of)
  %of% := RECORD
    SALT36.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial = (TYPEOF(le.Input_middle_initial))'','',':middle_initial')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_former_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_former_first_name = (TYPEOF(le.Input_former_first_name))'','',':former_first_name')
    #END
 
+    #IF( #TEXT(Input_former_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_former_middle_initial = (TYPEOF(le.Input_former_middle_initial))'','',':former_middle_initial')
    #END
 
+    #IF( #TEXT(Input_former_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_former_last_name = (TYPEOF(le.Input_former_last_name))'','',':former_last_name')
    #END
 
+    #IF( #TEXT(Input_former_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_former_suffix = (TYPEOF(le.Input_former_suffix))'','',':former_suffix')
    #END
 
+    #IF( #TEXT(Input_former_first_name2)='' )
      '' 
    #ELSE
        IF( le.Input_former_first_name2 = (TYPEOF(le.Input_former_first_name2))'','',':former_first_name2')
    #END
 
+    #IF( #TEXT(Input_former_middle_initial2)='' )
      '' 
    #ELSE
        IF( le.Input_former_middle_initial2 = (TYPEOF(le.Input_former_middle_initial2))'','',':former_middle_initial2')
    #END
 
+    #IF( #TEXT(Input_former_last_name2)='' )
      '' 
    #ELSE
        IF( le.Input_former_last_name2 = (TYPEOF(le.Input_former_last_name2))'','',':former_last_name2')
    #END
 
+    #IF( #TEXT(Input_former_suffix2)='' )
      '' 
    #ELSE
        IF( le.Input_former_suffix2 = (TYPEOF(le.Input_former_suffix2))'','',':former_suffix2')
    #END
 
+    #IF( #TEXT(Input_aka_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_aka_first_name = (TYPEOF(le.Input_aka_first_name))'','',':aka_first_name')
    #END
 
+    #IF( #TEXT(Input_aka_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_aka_middle_initial = (TYPEOF(le.Input_aka_middle_initial))'','',':aka_middle_initial')
    #END
 
+    #IF( #TEXT(Input_aka_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_aka_last_name = (TYPEOF(le.Input_aka_last_name))'','',':aka_last_name')
    #END
 
+    #IF( #TEXT(Input_aka_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_aka_suffix = (TYPEOF(le.Input_aka_suffix))'','',':aka_suffix')
    #END
 
+    #IF( #TEXT(Input_current_address)='' )
      '' 
    #ELSE
        IF( le.Input_current_address = (TYPEOF(le.Input_current_address))'','',':current_address')
    #END
 
+    #IF( #TEXT(Input_current_city)='' )
      '' 
    #ELSE
        IF( le.Input_current_city = (TYPEOF(le.Input_current_city))'','',':current_city')
    #END
 
+    #IF( #TEXT(Input_current_state)='' )
      '' 
    #ELSE
        IF( le.Input_current_state = (TYPEOF(le.Input_current_state))'','',':current_state')
    #END
 
+    #IF( #TEXT(Input_current_zip)='' )
      '' 
    #ELSE
        IF( le.Input_current_zip = (TYPEOF(le.Input_current_zip))'','',':current_zip')
    #END
 
+    #IF( #TEXT(Input_current_address_date_reported)='' )
      '' 
    #ELSE
        IF( le.Input_current_address_date_reported = (TYPEOF(le.Input_current_address_date_reported))'','',':current_address_date_reported')
    #END
 
+    #IF( #TEXT(Input_former1_address)='' )
      '' 
    #ELSE
        IF( le.Input_former1_address = (TYPEOF(le.Input_former1_address))'','',':former1_address')
    #END
 
+    #IF( #TEXT(Input_former1_city)='' )
      '' 
    #ELSE
        IF( le.Input_former1_city = (TYPEOF(le.Input_former1_city))'','',':former1_city')
    #END
 
+    #IF( #TEXT(Input_former1_state)='' )
      '' 
    #ELSE
        IF( le.Input_former1_state = (TYPEOF(le.Input_former1_state))'','',':former1_state')
    #END
 
+    #IF( #TEXT(Input_former1_zip)='' )
      '' 
    #ELSE
        IF( le.Input_former1_zip = (TYPEOF(le.Input_former1_zip))'','',':former1_zip')
    #END
 
+    #IF( #TEXT(Input_former1_address_date_reported)='' )
      '' 
    #ELSE
        IF( le.Input_former1_address_date_reported = (TYPEOF(le.Input_former1_address_date_reported))'','',':former1_address_date_reported')
    #END
 
+    #IF( #TEXT(Input_former2_address)='' )
      '' 
    #ELSE
        IF( le.Input_former2_address = (TYPEOF(le.Input_former2_address))'','',':former2_address')
    #END
 
+    #IF( #TEXT(Input_former2_city)='' )
      '' 
    #ELSE
        IF( le.Input_former2_city = (TYPEOF(le.Input_former2_city))'','',':former2_city')
    #END
 
+    #IF( #TEXT(Input_former2_state)='' )
      '' 
    #ELSE
        IF( le.Input_former2_state = (TYPEOF(le.Input_former2_state))'','',':former2_state')
    #END
 
+    #IF( #TEXT(Input_former2_zip)='' )
      '' 
    #ELSE
        IF( le.Input_former2_zip = (TYPEOF(le.Input_former2_zip))'','',':former2_zip')
    #END
 
+    #IF( #TEXT(Input_former2_address_date_reported)='' )
      '' 
    #ELSE
        IF( le.Input_former2_address_date_reported = (TYPEOF(le.Input_former2_address_date_reported))'','',':former2_address_date_reported')
    #END
 
+    #IF( #TEXT(Input_blank1)='' )
      '' 
    #ELSE
        IF( le.Input_blank1 = (TYPEOF(le.Input_blank1))'','',':blank1')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_cid)='' )
      '' 
    #ELSE
        IF( le.Input_cid = (TYPEOF(le.Input_cid))'','',':cid')
    #END
 
+    #IF( #TEXT(Input_ssn_confirmed)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_confirmed = (TYPEOF(le.Input_ssn_confirmed))'','',':ssn_confirmed')
    #END
 
+    #IF( #TEXT(Input_blank2)='' )
      '' 
    #ELSE
        IF( le.Input_blank2 = (TYPEOF(le.Input_blank2))'','',':blank2')
    #END
 
+    #IF( #TEXT(Input_blank3)='' )
      '' 
    #ELSE
        IF( le.Input_blank3 = (TYPEOF(le.Input_blank3))'','',':blank3')
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
