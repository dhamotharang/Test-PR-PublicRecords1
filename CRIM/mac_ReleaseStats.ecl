export mac_ReleaseStats(infile1,infile2,filetype,updateFreq,outfile) := macro

#uniquename(layout_popstats_infile1)
#uniquename(source_file)
#uniquename(countOfoffenders)
#uniquename(vendor)

#uniquename(has_process_date)
#uniquename(has_offender_key)
#uniquename(has_vendor)
#uniquename(has_state_origin)
#uniquename(has_data_type)
#uniquename(has_source_file)
#uniquename(has_case_number)
#uniquename(has_case_court)
#uniquename(has_case_name)
#uniquename(has_case_type)
#uniquename(has_case_type_desc)
#uniquename(has_case_filing_dt)
#uniquename(has_pty_nm)
#uniquename(has_pty_nm_fmt)
#uniquename(has_orig_lname)
#uniquename(has_orig_fname)
#uniquename(has_orig_mname)
#uniquename(has_orig_name_suffix)
#uniquename(has_pty_typ)
#uniquename(has_nitro_flag)
#uniquename(has_orig_ssn)
#uniquename(has_dle_num)
#uniquename(has_fbi_num)
#uniquename(has_doc_num)
#uniquename(has_ins_num)
#uniquename(has_id_num)
#uniquename(has_dl_num)
#uniquename(has_dl_state)
#uniquename(has_citizenship)
#uniquename(has_dob)
#uniquename(has_dob_alias)
#uniquename(has_place_of_birth)
#uniquename(has_street_address_1)
#uniquename(has_street_address_2)
#uniquename(has_street_address_3)
#uniquename(has_street_address_4)
#uniquename(has_street_address_5)
#uniquename(has_race)
#uniquename(has_race_desc)
#uniquename(has_sex)
#uniquename(has_hair_color)
#uniquename(has_hair_color_desc)
#uniquename(has_eye_color)
#uniquename(has_eye_color_desc)
#uniquename(has_skin_color)
#uniquename(has_skin_color_desc)
#uniquename(has_height)
#uniquename(has_weight)
#uniquename(has_party_status)
#uniquename(has_party_status_desc)
#uniquename(has_prim_range)
#uniquename(has_predir)
#uniquename(has_prim_name)
#uniquename(has_addr_suffix)
#uniquename(has_postdir)
#uniquename(has_unit_desig)
#uniquename(has_sec_range)
#uniquename(has_p_city_name)
#uniquename(has_v_city_name)
#uniquename(has_state)
#uniquename(has_zip5)
#uniquename(has_zip4)
#uniquename(has_cart)
#uniquename(has_cr_sort_sz)
#uniquename(has_lot)
#uniquename(has_lot_order)
#uniquename(has_dpbc)
#uniquename(has_chk_digit)
#uniquename(has_rec_type)
#uniquename(has_ace_fips_st)
#uniquename(has_ace_fips_county)
#uniquename(has_geo_lat)
#uniquename(has_geo_long)
#uniquename(has_msa)
#uniquename(has_geo_blk)
#uniquename(has_geo_match)
#uniquename(has_err_stat)
#uniquename(has_title)
#uniquename(has_fname)
#uniquename(has_mname)
#uniquename(has_lname)
#uniquename(has_name_suffix)
#uniquename(has_cleaning_score)

#uniquename(popstats1)


%layout_popstats_infile1% :=  record

%source_file%        := infile1.source_file;
%vendor%			 := infile1.vendor;
%countOfoffenders%   := count(group);

