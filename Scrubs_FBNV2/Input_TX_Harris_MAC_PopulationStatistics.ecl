 
EXPORT Input_TX_Harris_MAC_PopulationStatistics(infile,Ref='',Input_FILE_NUMBER = '',Input_DATE_FILED = '',Input_NAME1 = '',Input_NAME2 = '',Input_prep_addr1_line1 = '',Input_prep_addr1_line_last = '',Input_prep_addr2_line1 = '',Input_prep_addr2_line_last = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_FILE_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_FILE_NUMBER = (TYPEOF(le.Input_FILE_NUMBER))'','',':FILE_NUMBER')
    #END
 
+    #IF( #TEXT(Input_DATE_FILED)='' )
      '' 
    #ELSE
        IF( le.Input_DATE_FILED = (TYPEOF(le.Input_DATE_FILED))'','',':DATE_FILED')
    #END
 
+    #IF( #TEXT(Input_NAME1)='' )
      '' 
    #ELSE
        IF( le.Input_NAME1 = (TYPEOF(le.Input_NAME1))'','',':NAME1')
    #END
 
+    #IF( #TEXT(Input_NAME2)='' )
      '' 
    #ELSE
        IF( le.Input_NAME2 = (TYPEOF(le.Input_NAME2))'','',':NAME2')
    #END
 
+    #IF( #TEXT(Input_prep_addr1_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr1_line1 = (TYPEOF(le.Input_prep_addr1_line1))'','',':prep_addr1_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr1_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr1_line_last = (TYPEOF(le.Input_prep_addr1_line_last))'','',':prep_addr1_line_last')
    #END
 
+    #IF( #TEXT(Input_prep_addr2_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr2_line1 = (TYPEOF(le.Input_prep_addr2_line1))'','',':prep_addr2_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr2_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr2_line_last = (TYPEOF(le.Input_prep_addr2_line_last))'','',':prep_addr2_line_last')
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
