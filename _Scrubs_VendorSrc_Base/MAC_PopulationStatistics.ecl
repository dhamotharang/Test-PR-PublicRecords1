 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_item_source = '',Input_source_code = '',Input_display_name = '',Input_description = '',Input_status = '',Input_data_notes = '',Input_coverage_1 = '',Input_coverage_2 = '',Input_orbit_item_name = '',Input_orbit_source = '',Input_orbit_number = '',Input_website = '',Input_notes = '',Input_date_added = '',Input_input_file_id = '',Input_market_restrict_flag = '',Input_clean_phone = '',Input_clean_fax = '',Input_prepped_addr1 = '',Input_prepped_addr2 = '',Input_v_prim_name = '',Input_v_zip = '',Input_v_zip4 = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',OutFile) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_Base;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_item_source)='' )
      '' 
    #ELSE
        IF( le.Input_item_source = (TYPEOF(le.Input_item_source))'','',':item_source')
    #END
 
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
 
+    #IF( #TEXT(Input_display_name)='' )
      '' 
    #ELSE
        IF( le.Input_display_name = (TYPEOF(le.Input_display_name))'','',':display_name')
    #END
 
+    #IF( #TEXT(Input_description)='' )
      '' 
    #ELSE
        IF( le.Input_description = (TYPEOF(le.Input_description))'','',':description')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_data_notes)='' )
      '' 
    #ELSE
        IF( le.Input_data_notes = (TYPEOF(le.Input_data_notes))'','',':data_notes')
    #END
 
+    #IF( #TEXT(Input_coverage_1)='' )
      '' 
    #ELSE
        IF( le.Input_coverage_1 = (TYPEOF(le.Input_coverage_1))'','',':coverage_1')
    #END
 
+    #IF( #TEXT(Input_coverage_2)='' )
      '' 
    #ELSE
        IF( le.Input_coverage_2 = (TYPEOF(le.Input_coverage_2))'','',':coverage_2')
    #END
 
+    #IF( #TEXT(Input_orbit_item_name)='' )
      '' 
    #ELSE
        IF( le.Input_orbit_item_name = (TYPEOF(le.Input_orbit_item_name))'','',':orbit_item_name')
    #END
 
+    #IF( #TEXT(Input_orbit_source)='' )
      '' 
    #ELSE
        IF( le.Input_orbit_source = (TYPEOF(le.Input_orbit_source))'','',':orbit_source')
    #END
 
+    #IF( #TEXT(Input_orbit_number)='' )
      '' 
    #ELSE
        IF( le.Input_orbit_number = (TYPEOF(le.Input_orbit_number))'','',':orbit_number')
    #END
 
+    #IF( #TEXT(Input_website)='' )
      '' 
    #ELSE
        IF( le.Input_website = (TYPEOF(le.Input_website))'','',':website')
    #END
 
+    #IF( #TEXT(Input_notes)='' )
      '' 
    #ELSE
        IF( le.Input_notes = (TYPEOF(le.Input_notes))'','',':notes')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_input_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_input_file_id = (TYPEOF(le.Input_input_file_id))'','',':input_file_id')
    #END
 
+    #IF( #TEXT(Input_market_restrict_flag)='' )
      '' 
    #ELSE
        IF( le.Input_market_restrict_flag = (TYPEOF(le.Input_market_restrict_flag))'','',':market_restrict_flag')
    #END
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_clean_fax)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fax = (TYPEOF(le.Input_clean_fax))'','',':clean_fax')
    #END
 
+    #IF( #TEXT(Input_prepped_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr1 = (TYPEOF(le.Input_prepped_addr1))'','',':prepped_addr1')
    #END
 
+    #IF( #TEXT(Input_prepped_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_prepped_addr2 = (TYPEOF(le.Input_prepped_addr2))'','',':prepped_addr2')
    #END
 
+    #IF( #TEXT(Input_v_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_prim_name = (TYPEOF(le.Input_v_prim_name))'','',':v_prim_name')
    #END
 
+    #IF( #TEXT(Input_v_zip)='' )
      '' 
    #ELSE
        IF( le.Input_v_zip = (TYPEOF(le.Input_v_zip))'','',':v_zip')
    #END
 
+    #IF( #TEXT(Input_v_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_v_zip4 = (TYPEOF(le.Input_v_zip4))'','',':v_zip4')
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
