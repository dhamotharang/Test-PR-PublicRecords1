 
EXPORT MAC_PopulationStatistics(infile,Ref='',src_key='',Input_pty_key = '',Input_source = '',Input_orig_pty_name = '',Input_orig_vessel_name = '',Input_country = '',Input_name_type = '',Input_addr_1 = '',Input_addr_2 = '',Input_addr_3 = '',Input_addr_4 = '',Input_addr_5 = '',Input_addr_6 = '',Input_addr_7 = '',Input_addr_8 = '',Input_addr_9 = '',Input_addr_10 = '',Input_remarks_1 = '',Input_remarks_2 = '',Input_remarks_3 = '',Input_remarks_4 = '',Input_remarks_5 = '',Input_remarks_6 = '',Input_remarks_7 = '',Input_remarks_8 = '',Input_remarks_9 = '',Input_remarks_10 = '',Input_remarks_11 = '',Input_remarks_12 = '',Input_remarks_13 = '',Input_remarks_14 = '',Input_remarks_15 = '',Input_remarks_16 = '',Input_remarks_17 = '',Input_remarks_18 = '',Input_remarks_19 = '',Input_remarks_20 = '',Input_remarks_21 = '',Input_remarks_22 = '',Input_remarks_23 = '',Input_remarks_24 = '',Input_remarks_25 = '',Input_remarks_26 = '',Input_remarks_27 = '',Input_remarks_28 = '',Input_remarks_29 = '',Input_remarks_30 = '',Input_cname = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_suffix = '',Input_a_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_record_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_global_sid = '',Input_record_sid = '',Input_did = '',Input_aid_prim_range = '',Input_aid_predir = '',Input_aid_prim_name = '',Input_aid_addr_suffix = '',Input_aid_postdir = '',Input_aid_unit_desig = '',Input_aid_sec_range = '',Input_aid_p_city_name = '',Input_aid_v_city_name = '',Input_aid_st = '',Input_aid_zip = '',Input_aid_zip4 = '',Input_aid_cart = '',Input_aid_cr_sort_sz = '',Input_aid_lot = '',Input_aid_lot_order = '',Input_aid_dpbc = '',Input_aid_chk_digit = '',Input_aid_record_type = '',Input_aid_fips_st = '',Input_aid_county = '',Input_aid_geo_lat = '',Input_aid_geo_long = '',Input_aid_msa = '',Input_aid_geo_blk = '',Input_aid_geo_match = '',Input_aid_err_stat = '',Input_append_rawaid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Patriot;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(src_key)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_pty_key)='' )
      '' 
    #ELSE
        IF( le.Input_pty_key = (TYPEOF(le.Input_pty_key))'','',':pty_key')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_orig_pty_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_pty_name = (TYPEOF(le.Input_orig_pty_name))'','',':orig_pty_name')
    #END
 
+    #IF( #TEXT(Input_orig_vessel_name)='' )
      '' 
    #ELSE
        IF( le.Input_orig_vessel_name = (TYPEOF(le.Input_orig_vessel_name))'','',':orig_vessel_name')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
 
+    #IF( #TEXT(Input_addr_1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_1 = (TYPEOF(le.Input_addr_1))'','',':addr_1')
    #END
 
+    #IF( #TEXT(Input_addr_2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_2 = (TYPEOF(le.Input_addr_2))'','',':addr_2')
    #END
 
+    #IF( #TEXT(Input_addr_3)='' )
      '' 
    #ELSE
        IF( le.Input_addr_3 = (TYPEOF(le.Input_addr_3))'','',':addr_3')
    #END
 
+    #IF( #TEXT(Input_addr_4)='' )
      '' 
    #ELSE
        IF( le.Input_addr_4 = (TYPEOF(le.Input_addr_4))'','',':addr_4')
    #END
 
+    #IF( #TEXT(Input_addr_5)='' )
      '' 
    #ELSE
        IF( le.Input_addr_5 = (TYPEOF(le.Input_addr_5))'','',':addr_5')
    #END
 
+    #IF( #TEXT(Input_addr_6)='' )
      '' 
    #ELSE
        IF( le.Input_addr_6 = (TYPEOF(le.Input_addr_6))'','',':addr_6')
    #END
 
+    #IF( #TEXT(Input_addr_7)='' )
      '' 
    #ELSE
        IF( le.Input_addr_7 = (TYPEOF(le.Input_addr_7))'','',':addr_7')
    #END
 
+    #IF( #TEXT(Input_addr_8)='' )
      '' 
    #ELSE
        IF( le.Input_addr_8 = (TYPEOF(le.Input_addr_8))'','',':addr_8')
    #END
 
+    #IF( #TEXT(Input_addr_9)='' )
      '' 
    #ELSE
        IF( le.Input_addr_9 = (TYPEOF(le.Input_addr_9))'','',':addr_9')
    #END
 
+    #IF( #TEXT(Input_addr_10)='' )
      '' 
    #ELSE
        IF( le.Input_addr_10 = (TYPEOF(le.Input_addr_10))'','',':addr_10')
    #END
 
