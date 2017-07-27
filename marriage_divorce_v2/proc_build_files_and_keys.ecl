import ut;

export proc_build_files_and_keys := function

concat_them := marriage_divorce_v2.mapping_ky_divorce
             + marriage_divorce_v2.mapping_ky_marriage
			 + marriage_divorce_v2.mapping_nc_divorce
			 + marriage_divorce_v2.mapping_nc_marriage
			 + marriage_divorce_v2.mapping_fl_divorce
			 + marriage_divorce_v2.mapping_fl_marriage
			 + marriage_divorce_v2.mapping_tx_divorce
			 + marriage_divorce_v2.mapping_tx_marriage
			 + marriage_divorce_v2.mapping_ca_marriage
			 + marriage_divorce_v2.mapping_official_mar_div_records
			 + marriage_divorce_v2.mapping_civil_matter_party_mar_div
			 + marriage_divorce_v2.mapping_v1_to_v2
			 ;

marriage_divorce_v2.layout_mar_div_intermediate t_option_to_reclean(marriage_divorce_v2.layout_mar_div_intermediate le) := transform
 //Set to blank if you want older data re-cleaned
 //Else, leave it alone
 //self.touched := '';
 self := le;
end;

p_option_to_reclean := project(marriage_divorce_v2.file_mar_div_intermediate,t_option_to_reclean(left));

ut.mac_sf_buildprocess(marriage_divorce_v2.proc_clean_and_did(concat_them/*+p_option_to_reclean*/).base_file_intermediate,'~thor_data400::base::mar_div::intermediate',build_intermediate,3);
ut.mac_sf_buildprocess(marriage_divorce_v2.proc_clean_and_did(concat_them/*+p_option_to_reclean*/).base_file             ,'~thor_data400::base::mar_div::base'        ,build_base,3);
ut.mac_sf_buildprocess(marriage_divorce_v2.proc_clean_and_did(concat_them/*+p_option_to_reclean*/).search_file           ,'~thor_data400::base::mar_div::search'      ,build_search,3);

 do_all := sequential(build_intermediate,parallel(build_base,build_search),marriage_divorce_v2.proc_build_keys(marriage_divorce_v2.version));
 
return do_all;

end;