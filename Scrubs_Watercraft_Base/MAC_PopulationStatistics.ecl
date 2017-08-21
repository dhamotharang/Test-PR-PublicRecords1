EXPORT MAC_PopulationStatistics(infile,Ref='',source_code='',Input_watercraft_key = '',Input_sequence_key = '',Input_watercraft_id = '',Input_state_origin = '',Input_source_code = '',Input_st_registration = '',Input_county_registration = '',Input_registration_number = '',Input_hull_number = '',Input_propulsion_description = '',Input_vehicle_type_code = '',Input_vehicle_type_description = '',Input_fuel_code = '',Input_fuel_description = '',Input_hull_type_code = '',Input_hull_type_description = '',Input_use_code = '',Input_use_description = '',Input_model_year = '',Input_watercraft_name = '',Input_watercraft_class_code = '',Input_watercraft_class_description = '',Input_watercraft_make_code = '',Input_watercraft_make_description = '',Input_watercraft_model_code = '',Input_watercraft_model_description = '',Input_watercraft_length = '',Input_watercraft_width = '',Input_watercraft_weight = '',Input_watercraft_color_1_code = '',Input_watercraft_color_1_description = '',Input_watercraft_color_2_code = '',Input_watercraft_color_2_description = '',Input_watercraft_toilet_code = '',Input_watercraft_toilet_description = '',Input_watercraft_number_of_engines = '',Input_watercraft_hp_1 = '',Input_watercraft_hp_2 = '',Input_watercraft_hp_3 = '',Input_engine_number_1 = '',Input_engine_number_2 = '',Input_engine_number_3 = '',Input_engine_make_1 = '',Input_engine_make_2 = '',Input_engine_make_3 = '',Input_engine_model_1 = '',Input_engine_model_2 = '',Input_engine_model_3 = '',Input_engine_year_1 = '',Input_engine_year_2 = '',Input_engine_year_3 = '',Input_coast_guard_documented_flag = '',Input_coast_guard_number = '',Input_registration_date = '',Input_registration_expiration_date = '',Input_registration_status_code = '',Input_registration_status_description = '',Input_registration_status_date = '',Input_registration_renewal_date = '',Input_decal_number = '',Input_transaction_type_code = '',Input_transaction_type_description = '',Input_title_state = '',Input_title_status_code = '',Input_title_status_description = '',Input_title_number = '',Input_title_issue_date = '',Input_title_type_code = '',Input_title_type_description = '',Input_additional_owner_count = '',Input_lien_1_indicator = '',Input_lien_1_name = '',Input_lien_1_date = '',Input_lien_1_address_1 = '',Input_lien_1_address_2 = '',Input_lien_1_city = '',Input_lien_1_state = '',Input_lien_1_zip = '',Input_lien_2_indicator = '',Input_lien_2_name = '',Input_lien_2_date = '',Input_lien_2_address_1 = '',Input_lien_2_address_2 = '',Input_lien_2_city = '',Input_lien_2_state = '',Input_lien_2_zip = '',Input_state_purchased = '',Input_purchase_date = '',Input_dealer = '',Input_purchase_price = '',Input_new_used_flag = '',Input_watercraft_status_code = '',Input_watercraft_status_description = '',Input_history_flag = '',Input_coastguard_flag = '',Input_signatory = '',Input_persistent_record_id = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Watercraft_Base;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_code)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_watercraft_key)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_key = (TYPEOF(le.Input_watercraft_key))'','',':watercraft_key')
    #END
+    #IF( #TEXT(Input_sequence_key)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_key = (TYPEOF(le.Input_sequence_key))'','',':sequence_key')
    #END
+    #IF( #TEXT(Input_watercraft_id)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_id = (TYPEOF(le.Input_watercraft_id))'','',':watercraft_id')
    #END
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
+    #IF( #TEXT(Input_st_registration)='' )
      '' 
    #ELSE
        IF( le.Input_st_registration = (TYPEOF(le.Input_st_registration))'','',':st_registration')
    #END
+    #IF( #TEXT(Input_county_registration)='' )
      '' 
    #ELSE
        IF( le.Input_county_registration = (TYPEOF(le.Input_county_registration))'','',':county_registration')
    #END
