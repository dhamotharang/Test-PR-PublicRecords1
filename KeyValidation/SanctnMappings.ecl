EXPORT SanctnMappings := module

//SSN4Key
  export SSN4KeyName        := 'SSN4';
	export SSN4KeyType        := 'Search Key';
	export SSN4KeySet         :=  ['ssn4','batch_number','incident_number','party_number'];
	export SSN4ParentSet      := ['left.ssn4','left.batch_number','left.incident_number','left.party_number'];;
	export SSN4IgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export SSN4UniqueField    :=['ssn4'];
	export SSN4ParentName     := 'SSN4';


//rebuttalKey
  export rebuttalKeyName        := 'rebuttal';
	export rebuttalKeyType        := 'Search Key';
	export rebuttalKeySet         :=  ['batch_number',
																		'incident_number',
																		'party_number',
																		'order_number',
																		'party_text'];
	export rebuttalParentSet      := ['left.batch_number',
																		'left.incident_number',
																		'left.party_number',
																		'left.order_number',
																		'left.party_text'];
	export rebuttalIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export rebuttalUniqueField    :=['batch_number'];
	export rebuttalParentName     := 'rebuttal';
	
//Party Key
  export PartyKeyName        := 'Party';
	export PartyKeyType        := 'Search Key';
	export PartyKeySet         :=  ['batch_number',
																'incident_number',
																'party_number',
																'record_type',
																'order_number',
																'party_name',
																'party_position',
																'party_vocation',
																'party_firm',
																'inaddress',
																'incity',
																'instate',
																'inzip',
																'ssnumber',
																'fines_levied',
																'restitution',
																'ok_for_fcr',
																'party_text',
																'title',
																'fname',
																'mname',
																'lname',
																'name_suffix',
																'name_score',
																'cname',
																'prim_range',
																'predir',
																'prim_name',
																'addr_suffix',
																'postdir',
																'unit_desig',
																'sec_range',
																'p_city_name',
																'v_city_name',
																'st',
																'zip5',
																'zip4',
																'fips_state',
																'fips_county',
																'addr_rec_type',
																'geo_lat',
																'geo_long',
																'cbsa',
																'geo_blk',
																'geo_match',
																'cart',
																'cr_sort_sz',
																'lot',
																'lot_order',
																'dpbc',
																'chk_digit',
																'err_stat'];
	export PartyParentSet      := ['left.batch_number',
												'left.incident_number',
												'left.party_number',
												'left.record_type',
												'left.order_number',
												'left.party_name',
												'left.party_position',
												'left.party_vocation',
												'left.party_firm',
												'left.inaddress',
												'left.incity',
												'left.instate',
												'left.inzip',
												'left.ssnumber',
												'left.fines_levied',
												'left.restitution',
												'left.ok_for_fcr',
												'left.party_text',
												'left.title',
												'left.fname',
												'left.mname',
												'left.lname',
												'left.name_suffix',
												'left.name_score',
												'left.cname',
												'left.prim_range',
												'left.predir',
												'left.prim_name',
												'left.addr_suffix',
												'left.postdir',
												'left.unit_desig',
												'left.sec_range',
												'left.p_city_name',
												'left.v_city_name',
												'left.st',
												'left.zip5',
												'left.zip4',
												'left.fips_state',
												'left.fips_county',
												'left.addr_rec_type',
												'left.geo_lat',
												'left.geo_long',
												'left.cbsa',
												'left.geo_blk',
												'left.geo_match',
												'left.cart',
												'left.cr_sort_sz',
												'left.lot',
												'left.lot_order',
												'left.dpbc',
												'left.chk_digit',
												'left.err_stat'];
	export PartyIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export PartyUniqueField    :=['BATCH_NUMBER'];
	export PartyParentName     := 'Party';	
	
//Party_AKA Key
  export Party_AKA_dbaKeyName        := 'Party_AKA_dba';
	export Party_AKA_dbaKeyType        := 'Search Key';
	export Party_AKA_dbaKeySet         :=  ['batch_number',
																						'incident_number',
																						'party_number',
																						'order_number',
																						'name_type',
																						'aka_dba_text'];
	export Party_AKA_dbaParentSet      := ['left.batch_number',
																				'left.incident_number',
																				'left.party_number',
																				'left.order_number',
																				'left.name_type',
																				'left.aka_dba_text'];
	export Party_AKA_dbaIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export Party_AKA_dbaUniqueField    :=['BATCH_NUMBER'];
	export Party_AKA_dbaParentName     := 'Party_AKA_dba';
	
