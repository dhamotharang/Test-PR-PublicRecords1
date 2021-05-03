 
EXPORT Lerg6Main_MAC_PopulationStatistics(infile,Ref='',Input_dt_first_reported = '',Input_dt_last_reported = '',Input_dt_start = '',Input_dt_end = '',Input_source = '',Input_lata = '',Input_lata_name = '',Input_status = '',Input_eff_date = '',Input_eff_time = '',Input_npa = '',Input_nxx = '',Input_block_id = '',Input_filler1 = '',Input_coc_type = '',Input_ssc = '',Input_dind = '',Input_td_eo = '',Input_td_at = '',Input_portable = '',Input_aocn = '',Input_filler2 = '',Input_ocn = '',Input_loc_name = '',Input_loc = '',Input_loc_state = '',Input_rc_abbre = '',Input_rc_ty = '',Input_line_fr = '',Input_line_to = '',Input_switch = '',Input_sha_indicator = '',Input_filler3 = '',Input_test_line_num = '',Input_test_line_response = '',Input_test_line_exp_date = '',Input_test_line_exp_time = '',Input_blk_1000_pool = '',Input_rc_lata = '',Input_filler4 = '',Input_creation_date = '',Input_creation_time = '',Input_filler5 = '',Input_e_status_date = '',Input_e_status_time = '',Input_filler6 = '',Input_last_modified_date = '',Input_last_modified_time = '',Input_filler7 = '',Input_is_current = '',Input_os1 = '',Input_os2 = '',Input_os3 = '',Input_os4 = '',Input_os5 = '',Input_os6 = '',Input_os7 = '',Input_os8 = '',Input_os9 = '',Input_os10 = '',Input_os11 = '',Input_os12 = '',Input_os13 = '',Input_os14 = '',Input_os15 = '',Input_os16 = '',Input_os17 = '',Input_os18 = '',Input_os19 = '',Input_os20 = '',Input_os21 = '',Input_os22 = '',Input_os23 = '',Input_os24 = '',Input_os25 = '',Input_notes = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Phonesinfo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_reported = (TYPEOF(le.Input_dt_first_reported))'','',':dt_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_reported = (TYPEOF(le.Input_dt_last_reported))'','',':dt_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_start)='' )
      '' 
    #ELSE
        IF( le.Input_dt_start = (TYPEOF(le.Input_dt_start))'','',':dt_start')
    #END
 
+    #IF( #TEXT(Input_dt_end)='' )
      '' 
    #ELSE
        IF( le.Input_dt_end = (TYPEOF(le.Input_dt_end))'','',':dt_end')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_lata)='' )
      '' 
    #ELSE
        IF( le.Input_lata = (TYPEOF(le.Input_lata))'','',':lata')
    #END
 
+    #IF( #TEXT(Input_lata_name)='' )
      '' 
    #ELSE
        IF( le.Input_lata_name = (TYPEOF(le.Input_lata_name))'','',':lata_name')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_eff_date)='' )
      '' 
    #ELSE
        IF( le.Input_eff_date = (TYPEOF(le.Input_eff_date))'','',':eff_date')
    #END
 
+    #IF( #TEXT(Input_eff_time)='' )
      '' 
    #ELSE
        IF( le.Input_eff_time = (TYPEOF(le.Input_eff_time))'','',':eff_time')
    #END
 
+    #IF( #TEXT(Input_npa)='' )
      '' 
    #ELSE
        IF( le.Input_npa = (TYPEOF(le.Input_npa))'','',':npa')
    #END
 
+    #IF( #TEXT(Input_nxx)='' )
      '' 
    #ELSE
        IF( le.Input_nxx = (TYPEOF(le.Input_nxx))'','',':nxx')
    #END
 
+    #IF( #TEXT(Input_block_id)='' )
      '' 
    #ELSE
        IF( le.Input_block_id = (TYPEOF(le.Input_block_id))'','',':block_id')
    #END
 
+    #IF( #TEXT(Input_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_filler1 = (TYPEOF(le.Input_filler1))'','',':filler1')
    #END
 
