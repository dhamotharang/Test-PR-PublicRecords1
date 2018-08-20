 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_name1 = '',Input_name2 = '',Input_date_filed = '',Input_file_number = '',Input_prep_addr1_line1 = '',Input_prep_addr1_line_last = '',Input_prep_addr2_line1 = '',Input_prep_addr2_line_last = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_name1)='' )
      '' 
    #ELSE
        IF( le.Input_name1 = (TYPEOF(le.Input_name1))'','',':name1')
    #END
 
+    #IF( #TEXT(Input_name2)='' )
      '' 
    #ELSE
        IF( le.Input_name2 = (TYPEOF(le.Input_name2))'','',':name2')
    #END
 
+    #IF( #TEXT(Input_date_filed)='' )
      '' 
    #ELSE
        IF( le.Input_date_filed = (TYPEOF(le.Input_date_filed))'','',':date_filed')
    #END
 
+    #IF( #TEXT(Input_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_number = (TYPEOF(le.Input_file_number))'','',':file_number')
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
