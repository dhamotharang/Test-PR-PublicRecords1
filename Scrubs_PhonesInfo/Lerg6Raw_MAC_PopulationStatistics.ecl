 
EXPORT Lerg6Raw_MAC_PopulationStatistics(infile,Ref='',Input_lata = '',Input_lata_name = '',Input_status = '',Input_eff_date = '',Input_npa = '',Input_nxx = '',Input_block_id = '',Input_filler1 = '',Input_coc_type = '',Input_ssc = '',Input_dind = '',Input_td_eo = '',Input_td_at = '',Input_portable = '',Input_aocn = '',Input_filler2 = '',Input_ocn = '',Input_loc_name = '',Input_loc = '',Input_loc_state = '',Input_rc_abbre = '',Input_rc_ty = '',Input_line_fr = '',Input_line_to = '',Input_switch = '',Input_sha_indicator = '',Input_filler3 = '',Input_test_line_num = '',Input_test_line_response = '',Input_test_line_exp_date = '',Input_blk_1000_pool = '',Input_rc_lata = '',Input_filler4 = '',Input_creation_date = '',Input_filler5 = '',Input_e_status_date = '',Input_filler6 = '',Input_last_modified_date = '',Input_filler7 = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Phonesinfo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_lata)='' )
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
 
+    #IF( #TEXT(Input_filler7)='' )
      '' 
    #ELSE
        IF( le.Input_filler7 = (TYPEOF(le.Input_filler7))'','',':filler7')
    #END
 
+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
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
