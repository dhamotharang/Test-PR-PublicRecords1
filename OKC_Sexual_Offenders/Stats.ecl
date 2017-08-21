import SexOffender, lib_stringlib, strata;

string12 v_run_type := OKC_sexual_offenders.Version_Development + 'okc';

my_layout_sex_pred_2 := record
SexOffender.Layout_Accurint_Mainfile;
string2	newline;
end;

sex_pred_2 := dataset('~thor_200::base::okc_sex_offender_file_accurint_in', my_layout_sex_pred_2, flat);
b := sex_pred_2;


my_layout_sex_pred_search := record
SexOffender.Layout_Accurint_SearchFile;
string2 newline;
end;

sex_pred_search := dataset('~thor_200::base::okc_sex_offender_search_file', my_layout_sex_pred_search, flat);
s := sex_pred_search;




b_slim_layout := record
b.dt_first_reported;
b.dt_last_reported;
b.orig_state;
b.seisint_primary_key;
b.vendor_code;
//new fields////////////////////
b.intnet_email_address_1;
b.intnet_email_address_2;
b.intnet_email_address_3;
b.intnet_email_address_4;
b.intnet_email_address_5;
b.intnet_instant_message_addr_1;
b.intnet_instant_message_addr_2;
b.intnet_instant_message_addr_3;
b.intnet_instant_message_addr_4;
b.intnet_instant_message_addr_5;
b.intnet_user_name_1;
b.intnet_user_name_1_url;
b.intnet_user_name_2;
b.intnet_user_name_2_url;
b.intnet_user_name_3;
b.intnet_user_name_3_url;
b.intnet_user_name_4;
b.intnet_user_name_4_url;
b.intnet_user_name_5;
b.intnet_user_name_5_url;
///////////////////////////////
b.source_file;
b.name_orig;
b.lname;
b.fname;
b.mname;
b.name_suffix;
b.name_type;
b.offender_status;
b.offender_category;
b.risk_level_code;
b.risk_description;
b.police_agency;
b.police_agency_contact_name;
b.police_agency_address_1;
b.police_agency_address_2;
b.police_agency_phone;
b.registration_type;
b.reg_date_1;
b.reg_date_1_type;
b.reg_date_2;
b.reg_date_2_type;
b.reg_date_3;
b.reg_date_3_type;
b.registration_address_1;
b.registration_address_2;
b.registration_address_3;
b.registration_address_4;
b.registration_address_5;
b.registration_county;
//new fields///////////////////
b.registration_home_phone;
b.registration_cell_phone;
b.other_registration_address_1;
b.other_registration_address_2;
b.other_registration_address_3;
b.other_registration_address_4;
b.other_registration_address_5;
b.other_registration_county;
b.other_registration_phone;
b.temp_lodge_address_1;
b.temp_lodge_address_2;
b.temp_lodge_address_3;
b.temp_lodge_address_4;
b.temp_lodge_address_5;
b.temp_lodge_county;
b.temp_lodge_phone;
///////////////////////////////
b.employer;
b.employer_address_1;
b.employer_address_2;
b.employer_address_3;
b.employer_address_4;
b.employer_address_5;
b.employer_county;
//new fields /////////////
b.employer_phone;
b.employer_comments;
b.professional_licenses_1;
b.professional_licenses_2;
b.professional_licenses_3;
b.professional_licenses_4;
b.professional_licenses_5;
//////////////////////////
b.school;
b.school_address_1;
b.school_address_2;
b.school_address_3;
b.school_address_4;
b.school_address_5;
b.school_county;
b.school_phone;						//new field
b.school_comments;					//new field
b.offender_id;
b.doc_number;
b.sor_number;
b.st_id_number;
b.fbi_number;
b.ncic_number;
b.ssn;
b.dob;
b.dob_aka;
b.age;
b.dna;								//new field
b.race;
b.ethnicity;
b.sex;
b.hair_color;
b.eye_color;
b.height;
b.weight;
b.skin_tone;
b.build_type;
b.scars_marks_tattoos;
b.shoe_size;
b.corrective_lense_flag;
b.arrest_date_1;					//new field
b.arrest_warrant_1;					//new field
b.conviction_jurisdiction_1;
b.conviction_date_1;
b.court_1;
b.court_case_number_1;
b.offense_date_1;
b.offense_code_or_statute_1;
b.offense_description_1;
b.offense_description_1_2;
b.victim_minor_1;
b.victim_age_1;
b.victim_gender_1;
b.victim_relationship_1;
b.sentence_description_1;
b.sentence_description_1_2;
b.arrest_date_2;					//new field
b.arrest_warrant_2;					//new field
b.conviction_jurisdiction_2;
b.conviction_date_2;
b.court_2;
b.court_case_number_2;
b.offense_date_2;
b.offense_code_or_statute_2;
b.offense_description_2;
b.offense_description_2_2;
b.victim_minor_2;
b.victim_age_2;
b.victim_gender_2;
b.victim_relationship_2;
b.sentence_description_2;
b.sentence_description_2_2;
b.arrest_date_3;					//new field
b.arrest_warrant_3;					//new field
b.conviction_jurisdiction_3;
b.conviction_date_3;
b.court_3;
b.court_case_number_3;
b.offense_date_3;
b.offense_code_or_statute_3;
b.offense_description_3;
b.offense_description_3_2;
b.victim_minor_3;
b.victim_age_3;
b.victim_gender_3;
b.victim_relationship_3;
b.sentence_description_3;
b.sentence_description_3_2;
b.arrest_date_4;					//new field
b.arrest_warrant_4;					//new field
b.conviction_jurisdiction_4;
b.conviction_date_4;
b.court_4;
b.court_case_number_4;
b.offense_date_4;
b.offense_code_or_statute_4;
b.offense_description_4;
b.offense_description_4_2;
b.victim_minor_4;
b.victim_age_4;
b.victim_gender_4;
b.victim_relationship_4;
b.sentence_description_4;
b.sentence_description_4_2;
b.arrest_date_5;					//new field
b.arrest_warrant_5;					//new field
b.conviction_jurisdiction_5;
b.conviction_date_5;
b.court_5;
b.court_case_number_5;
b.offense_date_5;
b.offense_code_or_statute_5;
b.offense_description_5;
b.offense_description_5_2;
b.victim_minor_5;
b.victim_age_5;
b.victim_gender_5;
b.victim_relationship_5;
b.sentence_description_5;
b.sentence_description_5_2;
b.addl_comments_1;
b.addl_comments_2;
b.orig_dl_number;
b.orig_dl_state;
//new fields //////////////
b.orig_dl_link;
b.orig_dl_date;
b.passport_type;
b.passport_code;
b.passport_number;
b.passport_first_name;
b.passport_given_name;
b.passport_nationality;
b.passport_dob;
b.passport_place_of_birth;
b.passport_sex;
b.passport_issue_date;
b.passport_authority;
b.passport_expiration_date;
b.passport_endorsement;
b.passport_link;
b.passport_date;
///////////////////////////
b.orig_veh_year_1;
b.orig_veh_color_1;
b.orig_veh_make_model_1;
b.orig_veh_plate_1;
b.orig_registration_number_1;		//new field
b.orig_veh_state_1;
b.orig_veh_location_1;				//new field
b.orig_veh_year_2;
b.orig_veh_color_2;
b.orig_veh_make_model_2;
b.orig_veh_plate_2;
b.orig_registration_number_2;		//new field
b.orig_veh_state_2;
//new fields/////////////////
b.orig_veh_location_2;
b.orig_veh_year_3;
b.orig_veh_color_3;
b.orig_veh_make_model_3;
b.orig_veh_plate_3;
b.orig_registration_number_3;
b.orig_veh_state_3;
b.orig_veh_location_3;
b.orig_veh_year_4;
b.orig_veh_color_4;
b.orig_veh_make_model_4;
b.orig_veh_plate_4;
b.orig_registration_number_4;
b.orig_veh_state_4;
b.orig_veh_location_4;
b.orig_veh_year_5;
b.orig_veh_color_5;
b.orig_veh_make_model_5;
b.orig_veh_plate_5;
b.orig_registration_number_5;
b.orig_veh_state_5;
b.orig_veh_location_5;
b.fingerprint_link;
b.fingerprint_date;
b.palmprint_link;
b.palmprint_date;
/////////////////////////////
b.image_link;
b.image_date;
end;


