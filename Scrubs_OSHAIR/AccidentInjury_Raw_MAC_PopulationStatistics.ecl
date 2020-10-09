 
EXPORT AccidentInjury_Raw_MAC_PopulationStatistics(infile,Ref='',Input_summary_nr = '',Input_rel_insp_nr = '',Input_age = '',Input_sex = '',Input_nature_of_inj = '',Input_part_of_body = '',Input_src_of_injury = '',Input_event_type = '',Input_evn_factor = '',Input_hum_factor = '',Input_occ_code = '',Input_degree_of_inj = '',Input_task_assigned = '',Input_hazsub = '',Input_const_op = '',Input_const_op_cause = '',Input_fat_cause = '',Input_fall_distance = '',Input_fall_ht = '',Input_injury_line_nr = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_rel_insp_nr)='' )
      '' 
    #ELSE
        IF( le.Input_rel_insp_nr = (TYPEOF(le.Input_rel_insp_nr))'','',':rel_insp_nr')
    #END
 
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
 
+    #IF( #TEXT(Input_sex)='' )
      '' 
    #ELSE
        IF( le.Input_sex = (TYPEOF(le.Input_sex))'','',':sex')
    #END
 
+    #IF( #TEXT(Input_nature_of_inj)='' )
      '' 
    #ELSE
        IF( le.Input_nature_of_inj = (TYPEOF(le.Input_nature_of_inj))'','',':nature_of_inj')
    #END
 
+    #IF( #TEXT(Input_part_of_body)='' )
      '' 
    #ELSE
        IF( le.Input_part_of_body = (TYPEOF(le.Input_part_of_body))'','',':part_of_body')
    #END
 
+    #IF( #TEXT(Input_src_of_injury)='' )
      '' 
    #ELSE
        IF( le.Input_src_of_injury = (TYPEOF(le.Input_src_of_injury))'','',':src_of_injury')
    #END
 
+    #IF( #TEXT(Input_event_type)='' )
      '' 
    #ELSE
        IF( le.Input_event_type = (TYPEOF(le.Input_event_type))'','',':event_type')
    #END
 
+    #IF( #TEXT(Input_evn_factor)='' )
      '' 
    #ELSE
        IF( le.Input_evn_factor = (TYPEOF(le.Input_evn_factor))'','',':evn_factor')
    #END
 
+    #IF( #TEXT(Input_hum_factor)='' )
      '' 
    #ELSE
        IF( le.Input_hum_factor = (TYPEOF(le.Input_hum_factor))'','',':hum_factor')
    #END
 
+    #IF( #TEXT(Input_occ_code)='' )
      '' 
    #ELSE
        IF( le.Input_occ_code = (TYPEOF(le.Input_occ_code))'','',':occ_code')
    #END
 
+    #IF( #TEXT(Input_degree_of_inj)='' )
      '' 
    #ELSE
        IF( le.Input_degree_of_inj = (TYPEOF(le.Input_degree_of_inj))'','',':degree_of_inj')
    #END
 
+    #IF( #TEXT(Input_task_assigned)='' )
      '' 
    #ELSE
        IF( le.Input_task_assigned = (TYPEOF(le.Input_task_assigned))'','',':task_assigned')
    #END
 
+    #IF( #TEXT(Input_hazsub)='' )
      '' 
    #ELSE
        IF( le.Input_hazsub = (TYPEOF(le.Input_hazsub))'','',':hazsub')
    #END
 
+    #IF( #TEXT(Input_const_op)='' )
      '' 
    #ELSE
        IF( le.Input_const_op = (TYPEOF(le.Input_const_op))'','',':const_op')
    #END
 
+    #IF( #TEXT(Input_const_op_cause)='' )
      '' 
    #ELSE
        IF( le.Input_const_op_cause = (TYPEOF(le.Input_const_op_cause))'','',':const_op_cause')
    #END
 
+    #IF( #TEXT(Input_fat_cause)='' )
      '' 
    #ELSE
        IF( le.Input_fat_cause = (TYPEOF(le.Input_fat_cause))'','',':fat_cause')
    #END
 
+    #IF( #TEXT(Input_fall_distance)='' )
      '' 
    #ELSE
        IF( le.Input_fall_distance = (TYPEOF(le.Input_fall_distance))'','',':fall_distance')
    #END
 
+    #IF( #TEXT(Input_fall_ht)='' )
      '' 
    #ELSE
        IF( le.Input_fall_ht = (TYPEOF(le.Input_fall_ht))'','',':fall_ht')
    #END
 
+    #IF( #TEXT(Input_injury_line_nr)='' )
      '' 
    #ELSE
        IF( le.Input_injury_line_nr = (TYPEOF(le.Input_injury_line_nr))'','',':injury_line_nr')
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
