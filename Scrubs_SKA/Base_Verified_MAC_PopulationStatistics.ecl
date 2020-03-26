 
EXPORT Base_Verified_MAC_PopulationStatistics(infile,Ref='',Input_id_ska = '',Input_bdid = '',Input_ttl = '',Input_first_name = '',Input_middle = '',Input_last_name = '',Input_t1 = '',Input_do = '',Input_deptcode = '',Input_dept_expl = '',Input_key_file = '',Input_company1 = '',Input_address1 = '',Input_city = '',Input_state = '',Input_zip = '',Input_address2 = '',Input_city2 = '',Input_state2 = '',Input_zip2 = '',Input_fips = '',Input_phone = '',Input_spec = '',Input_spec_expl = '',Input_spec2 = '',Input_spec2_expl = '',Input_spec3 = '',Input_spec3_expl = '',Input_persid = '',Input_owner = '',Input_emailavail = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_mail_prim_range = '',Input_mail_predir = '',Input_mail_prim_name = '',Input_mail_addr_suffix = '',Input_mail_postdir = '',Input_mail_unit_desig = '',Input_mail_sec_range = '',Input_mail_p_city_name = '',Input_mail_v_city_name = '',Input_mail_st = '',Input_mail_zip = '',Input_mail_zip4 = '',Input_mail_cart = '',Input_mail_cr_sort_sz = '',Input_mail_lot = '',Input_mail_lot_order = '',Input_mail_dbpc = '',Input_mail_chk_digit = '',Input_mail_rec_type = '',Input_mail_ace_fips_state = '',Input_mail_county = '',Input_mail_geo_lat = '',Input_mail_geo_long = '',Input_mail_msa = '',Input_mail_geo_blk = '',Input_mail_geo_match = '',Input_mail_err_stat = '',Input_alt_prim_range = '',Input_alt_predir = '',Input_alt_prim_name = '',Input_alt_addr_suffix = '',Input_alt_postdir = '',Input_alt_unit_desig = '',Input_alt_sec_range = '',Input_alt_p_city_name = '',Input_alt_v_city_name = '',Input_alt_st = '',Input_alt_zip = '',Input_alt_zip4 = '',Input_alt_cart = '',Input_alt_cr_sort_sz = '',Input_alt_lot = '',Input_alt_lot_order = '',Input_alt_dbpc = '',Input_alt_chk_digit = '',Input_alt_rec_type = '',Input_alt_ace_fips_state = '',Input_alt_county = '',Input_alt_geo_lat = '',Input_alt_geo_long = '',Input_alt_msa = '',Input_alt_geo_blk = '',Input_alt_geo_match = '',Input_alt_err_stat = '',Input_lf = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_source_rec_id = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_SKA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_id_ska)='' )
      '' 
    #ELSE
        IF( le.Input_id_ska = (TYPEOF(le.Input_id_ska))'','',':id_ska')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_ttl)='' )
      '' 
    #ELSE
        IF( le.Input_ttl = (TYPEOF(le.Input_ttl))'','',':ttl')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle)='' )
      '' 
    #ELSE
        IF( le.Input_middle = (TYPEOF(le.Input_middle))'','',':middle')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_t1)='' )
      '' 
    #ELSE
        IF( le.Input_t1 = (TYPEOF(le.Input_t1))'','',':t1')
    #END
 
+    #IF( #TEXT(Input_do)='' )
      '' 
    #ELSE
        IF( le.Input_do = (TYPEOF(le.Input_do))'','',':do')
    #END
 
+    #IF( #TEXT(Input_deptcode)='' )
      '' 
    #ELSE
        IF( le.Input_deptcode = (TYPEOF(le.Input_deptcode))'','',':deptcode')
    #END
 
+    #IF( #TEXT(Input_dept_expl)='' )
      '' 
    #ELSE
        IF( le.Input_dept_expl = (TYPEOF(le.Input_dept_expl))'','',':dept_expl')
    #END
 
+    #IF( #TEXT(Input_key_file)='' )
      '' 
    #ELSE
        IF( le.Input_key_file = (TYPEOF(le.Input_key_file))'','',':key_file')
    #END
 