s_slim_layout := record
s.seisint_primary_key;
s.dt_last_reported;
s.vendor_code;
s.source_file;
s.orig_state;
s.name_orig;
s.name_type;
s.ssn;
s.dob;
s.dob_aka;
s.registration_address_1;
s.registration_address_2;
s.registration_address_3;
s.registration_address_4;
s.registration_address_5;
s.title;
s.fname;
s.mname;
s.lname;
s.name_suffix;
s.cleaning_score;
s.prim_range;
s.predir;
s.prim_name;
s.addr_suffix;
s.postdir;
s.unit_desig;
s.sec_range;
s.p_city_name;
s.v_city_name;
s.st;
s.zip;
s.zip4;
s.cart;
s.cr_sort_sz;
s.lot;
s.lot_order;
s.dpbc;
s.chk_digit;
s.rec_type;
s.fips_st;
s.fips_county;
s.geo_lat;
s.geo_long;
s.msa;
s.geo_blk;
s.geo_match;
s.err_stat;
s.did;
s.did_score;
s.ssn_appended;
end;


b_slim := table(b, b_slim_layout);

s_slim := table(s, s_slim_layout);

b_stat_layout := record
string2 		b_orig_state 							  := b.orig_state;
string2		    b_vendor_code							  := b.vendor_code;
string12		b_run_type							  := v_run_type;
integer4 		b_total								  := count(group);
integer4        has_b_dt_first_reported               := AVE(group, IF (b.dt_first_reported <>'',100,0));
integer4        has_b_dt_last_reported                := AVE(group, IF (b.dt_last_reported <>'',100,0));
integer4        has_b_orig_state                      := AVE(group, IF (b.orig_state <>'',100,0));
integer4        has_b_seisint_primary_key             := AVE(group, IF (b.seisint_primary_key <>'',100,0));
integer4        has_b_vendor_code                     := AVE(group, IF (b.vendor_code <>'',100,0));
integer4        has_b_source_file                     := AVE(group, IF (b.source_file <>'',100,0));
integer4        has_b_name_orig                       := AVE(group, IF (b.name_orig <>'',100,0));
integer4        has_b_lname                           := AVE(group, IF (b.lname <>'',100,0));
integer4        has_b_fname                           := AVE(group, IF (b.fname <>'',100,0));
integer4        has_b_mname                           := AVE(group, IF (b.mname <>'',100,0));
integer4        has_b_name_suffix                     := AVE(group, IF (b.name_suffix <>'',100,0));
integer4        has_b_name_type                       := AVE(group, IF (b.name_type <>'',100,0));
integer4        has_b_offender_status                 := AVE(group, IF (b.offender_status <>'',100,0));
integer4        has_b_offender_category               := AVE(group, IF (b.offender_category <>'',100,0));
integer4        has_b_risk_level_code                 := AVE(group, IF (b.risk_level_code <>'',100,0));
integer4        has_b_risk_description                := AVE(group, IF (b.risk_description <>'',100,0));
integer4        has_b_police_agency                   := AVE(group, IF (b.police_agency <>'',100,0));
integer4        has_b_police_agency_contact_name      := AVE(group, IF (b.police_agency_contact_name <>'',100,0));
integer4        has_b_police_agency_address_1         := AVE(group, IF (b.police_agency_address_1 <>'',100,0));
integer4        has_b_police_agency_address_2         := AVE(group, IF (b.police_agency_address_2 <>'',100,0));
integer4        has_b_police_agency_phone             := AVE(group, IF (b.police_agency_phone <>'',100,0));
integer4        has_b_registration_type               := AVE(group, IF (b.registration_type <>'',100,0));
integer4        has_b_reg_date_1                      := AVE(group, IF (b.reg_date_1 <>'',100,0));
integer4        has_b_reg_date_1_type                 := AVE(group, IF (b.reg_date_1_type <>'',100,0));
integer4        has_b_reg_date_2                      := AVE(group, IF (b.reg_date_2 <>'',100,0));
integer4        has_b_reg_date_2_type                 := AVE(group, IF (b.reg_date_2_type <>'',100,0));
integer4        has_b_reg_date_3                      := AVE(group, IF (b.reg_date_3 <>'',100,0));
integer4        has_b_reg_date_3_type                 := AVE(group, IF (b.reg_date_3_type <>'',100,0));
integer4        has_b_registration_address_1          := AVE(group, IF (b.registration_address_1 <>'',100,0));
integer4        has_b_registration_address_2          := AVE(group, IF (b.registration_address_2 <>'',100,0));
integer4        has_b_registration_address_3          := AVE(group, IF (b.registration_address_3 <>'',100,0));
integer4        has_b_registration_address_4          := AVE(group, IF (b.registration_address_4 <>'',100,0));
integer4        has_b_registration_address_5          := AVE(group, IF (b.registration_address_5 <>'',100,0));
integer4        has_b_registration_county             := AVE(group, IF (b.registration_county <>'',100,0));
integer4        has_b_employer                        := AVE(group, IF (b.employer <>'',100,0));
integer4        has_b_employer_address_1              := AVE(group, IF (b.employer_address_1 <>'',100,0));
integer4        has_b_employer_address_2              := AVE(group, IF (b.employer_address_2 <>'',100,0));
integer4        has_b_employer_address_3              := AVE(group, IF (b.employer_address_3 <>'',100,0));
integer4        has_b_employer_address_4              := AVE(group, IF (b.employer_address_4 <>'',100,0));
integer4        has_b_employer_address_5              := AVE(group, IF (b.employer_address_5 <>'',100,0));
integer4        has_b_employer_county                 := AVE(group, IF (b.employer_county <>'',100,0));
integer4        has_b_school                          := AVE(group, IF (b.school <>'',100,0));
integer4        has_b_school_address_1                := AVE(group, IF (b.school_address_1 <>'',100,0));
integer4        has_b_school_address_2                := AVE(group, IF (b.school_address_2 <>'',100,0));
integer4        has_b_school_address_3                := AVE(group, IF (b.school_address_3 <>'',100,0));
integer4        has_b_school_address_4                := AVE(group, IF (b.school_address_4 <>'',100,0));
integer4        has_b_school_address_5                := AVE(group, IF (b.school_address_5 <>'',100,0));
integer4        has_b_school_county                   := AVE(group, IF (b.school_county <>'',100,0));
integer4        has_b_offender_id                     := AVE(group, IF (b.offender_id <>'',100,0));
integer4        has_b_doc_number                      := AVE(group, IF (b.doc_number <>'',100,0));
integer4        has_b_sor_number                      := AVE(group, IF (b.sor_number <>'',100,0));
integer4        has_b_st_id_number                    := AVE(group, IF (b.st_id_number <>'',100,0));
integer4        has_b_fbi_number                      := AVE(group, IF (b.fbi_number <>'',100,0));
integer4        has_b_ncic_number                     := AVE(group, IF (b.ncic_number <>'',100,0));
integer4        has_b_ssn                             := AVE(group, IF (b.ssn <>'',100,0));
integer4        has_b_dob                             := AVE(group, IF (b.dob <>'',100,0));
integer4        has_b_dob_aka                         := AVE(group, IF (b.dob_aka <>'',100,0));
integer4        has_b_age                             := AVE(group, IF (b.age <>'',100,0));
integer4        has_b_race                            := AVE(group, IF (b.race <>'',100,0));
integer4        has_b_ethnicity                       := AVE(group, IF (b.ethnicity <>'',100,0));
integer4        has_b_sex                             := AVE(group, IF (b.sex <>'',100,0));
integer4        has_b_hair_color                      := AVE(group, IF (b.hair_color <>'',100,0));
integer4        has_b_eye_color                       := AVE(group, IF (b.eye_color <>'',100,0));
integer4        has_b_height                          := AVE(group, IF (b.height <>'',100,0));
integer4        has_b_weight                          := AVE(group, IF (b.weight <>'',100,0));
integer4        has_b_skin_tone                       := AVE(group, IF (b.skin_tone <>'',100,0));
integer4        has_b_build_type                      := AVE(group, IF (b.build_type <>'',100,0));
integer4        has_b_scars_marks_tattoos             := AVE(group, IF (b.scars_marks_tattoos <>'',100,0));
integer4        has_b_shoe_size                       := AVE(group, IF (b.shoe_size <>'',100,0));
integer4        has_b_corrective_lense_flag           := AVE(group, IF (b.corrective_lense_flag <>'',100,0));
integer4        has_b_conviction_jurisdiction_1       := AVE(group, IF (b.conviction_jurisdiction_1 <>'',100,0));
integer4        has_b_conviction_date_1               := AVE(group, IF (b.conviction_date_1 <>'',100,0));
integer4        has_b_court_1                         := AVE(group, IF (b.court_1 <>'',100,0));
integer4        has_b_court_case_number_1             := AVE(group, IF (b.court_case_number_1 <>'',100,0));
integer4        has_b_offense_date_1                  := AVE(group, IF (b.offense_date_1 <>'',100,0));
integer4        has_b_offense_code_or_statute_1       := AVE(group, IF (b.offense_code_or_statute_1 <>'',100,0));
integer4        has_b_offense_description_1           := AVE(group, IF (b.offense_description_1 <>'',100,0));
integer4        has_b_offense_description_1_2         := AVE(group, IF (b.offense_description_1_2 <>'',100,0));
integer4        has_b_victim_minor_1                  := AVE(group, IF (b.victim_minor_1 <>'',100,0));
integer4        has_b_victim_age_1                    := AVE(group, IF (b.victim_age_1 <>'',100,0));
integer4        has_b_victim_gender_1                 := AVE(group, IF (b.victim_gender_1 <>'',100,0));
integer4        has_b_victim_relationship_1           := AVE(group, IF (b.victim_relationship_1 <>'',100,0));
integer4        has_b_sentence_description_1          := AVE(group, IF (b.sentence_description_1 <>'',100,0));
integer4        has_b_sentence_description_1_2        := AVE(group, IF (b.sentence_description_1_2 <>'',100,0));
integer4        has_b_conviction_jurisdiction_2       := AVE(group, IF (b.conviction_jurisdiction_2 <>'',100,0));
integer4        has_b_conviction_date_2               := AVE(group, IF (b.conviction_date_2 <>'',100,0));
integer4        has_b_court_2                         := AVE(group, IF (b.court_2 <>'',100,0));
integer4        has_b_court_case_number_2             := AVE(group, IF (b.court_case_number_2 <>'',100,0));
integer4        has_b_offense_date_2                  := AVE(group, IF (b.offense_date_2 <>'',100,0));
integer4        has_b_offense_code_or_statute_2       := AVE(group, IF (b.offense_code_or_statute_2 <>'',100,0));
integer4        has_b_offense_description_2           := AVE(group, IF (b.offense_description_2 <>'',100,0));
integer4        has_b_offense_description_2_2         := AVE(group, IF (b.offense_description_2_2 <>'',100,0));
integer4        has_b_victim_minor_2                  := AVE(group, IF (b.victim_minor_2 <>'',100,0));
integer4        has_b_victim_age_2                    := AVE(group, IF (b.victim_age_2 <>'',100,0));
integer4        has_b_victim_gender_2                 := AVE(group, IF (b.victim_gender_2 <>'',100,0));
integer4        has_b_victim_relationship_2           := AVE(group, IF (b.victim_relationship_2 <>'',100,0));
integer4        has_b_sentence_description_2          := AVE(group, IF (b.sentence_description_2 <>'',100,0));
integer4        has_b_sentence_description_2_2        := AVE(group, IF (b.sentence_description_2_2 <>'',100,0));
integer4        has_b_conviction_jurisdiction_3       := AVE(group, IF (b.conviction_jurisdiction_3 <>'',100,0));
integer4        has_b_conviction_date_3               := AVE(group, IF (b.conviction_date_3 <>'',100,0));
integer4        has_b_court_3                         := AVE(group, IF (b.court_3 <>'',100,0));
integer4        has_b_court_case_number_3             := AVE(group, IF (b.court_case_number_3 <>'',100,0));
integer4        has_b_offense_date_3                  := AVE(group, IF (b.offense_date_3 <>'',100,0));
integer4        has_b_offense_code_or_statute_3       := AVE(group, IF (b.offense_code_or_statute_3 <>'',100,0));
integer4        has_b_offense_description_3           := AVE(group, IF (b.offense_description_3 <>'',100,0));
integer4        has_b_offense_description_3_2         := AVE(group, IF (b.offense_description_3_2 <>'',100,0));
integer4        has_b_victim_minor_3                  := AVE(group, IF (b.victim_minor_3 <>'',100,0));
integer4        has_b_victim_age_3                    := AVE(group, IF (b.victim_age_3 <>'',100,0));
integer4        has_b_victim_gender_3                 := AVE(group, IF (b.victim_gender_3 <>'',100,0));
integer4        has_b_victim_relationship_3           := AVE(group, IF (b.victim_relationship_3 <>'',100,0));
integer4        has_b_sentence_description_3          := AVE(group, IF (b.sentence_description_3 <>'',100,0));
integer4        has_b_sentence_description_3_2        := AVE(group, IF (b.sentence_description_3_2 <>'',100,0));
integer4        has_b_conviction_jurisdiction_4       := AVE(group, IF (b.conviction_jurisdiction_4 <>'',100,0));
integer4        has_b_conviction_date_4               := AVE(group, IF (b.conviction_date_4 <>'',100,0));
integer4        has_b_court_4                         := AVE(group, IF (b.court_4 <>'',100,0));
integer4        has_b_court_case_number_4             := AVE(group, IF (b.court_case_number_4 <>'',100,0));
integer4        has_b_offense_date_4                  := AVE(group, IF (b.offense_date_4 <>'',100,0));
integer4        has_b_offense_code_or_statute_4       := AVE(group, IF (b.offense_code_or_statute_4 <>'',100,0));
integer4        has_b_offense_description_4           := AVE(group, IF (b.offense_description_4 <>'',100,0));
integer4        has_b_offense_description_4_2         := AVE(group, IF (b.offense_description_4_2 <>'',100,0));
integer4        has_b_victim_minor_4                  := AVE(group, IF (b.victim_minor_4 <>'',100,0));
integer4        has_b_victim_age_4                    := AVE(group, IF (b.victim_age_4 <>'',100,0));
integer4        has_b_victim_gender_4                 := AVE(group, IF (b.victim_gender_4 <>'',100,0));
integer4        has_b_victim_relationship_4           := AVE(group, IF (b.victim_relationship_4 <>'',100,0));
integer4        has_b_sentence_description_4          := AVE(group, IF (b.sentence_description_4 <>'',100,0));
integer4        has_b_sentence_description_4_2        := AVE(group, IF (b.sentence_description_4_2 <>'',100,0));
integer4        has_b_conviction_jurisdiction_5       := AVE(group, IF (b.conviction_jurisdiction_5 <>'',100,0));
integer4        has_b_conviction_date_5               := AVE(group, IF (b.conviction_date_5 <>'',100,0));
integer4        has_b_court_5                         := AVE(group, IF (b.court_5 <>'',100,0));
integer4        has_b_court_case_number_5             := AVE(group, IF (b.court_case_number_5 <>'',100,0));
integer4        has_b_offense_date_5                  := AVE(group, IF (b.offense_date_5 <>'',100,0));
integer4        has_b_offense_code_or_statute_5       := AVE(group, IF (b.offense_code_or_statute_5 <>'',100,0));
integer4        has_b_offense_description_5           := AVE(group, IF (b.offense_description_5 <>'',100,0));
integer4        has_b_offense_description_5_2         := AVE(group, IF (b.offense_description_5_2 <>'',100,0));
integer4        has_b_victim_minor_5                  := AVE(group, IF (b.victim_minor_5 <>'',100,0));
integer4        has_b_victim_age_5                    := AVE(group, IF (b.victim_age_5 <>'',100,0));
integer4        has_b_victim_gender_5                 := AVE(group, IF (b.victim_gender_5 <>'',100,0));
integer4        has_b_victim_relationship_5           := AVE(group, IF (b.victim_relationship_5 <>'',100,0));
integer4        has_b_sentence_description_5          := AVE(group, IF (b.sentence_description_5 <>'',100,0));
integer4        has_b_sentence_description_5_2        := AVE(group, IF (b.sentence_description_5_2 <>'',100,0));
integer4        has_b_addl_comments_1                 := AVE(group, IF (b.addl_comments_1 <>'',100,0));
integer4        has_b_addl_comments_2                 := AVE(group, IF (b.addl_comments_2 <>'',100,0));
integer4        has_b_orig_dl_number                  := AVE(group, IF (b.orig_dl_number <>'',100,0));
integer4        has_b_orig_dl_state                   := AVE(group, IF (b.orig_dl_state <>'',100,0));
integer4        has_b_orig_veh_year_1                 := AVE(group, IF (b.orig_veh_year_1 <>'',100,0));
integer4        has_b_orig_veh_color_1                := AVE(group, IF (b.orig_veh_color_1 <>'',100,0));
integer4        has_b_orig_veh_make_model_1           := AVE(group, IF (b.orig_veh_make_model_1 <>'',100,0));
integer4        has_b_orig_veh_plate_1                := AVE(group, IF (b.orig_veh_plate_1 <>'',100,0));
integer4        has_b_orig_veh_state_1                := AVE(group, IF (b.orig_veh_state_1 <>'',100,0));
integer4        has_b_orig_veh_year_2                 := AVE(group, IF (b.orig_veh_year_2 <>'',100,0));
integer4        has_b_orig_veh_color_2                := AVE(group, IF (b.orig_veh_color_2 <>'',100,0));
integer4        has_b_orig_veh_make_model_2           := AVE(group, IF (b.orig_veh_make_model_2 <>'',100,0));
integer4        has_b_orig_veh_plate_2                := AVE(group, IF (b.orig_veh_plate_2 <>'',100,0));
integer4        has_b_orig_veh_state_2                := AVE(group, IF (b.orig_veh_state_2 <>'',100,0));
integer4        has_b_image_link                      := AVE(group, IF (b.image_link <>'',100,0));
integer4	    has_b_image_link_jpg				  := AVE(group, IF (lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.JPG' , 1)<>0,100,0));
integer4	    has_b_image_link_jpeg				  := AVE(group, IF (lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.JPEG', 1)<>0,100,0));
integer4	    has_b_image_link_gif				  := AVE(group, IF (lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.GIF' , 1)<>0,100,0));
integer4	    has_b_image_link_tif				  := AVE(group, IF (lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.TIF' , 1)<>0,100,0));
integer4	    has_b_image_link_bmp				  := AVE(group, IF (lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.BMP' , 1)<>0,100,0));
integer4	    has_b_image_link_bad				  := AVE(group, IF (b.image_link<> '' AND
																		lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.JPG' , 1)=0  AND
																		lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.JPEG', 1)=0  AND
																		lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.GIF' , 1)=0  AND
																		lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.BMP' , 1)=0  AND
																		lib_stringlib.stringlib.stringfind(lib_stringlib.stringlib.stringtouppercase(b.image_link), '.TIF' , 1)=0 ,100,0));
integer4        has_b_image_date                      := AVE(group, IF (b.image_date <>'',100,0));
end;

s_stat_layout := record
string2 	s_orig_state := s.orig_state;
string2		s_vendor_code := s.vendor_code;
string12	s_run_type							  		:= v_run_type;
integer4 	s_total										:= count(group);
integer4	has_s_seisint_primary_key					:= AVE(group, IF (s.seisint_primary_key 	 <>'',100,0));
integer4	has_s_dt_last_reported						:= AVE(group, IF (s.dt_last_reported         <>'',100,0));
integer4	has_s_vendor_code							:= AVE(group, IF (s.vendor_code 	         <>'',100,0));
integer4	has_s_source_file							:= AVE(group, IF (s.source_file 	         <>'',100,0));
integer4	has_s_orig_state							:= AVE(group, IF (s.orig_state 	             <>'',100,0));
integer4	has_s_name_orig								:= AVE(group, IF (s.name_orig 	             <>'',100,0));
integer4	has_s_name_type								:= AVE(group, IF (s.name_type 	             <>'',100,0));
integer4	has_s_ssn									:= AVE(group, IF (s.ssn 	                 <>'',100,0));
integer4	has_s_dob									:= AVE(group, IF (s.dob 	                 <>'',100,0));
integer4	has_s_dob_aka								:= AVE(group, IF (s.dob_aka 	             <>'',100,0));
integer4	has_s_registration_address_1				:= AVE(group, IF (s.registration_address_1 	 <>'',100,0));
integer4	has_s_registration_address_2				:= AVE(group, IF (s.registration_address_2 	 <>'',100,0));
integer4	has_s_registration_address_3				:= AVE(group, IF (s.registration_address_3 	 <>'',100,0));
integer4	has_s_registration_address_4				:= AVE(group, IF (s.registration_address_4 	 <>'',100,0));
integer4	has_s_registration_address_5				:= AVE(group, IF (s.registration_address_5 	 <>'',100,0));
integer4	has_s_title									:= AVE(group, IF (s.title 	                 <>'',100,0));
integer4	has_s_fname									:= AVE(group, IF (s.fname 	                 <>'',100,0));
integer4	has_s_mname									:= AVE(group, IF (s.mname 	                 <>'',100,0));
integer4	has_s_lname									:= AVE(group, IF (s.lname 	                 <>'',100,0));
integer4	has_s_name_suffix							:= AVE(group, IF (s.name_suffix 	         <>'',100,0));
integer4	has_s_cleaning_score						:= AVE(group, IF (s.cleaning_score 	         <>'',100,0));
integer4	has_s_prim_range							:= AVE(group, IF (s.prim_range 	             <>'',100,0));
integer4	has_s_predir								:= AVE(group, IF (s.predir 	                 <>'',100,0));
integer4	has_s_prim_name								:= AVE(group, IF (s.prim_name 	             <>'',100,0));
integer4	has_s_addr_suffix							:= AVE(group, IF (s.addr_suffix 	         <>'',100,0));
integer4	has_s_postdir								:= AVE(group, IF (s.postdir 	             <>'',100,0));
integer4	has_s_unit_desig							:= AVE(group, IF (s.unit_desig 	             <>'',100,0));
integer4	has_s_sec_range								:= AVE(group, IF (s.sec_range 	             <>'',100,0));
integer4	has_s_p_city_name							:= AVE(group, IF (s.p_city_name 	         <>'',100,0));
integer4	has_s_v_city_name							:= AVE(group, IF (s.v_city_name 	         <>'',100,0));
integer4	has_s_st									:= AVE(group, IF (s.st 	                     <>'',100,0));
integer4	has_s_zip									:= AVE(group, IF (s.zip 	                 <>'' 
                                                                      AND s.zip                      <>'00000',100,0));
integer4	has_s_zip4									:= AVE(group, IF (s.zip4 	                 <>'',100,0));
integer4	has_s_cart									:= AVE(group, IF (s.cart 	                 <>'',100,0));
integer4	has_s_cr_sort_sz							:= AVE(group, IF (s.cr_sort_sz 	             <>'',100,0));
integer4	has_s_lot									:= AVE(group, IF (s.lot 	                 <>'',100,0));
integer4	has_s_lot_order								:= AVE(group, IF (s.lot_order 	             <>'',100,0));
integer4	has_s_dpbc									:= AVE(group, IF (s.dpbc 	                 <>'',100,0));
integer4	has_s_chk_digit								:= AVE(group, IF (s.chk_digit 	             <>'',100,0));
integer4	has_s_rec_type								:= AVE(group, IF (s.rec_type 	             <>'',100,0));
integer4	has_s_fips_st								:= AVE(group, IF (s.fips_st 	             <>'',100,0));
integer4	has_s_fips_county							:= AVE(group, IF (s.fips_county 	         <>'',100,0));
integer4	has_s_geo_lat								:= AVE(group, IF (s.geo_lat 	             <>'',100,0));
integer4	has_s_geo_long								:= AVE(group, IF (s.geo_long     	         <>'',100,0));
integer4	has_s_msa									:= AVE(group, IF (s.msa 	                 <>'',100,0));
integer4	has_s_geo_blk								:= AVE(group, IF (s.geo_blk 	             <>'',100,0));
integer4	has_s_geo_match								:= AVE(group, IF (s.geo_match 	             <>'',100,0));
integer4	has_s_err_stat								:= AVE(group, IF (s.err_stat 	             <>'',100,0));
integer4	has_s_did									:= AVE(group, IF (s.did 	                 <>'',100,0));
integer4	has_s_did_score								:= AVE(group, IF (s.did_score 	             <>''
                                                                      AND s.did_score                <>'0',100,0));
integer4	has_s_ssn_appended							:= AVE(group, IF (s.ssn_appended 	         <>'',100,0));
end;

b_stat := table(b, b_stat_layout, orig_state,vendor_code, few);
//final _b output(sort(b_stat,b_orig_state,b_vendor_code));

s_stat := table(s, s_stat_layout, orig_state,vendor_code, few);
srt_s_stat := sort(s_stat,s_orig_state,s_vendor_code);
//output(sort(s_stat,orig_state,vendor_code));
//output(srt_s_stat);

//dis_s  := distribute(s, hash(did));
filtered_s := distribute(s(trim(did,left,right) <> '' and (integer)did <> 0),hash(orig_state));
sort_deduped_s_by_did := dedup(sort(filtered_s, did, orig_state, local), did, orig_state, local);
//output(count(sort_deduped_s_by_did),named('UniqueDidCount'));
s_did_stat_by_st := table(sort_deduped_s_by_did, {orig_state, Total := count(group)}, orig_state);
srt_s_did_stat_by_st := sort(s_did_stat_by_st, orig_state);
//output(srt_s_did_stat_by_st);

b_stat_layout_out := record
	recordof(srt_s_stat);
	unsigned5 uniq_did_cnt := 0;
end;
b_stat_layout_out trfJoinStats(srt_s_stat l, srt_s_did_stat_by_st r) := transform
	self.uniq_did_cnt := r.Total;
	self := l;
end;
merged_s_stats := join(srt_s_stat, srt_s_did_stat_by_st, left.s_orig_state = right.orig_state, trfJoinStats(left,right), full outer);
sorted_merged_s_stats := sort(merged_s_stats, s_orig_state);
//output(merged_s_stats);


// ----------  Count of records with 1 sex offender key having > 1 did in the same orig_state.-------
sorted_s_by_st_key_did := sort(filtered_s, orig_state, seisint_primary_key, did, local); 
deduped_s_by_st_key_did := dedup(sorted_s_by_st_key_did, orig_state, seisint_primary_key, did);
s_st_key_stat := table(deduped_s_by_st_key_did, {orig_state, seisint_primary_key, cnt := count(group)}, orig_state, seisint_primary_key);
sorted_s_st_key_stat := sort(s_st_key_stat, orig_state, seisint_primary_key);
s_st_key_cnt_stat := table(sorted_s_st_key_stat(cnt>1), {orig_state, cnt2 := count(group)}, orig_state);
sorted_s_st_key_cnt2_stat := sort(s_st_key_cnt_stat, orig_state);
//output(sorted_s_st_key_cnt2_stat, named('keys_having_GT_1_DID_AKA'));

layout_same_key_more_did := record
	recordof(merged_s_stats);
	unsigned5 Same_key_more_did_cnt := 0;
end;
layout_same_key_more_did trfJoinMoreDidStats(sorted_merged_s_stats l, sorted_s_st_key_cnt2_stat r) := transform
	self.Same_key_more_did_cnt := r.cnt2;
	self := l;
end;
merged_s_stats_key_more_did_stat := join(sorted_merged_s_stats, sorted_s_st_key_cnt2_stat, left.s_orig_state = right.orig_state, trfJoinMoreDidStats(left,right), full outer);
sorted_merged_s_stats_key_more_did_stat := sorted(merged_s_stats_key_more_did_stat, s_orig_state);
//output(merged_s_stats_key_more_did_stat);

//------------- Count of records with 1 did having > 1 sex offender keys in the same orig_state. --------------

sorted_s_by_st_did_key := sort(filtered_s, orig_state, did, seisint_primary_key, local); 
deduped_s_by_st_did_key := dedup(sorted_s_by_st_did_key, orig_state, did, seisint_primary_key);
s_st_did_stat := table(deduped_s_by_st_did_key, {orig_state, did, cnt := count(group)}, orig_state, did);
sorted_s_st_did_stat := sort(s_st_did_stat, orig_state, did);
s_st_did_cnt_stat := table(sorted_s_st_did_stat(cnt>1), {orig_state, cnt2 := count(group)}, orig_state);
sorted_s_st_did_cnt2_stat := sort(s_st_did_cnt_stat, orig_state);
//output(sorted_s_st_did_cnt2_stat, named('DIDs_having_GT_1_key_DUP'));

layout_same_did_more_keys := record
	recordof(merged_s_stats_key_more_did_stat);
	unsigned5 Same_did_more_keys_cnt := 0;
end;
layout_same_did_more_keys trfJoinMoreKeysStats(merged_s_stats_key_more_did_stat l, sorted_s_st_did_cnt2_stat r) := transform
	self.Same_did_more_keys_cnt := r.cnt2;
	self := l;
end;
merged_s_stats_did_more_keys_stat := join(merged_s_stats_key_more_did_stat, sorted_s_st_did_cnt2_stat, left.s_orig_state = right.orig_state, trfJoinMoreKeysStats(left,right), full outer);
sorted_merged_s_stats_did_more_keys_stat := sorted(merged_s_stats_did_more_keys_stat, s_orig_state);
//final_s output(merged_s_stats_did_more_keys_stat);


layout_all_stats := record
 recordof(sorted_merged_s_stats_did_more_keys_stat);
 recordof(b_stat);
 end;

layout_all_stats trfallstats(sorted_merged_s_stats_did_more_keys_stat l, b_stat r) := transform
  self:=l;
  self:=r;
end;

all_stats := join(sorted_merged_s_stats_did_more_keys_stat, b_stat, left.s_orig_state =right.b_orig_state, trfallstats(left,right), full outer);

//output(all_stats);
//check to see all that went into the build vs the previous build
/*
stat_layout := record

	string s_orig_state;
	string s_run_type;
  integer4 CountGroup;

end;
*/
//do a comparision from previous to latest 
stat_layout := record

	string s_orig_state;
  integer4 CountGroup;
  integer s_total;
	integer b_total ;
	integer uniq_did_cnt;
	integer Same_did_more_keys_cnt;
	integer has_b_image_link;
	integer has_b_image_link_jpg;
  integer  has_b_image_link_jpeg;
	integer has_b_image_link_gif;
	integer has_b_image_link_bmp;
  integer  has_b_image_link_bad;
	integer has_b_ssn;
	integer has_b_orig_dl_number;
	integer has_b_orig_dl_state;
	integer has_b_dob;
	integer has_s_ssn;
	integer has_s_ssn_appended;
	integer has_s_did_score;
	integer has_s_zip;
end;



 stat_layout tStat(all_stats l) := transform
 self.CountGroup := l.s_total; 
 self := l;
 end;
 final_stat := project(all_stats, tStat(left));

okc_post_pop_stats := output(final_stat, named('OKC_POST_pop_stats'), all);
/*
 Stats := output(all_stats(), {
	 s_orig_state
	,s_run_type
	,s_total
	,b_total 
	,uniq_did_cnt
	,Same_did_more_keys_cnt
	,has_b_image_link
	,has_b_image_link_jpg
    ,has_b_image_link_jpeg
	,has_b_image_link_gif
	,has_b_image_link_bmp
    ,has_b_image_link_bad
	,has_b_ssn
	,has_b_orig_dl_number
	,has_b_orig_dl_state
	,has_b_dob
	,has_s_ssn
	,has_s_ssn_appended
	,has_s_did_score
	,has_s_zip});

sequential(stats);
*/
// add strata line here to send results.
/*STRATA.createXMLStats(final_stat,  
											'OKC_Sex_Offenders',
											'Base',
											okc_sexual_offenders.version_development,
											'jtao@seisint.com',
											zOKC_Sex_Pred_Post_Data_Stats,  
											'View',
										  'POST_BUILD_OKC_Sex_Offenders_Pop_Stats_v4')

*/
//export Stats :=sequential(okc_post_pop_stats,zOKC_Sex_Pred_Post_Data_Stats);
export Stats := okc_post_pop_stats;
#option('skipFileFormatCrcCheck', 1); 
Stats; 