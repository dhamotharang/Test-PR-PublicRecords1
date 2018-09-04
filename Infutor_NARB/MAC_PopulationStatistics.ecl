 
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_process_date = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_did = '',Input_did_score = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_type = '',Input_pid = '',Input_record_id = '',Input_ein = '',Input_busname = '',Input_tradename = '',Input_house = '',Input_predirection = '',Input_street = '',Input_strtype = '',Input_postdirection = '',Input_apttype = '',Input_aptnbr = '',Input_city = '',Input_state = '',Input_zip5 = '',Input_ziplast4 = '',Input_dpc = '',Input_carrier_route = '',Input_address_type_code = '',Input_dpv_code = '',Input_mailable = '',Input_county_code = '',Input_censustract = '',Input_censusblockgroup = '',Input_censusblock = '',Input_congress_code = '',Input_msacode = '',Input_timezonecode = '',Input_latitude = '',Input_longitude = '',Input_url = '',Input_telephone = '',Input_toll_free_number = '',Input_fax = '',Input_sic1 = '',Input_sic2 = '',Input_sic3 = '',Input_sic4 = '',Input_sic5 = '',Input_stdclass = '',Input_heading1 = '',Input_heading2 = '',Input_heading3 = '',Input_heading4 = '',Input_heading5 = '',Input_business_specialty = '',Input_sales_code = '',Input_employee_code = '',Input_location_type = '',Input_parent_company = '',Input_parent_address = '',Input_parent_city = '',Input_parent_state = '',Input_parent_zip = '',Input_parent_phone = '',Input_stock_symbol = '',Input_stock_exchange = '',Input_public = '',Input_number_of_pcs = '',Input_square_footage = '',Input_business_type = '',Input_incorporation_state = '',Input_minority = '',Input_woman = '',Input_government = '',Input_small = '',Input_home_office = '',Input_soho = '',Input_franchise = '',Input_phoneable = '',Input_prefix = '',Input_first_name = '',Input_middle_name = '',Input_surname = '',Input_suffix = '',Input_birth_year = '',Input_ethnicity = '',Input_gender = '',Input_email = '',Input_contact_title = '',Input_year_started = '',Input_date_added = '',Input_validationdate = '',Input_internal1 = '',Input_dacd = '',Input_normcompany_type = '',Input_normcompany_name = '',Input_normcompany_street = '',Input_normcompany_city = '',Input_normcompany_state = '',Input_normcompany_zip = '',Input_normcompany_phone = '',Input_clean_company_name = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_clean_phone = '',Input_raw_aid = '',Input_ace_aid = '',Input_prep_address_line1 = '',Input_prep_address_line_last = '',OutFile) := MACRO
  IMPORT SALT34,infutor_narb;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT34.StrType source;
    #END
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
 
+    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END
 
+    #IF( #TEXT(Input_ein)='' )
      '' 
    #ELSE
        IF( le.Input_ein = (TYPEOF(le.Input_ein))'','',':ein')
    #END
 
+    #IF( #TEXT(Input_busname)='' )
      '' 
    #ELSE
        IF( le.Input_busname = (TYPEOF(le.Input_busname))'','',':busname')
    #END
 
+    #IF( #TEXT(Input_tradename)='' )
      '' 
    #ELSE
        IF( le.Input_tradename = (TYPEOF(le.Input_tradename))'','',':tradename')
    #END
 
+    #IF( #TEXT(Input_house)='' )
      '' 
    #ELSE
        IF( le.Input_house = (TYPEOF(le.Input_house))'','',':house')
    #END
 
+    #IF( #TEXT(Input_predirection)='' )
      '' 
    #ELSE
        IF( le.Input_predirection = (TYPEOF(le.Input_predirection))'','',':predirection')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_strtype)='' )
      '' 
    #ELSE
        IF( le.Input_strtype = (TYPEOF(le.Input_strtype))'','',':strtype')
    #END
 
+    #IF( #TEXT(Input_postdirection)='' )
      '' 
    #ELSE
        IF( le.Input_postdirection = (TYPEOF(le.Input_postdirection))'','',':postdirection')
    #END
 
+    #IF( #TEXT(Input_apttype)='' )
      '' 
    #ELSE
        IF( le.Input_apttype = (TYPEOF(le.Input_apttype))'','',':apttype')
    #END
 
+    #IF( #TEXT(Input_aptnbr)='' )
      '' 
    #ELSE
        IF( le.Input_aptnbr = (TYPEOF(le.Input_aptnbr))'','',':aptnbr')
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
 
