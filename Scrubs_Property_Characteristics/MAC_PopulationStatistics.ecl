 
EXPORT MAC_PopulationStatistics(infile,Ref='',vendor_source='',Input_property_rid = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_tax_sortby_date = '',Input_deed_sortby_date = '',Input_vendor_source = '',Input_fares_unformatted_apn = '',Input_property_street_address = '',Input_property_city_state_zip = '',Input_property_raw_aid = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_building_square_footage = '',Input_src_building_square_footage = '',Input_tax_dt_building_square_footage = '',Input_air_conditioning_type = '',Input_src_air_conditioning_type = '',Input_tax_dt_air_conditioning_type = '',Input_basement_finish = '',Input_src_basement_finish = '',Input_tax_dt_basement_finish = '',Input_construction_type = '',Input_src_construction_type = '',Input_tax_dt_construction_type = '',Input_exterior_wall = '',Input_src_exterior_wall = '',Input_tax_dt_exterior_wall = '',Input_fireplace_ind = '',Input_src_fireplace_ind = '',Input_tax_dt_fireplace_ind = '',Input_fireplace_type = '',Input_src_fireplace_type = '',Input_tax_dt_fireplace_type = '',Input_flood_zone_panel = '',Input_src_flood_zone_panel = '',Input_tax_dt_flood_zone_panel = '',Input_garage = '',Input_src_garage = '',Input_tax_dt_garage = '',Input_first_floor_square_footage = '',Input_src_first_floor_square_footage = '',Input_tax_dt_first_floor_square_footage = '',Input_heating = '',Input_src_heating = '',Input_tax_dt_heating = '',Input_living_area_square_footage = '',Input_src_living_area_square_footage = '',Input_tax_dt_living_area_square_footage = '',Input_no_of_baths = '',Input_src_no_of_baths = '',Input_tax_dt_no_of_baths = '',Input_no_of_bedrooms = '',Input_src_no_of_bedrooms = '',Input_tax_dt_no_of_bedrooms = '',Input_no_of_fireplaces = '',Input_src_no_of_fireplaces = '',Input_tax_dt_no_of_fireplaces = '',Input_no_of_full_baths = '',Input_src_no_of_full_baths = '',Input_tax_dt_no_of_full_baths = '',Input_no_of_half_baths = '',Input_src_no_of_half_baths = '',Input_tax_dt_no_of_half_baths = '',Input_no_of_stories = '',Input_src_no_of_stories = '',Input_tax_dt_no_of_stories = '',Input_parking_type = '',Input_src_parking_type = '',Input_tax_dt_parking_type = '',Input_pool_indicator = '',Input_src_pool_indicator = '',Input_tax_dt_pool_indicator = '',Input_pool_type = '',Input_src_pool_type = '',Input_tax_dt_pool_type = '',Input_roof_cover = '',Input_src_roof_cover = '',Input_tax_dt_roof_cover = '',Input_year_built = '',Input_src_year_built = '',Input_tax_dt_year_built = '',Input_foundation = '',Input_src_foundation = '',Input_tax_dt_foundation = '',Input_basement_square_footage = '',Input_src_basement_square_footage = '',Input_tax_dt_basement_square_footage = '',Input_effective_year_built = '',Input_src_effective_year_built = '',Input_tax_dt_effective_year_built = '',Input_garage_square_footage = '',Input_src_garage_square_footage = '',Input_tax_dt_garage_square_footage = '',Input_stories_type = '',Input_src_stories_type = '',Input_tax_dt_stories_type = '',Input_apn_number = '',Input_src_apn_number = '',Input_tax_dt_apn_number = '',Input_census_tract = '',Input_src_census_tract = '',Input_tax_dt_census_tract = '',Input_range = '',Input_src_range = '',Input_tax_dt_range = '',Input_zoning = '',Input_src_zoning = '',Input_tax_dt_zoning = '',Input_block_number = '',Input_src_block_number = '',Input_tax_dt_block_number = '',Input_county_name = '',Input_src_county_name = '',Input_tax_dt_county_name = '',Input_fips_code = '',Input_src_fips_code = '',Input_tax_dt_fips_code = '',Input_subdivision = '',Input_src_subdivision = '',Input_tax_dt_subdivision = '',Input_municipality = '',Input_src_municipality = '',Input_tax_dt_municipality = '',Input_township = '',Input_src_township = '',Input_tax_dt_township = '',Input_homestead_exemption_ind = '',Input_src_homestead_exemption_ind = '',Input_tax_dt_homestead_exemption_ind = '',Input_land_use_code = '',Input_src_land_use_code = '',Input_tax_dt_land_use_code = '',Input_latitude = '',Input_src_latitude = '',Input_tax_dt_latitude = '',Input_longitude = '',Input_src_longitude = '',Input_tax_dt_longitude = '',Input_location_influence_code = '',Input_src_location_influence_code = '',Input_tax_dt_location_influence_code = '',Input_acres = '',Input_src_acres = '',Input_tax_dt_acres = '',Input_lot_depth_footage = '',Input_src_lot_depth_footage = '',Input_tax_dt_lot_depth_footage = '',Input_lot_front_footage = '',Input_src_lot_front_footage = '',Input_tax_dt_lot_front_footage = '',Input_lot_number = '',Input_src_lot_number = '',Input_tax_dt_lot_number = '',Input_lot_size = '',Input_src_lot_size = '',Input_tax_dt_lot_size = '',Input_property_type_code = '',Input_src_property_type_code = '',Input_tax_dt_property_type_code = '',Input_structure_quality = '',Input_src_structure_quality = '',Input_tax_dt_structure_quality = '',Input_water = '',Input_src_water = '',Input_tax_dt_water = '',Input_sewer = '',Input_src_sewer = '',Input_tax_dt_sewer = '',Input_assessed_land_value = '',Input_src_assessed_land_value = '',Input_tax_dt_assessed_land_value = '',Input_assessed_year = '',Input_src_assessed_year = '',Input_tax_dt_assessed_year = '',Input_tax_amount = '',Input_src_tax_amount = '',Input_tax_dt_tax_amount = '',Input_tax_year = '',Input_src_tax_year = '',Input_market_land_value = '',Input_src_market_land_value = '',Input_tax_dt_market_land_value = '',Input_improvement_value = '',Input_src_improvement_value = '',Input_tax_dt_improvement_value = '',Input_percent_improved = '',Input_src_percent_improved = '',Input_tax_dt_percent_improved = '',Input_total_assessed_value = '',Input_src_total_assessed_value = '',Input_tax_dt_total_assessed_value = '',Input_total_calculated_value = '',Input_src_total_calculated_value = '',Input_tax_dt_total_calculated_value = '',Input_total_land_value = '',Input_src_total_land_value = '',Input_tax_dt_total_land_value = '',Input_total_market_value = '',Input_src_total_market_value = '',Input_tax_dt_total_market_value = '',Input_floor_type = '',Input_src_floor_type = '',Input_tax_dt_floor_type = '',Input_frame_type = '',Input_src_frame_type = '',Input_tax_dt_frame_type = '',Input_fuel_type = '',Input_src_fuel_type = '',Input_tax_dt_fuel_type = '',Input_no_of_bath_fixtures = '',Input_src_no_of_bath_fixtures = '',Input_tax_dt_no_of_bath_fixtures = '',Input_no_of_rooms = '',Input_src_no_of_rooms = '',Input_tax_dt_no_of_rooms = '',Input_no_of_units = '',Input_src_no_of_units = '',Input_tax_dt_no_of_units = '',Input_style_type = '',Input_src_style_type = '',Input_tax_dt_style_type = '',Input_assessment_document_number = '',Input_src_assessment_document_number = '',Input_tax_dt_assessment_document_number = '',Input_assessment_recording_date = '',Input_src_assessment_recording_date = '',Input_tax_dt_assessment_recording_date = '',Input_deed_document_number = '',Input_src_deed_document_number = '',Input_rec_dt_deed_document_number = '',Input_deed_recording_date = '',Input_src_deed_recording_date = '',Input_full_part_sale = '',Input_src_full_part_sale = '',Input_rec_dt_full_part_sale = '',Input_sale_amount = '',Input_src_sale_amount = '',Input_rec_dt_sale_amount = '',Input_sale_date = '',Input_src_sale_date = '',Input_rec_dt_sale_date = '',Input_sale_type_code = '',Input_src_sale_type_code = '',Input_rec_dt_sale_type_code = '',Input_mortgage_company_name = '',Input_src_mortgage_company_name = '',Input_rec_dt_mortgage_company_name = '',Input_loan_amount = '',Input_src_loan_amount = '',Input_rec_dt_loan_amount = '',Input_second_loan_amount = '',Input_src_second_loan_amount = '',Input_rec_dt_second_loan_amount = '',Input_loan_type_code = '',Input_src_loan_type_code = '',Input_rec_dt_loan_type_code = '',Input_interest_rate_type_code = '',Input_src_interest_rate_type_code = '',Input_rec_dt_interest_rate_type_code = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Property_Characteristics;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(vendor_source)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_property_rid)='' )
      '' 
    #ELSE
        IF( le.Input_property_rid = (TYPEOF(le.Input_property_rid))'','',':property_rid')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_first_reported = 0,'', ':dt_vendor_first_reported(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_first_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_dt_vendor_last_reported = 0,'', ':dt_vendor_last_reported(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_dt_vendor_last_reported) + ')' )
    #END
 
