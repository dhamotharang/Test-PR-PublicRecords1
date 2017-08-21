EXPORT MAC_PopulationStatistics(infile,Ref='',Input_id = '',Input_exchange_serial_number = '',Input_date_added_to_exchange = '',Input_connect_date = '',Input_date_first_seen = '',Input_record_date = '',Input_util_type = '',Input_orig_lname = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_name_suffix = '',Input_addr_type = '',Input_addr_dual = '',Input_address_street = '',Input_address_street_Name = '',Input_address_street_type = '',Input_address_street_direction = '',Input_address_apartment = '',Input_address_city = '',Input_address_state = '',Input_address_zip = '',Input_ssn = '',Input_work_phone = '',Input_phone = '',Input_dob = '',Input_drivers_license_state_code = '',Input_drivers_license = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_did = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_fdid = '',Input_hhid = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_UtilDid;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_id)='' )
      '' 
    #ELSE
        IF( le.Input_id = (TYPEOF(le.Input_id))'','',':id')
    #END
+    #IF( #TEXT(Input_exchange_serial_number)='' )
      '' 
    #ELSE
        IF( le.Input_exchange_serial_number = (TYPEOF(le.Input_exchange_serial_number))'','',':exchange_serial_number')
    #END
+    #IF( #TEXT(Input_date_added_to_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_date_added_to_exchange = (TYPEOF(le.Input_date_added_to_exchange))'','',':date_added_to_exchange')
    #END
+    #IF( #TEXT(Input_connect_date)='' )
      '' 
    #ELSE
        IF( le.Input_connect_date = (TYPEOF(le.Input_connect_date))'','',':connect_date')
    #END
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
+    #IF( #TEXT(Input_record_date)='' )
      '' 
    #ELSE
        IF( le.Input_record_date = (TYPEOF(le.Input_record_date))'','',':record_date')
    #END
+    #IF( #TEXT(Input_util_type)='' )
      '' 
    #ELSE
        IF( le.Input_util_type = (TYPEOF(le.Input_util_type))'','',':util_type')
    #END
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
+    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
+    #IF( #TEXT(Input_orig_mname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mname = (TYPEOF(le.Input_orig_mname))'','',':orig_mname')
    #END
+    #IF( #TEXT(Input_orig_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_name_suffix = (TYPEOF(le.Input_orig_name_suffix))'','',':orig_name_suffix')
    #END
+    #IF( #TEXT(Input_addr_type)='' )
      '' 
    #ELSE
        IF( le.Input_addr_type = (TYPEOF(le.Input_addr_type))'','',':addr_type')
    #END
+    #IF( #TEXT(Input_addr_dual)='' )
      '' 
    #ELSE
        IF( le.Input_addr_dual = (TYPEOF(le.Input_addr_dual))'','',':addr_dual')
    #END
+    #IF( #TEXT(Input_address_street)='' )
      '' 
    #ELSE
        IF( le.Input_address_street = (TYPEOF(le.Input_address_street))'','',':address_street')
    #END
+    #IF( #TEXT(Input_address_street_Name)='' )
      '' 
    #ELSE
        IF( le.Input_address_street_Name = (TYPEOF(le.Input_address_street_Name))'','',':address_street_Name')
    #END
+    #IF( #TEXT(Input_address_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_street_type = (TYPEOF(le.Input_address_street_type))'','',':address_street_type')
    #END
+    #IF( #TEXT(Input_address_street_direction)='' )
      '' 
    #ELSE
        IF( le.Input_address_street_direction = (TYPEOF(le.Input_address_street_direction))'','',':address_street_direction')
    #END
+    #IF( #TEXT(Input_address_apartment)='' )
      '' 
    #ELSE
        IF( le.Input_address_apartment = (TYPEOF(le.Input_address_apartment))'','',':address_apartment')
    #END
+    #IF( #TEXT(Input_address_city)='' )
      '' 
    #ELSE
        IF( le.Input_address_city = (TYPEOF(le.Input_address_city))'','',':address_city')
    #END
+    #IF( #TEXT(Input_address_state)='' )
      '' 
    #ELSE
        IF( le.Input_address_state = (TYPEOF(le.Input_address_state))'','',':address_state')
    #END
+    #IF( #TEXT(Input_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_address_zip = (TYPEOF(le.Input_address_zip))'','',':address_zip')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_work_phone = (TYPEOF(le.Input_work_phone))'','',':work_phone')
    #END
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
+    #IF( #TEXT(Input_drivers_license_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_state_code = (TYPEOF(le.Input_drivers_license_state_code))'','',':drivers_license_state_code')
    #END
+    #IF( #TEXT(Input_drivers_license)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license = (TYPEOF(le.Input_drivers_license))'','',':drivers_license')
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
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
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
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
+    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
    #END
+    #IF( #TEXT(Input_fdid)='' )
      '' 
    #ELSE
        IF( le.Input_fdid = (TYPEOF(le.Input_fdid))'','',':fdid')
    #END
+    #IF( #TEXT(Input_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_hhid = (TYPEOF(le.Input_hhid))'','',':hhid')
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