+    #IF( #TEXT(Input_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_zip5 = (TYPEOF(le.Input_zip5))'','',':zip5')
    #END
 
+    #IF( #TEXT(Input_ziplast4)='' )
      '' 
    #ELSE
        IF( le.Input_ziplast4 = (TYPEOF(le.Input_ziplast4))'','',':ziplast4')
    #END
 
+    #IF( #TEXT(Input_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_dpc = (TYPEOF(le.Input_dpc))'','',':dpc')
    #END
 
+    #IF( #TEXT(Input_carrier_route)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_route = (TYPEOF(le.Input_carrier_route))'','',':carrier_route')
    #END
 
+    #IF( #TEXT(Input_address_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_type_code = (TYPEOF(le.Input_address_type_code))'','',':address_type_code')
    #END
 
+    #IF( #TEXT(Input_dpv_code)='' )
      '' 
    #ELSE
        IF( le.Input_dpv_code = (TYPEOF(le.Input_dpv_code))'','',':dpv_code')
    #END
 
+    #IF( #TEXT(Input_mailable)='' )
      '' 
    #ELSE
        IF( le.Input_mailable = (TYPEOF(le.Input_mailable))'','',':mailable')
    #END
 
+    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
    #END
 
+    #IF( #TEXT(Input_censustract)='' )
      '' 
    #ELSE
        IF( le.Input_censustract = (TYPEOF(le.Input_censustract))'','',':censustract')
    #END
 
+    #IF( #TEXT(Input_censusblockgroup)='' )
      '' 
    #ELSE
        IF( le.Input_censusblockgroup = (TYPEOF(le.Input_censusblockgroup))'','',':censusblockgroup')
    #END
 
+    #IF( #TEXT(Input_censusblock)='' )
      '' 
    #ELSE
        IF( le.Input_censusblock = (TYPEOF(le.Input_censusblock))'','',':censusblock')
    #END
 
+    #IF( #TEXT(Input_congress_code)='' )
      '' 
    #ELSE
        IF( le.Input_congress_code = (TYPEOF(le.Input_congress_code))'','',':congress_code')
    #END
 
+    #IF( #TEXT(Input_msacode)='' )
      '' 
    #ELSE
        IF( le.Input_msacode = (TYPEOF(le.Input_msacode))'','',':msacode')
    #END
 
+    #IF( #TEXT(Input_timezonecode)='' )
      '' 
    #ELSE
        IF( le.Input_timezonecode = (TYPEOF(le.Input_timezonecode))'','',':timezonecode')
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
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END
 
+    #IF( #TEXT(Input_toll_free_number)='' )
      '' 
    #ELSE
        IF( le.Input_toll_free_number = (TYPEOF(le.Input_toll_free_number))'','',':toll_free_number')
    #END
 
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
 
+    #IF( #TEXT(Input_sic1)='' )
      '' 
    #ELSE
        IF( le.Input_sic1 = (TYPEOF(le.Input_sic1))'','',':sic1')
    #END
 
+    #IF( #TEXT(Input_sic2)='' )
      '' 
    #ELSE
        IF( le.Input_sic2 = (TYPEOF(le.Input_sic2))'','',':sic2')
    #END
 
+    #IF( #TEXT(Input_sic3)='' )
      '' 
    #ELSE
        IF( le.Input_sic3 = (TYPEOF(le.Input_sic3))'','',':sic3')
    #END
 
+    #IF( #TEXT(Input_sic4)='' )
      '' 
    #ELSE
        IF( le.Input_sic4 = (TYPEOF(le.Input_sic4))'','',':sic4')
    #END
 
+    #IF( #TEXT(Input_sic5)='' )
      '' 
    #ELSE
        IF( le.Input_sic5 = (TYPEOF(le.Input_sic5))'','',':sic5')
    #END
 
+    #IF( #TEXT(Input_stdclass)='' )
      '' 
    #ELSE
        IF( le.Input_stdclass = (TYPEOF(le.Input_stdclass))'','',':stdclass')
    #END
 
+    #IF( #TEXT(Input_heading1)='' )
      '' 
    #ELSE
        IF( le.Input_heading1 = (TYPEOF(le.Input_heading1))'','',':heading1')
    #END
 
+    #IF( #TEXT(Input_heading2)='' )
      '' 
    #ELSE
        IF( le.Input_heading2 = (TYPEOF(le.Input_heading2))'','',':heading2')
    #END
 
+    #IF( #TEXT(Input_heading3)='' )
      '' 
    #ELSE
        IF( le.Input_heading3 = (TYPEOF(le.Input_heading3))'','',':heading3')
    #END
 