+    #IF( #TEXT(Input_tax_sortby_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_sortby_date = 0,'', ':tax_sortby_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_sortby_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_deed_sortby_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_deed_sortby_date = 0,'', ':deed_sortby_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_deed_sortby_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_vendor_source)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_source = (TYPEOF(le.Input_vendor_source))'','',':vendor_source')
    #END
 
+    #IF( #TEXT(Input_fares_unformatted_apn)='' )
      '' 
    #ELSE
        IF( le.Input_fares_unformatted_apn = (TYPEOF(le.Input_fares_unformatted_apn))'','',':fares_unformatted_apn')
    #END
 
+    #IF( #TEXT(Input_property_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_property_street_address = (TYPEOF(le.Input_property_street_address))'','',':property_street_address')
    #END
 
+    #IF( #TEXT(Input_property_city_state_zip)='' )
      '' 
    #ELSE
        IF( le.Input_property_city_state_zip = (TYPEOF(le.Input_property_city_state_zip))'','',':property_city_state_zip')
    #END
 
+    #IF( #TEXT(Input_property_raw_aid)='' )
      '' 
    #ELSE
        IF( le.Input_property_raw_aid = (TYPEOF(le.Input_property_raw_aid))'','',':property_raw_aid')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
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
 
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
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
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
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
 
+    #IF( #TEXT(Input_building_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_building_square_footage = (TYPEOF(le.Input_building_square_footage))'','',':building_square_footage')
    #END
 
+    #IF( #TEXT(Input_src_building_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_building_square_footage = (TYPEOF(le.Input_src_building_square_footage))'','',':src_building_square_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_building_square_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_building_square_footage = 0,'', ':tax_dt_building_square_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_building_square_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_air_conditioning_type)='' )
      '' 
    #ELSE
        IF( le.Input_air_conditioning_type = (TYPEOF(le.Input_air_conditioning_type))'','',':air_conditioning_type')
    #END
 
+    #IF( #TEXT(Input_src_air_conditioning_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_air_conditioning_type = (TYPEOF(le.Input_src_air_conditioning_type))'','',':src_air_conditioning_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_air_conditioning_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_air_conditioning_type = 0,'', ':tax_dt_air_conditioning_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_air_conditioning_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_basement_finish)='' )
      '' 
    #ELSE
        IF( le.Input_basement_finish = (TYPEOF(le.Input_basement_finish))'','',':basement_finish')
    #END
 
+    #IF( #TEXT(Input_src_basement_finish)='' )
      '' 
    #ELSE
        IF( le.Input_src_basement_finish = (TYPEOF(le.Input_src_basement_finish))'','',':src_basement_finish')
    #END
 
+    #IF( #TEXT(Input_tax_dt_basement_finish)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_basement_finish = 0,'', ':tax_dt_basement_finish(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_basement_finish) + ')' )
    #END
 
+    #IF( #TEXT(Input_construction_type)='' )
      '' 
    #ELSE
        IF( le.Input_construction_type = (TYPEOF(le.Input_construction_type))'','',':construction_type')
    #END
 
+    #IF( #TEXT(Input_src_construction_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_construction_type = (TYPEOF(le.Input_src_construction_type))'','',':src_construction_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_construction_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_construction_type = 0,'', ':tax_dt_construction_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_construction_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_exterior_wall)='' )
      '' 
    #ELSE
        IF( le.Input_exterior_wall = (TYPEOF(le.Input_exterior_wall))'','',':exterior_wall')
    #END
 
+    #IF( #TEXT(Input_src_exterior_wall)='' )
      '' 
    #ELSE
        IF( le.Input_src_exterior_wall = (TYPEOF(le.Input_src_exterior_wall))'','',':src_exterior_wall')
    #END
 
+    #IF( #TEXT(Input_tax_dt_exterior_wall)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_exterior_wall = 0,'', ':tax_dt_exterior_wall(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_exterior_wall) + ')' )
    #END
 
