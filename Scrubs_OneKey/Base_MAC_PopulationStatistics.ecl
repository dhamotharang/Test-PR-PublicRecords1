 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_source = '',Input_bdid = '',Input_bdid_score = '',Input_source_rec_id = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_type = '',Input_hcp_hce_id = '',Input_ok_indv_id = '',Input_ska_uid = '',Input_frst_nm = '',Input_mid_nm = '',Input_last_nm = '',Input_sfx_cd = '',Input_gender_cd = '',Input_prim_prfsn_cd = '',Input_prim_prfsn_desc = '',Input_prim_spcl_cd = '',Input_prim_spcl_desc = '',Input_sec_spcl_cd = '',Input_sec_spcl_desc = '',Input_tert_spcl_cd = '',Input_tert_spcl_desc = '',Input_sub_spcl_cd = '',Input_sub_spcl_desc = '',Input_titl_typ_id = '',Input_titl_typ_desc = '',Input_hco_hce_id = '',Input_ok_wkp_id = '',Input_ska_id = '',Input_bus_nm = '',Input_dba_nm = '',Input_addr_id = '',Input_str_front_id = '',Input_addr_ln_1_txt = '',Input_addr_ln_2_txt = '',Input_city_nm = '',Input_st_cd = '',Input_zip5_cd = '',Input_zip4_cd = '',Input_fips_cnty_cd = '',Input_fips_cnty_desc = '',Input_telephn_nbr = '',Input_cot_id = '',Input_cot_clas_id = '',Input_cot_clas_desc = '',Input_cot_fclt_typ_id = '',Input_cot_fclt_typ_desc = '',Input_cot_spcl_id = '',Input_cot_spcl_desc = '',Input_email_ind_flag = '',Input_ims_id = '',Input_hce_prfsnl_stat_cd = '',Input_hce_prfsnl_stat_desc = '',Input_excld_rsn_desc = '',Input_npi = '',Input_deactv_dt = '',Input_cleaned_deactv_dt = '',Input_xref_hce_id = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_raw_aid = '',Input_ace_aid = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OneKey;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
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
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
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
 
+    #IF( #TEXT(Input_hcp_hce_id)='' )
      '' 
    #ELSE
        IF( le.Input_hcp_hce_id = (TYPEOF(le.Input_hcp_hce_id))'','',':hcp_hce_id')
    #END
 
+    #IF( #TEXT(Input_ok_indv_id)='' )
      '' 
    #ELSE
        IF( le.Input_ok_indv_id = (TYPEOF(le.Input_ok_indv_id))'','',':ok_indv_id')
    #END
 
+    #IF( #TEXT(Input_ska_uid)='' )
      '' 
    #ELSE
        IF( le.Input_ska_uid = (TYPEOF(le.Input_ska_uid))'','',':ska_uid')
    #END
 
+    #IF( #TEXT(Input_frst_nm)='' )
      '' 
    #ELSE
        IF( le.Input_frst_nm = (TYPEOF(le.Input_frst_nm))'','',':frst_nm')
    #END
 
+    #IF( #TEXT(Input_mid_nm)='' )
      '' 
    #ELSE
        IF( le.Input_mid_nm = (TYPEOF(le.Input_mid_nm))'','',':mid_nm')
    #END
 
+    #IF( #TEXT(Input_last_nm)='' )
      '' 
    #ELSE
        IF( le.Input_last_nm = (TYPEOF(le.Input_last_nm))'','',':last_nm')
    #END
 
+    #IF( #TEXT(Input_sfx_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sfx_cd = (TYPEOF(le.Input_sfx_cd))'','',':sfx_cd')
    #END
 
+    #IF( #TEXT(Input_gender_cd)='' )
      '' 
    #ELSE
        IF( le.Input_gender_cd = (TYPEOF(le.Input_gender_cd))'','',':gender_cd')
    #END
 
+    #IF( #TEXT(Input_prim_prfsn_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prim_prfsn_cd = (TYPEOF(le.Input_prim_prfsn_cd))'','',':prim_prfsn_cd')
    #END
 
+    #IF( #TEXT(Input_prim_prfsn_desc)='' )
      '' 
    #ELSE
        IF( le.Input_prim_prfsn_desc = (TYPEOF(le.Input_prim_prfsn_desc))'','',':prim_prfsn_desc')
    #END
 
