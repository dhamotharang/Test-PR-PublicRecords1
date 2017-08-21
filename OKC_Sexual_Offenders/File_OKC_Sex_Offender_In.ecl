
import Digssoff, OKC_Sexual_Offenders_v2, OKC_Sexual_Offenders;

current := DATASET('~thor_200::in::digssoff::soff_okc_outfile', 
                                  Digssoff.Layout_Target_OKC_Layout,
																	csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"'),
																	MAXLENGTH(9999)))
																	(trim(name_orig,left,right) not in ['LAST_NAME, FIRST_NAME MIDDLE_NAME','name_orig'] 
																	and trim(state_of_origin,left,right) not in ['GU','PR','CO','MO','NE','NJ','NV','TX','WV','WY','SC']//,'KY','LA','RI','MO','ND']//VA has a legal restriction 
																	and trim(source)<>''
																	and name_orig != 'JEPSEN,JESSE CLYDE II'
															    //Filter out counties for now
																	and regexfind('Lake County|Cass County|Greene County|'+
																	'Jackson County|Laclede Co|Newton County|St. Louis County|'+
																	'TULSA, OKLAHOMA|Benton County|Clackamas, Oregon|MARION COUNTY|'+
																	'Yamhill County|Clark County|King County|Registered Sex Offender List|'+
																	'Cape Girardeau County|Jefferson County',trim(source),0)=''
																	);


//Rollback Alpharetta Data

rollback1 := dataset('~thor_200::in::digssoff::soff_okc_outfile20110322',
Digssoff.Layout_Target_OKC_Layout,
csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"'),
MAXLENGTH(9999)));
                                                                                                                                                
rollback_filter1 := rollback1(state_of_origin in ['SC']); 


rollback2 := dataset('~thor_200::in::digssoff::soff_okc_outfile20110808',
Digssoff.Layout_Target_OKC_Layout,
csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"'),
MAXLENGTH(9999)));                         
												 
												 
rollback_filter2 := rollback2(state_of_origin in ['WV']); 


rollback3 := dataset('~thor_200::in::digssoff::soff_okc_outfile20110817',
Digssoff.Layout_Target_OKC_Layout,
csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"'),
MAXLENGTH(9999)));
                                                                                                                                                
rollback_filter3 := rollback3(state_of_origin in ['CO']); 


rollback4 := dataset('~thor_200::in::digssoff::soff_okc_outfile20111003',
Digssoff.Layout_Target_OKC_Layout,
csv(separator('|'),terminator(['\r\n','\r','\n']),quote('"'),
MAXLENGTH(9999)));
                                                                                                                                                
rollback_filter4 := rollback4(state_of_origin in ['MO','NE','NJ','NV','TX','WY']);


concat_files := current + rollback_filter1 + rollback_filter2 + rollback_filter3 + rollback_filter4;
                                                                                                
                
								
//Fix Source Name
Digssoff.Layout_Target_OKC_Layout sourceFix(concat_files l) := transform
self.source := if(l.state_of_origin = 'MO' and trim(l.source,left,right) = 'State Highway Patrol',
                                                                'MO State Highway Patrol',
                                                                l.source);
self := l;
end;

fixSource := project(concat_files, sourceFix(left));
                                                                                                
fixSource_dist                   :=            distribute(fixSource,hash32(state_of_origin,source,name_orig));
fixSource_sort                  :=                sort(fixSource_dist,state_of_origin,source,name_orig,date_of_birth,orig_ssn,passport_first_name,passport_given_name,passport_nationality,passport_dob,passport_place_of_birth,-date_added,-date_updated,-image_date,local);

