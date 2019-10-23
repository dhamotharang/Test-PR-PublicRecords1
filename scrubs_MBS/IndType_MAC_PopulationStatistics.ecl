 
EXPORT IndType_MAC_PopulationStatistics(infile,Ref='',Input_ind_type = '',Input_description = '',Input_status = '',Input_date_added = '',Input_user_added = '',Input_date_changed = '',Input_user_changed = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_MBS;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ind_type)='' )
      '' 
    #ELSE
        IF( le.Input_ind_type = (TYPEOF(le.Input_ind_type))'','',':ind_type')
    #END
 
+    #IF( #TEXT(Input_description)='' )
      '' 
    #ELSE
        IF( le.Input_description = (TYPEOF(le.Input_description))'','',':description')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_user_added)='' )
      '' 
    #ELSE
        IF( le.Input_user_added = (TYPEOF(le.Input_user_added))'','',':user_added')
    #END
 
+    #IF( #TEXT(Input_date_changed)='' )
      '' 
    #ELSE
        IF( le.Input_date_changed = (TYPEOF(le.Input_date_changed))'','',':date_changed')
    #END
 
+    #IF( #TEXT(Input_user_changed)='' )
      '' 
    #ELSE
        IF( le.Input_user_changed = (TYPEOF(le.Input_user_changed))'','',':user_changed')
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