+    #IF( #TEXT(Input_fireplace_ind)='' )
      '' 
    #ELSE
        IF( le.Input_fireplace_ind = (TYPEOF(le.Input_fireplace_ind))'','',':fireplace_ind')
    #END
 
+    #IF( #TEXT(Input_src_fireplace_ind)='' )
      '' 
    #ELSE
        IF( le.Input_src_fireplace_ind = (TYPEOF(le.Input_src_fireplace_ind))'','',':src_fireplace_ind')
    #END
 
+    #IF( #TEXT(Input_tax_dt_fireplace_ind)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_fireplace_ind = 0,'', ':tax_dt_fireplace_ind(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_fireplace_ind) + ')' )
    #END
 
+    #IF( #TEXT(Input_fireplace_type)='' )
      '' 
    #ELSE
        IF( le.Input_fireplace_type = (TYPEOF(le.Input_fireplace_type))'','',':fireplace_type')
    #END
 
+    #IF( #TEXT(Input_src_fireplace_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_fireplace_type = (TYPEOF(le.Input_src_fireplace_type))'','',':src_fireplace_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_fireplace_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_fireplace_type = 0,'', ':tax_dt_fireplace_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_fireplace_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_flood_zone_panel)='' )
      '' 
    #ELSE
        IF( le.Input_flood_zone_panel = (TYPEOF(le.Input_flood_zone_panel))'','',':flood_zone_panel')
    #END
 
+    #IF( #TEXT(Input_src_flood_zone_panel)='' )
      '' 
    #ELSE
        IF( le.Input_src_flood_zone_panel = (TYPEOF(le.Input_src_flood_zone_panel))'','',':src_flood_zone_panel')
    #END
 
+    #IF( #TEXT(Input_tax_dt_flood_zone_panel)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_flood_zone_panel = 0,'', ':tax_dt_flood_zone_panel(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_flood_zone_panel) + ')' )
    #END
 
+    #IF( #TEXT(Input_garage)='' )
      '' 
    #ELSE
        IF( le.Input_garage = (TYPEOF(le.Input_garage))'','',':garage')
    #END
 
+    #IF( #TEXT(Input_src_garage)='' )
      '' 
    #ELSE
        IF( le.Input_src_garage = (TYPEOF(le.Input_src_garage))'','',':src_garage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_garage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_garage = 0,'', ':tax_dt_garage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_garage) + ')' )
    #END
 
+    #IF( #TEXT(Input_first_floor_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_first_floor_square_footage = (TYPEOF(le.Input_first_floor_square_footage))'','',':first_floor_square_footage')
    #END
 
+    #IF( #TEXT(Input_src_first_floor_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_first_floor_square_footage = (TYPEOF(le.Input_src_first_floor_square_footage))'','',':src_first_floor_square_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_first_floor_square_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_first_floor_square_footage = 0,'', ':tax_dt_first_floor_square_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_first_floor_square_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_heating)='' )
      '' 
    #ELSE
        IF( le.Input_heating = (TYPEOF(le.Input_heating))'','',':heating')
    #END
 
+    #IF( #TEXT(Input_src_heating)='' )
      '' 
    #ELSE
        IF( le.Input_src_heating = (TYPEOF(le.Input_src_heating))'','',':src_heating')
    #END
 
+    #IF( #TEXT(Input_tax_dt_heating)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_heating = 0,'', ':tax_dt_heating(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_heating) + ')' )
    #END
 
+    #IF( #TEXT(Input_living_area_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_living_area_square_footage = (TYPEOF(le.Input_living_area_square_footage))'','',':living_area_square_footage')
    #END
 
+    #IF( #TEXT(Input_src_living_area_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_living_area_square_footage = (TYPEOF(le.Input_src_living_area_square_footage))'','',':src_living_area_square_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_living_area_square_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_living_area_square_footage = 0,'', ':tax_dt_living_area_square_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_living_area_square_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_baths)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_baths = (TYPEOF(le.Input_no_of_baths))'','',':no_of_baths')
    #END
 
+    #IF( #TEXT(Input_src_no_of_baths)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_baths = (TYPEOF(le.Input_src_no_of_baths))'','',':src_no_of_baths')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_baths)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_baths = 0,'', ':tax_dt_no_of_baths(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_baths) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_bedrooms)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_bedrooms = (TYPEOF(le.Input_no_of_bedrooms))'','',':no_of_bedrooms')
    #END
 
+    #IF( #TEXT(Input_src_no_of_bedrooms)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_bedrooms = (TYPEOF(le.Input_src_no_of_bedrooms))'','',':src_no_of_bedrooms')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_bedrooms)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_bedrooms = 0,'', ':tax_dt_no_of_bedrooms(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_bedrooms) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_fireplaces)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_fireplaces = (TYPEOF(le.Input_no_of_fireplaces))'','',':no_of_fireplaces')
    #END
 
+    #IF( #TEXT(Input_src_no_of_fireplaces)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_fireplaces = (TYPEOF(le.Input_src_no_of_fireplaces))'','',':src_no_of_fireplaces')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_fireplaces)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_fireplaces = 0,'', ':tax_dt_no_of_fireplaces(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_fireplaces) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_full_baths)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_full_baths = (TYPEOF(le.Input_no_of_full_baths))'','',':no_of_full_baths')
    #END
 
+    #IF( #TEXT(Input_src_no_of_full_baths)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_full_baths = (TYPEOF(le.Input_src_no_of_full_baths))'','',':src_no_of_full_baths')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_full_baths)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_full_baths = 0,'', ':tax_dt_no_of_full_baths(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_full_baths) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_half_baths)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_half_baths = (TYPEOF(le.Input_no_of_half_baths))'','',':no_of_half_baths')
    #END
 
+    #IF( #TEXT(Input_src_no_of_half_baths)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_half_baths = (TYPEOF(le.Input_src_no_of_half_baths))'','',':src_no_of_half_baths')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_half_baths)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_half_baths = 0,'', ':tax_dt_no_of_half_baths(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_half_baths) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_stories)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_stories = (TYPEOF(le.Input_no_of_stories))'','',':no_of_stories')
    #END
 
+    #IF( #TEXT(Input_src_no_of_stories)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_stories = (TYPEOF(le.Input_src_no_of_stories))'','',':src_no_of_stories')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_stories)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_stories = 0,'', ':tax_dt_no_of_stories(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_stories) + ')' )
    #END
 
+    #IF( #TEXT(Input_parking_type)='' )
      '' 
    #ELSE
        IF( le.Input_parking_type = (TYPEOF(le.Input_parking_type))'','',':parking_type')
    #END
 
