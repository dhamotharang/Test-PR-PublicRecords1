
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_seq_rec_id = '',Input_did = '',Input_did_score_field = '',Input_current_rec_flag = '',Input_current_experian_pin = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_encrypted_experian_pin = '',Input_social_security_number = '',Input_date_of_birth = '',Input_telephone = '',Input_gender = '',Input_additional_name_count = '',Input_previous_address_count = '',Input_nametype = '',Input_orig_consumer_create_date = '',Input_orig_fname = '',Input_orig_mname = '',Input_orig_lname = '',Input_orig_suffix = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_addressseq = '',Input_orig_address_create_date = '',Input_orig_address_update_date = '',Input_orig_prim_range = '',Input_orig_predir = '',Input_orig_prim_name = '',Input_orig_addr_suffix = '',Input_orig_postdir = '',Input_orig_unit_desig = '',Input_orig_sec_range = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zipcode = '',Input_orig_zipcode4 = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_delete_flag = '',Input_delete_file_date = '',Input_suppression_code = '',Input_deceased_ind = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Experian_Monthly;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_seq_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_seq_rec_id = (TYPEOF(le.Input_seq_rec_id))'','',':seq_rec_id')
    #END

+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END

+    #IF( #TEXT(Input_did_score_field)='' )
      '' 
    #ELSE
        IF( le.Input_did_score_field = (TYPEOF(le.Input_did_score_field))'','',':did_score_field')
    #END

+    #IF( #TEXT(Input_current_rec_flag)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec_flag = (TYPEOF(le.Input_current_rec_flag))'','',':current_rec_flag')
    #END

+    #IF( #TEXT(Input_current_experian_pin)='' )
      '' 
    #ELSE
        IF( le.Input_current_experian_pin = (TYPEOF(le.Input_current_experian_pin))'','',':current_experian_pin')
    #END

+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END

+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
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

+    #IF( #TEXT(Input_encrypted_experian_pin)='' )
      '' 
    #ELSE
        IF( le.Input_encrypted_experian_pin = (TYPEOF(le.Input_encrypted_experian_pin))'','',':encrypted_experian_pin')
    #END

+    #IF( #TEXT(Input_social_security_number)='' )
      '' 
    #ELSE
        IF( le.Input_social_security_number = (TYPEOF(le.Input_social_security_number))'','',':social_security_number')
    #END

+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END

+    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END

+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END

+    #IF( #TEXT(Input_additional_name_count)='' )
      '' 
    #ELSE
        IF( le.Input_additional_name_count = (TYPEOF(le.Input_additional_name_count))'','',':additional_name_count')
    #END

+    #IF( #TEXT(Input_previous_address_count)='' )
      '' 
    #ELSE
        IF( le.Input_previous_address_count = (TYPEOF(le.Input_previous_address_count))'','',':previous_address_count')
    #END

+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
    #END

+    #IF( #TEXT(Input_orig_consumer_create_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_consumer_create_date = (TYPEOF(le.Input_orig_consumer_create_date))'','',':orig_consumer_create_date')
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

+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END

+    #IF( #TEXT(Input_orig_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_suffix = (TYPEOF(le.Input_orig_suffix))'','',':orig_suffix')
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

+    #IF( #TEXT(Input_addressseq)='' )
      '' 
    #ELSE
        IF( le.Input_addressseq = (TYPEOF(le.Input_addressseq))'','',':addressseq')
    #END

+    #IF( #TEXT(Input_orig_address_create_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address_create_date = (TYPEOF(le.Input_orig_address_create_date))'','',':orig_address_create_date')
    #END

+    #IF( #TEXT(Input_orig_address_update_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address_update_date = (TYPEOF(le.Input_orig_address_update_date))'','',':orig_address_update_date')
    #END

+    #IF( #TEXT(Input_orig_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_orig_prim_range = (TYPEOF(le.Input_orig_prim_range))'','',':orig_prim_range')
    #END

+    #IF( #TEXT(Input_orig_predir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_predir = (TYPEOF(le.Input_orig_predir))'','',':orig_predir')
    #END

+    #IF( #TEXT(Input_orig_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_prim_name = (TYPEOF(le.Input_orig_prim_name))'','',':orig_prim_name')
    #END

+    #IF( #TEXT(Input_orig_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addr_suffix = (TYPEOF(le.Input_orig_addr_suffix))'','',':orig_addr_suffix')
    #END

+    #IF( #TEXT(Input_orig_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_orig_postdir = (TYPEOF(le.Input_orig_postdir))'','',':orig_postdir')
    #END

+    #IF( #TEXT(Input_orig_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_orig_unit_desig = (TYPEOF(le.Input_orig_unit_desig))'','',':orig_unit_desig')
    #END

+    #IF( #TEXT(Input_orig_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_orig_sec_range = (TYPEOF(le.Input_orig_sec_range))'','',':orig_sec_range')
    #END

+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END

+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END

+    #IF( #TEXT(Input_orig_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zipcode = (TYPEOF(le.Input_orig_zipcode))'','',':orig_zipcode')
    #END

+    #IF( #TEXT(Input_orig_zipcode4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zipcode4 = (TYPEOF(le.Input_orig_zipcode4))'','',':orig_zipcode4')
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

+    #IF( #TEXT(Input_delete_flag)='' )
      '' 
    #ELSE
        IF( le.Input_delete_flag = (TYPEOF(le.Input_delete_flag))'','',':delete_flag')
    #END

+    #IF( #TEXT(Input_delete_file_date)='' )
      '' 
    #ELSE
        IF( le.Input_delete_file_date = (TYPEOF(le.Input_delete_file_date))'','',':delete_file_date')
    #END

+    #IF( #TEXT(Input_suppression_code)='' )
      '' 
    #ELSE
        IF( le.Input_suppression_code = (TYPEOF(le.Input_suppression_code))'','',':suppression_code')
    #END

+    #IF( #TEXT(Input_deceased_ind)='' )
      '' 
    #ELSE
        IF( le.Input_deceased_ind = (TYPEOF(le.Input_deceased_ind))'','',':deceased_ind')
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
