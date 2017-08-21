d := CrimSrch.File_Crim_Offender2;

layout2 := record
	d.data_type;
	CountGroup := count(group);
	has_ssn := count(group,IF(stringlib.stringfilterout(d.ssn,'0')<>'',100,0));
	has_did := count(group,IF(stringlib.stringfilterout(d.did,'0')<>'',100,0));
end;

layout := record
	d.data_type;
	d.source_file;
	CountGroup := count(group);
	has_process_date := AVE(group,IF(stringlib.stringfilterout(d.process_date,'0')<>'',100,0));
	has_offender_key := AVE(group,IF(stringlib.stringfilterout(d.offender_key,'0')<>'',100,0));
	has_vendor := AVE(group,IF(stringlib.stringfilterout(d.vendor,'0')<>'',100,0));
	has_state_origin := AVE(group,IF(stringlib.stringfilterout(d.state_origin,'0')<>'',100,0));
	has_case_number := AVE(group,IF(stringlib.stringfilterout(d.case_number,'0')<>'',100,0));
	has_case_court := AVE(group,IF(stringlib.stringfilterout(d.case_court,'0')<>'',100,0));
	has_case_name := AVE(group,IF(stringlib.stringfilterout(d.case_name,'0')<>'',100,0));
	has_case_type := AVE(group,IF(stringlib.stringfilterout(d.case_type,'0')<>'',100,0));
	has_case_type_desc := AVE(group,IF(stringlib.stringfilterout(d.case_type_desc,'0')<>'',100,0));
	has_case_filing_dt := AVE(group,IF(stringlib.stringfilterout(d.case_filing_dt,'0')<>'',100,0));
	has_pty_nm := AVE(group,IF(stringlib.stringfilterout(d.pty_nm,'0')<>'',100,0));
	has_pty_nm_fmt := AVE(group,IF(stringlib.stringfilterout(d.pty_nm_fmt,'0')<>'',100,0));
	has_orig_lname := AVE(group,IF(stringlib.stringfilterout(d.orig_lname,'0')<>'',100,0));
	has_orig_fname := AVE(group,IF(stringlib.stringfilterout(d.orig_fname,'0')<>'',100,0));
	has_orig_mname := AVE(group,IF(stringlib.stringfilterout(d.orig_mname,'0')<>'',100,0));
	has_orig_name_suffix := AVE(group,IF(stringlib.stringfilterout(d.orig_name_suffix,'0')<>'',100,0));
	has_pty_typ := AVE(group,IF(stringlib.stringfilterout(d.pty_typ,'0')<>'',100,0));
	has_nitro_flag := AVE(group,IF(stringlib.stringfilterout(d.nitro_flag,'0')<>'',100,0));
	has_orig_ssn := AVE(group,IF(stringlib.stringfilterout(d.orig_ssn,'0')<>'',100,0));
	has_dle_num := AVE(group,IF(stringlib.stringfilterout(d.dle_num,'0')<>'',100,0));
	has_fbi_num := AVE(group,IF(stringlib.stringfilterout(d.fbi_num,'0')<>'',100,0));
	has_doc_num := AVE(group,IF(stringlib.stringfilterout(d.doc_num,'0')<>'',100,0));
	has_ins_num := AVE(group,IF(stringlib.stringfilterout(d.ins_num,'0')<>'',100,0));
	has_id_num := AVE(group,IF(stringlib.stringfilterout(d.id_num,'0')<>'',100,0));
	has_dl_num := AVE(group,IF(stringlib.stringfilterout(d.dl_num,'0')<>'',100,0));
	has_dl_state := AVE(group,IF(stringlib.stringfilterout(d.dl_state,'0')<>'',100,0));
	has_citizenship := AVE(group,IF(stringlib.stringfilterout(d.citizenship,'0')<>'',100,0));
	has_dob := AVE(group,IF(stringlib.stringfilterout(d.dob,'0')<>'',100,0));
	has_dob_alias := AVE(group,IF(stringlib.stringfilterout(d.dob_alias,'0')<>'',100,0));
	has_place_of_birth := AVE(group,IF(stringlib.stringfilterout(d.place_of_birth,'0')<>'',100,0));
	has_street_address_1 := AVE(group,IF(stringlib.stringfilterout(d.street_address_1,'0')<>'',100,0));
	has_street_address_2 := AVE(group,IF(stringlib.stringfilterout(d.street_address_2,'0')<>'',100,0));
	has_street_address_3 := AVE(group,IF(stringlib.stringfilterout(d.street_address_3,'0')<>'',100,0));
	has_street_address_4 := AVE(group,IF(stringlib.stringfilterout(d.street_address_4,'0')<>'',100,0));
	has_street_address_5 := AVE(group,IF(stringlib.stringfilterout(d.street_address_5,'0')<>'',100,0));
	has_race := AVE(group,IF(stringlib.stringfilterout(d.race,'0')<>'',100,0));
	has_race_desc := AVE(group,IF(stringlib.stringfilterout(d.race_desc,'0')<>'',100,0));
	has_sex := AVE(group,IF(stringlib.stringfilterout(d.sex,'0')<>'',100,0));
	has_hair_color := AVE(group,IF(stringlib.stringfilterout(d.hair_color,'0')<>'',100,0));
	has_hair_color_desc := AVE(group,IF(stringlib.stringfilterout(d.hair_color_desc,'0')<>'',100,0));
	has_eye_color := AVE(group,IF(stringlib.stringfilterout(d.eye_color,'0')<>'',100,0));
	has_eye_color_desc := AVE(group,IF(stringlib.stringfilterout(d.eye_color_desc,'0')<>'',100,0));
	has_skin_color := AVE(group,IF(stringlib.stringfilterout(d.skin_color,'0')<>'',100,0));
	has_skin_color_desc := AVE(group,IF(stringlib.stringfilterout(d.skin_color_desc,'0')<>'',100,0));
	has_height := AVE(group,IF(stringlib.stringfilterout(d.height,'0')<>'',100,0));
	has_weight := AVE(group,IF(stringlib.stringfilterout(d.weight,'0')<>'',100,0));
	has_party_status := AVE(group,IF(stringlib.stringfilterout(d.party_status,'0')<>'',100,0));
	has_party_status_desc := AVE(group,IF(stringlib.stringfilterout(d.party_status_desc,'0')<>'',100,0));
	has_prim_range := AVE(group,IF(stringlib.stringfilterout(d.prim_range,'0')<>'',100,0));
	has_predir := AVE(group,IF(stringlib.stringfilterout(d.predir,'0')<>'',100,0));
	has_prim_name := AVE(group,IF(stringlib.stringfilterout(d.prim_name,'0')<>'',100,0));
	has_addr_suffix := AVE(group,IF(stringlib.stringfilterout(d.addr_suffix,'0')<>'',100,0));
	has_postdir := AVE(group,IF(stringlib.stringfilterout(d.postdir,'0')<>'',100,0));
	has_unit_desig := AVE(group,IF(stringlib.stringfilterout(d.unit_desig,'0')<>'',100,0));
	has_sec_range := AVE(group,IF(stringlib.stringfilterout(d.sec_range,'0')<>'',100,0));
	has_p_city_name := AVE(group,IF(stringlib.stringfilterout(d.p_city_name,'0')<>'',100,0));
	has_v_city_name := AVE(group,IF(stringlib.stringfilterout(d.v_city_name,'0')<>'',100,0));
	has_state := AVE(group,IF(stringlib.stringfilterout(d.state,'0')<>'',100,0));
	has_zip5 := AVE(group,IF(stringlib.stringfilterout(d.zip5,'0')<>'',100,0));
	has_zip4 := AVE(group,IF(stringlib.stringfilterout(d.zip4,'0')<>'',100,0));
	has_cart := AVE(group,IF(stringlib.stringfilterout(d.cart,'0')<>'',100,0));
	has_cr_sort_sz := AVE(group,IF(stringlib.stringfilterout(d.cr_sort_sz,'0')<>'',100,0));
	has_lot := AVE(group,IF(stringlib.stringfilterout(d.lot,'0')<>'',100,0));
	has_lot_order := AVE(group,IF(stringlib.stringfilterout(d.lot_order,'0')<>'',100,0));
	has_dpbc := AVE(group,IF(stringlib.stringfilterout(d.dpbc,'0')<>'',100,0));
	has_chk_digit := AVE(group,IF(stringlib.stringfilterout(d.chk_digit,'0')<>'',100,0));
	has_rec_type := AVE(group,IF(stringlib.stringfilterout(d.rec_type,'0')<>'',100,0));
	has_ace_fips_st := AVE(group,IF(stringlib.stringfilterout(d.ace_fips_st,'0')<>'',100,0));
	has_ace_fips_county := AVE(group,IF(stringlib.stringfilterout(d.ace_fips_county,'0')<>'',100,0));
	has_geo_lat := AVE(group,IF(stringlib.stringfilterout(d.geo_lat,'0')<>'',100,0));
	has_geo_long := AVE(group,IF(stringlib.stringfilterout(d.geo_long,'0')<>'',100,0));
	has_msa := AVE(group,IF(stringlib.stringfilterout(d.msa,'0')<>'',100,0));
	has_geo_blk := AVE(group,IF(stringlib.stringfilterout(d.geo_blk,'0')<>'',100,0));
	has_geo_match := AVE(group,IF(stringlib.stringfilterout(d.geo_match,'0')<>'',100,0));
	has_err_stat := AVE(group,IF(stringlib.stringfilterout(d.err_stat,'0')<>'',100,0));
	has_title := AVE(group,IF(stringlib.stringfilterout(d.title,'0')<>'',100,0));
	has_fname := AVE(group,IF(stringlib.stringfilterout(d.fname,'0')<>'',100,0));
	has_mname := AVE(group,IF(stringlib.stringfilterout(d.mname,'0')<>'',100,0));
	has_lname := AVE(group,IF(stringlib.stringfilterout(d.lname,'0')<>'',100,0));
	has_name_suffix := AVE(group,IF(stringlib.stringfilterout(d.name_suffix,'0')<>'',100,0));
	has_cleaning_score := AVE(group,IF(stringlib.stringfilterout(d.cleaning_score,'0')<>'',100,0));
	has_ssn := AVE(group,IF(stringlib.stringfilterout(d.ssn,'0')<>'',100,0));
	has_did := AVE(group,IF(stringlib.stringfilterout(d.did,'0')<>'',100,0));
	has_pgid := AVE(group,IF(stringlib.stringfilterout(d.pgid,'0')<>'',100,0));
end;

dids_all_data := output(sort(table(d
                  ,layout2
				  ,data_type
				  ,few)
            ,data_type)
	   ,named('DIDs_All_Data')
	   ,all);

dids_no_akas := output(sort(table(d(pty_typ = '0')
                  ,layout2
				  ,data_type
				  ,few)
            ,data_type)
	   ,named('DIDs_No_AKAs')
	   ,all);

all_data := output(sort(table(d
                  ,layout
				  ,data_type
				  ,source_file
				  ,few)
            ,data_type
			,source_file)
	   ,named('All_Data')
	   ,all);

no_akas := output(sort(table(d(pty_typ = '0')
                  ,layout
				  ,data_type
				  ,source_file
				  ,few)
            ,data_type
			,source_file)
	   ,named('No_AKAs')
	   ,all);
dids_only := output(sort(table(d(did != '')
                  ,layout
				  ,data_type
				  ,source_file
				  ,few)
            ,data_type
			,source_file)
	   ,named('DIDs_Only')
	   ,all);
sequential(parallel(dids_all_data,dids_no_akas)
           ,parallel(all_data,no_akas,dids_only));