+    #IF( #TEXT(Input_src_parking_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_parking_type = (TYPEOF(le.Input_src_parking_type))'','',':src_parking_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_parking_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_parking_type = 0,'', ':tax_dt_parking_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_parking_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_pool_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_pool_indicator = (TYPEOF(le.Input_pool_indicator))'','',':pool_indicator')
    #END
 
+    #IF( #TEXT(Input_src_pool_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_src_pool_indicator = (TYPEOF(le.Input_src_pool_indicator))'','',':src_pool_indicator')
    #END
 
+    #IF( #TEXT(Input_tax_dt_pool_indicator)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_pool_indicator = 0,'', ':tax_dt_pool_indicator(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_pool_indicator) + ')' )
    #END
 
+    #IF( #TEXT(Input_pool_type)='' )
      '' 
    #ELSE
        IF( le.Input_pool_type = (TYPEOF(le.Input_pool_type))'','',':pool_type')
    #END
 
+    #IF( #TEXT(Input_src_pool_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_pool_type = (TYPEOF(le.Input_src_pool_type))'','',':src_pool_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_pool_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_pool_type = 0,'', ':tax_dt_pool_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_pool_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_roof_cover)='' )
      '' 
    #ELSE
        IF( le.Input_roof_cover = (TYPEOF(le.Input_roof_cover))'','',':roof_cover')
    #END
 
+    #IF( #TEXT(Input_src_roof_cover)='' )
      '' 
    #ELSE
        IF( le.Input_src_roof_cover = (TYPEOF(le.Input_src_roof_cover))'','',':src_roof_cover')
    #END
 
+    #IF( #TEXT(Input_tax_dt_roof_cover)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_roof_cover = 0,'', ':tax_dt_roof_cover(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_roof_cover) + ')' )
    #END
 
+    #IF( #TEXT(Input_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_year_built = (TYPEOF(le.Input_year_built))'','',':year_built')
    #END
 
+    #IF( #TEXT(Input_src_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_src_year_built = (TYPEOF(le.Input_src_year_built))'','',':src_year_built')
    #END
 
+    #IF( #TEXT(Input_tax_dt_year_built)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_year_built = 0,'', ':tax_dt_year_built(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_year_built) + ')' )
    #END
 
+    #IF( #TEXT(Input_foundation)='' )
      '' 
    #ELSE
        IF( le.Input_foundation = (TYPEOF(le.Input_foundation))'','',':foundation')
    #END
 
+    #IF( #TEXT(Input_src_foundation)='' )
      '' 
    #ELSE
        IF( le.Input_src_foundation = (TYPEOF(le.Input_src_foundation))'','',':src_foundation')
    #END
 
+    #IF( #TEXT(Input_tax_dt_foundation)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_foundation = 0,'', ':tax_dt_foundation(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_foundation) + ')' )
    #END
 
+    #IF( #TEXT(Input_basement_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_basement_square_footage = (TYPEOF(le.Input_basement_square_footage))'','',':basement_square_footage')
    #END
 
+    #IF( #TEXT(Input_src_basement_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_basement_square_footage = (TYPEOF(le.Input_src_basement_square_footage))'','',':src_basement_square_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_basement_square_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_basement_square_footage = 0,'', ':tax_dt_basement_square_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_basement_square_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_effective_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_effective_year_built = (TYPEOF(le.Input_effective_year_built))'','',':effective_year_built')
    #END
 
+    #IF( #TEXT(Input_src_effective_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_src_effective_year_built = (TYPEOF(le.Input_src_effective_year_built))'','',':src_effective_year_built')
    #END
 
+    #IF( #TEXT(Input_tax_dt_effective_year_built)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_effective_year_built = 0,'', ':tax_dt_effective_year_built(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_effective_year_built) + ')' )
    #END
 
+    #IF( #TEXT(Input_garage_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_garage_square_footage = (TYPEOF(le.Input_garage_square_footage))'','',':garage_square_footage')
    #END
 
+    #IF( #TEXT(Input_src_garage_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_garage_square_footage = (TYPEOF(le.Input_src_garage_square_footage))'','',':src_garage_square_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_garage_square_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_garage_square_footage = 0,'', ':tax_dt_garage_square_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_garage_square_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_stories_type)='' )
      '' 
    #ELSE
        IF( le.Input_stories_type = (TYPEOF(le.Input_stories_type))'','',':stories_type')
    #END
 
+    #IF( #TEXT(Input_src_stories_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_stories_type = (TYPEOF(le.Input_src_stories_type))'','',':src_stories_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_stories_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_stories_type = 0,'', ':tax_dt_stories_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_stories_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_apn_number)='' )
      '' 
    #ELSE
        IF( le.Input_apn_number = (TYPEOF(le.Input_apn_number))'','',':apn_number')
    #END
 
+    #IF( #TEXT(Input_src_apn_number)='' )
      '' 
    #ELSE
        IF( le.Input_src_apn_number = (TYPEOF(le.Input_src_apn_number))'','',':src_apn_number')
    #END
 
+    #IF( #TEXT(Input_tax_dt_apn_number)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_apn_number = 0,'', ':tax_dt_apn_number(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_apn_number) + ')' )
    #END
 
+    #IF( #TEXT(Input_census_tract)='' )
      '' 
    #ELSE
        IF( le.Input_census_tract = (TYPEOF(le.Input_census_tract))'','',':census_tract')
    #END
 
+    #IF( #TEXT(Input_src_census_tract)='' )
      '' 
    #ELSE
        IF( le.Input_src_census_tract = (TYPEOF(le.Input_src_census_tract))'','',':src_census_tract')
    #END
 
+    #IF( #TEXT(Input_tax_dt_census_tract)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_census_tract = 0,'', ':tax_dt_census_tract(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_census_tract) + ')' )
    #END
 
+    #IF( #TEXT(Input_range)='' )
      '' 
    #ELSE
        IF( le.Input_range = (TYPEOF(le.Input_range))'','',':range')
    #END
 
+    #IF( #TEXT(Input_src_range)='' )
      '' 
    #ELSE
        IF( le.Input_src_range = (TYPEOF(le.Input_src_range))'','',':src_range')
    #END
 
+    #IF( #TEXT(Input_tax_dt_range)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_range = 0,'', ':tax_dt_range(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_range) + ')' )
    #END
 
+    #IF( #TEXT(Input_zoning)='' )
      '' 
    #ELSE
        IF( le.Input_zoning = (TYPEOF(le.Input_zoning))'','',':zoning')
    #END
 
+    #IF( #TEXT(Input_src_zoning)='' )
      '' 
    #ELSE
        IF( le.Input_src_zoning = (TYPEOF(le.Input_src_zoning))'','',':src_zoning')
    #END
 
+    #IF( #TEXT(Input_tax_dt_zoning)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_zoning = 0,'', ':tax_dt_zoning(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_zoning) + ')' )
    #END
 
