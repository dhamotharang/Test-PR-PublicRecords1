import hygenics_soff, doxie_build, strata, sexoffender;

export Proc_Build_SO_Search(string filedate) := function

dofirst 	:= proc_build_SO_Search_Base;
dosecond 	:= proc_build_So_Search_Keys(filedate);
dosecond2 	:= Hygenics_SOff.Proc_Build_Autokey(filedate);
dothird 	:= doxie_build.proc_acceptSK_SO_ToQA;
dofourth 	:= fileservices.sendemail('jtao@seisint.com'
                                  ,'SEX OFFENDER BUILD SUCCESS ' + filedate,
							'keys: 1) thor_data400::key::sexoffender::spkpublic_qa (thor_data400::key::sexoffender::'+filedate+'::spkpublic)'           + '\n' +
							'      2) thor_data400::key::sexoffender::offenses_public_qa (thor_data400::key::sexoffender::'+filedate+'::offenses_public)'     + '\n' +
							'      3) thor_data400::key::sexoffender::didpublic_qa (thor_data400::key::sexoffender::'+filedate+'::didpublic)'           + '\n' +
							'      4) thor_data400::key::sexoffender::fdid_public_qa (thor_data400::key::sexoffender::'+filedate+'::fdid_public)'          + '\n' +
							'      5) thor_data400::key::sexoffender::publicaddress_qa (thor_data400::key::sexoffender::'+filedate+'::publicaddress)'        + '\n' +
							'      6) thor_data400::key::sexoffender::publiccitystname_qa (thor_data400::key::sexoffender::'+filedate+'::publiccitystname)'     + '\n' +
							'      7) thor_data400::key::sexoffender::publicname_qa (thor_data400::key::sexoffender::'+filedate+'::publicname)'           + '\n' +
							'      8) thor_data400::key::sexoffender::publicphone_qa (thor_data400::key::sexoffender::'+filedate+'::publicphone)'          + '\n' +
							'      9) thor_data400::key::sexoffender::publicssn_qa (thor_data400::key::sexoffender::'+filedate+'::publicssn)'            + '\n' +
							'     10) thor_data400::key::sexoffender::publicstname_qa (thor_data400::key::sexoffender::'+filedate+'::publicstname)'         + '\n' +
							'     11) thor_data400::key::sexoffender::publiczip_qa (thor_data400::key::sexoffender::'+filedate+'::publiczip)'            + '\n' +
							'     12) thor_data400::key::sexoffender::enhpublic_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublic)'            + '\n' +
							'     13) thor_data400::key::sexoffender::enhpublicaddress_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicaddress)'     + '\n' +
							'     14) thor_data400::key::sexoffender::enhpublicname_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicname)'        + '\n' +
							'     16) thor_data400::key::sexoffender::enhpublicphone_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicphone)'       + '\n' +
							'     17) thor_data400::key::sexoffender::enhpublicssn_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicssn)'         + '\n' +
							'     18) thor_data400::key::sexoffender::enhpublicstname_qa (thor_data400::key::sexoffender::'+filedate+'::enhpublicstname)'      + '\n' +
							'     19) thor_data400::key::sexoffender::enhpubliczip_qa (thor_data400::key::sexoffender::'+filedate+'::enhpubliczip)'         + '\n' +
							'     20) thor_data400::key::sexoffender::autokey::address_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::address)'         + '\n' +
							'     21) thor_data400::key::sexoffender::autokey::citystname_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::citystname)'         + '\n' +
							'     22) thor_data400::key::sexoffender::autokey::name_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::name)'         + '\n' +
							'     23) thor_data400::key::sexoffender::autokey::payload_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::payload)'         + '\n' +
							'     24) thor_data400::key::sexoffender::autokey::ssn2_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::ssn2)'         + '\n' +
							'     25) thor_data400::key::sexoffender::autokey::stname_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::stname)'         + '\n' +
							'     26) thor_data400::key::sexoffender::autokey::zip_qa (thor_data400::key::sexoffender::'+filedate+'::autokey::zip)'         + '\n' +
							'         have been built and ready to be deployed to QA.' + '\n');