+    #IF( #TEXT(Input_registration_number)='' )
      '' 
    #ELSE
        IF( le.Input_registration_number = (TYPEOF(le.Input_registration_number))'','',':registration_number')
    #END
+    #IF( #TEXT(Input_hull_number)='' )
      '' 
    #ELSE
        IF( le.Input_hull_number = (TYPEOF(le.Input_hull_number))'','',':hull_number')
    #END
+    #IF( #TEXT(Input_propulsion_description)='' )
      '' 
    #ELSE
        IF( le.Input_propulsion_description = (TYPEOF(le.Input_propulsion_description))'','',':propulsion_description')
    #END
+    #IF( #TEXT(Input_vehicle_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_type_code = (TYPEOF(le.Input_vehicle_type_code))'','',':vehicle_type_code')
    #END
+    #IF( #TEXT(Input_vehicle_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_type_description = (TYPEOF(le.Input_vehicle_type_description))'','',':vehicle_type_description')
    #END
+    #IF( #TEXT(Input_fuel_code)='' )
      '' 
    #ELSE
        IF( le.Input_fuel_code = (TYPEOF(le.Input_fuel_code))'','',':fuel_code')
    #END
+    #IF( #TEXT(Input_fuel_description)='' )
      '' 
    #ELSE
        IF( le.Input_fuel_description = (TYPEOF(le.Input_fuel_description))'','',':fuel_description')
    #END
+    #IF( #TEXT(Input_hull_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_hull_type_code = (TYPEOF(le.Input_hull_type_code))'','',':hull_type_code')
    #END
+    #IF( #TEXT(Input_hull_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_hull_type_description = (TYPEOF(le.Input_hull_type_description))'','',':hull_type_description')
    #END
+    #IF( #TEXT(Input_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_use_code = (TYPEOF(le.Input_use_code))'','',':use_code')
    #END
+    #IF( #TEXT(Input_use_description)='' )
      '' 
    #ELSE
        IF( le.Input_use_description = (TYPEOF(le.Input_use_description))'','',':use_description')
    #END
+    #IF( #TEXT(Input_model_year)='' )
      '' 
    #ELSE
        IF( le.Input_model_year = (TYPEOF(le.Input_model_year))'','',':model_year')
    #END
+    #IF( #TEXT(Input_watercraft_name)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_name = (TYPEOF(le.Input_watercraft_name))'','',':watercraft_name')
    #END
+    #IF( #TEXT(Input_watercraft_class_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_class_code = (TYPEOF(le.Input_watercraft_class_code))'','',':watercraft_class_code')
    #END
+    #IF( #TEXT(Input_watercraft_class_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_class_description = (TYPEOF(le.Input_watercraft_class_description))'','',':watercraft_class_description')
    #END
+    #IF( #TEXT(Input_watercraft_make_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_make_code = (TYPEOF(le.Input_watercraft_make_code))'','',':watercraft_make_code')
    #END
+    #IF( #TEXT(Input_watercraft_make_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_make_description = (TYPEOF(le.Input_watercraft_make_description))'','',':watercraft_make_description')
    #END
+    #IF( #TEXT(Input_watercraft_model_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_model_code = (TYPEOF(le.Input_watercraft_model_code))'','',':watercraft_model_code')
    #END
+    #IF( #TEXT(Input_watercraft_model_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_model_description = (TYPEOF(le.Input_watercraft_model_description))'','',':watercraft_model_description')
    #END
+    #IF( #TEXT(Input_watercraft_length)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_length = (TYPEOF(le.Input_watercraft_length))'','',':watercraft_length')
    #END
+    #IF( #TEXT(Input_watercraft_width)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_width = (TYPEOF(le.Input_watercraft_width))'','',':watercraft_width')
    #END
+    #IF( #TEXT(Input_watercraft_weight)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_weight = (TYPEOF(le.Input_watercraft_weight))'','',':watercraft_weight')
    #END
+    #IF( #TEXT(Input_watercraft_color_1_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_color_1_code = (TYPEOF(le.Input_watercraft_color_1_code))'','',':watercraft_color_1_code')
    #END
+    #IF( #TEXT(Input_watercraft_color_1_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_color_1_description = (TYPEOF(le.Input_watercraft_color_1_description))'','',':watercraft_color_1_description')
    #END
