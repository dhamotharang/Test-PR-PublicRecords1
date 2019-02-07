import _control, data_services;

export constants := module
	EXPORT prolicv2_base := data_services.foreign_prod + 'prte::base::prolicv2';
	EXPORT KeyName_prolicv2 := 	'~prte::key::prolicv2::';
	EXPORT ak_keyname := KeyName_prolicv2 +'@version@::autokey::';
	EXPORT ak_logical(string filedate) := KeyName_prolicv2 + filedate + '::autokey::';
	EXPORT ak_QAname := KeyName_prolicv2 +'qa::autokey::';	
	EXPORT ak_typestr := 'AK';

	export skip_set := ['F','P'];
		
	//Spray constants
	EXPORT IN_PREFIX_NAME := '~PRTE::IN::prolicv2';
	
	//DF-22706: FCRA Consusmer Data Field Depreciation
	EXPORT fields_to_clear := 'ace_fips_st,action_case_number,action_cds,action_complaint_violation_cds,action_complaint_violation_desc,action_complaint_violation_dt,'
	                   + 'action_desc,action_effective_dt,action_final_order_no,action_original_filename_or_url,action_posting_status_dt,action_record_type,'
										 + 'action_status,additional_licensing_specifics,additional_name_addr_type,additional_orig_additional_1,additional_orig_additional_2,'
										 + 'additional_orig_additional_3,additional_orig_additional_4,additional_orig_city,additional_orig_name,additional_orig_st,additional_orig_zip,'
										 + 'additional_phone,business_flag,company_name,country_str,county_str,education_1_curriculum,education_2_curriculum,education_2_dates_attended,'
										 + 'education_2_degree,education_2_school_attended,education_3_curriculum,education_3_dates_attended,education_3_degree,education_3_school_attended,'
										 + 'education_continuing_education,former_name_order,license_obtained_by,misc_email,misc_fax,misc_occupation,misc_other_id,misc_other_id_type,'
										 + 'misc_practice_hours,misc_practice_type,misc_web_site,orig_former_name,personal_pob_cd,personal_pob_desc,personal_race_cd,personal_race_desc,'
										 + 'previous_license_number,previous_license_type,record_type,sex,status_other_agency,status_renewal_desc,status_status_cds,title'; 
	
end;
