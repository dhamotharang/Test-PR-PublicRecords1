 
EXPORT Source_Level_Base_MAC_PopulationStatistics(infile,Ref='',source='',Input_cellphoneidkey = '',Input_source = '',Input_src_bitmap = '',Input_household_flag = '',Input_rules = '',Input_cellphone = '',Input_npa = '',Input_phone7 = '',Input_phone7_did_key = '',Input_pdid = '',Input_did = '',Input_did_score = '',Input_datefirstseen = '',Input_datelastseen = '',Input_datevendorfirstreported = '',Input_datevendorlastreported = '',Input_dt_nonglb_last_seen = '',Input_glb_dppa_flag = '',Input_did_type = '',Input_origname = '',Input_address1 = '',Input_address2 = '',Input_origcity = '',Input_origstate = '',Input_origzip = '',Input_orig_phone = '',Input_orig_carrier_name = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_state = '',Input_zip5 = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_ace_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_dob = '',Input_rawaid = '',Input_cleanaid = '',Input_current_rec = '',Input_first_build_date = '',Input_last_build_date = '',Input_ingest_tpe = '',Input_verified = '',Input_cord_cutter = '',Input_activity_status = '',Input_prepaid = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,PhonesPlus_V2;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cellphoneidkey)='' )
      '' 
    #ELSE
        IF( le.Input_cellphoneidkey = (TYPEOF(le.Input_cellphoneidkey))'','',':cellphoneidkey')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_src_bitmap)='' )
      '' 
    #ELSE
        IF( le.Input_src_bitmap = (TYPEOF(le.Input_src_bitmap))'','',':src_bitmap')
    #END
 
+    #IF( #TEXT(Input_household_flag)='' )
      '' 
    #ELSE
        IF( le.Input_household_flag = (TYPEOF(le.Input_household_flag))'','',':household_flag')
    #END
 
+    #IF( #TEXT(Input_rules)='' )
      '' 
    #ELSE
        IF( le.Input_rules = (TYPEOF(le.Input_rules))'','',':rules')
    #END
 
+    #IF( #TEXT(Input_cellphone)='' )
      '' 
    #ELSE
        IF( le.Input_cellphone = (TYPEOF(le.Input_cellphone))'','',':cellphone')
    #END
 
+    #IF( #TEXT(Input_npa)='' )
      '' 
    #ELSE
        IF( le.Input_npa = (TYPEOF(le.Input_npa))'','',':npa')
    #END
 
+    #IF( #TEXT(Input_phone7)='' )
      '' 
    #ELSE
        IF( le.Input_phone7 = (TYPEOF(le.Input_phone7))'','',':phone7')
    #END
 
+    #IF( #TEXT(Input_phone7_did_key)='' )
      '' 
    #ELSE
        IF( le.Input_phone7_did_key = (TYPEOF(le.Input_phone7_did_key))'','',':phone7_did_key')
    #END
 
+    #IF( #TEXT(Input_pdid)='' )
      '' 
    #ELSE
        IF( le.Input_pdid = (TYPEOF(le.Input_pdid))'','',':pdid')
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
 
+    #IF( #TEXT(Input_datevendorfirstreported)='' )
      '' 
    #ELSE
        IF( le.Input_datevendorfirstreported = (TYPEOF(le.Input_datevendorfirstreported))'','',':datevendorfirstreported')
    #END
 
+    #IF( #TEXT(Input_datevendorlastreported)='' )
      '' 
    #ELSE
        IF( le.Input_datevendorlastreported = (TYPEOF(le.Input_datevendorlastreported))'','',':datevendorlastreported')
    #END
 
+    #IF( #TEXT(Input_dt_nonglb_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_nonglb_last_seen = (TYPEOF(le.Input_dt_nonglb_last_seen))'','',':dt_nonglb_last_seen')
    #END
 
+    #IF( #TEXT(Input_glb_dppa_flag)='' )
      '' 
    #ELSE
        IF( le.Input_glb_dppa_flag = (TYPEOF(le.Input_glb_dppa_flag))'','',':glb_dppa_flag')
    #END
 
+    #IF( #TEXT(Input_did_type)='' )
      '' 
    #ELSE
        IF( le.Input_did_type = (TYPEOF(le.Input_did_type))'','',':did_type')
    #END
 
+    #IF( #TEXT(Input_origname)='' )
      '' 
    #ELSE
        IF( le.Input_origname = (TYPEOF(le.Input_origname))'','',':origname')
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
 
+    #IF( #TEXT(Input_origcity)='' )
      '' 
    #ELSE
        IF( le.Input_origcity = (TYPEOF(le.Input_origcity))'','',':origcity')
    #END
 
+    #IF( #TEXT(Input_origstate)='' )
      '' 
    #ELSE
        IF( le.Input_origstate = (TYPEOF(le.Input_origstate))'','',':origstate')
    #END
 
+    #IF( #TEXT(Input_origzip)='' )
      '' 
    #ELSE
        IF( le.Input_origzip = (TYPEOF(le.Input_origzip))'','',':origzip')
    #END
 
+    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
 
+    #IF( #TEXT(Input_orig_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_carrier_name = (TYPEOF(le.Input_orig_carrier_name))'','',':orig_carrier_name')
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
 
+    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
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
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_ace_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_county = (TYPEOF(le.Input_ace_fips_county))'','',':ace_fips_county')
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
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_cleanaid)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaid = (TYPEOF(le.Input_cleanaid))'','',':cleanaid')
    #END
 
+    #IF( #TEXT(Input_current_rec)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec = (TYPEOF(le.Input_current_rec))'','',':current_rec')
    #END
 
+    #IF( #TEXT(Input_first_build_date)='' )
      '' 
    #ELSE
        IF( le.Input_first_build_date = (TYPEOF(le.Input_first_build_date))'','',':first_build_date')
    #END
 
+    #IF( #TEXT(Input_last_build_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_build_date = (TYPEOF(le.Input_last_build_date))'','',':last_build_date')
    #END
 
+    #IF( #TEXT(Input_ingest_tpe)='' )
      '' 
    #ELSE
        IF( le.Input_ingest_tpe = (TYPEOF(le.Input_ingest_tpe))'','',':ingest_tpe')
    #END
 
+    #IF( #TEXT(Input_verified)='' )
      '' 
    #ELSE
        IF( le.Input_verified = (TYPEOF(le.Input_verified))'','',':verified')
    #END
 
+    #IF( #TEXT(Input_cord_cutter)='' )
      '' 
    #ELSE
        IF( le.Input_cord_cutter = (TYPEOF(le.Input_cord_cutter))'','',':cord_cutter')
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