+    #IF( #TEXT(Input_coc_type)='' )
      '' 
    #ELSE
        IF( le.Input_coc_type = (TYPEOF(le.Input_coc_type))'','',':coc_type')
    #END
 
+    #IF( #TEXT(Input_ssc)='' )
      '' 
    #ELSE
        IF( le.Input_ssc = (TYPEOF(le.Input_ssc))'','',':ssc')
    #END
 
+    #IF( #TEXT(Input_dind)='' )
      '' 
    #ELSE
        IF( le.Input_dind = (TYPEOF(le.Input_dind))'','',':dind')
    #END
 
+    #IF( #TEXT(Input_td_eo)='' )
      '' 
    #ELSE
        IF( le.Input_td_eo = (TYPEOF(le.Input_td_eo))'','',':td_eo')
    #END
 
+    #IF( #TEXT(Input_td_at)='' )
      '' 
    #ELSE
        IF( le.Input_td_at = (TYPEOF(le.Input_td_at))'','',':td_at')
    #END
 
+    #IF( #TEXT(Input_portable)='' )
      '' 
    #ELSE
        IF( le.Input_portable = (TYPEOF(le.Input_portable))'','',':portable')
    #END
 
+    #IF( #TEXT(Input_aocn)='' )
      '' 
    #ELSE
        IF( le.Input_aocn = (TYPEOF(le.Input_aocn))'','',':aocn')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END
 
+    #IF( #TEXT(Input_ocn)='' )
      '' 
    #ELSE
        IF( le.Input_ocn = (TYPEOF(le.Input_ocn))'','',':ocn')
    #END
 
+    #IF( #TEXT(Input_loc_name)='' )
      '' 
    #ELSE
        IF( le.Input_loc_name = (TYPEOF(le.Input_loc_name))'','',':loc_name')
    #END
 
+    #IF( #TEXT(Input_loc)='' )
      '' 
    #ELSE
        IF( le.Input_loc = (TYPEOF(le.Input_loc))'','',':loc')
    #END
 
+    #IF( #TEXT(Input_loc_state)='' )
      '' 
    #ELSE
        IF( le.Input_loc_state = (TYPEOF(le.Input_loc_state))'','',':loc_state')
    #END
 
+    #IF( #TEXT(Input_rc_abbre)='' )
      '' 
    #ELSE
        IF( le.Input_rc_abbre = (TYPEOF(le.Input_rc_abbre))'','',':rc_abbre')
    #END
 
+    #IF( #TEXT(Input_rc_ty)='' )
      '' 
    #ELSE
        IF( le.Input_rc_ty = (TYPEOF(le.Input_rc_ty))'','',':rc_ty')
    #END
 
+    #IF( #TEXT(Input_line_fr)='' )
      '' 
    #ELSE
        IF( le.Input_line_fr = (TYPEOF(le.Input_line_fr))'','',':line_fr')
    #END
 
+    #IF( #TEXT(Input_line_to)='' )
      '' 
    #ELSE
        IF( le.Input_line_to = (TYPEOF(le.Input_line_to))'','',':line_to')
    #END
 
+    #IF( #TEXT(Input_switch)='' )
      '' 
    #ELSE
        IF( le.Input_switch = (TYPEOF(le.Input_switch))'','',':switch')
    #END
 
+    #IF( #TEXT(Input_sha_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_sha_indicator = (TYPEOF(le.Input_sha_indicator))'','',':sha_indicator')
    #END
 
+    #IF( #TEXT(Input_filler3)='' )
      '' 
    #ELSE
        IF( le.Input_filler3 = (TYPEOF(le.Input_filler3))'','',':filler3')
    #END
 
+    #IF( #TEXT(Input_test_line_num)='' )
      '' 
    #ELSE
        IF( le.Input_test_line_num = (TYPEOF(le.Input_test_line_num))'','',':test_line_num')
    #END
 
+    #IF( #TEXT(Input_test_line_response)='' )
      '' 
    #ELSE
        IF( le.Input_test_line_response = (TYPEOF(le.Input_test_line_response))'','',':test_line_response')
    #END
 