+    #IF( #TEXT(Input_block_number)='' )
      '' 
    #ELSE
        IF( le.Input_block_number = (TYPEOF(le.Input_block_number))'','',':block_number')
    #END
 
+    #IF( #TEXT(Input_src_block_number)='' )
      '' 
    #ELSE
        IF( le.Input_src_block_number = (TYPEOF(le.Input_src_block_number))'','',':src_block_number')
    #END
 
+    #IF( #TEXT(Input_tax_dt_block_number)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_block_number = 0,'', ':tax_dt_block_number(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_block_number) + ')' )
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_src_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_src_county_name = (TYPEOF(le.Input_src_county_name))'','',':src_county_name')
    #END
 
+    #IF( #TEXT(Input_tax_dt_county_name)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_county_name = 0,'', ':tax_dt_county_name(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_county_name) + ')' )
    #END
 
+    #IF( #TEXT(Input_fips_code)='' )
      '' 
    #ELSE
        IF( le.Input_fips_code = (TYPEOF(le.Input_fips_code))'','',':fips_code')
    #END
 
+    #IF( #TEXT(Input_src_fips_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_fips_code = (TYPEOF(le.Input_src_fips_code))'','',':src_fips_code')
    #END
 
+    #IF( #TEXT(Input_tax_dt_fips_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_fips_code = 0,'', ':tax_dt_fips_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_fips_code) + ')' )
    #END
 
+    #IF( #TEXT(Input_subdivision)='' )
      '' 
    #ELSE
        IF( le.Input_subdivision = (TYPEOF(le.Input_subdivision))'','',':subdivision')
    #END
 
+    #IF( #TEXT(Input_src_subdivision)='' )
      '' 
    #ELSE
        IF( le.Input_src_subdivision = (TYPEOF(le.Input_src_subdivision))'','',':src_subdivision')
    #END
 
+    #IF( #TEXT(Input_tax_dt_subdivision)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_subdivision = 0,'', ':tax_dt_subdivision(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_subdivision) + ')' )
    #END
 
+    #IF( #TEXT(Input_municipality)='' )
      '' 
    #ELSE
        IF( le.Input_municipality = (TYPEOF(le.Input_municipality))'','',':municipality')
    #END
 
+    #IF( #TEXT(Input_src_municipality)='' )
      '' 
    #ELSE
        IF( le.Input_src_municipality = (TYPEOF(le.Input_src_municipality))'','',':src_municipality')
    #END
 
+    #IF( #TEXT(Input_tax_dt_municipality)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_municipality = 0,'', ':tax_dt_municipality(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_municipality) + ')' )
    #END
 
+    #IF( #TEXT(Input_township)='' )
      '' 
    #ELSE
        IF( le.Input_township = (TYPEOF(le.Input_township))'','',':township')
    #END
 
+    #IF( #TEXT(Input_src_township)='' )
      '' 
    #ELSE
        IF( le.Input_src_township = (TYPEOF(le.Input_src_township))'','',':src_township')
    #END
 
+    #IF( #TEXT(Input_tax_dt_township)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_township = 0,'', ':tax_dt_township(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_township) + ')' )
    #END
 
+    #IF( #TEXT(Input_homestead_exemption_ind)='' )
      '' 
    #ELSE
        IF( le.Input_homestead_exemption_ind = (TYPEOF(le.Input_homestead_exemption_ind))'','',':homestead_exemption_ind')
    #END
 
+    #IF( #TEXT(Input_src_homestead_exemption_ind)='' )
      '' 
    #ELSE
        IF( le.Input_src_homestead_exemption_ind = (TYPEOF(le.Input_src_homestead_exemption_ind))'','',':src_homestead_exemption_ind')
    #END
 
+    #IF( #TEXT(Input_tax_dt_homestead_exemption_ind)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_homestead_exemption_ind = 0,'', ':tax_dt_homestead_exemption_ind(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_homestead_exemption_ind) + ')' )
    #END
 
+    #IF( #TEXT(Input_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_land_use_code = (TYPEOF(le.Input_land_use_code))'','',':land_use_code')
    #END
 
+    #IF( #TEXT(Input_src_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_land_use_code = (TYPEOF(le.Input_src_land_use_code))'','',':src_land_use_code')
    #END
 
+    #IF( #TEXT(Input_tax_dt_land_use_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_land_use_code = 0,'', ':tax_dt_land_use_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_land_use_code) + ')' )
    #END
 
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
 
+    #IF( #TEXT(Input_src_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_src_latitude = (TYPEOF(le.Input_src_latitude))'','',':src_latitude')
    #END
 
+    #IF( #TEXT(Input_tax_dt_latitude)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_latitude = 0,'', ':tax_dt_latitude(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_latitude) + ')' )
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
 
+    #IF( #TEXT(Input_src_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_src_longitude = (TYPEOF(le.Input_src_longitude))'','',':src_longitude')
    #END
 
+    #IF( #TEXT(Input_tax_dt_longitude)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_longitude = 0,'', ':tax_dt_longitude(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_longitude) + ')' )
    #END
 
+    #IF( #TEXT(Input_location_influence_code)='' )
      '' 
    #ELSE
        IF( le.Input_location_influence_code = (TYPEOF(le.Input_location_influence_code))'','',':location_influence_code')
    #END
 
+    #IF( #TEXT(Input_src_location_influence_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_location_influence_code = (TYPEOF(le.Input_src_location_influence_code))'','',':src_location_influence_code')
    #END
 
+    #IF( #TEXT(Input_tax_dt_location_influence_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_location_influence_code = 0,'', ':tax_dt_location_influence_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_location_influence_code) + ')' )
    #END
 
+    #IF( #TEXT(Input_acres)='' )
      '' 
    #ELSE
        IF( le.Input_acres = (TYPEOF(le.Input_acres))'','',':acres')
    #END
 
+    #IF( #TEXT(Input_src_acres)='' )
      '' 
    #ELSE
        IF( le.Input_src_acres = (TYPEOF(le.Input_src_acres))'','',':src_acres')
    #END
 
+    #IF( #TEXT(Input_tax_dt_acres)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_acres = 0,'', ':tax_dt_acres(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_acres) + ')' )
    #END
 
+    #IF( #TEXT(Input_lot_depth_footage)='' )
      '' 
    #ELSE
        IF( le.Input_lot_depth_footage = (TYPEOF(le.Input_lot_depth_footage))'','',':lot_depth_footage')
    #END
 
