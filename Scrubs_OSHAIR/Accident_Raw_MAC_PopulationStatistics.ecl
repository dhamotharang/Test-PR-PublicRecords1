 
EXPORT Accident_Raw_MAC_PopulationStatistics(infile,Ref='',Input_summary_nr = '',Input_report_id = '',Input_event_date_time = '',Input_const_end_use = '',Input_build_stories = '',Input_nonbuild_ht = '',Input_project_cost = '',Input_project_type = '',Input_sic_list = '',Input_fatality = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_summary_nr)='' )
      '' 
    #ELSE
        IF( le.Input_summary_nr = (TYPEOF(le.Input_summary_nr))'','',':summary_nr')
    #END
 
+    #IF( #TEXT(Input_report_id)='' )
      '' 
    #ELSE
        IF( le.Input_report_id = (TYPEOF(le.Input_report_id))'','',':report_id')
    #END
 
+    #IF( #TEXT(Input_event_date_time)='' )
      '' 
    #ELSE
        IF( le.Input_event_date_time = (TYPEOF(le.Input_event_date_time))'','',':event_date_time')
    #END
 
+    #IF( #TEXT(Input_const_end_use)='' )
      '' 
    #ELSE
        IF( le.Input_const_end_use = (TYPEOF(le.Input_const_end_use))'','',':const_end_use')
    #END
 
+    #IF( #TEXT(Input_build_stories)='' )
      '' 
    #ELSE
        IF( le.Input_build_stories = (TYPEOF(le.Input_build_stories))'','',':build_stories')
    #END
 
+    #IF( #TEXT(Input_nonbuild_ht)='' )
      '' 
    #ELSE
        IF( le.Input_nonbuild_ht = (TYPEOF(le.Input_nonbuild_ht))'','',':nonbuild_ht')
    #END
 
+    #IF( #TEXT(Input_project_cost)='' )
      '' 
    #ELSE
        IF( le.Input_project_cost = (TYPEOF(le.Input_project_cost))'','',':project_cost')
    #END
 
+    #IF( #TEXT(Input_project_type)='' )
      '' 
    #ELSE
        IF( le.Input_project_type = (TYPEOF(le.Input_project_type))'','',':project_type')
    #END
 
+    #IF( #TEXT(Input_sic_list)='' )
      '' 
    #ELSE
        IF( le.Input_sic_list = (TYPEOF(le.Input_sic_list))'','',':sic_list')
    #END
 
+    #IF( #TEXT(Input_fatality)='' )
      '' 
    #ELSE
        IF( le.Input_fatality = (TYPEOF(le.Input_fatality))'','',':fatality')
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
