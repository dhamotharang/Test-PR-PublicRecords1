//************************************************************************************************************************************//
//Mapping information - IID Keys to Parent
//************************************************************************************************************************************//
EXPORT IIDMappings := MODULE

//Report Key
  export ReportKeyName        := 'ReportFile';
	export ReportKeyType        := 'Payload Key';
	export ReportKeySet         :=  ['transaction_id','product','date_added','request_data','response_data'];
	export ReportParentSet      := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export ReportIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export ReportUniqueField    :=['transaction_id'];
	export ReportParentName     := 'Report';

//Report1 Key
  export Report1KeyName       := 'ReportFile1';
	export Report1KeyType       := 'Payload Key';
	export Report1KeySet        :=  ['transaction_id','product','date_added','request_data','response_data'];
	export Report1ParentSet     := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export Report1IgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export Report1UniqueField   :=['transaction_id'];
	export Report1ParentName    := 'Report1';

//Report2 Key
  export Report2KeyName       := 'ReportFile2';
	export Report2KeyType       := 'Payload Key';
	export Report2KeySet        :=  ['transaction_id','product','date_added','request_data','response_data'];
	export Report2ParentSet     := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export Report2IgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export Report2UniqueField   :=['transaction_id'];
	export Report2ParentName    := 'Report2';

//Report3 Key
  export Report3KeyName       := 'ReportFile3';
	export Report3KeyType       := 'Payload Key';
	export Report3KeySet        :=  ['transaction_id','product','date_added','request_data','response_data'];
	export Report3ParentSet     := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export Report3IgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export Report3UniqueField   :=['transaction_id'];
	export Report3ParentName    := 'Report3';

//Report4 Key
  export Report4KeyName       := 'ReportFile4';
	export Report4KeyType       := 'Payload Key';
	export Report4KeySet        :=  ['transaction_id','product','date_added','request_data','response_data'];
	export Report4ParentSet     := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export Report4IgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export Report4UniqueField   :=['transaction_id'];
	export Report4ParentName    := 'Report4';

