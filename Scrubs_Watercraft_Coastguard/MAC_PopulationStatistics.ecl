EXPORT MAC_PopulationStatistics(infile,Ref='',source_code='',Input_watercraft_key = '',Input_sequence_key = '',Input_state_origin = '',Input_source_code = '',Input_vessel_id = '',Input_vessel_database_key = '',Input_name_of_vessel = '',Input_call_sign = '',Input_official_number = '',Input_imo_number = '',Input_hull_number = '',Input_hull_identification_number = '',Input_vessel_service_type = '',Input_flag = '',Input_self_propelled_indicator = '',Input_registered_gross_tons = '',Input_registered_net_tons = '',Input_registered_length = '',Input_registered_breadth = '',Input_registered_depth = '',Input_itc_gross_tons = '',Input_itc_net_tons = '',Input_itc_length = '',Input_itc_breadth = '',Input_itc_depth = '',Input_hailing_port = '',Input_hailing_port_state = '',Input_hailing_port_province = '',Input_home_port_name = '',Input_home_port_state = '',Input_home_port_province = '',Input_trade_ind_coastwise_unrestricted = '',Input_trade_ind_limited_coastwise_bowaters_only = '',Input_trade_ind_limited_coastwise_restricted = '',Input_trade_ind_limited_coastwise_oil_spill_response_only = '',Input_trade_ind_limited_coastwise_under_charter_to_citizen = '',Input_trade_ind_fishery = '',Input_trade_ind_limited_fishery_only = '',Input_trade_ind_recreation = '',Input_trade_ind_limited_recreation_great_lakes_use_only = '',Input_trade_ind_registry = '',Input_trade_ind_limited_registry_cross_border_financing = '',Input_trade_ind_limited_registry_no_foreign_voyage = '',Input_trade_ind_limited_registry_trade_with_canada_only = '',Input_trade_ind_great_lakes = '',Input_vessel_complete_build_city = '',Input_vessel_complete_build_state = '',Input_vessel_complete_build_province = '',Input_vessel_complete_build_country = '',Input_vessel_build_year = '',Input_vessel_hull_build_city = '',Input_vessel_hull_build_state = '',Input_vessel_hull_build_province = '',Input_vessel_hull_build_country = '',Input_party_identification_number = '',Input_main_hp_ahead = '',Input_main_hp_astern = '',Input_propulsion_type = '',Input_hull_material = '',Input_ship_yard = '',Input_hull_builder_name = '',Input_doc_certificate_status = '',Input_date_issued = '',Input_date_expires = '',Input_hull_design_type = '',Input_sail_ind = '',Input_party_database_key = '',Input_itc_tons_cod_ind = '',Input_persistent_record_id = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Watercraft_Coastguard;
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
+    #IF( #TEXT(Input_vessel_id)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_id = (TYPEOF(le.Input_vessel_id))'','',':vessel_id')
    #END
+    #IF( #TEXT(Input_vessel_database_key)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_database_key = (TYPEOF(le.Input_vessel_database_key))'','',':vessel_database_key')
    #END
+    #IF( #TEXT(Input_name_of_vessel)='' )
      '' 
    #ELSE
        IF( le.Input_name_of_vessel = (TYPEOF(le.Input_name_of_vessel))'','',':name_of_vessel')
    #END
+    #IF( #TEXT(Input_call_sign)='' )
      '' 
    #ELSE
        IF( le.Input_call_sign = (TYPEOF(le.Input_call_sign))'','',':call_sign')
    #END
+    #IF( #TEXT(Input_official_number)='' )
      '' 
    #ELSE
        IF( le.Input_official_number = (TYPEOF(le.Input_official_number))'','',':official_number')
    #END
+    #IF( #TEXT(Input_imo_number)='' )
      '' 
    #ELSE
        IF( le.Input_imo_number = (TYPEOF(le.Input_imo_number))'','',':imo_number')
    #END
+    #IF( #TEXT(Input_hull_number)='' )
      '' 
    #ELSE
        IF( le.Input_hull_number = (TYPEOF(le.Input_hull_number))'','',':hull_number')
    #END
+    #IF( #TEXT(Input_hull_identification_number)='' )
      '' 
    #ELSE
        IF( le.Input_hull_identification_number = (TYPEOF(le.Input_hull_identification_number))'','',':hull_identification_number')
    #END
+    #IF( #TEXT(Input_vessel_service_type)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_service_type = (TYPEOF(le.Input_vessel_service_type))'','',':vessel_service_type')
    #END
+    #IF( #TEXT(Input_flag)='' )
      '' 
    #ELSE
        IF( le.Input_flag = (TYPEOF(le.Input_flag))'','',':flag')
    #END
+    #IF( #TEXT(Input_self_propelled_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_self_propelled_indicator = (TYPEOF(le.Input_self_propelled_indicator))'','',':self_propelled_indicator')
    #END
+    #IF( #TEXT(Input_registered_gross_tons)='' )
      '' 
    #ELSE
        IF( le.Input_registered_gross_tons = (TYPEOF(le.Input_registered_gross_tons))'','',':registered_gross_tons')
    #END
+    #IF( #TEXT(Input_registered_net_tons)='' )
      '' 
    #ELSE
        IF( le.Input_registered_net_tons = (TYPEOF(le.Input_registered_net_tons))'','',':registered_net_tons')
    #END
+    #IF( #TEXT(Input_registered_length)='' )
      '' 
    #ELSE
        IF( le.Input_registered_length = (TYPEOF(le.Input_registered_length))'','',':registered_length')
    #END
+    #IF( #TEXT(Input_registered_breadth)='' )
      '' 
    #ELSE
        IF( le.Input_registered_breadth = (TYPEOF(le.Input_registered_breadth))'','',':registered_breadth')
    #END
+    #IF( #TEXT(Input_registered_depth)='' )
      '' 
    #ELSE
        IF( le.Input_registered_depth = (TYPEOF(le.Input_registered_depth))'','',':registered_depth')
    #END
+    #IF( #TEXT(Input_itc_gross_tons)='' )
      '' 
    #ELSE
        IF( le.Input_itc_gross_tons = (TYPEOF(le.Input_itc_gross_tons))'','',':itc_gross_tons')
    #END
+    #IF( #TEXT(Input_itc_net_tons)='' )
      '' 
    #ELSE
        IF( le.Input_itc_net_tons = (TYPEOF(le.Input_itc_net_tons))'','',':itc_net_tons')
    #END
+    #IF( #TEXT(Input_itc_length)='' )
      '' 
    #ELSE
        IF( le.Input_itc_length = (TYPEOF(le.Input_itc_length))'','',':itc_length')
    #END
+    #IF( #TEXT(Input_itc_breadth)='' )
      '' 
    #ELSE
        IF( le.Input_itc_breadth = (TYPEOF(le.Input_itc_breadth))'','',':itc_breadth')
    #END
+    #IF( #TEXT(Input_itc_depth)='' )
      '' 
    #ELSE
        IF( le.Input_itc_depth = (TYPEOF(le.Input_itc_depth))'','',':itc_depth')
    #END
+    #IF( #TEXT(Input_hailing_port)='' )
      '' 
    #ELSE
        IF( le.Input_hailing_port = (TYPEOF(le.Input_hailing_port))'','',':hailing_port')
    #END
+    #IF( #TEXT(Input_hailing_port_state)='' )
      '' 
    #ELSE
        IF( le.Input_hailing_port_state = (TYPEOF(le.Input_hailing_port_state))'','',':hailing_port_state')
    #END
+    #IF( #TEXT(Input_hailing_port_province)='' )
      '' 
    #ELSE
        IF( le.Input_hailing_port_province = (TYPEOF(le.Input_hailing_port_province))'','',':hailing_port_province')
    #END
+    #IF( #TEXT(Input_home_port_name)='' )
      '' 
    #ELSE
        IF( le.Input_home_port_name = (TYPEOF(le.Input_home_port_name))'','',':home_port_name')
    #END
+    #IF( #TEXT(Input_home_port_state)='' )
      '' 
    #ELSE
        IF( le.Input_home_port_state = (TYPEOF(le.Input_home_port_state))'','',':home_port_state')
    #END
+    #IF( #TEXT(Input_home_port_province)='' )
      '' 
    #ELSE
        IF( le.Input_home_port_province = (TYPEOF(le.Input_home_port_province))'','',':home_port_province')
    #END
+    #IF( #TEXT(Input_trade_ind_coastwise_unrestricted)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_coastwise_unrestricted = (TYPEOF(le.Input_trade_ind_coastwise_unrestricted))'','',':trade_ind_coastwise_unrestricted')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_coastwise_bowaters_only)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_coastwise_bowaters_only = (TYPEOF(le.Input_trade_ind_limited_coastwise_bowaters_only))'','',':trade_ind_limited_coastwise_bowaters_only')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_coastwise_restricted)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_coastwise_restricted = (TYPEOF(le.Input_trade_ind_limited_coastwise_restricted))'','',':trade_ind_limited_coastwise_restricted')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_coastwise_oil_spill_response_only)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_coastwise_oil_spill_response_only = (TYPEOF(le.Input_trade_ind_limited_coastwise_oil_spill_response_only))'','',':trade_ind_limited_coastwise_oil_spill_response_only')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_coastwise_under_charter_to_citizen)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_coastwise_under_charter_to_citizen = (TYPEOF(le.Input_trade_ind_limited_coastwise_under_charter_to_citizen))'','',':trade_ind_limited_coastwise_under_charter_to_citizen')
    #END
+    #IF( #TEXT(Input_trade_ind_fishery)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_fishery = (TYPEOF(le.Input_trade_ind_fishery))'','',':trade_ind_fishery')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_fishery_only)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_fishery_only = (TYPEOF(le.Input_trade_ind_limited_fishery_only))'','',':trade_ind_limited_fishery_only')
    #END
+    #IF( #TEXT(Input_trade_ind_recreation)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_recreation = (TYPEOF(le.Input_trade_ind_recreation))'','',':trade_ind_recreation')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_recreation_great_lakes_use_only)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_recreation_great_lakes_use_only = (TYPEOF(le.Input_trade_ind_limited_recreation_great_lakes_use_only))'','',':trade_ind_limited_recreation_great_lakes_use_only')
    #END
+    #IF( #TEXT(Input_trade_ind_registry)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_registry = (TYPEOF(le.Input_trade_ind_registry))'','',':trade_ind_registry')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_registry_cross_border_financing)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_registry_cross_border_financing = (TYPEOF(le.Input_trade_ind_limited_registry_cross_border_financing))'','',':trade_ind_limited_registry_cross_border_financing')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_registry_no_foreign_voyage)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_registry_no_foreign_voyage = (TYPEOF(le.Input_trade_ind_limited_registry_no_foreign_voyage))'','',':trade_ind_limited_registry_no_foreign_voyage')
    #END
+    #IF( #TEXT(Input_trade_ind_limited_registry_trade_with_canada_only)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_limited_registry_trade_with_canada_only = (TYPEOF(le.Input_trade_ind_limited_registry_trade_with_canada_only))'','',':trade_ind_limited_registry_trade_with_canada_only')
    #END
+    #IF( #TEXT(Input_trade_ind_great_lakes)='' )
      '' 
    #ELSE
        IF( le.Input_trade_ind_great_lakes = (TYPEOF(le.Input_trade_ind_great_lakes))'','',':trade_ind_great_lakes')
    #END
+    #IF( #TEXT(Input_vessel_complete_build_city)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_complete_build_city = (TYPEOF(le.Input_vessel_complete_build_city))'','',':vessel_complete_build_city')
    #END
+    #IF( #TEXT(Input_vessel_complete_build_state)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_complete_build_state = (TYPEOF(le.Input_vessel_complete_build_state))'','',':vessel_complete_build_state')
    #END
+    #IF( #TEXT(Input_vessel_complete_build_province)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_complete_build_province = (TYPEOF(le.Input_vessel_complete_build_province))'','',':vessel_complete_build_province')
    #END
+    #IF( #TEXT(Input_vessel_complete_build_country)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_complete_build_country = (TYPEOF(le.Input_vessel_complete_build_country))'','',':vessel_complete_build_country')
    #END
+    #IF( #TEXT(Input_vessel_build_year)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_build_year = (TYPEOF(le.Input_vessel_build_year))'','',':vessel_build_year')
    #END
+    #IF( #TEXT(Input_vessel_hull_build_city)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_hull_build_city = (TYPEOF(le.Input_vessel_hull_build_city))'','',':vessel_hull_build_city')
    #END
+    #IF( #TEXT(Input_vessel_hull_build_state)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_hull_build_state = (TYPEOF(le.Input_vessel_hull_build_state))'','',':vessel_hull_build_state')
    #END
+    #IF( #TEXT(Input_vessel_hull_build_province)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_hull_build_province = (TYPEOF(le.Input_vessel_hull_build_province))'','',':vessel_hull_build_province')
    #END
+    #IF( #TEXT(Input_vessel_hull_build_country)='' )
      '' 
    #ELSE
        IF( le.Input_vessel_hull_build_country = (TYPEOF(le.Input_vessel_hull_build_country))'','',':vessel_hull_build_country')
    #END
+    #IF( #TEXT(Input_party_identification_number)='' )
      '' 
    #ELSE
        IF( le.Input_party_identification_number = (TYPEOF(le.Input_party_identification_number))'','',':party_identification_number')
    #END
+    #IF( #TEXT(Input_main_hp_ahead)='' )
      '' 
    #ELSE
        IF( le.Input_main_hp_ahead = (TYPEOF(le.Input_main_hp_ahead))'','',':main_hp_ahead')
    #END
+    #IF( #TEXT(Input_main_hp_astern)='' )
      '' 
    #ELSE
        IF( le.Input_main_hp_astern = (TYPEOF(le.Input_main_hp_astern))'','',':main_hp_astern')
    #END
+    #IF( #TEXT(Input_propulsion_type)='' )
      '' 
    #ELSE
        IF( le.Input_propulsion_type = (TYPEOF(le.Input_propulsion_type))'','',':propulsion_type')
    #END
+    #IF( #TEXT(Input_hull_material)='' )
      '' 
    #ELSE
        IF( le.Input_hull_material = (TYPEOF(le.Input_hull_material))'','',':hull_material')
    #END
+    #IF( #TEXT(Input_ship_yard)='' )
      '' 
    #ELSE
        IF( le.Input_ship_yard = (TYPEOF(le.Input_ship_yard))'','',':ship_yard')
    #END
+    #IF( #TEXT(Input_hull_builder_name)='' )
      '' 
    #ELSE
        IF( le.Input_hull_builder_name = (TYPEOF(le.Input_hull_builder_name))'','',':hull_builder_name')
    #END
+    #IF( #TEXT(Input_doc_certificate_status)='' )
      '' 
    #ELSE
        IF( le.Input_doc_certificate_status = (TYPEOF(le.Input_doc_certificate_status))'','',':doc_certificate_status')
    #END
+    #IF( #TEXT(Input_date_issued)='' )
      '' 
    #ELSE
        IF( le.Input_date_issued = (TYPEOF(le.Input_date_issued))'','',':date_issued')
    #END
+    #IF( #TEXT(Input_date_expires)='' )
      '' 
    #ELSE
        IF( le.Input_date_expires = (TYPEOF(le.Input_date_expires))'','',':date_expires')
    #END
+    #IF( #TEXT(Input_hull_design_type)='' )
      '' 
    #ELSE
        IF( le.Input_hull_design_type = (TYPEOF(le.Input_hull_design_type))'','',':hull_design_type')
    #END
+    #IF( #TEXT(Input_sail_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sail_ind = (TYPEOF(le.Input_sail_ind))'','',':sail_ind')
    #END
+    #IF( #TEXT(Input_party_database_key)='' )
      '' 
    #ELSE
        IF( le.Input_party_database_key = (TYPEOF(le.Input_party_database_key))'','',':party_database_key')
    #END
+    #IF( #TEXT(Input_itc_tons_cod_ind)='' )
      '' 
    #ELSE
        IF( le.Input_itc_tons_cod_ind = (TYPEOF(le.Input_itc_tons_cod_ind))'','',':itc_tons_cod_ind')
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
