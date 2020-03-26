IMPORT ut, FCRA, emerges;

ccw_rec := RECORD
    emerges.layout_ccw_out;
    string20 flag_file_id;
  end;

EXPORT fDeprecate_Fields_CCW(DATASET(ccw_rec) pCCW) := FUNCTION
        
     // DF-24330 - Blank out fields in FCRA file thor_data400::key::override::fcra::concealed_weapons::qa::ffid
     fields_to_clear  := 'ace_fips_st,active_other,active_status,agecat,headhousehold,maiden_name,maiden_prior,' + 
                         'mail_ace_fips_st,mail_ace_zip,mail_addr_suffix,mail_addr1,mail_addr2,mail_cart,' + 
                         'mail_chk_digit,mail_city,mail_county,mail_cr_sort_sz,mail_dpbc,mail_err_stat,' + 
                         'mail_fipscounty,mail_geo_blk,mail_geo_lat,mail_geo_long,mail_geo_match,mail_lot,' + 
                         'mail_lot_order,mail_msa,mail_p_city_name,mail_postdir,mail_predir,mail_prim_name,' + 
                         'mail_prim_range,mail_record_type,mail_sec_range,mail_st,mail_state,mail_unit_desig,' + 
                         'mail_v_city_name,mail_zip,mail_zip4,motorvoterid,occupation,other_phone,phone,' + 
                         'place_of_birth,poliparty,race,record_type,regdate,regsource,res_county,source_voterid,' + 
                         'votefiller,votefiller2,voterstatus,work_phone';
                      
     ut.MAC_CLEAR_FIELDS(pCCW, dBase_FilterFCRA, fields_to_clear);
     dBase := DEDUP(dBase_FilterFCRA);
     
		RETURN(dBase); 

END;	