+    #IF( #TEXT(Input_watercraft_color_2_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_color_2_code = (TYPEOF(le.Input_watercraft_color_2_code))'','',':watercraft_color_2_code')
    #END
+    #IF( #TEXT(Input_watercraft_color_2_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_color_2_description = (TYPEOF(le.Input_watercraft_color_2_description))'','',':watercraft_color_2_description')
    #END
+    #IF( #TEXT(Input_watercraft_toilet_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_toilet_code = (TYPEOF(le.Input_watercraft_toilet_code))'','',':watercraft_toilet_code')
    #END
+    #IF( #TEXT(Input_watercraft_toilet_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_toilet_description = (TYPEOF(le.Input_watercraft_toilet_description))'','',':watercraft_toilet_description')
    #END
+    #IF( #TEXT(Input_watercraft_number_of_engines)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_number_of_engines = (TYPEOF(le.Input_watercraft_number_of_engines))'','',':watercraft_number_of_engines')
    #END
+    #IF( #TEXT(Input_watercraft_hp_1)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_hp_1 = (TYPEOF(le.Input_watercraft_hp_1))'','',':watercraft_hp_1')
    #END
+    #IF( #TEXT(Input_watercraft_hp_2)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_hp_2 = (TYPEOF(le.Input_watercraft_hp_2))'','',':watercraft_hp_2')
    #END
+    #IF( #TEXT(Input_watercraft_hp_3)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_hp_3 = (TYPEOF(le.Input_watercraft_hp_3))'','',':watercraft_hp_3')
    #END
+    #IF( #TEXT(Input_engine_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_engine_number_1 = (TYPEOF(le.Input_engine_number_1))'','',':engine_number_1')
    #END
+    #IF( #TEXT(Input_engine_number_2)='' )
      '' 
    #ELSE
        IF( le.Input_engine_number_2 = (TYPEOF(le.Input_engine_number_2))'','',':engine_number_2')
    #END
+    #IF( #TEXT(Input_engine_number_3)='' )
      '' 
    #ELSE
        IF( le.Input_engine_number_3 = (TYPEOF(le.Input_engine_number_3))'','',':engine_number_3')
    #END
+    #IF( #TEXT(Input_engine_make_1)='' )
      '' 
    #ELSE
        IF( le.Input_engine_make_1 = (TYPEOF(le.Input_engine_make_1))'','',':engine_make_1')
    #END
+    #IF( #TEXT(Input_engine_make_2)='' )
      '' 
    #ELSE
        IF( le.Input_engine_make_2 = (TYPEOF(le.Input_engine_make_2))'','',':engine_make_2')
    #END
+    #IF( #TEXT(Input_engine_make_3)='' )
      '' 
    #ELSE
        IF( le.Input_engine_make_3 = (TYPEOF(le.Input_engine_make_3))'','',':engine_make_3')
    #END
+    #IF( #TEXT(Input_engine_model_1)='' )
      '' 
    #ELSE
        IF( le.Input_engine_model_1 = (TYPEOF(le.Input_engine_model_1))'','',':engine_model_1')
    #END
+    #IF( #TEXT(Input_engine_model_2)='' )
      '' 
    #ELSE
        IF( le.Input_engine_model_2 = (TYPEOF(le.Input_engine_model_2))'','',':engine_model_2')
    #END
+    #IF( #TEXT(Input_engine_model_3)='' )
      '' 
    #ELSE
        IF( le.Input_engine_model_3 = (TYPEOF(le.Input_engine_model_3))'','',':engine_model_3')
    #END
+    #IF( #TEXT(Input_engine_year_1)='' )
      '' 
    #ELSE
        IF( le.Input_engine_year_1 = (TYPEOF(le.Input_engine_year_1))'','',':engine_year_1')
    #END
+    #IF( #TEXT(Input_engine_year_2)='' )
      '' 
    #ELSE
        IF( le.Input_engine_year_2 = (TYPEOF(le.Input_engine_year_2))'','',':engine_year_2')
    #END
+    #IF( #TEXT(Input_engine_year_3)='' )
      '' 
    #ELSE
        IF( le.Input_engine_year_3 = (TYPEOF(le.Input_engine_year_3))'','',':engine_year_3')
    #END
+    #IF( #TEXT(Input_coast_guard_documented_flag)='' )
      '' 
    #ELSE
        IF( le.Input_coast_guard_documented_flag = (TYPEOF(le.Input_coast_guard_documented_flag))'','',':coast_guard_documented_flag')
    #END