%has_process_date% := AVE(group,IF(stringlib.stringfilterout(infile1.process_date,'0')<>'',100,0));
%has_offender_key% := AVE(group,IF(stringlib.stringfilterout(infile1.offender_key,'0')<>'',100,0));
%has_vendor% := AVE(group,IF(stringlib.stringfilterout(infile1.vendor,'0')<>'',100,0));
%has_state_origin% := AVE(group,IF(stringlib.stringfilterout(infile1.state_origin,'0')<>'',100,0));
%has_data_type% := AVE(group,IF(stringlib.stringfilterout(infile1.data_type,'0')<>'',100,0));
%has_source_file% := AVE(group,IF(stringlib.stringfilterout(infile1.source_file,'0')<>'',100,0));
%has_case_number% := AVE(group,IF(stringlib.stringfilterout(infile1.case_number,'0')<>'',100,0));
%has_case_court% := AVE(group,IF(stringlib.stringfilterout(infile1.case_court,'0')<>'',100,0));
%has_case_name% := AVE(group,IF(stringlib.stringfilterout(infile1.case_name,'0')<>'',100,0));
%has_case_type% := AVE(group,IF(stringlib.stringfilterout(infile1.case_type,'0')<>'',100,0));
%has_case_type_desc% := AVE(group,IF(stringlib.stringfilterout(infile1.case_type_desc,'0')<>'',100,0));
%has_case_filing_dt% := AVE(group,IF(stringlib.stringfilterout(infile1.case_filing_dt,'0')<>'',100,0));
%has_pty_nm% := AVE(group,IF(stringlib.stringfilterout(infile1.pty_nm,'0')<>'',100,0));
%has_pty_nm_fmt% := AVE(group,IF(stringlib.stringfilterout(infile1.pty_nm_fmt,'0')<>'',100,0));
%has_orig_lname% := AVE(group,IF(stringlib.stringfilterout(infile1.orig_lname,'0')<>'',100,0));
%has_orig_fname% := AVE(group,IF(stringlib.stringfilterout(infile1.orig_fname,'0')<>'',100,0));
%has_orig_mname% := AVE(group,IF(stringlib.stringfilterout(infile1.orig_mname,'0')<>'',100,0));
%has_orig_name_suffix% := AVE(group,IF(stringlib.stringfilterout(infile1.orig_name_suffix,'0')<>'',100,0));
%has_pty_typ% := AVE(group,IF(stringlib.stringfilterout(infile1.pty_typ,'0')<>'',100,0));
%has_nitro_flag% := AVE(group,IF(stringlib.stringfilterout(infile1.nitro_flag,'0')<>'',100,0));
%has_orig_ssn% := AVE(group,IF(stringlib.stringfilterout(infile1.orig_ssn,'0')<>'',100,0));
%has_dle_num% := AVE(group,IF(stringlib.stringfilterout(infile1.dle_num,'0')<>'',100,0));
%has_fbi_num% := AVE(group,IF(stringlib.stringfilterout(infile1.fbi_num,'0')<>'',100,0));
%has_doc_num% := AVE(group,IF(stringlib.stringfilterout(infile1.doc_num,'0')<>'',100,0));
%has_ins_num% := AVE(group,IF(stringlib.stringfilterout(infile1.ins_num,'0')<>'',100,0));
%has_id_num% := AVE(group,IF(stringlib.stringfilterout(infile1.id_num,'0')<>'',100,0));
%has_dl_num% := AVE(group,IF(stringlib.stringfilterout(infile1.dl_num,'0')<>'',100,0));
%has_dl_state% := AVE(group,IF(stringlib.stringfilterout(infile1.dl_state,'0')<>'',100,0));
%has_citizenship% := AVE(group,IF(stringlib.stringfilterout(infile1.citizenship,'0')<>'',100,0));
%has_dob% := AVE(group,IF(stringlib.stringfilterout(infile1.dob,'0')<>'',100,0));
%has_dob_alias% := AVE(group,IF(stringlib.stringfilterout(infile1.dob_alias,'0')<>'',100,0));
%has_place_of_birth% := AVE(group,IF(stringlib.stringfilterout(infile1.place_of_birth,'0')<>'',100,0));
%has_street_address_1% := AVE(group,IF(stringlib.stringfilterout(infile1.street_address_1,'0')<>'',100,0));
%has_street_address_2% := AVE(group,IF(stringlib.stringfilterout(infile1.street_address_2,'0')<>'',100,0));
%has_street_address_3% := AVE(group,IF(stringlib.stringfilterout(infile1.street_address_3,'0')<>'',100,0));
%has_street_address_4% := AVE(group,IF(stringlib.stringfilterout(infile1.street_address_4,'0')<>'',100,0));
%has_street_address_5% := AVE(group,IF(stringlib.stringfilterout(infile1.street_address_5,'0')<>'',100,0));
%has_race% := AVE(group,IF(stringlib.stringfilterout(infile1.race,'0')<>'',100,0));
%has_race_desc% := AVE(group,IF(stringlib.stringfilterout(infile1.race_desc,'0')<>'',100,0));
%has_sex% := AVE(group,IF(stringlib.stringfilterout(infile1.sex,'0')<>'',100,0));
%has_hair_color% := AVE(group,IF(stringlib.stringfilterout(infile1.hair_color,'0')<>'',100,0));
%has_hair_color_desc% := AVE(group,IF(stringlib.stringfilterout(infile1.hair_color_desc,'0')<>'',100,0));
%has_eye_color% := AVE(group,IF(stringlib.stringfilterout(infile1.eye_color,'0')<>'',100,0));
%has_eye_color_desc% := AVE(group,IF(stringlib.stringfilterout(infile1.eye_color_desc,'0')<>'',100,0));
%has_skin_color% := AVE(group,IF(stringlib.stringfilterout(infile1.skin_color,'0')<>'',100,0));
%has_skin_color_desc% := AVE(group,IF(stringlib.stringfilterout(infile1.skin_color_desc,'0')<>'',100,0));
%has_height% := AVE(group,IF(stringlib.stringfilterout(infile1.height,'0')<>'',100,0));
%has_weight% := AVE(group,IF(stringlib.stringfilterout(infile1.weight,'0')<>'',100,0));
%has_party_status% := AVE(group,IF(stringlib.stringfilterout(infile1.party_status,'0')<>'',100,0));
%has_party_status_desc% := AVE(group,IF(stringlib.stringfilterout(infile1.party_status_desc,'0')<>'',100,0));
%has_prim_range% := AVE(group,IF(stringlib.stringfilterout(infile1.prim_range,'0')<>'',100,0));
%has_predir% := AVE(group,IF(stringlib.stringfilterout(infile1.predir,'0')<>'',100,0));
%has_prim_name% := AVE(group,IF(stringlib.stringfilterout(infile1.prim_name,'0')<>'',100,0));
%has_addr_suffix% := AVE(group,IF(stringlib.stringfilterout(infile1.addr_suffix,'0')<>'',100,0));
%has_postdir% := AVE(group,IF(stringlib.stringfilterout(infile1.postdir,'0')<>'',100,0));
%has_unit_desig% := AVE(group,IF(stringlib.stringfilterout(infile1.unit_desig,'0')<>'',100,0));
%has_sec_range% := AVE(group,IF(stringlib.stringfilterout(infile1.sec_range,'0')<>'',100,0));
%has_p_city_name% := AVE(group,IF(stringlib.stringfilterout(infile1.p_city_name,'0')<>'',100,0));
%has_v_city_name% := AVE(group,IF(stringlib.stringfilterout(infile1.v_city_name,'0')<>'',100,0));
%has_state% := AVE(group,IF(stringlib.stringfilterout(infile1.state,'0')<>'',100,0));
%has_zip5% := AVE(group,IF(stringlib.stringfilterout(infile1.zip5,'0')<>'',100,0));
%has_zip4% := AVE(group,IF(stringlib.stringfilterout(infile1.zip4,'0')<>'',100,0));
%has_cart% := AVE(group,IF(stringlib.stringfilterout(infile1.cart,'0')<>'',100,0));
%has_cr_sort_sz% := AVE(group,IF(stringlib.stringfilterout(infile1.cr_sort_sz,'0')<>'',100,0));
%has_lot% := AVE(group,IF(stringlib.stringfilterout(infile1.lot,'0')<>'',100,0));
%has_lot_order% := AVE(group,IF(stringlib.stringfilterout(infile1.lot_order,'0')<>'',100,0));
%has_dpbc% := AVE(group,IF(stringlib.stringfilterout(infile1.dpbc,'0')<>'',100,0));
%has_chk_digit% := AVE(group,IF(stringlib.stringfilterout(infile1.chk_digit,'0')<>'',100,0));
%has_rec_type% := AVE(group,IF(stringlib.stringfilterout(infile1.rec_type,'0')<>'',100,0));
%has_ace_fips_st% := AVE(group,IF(stringlib.stringfilterout(infile1.ace_fips_st,'0')<>'',100,0));
%has_ace_fips_county% := AVE(group,IF(stringlib.stringfilterout(infile1.ace_fips_county,'0')<>'',100,0));
%has_geo_lat% := AVE(group,IF(stringlib.stringfilterout(infile1.geo_lat,'0')<>'',100,0));
%has_geo_long% := AVE(group,IF(stringlib.stringfilterout(infile1.geo_long,'0')<>'',100,0));
%has_msa% := AVE(group,IF(stringlib.stringfilterout(infile1.msa,'0')<>'',100,0));
%has_geo_blk% := AVE(group,IF(stringlib.stringfilterout(infile1.geo_blk,'0')<>'',100,0));
%has_geo_match% := AVE(group,IF(stringlib.stringfilterout(infile1.geo_match,'0')<>'',100,0));
%has_err_stat% := AVE(group,IF(stringlib.stringfilterout(infile1.err_stat,'0')<>'',100,0));
%has_title% := AVE(group,IF(stringlib.stringfilterout(infile1.title,'0')<>'',100,0));
%has_fname% := AVE(group,IF(stringlib.stringfilterout(infile1.fname,'0')<>'',100,0));
%has_mname% := AVE(group,IF(stringlib.stringfilterout(infile1.mname,'0')<>'',100,0));
%has_lname% := AVE(group,IF(stringlib.stringfilterout(infile1.lname,'0')<>'',100,0));
%has_name_suffix% := AVE(group,IF(stringlib.stringfilterout(infile1.name_suffix,'0')<>'',100,0));
%has_cleaning_score% := AVE(group,IF(stringlib.stringfilterout(infile1.cleaning_score,'0')<>'',100,0));


