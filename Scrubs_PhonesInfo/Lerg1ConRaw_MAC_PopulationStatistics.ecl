 
EXPORT Lerg1ConRaw_MAC_PopulationStatistics(infile,Ref='',Input_ocn = '',Input_ocn_name = '',Input_ocn_state = '',Input_contact_function = '',Input_contact_phone = '',Input_contact_information = '',Input_filler = '',Input_filename = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_ocn_state)='' )
      '' 
    #ELSE
        IF( le.Input_ocn_state = (TYPEOF(le.Input_ocn_state))'','',':ocn_state')
    #END
 
+    #IF( #TEXT(Input_contact_function)='' )
      '' 
    #ELSE
        IF( le.Input_contact_function = (TYPEOF(le.Input_contact_function))'','',':contact_function')
    #END
 
+    #IF( #TEXT(Input_contact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_contact_phone = (TYPEOF(le.Input_contact_phone))'','',':contact_phone')
    #END
 
+    #IF( #TEXT(Input_contact_information)='' )
      '' 
    #ELSE
        IF( le.Input_contact_information = (TYPEOF(le.Input_contact_information))'','',':contact_information')
    #END
 
+    #IF( #TEXT(Input_filler)='' )
      '' 
    #ELSE
        IF( le.Input_filler = (TYPEOF(le.Input_filler))'','',':filler')
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
