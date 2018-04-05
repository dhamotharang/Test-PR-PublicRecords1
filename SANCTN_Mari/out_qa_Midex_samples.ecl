import SANCTN_Mari;

	//base files from current build
  file_incident 			:= dataset('~thor_data400::base::sanctn::np::incident',
																 SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base,thor);
  file_incident_text 	:= dataset('~thor_data400::base::sanctn::np::incidenttext',
	                               SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text,thor);
  file_incident_code 	:= dataset('~thor_data400::base::sanctn::np::incidentcode',
	                               SANCTN_Mari.layouts_SANCTN_common.Midex_cd,thor);													 
  file_incident_bip 	:= dataset('~thor_data400::base::sanctn::np::incident_bip',
	                               SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip,thor);															 
  file_party		 			:= dataset('~thor_data400::base::sanctn::np::party',
	                               SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base,thor);
  file_party_text 		:= dataset('~thor_data400::base::sanctn::np::partytext',
	                               SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text,thor);
	file_party_bip  		:= dataset('~thor_data400::base::sanctn::np::party_bip',
	                               SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip,thor);
	
	//base files from previous build
  file_incident_father			:= dataset('~thor_data400::base::sanctn::np::incident_father',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base,thor);
  file_incident_text_father := dataset('~thor_data400::base::sanctn::np::incidenttext_father',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text,thor);
  file_incident_code_father	:= dataset('~thor_data400::base::sanctn::np::incidentcode_father',
																			 SANCTN_Mari.layouts_SANCTN_common.Midex_cd,thor);
  //The first time running this attribute on production, no file exists within incident_bip_father
	//so we assign the incident_bip superfile to file_incident_bip_father.
	file_incident_bip_father 	:= if (not Constants.FIRST_TIME	= true																			 
															,dataset('~thor_data400::base::sanctn::np::incident_bip_father',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip,thor)
															,dataset('~thor_data400::base::sanctn::np::incident_bip',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip,thor)
															 );																				 
  file_party_father		 			:= dataset('~thor_data400::base::sanctn::np::party_father',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base,thor);
  file_party_text_father 		:= dataset('~thor_data400::base::sanctn::np::partytext_father',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text,thor);
  //The first time running this attribute on production, no file exists within party_bip_father
	//so we assign the party_bip superfile to file_party_bip_father.
	file_party_bip_father 		:= if (not Constants.FIRST_TIME = true
															,dataset('~thor_data400::base::sanctn::np::party_bip_father',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip,thor)																			 
															,dataset('~thor_data400::base::sanctn::np::party_bip',
																			 SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip,thor)
															 );	
	
	//Incident
	dist_file_incident := distribute(file_incident,HASH32(BATCH,DBCODE,INCIDENT_NUM));
	dist_file_incident_father := distribute(file_incident_father,HASH32(BATCH,DBCODE,INCIDENT_NUM));

	SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base tx_join_incident(dist_file_incident le,dist_file_incident_father re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_incident := join(dist_file_incident, dist_file_incident_father,
   						          LEFT.BATCH = RIGHT.BATCH AND 
												LEFT.DBCODE = RIGHT.DBCODE AND 
												LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,  
												tx_join_incident(LEFT,RIGHT),
												LEFT ONLY,
												LOCAL);     
	sort_incident := sort(join_incident,BATCH,DBCODE,INCIDENT_NUM,CASE_NUM,local);
	dedp_incident := dedup(sort_incident,BATCH,DBCODE,INCIDENT_NUM,CASE_NUM,local);
	//cnt_incident  := output('# of updated incident records is ' + count(dedp_incident) +'.');
	out_incident 	:= output(choosen(dedp_incident,100),,named('INCIDENT_QA_SAMPLES'));

	//Incident text
	dist_file_incident_text := distribute(file_incident_text,HASH32(BATCH,INCIDENT_NUM));
	dist_file_incident_text_father := distribute(file_incident_text_father,HASH32(BATCH,INCIDENT_NUM));

	SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text 
	tx_join_incident_text(dist_file_incident_text le,dist_file_incident_text_father re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_incident_text := join(dist_file_incident_text, dist_file_incident_text_father,
														 LEFT.BATCH = RIGHT.BATCH AND 
														 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM AND
														 LEFT.SEQ = RIGHT.SEQ AND 
														 LEFT.FIELD_TXT = RIGHT.FIELD_TXT AND 
														 LEFT.FIELD_NAME = RIGHT.FIELD_NAME,  
														 tx_join_incident_text(LEFT,RIGHT),
														 LEFT ONLY,
														 LOCAL); 														 
														 
	sort_incident_text := sort(join_incident_text,BATCH,INCIDENT_NUM,FIELD_TXT,local);
	dedp_incident_text := dedup(sort_incident_text,BATCH,INCIDENT_NUM,FIELD_TXT,local);
	//cnt_incident_text  := output('# of updated incident text records is ' + count(dedp_incident_text) +'.');
	out_incident_text 	:= output(dedp_incident_text,,named('INCIDENTTEXT_QA_SAMPLES'));

	//Incident code
	dist_file_incident_code := distribute(file_incident_code,HASH32(BATCH,INCIDENT_NUM));
	dist_file_incident_code_father := distribute(file_incident_code_father,HASH32(BATCH,INCIDENT_NUM));

	SANCTN_Mari.layouts_SANCTN_common.Midex_cd 
	tx_join_incident_code(dist_file_incident_code le,dist_file_incident_code_father re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_incident_code := join(dist_file_incident_code, dist_file_incident_code_father,
														 LEFT.BATCH = RIGHT.BATCH AND LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,  
														 tx_join_incident_code(LEFT,RIGHT),
														 LEFT ONLY,
														 LOCAL);     
	sort_incident_code := sort(join_incident_code,BATCH,INCIDENT_NUM,CLN_LICENSE_NUMBER,local);
	dedp_incident_code := dedup(sort_incident_code,BATCH,INCIDENT_NUM,CLN_LICENSE_NUMBER,local);
	//cnt_incident_code  := output('# of updated incident code records is ' + count(dedp_incident_code) +'.');
	out_incident_code 	:= output(dedp_incident_code,,named('INCIDENTCODE_QA_SAMPLES'));

	//Incident_Bip
	dist_file_incident_Bip := distribute(file_incident_Bip,HASH32(BATCH,INCIDENT_NUM));
	dist_file_incident_Bip_father := distribute(file_incident_Bip_father,HASH32(BATCH,INCIDENT_NUM));

	SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip tx_join_incident_bip(dist_file_incident_Bip le,dist_file_incident_Bip_father re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_incident_bip := join(dist_file_incident_Bip, dist_file_incident_Bip_father,
   						          LEFT.BATCH = RIGHT.BATCH AND LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,  
												tx_join_incident_bip(LEFT,RIGHT),
												LEFT ONLY,
												LOCAL);     
	sort_incident_bip := sort(join_incident_bip,BATCH,INCIDENT_NUM,local);
	dedp_incident_bip := dedup(sort_incident_bip,BATCH,INCIDENT_NUM,local);
	//cnt_incident  := output('# of updated incident records is ' + count(dedp_incident) +'.');
	out_incident_bip 	:= output(dedp_incident_bip,,named('INCIDENT_BIP_QA_SAMPLES'));

	//Party
	dist_file_party := distribute(file_party,HASH32(BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM));
	dist_file_party_father := distribute(file_party_father,HASH32(BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM));

	SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base 
	tx_join_party(dist_file_party le,dist_file_party_father re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_party := join(dist_file_party, dist_file_party_father,
										 LEFT.BATCH = RIGHT.BATCH AND 
										 LEFT.DBCODE = RIGHT.DBCODE AND
										 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM AND
										 LEFT.PARTY_NUM = RIGHT.PARTY_NUM,  
										 tx_join_party(LEFT,RIGHT),
										 LEFT ONLY,
										 LOCAL);     
	sort_party := sort(join_party,BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM);
	dedp_party := dedup(sort_party,BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM);
	//cnt_party  := output('# of updated party records is ' + count(dedp_party) +'.');
	out_party 	:= output(choosen(dedp_party,1000),,named('PARTY_QA_SAMPLES'));

	//PartyBip
	dist_file_party_bip := distribute(file_party_bip,HASH32(BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM));
	dist_file_party_father_bip := distribute(file_party_bip_father,HASH32(BATCH,DBCODE, INCIDENT_NUM,PARTY_NUM));

	SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip 
	tx_join_party_bip(dist_file_party_bip le,dist_file_party_father_bip re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_party_bip := join(dist_file_party_bip, dist_file_party_father_bip,
										 LEFT.BATCH = RIGHT.BATCH AND 
										 LEFT.DBCODE = RIGHT.DBCODE AND
										 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM AND
										 LEFT.PARTY_NUM = RIGHT.PARTY_NUM,  
										 tx_join_party_bip(LEFT,RIGHT),
										 LEFT ONLY,
										 LOCAL);     
	sort_party_bip := sort(join_party_bip,BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM,local);
	dedp_party_bip := dedup(sort_party_bip,BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM,local);
	//cnt_party_bip  := output('# of updated party bip records is ' + count(dedp_party_bip) +'.');
	out_party_bip := output(dedp_party_bip,,named('PARTY_BIP_QA_SAMPLES'));

	//Party text
	dist_file_party_text := distribute(file_party_text,HASH32(BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM));
	dist_file_party_text_father := distribute(file_party_text_father,HASH32(BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM));


	SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text 
	tx_join_party_text(dist_file_party_text le,dist_file_party_text_father re) := transform
   	self := le;
	end;
   
  //Join operation to get updates
  join_party_text := join(dist_file_party_text, dist_file_party_text_father,
										 LEFT.BATCH = RIGHT.BATCH AND 
										 LEFT.DBCODE = RIGHT.DBCODE AND
										 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM AND
										 LEFT.PARTY_NUM = RIGHT.PARTY_NUM AND
										 LEFT.FIELD_NAME = RIGHT.FIELD_NAME AND  
										 LEFT.SEQ = RIGHT.SEQ AND  
										 LEFT.FIELD_TXT = RIGHT.FIELD_TXT,  
										 tx_join_party_text(LEFT,RIGHT),
										 LEFT ONLY,
										 LOCAL);     
	sort_party_text := sort(join_party_text,BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM,local);
	dedp_party_text := dedup(sort_party_text,BATCH,DBCODE,INCIDENT_NUM,PARTY_NUM,local);
	//cnt_party_text  := output('# of updated party text records is ' + count(dedp_party_text) +'.');
	out_party_text 	:= output(dedp_party_text,,named('PARTYTEXT_QA_SAMPLES'));

	//roll up incident text
	SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text rollup_incident_text(dedp_incident_text le,dedp_incident_text re) := transform
		self.field_txt := trim(le.field_txt) + '  . ' + '\n' + trim(re.field_txt);
		self := le;
	end;  
  incident_text_roll := rollup(dedp_incident_text,LEFT.BATCH = RIGHT.BATCH AND
															 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,
															 rollup_incident_text(LEFT,RIGHT),local);
	//roll up party text
	SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text rollup_party_text(dedp_party_text le,dedp_party_text re) := transform
		self.field_txt := trim(le.field_txt) + '  . ' + '\n' +trim(re.field_txt);
		self := le;
	end;   
  party_text_roll := rollup(dedp_party_text,LEFT.BATCH = RIGHT.BATCH AND
															 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,
															 rollup_party_text(LEFT,RIGHT),local);
	//roll up incident code
	SANCTN_Mari.layouts_SANCTN_common.Midex_cd rollup_incodeent_code(dedp_incident_code le,dedp_incident_code re) := transform
		self.cln_license_number := trim(le.cln_license_number) + '  . ' + '\n' +trim(re.cln_license_number);
		self := le;
	end;   
  incident_code_roll := rollup(dedp_incident_code,LEFT.BATCH = RIGHT.BATCH AND
															 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,
															 rollup_incodeent_code(LEFT,RIGHT),local);

	layout_merged := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base;	
		STRING incident_text_plus;
		STRING party_text_plus;
		STRING license_nbr_plus;
	end;
	
	layout_merged add_incident_text(dedp_incident le,incident_text_roll re) := transform
		self.incident_text_plus := re.field_txt;
		self := le;
		self := [];
	end;
	
	merge1 := join(dedp_incident,incident_text_roll,
	  						 LEFT.BATCH = RIGHT.BATCH AND 
   							 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,
								 add_incident_text(LEFT,RIGHT),
								 LOCAL);

	layout_merged add_party_text(merge1 le,party_text_roll re) := transform
		self.party_text_plus := re.field_txt;
		self := le;
	end;

	merge2 := join(merge1,party_text_roll,
	  						 LEFT.BATCH = RIGHT.BATCH AND 
   							 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,
								 add_party_text(LEFT,RIGHT),
								 LEFT OUTER,
								 LOCAL);

	layout_merged add_license_nbr(merge2 le,incident_code_roll re) := transform
		self.license_nbr_plus := re.cln_license_number;
		self := le;
	end;

	merge3 := join(merge2,incident_code_roll,
	  						 LEFT.BATCH = RIGHT.BATCH AND 
   							 LEFT.INCIDENT_NUM = RIGHT.INCIDENT_NUM,
								 add_license_nbr(LEFT,RIGHT),
								 LEFT OUTER,
								 LOCAL);


  out_all := output(merge3,,named('SANCTN_NP_QA_SAMPLES_ALL'));
	
	export out_qa_Midex_samples := sequential(
																					out_incident
																				  ,out_incident_text
																				  ,out_incident_code
																					,out_incident_bip
																				  ,out_party
																					,out_party_bip
																				  ,out_party_text
																				  ,out_all
																				 );																		 
