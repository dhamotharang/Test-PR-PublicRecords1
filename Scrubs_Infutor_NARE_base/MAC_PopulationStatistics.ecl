EXPORT MAC_PopulationStatistics(infile,Ref='',Input_idnum = '',Input_firstname = '',Input_middlename = '',Input_lastname = '',Input_suffix = '',Input_rectype = '',Input_gender = '',Input_dob = '',Input_addrline1 = '',Input_streetnum = '',Input_streetpredir = '',Input_streetname = '',Input_streetsuffix = '',Input_streetpostdir = '',Input_apttype = '',Input_aptnum = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_zipplus4 = '',Input_dpc = '',Input_z4type = '',Input_crte = '',Input_fipscounty = '',Input_dpv = '',Input_vacantflag = '',Input_phone = '',Input_phone2 = '',Input_email = '',Input_url = '',Input_ipaddr = '',Input_wesitetype = '',Input_datefirstseen = '',Input_datelastseen = '',Input_filedate = '',Input_confidencescore = '',Input_occurance = '',Input_persistid = '',Input_emailsuppressioncd = '',Input_age = '',Input_persistent_record_id = '',Input_did = '',Input_did_score = '',Input_clean_title = '',Input_clean_fname = '',Input_clean_mname = '',Input_clean_lname = '',Input_clean_name_suffix = '',Input_clean_name_score = '',Input_rawaid = '',Input_append_prep_address_situs = '',Input_append_prep_address_last_situs = '',Input_clean_prim_range = '',Input_clean_predir = '',Input_clean_prim_name = '',Input_clean_addr_suffix = '',Input_clean_postdir = '',Input_clean_unit_desig = '',Input_clean_sec_range = '',Input_clean_p_city_name = '',Input_clean_v_city_name = '',Input_clean_st = '',Input_clean_zip = '',Input_clean_zip4 = '',Input_clean_cart = '',Input_clean_cr_sort_sz = '',Input_clean_lot = '',Input_clean_lot_order = '',Input_clean_dbpc = '',Input_clean_chk_digit = '',Input_clean_rec_type = '',Input_clean_county = '',Input_clean_geo_lat = '',Input_clean_geo_long = '',Input_clean_msa = '',Input_clean_geo_blk = '',Input_clean_geo_match = '',Input_clean_err_stat = '',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_current_rec_flag = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Infutor_NARE_base;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_idnum)='' )
      '' 
    #ELSE
        IF( le.Input_idnum = (TYPEOF(le.Input_idnum))'','',':idnum')
    #END
+    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
+    #IF( #TEXT(Input_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_middlename = (TYPEOF(le.Input_middlename))'','',':middlename')
    #END
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
+    #IF( #TEXT(Input_rectype)='' )
      '' 
    #ELSE
        IF( le.Input_rectype = (TYPEOF(le.Input_rectype))'','',':rectype')
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
+    #IF( #TEXT(Input_addrline1)='' )
      '' 
    #ELSE
        IF( le.Input_addrline1 = (TYPEOF(le.Input_addrline1))'','',':addrline1')
    #END
+    #IF( #TEXT(Input_streetnum)='' )
      '' 
    #ELSE
        IF( le.Input_streetnum = (TYPEOF(le.Input_streetnum))'','',':streetnum')
    #END
+    #IF( #TEXT(Input_streetpredir)='' )
      '' 
    #ELSE
        IF( le.Input_streetpredir = (TYPEOF(le.Input_streetpredir))'','',':streetpredir')
    #END
+    #IF( #TEXT(Input_streetname)='' )
      '' 
    #ELSE
        IF( le.Input_streetname = (TYPEOF(le.Input_streetname))'','',':streetname')
    #END
+    #IF( #TEXT(Input_streetsuffix)='' )
      '' 
    #ELSE
        IF( le.Input_streetsuffix = (TYPEOF(le.Input_streetsuffix))'','',':streetsuffix')
    #END
+    #IF( #TEXT(Input_streetpostdir)='' )
      '' 
    #ELSE
        IF( le.Input_streetpostdir = (TYPEOF(le.Input_streetpostdir))'','',':streetpostdir')
    #END
+    #IF( #TEXT(Input_apttype)='' )
      '' 
    #ELSE
        IF( le.Input_apttype = (TYPEOF(le.Input_apttype))'','',':apttype')
    #END
