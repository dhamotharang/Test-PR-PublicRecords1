 
EXPORT Input_FL_Filing_MAC_PopulationStatistics(infile,Ref='',Input_FIC_FIL_DOC_NUM = '',Input_FIC_FIL_NAME = '',Input_FIC_FIL_DATE = '',Input_FIC_OWNER_DOC_NUM = '',Input_FIC_OWNER_NAME = '',Input_p_owner_name = '',Input_c_owner_name = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',Input_prep_owner_addr_line1 = '',Input_prep_owner_addr_line_last = '',Input_seq = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_FIC_FIL_DOC_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_FIC_FIL_DOC_NUM = (TYPEOF(le.Input_FIC_FIL_DOC_NUM))'','',':FIC_FIL_DOC_NUM')
    #END
 
+    #IF( #TEXT(Input_FIC_FIL_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_FIC_FIL_NAME = (TYPEOF(le.Input_FIC_FIL_NAME))'','',':FIC_FIL_NAME')
    #END
 
+    #IF( #TEXT(Input_FIC_FIL_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_FIC_FIL_DATE = (TYPEOF(le.Input_FIC_FIL_DATE))'','',':FIC_FIL_DATE')
    #END
 
+    #IF( #TEXT(Input_FIC_OWNER_DOC_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_FIC_OWNER_DOC_NUM = (TYPEOF(le.Input_FIC_OWNER_DOC_NUM))'','',':FIC_OWNER_DOC_NUM')
    #END
 
+    #IF( #TEXT(Input_FIC_OWNER_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_FIC_OWNER_NAME = (TYPEOF(le.Input_FIC_OWNER_NAME))'','',':FIC_OWNER_NAME')
    #END
 
+    #IF( #TEXT(Input_p_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_owner_name = (TYPEOF(le.Input_p_owner_name))'','',':p_owner_name')
    #END
 
+    #IF( #TEXT(Input_c_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_c_owner_name = (TYPEOF(le.Input_c_owner_name))'','',':c_owner_name')
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
 
+    #IF( #TEXT(Input_prep_owner_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_owner_addr_line1 = (TYPEOF(le.Input_prep_owner_addr_line1))'','',':prep_owner_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_owner_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_owner_addr_line_last = (TYPEOF(le.Input_prep_owner_addr_line_last))'','',':prep_owner_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_seq)='' )
      '' 
    #ELSE
        IF( le.Input_seq = (TYPEOF(le.Input_seq))'','',':seq')
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
