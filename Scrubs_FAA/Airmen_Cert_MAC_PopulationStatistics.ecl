 
EXPORT Airmen_Cert_MAC_PopulationStatistics(infile,Ref='',Input_date_first_seen = '',Input_date_last_seen = '',Input_current_flag = '',Input_letter = '',Input_unique_id = '',Input_rec_type = '',Input_cer_type = '',Input_cer_type_mapped = '',Input_cer_level = '',Input_cer_level_mapped = '',Input_cer_exp_date = '',Input_ratings = '',Input_filler = '',Input_lfcr = '',Input_persistent_record_id = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_FAA;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
 
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
 
+    #IF( #TEXT(Input_current_flag)='' )
      '' 
    #ELSE
        IF( le.Input_current_flag = (TYPEOF(le.Input_current_flag))'','',':current_flag')
    #END
 
+    #IF( #TEXT(Input_letter)='' )
      '' 
    #ELSE
        IF( le.Input_letter = (TYPEOF(le.Input_letter))'','',':letter')
    #END
 
+    #IF( #TEXT(Input_unique_id)='' )
      '' 
    #ELSE
        IF( le.Input_unique_id = (TYPEOF(le.Input_unique_id))'','',':unique_id')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_cer_type)='' )
      '' 
    #ELSE
        IF( le.Input_cer_type = (TYPEOF(le.Input_cer_type))'','',':cer_type')
    #END
 
+    #IF( #TEXT(Input_cer_type_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_cer_type_mapped = (TYPEOF(le.Input_cer_type_mapped))'','',':cer_type_mapped')
    #END
 
+    #IF( #TEXT(Input_cer_level)='' )
      '' 
    #ELSE
        IF( le.Input_cer_level = (TYPEOF(le.Input_cer_level))'','',':cer_level')
    #END
 
+    #IF( #TEXT(Input_cer_level_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_cer_level_mapped = (TYPEOF(le.Input_cer_level_mapped))'','',':cer_level_mapped')
    #END
 
+    #IF( #TEXT(Input_cer_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_cer_exp_date = (TYPEOF(le.Input_cer_exp_date))'','',':cer_exp_date')
    #END
 
+    #IF( #TEXT(Input_ratings)='' )
      '' 
    #ELSE
        IF( le.Input_ratings = (TYPEOF(le.Input_ratings))'','',':ratings')
    #END
 
+    #IF( #TEXT(Input_filler)='' )
      '' 
    #ELSE
        IF( le.Input_filler = (TYPEOF(le.Input_filler))'','',':filler')
    #END
 
+    #IF( #TEXT(Input_lfcr)='' )
      '' 
    #ELSE
        IF( le.Input_lfcr = (TYPEOF(le.Input_lfcr))'','',':lfcr')
    #END
 
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
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