end;

%popstats1% := table(infile1,%layout_popstats_infile1%,few);


#uniquename(layout_popstats_infile2)
#uniquename(countOfoffenses)

#uniquename(has_off_comp)
#uniquename(has_off_delete_flag)
#uniquename(has_off_date)
#uniquename(has_arr_date)
#uniquename(has_num_of_counts)
#uniquename(has_le_agency_cd)
#uniquename(has_le_agency_desc)
#uniquename(has_le_agency_case_number)
#uniquename(has_traffic_ticket_number)
#uniquename(has_traffic_dl_no)
#uniquename(has_traffic_dl_st)
#uniquename(has_arr_off_code)
#uniquename(has_arr_off_desc_1)
#uniquename(has_arr_off_desc_2)
#uniquename(has_arr_off_type_cd)
#uniquename(has_arr_off_type_desc)
#uniquename(has_arr_off_lev)
#uniquename(has_arr_statute)
#uniquename(has_arr_statute_desc)
#uniquename(has_arr_disp_date)
#uniquename(has_arr_disp_code)
#uniquename(has_arr_disp_desc_1)
#uniquename(has_arr_disp_desc_2)
#uniquename(has_pros_refer_cd)
#uniquename(has_pros_refer)
#uniquename(has_pros_assgn_cd)
#uniquename(has_pros_assgn)
#uniquename(has_pros_chg_rej)
#uniquename(has_pros_off_code)
#uniquename(has_pros_off_desc_1)
#uniquename(has_pros_off_desc_2)
#uniquename(has_pros_off_type_cd)
#uniquename(has_pros_off_type_desc)
#uniquename(has_pros_off_lev)
#uniquename(has_pros_act_filed)
#uniquename(has_court_case_number)
#uniquename(has_court_cd)
#uniquename(has_court_desc)
#uniquename(has_court_appeal_flag)
#uniquename(has_court_final_plea)
#uniquename(has_court_off_code)
#uniquename(has_court_off_desc_1)
#uniquename(has_court_off_desc_2)
#uniquename(has_court_off_type_cd)
#uniquename(has_court_off_type_desc)
#uniquename(has_court_off_lev)
#uniquename(has_court_statute)
#uniquename(has_court_additional_statutes)
#uniquename(has_court_statute_desc)
#uniquename(has_court_disp_date)
#uniquename(has_court_disp_code)
#uniquename(has_court_disp_desc_1)
#uniquename(has_court_disp_desc_2)
#uniquename(has_sent_date)
#uniquename(has_sent_jail)
#uniquename(has_sent_susp_time)
#uniquename(has_sent_court_cost)
#uniquename(has_sent_court_fine)
#uniquename(has_sent_susp_court_fine)
#uniquename(has_sent_probation)
#uniquename(has_sent_addl_prov_code)
#uniquename(has_sent_addl_prov_desc_1)
#uniquename(has_sent_addl_prov_desc_2)
#uniquename(has_sent_consec)
#uniquename(has_sent_agency_rec_cust_ori)
#uniquename(has_sent_agency_rec_cust)
#uniquename(has_appeal_date)
#uniquename(has_appeal_off_disp)
#uniquename(has_appeal_final_decision)

