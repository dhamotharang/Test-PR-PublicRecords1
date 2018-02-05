 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_history_date = '',Input_ln_fares_id_ta = '',Input_ln_fares_id_pi = '',Input_unformatted_apn = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_lat = '',Input_long = '',Input_geo_blk = '',Input_fips_code = '',Input_land_use = '',Input_recording_date = '',Input_assessed_value_year = '',Input_sales_price = '',Input_assessed_total_value = '',Input_market_total_value = '',Input_tax_assessment_valuation = '',Input_price_index_valuation = '',Input_hedonic_valuation = '',Input_automated_valuation = '',Input_confidence_score = '',Input_comp1 = '',Input_comp2 = '',Input_comp3 = '',Input_comp4 = '',Input_comp5 = '',Input_nearby1 = '',Input_nearby2 = '',Input_nearby3 = '',Input_nearby4 = '',Input_nearby5 = '',Input_history_history_date = '',Input_history_land_use = '',Input_history_recording_date = '',Input_history_assessed_value_year = '',Input_history_sales_price = '',Input_history_assessed_total_value = '',Input_history_market_total_value = '',Input_history_tax_assessment_valuation = '',Input_history_price_index_valuation = '',Input_history_hedonic_valuation = '',Input_history_automated_valuation = '',Input_history_confidence_score = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_AVM;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_history_date)='' )
      '' 
    #ELSE
        IF( le.Input_history_date = (TYPEOF(le.Input_history_date))'','',':history_date')
    #END
 
+    #IF( #TEXT(Input_ln_fares_id_ta)='' )
      '' 
    #ELSE
        IF( le.Input_ln_fares_id_ta = (TYPEOF(le.Input_ln_fares_id_ta))'','',':ln_fares_id_ta')
    #END
 
+    #IF( #TEXT(Input_ln_fares_id_pi)='' )
      '' 
    #ELSE
        IF( le.Input_ln_fares_id_pi = (TYPEOF(le.Input_ln_fares_id_pi))'','',':ln_fares_id_pi')
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
 
+    #IF( #TEXT(Input_land_use)='' )
      '' 
    #ELSE
        IF( le.Input_land_use = (TYPEOF(le.Input_land_use))'','',':land_use')
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
 
+    #IF( #TEXT(Input_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price = (TYPEOF(le.Input_sales_price))'','',':sales_price')
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
 
+    #IF( #TEXT(Input_tax_assessment_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_tax_assessment_valuation = (TYPEOF(le.Input_tax_assessment_valuation))'','',':tax_assessment_valuation')
    #END
 
+    #IF( #TEXT(Input_price_index_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_price_index_valuation = (TYPEOF(le.Input_price_index_valuation))'','',':price_index_valuation')
    #END
 
+    #IF( #TEXT(Input_hedonic_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_hedonic_valuation = (TYPEOF(le.Input_hedonic_valuation))'','',':hedonic_valuation')
    #END
 
+    #IF( #TEXT(Input_automated_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_automated_valuation = (TYPEOF(le.Input_automated_valuation))'','',':automated_valuation')
    #END
 
+    #IF( #TEXT(Input_confidence_score)='' )
      '' 
    #ELSE
        IF( le.Input_confidence_score = (TYPEOF(le.Input_confidence_score))'','',':confidence_score')
    #END
 
+    #IF( #TEXT(Input_comp1)='' )
      '' 
    #ELSE
        IF( le.Input_comp1 = (TYPEOF(le.Input_comp1))'','',':comp1')
    #END
 
+    #IF( #TEXT(Input_comp2)='' )
      '' 
    #ELSE
        IF( le.Input_comp2 = (TYPEOF(le.Input_comp2))'','',':comp2')
    #END
 
+    #IF( #TEXT(Input_comp3)='' )
      '' 
    #ELSE
        IF( le.Input_comp3 = (TYPEOF(le.Input_comp3))'','',':comp3')
    #END
 
