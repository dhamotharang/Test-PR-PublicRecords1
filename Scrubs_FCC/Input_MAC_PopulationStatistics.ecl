 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_license_type = '',Input_file_number = '',Input_callsign_of_license = '',Input_radio_service_code = '',Input_licensees_name = '',Input_licensees_attention_line = '',Input_dba_name = '',Input_licensees_street = '',Input_licensees_city = '',Input_licensees_state = '',Input_licensees_zip = '',Input_licensees_phone = '',Input_date_application_received_at_fcc = '',Input_date_license_issued = '',Input_date_license_expires = '',Input_date_of_last_change = '',Input_type_of_last_change = '',Input_latitude = '',Input_longitude = '',Input_transmitters_street = '',Input_transmitters_city = '',Input_transmitters_county = '',Input_transmitters_state = '',Input_transmitters_antenna_height = '',Input_transmitters_height_above_avg_terra = '',Input_transmitters_height_above_ground_le = '',Input_power_of_this_frequency = '',Input_frequency_mhz = '',Input_class_of_station = '',Input_number_of_units_authorized_on_freq = '',Input_effective_radiated_power = '',Input_emissions_codes = '',Input_frequency_coordination_number = '',Input_paging_license_status = '',Input_control_point_for_the_system = '',Input_pending_or_granted = '',Input_firm_preparing_application = '',Input_contact_firms_street_address = '',Input_contact_firms_city = '',Input_contact_firms_state = '',Input_contact_firms_zipcode = '',Input_contact_firms_phone_number = '',Input_contact_firms_fax_number = '',Input_unique_key = '',Input_crlf = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FCC;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_license_type = (TYPEOF(le.Input_license_type))'','',':license_type')
    #END
 
+    #IF( #TEXT(Input_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_number = (TYPEOF(le.Input_file_number))'','',':file_number')
    #END
 
+    #IF( #TEXT(Input_callsign_of_license)='' )
      '' 
    #ELSE
        IF( le.Input_callsign_of_license = (TYPEOF(le.Input_callsign_of_license))'','',':callsign_of_license')
    #END
 
+    #IF( #TEXT(Input_radio_service_code)='' )
      '' 
    #ELSE
        IF( le.Input_radio_service_code = (TYPEOF(le.Input_radio_service_code))'','',':radio_service_code')
    #END
 
+    #IF( #TEXT(Input_licensees_name)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_name = (TYPEOF(le.Input_licensees_name))'','',':licensees_name')
    #END
 
+    #IF( #TEXT(Input_licensees_attention_line)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_attention_line = (TYPEOF(le.Input_licensees_attention_line))'','',':licensees_attention_line')
    #END
 
+    #IF( #TEXT(Input_dba_name)='' )
      '' 
    #ELSE
        IF( le.Input_dba_name = (TYPEOF(le.Input_dba_name))'','',':dba_name')
    #END
 
+    #IF( #TEXT(Input_licensees_street)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_street = (TYPEOF(le.Input_licensees_street))'','',':licensees_street')
    #END
 
+    #IF( #TEXT(Input_licensees_city)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_city = (TYPEOF(le.Input_licensees_city))'','',':licensees_city')
    #END
 
+    #IF( #TEXT(Input_licensees_state)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_state = (TYPEOF(le.Input_licensees_state))'','',':licensees_state')
    #END
 
+    #IF( #TEXT(Input_licensees_zip)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_zip = (TYPEOF(le.Input_licensees_zip))'','',':licensees_zip')
    #END
 
+    #IF( #TEXT(Input_licensees_phone)='' )
      '' 
    #ELSE
        IF( le.Input_licensees_phone = (TYPEOF(le.Input_licensees_phone))'','',':licensees_phone')
    #END
 
+    #IF( #TEXT(Input_date_application_received_at_fcc)='' )
      '' 
    #ELSE
        IF( le.Input_date_application_received_at_fcc = (TYPEOF(le.Input_date_application_received_at_fcc))'','',':date_application_received_at_fcc')
    #END
 
+    #IF( #TEXT(Input_date_license_issued)='' )
      '' 
    #ELSE
        IF( le.Input_date_license_issued = (TYPEOF(le.Input_date_license_issued))'','',':date_license_issued')
    #END
 
+    #IF( #TEXT(Input_date_license_expires)='' )
      '' 
    #ELSE
        IF( le.Input_date_license_expires = (TYPEOF(le.Input_date_license_expires))'','',':date_license_expires')
    #END
 
+    #IF( #TEXT(Input_date_of_last_change)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_last_change = (TYPEOF(le.Input_date_of_last_change))'','',':date_of_last_change')
    #END
 
+    #IF( #TEXT(Input_type_of_last_change)='' )
      '' 
    #ELSE
        IF( le.Input_type_of_last_change = (TYPEOF(le.Input_type_of_last_change))'','',':type_of_last_change')
    #END
 
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
 
+    #IF( #TEXT(Input_transmitters_street)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_street = (TYPEOF(le.Input_transmitters_street))'','',':transmitters_street')
    #END
 
+    #IF( #TEXT(Input_transmitters_city)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_city = (TYPEOF(le.Input_transmitters_city))'','',':transmitters_city')
    #END
 