+    #IF( #TEXT(Input_coast_guard_number)='' )
      '' 
    #ELSE
        IF( le.Input_coast_guard_number = (TYPEOF(le.Input_coast_guard_number))'','',':coast_guard_number')
    #END
+    #IF( #TEXT(Input_registration_date)='' )
      '' 
    #ELSE
        IF( le.Input_registration_date = (TYPEOF(le.Input_registration_date))'','',':registration_date')
    #END
+    #IF( #TEXT(Input_registration_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_registration_expiration_date = (TYPEOF(le.Input_registration_expiration_date))'','',':registration_expiration_date')
    #END
+    #IF( #TEXT(Input_registration_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_registration_status_code = (TYPEOF(le.Input_registration_status_code))'','',':registration_status_code')
    #END
+    #IF( #TEXT(Input_registration_status_description)='' )
      '' 
    #ELSE
        IF( le.Input_registration_status_description = (TYPEOF(le.Input_registration_status_description))'','',':registration_status_description')
    #END
+    #IF( #TEXT(Input_registration_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_registration_status_date = (TYPEOF(le.Input_registration_status_date))'','',':registration_status_date')
    #END
+    #IF( #TEXT(Input_registration_renewal_date)='' )
      '' 
    #ELSE
        IF( le.Input_registration_renewal_date = (TYPEOF(le.Input_registration_renewal_date))'','',':registration_renewal_date')
    #END
+    #IF( #TEXT(Input_decal_number)='' )
      '' 
    #ELSE
        IF( le.Input_decal_number = (TYPEOF(le.Input_decal_number))'','',':decal_number')
    #END
+    #IF( #TEXT(Input_transaction_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_type_code = (TYPEOF(le.Input_transaction_type_code))'','',':transaction_type_code')
    #END
+    #IF( #TEXT(Input_transaction_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_type_description = (TYPEOF(le.Input_transaction_type_description))'','',':transaction_type_description')
    #END
+    #IF( #TEXT(Input_title_state)='' )
      '' 
    #ELSE
        IF( le.Input_title_state = (TYPEOF(le.Input_title_state))'','',':title_state')
    #END
+    #IF( #TEXT(Input_title_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_title_status_code = (TYPEOF(le.Input_title_status_code))'','',':title_status_code')
    #END
+    #IF( #TEXT(Input_title_status_description)='' )
      '' 
    #ELSE
        IF( le.Input_title_status_description = (TYPEOF(le.Input_title_status_description))'','',':title_status_description')
    #END
+    #IF( #TEXT(Input_title_number)='' )
      '' 
    #ELSE
        IF( le.Input_title_number = (TYPEOF(le.Input_title_number))'','',':title_number')
    #END
+    #IF( #TEXT(Input_title_issue_date)='' )
      '' 
    #ELSE
        IF( le.Input_title_issue_date = (TYPEOF(le.Input_title_issue_date))'','',':title_issue_date')
    #END
+    #IF( #TEXT(Input_title_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_title_type_code = (TYPEOF(le.Input_title_type_code))'','',':title_type_code')
    #END
+    #IF( #TEXT(Input_title_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_title_type_description = (TYPEOF(le.Input_title_type_description))'','',':title_type_description')
    #END
+    #IF( #TEXT(Input_additional_owner_count)='' )
      '' 
    #ELSE
        IF( le.Input_additional_owner_count = (TYPEOF(le.Input_additional_owner_count))'','',':additional_owner_count')
    #END
+    #IF( #TEXT(Input_lien_1_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_indicator = (TYPEOF(le.Input_lien_1_indicator))'','',':lien_1_indicator')
    #END
+    #IF( #TEXT(Input_lien_1_name)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_name = (TYPEOF(le.Input_lien_1_name))'','',':lien_1_name')
    #END
+    #IF( #TEXT(Input_lien_1_date)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_date = (TYPEOF(le.Input_lien_1_date))'','',':lien_1_date')
    #END
+    #IF( #TEXT(Input_lien_1_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_address_1 = (TYPEOF(le.Input_lien_1_address_1))'','',':lien_1_address_1')
    #END
