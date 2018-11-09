 
EXPORT Comps_MAC_PopulationStatistics(infile,Ref='',Input_seq = '',Input_ln_fares_id = '',Input_unformatted_apn = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_lat = '',Input_long = '',Input_geo_blk = '',Input_fips_code = '',Input_land_use_code = '',Input_sales_price = '',Input_sales_price_code = '',Input_recording_date = '',Input_assessed_value_year = '',Input_assessed_total_value = '',Input_market_total_value = '',Input_lot_size = '',Input_building_area = '',Input_year_built = '',Input_no_of_stories = '',Input_no_of_rooms = '',Input_no_of_bedrooms = '',Input_no_of_baths = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_AVM;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_seq)='' )
      '' 
    #ELSE
        IF( le.Input_seq = (TYPEOF(le.Input_seq))'','',':seq')
    #END
 
+    #IF( #TEXT(Input_ln_fares_id)='' )
      '' 
    #ELSE
        IF( le.Input_ln_fares_id = (TYPEOF(le.Input_ln_fares_id))'','',':ln_fares_id')
    #END
 
+    #IF( #TEXT(Input_unformatted_apn)='' )
      '' 
    #ELSE
        IF( le.Input_unformatted_apn = (TYPEOF(le.Input_unformatted_apn))'','',':unformatted_apn')
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
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
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
 
+    #IF( #TEXT(Input_lat)='' )
      '' 
    #ELSE
        IF( le.Input_lat = (TYPEOF(le.Input_lat))'','',':lat')
    #END
 
+    #IF( #TEXT(Input_long)='' )
      '' 
    #ELSE
        IF( le.Input_long = (TYPEOF(le.Input_long))'','',':long')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_fips_code)='' )
      '' 
    #ELSE
        IF( le.Input_fips_code = (TYPEOF(le.Input_fips_code))'','',':fips_code')
    #END
 
+    #IF( #TEXT(Input_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_land_use_code = (TYPEOF(le.Input_land_use_code))'','',':land_use_code')
    #END
 
+    #IF( #TEXT(Input_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price = (TYPEOF(le.Input_sales_price))'','',':sales_price')
    #END
 
+    #IF( #TEXT(Input_sales_price_code)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price_code = (TYPEOF(le.Input_sales_price_code))'','',':sales_price_code')
    #END
 
+    #IF( #TEXT(Input_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_recording_date = (TYPEOF(le.Input_recording_date))'','',':recording_date')
    #END
 
+    #IF( #TEXT(Input_assessed_value_year)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_value_year = (TYPEOF(le.Input_assessed_value_year))'','',':assessed_value_year')
    #END
 
+    #IF( #TEXT(Input_assessed_total_value)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_total_value = (TYPEOF(le.Input_assessed_total_value))'','',':assessed_total_value')
    #END
 
+    #IF( #TEXT(Input_market_total_value)='' )
      '' 
    #ELSE
        IF( le.Input_market_total_value = (TYPEOF(le.Input_market_total_value))'','',':market_total_value')
    #END
 
+    #IF( #TEXT(Input_lot_size)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size = (TYPEOF(le.Input_lot_size))'','',':lot_size')
    #END
 
+    #IF( #TEXT(Input_building_area)='' )
      '' 
    #ELSE
        IF( le.Input_building_area = (TYPEOF(le.Input_building_area))'','',':building_area')
    #END
 
+    #IF( #TEXT(Input_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_year_built = (TYPEOF(le.Input_year_built))'','',':year_built')
    #END
 
+    #IF( #TEXT(Input_no_of_stories)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_stories = (TYPEOF(le.Input_no_of_stories))'','',':no_of_stories')
    #END
 
+    #IF( #TEXT(Input_no_of_rooms)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_rooms = (TYPEOF(le.Input_no_of_rooms))'','',':no_of_rooms')
    #END
 
+    #IF( #TEXT(Input_no_of_bedrooms)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_bedrooms = (TYPEOF(le.Input_no_of_bedrooms))'','',':no_of_bedrooms')
    #END
 
+    #IF( #TEXT(Input_no_of_baths)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_baths = (TYPEOF(le.Input_no_of_baths))'','',':no_of_baths')
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