// DF-21836 Show counts of blanked out fields in thor_data400::key::sexoffender::fcra::spkpublic_qa
cnt_so_spkpublic_fcra := OUTPUT(strata.macf_pops(sexoffender.key_SexOffender_SPK (true),,,,,,FALSE,
																									['addl_comments_1','addl_comments_2','age','build_type','corrective_lense_flag','dna','dob_aka','doc_number','employer','employer_address_1',
																									 'employer_address_2','employer_address_3','employer_address_4','employer_address_5','employer_comments','employer_county',
																									 'employer_phone','ethnicity','fbi_number','fingerprint_date','fingerprint_link','image_date','image_link','intnet_email_address_1',
																									 'intnet_email_address_2','intnet_email_address_3','intnet_email_address_4','intnet_email_address_5','intnet_instant_message_addr_1',
																									 'intnet_instant_message_addr_2','intnet_instant_message_addr_3','intnet_instant_message_addr_4','intnet_instant_message_addr_5','intnet_user_name_1',
																									 'intnet_user_name_1_url','intnet_user_name_2','intnet_user_name_2_url','intnet_user_name_3','intnet_user_name_3_url',
																									 'intnet_user_name_4','intnet_user_name_4_url','intnet_user_name_5','intnet_user_name_5_url','ncic_number',
																									 'offender_category','offender_status','orig_dl_date','orig_dl_link','orig_dl_number',
																									 'orig_dl_state','orig_registration_number_1','orig_registration_number_2','orig_registration_number_3','orig_registration_number_4',
																									 'orig_registration_number_5','orig_state','orig_state_code','orig_veh_color_1','orig_veh_color_2',
																									 'orig_veh_color_3','orig_veh_color_4','orig_veh_color_5','orig_veh_location_1','orig_veh_location_2',
																									 'orig_veh_location_3','orig_veh_location_4','orig_veh_location_5','orig_veh_make_model_1','orig_veh_make_model_2',
																									 'orig_veh_make_model_3','orig_veh_make_model_4','orig_veh_make_model_5','orig_veh_plate_1','orig_veh_plate_2',
																									 'orig_veh_plate_3','orig_veh_plate_4','orig_veh_plate_5','orig_veh_state_1','orig_veh_state_2',
																									 'orig_veh_state_3','orig_veh_state_4','orig_veh_state_5','orig_veh_year_1','orig_veh_year_2',
																									 'orig_veh_year_3','orig_veh_year_4','orig_veh_year_5','other_registration_address_1','other_registration_address_2',
																									 'other_registration_address_3','other_registration_address_4','other_registration_address_5','other_registration_county','other_registration_phone',
																									 'palmprint_date','palmprint_link','passport_authority','passport_code','passport_date',
																									 'passport_dob','passport_endorsement','passport_expiration_date','passport_first_name','passport_given_name',
																									 'passport_issue_date','passport_link','passport_nationality','passport_number','passport_place_of_birth',
																									 'passport_sex','passport_type','police_agency','police_agency_address_1','police_agency_address_2',
																									 'police_agency_contact_name','police_agency_phone','professional_licenses_1','professional_licenses_2','professional_licenses_3',
																									 'professional_licenses_4','professional_licenses_5','reg_date_1_type','reg_date_2','reg_date_2_type',
																									 'reg_date_3','reg_date_3_type','registration_address_3','registration_address_4','registration_address_5',
																									 'registration_cell_phone','registration_home_phone','registration_type','risk_description','risk_level_code',
																									 'scars_marks_tattoos','school','school_address_1','school_address_2','school_address_3',
																									 'school_address_4','school_address_5','school_comments','school_county','school_phone',
																									 'shoe_size','skin_tone','ssn','st_id_number','temp_lodge_address_1',
																									 'temp_lodge_address_2','temp_lodge_address_3','temp_lodge_address_4','temp_lodge_address_5','temp_lodge_county','temp_lodge_phone']));
cnt_so_offenses_fcra := OUTPUT(strata.macf_pops(sexoffender.key_sexoffender_offenses(true),,,,,,FALSE,
																									['arrest_date','arrest_warrant','conviction_date','conviction_jurisdiction','court','court_case_number',
																									 'offense_category','offense_code_or_statute','offense_date','offense_description','offense_description_2',
																									 'sentence_description','sentence_description_2','victim_age','victim_gender','victim_minor','victim_relationship']));

return sequential(dofirst, dosecond, dosecond2, dothird, dofourth, cnt_so_spkpublic_fcra, cnt_so_offenses_fcra);
// Removed the steps that completed successfully in the previous run -- This is for sandboxing only
//return sequential(dosecond, dothird, dofourth);

end;