+    #IF( #TEXT(Input_aptnum)='' )
      '' 
    #ELSE
        IF( le.Input_aptnum = (TYPEOF(le.Input_aptnum))'','',':aptnum')
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
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
+    #IF( #TEXT(Input_zipplus4)='' )
      '' 
    #ELSE
        IF( le.Input_zipplus4 = (TYPEOF(le.Input_zipplus4))'','',':zipplus4')
    #END
+    #IF( #TEXT(Input_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_dpc = (TYPEOF(le.Input_dpc))'','',':dpc')
    #END
+    #IF( #TEXT(Input_z4type)='' )
      '' 
    #ELSE
        IF( le.Input_z4type = (TYPEOF(le.Input_z4type))'','',':z4type')
    #END
+    #IF( #TEXT(Input_crte)='' )
      '' 
    #ELSE
        IF( le.Input_crte = (TYPEOF(le.Input_crte))'','',':crte')
    #END
+    #IF( #TEXT(Input_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_fipscounty = (TYPEOF(le.Input_fipscounty))'','',':fipscounty')
    #END
+    #IF( #TEXT(Input_dpv)='' )
      '' 
    #ELSE
        IF( le.Input_dpv = (TYPEOF(le.Input_dpv))'','',':dpv')
    #END
+    #IF( #TEXT(Input_vacantflag)='' )
      '' 
    #ELSE
        IF( le.Input_vacantflag = (TYPEOF(le.Input_vacantflag))'','',':vacantflag')
    #END
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
+    #IF( #TEXT(Input_phone2)='' )
      '' 
    #ELSE
        IF( le.Input_phone2 = (TYPEOF(le.Input_phone2))'','',':phone2')
    #END
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
+    #IF( #TEXT(Input_ipaddr)='' )
      '' 
    #ELSE
        IF( le.Input_ipaddr = (TYPEOF(le.Input_ipaddr))'','',':ipaddr')
    #END
+    #IF( #TEXT(Input_wesitetype)='' )
      '' 
    #ELSE
        IF( le.Input_wesitetype = (TYPEOF(le.Input_wesitetype))'','',':wesitetype')
    #END
+    #IF( #TEXT(Input_datefirstseen)='' )
      '' 
    #ELSE
        IF( le.Input_datefirstseen = (TYPEOF(le.Input_datefirstseen))'','',':datefirstseen')
    #END
+    #IF( #TEXT(Input_datelastseen)='' )
      '' 
    #ELSE
        IF( le.Input_datelastseen = (TYPEOF(le.Input_datelastseen))'','',':datelastseen')
    #END
+    #IF( #TEXT(Input_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_filedate = (TYPEOF(le.Input_filedate))'','',':filedate')
    #END
+    #IF( #TEXT(Input_confidencescore)='' )
      '' 
    #ELSE
        IF( le.Input_confidencescore = (TYPEOF(le.Input_confidencescore))'','',':confidencescore')
    #END
+    #IF( #TEXT(Input_occurance)='' )
      '' 
    #ELSE
        IF( le.Input_occurance = (TYPEOF(le.Input_occurance))'','',':occurance')
    #END
+    #IF( #TEXT(Input_persistid)='' )
      '' 
    #ELSE
        IF( le.Input_persistid = (TYPEOF(le.Input_persistid))'','',':persistid')
    #END
+    #IF( #TEXT(Input_emailsuppressioncd)='' )
      '' 
    #ELSE
        IF( le.Input_emailsuppressioncd = (TYPEOF(le.Input_emailsuppressioncd))'','',':emailsuppressioncd')
    #END
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
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
+    #IF( #TEXT(Input_clean_title)='' )
      '' 
    #ELSE
        IF( le.Input_clean_title = (TYPEOF(le.Input_clean_title))'','',':clean_title')
    #END
+    #IF( #TEXT(Input_clean_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fname = (TYPEOF(le.Input_clean_fname))'','',':clean_fname')
    #END
+    #IF( #TEXT(Input_clean_mname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_mname = (TYPEOF(le.Input_clean_mname))'','',':clean_mname')
    #END
+    #IF( #TEXT(Input_clean_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lname = (TYPEOF(le.Input_clean_lname))'','',':clean_lname')
    #END
+    #IF( #TEXT(Input_clean_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_suffix = (TYPEOF(le.Input_clean_name_suffix))'','',':clean_name_suffix')
    #END
+    #IF( #TEXT(Input_clean_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_score = (TYPEOF(le.Input_clean_name_score))'','',':clean_name_score')
    #END
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
+    #IF( #TEXT(Input_append_prep_address_situs)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_address_situs = (TYPEOF(le.Input_append_prep_address_situs))'','',':append_prep_address_situs')
    #END
