import ut,RoxieKeybuild,orbit_report,PromoteSupers,Orbit3,Scrubs_marriage_divorce_v2;

//Modified filedate as ut.getdate is failing to create version
export proc_build_files_and_keys(string filedate) := function

OffensiveTerms := ['NEGRO'];

concat_them0 := 
          marriage_divorce_v2.mapping_ky_divorce
        + marriage_divorce_v2.mapping_ky_marriage
			  + marriage_divorce_v2.mapping_nc_divorce
			  + marriage_divorce_v2.mapping_nc_marriage
				+ marriage_divorce_v2.mapping_fl_new_divorce
			  + marriage_divorce_v2.mapping_fl_new_marriage
			  // + marriage_divorce_v2.mapping_fl_divorce	
			  //+ marriage_divorce_v2.mapping_fl_marriage	
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
				//+  marriage_divorce_v2.mapping_ct_new_marriage
				+ marriage_divorce_v2.mapping_ct_divorce
				;



//legal reasons to exclude RI data
//stats show RI only provides divorce information
concat_them1 := concat_them0(~((state_origin='RI' or vendor='CIV15') and filing_type='7' and divorce_dt[1..4]>'2006'));			  

//to remove offensive terms
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
		//to remove offensive terms		
		Self.Party1_Race	:= 	If(L.Party1_Race in OffensiveTerms, '', L.Party1_Race);
		Self.Party2_Race	:= 	If(L.Party2_Race in OffensiveTerms, '', L.Party2_Race); 
		Self := L;
End;

p_option_to_reclean := project(marriage_divorce_v2.file_mar_div_intermediate,t_option_to_reclean(left));

PromoteSupers.MAC_SF_BuildProcess(marriage_divorce_v2.proc_clean_and_did(concat_them+p_option_to_reclean).base_file_intermediate,'~thor_data400::base::mar_div::intermediate',build_intermediate,3,,true);
PromoteSupers.MAC_SF_BuildProcess(marriage_divorce_v2.proc_clean_and_did(concat_them+p_option_to_reclean).base_file             ,'~thor_data400::base::mar_div::base'        ,build_base,3,,true);
PromoteSupers.MAC_SF_BuildProcess(marriage_divorce_v2.proc_clean_and_did(concat_them+p_option_to_reclean).search_file           ,'~thor_data400::base::mar_div::search'      ,build_search,3,,true);

//send email to qa with sample records.
sample_records_for_qa	:= marriage_divorce_v2.fn_Qa_Sample_Records : success(marriage_divorce_V2.Email_notification_list(marriage_divorce_v2.version));
updatedops                       := RoxieKeyBuild.updateversion('MDV2Keys',filedate,'skasavajjala@seisint.com',,'N|B');
fcraupdatedops                   := RoxieKeyBuild.updateversion('FCRA_MDV2Keys',filedate,'skasavajjala@seisint.com',,'F');
orbit_report.MD_Stats(getretval);
//added function call that will clear both div and mar superfiles after the build is finished.

orbit_update := sequential(Orbit3.proc_Orbit3_CreateBuild ('Marriages & Divorces',filedate,'N'),
								Orbit3.proc_Orbit3_CreateBuild ('FCRA Marriage & Divorces',filedate,'F'));


 do_all := sequential(marriage_divorce_v2.File_In_FL_Validate,build_intermediate,parallel(build_base,build_search),
									marriage_divorce_v2.proc_build_keys(filedate),
									marriage_divorce_v2.Proc_Build_Boolean_Keys(filedate),
									marriage_divorce_v2.proc_move_to_qa,
									marriage_divorce_V2.coverage,
									marriage_divorce_v2.Out_Base_Dev_Stats(filedate),
									Scrubs_marriage_divorce_v2.PostBuildScrubs(filedate),
									sample_records_for_qa,
									updatedops,
									fcraupdatedops,
									orbit_update,
									getretval
									);
 
return do_all;

end;