#uniquename(popstats2)


%layout_popstats_infile2% :=  record 

%countOfoffenses% := count(group);

%has_off_comp% := AVE(group,IF(stringlib.stringfilterout(infile2.off_comp,'0')<>'',100,0));
%has_off_delete_flag% := AVE(group,IF(stringlib.stringfilterout(infile2.off_delete_flag,'0')<>'',100,0));
%has_off_date% := AVE(group,IF(stringlib.stringfilterout(infile2.off_date,'0')<>'',100,0));
%has_arr_date% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_date,'0')<>'',100,0));
%has_num_of_counts% := AVE(group,IF(stringlib.stringfilterout(infile2.num_of_counts,'0')<>'',100,0));
%has_le_agency_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.le_agency_cd,'0')<>'',100,0));
%has_le_agency_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.le_agency_desc,'0')<>'',100,0));
%has_le_agency_case_number% := AVE(group,IF(stringlib.stringfilterout(infile2.le_agency_case_number,'0')<>'',100,0));
%has_traffic_ticket_number% := AVE(group,IF(stringlib.stringfilterout(infile2.traffic_ticket_number,'0')<>'',100,0));
%has_traffic_dl_no% := AVE(group,IF(stringlib.stringfilterout(infile2.traffic_dl_no,'0')<>'',100,0));
%has_traffic_dl_st% := AVE(group,IF(stringlib.stringfilterout(infile2.traffic_dl_st,'0')<>'',100,0));
%has_arr_off_code% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_off_code,'0')<>'',100,0));
%has_arr_off_desc_1% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_off_desc_1,'0')<>'',100,0));
%has_arr_off_desc_2% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_off_desc_2,'0')<>'',100,0));
%has_arr_off_type_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_off_type_cd,'0')<>'',100,0));
%has_arr_off_type_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_off_type_desc,'0')<>'',100,0));
%has_arr_off_lev% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_off_lev,'0')<>'',100,0));
%has_arr_statute% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_statute,'0')<>'',100,0));
%has_arr_statute_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_statute_desc,'0')<>'',100,0));
%has_arr_disp_date% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_disp_date,'0')<>'',100,0));
%has_arr_disp_code% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_disp_code,'0')<>'',100,0));
%has_arr_disp_desc_1% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_disp_desc_1,'0')<>'',100,0));
%has_arr_disp_desc_2% := AVE(group,IF(stringlib.stringfilterout(infile2.arr_disp_desc_2,'0')<>'',100,0));
%has_pros_refer_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_refer_cd,'0')<>'',100,0));
%has_pros_refer% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_refer,'0')<>'',100,0));
%has_pros_assgn_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_assgn_cd,'0')<>'',100,0));
%has_pros_assgn% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_assgn,'0')<>'',100,0));
%has_pros_chg_rej% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_chg_rej,'0')<>'',100,0));
%has_pros_off_code% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_off_code,'0')<>'',100,0));
%has_pros_off_desc_1% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_off_desc_1,'0')<>'',100,0));
%has_pros_off_desc_2% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_off_desc_2,'0')<>'',100,0));
%has_pros_off_type_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_off_type_cd,'0')<>'',100,0));
%has_pros_off_type_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_off_type_desc,'0')<>'',100,0));
%has_pros_off_lev% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_off_lev,'0')<>'',100,0));
%has_pros_act_filed% := AVE(group,IF(stringlib.stringfilterout(infile2.pros_act_filed,'0')<>'',100,0));
%has_court_case_number% := AVE(group,IF(stringlib.stringfilterout(infile2.court_case_number,'0')<>'',100,0));
%has_court_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.court_cd,'0')<>'',100,0));
%has_court_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.court_desc,'0')<>'',100,0));
%has_court_appeal_flag% := AVE(group,IF(stringlib.stringfilterout(infile2.court_appeal_flag,'0')<>'',100,0));
%has_court_final_plea% := AVE(group,IF(stringlib.stringfilterout(infile2.court_final_plea,'0')<>'',100,0));
%has_court_off_code% := AVE(group,IF(stringlib.stringfilterout(infile2.court_off_code,'0')<>'',100,0));
%has_court_off_desc_1% := AVE(group,IF(stringlib.stringfilterout(infile2.court_off_desc_1,'0')<>'',100,0));
%has_court_off_desc_2% := AVE(group,IF(stringlib.stringfilterout(infile2.court_off_desc_2,'0')<>'',100,0));
%has_court_off_type_cd% := AVE(group,IF(stringlib.stringfilterout(infile2.court_off_type_cd,'0')<>'',100,0));
%has_court_off_type_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.court_off_type_desc,'0')<>'',100,0));
%has_court_off_lev% := AVE(group,IF(stringlib.stringfilterout(infile2.court_off_lev,'0')<>'',100,0));
%has_court_statute% := AVE(group,IF(stringlib.stringfilterout(infile2.court_statute,'0')<>'',100,0));
%has_court_additional_statutes% := AVE(group,IF(stringlib.stringfilterout(infile2.court_additional_statutes,'0')<>'',100,0));
%has_court_statute_desc% := AVE(group,IF(stringlib.stringfilterout(infile2.court_statute_desc,'0')<>'',100,0));
%has_court_disp_date% := AVE(group,IF(stringlib.stringfilterout(infile2.court_disp_date,'0')<>'',100,0));
%has_court_disp_code% := AVE(group,IF(stringlib.stringfilterout(infile2.court_disp_code,'0')<>'',100,0));
%has_court_disp_desc_1% := AVE(group,IF(stringlib.stringfilterout(infile2.court_disp_desc_1,'0')<>'',100,0));
%has_court_disp_desc_2% := AVE(group,IF(stringlib.stringfilterout(infile2.court_disp_desc_2,'0')<>'',100,0));
%has_sent_date% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_date,'0')<>'',100,0));
%has_sent_jail% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_jail,'0')<>'',100,0));
%has_sent_susp_time% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_susp_time,'0')<>'',100,0));
%has_sent_court_cost% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_court_cost,'0')<>'',100,0));
%has_sent_court_fine% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_court_fine,'0')<>'',100,0));
%has_sent_susp_court_fine% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_susp_court_fine,'0')<>'',100,0));
%has_sent_probation% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_probation,'0')<>'',100,0));
%has_sent_addl_prov_code% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_addl_prov_code,'0')<>'',100,0));
%has_sent_addl_prov_desc_1% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_addl_prov_desc_1,'0')<>'',100,0));
%has_sent_addl_prov_desc_2% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_addl_prov_desc_2,'0')<>'',100,0));
%has_sent_consec% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_consec,'0')<>'',100,0));
%has_sent_agency_rec_cust_ori% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_agency_rec_cust_ori,'0')<>'',100,0));
%has_sent_agency_rec_cust% := AVE(group,IF(stringlib.stringfilterout(infile2.sent_agency_rec_cust,'0')<>'',100,0));
%has_appeal_date% := AVE(group,IF(stringlib.stringfilterout(infile2.appeal_date,'0')<>'',100,0));
%has_appeal_off_disp% := AVE(group,IF(stringlib.stringfilterout(infile2.appeal_off_disp,'0')<>'',100,0));
%has_appeal_final_decision% := AVE(group,IF(stringlib.stringfilterout(infile2.appeal_final_decision,'0')<>'',100,0));

