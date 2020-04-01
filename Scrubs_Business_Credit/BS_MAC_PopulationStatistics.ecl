 
EXPORT BS_MAC_PopulationStatistics(infile,Ref='',Input_segment_identifier = '',Input_file_sequence_number = '',Input_parent_sequence_number = '',Input_account_base_number = '',Input_business_name = '',Input_web_address = '',Input_guarantor_owner_indicator = '',Input_relationship_to_business_indicator = '',Input_percent_of_liability = '',Input_percent_of_ownership_if_owner_principal = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Business_Credit;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_segment_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_segment_identifier = (TYPEOF(le.Input_segment_identifier))'','',':segment_identifier')
    #END
 
+    #IF( #TEXT(Input_file_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_sequence_number = (TYPEOF(le.Input_file_sequence_number))'','',':file_sequence_number')
    #END
 
+    #IF( #TEXT(Input_parent_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_parent_sequence_number = (TYPEOF(le.Input_parent_sequence_number))'','',':parent_sequence_number')
    #END
 
+    #IF( #TEXT(Input_account_base_number)='' )
      '' 
    #ELSE
        IF( le.Input_account_base_number = (TYPEOF(le.Input_account_base_number))'','',':account_base_number')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_web_address = (TYPEOF(le.Input_web_address))'','',':web_address')
    #END
 
+    #IF( #TEXT(Input_guarantor_owner_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_guarantor_owner_indicator = (TYPEOF(le.Input_guarantor_owner_indicator))'','',':guarantor_owner_indicator')
    #END
 
+    #IF( #TEXT(Input_relationship_to_business_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_to_business_indicator = (TYPEOF(le.Input_relationship_to_business_indicator))'','',':relationship_to_business_indicator')
    #END
 
+    #IF( #TEXT(Input_percent_of_liability)='' )
      '' 
    #ELSE
        IF( le.Input_percent_of_liability = (TYPEOF(le.Input_percent_of_liability))'','',':percent_of_liability')
    #END
 
+    #IF( #TEXT(Input_percent_of_ownership_if_owner_principal)='' )
      '' 
    #ELSE
        IF( le.Input_percent_of_ownership_if_owner_principal = (TYPEOF(le.Input_percent_of_ownership_if_owner_principal))'','',':percent_of_ownership_if_owner_principal')
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
