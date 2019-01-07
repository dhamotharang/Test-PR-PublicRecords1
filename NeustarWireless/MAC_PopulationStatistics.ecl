 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_phone = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_salutation = '',Input_suffix = '',Input_gender = '',Input_dob = '',Input_house = '',Input_pre_dir = '',Input_street = '',Input_street_type = '',Input_post_dir = '',Input_apt_type = '',Input_apt_nbr = '',Input_zip = '',Input_plus4 = '',Input_dpc = '',Input_z4_type = '',Input_crte = '',Input_city = '',Input_state = '',Input_dpvcmra = '',Input_dpvconf = '',Input_fips_state = '',Input_fips_county = '',Input_census_tract = '',Input_census_block_group = '',Input_cbsa = '',Input_match_code = '',Input_latitude = '',Input_longitude = '',Input_email = '',Input_verified = '',Input_activity_status = '',Input_prepaid = '',Input_cord_cutter = '',Input_raw_file_name = '',Input_rcid = '',Input_source = '',Input_persistent_record_id = '',Input_did = '',Input_did_score = '',Input_xadl2_weight = '',Input_xadl2_score = '',Input_xadl2_keys_used = '',Input_xadl2_distance = '',Input_xadl2_matches = '',Input_append_prep_address_1 = '',Input_append_prep_address_2 = '',Input_rawaid = '',Input_aceaid = '',Input_clean_address_prim_range = '',Input_clean_address_predir = '',Input_clean_address_prim_name = '',Input_clean_address_addr_suffix = '',Input_clean_address_postdir = '',Input_clean_address_unit_desig = '',Input_clean_address_sec_range = '',Input_clean_address_p_city_name = '',Input_clean_address_v_city_name = '',Input_clean_address_st = '',Input_clean_address_zip = '',Input_clean_address_zip4 = '',Input_clean_address_cart = '',Input_clean_address_cr_sort_sz = '',Input_clean_address_lot = '',Input_clean_address_lot_order = '',Input_clean_address_dbpc = '',Input_clean_address_chk_digit = '',Input_clean_address_rec_type = '',Input_clean_address_county = '',Input_clean_address_geo_lat = '',Input_clean_address_geo_long = '',Input_clean_address_msa = '',Input_clean_address_geo_blk = '',Input_clean_address_geo_match = '',Input_clean_address_err_stat = '',Input_append_prep_name = '',Input_nid = '',Input_name_ind = '',Input_nametype = '',Input_cln_title = '',Input_cln_fname = '',Input_cln_mname = '',Input_cln_lname = '',Input_cln_suffix = '',Input_cln_fullname = '',Input_process_date = '',Input_process_time = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_current_rec = '',Input_ingest_tpe = '',OutFile) := MACRO
  IMPORT SALT311,NeustarWireless;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_salutation)='' )
      '' 
    #ELSE
        IF( le.Input_salutation = (TYPEOF(le.Input_salutation))'','',':salutation')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_house)='' )
      '' 
    #ELSE
        IF( le.Input_house = (TYPEOF(le.Input_house))'','',':house')
    #END
 
+    #IF( #TEXT(Input_pre_dir)='' )
      '' 
    #ELSE
        IF( le.Input_pre_dir = (TYPEOF(le.Input_pre_dir))'','',':pre_dir')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_street_type = (TYPEOF(le.Input_street_type))'','',':street_type')
    #END
 
+    #IF( #TEXT(Input_post_dir)='' )
      '' 
    #ELSE
        IF( le.Input_post_dir = (TYPEOF(le.Input_post_dir))'','',':post_dir')
    #END
 
+    #IF( #TEXT(Input_apt_type)='' )
      '' 
    #ELSE
        IF( le.Input_apt_type = (TYPEOF(le.Input_apt_type))'','',':apt_type')
    #END
 
+    #IF( #TEXT(Input_apt_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_apt_nbr = (TYPEOF(le.Input_apt_nbr))'','',':apt_nbr')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_plus4)='' )
      '' 
    #ELSE
        IF( le.Input_plus4 = (TYPEOF(le.Input_plus4))'','',':plus4')
    #END
 
+    #IF( #TEXT(Input_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_dpc = (TYPEOF(le.Input_dpc))'','',':dpc')
    #END
 
+    #IF( #TEXT(Input_z4_type)='' )
      '' 
    #ELSE
        IF( le.Input_z4_type = (TYPEOF(le.Input_z4_type))'','',':z4_type')
    #END
 
