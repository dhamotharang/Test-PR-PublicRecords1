 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_append_process_date = '',Input_orig_dob = '',Input_orig_credential_type = '',Input_orig_id_terminal_date = '',Input_orig_lname = '',Input_orig_fname = '',Input_orig_mi = '',Input_orig_namesuf = '',Input_orig_street = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_drivered = '',Input_orig_sex = '',Input_orig_height = '',Input_orig_height2 = '',Input_orig_weight = '',Input_orig_hair = '',Input_orig_eyes = '',Input_orig_dlexpiredate = '',Input_orig_dlstat = '',Input_orig_dlissuedate = '',Input_orig_originalissuedate = '',Input_orig_regstatfr = '',Input_orig_regstatcr = '',Input_orig_dlclass = '',Input_orig_historynum = '',Input_orig_disabledvet = '',Input_orig_photo = '',Input_orig_habitualoffender = '',Input_orig_restrictions = '',Input_orig_endorsements = '',Input_orig_endorsements2 = '',Input_orig_endorsements3 = '',Input_orig_endorsements4 = '',Input_orig_endorsements5 = '',Input_orig_endorsements6 = '',Input_orig_endorsements7 = '',Input_orig_endorsements8 = '',Input_orig_endorsements9 = '',Input_orig_endorsements10 = '',Input_orig_endorsements11_20 = '',Input_orig_comm_driv_status = '',Input_orig_disabled_vet_type = '',Input_orig_organ_donor = '',Input_orig_crlf = '',Input_clean_name_prefix = '',Input_clean_name_first = '',Input_clean_name_middle = '',Input_clean_name_last = '',Input_clean_name_suffix = '',Input_clean_name_score = '',Input_clean_prim_range = '',Input_clean_predir = '',Input_clean_prim_name = '',Input_clean_addr_suffix = '',Input_clean_postdir = '',Input_clean_unit_desig = '',Input_clean_sec_range = '',Input_clean_p_city_name = '',Input_clean_v_city_name = '',Input_clean_st = '',Input_clean_zip = '',Input_clean_zip4 = '',Input_clean_cart = '',Input_clean_cr_sort_sz = '',Input_clean_lot = '',Input_clean_lot_order = '',Input_clean_dpbc = '',Input_clean_chk_digit = '',Input_clean_record_type = '',Input_clean_ace_fips_st = '',Input_clean_fipscounty = '',Input_clean_geo_lat = '',Input_clean_geo_long = '',Input_clean_msa = '',Input_clean_geo_blk = '',Input_clean_geo_match = '',Input_clean_err_stat = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_DL_ME_MEDCERT;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_append_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_append_process_date = (TYPEOF(le.Input_append_process_date))'','',':append_process_date')
    #END
 
+    #IF( #TEXT(Input_orig_dob)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dob = (TYPEOF(le.Input_orig_dob))'','',':orig_dob')
    #END
 
+    #IF( #TEXT(Input_orig_credential_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_credential_type = (TYPEOF(le.Input_orig_credential_type))'','',':orig_credential_type')
    #END
 
+    #IF( #TEXT(Input_orig_id_terminal_date)='' )
      '' 
    #ELSE
        IF( le.Input_orig_id_terminal_date = (TYPEOF(le.Input_orig_id_terminal_date))'','',':orig_id_terminal_date')
    #END
 
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
 
+    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
 
+    #IF( #TEXT(Input_orig_mi)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mi = (TYPEOF(le.Input_orig_mi))'','',':orig_mi')
    #END
 
+    #IF( #TEXT(Input_orig_namesuf)='' )
      '' 
    #ELSE
        IF( le.Input_orig_namesuf = (TYPEOF(le.Input_orig_namesuf))'','',':orig_namesuf')
    #END
 
+    #IF( #TEXT(Input_orig_street)='' )
      '' 
    #ELSE
        IF( le.Input_orig_street = (TYPEOF(le.Input_orig_street))'','',':orig_street')
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
 
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
 