+    #IF( #TEXT(Input_heading4)='' )
      '' 
    #ELSE
        IF( le.Input_heading4 = (TYPEOF(le.Input_heading4))'','',':heading4')
    #END
 
+    #IF( #TEXT(Input_heading5)='' )
      '' 
    #ELSE
        IF( le.Input_heading5 = (TYPEOF(le.Input_heading5))'','',':heading5')
    #END
 
+    #IF( #TEXT(Input_business_specialty)='' )
      '' 
    #ELSE
        IF( le.Input_business_specialty = (TYPEOF(le.Input_business_specialty))'','',':business_specialty')
    #END
 
+    #IF( #TEXT(Input_sales_code)='' )
      '' 
    #ELSE
        IF( le.Input_sales_code = (TYPEOF(le.Input_sales_code))'','',':sales_code')
    #END
 
+    #IF( #TEXT(Input_employee_code)='' )
      '' 
    #ELSE
        IF( le.Input_employee_code = (TYPEOF(le.Input_employee_code))'','',':employee_code')
    #END
 
+    #IF( #TEXT(Input_location_type)='' )
      '' 
    #ELSE
        IF( le.Input_location_type = (TYPEOF(le.Input_location_type))'','',':location_type')
    #END
 
+    #IF( #TEXT(Input_parent_company)='' )
      '' 
    #ELSE
        IF( le.Input_parent_company = (TYPEOF(le.Input_parent_company))'','',':parent_company')
    #END
 
+    #IF( #TEXT(Input_parent_address)='' )
      '' 
    #ELSE
        IF( le.Input_parent_address = (TYPEOF(le.Input_parent_address))'','',':parent_address')
    #END
 
+    #IF( #TEXT(Input_parent_city)='' )
      '' 
    #ELSE
        IF( le.Input_parent_city = (TYPEOF(le.Input_parent_city))'','',':parent_city')
    #END
 
+    #IF( #TEXT(Input_parent_state)='' )
      '' 
    #ELSE
        IF( le.Input_parent_state = (TYPEOF(le.Input_parent_state))'','',':parent_state')
    #END
 
+    #IF( #TEXT(Input_parent_zip)='' )
      '' 
    #ELSE
        IF( le.Input_parent_zip = (TYPEOF(le.Input_parent_zip))'','',':parent_zip')
    #END
 
+    #IF( #TEXT(Input_parent_phone)='' )
      '' 
    #ELSE
        IF( le.Input_parent_phone = (TYPEOF(le.Input_parent_phone))'','',':parent_phone')
    #END
 
+    #IF( #TEXT(Input_stock_symbol)='' )
      '' 
    #ELSE
        IF( le.Input_stock_symbol = (TYPEOF(le.Input_stock_symbol))'','',':stock_symbol')
    #END
 
+    #IF( #TEXT(Input_stock_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_stock_exchange = (TYPEOF(le.Input_stock_exchange))'','',':stock_exchange')
    #END
 
+    #IF( #TEXT(Input_public)='' )
      '' 
    #ELSE
        IF( le.Input_public = (TYPEOF(le.Input_public))'','',':public')
    #END
 
+    #IF( #TEXT(Input_number_of_pcs)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_pcs = (TYPEOF(le.Input_number_of_pcs))'','',':number_of_pcs')
    #END
 
+    #IF( #TEXT(Input_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_square_footage = (TYPEOF(le.Input_square_footage))'','',':square_footage')
    #END
 
+    #IF( #TEXT(Input_business_type)='' )
      '' 
    #ELSE
        IF( le.Input_business_type = (TYPEOF(le.Input_business_type))'','',':business_type')
    #END
 
+    #IF( #TEXT(Input_incorporation_state)='' )
      '' 
    #ELSE
        IF( le.Input_incorporation_state = (TYPEOF(le.Input_incorporation_state))'','',':incorporation_state')
    #END
 
+    #IF( #TEXT(Input_minority)='' )
      '' 
    #ELSE
        IF( le.Input_minority = (TYPEOF(le.Input_minority))'','',':minority')
    #END
 
+    #IF( #TEXT(Input_woman)='' )
      '' 
    #ELSE
        IF( le.Input_woman = (TYPEOF(le.Input_woman))'','',':woman')
    #END
 
+    #IF( #TEXT(Input_government)='' )
      '' 
    #ELSE
        IF( le.Input_government = (TYPEOF(le.Input_government))'','',':government')
    #END
 
+    #IF( #TEXT(Input_small)='' )
      '' 
    #ELSE
        IF( le.Input_small = (TYPEOF(le.Input_small))'','',':small')
    #END
 