end;

%popstats2% := table(infile2,%layout_popstats_infile2%,few);


//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_caseType)
#uniquename(tblcasetype)

%layout_caseType% := record
infile1.case_type;
total:= count(group);
end;

%tblcasetype% := sort(table(infile1,%layout_caseType%,case_type,few),case_type);

//////////////////////////////////////////////////////////////////////////////
//COVERAGE DATES
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_casefilingdt)
#uniquename(tblcase_filing_dt)

%layout_casefilingdt%:= record
infile1.case_filing_dt;
total:= count(group);
end;

%tblcase_filing_dt% := sort(table(infile1,%layout_casefilingdt%,case_filing_dt,few),case_filing_dt);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_crtDispdt)
#uniquename(tblcourt_disp_date)

%layout_crtDispdt%:= record
infile2.court_disp_date;
total:= count(group);
end;


%tblcourt_disp_date% := sort(table(infile2,%layout_crtDispdt%,court_disp_date,few),court_disp_date);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_sntdt)
#uniquename(tblsent_date)

%layout_sntdt%:= record
infile2.sent_date;
total:= count(group);
end;

%tblsent_date% := sort(table(infile2,%layout_sntdt%,sent_date,few),sent_date);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_arrdt)
#uniquename(tblarr_date)

%layout_arrdt%:= record
infile2.arr_date;
total:= count(group);
end;

