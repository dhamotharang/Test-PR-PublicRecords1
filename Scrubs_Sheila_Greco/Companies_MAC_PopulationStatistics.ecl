 
EXPORT Companies_MAC_PopulationStatistics(infile,Ref='',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_source_rec_id = '',Input_bdid = '',Input_bdid_score = '',Input_raw_aid = '',Input_ace_aid = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_type = '',Input_rawfields_maincompanyid = '',Input_rawfields_companyname = '',Input_rawfields_ticker = '',Input_rawfields_fortunerank = '',Input_rawfields_primaryindustry = '',Input_rawfields_address1 = '',Input_rawfields_address2 = '',Input_rawfields_city = '',Input_rawfields_state = '',Input_rawfields_zip = '',Input_rawfields_country = '',Input_rawfields_region = '',Input_rawfields_phone = '',Input_rawfields_extension = '',Input_rawfields_weburl = '',Input_rawfields_sales = '',Input_rawfields_employees = '',Input_rawfields_competitors = '',Input_rawfields_divisionname = '',Input_rawfields_siccode = '',Input_rawfields_auditor = '',Input_rawfields_entrydate = '',Input_rawfields_lastupdate = '',Input_rawfields_entrystaffid = '',Input_clean_address_prim_range = '',Input_clean_address_predir = '',Input_clean_address_prim_name = '',Input_clean_address_addr_suffix = '',Input_clean_address_postdir = '',Input_clean_address_unit_desig = '',Input_clean_address_sec_range = '',Input_clean_address_p_city_name = '',Input_clean_address_v_city_name = '',Input_clean_address_st = '',Input_clean_address_zip = '',Input_clean_address_zip4 = '',Input_clean_address_cart = '',Input_clean_address_cr_sort_sz = '',Input_clean_address_lot = '',Input_clean_address_lot_order = '',Input_clean_address_dbpc = '',Input_clean_address_chk_digit = '',Input_clean_address_rec_type = '',Input_clean_address_fips_state = '',Input_clean_address_fips_county = '',Input_clean_address_geo_lat = '',Input_clean_address_geo_long = '',Input_clean_address_msa = '',Input_clean_address_geo_blk = '',Input_clean_address_geo_match = '',Input_clean_address_err_stat = '',Input_clean_dates_entrydate = '',Input_clean_dates_lastupdate = '',Input_clean_phones_phone = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Sheila_Greco;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dotid)='' )
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
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
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
 
+    #IF( #TEXT(Input_rawfields_maincompanyid)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_maincompanyid = (TYPEOF(le.Input_rawfields_maincompanyid))'','',':rawfields_maincompanyid')
    #END
 
+    #IF( #TEXT(Input_rawfields_companyname)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_companyname = (TYPEOF(le.Input_rawfields_companyname))'','',':rawfields_companyname')
    #END
 
+    #IF( #TEXT(Input_rawfields_ticker)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_ticker = (TYPEOF(le.Input_rawfields_ticker))'','',':rawfields_ticker')
    #END
 
+    #IF( #TEXT(Input_rawfields_fortunerank)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_fortunerank = (TYPEOF(le.Input_rawfields_fortunerank))'','',':rawfields_fortunerank')
    #END
 
+    #IF( #TEXT(Input_rawfields_primaryindustry)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_primaryindustry = (TYPEOF(le.Input_rawfields_primaryindustry))'','',':rawfields_primaryindustry')
    #END
 
+    #IF( #TEXT(Input_rawfields_address1)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_address1 = (TYPEOF(le.Input_rawfields_address1))'','',':rawfields_address1')
    #END
 
+    #IF( #TEXT(Input_rawfields_address2)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_address2 = (TYPEOF(le.Input_rawfields_address2))'','',':rawfields_address2')
    #END
 
+    #IF( #TEXT(Input_rawfields_city)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_city = (TYPEOF(le.Input_rawfields_city))'','',':rawfields_city')
    #END
 
+    #IF( #TEXT(Input_rawfields_state)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_state = (TYPEOF(le.Input_rawfields_state))'','',':rawfields_state')
    #END
 
+    #IF( #TEXT(Input_rawfields_zip)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_zip = (TYPEOF(le.Input_rawfields_zip))'','',':rawfields_zip')
    #END
 
+    #IF( #TEXT(Input_rawfields_country)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_country = (TYPEOF(le.Input_rawfields_country))'','',':rawfields_country')
    #END
 
+    #IF( #TEXT(Input_rawfields_region)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_region = (TYPEOF(le.Input_rawfields_region))'','',':rawfields_region')
    #END
 
+    #IF( #TEXT(Input_rawfields_phone)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_phone = (TYPEOF(le.Input_rawfields_phone))'','',':rawfields_phone')
    #END
 
+    #IF( #TEXT(Input_rawfields_extension)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_extension = (TYPEOF(le.Input_rawfields_extension))'','',':rawfields_extension')
    #END
 
+    #IF( #TEXT(Input_rawfields_weburl)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_weburl = (TYPEOF(le.Input_rawfields_weburl))'','',':rawfields_weburl')
    #END
 
+    #IF( #TEXT(Input_rawfields_sales)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sales = (TYPEOF(le.Input_rawfields_sales))'','',':rawfields_sales')
    #END
 
+    #IF( #TEXT(Input_rawfields_employees)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_employees = (TYPEOF(le.Input_rawfields_employees))'','',':rawfields_employees')
    #END
 