+    #IF( #TEXT(Input_remarks_1)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_1 = (TYPEOF(le.Input_remarks_1))'','',':remarks_1')
    #END
 
+    #IF( #TEXT(Input_remarks_2)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_2 = (TYPEOF(le.Input_remarks_2))'','',':remarks_2')
    #END
 
+    #IF( #TEXT(Input_remarks_3)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_3 = (TYPEOF(le.Input_remarks_3))'','',':remarks_3')
    #END
 
+    #IF( #TEXT(Input_remarks_4)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_4 = (TYPEOF(le.Input_remarks_4))'','',':remarks_4')
    #END
 
+    #IF( #TEXT(Input_remarks_5)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_5 = (TYPEOF(le.Input_remarks_5))'','',':remarks_5')
    #END
 
+    #IF( #TEXT(Input_remarks_6)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_6 = (TYPEOF(le.Input_remarks_6))'','',':remarks_6')
    #END
 
+    #IF( #TEXT(Input_remarks_7)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_7 = (TYPEOF(le.Input_remarks_7))'','',':remarks_7')
    #END
 
+    #IF( #TEXT(Input_remarks_8)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_8 = (TYPEOF(le.Input_remarks_8))'','',':remarks_8')
    #END
 
+    #IF( #TEXT(Input_remarks_9)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_9 = (TYPEOF(le.Input_remarks_9))'','',':remarks_9')
    #END
 
+    #IF( #TEXT(Input_remarks_10)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_10 = (TYPEOF(le.Input_remarks_10))'','',':remarks_10')
    #END
 
+    #IF( #TEXT(Input_remarks_11)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_11 = (TYPEOF(le.Input_remarks_11))'','',':remarks_11')
    #END
 
+    #IF( #TEXT(Input_remarks_12)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_12 = (TYPEOF(le.Input_remarks_12))'','',':remarks_12')
    #END
 
+    #IF( #TEXT(Input_remarks_13)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_13 = (TYPEOF(le.Input_remarks_13))'','',':remarks_13')
    #END
 
+    #IF( #TEXT(Input_remarks_14)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_14 = (TYPEOF(le.Input_remarks_14))'','',':remarks_14')
    #END
 
+    #IF( #TEXT(Input_remarks_15)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_15 = (TYPEOF(le.Input_remarks_15))'','',':remarks_15')
    #END
 
+    #IF( #TEXT(Input_remarks_16)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_16 = (TYPEOF(le.Input_remarks_16))'','',':remarks_16')
    #END
 
+    #IF( #TEXT(Input_remarks_17)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_17 = (TYPEOF(le.Input_remarks_17))'','',':remarks_17')
    #END
 
+    #IF( #TEXT(Input_remarks_18)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_18 = (TYPEOF(le.Input_remarks_18))'','',':remarks_18')
    #END
 
+    #IF( #TEXT(Input_remarks_19)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_19 = (TYPEOF(le.Input_remarks_19))'','',':remarks_19')
    #END
 
+    #IF( #TEXT(Input_remarks_20)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_20 = (TYPEOF(le.Input_remarks_20))'','',':remarks_20')
    #END
 
+    #IF( #TEXT(Input_remarks_21)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_21 = (TYPEOF(le.Input_remarks_21))'','',':remarks_21')
    #END
 
+    #IF( #TEXT(Input_remarks_22)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_22 = (TYPEOF(le.Input_remarks_22))'','',':remarks_22')
    #END
 
+    #IF( #TEXT(Input_remarks_23)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_23 = (TYPEOF(le.Input_remarks_23))'','',':remarks_23')
    #END
 
+    #IF( #TEXT(Input_remarks_24)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_24 = (TYPEOF(le.Input_remarks_24))'','',':remarks_24')
    #END
 
+    #IF( #TEXT(Input_remarks_25)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_25 = (TYPEOF(le.Input_remarks_25))'','',':remarks_25')
    #END
 
+    #IF( #TEXT(Input_remarks_26)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_26 = (TYPEOF(le.Input_remarks_26))'','',':remarks_26')
    #END
 
+    #IF( #TEXT(Input_remarks_27)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_27 = (TYPEOF(le.Input_remarks_27))'','',':remarks_27')
    #END
 
+    #IF( #TEXT(Input_remarks_28)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_28 = (TYPEOF(le.Input_remarks_28))'','',':remarks_28')
    #END
 
+    #IF( #TEXT(Input_remarks_29)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_29 = (TYPEOF(le.Input_remarks_29))'','',':remarks_29')
    #END
 
+    #IF( #TEXT(Input_remarks_30)='' )
      '' 
    #ELSE
        IF( le.Input_remarks_30 = (TYPEOF(le.Input_remarks_30))'','',':remarks_30')
    #END
 
+    #IF( #TEXT(Input_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cname = (TYPEOF(le.Input_cname))'','',':cname')
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
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_a_score)='' )
      '' 
    #ELSE
        IF( le.Input_a_score = (TYPEOF(le.Input_a_score))'','',':a_score')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
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
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_aid_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_aid_prim_range = (TYPEOF(le.Input_aid_prim_range))'','',':aid_prim_range')
    #END
 
