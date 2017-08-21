import OKC_Sexual_Offenders_V2, OKC_Sexual_Offenders, doxie_build;

// export MAC_OKC_SexOffenders_Spray_V2(source_IP,source_path,source_state,file_name,group_name ='\'thor_dataland_linux\'',clear_Super ='Y') := 
export Mac_OKC_SexOffenders_Spray_V2(source_IP,source_path,source_state,file_name,group_name ='\'thor_200\'',clear_Super ='Y') := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(Layout_In_File)
#uniquename(Layout_In_File_V2)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)


#workunit('name','OKC SexOffender ' + source_state + ' Spray ');

%sourceCsvSeparater% := '\\|';
%sourceCsvTeminater% := '\\n,\\r\\n';
// %sourceCsvQuote% := '\"';
%sourceCsvQuote% := '';

%doCleanup% := sequential(FileServices.RemoveSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old'
                                                       ,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name)
						  ,FileServices.RemoveSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete'
						                               ,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name)
						  ,FileServices.RemoveSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile'
						                               ,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name)
						  ,//FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name),
						     FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name));

%deleteIfExist% := if(FileServices.FileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name),
										  %doCleanup%);
/*                             SprayVariable(const varstring sourceIP
							              , const varstring sourcePath
										  , integer4 sourceMaxRecordSize=8192
										  , const varstring sourceCsvSeparate='\\,'
										  , const varstring sourceCsvTerminate='\\n,\\r\\n'
										  , const varstring sourceCsvQuote='\''
										  , const varstring destinationGroup
										  , const varstring destinationLogicalName
										  , integer4 timeOut=-1
										  , const varstring espServerIpPort=lib_system.ws_fs_server
										  , integer4 maxConnections=-1
										  , boolean allowoverwrite=false
										  , boolean replicate=false
										  , boolean compress=false)
*/
%spray_main% := FileServices.SprayVariable(Source_IP
                                          ,source_path + file_name
										  ,9999
										  ,%sourceCsvSeparater%
										  ,
										  ,%sourceCsvQuote%
										  ,group_name
										  ,OKC_Sexual_Offenders.Cluster +'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name
										  ,-1
										  ,
										  ,
										  ,true
										  ,true);

// Old source layout
%Layout_In_File% := record, maxlength(9999)
	OKC_Sexual_Offenders_v2.Layout_OKC;
end;

// New source layout
%Layout_In_File_V2% := record, maxlength(9999)
	OKC_Sexual_Offenders_v2.Layout_OKC_V2;
end;