//NMLS_MIDEX Key
  export NMLS_MIDEXKeyName        := 'NMLS_MIDEX';
	export NMLS_MIDEXKeyType        := 'Search Key';
	export NMLS_MIDEXKeySet         :=  ['midex_rpt_nbr',
																				'batch_number',
																				'incident_number',
																				'party_number',
																				'order_number',
																				'license_number',
																				'license_type',
																				'license_state',
																				'std_type_desc',
																				'nmls_id'];
	export NMLS_MIDEXParentSet      := ['left.midex_rpt_nbr',
																			'left.batch_number',
																			'left.incident_number',
																			'left.party_number',
																			'left.order_number',
																			'left.license_number',
																			'left.license_type',
																			'left.license_state',
																			'left.std_type_desc',
																			'left.nmls_id'];
	export NMLS_MIDEXIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export NMLS_MIDEXUniqueField    :=['midex_rpt_nbr'];
	export NMLS_MIDEXParentName     := 'NMLS_MIDEX';	


//nmls_id Key
  export nmls_idKeyName        := 'nmls_id';
	export nmls_idKeyType        := 'Search Key';
	export nmls_idKeySet         :=  ['nmls_id',
																		'batch_number',
																		'incident_number',
																		'party_number',
																		'order_number',
																		'license_number',
																		'license_type',
																		'license_state',
																		'std_type_desc',
																		'midex_rpt_nbr'  ];
	export nmls_idParentSet      := [ 'left.nmls_id',
																		'left.batch_number',
																		'left.incident_number',
																		'left.party_number',
																		'left.order_number',
																		'left.license_number',
																		'left.license_type',
																		'left.license_state',
																		'left.std_type_desc',
																		'left.midex_rpt_nbr' ];
	export nmls_idIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export nmls_idUniqueField    :=['NMLS_ID'];
	export nmls_idParentName     := 'nmls_id';	
	
