 
EXPORT KeyGrowth_MAC_PopulationStatistics(infile,Ref='',Input_dataset_name = '',Input_file_type = '',Input_version = '',Input_wu = '',Input_count_oldfile = '',Input_count_newfile = '',Input_count_deduped_combined = '',Input_percent_change = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Risk_Indicators;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dataset_name)='' )
      '' 
    #ELSE
        IF( le.Input_dataset_name = (TYPEOF(le.Input_dataset_name))'','',':dataset_name')
    #END
 
+    #IF( #TEXT(Input_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_file_type = (TYPEOF(le.Input_file_type))'','',':file_type')
    #END
 
+    #IF( #TEXT(Input_version)='' )
      '' 
    #ELSE
        IF( le.Input_version = (TYPEOF(le.Input_version))'','',':version')
    #END
 
+    #IF( #TEXT(Input_wu)='' )
      '' 
    #ELSE
        IF( le.Input_wu = (TYPEOF(le.Input_wu))'','',':wu')
    #END
 
+    #IF( #TEXT(Input_count_oldfile)='' )
      '' 
    #ELSE
        IF( le.Input_count_oldfile = (TYPEOF(le.Input_count_oldfile))'','',':count_oldfile')
    #END
 
+    #IF( #TEXT(Input_count_newfile)='' )
      '' 
    #ELSE
        IF( le.Input_count_newfile = (TYPEOF(le.Input_count_newfile))'','',':count_newfile')
    #END
 
+    #IF( #TEXT(Input_count_deduped_combined)='' )
      '' 
    #ELSE
        IF( le.Input_count_deduped_combined = (TYPEOF(le.Input_count_deduped_combined))'','',':count_deduped_combined')
    #END
 
+    #IF( #TEXT(Input_percent_change)='' )
      '' 
    #ELSE
        IF( le.Input_percent_change = (TYPEOF(le.Input_percent_change))'','',':percent_change')
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
