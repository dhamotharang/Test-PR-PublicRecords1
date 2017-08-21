EXPORT MAC_PopulationStatistics(infile,Ref='',Input_record_id = '',Input_pubdate = '',Input_filler = '',Input_yppa_code = '',Input_book_code = '',Input_page_number = '',Input_record_number = '',Input_phone_number = '',Input_phone_type = '',Input_record_type = '',Input_no_solicitation_code = '',Input_title = '',Input_first_name = '',Input_middle_name = '',Input_last_name = '',Input_last_name_suffix = '',Input_job_title = '',Input_secondary_name_title = '',Input_secondary_first_name = '',Input_secondary_middle_name = '',Input_secondary_name_suffix = '',Input_house_number = '',Input_pre_direction = '',Input_street_name = '',Input_street_type = '',Input_post_direction = '',Input_apt_type = '',Input_apt_number = '',Input_box_number = '',Input_expanded_pub_city_name = '',Input_postal_city_name = '',Input_state = '',Input_z5 = '',Input_plus4 = '',Input_delivery_point_code = '',Input_carrier_route = '',Input_county_code_ = '',Input_gnrl_address_return_code = '',Input_house_number_usage_flag = '',Input_pre_direction_usage_flag = '',Input_street_name_usage_flag = '',Input_street_type_usage_flag = '',Input_post_direction_usage_flag = '',Input_apt_number_usage_flag = '',Input_validation_date = '',Input_validation_flag = '',Input_filler1 = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_last_reported = '',Input_dt_vendor_first_reported = '',Input_rec_type = '',Input_hhid = '',Input_did = '',Input_did_score = '',Input_fname = '',Input_minit = '',Input_lname = '',Input_name_suffix = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_county = '',Input_cbsa = '',Input_geo_blk = '',Input_cleanname = '',Input_cleanaddress = '',Input_active = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Targus;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END
+    #IF( #TEXT(Input_pubdate)='' )
      '' 
    #ELSE
        IF( le.Input_pubdate = (TYPEOF(le.Input_pubdate))'','',':pubdate')
    #END
+    #IF( #TEXT(Input_filler)='' )
      '' 
    #ELSE
        IF( le.Input_filler = (TYPEOF(le.Input_filler))'','',':filler')
    #END
+    #IF( #TEXT(Input_yppa_code)='' )
      '' 
    #ELSE
        IF( le.Input_yppa_code = (TYPEOF(le.Input_yppa_code))'','',':yppa_code')
    #END
+    #IF( #TEXT(Input_book_code)='' )
      '' 
    #ELSE
        IF( le.Input_book_code = (TYPEOF(le.Input_book_code))'','',':book_code')
    #END
+    #IF( #TEXT(Input_page_number)='' )
      '' 
    #ELSE
        IF( le.Input_page_number = (TYPEOF(le.Input_page_number))'','',':page_number')
    #END
+    #IF( #TEXT(Input_record_number)='' )
      '' 
    #ELSE
        IF( le.Input_record_number = (TYPEOF(le.Input_record_number))'','',':record_number')
    #END
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
+    #IF( #TEXT(Input_no_solicitation_code)='' )
      '' 
    #ELSE
        IF( le.Input_no_solicitation_code = (TYPEOF(le.Input_no_solicitation_code))'','',':no_solicitation_code')
    #END
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
+    #IF( #TEXT(Input_last_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_last_name_suffix = (TYPEOF(le.Input_last_name_suffix))'','',':last_name_suffix')
    #END
+    #IF( #TEXT(Input_job_title)='' )
      '' 
    #ELSE
        IF( le.Input_job_title = (TYPEOF(le.Input_job_title))'','',':job_title')
    #END
+    #IF( #TEXT(Input_secondary_name_title)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_name_title = (TYPEOF(le.Input_secondary_name_title))'','',':secondary_name_title')
    #END
+    #IF( #TEXT(Input_secondary_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_first_name = (TYPEOF(le.Input_secondary_first_name))'','',':secondary_first_name')
    #END
+    #IF( #TEXT(Input_secondary_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_middle_name = (TYPEOF(le.Input_secondary_middle_name))'','',':secondary_middle_name')
    #END
+    #IF( #TEXT(Input_secondary_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_name_suffix = (TYPEOF(le.Input_secondary_name_suffix))'','',':secondary_name_suffix')
    #END
+    #IF( #TEXT(Input_house_number)='' )
      '' 
    #ELSE
        IF( le.Input_house_number = (TYPEOF(le.Input_house_number))'','',':house_number')
    #END
+    #IF( #TEXT(Input_pre_direction)='' )
      '' 
    #ELSE
        IF( le.Input_pre_direction = (TYPEOF(le.Input_pre_direction))'','',':pre_direction')
    #END
+    #IF( #TEXT(Input_street_name)='' )
      '' 
    #ELSE
        IF( le.Input_street_name = (TYPEOF(le.Input_street_name))'','',':street_name')
    #END
+    #IF( #TEXT(Input_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_street_type = (TYPEOF(le.Input_street_type))'','',':street_type')
    #END
+    #IF( #TEXT(Input_post_direction)='' )
      '' 
    #ELSE
        IF( le.Input_post_direction = (TYPEOF(le.Input_post_direction))'','',':post_direction')
    #END
+    #IF( #TEXT(Input_apt_type)='' )
      '' 
    #ELSE
        IF( le.Input_apt_type = (TYPEOF(le.Input_apt_type))'','',':apt_type')
    #END
+    #IF( #TEXT(Input_apt_number)='' )
      '' 
    #ELSE
        IF( le.Input_apt_number = (TYPEOF(le.Input_apt_number))'','',':apt_number')
    #END
+    #IF( #TEXT(Input_box_number)='' )
      '' 
    #ELSE
        IF( le.Input_box_number = (TYPEOF(le.Input_box_number))'','',':box_number')
    #END
+    #IF( #TEXT(Input_expanded_pub_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_expanded_pub_city_name = (TYPEOF(le.Input_expanded_pub_city_name))'','',':expanded_pub_city_name')
    #END
+    #IF( #TEXT(Input_postal_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_postal_city_name = (TYPEOF(le.Input_postal_city_name))'','',':postal_city_name')
    #END
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
+    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
    #END
+    #IF( #TEXT(Input_plus4)='' )
      '' 
    #ELSE
        IF( le.Input_plus4 = (TYPEOF(le.Input_plus4))'','',':plus4')
    #END
+    #IF( #TEXT(Input_delivery_point_code)='' )
      '' 
    #ELSE
        IF( le.Input_delivery_point_code = (TYPEOF(le.Input_delivery_point_code))'','',':delivery_point_code')
    #END
+    #IF( #TEXT(Input_carrier_route)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_route = (TYPEOF(le.Input_carrier_route))'','',':carrier_route')
    #END
+    #IF( #TEXT(Input_county_code_)='' )
      '' 
    #ELSE
        IF( le.Input_county_code_ = (TYPEOF(le.Input_county_code_))'','',':county_code_')
    #END
+    #IF( #TEXT(Input_gnrl_address_return_code)='' )
      '' 
    #ELSE
        IF( le.Input_gnrl_address_return_code = (TYPEOF(le.Input_gnrl_address_return_code))'','',':gnrl_address_return_code')
    #END
+    #IF( #TEXT(Input_house_number_usage_flag)='' )
      '' 
    #ELSE
        IF( le.Input_house_number_usage_flag = (TYPEOF(le.Input_house_number_usage_flag))'','',':house_number_usage_flag')
    #END
+    #IF( #TEXT(Input_pre_direction_usage_flag)='' )
      '' 
    #ELSE
        IF( le.Input_pre_direction_usage_flag = (TYPEOF(le.Input_pre_direction_usage_flag))'','',':pre_direction_usage_flag')
    #END
+    #IF( #TEXT(Input_street_name_usage_flag)='' )
      '' 
    #ELSE
        IF( le.Input_street_name_usage_flag = (TYPEOF(le.Input_street_name_usage_flag))'','',':street_name_usage_flag')
    #END
+    #IF( #TEXT(Input_street_type_usage_flag)='' )
      '' 
    #ELSE
        IF( le.Input_street_type_usage_flag = (TYPEOF(le.Input_street_type_usage_flag))'','',':street_type_usage_flag')
    #END
+    #IF( #TEXT(Input_post_direction_usage_flag)='' )
      '' 
    #ELSE
        IF( le.Input_post_direction_usage_flag = (TYPEOF(le.Input_post_direction_usage_flag))'','',':post_direction_usage_flag')
    #END
+    #IF( #TEXT(Input_apt_number_usage_flag)='' )
      '' 
    #ELSE
        IF( le.Input_apt_number_usage_flag = (TYPEOF(le.Input_apt_number_usage_flag))'','',':apt_number_usage_flag')
    #END
+    #IF( #TEXT(Input_validation_date)='' )
      '' 
    #ELSE
        IF( le.Input_validation_date = (TYPEOF(le.Input_validation_date))'','',':validation_date')
    #END
+    #IF( #TEXT(Input_validation_flag)='' )
      '' 
    #ELSE
        IF( le.Input_validation_flag = (TYPEOF(le.Input_validation_flag))'','',':validation_flag')
    #END
+    #IF( #TEXT(Input_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_filler1 = (TYPEOF(le.Input_filler1))'','',':filler1')
    #END
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_hhid)='' )
      '' 
    #ELSE
        IF( le.Input_hhid = (TYPEOF(le.Input_hhid))'','',':hhid')
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
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+    #IF( #TEXT(Input_minit)='' )
      '' 
    #ELSE
        IF( le.Input_minit = (TYPEOF(le.Input_minit))'','',':minit')
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
+    #IF( #TEXT(Input_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_city_name = (TYPEOF(le.Input_city_name))'','',':city_name')
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
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
+    #IF( #TEXT(Input_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa = (TYPEOF(le.Input_cbsa))'','',':cbsa')
    #END
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
+    #IF( #TEXT(Input_cleanname)='' )
      '' 
    #ELSE
        IF( le.Input_cleanname = (TYPEOF(le.Input_cleanname))'','',':cleanname')
    #END
+    #IF( #TEXT(Input_cleanaddress)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaddress = (TYPEOF(le.Input_cleanaddress))'','',':cleanaddress')
    #END
+    #IF( #TEXT(Input_active)='' )
      '' 
    #ELSE
        IF( le.Input_active = (TYPEOF(le.Input_active))'','',':active')
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
