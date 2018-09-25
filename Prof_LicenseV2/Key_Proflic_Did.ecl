Import Data_Services, doxie, FCRA, ut,misc;

export key_proflic_did (boolean IsFCRA = false) := function
  // Found out from Danny Bello that the exclusion of INFUTOR only happens when it's FCRA data
  df := IF(~IsFCRA,
	         Prof_LicenseV2.File_Proflic_Base_Keybuild((unsigned)did != 0),
					 Prof_LicenseV2.File_Proflic_Base_Keybuild((unsigned)did != 0 AND vendor <> 'INFUTOR'));

  Layout_out := record
    unsigned6 did;
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base and not [did];  
  end;

  Layout_out trfProject(df l) := transform
    self.did := (unsigned6) l.did;
    self     := l;
  end;

  nFCRA_out_df := project(df (~IsFCRA or orbit_source not in FCRA.compliance.proflicenses.restricted_sources), trfProject(left));

	// For FCRA, only allow sources that have info in vendor source info key
  allSources   := table(misc.Key_VendorSrc().Vendor_Source,{source_code},source_code,merge,few);
  FCRA_out_df  := join(nFCRA_out_df,allSources,left.vendor=right.source_code,transform(left),lookup);
  
  // DF-21732 (FCRA Consumer Data Field Deprecation - FCRA_ProfLic Keys)
  fields_to_clear := 'ace_fips_st,action_case_number,action_cds,action_complaint_violation_cds,action_complaint_violation_desc,action_complaint_violation_dt,'
	                   + 'action_desc,action_effective_dt,action_final_order_no,action_original_filename_or_url,action_posting_status_dt,action_record_type,'
					   + 'action_status,additional_licensing_specifics,additional_name_addr_type,additional_orig_additional_1,additional_orig_additional_2,'
					   + 'additional_orig_additional_3,additional_orig_additional_4,additional_orig_city,additional_orig_name,additional_orig_st,additional_orig_zip,'
					   + 'additional_phone,business_flag,company_name,country_str,county_str,education_1_curriculum,education_2_curriculum,education_2_dates_attended,'
					   + 'education_2_degree,education_2_school_attended,education_3_curriculum,education_3_dates_attended,education_3_degree,education_3_school_attended,'
					   + 'education_continuing_education,former_name_order,license_obtained_by,misc_email,misc_fax,misc_occupation,misc_other_id,misc_other_id_type,'
					   + 'misc_practice_hours,misc_practice_type,misc_web_site,orig_former_name,personal_pob_cd,personal_pob_desc,personal_race_cd,personal_race_desc,'
					   + 'previous_license_number,previous_license_type,record_type,sex,status_other_agency,status_renewal_desc,status_status_cds,title';
                       
  ut.MAC_CLEAR_FIELDS(FCRA_out_df,FCRA_out_df_cleared, fields_to_clear);
 
  out_df       := if(IsFCRA, FCRA_out_df_cleared, nFCRA_out_df);

  file_name := if (IsFCRA, 
                   Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ProlicV2::fcra::' + doxie.Version_SuperKey + '::prolicense_did',
                   Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ProlicV2::'+ doxie.Version_SuperKey +'::prolicense_did');

  return index (out_df, {did}, {out_df}, file_name);
end;
