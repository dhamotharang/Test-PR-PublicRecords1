 
EXPORT Lerg1Raw_MAC_PopulationStatistics(infile,Ref='',Input_ocn = '',Input_ocn_name = '',Input_ocn_abbr_name = '',Input_ocn_state = '',Input_category = '',Input_overall_ocn = '',Input_filler1 = '',Input_filler2 = '',Input_last_name = '',Input_first_name = '',Input_middle_initial = '',Input_company_name = '',Input_title = '',Input_address1 = '',Input_address2 = '',Input_floor = '',Input_room = '',Input_city = '',Input_state = '',Input_postal_code = '',Input_phone = '',Input_target_ocn = '',Input_overall_target_ocn = '',Input_rural_lec_indicator = '',Input_small_ilec_indicator = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_ocn = (TYPEOF(le.Input_ocn))'','',':ocn')
    #END
 
+    #IF( #TEXT(Input_ocn_name)='' )
      '' 
    #ELSE
        IF( le.Input_ocn_name = (TYPEOF(le.Input_ocn_name))'','',':ocn_name')
    #END
 
+    #IF( #TEXT(Input_ocn_abbr_name)='' )
      '' 
    #ELSE
        IF( le.Input_ocn_abbr_name = (TYPEOF(le.Input_ocn_abbr_name))'','',':ocn_abbr_name')
    #END
 
+    #IF( #TEXT(Input_ocn_state)='' )
      '' 
    #ELSE
        IF( le.Input_ocn_state = (TYPEOF(le.Input_ocn_state))'','',':ocn_state')
    #END
 
+    #IF( #TEXT(Input_category)='' )
      '' 
    #ELSE
        IF( le.Input_category = (TYPEOF(le.Input_category))'','',':category')
    #END
 
+    #IF( #TEXT(Input_overall_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_overall_ocn = (TYPEOF(le.Input_overall_ocn))'','',':overall_ocn')
    #END
 
+    #IF( #TEXT(Input_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_filler1 = (TYPEOF(le.Input_filler1))'','',':filler1')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial = (TYPEOF(le.Input_middle_initial))'','',':middle_initial')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_floor)='' )
      '' 
    #ELSE
        IF( le.Input_floor = (TYPEOF(le.Input_floor))'','',':floor')
    #END
 
+    #IF( #TEXT(Input_room)='' )
      '' 
    #ELSE
        IF( le.Input_room = (TYPEOF(le.Input_room))'','',':room')
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
 
+    #IF( #TEXT(Input_postal_code)='' )
      '' 
    #ELSE
        IF( le.Input_postal_code = (TYPEOF(le.Input_postal_code))'','',':postal_code')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_target_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_target_ocn = (TYPEOF(le.Input_target_ocn))'','',':target_ocn')
    #END
 
+    #IF( #TEXT(Input_overall_target_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_overall_target_ocn = (TYPEOF(le.Input_overall_target_ocn))'','',':overall_target_ocn')
    #END
 
+    #IF( #TEXT(Input_rural_lec_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_rural_lec_indicator = (TYPEOF(le.Input_rural_lec_indicator))'','',':rural_lec_indicator')
    #END
 
+    #IF( #TEXT(Input_small_ilec_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_small_ilec_indicator = (TYPEOF(le.Input_small_ilec_indicator))'','',':small_ilec_indicator')
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