%tblarr_date% := sort(table(infile2,%layout_arrdt%,arr_date,few),arr_date);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_arrdispdt)
#uniquename(tblarr_disp_date)

%layout_arrdispdt%:= record
infile2.arr_disp_date;
total:= count(group);
end;

%tblarr_disp_date% := sort(table(infile2,%layout_arrdispdt%,arr_disp_date,few),arr_disp_date);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_offdt)
#uniquename(tbloff_date)

%layout_offdt%:= record
infile2.off_date;
total:= count(group);
end;

%tbloff_date% := sort(table(infile2,%layout_offdt%,off_date,few),off_date);

//////////////////////////////////////////////////////////////////////////////
//ARREST LOGS
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_arrofnsLev)
#uniquename(tblarrofflev)

%layout_arrofnsLev%:= record
infile2.arr_off_lev;
total:= count(group);
end;

%tblarrofflev% := sort(table(infile2,%layout_arrofnsLev%,arr_off_lev,few),arr_off_lev);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_arrOfns)
#uniquename(tblarroffdesc1)

%layout_arrOfns%:= record
infile2.arr_off_desc_1;
total:= count(group);
end;

%tblarroffdesc1% := sort(table(infile2,%layout_arrOfns%,arr_off_desc_1,few),arr_off_desc_1);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_arrdisp)
#uniquename(tblarrdispdesc1)