+    #IF( #TEXT(Input_transmitters_county)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_county = (TYPEOF(le.Input_transmitters_county))'','',':transmitters_county')
    #END
 
+    #IF( #TEXT(Input_transmitters_state)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_state = (TYPEOF(le.Input_transmitters_state))'','',':transmitters_state')
    #END
 
+    #IF( #TEXT(Input_transmitters_antenna_height)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_antenna_height = (TYPEOF(le.Input_transmitters_antenna_height))'','',':transmitters_antenna_height')
    #END
 
+    #IF( #TEXT(Input_transmitters_height_above_avg_terra)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_height_above_avg_terra = (TYPEOF(le.Input_transmitters_height_above_avg_terra))'','',':transmitters_height_above_avg_terra')
    #END
 
+    #IF( #TEXT(Input_transmitters_height_above_ground_le)='' )
      '' 
    #ELSE
        IF( le.Input_transmitters_height_above_ground_le = (TYPEOF(le.Input_transmitters_height_above_ground_le))'','',':transmitters_height_above_ground_le')
    #END
 
+    #IF( #TEXT(Input_power_of_this_frequency)='' )
      '' 
    #ELSE
        IF( le.Input_power_of_this_frequency = (TYPEOF(le.Input_power_of_this_frequency))'','',':power_of_this_frequency')
    #END
 
+    #IF( #TEXT(Input_frequency_mhz)='' )
      '' 
    #ELSE
        IF( le.Input_frequency_mhz = (TYPEOF(le.Input_frequency_mhz))'','',':frequency_mhz')
    #END
 
+    #IF( #TEXT(Input_class_of_station)='' )
      '' 
    #ELSE
        IF( le.Input_class_of_station = (TYPEOF(le.Input_class_of_station))'','',':class_of_station')
    #END
 
+    #IF( #TEXT(Input_number_of_units_authorized_on_freq)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_units_authorized_on_freq = (TYPEOF(le.Input_number_of_units_authorized_on_freq))'','',':number_of_units_authorized_on_freq')
    #END
 
+    #IF( #TEXT(Input_effective_radiated_power)='' )
      '' 
    #ELSE
        IF( le.Input_effective_radiated_power = (TYPEOF(le.Input_effective_radiated_power))'','',':effective_radiated_power')
    #END
 
+    #IF( #TEXT(Input_emissions_codes)='' )
      '' 
    #ELSE
        IF( le.Input_emissions_codes = (TYPEOF(le.Input_emissions_codes))'','',':emissions_codes')
    #END
 
+    #IF( #TEXT(Input_frequency_coordination_number)='' )
      '' 
    #ELSE
        IF( le.Input_frequency_coordination_number = (TYPEOF(le.Input_frequency_coordination_number))'','',':frequency_coordination_number')
    #END
 
+    #IF( #TEXT(Input_paging_license_status)='' )
      '' 
    #ELSE
        IF( le.Input_paging_license_status = (TYPEOF(le.Input_paging_license_status))'','',':paging_license_status')
    #END
 
+    #IF( #TEXT(Input_control_point_for_the_system)='' )
      '' 
    #ELSE
        IF( le.Input_control_point_for_the_system = (TYPEOF(le.Input_control_point_for_the_system))'','',':control_point_for_the_system')
    #END
 
+    #IF( #TEXT(Input_pending_or_granted)='' )
      '' 
    #ELSE
        IF( le.Input_pending_or_granted = (TYPEOF(le.Input_pending_or_granted))'','',':pending_or_granted')
    #END
 
+    #IF( #TEXT(Input_firm_preparing_application)='' )
      '' 
    #ELSE
        IF( le.Input_firm_preparing_application = (TYPEOF(le.Input_firm_preparing_application))'','',':firm_preparing_application')
    #END
 
+    #IF( #TEXT(Input_contact_firms_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_contact_firms_street_address = (TYPEOF(le.Input_contact_firms_street_address))'','',':contact_firms_street_address')
    #END
 
+    #IF( #TEXT(Input_contact_firms_city)='' )
      '' 
    #ELSE
        IF( le.Input_contact_firms_city = (TYPEOF(le.Input_contact_firms_city))'','',':contact_firms_city')
    #END
 
+    #IF( #TEXT(Input_contact_firms_state)='' )
      '' 
    #ELSE
        IF( le.Input_contact_firms_state = (TYPEOF(le.Input_contact_firms_state))'','',':contact_firms_state')
    #END
 
+    #IF( #TEXT(Input_contact_firms_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_contact_firms_zipcode = (TYPEOF(le.Input_contact_firms_zipcode))'','',':contact_firms_zipcode')
    #END
 
+    #IF( #TEXT(Input_contact_firms_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_contact_firms_phone_number = (TYPEOF(le.Input_contact_firms_phone_number))'','',':contact_firms_phone_number')
    #END
 
+    #IF( #TEXT(Input_contact_firms_fax_number)='' )
      '' 
    #ELSE
        IF( le.Input_contact_firms_fax_number = (TYPEOF(le.Input_contact_firms_fax_number))'','',':contact_firms_fax_number')
    #END
 
+    #IF( #TEXT(Input_unique_key)='' )
      '' 
    #ELSE
        IF( le.Input_unique_key = (TYPEOF(le.Input_unique_key))'','',':unique_key')
    #END
 
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
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