+    #IF( #TEXT(Input_orig_drivered)='' )
      '' 
    #ELSE
        IF( le.Input_orig_drivered = (TYPEOF(le.Input_orig_drivered))'','',':orig_drivered')
    #END
 
+    #IF( #TEXT(Input_orig_sex)='' )
      '' 
    #ELSE
        IF( le.Input_orig_sex = (TYPEOF(le.Input_orig_sex))'','',':orig_sex')
    #END
 
+    #IF( #TEXT(Input_orig_height)='' )
      '' 
    #ELSE
        IF( le.Input_orig_height = (TYPEOF(le.Input_orig_height))'','',':orig_height')
    #END
 
+    #IF( #TEXT(Input_orig_height2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_height2 = (TYPEOF(le.Input_orig_height2))'','',':orig_height2')
    #END
 
+    #IF( #TEXT(Input_orig_weight)='' )
      '' 
    #ELSE
        IF( le.Input_orig_weight = (TYPEOF(le.Input_orig_weight))'','',':orig_weight')
    #END
 
+    #IF( #TEXT(Input_orig_hair)='' )
      '' 
    #ELSE
        IF( le.Input_orig_hair = (TYPEOF(le.Input_orig_hair))'','',':orig_hair')
    #END
 
+    #IF( #TEXT(Input_orig_eyes)='' )
      '' 
    #ELSE
        IF( le.Input_orig_eyes = (TYPEOF(le.Input_orig_eyes))'','',':orig_eyes')
    #END
 
+    #IF( #TEXT(Input_orig_dlexpiredate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlexpiredate = (TYPEOF(le.Input_orig_dlexpiredate))'','',':orig_dlexpiredate')
    #END
 
+    #IF( #TEXT(Input_orig_dlstat)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlstat = (TYPEOF(le.Input_orig_dlstat))'','',':orig_dlstat')
    #END
 
+    #IF( #TEXT(Input_orig_dlissuedate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlissuedate = (TYPEOF(le.Input_orig_dlissuedate))'','',':orig_dlissuedate')
    #END
 
+    #IF( #TEXT(Input_orig_originalissuedate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_originalissuedate = (TYPEOF(le.Input_orig_originalissuedate))'','',':orig_originalissuedate')
    #END
 
+    #IF( #TEXT(Input_orig_regstatfr)='' )
      '' 
    #ELSE
        IF( le.Input_orig_regstatfr = (TYPEOF(le.Input_orig_regstatfr))'','',':orig_regstatfr')
    #END
 
+    #IF( #TEXT(Input_orig_regstatcr)='' )
      '' 
    #ELSE
        IF( le.Input_orig_regstatcr = (TYPEOF(le.Input_orig_regstatcr))'','',':orig_regstatcr')
    #END
 
+    #IF( #TEXT(Input_orig_dlclass)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dlclass = (TYPEOF(le.Input_orig_dlclass))'','',':orig_dlclass')
    #END
 
+    #IF( #TEXT(Input_orig_historynum)='' )
      '' 
    #ELSE
        IF( le.Input_orig_historynum = (TYPEOF(le.Input_orig_historynum))'','',':orig_historynum')
    #END
 
+    #IF( #TEXT(Input_orig_disabledvet)='' )
      '' 
    #ELSE
        IF( le.Input_orig_disabledvet = (TYPEOF(le.Input_orig_disabledvet))'','',':orig_disabledvet')
    #END
 
+    #IF( #TEXT(Input_orig_photo)='' )
      '' 
    #ELSE
        IF( le.Input_orig_photo = (TYPEOF(le.Input_orig_photo))'','',':orig_photo')
    #END
 
+    #IF( #TEXT(Input_orig_habitualoffender)='' )
      '' 
    #ELSE
        IF( le.Input_orig_habitualoffender = (TYPEOF(le.Input_orig_habitualoffender))'','',':orig_habitualoffender')
    #END
 