%layout_arrdisp%:= record
infile2.arr_disp_desc_1;
total:= count(group);
end;

%tblarrdispdesc1% := sort(table(infile2,%layout_arrdisp%,arr_disp_desc_1,few),arr_disp_desc_1);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_arrstatute)
#uniquename(tblarrstatute)

%layout_arrstatute%:= record
infile2.arr_statute_desc;
total:= count(group);
end;

%tblarrstatute% := sort(table(infile2,%layout_arrstatute%,arr_statute_desc,few),arr_statute_desc);


//////////////////////////////////////////////////////////////////////////////
//CRIMINAL CRT & FCRA CRIMINAL
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_crtofnsLev)
#uniquename(tblcrtofflev)

%layout_crtofnsLev%:= record
infile2.court_off_lev;
total:= count(group);
end;

%tblcrtofflev% := sort(table(infile2,%layout_crtofnsLev%,court_off_lev,few),court_off_lev);
///////////////////////////////////////////////////////////////////////////////
#uniquename(layout_crtOfns)
#uniquename(tblcrtoffdesc1)

%layout_crtOfns%:= record
infile2.court_off_desc_1;
total:= count(group);
end;

%tblcrtoffdesc1% := sort(table(infile2,%layout_crtOfns%,court_off_desc_1,few),court_off_desc_1);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_crtdisp)
#uniquename(tblcrtdispdesc1)