+    #IF( #TEXT(Input_src_lot_depth_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_lot_depth_footage = (TYPEOF(le.Input_src_lot_depth_footage))'','',':src_lot_depth_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_lot_depth_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_lot_depth_footage = 0,'', ':tax_dt_lot_depth_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_lot_depth_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_lot_front_footage)='' )
      '' 
    #ELSE
        IF( le.Input_lot_front_footage = (TYPEOF(le.Input_lot_front_footage))'','',':lot_front_footage')
    #END
 
+    #IF( #TEXT(Input_src_lot_front_footage)='' )
      '' 
    #ELSE
        IF( le.Input_src_lot_front_footage = (TYPEOF(le.Input_src_lot_front_footage))'','',':src_lot_front_footage')
    #END
 
+    #IF( #TEXT(Input_tax_dt_lot_front_footage)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_lot_front_footage = 0,'', ':tax_dt_lot_front_footage(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_lot_front_footage) + ')' )
    #END
 
+    #IF( #TEXT(Input_lot_number)='' )
      '' 
    #ELSE
        IF( le.Input_lot_number = (TYPEOF(le.Input_lot_number))'','',':lot_number')
    #END
 
+    #IF( #TEXT(Input_src_lot_number)='' )
      '' 
    #ELSE
        IF( le.Input_src_lot_number = (TYPEOF(le.Input_src_lot_number))'','',':src_lot_number')
    #END
 
+    #IF( #TEXT(Input_tax_dt_lot_number)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_lot_number = 0,'', ':tax_dt_lot_number(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_lot_number) + ')' )
    #END
 
+    #IF( #TEXT(Input_lot_size)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size = (TYPEOF(le.Input_lot_size))'','',':lot_size')
    #END
 
+    #IF( #TEXT(Input_src_lot_size)='' )
      '' 
    #ELSE
        IF( le.Input_src_lot_size = (TYPEOF(le.Input_src_lot_size))'','',':src_lot_size')
    #END
 
+    #IF( #TEXT(Input_tax_dt_lot_size)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_lot_size = 0,'', ':tax_dt_lot_size(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_lot_size) + ')' )
    #END
 
+    #IF( #TEXT(Input_property_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_property_type_code = (TYPEOF(le.Input_property_type_code))'','',':property_type_code')
    #END
 
+    #IF( #TEXT(Input_src_property_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_property_type_code = (TYPEOF(le.Input_src_property_type_code))'','',':src_property_type_code')
    #END
 
+    #IF( #TEXT(Input_tax_dt_property_type_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_property_type_code = 0,'', ':tax_dt_property_type_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_property_type_code) + ')' )
    #END
 
+    #IF( #TEXT(Input_structure_quality)='' )
      '' 
    #ELSE
        IF( le.Input_structure_quality = (TYPEOF(le.Input_structure_quality))'','',':structure_quality')
    #END
 
+    #IF( #TEXT(Input_src_structure_quality)='' )
      '' 
    #ELSE
        IF( le.Input_src_structure_quality = (TYPEOF(le.Input_src_structure_quality))'','',':src_structure_quality')
    #END
 
+    #IF( #TEXT(Input_tax_dt_structure_quality)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_structure_quality = 0,'', ':tax_dt_structure_quality(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_structure_quality) + ')' )
    #END
 
+    #IF( #TEXT(Input_water)='' )
      '' 
    #ELSE
        IF( le.Input_water = (TYPEOF(le.Input_water))'','',':water')
    #END
 
+    #IF( #TEXT(Input_src_water)='' )
      '' 
    #ELSE
        IF( le.Input_src_water = (TYPEOF(le.Input_src_water))'','',':src_water')
    #END
 
+    #IF( #TEXT(Input_tax_dt_water)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_water = 0,'', ':tax_dt_water(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_water) + ')' )
    #END
 
+    #IF( #TEXT(Input_sewer)='' )
      '' 
    #ELSE
        IF( le.Input_sewer = (TYPEOF(le.Input_sewer))'','',':sewer')
    #END
 
+    #IF( #TEXT(Input_src_sewer)='' )
      '' 
    #ELSE
        IF( le.Input_src_sewer = (TYPEOF(le.Input_src_sewer))'','',':src_sewer')
    #END
 
+    #IF( #TEXT(Input_tax_dt_sewer)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_sewer = 0,'', ':tax_dt_sewer(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_sewer) + ')' )
    #END
 
+    #IF( #TEXT(Input_assessed_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_land_value = (TYPEOF(le.Input_assessed_land_value))'','',':assessed_land_value')
    #END
 
+    #IF( #TEXT(Input_src_assessed_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_assessed_land_value = (TYPEOF(le.Input_src_assessed_land_value))'','',':src_assessed_land_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_assessed_land_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_assessed_land_value = 0,'', ':tax_dt_assessed_land_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_assessed_land_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_assessed_year)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_year = (TYPEOF(le.Input_assessed_year))'','',':assessed_year')
    #END
 
+    #IF( #TEXT(Input_src_assessed_year)='' )
      '' 
    #ELSE
        IF( le.Input_src_assessed_year = (TYPEOF(le.Input_src_assessed_year))'','',':src_assessed_year')
    #END
 
+    #IF( #TEXT(Input_tax_dt_assessed_year)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_assessed_year = 0,'', ':tax_dt_assessed_year(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_assessed_year) + ')' )
    #END
 
+    #IF( #TEXT(Input_tax_amount)='' )
      '' 
    #ELSE
        IF( le.Input_tax_amount = (TYPEOF(le.Input_tax_amount))'','',':tax_amount')
    #END
 
+    #IF( #TEXT(Input_src_tax_amount)='' )
      '' 
    #ELSE
        IF( le.Input_src_tax_amount = (TYPEOF(le.Input_src_tax_amount))'','',':src_tax_amount')
    #END
 
+    #IF( #TEXT(Input_tax_dt_tax_amount)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_tax_amount = 0,'', ':tax_dt_tax_amount(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_tax_amount) + ')' )
    #END
 
+    #IF( #TEXT(Input_tax_year)='' )
      '' 
    #ELSE
        IF( le.Input_tax_year = (TYPEOF(le.Input_tax_year))'','',':tax_year')
    #END
 
+    #IF( #TEXT(Input_src_tax_year)='' )
      '' 
    #ELSE
        IF( le.Input_src_tax_year = (TYPEOF(le.Input_src_tax_year))'','',':src_tax_year')
    #END
 
+    #IF( #TEXT(Input_market_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_market_land_value = (TYPEOF(le.Input_market_land_value))'','',':market_land_value')
    #END
 
+    #IF( #TEXT(Input_src_market_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_market_land_value = (TYPEOF(le.Input_src_market_land_value))'','',':src_market_land_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_market_land_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_market_land_value = 0,'', ':tax_dt_market_land_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_market_land_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_improvement_value)='' )
      '' 
    #ELSE
        IF( le.Input_improvement_value = (TYPEOF(le.Input_improvement_value))'','',':improvement_value')
    #END
 