+    #IF( #TEXT(Input_company1)='' )
      '' 
    #ELSE
        IF( le.Input_company1 = (TYPEOF(le.Input_company1))'','',':company1')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_city2)='' )
      '' 
    #ELSE
        IF( le.Input_city2 = (TYPEOF(le.Input_city2))'','',':city2')
    #END
 
+    #IF( #TEXT(Input_state2)='' )
      '' 
    #ELSE
        IF( le.Input_state2 = (TYPEOF(le.Input_state2))'','',':state2')
    #END
 
+    #IF( #TEXT(Input_zip2)='' )
      '' 
    #ELSE
        IF( le.Input_zip2 = (TYPEOF(le.Input_zip2))'','',':zip2')
    #END
 
+    #IF( #TEXT(Input_fips)='' )
      '' 
    #ELSE
        IF( le.Input_fips = (TYPEOF(le.Input_fips))'','',':fips')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_spec)='' )
      '' 
    #ELSE
        IF( le.Input_spec = (TYPEOF(le.Input_spec))'','',':spec')
    #END
 
+    #IF( #TEXT(Input_spec_expl)='' )
      '' 
    #ELSE
        IF( le.Input_spec_expl = (TYPEOF(le.Input_spec_expl))'','',':spec_expl')
    #END
 
+    #IF( #TEXT(Input_spec2)='' )
      '' 
    #ELSE
        IF( le.Input_spec2 = (TYPEOF(le.Input_spec2))'','',':spec2')
    #END
 
+    #IF( #TEXT(Input_spec2_expl)='' )
      '' 
    #ELSE
        IF( le.Input_spec2_expl = (TYPEOF(le.Input_spec2_expl))'','',':spec2_expl')
    #END
 
+    #IF( #TEXT(Input_spec3)='' )
      '' 
    #ELSE
        IF( le.Input_spec3 = (TYPEOF(le.Input_spec3))'','',':spec3')
    #END
 
+    #IF( #TEXT(Input_spec3_expl)='' )
      '' 
    #ELSE
        IF( le.Input_spec3_expl = (TYPEOF(le.Input_spec3_expl))'','',':spec3_expl')
    #END
 
+    #IF( #TEXT(Input_persid)='' )
      '' 
    #ELSE
        IF( le.Input_persid = (TYPEOF(le.Input_persid))'','',':persid')
    #END
 
+    #IF( #TEXT(Input_owner)='' )
      '' 
    #ELSE
        IF( le.Input_owner = (TYPEOF(le.Input_owner))'','',':owner')
    #END
 
+    #IF( #TEXT(Input_emailavail)='' )
      '' 
    #ELSE
        IF( le.Input_emailavail = (TYPEOF(le.Input_emailavail))'','',':emailavail')
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
 
+    #IF( #TEXT(Input_mail_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_mail_prim_range = (TYPEOF(le.Input_mail_prim_range))'','',':mail_prim_range')
    #END
 
+    #IF( #TEXT(Input_mail_predir)='' )
      '' 
    #ELSE
        IF( le.Input_mail_predir = (TYPEOF(le.Input_mail_predir))'','',':mail_predir')
    #END
 
+    #IF( #TEXT(Input_mail_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_mail_prim_name = (TYPEOF(le.Input_mail_prim_name))'','',':mail_prim_name')
    #END
 
+    #IF( #TEXT(Input_mail_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_suffix = (TYPEOF(le.Input_mail_addr_suffix))'','',':mail_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_mail_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_mail_postdir = (TYPEOF(le.Input_mail_postdir))'','',':mail_postdir')
    #END
 
+    #IF( #TEXT(Input_mail_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_mail_unit_desig = (TYPEOF(le.Input_mail_unit_desig))'','',':mail_unit_desig')
    #END
 
+    #IF( #TEXT(Input_mail_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_mail_sec_range = (TYPEOF(le.Input_mail_sec_range))'','',':mail_sec_range')
    #END
 
+    #IF( #TEXT(Input_mail_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_mail_p_city_name = (TYPEOF(le.Input_mail_p_city_name))'','',':mail_p_city_name')
    #END
 
