import STD, ut;

File_prolic := dataset('~thor_data400::in::prolic::allsources',Prof_License.Layout_proLic_in,thor);

Prof_License.Layout_proLic_in tprolic(File_prolic L) := transform
    self.prolic_key         		        := ut.CleanSpacesAndUpper( l.prolic_key);
    self.status        								  := ut.CleanSpacesAndUpper( l.status);
    self.license_number         			  := ut.CleanSpacesAndUpper( l.license_number);
    self.previous_license_number     	  := ut.CleanSpacesAndUpper( l.previous_license_number);
    self.company_name         				  := ut.CleanSpacesAndUpper( l.company_name);
    self.orig_name         						  := ut.CleanSpacesAndUpper( l.orig_name);
    self.name_order        				  	  := ut.CleanSpacesAndUpper( l.name_order);
    self.orig_former_name         		  := ut.CleanSpacesAndUpper( l.orig_former_name );
    self.former_name_order         		  := ut.CleanSpacesAndUpper( l.former_name_order );
    self.orig_addr_1             			  := ut.CleanSpacesAndUpper( l.orig_addr_1); 
    self.orig_addr_2            			  := ut.CleanSpacesAndUpper( l.orig_addr_2); 
    self.orig_addr_3             			  := ut.CleanSpacesAndUpper( l.orig_addr_3);
    self.orig_addr_4             			  := ut.CleanSpacesAndUpper( l.orig_addr_4);
    self.orig_city        					    := ut.CleanSpacesAndUpper( l.orig_city);
    self.orig_st         							  := ut.CleanSpacesAndUpper( l.orig_st);
    self.orig_zip         						  := ut.CleanSpacesAndUpper( l.orig_zip);
    self.county_str         					  := ut.CleanSpacesAndUpper( l.county_str);
    self.country_str         					  := ut.CleanSpacesAndUpper( l.country_str);
    self.business_flag        				  := ut.CleanSpacesAndUpper( l.business_flag);
    self.phone         								  := ut.CleanSpacesAndUpper( l.phone);
    self.sex         									  := ut.CleanSpacesAndUpper( l.sex);
    self.dob         									  := ut.CleanSpacesAndUpper( l.dob);
    self.expiration_date         			  := ut.CleanSpacesAndUpper( l.expiration_date);
    self.last_renewal_date         		  := ut.CleanSpacesAndUpper( l.last_renewal_date);
    self.license_obtained_by         	  := ut.CleanSpacesAndUpper( l.license_obtained_by);
    self.source_st         						  := ut.CleanSpacesAndUpper( l.source_st);
    self.vendor         							  := ut.CleanSpacesAndUpper( l.vendor);
    self.board_action_indicator         := ut.CleanSpacesAndUpper( l.board_action_indicator); 
    self.action_record_type         	  := ut.CleanSpacesAndUpper( l.action_record_type);
    self.action_complaint_violation_cds := ut.CleanSpacesAndUpper( l.action_complaint_violation_cds); 
    self.action_complaint_violation_desc:= ut.CleanSpacesAndUpper( l.action_complaint_violation_desc);
    self.additional_orig_name           := ut.CleanSpacesAndUpper( l.additional_orig_name);
    self.additional_phone         		  := ut.CleanSpacesAndUpper( l.additional_phone);
    self.additional_licensing_specifics := ut.CleanSpacesAndUpper( l.additional_licensing_specifics);													
    self.action_complaint_violation_dt  := ut.CleanSpacesAndUpper( l.action_complaint_violation_dt);
    self.misc_practice_type        		  := ut.CleanSpacesAndUpper( l.misc_practice_type);
    self.misc_email         						:= ut.CleanSpacesAndUpper( l.misc_email);
    self.misc_fax         							:= ut.CleanSpacesAndUpper( l.misc_fax);
    self.misc_other_id        					:= ut.CleanSpacesAndUpper( l.misc_other_id);
    self.misc_other_id_type         		:= ut.CleanSpacesAndUpper( l.misc_other_id_type);
    self.action_case_number         		:= ut.CleanSpacesAndUpper( l.action_case_number );
    self.action_effective_dt         	  := ut.CleanSpacesAndUpper( l.action_effective_dt );
    self.action_cds         						:= ut.CleanSpacesAndUpper( l.action_cds );
    self.action_desc         					  := ut.CleanSpacesAndUpper( l.action_desc );
    self.action_final_order_no          := ut.CleanSpacesAndUpper( l.action_final_order_no );
    self.action_status         				  := ut.CleanSpacesAndUpper( l.action_status );
    self.action_posting_status_dt       := ut.CleanSpacesAndUpper( l.action_posting_status_dt );
    self.action_original_filename_or_url:= ut.CleanSpacesAndUpper( l.action_original_filename_or_url );
    self.additional_name_addr_type      := ut.CleanSpacesAndUpper( l.additional_name_addr_type );
    self.additional_name_order          := ut.CleanSpacesAndUpper( l.additional_name_order );
    self.additional_orig_additional_1   := ut.CleanSpacesAndUpper( l.additional_orig_additional_1 );
    self.additional_orig_additional_2   := ut.CleanSpacesAndUpper( l.additional_orig_additional_2 );
    self.additional_orig_additional_3   := ut.CleanSpacesAndUpper( l.additional_orig_additional_3 );
    self.additional_orig_additional_4   := ut.CleanSpacesAndUpper( l.additional_orig_additional_4 );
    self.additional_orig_city         	:= ut.CleanSpacesAndUpper( l.additional_orig_city );
    self.additional_orig_st         		:= ut.CleanSpacesAndUpper( l.additional_orig_st );
    self.additional_orig_zip         	  := ut.CleanSpacesAndUpper( l.additional_orig_zip );
    self.misc_occupation         			  := ut.CleanSpacesAndUpper( l.misc_occupation );
    self.misc_practice_hours         	  := ut.CleanSpacesAndUpper( l.misc_practice_hours );
    self.misc_web_site         				  := ut.CleanSpacesAndUpper( l.misc_web_site );
    self.education_1_school_attended    := ut.CleanSpacesAndUpper( l.education_1_school_attended);
    self.education_1_dates_attended     := ut.CleanSpacesAndUpper( l.education_1_dates_attended);
    self.education_continuing_education := ut.CleanSpacesAndUpper( l.education_continuing_education);
    self.education_1_curriculum         := ut.CleanSpacesAndUpper( l.education_1_curriculum);
    self.education_1_degree             := ut.CleanSpacesAndUpper( l.education_1_degree);
    self.education_2_school_attended    := ut.CleanSpacesAndUpper( l.education_2_school_attended );
    self.education_2_dates_attended     := ut.CleanSpacesAndUpper( l.education_2_dates_attended );
    self.education_2_curriculum         := ut.CleanSpacesAndUpper( l.education_2_curriculum );
    self.education_2_degree         		:= ut.CleanSpacesAndUpper( l.education_2_degree );
    self.education_3_school_attended    := ut.CleanSpacesAndUpper( l.education_3_school_attended );
    self.education_3_dates_attended     := ut.CleanSpacesAndUpper( l.education_3_dates_attended );
    self.education_3_curriculum         := ut.CleanSpacesAndUpper( l.education_3_curriculum );
    self.education_3_degree         		:= ut.CleanSpacesAndUpper( l.education_3_degree );
    self.personal_pob_cd         			  := ut.CleanSpacesAndUpper( l.personal_pob_cd );
    self.personal_pob_desc         		  := ut.CleanSpacesAndUpper( l.personal_pob_desc );
    self.personal_race_cd         		  := ut.CleanSpacesAndUpper( l.personal_race_cd );
    self.personal_race_desc         	  := ut.CleanSpacesAndUpper( l.personal_race_desc );
    self.status_status_cds         		  := ut.CleanSpacesAndUpper( l.status_status_cds );
    self.status_effective_dt         	  := ut.CleanSpacesAndUpper( l.status_effective_dt );
    self.status_renewal_desc         	  := ut.CleanSpacesAndUpper( l.status_renewal_desc );
    self.status_other_agency         	  := ut.CleanSpacesAndUpper( l.status_other_agency );
    self.profession_or_board            := if( regexfind('"',L.profession_or_board),regexreplace('"',L.profession_or_board,''), ut.CleanSpacesAndUpper( l.profession_or_board));
    self.license_type                   := if( regexfind('"',L.license_type),regexreplace('"',L.license_type,''),ut.CleanSpacesAndUpper( l.license_type));
    self.orig_license_number            := if( L.orig_license_number <> '',L.orig_license_number, trim(L.license_number,left,right));
    self.issue_date                     := map( L.issue_date > (STRING8)STD.Date.Today()  => '19'+l.issue_date[3..8],
		                                            L.issue_date[3..4] between '00' and ((STRING8)STD.Date.Today())[3..4] => '20'+ L.issue_date[3..8], trim(L.issue_date,left,right) );
    self                                := L;
end;

export File_prolic_in := project(File_prolic,tprolic(LEFT));




