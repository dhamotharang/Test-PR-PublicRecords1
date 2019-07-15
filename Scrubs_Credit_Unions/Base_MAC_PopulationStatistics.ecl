 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_source_rec_id = '',Input_bdid = '',Input_record_type = '',Input_raw_aid = '',Input_ace_aid = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_charter = '',Input_cycle_date = '',Input_join_number = '',Input_siteid = '',Input_cu_name = '',Input_sitename = '',Input_sitetypename = '',Input_mainoffice = '',Input_addrtype = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_statename = '',Input_zip_code = '',Input_countyname = '',Input_country = '',Input_phone = '',Input_contact_name = '',Input_assets = '',Input_loans = '',Input_networthratio = '',Input_perc_sharegrowth = '',Input_perc_loangrowth = '',Input_loantoassetsratio = '',Input_investassetsratio = '',Input_nummem = '',Input_numfull = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Credit_Unions;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
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
 
+    #IF( #TEXT(Input_charter)='' )
      '' 
    #ELSE
        IF( le.Input_charter = (TYPEOF(le.Input_charter))'','',':charter')
    #END
 
+    #IF( #TEXT(Input_cycle_date)='' )
      '' 
    #ELSE
        IF( le.Input_cycle_date = (TYPEOF(le.Input_cycle_date))'','',':cycle_date')
    #END
 
+    #IF( #TEXT(Input_join_number)='' )
      '' 
    #ELSE
        IF( le.Input_join_number = (TYPEOF(le.Input_join_number))'','',':join_number')
    #END
 
+    #IF( #TEXT(Input_siteid)='' )
      '' 
    #ELSE
        IF( le.Input_siteid = (TYPEOF(le.Input_siteid))'','',':siteid')
    #END
 
+    #IF( #TEXT(Input_cu_name)='' )
      '' 
    #ELSE
        IF( le.Input_cu_name = (TYPEOF(le.Input_cu_name))'','',':cu_name')
    #END
 
+    #IF( #TEXT(Input_sitename)='' )
      '' 
    #ELSE
        IF( le.Input_sitename = (TYPEOF(le.Input_sitename))'','',':sitename')
    #END
 
+    #IF( #TEXT(Input_sitetypename)='' )
      '' 
    #ELSE
        IF( le.Input_sitetypename = (TYPEOF(le.Input_sitetypename))'','',':sitetypename')
    #END
 
+    #IF( #TEXT(Input_mainoffice)='' )
      '' 
    #ELSE
        IF( le.Input_mainoffice = (TYPEOF(le.Input_mainoffice))'','',':mainoffice')
    #END
 
+    #IF( #TEXT(Input_addrtype)='' )
      '' 
    #ELSE
        IF( le.Input_addrtype = (TYPEOF(le.Input_addrtype))'','',':addrtype')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
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
 
+    #IF( #TEXT(Input_statename)='' )
      '' 
    #ELSE
        IF( le.Input_statename = (TYPEOF(le.Input_statename))'','',':statename')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_countyname)='' )
      '' 
    #ELSE
        IF( le.Input_countyname = (TYPEOF(le.Input_countyname))'','',':countyname')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_contact_name)='' )
      '' 
    #ELSE
        IF( le.Input_contact_name = (TYPEOF(le.Input_contact_name))'','',':contact_name')
    #END
 
+    #IF( #TEXT(Input_assets)='' )
      '' 
    #ELSE
        IF( le.Input_assets = (TYPEOF(le.Input_assets))'','',':assets')
    #END
 
+    #IF( #TEXT(Input_loans)='' )
      '' 
    #ELSE
        IF( le.Input_loans = (TYPEOF(le.Input_loans))'','',':loans')
    #END
 
+    #IF( #TEXT(Input_networthratio)='' )
      '' 
    #ELSE
        IF( le.Input_networthratio = (TYPEOF(le.Input_networthratio))'','',':networthratio')
    #END
 
+    #IF( #TEXT(Input_perc_sharegrowth)='' )
      '' 
    #ELSE
        IF( le.Input_perc_sharegrowth = (TYPEOF(le.Input_perc_sharegrowth))'','',':perc_sharegrowth')
    #END
 
+    #IF( #TEXT(Input_perc_loangrowth)='' )
      '' 
    #ELSE
        IF( le.Input_perc_loangrowth = (TYPEOF(le.Input_perc_loangrowth))'','',':perc_loangrowth')
    #END
 
+    #IF( #TEXT(Input_loantoassetsratio)='' )
      '' 
    #ELSE
        IF( le.Input_loantoassetsratio = (TYPEOF(le.Input_loantoassetsratio))'','',':loantoassetsratio')
    #END
 
+    #IF( #TEXT(Input_investassetsratio)='' )
      '' 
    #ELSE
        IF( le.Input_investassetsratio = (TYPEOF(le.Input_investassetsratio))'','',':investassetsratio')
    #END
 
+    #IF( #TEXT(Input_nummem)='' )
      '' 
    #ELSE
        IF( le.Input_nummem = (TYPEOF(le.Input_nummem))'','',':nummem')
    #END
 
+    #IF( #TEXT(Input_numfull)='' )
      '' 
    #ELSE
        IF( le.Input_numfull = (TYPEOF(le.Input_numfull))'','',':numfull')
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
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line_last = (TYPEOF(le.Input_prep_addr_line_last))'','',':prep_addr_line_last')
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