+    #IF( #TEXT(Input_mail_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_mail_v_city_name = (TYPEOF(le.Input_mail_v_city_name))'','',':mail_v_city_name')
    #END
 
+    #IF( #TEXT(Input_mail_st)='' )
      '' 
    #ELSE
        IF( le.Input_mail_st = (TYPEOF(le.Input_mail_st))'','',':mail_st')
    #END
 
+    #IF( #TEXT(Input_mail_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip = (TYPEOF(le.Input_mail_zip))'','',':mail_zip')
    #END
 
+    #IF( #TEXT(Input_mail_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip4 = (TYPEOF(le.Input_mail_zip4))'','',':mail_zip4')
    #END
 
+    #IF( #TEXT(Input_mail_cart)='' )
      '' 
    #ELSE
        IF( le.Input_mail_cart = (TYPEOF(le.Input_mail_cart))'','',':mail_cart')
    #END
 
+    #IF( #TEXT(Input_mail_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_mail_cr_sort_sz = (TYPEOF(le.Input_mail_cr_sort_sz))'','',':mail_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_mail_lot)='' )
      '' 
    #ELSE
        IF( le.Input_mail_lot = (TYPEOF(le.Input_mail_lot))'','',':mail_lot')
    #END
 
+    #IF( #TEXT(Input_mail_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_mail_lot_order = (TYPEOF(le.Input_mail_lot_order))'','',':mail_lot_order')
    #END
 
+    #IF( #TEXT(Input_mail_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_mail_dbpc = (TYPEOF(le.Input_mail_dbpc))'','',':mail_dbpc')
    #END
 
+    #IF( #TEXT(Input_mail_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_mail_chk_digit = (TYPEOF(le.Input_mail_chk_digit))'','',':mail_chk_digit')
    #END
 
+    #IF( #TEXT(Input_mail_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_mail_rec_type = (TYPEOF(le.Input_mail_rec_type))'','',':mail_rec_type')
    #END
 
+    #IF( #TEXT(Input_mail_ace_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_ace_fips_state = (TYPEOF(le.Input_mail_ace_fips_state))'','',':mail_ace_fips_state')
    #END
 
+    #IF( #TEXT(Input_mail_county)='' )
      '' 
    #ELSE
        IF( le.Input_mail_county = (TYPEOF(le.Input_mail_county))'','',':mail_county')
    #END
 
+    #IF( #TEXT(Input_mail_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_lat = (TYPEOF(le.Input_mail_geo_lat))'','',':mail_geo_lat')
    #END
 
+    #IF( #TEXT(Input_mail_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_long = (TYPEOF(le.Input_mail_geo_long))'','',':mail_geo_long')
    #END
 
+    #IF( #TEXT(Input_mail_msa)='' )
      '' 
    #ELSE
        IF( le.Input_mail_msa = (TYPEOF(le.Input_mail_msa))'','',':mail_msa')
    #END
 
+    #IF( #TEXT(Input_mail_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_blk = (TYPEOF(le.Input_mail_geo_blk))'','',':mail_geo_blk')
    #END
 
+    #IF( #TEXT(Input_mail_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_mail_geo_match = (TYPEOF(le.Input_mail_geo_match))'','',':mail_geo_match')
    #END
 
+    #IF( #TEXT(Input_mail_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_mail_err_stat = (TYPEOF(le.Input_mail_err_stat))'','',':mail_err_stat')
    #END
 
+    #IF( #TEXT(Input_alt_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_alt_prim_range = (TYPEOF(le.Input_alt_prim_range))'','',':alt_prim_range')
    #END
 
+    #IF( #TEXT(Input_alt_predir)='' )
      '' 
    #ELSE
        IF( le.Input_alt_predir = (TYPEOF(le.Input_alt_predir))'','',':alt_predir')
    #END
 
+    #IF( #TEXT(Input_alt_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_alt_prim_name = (TYPEOF(le.Input_alt_prim_name))'','',':alt_prim_name')
    #END
 
+    #IF( #TEXT(Input_alt_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_alt_addr_suffix = (TYPEOF(le.Input_alt_addr_suffix))'','',':alt_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_alt_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_alt_postdir = (TYPEOF(le.Input_alt_postdir))'','',':alt_postdir')
    #END
 