+    #IF( #TEXT(Input_home_office)='' )
      '' 
    #ELSE
        IF( le.Input_home_office = (TYPEOF(le.Input_home_office))'','',':home_office')
    #END
 
+    #IF( #TEXT(Input_soho)='' )
      '' 
    #ELSE
        IF( le.Input_soho = (TYPEOF(le.Input_soho))'','',':soho')
    #END
 
+    #IF( #TEXT(Input_franchise)='' )
      '' 
    #ELSE
        IF( le.Input_franchise = (TYPEOF(le.Input_franchise))'','',':franchise')
    #END
 
+    #IF( #TEXT(Input_phoneable)='' )
      '' 
    #ELSE
        IF( le.Input_phoneable = (TYPEOF(le.Input_phoneable))'','',':phoneable')
    #END
 
+    #IF( #TEXT(Input_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_prefix = (TYPEOF(le.Input_prefix))'','',':prefix')
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
 
+    #IF( #TEXT(Input_surname)='' )
      '' 
    #ELSE
        IF( le.Input_surname = (TYPEOF(le.Input_surname))'','',':surname')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_birth_year)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year = (TYPEOF(le.Input_birth_year))'','',':birth_year')
    #END
 
+    #IF( #TEXT(Input_ethnicity)='' )
      '' 
    #ELSE
        IF( le.Input_ethnicity = (TYPEOF(le.Input_ethnicity))'','',':ethnicity')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_contact_title)='' )
      '' 
    #ELSE
        IF( le.Input_contact_title = (TYPEOF(le.Input_contact_title))'','',':contact_title')
    #END
 
+    #IF( #TEXT(Input_year_started)='' )
      '' 
    #ELSE
        IF( le.Input_year_started = (TYPEOF(le.Input_year_started))'','',':year_started')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_validationdate)='' )
      '' 
    #ELSE
        IF( le.Input_validationdate = (TYPEOF(le.Input_validationdate))'','',':validationdate')
    #END
 
+    #IF( #TEXT(Input_internal1)='' )
      '' 
    #ELSE
        IF( le.Input_internal1 = (TYPEOF(le.Input_internal1))'','',':internal1')
    #END
 
+    #IF( #TEXT(Input_dacd)='' )
      '' 
    #ELSE
        IF( le.Input_dacd = (TYPEOF(le.Input_dacd))'','',':dacd')
    #END
 
+    #IF( #TEXT(Input_normcompany_type)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_type = (TYPEOF(le.Input_normcompany_type))'','',':normcompany_type')
    #END
 
+    #IF( #TEXT(Input_normcompany_name)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_name = (TYPEOF(le.Input_normcompany_name))'','',':normcompany_name')
    #END
 
+    #IF( #TEXT(Input_normcompany_street)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_street = (TYPEOF(le.Input_normcompany_street))'','',':normcompany_street')
    #END
 
+    #IF( #TEXT(Input_normcompany_city)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_city = (TYPEOF(le.Input_normcompany_city))'','',':normcompany_city')
    #END
 
+    #IF( #TEXT(Input_normcompany_state)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_state = (TYPEOF(le.Input_normcompany_state))'','',':normcompany_state')
    #END
 
+    #IF( #TEXT(Input_normcompany_zip)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_zip = (TYPEOF(le.Input_normcompany_zip))'','',':normcompany_zip')
    #END
 
+    #IF( #TEXT(Input_normcompany_phone)='' )
      '' 
    #ELSE
        IF( le.Input_normcompany_phone = (TYPEOF(le.Input_normcompany_phone))'','',':normcompany_phone')
    #END
 
+    #IF( #TEXT(Input_clean_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company_name = (TYPEOF(le.Input_clean_company_name))'','',':clean_company_name')
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
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_raw_aid)='' )
      '' 
    #ELSE
        IF( le.Input_raw_aid = (TYPEOF(le.Input_raw_aid))'','',':raw_aid')
    #END
 
+    #IF( #TEXT(Input_ace_aid)='' )
      '' 
    #ELSE
        IF( le.Input_ace_aid = (TYPEOF(le.Input_ace_aid))'','',':ace_aid')
    #END
 
+    #IF( #TEXT(Input_prep_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_address_line1 = (TYPEOF(le.Input_prep_address_line1))'','',':prep_address_line1')
    #END
 
+    #IF( #TEXT(Input_prep_address_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_address_line_last = (TYPEOF(le.Input_prep_address_line_last))'','',':prep_address_line_last')
    #END
;
    #IF (#TEXT(source)<>'')
    SELF.source := le.source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source)<>'' ) source, #END -cnt );
ENDMACRO;
