 
EXPORT Input_FL_Event_MAC_PopulationStatistics(infile,Ref='',Input_EVENT_DOC_NUMBER = '',Input_EVENT_ORIG_DOC_NUMBER = '',Input_EVENT_DATE = '',Input_ACTION_OWN_NAME = '',Input_prep_old_addr_line1 = '',Input_prep_old_addr_line_last = '',Input_prep_new_addr_line1 = '',Input_prep_new_addr_line_last = '',Input_prep_owner_addr_line1 = '',Input_prep_owner_addr_line_last = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_EVENT_DOC_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_EVENT_DOC_NUMBER = (TYPEOF(le.Input_EVENT_DOC_NUMBER))'','',':EVENT_DOC_NUMBER')
    #END
 
+    #IF( #TEXT(Input_EVENT_ORIG_DOC_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_EVENT_ORIG_DOC_NUMBER = (TYPEOF(le.Input_EVENT_ORIG_DOC_NUMBER))'','',':EVENT_ORIG_DOC_NUMBER')
    #END
 
+    #IF( #TEXT(Input_EVENT_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_EVENT_DATE = (TYPEOF(le.Input_EVENT_DATE))'','',':EVENT_DATE')
    #END
 
+    #IF( #TEXT(Input_ACTION_OWN_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_ACTION_OWN_NAME = (TYPEOF(le.Input_ACTION_OWN_NAME))'','',':ACTION_OWN_NAME')
    #END
 
+    #IF( #TEXT(Input_prep_old_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_old_addr_line1 = (TYPEOF(le.Input_prep_old_addr_line1))'','',':prep_old_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_old_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_old_addr_line_last = (TYPEOF(le.Input_prep_old_addr_line_last))'','',':prep_old_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_prep_new_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_new_addr_line1 = (TYPEOF(le.Input_prep_new_addr_line1))'','',':prep_new_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_new_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_new_addr_line_last = (TYPEOF(le.Input_prep_new_addr_line_last))'','',':prep_new_addr_line_last')
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