+    #IF( #TEXT(Input_prim_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_prim_spcl_cd = (TYPEOF(le.Input_prim_spcl_cd))'','',':prim_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_prim_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_prim_spcl_desc = (TYPEOF(le.Input_prim_spcl_desc))'','',':prim_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_sec_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sec_spcl_cd = (TYPEOF(le.Input_sec_spcl_cd))'','',':sec_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_sec_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sec_spcl_desc = (TYPEOF(le.Input_sec_spcl_desc))'','',':sec_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_tert_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_tert_spcl_cd = (TYPEOF(le.Input_tert_spcl_cd))'','',':tert_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_tert_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_tert_spcl_desc = (TYPEOF(le.Input_tert_spcl_desc))'','',':tert_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_sub_spcl_cd)='' )
      '' 
    #ELSE
        IF( le.Input_sub_spcl_cd = (TYPEOF(le.Input_sub_spcl_cd))'','',':sub_spcl_cd')
    #END
 
+    #IF( #TEXT(Input_sub_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sub_spcl_desc = (TYPEOF(le.Input_sub_spcl_desc))'','',':sub_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_titl_typ_id)='' )
      '' 
    #ELSE
        IF( le.Input_titl_typ_id = (TYPEOF(le.Input_titl_typ_id))'','',':titl_typ_id')
    #END
 
+    #IF( #TEXT(Input_titl_typ_desc)='' )
      '' 
    #ELSE
        IF( le.Input_titl_typ_desc = (TYPEOF(le.Input_titl_typ_desc))'','',':titl_typ_desc')
    #END
 
+    #IF( #TEXT(Input_hco_hce_id)='' )
      '' 
    #ELSE
        IF( le.Input_hco_hce_id = (TYPEOF(le.Input_hco_hce_id))'','',':hco_hce_id')
    #END
 
+    #IF( #TEXT(Input_ok_wkp_id)='' )
      '' 
    #ELSE
        IF( le.Input_ok_wkp_id = (TYPEOF(le.Input_ok_wkp_id))'','',':ok_wkp_id')
    #END
 
+    #IF( #TEXT(Input_ska_id)='' )
      '' 
    #ELSE
        IF( le.Input_ska_id = (TYPEOF(le.Input_ska_id))'','',':ska_id')
    #END
 
+    #IF( #TEXT(Input_bus_nm)='' )
      '' 
    #ELSE
        IF( le.Input_bus_nm = (TYPEOF(le.Input_bus_nm))'','',':bus_nm')
    #END
 
+    #IF( #TEXT(Input_dba_nm)='' )
      '' 
    #ELSE
        IF( le.Input_dba_nm = (TYPEOF(le.Input_dba_nm))'','',':dba_nm')
    #END
 
+    #IF( #TEXT(Input_addr_id)='' )
      '' 
    #ELSE
        IF( le.Input_addr_id = (TYPEOF(le.Input_addr_id))'','',':addr_id')
    #END
 
+    #IF( #TEXT(Input_str_front_id)='' )
      '' 
    #ELSE
        IF( le.Input_str_front_id = (TYPEOF(le.Input_str_front_id))'','',':str_front_id')
    #END
 
+    #IF( #TEXT(Input_addr_ln_1_txt)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ln_1_txt = (TYPEOF(le.Input_addr_ln_1_txt))'','',':addr_ln_1_txt')
    #END
 
+    #IF( #TEXT(Input_addr_ln_2_txt)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ln_2_txt = (TYPEOF(le.Input_addr_ln_2_txt))'','',':addr_ln_2_txt')
    #END
 
+    #IF( #TEXT(Input_city_nm)='' )
      '' 
    #ELSE
        IF( le.Input_city_nm = (TYPEOF(le.Input_city_nm))'','',':city_nm')
    #END
 
+    #IF( #TEXT(Input_st_cd)='' )
      '' 
    #ELSE
        IF( le.Input_st_cd = (TYPEOF(le.Input_st_cd))'','',':st_cd')
    #END
 
+    #IF( #TEXT(Input_zip5_cd)='' )
      '' 
    #ELSE
        IF( le.Input_zip5_cd = (TYPEOF(le.Input_zip5_cd))'','',':zip5_cd')
    #END
 
+    #IF( #TEXT(Input_zip4_cd)='' )
      '' 
    #ELSE
        IF( le.Input_zip4_cd = (TYPEOF(le.Input_zip4_cd))'','',':zip4_cd')
    #END
 
