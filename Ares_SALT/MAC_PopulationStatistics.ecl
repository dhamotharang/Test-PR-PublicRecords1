 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_deleted = '',Input_fid = '',Input_id = '',Input_resource = '',Input_source = '',Input_summary_type = '',Input_type = '',Input_value = '',Input_status = '',Input_useinaddress = '',Input_link_href = '',Input_link_rel = '',OutFile) := MACRO
  IMPORT SALT311,Ares_SALT;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_deleted)='' )
      '' 
    #ELSE
        IF( le.Input_deleted = (TYPEOF(le.Input_deleted))'','',':deleted')
    #END
 
+    #IF( #TEXT(Input_fid)='' )
      '' 
    #ELSE
        IF( le.Input_fid = (TYPEOF(le.Input_fid))'','',':fid')
    #END
 
+    #IF( #TEXT(Input_id)='' )
      '' 
    #ELSE
        IF( le.Input_id = (TYPEOF(le.Input_id))'','',':id')
    #END
 
+    #IF( #TEXT(Input_resource)='' )
      '' 
    #ELSE
        IF( le.Input_resource = (TYPEOF(le.Input_resource))'','',':resource')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_summary_type)='' )
      '' 
    #ELSE
        IF( le.Input_summary_type = (TYPEOF(le.Input_summary_type))'','',':summary.type')
    #END
 
+    #IF( #TEXT(Input_type)='' )
      '' 
    #ELSE
        IF( le.Input_type = (TYPEOF(le.Input_type))'','',':type')
    #END
 
+    #IF( #TEXT(Input_value)='' )
      '' 
    #ELSE
        IF( le.Input_value = (TYPEOF(le.Input_value))'','',':value')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_useinaddress)='' )
      '' 
    #ELSE
        IF( le.Input_useinaddress = (TYPEOF(le.Input_useinaddress))'','',':useinaddress')
    #END
 
+    #IF( #TEXT(Input_link_href)='' )
      '' 
    #ELSE
        IF( le.Input_link_href = (TYPEOF(le.Input_link_href))'','',':link_href')
    #END
 
+    #IF( #TEXT(Input_link_rel)='' )
      '' 
    #ELSE
        IF( le.Input_link_rel = (TYPEOF(le.Input_link_rel))'','',':link_rel')
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
