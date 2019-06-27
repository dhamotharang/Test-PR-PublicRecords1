 
EXPORT Input_CA_San_Diego_MAC_PopulationStatistics(infile,Ref='',Input_FILE_NUMBER = '',Input_FILE_DATE = '',Input_PREV_FILE_NUMBER = '',Input_PREV_FILE_DATE = '',Input_FILING_TYPE = '',Input_BUSINESS_NAME = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_FILE_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_FILE_DATE = (TYPEOF(le.Input_FILE_DATE))'','',':FILE_DATE')
    #END
 
+    #IF( #TEXT(Input_PREV_FILE_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_PREV_FILE_NUMBER = (TYPEOF(le.Input_PREV_FILE_NUMBER))'','',':PREV_FILE_NUMBER')
    #END
 
+    #IF( #TEXT(Input_PREV_FILE_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_PREV_FILE_DATE = (TYPEOF(le.Input_PREV_FILE_DATE))'','',':PREV_FILE_DATE')
    #END
 
+    #IF( #TEXT(Input_FILING_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_FILING_TYPE = (TYPEOF(le.Input_FILING_TYPE))'','',':FILING_TYPE')
    #END
 
+    #IF( #TEXT(Input_BUSINESS_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_NAME = (TYPEOF(le.Input_BUSINESS_NAME))'','',':BUSINESS_NAME')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line_last = (TYPEOF(le.Input_prep_addr_line_last))'','',':prep_addr_line_last')
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