+    #IF( #TEXT(Input_orig_restrictions)='' )
      '' 
    #ELSE
        IF( le.Input_orig_restrictions = (TYPEOF(le.Input_orig_restrictions))'','',':orig_restrictions')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements = (TYPEOF(le.Input_orig_endorsements))'','',':orig_endorsements')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements2)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements2 = (TYPEOF(le.Input_orig_endorsements2))'','',':orig_endorsements2')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements3)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements3 = (TYPEOF(le.Input_orig_endorsements3))'','',':orig_endorsements3')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements4 = (TYPEOF(le.Input_orig_endorsements4))'','',':orig_endorsements4')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements5)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements5 = (TYPEOF(le.Input_orig_endorsements5))'','',':orig_endorsements5')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements6)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements6 = (TYPEOF(le.Input_orig_endorsements6))'','',':orig_endorsements6')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements7)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements7 = (TYPEOF(le.Input_orig_endorsements7))'','',':orig_endorsements7')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements8)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements8 = (TYPEOF(le.Input_orig_endorsements8))'','',':orig_endorsements8')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements9)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements9 = (TYPEOF(le.Input_orig_endorsements9))'','',':orig_endorsements9')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements10)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements10 = (TYPEOF(le.Input_orig_endorsements10))'','',':orig_endorsements10')
    #END
 
+    #IF( #TEXT(Input_orig_endorsements11_20)='' )
      '' 
    #ELSE
        IF( le.Input_orig_endorsements11_20 = (TYPEOF(le.Input_orig_endorsements11_20))'','',':orig_endorsements11_20')
    #END
 
+    #IF( #TEXT(Input_orig_comm_driv_status)='' )
      '' 
    #ELSE
        IF( le.Input_orig_comm_driv_status = (TYPEOF(le.Input_orig_comm_driv_status))'','',':orig_comm_driv_status')
    #END
 
+    #IF( #TEXT(Input_orig_disabled_vet_type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_disabled_vet_type = (TYPEOF(le.Input_orig_disabled_vet_type))'','',':orig_disabled_vet_type')
    #END
 
+    #IF( #TEXT(Input_orig_organ_donor)='' )
      '' 
    #ELSE
        IF( le.Input_orig_organ_donor = (TYPEOF(le.Input_orig_organ_donor))'','',':orig_organ_donor')
    #END
 
+    #IF( #TEXT(Input_orig_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_orig_crlf = (TYPEOF(le.Input_orig_crlf))'','',':orig_crlf')
    #END
 
+    #IF( #TEXT(Input_clean_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_prefix = (TYPEOF(le.Input_clean_name_prefix))'','',':clean_name_prefix')
    #END
 
+    #IF( #TEXT(Input_clean_name_first)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_first = (TYPEOF(le.Input_clean_name_first))'','',':clean_name_first')
    #END
 
+    #IF( #TEXT(Input_clean_name_middle)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_middle = (TYPEOF(le.Input_clean_name_middle))'','',':clean_name_middle')
    #END
 
+    #IF( #TEXT(Input_clean_name_last)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_last = (TYPEOF(le.Input_clean_name_last))'','',':clean_name_last')
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
 
+    #IF( #TEXT(Input_clean_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dpbc = (TYPEOF(le.Input_clean_dpbc))'','',':clean_dpbc')
    #END
 
+    #IF( #TEXT(Input_clean_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_chk_digit = (TYPEOF(le.Input_clean_chk_digit))'','',':clean_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_record_type = (TYPEOF(le.Input_clean_record_type))'','',':clean_record_type')
    #END
 
+    #IF( #TEXT(Input_clean_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_ace_fips_st = (TYPEOF(le.Input_clean_ace_fips_st))'','',':clean_ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_clean_fipscounty)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fipscounty = (TYPEOF(le.Input_clean_fipscounty))'','',':clean_fipscounty')
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