+    #IF( #TEXT(Input_test_line_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_test_line_exp_date = (TYPEOF(le.Input_test_line_exp_date))'','',':test_line_exp_date')
    #END
 
+    #IF( #TEXT(Input_test_line_exp_time)='' )
      '' 
    #ELSE
        IF( le.Input_test_line_exp_time = (TYPEOF(le.Input_test_line_exp_time))'','',':test_line_exp_time')
    #END
 
+    #IF( #TEXT(Input_blk_1000_pool)='' )
      '' 
    #ELSE
        IF( le.Input_blk_1000_pool = (TYPEOF(le.Input_blk_1000_pool))'','',':blk_1000_pool')
    #END
 
+    #IF( #TEXT(Input_rc_lata)='' )
      '' 
    #ELSE
        IF( le.Input_rc_lata = (TYPEOF(le.Input_rc_lata))'','',':rc_lata')
    #END
 
+    #IF( #TEXT(Input_filler4)='' )
      '' 
    #ELSE
        IF( le.Input_filler4 = (TYPEOF(le.Input_filler4))'','',':filler4')
    #END
 
+    #IF( #TEXT(Input_creation_date)='' )
      '' 
    #ELSE
        IF( le.Input_creation_date = (TYPEOF(le.Input_creation_date))'','',':creation_date')
    #END
 
+    #IF( #TEXT(Input_creation_time)='' )
      '' 
    #ELSE
        IF( le.Input_creation_time = (TYPEOF(le.Input_creation_time))'','',':creation_time')
    #END
 
+    #IF( #TEXT(Input_filler5)='' )
      '' 
    #ELSE
        IF( le.Input_filler5 = (TYPEOF(le.Input_filler5))'','',':filler5')
    #END
 
+    #IF( #TEXT(Input_e_status_date)='' )
      '' 
    #ELSE
        IF( le.Input_e_status_date = (TYPEOF(le.Input_e_status_date))'','',':e_status_date')
    #END
 
+    #IF( #TEXT(Input_e_status_time)='' )
      '' 
    #ELSE
        IF( le.Input_e_status_time = (TYPEOF(le.Input_e_status_time))'','',':e_status_time')
    #END
 
+    #IF( #TEXT(Input_filler6)='' )
      '' 
    #ELSE
        IF( le.Input_filler6 = (TYPEOF(le.Input_filler6))'','',':filler6')
    #END
 
+    #IF( #TEXT(Input_last_modified_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_modified_date = (TYPEOF(le.Input_last_modified_date))'','',':last_modified_date')
    #END
 
+    #IF( #TEXT(Input_last_modified_time)='' )
      '' 
    #ELSE
        IF( le.Input_last_modified_time = (TYPEOF(le.Input_last_modified_time))'','',':last_modified_time')
    #END
 
+    #IF( #TEXT(Input_filler7)='' )
      '' 
    #ELSE
        IF( le.Input_filler7 = (TYPEOF(le.Input_filler7))'','',':filler7')
    #END
 
+    #IF( #TEXT(Input_is_current)='' )
      '' 
    #ELSE
        IF( le.Input_is_current = (TYPEOF(le.Input_is_current))'','',':is_current')
    #END
 
+    #IF( #TEXT(Input_os1)='' )
      '' 
    #ELSE
        IF( le.Input_os1 = (TYPEOF(le.Input_os1))'','',':os1')
    #END
 
+    #IF( #TEXT(Input_os2)='' )
      '' 
    #ELSE
        IF( le.Input_os2 = (TYPEOF(le.Input_os2))'','',':os2')
    #END
 
+    #IF( #TEXT(Input_os3)='' )
      '' 
    #ELSE
        IF( le.Input_os3 = (TYPEOF(le.Input_os3))'','',':os3')
    #END
 
+    #IF( #TEXT(Input_os4)='' )
      '' 
    #ELSE
        IF( le.Input_os4 = (TYPEOF(le.Input_os4))'','',':os4')
    #END
 
+    #IF( #TEXT(Input_os5)='' )
      '' 
    #ELSE
        IF( le.Input_os5 = (TYPEOF(le.Input_os5))'','',':os5')
    #END
 