+    #IF( #TEXT(Input_crte)='' )
      '' 
    #ELSE
        IF( le.Input_crte = (TYPEOF(le.Input_crte))'','',':crte')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_dpvcmra)='' )
      '' 
    #ELSE
        IF( le.Input_dpvcmra = (TYPEOF(le.Input_dpvcmra))'','',':dpvcmra')
    #END
 
+    #IF( #TEXT(Input_dpvconf)='' )
      '' 
    #ELSE
        IF( le.Input_dpvconf = (TYPEOF(le.Input_dpvconf))'','',':dpvconf')
    #END
 
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_census_tract)='' )
      '' 
    #ELSE
        IF( le.Input_census_tract = (TYPEOF(le.Input_census_tract))'','',':census_tract')
    #END
 
+    #IF( #TEXT(Input_census_block_group)='' )
      '' 
    #ELSE
        IF( le.Input_census_block_group = (TYPEOF(le.Input_census_block_group))'','',':census_block_group')
    #END
 
+    #IF( #TEXT(Input_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa = (TYPEOF(le.Input_cbsa))'','',':cbsa')
    #END
 
+    #IF( #TEXT(Input_match_code)='' )
      '' 
    #ELSE
        IF( le.Input_match_code = (TYPEOF(le.Input_match_code))'','',':match_code')
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
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_verified)='' )
      '' 
    #ELSE
        IF( le.Input_verified = (TYPEOF(le.Input_verified))'','',':verified')
    #END
 
+    #IF( #TEXT(Input_activity_status)='' )
      '' 
    #ELSE
        IF( le.Input_activity_status = (TYPEOF(le.Input_activity_status))'','',':activity_status')
    #END
 
+    #IF( #TEXT(Input_prepaid)='' )
      '' 
    #ELSE
        IF( le.Input_prepaid = (TYPEOF(le.Input_prepaid))'','',':prepaid')
    #END
 
+    #IF( #TEXT(Input_cord_cutter)='' )
      '' 
    #ELSE
        IF( le.Input_cord_cutter = (TYPEOF(le.Input_cord_cutter))'','',':cord_cutter')
    #END
 
+    #IF( #TEXT(Input_raw_file_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_file_name = (TYPEOF(le.Input_raw_file_name))'','',':raw_file_name')
    #END
 
+    #IF( #TEXT(Input_rcid)='' )
      '' 
    #ELSE
        IF( le.Input_rcid = (TYPEOF(le.Input_rcid))'','',':rcid')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
 
+    #IF( #TEXT(Input_xadl2_weight)='' )
      '' 
    #ELSE
        IF( le.Input_xadl2_weight = (TYPEOF(le.Input_xadl2_weight))'','',':xadl2_weight')
    #END
 
+    #IF( #TEXT(Input_xadl2_score)='' )
      '' 
    #ELSE
        IF( le.Input_xadl2_score = (TYPEOF(le.Input_xadl2_score))'','',':xadl2_score')
    #END
 
+    #IF( #TEXT(Input_xadl2_keys_used)='' )
      '' 
    #ELSE
        IF( le.Input_xadl2_keys_used = (TYPEOF(le.Input_xadl2_keys_used))'','',':xadl2_keys_used')
    #END
 
+    #IF( #TEXT(Input_xadl2_distance)='' )
      '' 
    #ELSE
        IF( le.Input_xadl2_distance = (TYPEOF(le.Input_xadl2_distance))'','',':xadl2_distance')
    #END
 
+    #IF( #TEXT(Input_xadl2_matches)='' )
      '' 
    #ELSE
        IF( le.Input_xadl2_matches = (TYPEOF(le.Input_xadl2_matches))'','',':xadl2_matches')
    #END
 
+    #IF( #TEXT(Input_append_prep_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_address_1 = (TYPEOF(le.Input_append_prep_address_1))'','',':append_prep_address_1')
    #END
 
+    #IF( #TEXT(Input_append_prep_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_address_2 = (TYPEOF(le.Input_append_prep_address_2))'','',':append_prep_address_2')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_aceaid = (TYPEOF(le.Input_aceaid))'','',':aceaid')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_range = (TYPEOF(le.Input_clean_address_prim_range))'','',':clean_address.prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_address_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_predir = (TYPEOF(le.Input_clean_address_predir))'','',':clean_address.predir')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_name = (TYPEOF(le.Input_clean_address_prim_name))'','',':clean_address.prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_addr_suffix = (TYPEOF(le.Input_clean_address_addr_suffix))'','',':clean_address.addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_address_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_postdir = (TYPEOF(le.Input_clean_address_postdir))'','',':clean_address.postdir')
    #END
 
