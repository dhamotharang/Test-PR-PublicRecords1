
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_persistent_record_id = '',Input_src = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_did = '',Input_did_score = '',Input_orig_first_name = '',Input_orig_middle_name = '',Input_orig_last_name = '',Input_orig_suffix = '',Input_orig_address1 = '',Input_orig_address2 = '',Input_orig_city = '',Input_orig_state_province = '',Input_orig_zip4 = '',Input_orig_zip5 = '',Input_orig_dob = '',Input_orig_ssn = '',Input_orig_dl = '',Input_orig_dlstate = '',Input_orig_phone = '',Input_clientassigneduniquerecordid = '',Input_adl_ind = '',Input_orig_email = '',Input_orig_ipaddress = '',Input_orig_filecategory = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_nid = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_rawaid = '',Input_aceaid = '',Input_clean_phone = '',Input_clean_dob = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_IDA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END

+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
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

+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END

+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
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

+    #IF( #TEXT(Input_orig_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_first_name = (TYPEOF(le.Input_orig_first_name))'','',':orig_first_name')
    #END

+    #IF( #TEXT(Input_orig_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_middle_name = (TYPEOF(le.Input_orig_middle_name))'','',':orig_middle_name')
    #END

+    #IF( #TEXT(Input_orig_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_last_name = (TYPEOF(le.Input_orig_last_name))'','',':orig_last_name')
    #END

+    #IF( #TEXT(Input_orig_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_orig_suffix = (TYPEOF(le.Input_orig_suffix))'','',':orig_suffix')
    #END

+    #IF( #TEXT(Input_orig_address1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address1 = (TYPEOF(le.Input_orig_address1))'','',':orig_address1')
    #END

+    #IF( #TEXT(Input_orig_address2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_address2 = (TYPEOF(le.Input_orig_address2))'','',':orig_address2')
    #END

+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END

+    #IF( #TEXT(Input_orig_state_province)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state_province = (TYPEOF(le.Input_orig_state_province))'','',':orig_state_province')
    #END

+    #IF( #TEXT(Input_orig_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4 = (TYPEOF(le.Input_orig_zip4))'','',':orig_zip4')
    #END

+    #IF( #TEXT(Input_orig_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip5 = (TYPEOF(le.Input_orig_zip5))'','',':orig_zip5')
    #END

+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END

+    #IF( #TEXT(Input_orig_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ssn = (TYPEOF(le.Input_orig_ssn))'','',':orig_ssn')
    #END

+    #IF( #TEXT(Input_orig_dl)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dl = (TYPEOF(le.Input_orig_dl))'','',':orig_dl')
    #END

+    #IF( #TEXT(Input_orig_dlstate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlstate = (TYPEOF(le.Input_orig_dlstate))'','',':orig_dlstate')
    #END

+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END

+    #IF( #TEXT(Input_clientassigneduniquerecordid)='' )
      '' 
    #ELSE
        IF( le.Input_clientassigneduniquerecordid = (TYPEOF(le.Input_clientassigneduniquerecordid))'','',':clientassigneduniquerecordid')
    #END

+    #IF( #TEXT(Input_adl_ind)='' )
      '' 
    #ELSE
        IF( le.Input_adl_ind = (TYPEOF(le.Input_adl_ind))'','',':adl_ind')
    #END

+    #IF( #TEXT(Input_orig_email)='' )
      '' 
    #ELSE
        IF( le.Input_orig_email = (TYPEOF(le.Input_orig_email))'','',':orig_email')
    #END

+    #IF( #TEXT(Input_orig_ipaddress)='' )
      '' 
    #ELSE
        IF( le.Input_orig_ipaddress = (TYPEOF(le.Input_orig_ipaddress))'','',':orig_ipaddress')
    #END

+    #IF( #TEXT(Input_orig_filecategory)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filecategory = (TYPEOF(le.Input_orig_filecategory))'','',':orig_filecategory')
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

+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
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

+    #IF( #TEXT(Input_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_fips_st = (TYPEOF(le.Input_fips_st))'','',':fips_st')
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

+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END

+    #IF( #TEXT(Input_clean_dob)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dob = (TYPEOF(le.Input_clean_dob))'','',':clean_dob')
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