+    #IF( #TEXT(Input_alt_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_alt_unit_desig = (TYPEOF(le.Input_alt_unit_desig))'','',':alt_unit_desig')
    #END
 
+    #IF( #TEXT(Input_alt_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_alt_sec_range = (TYPEOF(le.Input_alt_sec_range))'','',':alt_sec_range')
    #END
 
+    #IF( #TEXT(Input_alt_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_alt_p_city_name = (TYPEOF(le.Input_alt_p_city_name))'','',':alt_p_city_name')
    #END
 
+    #IF( #TEXT(Input_alt_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_alt_v_city_name = (TYPEOF(le.Input_alt_v_city_name))'','',':alt_v_city_name')
    #END
 
+    #IF( #TEXT(Input_alt_st)='' )
      '' 
    #ELSE
        IF( le.Input_alt_st = (TYPEOF(le.Input_alt_st))'','',':alt_st')
    #END
 
+    #IF( #TEXT(Input_alt_zip)='' )
      '' 
    #ELSE
        IF( le.Input_alt_zip = (TYPEOF(le.Input_alt_zip))'','',':alt_zip')
    #END
 
+    #IF( #TEXT(Input_alt_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_alt_zip4 = (TYPEOF(le.Input_alt_zip4))'','',':alt_zip4')
    #END
 
+    #IF( #TEXT(Input_alt_cart)='' )
      '' 
    #ELSE
        IF( le.Input_alt_cart = (TYPEOF(le.Input_alt_cart))'','',':alt_cart')
    #END
 
+    #IF( #TEXT(Input_alt_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_alt_cr_sort_sz = (TYPEOF(le.Input_alt_cr_sort_sz))'','',':alt_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_alt_lot)='' )
      '' 
    #ELSE
        IF( le.Input_alt_lot = (TYPEOF(le.Input_alt_lot))'','',':alt_lot')
    #END
 
+    #IF( #TEXT(Input_alt_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_alt_lot_order = (TYPEOF(le.Input_alt_lot_order))'','',':alt_lot_order')
    #END
 
+    #IF( #TEXT(Input_alt_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_alt_dbpc = (TYPEOF(le.Input_alt_dbpc))'','',':alt_dbpc')
    #END
 
+    #IF( #TEXT(Input_alt_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_alt_chk_digit = (TYPEOF(le.Input_alt_chk_digit))'','',':alt_chk_digit')
    #END
 
+    #IF( #TEXT(Input_alt_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_alt_rec_type = (TYPEOF(le.Input_alt_rec_type))'','',':alt_rec_type')
    #END
 
+    #IF( #TEXT(Input_alt_ace_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_alt_ace_fips_state = (TYPEOF(le.Input_alt_ace_fips_state))'','',':alt_ace_fips_state')
    #END
 
+    #IF( #TEXT(Input_alt_county)='' )
      '' 
    #ELSE
        IF( le.Input_alt_county = (TYPEOF(le.Input_alt_county))'','',':alt_county')
    #END
 
+    #IF( #TEXT(Input_alt_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_alt_geo_lat = (TYPEOF(le.Input_alt_geo_lat))'','',':alt_geo_lat')
    #END
 
+    #IF( #TEXT(Input_alt_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_alt_geo_long = (TYPEOF(le.Input_alt_geo_long))'','',':alt_geo_long')
    #END
 
+    #IF( #TEXT(Input_alt_msa)='' )
      '' 
    #ELSE
        IF( le.Input_alt_msa = (TYPEOF(le.Input_alt_msa))'','',':alt_msa')
    #END
 
+    #IF( #TEXT(Input_alt_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_alt_geo_blk = (TYPEOF(le.Input_alt_geo_blk))'','',':alt_geo_blk')
    #END
 
+    #IF( #TEXT(Input_alt_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_alt_geo_match = (TYPEOF(le.Input_alt_geo_match))'','',':alt_geo_match')
    #END
 
+    #IF( #TEXT(Input_alt_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_alt_err_stat = (TYPEOF(le.Input_alt_err_stat))'','',':alt_err_stat')
    #END
 
+    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
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
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
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
