 
EXPORT CarrierReferenceMain_MAC_PopulationStatistics(infile,Ref='',Input_dt_first_reported = '',Input_dt_last_reported = '',Input_dt_start = '',Input_dt_end = '',Input_ocn = '',Input_carrier_name = '',Input_serv = '',Input_line = '',Input_prepaid = '',Input_high_risk_indicator = '',Input_activation_dt = '',Input_number_in_service = '',Input_spid = '',Input_operator_full_name = '',Input_is_current = '',Input_override_file = '',Input_data_type = '',Input_ocn_state = '',Input_overall_ocn = '',Input_target_ocn = '',Input_overall_target_ocn = '',Input_ocn_abbr_name = '',Input_rural_lec_indicator = '',Input_small_ilec_indicator = '',Input_category = '',Input_carrier_address1 = '',Input_carrier_address2 = '',Input_carrier_floor = '',Input_carrier_room = '',Input_carrier_city = '',Input_carrier_state = '',Input_carrier_zip = '',Input_carrier_phone = '',Input_affiliated_to = '',Input_overall_company = '',Input_contact_function = '',Input_contact_name = '',Input_contact_title = '',Input_contact_address1 = '',Input_contact_address2 = '',Input_contact_city = '',Input_contact_state = '',Input_contact_zip = '',Input_contact_phone = '',Input_contact_fax = '',Input_contact_email = '',Input_contact_information = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_z5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_append_rawaid = '',Input_address_type = '',Input_privacy_indicator = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_reported = (TYPEOF(le.Input_dt_first_reported))'','',':dt_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_reported = (TYPEOF(le.Input_dt_last_reported))'','',':dt_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_start)='' )
      '' 
    #ELSE
        IF( le.Input_dt_start = (TYPEOF(le.Input_dt_start))'','',':dt_start')
    #END
 
+    #IF( #TEXT(Input_dt_end)='' )
      '' 
    #ELSE
        IF( le.Input_dt_end = (TYPEOF(le.Input_dt_end))'','',':dt_end')
    #END
 
+    #IF( #TEXT(Input_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_ocn = (TYPEOF(le.Input_ocn))'','',':ocn')
    #END
 
+    #IF( #TEXT(Input_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_name = (TYPEOF(le.Input_carrier_name))'','',':carrier_name')
    #END
 
+    #IF( #TEXT(Input_serv)='' )
      '' 
    #ELSE
        IF( le.Input_serv = (TYPEOF(le.Input_serv))'','',':serv')
    #END
 
+    #IF( #TEXT(Input_line)='' )
      '' 
    #ELSE
        IF( le.Input_line = (TYPEOF(le.Input_line))'','',':line')
    #END
 
+    #IF( #TEXT(Input_prepaid)='' )
      '' 
    #ELSE
        IF( le.Input_prepaid = (TYPEOF(le.Input_prepaid))'','',':prepaid')
    #END
 
+    #IF( #TEXT(Input_high_risk_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_high_risk_indicator = (TYPEOF(le.Input_high_risk_indicator))'','',':high_risk_indicator')
    #END
 
+    #IF( #TEXT(Input_activation_dt)='' )
      '' 
    #ELSE
        IF( le.Input_activation_dt = (TYPEOF(le.Input_activation_dt))'','',':activation_dt')
    #END
 
+    #IF( #TEXT(Input_number_in_service)='' )
      '' 
    #ELSE
        IF( le.Input_number_in_service = (TYPEOF(le.Input_number_in_service))'','',':number_in_service')
    #END
 
+    #IF( #TEXT(Input_spid)='' )
      '' 
    #ELSE
        IF( le.Input_spid = (TYPEOF(le.Input_spid))'','',':spid')
    #END
 
+    #IF( #TEXT(Input_operator_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_operator_full_name = (TYPEOF(le.Input_operator_full_name))'','',':operator_full_name')
    #END
 
+    #IF( #TEXT(Input_is_current)='' )
      '' 
    #ELSE
        IF( le.Input_is_current = (TYPEOF(le.Input_is_current))'','',':is_current')
    #END
 
+    #IF( #TEXT(Input_override_file)='' )
      '' 
    #ELSE
        IF( le.Input_override_file = (TYPEOF(le.Input_override_file))'','',':override_file')
    #END
 
+    #IF( #TEXT(Input_data_type)='' )
      '' 
    #ELSE
        IF( le.Input_data_type = (TYPEOF(le.Input_data_type))'','',':data_type')
    #END
 
+    #IF( #TEXT(Input_ocn_state)='' )
      '' 
    #ELSE
        IF( le.Input_ocn_state = (TYPEOF(le.Input_ocn_state))'','',':ocn_state')
    #END
 
+    #IF( #TEXT(Input_overall_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_overall_ocn = (TYPEOF(le.Input_overall_ocn))'','',':overall_ocn')
    #END
 
+    #IF( #TEXT(Input_target_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_target_ocn = (TYPEOF(le.Input_target_ocn))'','',':target_ocn')
    #END
 
+    #IF( #TEXT(Input_overall_target_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_overall_target_ocn = (TYPEOF(le.Input_overall_target_ocn))'','',':overall_target_ocn')
    #END
 
