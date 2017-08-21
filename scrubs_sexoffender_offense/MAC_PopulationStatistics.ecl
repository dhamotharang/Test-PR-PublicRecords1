EXPORT MAC_PopulationStatistics(infile,Ref='',orig_state_code='',Input_orig_state = '',Input_orig_state_code = '',Input_vendor_code = '',Input_source_file = '',Input_seisint_primary_key = '',Input_conviction_jurisdiction = '',Input_conviction_date = '',Input_court = '',Input_court_case_number = '',Input_offense_date = '',Input_offense_code_or_statute = '',Input_offense_description = '',Input_offense_description_2 = '',Input_offense_category = '',Input_victim_minor = '',Input_victim_age = '',Input_victim_gender = '',Input_victim_relationship = '',Input_sentence_description = '',Input_sentence_description_2 = '',Input_arrest_date = '',Input_arrest_warrant = '',Input_fcra_conviction_flag = '',Input_fcra_traffic_flag = '',Input_fcra_date = '',Input_fcra_date_type = '',Input_conviction_override_date = '',Input_conviction_override_date_type = '',Input_offense_score = '',Input_offense_persistent_id = '',OutFile) := MACRO
  IMPORT SALT33,scrubs_sexoffender_offense;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(orig_state_code)<>'')
    SALT33.StrType source;
    #END
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
+    #IF( #TEXT(Input_orig_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state_code = (TYPEOF(le.Input_orig_state_code))'','',':orig_state_code')
    #END
+    #IF( #TEXT(Input_vendor_code)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_code = (TYPEOF(le.Input_vendor_code))'','',':vendor_code')
    #END
+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END
+    #IF( #TEXT(Input_seisint_primary_key)='' )
      '' 
    #ELSE
        IF( le.Input_seisint_primary_key = (TYPEOF(le.Input_seisint_primary_key))'','',':seisint_primary_key')
    #END
+    #IF( #TEXT(Input_conviction_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_jurisdiction = (TYPEOF(le.Input_conviction_jurisdiction))'','',':conviction_jurisdiction')
    #END
+    #IF( #TEXT(Input_conviction_date)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_date = (TYPEOF(le.Input_conviction_date))'','',':conviction_date')
    #END
+    #IF( #TEXT(Input_court)='' )
      '' 
    #ELSE
        IF( le.Input_court = (TYPEOF(le.Input_court))'','',':court')
    #END
+    #IF( #TEXT(Input_court_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_court_case_number = (TYPEOF(le.Input_court_case_number))'','',':court_case_number')
    #END
+    #IF( #TEXT(Input_offense_date)='' )
      '' 
    #ELSE
        IF( le.Input_offense_date = (TYPEOF(le.Input_offense_date))'','',':offense_date')
    #END
+    #IF( #TEXT(Input_offense_code_or_statute)='' )
      '' 
    #ELSE
        IF( le.Input_offense_code_or_statute = (TYPEOF(le.Input_offense_code_or_statute))'','',':offense_code_or_statute')
    #END
+    #IF( #TEXT(Input_offense_description)='' )
      '' 
    #ELSE
        IF( le.Input_offense_description = (TYPEOF(le.Input_offense_description))'','',':offense_description')
    #END
+    #IF( #TEXT(Input_offense_description_2)='' )
      '' 
    #ELSE
        IF( le.Input_offense_description_2 = (TYPEOF(le.Input_offense_description_2))'','',':offense_description_2')
    #END
+    #IF( #TEXT(Input_offense_category)='' )
      '' 
    #ELSE
        IF( le.Input_offense_category = (TYPEOF(le.Input_offense_category))'','',':offense_category')
    #END
+    #IF( #TEXT(Input_victim_minor)='' )
      '' 
    #ELSE
        IF( le.Input_victim_minor = (TYPEOF(le.Input_victim_minor))'','',':victim_minor')
    #END
+    #IF( #TEXT(Input_victim_age)='' )
      '' 
    #ELSE
        IF( le.Input_victim_age = (TYPEOF(le.Input_victim_age))'','',':victim_age')
    #END
+    #IF( #TEXT(Input_victim_gender)='' )
      '' 
    #ELSE
        IF( le.Input_victim_gender = (TYPEOF(le.Input_victim_gender))'','',':victim_gender')
    #END
+    #IF( #TEXT(Input_victim_relationship)='' )
      '' 
    #ELSE
        IF( le.Input_victim_relationship = (TYPEOF(le.Input_victim_relationship))'','',':victim_relationship')
    #END
+    #IF( #TEXT(Input_sentence_description)='' )
      '' 
    #ELSE
        IF( le.Input_sentence_description = (TYPEOF(le.Input_sentence_description))'','',':sentence_description')
    #END
+    #IF( #TEXT(Input_sentence_description_2)='' )
      '' 
    #ELSE
        IF( le.Input_sentence_description_2 = (TYPEOF(le.Input_sentence_description_2))'','',':sentence_description_2')
    #END
+    #IF( #TEXT(Input_arrest_date)='' )
      '' 
    #ELSE
        IF( le.Input_arrest_date = (TYPEOF(le.Input_arrest_date))'','',':arrest_date')
    #END
+    #IF( #TEXT(Input_arrest_warrant)='' )
      '' 
    #ELSE
        IF( le.Input_arrest_warrant = (TYPEOF(le.Input_arrest_warrant))'','',':arrest_warrant')
    #END
+    #IF( #TEXT(Input_fcra_conviction_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_conviction_flag = (TYPEOF(le.Input_fcra_conviction_flag))'','',':fcra_conviction_flag')
    #END
+    #IF( #TEXT(Input_fcra_traffic_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_traffic_flag = (TYPEOF(le.Input_fcra_traffic_flag))'','',':fcra_traffic_flag')
    #END
+    #IF( #TEXT(Input_fcra_date)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_date = (TYPEOF(le.Input_fcra_date))'','',':fcra_date')
    #END
+    #IF( #TEXT(Input_fcra_date_type)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_date_type = (TYPEOF(le.Input_fcra_date_type))'','',':fcra_date_type')
    #END
+    #IF( #TEXT(Input_conviction_override_date)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_override_date = (TYPEOF(le.Input_conviction_override_date))'','',':conviction_override_date')
    #END
+    #IF( #TEXT(Input_conviction_override_date_type)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_override_date_type = (TYPEOF(le.Input_conviction_override_date_type))'','',':conviction_override_date_type')
    #END
+    #IF( #TEXT(Input_offense_score)='' )
      '' 
    #ELSE
        IF( le.Input_offense_score = (TYPEOF(le.Input_offense_score))'','',':offense_score')
    #END
+    #IF( #TEXT(Input_offense_persistent_id)='' )
      '' 
    #ELSE
        IF( le.Input_offense_persistent_id = (TYPEOF(le.Input_offense_persistent_id))'','',':offense_persistent_id')
    #END
;
    #IF (#TEXT(orig_state_code)<>'')
    SELF.source := le.orig_state_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(orig_state_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(orig_state_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(orig_state_code)<>'' ) source, #END -cnt );
ENDMACRO;