//MIDEX_RPT_NBR Key
  export MIDEX_RPT_NBRKeyName        := 'MIDEX_RPT_NBR';
	export MIDEX_RPT_NBRKeyType        := 'Search Key';
	export MIDEX_RPT_NBRKeySet         :=  ['midex_rpt_nbr',
																					'batch_number',
																					'incident_number',
																					'party_number',
																					'order_number',
																					'party_name',
																					'party_position',
																					'party_vocation',
																					'party_firm',
																					'inaddress',
																					'incity',
																					'instate',
																					'inzip',
																					'ssnumber',
																					'fines_levied',
																					'restitution',
																					'ok_for_fcr',
																					'party_text',
																					'title',
																					'fname',
																					'mname',
																					'lname',
																					'name_suffix',
																					'name_score',
																					'cname',
																					'prim_range',
																					'predir',
																					'prim_name',
																					'addr_suffix',
																					'postdir',
																					'unit_desig',
																					'sec_range',
																					'p_city_name',
																					'v_city_name',
																					'st',
																					'zip5',
																					'zip4',
																					'fips_state',
																					'fips_county',
																					'addr_rec_type',
																					'geo_lat',
																					'geo_long',
																					'cbsa',
																					'geo_blk',
																					'geo_match',
																					'cart',
																					'cr_sort_sz',
																					'lot',
																					'lot_order',
																					'dpbc',
																					'chk_digit',
																					'err_stat',
																					'dotid',
																					'dotscore',
																					'dotweight',
																					'empid',
																					'empscore',
																					'empweight',
																					'powid',
																					'powscore',
																					'powweight',
																					'proxid',
																					'proxscore',
																					'proxweight',
																					'seleid',
																					'selescore',
																					'seleweight',
																					'orgid',
																					'orgscore',
																					'orgweight',
																					'ultid',
																					'ultscore',
																					'ultweight',
																					'did',
																					'did_score',
																					'bdid',
																					'bdid_score',
																					'ssn_appended',
																					'dba_name',
																					'contact_name'  ];
	export MIDEX_RPT_NBRParentSet      := ['left.midex_rpt_nbr',
													'left.batch_number',
													'left.incident_number',
													'left.party_number',
													'left.order_number',
													'left.party_name',
													'left.party_position',
													'left.party_vocation',
													'left.party_firm',
													'left.inaddress',
													'left.incity',
													'left.instate',
													'left.inzip',
													'left.ssnumber',
													'left.fines_levied',
													'left.restitution',
													'left.ok_for_fcr',
													'left.party_text',
													'left.title',
													'left.fname',
													'left.mname',
													'left.lname',
													'left.name_suffix',
													'left.name_score',
													'left.cname',
													'left.prim_range',
													'left.predir',
													'left.prim_name',
													'left.addr_suffix',
													'left.postdir',
													'left.unit_desig',
													'left.sec_range',
													'left.p_city_name',
													'left.v_city_name',
													'left.st',
													'left.zip5',
													'left.zip4',
													'left.fips_state',
													'left.fips_county',
													'left.addr_rec_type',
													'left.geo_lat',
													'left.geo_long',
													'left.cbsa',
													'left.geo_blk',
													'left.geo_match',
													'left.cart',
													'left.cr_sort_sz',
													'left.lot',
													'left.lot_order',
													'left.dpbc',
													'left.chk_digit',
													'left.err_stat',
													'left.dotid',
													'left.dotscore',
													'left.dotweight',
													'left.empid',
													'left.empscore',
													'left.empweight',
													'left.powid',
													'left.powscore',
													'left.powweight',
													'left.proxid',
													'left.proxscore',
													'left.proxweight',
													'left.seleid',
													'left.selescore',
													'left.seleweight',
													'left.orgid',
													'left.orgscore',
													'left.orgweight',
													'left.ultid',
													'left.ultscore',
													'left.ultweight',
													'left.did',
													'left.did_score',
													'left.bdid',
													'left.bdid_score',
													'left.ssn_appended',
													'left.dba_name',
													'left.contact_name'  ];
	export MIDEX_RPT_NBRIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export MIDEX_RPT_NBRUniqueField    :=['midex_rpt_nbr'];
	export MIDEX_RPT_NBRParentName     := 'MIDEX_RPT_NBR';	
	
//license_nbr Key
  export license_nbrKeyName        := 'license_nbr';
	export license_nbrKeyType        := 'Search Key';
	export license_nbrKeySet         :=  ['cln_license_number',
																						'license_state',
																						'batch_number',
																						'incident_number',
																						'party_number',
																						'order_number',
																						'license_number',
																						'license_type',
																						'std_type_desc'  ];
	export license_nbrParentSet      := [ 'left.cln_license_number',
																					'left.license_state',
																					'left.batch_number',
																					'left.incident_number',
																					'left.party_number',
																					'left.order_number',
																					'left.license_number',
																					'left.license_type',
																					'left.std_type_desc' ];
	export license_nbrIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export license_nbrUniqueField    :=['CLN_LICENSE_NUMBER'];
	export license_nbrParentName     := 'license_nbr';

