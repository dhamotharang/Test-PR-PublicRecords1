 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_npa = '',Input_nxx = '',Input_tb = '',Input_city = '',Input_st = '',Input_ocn = '',Input_company_type = '',Input_nxx_type = '',Input_dial_ind = '',Input_point_id = '',Input_lf = '',Input_zip = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_TelcordiaTPM;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_npa)='' )
      '' 
    #ELSE
        IF( le.Input_npa = (TYPEOF(le.Input_npa))'','',':npa')
    #END
 
+    #IF( #TEXT(Input_nxx)='' )
      '' 
    #ELSE
        IF( le.Input_nxx = (TYPEOF(le.Input_nxx))'','',':nxx')
    #END
 
+    #IF( #TEXT(Input_tb)='' )
      '' 
    #ELSE
        IF( le.Input_tb = (TYPEOF(le.Input_tb))'','',':tb')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_ocn = (TYPEOF(le.Input_ocn))'','',':ocn')
    #END
 
+    #IF( #TEXT(Input_company_type)='' )
      '' 
    #ELSE
        IF( le.Input_company_type = (TYPEOF(le.Input_company_type))'','',':company_type')
    #END
 
+    #IF( #TEXT(Input_nxx_type)='' )
      '' 
    #ELSE
        IF( le.Input_nxx_type = (TYPEOF(le.Input_nxx_type))'','',':nxx_type')
    #END
 
+    #IF( #TEXT(Input_dial_ind)='' )
      '' 
    #ELSE
        IF( le.Input_dial_ind = (TYPEOF(le.Input_dial_ind))'','',':dial_ind')
    #END
 
+    #IF( #TEXT(Input_point_id)='' )
      '' 
    #ELSE
        IF( le.Input_point_id = (TYPEOF(le.Input_point_id))'','',':point_id')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
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