+    #IF( #TEXT(Input_comp4)='' )
      '' 
    #ELSE
        IF( le.Input_comp4 = (TYPEOF(le.Input_comp4))'','',':comp4')
    #END
 
+    #IF( #TEXT(Input_comp5)='' )
      '' 
    #ELSE
        IF( le.Input_comp5 = (TYPEOF(le.Input_comp5))'','',':comp5')
    #END
 
+    #IF( #TEXT(Input_nearby1)='' )
      '' 
    #ELSE
        IF( le.Input_nearby1 = (TYPEOF(le.Input_nearby1))'','',':nearby1')
    #END
 
+    #IF( #TEXT(Input_nearby2)='' )
      '' 
    #ELSE
        IF( le.Input_nearby2 = (TYPEOF(le.Input_nearby2))'','',':nearby2')
    #END
 
+    #IF( #TEXT(Input_nearby3)='' )
      '' 
    #ELSE
        IF( le.Input_nearby3 = (TYPEOF(le.Input_nearby3))'','',':nearby3')
    #END
 
+    #IF( #TEXT(Input_nearby4)='' )
      '' 
    #ELSE
        IF( le.Input_nearby4 = (TYPEOF(le.Input_nearby4))'','',':nearby4')
    #END
 
+    #IF( #TEXT(Input_nearby5)='' )
      '' 
    #ELSE
        IF( le.Input_nearby5 = (TYPEOF(le.Input_nearby5))'','',':nearby5')
    #END
 
+    #IF( #TEXT(Input_history_history_date)='' )
      '' 
    #ELSE
        IF( le.Input_history_history_date = (TYPEOF(le.Input_history_history_date))'','',':history_history_date')
    #END
 
+    #IF( #TEXT(Input_history_land_use)='' )
      '' 
    #ELSE
        IF( le.Input_history_land_use = (TYPEOF(le.Input_history_land_use))'','',':history_land_use')
    #END
 
+    #IF( #TEXT(Input_history_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_history_recording_date = (TYPEOF(le.Input_history_recording_date))'','',':history_recording_date')
    #END
 
+    #IF( #TEXT(Input_history_assessed_value_year)='' )
      '' 
    #ELSE
        IF( le.Input_history_assessed_value_year = (TYPEOF(le.Input_history_assessed_value_year))'','',':history_assessed_value_year')
    #END
 
+    #IF( #TEXT(Input_history_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_history_sales_price = (TYPEOF(le.Input_history_sales_price))'','',':history_sales_price')
    #END
 
+    #IF( #TEXT(Input_history_assessed_total_value)='' )
      '' 
    #ELSE
        IF( le.Input_history_assessed_total_value = (TYPEOF(le.Input_history_assessed_total_value))'','',':history_assessed_total_value')
    #END
 
+    #IF( #TEXT(Input_history_market_total_value)='' )
      '' 
    #ELSE
        IF( le.Input_history_market_total_value = (TYPEOF(le.Input_history_market_total_value))'','',':history_market_total_value')
    #END
 
+    #IF( #TEXT(Input_history_tax_assessment_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_history_tax_assessment_valuation = (TYPEOF(le.Input_history_tax_assessment_valuation))'','',':history_tax_assessment_valuation')
    #END
 
+    #IF( #TEXT(Input_history_price_index_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_history_price_index_valuation = (TYPEOF(le.Input_history_price_index_valuation))'','',':history_price_index_valuation')
    #END
 
+    #IF( #TEXT(Input_history_hedonic_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_history_hedonic_valuation = (TYPEOF(le.Input_history_hedonic_valuation))'','',':history_hedonic_valuation')
    #END
 
+    #IF( #TEXT(Input_history_automated_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_history_automated_valuation = (TYPEOF(le.Input_history_automated_valuation))'','',':history_automated_valuation')
    #END
 
+    #IF( #TEXT(Input_history_confidence_score)='' )
      '' 
    #ELSE
        IF( le.Input_history_confidence_score = (TYPEOF(le.Input_history_confidence_score))'','',':history_confidence_score')
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