+    #IF( #TEXT(Input_rawfields_competitors)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_competitors = (TYPEOF(le.Input_rawfields_competitors))'','',':rawfields_competitors')
    #END
 
+    #IF( #TEXT(Input_rawfields_divisionname)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_divisionname = (TYPEOF(le.Input_rawfields_divisionname))'','',':rawfields_divisionname')
    #END
 
+    #IF( #TEXT(Input_rawfields_siccode)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_siccode = (TYPEOF(le.Input_rawfields_siccode))'','',':rawfields_siccode')
    #END
 
+    #IF( #TEXT(Input_rawfields_auditor)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_auditor = (TYPEOF(le.Input_rawfields_auditor))'','',':rawfields_auditor')
    #END
 
+    #IF( #TEXT(Input_rawfields_entrydate)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_entrydate = (TYPEOF(le.Input_rawfields_entrydate))'','',':rawfields_entrydate')
    #END
 
+    #IF( #TEXT(Input_rawfields_lastupdate)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_lastupdate = (TYPEOF(le.Input_rawfields_lastupdate))'','',':rawfields_lastupdate')
    #END
 
+    #IF( #TEXT(Input_rawfields_entrystaffid)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_entrystaffid = (TYPEOF(le.Input_rawfields_entrystaffid))'','',':rawfields_entrystaffid')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_range = (TYPEOF(le.Input_clean_address_prim_range))'','',':clean_address_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_address_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_predir = (TYPEOF(le.Input_clean_address_predir))'','',':clean_address_predir')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_name = (TYPEOF(le.Input_clean_address_prim_name))'','',':clean_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_addr_suffix = (TYPEOF(le.Input_clean_address_addr_suffix))'','',':clean_address_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_address_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_postdir = (TYPEOF(le.Input_clean_address_postdir))'','',':clean_address_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_address_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_unit_desig = (TYPEOF(le.Input_clean_address_unit_desig))'','',':clean_address_unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_address_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_sec_range = (TYPEOF(le.Input_clean_address_sec_range))'','',':clean_address_sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_p_city_name = (TYPEOF(le.Input_clean_address_p_city_name))'','',':clean_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_v_city_name = (TYPEOF(le.Input_clean_address_v_city_name))'','',':clean_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_st = (TYPEOF(le.Input_clean_address_st))'','',':clean_address_st')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip = (TYPEOF(le.Input_clean_address_zip))'','',':clean_address_zip')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip4 = (TYPEOF(le.Input_clean_address_zip4))'','',':clean_address_zip4')
    #END
 
+    #IF( #TEXT(Input_clean_address_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_cart = (TYPEOF(le.Input_clean_address_cart))'','',':clean_address_cart')
    #END
 
+    #IF( #TEXT(Input_clean_address_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_cr_sort_sz = (TYPEOF(le.Input_clean_address_cr_sort_sz))'','',':clean_address_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_address_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_lot = (TYPEOF(le.Input_clean_address_lot))'','',':clean_address_lot')
    #END
 
+    #IF( #TEXT(Input_clean_address_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_lot_order = (TYPEOF(le.Input_clean_address_lot_order))'','',':clean_address_lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_address_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_dbpc = (TYPEOF(le.Input_clean_address_dbpc))'','',':clean_address_dbpc')
    #END
 
+    #IF( #TEXT(Input_clean_address_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_chk_digit = (TYPEOF(le.Input_clean_address_chk_digit))'','',':clean_address_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_address_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_rec_type = (TYPEOF(le.Input_clean_address_rec_type))'','',':clean_address_rec_type')
    #END
 
+    #IF( #TEXT(Input_clean_address_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_fips_state = (TYPEOF(le.Input_clean_address_fips_state))'','',':clean_address_fips_state')
    #END
 
+    #IF( #TEXT(Input_clean_address_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_fips_county = (TYPEOF(le.Input_clean_address_fips_county))'','',':clean_address_fips_county')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_lat = (TYPEOF(le.Input_clean_address_geo_lat))'','',':clean_address_geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_long = (TYPEOF(le.Input_clean_address_geo_long))'','',':clean_address_geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_address_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_msa = (TYPEOF(le.Input_clean_address_msa))'','',':clean_address_msa')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_blk = (TYPEOF(le.Input_clean_address_geo_blk))'','',':clean_address_geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_match = (TYPEOF(le.Input_clean_address_geo_match))'','',':clean_address_geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_address_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_err_stat = (TYPEOF(le.Input_clean_address_err_stat))'','',':clean_address_err_stat')
    #END
 
+    #IF( #TEXT(Input_clean_dates_entrydate)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dates_entrydate = (TYPEOF(le.Input_clean_dates_entrydate))'','',':clean_dates_entrydate')
    #END
 
+    #IF( #TEXT(Input_clean_dates_lastupdate)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dates_lastupdate = (TYPEOF(le.Input_clean_dates_lastupdate))'','',':clean_dates_lastupdate')
    #END
 
+    #IF( #TEXT(Input_clean_phones_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_phone = (TYPEOF(le.Input_clean_phones_phone))'','',':clean_phones_phone')
    #END
 
+    #IF( #TEXT(Input_global_sid)='' )
      '' 
    #ELSE
        IF( le.Input_global_sid = (TYPEOF(le.Input_global_sid))'','',':global_sid')
    #END
 
+    #IF( #TEXT(Input_record_sid)='' )
      '' 
    #ELSE
        IF( le.Input_record_sid = (TYPEOF(le.Input_record_sid))'','',':record_sid')
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
