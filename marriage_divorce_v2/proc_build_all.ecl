import ut,RoxieKeybuild,orbit_report;

export proc_build_all := function

OffensiveTerms := ['NEGRO'];

concat_them0 := 
          marriage_divorce_v2.mapping_ky_divorce
        + marriage_divorce_v2.mapping_ky_marriage
			  + marriage_divorce_v2.mapping_nc_divorce
			  + marriage_divorce_v2.mapping_nc_marriage
			 // + marriage_divorce_v2.mapping_fl_divorce	
			 // + marriage_divorce_v2.mapping_fl_marriage
			 + marriage_divorce_v2.mapping_fl_new_divorce
			 + marriage_divorce_v2.mapping_fl_new_marriage
			  + marriage_divorce_v2.mapping_tx_divorce
			  + marriage_divorce_v2.mapping_tx_marriage
			  + marriage_divorce_v2.mapping_ca_marriage
			  + marriage_divorce_v2.mapping_official_mar_div_records
			  + marriage_divorce_v2.mapping_civil_matter_party_mar_div
			  + marriage_divorce_v2.mapping_oh_divorce						
			  + marriage_divorce_v2.mapping_oh_marriage					 
			  + marriage_divorce_v2.mapping_mi_marriage					 
			  + marriage_divorce_v2.mapping_nv_divorce
				+ marriage_divorce_v2.mapping_nv_marriage
				+ marriage_divorce_v2.mapping_ct_marriage
				+ marriage_divorce_v2.mapping_ct_divorce
				;



//legal reasons to exclude RI data
//stats show RI only provides divorce information
concat_them1 := concat_them0(~((state_origin='RI' or vendor='CIV15') and filing_type='7' and divorce_dt[1..4]>'2006'));			  

marriage_divorce_v2.layout_mar_div_intermediate OffTerms(concat_them1 L) := Transform
		Self.Party1_Race	:= 	If(L.Party1_Race in OffensiveTerms, '', L.Party1_Race);
		Self.Party2_Race	:= 	If(L.Party2_Race in OffensiveTerms, '', L.Party2_Race);
		Self := L;
End;

Concat_them := Project(concat_them1, OffTerms(Left));

marriage_divorce_v2.layout_mar_div_intermediate t_option_to_reclean(marriage_divorce_v2.layout_mar_div_intermediate L) := transform
 //Set to blank if you want older data re-cleaned
 //Else, leave it alone
 //self.touched := '';
		Self.Party1_Race	:= 	If(L.Party1_Race in OffensiveTerms, '', L.Party1_Race);
		Self.Party2_Race	:= 	If(L.Party2_Race in OffensiveTerms, '', L.Party2_Race); 
		Self := L;
End;

p_option_to_reclean := project(marriage_divorce_v2.file_mar_div_intermediate,t_option_to_reclean(left));

ut.mac_sf_buildprocess(marriage_divorce_v2.proc_clean_and_did(concat_them+p_option_to_reclean).base_file_intermediate,'~thor_data400::base::mar_div::intermediate',build_intermediate,3);
ut.mac_sf_buildprocess(marriage_divorce_v2.proc_clean_and_did(concat_them+p_option_to_reclean).base_file             ,'~thor_data400::base::mar_div::base'        ,build_base,3);
ut.mac_sf_buildprocess(marriage_divorce_v2.proc_clean_and_did(concat_them+p_option_to_reclean).search_file           ,'~thor_data400::base::mar_div::search'      ,build_search,3);

//send email to qa with sample records.
sample_records_for_qa	:= marriage_divorce_v2.fn_Qa_Sample_Records : success(marriage_divorce_V2.Email_notification_list(marriage_divorce_v2.version));
updatedops                       := RoxieKeyBuild.updateversion('MDV2Keys',marriage_divorce_v2.version,'skasavajjala@seisint.com',,'N|B');
orbit_report.MD_Stats(getretval);
//added function call that will clear both div and mar superfiles after the build is finished.
 do_all := sequential(build_intermediate,parallel(build_base,build_search),
									marriage_divorce_v2.proc_build_keys(marriage_divorce_v2.version),
									marriage_divorce_v2.Proc_Build_Boolean_Keys(marriage_divorce_v2.version),
									marriage_divorce_v2.proc_move_to_qa,
									marriage_divorce_V2.coverage,
									marriage_divorce_v2.Out_Base_Dev_Stats,
									sample_records_for_qa,
									updatedops,
									getretval
									);
 
return do_all;

end;