+    #IF( #TEXT(Input_src_improvement_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_improvement_value = (TYPEOF(le.Input_src_improvement_value))'','',':src_improvement_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_improvement_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_improvement_value = 0,'', ':tax_dt_improvement_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_improvement_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_percent_improved)='' )
      '' 
    #ELSE
        IF( le.Input_percent_improved = (TYPEOF(le.Input_percent_improved))'','',':percent_improved')
    #END
 
+    #IF( #TEXT(Input_src_percent_improved)='' )
      '' 
    #ELSE
        IF( le.Input_src_percent_improved = (TYPEOF(le.Input_src_percent_improved))'','',':src_percent_improved')
    #END
 
+    #IF( #TEXT(Input_tax_dt_percent_improved)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_percent_improved = 0,'', ':tax_dt_percent_improved(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_percent_improved) + ')' )
    #END
 
+    #IF( #TEXT(Input_total_assessed_value)='' )
      '' 
    #ELSE
        IF( le.Input_total_assessed_value = (TYPEOF(le.Input_total_assessed_value))'','',':total_assessed_value')
    #END
 
+    #IF( #TEXT(Input_src_total_assessed_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_total_assessed_value = (TYPEOF(le.Input_src_total_assessed_value))'','',':src_total_assessed_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_total_assessed_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_total_assessed_value = 0,'', ':tax_dt_total_assessed_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_total_assessed_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_total_calculated_value)='' )
      '' 
    #ELSE
        IF( le.Input_total_calculated_value = (TYPEOF(le.Input_total_calculated_value))'','',':total_calculated_value')
    #END
 
+    #IF( #TEXT(Input_src_total_calculated_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_total_calculated_value = (TYPEOF(le.Input_src_total_calculated_value))'','',':src_total_calculated_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_total_calculated_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_total_calculated_value = 0,'', ':tax_dt_total_calculated_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_total_calculated_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_total_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_total_land_value = (TYPEOF(le.Input_total_land_value))'','',':total_land_value')
    #END
 
+    #IF( #TEXT(Input_src_total_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_total_land_value = (TYPEOF(le.Input_src_total_land_value))'','',':src_total_land_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_total_land_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_total_land_value = 0,'', ':tax_dt_total_land_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_total_land_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_total_market_value)='' )
      '' 
    #ELSE
        IF( le.Input_total_market_value = (TYPEOF(le.Input_total_market_value))'','',':total_market_value')
    #END
 
+    #IF( #TEXT(Input_src_total_market_value)='' )
      '' 
    #ELSE
        IF( le.Input_src_total_market_value = (TYPEOF(le.Input_src_total_market_value))'','',':src_total_market_value')
    #END
 
+    #IF( #TEXT(Input_tax_dt_total_market_value)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_total_market_value = 0,'', ':tax_dt_total_market_value(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_total_market_value) + ')' )
    #END
 
+    #IF( #TEXT(Input_floor_type)='' )
      '' 
    #ELSE
        IF( le.Input_floor_type = (TYPEOF(le.Input_floor_type))'','',':floor_type')
    #END
 
+    #IF( #TEXT(Input_src_floor_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_floor_type = (TYPEOF(le.Input_src_floor_type))'','',':src_floor_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_floor_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_floor_type = 0,'', ':tax_dt_floor_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_floor_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_frame_type)='' )
      '' 
    #ELSE
        IF( le.Input_frame_type = (TYPEOF(le.Input_frame_type))'','',':frame_type')
    #END
 
+    #IF( #TEXT(Input_src_frame_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_frame_type = (TYPEOF(le.Input_src_frame_type))'','',':src_frame_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_frame_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_frame_type = 0,'', ':tax_dt_frame_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_frame_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_fuel_type)='' )
      '' 
    #ELSE
        IF( le.Input_fuel_type = (TYPEOF(le.Input_fuel_type))'','',':fuel_type')
    #END
 
+    #IF( #TEXT(Input_src_fuel_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_fuel_type = (TYPEOF(le.Input_src_fuel_type))'','',':src_fuel_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_fuel_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_fuel_type = 0,'', ':tax_dt_fuel_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_fuel_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_bath_fixtures)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_bath_fixtures = (TYPEOF(le.Input_no_of_bath_fixtures))'','',':no_of_bath_fixtures')
    #END
 
+    #IF( #TEXT(Input_src_no_of_bath_fixtures)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_bath_fixtures = (TYPEOF(le.Input_src_no_of_bath_fixtures))'','',':src_no_of_bath_fixtures')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_bath_fixtures)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_bath_fixtures = 0,'', ':tax_dt_no_of_bath_fixtures(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_bath_fixtures) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_rooms)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_rooms = (TYPEOF(le.Input_no_of_rooms))'','',':no_of_rooms')
    #END
 
+    #IF( #TEXT(Input_src_no_of_rooms)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_rooms = (TYPEOF(le.Input_src_no_of_rooms))'','',':src_no_of_rooms')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_rooms)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_rooms = 0,'', ':tax_dt_no_of_rooms(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_rooms) + ')' )
    #END
 
+    #IF( #TEXT(Input_no_of_units)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_units = (TYPEOF(le.Input_no_of_units))'','',':no_of_units')
    #END
 
+    #IF( #TEXT(Input_src_no_of_units)='' )
      '' 
    #ELSE
        IF( le.Input_src_no_of_units = (TYPEOF(le.Input_src_no_of_units))'','',':src_no_of_units')
    #END
 
+    #IF( #TEXT(Input_tax_dt_no_of_units)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_no_of_units = 0,'', ':tax_dt_no_of_units(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_no_of_units) + ')' )
    #END
 
+    #IF( #TEXT(Input_style_type)='' )
      '' 
    #ELSE
        IF( le.Input_style_type = (TYPEOF(le.Input_style_type))'','',':style_type')
    #END
 
+    #IF( #TEXT(Input_src_style_type)='' )
      '' 
    #ELSE
        IF( le.Input_src_style_type = (TYPEOF(le.Input_src_style_type))'','',':src_style_type')
    #END
 
+    #IF( #TEXT(Input_tax_dt_style_type)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_style_type = 0,'', ':tax_dt_style_type(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_style_type) + ')' )
    #END
 
+    #IF( #TEXT(Input_assessment_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_assessment_document_number = (TYPEOF(le.Input_assessment_document_number))'','',':assessment_document_number')
    #END
 
+    #IF( #TEXT(Input_src_assessment_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_src_assessment_document_number = (TYPEOF(le.Input_src_assessment_document_number))'','',':src_assessment_document_number')
    #END
 