+    #IF( #TEXT(Input_append_prep_address_last_situs)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_address_last_situs = (TYPEOF(le.Input_append_prep_address_last_situs))'','',':append_prep_address_last_situs')
    #END
+    #IF( #TEXT(Input_clean_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_prim_range = (TYPEOF(le.Input_clean_prim_range))'','',':clean_prim_range')
    #END
+    #IF( #TEXT(Input_clean_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_predir = (TYPEOF(le.Input_clean_predir))'','',':clean_predir')
    #END
+    #IF( #TEXT(Input_clean_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_prim_name = (TYPEOF(le.Input_clean_prim_name))'','',':clean_prim_name')
    #END
+    #IF( #TEXT(Input_clean_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_addr_suffix = (TYPEOF(le.Input_clean_addr_suffix))'','',':clean_addr_suffix')
    #END
+    #IF( #TEXT(Input_clean_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_postdir = (TYPEOF(le.Input_clean_postdir))'','',':clean_postdir')
    #END
+    #IF( #TEXT(Input_clean_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_unit_desig = (TYPEOF(le.Input_clean_unit_desig))'','',':clean_unit_desig')
    #END
+    #IF( #TEXT(Input_clean_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_sec_range = (TYPEOF(le.Input_clean_sec_range))'','',':clean_sec_range')
    #END
+    #IF( #TEXT(Input_clean_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_p_city_name = (TYPEOF(le.Input_clean_p_city_name))'','',':clean_p_city_name')
    #END
+    #IF( #TEXT(Input_clean_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_v_city_name = (TYPEOF(le.Input_clean_v_city_name))'','',':clean_v_city_name')
    #END
+    #IF( #TEXT(Input_clean_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_st = (TYPEOF(le.Input_clean_st))'','',':clean_st')
    #END
+    #IF( #TEXT(Input_clean_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_zip = (TYPEOF(le.Input_clean_zip))'','',':clean_zip')
    #END
+    #IF( #TEXT(Input_clean_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_zip4 = (TYPEOF(le.Input_clean_zip4))'','',':clean_zip4')
    #END
+    #IF( #TEXT(Input_clean_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_cart = (TYPEOF(le.Input_clean_cart))'','',':clean_cart')
    #END
+    #IF( #TEXT(Input_clean_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_cr_sort_sz = (TYPEOF(le.Input_clean_cr_sort_sz))'','',':clean_cr_sort_sz')
    #END
+    #IF( #TEXT(Input_clean_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lot = (TYPEOF(le.Input_clean_lot))'','',':clean_lot')
    #END
+    #IF( #TEXT(Input_clean_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lot_order = (TYPEOF(le.Input_clean_lot_order))'','',':clean_lot_order')
    #END
+    #IF( #TEXT(Input_clean_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dbpc = (TYPEOF(le.Input_clean_dbpc))'','',':clean_dbpc')
    #END
+    #IF( #TEXT(Input_clean_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_chk_digit = (TYPEOF(le.Input_clean_chk_digit))'','',':clean_chk_digit')
    #END
+    #IF( #TEXT(Input_clean_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_rec_type = (TYPEOF(le.Input_clean_rec_type))'','',':clean_rec_type')
    #END
+    #IF( #TEXT(Input_clean_county)='' )
      '' 
    #ELSE
        IF( le.Input_clean_county = (TYPEOF(le.Input_clean_county))'','',':clean_county')
    #END
+    #IF( #TEXT(Input_clean_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_lat = (TYPEOF(le.Input_clean_geo_lat))'','',':clean_geo_lat')
    #END
+    #IF( #TEXT(Input_clean_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_long = (TYPEOF(le.Input_clean_geo_long))'','',':clean_geo_long')
    #END
+    #IF( #TEXT(Input_clean_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_msa = (TYPEOF(le.Input_clean_msa))'','',':clean_msa')
    #END
+    #IF( #TEXT(Input_clean_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_blk = (TYPEOF(le.Input_clean_geo_blk))'','',':clean_geo_blk')
    #END
+    #IF( #TEXT(Input_clean_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_geo_match = (TYPEOF(le.Input_clean_geo_match))'','',':clean_geo_match')
    #END
+    #IF( #TEXT(Input_clean_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_err_stat = (TYPEOF(le.Input_clean_err_stat))'','',':clean_err_stat')
    #END
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
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
+    #IF( #TEXT(Input_current_rec_flag)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec_flag = (TYPEOF(le.Input_current_rec_flag))'','',':current_rec_flag')
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