%layout_crtdisp%:= record
infile2.court_disp_desc_1;
total:= count(group);
end;

%tblcrtdispdesc1% := sort(table(infile2,%layout_crtdisp%,court_disp_desc_1,few),court_disp_desc_1);
//////////////////////////////////////////////////////////////////////////////
#uniquename(layout_statute)
#uniquename(tblcrtstatute)

%layout_statute%:= record
infile2.court_statute_desc;
total:= count(group);
end;

%tblcrtstatute% := sort(table(infile2,%layout_statute%,court_statute_desc,few),court_statute_desc);
//////////////////////////////////////////////////////////////////////////////
#uniquename(tblcoverage)
#uniquename(coverageDateUsed)
/*
#if(AVE(group,IF(stringlib.stringfilterout(infile1.case_filing_dt,'0')<>'',100,0)) <> 0)
	%tblcoverage% := %tblcase_filing_dt%;
#else #if(%popstats2%.%has_court_disp_date% <> 0 and filetype = 'crim')
	%tblcoverage% := 'NO USABLE DATE';
#else #if(%popstats2%.%has_sent_date% <> 0 and filetype = 'crim')
	%tblcoverage% := 'NO USABLE DATE';
#else #if(%popstats2%.%has_arr_date% <> 0 and filetype = 'arr')
	%tblcoverage% := 'NO USABLE DATE';
#else #if(%popstats2%.%has_arr_disp_date% <> 0 and filetype = 'arr')
	%tblcoverage% := 'NO USABLE DATE';
#else #if(%popstats2%.%has_off_date% <> 0 and filetype = 'arr')
	%tblcoverage% := 'NO USABLE DATE';
#else
%tblcoverage% := 'NO USABLE DATE';
%coverageDateUsed% := 'NO USABLE DATE';

#end

*/
#uniquename(layout_out)
%layout_out% := record
string   fieldName;
string   fieldVal;
end;

outfile := 
 /*output(dataset([
				  {'UpdateFrequency            : ',updateFreq},
				 // {'CoverageDateUsed           : ',%coverageDateUsed%},
				 // {'CoverageDateRange          : ',%tblcoverage% }
				  {'CaseTypes				   : ',%tblcasetype%},
				  {'ArrestOffenseLev           : ',%tblarrofflev%},
				  {'ArrestOffenseDesc          : ',%tblarroffdesc1%},
				  {'ArrestDispositionDesc      : ',%tblarrdispdesc1%},
				  {'ArrestStatuteDesc          : ',%tblarrstatute%},
				  {'CourtOffenseLev            : ',%tblcrtofflev%},
				  {'CourtOffenseDesc           : ',%tblcrtoffdesc1%},
				  {'CourtDispositionDesc       : ',%tblcrtdispdesc1%},
				  {'CourtStatuteDesc           : ',%tblcrtstatute%}

				  ], %layout_out%),named('ReleaseReport')); */
 parallel(
 output(%popstats1%,all,named('OffenderFieldPopulations')),
 output(%popstats2%,all,named('OffensesFieldPopulations')),
 output(%tblcasetype%,all,named('CaseTypes')),
 output(%tblarrofflev%,all,named('ArrestOffenseLev')),
 output(%tblarroffdesc1%,all,named('ArrestOffenseDesc')),
 output(%tblarrdispdesc1%,all,named('ArrestDispositionDesc')),
 output(%tblarrstatute%,all,named('ArrestStatuteDesc')),
 output(%tblcrtofflev%,all,named('CourtOffenseLev')),
 output(%tblcrtoffdesc1%,all,named('CourtOffenseDesc')),
 output(%tblcrtdispdesc1%,all,named('CourtDispositionDesc')),
 output(%tblcrtstatute%,all,named('CourtStatuteDesc')));




endmacro;