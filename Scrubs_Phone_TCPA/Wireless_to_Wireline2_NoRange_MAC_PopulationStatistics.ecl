﻿ 
EXPORT Wireless_to_Wireline2_NoRange_MAC_PopulationStatistics(infile,Ref='',Input_cellphone = '',Input_lf = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Phone_TCPA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cellphone)='' )
      '' 
    #ELSE
        IF( le.Input_cellphone = (TYPEOF(le.Input_cellphone))'','',':cellphone')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
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
