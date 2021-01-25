EXPORT Preprocess_rawfile  (STRING pVersion, BOOLEAN pUseProd) := FUNCTION

//// ABMS preprocessor///////////
//// The abms_id will go into the biog_number field
//// split the raw file into separate files by record type and try to recreate the original layouts
//// freeze any existing files that will no longer be updated, but rename keys to stay with package

	starting_file			:= DISTRIBUTE(ABMS.Files(pVersion,pUseProd).input.raw_input.sprayed, HASH(record_type));

	biog_only					:= starting_file(record_type = 'NA');
	cert_only					:= starting_file(record_type = 'CE');
	cert_inact_only		:= starting_file(record_type = 'IA');
	cert_exp_only			:= starting_file(record_type = 'EX');
	cert_status_only	:= starting_file(record_type = 'CS');
	deceased_only			:= starting_file(record_type = 'DD');
	address_only			:= starting_file(record_type = 'AD');
	moc_only					:= starting_file(record_type = 'MC');
	edu_recs_only 		:= starting_file(record_type = 'NA' and (degree_id <> '' or degree_code <> '' or degree_year <> ''));
	
	deceased_input		:= project(deceased_only,			transform(ABMS.layouts.input.deceased,
												self.biog_number					:= Left.abms_id,
												self.dod									:= Left.dod,
												self											:= Left));
												
	pre_moc_input			:= project(moc_only,					transform(ABMS.layouts.input.MOCParticipation,
												self.biog_number					:= Left.abms_id,
												self.board_code						:= Left.board_code,
												self.board_name						:= '', 
												self.participation				:= Left.participation,
												self.moc_cert_id					:= Left.moc_cert_id,
												self.moc_cert_name				:= '', 
												self											:= Left));

	moc_input0				:= join(sort(distribute(pre_moc_input, hash(board_code)), board_code, local),
												ABMS.Board_Code_Lookup.dsBoardLookup,
														LEFT.board_code =RIGHT.board_code,
														transform({pre_moc_input}, 
															SELF.board_name	:= RIGHT.board_name,
															SELF					:= LEFT),
															LEFT OUTER, LOOKUP);

	moc_input					:= join(sort(distribute(moc_input0, hash(moc_cert_id)), moc_cert_id, local),
													ABMS.Certificate_ID_Lookup.dsCertLookup,
														LEFT.moc_cert_id = RIGHT.cert_id,
														transform({moc_input0},
															SELF.moc_cert_name := RIGHT.cert_name,
															SELF		:= LEFT),
															LEFT OUTER, LOOKUP);
															
	temp_cert	:= record
		starting_file.board_code;
		ABMS.layouts.input.cert;
	end;

	cert_input_d		:= project(cert_status_only,		transform(temp_cert,
											self.board_code							:= Left.board_code,
											self.biog_number						:= Left.abms_id,
											self.biog_cert_id						:= Left.biog_cert_id,
											self.cert_name							:= '', // for now - will lookup in table in next step
											self.cert_type_ind					:= Left.cert_type_ind,
											self.recert_ind							:= Left.recert_ind,
											self.board_certified				:= 'N', // records in cert stat file do not have record_type 'CE', so should be marked as board certified = N
											self.cert_year							:= Left.cert_year,
											self.cert_month							:= Left.cert_month,
											self.cert_day								:= Left.cert_day,
											self.expiration_year				:= Left.expiration_year,
											self.expiration_month				:= Left.expiration_month,
											self.expiration_day					:= Left.expiration_day,
											self.reverification_year		:= if(Left.reverification_date <> '', Left.reverification_date[7..10], ''),
											self.reverification_month		:= if(Left.reverification_date <> '', Left.reverification_date[1..2], ''),
											self.reverification_day			:= if(Left.reverification_date <> '', Left.reverification_date[4..5], ''),
											self.duration_type					:= Left.duration_type,
											self.board_web_desc					:= '', // for now - will lookup name in next step
											self.cert_id								:= Left.moc_cert_id,
											self.mocpathway_id					:= Left.mocpathway_id,
											self.mocpathway_name				:= '', // for now - will lookup name in next step
											self												:= Left));

	cert_input_c		:= project(cert_inact_only,		transform(temp_cert,
											self.board_code							:= Left.board_code,
											self.biog_number						:= Left.abms_id,
											self.biog_cert_id						:= Left.biog_cert_id,
											self.cert_name							:= '', // for now - will lookup in table in next step
											self.cert_type_ind					:= Left.cert_type_ind,
											self.recert_ind							:= Left.recert_ind,
											self.board_certified				:= 'N', // records in cert inact file do not have record_type 'CE', so should be marked as board certified = N
											self.cert_year							:= Left.cert_year,
											self.cert_month							:= Left.cert_month,
											self.cert_day								:= Left.cert_day,
											self.expiration_year				:= Left.expiration_year,
											self.expiration_month				:= Left.expiration_month,
											self.expiration_day					:= Left.expiration_day,
											self.reverification_year		:= if(Left.reverification_date <> '', Left.reverification_date[7..10], ''),
											self.reverification_month		:= if(Left.reverification_date <> '', Left.reverification_date[1..2], ''),
											self.reverification_day			:= if(Left.reverification_date <> '', Left.reverification_date[4..5], ''),
											self.duration_type					:= Left.duration_type,
											self.board_web_desc					:= '', // for now - will lookup name in next step
											self.cert_id								:= Left.moc_cert_id, 
											self.mocpathway_id					:= Left.mocpathway_id,
											self.mocpathway_name				:= '', // for now - will lookup name in next step
											self												:= Left));

	cert_input_b		:= project(cert_exp_only,		transform(temp_cert,
											self.board_code							:= Left.board_code,
											self.biog_number						:= Left.abms_id,
											self.biog_cert_id						:= Left.biog_cert_id,
											self.cert_name							:= '', // for now - will lookup in table in next step
											self.cert_type_ind					:= Left.cert_type_ind,
											self.recert_ind							:= Left.recert_ind,
											self.board_certified				:= 'N', // records in cert exp file do not have record_type 'CE', and so should be marked as board certified = N
											self.cert_year							:= Left.cert_year,
											self.cert_month							:= Left.cert_month,
											self.cert_day								:= Left.cert_day,
											self.expiration_year				:= Left.expiration_year,
											self.expiration_month				:= Left.expiration_month,
											self.expiration_day					:= Left.expiration_day,
											self.reverification_year		:= if(Left.reverification_date <> '', Left.reverification_date[7..10], ''),
											self.reverification_month		:= if(Left.reverification_date <> '', Left.reverification_date[1..2], ''),
											self.reverification_day			:= if(Left.reverification_date <> '', Left.reverification_date[4..5], ''),
											self.duration_type					:= Left.duration_type,
											self.board_web_desc					:= '', // for now - will lookup name in next step
											self.cert_id								:= Left.moc_cert_id,
											self.mocpathway_id					:= Left.mocpathway_id,
											self.mocpathway_name				:= '', // for now - will lookup name in next step
											self												:= Left));

	cert_input_a		:= project(cert_only,		transform(temp_cert,
											self.board_code							:= Left.board_code,
											self.biog_number						:= Left.abms_id,
											self.biog_cert_id						:= Left.biog_cert_id,
											self.cert_name							:= '', // for now - will lookup in table in next step
											self.cert_type_ind					:= Left.cert_type_ind,
											self.recert_ind							:= Left.recert_ind,
											self.board_certified				:= 'Y', // records in cert file have record_type 'CE', which are to be marked as board certified = Y
											self.cert_year							:= Left.cert_year,
											self.cert_month							:= Left.cert_month,
											self.cert_day								:= Left.cert_day,
											self.expiration_year				:= Left.expiration_year,
											self.expiration_month				:= Left.expiration_month,
											self.expiration_day					:= Left.expiration_day,
											self.reverification_year		:= if(Left.reverification_date <> '', Left.reverification_date[7..10], ''),
											self.reverification_month		:= if(Left.reverification_date <> '', Left.reverification_date[1..2], ''),
											self.reverification_day			:= if(Left.reverification_date <> '', Left.reverification_date[4..5], ''),
											self.duration_type					:= Left.duration_type,
											self.board_web_desc					:= '', // for now - will lookup name in next step
											self.cert_id								:= Left.moc_cert_id, 
											self.mocpathway_id					:= Left.mocpathway_id,
											self.mocpathway_name				:= '', // for now - will lookup name in next step
											self												:= Left));

	pre_cert_input	:= cert_input_a + cert_input_b + cert_input_c + cert_input_d;
	cert_input0			:= join(sort(distribute(pre_cert_input, hash(cert_id)), cert_id, local),
													ABMS.Certificate_ID_Lookup.dsCertLookup,
														LEFT.cert_id = RIGHT.cert_id,
														transform({pre_cert_input},
															SELF.cert_name := RIGHT.cert_name,
															SELF		:= LEFT),
															LEFT OUTER, LOOKUP);

	cert_input1			:= 	join(cert_input0, ABMS.MOC_Pathway_Lookup.dsMOCLookup,
										LEFT.mocpathway_id = RIGHT.mocpathway_id,
										transform({pre_cert_input},
												SELF.mocpathway_name := RIGHT.mocpathway_name,
												SELF		:= LEFT),
												LEFT OUTER, LOOKUP);
												
	cert_input2			:= 	join(cert_input1, ABMS.Board_Code_Lookup.dsBoardLookup,
										LEFT.board_code =RIGHT.board_code,
										transform({pre_cert_input}, 
												SELF.board_web_desc	:= RIGHT.board_name,
												SELF					:= LEFT),
												LEFT OUTER, LOOKUP);

	cert_input			:= project(cert_input2, ABMS.layouts.input.cert);

	biog_input			:= project(biog_only,		transform(ABMS.layouts.input.biog,
											self.biog_number									:= Left.abms_id,
											self.birth_day										:= Left.birth_day,
											self.birth_month									:= Left.birth_month,
											self.birth_year										:= Left.birth_year,
											self.birth_date_suppress_ind			:= if(Left.birth_date_suppress_ind = '1','Y','N'),
											self.birth_city										:= '',
											self.birth_state									:= '',
											self.birth_nation									:= '',
											self.birth_location_suppress_ind	:= '',
											self.first_name										:= Left.first_name,
											self.middle_name									:= Left.middle_name,
											self.last_name										:= Left.last_name,
											self.name_suffix									:= Left.name_suffix,
											self.placement_cert								:= '',
											self.placement_city								:= '',
											self.placement_state							:= '',
											self.gender												:= Left.gender,
											self.board_certified							:= '', // for now - will populate in Update Base
											self.npi													:= Left.npi,
											self															:= Left));

	address_input := project(address_only, transform(ABMS.layouts.input.address,
											self.biog_number					:= Left.abms_id,
											self.address_id						:= Left.address_id,
											self.occurrence_number			:= 0,
											self.state								:= Left.state,
											self.full_zip							:= stringlib.stringfilterout(Left.full_zip,'-'),
											self.org1									:= Left.org1,
											self.line1								:= Left.line1,
											self.line2								:= Left.line2,
											self.line3								:= Left.line3,
											self.city									:= Left.city,
											self.country							:= Left.country,
											self.address_type					:= Left.address_type,
											self.address_suppress_ind := map(
																										Left.address_suppress_ind = '0' => 'N',
																										Left.address_suppress_ind = '2' => 'Y',
																										Left.address_suppress_ind = '3' => 'Y',
																										''),
											self											:= Left));
													
	create_edu	:= project(edu_recs_only, transform(ABMS.Layouts.input.education, 
									self.biog_number := left.abms_id, 
									self.degree := left.degree_code, 
									self.years := left.degree_year, 
									self := left, 
									self := []));
		
	biog_only_logical_file 				:= ABMS.Filenames(pVersion,pUseProd).Input.Biog.new(pversion);
	cert_only_logical_file 				:= ABMS.Filenames(pVersion,pUseProd).Input.Cert.new(pversion);
	deceased_only_logical_file 		:= ABMS.Filenames(pVersion,pUseProd).Input.Deceased.new(pversion);
	address_only_logical_file 		:= ABMS.Filenames(pVersion,pUseProd).Input.Address.new(pversion);
	moc_only_logical_file 				:= ABMS.Filenames(pVersion,pUseProd).Input.MOCParticipation.new(pversion);
	edu_only_logical_file					:= ABMS.Filenames(pVersion,pUseProd).Input.Education.new(pversion);
	
	biog_only_super_file 					:= ABMS.Filenames(pVersion,pUseProd).Input.Biog.Sprayed;
	cert_only_super_file 					:= ABMS.Filenames(pVersion,pUseProd).Input.Cert.Sprayed;
	deceased_only_super_file 			:= ABMS.Filenames(pVersion,pUseProd).Input.Deceased.Sprayed;
	address_only_super_file 			:= ABMS.Filenames(pVersion,pUseProd).Input.Address.Sprayed;
	moc_only_super_file 					:= ABMS.Filenames(pVersion,pUseProd).Input.MOCParticipation.Sprayed;
	edu_only_super_file						:= ABMS.Filenames(pVersion,pUseProd).Input.Education.Sprayed;
	
	Prepped_biog_only_file	:= 
			OUTPUT(biog_input,,biog_only_logical_file, overwrite, compressed);
	Prepped_cert_only_file	:= 
			OUTPUT(cert_input,,cert_only_logical_file, overwrite, compressed);
	Prepped_deceased_only_file	:= 
			OUTPUT(deceased_input,,deceased_only_logical_file, overwrite, compressed);
	Prepped_address_only_file	:= 
			OUTPUT(address_input,,address_only_logical_file, overwrite, compressed);
	Prepped_moc_only_file	:= 
			OUTPUT(moc_input,,moc_only_logical_file, overwrite, compressed);
	Prepped_edu_only_file :=
			OUTPUT(create_edu,,edu_only_logical_file, overwrite, compressed);
			
	biog_only_to_superfile 				:= FileServices.AddSuperFile(biog_only_super_file, biog_only_logical_file);
	cert_only_to_superfile 				:= FileServices.AddSuperFile(cert_only_super_file, 	cert_only_logical_file);
	deceased_only_to_superfile 		:= FileServices.AddSuperFile(deceased_only_super_file, deceased_only_logical_file);
	address_only_to_superfile 		:= FileServices.AddSuperFile(address_only_super_file, address_only_logical_file);
	moc_only_to_superfile 				:= FileServices.AddSuperFile(moc_only_super_file, moc_only_logical_file);
	edu_only_to_superfile					:= FileServices.AddSuperFile(edu_only_super_file, edu_only_logical_file);

	All_prepped_files	:= SEQUENTIAL(
												Prepped_biog_only_file,
												Prepped_cert_only_file,
												Prepped_deceased_only_file,
												Prepped_address_only_file,
												Prepped_moc_only_file,
												Prepped_edu_only_file,
												biog_only_to_superfile,
												cert_only_to_superfile,
												deceased_only_to_superfile,
												address_only_to_superfile,
												moc_only_to_superfile,
												edu_only_to_superfile
												);
	
	RETURN All_prepped_files;
	
END;