+    #IF( #TEXT(Input_ocn_abbr_name)='' )
      '' 
    #ELSE
        IF( le.Input_ocn_abbr_name = (TYPEOF(le.Input_ocn_abbr_name))'','',':ocn_abbr_name')
    #END
 
+    #IF( #TEXT(Input_rural_lec_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_rural_lec_indicator = (TYPEOF(le.Input_rural_lec_indicator))'','',':rural_lec_indicator')
    #END
 
+    #IF( #TEXT(Input_small_ilec_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_small_ilec_indicator = (TYPEOF(le.Input_small_ilec_indicator))'','',':small_ilec_indicator')
    #END
 
+    #IF( #TEXT(Input_category)='' )
      '' 
    #ELSE
        IF( le.Input_category = (TYPEOF(le.Input_category))'','',':category')
    #END
 
+    #IF( #TEXT(Input_carrier_address1)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_address1 = (TYPEOF(le.Input_carrier_address1))'','',':carrier_address1')
    #END
 
+    #IF( #TEXT(Input_carrier_address2)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_address2 = (TYPEOF(le.Input_carrier_address2))'','',':carrier_address2')
    #END
 
+    #IF( #TEXT(Input_carrier_floor)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_floor = (TYPEOF(le.Input_carrier_floor))'','',':carrier_floor')
    #END
 
+    #IF( #TEXT(Input_carrier_room)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_room = (TYPEOF(le.Input_carrier_room))'','',':carrier_room')
    #END
 
+    #IF( #TEXT(Input_carrier_city)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_city = (TYPEOF(le.Input_carrier_city))'','',':carrier_city')
    #END
 
+    #IF( #TEXT(Input_carrier_state)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_state = (TYPEOF(le.Input_carrier_state))'','',':carrier_state')
    #END
 
+    #IF( #TEXT(Input_carrier_zip)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_zip = (TYPEOF(le.Input_carrier_zip))'','',':carrier_zip')
    #END
 
+    #IF( #TEXT(Input_carrier_phone)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_phone = (TYPEOF(le.Input_carrier_phone))'','',':carrier_phone')
    #END
 
+    #IF( #TEXT(Input_affiliated_to)='' )
      '' 
    #ELSE
        IF( le.Input_affiliated_to = (TYPEOF(le.Input_affiliated_to))'','',':affiliated_to')
    #END
 
+    #IF( #TEXT(Input_overall_company)='' )
      '' 
    #ELSE
        IF( le.Input_overall_company = (TYPEOF(le.Input_overall_company))'','',':overall_company')
    #END
 
+    #IF( #TEXT(Input_contact_function)='' )
      '' 
    #ELSE
        IF( le.Input_contact_function = (TYPEOF(le.Input_contact_function))'','',':contact_function')
    #END
 
+    #IF( #TEXT(Input_contact_name)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name = (TYPEOF(le.Input_contact_name))'','',':contact_name')
    #END
 
+    #IF( #TEXT(Input_contact_title)='' )
      '' 
    #ELSE
        IF( le.Input_contact_title = (TYPEOF(le.Input_contact_title))'','',':contact_title')
    #END
 
+    #IF( #TEXT(Input_contact_address1)='' )
      '' 
    #ELSE
        IF( le.Input_contact_address1 = (TYPEOF(le.Input_contact_address1))'','',':contact_address1')
    #END
 
+    #IF( #TEXT(Input_contact_address2)='' )
      '' 
    #ELSE
        IF( le.Input_contact_address2 = (TYPEOF(le.Input_contact_address2))'','',':contact_address2')
    #END
 
+    #IF( #TEXT(Input_contact_city)='' )
      '' 
    #ELSE
        IF( le.Input_contact_city = (TYPEOF(le.Input_contact_city))'','',':contact_city')
    #END
 
+    #IF( #TEXT(Input_contact_state)='' )
      '' 
    #ELSE
        IF( le.Input_contact_state = (TYPEOF(le.Input_contact_state))'','',':contact_state')
    #END
 
+    #IF( #TEXT(Input_contact_zip)='' )
      '' 
    #ELSE
        IF( le.Input_contact_zip = (TYPEOF(le.Input_contact_zip))'','',':contact_zip')
    #END
 
+    #IF( #TEXT(Input_contact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_contact_phone = (TYPEOF(le.Input_contact_phone))'','',':contact_phone')
    #END
 
+    #IF( #TEXT(Input_contact_fax)='' )
      '' 
    #ELSE
        IF( le.Input_contact_fax = (TYPEOF(le.Input_contact_fax))'','',':contact_fax')
    #END
 
+    #IF( #TEXT(Input_contact_email)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email = (TYPEOF(le.Input_contact_email))'','',':contact_email')
    #END
 
+    #IF( #TEXT(Input_contact_information)='' )
      '' 
    #ELSE
        IF( le.Input_contact_information = (TYPEOF(le.Input_contact_information))'','',':contact_information')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
 
+    #IF( #TEXT(Input_append_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_rawaid = (TYPEOF(le.Input_append_rawaid))'','',':append_rawaid')
    #END
 
+    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
 
+    #IF( #TEXT(Input_privacy_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_privacy_indicator = (TYPEOF(le.Input_privacy_indicator))'','',':privacy_indicator')
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
