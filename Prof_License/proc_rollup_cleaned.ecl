import Prof_License;
 
ds_distributed := distribute(Prof_License.File_prolic_in,hash(prolic_key,profession_or_board,license_type));

ds_sorted := 
   sort(ds_distributed,
		prolic_key,
		profession_or_board,
		license_type,
		status,
		license_number,
		company_name,
		phone,
		expiration_date,
		license_obtained_by,
		source_st,
		prim_range,
		predir,
		prim_name,
		sec_range,
		zip,
		fname,
		mname,
		lname,
		suffix,
		date_last_seen,	
		local);

Prof_license.layout_prolic_in tRollup(Prof_license.layout_prolic_in L, Prof_license.layout_prolic_in R)
 := transform
self.date_first_seen := if(L.date_first_seen < R.date_first_seen, L.date_first_seen , R.date_first_seen );
self.date_last_seen  := if(R.date_last_seen  > L.date_last_seen,  R.date_last_seen ,  L.date_last_seen );
//
self.county_str := 	if (R.county_str<>'', R.county_str , L.county_str);
self.country_str := if (R.country_str<>'', R.country_str , L.country_str);
self.sex := if (R.sex<>'', R.sex , L.sex);
self.issue_date := 	if (R.issue_date<>'', R.issue_date , L.issue_date);
self.last_renewal_date := if (R.last_renewal_date<>'', R.last_renewal_date , L.last_renewal_date);
//
self.action_record_type := if (R.action_record_type<>'', R.action_record_type , L.action_record_type);
self.action_complaint_violation_cds := if (R.action_record_type<>'', R.action_complaint_violation_cds , L.action_complaint_violation_cds);
self.action_complaint_violation_desc := if (R.action_record_type<>'', R.action_complaint_violation_desc , L.action_complaint_violation_desc);
self.action_complaint_violation_dt := if (R.action_record_type<>'', R.action_complaint_violation_dt , L.action_complaint_violation_dt);
self.action_case_number := if (R.action_record_type<>'', R.action_case_number , L.action_case_number);
self.action_effective_dt := if (R.action_record_type<>'', R.action_effective_dt , L.action_effective_dt);
self.action_cds := if (R.action_record_type<>'', R.action_cds , L.action_cds);
self.action_desc := if (R.action_record_type<>'', R.action_desc , L.action_desc);
self.action_final_order_no := if (R.action_record_type<>'', R.action_final_order_no , L.action_final_order_no);
self.action_status := if (R.action_record_type<>'', R.action_status , L.action_status);
self.action_posting_status_dt := if (R.action_record_type<>'', R.action_posting_status_dt , L.action_posting_status_dt);
self.action_original_filename_or_url := if (R.action_record_type<>'', R.action_original_filename_or_url , L.action_original_filename_or_url);
//
self.additional_name_addr_type := 	if (R.additional_orig_name<>'', R.additional_name_addr_type , L.additional_name_addr_type);
self.additional_orig_name := 		if (R.additional_orig_name<>'', R.additional_orig_name , L.additional_orig_name);
self.additional_name_order := 		if (R.additional_orig_name<>'', R.additional_name_order , L.additional_name_order);
//
self.additional_orig_additional_1 := if (R.additional_orig_additional_1<>'', R.additional_orig_additional_1 , L.additional_orig_additional_1);
self.additional_orig_additional_2 := if (R.additional_orig_additional_1<>'', R.additional_orig_additional_2 , L.additional_orig_additional_2);
self.additional_orig_additional_3 := if (R.additional_orig_additional_1<>'', R.additional_orig_additional_3 , L.additional_orig_additional_3);
self.additional_orig_additional_4 := if (R.additional_orig_additional_1<>'', R.additional_orig_additional_4 , L.additional_orig_additional_4);
self.additional_orig_city := 		 if (R.additional_orig_additional_1<>'', R.additional_orig_city , L.additional_orig_city);
self.additional_orig_st := 			 if (R.additional_orig_additional_1<>'', R.additional_orig_st , L.additional_orig_st);
self.additional_orig_zip := 		 if (R.additional_orig_additional_1<>'', R.additional_orig_zip , L.additional_orig_zip);
//
self.additional_phone := if (R.additional_phone<>'', R.additional_phone , L.additional_phone);
self.misc_occupation := if (R.misc_occupation<>'', R.misc_occupation , L.misc_occupation);
self.misc_practice_hours := if (R.misc_practice_hours<>'', R.misc_practice_hours , L.misc_practice_hours);
self.misc_practice_type := if (R.misc_practice_type<>'', R.misc_practice_type , L.misc_practice_type);
self.misc_email := if (R.misc_email<>'', R.misc_email , L.misc_email);
self.misc_fax := if (R.misc_fax<>'', R.misc_fax , L.misc_fax);
self.misc_web_site := if (R.misc_web_site<>'', R.misc_web_site , L.misc_web_site);
//
self.misc_other_id := 				if (R.misc_other_id<>'', R.misc_other_id , L.misc_other_id);
self.misc_other_id_type := 			if (R.misc_other_id<>'', R.misc_other_id_type , L.misc_other_id_type);
//
self.education_continuing_education := if (R.education_continuing_education<>'', R.education_continuing_education , L.education_continuing_education);
//
self.education_1_school_attended := if (R.education_1_school_attended<>'', R.education_1_school_attended , L.education_1_school_attended);
self.education_1_dates_attended := 	if (R.education_1_dates_attended<>'', R.education_1_dates_attended , L.education_1_dates_attended);
//
self.education_1_curriculum := if (R.education_1_curriculum<>'', R.education_1_curriculum , L.education_1_curriculum);
self.education_1_degree := if (R.education_1_degree<>'', R.education_1_degree , L.education_1_degree);
//
self.education_2_school_attended := if (R.education_2_school_attended<>'', R.education_2_school_attended , L.education_2_school_attended);
self.education_2_dates_attended := if (R.education_2_dates_attended<>'', R.education_2_dates_attended , L.education_2_dates_attended);
//
self.education_2_curriculum := if (R.education_2_curriculum<>'', R.education_2_curriculum , L.education_2_curriculum);
self.education_2_degree := if (R.education_2_degree<>'', R.education_2_degree , L.education_2_degree);
//
self.education_3_school_attended := if (R.education_3_school_attended<>'', R.education_3_school_attended , L.education_3_school_attended);
self.education_3_dates_attended := if (R.education_3_dates_attended<>'', R.education_3_dates_attended , L.education_3_dates_attended);
//
self.education_3_curriculum := if (R.education_3_curriculum<>'', R.education_3_curriculum , L.education_3_curriculum);
self.education_3_degree := if (R.education_3_degree<>'', R.education_3_degree , L.education_3_degree);
//
self.additional_licensing_specifics := if (R.additional_licensing_specifics<>'', R.additional_licensing_specifics , L.additional_licensing_specifics);
//
self.personal_pob_cd := 	if (R.personal_pob_desc<>'', R.personal_pob_cd , L.personal_pob_cd);
self.personal_pob_desc := 	if (R.personal_pob_desc<>'', R.personal_pob_desc , L.personal_pob_desc);
//
self.personal_race_cd := 	if (R.personal_race_desc<>'', R.personal_race_cd , L.personal_race_cd);
self.personal_race_desc := 	if (R.personal_race_desc<>'', R.personal_race_desc , L.personal_race_desc);
//
self.status_status_cds := if (R.status_status_cds<>'', R.status_status_cds , L.status_status_cds);
self.status_effective_dt := if (R.status_effective_dt<>'', R.status_effective_dt , L.status_effective_dt);
self.status_renewal_desc := if (R.status_renewal_desc<>'', R.status_renewal_desc , L.status_renewal_desc);
self.status_other_agency := if (R.status_other_agency<>'', R.status_other_agency , L.status_other_agency);
self := R;
end;

ds_rolled_up := 
	rollup(ds_sorted,
		tRollup(left, right),
		prolic_key,
		profession_or_board,
		license_type,
		status,
		license_number,
		company_name,
		phone,
		expiration_date,
		license_obtained_by,
		source_st,
		prim_range,
		predir,
		prim_name,
		sec_range,
		zip,
		fname,
		mname,
		lname,
		suffix,
		local);
	
//count(ds_rolled_up);		
//output(ds_rolled_up);


export proc_rollup_cleaned := output(ds_rolled_up,,'~thor_data400::in::prof_license_' + prof_license.version,overwrite);
//export proc_rollup_cleaned := output(ds_rolled_up,,'~thor_200::in::prof_license_test',overwrite);