//Report5 Key
  export Report5KeyName       := 'ReportFile5';
	export Report5KeyType       := 'Payload Key';
	export Report5KeySet        :=  ['transaction_id','product','date_added','request_data','response_data'];
	export Report5ParentSet     := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export Report5IgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export Report5UniqueField   :=['transaction_id'];
	export Report5ParentName    := 'Report5';

	//Report6 Key
  export Report6KeyName       := 'ReportFile6';
	export Report6KeyType       := 'Payload Key';
	export Report6KeySet        :=  ['transaction_id','product','date_added','request_data','response_data'];
	export Report6ParentSet     := ['left.transaction_id','left.product','left.date_added','left.request_data', 'left.response_data'];
	export Report6IgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export Report6UniqueField   :=['transaction_id'];
	export Report6ParentName    := 'Report6';

	//Verification Key
  export VerificationKeyName       := 'Verification';
	export VerificationKeyType       := 'Payload Key';
	export VerificationKeySet        := ['transaction_id','product','name','is_verified','date_added','source_count'];
	export VerificationParentSet     := ['left.transaction_id','left.product','left.name','left.is_verified','left.date_added','left.source_count'];
	export VerificationIgnoredFields :=['qa_defined_empty'];
	export VerificationUniqueField   :=['transaction_id'];
	export VerificationParentName    := 'Verification';

	//Risk Key
  export RiskKeyName          := 'Risk';
	export RiskKeyType          := 'Payload Key';
	export RiskKeySet           := ['transaction_id','product','risk_code','description','date_added'];
	export RiskParentSet        := ['left.transaction_id','left.product','left.risk_code', 'left.description','left.date_added'];
	export RiskIgnoredFields    :=['__internal_fpos__','qa_defined_empty'];
	export RiskUniqueField      :=['transaction_id'];
	export RiskParentName       := 'Risk';
	
	//Model Key
  export ModelKeyName         := 'Model';
	export ModelKeyType         := 'Payload Key';
	export ModelKeySet          := ['transaction_id','score_id','product','name','score','score_type','date_added'];
	export ModelParentSet       := ['left.transaction_id','left.score_id','left.product','left.name','left.score','left.score_type','left.date_added'];
	export ModelIgnoredFields   :=['__internal_fpos__','qa_defined_empty'];
	export ModelUniqueField     :=['transaction_id'];
	export ModelParentName      := 'Model';
	
	//ModelRisk Key
  export ModelRiskKeyName       := 'ModelRisk';
	export ModelRiskKeyType       := 'Payload Key';
	export ModelRiskKeySet        := ['transaction_id','score_id','product','risk_code', 'description', 'date_added'];
	export ModelRiskParentSet     := ['left.transaction_id','left.score_id','left.product','left.risk_code','left.description', 'left.date_added'];
	export ModelRiskIgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export ModelRiskUniqueField   :=['transaction_id'];
	export ModelRiskParentName    := 'ModelRisk';

	//DateAdded Key
  export DateAddedKeyName       := 'DateAdded';
	export DateAddedKeyType       := 'Payload Key';
	export DateAddedKeySet        := ['company_id','product','date_added','country','transaction_id'];
	export DateAddedParentSet     := ['left.company_id','left.product','left.date_added','left.country','left.transaction_id'];
	export DateAddedIgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export DateAddedUniqueField   :=['transaction_id'];
	export DateAddedParentName    := 'DateAdded';

	//RiskIndex Key
  export RiskIndexKeyName       := 'RiskIndex';
	export RiskIndexKeyType       := 'Payload Key';
	export RiskIndexKeySet        := ['transaction_id','score_id','product','name','ivalue', 'date_added'];
	export RiskIndexParentSet     := ['left.transaction_id','left.score_id','left.product','left.name','left.ivalue', 'left.date_added'];
	export RiskIndexIgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export RiskIndexUniqueField   :=['transaction_id'];
	export RiskIndexParentName    := 'RiskIndex';	
	
	//Redflags Key
  export RedflagsKeyName        := 'Redflags';
	export RedflagsKeyType        := 'Payload Key';
	export RedflagsKeySet         := ['transaction_id','product','rec_version','name','risk_code', 'description','date_added'];
	export RedflagsParentSet      := ['left.transaction_id','left.product','left.rec_version','left.name','left.risk_code','left.description','left.date_added'];
	export RedflagsIgnoredFields  :=['__internal_fpos__','qa_defined_empty'];
	export RedflagsUniqueField    :=['transaction_id'];
	export RedflagsParentName     := 'Redflags';		
	
	//Payload Key
  export PayloadKeyName         := 'Payload';
	export PayloadKeyType         := 'Payload Key';
	export PayloadKeySet := ['transaction_id','product','country','transaction_id_key','company_id','company_id_source','version','source','iidi_type','batch_job_id',
	                      'batch_seq_number','orig_fname','orig_mname','orig_lname','fullname','maiden_name','gender','orig_address_number','orig_address','orig_address_type',
												'orig_city','orig_state','orig_zip','orig_dob','orig_ssn','street_address1','street_address2','unit_number','building_number','building_name',
												'floor_number','suburb','district','county','phone','mobile_phone','work_phone','national_id_city_issued','national_id_district_issued',
												'national_id_county_issued','national_id_province_issued','dl_number','dl_version_number','dl_state','dl_expire_date','passport_number',
												'passport_expire_date','passport_place_birth','passport_country_birth','passport_family_name_birth','clean_rec','dob','ssn','title','fname',
												'mname','lname','name_suffix','name_score','title2','fname2','mname2','lname2','name_suffix2','prim_range','predir','prim_name','addr_suffix','postdir',
												'unit_desig','sec_range','v_city_name','st','zip5','zip4','addr_rec_type','fips_state','fips_county','geo_lat','geo_long','cbsa','geo_blk','geo_match',
												'err_stat','prim_range2','predir2','prim_name2','addr_suffix2','postdir2','unit_desig2','sec_range2','v_city_name2','st2','zip52','zip42','query_id',
												'unique_id','national_id','cvi','nas','nap','ivi','compliance_level','dob_verified','fname_verified','lname_verified','address_verified','city_verified',
												'state_verified','zip_verified','home_phone_verified','dob_match_verified','ssn_verified','dl_verified','date_added'];
	export PayloadParentSet := ['left.transaction_id','left.product','left.country','left.transaction_id_key','left.company_id','left.company_id_source','left.version',
													 'left.source','left.iidi_type','left.batch_job_id','left.batch_seq_number','left.orig_fname', 'left.orig_mname','left.orig_lname','left.fullname',
													 'left.maiden_name','left.gender', 'left.orig_address_number','left.orig_address','left.orig_address_type','left.orig_city','left.orig_state',
													 'left.orig_zip','left.orig_dob','left.orig_ssn','left.street_address1','left.street_address2','left.unit_number','left.building_number',
													 'left.building_name', 'left.floor_number','left.suburb','left.district','left.county','left.phone','left.mobile_phone','left.work_phone',
													 'left.national_id_city_issued','left.national_id_district_issued','left.national_id_county_issued','left.national_id_province_issued',
													 'left.dl_number', 'left.dl_version_number','left.dl_state','left.dl_expire_date','left.passport_number', 'left.passport_expire_date',
													 'left.passport_place_birth','left.passport_country_birth','left.passport_family_name_birth','left.clean_rec','left.dob','left.ssn','left.title',
													 'left.fname','left.mname','left.lname','left.name_suffix','left.name_score','left.title2','left.fname2','left.mname2','left.lname2',
													 'left.name_suffix2','left.prim_range','left.predir','left.prim_name','left.addr_suffix','left.postdir','left.unit_desig','left.sec_range',
													 'left.v_city_name','left.st','left.zip5','left.zip4','left.addr_rec_type','left.fips_state','left.fips_county','left.geo_lat','left.geo_long',
													 'left.cbsa','left.geo_blk','left.geo_match','left.err_stat','left.prim_range2','left.predir2','left.prim_name2','left.addr_suffix2','left.postdir2',
													 'left.unit_desig2','left.sec_range2','left.v_city_name2','left.st2','left.zip52','left.zip42','left.query_id','left.unique_id','left.national_id',
													 'left.cvi','left.nas','left.nap','left.ivi','left.compliance_level','left.dob_verified','left.fname_verified','left.lname_verified',
													 'left.address_verified','left.city_verified','left.state_verified','left.zip_verified','left.home_phone_verified','left.dob_match_verified',
													 'left.ssn_verified','left.dl_verified','left.date_added'];
	export PayloadIgnoredFields :=['__internal_fpos__','qa_defined_empty'];
	export PayloadUniqueField   :=['transaction_id'];
	export PayloadParentName    := 'Payload';		
		
	//AutokeyPayload Key
  export PayloadAKKeyName     := 'AutokeyPayload';
	export PayloadAKKeyType     := 'Payload Key';
	export PayloadAKKeySet := ['transaction_id','product','country','transaction_id_key','company_id','company_id_source','version','source','iidi_type',
														 'batch_job_id','batch_seq_number','orig_fname','orig_mname','orig_lname','fullname','maiden_name','gender','orig_address_number','orig_address',
														 'orig_address_type','orig_city','orig_state','orig_zip','orig_dob','orig_ssn','street_address1','street_address2','unit_number',
														 'building_number','building_name','floor_number','suburb','district','county','phone','mobile_phone','work_phone','national_id_city_issued',
														 'national_id_district_issued','national_id_county_issued','national_id_province_issued','dl_number','dl_version_number',
														 'dl_state','dl_expire_date','passport_number','passport_expire_date','passport_place_birth','passport_country_birth','passport_family_name_birth',
														 'clean_rec','dob','ssn','title','fname','mname','lname','name_suffix','name_score','title2','fname2','mname2','lname2','name_suffix2',
														 'prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','v_city_name','st','zip5','zip4','addr_rec_type','fips_state',
														 'fips_county','geo_lat','geo_long','cbsa','geo_blk','geo_match','err_stat','prim_range2','predir2','prim_name2','addr_suffix2','postdir2',
														 'unit_desig2','sec_range2','v_city_name2','st2','zip52','zip42','query_id','unique_id','national_id','cvi','nas','nap','ivi','compliance_level',
														 'dob_verified','fname_verified','lname_verified','address_verified','city_verified','state_verified','zip_verified', 'home_phone_verified',
														 'dob_match_verified','ssn_verified','dl_verified','date_added','did','bdid'];
	export PayloadAKParentSet := ['left.transaction_id','left.product','left.country','left.transaction_id_key','left.company_id', 'left.company_id_source','left.version',
	                              'left.source','left.iidi_type','left.batch_job_id','left.batch_seq_number','left.orig_fname','left.orig_mname','left.orig_lname','left.fullname',
																'left.maiden_name','left.gender','left.orig_address_number','left.orig_address','left.orig_address_type','left.orig_city','left.orig_state',
																'left.orig_zip','left.orig_dob','left.orig_ssn','left.street_address1','left.street_address2','left.unit_number','left.building_number',
																'left.building_name','left.floor_number','left.suburb','left.district','left.county','left.phone','left.mobile_phone','left.work_phone',
																'left.national_id_city_issued','left.national_id_district_issued','left.national_id_county_issued',	'left.national_id_province_issued',
																'left.dl_number','left.dl_version_number','left.dl_state','left.dl_expire_date','left.passport_number','left.passport_expire_date',
																'left.passport_place_birth','left.passport_country_birth','left.passport_family_name_birth','left.clean_rec','left.dob','left.ssn','left.title',
																'left.fname','left.mname','left.lname','left.name_suffix','left.name_score','left.title2','left.fname2','left.mname2','left.lname2',
																'left.name_suffix2','left.prim_range','left.predir','left.prim_name','left.addr_suffix','left.postdir','left.unit_desig','left.sec_range',
																'left.v_city_name','left.st','left.zip5','left.zip4','left.addr_rec_type','left.fips_state','left.fips_county','left.geo_lat',
																'left.geo_long','left.cbsa','left.geo_blk','left.geo_match','left.err_stat','left.prim_range2','left.predir2','left.prim_name2',
																'left.addr_suffix2','left.postdir2','left.unit_desig2','left.sec_range2','left.v_city_name2','left.st2','left.zip52','left.zip42',
																'left.query_id','left.unique_id','left.national_id','left.cvi','left.nas','left.nap','left.ivi','left.compliance_level','left.dob_verified',
																'left.fname_verified','left.lname_verified','left.address_verified','left.city_verified','left.state_verified','left.zip_verified',
																'left.home_phone_verified','left.dob_match_verified','left.ssn_verified','left.dl_verified','left.date_added','left.did','left.bdid'];
	export PayloadAKIgnoredFields := ['qa_defined_empty'];
	export PayloadAKUniqueField   :=['transaction_id'];
	export PayloadAKParentName    := 'AutokeyPayload';

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
	
END;