//license_midex Key
  export license_midexKeyName        := 'license_midex';
	export license_midexKeyType        := 'Search Key';
	export license_midexKeySet         :=  [ 'midex_rpt_nbr',
																						'batch_number',
																						'incident_number',
																						'party_number',
																						'order_number',
																						'license_number',
																						'license_type',
																						'license_state',
																						'cln_license_number',
																						'std_type_desc' ];
	export license_midexParentSet      := [ 'left.midex_rpt_nbr',
																					'left.batch_number',
																					'left.incident_number',
																					'left.party_number',
																					'left.order_number',
																					'left.license_number',
																					'left.license_type',
																					'left.license_state',
																					'left.cln_license_number',
																					'left.std_type_desc' ];
	export license_midexIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export license_midexUniqueField    :=['midex_rpt_nbr'];
	export license_midexParentName     := 'license_midex';

	//incident Key
  export incidentKeyName        := 'incident';
	export incidentKeyType        := 'Search Key';
	export incidentKeySet         :=  ['batch_number',
																			'incident_number',
																			'order_number',
																			'ag_code',
																			'case_number',
																			'incident_date',
																			'jurisdiction',
																			'source_document',
																			'additional_info',
																			'agency',
																			'alleged_amount',
																			'estimated_loss',
																			'fcr_date',
																			'ok_for_fcr',
																			'incident_text',
																			'incident_date_clean',
																			'fcr_date_clean'  ];
	export incidentParentSet      := ['left.batch_number',
																		'left.incident_number',
																		'left.order_number',
																		'left.ag_code',
																		'left.case_number',
																		'left.incident_date',
																		'left.jurisdiction',
																		'left.source_document',
																		'left.additional_info',
																		'left.agency',
																		'left.alleged_amount',
																		'left.estimated_loss',
																		'left.fcr_date',
																		'left.ok_for_fcr',
																		'left.incident_text',
																		'left.incident_date_clean',
																		'left.fcr_date_clean'  ];
	export incidentIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export incidentUniqueField    :=['BATCH_NUMBER'];
	export incidentParentName     := 'incident';
//incident_midex Key
  export incident_midexKeyName        := 'incident_midex';
	export incident_midexKeyType        := 'Search Key';
	export incident_midexKeySet         :=  ['batch_number',
																						'incident_number',
																						'party_number',
																						'order_number',
																						'ag_code',
																						'case_number',
																						'incident_date',
																						'jurisdiction',
																						'source_document',
																						'additional_info',
																						'agency',
																						'alleged_amount',
																						'estimated_loss',
																						'fcr_date',
																						'ok_for_fcr',
																						'modified_date',
																						'load_date',
																						'incident_text',
																						'incident_date_clean',
																						'fcr_date_clean',
																						'cln_modified_date',
																						'cln_load_date'  ];
	export incident_midexParentSet      := ['left.batch_number',
																					'left.incident_number',
																					'left.party_number',
																					'left.order_number',
																					'left.ag_code',
																					'left.case_number',
																					'left.incident_date',
																					'left.jurisdiction',
																					'left.source_document',
																					'left.additional_info',
																					'left.agency',
																					'left.alleged_amount',
																					'left.estimated_loss',
																					'left.fcr_date',
																					'left.ok_for_fcr',
																					'left.modified_date',
																					'left.load_date',
																					'left.incident_text',
																					'left.incident_date_clean',
																					'left.fcr_date_clean',
																					'left.cln_modified_date',
																					'left.cln_load_date'  ];
	export incident_midexIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export incident_midexUniqueField    :=['BATCH_NUMBER'];
	export incident_midexParentName     := 'incident_midex';
//did Key
  export didKeyName        := 'did';
	export didKeyType        := 'Search Key';
	export didKeySet         :=  [ 'did',
																	'batch_number',
																	'incident_number',
																	'party_number' ];
	export didParentSet      := [ 'left.did',
																'left.batch_number',
																'left.incident_number',
																'left.party_number' ];
	export didIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export didUniqueField    :=['did'];
	export didParentName     := 'did';
//casenum Key
  export casenumKeyName        := 'casenum';
	export casenumKeyType        := 'Search Key';
	export casenumKeySet         :=  [ 'case_number',
																			'batch_number',
																			'incident_number' ];
	export casenumParentSet      := ['left.case_number',
																		'left.batch_number',
																		'left.incident_number'  ];
	export casenumIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export casenumUniqueField    :=['case_number'];
	export casenumParentName     := 'casenum';