// Trim the additional comments fields down to 1000 to be sure that the data can be parsed properly.
%Layout_In_File% %trfProject%(%Layout_In_File_v2% l) := transform
	self.orig_state   := if(trim(l.state_of_origin,left,right) = '', source_state, l.state_of_origin);
	//self.addl_comments_1 := if(length(l.addl_comments_1) > 1000,l.addl_comments_1(1..1000), l.addl_comments_1;
	self.addl_comments_1 := trim(l.addl_comments_1[1..1000],left,right);
	self.addl_comments_2 := trim(l.addl_comments_2[1..1000],left,right);
	self := l;
	self.source_file					:=l.source;
	self.scrape_date					:=l.date_updated;
	
	/*self.date_added						:=l.date_added;
	self.date_updated					:=l.date_updated;
	self.state_of_origin				:=if(trim(l.state_of_origin,left,right) = '', l.source, l.state_of_origin);
	self.name_orig						:=l.name_orig;
	self.name_aka						:=l.name_aka;
	self.intnet_email_address_1 		:=l.intnet_email_address_1;
	self.intnet_email_address_2 		:=l.intnet_email_address_2;
	self.intnet_email_address_3 		:=l.intnet_email_address_3;
	self.intnet_email_address_4 		:=l.intnet_email_address_4;
	self.intnet_email_address_5 		:=l.intnet_email_address_5;
	self.intnet_instant_message_addr_1 	:=l.intnet_instant_message_addr_1;
	self.intnet_instant_message_addr_2 	:=l.intnet_instant_message_addr_2;
	self.intnet_instant_message_addr_3 	:=l.intnet_instant_message_addr_3;
	self.intnet_instant_message_addr_4 	:=l.intnet_instant_message_addr_4;
	self.intnet_instant_message_addr_5 	:=l.intnet_instant_message_addr_5;
	self.intnet_user_name_1 			:=l.intnet_user_name_1;
	self.intnet_user_name_1_url 		:=l.intnet_user_name_1_url;
	self.intnet_user_name_2 			:=l.intnet_user_name_2 ;
	self.intnet_user_name_2_url 		:=l.intnet_user_name_2_url;
	self.intnet_user_name_3 			:=l.intnet_user_name_3;
	self.intnet_user_name_3_url 		:=l.intnet_user_name_3_url;
	self.intnet_user_name_4 			:=l.intnet_user_name_4;
	self.intnet_user_name_4_url 		:=l.intnet_user_name_4_url;
	self.intnet_user_name_5 			:=l.intnet_user_name_5 ;
	self.intnet_user_name_5_url 		:=l.intnet_user_name_5_url ;
	self.offender_status:=l.offender_status;
	self.offender_category:=l.offender_category;
	self.risk_level_code:=l.risk_level_code;
	self.risk_description:=l.risk_description;
	self.police_agency:=l.police_agency;
	self.police_agency_contact_name:=l.police_agency_contact_name;
	self.police_agency_address_1:=l.police_agency_address_1;
	self.police_agency_address_2:=l.police_agency_address_2;
	self.police_agency_phone:=l.police_agency_phone;
	self.registration_type:=l.registration_type;
	self.reg_date_1:=l.reg_date_1;
	self.reg_date_1_type:=l.reg_date_1_type;
	self.reg_date_2:=l.reg_date_2;
	self.reg_date_2_type:=l.reg_date_2_type;
	self.reg_date_3:=l.reg_date_3;
	self.reg_date_3_type:=l.reg_date_3_type;
	self.registration_address_1:=l.registration_address_1;
	self.registration_address_2:=l.registration_address_2;
	self.registration_address_3:=l.registration_address_3;
	self.registration_address_4:=l.registration_address_4;
	self.registration_address_5:=l.registration_address_5;
	self.registration_county:=l.registration_county;
	self.registration_home_phone 		:=l.registration_home_phone;
	self.registration_cell_phone 		:=l.registration_cell_phone;
	self.other_registration_address_1 	:=l.other_registration_address_1;
	self.other_registration_address_2 	:=l.other_registration_address_2;
	self.other_registration_address_3 	:=l.other_registration_address_3;
	self.other_registration_address_4 	:=l.other_registration_address_4;
	self.other_registration_address_5 	:=l.other_registration_address_5;
	self.other_registration_county 		:=l.other_registration_county;
	self.other_registration_phone 		:=l.other_registration_phone;
	self.temp_lodge_address_1 			:=l.temp_lodge_address_1;
	self.temp_lodge_address_2 			:=l.temp_lodge_address_2;
	self.temp_lodge_address_3 			:=l.temp_lodge_address_3;
	self.temp_lodge_address_4 			:=l.temp_lodge_address_4;
	self.temp_lodge_address_5 			:=l.temp_lodge_address_5;
	self.temp_lodge_county 				:=l.temp_lodge_county;
	self.temp_lodge_phone 				:=l.temp_lodge_phone;
	self.employer:=l.employer;
	self.employer_address_1:=l.employer_address_1;
	self.employer_address_2:=l.employer_address_2;
	self.employer_address_3:=l.employer_address_3;
	self.employer_address_4:=l.employer_address_4;
	self.employer_address_5:=l.employer_address_5;
	self.employer_county:=l.employer_county;
	self.employer_phone 				:=l.employer_phone;
	self.employer_comments 				:=l.employer_comments;
	self.professional_licenses_1        :=l.professional_licenses_1;
	self.professional_licenses_2 		:=l.professional_licenses_2;
	self.professional_licenses_3 		:=l.professional_licenses_3;
	self.professional_licenses_4 		:=l.professional_licenses_4;
	self.professional_licenses_5 		:=l.professional_licenses_5;
	self.school:=l.school;
	self.school_address_1:=l.school_address_1;
	self.school_address_2:=l.school_address_2;
	self.school_address_3:=l.school_address_3;
	self.school_address_4:=l.school_address_4;
	self.school_address_5:=l.school_address_5;
	self.school_county:=l.school_county;
	self.school_phone 					:=l.school_phone;
	self.school_comments 				:=l.school_comments;
	self.offender_id:=l.offender_id;
	self.doc_number:=l.doc_number;
	self.sor_number:=l.sor_number;
	self.st_id_number:=l.st_id_number;
	self.fbi_number:=l.fbi_number;
	self.ncic_number:=l.ncic_number;
	self.orig_ssn:=l.orig_ssn;
	self.date_of_birth:=l.date_of_birth;
	self.date_of_birth_aka:=l.date_of_birth_aka;
	self.age:=l.age;
	self.dna			 				:=l.dna;
	self.race:=l.race;
	self.ethnicity:=l.ethnicity;
	self.sex:=l.sex;
	self.hair_color:=l.hair_color;
	self.eye_color:=l.eye_color;
	self.height:=l.height;
	self.weight:=l.weight;
	self.skin_tone:=l.skin_tone;
	self.build_type:=l.build_type;
	self.scars_marks_tattoos:=l.scars_marks_tattoos;
	self.shoe_size:=l.shoe_size;
	self.corrective_lense_flag:=l.corrective_lense_flag;
	self.arrest_date_1 					:=l.arrest_date_1;
	self.arrest_warrant_1 				:=l.arrest_warrant_1;
	self.conviction_jurisdiction_1:=l.conviction_jurisdiction_1;
	self.conviction_date_1:=l.conviction_date_1;
	self.court_1:=l.court_1;
	self.court_case_number_1:=l.court_case_number_1;
	self.offense_date_1:=l.offense_date_1;
	self.offense_code_or_statute_1:=l.offense_code_or_statute_1;
	self.offense_description_1:=l.offense_description_1;
	self.offense_description_1_2:=l.offense_description_1_2;
	self.victim_minor_1:=l.victim_minor_1;
	self.victim_age_1:=l.victim_age_1;
	self.victim_gender_1:=l.victim_gender_1;
	self.victim_relationship_1:=l.victim_relationship_1;
	self.sentence_description_1:=l.sentence_description_1;
	self.sentence_description_1_2:=l.sentence_description_1_2;
	self.arrest_date_2 					:=l.arrest_date_2;
	self.arrest_warrant_2 				:=l.arrest_warrant_2;
	self.conviction_jurisdiction_2:=l.conviction_jurisdiction_2;
	self.conviction_date_2:=l.conviction_date_2;
	self.court_2:=l.court_2;
	self.court_case_number_2:=l.court_case_number_2;
	self.offense_date_2:=l.offense_date_2;
	self.offense_code_or_statute_2:=l.offense_code_or_statute_2;
	self.offense_description_2:=l.offense_description_2;
	self.offense_description_2_2:=l.offense_description_2_2;
	self.victim_minor_2:=l.victim_minor_2;
	self.victim_age_2:=l.victim_age_2;
	self.victim_gender_2:=l.victim_gender_2;
	self.victim_relationship_2:=l.victim_relationship_2;
	self.sentence_description_2:=l.sentence_description_2;
	self.sentence_description_2_2:=l.sentence_description_2_2;	
	self.arrest_date_3 					:=l.arrest_date_3;
	self.arrest_warrant_3 				:=l.arrest_warrant_3;
	self.conviction_jurisdiction_3:=l.conviction_jurisdiction_3;
	self.conviction_date_3:=l.conviction_date_3;
	self.court_3:=l.court_3;
	self.court_case_number_3:=l.court_case_number_3;
	self.offense_date_3:=l.offense_date_3;
	self.offense_code_or_statute_3:=l.offense_code_or_statute_3;
	self.offense_description_3:=l.offense_description_3;
	self.offense_description_3_2:=l.offense_description_3_2;
	self.victim_minor_3:=l.victim_minor_3;
	self.victim_age_3:=l.victim_age_3;
	self.victim_gender_3:=l.victim_gender_3;
	self.victim_relationship_3:=l.victim_relationship_3;
	self.sentence_description_3:=l.sentence_description_3;
	self.sentence_description_3_2:=l.sentence_description_3_2;
	self.arrest_date_4 					:=l.arrest_date_4;
	self.arrest_warrant_4 				:=l.arrest_warrant_4;
	self.conviction_jurisdiction_4:=l.conviction_jurisdiction_4;
	self.conviction_date_4:=l.conviction_date_4;
	self.court_4:=l.court_4;
	self.court_case_number_4:=l.court_case_number_4;
	self.offense_date_4:=l.offense_date_4;
	self.offense_code_or_statute_4:=l.offense_code_or_statute_4;
	self.offense_description_4:=l.offense_description_4;
	self.offense_description_4_2:=l.offense_description_4_2;
	self.victim_minor_4:=l.victim_minor_4;
	self.victim_age_4:=l.victim_age_4;
	self.victim_gender_4:=l.victim_gender_4;
	self.victim_relationship_4:=l.victim_relationship_4;
	self.sentence_description_4:=l.sentence_description_4;
	self.sentence_description_4_2:=l.sentence_description_4_2;
	self.arrest_date_5 					:=l.arrest_date_5;
	self.arrest_warrant_5 				:=l.arrest_warrant_5;
	self.conviction_jurisdiction_5:=l.conviction_jurisdiction_5;
	self.conviction_date_5:=l.conviction_date_5;
	self.court_5:=l.court_5;
	self.court_case_number_5:=l.court_case_number_5;
	self.offense_date_5:=l.offense_date_5;
	self.offense_code_or_statute_5:=l.offense_code_or_statute_5;
	self.offense_description_5:=l.offense_description_5;
	self.offense_description_5_2:=l.offense_description_5_2;
	self.victim_minor_5:=l.victim_minor_5;
	self.victim_age_5:=l.victim_age_5;
	self.victim_gender_5:=l.victim_gender_5;
	self.victim_relationship_5:=l.victim_relationship_5;
	self.sentence_description_5:=l.sentence_descrition_5;
	self.sentence_description_5_2:=l.sentence_description_5_2;
	//self.addl_comments_1 := if(length(l.addl_comments_1) > 1000,l.addl_comments_1(1..1000), l.addl_comments_1;
	self.addl_comments_1 := trim(l.addl_comments_1[1..1000],left,right);
	self.addl_comments_2 := trim(l.addl_comments_2[1..1000],left,right);
	self.orig_dl_number:=l.orig_dl_number;
	self.orig_dl_state:=l.orig_dl_state;
	self.orig_dl_link 					:=l.orig_dl_link;
	self.orig_dl_date 					:=l.orig_dl_date;
	self.passport_type 					:=l.passport_type;
	self.passport_code 					:=l.passport_code;
	self.passport_number 				:=l.passport_number;
	self.passport_first_name 			:=l.passport_first_name;
	self.passport_given_name 			:=l.passport_given_name;
	self.passport_nationality 			:=l.passport_nationality;
	self.passport_dob 					:=l.passport_dob;
	self.passport_place_of_birth 		:=l.passport_place_of_birth;
	self.passport_sex 					:=l.passport_sex;
	self.passport_issue_date 			:=l.passport_issue_date;
	self.passport_authority 			:=l.passport_authority;
	self.passport_expiration_date 		:=l.passport_expiration_date;
	self.passport_endorsement 			:=l.passport_endorsement;
	self.passport_link 					:=l.passport_link;
	self.passport_date 					:=l.passport_date;
	self.orig_veh_year_1:=l.orig_veh_year_1;
	self.orig_veh_color_1:=l.orig_veh_color_1;
	self.orig_veh_make_model_1:=l.orig_veh_make_model_1;
	self.orig_veh_plate_1:=l.orig_veh_plate_1;	
	self.orig_registration_number_1 	:=l.orig_registration_number_1;
	self.orig_veh_state_1:=l.orig_veh_state_1;
	self.orig_veh_location_1 			:=l.orig_veh_location_1;
	self.orig_veh_year_2:=l.orig_veh_year_2;
	self.orig_veh_color_2:=l.orig_veh_color_2;
	self.orig_veh_make_model_2:=l.orig_veh_make_model_2;
	self.orig_veh_plate_2:=l.orig_veh_plate_2;	
	self.orig_registration_number_2 	:=l.orig_registration_number_2;
	self.orig_veh_state_2:=l.orig_veh_state_2;
	self.orig_veh_location_2 			:=l.orig_veh_location_2;
	self.orig_veh_year_3 				:=l.orig_veh_year_3;
	self.orig_veh_color_3 				:=l.orig_veh_color_3;
	self.orig_veh_make_model_3 			:=l.orig_veh_make_model_3;
	self.orig_veh_plate_3 				:=l.orig_veh_plate_3;
	self.orig_registration_number_3 	:=l.orig_registration_number_3;
	self.orig_veh_state_3 				:=l.orig_veh_state_3;
	self.orig_veh_location_3 			:=l.orig_veh_location_3;
	self.orig_veh_year_4 				:=l.orig_veh_year_4;
	self.orig_veh_color_4 				:=l.orig_veh_color_4;
	self.orig_veh_make_model_4 			:=l.orig_veh_make_model_4;
	self.orig_veh_plate_4 				:=l.orig_veh_plate_4;
	self.orig_registration_number_4 	:=l.orig_registration_number_4;
	self.orig_veh_state_4 				:=l.orig_veh_state_4;
	self.orig_veh_location_4 			:=l.orig_veh_location_4;
	self.orig_veh_year_5 				:=l.orig_veh_year_5;
	self.orig_veh_color_5 				:=l.orig_veh_color_5;
	self.orig_veh_make_model_5 			:=l.orig_veh_make_model_5;
	self.orig_veh_plate_5 				:=l.orig_veh_plate_5;
	self.orig_registration_number_5 	:=l.orig_registration_number_5;
	self.orig_veh_state_5 				:=l.orig_veh_state_5;
	self.orig_veh_location_5 			:=l.orig_veh_location_5;
	self.fingerprint_link 				:=l.fingerprint_link;
	self.fingerprint_date 				:=l.fingerprint_date;
	self.palmprint_link 				:=l.palmprint_link;
	self.palmprint_date 				:=l.palmprint_date;
	self.image_link:=l.image_link;
	self.image_date:=l.image_date;*/
	//self := l;
end;

%outfile% := project(dataset(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name,%Layout_In_File_V2%,csv(heading(1),separator('|'),terminator(['\r\n','\r','\n']),quote('"'),maxlength(9999))),
                     %trfProject%(left));

%ds% := output(%outfile%,,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name,overwrite);

%temp_delete% := if (FileServices.FileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name), 
											FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile',, true),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',true));

#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)

%do_super%  := sequential(output('do super 1...'),%deleteIfExist%, %spray_main%, %ds%, %super_main%, %temp_delete%);

%do_super1% := sequential(output('do super 2...'),%deleteIfExist%, %spray_main%, %ds%, %super_main1%, %temp_delete%);

%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

sequential(%out_super%);

endmacro;
