EXPORT MAC_PopulationStatistics(infile,Ref='',Input_agency_id = '',Input_agency_name = '',Input_source_id = '',Input_agency_state_abbr = '',Input_agency_ori = '',Input_allow_open_search = '',Input_append_overwrite_flag = '',Input_drivers_exchange_flag = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_eCrash_MBSAgency;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_agency_id)='' )
      '' 
    #ELSE
        IF( le.Input_agency_id = (TYPEOF(le.Input_agency_id))'','',':agency_id')
    #END
+    #IF( #TEXT(Input_agency_name)='' )
      '' 
    #ELSE
        IF( le.Input_agency_name = (TYPEOF(le.Input_agency_name))'','',':agency_name')
    #END
+    #IF( #TEXT(Input_source_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_id = (TYPEOF(le.Input_source_id))'','',':source_id')
    #END
+    #IF( #TEXT(Input_agency_state_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_agency_state_abbr = (TYPEOF(le.Input_agency_state_abbr))'','',':agency_state_abbr')
    #END
+    #IF( #TEXT(Input_agency_ori)='' )
      '' 
    #ELSE
        IF( le.Input_agency_ori = (TYPEOF(le.Input_agency_ori))'','',':agency_ori')
    #END
+    #IF( #TEXT(Input_allow_open_search)='' )
      '' 
    #ELSE
        IF( le.Input_allow_open_search = (TYPEOF(le.Input_allow_open_search))'','',':allow_open_search')
    #END
+    #IF( #TEXT(Input_append_overwrite_flag)='' )
      '' 
    #ELSE
        IF( le.Input_append_overwrite_flag = (TYPEOF(le.Input_append_overwrite_flag))'','',':append_overwrite_flag')
    #END
+    #IF( #TEXT(Input_drivers_exchange_flag)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_exchange_flag = (TYPEOF(le.Input_drivers_exchange_flag))'','',':drivers_exchange_flag')
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
