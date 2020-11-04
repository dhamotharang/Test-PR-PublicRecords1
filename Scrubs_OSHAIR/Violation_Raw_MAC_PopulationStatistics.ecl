 
EXPORT Violation_Raw_MAC_PopulationStatistics(infile,Ref='',Input_activity_nr = '',Input_citation_id = '',Input_delete_flag = '',Input_viol_type = '',Input_issuance_date = '',Input_abate_date = '',Input_current_penalty = '',Input_initial_penalty = '',Input_contest_date = '',Input_final_order_date = '',Input_nr_instances = '',Input_nr_exposed = '',Input_rec = '',Input_gravity = '',Input_emphasis = '',Input_hazcat = '',Input_fta_insp_nr = '',Input_fta_issuance_date = '',Input_fta_penalty = '',Input_fta_contest_date = '',Input_fta_final_order_date = '',Input_hazsub1 = '',Input_hazsub2 = '',Input_hazsub3 = '',Input_hazsub4 = '',Input_hazsub5 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_activity_nr)='' )
      '' 
    #ELSE
        IF( le.Input_activity_nr = (TYPEOF(le.Input_activity_nr))'','',':activity_nr')
    #END
 
+    #IF( #TEXT(Input_citation_id)='' )
      '' 
    #ELSE
        IF( le.Input_citation_id = (TYPEOF(le.Input_citation_id))'','',':citation_id')
    #END
 
+    #IF( #TEXT(Input_delete_flag)='' )
      '' 
    #ELSE
        IF( le.Input_delete_flag = (TYPEOF(le.Input_delete_flag))'','',':delete_flag')
    #END
 
+    #IF( #TEXT(Input_viol_type)='' )
      '' 
    #ELSE
        IF( le.Input_viol_type = (TYPEOF(le.Input_viol_type))'','',':viol_type')
    #END
 
+    #IF( #TEXT(Input_issuance_date)='' )
      '' 
    #ELSE
        IF( le.Input_issuance_date = (TYPEOF(le.Input_issuance_date))'','',':issuance_date')
    #END
 
+    #IF( #TEXT(Input_abate_date)='' )
      '' 
    #ELSE
        IF( le.Input_abate_date = (TYPEOF(le.Input_abate_date))'','',':abate_date')
    #END
 
+    #IF( #TEXT(Input_current_penalty)='' )
      '' 
    #ELSE
        IF( le.Input_current_penalty = (TYPEOF(le.Input_current_penalty))'','',':current_penalty')
    #END
 
+    #IF( #TEXT(Input_initial_penalty)='' )
      '' 
    #ELSE
        IF( le.Input_initial_penalty = (TYPEOF(le.Input_initial_penalty))'','',':initial_penalty')
    #END
 
+    #IF( #TEXT(Input_contest_date)='' )
      '' 
    #ELSE
        IF( le.Input_contest_date = (TYPEOF(le.Input_contest_date))'','',':contest_date')
    #END
 
+    #IF( #TEXT(Input_final_order_date)='' )
      '' 
    #ELSE
        IF( le.Input_final_order_date = (TYPEOF(le.Input_final_order_date))'','',':final_order_date')
    #END
 
+    #IF( #TEXT(Input_nr_instances)='' )
      '' 
    #ELSE
        IF( le.Input_nr_instances = (TYPEOF(le.Input_nr_instances))'','',':nr_instances')
    #END
 
+    #IF( #TEXT(Input_nr_exposed)='' )
      '' 
    #ELSE
        IF( le.Input_nr_exposed = (TYPEOF(le.Input_nr_exposed))'','',':nr_exposed')
    #END
 
+    #IF( #TEXT(Input_rec)='' )
      '' 
    #ELSE
        IF( le.Input_rec = (TYPEOF(le.Input_rec))'','',':rec')
    #END
 
+    #IF( #TEXT(Input_gravity)='' )
      '' 
    #ELSE
        IF( le.Input_gravity = (TYPEOF(le.Input_gravity))'','',':gravity')
    #END
 
+    #IF( #TEXT(Input_emphasis)='' )
      '' 
    #ELSE
        IF( le.Input_emphasis = (TYPEOF(le.Input_emphasis))'','',':emphasis')
    #END
 
+    #IF( #TEXT(Input_hazcat)='' )
      '' 
    #ELSE
        IF( le.Input_hazcat = (TYPEOF(le.Input_hazcat))'','',':hazcat')
    #END
 
+    #IF( #TEXT(Input_fta_insp_nr)='' )
      '' 
    #ELSE
        IF( le.Input_fta_insp_nr = (TYPEOF(le.Input_fta_insp_nr))'','',':fta_insp_nr')
    #END
 
+    #IF( #TEXT(Input_fta_issuance_date)='' )
      '' 
    #ELSE
        IF( le.Input_fta_issuance_date = (TYPEOF(le.Input_fta_issuance_date))'','',':fta_issuance_date')
    #END
 
+    #IF( #TEXT(Input_fta_penalty)='' )
      '' 
    #ELSE
        IF( le.Input_fta_penalty = (TYPEOF(le.Input_fta_penalty))'','',':fta_penalty')
    #END
 
+    #IF( #TEXT(Input_fta_contest_date)='' )
      '' 
    #ELSE
        IF( le.Input_fta_contest_date = (TYPEOF(le.Input_fta_contest_date))'','',':fta_contest_date')
    #END
 
+    #IF( #TEXT(Input_fta_final_order_date)='' )
      '' 
    #ELSE
        IF( le.Input_fta_final_order_date = (TYPEOF(le.Input_fta_final_order_date))'','',':fta_final_order_date')
    #END
 
+    #IF( #TEXT(Input_hazsub1)='' )
      '' 
    #ELSE
        IF( le.Input_hazsub1 = (TYPEOF(le.Input_hazsub1))'','',':hazsub1')
    #END
 
+    #IF( #TEXT(Input_hazsub2)='' )
      '' 
    #ELSE
        IF( le.Input_hazsub2 = (TYPEOF(le.Input_hazsub2))'','',':hazsub2')
    #END
 
+    #IF( #TEXT(Input_hazsub3)='' )
      '' 
    #ELSE
        IF( le.Input_hazsub3 = (TYPEOF(le.Input_hazsub3))'','',':hazsub3')
    #END
 
+    #IF( #TEXT(Input_hazsub4)='' )
      '' 
    #ELSE
        IF( le.Input_hazsub4 = (TYPEOF(le.Input_hazsub4))'','',':hazsub4')
    #END
 
+    #IF( #TEXT(Input_hazsub5)='' )
      '' 
    #ELSE
        IF( le.Input_hazsub5 = (TYPEOF(le.Input_hazsub5))'','',':hazsub5')
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
