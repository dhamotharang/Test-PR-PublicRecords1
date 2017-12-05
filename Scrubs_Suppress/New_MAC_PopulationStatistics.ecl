 
EXPORT New_MAC_PopulationStatistics(infile,Ref='',Input_product = '',Input_linking_type = '',Input_linking_id = '',Input_document_type = '',Input_document_id = '',Input_date_added = '',Input_user = '',Input_compliance_id = '',Input_comment = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Suppress;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_product)='' )
      '' 
    #ELSE
        IF( le.Input_product = (TYPEOF(le.Input_product))'','',':product')
    #END
 
+    #IF( #TEXT(Input_linking_type)='' )
      '' 
    #ELSE
        IF( le.Input_linking_type = (TYPEOF(le.Input_linking_type))'','',':linking_type')
    #END
 
+    #IF( #TEXT(Input_linking_id)='' )
      '' 
    #ELSE
        IF( le.Input_linking_id = (TYPEOF(le.Input_linking_id))'','',':linking_id')
    #END
 
+    #IF( #TEXT(Input_document_type)='' )
      '' 
    #ELSE
        IF( le.Input_document_type = (TYPEOF(le.Input_document_type))'','',':document_type')
    #END
 
+    #IF( #TEXT(Input_document_id)='' )
      '' 
    #ELSE
        IF( le.Input_document_id = (TYPEOF(le.Input_document_id))'','',':document_id')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_user)='' )
      '' 
    #ELSE
        IF( le.Input_user = (TYPEOF(le.Input_user))'','',':user')
    #END
 
+    #IF( #TEXT(Input_compliance_id)='' )
      '' 
    #ELSE
        IF( le.Input_compliance_id = (TYPEOF(le.Input_compliance_id))'','',':compliance_id')
    #END
 
+    #IF( #TEXT(Input_comment)='' )
      '' 
    #ELSE
        IF( le.Input_comment = (TYPEOF(le.Input_comment))'','',':comment')
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