+    #IF( #TEXT(Input_lien_1_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_address_2 = (TYPEOF(le.Input_lien_1_address_2))'','',':lien_1_address_2')
    #END
+    #IF( #TEXT(Input_lien_1_city)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_city = (TYPEOF(le.Input_lien_1_city))'','',':lien_1_city')
    #END
+    #IF( #TEXT(Input_lien_1_state)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_state = (TYPEOF(le.Input_lien_1_state))'','',':lien_1_state')
    #END
+    #IF( #TEXT(Input_lien_1_zip)='' )
      '' 
    #ELSE
        IF( le.Input_lien_1_zip = (TYPEOF(le.Input_lien_1_zip))'','',':lien_1_zip')
    #END
+    #IF( #TEXT(Input_lien_2_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_indicator = (TYPEOF(le.Input_lien_2_indicator))'','',':lien_2_indicator')
    #END
+    #IF( #TEXT(Input_lien_2_name)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_name = (TYPEOF(le.Input_lien_2_name))'','',':lien_2_name')
    #END
+    #IF( #TEXT(Input_lien_2_date)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_date = (TYPEOF(le.Input_lien_2_date))'','',':lien_2_date')
    #END
+    #IF( #TEXT(Input_lien_2_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_address_1 = (TYPEOF(le.Input_lien_2_address_1))'','',':lien_2_address_1')
    #END
+    #IF( #TEXT(Input_lien_2_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_address_2 = (TYPEOF(le.Input_lien_2_address_2))'','',':lien_2_address_2')
    #END
+    #IF( #TEXT(Input_lien_2_city)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_city = (TYPEOF(le.Input_lien_2_city))'','',':lien_2_city')
    #END
+    #IF( #TEXT(Input_lien_2_state)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_state = (TYPEOF(le.Input_lien_2_state))'','',':lien_2_state')
    #END
+    #IF( #TEXT(Input_lien_2_zip)='' )
      '' 
    #ELSE
        IF( le.Input_lien_2_zip = (TYPEOF(le.Input_lien_2_zip))'','',':lien_2_zip')
    #END
+    #IF( #TEXT(Input_state_purchased)='' )
      '' 
    #ELSE
        IF( le.Input_state_purchased = (TYPEOF(le.Input_state_purchased))'','',':state_purchased')
    #END
+    #IF( #TEXT(Input_purchase_date)='' )
      '' 
    #ELSE
        IF( le.Input_purchase_date = (TYPEOF(le.Input_purchase_date))'','',':purchase_date')
    #END
+    #IF( #TEXT(Input_dealer)='' )
      '' 
    #ELSE
        IF( le.Input_dealer = (TYPEOF(le.Input_dealer))'','',':dealer')
    #END
+    #IF( #TEXT(Input_purchase_price)='' )
      '' 
    #ELSE
        IF( le.Input_purchase_price = (TYPEOF(le.Input_purchase_price))'','',':purchase_price')
    #END
+    #IF( #TEXT(Input_new_used_flag)='' )
      '' 
    #ELSE
        IF( le.Input_new_used_flag = (TYPEOF(le.Input_new_used_flag))'','',':new_used_flag')
    #END
+    #IF( #TEXT(Input_watercraft_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_status_code = (TYPEOF(le.Input_watercraft_status_code))'','',':watercraft_status_code')
    #END
+    #IF( #TEXT(Input_watercraft_status_description)='' )
      '' 
    #ELSE
        IF( le.Input_watercraft_status_description = (TYPEOF(le.Input_watercraft_status_description))'','',':watercraft_status_description')
    #END
+    #IF( #TEXT(Input_history_flag)='' )
      '' 
    #ELSE
        IF( le.Input_history_flag = (TYPEOF(le.Input_history_flag))'','',':history_flag')
    #END
+    #IF( #TEXT(Input_coastguard_flag)='' )
      '' 
    #ELSE
        IF( le.Input_coastguard_flag = (TYPEOF(le.Input_coastguard_flag))'','',':coastguard_flag')
    #END
+    #IF( #TEXT(Input_signatory)='' )
      '' 
    #ELSE
        IF( le.Input_signatory = (TYPEOF(le.Input_signatory))'','',':signatory')
    #END
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END
;
    #IF (#TEXT(source_code)<>'')
    SELF.source := le.source_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_code)<>'' ) source, #END -cnt );
ENDMACRO;