+    #IF( #TEXT(Input_tax_dt_assessment_document_number)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_assessment_document_number = 0,'', ':tax_dt_assessment_document_number(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_assessment_document_number) + ')' )
    #END
 
+    #IF( #TEXT(Input_assessment_recording_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_assessment_recording_date = 0,'', ':assessment_recording_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_assessment_recording_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_src_assessment_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_src_assessment_recording_date = (TYPEOF(le.Input_src_assessment_recording_date))'','',':src_assessment_recording_date')
    #END
 
+    #IF( #TEXT(Input_tax_dt_assessment_recording_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tax_dt_assessment_recording_date = 0,'', ':tax_dt_assessment_recording_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tax_dt_assessment_recording_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_deed_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_deed_document_number = (TYPEOF(le.Input_deed_document_number))'','',':deed_document_number')
    #END
 
+    #IF( #TEXT(Input_src_deed_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_src_deed_document_number = (TYPEOF(le.Input_src_deed_document_number))'','',':src_deed_document_number')
    #END
 
+    #IF( #TEXT(Input_rec_dt_deed_document_number)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_deed_document_number = 0,'', ':rec_dt_deed_document_number(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_deed_document_number) + ')' )
    #END
 
+    #IF( #TEXT(Input_deed_recording_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_deed_recording_date = 0,'', ':deed_recording_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_deed_recording_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_src_deed_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_src_deed_recording_date = (TYPEOF(le.Input_src_deed_recording_date))'','',':src_deed_recording_date')
    #END
 
+    #IF( #TEXT(Input_full_part_sale)='' )
      '' 
    #ELSE
        IF( le.Input_full_part_sale = (TYPEOF(le.Input_full_part_sale))'','',':full_part_sale')
    #END
 
+    #IF( #TEXT(Input_src_full_part_sale)='' )
      '' 
    #ELSE
        IF( le.Input_src_full_part_sale = (TYPEOF(le.Input_src_full_part_sale))'','',':src_full_part_sale')
    #END
 
+    #IF( #TEXT(Input_rec_dt_full_part_sale)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_full_part_sale = 0,'', ':rec_dt_full_part_sale(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_full_part_sale) + ')' )
    #END
 
+    #IF( #TEXT(Input_sale_amount)='' )
      '' 
    #ELSE
        IF( le.Input_sale_amount = (TYPEOF(le.Input_sale_amount))'','',':sale_amount')
    #END
 
+    #IF( #TEXT(Input_src_sale_amount)='' )
      '' 
    #ELSE
        IF( le.Input_src_sale_amount = (TYPEOF(le.Input_src_sale_amount))'','',':src_sale_amount')
    #END
 
+    #IF( #TEXT(Input_rec_dt_sale_amount)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_sale_amount = 0,'', ':rec_dt_sale_amount(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_sale_amount) + ')' )
    #END
 
+    #IF( #TEXT(Input_sale_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_sale_date = 0,'', ':sale_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_sale_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_src_sale_date)='' )
      '' 
    #ELSE
        IF( le.Input_src_sale_date = (TYPEOF(le.Input_src_sale_date))'','',':src_sale_date')
    #END
 
+    #IF( #TEXT(Input_rec_dt_sale_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_sale_date = 0,'', ':rec_dt_sale_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_sale_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_sale_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_sale_type_code = (TYPEOF(le.Input_sale_type_code))'','',':sale_type_code')
    #END
 
+    #IF( #TEXT(Input_src_sale_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_sale_type_code = (TYPEOF(le.Input_src_sale_type_code))'','',':src_sale_type_code')
    #END
 
+    #IF( #TEXT(Input_rec_dt_sale_type_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_sale_type_code = 0,'', ':rec_dt_sale_type_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_sale_type_code) + ')' )
    #END
 
+    #IF( #TEXT(Input_mortgage_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_mortgage_company_name = (TYPEOF(le.Input_mortgage_company_name))'','',':mortgage_company_name')
    #END
 
+    #IF( #TEXT(Input_src_mortgage_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_src_mortgage_company_name = (TYPEOF(le.Input_src_mortgage_company_name))'','',':src_mortgage_company_name')
    #END
 
+    #IF( #TEXT(Input_rec_dt_mortgage_company_name)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_mortgage_company_name = 0,'', ':rec_dt_mortgage_company_name(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_mortgage_company_name) + ')' )
    #END
 
+    #IF( #TEXT(Input_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_loan_amount = (TYPEOF(le.Input_loan_amount))'','',':loan_amount')
    #END
 
+    #IF( #TEXT(Input_src_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_src_loan_amount = (TYPEOF(le.Input_src_loan_amount))'','',':src_loan_amount')
    #END
 
+    #IF( #TEXT(Input_rec_dt_loan_amount)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_loan_amount = 0,'', ':rec_dt_loan_amount(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_loan_amount) + ')' )
    #END
 
+    #IF( #TEXT(Input_second_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_second_loan_amount = (TYPEOF(le.Input_second_loan_amount))'','',':second_loan_amount')
    #END
 
+    #IF( #TEXT(Input_src_second_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_src_second_loan_amount = (TYPEOF(le.Input_src_second_loan_amount))'','',':src_second_loan_amount')
    #END
 
+    #IF( #TEXT(Input_rec_dt_second_loan_amount)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_second_loan_amount = 0,'', ':rec_dt_second_loan_amount(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_second_loan_amount) + ')' )
    #END
 
+    #IF( #TEXT(Input_loan_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_loan_type_code = (TYPEOF(le.Input_loan_type_code))'','',':loan_type_code')
    #END
 
+    #IF( #TEXT(Input_src_loan_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_loan_type_code = (TYPEOF(le.Input_src_loan_type_code))'','',':src_loan_type_code')
    #END
 
+    #IF( #TEXT(Input_rec_dt_loan_type_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_loan_type_code = 0,'', ':rec_dt_loan_type_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_loan_type_code) + ')' )
    #END
 
+    #IF( #TEXT(Input_interest_rate_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_interest_rate_type_code = (TYPEOF(le.Input_interest_rate_type_code))'','',':interest_rate_type_code')
    #END
 
+    #IF( #TEXT(Input_src_interest_rate_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_src_interest_rate_type_code = (TYPEOF(le.Input_src_interest_rate_type_code))'','',':src_interest_rate_type_code')
    #END
 
+    #IF( #TEXT(Input_rec_dt_interest_rate_type_code)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_rec_dt_interest_rate_type_code = 0,'', ':rec_dt_interest_rate_type_code(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_rec_dt_interest_rate_type_code) + ')' )
    #END
;
    #IF (#TEXT(vendor_source)<>'')
    SELF.source := le.vendor_source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(vendor_source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(vendor_source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(vendor_source)<>'' ) source, #END -cnt );
ENDMACRO;