recordof(fixSource)        tRollup(fixSource_sort  le,fixSource_sort             ri)            :=
transform
                self.name_aka:= if(le.name_aka != '',le.name_aka,ri.name_aka);
                self.intnet_email_address_1:= if(le.intnet_email_address_1 != '',le.intnet_email_address_1,ri.intnet_email_address_1);
                self.intnet_email_address_2:= if(le.intnet_email_address_2 != '',le.intnet_email_address_2,ri.intnet_email_address_2);
                self.intnet_email_address_3:= if(le.intnet_email_address_3 != '',le.intnet_email_address_3,ri.intnet_email_address_3);
                self.intnet_email_address_4:= if(le.intnet_email_address_4 != '',le.intnet_email_address_4,ri.intnet_email_address_4);
                self.intnet_email_address_5:= if(le.intnet_email_address_5 != '',le.intnet_email_address_5,ri.intnet_email_address_5);
                self.intnet_instant_message_addr_1:= if(le.intnet_instant_message_addr_1 != '',le.intnet_instant_message_addr_1,ri.intnet_instant_message_addr_1);
                self.intnet_instant_message_addr_2:= if(le.intnet_instant_message_addr_2 != '',le.intnet_instant_message_addr_2,ri.intnet_instant_message_addr_2);
                self.intnet_instant_message_addr_3:= if(le.intnet_instant_message_addr_3 != '',le.intnet_instant_message_addr_3,ri.intnet_instant_message_addr_3);
                self.intnet_instant_message_addr_4:= if(le.intnet_instant_message_addr_4 != '',le.intnet_instant_message_addr_4,ri.intnet_instant_message_addr_4);
                self.intnet_instant_message_addr_5:= if(le.intnet_instant_message_addr_5 != '',le.intnet_instant_message_addr_5,ri.intnet_instant_message_addr_5);
                self.intnet_user_name_1:= if(le.intnet_user_name_1 != '',le.intnet_user_name_1,ri.intnet_user_name_1);
                self.intnet_user_name_1_url:= if(le.intnet_user_name_1_url != '',le.intnet_user_name_1_url,ri.intnet_user_name_1_url);
                self.intnet_user_name_2:= if(le.intnet_user_name_2 != '',le.intnet_user_name_2,ri.intnet_user_name_2);
                self.intnet_user_name_2_url:= if(le.intnet_user_name_2_url != '',le.intnet_user_name_2_url,ri.intnet_user_name_2_url);
                self.intnet_user_name_3:= if(le.intnet_user_name_3 != '',le.intnet_user_name_3,ri.intnet_user_name_3);
                self.intnet_user_name_3_url:= if(le.intnet_user_name_3_url != '',le.intnet_user_name_3_url,ri.intnet_user_name_3_url);
                self.intnet_user_name_4:= if(le.intnet_user_name_4 != '',le.intnet_user_name_4,ri.intnet_user_name_4);
                self.intnet_user_name_4_url:= if(le.intnet_user_name_4_url != '',le.intnet_user_name_4_url,ri.intnet_user_name_4_url);
                self.intnet_user_name_5:= if(le.intnet_user_name_5 != '',le.intnet_user_name_5,ri.intnet_user_name_5);
                self.intnet_user_name_5_url:= if(le.intnet_user_name_5_url != '',le.intnet_user_name_5_url,ri.intnet_user_name_5_url);
                self.offender_status:= if(le.offender_status != '',le.offender_status,ri.offender_status);
                self.offender_category:= if(le.offender_category != '',le.offender_category,ri.offender_category);
                self.risk_level_code:= if(le.risk_level_code != '',le.risk_level_code,ri.risk_level_code);
                self.risk_description:= if(le.risk_description != '',le.risk_description,ri.risk_description);
                self.police_agency:= if(le.police_agency != '',le.police_agency,ri.police_agency);
                self.police_agency_contact_name:= if(le.police_agency_contact_name != '',le.police_agency_contact_name,ri.police_agency_contact_name);
                self.police_agency_address_1:= if(le.police_agency_address_1 != '',le.police_agency_address_1,ri.police_agency_address_1);
                self.police_agency_address_2:= if(le.police_agency_address_2 != '',le.police_agency_address_2,ri.police_agency_address_2);
                self.police_agency_phone:= if(le.police_agency_phone != '',le.police_agency_phone,ri.police_agency_phone);
                self.registration_type:= if(le.registration_type != '',le.registration_type,ri.registration_type);
                self.reg_date_1:= if(le.reg_date_1 != '',le.reg_date_1,ri.reg_date_1);
                self.reg_date_1_type:= if(le.reg_date_1_type != '',le.reg_date_1_type,ri.reg_date_1_type);
                self.reg_date_2:= if(le.reg_date_2 != '',le.reg_date_2,ri.reg_date_2);
                self.reg_date_2_type:= if(le.reg_date_2_type != '',le.reg_date_2_type,ri.reg_date_2_type);
                self.reg_date_3:= if(le.reg_date_3 != '',le.reg_date_3,ri.reg_date_3);
                self.reg_date_3_type:= if(le.reg_date_3_type != '',le.reg_date_3_type,ri.reg_date_3_type);
                self.registration_address_1:= if(le.registration_address_1 != '',le.registration_address_1,ri.registration_address_1);
                self.registration_address_2:= if(le.registration_address_2 != '',le.registration_address_2,ri.registration_address_2);
                self.registration_address_3:= if(le.registration_address_3 != '',le.registration_address_3,ri.registration_address_3);
                self.registration_address_4:= if(le.registration_address_4 != '',le.registration_address_4,ri.registration_address_4);
                self.registration_address_5:= if(le.registration_address_5 != '',le.registration_address_5,ri.registration_address_5);
                self.registration_county:= if(le.registration_county != '',le.registration_county,ri.registration_county);
                self.registration_home_phone:= if(le.registration_home_phone != '',le.registration_home_phone,ri.registration_home_phone);
                self.registration_cell_phone:= if(le.registration_cell_phone != '',le.registration_cell_phone,ri.registration_cell_phone);
                self.other_registration_address_1:= if(le.other_registration_address_1 != '',le.other_registration_address_1,ri.other_registration_address_1);
                self.other_registration_address_2:= if(le.other_registration_address_2 != '',le.other_registration_address_2,ri.other_registration_address_2);
                self.other_registration_address_3:= if(le.other_registration_address_3 != '',le.other_registration_address_3,ri.other_registration_address_3);
                self.other_registration_address_4:= if(le.other_registration_address_4 != '',le.other_registration_address_4,ri.other_registration_address_4);
                self.other_registration_address_5:= if(le.other_registration_address_5 != '',le.other_registration_address_5,ri.other_registration_address_5);
                self.other_registration_county:= if(le.other_registration_county != '',le.other_registration_county,ri.other_registration_county);
                self.other_registration_phone:= if(le.other_registration_phone != '',le.other_registration_phone,ri.other_registration_phone);
                self.temp_lodge_address_1:= if(le.temp_lodge_address_1 != '',le.temp_lodge_address_1,ri.temp_lodge_address_1);
                self.temp_lodge_address_2:= if(le.temp_lodge_address_2 != '',le.temp_lodge_address_2,ri.temp_lodge_address_2);
                self.temp_lodge_address_3:= if(le.temp_lodge_address_3 != '',le.temp_lodge_address_3,ri.temp_lodge_address_3);
                self.temp_lodge_address_4:= if(le.temp_lodge_address_4 != '',le.temp_lodge_address_4,ri.temp_lodge_address_4);
                self.temp_lodge_address_5:= if(le.temp_lodge_address_5 != '',le.temp_lodge_address_5,ri.temp_lodge_address_5);
                self.temp_lodge_county:= if(le.temp_lodge_county != '',le.temp_lodge_county,ri.temp_lodge_county);
                self.temp_lodge_phone:= if(le.temp_lodge_phone != '',le.temp_lodge_phone,ri.temp_lodge_phone);
                self.employer:= if(le.employer != '',le.employer,ri.employer);
                self.employer_address_1:= if(le.employer_address_1 != '',le.employer_address_1,ri.employer_address_1);
                self.employer_address_2:= if(le.employer_address_2 != '',le.employer_address_2,ri.employer_address_2);
                self.employer_address_3:= if(le.employer_address_3 != '',le.employer_address_3,ri.employer_address_3);
                self.employer_address_4:= if(le.employer_address_4 != '',le.employer_address_4,ri.employer_address_4);
                self.employer_address_5:= if(le.employer_address_5 != '',le.employer_address_5,ri.employer_address_5);
                self.employer_county:= if(le.employer_county != '',le.employer_county,ri.employer_county);
                self.employer_phone:= if(le.employer_phone != '',le.employer_phone,ri.employer_phone);
                self.employer_comments:= if(le.employer_comments != '',le.employer_comments,ri.employer_comments);
                self.professional_licenses_1:= if(le.professional_licenses_1 != '',le.professional_licenses_1,ri.professional_licenses_1);
                self.professional_licenses_2:= if(le.professional_licenses_2 != '',le.professional_licenses_2,ri.professional_licenses_2);
                self.professional_licenses_3:= if(le.professional_licenses_3 != '',le.professional_licenses_3,ri.professional_licenses_3);
                self.professional_licenses_4:= if(le.professional_licenses_4 != '',le.professional_licenses_4,ri.professional_licenses_4);
                self.professional_licenses_5:= if(le.professional_licenses_5 != '',le.professional_licenses_5,ri.professional_licenses_5);
                self.school:= if(le.school != '',le.school,ri.school);
                self.school_address_1:= if(le.school_address_1 != '',le.school_address_1,ri.school_address_1);
                self.school_address_2:= if(le.school_address_2 != '',le.school_address_2,ri.school_address_2);
                self.school_address_3:= if(le.school_address_3 != '',le.school_address_3,ri.school_address_3);
                self.school_address_4:= if(le.school_address_4 != '',le.school_address_4,ri.school_address_4);
                self.school_address_5:= if(le.school_address_5 != '',le.school_address_5,ri.school_address_5);
                self.school_county:= if(le.school_county != '',le.school_county,ri.school_county);
                self.school_phone:= if(le.school_phone != '',le.school_phone,ri.school_phone);
                self.school_comments:= if(le.school_comments != '',le.school_comments,ri.school_comments);
                self.doc_number:= if(le.doc_number != '',le.doc_number,ri.doc_number);
                self.st_id_number:= if(le.st_id_number != '',le.st_id_number,ri.st_id_number);
                self.fbi_number:= if(le.fbi_number != '',le.fbi_number,ri.fbi_number);
                self.ncic_number:= if(le.ncic_number != '',le.ncic_number,ri.ncic_number);
                self.date_of_birth_aka:= if(le.date_of_birth_aka != '',le.date_of_birth_aka,ri.date_of_birth_aka);
                self.age:= if(le.age != '',le.age,ri.age);
                self.dna:= if(le.dna != '',le.dna,ri.dna);
                self.race:= if(le.race != '',le.race,ri.race);
                self.ethnicity:= if(le.ethnicity != '',le.ethnicity,ri.ethnicity);
                self.sex:= if(le.sex != '',le.sex,ri.sex);
                self.hair_color:= if(le.hair_color != '',le.hair_color,ri.hair_color);
                self.eye_color:= if(le.eye_color != '',le.eye_color,ri.eye_color);
                self.height:= if(le.height != '',le.height,ri.height);
                self.weight:= if(le.weight != '',le.weight,ri.weight);
                self.skin_tone:= if(le.skin_tone != '',le.skin_tone,ri.skin_tone);
                self.build_type:= if(le.build_type != '',le.build_type,ri.build_type);
                self.scars_marks_tattoos:= if(le.scars_marks_tattoos != '',le.scars_marks_tattoos,ri.scars_marks_tattoos);
                self.shoe_size:= if(le.shoe_size != '',le.shoe_size,ri.shoe_size);
                self.corrective_lense_flag:= if(le.corrective_lense_flag != '',le.corrective_lense_flag,ri.corrective_lense_flag);
                self.arrest_date_1:= if(le.arrest_date_1 != '',le.arrest_date_1,ri.arrest_date_1);
                self.arrest_warrant_1:= if(le.arrest_warrant_1 != '',le.arrest_warrant_1,ri.arrest_warrant_1);
                self.conviction_jurisdiction_1:= if(le.conviction_jurisdiction_1 != '',le.conviction_jurisdiction_1,ri.conviction_jurisdiction_1);
                self.conviction_date_1:= if(le.conviction_date_1 != '',le.conviction_date_1,ri.conviction_date_1);
                self.court_1:= if(le.court_1 != '',le.court_1,ri.court_1);
                self.court_case_number_1:= if(le.court_case_number_1 != '',le.court_case_number_1,ri.court_case_number_1);
                self.offense_date_1:= if(le.offense_date_1 != '',le.offense_date_1,ri.offense_date_1);
                self.offense_code_or_statute_1:= if(le.offense_code_or_statute_1 != '',le.offense_code_or_statute_1,ri.offense_code_or_statute_1);
                self.offense_description_1:= if(le.offense_description_1 != '',le.offense_description_1,ri.offense_description_1);
                self.offense_description_1_2:= if(le.offense_description_1_2 != '',le.offense_description_1_2,ri.offense_description_1_2);
                self.victim_minor_1:= if(le.victim_minor_1 != '',le.victim_minor_1,ri.victim_minor_1);
                self.victim_age_1:= if(le.victim_age_1 != '',le.victim_age_1,ri.victim_age_1);
                self.victim_gender_1:= if(le.victim_gender_1 != '',le.victim_gender_1,ri.victim_gender_1);
                self.victim_relationship_1:= if(le.victim_relationship_1 != '',le.victim_relationship_1,ri.victim_relationship_1);
                self.sentence_description_1:= if(le.sentence_description_1 != '',le.sentence_description_1,ri.sentence_description_1);
                self.sentence_description_1_2:= if(le.sentence_description_1_2 != '',le.sentence_description_1_2,ri.sentence_description_1_2);
                self.arrest_date_2:= if(le.arrest_date_2 != '',le.arrest_date_2,ri.arrest_date_2);
                self.arrest_warrant_2:= if(le.arrest_warrant_2 != '',le.arrest_warrant_2,ri.arrest_warrant_2);
                self.conviction_jurisdiction_2:= if(le.conviction_jurisdiction_2 != '',le.conviction_jurisdiction_2,ri.conviction_jurisdiction_2);
                self.conviction_date_2:= if(le.conviction_date_2 != '',le.conviction_date_2,ri.conviction_date_2);
                self.court_2:= if(le.court_2 != '',le.court_2,ri.court_2);
                self.court_case_number_2:= if(le.court_case_number_2 != '',le.court_case_number_2,ri.court_case_number_2);
                self.offense_date_2:= if(le.offense_date_2 != '',le.offense_date_2,ri.offense_date_2);
                self.offense_code_or_statute_2:= if(le.offense_code_or_statute_2 != '',le.offense_code_or_statute_2,ri.offense_code_or_statute_2);
                self.offense_description_2:= if(le.offense_description_2 != '',le.offense_description_2,ri.offense_description_2);
                self.offense_description_2_2:= if(le.offense_description_2_2 != '',le.offense_description_2_2,ri.offense_description_2_2);
                self.victim_minor_2:= if(le.victim_minor_2 != '',le.victim_minor_2,ri.victim_minor_2);
                self.victim_age_2:= if(le.victim_age_2 != '',le.victim_age_2,ri.victim_age_2);
                self.victim_gender_2:= if(le.victim_gender_2 != '',le.victim_gender_2,ri.victim_gender_2);
                self.victim_relationship_2:= if(le.victim_relationship_2 != '',le.victim_relationship_2,ri.victim_relationship_2);
                self.sentence_description_2:= if(le.sentence_description_2 != '',le.sentence_description_2,ri.sentence_description_2);
                self.sentence_description_2_2:= if(le.sentence_description_2_2 != '',le.sentence_description_2_2,ri.sentence_description_2_2);
                self.arrest_date_3:= if(le.arrest_date_3 != '',le.arrest_date_3,ri.arrest_date_3);
                self.arrest_warrant_3:= if(le.arrest_warrant_3 != '',le.arrest_warrant_3,ri.arrest_warrant_3);
                self.conviction_jurisdiction_3:= if(le.conviction_jurisdiction_3 != '',le.conviction_jurisdiction_3,ri.conviction_jurisdiction_3);
                self.conviction_date_3:= if(le.conviction_date_3 != '',le.conviction_date_3,ri.conviction_date_3);
                self.court_3:= if(le.court_3 != '',le.court_3,ri.court_3);
                self.court_case_number_3:= if(le.court_case_number_3 != '',le.court_case_number_3,ri.court_case_number_3);
                self.offense_date_3:= if(le.offense_date_3 != '',le.offense_date_3,ri.offense_date_3);
                self.offense_code_or_statute_3:= if(le.offense_code_or_statute_3 != '',le.offense_code_or_statute_3,ri.offense_code_or_statute_3);
                self.offense_description_3:= if(le.offense_description_3 != '',le.offense_description_3,ri.offense_description_3);
                self.offense_description_3_2:= if(le.offense_description_3_2 != '',le.offense_description_3_2,ri.offense_description_3_2);
                self.victim_minor_3:= if(le.victim_minor_3 != '',le.victim_minor_3,ri.victim_minor_3);
                self.victim_age_3:= if(le.victim_age_3 != '',le.victim_age_3,ri.victim_age_3);
                self.victim_gender_3:= if(le.victim_gender_3 != '',le.victim_gender_3,ri.victim_gender_3);
                self.victim_relationship_3:= if(le.victim_relationship_3 != '',le.victim_relationship_3,ri.victim_relationship_3);
                self.sentence_description_3:= if(le.sentence_description_3 != '',le.sentence_description_3,ri.sentence_description_3);
                self.sentence_description_3_2:= if(le.sentence_description_3_2 != '',le.sentence_description_3_2,ri.sentence_description_3_2);
                self.arrest_date_4:= if(le.arrest_date_4 != '',le.arrest_date_4,ri.arrest_date_4);
                self.arrest_warrant_4:= if(le.arrest_warrant_4 != '',le.arrest_warrant_4,ri.arrest_warrant_4);
                self.conviction_jurisdiction_4:= if(le.conviction_jurisdiction_4 != '',le.conviction_jurisdiction_4,ri.conviction_jurisdiction_4);
                self.conviction_date_4:= if(le.conviction_date_4 != '',le.conviction_date_4,ri.conviction_date_4);
                self.court_4:= if(le.court_4 != '',le.court_4,ri.court_4);
                self.court_case_number_4:= if(le.court_case_number_4 != '',le.court_case_number_4,ri.court_case_number_4);
                self.offense_date_4:= if(le.offense_date_4 != '',le.offense_date_4,ri.offense_date_4);
                self.offense_code_or_statute_4:= if(le.offense_code_or_statute_4 != '',le.offense_code_or_statute_4,ri.offense_code_or_statute_4);
                self.offense_description_4:= if(le.offense_description_4 != '',le.offense_description_4,ri.offense_description_4);
                self.offense_description_4_2:= if(le.offense_description_4_2 != '',le.offense_description_4_2,ri.offense_description_4_2);
                self.victim_minor_4:= if(le.victim_minor_4 != '',le.victim_minor_4,ri.victim_minor_4);
                self.victim_age_4:= if(le.victim_age_4 != '',le.victim_age_4,ri.victim_age_4);
                self.victim_gender_4:= if(le.victim_gender_4 != '',le.victim_gender_4,ri.victim_gender_4);
                self.victim_relationship_4:= if(le.victim_relationship_4 != '',le.victim_relationship_4,ri.victim_relationship_4);
                self.sentence_description_4:= if(le.sentence_description_4 != '',le.sentence_description_4,ri.sentence_description_4);
                self.sentence_description_4_2:= if(le.sentence_description_4_2 != '',le.sentence_description_4_2,ri.sentence_description_4_2);
                self.arrest_date_5:= if(le.arrest_date_5 != '',le.arrest_date_5,ri.arrest_date_5);
                self.arrest_warrant_5:= if(le.arrest_warrant_5 != '',le.arrest_warrant_5,ri.arrest_warrant_5);
                self.conviction_jurisdiction_5:= if(le.conviction_jurisdiction_5 != '',le.conviction_jurisdiction_5,ri.conviction_jurisdiction_5);
                self.conviction_date_5:= if(le.conviction_date_5 != '',le.conviction_date_5,ri.conviction_date_5);
                self.court_5:= if(le.court_5 != '',le.court_5,ri.court_5);
                self.court_case_number_5:= if(le.court_case_number_5 != '',le.court_case_number_5,ri.court_case_number_5);
                self.offense_date_5:= if(le.offense_date_5 != '',le.offense_date_5,ri.offense_date_5);
                self.offense_code_or_statute_5:= if(le.offense_code_or_statute_5 != '',le.offense_code_or_statute_5,ri.offense_code_or_statute_5);
                self.offense_description_5:= if(le.offense_description_5 != '',le.offense_description_5,ri.offense_description_5);
                self.offense_description_5_2:= if(le.offense_description_5_2 != '',le.offense_description_5_2,ri.offense_description_5_2);
                self.victim_minor_5:= if(le.victim_minor_5 != '',le.victim_minor_5,ri.victim_minor_5);
                self.victim_age_5:= if(le.victim_age_5 != '',le.victim_age_5,ri.victim_age_5);
                self.victim_gender_5:= if(le.victim_gender_5 != '',le.victim_gender_5,ri.victim_gender_5);
                self.victim_relationship_5:= if(le.victim_relationship_5 != '',le.victim_relationship_5,ri.victim_relationship_5);
                self.sentence_description_5:= if(le.sentence_description_5 != '',le.sentence_description_5,ri.sentence_description_5);
                self.sentence_description_5_2:= if(le.sentence_description_5_2 != '',le.sentence_description_5_2,ri.sentence_description_5_2);
                self.addl_comments_1:= if(le.addl_comments_1 != '',le.addl_comments_1,ri.addl_comments_1);
                self.addl_comments_2:= if(le.addl_comments_2 != '',le.addl_comments_2,ri.addl_comments_2);
                self.orig_dl_number:= if(le.orig_dl_number != '',le.orig_dl_number,ri.orig_dl_number);
                self.orig_dl_state:= if(le.orig_dl_state != '',le.orig_dl_state,ri.orig_dl_state);
                self.orig_dl_link:= if(le.orig_dl_link != '',le.orig_dl_link,ri.orig_dl_link);
                self.orig_dl_date:= if(le.orig_dl_date != '',le.orig_dl_date,ri.orig_dl_date);
                self.passport_type:= if(le.passport_type != '',le.passport_type,ri.passport_type);
                self.passport_code:= if(le.passport_code != '',le.passport_code,ri.passport_code);
                self.passport_number:= if(le.passport_number != '',le.passport_number,ri.passport_number);
                self.passport_sex:= if(le.passport_sex != '',le.passport_sex,ri.passport_sex);
                self.passport_issue_date:= if(le.passport_issue_date != '',le.passport_issue_date,ri.passport_issue_date);
                self.passport_authority:= if(le.passport_authority != '',le.passport_authority,ri.passport_authority);
                self.passport_expiration_date:= if(le.passport_expiration_date != '',le.passport_expiration_date,ri.passport_expiration_date);
                self.passport_endorsement:= if(le.passport_endorsement != '',le.passport_endorsement,ri.passport_endorsement);
                self.passport_link:= if(le.passport_link != '',le.passport_link,ri.passport_link);
                self.passport_date:= if(le.passport_date != '',le.passport_date,ri.passport_date);
                self.orig_veh_year_1:= if(le.orig_veh_year_1 != '',le.orig_veh_year_1,ri.orig_veh_year_1);
                self.orig_veh_color_1:= if(le.orig_veh_color_1 != '',le.orig_veh_color_1,ri.orig_veh_color_1);
                self.orig_veh_make_model_1:= if(le.orig_veh_make_model_1 != '',le.orig_veh_make_model_1,ri.orig_veh_make_model_1);
                self.orig_veh_plate_1:= if(le.orig_veh_plate_1 != '',le.orig_veh_plate_1,ri.orig_veh_plate_1);
                self.orig_registration_number_1:= if(le.orig_registration_number_1 != '',le.orig_registration_number_1,ri.orig_registration_number_1);
                self.orig_veh_state_1:= if(le.orig_veh_state_1 != '',le.orig_veh_state_1,ri.orig_veh_state_1);
                self.orig_veh_location_1:= if(le.orig_veh_location_1 != '',le.orig_veh_location_1,ri.orig_veh_location_1);
                self.orig_veh_year_2:= if(le.orig_veh_year_2 != '',le.orig_veh_year_2,ri.orig_veh_year_2);
                self.orig_veh_color_2:= if(le.orig_veh_color_2 != '',le.orig_veh_color_2,ri.orig_veh_color_2);
                self.orig_veh_make_model_2:= if(le.orig_veh_make_model_2 != '',le.orig_veh_make_model_2,ri.orig_veh_make_model_2);
                self.orig_veh_plate_2:= if(le.orig_veh_plate_2 != '',le.orig_veh_plate_2,ri.orig_veh_plate_2);
                self.orig_registration_number_2:= if(le.orig_registration_number_2 != '',le.orig_registration_number_2,ri.orig_registration_number_2);
                self.orig_veh_state_2:= if(le.orig_veh_state_2 != '',le.orig_veh_state_2,ri.orig_veh_state_2);
                self.orig_veh_location_2:= if(le.orig_veh_location_2 != '',le.orig_veh_location_2,ri.orig_veh_location_2);
                self.orig_veh_year_3:= if(le.orig_veh_year_3 != '',le.orig_veh_year_3,ri.orig_veh_year_3);
                self.orig_veh_color_3:= if(le.orig_veh_color_3 != '',le.orig_veh_color_3,ri.orig_veh_color_3);
                self.orig_veh_make_model_3:= if(le.orig_veh_make_model_3 != '',le.orig_veh_make_model_3,ri.orig_veh_make_model_3);
                self.orig_veh_plate_3:= if(le.orig_veh_plate_3 != '',le.orig_veh_plate_3,ri.orig_veh_plate_3);
                self.orig_registration_number_3:= if(le.orig_registration_number_3 != '',le.orig_registration_number_3,ri.orig_registration_number_3);
                self.orig_veh_state_3:= if(le.orig_veh_state_3 != '',le.orig_veh_state_3,ri.orig_veh_state_3);
                self.orig_veh_location_3:= if(le.orig_veh_location_3 != '',le.orig_veh_location_3,ri.orig_veh_location_3);
                self.orig_veh_year_4:= if(le.orig_veh_year_4 != '',le.orig_veh_year_4,ri.orig_veh_year_4);
                self.orig_veh_color_4:= if(le.orig_veh_color_4 != '',le.orig_veh_color_4,ri.orig_veh_color_4);
                self.orig_veh_make_model_4:= if(le.orig_veh_make_model_4 != '',le.orig_veh_make_model_4,ri.orig_veh_make_model_4);
                self.orig_veh_plate_4:= if(le.orig_veh_plate_4 != '',le.orig_veh_plate_4,ri.orig_veh_plate_4);
                self.orig_registration_number_4:= if(le.orig_registration_number_4 != '',le.orig_registration_number_4,ri.orig_registration_number_4);
                self.orig_veh_state_4:= if(le.orig_veh_state_4 != '',le.orig_veh_state_4,ri.orig_veh_state_4);
                self.orig_veh_location_4:= if(le.orig_veh_location_4 != '',le.orig_veh_location_4,ri.orig_veh_location_4);
                self.orig_veh_year_5:= if(le.orig_veh_year_5 != '',le.orig_veh_year_5,ri.orig_veh_year_5);
                self.orig_veh_color_5:= if(le.orig_veh_color_5 != '',le.orig_veh_color_5,ri.orig_veh_color_5);
                self.orig_veh_make_model_5:= if(le.orig_veh_make_model_5 != '',le.orig_veh_make_model_5,ri.orig_veh_make_model_5);
                self.orig_veh_plate_5:= if(le.orig_veh_plate_5 != '',le.orig_veh_plate_5,ri.orig_veh_plate_5);
                self.orig_registration_number_5:= if(le.orig_registration_number_5 != '',le.orig_registration_number_5,ri.orig_registration_number_5);
                self.orig_veh_state_5:= if(le.orig_veh_state_5 != '',le.orig_veh_state_5,ri.orig_veh_state_5);
                self.orig_veh_location_5:= if(le.orig_veh_location_5 != '',le.orig_veh_location_5,ri.orig_veh_location_5);
                self.fingerprint_link:= if(le.fingerprint_link != '',le.fingerprint_link,ri.fingerprint_link);
                self.fingerprint_date:= if(le.fingerprint_date != '',le.fingerprint_date,ri.fingerprint_date);
                self.palmprint_link:= if(le.palmprint_link != '',le.palmprint_link,ri.palmprint_link);
                self.palmprint_date:= if(le.palmprint_date != '',le.palmprint_date,ri.palmprint_date);
                self.image_link:= if(le.image_link != '',le.image_link,ri.image_link);

                self                                                                                                                                                                                                                         :=                le;
end;

fixSource_rollup :=                rollup(fixSource_sort,tRollup(left,right),state_of_origin,source,name_orig,date_of_birth,orig_ssn,passport_nationality,passport_dob,passport_place_of_birth,local);

export File_OKC_Sex_Offender_In := fixSource_rollup;