+    #IF( #TEXT(Input_fips_cnty_cd)='' )
      '' 
    #ELSE
        IF( le.Input_fips_cnty_cd = (TYPEOF(le.Input_fips_cnty_cd))'','',':fips_cnty_cd')
    #END
 
+    #IF( #TEXT(Input_fips_cnty_desc)='' )
      '' 
    #ELSE
        IF( le.Input_fips_cnty_desc = (TYPEOF(le.Input_fips_cnty_desc))'','',':fips_cnty_desc')
    #END
 
+    #IF( #TEXT(Input_telephn_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_telephn_nbr = (TYPEOF(le.Input_telephn_nbr))'','',':telephn_nbr')
    #END
 
+    #IF( #TEXT(Input_cot_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_id = (TYPEOF(le.Input_cot_id))'','',':cot_id')
    #END
 
+    #IF( #TEXT(Input_cot_clas_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_clas_id = (TYPEOF(le.Input_cot_clas_id))'','',':cot_clas_id')
    #END
 
+    #IF( #TEXT(Input_cot_clas_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cot_clas_desc = (TYPEOF(le.Input_cot_clas_desc))'','',':cot_clas_desc')
    #END
 
+    #IF( #TEXT(Input_cot_fclt_typ_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_fclt_typ_id = (TYPEOF(le.Input_cot_fclt_typ_id))'','',':cot_fclt_typ_id')
    #END
 
+    #IF( #TEXT(Input_cot_fclt_typ_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cot_fclt_typ_desc = (TYPEOF(le.Input_cot_fclt_typ_desc))'','',':cot_fclt_typ_desc')
    #END
 
+    #IF( #TEXT(Input_cot_spcl_id)='' )
      '' 
    #ELSE
        IF( le.Input_cot_spcl_id = (TYPEOF(le.Input_cot_spcl_id))'','',':cot_spcl_id')
    #END
 
+    #IF( #TEXT(Input_cot_spcl_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cot_spcl_desc = (TYPEOF(le.Input_cot_spcl_desc))'','',':cot_spcl_desc')
    #END
 
+    #IF( #TEXT(Input_email_ind_flag)='' )
      '' 
    #ELSE
        IF( le.Input_email_ind_flag = (TYPEOF(le.Input_email_ind_flag))'','',':email_ind_flag')
    #END
 
+    #IF( #TEXT(Input_ims_id)='' )
      '' 
    #ELSE
        IF( le.Input_ims_id = (TYPEOF(le.Input_ims_id))'','',':ims_id')
    #END
 
+    #IF( #TEXT(Input_hce_prfsnl_stat_cd)='' )
      '' 
    #ELSE
        IF( le.Input_hce_prfsnl_stat_cd = (TYPEOF(le.Input_hce_prfsnl_stat_cd))'','',':hce_prfsnl_stat_cd')
    #END
 
+    #IF( #TEXT(Input_hce_prfsnl_stat_desc)='' )
      '' 
    #ELSE
        IF( le.Input_hce_prfsnl_stat_desc = (TYPEOF(le.Input_hce_prfsnl_stat_desc))'','',':hce_prfsnl_stat_desc')
    #END
 
+    #IF( #TEXT(Input_excld_rsn_desc)='' )
      '' 
    #ELSE
        IF( le.Input_excld_rsn_desc = (TYPEOF(le.Input_excld_rsn_desc))'','',':excld_rsn_desc')
    #END
 
+    #IF( #TEXT(Input_npi)='' )
      '' 
    #ELSE
        IF( le.Input_npi = (TYPEOF(le.Input_npi))'','',':npi')
    #END
 
+    #IF( #TEXT(Input_deactv_dt)='' )
      '' 
    #ELSE
        IF( le.Input_deactv_dt = (TYPEOF(le.Input_deactv_dt))'','',':deactv_dt')
    #END
 
+    #IF( #TEXT(Input_cleaned_deactv_dt)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_deactv_dt = (TYPEOF(le.Input_cleaned_deactv_dt))'','',':cleaned_deactv_dt')
    #END
 
+    #IF( #TEXT(Input_xref_hce_id)='' )
      '' 
    #ELSE
        IF( le.Input_xref_hce_id = (TYPEOF(le.Input_xref_hce_id))'','',':xref_hce_id')
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