//bdidKey
  export bdidKeyName        := 'bdid';
	export bdidKeyType        := 'Search Key';
	export bdidKeySet         :=  [  'bdid',
																	'batch_number',
																	'incident_number',
																	'party_number'];
	export bdidParentSet      := [ 'left.bdid',
																	'left.batch_number',
																	'left.incident_number',
																	'left.party_number' ];
	export bdidIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export bdidUniqueField    :=['bdid'];
	export bdidParentName     := 'bdid';	
	//linkids Key
  export linkidsKeyName        := 'linkids';
	export linkidsKeyType        := 'Search Key';
	export linkidsKeySet         :=  ['ultid',
																		'orgid',
																		'seleid',
																		'proxid',
																		'powid',
																		'empid',
																		'dotid',
																		'ultscore',
																		'orgscore',
																		'selescore',
																		'proxscore',
																		'powscore',
																		'empscore',
																		'dotscore',
																		'ultweight',
																		'orgweight',
																		'seleweight',
																		'proxweight',
																		'powweight',
																		'empweight',
																		'dotweight',
																		'batch_number',
																		'incident_number',
																		'party_number',
																		'record_type',
																		'order_number',
																		'party_name',
																		'party_position',
																		'party_vocation',
																		'party_firm',
																		'inaddress',
																		'incity',
																		'instate',
																		'inzip',
																		'ssnumber',
																		'fines_levied',
																		'restitution',
																		'ok_for_fcr',
																		'party_text',
																		'title',
																		'fname',
																		'mname',
																		'lname',
																		'name_suffix',
																		'name_score',
																		'cname',
																		'prim_range',
																		'predir',
																		'prim_name',
																		'addr_suffix',
																		'postdir',
																		'unit_desig',
																		'sec_range',
																		'p_city_name',
																		'v_city_name',
																		'st',
																		'zip5',
																		'zip4',
																		'fips_state',
																		'fips_county',
																		'addr_rec_type',
																		'geo_lat',
																		'geo_long',
																		'cbsa',
																		'geo_blk',
																		'geo_match',
																		'cart',
																		'cr_sort_sz',
																		'lot',
																		'lot_order',
																		'dpbc',
																		'chk_digit',
																		'err_stat',
																		'source_rec_id',
																		'did',
																		'did_score',
																		'bdid',
																		'bdid_score',
																		'ssn_appended',
																		'dba_name',
																		'contact_name'];
	export linkidsParentSet      := ['left.ultid',
																	'left.orgid',
																	'left.seleid',
																	'left.proxid',
																	'left.powid',
																	'left.empid',
																	'left.dotid',
																	'left.ultscore',
																	'left.orgscore',
																	'left.selescore',
																	'left.proxscore',
																	'left.powscore',
																	'left.empscore',
																	'left.dotscore',
																	'left.ultweight',
																	'left.orgweight',
																	'left.seleweight',
																	'left.proxweight',
																	'left.powweight',
																	'left.empweight',
																	'left.dotweight',
																	'left.batch_number',
																	'left.incident_number',
																	'left.party_number',
																	'left.record_type',
																	'left.order_number',
																	'left.party_name',
																	'left.party_position',
																	'left.party_vocation',
																	'left.party_firm',
																	'left.inaddress',
																	'left.incity',
																	'left.instate',
																	'left.inzip',
																	'left.ssnumber',
																	'left.fines_levied',
																	'left.restitution',
																	'left.ok_for_fcr',
																	'left.party_text',
																	'left.title',
																	'left.fname',
																	'left.mname',
																	'left.lname',
																	'left.name_suffix',
																	'left.name_score',
																	'left.cname',
																	'left.prim_range',
																	'left.predir',
																	'left.prim_name',
																	'left.addr_suffix',
																	'left.postdir',
																	'left.unit_desig',
																	'left.sec_range',
																	'left.p_city_name',
																	'left.v_city_name',
																	'left.st',
																	'left.zip5',
																	'left.zip4',
																	'left.fips_state',
																	'left.fips_county',
																	'left.addr_rec_type',
																	'left.geo_lat',
																	'left.geo_long',
																	'left.cbsa',
																	'left.geo_blk',
																	'left.geo_match',
																	'left.cart',
																	'left.cr_sort_sz',
																	'left.lot',
																	'left.lot_order',
																	'left.dpbc',
																	'left.chk_digit',
																	'left.err_stat',
																	'left.source_rec_id',
																	'left.did',
																	'left.did_score',
																	'left.bdid',
																	'left.bdid_score',
																	'left.ssn_appended',
																	'left.dba_name',
																	'left.contact_name' ];
	export linkidsIgnoredFields  :=['fp','qa_defined_empty'];
	export linkidsUniqueField    :=['ultid'];
	export linkidsParentName     := 'linkids';
	
	
	
	//AutokeyAdress Key
  export AddressAKKeyName := 'AutokeyAdress';
	export AddressAKKeyType := 'Search Key';
	export AddressAKKeySet := ['prim_name','prim_range','st','zip','sec_range','lname','fname','did'];
	export AddressAKParentSet :=  ['ut.stripOrdinal(left.prim_name)','TRIM(ut.CleanPrimRange(left.prim_range),left)','left.st','left.zip5','left.sec_range','left.lname',
	                               'left.fname','left.did'];
	export AddressAKIgnoredFields :=['lname1','lname2','lname3','states','pfname', 'lookups','dph_lname','city_code','qa_defined_empty'];
	export AddressAKUniqueField :=['did'];
	export AddressAKParentName := 'AutokeyPayload';
	
	//Autokeycitystname Key
  export CityStNameAKKeyName := 'Autokeycitystname';
	export CityStNameAKKeyType := 'Search Key';
	export CityStNameAKKeySet := ['st','lname','fname','did','dob'];
	export CityStNameAKParentSet := ['left.st','left.lname','left.fname','left.did','((integer4)left.dob)'];
	export CityStNameAKIgnoredFields :=['city1','city2','city3','rel_fname1','rel_fname2','rel_fname3','lname1','lname2','lname3','states','pfname','lookups','dph_lname',
																			'city_code','qa_defined_empty'];
	export CityStNameAKUniqueField :=['did'];
	export CityStNameAKParentName := 'AutokeyPayload';

	//AutokeyName Key
  export NameAKKeyName := 'AutokeyName';
	export NameAKKeyType := 'Search Key';
	export NameAKKeySet :=  ['lname','fname','did','dob','s4','yob'];
	export NameAKParentSet := ['left.lname','left.fname','left.did','((integer4)left.dob)', '((integer4)left.ssn[6..9])','((integer4)(left.dob[1..4]))'];
	export NameAKIgnoredFields :=['minit','lname1','lname2','lname3','city1','city2','city3','rel_fname1','rel_fname2','rel_fname3','states','pfname','lookups','dph_lname',
	                              'qa_defined_empty'];
	export NameAKUniqueField :=['did'];
	export NameAKParentName := 'AutokeyPayload';

	//AutokeySSN2 Key
  export SSN2AKKeyName := 'AutokeySSN2';
	export SSN2AKKeyType := 'Search Key';
	export SSN2AKKeySet :=   ['s1','s2','s3','s4','s5','s6','s7','s8','s9', 'did'];
	export SSN2AKParentSet := [ 'left.ssn[1]', 'left.ssn[2]', 'left.ssn[3]','left.ssn[4]', 'left.ssn[5]', 'left.ssn[6]', 'left.ssn[7]', 'left.ssn[8]', 'left.ssn[9]','left.did'];
	export SSN2AKIgnoredFields :=	['dph_lname', 'pfname', 'lookups', 'qa_defined_empty'];
	export SSN2AKUniqueField :=['did'];
	export SSN2AKParentName := 'AutokeyPayload';

	//AutokeyStName Key
  export StNameAKKeyName        := 'AutokeyStName';
	export StNameAKKeyType        := 'Search Key';
	export StNameAKKeySet         := ['st','lname', 'fname','yob','s4', 'zip','dob',  'did'];
	export StNameAKParentSet      := [ 'left.st','left.lname','left.fname','((integer4)(left.dob[1..4]))', '((integer4)left.ssn[6..9])', '((integer4)left.zip5)',
																																			'((integer4)left.dob)', 'left.did'];
	export StNameAKIgnoredFields  :=['minit','dph_lname','pfname', 'states', 'lname1', 'lname2', 'lname3','city1', 'city2', 'city3', 'rel_fname1', 'rel_fname2', 'rel_fname3',
																	'lookups', 'qa_defined_empty' ];
	export StNameAKUniqueField    :=['did'];
	export StNameAKParentName     := 'AutokeyPayload';

	//AutokeyZip Key
  export ZipAKKeyName := 'AutokeyZip';
	export ZipAKKeyType := 'Search Key';
	export ZipAKKeySet :=  ['lname', 'fname','yob','s4', 'zip', 'dob',  'did'];
	export ZipAKParentSet :=  ['left.lname', 'left.fname','((integer4)(left.dob[1..4]))','((integer4)left.ssn[6..9])', '((integer4)left.zip5)','((integer4)left.dob)', 'left.did'];
	export ZipAKIgnoredFields :=['minit','dph_lname', 'pfname', 'states', 'lname1','lname2','lname3','city1','city2','city3','rel_fname1','rel_fname2','rel_fname3', 'lookups',
	                             'qa_defined_empty'];
	export ZipAKUniqueField :=['did'];
	export ZipAKParentName := 'AutokeyPayload';
		
	//Zipb2AK Key
	export Zipb2AKKeyName := 'AutokeyZipB2';
	export Zipb2AKKeyType := 'Search Key';
	export Zipb2AKKeySet := ['zip', 'bdid'];
	export Zipb2AKParentSet := [ '(integer4)left.person_addr__zip5', 'left.fakeid'];
	export Zipb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty' ];
	export Zipb2AKUniqueField := ['bdid'];
	export Zipb2AKParentName := 'AutokeyZipB2';	
	
	//StNameb2AK Key
  export StNameb2AKKeyName := 'AutoKeyStNameb2';
	export StNameb2AKKeyType := 'Search Key';
	export StNameb2AKKeySet := ['st', 'bdid'];
	export StNameb2AKParentSet := ['left.person_addr__st', 'left.fakeid'];
	export StNameb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export StNameb2AKUniqueField := ['bdid'];
	export StNameb2AKParentName := 'AutoKeyStNameb2';	
	
		//Addressb2AK Key
	export Addressb2AKKeyName := 'AutoKeyAddressb2';
	export Addressb2AKKeyType := 'Search Key';	
	export Addressb2AKKeySet := ['prim_name', 'prim_range',  'st', 'zip', 'sec_range', 'bdid'];
	export Addressb2AKParentSet := ['ut.stripOrdinal(left.person_addr__prim_name)', 
																					 'TRIM(ut.CleanPrimRange(left.person_addr__prim_range),left)',  
																					 'left.person_addr__st',  'left.person_addr__zip5', 
																					 'left.person_addr__sec_range', 'left.fakeid'];
	export Addressb2AKIgnoredFields := ['city_code', 'cname_indic', 'cname_sec', 'lookups', 'qa_defined_empty' ];
	export Addressb2AKUniqueField := ['bdid'];
	export Addressb2AKParentName := 'AutoKeyAddressb2';
	
		//NameWords2AK Key
	export Namewords2AKKeyName := 'AutoKeynamewords2';
	export Namewords2AKKeyType := 'Search Key';	
	export NameWords2AKKeySet := ['state', 'bdid'];
	export NameWords2AKParentSet := [ 'left.person_addr__st', 'left.fakeid'];
	export NameWords2AKIgnoredFields := ['word', 'seq', 'lookups', ' qa_defined_empty' ];
	export NameWords2AKUniqueField := ['bdid'];
	export NameWords2AKParentName := 'AutoKeynamewords2';
	
		//CityStNameb2AK Key
  export CityStName2AKKeyName := 'AutoKeyCityStName2';
	export CityStname2AKKeyType := 'Search Key';	
	export CityStNameb2AKKeySet := ['st', 'bdid'];
	export CityStNameb2AKParentSet := ['left.person_addr__st', 'left.fakeid'];
	export CityStNameb2AKIgnoredFields := ['city_code', ' cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty'];
	export CityStNameb2AKUniqueField := ['bdid'];
	export CityStNameb2AKParentName := 'AutoKeyCityStName2';
	//Nameb2AK Key
	export Nameb2AKKeyName := 'AutoKeynameb2';
	export Nameb2AKKeyType := 'Search Key';	
	export Nameb2AKKeySet := ['bdid'];
	export Nameb2AKParentSet := ['left.fakeid'];
	export Nameb2AKIgnoredFields := ['cname_indic', ' cname_sec', ' lookups', ' qa_defined_empty' ];
	export Nameb2AKUniqueField := ['bdid'];
	export Nameb2AKParentName := 'AutokeyNameb2';	
	
end;