+    #IF( #TEXT(Input_clean_address_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_unit_desig = (TYPEOF(le.Input_clean_address_unit_desig))'','',':clean_address.unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_address_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_sec_range = (TYPEOF(le.Input_clean_address_sec_range))'','',':clean_address.sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_p_city_name = (TYPEOF(le.Input_clean_address_p_city_name))'','',':clean_address.p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_v_city_name = (TYPEOF(le.Input_clean_address_v_city_name))'','',':clean_address.v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_st = (TYPEOF(le.Input_clean_address_st))'','',':clean_address.st')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip = (TYPEOF(le.Input_clean_address_zip))'','',':clean_address.zip')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip4 = (TYPEOF(le.Input_clean_address_zip4))'','',':clean_address.zip4')
    #END
 
+    #IF( #TEXT(Input_clean_address_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_cart = (TYPEOF(le.Input_clean_address_cart))'','',':clean_address.cart')
    #END
 
+    #IF( #TEXT(Input_clean_address_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_cr_sort_sz = (TYPEOF(le.Input_clean_address_cr_sort_sz))'','',':clean_address.cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_address_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_lot = (TYPEOF(le.Input_clean_address_lot))'','',':clean_address.lot')
    #END
 
+    #IF( #TEXT(Input_clean_address_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_lot_order = (TYPEOF(le.Input_clean_address_lot_order))'','',':clean_address.lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_address_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_dbpc = (TYPEOF(le.Input_clean_address_dbpc))'','',':clean_address.dbpc')
    #END
 
+    #IF( #TEXT(Input_clean_address_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_chk_digit = (TYPEOF(le.Input_clean_address_chk_digit))'','',':clean_address.chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_address_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_rec_type = (TYPEOF(le.Input_clean_address_rec_type))'','',':clean_address.rec_type')
    #END
 
+    #IF( #TEXT(Input_clean_address_county)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_county = (TYPEOF(le.Input_clean_address_county))'','',':clean_address.county')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_lat = (TYPEOF(le.Input_clean_address_geo_lat))'','',':clean_address.geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_long = (TYPEOF(le.Input_clean_address_geo_long))'','',':clean_address.geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_address_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_msa = (TYPEOF(le.Input_clean_address_msa))'','',':clean_address.msa')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_blk = (TYPEOF(le.Input_clean_address_geo_blk))'','',':clean_address.geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_match = (TYPEOF(le.Input_clean_address_geo_match))'','',':clean_address.geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_address_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_err_stat = (TYPEOF(le.Input_clean_address_err_stat))'','',':clean_address.err_stat')
    #END
 
+    #IF( #TEXT(Input_append_prep_name)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_name = (TYPEOF(le.Input_append_prep_name))'','',':append_prep_name')
    #END
 
+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END
 
+    #IF( #TEXT(Input_name_ind)='' )
      '' 
    #ELSE
        IF( le.Input_name_ind = (TYPEOF(le.Input_name_ind))'','',':name_ind')
    #END
 
+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
    #END
 
+    #IF( #TEXT(Input_cln_title)='' )
      '' 
    #ELSE
        IF( le.Input_cln_title = (TYPEOF(le.Input_cln_title))'','',':cln_title')
    #END
 
+    #IF( #TEXT(Input_cln_fname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_fname = (TYPEOF(le.Input_cln_fname))'','',':cln_fname')
    #END
 
+    #IF( #TEXT(Input_cln_mname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_mname = (TYPEOF(le.Input_cln_mname))'','',':cln_mname')
    #END
 
+    #IF( #TEXT(Input_cln_lname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_lname = (TYPEOF(le.Input_cln_lname))'','',':cln_lname')
    #END
 
+    #IF( #TEXT(Input_cln_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cln_suffix = (TYPEOF(le.Input_cln_suffix))'','',':cln_suffix')
    #END
 
+    #IF( #TEXT(Input_cln_fullname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_fullname = (TYPEOF(le.Input_cln_fullname))'','',':cln_fullname')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_process_time)='' )
      '' 
    #ELSE
        IF( le.Input_process_time = (TYPEOF(le.Input_process_time))'','',':process_time')
    #END
 
+    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_current_rec)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec = (TYPEOF(le.Input_current_rec))'','',':current_rec')
    #END
 
+    #IF( #TEXT(Input_ingest_tpe)='' )
      '' 
    #ELSE
        IF( le.Input_ingest_tpe = (TYPEOF(le.Input_ingest_tpe))'','',':ingest_tpe')
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