+    #IF( #TEXT(Input_os6)='' )
      '' 
    #ELSE
        IF( le.Input_os6 = (TYPEOF(le.Input_os6))'','',':os6')
    #END
 
+    #IF( #TEXT(Input_os7)='' )
      '' 
    #ELSE
        IF( le.Input_os7 = (TYPEOF(le.Input_os7))'','',':os7')
    #END
 
+    #IF( #TEXT(Input_os8)='' )
      '' 
    #ELSE
        IF( le.Input_os8 = (TYPEOF(le.Input_os8))'','',':os8')
    #END
 
+    #IF( #TEXT(Input_os9)='' )
      '' 
    #ELSE
        IF( le.Input_os9 = (TYPEOF(le.Input_os9))'','',':os9')
    #END
 
+    #IF( #TEXT(Input_os10)='' )
      '' 
    #ELSE
        IF( le.Input_os10 = (TYPEOF(le.Input_os10))'','',':os10')
    #END
 
+    #IF( #TEXT(Input_os11)='' )
      '' 
    #ELSE
        IF( le.Input_os11 = (TYPEOF(le.Input_os11))'','',':os11')
    #END
 
+    #IF( #TEXT(Input_os12)='' )
      '' 
    #ELSE
        IF( le.Input_os12 = (TYPEOF(le.Input_os12))'','',':os12')
    #END
 
+    #IF( #TEXT(Input_os13)='' )
      '' 
    #ELSE
        IF( le.Input_os13 = (TYPEOF(le.Input_os13))'','',':os13')
    #END
 
+    #IF( #TEXT(Input_os14)='' )
      '' 
    #ELSE
        IF( le.Input_os14 = (TYPEOF(le.Input_os14))'','',':os14')
    #END
 
+    #IF( #TEXT(Input_os15)='' )
      '' 
    #ELSE
        IF( le.Input_os15 = (TYPEOF(le.Input_os15))'','',':os15')
    #END
 
+    #IF( #TEXT(Input_os16)='' )
      '' 
    #ELSE
        IF( le.Input_os16 = (TYPEOF(le.Input_os16))'','',':os16')
    #END
 
+    #IF( #TEXT(Input_os17)='' )
      '' 
    #ELSE
        IF( le.Input_os17 = (TYPEOF(le.Input_os17))'','',':os17')
    #END
 
+    #IF( #TEXT(Input_os18)='' )
      '' 
    #ELSE
        IF( le.Input_os18 = (TYPEOF(le.Input_os18))'','',':os18')
    #END
 
+    #IF( #TEXT(Input_os19)='' )
      '' 
    #ELSE
        IF( le.Input_os19 = (TYPEOF(le.Input_os19))'','',':os19')
    #END
 
+    #IF( #TEXT(Input_os20)='' )
      '' 
    #ELSE
        IF( le.Input_os20 = (TYPEOF(le.Input_os20))'','',':os20')
    #END
 
+    #IF( #TEXT(Input_os21)='' )
      '' 
    #ELSE
        IF( le.Input_os21 = (TYPEOF(le.Input_os21))'','',':os21')
    #END
 
+    #IF( #TEXT(Input_os22)='' )
      '' 
    #ELSE
        IF( le.Input_os22 = (TYPEOF(le.Input_os22))'','',':os22')
    #END
 
+    #IF( #TEXT(Input_os23)='' )
      '' 
    #ELSE
        IF( le.Input_os23 = (TYPEOF(le.Input_os23))'','',':os23')
    #END
 
+    #IF( #TEXT(Input_os24)='' )
      '' 
    #ELSE
        IF( le.Input_os24 = (TYPEOF(le.Input_os24))'','',':os24')
    #END
 
+    #IF( #TEXT(Input_os25)='' )
      '' 
    #ELSE
        IF( le.Input_os25 = (TYPEOF(le.Input_os25))'','',':os25')
    #END
 
+    #IF( #TEXT(Input_notes)='' )
      '' 
    #ELSE
        IF( le.Input_notes = (TYPEOF(le.Input_notes))'','',':notes')
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