+    #IF( #TEXT(Input_aid_predir)='' )
      '' 
    #ELSE
        IF( le.Input_aid_predir = (TYPEOF(le.Input_aid_predir))'','',':aid_predir')
    #END
 
+    #IF( #TEXT(Input_aid_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_aid_prim_name = (TYPEOF(le.Input_aid_prim_name))'','',':aid_prim_name')
    #END
 
+    #IF( #TEXT(Input_aid_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_aid_addr_suffix = (TYPEOF(le.Input_aid_addr_suffix))'','',':aid_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_aid_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_aid_postdir = (TYPEOF(le.Input_aid_postdir))'','',':aid_postdir')
    #END
 
+    #IF( #TEXT(Input_aid_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_aid_unit_desig = (TYPEOF(le.Input_aid_unit_desig))'','',':aid_unit_desig')
    #END
 
+    #IF( #TEXT(Input_aid_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_aid_sec_range = (TYPEOF(le.Input_aid_sec_range))'','',':aid_sec_range')
    #END
 
+    #IF( #TEXT(Input_aid_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_aid_p_city_name = (TYPEOF(le.Input_aid_p_city_name))'','',':aid_p_city_name')
    #END
 
+    #IF( #TEXT(Input_aid_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_aid_v_city_name = (TYPEOF(le.Input_aid_v_city_name))'','',':aid_v_city_name')
    #END
 
+    #IF( #TEXT(Input_aid_st)='' )
      '' 
    #ELSE
        IF( le.Input_aid_st = (TYPEOF(le.Input_aid_st))'','',':aid_st')
    #END
 
+    #IF( #TEXT(Input_aid_zip)='' )
      '' 
    #ELSE
        IF( le.Input_aid_zip = (TYPEOF(le.Input_aid_zip))'','',':aid_zip')
    #END
 
+    #IF( #TEXT(Input_aid_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_aid_zip4 = (TYPEOF(le.Input_aid_zip4))'','',':aid_zip4')
    #END
 
+    #IF( #TEXT(Input_aid_cart)='' )
      '' 
    #ELSE
        IF( le.Input_aid_cart = (TYPEOF(le.Input_aid_cart))'','',':aid_cart')
    #END
 
+    #IF( #TEXT(Input_aid_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_aid_cr_sort_sz = (TYPEOF(le.Input_aid_cr_sort_sz))'','',':aid_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_aid_lot)='' )
      '' 
    #ELSE
        IF( le.Input_aid_lot = (TYPEOF(le.Input_aid_lot))'','',':aid_lot')
    #END
 
+    #IF( #TEXT(Input_aid_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_aid_lot_order = (TYPEOF(le.Input_aid_lot_order))'','',':aid_lot_order')
    #END
 
+    #IF( #TEXT(Input_aid_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_aid_dpbc = (TYPEOF(le.Input_aid_dpbc))'','',':aid_dpbc')
    #END
 
+    #IF( #TEXT(Input_aid_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_aid_chk_digit = (TYPEOF(le.Input_aid_chk_digit))'','',':aid_chk_digit')
    #END
 
+    #IF( #TEXT(Input_aid_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_aid_record_type = (TYPEOF(le.Input_aid_record_type))'','',':aid_record_type')
    #END
 
+    #IF( #TEXT(Input_aid_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_aid_fips_st = (TYPEOF(le.Input_aid_fips_st))'','',':aid_fips_st')
    #END
 
+    #IF( #TEXT(Input_aid_county)='' )
      '' 
    #ELSE
        IF( le.Input_aid_county = (TYPEOF(le.Input_aid_county))'','',':aid_county')
    #END
 
+    #IF( #TEXT(Input_aid_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_aid_geo_lat = (TYPEOF(le.Input_aid_geo_lat))'','',':aid_geo_lat')
    #END
 
+    #IF( #TEXT(Input_aid_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_aid_geo_long = (TYPEOF(le.Input_aid_geo_long))'','',':aid_geo_long')
    #END
 
+    #IF( #TEXT(Input_aid_msa)='' )
      '' 
    #ELSE
        IF( le.Input_aid_msa = (TYPEOF(le.Input_aid_msa))'','',':aid_msa')
    #END
 
+    #IF( #TEXT(Input_aid_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_aid_geo_blk = (TYPEOF(le.Input_aid_geo_blk))'','',':aid_geo_blk')
    #END
 
+    #IF( #TEXT(Input_aid_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_aid_geo_match = (TYPEOF(le.Input_aid_geo_match))'','',':aid_geo_match')
    #END
 
+    #IF( #TEXT(Input_aid_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_aid_err_stat = (TYPEOF(le.Input_aid_err_stat))'','',':aid_err_stat')
    #END
 
+    #IF( #TEXT(Input_append_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_append_rawaid = (TYPEOF(le.Input_append_rawaid))'','',':append_rawaid')
    #END
;
    #IF (#TEXT(src_key)<>'')
    SELF.source := le.src_key;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(src_key)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(src_key)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(src_key)<>'' ) source, #END -cnt );
ENDMACRO;
