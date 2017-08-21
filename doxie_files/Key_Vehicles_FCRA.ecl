import doxie_build, doxie, ut;

ds_preprocessed := doxie_build.Vehlic_Decoded;

export Key_Vehicles_FCRA := 
  INDEX (ds_preprocessed, {sseq_no := seq_no}, 
         {
          dt_first_seen, orig_state, source_code, orig_vin, LIEN_COUNTxBG10,
          own_1_fname, own_1_lname, own_1_did, own_1_ssn, 
          own_1_prim_range, own_1_predir, own_1_prim_name, own_1_suffix, own_1_postdir, 
          own_1_unit_desig, own_1_p_city_name, own_1_state_2, own_1_zip5, own_1_zip4, 
          own_2_fname, own_2_lname, own_2_did, own_2_ssn, 
          own_2_prim_range, own_2_predir, own_2_prim_name, own_2_suffix, own_2_postdir, 
          own_2_unit_desig, own_2_p_city_name, own_2_state_2, own_2_zip5, own_2_zip4, 
          reg_1_fname, reg_1_lname, reg_1_did, reg_1_ssn, 
          reg_1_prim_range, reg_1_predir, reg_1_prim_name, reg_1_suffix, reg_1_postdir,
          reg_1_unit_desig, reg_1_p_city_name, reg_1_state_2, reg_1_zip5, reg_1_zip4, 
          reg_2_fname, reg_2_lname, reg_2_did, reg_2_ssn, 
          reg_2_prim_range, reg_2_predir, reg_2_prim_name, reg_2_suffix, reg_2_postdir, 
          reg_2_unit_desig, reg_2_p_city_name, reg_2_state_2, reg_2_zip5, reg_2_zip4, 
					history, Best_Make_Code, Best_Model_Code, Best_Model_Year
         },
         '~thor_data400::key::vehicle::fcra::full_' + doxie.Version_SuperKey);